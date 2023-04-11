Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53176DE136
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 18:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjDKQne (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 12:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjDKQnc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 12:43:32 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF875588;
        Tue, 11 Apr 2023 09:43:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SoPHg7di7xsWwcFsP6SpQsA2Nnj7yV7qqcHwe9+CMx//+B4U+Sy372RgMvP2FzAuJXJuMq/7enWnb1H2IGvV+X6wONne+F4oll4ufqY13r40JAl6UhIncPGCrnT8Aoyb8QsmLm2VGpT3EsoACS9om3teSmQtX3Uowyz8RyLMC0TBk6olzcL8SV4J8bvHyvUZzuyEzohWLX1iJDfRxfciL/qBFUGaZVzD7v03PyDCeIhboOTGFx+KBC8nbG0QIz1xrw3y9+kkbMKhLtnX2Sligw/vAymAGmNRNbNSbVGVT+IMiztBijvm78sVMcEvxJUGX26UYVZdy+ekRSj0Y+VfOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uD34Oq8oTy+sonXeAwv4BDmlwZH/r68vKzO3PLkSKu0=;
 b=jN+ajVNO+20b3IcSUOzwmreuMVIUsWJ36ylRH6ppKUXpeNh3pN4yKGcZGLQbRR/JgwMIJJ3wwfM9bPD2Uhig6LSyfmdElIy12RYy1ATJlZhzAGF8YFaQf/9QxE2zmO6LpwXsGVUt6dXmm8vduFcU8g5vdmz35pSBzrk3StqBEKZSEDg/ggGlEAEj7Bz397+GJWfkaH7qiFWAVEkby4tEqAMrs28lP9EMBO+TWLCvF5fABubZ4DXkvMCXtt6cD4Mvs10eyIX869qk7IsRIrnHvD+eJdgtiuvLklduFNsr2qpwQgvg1fjkWhMDll4lV0byyjl8u/80MrYM1L0D5xpdaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uD34Oq8oTy+sonXeAwv4BDmlwZH/r68vKzO3PLkSKu0=;
 b=XdPJDvuh14kdbPe3Xl1j1SKzoOYm8FbGrd6CG38ZO32forLTjUGWBXoL4LGnjoigY+Hn91X5GQnhnAGVqy02Bn/6ibhkWQRjG4CHmnW5ntRP0Bj/NBLMIw8FWGwxxbhAk9nXhng7kgMQtMWiGEoJAYMVDbPzg93Whq0OsFhyC9Cs5Cba0WVVTh1yk+sI/P+NUnkgj0PmLX938uQuT2NzuZD6NxaY0NFNSgQeQqP2TzQJqNADRJyhok3kbcT75wkT0/rF6d38qpZVQUAbuiPES/YHoM4rYUn1DlzRfZ1CUTsDgAJy20puZ7CZcCJS9I/pWsFbXQ7/Qf2MKhtETW4gsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL3PR12MB6596.namprd12.prod.outlook.com (2603:10b6:208:38f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Tue, 11 Apr
 2023 16:43:22 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 16:43:22 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v5 17/17] iommufd/selftest: Add a selftest for IOMMU_HWPT_ALLOC
Date:   Tue, 11 Apr 2023 13:43:18 -0300
Message-Id: <17-v5-6716da355392+c5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v5-6716da355392+c5-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0040.namprd07.prod.outlook.com
 (2603:10b6:a03:60::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL3PR12MB6596:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b102766-c51a-4bbd-bc14-08db3aabdc88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ea0BkqGZw6jm7O2y7C7J8v1yL3oBdUBIwaAzl7ToRN9rAWqOBVFrus7aCSXLt9qZumV10jNk0VSP1nMsXG9orBLYqCzCWdAKkQNEWo306Yceq8yLSRklGvY3BB+IchpwGGK5A52BjIzJRQlyLWjWVawCqrQ3f65OJnfyxw4KEhrPhTLcAY/oS/8+MFXjAPn97daocY4usIMI1LMwrsNPngcgeu6jm0KOfsN+qflN99kwmevwcg5l17eD9aXMQzp6XfqXgon7vbk+KMQtm6+tCzESt3G7/wM+IXZRtqafxaMGGeVs6vid4kUC6/1roUFivQEC4ldCUgyih/c1asASrcZsu+Edg0XWhmfDjlqRITtj0AoOBIcGmh7UcwXeaESapdN0I4TBV9BfsqemiomQAPBEbO0CPXCcn+7pm8sjSDFoW8EGHRUBqlAfLrn9Q7IctY521FFRBUXtpUXsT39tRtYPdnz19EqPfF5vyRGPJSglSuMIOnXWAro4aEd0upPnCUGuxUVA7LQpb1AkJP7YNoro5fagw36JieOunHJjFAs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199021)(2906002)(86362001)(36756003)(6486002)(6666004)(2616005)(83380400001)(186003)(6506007)(26005)(6512007)(478600001)(66556008)(66476007)(66946007)(4326008)(316002)(8936002)(41300700001)(38100700002)(8676002)(5660300002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9YdfXIcZMIcy3n9gDyE11s2AG7P/03uizc5rYeEi0BPtMAyhLT4OWybgaOen?=
 =?us-ascii?Q?6XNI3l3IPxFaz+9MWFvGY2Tys51trUI3YYO1mjUJ+ClY0l0K4ae8OvunR6wZ?=
 =?us-ascii?Q?aq+aqMsqfgvea/ROIEJoIjeFFb/6JO1CNAqbcZsgd3gRzLm/4XB/8lSSIcEe?=
 =?us-ascii?Q?TleGEjbnfxGBYT9tWbl5g0V6n6cxS9kiTnQpRFawBVjpi7vY6ox/fzMPtkbs?=
 =?us-ascii?Q?aMEu45E5IjAqV1bLBWgEOCeYPNm1smwI9Zex0jva/YXg1Mn2GmNJeodX7O+/?=
 =?us-ascii?Q?9djjfJO6/VLJlaTq598V6SYew2hiMzLLQf/9QZFxGiTybzoPR19OOLpk1iqN?=
 =?us-ascii?Q?7NMLuxqF10zos32QmPw57OoG8E5mVKxtYiVBilCHogCAL8UnhC11Iw6yVBTK?=
 =?us-ascii?Q?DaaDRhCppgqV91ZGM02DUGPHCUGwofWn3K5ITW+y7FkbJyyQ3DEntVywa425?=
 =?us-ascii?Q?4NQEXKezcJCrEsy6pt2LnyTbZ4hAsHFV8Lx2DJAQzyPiMshG8ziGk6rI5C14?=
 =?us-ascii?Q?5gIsnpEP4zzv21o6EjiKYanLntmoIHC8ANrYhevBKSzJJkZQfUqzIjfMU/I8?=
 =?us-ascii?Q?ERa6CJXHOcz6i9NjeYYnNafRtas+Wu/5dTc9LT1Li124bGS3VYoJUmJpk04x?=
 =?us-ascii?Q?tjTpezMaKet1eXp7WI5eDm/I2XzNGNtyBaq1opnxDoo1diewpG02kU7JQLr4?=
 =?us-ascii?Q?gvGnhqLh3lEvTi1I9maH49MbPmmJUGzXs5wJ5E3AbFHXEb5+Sm7sFDJXN9Zz?=
 =?us-ascii?Q?fELxA+X2dnOZbma4j8X745gyrUkrJO6eYZKtpkWBH0nXfWYRnqXRPSQojMhT?=
 =?us-ascii?Q?S7MiiKfgR3i5bW9cKPorGwOh/jsk0t7KaaGRIIkvDIUCPUQSOVQXYvbChK4q?=
 =?us-ascii?Q?tur87nXYsqstfBmD6kdq4RVMlva1SehF/pL+8yHdoekGQmvMY9BRR85sIVjY?=
 =?us-ascii?Q?RgknArWkoEAcDBYmu16P1xq1+XUWNhbnvASFpca6KVuVyw078NfLmlY+4W7o?=
 =?us-ascii?Q?wsfTKGo2qfVNlr4yRWs8HSALzuBWZ0PEeqGj8GvEShSUQrJSo9XW9A5hmWSA?=
 =?us-ascii?Q?frGwnb6E3KOXZBV8kFL4Je0gVd9zhS6EATQhGaYOv7N1nKGoG9KsxUyoSq02?=
 =?us-ascii?Q?MLS4VKFkjcXoz3e6MycA2MmQnIsqJqTuJ0VrvAxL6seWCCBPam90/WvAV9ZG?=
 =?us-ascii?Q?d8WgPjeq8q1/9IHB72W0qP8IfWx04OuGDRkwUHorVMqQmQ+K37yQ083n/B3Z?=
 =?us-ascii?Q?QWFUpb5Zs76bhdLOlLY7gbGDctOcjjJzbyWdqhCYblWtI1BYE/0o8A3sqsmX?=
 =?us-ascii?Q?1xzCxPNDxbtQ0FLHN90otAsIslRzdmFHcoo/F9+Jh36olnPe2aIGIqVETJes?=
 =?us-ascii?Q?mmq7aZHd4eKyd7kTt+ueA/rSKE+vwNKUYBsdmvA0xfK6xjO63pGkQPYkgpDx?=
 =?us-ascii?Q?OkIEmxZ/1FAwiiiEU9S/7xnC96kJgTKqBT8gapXZsVpvr86ZUVIFSrjZa4U1?=
 =?us-ascii?Q?6Hz5EZk2xIuUeP7KxEowe7KQ1DMo1MAFwh+c+xJ3ccY27J6azGnqm0Ix+C35?=
 =?us-ascii?Q?KzkUE0l9jqtE69glA8QwSwJyp8STME1n+Mx4ELNk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b102766-c51a-4bbd-bc14-08db3aabdc88
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 16:43:21.8334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HT1v7AriNyvH+I0dUUUi/pTI6BHccBhaXwkbBhteR4OgJv70lFnSvHg5Imls5EAe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6596
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Test the basic flow.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 tools/testing/selftests/iommu/iommufd.c       | 15 +++++++++++++
 .../selftests/iommu/iommufd_fail_nth.c        | 11 +++++++++-
 tools/testing/selftests/iommu/iommufd_utils.h | 21 +++++++++++++++++++
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index a6bc090d4b38a9..8b2c18ac6a2864 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -1304,6 +1304,21 @@ TEST_F(iommufd_mock_domain, replace)
 	test_ioctl_destroy(ioas_id);
 }
 
+TEST_F(iommufd_mock_domain, alloc_hwpt)
+{
+	int i;
+
+	for (i = 0; i != variant->mock_domains; i++) {
+		uint32_t stddev_id;
+		uint32_t hwpt_id;
+
+		test_cmd_hwpt_alloc(self->idev_ids[0], self->ioas_id, &hwpt_id);
+		test_cmd_mock_domain(hwpt_id, &stddev_id, NULL, NULL);
+		test_ioctl_destroy(stddev_id);
+		test_ioctl_destroy(hwpt_id);
+	}
+}
+
 /* VFIO compatibility IOCTLs */
 
 TEST_F(iommufd, simple_ioctls)
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index 8ab20df4edc8c7..d4c552e5694812 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -579,6 +579,8 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 	uint32_t ioas_id;
 	uint32_t ioas_id2;
 	uint32_t stdev_id;
+	uint32_t idev_id;
+	uint32_t hwpt_id;
 	__u64 iova;
 
 	self->fd = open("/dev/iommu", O_RDWR);
@@ -605,11 +607,18 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 
 	fail_nth_enable();
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, NULL, NULL))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, NULL,
+				  &idev_id))
+		return -1;
+
+	if (_test_cmd_hwpt_alloc(self->fd, idev_id, ioas_id, &hwpt_id))
 		return -1;
 
 	if (_test_cmd_mock_domain_replace(self->fd, stdev_id, ioas_id2, NULL))
 		return -1;
