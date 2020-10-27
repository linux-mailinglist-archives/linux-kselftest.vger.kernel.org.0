Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFFF529A37C
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Oct 2020 04:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505304AbgJ0D5Y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Oct 2020 23:57:24 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5118 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505303AbgJ0D5Y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Oct 2020 23:57:24 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CKyZs5BJ1zLmpC;
        Tue, 27 Oct 2020 11:57:25 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.202.177) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Tue, 27 Oct 2020 11:57:13 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <iommu@lists.linux-foundation.org>, <hch@lst.de>,
        <m.szyprowski@samsung.com>, <robin.murphy@arm.com>
CC:     <joro@8bytes.org>, <will@kernel.org>, <shuah@kernel.org>,
        <linuxarm@huawei.com>, <linux-kselftest@vger.kernel.org>,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH 0/2] dma-mapping: provide a benchmark for streaming DMA mapping
Date:   Tue, 27 Oct 2020 16:53:28 +1300
Message-ID: <20201027035330.29612-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.202.177]
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
* use the existing driver_override mechinism, unbind device A,B, or c from
their original driver and bind them to "dma_map_benchmark" platform_driver
or pci_driver for benchmarking.

In this patchset, I prefer to use the driver_override and avoid the various
hack in kernel. We can dynamically switch devices behind different IOMMUs
to get the performance of dma map on IOMMU or non-IOMMU.

Barry Song (2):
  dma-mapping: add benchmark support for streaming DMA APIs
  selftests/dma: add test application for DMA_MAP_BENCHMARK

 MAINTAINERS                                   |   6 +
 kernel/dma/Kconfig                            |   8 +
 kernel/dma/Makefile                           |   1 +
 kernel/dma/map_benchmark.c                    | 202 ++++++++++++++++++
 tools/testing/selftests/dma/Makefile          |   6 +
 tools/testing/selftests/dma/config            |   1 +
 .../testing/selftests/dma/dma_map_benchmark.c |  72 +++++++
 7 files changed, 296 insertions(+)
 create mode 100644 kernel/dma/map_benchmark.c
 create mode 100644 tools/testing/selftests/dma/Makefile
 create mode 100644 tools/testing/selftests/dma/config
 create mode 100644 tools/testing/selftests/dma/dma_map_benchmark.c

-- 
2.25.1

