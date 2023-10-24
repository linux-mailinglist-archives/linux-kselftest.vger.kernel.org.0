Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79327D5E87
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Oct 2023 01:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344466AbjJXXD0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 19:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbjJXXDZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 19:03:25 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCE210C9;
        Tue, 24 Oct 2023 16:03:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jIo81T3I7X+bScskpGVCR6/BOLu8+WSE7pI0DEZGToL+UIE1w6QnM8JqWp1l2ttYM5u6TxDjEsIDKY0VyHCUi2Yn4IZKhqAU8qyz8sKP4UELzAvtKpoF/tsMGZxTK7Jce0Q+/CGvrFezuSr1JMAfzEXdO+5ZwlIo0A/lxFVN5jNbwAWjL2eESsZ8lPwrW8qn7kbbO/cYi5RbxWjICq6zJ52I3ZAKNOE894/R3TBlLN6dh8lIh6czmEpxf14CDCQnAkMBx9dbipgCSNhAx03OSDO3rAoh9nf6LN2hDU8LwhkJIBNVxtaGTD1AJrO7A3+1oXMQKjUojJGZ5N99JHMoPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7M6tAb22pOYOnmz5n1ogKQukoi70QLknKNx83CqmgnQ=;
 b=eIq59ktFC1NF7eUTjnw8XCQkIdteAbjmg0Aj18sxQ13WaorJWE+xJsCwcOKtOeCjTTG/AR7YafDWUmmef17AqwcNtdtQsbtPsy1R6QphMv6aRNygj+OI9p/HbW6K9ZEnxmKIB1BLQG6rmIVCpjCkXJcLFxqi/RO72qno5mpFNnP8piAgRZXY/4pIM3eL95UJ4H/BHnFyFfz9ouo7kB66+uJ+7+h6VG0fm3oZei+Rkv+d8xBmw4KdloV5h1sAgxX/mcyTLvaQqt6byvesEjNdr6PEOeotP9ayhUxkhUnT4Dumf7KGhyaBo3432ocWBPRrvnXPtcN4Q/EgRSeRUw/6AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7M6tAb22pOYOnmz5n1ogKQukoi70QLknKNx83CqmgnQ=;
 b=mgK7rsoOekegxP1ScWIscGq5UeZ6jpRJH2kuCL+IofjtGEdFI/o/rtKYz4l0rozH6WncHxhgwTXkOiDMLTqcxAawHrqB4aZqjbiDPHcSjwujk4j5EAsXRqaDGfJg4s8eELbdQmG1cgp6AODddTEP5VKvwKG3nnLUdWYTrwO2rhfpB9TWgPR1TLeRZDxMmO3FZikWfVJW9nGZLMxyqxWYyoSkfILgHTAnmUXV+ewaE3kK9zzHy7QxsBZ0J30m54hFD1yE2P91UJpJeQ4kGUDMk0Oq7T8p8kN3YpJAnOAWhSMYfsXw5UJIqdwZvx2Ipo/C41aqJXyZBOARB2kU1ncXJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Tue, 24 Oct
 2023 23:03:20 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Tue, 24 Oct 2023
 23:03:20 +0000
Date:   Tue, 24 Oct 2023 20:03:19 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yi Liu <yi.l.liu@intel.com>
Cc:     joro@8bytes.org, alex.williamson@redhat.com, kevin.tian@intel.com,
        robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
        eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
        mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
        yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: Re: [PATCH v7 7/8] iommu/vt-d: Add nested domain allocation
Message-ID: <20231024230319.GW3952@nvidia.com>
References: <20231024151412.50046-1-yi.l.liu@intel.com>
 <20231024151412.50046-8-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024151412.50046-8-yi.l.liu@intel.com>
