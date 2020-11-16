Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B6D2B3CD7
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Nov 2020 07:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgKPGNF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Nov 2020 01:13:05 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:7902 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgKPGNF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Nov 2020 01:13:05 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CZJdt6GWfz6xXR;
        Mon, 16 Nov 2020 14:12:50 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.201.147) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Mon, 16 Nov 2020 14:12:52 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <iommu@lists.linux-foundation.org>, <hch@lst.de>,
        <robin.murphy@arm.com>, <m.szyprowski@samsung.com>
CC:     <linuxarm@huawei.com>, <linux-kselftest@vger.kernel.org>,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH v4 0/2] dma-mapping: provide a benchmark for streaming DMA mapping
Date:   Mon, 16 Nov 2020 19:08:46 +1300
Message-ID: <20201116060848.1848-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.201.147]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Nowadays, there are increasing requirements to benchmark the performance
of dma_map and dma_unmap particually while the device is attached to an
IOMMU.

This patchset provides the benchmark infrastruture for streaming DMA
mapping. The architecture of the code is pretty much similar with GUP
benchmark:
* mm/gup_benchmark.c provides kernel interface;
* tools/testing/selftests/vm/gup_benchmark.c provides user program to
call the interface provided by mm/gup_benchmark.c.

In our case, kernel/dma/map_benchmark.c is like mm/gup_benchmark.c;
tools/testing/selftests/dma/dma_map_benchmark.c is like tools/testing/
selftests/vm/gup_benchmark.c

A major difference with GUP benchmark is DMA_MAP benchmark needs to run
on a device. Considering one board with below devices and IOMMUs
device A  ------- IOMMU 1
device B  ------- IOMMU 2
device C  ------- non-IOMMU

Different devices might attach to different IOMMU or non-IOMMU. To make
benchmark run, we can either
* create a virtual device and hack the kernel code to attach the virtual
device to IOMMU1, IOMMU2 or non-IOMMU.
* use the existing driver_override mechinism, unbind device A,B, OR c from
their original driver and bind A to dma_map_benchmark platform driver or
pci driver for benchmarking.

In this patchset, I prefer to use the driver_override and avoid the ugly
hack in kernel. We can dynamically switch device behind different IOMMUs
to get the performance of IOMMU or non-IOMMU.

-v4:
  * add dma direction support according to Christoph Hellwig's comment;
  * add dma mask bit set according to Christoph Hellwig's comment;
  * make the benchmark depend on DEBUG_FS according to John Garry's comment;
  * strictly check parameters in ioctl
-v3:
  * fix build issues reported by 0day kernel test robot
-v2:
  * add PCI support; v1 supported platform devices only
  * replace ssleep by msleep_interruptible() to permit users to exit
    benchmark before it is completed
  * many changes according to Robin's suggestions, thanks! Robin
    - add standard deviation output to reflect the worst case
    - check users' parameters strictly like the number of threads
    - make cache dirty before dma_map
    - fix unpaired dma_map_page and dma_unmap_single;
    - remove redundant "long long" before ktime_to_ns();
    - use devm_add_action()

Barry Song (2):
  dma-mapping: add benchmark support for streaming DMA APIs
  selftests/dma: add test application for DMA_MAP_BENCHMARK

 MAINTAINERS                                   |   6 +
 kernel/dma/Kconfig                            |   9 +
 kernel/dma/Makefile                           |   1 +
 kernel/dma/map_benchmark.c                    | 361 ++++++++++++++++++
 tools/testing/selftests/dma/Makefile          |   6 +
 tools/testing/selftests/dma/config            |   1 +
 .../testing/selftests/dma/dma_map_benchmark.c | 123 ++++++
 7 files changed, 507 insertions(+)
 create mode 100644 kernel/dma/map_benchmark.c
 create mode 100644 tools/testing/selftests/dma/Makefile
 create mode 100644 tools/testing/selftests/dma/config
 create mode 100644 tools/testing/selftests/dma/dma_map_benchmark.c

-- 
2.25.1

