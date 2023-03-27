Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684B76CAD37
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Mar 2023 20:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbjC0SjG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 14:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbjC0SjF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 14:39:05 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C221AD;
        Mon, 27 Mar 2023 11:38:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxYW5GjUtnzzSHOrtZuuIbvHqn2Cy45EAb0LQ8jajOwYSsQ7CrJXjQV70yLnfLUmRP+2rf/XnBWWhq5NDdSvGKfeY9FL5d0vgL1kckf+K3E/vnhzFnOsYxh7dXPbIk6lqmxrkb5xZaAjU9JqYqXte/EZpTFP7kzTKED+aOkUfAcOuEt2DgtqpwO+AEPAAZLgIvZNzozKK8EfIImplZgyg4xGe1QgWaEDG7xRAkwkPjC1TSfakmCf97Mw6r/JANifioTFUh7Li1uvjcSAe2k0iA/0Z5pagb9F8TaXRt1iJUrI1jNvILPEucwF35XKwshlJ/I37CXTMG+quc2IbS/mPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPFv55G9dMElzX1sVD7XmlLL1r1w5TkbGUmLhCo4NDs=;
 b=mOMsbhdqBdjRZvMwjV0FYdYxTTiDypqmhYNWlxMhVsGp8E5v267IWKFSRNyBB1GvoylNXFkdsRqzAgapzqtKoxvrhxbL2MYSzdbdxSr9JF/7V2mg3OXJVjUQzuDKScb/4h1HH55WTQoNUx5+1Xi2OJkIfluWKFnmojhvK2wAYqhN0ujNOywIu5cwVw1qFI9JJIZL6k2JZcpJYJiXipbx+JiWEAofQgI7vplz//qklylrmtINXxV1VXcswVXWLw6pZYDzUrXxVBAQpJaEIPkh9xBFt/EkxwGmFJKGD/qAdZunRluzXz4L9y4sc4P07kNhJ9CxqZomGpcEMRvuxIqvpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPFv55G9dMElzX1sVD7XmlLL1r1w5TkbGUmLhCo4NDs=;
 b=VFf9nwu1HQEecT5OKBc5c8Kqmh54RcIO6JMixRL8Didgw1rP0mypMZooU3pYaWxOAXRzRiF/MFnpSpMNHQyg0B+hh9yfBJpoDHEKLyp6e4Dwj07bjh+XNImxlax9S4kfAZstmDCWRrasx5DxH8LAEHyZFrJXidT/JWADIIxWEmulLmoIJexX6ieL6mcHkP1VOJKHE9407jvBg3nHCbcpLZ4JRcc7Ft2StjRlmDJRNJ7sB6haqXKRDJ1ggUmAW5YCganWirSPdAEkhexvcB9oB89J7kNf221ao2v8fWkLNh4z+gMsDUColB5XBZSp+gyLYCsCdeag5UTPwNFxUXycIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 18:38:16 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Mon, 27 Mar 2023
 18:38:16 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v4 17/17] iommufd/selftest: Add a selftest for IOMMU_HWPT_ALLOC
