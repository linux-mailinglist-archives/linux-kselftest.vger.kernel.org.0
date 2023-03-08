Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522846AFB46
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 01:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjCHAg0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 19:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjCHAgT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 19:36:19 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20608.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D05A3B43;
        Tue,  7 Mar 2023 16:36:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BpF/SZmUjbrOOZipzoBoM0eb/hWNBNIDvvmXNwKNHThfGqfoD0vUMmlZQDoe//ZP317/gg6l79L3znhdaFnMXwx4Bptjdg+HvgZJ8O7RCdaQ7O4sF43H/q/Hzk5gn8Yv1tMJbg30/Fsn3Iapd7GSYx1TVemV99nK0HRMDOiSxnEIP+6KleMvj1Z5EGr2Yh1/rCh8QGGU7pkCqHScgHxP3/lUR4jJDLo1m5BMq1BXpu3g+gwB1DW8xjSdZiJMs7G+V7DZLtN1QtDlumOBMB5xj+IGI6cSOHWDNhu9Kf45//O84aflBkgAK/G5uvEAAqshqvEDZ0aBgJACs/wnmMKrOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWNmTsLY5vQfv6E+IgOlY+ECzeopldYwfZ8lazNJcjg=;
 b=Yg5H+62cg0gdEPnEodWPLK6iTr6EcWtgP4J0Em6Hwx8NiRErbPs3VTWvvuFtxmubb3T865cgg6oOcpIPTNRrXHPtFKCsvdwW5NFMQRpnxKL3Raz7hRWfJ6ABViWlXb1cWH/FrUBTIjAAHv7vzCdPybgjmzCnJ4HbdWP0R2TSaUEOYwrPTSPPi+zQGQmdM0cHaIs1i8j8eNbKcLQLF+nUHzN8f9SKjnSjIAPSKfXzuu3J2XoIjrKktDwHruc+V9Hh62ahvmwdjMIN1AeoWGaE/RQdwjS6rJeIa3usBTMxTJN/XieZAWV5sHx9BPKFPJkXOgqyjSr/AOC7G82gtayNzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWNmTsLY5vQfv6E+IgOlY+ECzeopldYwfZ8lazNJcjg=;
 b=b6pd2ESKQGYfuaxFs3SsmPnSH5XDW3DduD9wliDTK3eYjaPz9pBlfgwR+3FQjYDMkcWmp85FhjSm9IQKt5ySz5vUxb8BRIELXyHzTQSmMgjzbn/qVdeB13h0WbHCkL0193hHVD/tWfLYxT5GH+MA8PdTKz6n5J5ODe9lYaGSXriBkZjan+UHvVdrsnZT6mfWqTZooCeu5YlP+bN42BWZzrfSzz+DvYXd1NUd6TLmz0FSmS7vntVbFpSfa66V4B72hIG5FGX+5dFI8OdQ1z/wa4SuL8/pHPhpjxwRHU/ImHHtMaUJIGG9dV9voiU6cHjkSm3NrfSAMjUuULk0NSPzow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB7625.namprd12.prod.outlook.com (2603:10b6:208:439::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 00:36:02 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%5]) with mapi id 15.20.6156.029; Wed, 8 Mar 2023
 00:36:02 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     kvm@vger.kernel.org, Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v2 16/17] iommufd/selftest: Return the real idev id from selftest mock_domain
