Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A164779101D
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Sep 2023 04:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350465AbjIDCdv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 3 Sep 2023 22:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347210AbjIDCdu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 3 Sep 2023 22:33:50 -0400
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE135EC;
        Sun,  3 Sep 2023 19:33:45 -0700 (PDT)
X-QQ-mid: bizesmtp62t1693794758twa69jzb
Received: from localhost ( [221.216.117.35])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 04 Sep 2023 10:32:36 +0800 (CST)
X-QQ-SSF: 0140000000000010B000000A0000000
X-QQ-FEAT: tSQw27OYC23XBEqWAG0b/gTmfSNbAKillH2LUjy1Y2LDOPl/U8lWxIKgXVvVx
        MLTV21ye1KpLb/hbWDfY01FkK0KYbpuZjFieCaTbQP6lLhzTZnbDUVSBBpIrY71Qf065rpX
        1LP8ATObXQAfZJytn/j/UG4NoSLbLYU7Moac48ZU/9upewz4d7fR+z1F86kCMa/1D4Rl92e
        hdbAsvyLc+ynboOkXUYwTHHeuvwVtPSfUjuXnUm8a/qSSECZfvFswb+uaSG3F77usy0Pdg0
        zQNuT753vw6RYU11MMboLqXSbBogycvswg5N6xA5yo15bXaD1rqdKY1ViiUI5AvY5Ql7LzV
        l1rd7qcfnxhkqq5WeD4xHvRv1NYPx1afqBa2iSHPwdx8wxMlV8=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 2023375898041890435
Date:   Mon, 4 Sep 2023 10:32:36 +0800
From:   GuokaiXu <xuguokai@ucas.com.cn>
To:     jgg@ziepe.ca, kevin.tian@intel.com, shuah@kernel.org
Cc:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] tools/testing/selftests/iommu:Fixed spelling errors in
 comments
Message-ID: <31680D47D9533D91+20230904023236.GA12494@xgk8823>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:ucas.com.cn:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From c4e404036e0a7ffcaedc5760bee234713ccfe4a4 Mon Sep 17 00:00:00 2001
From: GuokaiXu <xuguokai@ucas.com.cn>
Date: Mon, 4 Sep 2023 10:18:04 +0800
Subject: [PATCH 1/1] Fix the spelling errors in comments

Signed-off-by: GuokaiXu <xuguokai@ucas.com.cn>
---
 tools/testing/selftests/iommu/iommufd.c          | 2 +-
 tools/testing/selftests/iommu/iommufd_fail_nth.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 33d08600be13..b7249ffc6750 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -1729,7 +1729,7 @@ TEST_F(vfio_compat_mock_domain, map)
 	ASSERT_EQ(0, ioctl(self->fd, VFIO_IOMMU_UNMAP_DMA, &unmap_cmd));
 	ASSERT_EQ(BUFFER_SIZE, unmap_cmd.size);
 
-	/* UNMAP_FLAG_ALL requres 0 iova/size */
+	/* UNMAP_FLAG_ALL requires 0 iova/size */
 	ASSERT_EQ(0, ioctl(self->fd, VFIO_IOMMU_MAP_DMA, &map_cmd));
 	unmap_cmd.flags = VFIO_DMA_UNMAP_FLAG_ALL;
 	EXPECT_ERRNO(EINVAL, ioctl(self->fd, VFIO_IOMMU_UNMAP_DMA, &unmap_cmd));
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index a220ca2a689d..36e7aa4f615c 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -105,7 +105,7 @@ static bool fail_nth_next(struct __test_metadata *_metadata,
 
 	/*
 	 * This is just an arbitrary limit based on the current kernel
-	 * situation. Changes in the kernel can dramtically change the number of
+	 * situation. Changes in the kernel can dramatically change the number of
 	 * required fault injection sites, so if this hits it doesn't
 	 * necessarily mean a test failure, just that the limit has to be made
 	 * bigger.
-- 
2.25.1