X-ClientProxiedBy: SN6PR2101CA0022.namprd21.prod.outlook.com
 (2603:10b6:805:106::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4356:EE_
X-MS-Office365-Filtering-Correlation-Id: fb986055-814c-440c-f345-08dbd4e56a6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: csDz33GOQ5M/VucU80GDjWHLhkdP45ic+To18ZMiK4iQWfCQOzaq5n6rIh3Qcq/XlB9tol+SYNc+piqYA+nmI9NjnnoJpRLi98jBIORfTL+l6CCbccFKo4vsfNdmDEx4JEk5WlljQzrD+iPZI5pYs+3e37zd6QKKuxBI5G1PTL3cQmiW+ssmvR4jC/UWTyHOmLCueeAijk+Akw3CmQwX0VvAGAzK4z5F0SP9FR0H56VUGjPkpETGTIgP9HKUTb6KRYJ3R0LX69rNjBwnoHumDCS+kislm51KhvO7QlNQ+MM3l5GR+l9LuS9pssxCE7J5V1sENY2tgS4rlO9yW4D3nzk1kLBusP4e9y6uYnYmRx4tvg/7BTdDI0rX7WPO0546HcJ0LyXJh5KTUfWTcSRUHQAVpUGsrSVzf+yZCD5rD/bwXHlUCzGin94g9wljaFibK7T0jJi7bb9DfiVvwFSdIY3M5ZjUriDgw9TKFiM6uMEpF7SamM0DFYS5fmpQEr2iPqhO4DQ+saDpY2MnOOMLvBIHYXGsJvqA7JVe2E/ssVl/u4Fr2zwEelxNh6E4veJa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(39860400002)(346002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(26005)(38100700002)(2906002)(36756003)(66946007)(86362001)(5660300002)(4326008)(7416002)(8676002)(41300700001)(66476007)(8936002)(33656002)(478600001)(6506007)(1076003)(6916009)(2616005)(66556008)(316002)(83380400001)(6486002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z5ZZxBoa0RYD30lFugq46jF8S31+O0lZjW3fTGa5w/wnS3ytGWw39c73hQB/?=
 =?us-ascii?Q?0jBlzZv9oSfyp1YOj7sZI1bk+rblz0KIOOpd04/8tLxkIY5Ishol2pIKt7W+?=
 =?us-ascii?Q?AQLlyeVqxCL9SnmAM4LiXLeg9p/IvLozASBzhpSO6KayUu7UMneqfXXSyKgg?=
 =?us-ascii?Q?Z16g1nEaUzsFcALWKRur/INaHlTwwwC19VELTqQKfoCg/PhdZcrC65jAJeju?=
 =?us-ascii?Q?YCEFvP5Ks1DpD6hoBbp+RiVrdyrOOO3F+vcU+kFksgFiTcHmmjuAiFXJSDcb?=
 =?us-ascii?Q?AvgKnZxRQOXOsWbp+fqGM4lB0S/oGxkB1tkcX/1aGeHfcn10qpZaqdIpPop1?=
 =?us-ascii?Q?GDiFapSpjcs1SZr7FrWD7iyd81rDK6BQRl9+oqGq5j6F4hE2wkly0rGuEnze?=
 =?us-ascii?Q?jpHf2gCysSGbt4z0oodVXnL033Dn53uj35RrTOXm2p0YYm5IDUddORHPrFUL?=
 =?us-ascii?Q?4RFXtQ5ty2txLbGzhivghgyXGSReFSQBKLRiGGx177GFPZsjfDwVRMY+1t4r?=
 =?us-ascii?Q?ehNxOplRsPNClG4c7+qz1uYpHV3vSrKElMw9+3L6msnqUqeowNcn3fQVBt7g?=
 =?us-ascii?Q?x9luaBJInlvKb7NjOgCGhgQjQoq8o06SrOrvfgTRC37T0ngxTR8WTQN/tGkp?=
 =?us-ascii?Q?I88ws1v4Qoa1IFmwZWniKVd0y+aHpQOFHG9eSyn57KRDcfApO4aeeZTHU8YO?=
 =?us-ascii?Q?fGLkGjD+uLGrl7r7Crms2BEfDTXn6hHb7nWse1WFpaOycNv03kpYHFWurAoi?=
 =?us-ascii?Q?gVKRSXbZGo62Ak5LOwom2+7L/w5w+q8Dms1cr7wt+TUbEpSto9ddB7YF/UJ0?=
 =?us-ascii?Q?5BiT2ATD2w+jQXHfMBQgchE2Xwsu/Dh8W60SPbzI0fDHzuaI5LhCuWX4q4Uu?=
 =?us-ascii?Q?BFSGMB8e4sR92gmtuluzGnwXZgqbKR+/rHsjY2YM3cz7dKsmTjtS81LpU5Qq?=
 =?us-ascii?Q?CsFBEkqSHKwylyvigRdL+sFdBWfLxFIP0rYBTFBxGiRugi0gjWGp9HH+74Rq?=
 =?us-ascii?Q?a4Pt3ZeFgbWPkHc/cMFoqSdlfuuODux04HQpM528UhehT0ZIo2srRcDew4Pf?=
 =?us-ascii?Q?mXnjLUgIhXBYsYBbS8pTLp2ZbPMYIyyfHekxDzMgtexAd2IWZqoiw8sEs8+E?=
 =?us-ascii?Q?0gGMt2dYi0n1nY2yEQ3XHuHUth5eC+hVzbCFDvaxjKqU0XYMtTdav9nlJJxC?=
 =?us-ascii?Q?jxn4faR0X9itD3lX3NTcp6QJcIXoD/rjxBFI7buZGEc5d3KCVG1CdF9ixt7R?=
 =?us-ascii?Q?oy+jRvnjdPU1V43c5MH5/OSRqQyfd6uLYaIjoixlqmZSc/d1J2BzZWzooNYt?=
 =?us-ascii?Q?Q6tksT/lIzB7fcyqwt7ncNeZ/ZvOfMOMn5ZZtICh8qdqeBEyNafEZusKI36o?=
 =?us-ascii?Q?V0UwnYxWidfNBHssYvh7aoBRW74OHhOKBUetjq+WcQecx0aKB5l+ByD7Fd1l?=
 =?us-ascii?Q?H+/z5imx2r+RiZX0r/f/r/Zj8b4aWAC8bLt0ESJJ+O+8kCrT3N4eVYIdqHUJ?=
 =?us-ascii?Q?YQb6Y7ee4gvxb8wLLoIKk+CKhvWRUrUaxJUJkhIFbeS9ljQheGoiDkTsoxna?=
 =?us-ascii?Q?r2zyQkWgsIAf5w4ND1cHWPPAklfAyKPjLkz9LGSd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb986055-814c-440c-f345-08dbd4e56a6b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 23:03:20.2821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n1KcIZR8W87LacLiII+tz2TYMahlhZB9zx7ittUk+XQqUtVbr4h6xSDmIW1mccBh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4356
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 24, 2023 at 08:14:11AM -0700, Yi Liu wrote:
> From: Lu Baolu <baolu.lu@linux.intel.com>
> 
> This adds the support for IOMMU_HWPT_DATA_VTD_S1 type. And 'nested_parent'
> is added to mark the nested parent domain to sanitize the input parent domain.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 67 +++++++++++++++++++++++++------------
>  drivers/iommu/intel/iommu.h |  1 +
>  2 files changed, 46 insertions(+), 22 deletions(-)

I think it should be written like this:

@@ -4077,38 +4082,39 @@ intel_iommu_domain_alloc_user(struct device *dev, u32 flags,
 			      struct iommu_domain *parent,
 			      const struct iommu_user_data *user_data)
 {
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	bool dirty_tracking = flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
+	bool nested_parent = flags & IOMMU_HWPT_ALLOC_NEST_PARENT;
+	struct intel_iommu *iommu = info->iommu;
 	struct iommu_domain *domain;
-	struct intel_iommu *iommu;
-	bool dirty_tracking;
+
+	/* Must be NESTING domain */
+	if (parent) {
+		if (!nested_supported(iommu) || flags)
+			return ERR_PTR(-EOPNOTSUPP);
+		return intel_nested_domain_alloc(parent, user_data);
+	}
 
 	if (flags &
 	    (~(IOMMU_HWPT_ALLOC_NEST_PARENT | IOMMU_HWPT_ALLOC_DIRTY_TRACKING)))
 		return ERR_PTR(-EOPNOTSUPP);
-
-	if (parent || user_data)
+	if (nested_parent && !nested_supported(iommu))
 		return ERR_PTR(-EOPNOTSUPP);
-
-	iommu = device_to_iommu(dev, NULL, NULL);
-	if (!iommu)
-		return ERR_PTR(-ENODEV);
-
-	if ((flags & IOMMU_HWPT_ALLOC_NEST_PARENT) && !nested_supported(iommu))
-		return ERR_PTR(-EOPNOTSUPP);
-
-	dirty_tracking = (flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING);
-	if (dirty_tracking && !ssads_supported(iommu))
+	if (user_data || (dirty_tracking && !ssads_supported(iommu)))
 		return ERR_PTR(-EOPNOTSUPP);
 
 	/*
-	 * domain_alloc_user op needs to fully initialize a domain
-	 * before return, so uses iommu_domain_alloc() here for
-	 * simple.
+	 * domain_alloc_user op needs to fully initialize a domain before
+	 * return, so uses iommu_domain_alloc() here for simple.
 	 */
 	domain = iommu_domain_alloc(dev->bus);
 	if (!domain)
-		domain = ERR_PTR(-ENOMEM);
+		return ERR_PTR(-ENOMEM);
 
-	if (!IS_ERR(domain) && dirty_tracking) {
+	if (nested_parent)
+		to_dmar_domain(domain)->nested_parent = true;
+
+	if (dirty_tracking) {
 		if (to_dmar_domain(domain)->use_first_level) {
 			iommu_domain_free(domain);
 			return ERR_PTR(-EOPNOTSUPP);
@@ -4849,6 +4855,7 @@ static void *intel_iommu_hw_info(struct device *dev, u32 *length, u32 *type)
 	if (!vtd)
 		return ERR_PTR(-ENOMEM);
 
+	vtd->flags = IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17;
 	vtd->cap_reg = iommu->cap;
 	vtd->ecap_reg = iommu->ecap;
 	*length = sizeof(*vtd);
diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index d9197dd72748b1..b5a5563ab32c6b 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -78,13 +78,21 @@ static const struct iommu_domain_ops intel_nested_domain_ops = {
 	.free			= intel_nested_domain_free,
 };
 
-struct iommu_domain *intel_nested_domain_alloc(struct iommu_domain *s2_domain,
+struct iommu_domain *intel_nested_domain_alloc(struct iommu_domain *parent,
 					       const struct iommu_user_data *user_data)
 {
+	struct dmar_domain *s2_domain = to_dmar_domain(parent);
 	struct iommu_hwpt_vtd_s1 vtd;
 	struct dmar_domain *domain;
 	int ret;
 
+	/* Must be nested domain */
+	if (user_data->type != IOMMU_HWPT_DATA_VTD_S1)
+		return ERR_PTR(-EOPNOTSUPP);
+	if (parent->ops != intel_iommu_ops.default_domain_ops ||
+	    !s2_domain->nested_parent)
+		return ERR_PTR(-EINVAL);
+
 	ret = iommu_copy_struct_from_user(&vtd, user_data,
 					  IOMMU_HWPT_DATA_VTD_S1, __reserved);
 	if (ret)
@@ -95,7 +103,7 @@ struct iommu_domain *intel_nested_domain_alloc(struct iommu_domain *s2_domain,
 		return ERR_PTR(-ENOMEM);
 
 	domain->use_first_level = true;
-	domain->s2_domain = to_dmar_domain(s2_domain);
+	domain->s2_domain = s2_domain;
 	domain->s1_pgtbl = vtd.pgtbl_addr;
 	domain->s1_cfg = vtd;
 	domain->domain.ops = &intel_nested_domain_ops;
