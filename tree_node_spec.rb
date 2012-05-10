require './tree_node'

describe TreeNode do
  describe 'basic methods' do
    let(:some_value) { rand(10) }
    let(:root_tree_node) { TreeNode.new }
    let(:leaf_tree_node) { TreeNode.new }

    before do
      root_tree_node.add_child leaf_tree_node
      leaf_tree_node.value = some_value
    end

    it 'should initialize the value' do
      TreeNode.new(some_value).value.should == some_value
    end

    it 'should have a child node' do
      root_tree_node.children.length.should == 1
    end

    it 'should have a parent TreeNode' do
      leaf_tree_node.parent.class.should == TreeNode
    end

    it 'should have a parent' do
      leaf_tree_node.parent.should_not be_nil
    end

    it 'should have a value' do
      leaf_tree_node.value.should_not be_nil
    end

    it 'should return the value that was originally set' do
      leaf_tree_node.value.should == some_value
    end

    it 'should return the child node' do
      child_node = root_tree_node.add_child leaf_tree_node
      child_node.should == leaf_tree_node
    end

    it 'should return true if it is a root node' do
      root_tree_node.root?.should == true
      leaf_tree_node.root?.should == false
    end

    it 'should return the root node' do
      leaf_tree_node.root.should == root_tree_node
    end

    it 'should return the root node for a deeper nested node' do
      deeper_tree_node = TreeNode.new
      leaf_tree_node.add_child deeper_tree_node

      deeper_tree_node.root.should == root_tree_node
    end
  end

  describe 'descendants' do
    let(:another_root_tree_node) { TreeNode.new }
    let(:expected_values) { Array.new }

    before do
      (1..3).each do |i|
        leaf_tree_node = TreeNode.new i
        another_root_tree_node.add_child leaf_tree_node
        expected_values << i

        (1..5).each do |j|
          leaf_tree_node.add_child TreeNode.new(j)
          expected_values << j
        end
      end
    end

    it 'should return all descendants' do
      another_root_tree_node.all.map(&:value).sort.should == expected_values.sort
    end

    it 'should operate on all the descendants' do
      values = []
      another_root_tree_node.each { |tree_node| values << tree_node.value }
      expected_values.sort.should == values.sort
    end
  end

  describe 'root of the tree' do
    let(:tree_node) { TreeNode.new }

    it 'should not have a parent' do
      tree_node.parent.should be_nil
    end
  end
end
