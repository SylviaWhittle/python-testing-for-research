from plotting import plot_data
import pytest


@pytest.mark.mpl_image_compare(baseline_dir="test_plots/")
def test_plot_data():
    data = [1, 3, 2]
    fig = plot_data(data)
    return fig
