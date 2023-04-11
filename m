Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A17A6DE13F
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 18:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjDKQnn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 12:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjDKQnm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 12:43:42 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF785247;
        Tue, 11 Apr 2023 09:43:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FD4yBoBfg1UxH9C5Ru7mzh3wOdEmg9YT5+h2OHyqrn/5KANKCs9gZWeBgI1ZhHmXWjZwqK7vQvrTAG7vYdkmpcFY0CQ4Vn1urpN9pnY855zXt6CDITl5tA3Z7RCBVgqJ/tIss4JIUOdczYjaCGDy6wiByy36lA/nM5t9ebEMrC4D/UWp5vr9RlBshuGP14BmWc7UiZJRJ5WkwcW94k9eFNTfrLrS0uWfYl58sEj5QkzvCICO3w34irHg0xOpR2YkINfaIRMfSt2wjYGIo9khO7GZOUAirHSf1pYVtB/S+XDiIjpEXEu3pt3PueaY3Ha7wyWC1C+N1VAVGRkeombo0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+913O9G4ulLwvk+m50ADYtqHPLOTp0dqAaNi68zgDug=;
 b=Evm1e/9LCUiJbxwctEghq/GzJ1Kv8DgQbOXN3c6RMI/ThOXhP1VAdpOZbRJr6wB0sapE7ByAMzMDvCJpOpg4fmKSjq599tLCpvXHdQzU7wh14NMbWvQ7lPkU+G9iqyCIVuTvLZQYKlTaKbVUQYvdmtJ3WYJvI4Z82E9jcoC+2rOLoUUi7ZGKEenFBgRJXCxP/GpRzfl6Y2QtuWE6W3xEWvL50mEz9U3HiQRBRfQ1lrqDq61YNJ9oMF+abNA+U89BIct+WR8fs4aO5+G6IBdoUfMiQ+OQ9jTeG3WD2jnQsIfxAm3raJiqPxbye1U6qf/fuqnjbBgK8g5HUHPb6ErY7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+913O9G4ulLwvk+m50ADYtqHPLOTp0dqAaNi68zgDug=;
 b=Q/qORTMiE3DvA8+c5EMj51H3D3MNKcrpPT2zqo+nDIcifDjYtOh4AMG+kKNPA6If9qdoyQuvVv4FKSaFLH01bctQoivqbx6Ujxe0bkcsi+tBLW9EAYxGtq+HAulcT4rgC3CJl0y4uu68oiUy5swWA6c1I4FktnzXVfQCuoDn3C3S8gtOnMTL/xB8dYnajulWaVx21GYCsHpqEMEijSWAllkuD0iajTPGfkiucIgaoYradEyI986O65hFK3p/wPJUN/B6uSqXt/5WTeQWp4oUzCuBtu9UMc3CcVQw6kxVFgfdWF6pdK3A4rfm6SzMg3yEi5D5Lf+2q1mm9IUKthIknQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL3PR12MB6596.namprd12.prod.outlook.com (2603:10b6:208:38f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Tue, 11 Apr
 2023 16:43:23 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 16:43:23 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v5 16/17] iommufd/selftest: Return the real idev id from selftest mock_domain
Date:   Tue, 11 Apr 2023 13:43:17 -0300
Message-Id: <16-v5-6716da355392+c5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v5-6716da355392+c5-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0053.namprd07.prod.outlook.com
 (2603:10b6:a03:60::30) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL3PR12MB6596:EE_
