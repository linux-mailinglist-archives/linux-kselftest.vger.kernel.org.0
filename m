Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109476E9C0C
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Apr 2023 20:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjDTSw2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Apr 2023 14:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbjDTSwF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Apr 2023 14:52:05 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600B346AF;
        Thu, 20 Apr 2023 11:51:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fcRFhMyOu4OzuMocNbpBRJ/LCy7vWRYAXp6U8A6qqADZuvyRBnKAhLibYr2UJCuM/AiCEEHxlBdVTJtJJkPr2EU5Y2o6oyhYa9P/962EqNrB241MmTe6PhPMkxBaDGl8lghGUta9rh9NQTsdCdN/m+e8dqYjG2wxnkuIYd4uvlSi78dpBViTrL/qYutVEQBN9mWeBp+tgBZr9CZT59p3E38owXHU3IL2hgJZ60JlguuEuYU0gOvuHPd2zS2I8RNu1Llhnpz8qNMIi95aW5BXbgkb443mfTI+c9cIfvC4z9NLyq7TeJ5Mhfxiv9O8iK7QkdMBkN9cvZBGMmKIsZiqjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YolAE6BNvfYz0E6dQwvzLuefk2hk+Mt9iPrHht8Q+D8=;
 b=nmHa8SM8Cbtzg4M8oJELzlJoHXkhRr81KUz9sQR1/0Y+1xdtC5v93x7U7EPstFI8w/t/T/HKmB32CZbsIKTiRh7tvnE1MUHju/LptUCJjdACugvKxEqP3DG9/BgczzVXBLG1+JAAkQUt/0pC63q+ngoeqyu8DtFUGIy2dp3SslYwJXZfi+9MPJ8B5+hkpMoeUuXEufYo/EyP+wQsPEwb7enxg9c0CAje7q3wBx5JMmJgqkQb8ofYJmYshPEQp+iaeABX2NBf6iBT3cTPa1EvIRjPut9dnApIIENdsYS0eR1w7d5PcYQhLKNlWFUtTqL7h67zV5cAumSazQIwPQuIeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YolAE6BNvfYz0E6dQwvzLuefk2hk+Mt9iPrHht8Q+D8=;
 b=Ch5lRF6M8dyyjsQgyo1kSjQj+dc+idHEfIa2R6AwopeP58gf1haDfDe7K41H9g/91UoRwtLfgurbtgrvJhkhGGfuB7j/pd7F0LRYWENdJ4YThOOQgtYi8GkvK6GbNBMENuPbv1UAjxJOcBDVrtTVt/ahhoVDPPFRxs2fJH0Ua6i/iEmEPN9JXoi/F7GmwldCJNqRYr+/uifEyCBZRKxjm2uq3fJYGnLpYkmQfsH0M4JbWouQB99GImLTfqAQ0B7HLVzSMpHsjoVgh+YZGhj22ZzrdyCTyKZvGqvqE2Iy6vs+AvXiECpqLGTUYwLju54y3oxascxSuA8ayZA7F6e6kA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 18:51:48 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6319.020; Thu, 20 Apr 2023
 18:51:48 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v6 19/19] iommufd/selftest: Add a selftest for IOMMU_HWPT_ALLOC
