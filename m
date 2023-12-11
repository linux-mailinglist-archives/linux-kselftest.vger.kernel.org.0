Return-Path: <linux-kselftest+bounces-1562-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBBF80CAB1
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 14:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4840B281D50
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 13:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C7B3D981;
	Mon, 11 Dec 2023 13:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BJItbru2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57097DB;
	Mon, 11 Dec 2023 05:20:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F4rpjM1iHybaI0vX/nOADeutbLukThbPon8DA8gNGUHFHT3tkB15efbRYKK2P56pmOVryEuezdptbrn6+Bu0uUgB+Vi+VwRkJ16DnYuXUpxx0RHMCeK4FEyye5ZBc39x0altVw0I1ILOTchmdvdDbsDrLjzlD/XwxzvWTX3gyyKUTYsRZZPzlbBSg7ttrLpSewaAi2Pf6OkCljq6BwwfFlU698mxTEd/eoXj9uXkGffQwXq28uukY9XbghEF/F95+J35/YIM20XxeCkUmLDwXpdUil/m1CUx+j8ySVzOGLLaRV5qcKiKATx71n1/GeAshfxYs0Y0fAJepYC3D2o67Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+WITRz0gjyWRA3VOGox+SRsg3Itx/VuYGmKozrmE1o=;
 b=UFrMHlTz60fE1ioHO8PIwsyBMLdLYczT0yYWx9YqNGs7w0JZJl9MHPOD6I2GPArIGvi8CMrTzI0Do/zXIltTfDVgupQaOXRJ/vTBhBWVl9FdRBxp5HvmRprBtOmG/Z8lmQzonJL40PFxUZl1tzTMVi7gmLDmsoGo1pc97W6HkU5DK4h2P3odUrAD0tbNgEPOI9AUPaghYk81CHXrJQHjzKgTpHTF6+VbR7inKbOzkz8q1sCbgOcrH9BgeXg4ByZMSDY6eqAX5oXAxLAfNo10nwt+PrfahHloP8G3nyQzqz8GAgg8qYlvNVuzxPvQ+Er3dt6XVMXFQdrzuprpcIUqfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+WITRz0gjyWRA3VOGox+SRsg3Itx/VuYGmKozrmE1o=;
 b=BJItbru2mQv9eTxsePpH6XHlrxQi9VQR09ItX+u1Najs85x+cc4pnb9jlhrqiLkwJ1SGQB0H/2M0TzpiHBVLYYI1xxD/NXxmwpfmCMpv9A7sPRKHf9OOacz89PtIUyFxr/jha+XpyJtC2yPVnI6aAzzNm6vIyQQOlEUlxAzeJ+5O+RCMQXNbzmtVih6Re8UV3iKhN5o9UlbwvYVkSeBkz8FqHoAZ9lMBWTHqEGItRloqXFWpNDhkg2vhYqbLbdFmXr++gPjQbs9+jlOJ+FqLRwHKAcwKCHd3ZkmYVW7Ud5kmljSHTiuzfVlQMSs9YyjyOxG/62lQXWuYAp+hDeegwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB4178.namprd12.prod.outlook.com (2603:10b6:a03:20e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 13:20:43 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 13:20:42 +0000
Date: Mon, 11 Dec 2023 09:20:41 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: "Giani, Dhaval" <Dhaval.Giani@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	joro@8bytes.org, alex.williamson@redhat.com, kevin.tian@intel.com,
	robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
	eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
	mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
	yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
	shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, zhenzhong.duan@intel.com,
	joao.m.martins@oracle.com, xin.zeng@intel.com, yan.y.zhao@intel.com
Subject: Re: [PATCH v6 0/6] iommufd: Add nesting infrastructure (part 2/2)
Message-ID: <20231211132041.GE2944114@nvidia.com>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231209014726.GA2945299@nvidia.com>
 <77ac47d0-2ef0-41fa-86c2-091358541465@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77ac47d0-2ef0-41fa-86c2-091358541465@intel.com>
X-ClientProxiedBy: BL6PEPF00013DF7.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB4178:EE_
X-MS-Office365-Filtering-Correlation-Id: d2d80785-df60-43fe-fd54-08dbfa4bfa07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tDBsMTHoYR9L8xV2gjK98vO+SgRK3l+RZILJ8t2VAeKByDjkJ9+8lBhEKVquPb63+KTdSvl7qkXasAyUrBTBXFwYztjb+EG6q9klJpNZ7K+DqFCuqQL/qV9txNssymHqU63fEylLNu3URcRTMEKdkTNvZTABw1kk3uxYU+VRB6BO6yp9Lr/anWM+qPwjE5+iGDpLBnoZioL9SxnTexO+YAnKA/VmtlWlA9vpZcTzkNhYUxyIZ4hg3HU5Tw5CPz7DISl+kwfmG8vG/le7qtJPS9HdZx5o60d1f69PnQmFC86L4VPy8puTkQg8TjBTEZZIHaT4I+ausulN3XBSVG7FhCGjJiFk5cmPAd2BaQG2GpBvofOdQiILvavwSts3NiKNZJQNFQ7D5u+Sr7ohfojKh5zUGLcV2D7e/Ork77r6/aPGBtpAFF/TDEOKl5kiSmYTaBhj3bCsH8ETldamEaKBgcUm2g3od25gbDDIBz4juzRCeOKY1f1D4+IkBD8dhETn1HQIKAvDF+dIcqU/yIeus9xFGOFRFtcQWUfA/UfJ74l1i5TknyF2O9cqwX7vI9ez/PEEooiIiCSU91iwFsOVe37evbkPO7RdsFYUY9pshps=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(1076003)(26005)(2616005)(6506007)(6512007)(83380400001)(5660300002)(7416002)(41300700001)(2906002)(4326008)(478600001)(6486002)(66946007)(8936002)(8676002)(316002)(66476007)(54906003)(6916009)(66556008)(33656002)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0BcBTaelb7kFCycCipzLQzRcElUN91/lSyFFkZ+DBZyqcT77dNUkbEbGa9ws?=
 =?us-ascii?Q?Zb7LQsJ00WuEMc266xArwI/o7+xY3v4bf/zTXYAbMsU8Zs1YS76SmoXOHqf8?=
 =?us-ascii?Q?DDIdX9ea3HHjYzYrFrizmXhxJm8Ooor/2+Mxnulx9dMoflhlI5JJKsJzWGSC?=
 =?us-ascii?Q?nLWbQO6V1pPdN/kRk/Gbea+uEmpCXg1tKz5lxlWZodTMx7tsZIhrkwsMRn5P?=
 =?us-ascii?Q?L6VmxG42CCy/lKnos5GxcFhPr7xEx4V1E/mctIfDsrl5JgmbK1iHsYbSzy1W?=
 =?us-ascii?Q?5Cv8/ciSl6Q5KIlUfbBFVzxuHqDmEnmd2RRz0K4LC3rTY7Fzki+imMFp6VtS?=
 =?us-ascii?Q?m4U3PonW5FH57YBw3uOrEgr8cEW7kR73FBHsQtq1SbQUlO1l3LBkYPu8RLcA?=
 =?us-ascii?Q?KeoZZPTAv1C2ohwLxTJBRjURIll68MDfwINvQXdV3cb8K5rMX+l3jMgde+Y6?=
 =?us-ascii?Q?GUjFTJs51GGTRU1V6CIFXBkFB2BJu/MOKHLZMWdp1UmNAhWCJNGY0IoXCn59?=
 =?us-ascii?Q?8OAcLnozEsS3O5J9nmvAWUvNKfaG3iOLXmOi57TF8lwebFUpkmcT/1w2HHeq?=
 =?us-ascii?Q?Mpsk6JzD6MTV8HKuSashM9PFxI8Ob2xL0pFAhkYjv9be2LgvuC9BioeADMLM?=
 =?us-ascii?Q?qSwVc1H6o5U1TDTvqbWn792Z2TX7CErJBwc3ZmtDNGyhE0C+dPTmS5gF2Tzi?=
 =?us-ascii?Q?4XekRBpXSXkLBgSWww0grG+4GyNpNCD7DgUXpM2FxtHZF4vXvl8DTXE+5Xb7?=
 =?us-ascii?Q?acj9mGzcXZgU+6PSBbqPjuiEv5zNhy026jdAj/ifdwgX+ApBVOkQTd9e7HtK?=
 =?us-ascii?Q?OFP45Dd7DkHGBxjGhNajdsS5dNaPHS80x8At90WwrKnQwHlVsh40JPxCCe5Y?=
 =?us-ascii?Q?cQWDqQ5YKCXo1QfestCqaq5egdUYMQCkvT2fKYo/UNJsbXRzkbQu14dLHuVC?=
 =?us-ascii?Q?UN0Y5VBFKCyeBpDxqcp4Y05zA0d1QPdbAJYqQBNNetyzQeCPB32xpnH5uGdb?=
 =?us-ascii?Q?UBUbT88WOA20L4p0kEYjS1LTIgRpdg04um5Ah46kNP6xNKkM1Npx3cCork10?=
 =?us-ascii?Q?heos1uI6h73PhzM65c7zvwsW55WqpFiaqhpgDADF5kb2I0I+CzvX/6Pxk+06?=
 =?us-ascii?Q?WHuXjBscm20l9ji7H55VyxSmNZs71zImrtTSUgFcHmGNq9XD3i8OBNYF/jtW?=
 =?us-ascii?Q?tsZsYIIUbljry2rL9M5kNtVsvUnJFWHXEUewMwqs/CgbIAO/BsduzLF+IYsh?=
 =?us-ascii?Q?XsMY9CIuWllZpSDJMlORIBTUb7B14jaILhwZ96Sc0TWVg+Z53S4c9RsO+ZMy?=
 =?us-ascii?Q?2gZNNPPtsqkopqwdi3fm0dsXawJZtn6wwd80SEEDeP+VNDKQNdq/ywAnETxe?=
 =?us-ascii?Q?sMLm3t9g/Cxu7ciOvEHitncg9sOzzKsjDXNZVoajvGTdlPkoZm/4ny/7LviX?=
 =?us-ascii?Q?nl69g9y2n6ycw8jlY70o2XSWXb4Y963UpgJ5RHxFdq6I+v+sSJ/7Kbw4vQNJ?=
 =?us-ascii?Q?abXkH/vtM9MRc6J7KYopva7fmu8PRP1T8luIwPF9uSVvH+g70b0XELW031R8?=
 =?us-ascii?Q?GpYqJxffyBibHfg4tTR7hph34K2dC7cik0TyUQ0G?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2d80785-df60-43fe-fd54-08dbfa4bfa07
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 13:20:42.8520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6USC606W1KUQG6muXesMZiz0WErARjrBK6U2Iy+mpyRkoxXXe0ke2lv1GxnJ9n9N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4178

On Mon, Dec 11, 2023 at 08:35:09PM +0800, Yi Liu wrote:

> > What iommufd object should receive the IOTLB invalidation command list:
> >   Intel: The Nesting domain. The command list has to be broken up per
> >          (vDomain-ID,PASID) and that batch delivered to the single
> > 	nesting domain. Kernel ignores vDomain-ID/PASID and just
> > 	invalidates whatever the nesting domain is actually attached to
> 
> this is what we are doing in current series[1]. is it?

I think so

> > So.. In short.. Invalidation is a PITA. The idea is the same but
> > annoying little details interfere with actually having a compltely
> > common API here. IMHO the uAPI in this series is fine. It will support
> > Intel invalidation and non-ATC invalidation on AMD/ARM. It should be
> > setup to allow that the target domain object can be any HWPT.
> 
> This HWPT is still nested domain. Is it? But it can represent a guest I/O
> page table (VT-d), guest CD table (ARM), guest CR3 Table (AMD, it seems to
> be a set of guest CR3 table pointers). May ARM and AMD guys keep me honest
> here.

I was thinking ARM would not want to use a nested domain because
really the invalidation is global to the entire nesting parent.

But, there is an issue with that - the nesting parent could be
attached to multiple iommu instances but we only want to invalidate a
single instance. 

However, specifying the nesting domain instead, and restricting the
nesting domain to be single-instance would provide the kernel enough
information without providing weird new APIs. So maybe it is best to
just make everything use the nesting domain even if it is somewhat
semantically weird on arm.

> The Intel guest I/O page table case may be the simplest as userspace only
> needs to provide the HWPT ID and the affected ranges for invalidating. As
> mentioned above, kernel will find out the attached device/pasid and
> invalidating cache with the device/pasid. For ARM and AMD case, extra
> information is needed. Am I getting you correct?

Yes
 
> > Thus next steps:
> >   - Respin this and lets focus on Intel only (this will be tough for
> >     the holidays, but if it is available I will try)
> 
> I've respinned the iommufd cache invalidation part with the change to
> report error_code/error_data per invalidation entry. yet still busy on
> making Intel VTd part to report the error_code. Besides, I didn't see
> other respin needed for Intel VT-d invalidation. If I missed thing, please
> do let me know.:)

Lets see

Jason

