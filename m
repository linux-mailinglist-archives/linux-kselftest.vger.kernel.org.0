Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9277756B8D
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 20:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjGQSOP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 14:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbjGQSOM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 14:14:12 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F202C1731;
        Mon, 17 Jul 2023 11:13:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bl1VapG0+Kju0rLBJZa9gYYQurBXTF6Lbn4KP3Q+OjnJFzw9FJN9j5wnXnnN52KQfgtC45EFGylTQmtrWp1qmMBPgadvonBGKuJdvgol4TkaKRA4s08/Wa3TfXmO+CvUVqHiuZif0K7564RrWOK8UghrdGDgyuGzOCEV8WCqvMf7j6cuzPPP8PcALfjdDrxXaKMjHV6KiGYg5jXuMi4GGX1LmFperoXPscvv0lQ9ytwvlXuVYaWBN3LdhC82lRHbG5qh3jIFEpg/mo43QZ7UIIBrsIYm6AerNsyjEjuQERxonB5RdQdjn5CTPcnZ98uTveIcxoB6d21L3H7+swYajA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6dttoGv0tLDpUn1w7Pj0S44VfDSejSDJqLPkW9nuJyI=;
 b=XYo+P4jj80ECZsBEXOw+VHWSWLm6gs0NYke1dHigNu1C7PrPDQtkxXWXJJ5e6JYzVawosY3TzMNWoYQjKOKowsEaup9XTmVCX02jwldC/0+5RnLBImr4U3wvfJKg+rM+0EYJqyV8De6tBJiAqSGzje8ll92/sSMYtxwbyIWLa/MrxHCF1OnrHgYlZGnCzpIqCvEWDFKOZHehgzN1hJwqhkvQNWZH67+5pm1Zs9PxbDaupDyxN93foZAtrgzV6Pdtzgk3esvbxFmc00T23QJlpXqxs89P+2IBnZsfCnT64UdT1W9CowCz3bWR6ImhQrSrsHKI9RUhk0SV+s4A/YlXzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dttoGv0tLDpUn1w7Pj0S44VfDSejSDJqLPkW9nuJyI=;
 b=i9xbCzo7PQAl6/2mrphzlBM2thpi0goy3iziLZA6TLbYvF1eDop1yz7YU5mOr6Xnpm0ODesIhswRxugGp3/v2gYgnOStDIXfn29Iq73AETHVad7Xv0ANJoV5ZUknfAbN+Ba43R+kwOOD0g9wFL5ay8qa9iCdXnAt/Np/fkta+GmruGhxFfgpMaES88NEpzFJYIqXY3qEkVXUahyk982ncxNATDjW0P/ubyFTW51A8MG0bW6Z3+BIuT/21Ff+MfXm9yEspcpxNVHw/GS4iGzDNFL/jZEOM7TmINce8VzF2SpxJloXkH0Myx3NWfCnE73AJVeowIDYxmB2OF2Z0YQudg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6205.namprd12.prod.outlook.com (2603:10b6:8:a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 18:12:22 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 18:12:21 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v8 19/19] iommufd/selftest: Add a selftest for IOMMU_HWPT_ALLOC
