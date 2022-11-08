Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E27620514
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 01:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbiKHAtc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 19:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233172AbiKHAtZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 19:49:25 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3ED22611F;
        Mon,  7 Nov 2022 16:49:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOJxZS277RIwnJUwcc9TDlOEp/cGMFoAZ9hRD7gZk1XgM1rGsZuYWA7UAW/q8JWSZxwuWhlvIeoMM/GecJ0KGZ/GF4fnOvIVEMCig3JrEygJms/qZdwSH746VEQK9jrPpO/si5qXWH67CeZ3l70E3kBSuYIg5ucg2utDqTT8MdvvXs48dW0bUxZZ1waTd9lhIw2IH6YxyBWIfoj7Oe34aHrpRf+lEa2ALVIaWl2BABrJYAhe8jRwggqxSBAtX8J4ZpnCtZDqXT2wrruP+34MQeMBA+TDqmDnJwxbmN0kqYQFuMrBfX+AFvDqiGqGEoLS0m41kcH13mFHktn3KnwOuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nax86Cr+PJ7Ntx3eScgfRADx1OUFvmfxkm3/LIsAUwo=;
 b=FByQnggSox5KYE9XQHMIqpoWXU00rcQsozCw7xLS6AF6o3GvPPEEuJVDw0TorO+aaOZluG4/An8Sf5WSpkg6XBS/0cWC0nMYgNlgu4b1DdIKQRyU9J+lw80wZ9GRtKg/twiHhMBJGYil1/XoqWhlFZSyZgenQtUsUl4072VXz58JmvCAgFu7I7uPNcdqk2Dkvb2RHNqj7SUB0Xfl33tdb3lpyxPf7LfogHPEaOYEHlAcEnyfN4ng1OVM+ELlGZTJitMF9mhcEsnKu9kq3CasM1IHog8QG+d4/n+TFYu3Y9YzU7oy6l0zBJbhpvN80BCn4nA8FIIurWHzZmWhnf0pww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nax86Cr+PJ7Ntx3eScgfRADx1OUFvmfxkm3/LIsAUwo=;
 b=uNX242jJHoIdZLgbgWbUUng1ogFlEoDBajOLP4bEXR38R/ZPPFZ0+kC0PVBZjUkefle9dy0CbOizVbitqOpdUKdxUj1YV+FZEdGhLhwql7hIwMA0VVEOk4I60mlit47IRva7i31CzQQ2d4zVuIcr+MmmOTZ9Cbo9OiX5kiQjs1xmeHM7HUr1kGLDsH0X0EC+ZtcJfpdWOjZj7Wo9s/XiA9JXR/l6MHTm/BEsz2Y3HN6dSI1/VqVFkZlZJAYm15OdpyJXMeWtje3ShWqSg0ci/NGO7cL4+lFqiZtfQldetAhU6L+K8f7UWI9UzR+vOmSmaFkWsb+Pt2MRAakkL5+6+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB7222.namprd12.prod.outlook.com (2603:10b6:806:2bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 00:49:17 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 00:49:17 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     bpf@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: [PATCH v4 17/17] iommufd: Add additional invariant assertions
Date:   Mon,  7 Nov 2022 20:49:10 -0400
Message-Id: <17-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
In-Reply-To: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0029.prod.exchangelabs.com
 (2603:10b6:207:18::42) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: 72b012df-6646-47a2-a1f9-08dac1230d66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uCYzba1l6/rQjDiv7S/sgasAHduWOjZXQR/jA3LqTbZdJxpqXBGJoxoxYkjKfvMTK8HMuyvirm7UUajOSqs7HgNsQ3MNSiILphvYbNofO/K5WrrigqsAERAMHVHYhG9myPsWlotdlCSZMj5YptY/8INpT/WDCWeLQbYdyygLlygCYtBBH807KILbMha0GNrNTwe+t5iscpEXw/0zrjUJv6WWX6pql6m865AY1UqKuMj97D+WD+PmPtzJGfs4nuFeCPoCBJywiyj33V0p1dPDvFmeGC4Ux4onqhUVeEV6K9jTJgT+5Rg9lrWo7s+Eps8oEF3E/qcwrZ6wngLfbmeSMfAy9jmsc6VVJSkrMYkVooJh151yYIdYRnxMG+AkxhvNAsduMdXhcNBcWl1+d9iavyWGrigpkRwVODJxavKQjSFAFDabbphnUwzfOXQJGxbpayDgZ1n6Hj9nNVbSbWi3PzM26n/nxtku9eVE8DvKQ6LRwoHyB7+ZVuaKol3uoDps6j/ehZ3VfCnt5lfkiP4aHllljSGRbwMlDfYAIIrontmP0J9z5ZiiGDWLbbpFPc4kKT88dwrxntNcOqmgby4QNFNm8YsBIDD+PxWMLi8t1sbfGXEVzxT9t+o5Bn447EA9uV13yxYC4guKQLx1+q7+9tjl0ph48cE+xVoq8JTI/C/gQStcVObj36Jn8titjScf39yJmhKJi7tWq+gF2IqlNGYqWQD8InAacjxcD2Nb5hYQy9k7SVU8vESrNCYmN4rq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(396003)(39860400002)(136003)(346002)(451199015)(8676002)(54906003)(110136005)(66476007)(8936002)(7416002)(5660300002)(7406005)(2906002)(38100700002)(316002)(66946007)(41300700001)(66556008)(4326008)(186003)(2616005)(83380400001)(6486002)(478600001)(6512007)(26005)(6666004)(6506007)(86362001)(921005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oSOvrfGslJvXoxYDh4mFhObOLtaIQjYZcP8JFotGa6gFo+SiIAH01MAN1HpD?=
 =?us-ascii?Q?hPWpLbvWAjQ2BZm/AxjiwSl0JSybvigVBHUgOPtM9Rr0cIp8+6MUp2NvmqpI?=
 =?us-ascii?Q?C2RfvNijiBCy5bFwLpFmDPQAK0u57zZYrAY+iDTMO3YLq1CoF/gk3OPseq/y?=
 =?us-ascii?Q?fM5ZuccQRxbf+X24TdAoJXao1XXIdvx2oDdJ5nrYVbNqbpLdHrdtwWQzC3wI?=
 =?us-ascii?Q?4ON6ru2TnED9oN5JnVOReCPer2lrihSq2s+YbR/l5jumyAMGRd+Ki1HTidTC?=
 =?us-ascii?Q?ELFMF0QY68AMg7hOzhCiTKS5NEvc7Z5YqpZFHYK/oIXIy+DDlU84sqhNW41O?=
 =?us-ascii?Q?E7PXZyaCPf6xVmV9ysbARafvKfjr35K2Z272CDBN2BabuX29GnovEwl3wkFm?=
 =?us-ascii?Q?RkDjpyMFBt9h3sH3Z7GPuerpzZZ7h0j7OkfxkWqjKbETURSbbNLT6c40cdqn?=
 =?us-ascii?Q?EaWsvGLu57dbvEEvujFp3Emweb0vE9DxJHHGxXIOC+yuoBDL5OowsVze7FHQ?=
 =?us-ascii?Q?f7g9ud/W8RiMZSFHGt1q/iAg8RXRwBWT2zqwCI/Nm7dHZIPZ9OyaOt9w3LFB?=
 =?us-ascii?Q?IdnvRiUkEFtSmgSESa/5OtJ2zPpNLVHrH4aQDmeMmCw/I6X3whe93IFvU1oe?=
 =?us-ascii?Q?4vZIReKmRI9pT/zt+I9byMwTCGh0Esv8Zlbzlp8spggedjh0gOdWsaROZyux?=
 =?us-ascii?Q?KVSPtaZeZE6pC2isUckCBjheGKnGx6TFsjoFZW+lU3Hmkqm0Oz5GEuv/XDhJ?=
 =?us-ascii?Q?KmsJaWMaViju2WSWCT9gRXNkaVL2wbbHmWlu4gahJjVIE/efxh5q2Y8XZDVT?=
 =?us-ascii?Q?r71pfVx6AiwdWdW5uiiIosrtTaWUVSGBEh/Zzasc+69iAPvNnVDy4l6Vqewf?=
 =?us-ascii?Q?06O5MdoR8e2wjdzN7nf6P7G0ZGbXWhC3IlJDP5bobFUhNxgYdo8v4Kr43ZB+?=
 =?us-ascii?Q?hXe/cql8ImjpsxtFUqTVG8KQVAiX9S+gg1kLB6gCVt95QIqlCfgglFH0upfQ?=
 =?us-ascii?Q?Qhdf0/hTBnCGDhbXP8j7BTGyCGw4+GqlvBFJrlwpFQznrhPbK16zGKwSxYEa?=
 =?us-ascii?Q?+oa4VPkPQB3aDRkOUfVhZ81x5joO2D0/Pdjwcd2RgqSu6iBUEfRlb4R44XhQ?=
 =?us-ascii?Q?3RBAfmL3ndnEELcKIYORnomFbgB8LuaumLdBWawC9fukk/E72svEG+KpuDsB?=
 =?us-ascii?Q?h2gq38R8bGBuZ5JgIyVKBuJ0RzNkjYovjndI1Cbx3TTItUsrIkcni+O9ZvpW?=
 =?us-ascii?Q?FFzEtuMZ/otLJ7NcX8ImChHOLV1dHl6cU11eBdqoRmaqUDVxQsy8W4P7Rrtz?=
 =?us-ascii?Q?CMA9wishLrMp7HjTHwxUtCnPHnA1TYV2dfzspd7H8hodHE4//wFaboF8a0uz?=
 =?us-ascii?Q?n+ITm1Y2YfXiUWzE2KhGMJ+ASzjc7Q6sXY5YPqCb3xxj5JSART2wIf7WLLWn?=
 =?us-ascii?Q?aEmafXeEC3CkjhDtA9c1hoCo9231C4i7h1O/sAh/AX+RBlpE96XgMUwSteEc?=
 =?us-ascii?Q?p1fXbugPSphUExZi7Tl9XiI40zc9tVZUhEySCTucSbrRKpqX+tQDaiDYnUWg?=
 =?us-ascii?Q?gQ3l1C/+Zr5pTVbVPH4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72b012df-6646-47a2-a1f9-08dac1230d66
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 00:49:12.1066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i5T3YKvNEPL7WlKhxBmcVkbprTodXm11Tv7/k6Pe9BLocGGQGsAWUCrkK2Uy8bTw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7222
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

These are on performance paths so we protect them using the
CONFIG_IOMMUFD_TEST to not hit during normal operation.

These are useful when running the test suite and syzkaller to find data
structure inconsistencies early.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c       |  5 ++++
 drivers/iommu/iommufd/io_pagetable.c | 22 +++++++++++++++
 drivers/iommu/iommufd/io_pagetable.h |  3 +++
 drivers/iommu/iommufd/pages.c        | 40 ++++++++++++++++++++++++++--
 4 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 8ca5a38b2a79b8..536a34d099968d 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -589,6 +589,11 @@ int iommufd_access_pin_pages(struct iommufd_access *access, unsigned long iova,
 	bool first = true;
 	int rc;
 
+	/* Driver didn't specify needs_pin_pages in its ops */
+	if (IS_ENABLED(CONFIG_IOMMUFD_TEST) &&
+	    WARN_ON(access->iova_alignment != PAGE_SIZE))
+		return -EINVAL;
+
 	if (!length)
 		return -EINVAL;
 	if (check_add_overflow(iova, length - 1, &last_iova))
diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index a7d16cd14ea200..432592fc026f4e 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -261,6 +261,11 @@ static int iopt_alloc_area_pages(struct io_pagetable *iopt,
 			(uintptr_t)elm->pages->uptr + elm->start_byte, length);
 		if (rc)
 			goto out_unlock;
+		if (IS_ENABLED(CONFIG_IOMMUFD_TEST) &&
+		    WARN_ON(iopt_check_iova(iopt, *dst_iova, length))) {
+			rc = -EINVAL;
+			goto out_unlock;
+		}
 	} else {
 		rc = iopt_check_iova(iopt, *dst_iova, length);
 		if (rc)
@@ -287,6 +292,8 @@ static int iopt_alloc_area_pages(struct io_pagetable *iopt,
 
 static void iopt_abort_area(struct iopt_area *area)
 {
+	if (IS_ENABLED(CONFIG_IOMMUFD_TEST))
+		WARN_ON(area->pages);
 	if (area->iopt) {
 		down_write(&area->iopt->iova_rwsem);
 		interval_tree_remove(&area->node, &area->iopt->area_itree);
@@ -652,6 +659,9 @@ void iopt_destroy_table(struct io_pagetable *iopt)
 {
 	struct interval_tree_node *node;
 
+	if (IS_ENABLED(CONFIG_IOMMUFD_TEST))
+		iopt_remove_reserved_iova(iopt, NULL);
+
 	while ((node = interval_tree_iter_first(&iopt->allowed_itree, 0,
 						ULONG_MAX))) {
 		interval_tree_remove(node, &iopt->allowed_itree);
@@ -698,6 +708,8 @@ static void iopt_unfill_domain(struct io_pagetable *iopt,
 				continue;
 
 			mutex_lock(&pages->mutex);
+			if (IS_ENABLED(CONFIG_IOMMUFD_TEST))
+				WARN_ON(!area->storage_domain);
 			if (area->storage_domain == domain)
 				area->storage_domain = storage_domain;
 			mutex_unlock(&pages->mutex);
@@ -802,6 +814,16 @@ static int iopt_check_iova_alignment(struct io_pagetable *iopt,
 		    (iopt_area_length(area) & align_mask) ||
 		    (area->page_offset & align_mask))
 			return -EADDRINUSE;
+
+	if (IS_ENABLED(CONFIG_IOMMUFD_TEST)) {
+		struct iommufd_access *access;
+		unsigned long index;
+
+		xa_for_each(&iopt->access_list, index, access)
+			if (WARN_ON(access->iova_alignment >
+				    new_iova_alignment))
+				return -EADDRINUSE;
+	}
 	return 0;
 }
 
diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
index 9a1c8a5ae3c883..3b85fa344f6be3 100644
--- a/drivers/iommu/iommufd/io_pagetable.h
+++ b/drivers/iommu/iommufd/io_pagetable.h
@@ -101,6 +101,9 @@ static inline size_t iopt_area_length(struct iopt_area *area)
 static inline unsigned long iopt_area_start_byte(struct iopt_area *area,
 						 unsigned long iova)
 {
+	if (IS_ENABLED(CONFIG_IOMMUFD_TEST))
+		WARN_ON(iova < iopt_area_iova(area) ||
+			iova > iopt_area_last_iova(area));
 	return (iova - iopt_area_iova(area)) + area->page_offset +
 	       iopt_area_index(area) * PAGE_SIZE;
 }
diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 2ddcb0d4f71e04..c535be1bedb9ba 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -101,12 +101,20 @@ static void *temp_kmalloc(size_t *size, void *backup, size_t backup_len)
 
 static void iopt_pages_add_npinned(struct iopt_pages *pages, size_t npages)
 {
-	pages->npinned += npages;
+	int rc;
+
+	rc = check_add_overflow(pages->npinned, npages, &pages->npinned);
+	if (IS_ENABLED(CONFIG_IOMMUFD_TEST))
+		WARN_ON(rc || pages->npinned > pages->npages);
 }
 
 static void iopt_pages_sub_npinned(struct iopt_pages *pages, size_t npages)
 {
-	pages->npinned -= npages;
+	int rc;
+
+	rc = check_sub_overflow(pages->npinned, npages, &pages->npinned);
+	if (IS_ENABLED(CONFIG_IOMMUFD_TEST))
+		WARN_ON(rc || pages->npinned > pages->npages);
 }
 
 static void iopt_pages_err_unpin(struct iopt_pages *pages,
@@ -128,6 +136,9 @@ static void iopt_pages_err_unpin(struct iopt_pages *pages,
 static unsigned long iopt_area_index_to_iova(struct iopt_area *area,
 					     unsigned long index)
 {
+	if (IS_ENABLED(CONFIG_IOMMUFD_TEST))
+		WARN_ON(index < iopt_area_index(area) ||
+			index > iopt_area_last_index(area));
 	index -= iopt_area_index(area);
 	if (index == 0)
 		return iopt_area_iova(area);
@@ -137,6 +148,9 @@ static unsigned long iopt_area_index_to_iova(struct iopt_area *area,
 static unsigned long iopt_area_index_to_iova_last(struct iopt_area *area,
 						  unsigned long index)
 {
+	if (IS_ENABLED(CONFIG_IOMMUFD_TEST))
+		WARN_ON(index < iopt_area_index(area) ||
+			index > iopt_area_last_index(area));
 	if (index == iopt_area_last_index(area))
 		return iopt_area_last_iova(area);
 	return iopt_area_iova(area) - area->page_offset +
@@ -240,6 +254,8 @@ static int __batch_init(struct pfn_batch *batch, size_t max_pages, void *backup,
 	batch->pfns = temp_kmalloc(&size, backup, backup_len);
 	if (!batch->pfns)
 		return -ENOMEM;
+	if (IS_ENABLED(CONFIG_IOMMUFD_TEST) && WARN_ON(size < elmsz))
+		return -EINVAL;
 	batch->array_size = size / elmsz;
 	batch->npfns = (u32 *)(batch->pfns + batch->array_size);
 	batch_clear(batch);
@@ -367,6 +383,10 @@ static int batch_iommu_map_small(struct iommu_domain *domain,
 	unsigned long start_iova = iova;
 	int rc;
 
+	if (IS_ENABLED(CONFIG_IOMMUFD_TEST))
+		WARN_ON(paddr % PAGE_SIZE || iova % PAGE_SIZE ||
+			size % PAGE_SIZE);
+
 	while (size) {
 		rc = iommu_map(domain, iova, paddr, PAGE_SIZE, prot);
 		if (rc)
@@ -652,6 +672,10 @@ static int pfn_reader_user_pin(struct pfn_reader_user *user,
 	uintptr_t uptr;
 	long rc;
 
+	if (IS_ENABLED(CONFIG_IOMMUFD_TEST) &&
+	    WARN_ON(last_index < start_index))
+		return -EINVAL;
+
 	if (!user->upages) {
 		/* All undone in pfn_reader_destroy() */
 		user->upages_len =
@@ -890,6 +914,10 @@ static int pfn_reader_fill_span(struct pfn_reader *pfns)
 	struct iopt_area *area;
 	int rc;
 
+	if (IS_ENABLED(CONFIG_IOMMUFD_TEST) &&
+	    WARN_ON(span->last_used < start_index))
+		return -EINVAL;
+
 	if (span->is_used == 1) {
 		batch_from_xarray(&pfns->batch, &pfns->pages->pinned_pfns,
 				  start_index, span->last_used);
@@ -942,6 +970,10 @@ static int pfn_reader_next(struct pfn_reader *pfns)
 	while (pfns->batch_end_index != pfns->last_index + 1) {
 		unsigned int npfns = pfns->batch.total_pfns;
 
+		if (IS_ENABLED(CONFIG_IOMMUFD_TEST) &&
+		    WARN_ON(interval_tree_double_span_iter_done(&pfns->span)))
+			return -EINVAL;
+
 		rc = pfn_reader_fill_span(pfns);
 		if (rc)
 			return rc;
@@ -1025,6 +1057,10 @@ static int pfn_reader_first(struct pfn_reader *pfns, struct iopt_pages *pages,
 {
 	int rc;
 
+	if (IS_ENABLED(CONFIG_IOMMUFD_TEST) &&
+	    WARN_ON(last_index < start_index))
+		return -EINVAL;
+
 	rc = pfn_reader_init(pfns, pages, start_index, last_index);
 	if (rc)
 		return rc;
-- 
2.38.1

