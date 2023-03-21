Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7DE56C3A27
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Mar 2023 20:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjCUTP6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Mar 2023 15:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjCUTP4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Mar 2023 15:15:56 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7A12CFEF;
        Tue, 21 Mar 2023 12:15:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPKH/LaqSIg9bEdCn2Lep+RxAyUvfox3iobVOLuzDNtOrfbNhygSCXQ590lp0uvGODmpU+N3cN5T70Yjfkdh+wm/+koJ43CVJmTrct6/2eL6iTwNcsDc+egGkj+JRGDWsLn8OLqLnhfHIdadypW0toHIKjh5w3oLFEDbRYlAutqgx3rFqqKfvbx+VZCXfh6lT0jSHfeG4D71G476OV7B+lJTIvtbeSYfEBF4eybjSKt04s+exxanA+Hon1/iuCIkQiC1XQRbYgheUMfZ9vKfY0XPnKkCvZoply7/mhhfI+/BchpOw3uu5kzluhi/KvPRwucIuzGdklRrg0u1Or9qFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gnr6cnhZU0rNE3YlzFnCSwcbPEqYyLdyzKsA7cjpxbo=;
 b=gzG/dkzVC2lcyu/LPcSWrUsEM07XkVDiCGQkPrq0rcxLh25uPm79EM8OAG/icHYjzpCf6D110MB/HcMs0Z3iJTSPWKy0rJTUuq2gj3vO1JpdSRYhokyecgpCVIghIHiwiS03r0OJc0Xo6wzAxAFndTRVYBKou5fxieU6u+o4fXYrXkhjcZ9Po8xhjH3eCEwkKdSq0gfPSCNLLGrPLmX1i0D8MCxwS8lEfQ/u40IIk31EiXAJJ8v4RxrnUzRuPiFHDi0iTtrjqzi9qVTSkPkZi5k0MlelgRWhGHPducLlwKJsvcAawXZ8kI1gBmW8sHeJmvlPQdV2nxwPfr7Oxclbbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gnr6cnhZU0rNE3YlzFnCSwcbPEqYyLdyzKsA7cjpxbo=;
 b=bBAxWWPTAD54zmbnzYuNOgEAzDGwcPtGaad8lG1M6RbARi+gN3Vcmspw2v2NE6RhllUKmkEkS81YDwtAFf5scj4JaBUNlpp1kNVwcX/HBtZ86l100G/uRcTt/5Tn9kKf9vLWijOmeAS3y1177qfSWpscbLYTrR5JoLP/PmcOkUbDHpPhoF5e7J14Bkb9t8BfQZn7CgPWqgNswzm0xhwscBxCHJ1kId1q2Vt9TfJzV28BNtsjUwqSmixenREgpiZzUVRnfNLIhbhZcGSpPKWJYdyR1BarkLflzotTodbd9HIw71smkbJ4S93pJw7HWxxesBSpPFdvs+4ANghnCwrmag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB8237.namprd12.prod.outlook.com (2603:10b6:208:3f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 19:14:56 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 19:14:56 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v3 17/17] iommufd/selftest: Add a selftest for IOMMU_HWPT_ALLOC