X-MS-Office365-Filtering-Correlation-Id: 38b213af-e413-4245-59fa-08db3aabdc86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z5EeHtH+GLIOfqRcehAOX7ZfseO56vtXQUYk3d/aPl1JZaI/pVX5KgPjrqkka20lGL1o370gapv5LnsFOfYteGghDrGskGyMvTy5bjsNKt+pNQ1/jwGZ2aFEla1TLuC9sImh+EqlNO7OLdcIAl8Rep/LgmqC/OJF//2+0IyTJqr1GaAgRJrkg/gA2KPuOjC+DSAK3+dVgt2yGbm+B4P/CRjRgjOU623Npcjb3P3kfQDpbGSU3oNiSmL6lwb3G3vmRDu9Zdz69xwt65hSh0uB8HELVjPOM9Z2eS9aKX1/TthvbJ+DKBnAzmSwooX6oYkqRp4/jdTmWYlEejTK2zLndWZkDw69VBPtKZRAtqx6SVoM2ohyjZRSqnnbkHxsCK0Bo7guC1WAh25ChmXAgeNqN+ayAN56OyK7euzcQkvZqy3dnR51SlVR5K8w3p4UegZXi+ASvVydq85nEkfx2Jfw+wpHSjRFOXQsNEhRP2l5RT/5P55oYuEO+PThTufwDZUl4LOm0+exmoBxI4XwxeR9YOQj5FlewEQycLqY208iW4P5sqVB5H4WkWM/Ir+mGQY8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199021)(2906002)(86362001)(36756003)(6486002)(6666004)(2616005)(83380400001)(186003)(6506007)(26005)(6512007)(478600001)(66556008)(66476007)(66946007)(4326008)(316002)(8936002)(41300700001)(38100700002)(8676002)(5660300002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UuiF9mgArs/O9+pzHWbMS4J6CqJ9xO41Cph+pVbET0xTwAUDf+Vsx/BRZ11A?=
 =?us-ascii?Q?/pj9v+CVcOtLiAv5dRST26731bNLuktL2aqSqDTTASNVCJOZUcKpLKZ8uSF0?=
 =?us-ascii?Q?338Coxq/4z1dnI1jZ4qXnXAJanK9acR++iMOO46jG+MrctzcVZBVUP2g7aJp?=
 =?us-ascii?Q?fKIj3dW9mYKz+gt/ifzKY4x5d7nV1Z8crtazPMs1MhkLt/Sh9MSTcSg2aDzi?=
 =?us-ascii?Q?GHtIKo5/zq/qUIrh5cMACflCA2EKdpBxy4gBZhEtHDWaHXrYpowVVjjvteQe?=
 =?us-ascii?Q?6OK6VlykNP885AB6nctr+wuxTf3aHiznsoDw8Y+ZPBqnFaocGIu8f2AIKgxV?=
 =?us-ascii?Q?FRD99wLAUlffzpUPfZTshHcYbIPwdNIvLXPz4BH/dIlNDAIY7s49wGhyygQH?=
 =?us-ascii?Q?J3yeNN5WB9gD1YupqRJe3FJuqc2US4PTUU/Ai0Zz8B9RMlpuYsKj3gjhuuqG?=
 =?us-ascii?Q?NkIk88IHlQFSakZNHqslfy2a9urTusEtuZ/R9fg0DtKflnuz7wnVYUMiRblt?=
 =?us-ascii?Q?GKVvdKUSzSWcDhlqZ4AFnaHXXS6fTa/2wAz3KvmJzpYkBIMcGYqPFKQd0BMe?=
 =?us-ascii?Q?MhNnAWs7rXfyeyvRJo/PfW+m3or71embdEwA1qfTjfGTTHot758fgxgyisLs?=
 =?us-ascii?Q?uO2ATvdBsQ0Tr11qoFOpV2TAE+et4gsv51LXS63wDPo+IqzxLyfiywahPJpL?=
 =?us-ascii?Q?WgvK+iPuctfxPE3NPMw6fblCbXo/R4YsB96ulGM+w46yLZ2ZtugM3N3fVs28?=
 =?us-ascii?Q?7stgL/NiIffOl3z98jD1F7MOM+CzICMk7CuerVWswFOy6wyHTTzMVScnAquH?=
 =?us-ascii?Q?YTAsy3CD2QXfVqIhZqyhstgTpR6q1dd6K62IjRe47qw00ZYT0Bu8JMTITtIC?=
 =?us-ascii?Q?Fs3gnG3MN3P5ZYT76kT8+/IM9MOfsmBI/U8/LH/1XxuSFEue//NCkxjxfgJD?=
 =?us-ascii?Q?s2jnpXu3qbUFFJ8pKY3tAq6sAG+N5pRoMs7EXYjjzX6iPabmmpUOg1YL+29e?=
 =?us-ascii?Q?qjxdEPLw7hJGp1WlQUycmAWupLjzthKeMADyiBEzabPrfkDpEJ1nOqtC6TD3?=
 =?us-ascii?Q?bgS4OgsjwiI9ezIn45jbaP2uRxAUSdRWLI1HVRszQY8dLIS5PYEQOF1Jpi5S?=
 =?us-ascii?Q?Vo0o5lEcuXK4j4CH1j1A/HP62VW5kgKYtAuM7/Y0KR/01t78nv0lp0ma6XH+?=
 =?us-ascii?Q?ZFcBC7P6Xs7amcFj/vQI5uxy8yB70a9Jzrrzs7k11G76je8weQrUd5/dgY+B?=
 =?us-ascii?Q?wgs5DdVfMuLzzEiIBTysDijbvMJwVW/GuejeOgnz4L27YZg1F85W6bnb4yXw?=
 =?us-ascii?Q?8LXITqP2jK7xYJOVar35e/lor5gJgbz/rec/3lOs223vHyeZgwFddSWmd6io?=
 =?us-ascii?Q?NEg6E1AszolfkauEHX8pXXIwMmb5Qp0SdO0Qo4KKWdnoTQdkeJIzmSIXUhVc?=
 =?us-ascii?Q?9q1maP6ZLMAlWzxrFpyQAuzLNB5z25zlaPUB04H8JGYO8GkNqz7kmam0KSms?=
 =?us-ascii?Q?HnKkNcBYOvDk9BAwWw6V219QS7KokrYSftqkvXUI8wce9RZmTsdk1FkRjxKS?=
 =?us-ascii?Q?FUKxDz/0oDBRj7WU5nlcY8iKjkWt+Fci42t5TJ94?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38b213af-e413-4245-59fa-08db3aabdc86
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 16:43:22.1169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C8150NmdeVAZ6bOKJGi9yMfxbxF+XgxWtFwtPsfcMFZ2sw1wR71g+/hXnp6Yep/3
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