Date:   Tue,  7 Mar 2023 20:35:55 -0400
Message-Id: <16-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0085.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: d6b1dc7d-62ab-43aa-db2a-08db1f6d16d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iBE4TF69IcH0leFODuUW10nVOtSkr2qJDNqvJ1NuoNl8SEjefL6ttVRns92B6h/2fTzuefteP2oFudYgxpfgfGGknPFEGfZH2i/4VqCqDQuq9yoRk71xGXZ2WASika0mqqJKiK1xm3HrQHiyA0DO7Hf+FHQtpWbUrlHcdmdtw0Cdv8VSPknuukh6VadCkYCl+bqL2O52hz9hqrWT8OvkVCuTA+u9ut/Jv5VpzFzH0CJbjZxGyKwGwpVhPoQUCo2w15PIhgMIm6T1YPkuVPetV4PGwu756l5mFHUh0y9T65bqDi+VnRozRT2UxIveNwfYDn63704t7e8sFj9yWUsTlUpsSOOkWXbkLn61Se+/Wz/eM7n01qT1I76H2yZSN44el6A8qsZ6cNTRd+DOwDdOzsPqUJqc/rELSKXmZM2EEbykiiOizcn22DzGuiJN3/LceQDnoFnZyjnCNZy+IersPQGSRCOCPcojz+iMbXQibh0JDsmDjSHoYhiEiK+kDrIVf9Z+7ahD0ofyFXiY9fAEL3wvMDAoJ/lYwJHkCpqi+VXyfboCFQy2+uV+gbd4seXUXOWgpHsYhzhF+e7/9rBqgo3gvaBKsPcfg2hWQGC24yGrbUXox32+sdQnPemZXNJ6B/bAgXNkwoRTVTXApt5/JQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(451199018)(36756003)(41300700001)(66556008)(4326008)(8936002)(8676002)(2906002)(5660300002)(66946007)(86362001)(66476007)(38100700002)(6666004)(478600001)(54906003)(6486002)(316002)(6512007)(83380400001)(6506007)(2616005)(186003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2qAtph4BuGJKIFsNpDOXH/YtM7tj+vWHIY+LQjgREAaQd/yEZf9gzFc+yo2G?=
 =?us-ascii?Q?rQA026JjYtqdHIV9pv9YzB49ZBwKx7G4rCcK3cPJT8R6l3tOMQIArQYVIXk8?=
 =?us-ascii?Q?ppZ36HT5pH7nvpncddjT9Z2G2OS/vg18TX+3k9n6bjmVyhcQRFadxUVM8hnn?=
 =?us-ascii?Q?bxMYzHmrYn7sJg7QZ8Itk8JSL1QlN5KI2GMZExzv+hoovhQb+s1tm9Mit3r5?=
 =?us-ascii?Q?malilJsamAO4qFBm1f60TqFMG0kPmLY1ICDUvNnIi/kkzQ4JLuJBM3wz9G12?=
 =?us-ascii?Q?tN1h0p/GOxm5aF9LUGwAOYN6Fa5be9karz0lQHOBJOKC3Bd0iCZUI/+5wpb8?=
 =?us-ascii?Q?66+pj8xfBBbFm8JHGUpN97Gv90i1GOVlEAYywV5XlMHKgaXdUhaBB7yUBQ87?=
 =?us-ascii?Q?Sm+FhHWiH3Pf/07GoSbAtVeQzgZdSiYptO0W5R0LZ2D2oAIidN0fvDhPtSIO?=
 =?us-ascii?Q?+zbiRGwaJpvIqw0UCIRG7MOwB65ZcRh5E9W0XIIYO52O122B6pWnRbNUducH?=
 =?us-ascii?Q?IjaFlyXAnb2l64liiD92c2zqeBc4hGZ2VLsjw/eJf1BN4T+neJCtRgo7djMz?=
 =?us-ascii?Q?nHk6w4k9PG80DnU/2A6sfZtp7IFB6qnAgio0htd/dLvtZVAbu9wN5fyvC1s+?=
 =?us-ascii?Q?4vaoL2GR27VqX9C4n9oGc0gYGbf75nZ5W2mtuKNjBsrhMeskWkAnQ0s1wVBa?=
 =?us-ascii?Q?lZ6oLCIlpcyow29fMCQAk1qodVulhwVMTPL7AYH1uC9PD0yr8k1cATHyBRCl?=
 =?us-ascii?Q?QvPWaiAXl81cSCUKWNFIRc8bYMvb9mJ1yjkQRFnhxJFyQZg7N2f8CCCCHu4N?=
 =?us-ascii?Q?26ddaDXj5zyXCf0cQ+kU9b9u4u3s6bLt0Io2JiGSyS3REwuSzDMED8RIex5+?=
 =?us-ascii?Q?L3Z4mdy9FIarohJqzKOW7ed07E7nIeqFX4KY9WZw3SzqFlkcM+Hr7zV0lDqw?=
 =?us-ascii?Q?MB3yGj2Mtejw8M5vgNj4aVO2hEXw1kGbJjW7JMpWNpQyQO6LsxvUCXl5bTAg?=
 =?us-ascii?Q?HLKfaGIPUDqzchKbgG3XQ9d6TZ7+WcoQblwdOH8mRVqHyy5P/508L5pTlPwj?=
 =?us-ascii?Q?0A3vaAek55ZeMT3c+VUPVOywdJ0Gb+4dxqztlJWrzuINIc1FdlD04qF9NC1I?=
 =?us-ascii?Q?jZBtU/6UVmLpuRkOyTfC2FXwI53zttvvTw9whooi5BWRoNsh6fsoSoD19N/o?=
 =?us-ascii?Q?LkOxO3AwGTfkKMnFU/4eo35AnQaVun5vJghfh2ihpCbl7AIR9m0qrU2SqsuC?=
 =?us-ascii?Q?NP6E0CcXq9umqiViAJVfW2ootuAWEYKoHRzp4PCMCBtNuX8gz4MmoA9Rz/hS?=
 =?us-ascii?Q?UrEhbWI51/HY0lL4E+Z001fZM/B1gduj4MV5LCmTgGTkrvf5NU9xAhhBER17?=
 =?us-ascii?Q?tr1zafTK/ZlXdzX8hULy9jEGvt58yRif4KlB/5zA6nYlUo+ldCAbaFRAq+OZ?=
 =?us-ascii?Q?B/YkC3yG7mV6omt6Wqy7n8T8IIL2SUha+IbO5mAjm1IfOukzYs8xolPcLziP?=
 =?us-ascii?Q?wsxd9/sIkOWfAyasqbGO/4xXz9MF6q3quBZBZVl4z1zQW2VkBPtHNvreuqJY?=
 =?us-ascii?Q?kPsLNs3KZHN8WsCQ9NHFLk23iynLFo1BXliSAF5E?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b1dc7d-62ab-43aa-db2a-08db1f6d16d1
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 00:36:00.0461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uYt/NuB3bWxOYmUduW7gtQn5CTnZp+hzaUZq9g3dtUe6zBKWhRN5yn7josOrLp4f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7625
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Now that we actually call iommufd_device_bind() we can return the
idev_id from that function to userspace for use in other APIs.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h           |  2 ++
 drivers/iommu/iommufd/selftest.c               |  1 +
 tools/testing/selftests/iommu/iommufd.c        | 17 +++++++++--------
 .../testing/selftests/iommu/iommufd_fail_nth.c | 18 ++++++++++--------
 tools/testing/selftests/iommu/iommufd_utils.h  | 12 +++++++-----
 5 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index e3f1035cbd6464..dd9168a20ddf4c 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -52,6 +52,8 @@ struct iommu_test_cmd {
 		struct {
 			__u32 out_stdev_id;
 			__u32 out_hwpt_id;
+			/* out_idev_id is the standard iommufd_bind object */
+			__u32 out_idev_id;
 		} mock_domain;
 		struct {
 			__u32 pt_id;
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 866d77247a07fc..3e2284811fb326 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -443,6 +443,7 @@ static int iommufd_test_mock_domain(struct iommufd_ucmd *ucmd,
 	/* Userspace must destroy the device_id to destroy the object */
 	cmd->mock_domain.out_hwpt_id = pt_id;
 	cmd->mock_domain.out_stdev_id = sobj->obj.id;
+	cmd->mock_domain.out_idev_id = idev_id;
 	iommufd_object_finalize(ucmd->ictx, &sobj->obj);
 	return iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 77b0601fd13a71..83c98a371f9e7a 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -214,7 +214,7 @@ FIXTURE_SETUP(iommufd_ioas)
 
 	for (i = 0; i != variant->mock_domains; i++) {
 		test_cmd_mock_domain(self->ioas_id, &self->stdev_id,
-				     &self->hwpt_id);
+				     &self->hwpt_id, NULL);
 		self->base_iova = MOCK_APERTURE_START;
 	}
 }
@@ -265,7 +265,7 @@ TEST_F(iommufd_ioas, hwpt_attach)
 {
 	/* Create a device attached directly to a hwpt */
 	if (self->stdev_id) {
-		test_cmd_mock_domain(self->hwpt_id, NULL, NULL);
+		test_cmd_mock_domain(self->hwpt_id, NULL, NULL, NULL);
 	} else {
 		test_err_mock_domain(ENOENT, self->hwpt_id, NULL, NULL);
 	}
@@ -650,7 +650,7 @@ TEST_F(iommufd_ioas, access_pin)
 				   _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_PAGES),
 				   &access_cmd));
 		test_cmd_mock_domain(self->ioas_id, &mock_stdev_id,
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
 	uint32_t stdev_ids[2];
+	uint32_t idev_ids[2];
 	int mmap_flags;
 	size_t mmap_buf_size;
 };
