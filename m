Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59456CAD41
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Mar 2023 20:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbjC0Sjc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 14:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbjC0Sj3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 14:39:29 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7188E46A8;
        Mon, 27 Mar 2023 11:39:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UX64sHWmHEf98yTpBqsXsjc2pDlmBebjQ4tSleLd8gGG5oQM7K3NTrk2u/JcPL+qCYc0RbB4ONPHL2oCZwAFBLuL3Y+3P2/SXW/WKvVrTpEumbY/kzNPBfOwommvqRj6i6dj4+dwJFnkd0ojfNiPlrSQfDwKXwRDsPeDa6GprQ1hV58P5W6dYRxyuJQwBaFqAeOhbidNdmAFRKZ94lribVEgRltOcY1cP6tP0Jo+siHU5bkNGOdg4AktyYDydqu/DnTLJD+kXRdImX6xsIwfqczLJaEGGhOQ9GZO4Qu3qnWuXSns12UIw0RiMVcYRAjpIgIRZ/8DwRxzF3Kn1OL7JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOQxQdd+wigXZPIqPyxdLQUDfhoEImkXV1bAoVhAh48=;
 b=bNsgI87cXGH8Y9dAKx0WjBcMmHb0LfHBJSGamgF28y14MyG7SOjfJvrgNL0tPaZPki4EVy5gy2bxSAkCeUD9sJXOT7suZNF1h76uhJrmXHno16n/xe2IfogzpVvOiB8irfKUeATKuV7EGk0jF6YfgdfgUfc2UfeGr6qaCAe/nYWHoUfgJLNKw/Yi9oMj+eki77LxmRfTS+SlqeI9W/zQK8teXMVyv6SlWU//Qn8z4MZveJtfIDdgVICDYWdiTYd44VA2hl/02MgYxadJkB1I6hCT4sJlRH1fHjFYzzMKowbuOQetkH1c1lb1A04mtb6YWJhnaFlWfn/K/dUZK4Z+2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOQxQdd+wigXZPIqPyxdLQUDfhoEImkXV1bAoVhAh48=;
 b=DR8l8FzIeQicDI33p1ucVU+NHdlreGlyH4Sqowjyb3wMR0QSAATBisNqDx4ladnkukzhF4GnZPTCkot3GP0DKsSK0WCD5ldVmjSd2byu+MLPwemrYDvrwAGilPU80f2oD1cRSa0oi9MvW/0QPMINhkoo5T0A6q9ijdjvST87uPtvsLBhhfblj5KDhBEpmbQKFItV5xE+lb6aNtjUscS0P8IuRDAUOJqO3nDh4MfLpJFxVqQCnIaJnA9CFNQBsLFYYZamZ6U+y7XJYa4831JBG/gxx5IMn8lBLRMfRBOoluakah6uf1TlWPP26khAQA3i1XOW7s41pXruHBt06HCtqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 18:38:19 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Mon, 27 Mar 2023
 18:38:19 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v4 16/17] iommufd/selftest: Return the real idev id from selftest mock_domain