+
+	if (_test_cmd_mock_domain_replace(self->fd, stdev_id, hwpt_id, NULL))
+		return -1;
 	return 0;
 }
 
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 62e01412a7679e..53b4d3f2d9fc6c 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -98,6 +98,27 @@ static int _test_cmd_mock_domain_replace(int fd, __u32 stdev_id, __u32 pt_id,
 	EXPECT_ERRNO(_errno, _test_cmd_mock_domain_replace(self->fd, stdev_id, \
 							   pt_id, NULL))
 
+static int _test_cmd_hwpt_alloc(int fd, __u32 device_id, __u32 pt_id,
+					 __u32 *hwpt_id)
+{
+	struct iommu_hwpt_alloc cmd = {
+		.size = sizeof(cmd),
+		.dev_id = device_id,
+		.pt_id = pt_id,
+	};
+	int ret;
+
+	ret = ioctl(fd, IOMMU_HWPT_ALLOC, &cmd);
+	if (ret)
+		return ret;
+	if (hwpt_id)
+		*hwpt_id = cmd.out_hwpt_id;
+	return 0;
+}
+
+#define test_cmd_hwpt_alloc(device_id, pt_id, hwpt_id) \
+	ASSERT_EQ(0, _test_cmd_hwpt_alloc(self->fd, device_id, pt_id, hwpt_id))
+
 static int _test_cmd_create_access(int fd, unsigned int ioas_id,
 				   __u32 *access_id, unsigned int flags)
 {
-- 
2.40.0

