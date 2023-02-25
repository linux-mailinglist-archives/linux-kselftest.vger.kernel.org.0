Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564C76A2592
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Feb 2023 01:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjBYA2R (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Feb 2023 19:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjBYA2P (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Feb 2023 19:28:15 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347401A4AC;
        Fri, 24 Feb 2023 16:28:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9ooRtsnp6DS1wKhQ4701a0abNg/VZiGo0+kIyXNILtUEmYfSmj1GwHLfN9Fsxdl9ZUWIwdlNWVafexwjTHo8jiS6GmSpNO44u5py9YiluUTfLfF9YTyLJKpXFT5z2rZTdNEU61pJFJDVVGOMeCPE3xMvF6F0aNmkIiWi3Ko3UKt4oGrR3lDq3HN2cugM2LGuaOUhhKE+5DB4i4sUsj8ViIdh06GqQuruRYsQZQCCVeRoEyhicaY5i/mfagOmGGZgsvf6ngBKBF8kywQJDwTcQAiJGTH397hFh9MMze76/MjERIAehBvY/nf7vLkO3CHNOHNpG+gRvyNKV/9CXXnLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zpFyVsyIrY75L4aZxMwQJVdSVVOpwhFv5KjASqlkCek=;
 b=PhiPiR/ZyoH9S0bNBhKFMFuxTN/LUmt9pB6XdDsdTnyM8aTksAr1nk1PnqE73V+dxnOpQNL55o7PEwV8SnVkOZhlaESA+/ScyJrT7hJwc8+fA0Bmtg/KlidQGiWsG6mqgYxmSd/N2quzumQluGqZQSPZsSdqX4/8xkM9WIRrigYYtqwFJ7KUEY3c2fIQO5/lZl8KjJ+iGe3AmIRXsO3DiuqYQB0vmGVKJc0BUTLlEyXUWkC1AXAPlQfF9ZK8kDZtYh4gWjvqL3eLEBPCbNxQxIf1KMp90fx8I/QR5JWIUKdWtaMsSzp/RIdzkDi8BM0t/e2RsAyqHZdEEL62iGj60Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpFyVsyIrY75L4aZxMwQJVdSVVOpwhFv5KjASqlkCek=;
 b=raEMj6TI70rmWtg5rb21rNzvqSmGjq0o3Z+uJmhKbchg34jOMTxqEtU+SmZqH7wMiWKLFshVedOxZ0UBd91ecN3gq2BEWz9dtxAFojWJQagJD5IZm9cnFgFRtQgxhFJLBmb3ABhROM34sUJJifgqtBs+jlD+BdZtKQiBcc1qvzo+OrhuOPOy6jL1lt7D3uss0GKH0XNXcJ37NvMRi7gIocH5EANOL0xNAyvWAg6MDkG0XXhuCN1qbsMYA4eBR41fyoUfGWTuFgb0dvomdzpkuOe6va3g9uqIkAW6eIckz8KmnYHIQ9ggYAM3PbTAOdU8C6sMxKgLPl8o6aL+KdRHzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB8019.namprd12.prod.outlook.com (2603:10b6:8:14e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Sat, 25 Feb
 2023 00:28:08 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6134.021; Sat, 25 Feb 2023
 00:28:08 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     kvm@vger.kernel.org, Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 13/14] iommufd/selftest: Return the real idev id from selftest mock_domain
Date:   Fri, 24 Feb 2023 20:27:58 -0400
Message-Id: <13-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR20CA0011.namprd20.prod.outlook.com
 (2603:10b6:208:e8::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB8019:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cb2bd04-1cbe-4d8a-09ac-08db16c72853
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nVPsfQXHukqy/i2Xdt+yNGSupVWhnyWl824aCoMSiM5JxDvxcU355d87jlrKwMDH6kDplAkFZ5Dl3UBKFCjKanCyl49R7AHK30hUY0zLH66sKPNNUwQGbr48xgnFClFBGcx9X/NB4brhRq57MGKyr57euM5fZHh1JMSodskVjnkY15/Epvd8kxmIiTH2mNhE1nBfAQuDkuS2iL4EeABA80J95xfg3ExpxqBoDebc5zamP/gLrl5K9u5i8MsEANiAnk7aXuLGD9bFOklQrMFYLu4kAvLfMDh8cT0VXUMG91COOe6fZPn8eti52Xd724Xg9hAlRqo10JkdHQjng/uXFmIKZJCVSGsMOBeFtRB2zILvvKAGzYzMMnmVIMSn8ER7F7yZhBl9VPxyyS4cWTHsl32IiaVvG34iRDP8/UXjLwPV4tCYwfpu2Dv7+KscHb+lYarbXRwMJveAFc+v2QF1AfV0kD4J2k1ODmxYvQD8+phQ5vXs0eeghMLiVZLAQHMzvWrjMe8BLJdCr7IqL9DgcH2jPXpPRE89d6Os9GKaqhboWVAJU3XG7IJmhac6xQqvVh83kWKZF0zbo5keRs0VCGj9PBd1RdYBgTqSGDXsrAu8FrGVD0UfqHbyeIaGWkvSqg+tdpdAjhDZ4fgyW4w42A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(396003)(136003)(346002)(366004)(451199018)(36756003)(2616005)(316002)(54906003)(86362001)(6486002)(6666004)(26005)(186003)(66946007)(2906002)(8676002)(41300700001)(66476007)(6506007)(478600001)(6512007)(5660300002)(66556008)(4326008)(8936002)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kolXuKMogYENc466WEt8oVTcMNhSNGtzOiLXzNiHby8zZ18rFkd65bo/QTdN?=
 =?us-ascii?Q?KatvSwXnsdt77i21kKOWT7c/e6Dvcs9+j5vd4XD0BkDPpymUCCzJhAGBc+iu?=
 =?us-ascii?Q?DJ5F0B76Ewa0adnAS/eXkxCJyG3w0Ns0F2FUCd6Zgj+bpZSR/L4ouQST+KMk?=
 =?us-ascii?Q?nJz22SgBZcLGT9otZra8ZEUr/++/T/ZAW0Lta+xkkm9u6/tLMYmZjnIcsLAw?=
 =?us-ascii?Q?E7L46JSHTepUI5TWWxWL2NCg/8LK1BWVVoSKJ7FGk+TSCSiPqWU5MIjiERxd?=
 =?us-ascii?Q?+J3n+Dz/HJT/cdsUS6PkX0lm62nxARjjpaOuLPqJTyCsrVfhcHMuTXI+kW6a?=
 =?us-ascii?Q?sH9+i6vG8RmHnfPhscnyFX9t8wPzbNt/mq7FMLb2b5R3h5rklx+O7bUHfT7t?=
 =?us-ascii?Q?nVY49erQDOpGu5CJQlLiuqB8e1t/b9ECG8Yxg1VuhWT+4VMmfddCXjWAkbsf?=
 =?us-ascii?Q?u6tqEIDVP7zVPL1Vl+YLWpgjUtUwuA7uUHK5j3yqG2hF2JZYizEMjK5sqcZN?=
 =?us-ascii?Q?vBtd/LxSYmUYWAbSVbjSIzCfhP38mQHdlrlnrBDypEOmFmtLeCf1olWF8uOY?=
 =?us-ascii?Q?cHfsBL1MC3xTliiNdhNthGMxhFJiOFYij/sel5p32rFM5z2XmFPmerQNwt81?=
 =?us-ascii?Q?bFtXEh8UqeaFEJNQB3FcIBAdhgtMLIfCNIwREDGrBxUIeusHUwL7pg9kdmOs?=
 =?us-ascii?Q?mePUgApyWfOhakfWu2ckUAQba4rT5NFfSArhkIEiJJmsCPtGDo6XeEJ7Snik?=
 =?us-ascii?Q?EyVF/P268x6aZRC1NSH/lbRpaolF5IDvBwso6cuIhfpWBDPIe2xxcY7ZhWaY?=
 =?us-ascii?Q?GTM0G/Rkj+MFKlAa3z2DlBL7X1V6zJF12WBnELfUrcF0pgHlitWhFpPhq1ui?=
 =?us-ascii?Q?d01NRmvY4Leg24MrWsKTmlCuQg4cB2FjefIy7wFkY6LwLd6QueYM2NYxdoJu?=
 =?us-ascii?Q?kYNb60LkuNzhcO5ZDTZ1adi/8Nh6mqGiQcyXOMZg16FzGXhLZIlvoPTuJ8jy?=
 =?us-ascii?Q?nj72rMb4e4nXQcPPpx4shKJm+2y7WJMAvVgittIp5zt8LUFh4CdDR+GRN/CM?=
 =?us-ascii?Q?sS+Nv/ec5uZUcDijtL5XbmKJIBAFAORWgZOxjUOod6UcQpekt+xng0ZB8HM6?=
 =?us-ascii?Q?Gjftgt6WoLCvrsOiVzORsUW4laXw+o96Cs9sSl7mCl+i/r+UJp8g8JsEmLMc?=
 =?us-ascii?Q?OsBpd7oE9X715tgWFq5tVMhTbmXJAVndMO2J+ZnnCkWzHkrAWb20y3B/LawM?=
 =?us-ascii?Q?K7qPcHS3/uc0eYSCLJ5ilMUTvzwYkqd+V6zqtfGgW6gmhLhhZx+HJq6AWF/n?=
 =?us-ascii?Q?fFtA2FYWyujGXONsdTCD2CzOJJjXrDIGQsOVO+VbM5/z2DragQ7nFnyxcKbJ?=
 =?us-ascii?Q?IBN1h1qD2SXGn7wCvGB7l8VoKEccg0HZXmhXK1yPYRTM9kTLyLPlAupzx4QW?=
 =?us-ascii?Q?5r/88C5mPMmh40NEkIA2KSV+fpIMPHTDUQ9T0ImkRqxgNS7PwQEnpKZKbnGR?=
 =?us-ascii?Q?+SFNzQ9BaPb84fIGNijq9DpxnMQL4rVgC5Tmz7YzyXUYA6b4C6mCH83apv1u?=
 =?us-ascii?Q?hrt4lc0PVlWJX7OBfPZ+huqhKzxZi1ZefI53uIIO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb2bd04-1cbe-4d8a-09ac-08db16c72853
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2023 00:28:03.5921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pa4tqA/y5zuxhM1GShrYCfk0Y4AiVLXFiIvSjVDiGWgkyq4lYukmvKhHFi80q3tn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8019
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Now that we actually call iommufd_device_bind() we can return the
idev_id from that function to userspace for use in other APIs.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h          |  3 +++
 drivers/iommu/iommufd/selftest.c              |  1 +
 tools/testing/selftests/iommu/iommufd.c       | 17 +++++++-------
 .../selftests/iommu/iommufd_fail_nth.c        | 23 ++++++++++++-------
 tools/testing/selftests/iommu/iommufd_utils.h | 10 ++++----
 5 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index c60c501775e9bb..d35620158c8b15 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -50,8 +50,11 @@ struct iommu_test_cmd {
 			__aligned_u64 length;
 		} add_reserved;
 		struct {
+			/* out_device_id is the selftest object */
 			__u32 out_device_id;
 			__u32 out_hwpt_id;
+			/* out_idev_id is the standard iommufd_bind object */
+			__u32 out_idev_id;
 		} mock_domain;
 		struct {
 			__u32 pt_id;
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 701d6d6be3f06d..9cb206b31374fd 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -443,6 +443,7 @@ static int iommufd_test_mock_domain(struct iommufd_ucmd *ucmd,
 	/* Userspace must destroy the device_id to destroy the object */
 	cmd->mock_domain.out_hwpt_id = pt_id;
 	cmd->mock_domain.out_device_id = sobj->obj.id;
+	cmd->mock_domain.out_idev_id = idev_id;
 	iommufd_object_finalize(ucmd->ictx, &sobj->obj);
 	return iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index e1252a874f0b32..7e6fe263e1b62e 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -214,7 +214,7 @@ FIXTURE_SETUP(iommufd_ioas)
 
 	for (i = 0; i != variant->mock_domains; i++) {
 		test_cmd_mock_domain(self->ioas_id, &self->device_id,
-				     &self->hwpt_id);
+				     &self->hwpt_id, NULL);
 		self->base_iova = MOCK_APERTURE_START;
 	}
 }
@@ -265,7 +265,7 @@ TEST_F(iommufd_ioas, hwpt_attach)
 {
 	/* Create a device attached directly to a hwpt */
 	if (self->device_id) {
-		test_cmd_mock_domain(self->hwpt_id, NULL, NULL);
+		test_cmd_mock_domain(self->hwpt_id, NULL, NULL, NULL);
 	} else {
 		test_err_mock_domain(ENOENT, self->hwpt_id, NULL, NULL);
 	}
@@ -650,7 +650,7 @@ TEST_F(iommufd_ioas, access_pin)
 				   _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_PAGES),
 				   &access_cmd));
 		test_cmd_mock_domain(self->ioas_id, &mock_device_id,
-				     &mock_hwpt_id);
+				     &mock_hwpt_id, NULL);
 		check_map_cmd.id = mock_hwpt_id;
 		ASSERT_EQ(0, ioctl(self->fd,
 				   _IOMMU_TEST_CMD(IOMMU_TEST_OP_MD_CHECK_MAP),
@@ -805,7 +805,7 @@ TEST_F(iommufd_ioas, fork_gone)
 		 * If a domain already existed then everything was pinned within
 		 * the fork, so this copies from one domain to another.
 		 */
-		test_cmd_mock_domain(self->ioas_id, NULL, NULL);
+		test_cmd_mock_domain(self->ioas_id, NULL, NULL, NULL);
 		check_access_rw(_metadata, self->fd, access_id,
 				MOCK_APERTURE_START, 0);
 
@@ -854,7 +854,7 @@ TEST_F(iommufd_ioas, fork_present)
 	ASSERT_EQ(8, read(efd, &tmp, sizeof(tmp)));
 
 	/* Read pages from the remote process */
-	test_cmd_mock_domain(self->ioas_id, NULL, NULL);
+	test_cmd_mock_domain(self->ioas_id, NULL, NULL, NULL);
 	check_access_rw(_metadata, self->fd, access_id, MOCK_APERTURE_START, 0);
 
 	ASSERT_EQ(0, close(pipefds[1]));
@@ -1002,6 +1002,7 @@ FIXTURE(iommufd_mock_domain)
 	uint32_t hwpt_id;
 	uint32_t hwpt_ids[2];
 	uint32_t device_ids[2];
+	uint32_t idev_ids[2];
 	int mmap_flags;
 	size_t mmap_buf_size;
 };
@@ -1024,7 +1025,7 @@ FIXTURE_SETUP(iommufd_mock_domain)
 
 	for (i = 0; i != variant->mock_domains; i++)
 		test_cmd_mock_domain(self->ioas_id, &self->device_ids[i],
-				     &self->hwpt_ids[i]);
+				     &self->hwpt_ids[i], &self->idev_ids[i]);
 	self->hwpt_id = self->hwpt_ids[0];
 
 	self->mmap_flags = MAP_SHARED | MAP_ANONYMOUS;