Date:   Mon, 27 Mar 2023 15:38:11 -0300
Message-Id: <17-v4-9cd79ad52ee8+13f5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v4-9cd79ad52ee8+13f5-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0391.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b8cad41-6fdf-4b63-f92c-08db2ef26bb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KoHjRHjJc8/FuG9uZzVfjl/mczq101Qh9p0U4ZkU/MV6zJ/YyIaFurFxHtHNvzZFdkgzSnLJfMqWMF51Dh6m12RxLVyazgQooShWQ51pzvV1QcYohF4VSw4xwOawQVWPkFQPeX4eXwGI9rlmswIm8ZlXe9ajsPflVZB8rVI4urx7IjVnWyG5YWd1d470BVDz/gaLKPPJ85sJ3uTqfDPtVIzdefCgR2wuVj0AiakDx0C7Ef2xsdwZ3+HKBHklsrRBtAMYgj32H/DnUHrrMbisRnVsbyNBU8QP3h1wBj87qEPYfeEtBr24ZYeB8sFMuWOw/0eTA8/wb3acBOVW2EGSJ9NlxaEBRE7EuMKaA6KcIg03hcyTBpZHZchTlfFnZsd+q3F7VHVvXygXvx/etFt82XWjgmiOIJuz+9ZjJ1EUhkpBDQiHEDFVRqhLhSLmc4o9Q81UjbMsmHDVB8E1JjhBUTMOfQmkqRNJ2ZtrKxBOERU3VmmKRAb9ekttou/Y0qG75+41TN4pgAtUEBLwPq2xfHUc7m/4PE0UL1L0Mrz5Y83l9jHOA+bdJDlJk3Bsprbc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199021)(6512007)(6506007)(26005)(54906003)(6486002)(316002)(6666004)(4326008)(186003)(66476007)(66556008)(66946007)(8676002)(478600001)(41300700001)(86362001)(5660300002)(38100700002)(2906002)(83380400001)(36756003)(2616005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2r/K4ryyMCUGiYY1hebSMFM3wkxklHpVNpqdTPa3XCQ8o6nDvit+DLLUtr3S?=
 =?us-ascii?Q?tfEZ+BXbOIE3GZUcI7aMZ81i2th0X1F+ku1J9mzElUi0DC+CJTQfZA/wdIIC?=
 =?us-ascii?Q?YZeZpr7xovxNKu4Gw5graioynwJFQMor7zZXZdVwdbeg6oADl5fwnGapnuY1?=
 =?us-ascii?Q?ekppziCg6tRXUMxRFsrrCEhKbSKuL/XWQjFmArwiDL3rxKiVm/dKtDyQJa7T?=
 =?us-ascii?Q?+hCU44jqz8iFtVKsLcJ8EEKnBFtQYtwRs4qcySK321YKlz53Ftdf+CLtpJOP?=
 =?us-ascii?Q?07CYlk/+HLsl06rvZLMBYQaXCH+QkbOJumdXQUKmmJOmARZfiBl4kWQRfInJ?=
 =?us-ascii?Q?YUSJCQThOGOx0jTsPGjTAd+ToloV+iNgVhr9G6a0siYYuUefWv7Uo5DAAjuv?=
 =?us-ascii?Q?ld0Gvuve+pXej5DXvLWA4pyrkxIFIajdWHF/FoW/2AlmCK6NaAVKpuCSx83E?=
 =?us-ascii?Q?QunEDCM9c+IXpHRAfGDHZG4PVK8rU7zuadFVTO7kXncRri0lwzMgoC55ZuME?=
 =?us-ascii?Q?rkfmkke2Dcw1esJOh0z9UGJjWd7rBanDcfXLi9n7zPvIbfGhZGCFT6JE5peI?=
 =?us-ascii?Q?GgbZT8hqy1aVc4z30RsA0utHqiv4ljBnUNAJGpJE566JToUjPzJhUJdmqNJE?=
 =?us-ascii?Q?uTQTMOVUTFfh4gnCRJppolJNaXYboO8m4SF33aVBhY8PERZKSu6N4+u73JIt?=
 =?us-ascii?Q?a7hIRvudAGD3Q9Kn4EMwxM06y9ea7oFUWbyTKjiVTValOM4PjdTvQydmUSgO?=
 =?us-ascii?Q?jeaNXrHgbAxmVJGXAJelXPIeq2g/5ZZv241DKKYvx0UMfDzPeJUmDflHA5/P?=
 =?us-ascii?Q?5X16vmIApFkNg0os5dhiAbSrlCHSiQ2XtTe+QyP5Cbv7IsH5y+o4FdtrDHAK?=
 =?us-ascii?Q?TjchPZLecxDzVMTb0TKWZu14CX4nbU9KqtNRHaw1ek6wFdi/pNDpCTu7xMkl?=
 =?us-ascii?Q?whNPxTohFKMCiGW8qtX409Z2DEgWuZ7QKlGRx9dRYYZduFZiTBn4OXIr3/bo?=
 =?us-ascii?Q?7tFQ6NfGFWD4vrm418ErU5w+2uMGjR/8XchjwWBVTnvNm1VUXF6GSpuiaHhT?=
 =?us-ascii?Q?ZZHy3fk+X4Wkkv7IHFmOFeO/1KB0z1hU7pJNQoNttAAL5htrmoiVmLACu2RM?=
 =?us-ascii?Q?AvKJOY0mGXYLt8uCNmm+u9pe1nDSHg/6ePyICECC0HcWK4vOf48auYg7iSYe?=
 =?us-ascii?Q?k1ikVGWWgWCcUDpyf79fVqt5vmh4zuaFJEra35f4lbO9KYTOb8RN+hqlOGFf?=
 =?us-ascii?Q?VNLA10uFedWMKNCoA6bvplwLucXwhvhjBHGMprMzYWdRTbTncVwiE9PbKC/M?=
 =?us-ascii?Q?lf7KIEOcw/4MrLVhZAI+XIQA6TMWDEsPS/VaXOlsP7mh2dkSrQaO8AfhYiY4?=
 =?us-ascii?Q?qciH8uW4c2/NVsjgv3GCioUmAuCKy326js5JLAIYpMYihzNRbxw1wrcuO8SJ?=
 =?us-ascii?Q?KzgwhUPODFsOCa7r2eTotYF6qBFYyLRyyGmlFPp+oRitor2A94+MfugUkFrA?=
 =?us-ascii?Q?QE+OVuL0Kyqln5MOs34ZkqIaesr68lKIwQ+ApzylhStHzqBILcBK5Wf6k0uC?=
 =?us-ascii?Q?qyfffTS21EWJwEmR0Mmzo5KlnE125kM8pi9eajAJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b8cad41-6fdf-4b63-f92c-08db2ef26bb2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 18:38:12.8630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jJNVv0bSDJ3PTa9JLooq9cRRFyNDiMfkeJG0Rjx6ZPYmYm3FSnL+WdStjF5sonun
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9008
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 83c98a371f9e7a..c07252dbf62d72 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -1307,6 +1307,21 @@ TEST_F(iommufd_mock_domain, replace)
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
index 7a3d149019da92..7e1afb6ff9bd8d 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -577,6 +577,8 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 	uint32_t ioas_id;
 	uint32_t ioas_id2;
 	uint32_t stdev_id;
+	uint32_t idev_id;
+	uint32_t hwpt_id;
 
 	self->fd = open("/dev/iommu", O_RDWR);
 	if (self->fd == -1)
@@ -590,11 +592,18 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 
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
index e67a929a5c87d3..9b6dcb921750b6 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -96,6 +96,27 @@ static int _test_cmd_mock_domain_replace(int fd, __u32 stdev_id, __u32 pt_id,
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