@@ -1024,7 +1025,7 @@ FIXTURE_SETUP(iommufd_mock_domain)
 
 	for (i = 0; i != variant->mock_domains; i++)
 		test_cmd_mock_domain(self->ioas_id, &self->stdev_ids[i],
-				     &self->hwpt_ids[i]);
+				     &self->hwpt_ids[i], &self->idev_ids[i]);
 	self->hwpt_id = self->hwpt_ids[0];
 
 	self->mmap_flags = MAP_SHARED | MAP_ANONYMOUS;
@@ -1218,7 +1219,7 @@ TEST_F(iommufd_mock_domain, all_aligns_copy)
 			/* Add and destroy a domain while the area exists */
 			old_id = self->hwpt_ids[1];
 			test_cmd_mock_domain(self->ioas_id, &mock_stdev_id,
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
index baaea15b355297..7a3d149019da92 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -313,7 +313,7 @@ TEST_FAIL_NTH(basic_fail_nth, map_domain)
 
 	fail_nth_enable();
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id, NULL))
 		return -1;
 
 	if (_test_ioctl_ioas_map(self->fd, ioas_id, buffer, 262144, &iova,
@@ -324,7 +324,7 @@ TEST_FAIL_NTH(basic_fail_nth, map_domain)
 	if (_test_ioctl_destroy(self->fd, stdev_id))
 		return -1;
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id, NULL))
 		return -1;
 	return 0;
 }