Date:   Thu, 20 Apr 2023 15:51:34 -0300
Message-Id: <19-v6-fdb604df649a+369-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v6-fdb604df649a+369-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0343.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4553:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c749862-d9bc-4937-81a8-08db41d04639
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7BOpOzR22aXWCgCkR0Qxog4gRau4uJfJM1USQJPPSxYLVTq0W31wBttsyfKWr2ari4T9YfmfLD1wZxf1nb0zSEx8CsvIt4c5qgdPzBPojIJkaCmW+dT7hzJMZwwe5+IIR7UO0UcxI1Btj0P7xyEdvPEH2/w2+BmC++SnKf1BChDx9QYASmQToa2jErL82xKYFNNgRw4Vy6vuISQEtfdV0RNSXWAgVw+CBeznN1ly+RHtnGDp76TDEdjLoDwk16p8sbCHF8bq6gKT2Qm2O/qvuVG7krtjuthORwI6ajoHHMjnG9XxNSx0Z9FJpfheOjadphY3nTsVF+wT8HJqBwMTxtEWqQboIQQrAvpfOjXo7lZbPSPKpku69EeFIne0a9FVdi6ITgq3mFhwC2Vz6PUoaChlb8PUmhMKShAFKiveHKzy0EqKXN/ekqB2r/UQG2sCNAD23oBTHu0zVqNDUQgqJ100SYxtuQRTCQ48Y0kChMTgJbjrnllDbzi3XXB46Kwf41wdC08T5G0c50qgMzb5zeAPLfYInYsOAN5ePEOzQGKXnk97IO6ZaTG2zBiem6Oz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199021)(54906003)(4326008)(316002)(66946007)(66556008)(66476007)(478600001)(6666004)(6486002)(5660300002)(8936002)(41300700001)(8676002)(2906002)(86362001)(36756003)(38100700002)(2616005)(6512007)(186003)(6506007)(26005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8vw51BuNjZarjrAfNREMC0/4i0h6nDn+r0yxD3dSOOl2hXayYLUnYJWc7E5l?=
 =?us-ascii?Q?Pp/Alf84NCJC1MBtN0nHqds5bkKNL01YNTaTMhH+TCFnKDxrpWONRMiYRR6p?=
 =?us-ascii?Q?ksVKlO6C1hPs3u2e/Csxfu1ghjRHO/L32itlGw/FC1d2rQsl39syQGgBwrPc?=
 =?us-ascii?Q?BGjC0z05eQJNMmTvx4reW/mv71yoCUUmUrowuWD/vAlIBE8vTRMPtdrMiS9R?=
 =?us-ascii?Q?hWyI5UYqa/eFtUOTloG9+zQ4L6UF48SoqZKKGUKJD5Zrnhz6W66imMx3Vdde?=
 =?us-ascii?Q?e8HvZT3H1HHonpe+A6md/9jzecui5QP+8nfDAmlRSxIYNilGTqOlXN8O6Jif?=
 =?us-ascii?Q?Gkm8iofnd7HZCnNDnFa/LjZeFyWdWkCSQwSfPPuwEtutahBzTm02h9DFSx8H?=
 =?us-ascii?Q?nOeydAudrqnSn18K9IWpTyb+MeSCUXh931ntUtSiQUMgyzzffceWH9TKH+0y?=
 =?us-ascii?Q?aiDtGyJz7ML0kUTu5E+QycsyHJ7kfo8Zp1OInd+8JrXGkXnMKZZIzzcTlEib?=
 =?us-ascii?Q?zzqyylLxUHi6E+r2ZUhg3x4UoEhw4D49VY7uO5mouzXGxrYifgevXYyJRnfd?=
 =?us-ascii?Q?wgMmpfJ82C4BO/DPFCFuw7ir9II7Lst3ION3cSUSY87BZ/R1snRpHaiGs919?=
 =?us-ascii?Q?WdYtMJa9Qkvb/64A1JoWFsv9TKEpAHP0oE/gsO+2F2E1pVfJwRFELtvHuC35?=
 =?us-ascii?Q?cxAhnhyj35B15+vA26E8ma0PTjNp/iEyIaQ2kyLd3J6POK4cUpr3TK6uhWp1?=
 =?us-ascii?Q?Kh/QWFJQ6p2TPJeCAro8UeuH0jGXtgPcKDYav8Ky1uN8jDYWC9gwquR8Kedf?=
 =?us-ascii?Q?93wDdYfSs1wij6CdNKV0A2K8dbZtfHJFYXUaTmzB/yNPUtHGlrcm+FvG00da?=
 =?us-ascii?Q?yflHKzbRM4Gnwwn4aYoei4cew3F7oA3WpHtzvzHiXq+DuSt3m5M2yGhHUpDm?=
 =?us-ascii?Q?DwDXJMRfVJ+R8HeVhOD+foFZFaa7/dizaMAWWtpQ86nBLQvpKZTzRObn2haw?=
 =?us-ascii?Q?BKWKmtVcldRx7Sf2Yc+N0nIUgGWaPiDK/iJvcbuKx6Uaz3C7vXbdGa2f9sf7?=
 =?us-ascii?Q?2nhtKbyNpn8eloRXsXxTBmgo0EdGiCv4nMObLK7UvFOnkDMu/03RbPeNWewn?=
 =?us-ascii?Q?GzI9KqW2pmjZG1i4IY68CHdcWL8fHD7AxcW4j33Z3GRtVlBKpzml+gYga3Oh?=
 =?us-ascii?Q?Pj+uldai4zpTr+pzVobLyFddvqxpGMlwh7uKeXqhY/zxA7yalvxHo3KuBSGA?=
 =?us-ascii?Q?Vj57aLw6oZRvPhOcNCQ9tlBrNe9KifYIuRft5I5SUchyNt5VFfVn4eP4kDhv?=
 =?us-ascii?Q?/VczqqEtfPIqPeVFhaTvL+jAv5ofqgOJ1ZHgFN6ey9Xqx6HROSv/2DiRaWVh?=
 =?us-ascii?Q?/rRSVsrQmVYn3GMzrLILTGgigBtm6uDmcxbO9cwLFm+eRCNFGItPsfgS4hXN?=
 =?us-ascii?Q?YRaDuV3ZOv8jyqxi4jnpeRgSg2wQs5tK39X9Z/2K2Ofkdo4MDufAEpOD9rBS?=
 =?us-ascii?Q?yJM1rFIjZeiOyxQ0+0QjFUyauex/UE1YlHrwr2j1ljVmERMQqgjHmBZXeeYT?=
 =?us-ascii?Q?CCrRRz4bPhe24dgiq+79m+0pp0E/+U0tzxB3wvw5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c749862-d9bc-4937-81a8-08db41d04639
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 18:51:39.1779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mjJLm7/S5+VhHI9KjWxPqie8wPiTjI0iocv1rA5aIV3gSEcZMeQ5bpID4ErK3M+/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4553
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Test the basic flow.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/io_pagetable.c          |  3 +++
 tools/testing/selftests/iommu/iommufd.c       | 15 +++++++++++++
 .../selftests/iommu/iommufd_fail_nth.c        | 11 +++++++++-
 tools/testing/selftests/iommu/iommufd_utils.h | 21 +++++++++++++++++++
 4 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index f842768b2e250b..21052f64f95649 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -1172,6 +1172,9 @@ int iopt_table_enforce_dev_resv_regions(struct io_pagetable *iopt,
 	unsigned int num_sw_msi = 0;
 	int rc;
 
+	if (iommufd_should_fail())
+		return -EINVAL;
+
 	down_write(&iopt->iova_rwsem);
 	/* FIXME: drivers allocate memory but there is no failure propogated */
 	iommu_get_resv_regions(dev, &resv_regions);
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

