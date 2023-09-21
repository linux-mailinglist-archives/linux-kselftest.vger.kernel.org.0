Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2797A9A18
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Sep 2023 20:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjIUSgZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Sep 2023 14:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjIUSf4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Sep 2023 14:35:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7E45AAAC;
        Thu, 21 Sep 2023 10:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695318595; x=1726854595;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h3pYIci+iZkkMqhwJQHGy+I5as9zK7da73IbWNzAKLo=;
  b=Y+RG75aioVtRKtk33xee1Zf9p3cxt+QQsafy8UUV+ibcGESm6oyD6keg
   mxI/HDNOVz2ovixmOqraV9gjgvrEIAp8Db8Y6ERkhqEZT1KSsNOFZK8A6
   0NZbNe4lSgG1wAPxoBmUUGuUuCGdD7vzOE0CSya9G4mrnwWbWeqf5/Wjd
   sduYnpEvIlvYNtNGZs/HDx7vE3pkBKICJTQ5dVawlpRgQada4i96pxIjf
   oy53twjPH5+69VmaTBvOd8a0M8b7NKktm8FSj6CLBc2kCJ2ApjaT9scZK
   V1rtLBaCPD+HhxUUG+kHrsD06GiPjVoM5VjY0O19diUZtd+tTnvl2jirv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="359832935"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="359832935"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 00:52:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="723649573"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; 
   d="scan'208";a="723649573"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orsmga006.jf.intel.com with ESMTP; 21 Sep 2023 00:52:16 -0700
From:   Yi Liu <yi.l.liu@intel.com>
To:     joro@8bytes.org, alex.williamson@redhat.com, jgg@nvidia.com,
        kevin.tian@intel.com, robin.murphy@arm.com,
        baolu.lu@linux.intel.com
Cc:     cohuck@redhat.com, eric.auger@redhat.com, nicolinc@nvidia.com,
        kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.l.liu@intel.com,
        yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: [PATCH v4 12/17] iommufd/selftest: Rework TEST_LENGTH to test min_size explicitly
Date:   Thu, 21 Sep 2023 00:51:33 -0700
Message-Id: <20230921075138.124099-13-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921075138.124099-1-yi.l.liu@intel.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Nicolin Chen <nicolinc@nvidia.com>

TEST_LENGTH passing ".size = sizeof(struct _struct) - 1" expects -EINVAL
from "if (ucmd.user_size < op->min_size)" check in iommufd_fops_ioctl().
This has been working when min_size is exactly the size of the structure.

However, if the size of the structure becomes larger than min_size, i.e.
the passing size above is larger than min_size, that min_size sanity no
longer works.

Since the first test in TEST_LENGTH() was to test that min_size sanity
routine, rework it to support a min_size calculation, rather than using
the full size of the structure.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 tools/testing/selftests/iommu/iommufd.c | 29 ++++++++++++++-----------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 9c129e63d7c7..7a29d68bd1d2 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -86,12 +86,13 @@ TEST_F(iommufd, cmd_fail)
 
 TEST_F(iommufd, cmd_length)
 {
-#define TEST_LENGTH(_struct, _ioctl)                                     \
+#define TEST_LENGTH(_struct, _ioctl, _last)                              \
 	{                                                                \
+		size_t min_size = offsetofend(struct _struct, _last);    \
 		struct {                                                 \
 			struct _struct cmd;                              \
 			uint8_t extra;                                   \
-		} cmd = { .cmd = { .size = sizeof(struct _struct) - 1 }, \
+		} cmd = { .cmd = { .size = min_size - 1 },               \
 			  .extra = UINT8_MAX };                          \
 		int old_errno;                                           \
 		int rc;                                                  \
@@ -112,17 +113,19 @@ TEST_F(iommufd, cmd_length)
 		}                                                        \
 	}
 
-	TEST_LENGTH(iommu_destroy, IOMMU_DESTROY);
-	TEST_LENGTH(iommu_hw_info, IOMMU_GET_HW_INFO);
-	TEST_LENGTH(iommu_hwpt_alloc, IOMMU_HWPT_ALLOC);
-	TEST_LENGTH(iommu_ioas_alloc, IOMMU_IOAS_ALLOC);
-	TEST_LENGTH(iommu_ioas_iova_ranges, IOMMU_IOAS_IOVA_RANGES);
-	TEST_LENGTH(iommu_ioas_allow_iovas, IOMMU_IOAS_ALLOW_IOVAS);
-	TEST_LENGTH(iommu_ioas_map, IOMMU_IOAS_MAP);
-	TEST_LENGTH(iommu_ioas_copy, IOMMU_IOAS_COPY);
-	TEST_LENGTH(iommu_ioas_unmap, IOMMU_IOAS_UNMAP);
-	TEST_LENGTH(iommu_option, IOMMU_OPTION);
-	TEST_LENGTH(iommu_vfio_ioas, IOMMU_VFIO_IOAS);
+	TEST_LENGTH(iommu_destroy, IOMMU_DESTROY, id);
+	TEST_LENGTH(iommu_hw_info, IOMMU_GET_HW_INFO, __reserved);
+	TEST_LENGTH(iommu_hwpt_alloc, IOMMU_HWPT_ALLOC, __reserved);
+	TEST_LENGTH(iommu_ioas_alloc, IOMMU_IOAS_ALLOC, out_ioas_id);
+	TEST_LENGTH(iommu_ioas_iova_ranges, IOMMU_IOAS_IOVA_RANGES,
+		    out_iova_alignment);
+	TEST_LENGTH(iommu_ioas_allow_iovas, IOMMU_IOAS_ALLOW_IOVAS,
+		    allowed_iovas);
+	TEST_LENGTH(iommu_ioas_map, IOMMU_IOAS_MAP, iova);
+	TEST_LENGTH(iommu_ioas_copy, IOMMU_IOAS_COPY, src_iova);
+	TEST_LENGTH(iommu_ioas_unmap, IOMMU_IOAS_UNMAP, length);
+	TEST_LENGTH(iommu_option, IOMMU_OPTION, val64);
+	TEST_LENGTH(iommu_vfio_ioas, IOMMU_VFIO_IOAS, __reserved);
 #undef TEST_LENGTH
 }
 
-- 
2.34.1