Date:   Mon, 17 Jul 2023 15:12:15 -0300
Message-ID: <19-v8-6659224517ea+532-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v8-6659224517ea+532-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0202.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6205:EE_
X-MS-Office365-Filtering-Correlation-Id: 723008c6-58b2-4fdb-3859-08db86f15b7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UbhyC69E/nv0HKd0xf3bUwrvMVKKW3ur64crglMOwewqud3gXITipCRxLcIu3rw7rmaFKusipDuOIHs5CI6TUZ00Uk59tkpdC6Xaw19nqwIVwQ7veN9WuttFU18TlH4Xl7FX3X4wiqfKUnitbdOiGBriz5z6HS97A49ixSJeOhmCH9KfIq7mTC68VcxpECkp2++XIdSVG8E/kFpafpjx3UX5wsdshkwncMmgzKVodbU9EBLTDZA/xsAsCXVnmJD60jJw1rGoeXuKfaaAQmCcIxG9wZK0c4OJik9AmoUilciCK//eYTH4ypRBh7r68U8aaM7ZJClWDuwAPw9CjuQ1x2BhLLcIxYXfnNzjfwViWq6YzFeT0NT5+7b8C5afqWgGrgZLGDZIueahJ0knr/zZR9SCmwTjWn1rdK0j6395rMnkFfHfHXsIGIp2Ipt1GbMAk08+fkQyiOTJigUcb6Dk0VSlvoM10ru//02YfjqOxyQFsPpCtUHIKGyccSWhzm7tVitB27lQl+Dpl6h7+uQCCJe5UgP6hFPwZqqQTlGGEQxKS0AsGsM3qtnenxSYOIIw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(451199021)(6666004)(478600001)(83380400001)(186003)(2616005)(26005)(6506007)(6512007)(8936002)(41300700001)(8676002)(4326008)(2906002)(5660300002)(316002)(86362001)(6486002)(66556008)(66946007)(36756003)(54906003)(38100700002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YiekfgnrdvN+VXUN6pr+xEsdVQOS19IoTaHc33QeYvy7W0C/2pUmvJkQHN45?=
 =?us-ascii?Q?0XS5k44d6UWeWxxANWnsguDphMdwaz8h/WVqzYjuIm6Wy51eUzJdregkCezh?=
 =?us-ascii?Q?cjtg8b4sKRm7UHovoSRHliFJhm5XjD9/k3q5LCoekhQCIjuDrrfcVFSET50b?=
 =?us-ascii?Q?T7/5V+AIfJDgj12DdMr1uQXr6txf2REOSCE9Wl9VjE9r5GTilHaneppN95ne?=
 =?us-ascii?Q?b19BGUE6YqbXqaN75zFYGIloH+48+WCPSy/jZvIYGbnJrb2P4St5Sxq12htG?=
 =?us-ascii?Q?N9aHyEC91nPCuT2S/kjcQ1+uSB3X0QfmTVkAACRwMlBnRh322q6S9uy0kny5?=
 =?us-ascii?Q?JMFdiEFMZnJdL/GVygIJXbCHs2MGkrm4DgPybeqL/KZ66r/MEkmXr1GP1FeN?=
 =?us-ascii?Q?7gnoxzdH2HljsIAB5E3iE/TWeB8+k3AJIvxTCVqxQyzjQ0pauPxghbsOz5jx?=
 =?us-ascii?Q?LuUKlddEAkyMFDe1avqx6BGuJTDrjqPgH+aNQqli1qM0DMV99te12AeS2cPx?=
 =?us-ascii?Q?4/4A7zVDqrTOzpNj/xiT5cGrXjXTHdxOyD1zyVODjsKOyUiePs9OPqx9tP6t?=
 =?us-ascii?Q?YcJd2VlR94U9Chw3Og308W78yd8H4jjtoLYeX3LdlMxypQatJl4qXQ/GEhV/?=
 =?us-ascii?Q?84TilWGt0ixHFxWt0KKko5davZQrTcgg58MElQkmkpY6V4eN8kA39MoZtQqH?=
 =?us-ascii?Q?8+FD8cltiQdZgxhTjYYCx6bbXPeIDl04DrJcKWepOoE67Wrg77uGmcU8Dmj3?=
 =?us-ascii?Q?FfiU234+L9yQtkUyXd2WWx9TIaQNiti93pIiv9Ezw6ThWy56LhaVExgJBD87?=
 =?us-ascii?Q?pvB+KCymEflAI1j13iRddJHstHDMEFZRkY+4WQzsdxDIArTNf8KoSDq0yusQ?=
 =?us-ascii?Q?/EoTyUYmfvDwv4XsJnwg/Vh5eEYuInXEi9DPjO1pRcbJptgvtkO/xrBGZDj4?=
 =?us-ascii?Q?ekgTU9mxUtsqn5htie70UxWv0dY7uvAF+2SyZ/reEpyWOpZEycdM47Y12jSL?=
 =?us-ascii?Q?ePTLWSeUcM3asAlnllFEcGt1hyXlZT55hV/stZJ5Ge38iXz6tjiKQO7xjmX+?=
 =?us-ascii?Q?hrzS63mc3v9CdCEjuP2ggRIIWlgh7aUCvStFKzzwWWHXW1nGejbWq7LvOULR?=
 =?us-ascii?Q?onn7q4sYAae2VXQr3QPPSj52QTKf/xqlyF/HaXcmVDbPex6FibwVpkcy4j0i?=
 =?us-ascii?Q?c8hXIEx7d2UNg55H/2FOMWz4KP5KnCbXIsZ8XgqvzhYQzT/O/9COVnXIpGsy?=
 =?us-ascii?Q?eH+ZvSkfLqfqhDMegdSRcU0o0/FeSwfTOukikEAjnZ1u6J78zne+SF4YddmR?=
 =?us-ascii?Q?MCNGzkoWp9lQD5ZiaLjpT+zIDVv/JaYKxDYCYT6xJyVwvGwVEx8+tF2fX/GK?=
 =?us-ascii?Q?tJaNaIGg/3goIjIfcooHR6lUsuxISZOzbdSdTSQbSPfGZgt0DUOyeNqps9Zy?=
 =?us-ascii?Q?yyOa0swckMsypwfT0cHgADOAyO89wv5Pw1xUdYV1UUftLYp3CYHnYRphRemN?=
 =?us-ascii?Q?xs6Icu7C46jUEugJwov786ckUufPAUihs7ZcAEnS7Z232CglGp3eMjsfsOom?=
 =?us-ascii?Q?CoQ72S3LqYgeZcI75PMVrHxUQTdgyNeVh+1UmXjR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 723008c6-58b2-4fdb-3859-08db86f15b7f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 18:12:18.5054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MammSpFFpd0pHXl7YqProk5O3H9oODvNtCrkG2y1jEikBE8YGBDf0O9JcEdXZQxV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6205
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Test the basic flow.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/io_pagetable.c          |  3 +++
 tools/testing/selftests/iommu/iommufd.c       | 15 +++++++++++++
 .../selftests/iommu/iommufd_fail_nth.c        | 11 +++++++++-
 tools/testing/selftests/iommu/iommufd_utils.h | 21 +++++++++++++++++++
 4 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 112bea5a84e43a..4d095115c2d0b8 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -1180,6 +1180,9 @@ int iopt_table_enforce_dev_resv_regions(struct io_pagetable *iopt,
 	unsigned int num_sw_msi = 0;
 	int rc;
 
+	if (iommufd_should_fail())
+		return -EINVAL;
+
 	down_write(&iopt->iova_rwsem);
 	/* FIXME: drivers allocate memory but there is no failure propogated */
 	iommu_get_resv_regions(dev, &resv_regions);
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 78841aba47d038..dc09c1de319f05 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -1338,6 +1338,21 @@ TEST_F(iommufd_mock_domain, replace)
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
2.41.0

