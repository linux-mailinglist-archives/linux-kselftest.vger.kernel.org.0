Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0041B6B4F6A
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Mar 2023 18:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjCJRts (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Mar 2023 12:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjCJRto (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Mar 2023 12:49:44 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADCF130C0F;
        Fri, 10 Mar 2023 09:49:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEIqHqDKh1/DcKfTG0U2oRzzcRW4c2bgHCt7E0FLS+OpNWhuZZtx7ohTbqMthrU4us46h6tbabg/Yd1dwiNDGlFtwpwpXLklbdBcB7F02r0UZm/ucbkm+z+mWn0fBv/jq2zCk8o/xKGFeRMpLnTWAE9yudorx+rOT7XRRbB6RKJGmaVN0A5EwYiqRk7PYdOdzrvgzrn6r3ORjn59Vek4SDYVnwdPpIzlWd1zEte2xvXHYovNJVLnXUtcYPlklBrqrFVdJHEWsFQtGtX2O6eQi/aBIoaKxcPRLGYCNsapGKQ7S+yIX4bpJDDBDH4Q+DH2B9PAKn7/E4sPf+QB1B/pRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YsytyIQ4RIlP/oR3M51PQFATYYSpKScNdIP1vdBvco0=;
 b=JGiJ6QsTqzstUN33kLIC9HYFM9rdL3WzQ+ed+rWUoupzHv2BhJWBnanP4qhfNXuOI/mazzDp3ptI5JSbfgIJXxW/AI8sVE4uyfB6Cdw/duE7oDaBIUBgSNjrxgsEUG0UZEkDGOJD996jrX+9+GbEGWqm1VU+nvM/sup1xir0BQdPk3jyOMLNiFkW8227koAydusCnUWpF3mjUKIv5Ip6412liGcfkmcWKn/0z26JthKGTe4nQjLwND+hLGBUi0+IwkVP/ILHFB98FhFN07a1B6Qm3a51trSg4x6incnBYlBjf6uqzjMsDqHqiMD735z1u2OHJFR016bevqsA8e58VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsytyIQ4RIlP/oR3M51PQFATYYSpKScNdIP1vdBvco0=;
 b=VhLwto5B+ZIUOhTLFivmOtbBjngluYSHlDSEzRXBqwEUZCfjT88SylLl7KmWEdbysi0OAJqCNarSf40OwlFtN9bISiJ963l7/CeRVvAw1i/m4Oi3jUOBImMM4PEgLM7/xJAEtOehzyGEoIfmrgJdTWda8oASQE+cn8gjJmDgr864ZVLCgolbvjY+1X5B0OwuBUCY4NPbl58hTEjkSoNBpZ3RIfSB+Z0k9hOBvSaQVXiPsLT+J+cDt2Kf4n4PeHcTW6M0U51eb4oXHP9wFGCOvY9GyAWJjuYHfP/QiIPbMVTIyuqfDb4CGQZoAxrBw/Bw/g5rhQC9iOqq9w9kouX3+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH2PR12MB4103.namprd12.prod.outlook.com (2603:10b6:610:7e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 17:49:10 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Fri, 10 Mar 2023
 17:49:10 +0000
Date:   Fri, 10 Mar 2023 13:49:07 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org,
        alex.williamson@redhat.com, kevin.tian@intel.com,
        robin.murphy@arm.com, cohuck@redhat.com, eric.auger@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 04/12] iommufd: Pass parent hwpt and user_data to
 iommufd_hw_pagetable_alloc()
Message-ID: <ZAttk17mCqgCU1nK@nvidia.com>
References: <20230309080910.607396-1-yi.l.liu@intel.com>
 <20230309080910.607396-5-yi.l.liu@intel.com>
 <21c95149-6acb-e330-acaa-390309269a21@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21c95149-6acb-e330-acaa-390309269a21@linux.intel.com>
X-ClientProxiedBy: SJ0PR13CA0203.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH2PR12MB4103:EE_
X-MS-Office365-Filtering-Correlation-Id: a8eedfcd-d6e8-4f3e-5fd1-08db218fc0c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R8pr3VzK/YtZgVFL2cNuUmtg70VSoZg0gudAOm4PGUcyRu09xYVsqqmuM+FGU52cAimgX7DxJqVV3woaY0T8eNHmi9LkyoPlwseHIHRMdNLPCLouitp4IzzgNE1MED+lxGJ7+guDdos27fqTOZu/uY5VOJHu1se05J6BGM1pMAUuteZqWrC5WTjnFoEzOD1pSjdrGObg74opdSJC9vPmgpqLA1KrA7LI4JdtKJgbfJOTry+mlK7aUK6j84hTChexBuRvzASzWSha7WszIVtSr6kemsx73UIEcSwaLq1Pe1fgsafAToY1aXYAgS/DpVXWU/VmMxf2bFwFbiKOCOVhLTb1dSFYzWCXcBQ9vuVPTf3eYdYGwQO/Ai0dGnOZUOaL+3bWQL3kLzSBTVkeFFKp6mMkrIV57OrJsmbnLD93tAPInoMUnU8SNRZn9W2IcbZoU20+wd3sChNAfTse5ZQyqvnDcTL2cuMnY+FaTzETb5nQPk1qYo2udey4z62pS0dnzINF/BkP1sY5RWIsCD6jIqcdnwrM4EKr2qopWQhscSjMy10//fdNReH8mZmTWRCs26NnX2QeDk0FvGKtMAqlApQ9Ks1LxMyCmcLYUNAQGVfVFSEsh4I0sxNWWoxNO+LbD5co51cD5R744xn69zHg3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(451199018)(186003)(36756003)(38100700002)(86362001)(26005)(6506007)(6512007)(83380400001)(478600001)(2906002)(6666004)(2616005)(316002)(7416002)(5660300002)(6486002)(4326008)(6916009)(8936002)(41300700001)(66476007)(66556008)(8676002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w20o4tQ2lHHJ+itxKDm6cnPkQzA3axUu3/34Fvx9W9ySHKQFfyqkbQqFWTWT?=
 =?us-ascii?Q?UEgOUJANy4GcD2N3dArYlHtc/dKqz2NcMQNlaWq9uK4Ve5Q+GL6qJh93LKa3?=
 =?us-ascii?Q?OGChClpQUQ+ozM9LmLJ//RjMIUIughZ7Koza11ATPJQkdMHVSQyRqOyxr5IW?=
 =?us-ascii?Q?1jorSiyJtIR1EFJDDd7GrN0L2J1EFEtlCdYuIwPm/dU6ubKAe77IM0de4ghF?=
 =?us-ascii?Q?IQkYMI3nodwk4ImiEVW7e3HNR3eRuS7/nMdZ0W4sE2x0cPB6JLL2fkJrX7pp?=
 =?us-ascii?Q?zn0wRLqAEUdsKEy8FbTa25Xa0ueCu/0V6btu+IMsse3DRlPRiPiWu6vFLCb/?=
 =?us-ascii?Q?JoD7CcCbKIxNK/vovrF3V3JWy64iP3861S/KEfo1E80poZPicnpkFaEu9m/Z?=
 =?us-ascii?Q?EY5urx2T7cfXxitBzOwWl/RlLcZ9Z0Q7U1A0eNP/Xu4q2yJ4psLqnYaRFvrl?=
 =?us-ascii?Q?0sw2UM2quovOMwuySuPRniKPaKvx+dzfT6P0srUFipdoqQ6MVC1w2WC3WEmA?=
 =?us-ascii?Q?nn4sC+Pw3fYeV1BIv0c0qUWOUsCUwuN/BddRp97JGn4s5Mt1ZRYV3eSHokkP?=
 =?us-ascii?Q?SSGOss1pJk1jojkytPmlN+a8m1Kb0cixojCrro3K+mz3CxuMINQeD/vu2VYz?=
 =?us-ascii?Q?Va7N3NFduzY1MFaK5a06mjfpJrD0TAIQAUPQgEGc/3GW81D+WNVhj+bCSuqp?=
 =?us-ascii?Q?3vlj6r9hBu7DJ7I4hyyRBtgWKqEWe0d6mSRvHvGpuHFqFq+3/+1+9qVBeD53?=
 =?us-ascii?Q?xc3pLpLDVZw51CrLMjLA1jFDtRAJG/gCVI+6YUPgfXPvj0flPY1HKB/Wp3cF?=
 =?us-ascii?Q?DqYb70a6VxnpCyZuEjUji2Iu/itRtlQE6OHqRp83briC3ecv6iKMcgepA6M8?=
 =?us-ascii?Q?YV0qqO7JivDrgJXCwt3AG0BLl2QjMy3ADAgA61RnHyxfUXXyMN1cDm+/Bm9u?=
 =?us-ascii?Q?lVwLvKtmkpXM0fCPD7QG53wP2BvGbJ3HZLv1tL8VFnY9wGdv4XthObHXmS2f?=
 =?us-ascii?Q?FsgD4VfpUphLpO5Q+pbkZ3fHMGFzJFc1l8FBXwqlVlCa5WXLtcBLvbr2BGk/?=
 =?us-ascii?Q?x8K2Pgkv10/PARtMYO8j1NwSrZYLNLZbaKCxa91hAKL6SlxvJMtiwbsB0pWZ?=
 =?us-ascii?Q?XR70Q6pZN706+q5tr8LmgLBdOu6jd9AbvBY3D6YPxykt6VlEQu1aTOS5FIiw?=
 =?us-ascii?Q?2g88IEcNTylN5kfpsSd/85LfUvGwTeZREXk2cvpz/gNUriGbIRsM/mGHrJJ2?=
 =?us-ascii?Q?32kYtvF4+EiAoyrnp+eagfahcXOHRN7si5RvCY4rDMEv4lUTyEPmLbSMc3cP?=
 =?us-ascii?Q?7Q2Fbm1t8JmKzfAJaeVTRToAoy5YmfcL/q2wf07WmOYA1HTzLVVDmmUoTf2N?=
 =?us-ascii?Q?9xmCJnMoLC5XzYGQUris95DasC6MZABeozPtdGUvaTAmdnkIvcWCvz3DpMrN?=
 =?us-ascii?Q?m+mVHnQiGAO0pIDGZ2xXr6BTxTasEfGV9LST/0sKh/CeV4U2Nv2ZDCdcpSLz?=
 =?us-ascii?Q?QG7ukLvtQxhy9XEA3wIIIW/V0rG9PCL3VnUnlKXeysIsPdqwXqZjZ6LdyYqY?=
 =?us-ascii?Q?T4txKhHR6vmk9+asLF6UzcGE2KCPOmSWDi4VNg7H?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8eedfcd-d6e8-4f3e-5fd1-08db218fc0c4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 17:49:10.3379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7oA7UJYjBHx4/st+UZ+m0ZlNbkiW0t2IObtrhhll2pdMgufgFi+Skyx/g/jxTE69
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4103
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 10, 2023 at 10:10:56AM +0800, Baolu Lu wrote:
> > @@ -54,14 +58,20 @@ int iommufd_hw_pagetable_enforce_cc(struct iommufd_hw_pagetable *hwpt)
> >    */
> >   struct iommufd_hw_pagetable *
> >   iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
> > -			   struct iommufd_device *idev, bool immediate_attach)
> > +			   struct iommufd_device *idev,
> > +			   struct iommufd_hw_pagetable *parent,
> > +			   void *user_data, bool immediate_attach)
> >   {
> >   	const struct iommu_ops *ops = dev_iommu_ops(idev->dev);
> > +	struct iommu_domain *parent_domain = NULL;
> >   	struct iommufd_hw_pagetable *hwpt;
> >   	int rc;
> >   	lockdep_assert_held(&ioas->mutex);
> > +	if (parent && !ops->domain_alloc_user)
> > +		return ERR_PTR(-EOPNOTSUPP);
> 
> My understanding here is that we are checking whether domain_alloc_user
> is required. It seems that as long as the caller inputs a valid
> user_data or parent, domain_alloc_user is required. If so,
> 
> 	if ((user_data || parent) && !ops->domain_alloc_user)
> 		return ERR_PTR(-EOPNOTSUPP);

Yes

Jason
