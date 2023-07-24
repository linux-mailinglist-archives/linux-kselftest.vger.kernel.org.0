Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A4A75F45D
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 13:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbjGXLFU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 07:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjGXLFK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 07:05:10 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E96410DE;
        Mon, 24 Jul 2023 04:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690196685; x=1721732685;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wu92GRhppcU7MkbkHzcmjc/NGunkuHuJrkG4JF9bmNM=;
  b=HBd3gh2MN1t0DXy55YYzU2w9I1Os1VxvP2JcHFX6qPLfz/2id9h/4lbQ
   zf5r44/Pp69VqtAVq9i7mW09th+o7ghpuACqs0E6r1LuqOa3qQUqUmhLi
   2WJlKwMyZdrRMuLaIzLYiNLTR7rSQmIK04WxsvqPmXh6yPd1i37lUVvwE
   c+8+8SInIbYSdN68edcvhTtPvg8KMjgcr+2kLghffArAqBRnO4RBScdvk
   dEtNl0v352YtsWPKm7CA1abnb2A4SsyBAC+XbTt46Wmp5L1I7S3PBoOhp
   YHCOdI/2rOtAondsq26tBCC7VcPE3MMB7d99PGNI6R2QEse2S59vH2zyQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="347013339"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="347013339"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 04:04:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="815775877"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="815775877"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jul 2023 04:04:22 -0700
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
        zhenzhong.duan@intel.com
Subject: [PATCH v3 13/17] iommufd/selftest: Add coverage for IOMMU_RESV_IOVA_RANGES
Date:   Mon, 24 Jul 2023 04:04:02 -0700
Message-Id: <20230724110406.107212-14-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724110406.107212-1-yi.l.liu@intel.com>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This adds selftest for ioctl IOMMU_RESV_IOVA_RANGES.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 tools/testing/selftests/iommu/iommufd.c | 98 +++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 6b075a68b928..bfe0f76f7fb0 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -1780,4 +1780,102 @@ TEST_F(vfio_compat_mock_domain, huge_map)
 	}
 }
 
+FIXTURE(iommufd_device_resv_iova)
+{
+	int fd;
+	uint32_t ioas_id;
+	uint32_t stdev_id;
+	uint32_t device_id;
+};
+
+FIXTURE_SETUP(iommufd_device_resv_iova)
+{
+	self->fd = open("/dev/iommu", O_RDWR);
+	ASSERT_NE(-1, self->fd);
+	test_ioctl_ioas_alloc(&self->ioas_id);
+
+	test_cmd_mock_domain(self->ioas_id, &self->stdev_id,
+			     NULL, &self->device_id);
+}
+
+FIXTURE_TEARDOWN(iommufd_device_resv_iova)
+{
+	teardown_iommufd(self->fd, _metadata);
+}
+
+TEST_F(iommufd_device_resv_iova, dev_resv_iova_ranges)
+{
+	struct iommu_test_cmd test_cmd = {
+		.size = sizeof(test_cmd),
+		.op = IOMMU_TEST_OP_DEV_ADD_RESERVED,
+		.id = self->stdev_id,
+		.add_dev_reserved = { .start = PAGE_SIZE, .length = PAGE_SIZE },
+	};
+	struct iommu_test_cmd test_cmd_del = {
+		.size = sizeof(test_cmd_del),
+		.op = IOMMU_TEST_OP_DEV_DEL_RESERVED,
+		.id = self->stdev_id,
+	};
+	struct iommu_resv_iova_range *ranges = buffer;
+	struct iommu_resv_iova_ranges ranges_cmd = {
+		.size = sizeof(ranges_cmd),
+		.dev_id = self->device_id,
+		.num_iovas = BUFFER_SIZE / sizeof(*ranges),
+		.resv_iovas = (uintptr_t)ranges,
+	};
+
+	/* Range can be read */
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_RESV_IOVA_RANGES, &ranges_cmd));
+	EXPECT_EQ(0, ranges_cmd.num_iovas);
+
+	/* 1 range */
+	ASSERT_EQ(0,
+		  ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_DEV_ADD_RESERVED),
+			&test_cmd));
+	ranges_cmd.num_iovas = BUFFER_SIZE / sizeof(*ranges);
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_RESV_IOVA_RANGES, &ranges_cmd));
+	EXPECT_EQ(1, ranges_cmd.num_iovas);
+	EXPECT_EQ(PAGE_SIZE, ranges[0].start);
+	EXPECT_EQ(PAGE_SIZE * 2 - 1, ranges[0].last);
+
+	/* Buffer too small */
+	memset(ranges, 0, BUFFER_SIZE);
+	ranges_cmd.num_iovas = 0;
+	EXPECT_ERRNO(EMSGSIZE,
+		     ioctl(self->fd, IOMMU_RESV_IOVA_RANGES, &ranges_cmd));
+	EXPECT_EQ(1, ranges_cmd.num_iovas);
+	EXPECT_EQ(0, ranges[0].start);
+	EXPECT_EQ(0, ranges[0].last);
+
+	/* 2 ranges */
+	test_cmd.add_dev_reserved.start = PAGE_SIZE * 4;
+	test_cmd.add_dev_reserved.length = PAGE_SIZE;
+
+	ASSERT_EQ(0,
+		  ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_DEV_ADD_RESERVED),
+			&test_cmd));
+	ranges_cmd.num_iovas = BUFFER_SIZE / sizeof(*ranges);
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_RESV_IOVA_RANGES, &ranges_cmd));
+	EXPECT_EQ(2, ranges_cmd.num_iovas);
+	EXPECT_EQ(PAGE_SIZE, ranges[0].start);
+	EXPECT_EQ(PAGE_SIZE * 2 - 1, ranges[0].last);
+	EXPECT_EQ(PAGE_SIZE * 4, ranges[1].start);
+	EXPECT_EQ(PAGE_SIZE * 5 - 1, ranges[1].last);
+
+	/* Buffer too small */
+	memset(ranges, 0, BUFFER_SIZE);
+	ranges_cmd.num_iovas = 1;
+	EXPECT_ERRNO(EMSGSIZE, ioctl(self->fd, IOMMU_RESV_IOVA_RANGES,
+				     &ranges_cmd));
+	EXPECT_EQ(2, ranges_cmd.num_iovas);
+	EXPECT_EQ(PAGE_SIZE, ranges[0].start);
+	EXPECT_EQ(PAGE_SIZE * 2 - 1, ranges[0].last);
+	EXPECT_EQ(0, ranges[1].start);
+	EXPECT_EQ(0, ranges[1].last);
+
+	ASSERT_EQ(0,
+		  ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_DEV_DEL_RESERVED),
+			&test_cmd_del));
+}
+
 TEST_HARNESS_MAIN
-- 
2.34.1

