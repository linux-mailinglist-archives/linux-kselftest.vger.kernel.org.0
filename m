Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDB54AD22D
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 08:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346099AbiBHH2Z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Feb 2022 02:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242843AbiBHH2W (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Feb 2022 02:28:22 -0500
X-Greylist: delayed 1077 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 23:28:20 PST
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FB1C0401EF
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 23:28:20 -0800 (PST)
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JtDZB4MvFz1FD3Z;
        Tue,  8 Feb 2022 15:06:10 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 dggeme756-chm.china.huawei.com (10.3.19.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Tue, 8 Feb 2022 15:10:21 +0800
From:   chenxiang <chenxiang66@hisilicon.com>
To:     <song.bao.hua@hisilicon.com>, <hch@lst.de>,
        <m.szyprowski@samsung.com>, <robin.murphy@arm.com>
CC:     <linuxarm@openeuler.org>, <linuxarm@huawei.com>,
        <iommu@lists.linux-foundation.org>,
        <linux-kselftest@vger.kernel.org>,
        Xiang Chen <chenxiang66@hisilicon.com>
Subject: [PATCH] MAINTAINERS: Update maintainer list of DMA MAPPING BENCHMARK
Date:   Tue, 8 Feb 2022 15:04:51 +0800
Message-ID: <1644303891-81063-1-git-send-email-chenxiang66@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

Barry Song will not focus on this area, and Xiang Chen will continue his 
work to maintain this module.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ea3e6c914384..48335022b0e4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5765,7 +5765,7 @@ F:	include/linux/dma-map-ops.h
 F:	kernel/dma/
 
 DMA MAPPING BENCHMARK
-M:	Barry Song <song.bao.hua@hisilicon.com>
+M:	Xiang Chen <chenxiang66@hisilicon.com>
 L:	iommu@lists.linux-foundation.org
 F:	kernel/dma/map_benchmark.c
 F:	tools/testing/selftests/dma/
-- 
2.33.0