Date:   Mon, 27 Mar 2023 15:38:10 -0300
Message-Id: <16-v4-9cd79ad52ee8+13f5-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v4-9cd79ad52ee8+13f5-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0180.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: b00027a1-d862-4e0e-9116-08db2ef26bee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hQwedcHDzQkVoPSyJp5IzR46JGeVFuaLr8+Fki39L0oSa2mSu3636GxKY08RprmnGqivj3lWkjkDMB4zsEpoPQxwkJmLBBKRFvqqkm0eZgxvcD98mwewXpoH5WBN1rnpCZQjbNThNm7VybMoWiuQMet6Z/kgphKvhrK3iC9yrlwZgfO2HusaEj+awADcY2Iv3uPPvCweNMXnKDGzqDgrrYXAFaL743HK70hc8RoPqJBDqWH/KabGn69KJiewn7J1gNDNmukW6BRTiP9cxYR9hInTNdk4QQd0KduWXpBTiESdrBs2czqyygM9UJAdoEmYVrFH9e6jz3aNim6Uslp6jRrEce4ooNyup/X2FnBfbbHnj/EQpW2AoDY/UepHmvIJSbqrGlbOOFs2afGkHo9QQP2GyqlYmYksISyCIeQbhYmqI7vDSEP6o8eCf+vepAN3U9jGvlkDlVx1QlYE89qamLOLWehyppHljP6ZBDEJbmGUbtOYOTpIZafjKdDLio9dnaplLyuyoywW7dl+H9Je5M8gEZinUfaUtDF213gum+HfmUVvtnaSBZfCMfE90rT9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199021)(6512007)(6506007)(26005)(54906003)(6486002)(316002)(6666004)(4326008)(186003)(66476007)(66556008)(66946007)(8676002)(478600001)(41300700001)(86362001)(5660300002)(38100700002)(2906002)(83380400001)(36756003)(2616005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m35F7WIuQjgQq3TIv+a86Axr3oWJNWb8tGO2qMA1YBMeool1BZLbiCQ2lMur?=
 =?us-ascii?Q?WaRACguZVQNnRuos5zACj/bjJHZt8c0PYha+Uysaz8O27Evt1OdfY+iHrKGz?=
 =?us-ascii?Q?B9qkn5R+C6moEjSyoaWOSRVyULnXo0maUEXaHv8pqPuKLrxSALdkUKrUNegu?=
 =?us-ascii?Q?qpJConF0bznCWly5LJPTUGhNLMrWlHK6jMzYLApDy/B/5Kb9h51qS7AqIIxb?=
 =?us-ascii?Q?aJHYQ/5Ii9Nxgej9p8qaMtg99iRZ6+aQ1YCAlbXbapj/bPKRtNFkZeHfaLr1?=
 =?us-ascii?Q?+m+WNVUUgsL/aaQqGWDgxS69l4BO6vRkuukZ1qND8Bf318BIUydEu9Z+6sKv?=
 =?us-ascii?Q?/8TilTNPDe96rDdvCJ8b9JWW6IIW+5UGtyy+A4JrL5UFTqRS/uvhtuZ3Rm3I?=
 =?us-ascii?Q?qZ+69A8u1jPEaR8ZBx2AIdhD0sA8A9fC9u9mGY27KTnKm2D2dvFCqBhQkudY?=
 =?us-ascii?Q?ih3SI1gq9vrMw2+6hHq/717ZC9T8THTEv9aHax4FrfgfZgJQZZKNwAxhvmZz?=
 =?us-ascii?Q?c+UFUd+vIO7hJ1ZJ4uiONOf2Ohmtn5WwL6v7gcLj9Y4X89fZylpMQlGDiRmg?=
 =?us-ascii?Q?9vtMdw3ZKAZaoIScO4CyyuhNYqk9CmuPsv1F2w9dROVRn2FrSjOtCpXzFK3Y?=
 =?us-ascii?Q?J4b3TmnaLlUeKd+lxA5/oj1rCmY4emov7IPSiuK5nlCUHtYbX38d1VvzOe1y?=
 =?us-ascii?Q?YQyYCBq9eyaAQwPFDkJWjBYswLbmZgokpyrBkMMWyEUr3OdVhmE0OsQjBCLy?=
 =?us-ascii?Q?ZWf6Evj6b/65uK4/8e4E4t2ooxEnfNEho9OO5YWlIFe51BPfhDN2we106P8Q?=
 =?us-ascii?Q?eeRRu/WcKVBGVq9w/AHchMc7l4gkgQQzWhLEqKGWnJmesfkaCW1wILSAOHiS?=
 =?us-ascii?Q?UlKbP21Z+bBWXXWm+aUndlKFnhkXCbkyPY07p/lGp7uaL/Dp9vsTCglGhW4L?=
 =?us-ascii?Q?2a8SiLzaDAmUPC1TBT4GdOs4bfV+kKQuD+HiZHMlac6A0f+XxjD6BsJX49C4?=
 =?us-ascii?Q?3ktIdfRyr5+Wecwiq93pNmR/eOXUl9r1RTrBiHI5swVbloZ15ANEvX4mdvMI?=
 =?us-ascii?Q?8Bb9LJFhUx+/flUwLOd1ga7fT3e/tt4qUxH4OHRjtDdJDjPKr5rzDHjKxZKL?=
 =?us-ascii?Q?dV8lNlYOllaAliKG69Y98rcg8uXk7OiZVkH2pUJIqrfbCfPQbI7oyh8G9bHY?=
 =?us-ascii?Q?nfs3wcFt4pDQ2CKy0c7Yp8CYDYKfVxRhrSo+GYywJiJHthS2Nj10vIDkKC6F?=
 =?us-ascii?Q?KwPAgSwaKgVnP7W6ZoqhOM99GB+0wAlTOUwEkcvF+2ESE/41ac5rEUXYkbSj?=
 =?us-ascii?Q?FQZ8KG9EKDcMorh3mTw7cCgIiQ6S+xIG7PW2cp4xMNDCNm/3g8N4sUseRCzB?=
 =?us-ascii?Q?mMvsqgk0/f8QgPIvtW7b2jGz/uEYJglWLwPOBxOJCAqwnUbMmpRhsklh5iX7?=
 =?us-ascii?Q?Rjrp4LqBV6GQPi11KtjfdGp9bAbNzFoN0UB4mbTJL/RgdxbDX+i2/59YAI00?=
 =?us-ascii?Q?7kjIcX5kVCHPjBiz853skyCRpewRiKjajl+jn2VSSpwOovASM4nhZBALyEQz?=
 =?us-ascii?Q?3OFgwuh18XFSNs5rOx3Z7llGfib2K8C27T4zn/6b?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b00027a1-d862-4e0e-9116-08db2ef26bee
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 18:38:13.5214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cErLpWSOKyjwBmAi3+4Pbx2cg6Z+JWpmpCSOJAF/62AFGJ7sd7jiTuHeWXs9tyGb
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
2.40.0