Now that we actually call iommufd_device_bind() we can return the
idev_id from that function to userspace for use in other APIs.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
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
index dd792294298ffd..a9c22560f51aa9 100644
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
index 57559f60ca6486..a6bc090d4b38a9 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -211,7 +211,7 @@ FIXTURE_SETUP(iommufd_ioas)
 
 	for (i = 0; i != variant->mock_domains; i++) {
 		test_cmd_mock_domain(self->ioas_id, &self->stdev_id,
-				     &self->hwpt_id);
+				     &self->hwpt_id, NULL);
 		self->base_iova = MOCK_APERTURE_START;
 	}
 }
@@ -262,7 +262,7 @@ TEST_F(iommufd_ioas, hwpt_attach)
 {
 	/* Create a device attached directly to a hwpt */
 	if (self->stdev_id) {
-		test_cmd_mock_domain(self->hwpt_id, NULL, NULL);
+		test_cmd_mock_domain(self->hwpt_id, NULL, NULL, NULL);
 	} else {
 		test_err_mock_domain(ENOENT, self->hwpt_id, NULL, NULL);
 	}
@@ -647,7 +647,7 @@ TEST_F(iommufd_ioas, access_pin)
 				   _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_PAGES),
 				   &access_cmd));
 		test_cmd_mock_domain(self->ioas_id, &mock_stdev_id,
-				     &mock_hwpt_id);
+				     &mock_hwpt_id, NULL);
 		check_map_cmd.id = mock_hwpt_id;
 		ASSERT_EQ(0, ioctl(self->fd,
 				   _IOMMU_TEST_CMD(IOMMU_TEST_OP_MD_CHECK_MAP),
@@ -802,7 +802,7 @@ TEST_F(iommufd_ioas, fork_gone)
 		 * If a domain already existed then everything was pinned within
 		 * the fork, so this copies from one domain to another.
 		 */
-		test_cmd_mock_domain(self->ioas_id, NULL, NULL);
+		test_cmd_mock_domain(self->ioas_id, NULL, NULL, NULL);
 		check_access_rw(_metadata, self->fd, access_id,
 				MOCK_APERTURE_START, 0);
 
@@ -851,7 +851,7 @@ TEST_F(iommufd_ioas, fork_present)
 	ASSERT_EQ(8, read(efd, &tmp, sizeof(tmp)));
 
 	/* Read pages from the remote process */
-	test_cmd_mock_domain(self->ioas_id, NULL, NULL);
+	test_cmd_mock_domain(self->ioas_id, NULL, NULL, NULL);
 	check_access_rw(_metadata, self->fd, access_id, MOCK_APERTURE_START, 0);
 
 	ASSERT_EQ(0, close(pipefds[1]));
@@ -999,6 +999,7 @@ FIXTURE(iommufd_mock_domain)
 	uint32_t hwpt_id;
 	uint32_t hwpt_ids[2];
 	uint32_t stdev_ids[2];
+	uint32_t idev_ids[2];
 	int mmap_flags;
 	size_t mmap_buf_size;
 };
@@ -1021,7 +1022,7 @@ FIXTURE_SETUP(iommufd_mock_domain)
 
 	for (i = 0; i != variant->mock_domains; i++)
 		test_cmd_mock_domain(self->ioas_id, &self->stdev_ids[i],
-				     &self->hwpt_ids[i]);
+				     &self->hwpt_ids[i], &self->idev_ids[i]);
 	self->hwpt_id = self->hwpt_ids[0];
 
 	self->mmap_flags = MAP_SHARED | MAP_ANONYMOUS;