Date:   Tue, 21 Mar 2023 16:14:51 -0300
Message-Id: <17-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0303.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::8) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB8237:EE_
X-MS-Office365-Filtering-Correlation-Id: 45f47f48-197e-4dff-9982-08db2a408d79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O77p9sFqbCWHqj3Mj/yaVtSvdFRCKGDBRBNopzqx3ymmnwb6MMjT0T/KCcDJgjxBC+6/fCSEfEbfhS3GFEX07eieCMHJiBEswOBHQLyznk8uCA11vy5YQp0ImsxMOfXrN7cuhrCV0WwfDG/vzpeGMCYImOXPVi7kzd7h++Y4dPktabyoCJXkX8aqK9a1yJIprlaWm8S7tZjPSmGTQZosekOBG+yC0fEbGduSNhiVC2A7Od7BK0DNPXugo6iWu+XVo57ZU9uUK56BIwwdPbii9vhtkMsfgMRVzN7odglBWGD0bOgWKJLeNLKLgznSXX+MmOoLwIPI7Zbu9FondZmpJxrM90rDQkmp2q5hgbVpvowKxB+7lbaYT9tuVuS9FyzGQl3H0GbCLgRSvIJv0eoN+gmw2nVrCOZVcn9kKwiiCjeTrXuKMrWBleMHXRUgKPK6/H9AbIQeCRpS/A1RsADxFywMYYcVLDIMrBSKq6b6hMqKQe8W+BavKvTbPavxu5oXeLmNxHT1fKx1aIbtnx8afR5+FUgeKoQq0zAcLNX01dD/jr/jqPLJxvInvEzJM4Ap5q2zHAcZXbs8kgL34MVUXxFjmKnnd9olqLdJt4NO55xmVL8zQBrAplu56FUqwRHVvgbaGYM3LejsAOT9Oq6GDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(451199018)(38100700002)(36756003)(86362001)(83380400001)(26005)(6506007)(6512007)(186003)(6666004)(2616005)(6486002)(8676002)(66476007)(66946007)(4326008)(66556008)(478600001)(316002)(54906003)(5660300002)(8936002)(2906002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y3ZO6s0dNP9SaCgjJyA5iXkdrQZmGDLaRQ/bEeJVm8q8aAkMtdfSjKH5Bmaa?=
 =?us-ascii?Q?mx/3o7vQU5USFiMQZfi1Mj+pxMLlQo5wpPJRGS5/DQeNniy36RiLHh6JeRu0?=
 =?us-ascii?Q?1ruruA+5FJ7Cv38WKr+JDT+cEYNFq6oayEynvvLI60WQJrpN4w2hAfm+EKjQ?=
 =?us-ascii?Q?R0jDRzmJ/tE8WuEwai4JFIYTRpJUK8OKIJhcJywVTop5L+Dy6n9CcsHa97ZN?=
 =?us-ascii?Q?Rk27XWsq2Bh5dbGKQrRolp0Onnf6b5R30kOZ5LGbx1A+734Uqj09KLQSu+g0?=
 =?us-ascii?Q?XFbLwUypDbBLEZEuTXILB4idrv3FXW1BByutqxxGvqlpvnCEE08xhbPwciBg?=
 =?us-ascii?Q?qkCA7fONsrK2l1ivQ1dswJyXWqndfss4qZ6MR8CSGRuX/tBhWDVyal7f8Gb6?=
 =?us-ascii?Q?nmKSW54GLKbXsjBM+NR6t3xYWDGGEG2DzM1H7vfC13EMVY2IMD/BZomlBUX5?=
 =?us-ascii?Q?oyFyLvBg97MmOS5rcSSAXTfUbPdYUuMh+D5WM43enOjjyEQYBvrbzUbNpZe3?=
 =?us-ascii?Q?oo2c11WIQQA6fweaRrmWNEACykAQWw9uZ99bhYqz3ziTz2l/KKjxIWM0IsbU?=
 =?us-ascii?Q?Lxm+LOSS0ypv0iVMhJPvLomjEadOXbdnqqh8yVc2s5YcSXCtx+rpTyZXVO03?=
 =?us-ascii?Q?aNNa/fx9fEjJa7S+xJI1D8co2C9/QBnCbOquCuz1Kn8EfkqzZxyqelEZtMxU?=
 =?us-ascii?Q?Xc4YBRe+/vT3xPcpZtrfYdXHRThjbxaSp/+rIUPByzr+TJ19aKYP9hiIKNoV?=
 =?us-ascii?Q?ujC4aKXOwCmrfzrtRUUaZOuXlLbBYQ6m1EzU72E93rgoxhGC2D1gyFc3wCkT?=
 =?us-ascii?Q?6hl+F+cYJZxyq3ooXOcNkaBM9D3KME0EG1MmXJVN3FKmNdJS6nWVlpbzwCI2?=
 =?us-ascii?Q?4SQhw+w6anMk5NVbSUlmBTWL+LVC9ohD+isn7JWMW2GEvBvVJtGOV/83sj7s?=
 =?us-ascii?Q?wyM5P3dZdKDgSZYw2sWpAX6Pbr+upWnqeLc4fgF3W1dCy/FmxOPC2oVB7SA9?=
 =?us-ascii?Q?HX2MrlcsORK0SHSfuP30rf/SUXYS4XcOJMiw4QXn1PqYLZUT1mpP7d2H8o5I?=
 =?us-ascii?Q?OS3krKAeFwde557jn2uHWW6kyjwjukEFwMQrnUKvbZLXDs5H9PoXhkvihNft?=
 =?us-ascii?Q?fKTuRtf6DcdDBzkV0uVWMXl9zdMWiOiSV/swaT5EaiJwgkiZoaYUdkRqdeKE?=
 =?us-ascii?Q?NnxyKV2Nh7EJWlNuR+oIkzgnH1uYweNb8HPquB/BYLzXKV9ADvnqzk3sonGI?=
 =?us-ascii?Q?1xZwHN2WTYAPIzbzSYyBAKJJHkbz/9zwkPoqn53jAEqMKWgBaHPqOO/WyMEn?=
 =?us-ascii?Q?eqaTf6NxFQtdBYlrXMSkTstUDcnyaiuHUGFNQLaFgtkYPDgURO+GstXxjkVa?=
 =?us-ascii?Q?cyrPQId/iQHKQh3wnWUiJ4HNZ5sQYVVdDlai76RpE1F/0B71a8uXJlCsJBbp?=
 =?us-ascii?Q?EVLXqcui4FU8sVzyWI6quxFHGZXwpb4KaKBORCXnic5eOsw2+SykA+scdLdX?=
 =?us-ascii?Q?VdSyVPkF3NO1mTkvjPBjvNGatTNQfmCj1pMD9UuRu73MaCEgQPcmfmdbUajt?=
 =?us-ascii?Q?7P5kHohq4JPcFsV0W42SCAw2LELw79UrETAkMl6h?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45f47f48-197e-4dff-9982-08db2a408d79
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 19:14:54.4761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vL0NgmJvX/x4nNyai50N8lA13xHT4zeutAYpK6odZKMaHWoWRM46Kf69nHmT402h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8237
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Test the basic flow.

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