@@ -1218,7 +1219,7 @@ TEST_F(iommufd_mock_domain, all_aligns_copy)
 			/* Add and destroy a domain while the area exists */
 			old_id = self->hwpt_ids[1];
 			test_cmd_mock_domain(self->ioas_id, &mock_device_id,
-					     &self->hwpt_ids[1]);
+					     &self->hwpt_ids[1], NULL);
 
 			check_mock_iova(buf + start, iova, length);
 			check_refs(buf + start / PAGE_SIZE * PAGE_SIZE,
@@ -1427,7 +1428,7 @@ FIXTURE_SETUP(vfio_compat_mock_domain)
 
 	/* Create what VFIO would consider a group */
 	test_ioctl_ioas_alloc(&self->ioas_id);
-	test_cmd_mock_domain(self->ioas_id, NULL, NULL);
+	test_cmd_mock_domain(self->ioas_id, NULL, NULL, NULL);
 
 	/* Attach it to the vfio compat */
 	vfio_ioas_cmd.ioas_id = self->ioas_id;
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index 352835cfe84de0..f2012db43fbc16 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -313,7 +313,8 @@ TEST_FAIL_NTH(basic_fail_nth, map_domain)
 
 	fail_nth_enable();
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &device_id, &hwpt_id))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &device_id, &hwpt_id,
+				  NULL))
 		return -1;
 
 	if (_test_ioctl_ioas_map(self->fd, ioas_id, buffer, 262144, &iova,
@@ -324,7 +325,8 @@ TEST_FAIL_NTH(basic_fail_nth, map_domain)
 	if (_test_ioctl_destroy(self->fd, device_id))
 		return -1;
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &device_id, &hwpt_id))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &device_id, &hwpt_id,
+				  NULL))
 		return -1;
 	return 0;
 }