@@ -348,12 +348,13 @@ TEST_FAIL_NTH(basic_fail_nth, map_two_domains)
 	if (_test_ioctl_set_temp_memory_limit(self->fd, 32))
 		return -1;
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id, NULL))
 		return -1;
 
 	fail_nth_enable();
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id2, &hwpt_id2))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id2, &hwpt_id2,
+				  NULL))
 		return -1;
 
 	if (_test_ioctl_ioas_map(self->fd, ioas_id, buffer, 262144, &iova,
@@ -367,9 +368,10 @@ TEST_FAIL_NTH(basic_fail_nth, map_two_domains)
 	if (_test_ioctl_destroy(self->fd, stdev_id2))
 		return -1;
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id, NULL))
 		return -1;
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id2, &hwpt_id2))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id2, &hwpt_id2,
+				  NULL))
 		return -1;
 	return 0;
 }
@@ -526,7 +528,7 @@ TEST_FAIL_NTH(basic_fail_nth, access_pin_domain)
 	if (_test_ioctl_set_temp_memory_limit(self->fd, 32))
 		return -1;
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id, NULL))
 		return -1;
 
 	if (_test_ioctl_ioas_map(self->fd, ioas_id, buffer, BUFFER_SIZE, &iova,
@@ -588,7 +590,7 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 
 	fail_nth_enable();
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, NULL))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, NULL, NULL))
 		return -1;
 
 	if (_test_cmd_mock_domain_replace(self->fd, stdev_id, ioas_id2, NULL))
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 3222f246600422..e67a929a5c87d3 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -39,7 +39,7 @@ static unsigned long BUFFER_SIZE;
 	})
 
 static int _test_cmd_mock_domain(int fd, unsigned int ioas_id, __u32 *stdev_id,
-				 __u32 *hwpt_id)
+				 __u32 *hwpt_id, __u32 *idev_id)
 {
 	struct iommu_test_cmd cmd = {
 		.size = sizeof(cmd),
@@ -57,14 +57,16 @@ static int _test_cmd_mock_domain(int fd, unsigned int ioas_id, __u32 *stdev_id,
 	assert(cmd.id != 0);
 	if (hwpt_id)
 		*hwpt_id = cmd.mock_domain.out_hwpt_id;
+	if (idev_id)
+		*idev_id = cmd.mock_domain.out_idev_id;
 	return 0;
 }
-#define test_cmd_mock_domain(ioas_id, stdev_id, hwpt_id) \
-	ASSERT_EQ(0,                                     \
-		  _test_cmd_mock_domain(self->fd, ioas_id, stdev_id, hwpt_id))
+#define test_cmd_mock_domain(ioas_id, stdev_id, hwpt_id, idev_id)       \
+	ASSERT_EQ(0, _test_cmd_mock_domain(self->fd, ioas_id, stdev_id, \
+					   hwpt_id, idev_id))
 #define test_err_mock_domain(_errno, ioas_id, stdev_id, hwpt_id)      \
 	EXPECT_ERRNO(_errno, _test_cmd_mock_domain(self->fd, ioas_id, \
-						   stdev_id, hwpt_id))
+						   stdev_id, hwpt_id, NULL))
 
 static int _test_cmd_mock_domain_replace(int fd, __u32 stdev_id, __u32 pt_id,
 					 __u32 *hwpt_id)
-- 
2.39.2