@@ -1215,7 +1216,7 @@ TEST_F(iommufd_mock_domain, all_aligns_copy)
 			/* Add and destroy a domain while the area exists */
 			old_id = self->hwpt_ids[1];
 			test_cmd_mock_domain(self->ioas_id, &mock_stdev_id,
-					     &self->hwpt_ids[1]);
+					     &self->hwpt_ids[1], NULL);
 
 			check_mock_iova(buf + start, iova, length);
 			check_refs(buf + start / PAGE_SIZE * PAGE_SIZE,
@@ -1424,7 +1425,7 @@ FIXTURE_SETUP(vfio_compat_mock_domain)
 
 	/* Create what VFIO would consider a group */
 	test_ioctl_ioas_alloc(&self->ioas_id);
-	test_cmd_mock_domain(self->ioas_id, NULL, NULL);
+	test_cmd_mock_domain(self->ioas_id, NULL, NULL, NULL);
 
 	/* Attach it to the vfio compat */
 	vfio_ioas_cmd.ioas_id = self->ioas_id;
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index 96fb2f04623f23..8ab20df4edc8c7 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -315,7 +315,7 @@ TEST_FAIL_NTH(basic_fail_nth, map_domain)
 
 	fail_nth_enable();
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id, NULL))
 		return -1;
 
 	if (_test_ioctl_ioas_map(self->fd, ioas_id, buffer, 262144, &iova,
@@ -326,7 +326,7 @@ TEST_FAIL_NTH(basic_fail_nth, map_domain)
 	if (_test_ioctl_destroy(self->fd, stdev_id))
 		return -1;
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id, NULL))
 		return -1;
 	return 0;
 }
@@ -350,12 +350,13 @@ TEST_FAIL_NTH(basic_fail_nth, map_two_domains)
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
@@ -369,9 +370,10 @@ TEST_FAIL_NTH(basic_fail_nth, map_two_domains)
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
@@ -528,7 +530,7 @@ TEST_FAIL_NTH(basic_fail_nth, access_pin_domain)
 	if (_test_ioctl_set_temp_memory_limit(self->fd, 32))
 		return -1;
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id, NULL))
 		return -1;
 
 	if (_test_ioctl_ioas_map(self->fd, ioas_id, buffer, BUFFER_SIZE, &iova,
@@ -603,7 +605,7 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 
 	fail_nth_enable();
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, NULL))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, NULL, NULL))
 		return -1;
 
 	if (_test_cmd_mock_domain_replace(self->fd, stdev_id, ioas_id2, NULL))
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 8b11bb70095269..62e01412a7679e 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -41,7 +41,7 @@ static unsigned long PAGE_SIZE;
 	})
 
 static int _test_cmd_mock_domain(int fd, unsigned int ioas_id, __u32 *stdev_id,
-				 __u32 *hwpt_id)
+				 __u32 *hwpt_id, __u32 *idev_id)
 {
 	struct iommu_test_cmd cmd = {
 		.size = sizeof(cmd),
@@ -59,14 +59,16 @@ static int _test_cmd_mock_domain(int fd, unsigned int ioas_id, __u32 *stdev_id,
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
2.40.0