@@ -348,12 +350,14 @@ TEST_FAIL_NTH(basic_fail_nth, map_two_domains)
 	if (_test_ioctl_set_temp_memory_limit(self->fd, 32))
 		return -1;
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &device_id, &hwpt_id))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &device_id, &hwpt_id,
+				  NULL))
 		return -1;
 
 	fail_nth_enable();
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &device_id2, &hwpt_id2))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &device_id2, &hwpt_id2,
+				  NULL))
 		return -1;
 
 	if (_test_ioctl_ioas_map(self->fd, ioas_id, buffer, 262144, &iova,
@@ -367,9 +371,11 @@ TEST_FAIL_NTH(basic_fail_nth, map_two_domains)
 	if (_test_ioctl_destroy(self->fd, device_id2))
 		return -1;
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &device_id, &hwpt_id))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &device_id, &hwpt_id,
+				  NULL))
 		return -1;
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &device_id2, &hwpt_id2))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &device_id2, &hwpt_id2,
+				  NULL))
 		return -1;
 	return 0;
 }
@@ -526,7 +532,8 @@ TEST_FAIL_NTH(basic_fail_nth, access_pin_domain)
 	if (_test_ioctl_set_temp_memory_limit(self->fd, 32))
 		return -1;
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &device_id, &hwpt_id))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &device_id, &hwpt_id,
+				  NULL))
 		return -1;
 
 	if (_test_ioctl_ioas_map(self->fd, ioas_id, buffer, BUFFER_SIZE, &iova,
@@ -588,7 +595,7 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 
 	fail_nth_enable();
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &device_id, NULL))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &device_id, NULL, NULL))
 		return -1;
 
 	if (_test_cmd_mock_domain_replace(self->fd, device_id, ioas_id2, NULL))
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 68dbb59f9a515a..807a2421121b51 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -39,7 +39,7 @@ static unsigned long BUFFER_SIZE;
 	})
 
 static int _test_cmd_mock_domain(int fd, unsigned int ioas_id, __u32 *device_id,
-				 __u32 *hwpt_id)
+				 __u32 *hwpt_id, __u32 *idev_id)
 {
 	struct iommu_test_cmd cmd = {
 		.size = sizeof(cmd),
@@ -57,14 +57,16 @@ static int _test_cmd_mock_domain(int fd, unsigned int ioas_id, __u32 *device_id,
 	assert(cmd.id != 0);
 	if (hwpt_id)
 		*hwpt_id = cmd.mock_domain.out_hwpt_id;
+	if (idev_id)
+		*idev_id = cmd.mock_domain.out_idev_id;
 	return 0;
 }
-#define test_cmd_mock_domain(ioas_id, device_id, hwpt_id)                \
+#define test_cmd_mock_domain(ioas_id, device_id, hwpt_id, idev_id)       \
 	ASSERT_EQ(0, _test_cmd_mock_domain(self->fd, ioas_id, device_id, \
-					   hwpt_id))
+					   hwpt_id, idev_id))
 #define test_err_mock_domain(_errno, ioas_id, device_id, hwpt_id)     \
 	EXPECT_ERRNO(_errno, _test_cmd_mock_domain(self->fd, ioas_id, \
-						   device_id, hwpt_id))
+						   device_id, hwpt_id, NULL))
 
 static int _test_cmd_mock_domain_replace(int fd, __u32 device_id, __u32 pt_id,
 					 __u32 *hwpt_id)
-- 
2.39.1

