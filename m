Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD6334E14D
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Mar 2021 08:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbhC3Ggr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Mar 2021 02:36:47 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:15389 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhC3Gge (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Mar 2021 02:36:34 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F8fnP5pcQzpSvp;
        Tue, 30 Mar 2021 14:34:49 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Tue, 30 Mar 2021 14:36:22 +0800
From:   Hao Fang <fanghao11@huawei.com>
To:     <hch@lst.de>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
        <song.bao.hua@hisilicon.com>
CC:     <iommu@lists.linux-foundation.org>, <linuxarm@openeuler.org>,
        <linux-kselftest@vger.kernel.org>, <fanghao11@huawei.com>
Subject: [PATCH] dma-mapping: benchmark: use the correct HiSilicon copyright
Date:   Tue, 30 Mar 2021 14:33:48 +0800
Message-ID: <1617086028-18986-1-git-send-email-fanghao11@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

s/Hisilicon/HiSilicon/g.
It should use capital S, according to
https://www.hisilicon.com/en/terms-of-use.

Signed-off-by: Hao Fang <fanghao11@huawei.com>
---
 kernel/dma/map_benchmark.c                      | 2 +-
 tools/testing/selftests/dma/dma_map_benchmark.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index e0e64f8..00d6549 100644
--- a/kernel/dma/map_benchmark.c
+++ b/kernel/dma/map_benchmark.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2020 Hisilicon Limited.
+ * Copyright (C) 2020 HiSilicon Limited.
  */
 
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c b/tools/testing/selftests/dma/dma_map_benchmark.c
index fb23ce9..b492bed 100644
--- a/tools/testing/selftests/dma/dma_map_benchmark.c
+++ b/tools/testing/selftests/dma/dma_map_benchmark.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2020 Hisilicon Limited.
+ * Copyright (C) 2020 HiSilicon Limited.
  */
 
 #include <fcntl.h>
-- 
2.8.1

