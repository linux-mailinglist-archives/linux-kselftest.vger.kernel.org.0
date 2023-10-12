Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6697C7666
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Oct 2023 21:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441845AbjJLTJg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Oct 2023 15:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347366AbjJLTJg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Oct 2023 15:09:36 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A290383;
        Thu, 12 Oct 2023 12:09:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QL8gotuqbeRKhGlKssOspplMphVQdt01ecy2/V2cmwwn+XaSJ77EvhMaOg/X7ZmCcHzg51doTuIUhlPCASgQr1g6Lo+A9gGUjKV+nRbXq5UJp3S1dxA8pXyiNyUo9WIqQHZpHtowrUZa8Cj5bIPubn9qdAeGolqm6b6G/HNZ768I+es28gMIG8oFZoL4JSsAIubwykJhZpNN2brXAtuWfvjGWfapv7skubYOfDsPGXnFyVho8r257g8hfvS01L9EvPQK9wDdwEqqyfJpb98KbMc7Z8KrrtOFzEfPMZRz9jcLsirxDpwovy4tz1KnoFzIKoWZGMzpFT4nqvGK+0KHow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xIYjUf+QHjA6R4BQiC8iGALjcWM5zXxcaFHC9cRTASA=;
 b=KWMkpHd/4K2YZpZQAHF01gvNO200MTUOQDh6qlDHLL5g4PMv7sZ8iLdNqIYUqnPwq0EOaHj+YwKYSJqHqg4CpMlvhnQ80q+Dl5NjbdJLSvb442ShcOY6pk3O04FxksXTSPIUp1PZmOnbccUDhQJhMYXpseWS2yfmfxufPXZrk05//4xMCl8T8Ymbz+U+rgZDOjI+f6NQv1K0BkGE9kj0RtH0ZzY+LUlgEDH+qAl1FPCM90jD8XTYP43xeRosUjLnv0CE6qtdYj+11Q8q5xwyjiq+5uddggZ3+x1smy+iRi27ORMl3uSSqvc2NyRcq/ErOjwxnqrRz3C6nESdTm8jZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIYjUf+QHjA6R4BQiC8iGALjcWM5zXxcaFHC9cRTASA=;
 b=t32CEEdBeYFyXQOCuQ7H9O8IDCtaYCXbnLQlYg2mFdH5OehlRb90spDddYSU3jl2SzE/STeDtCYH6e5dVhh9WCvsTnIxj0T/sW5pYKLWWPozhbYvW6fYFUYiFhVJM5jdAaxnUei+KOKpJa0FEae0La7DLl2WnbQpImZlAi2LDxRssPsEepHQMFcfwifk7r9D1d9mhUi2N/70LzoLOlwGeCSPx/F8P4NROLPx06Rsc3MzLeHXiz+VC0mvbE6OlJAOZgP2+WdFtaaNIydWZjjtjrS0CPZcqgY1p7dFuTMK/AEIRt3h3i4iXGDAWYIIDHtcrQIREDmPFSzqPgXP6/Z/WQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB9176.namprd12.prod.outlook.com (2603:10b6:510:2e9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Thu, 12 Oct
 2023 19:09:32 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 19:09:32 +0000
Date:   Thu, 12 Oct 2023 16:09:31 -0300
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
Subject: Re: [PATCH v4 05/17] iommufd: Separate kernel-managed HWPT
 alloc/destroy/abort functions
Message-ID: <20231012190931.GO3952@nvidia.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-6-yi.l.liu@intel.com>
 <20231010184932.GT3952@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010184932.GT3952@nvidia.com>
X-ClientProxiedBy: MN2PR05CA0058.namprd05.prod.outlook.com
 (2603:10b6:208:236::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB9176:EE_
X-MS-Office365-Filtering-Correlation-Id: c5ea6eb3-69a5-4c94-3c7d-08dbcb56c417
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dnuvVl/OadOSqBW4CfUEqX8Qss66CknmOkTXHLd4tu6dA1gSKaIZjRvsHFUcn6IUPdaL2thvaUwvL8ocqSQNSK161U2/Y1MfJrio+jZpPifmKGTayQQD68L6gAlqg2Tmw6TFeHsEhen9y87BNhZB7slxwsqS87Uur1K/vm7ATPdJuxegPpjwrc2DjaGL4ndxrGU7p1fPOtNS7qyDyY5tAK0ed+02O874nvTqY5ZrYo52t94HTin964PX/8OfXWSV4RXEOHU5Xo0OybvXF45n8LzutZegRDG3kHO89vDS47cr3x79QK3I87Wa7ArEt5P72tx/HwhCs+j9ukAiG3khptwXFXq0kuMwNU+HjxC2TXD3GnUTIS3JIl+zChEpz9dGwNjP913uIzXN0FXwrEAuSOcpEbm3P0WIXotEH3uO5299SLp9rTsopTP5afuUiJ0vU1Wd+klCZZYh3zoDjzhXpvARw67zKHSEbDTBDHiqMB+0SdXU4sFgb1a+Sc2VPsHKNcFVUesetqvPWZeaHeXtJHMU+I4pswyuAx1DjD5986SpGPKUaehu//k3r8onOnAq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(136003)(346002)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(26005)(66946007)(86362001)(6486002)(478600001)(6512007)(36756003)(6506007)(33656002)(38100700002)(41300700001)(5660300002)(66476007)(7416002)(2906002)(6916009)(316002)(8676002)(2616005)(1076003)(4326008)(66556008)(8936002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NT9eamY/mDhphzD1vehN45NtM+i4v0T3CVyTc9NrDeMPMEy9RbWSmyL8k4ZK?=
 =?us-ascii?Q?IwPC5peMxHMR2FbHHhrxMUhbm+ecMr69g7IQeVVLuRGqa82p6bE4qH6uSNPS?=
 =?us-ascii?Q?/NbbP76sfRmF6mTUukiSoySBhrDd8lhBsKPeRMqcN3ybbxd+pNgYS05eRBvt?=
 =?us-ascii?Q?GQNJTfZCr0tLVJleqkDDjoujq5Edsyyh5YPitoOxiyphpY3Meh0lamARSL0z?=
 =?us-ascii?Q?ylqOwu1LAayg4YDUXXmo6exM5i8SZ7IJuyYlA7UMIXsEexCzW28LXIUOu0ox?=
 =?us-ascii?Q?xdrhuEq7t1cB7eoPYR2DW0/ZkONKQ2822pThNyVrtNaRP0YtqB3zrUX1iyw8?=
 =?us-ascii?Q?ijnDCW3x5H0eNk+E6NU42kB+gPNBF4+b8zlf8hZ15nTHIWePzVFID56r8BBj?=
 =?us-ascii?Q?V/1Kp0SOUQ8Y1Dnxv9I9eg0egEpiyos4IndfREGXSeLasU8HiePxdRkvLQS6?=
 =?us-ascii?Q?Wzj9ZPPau5zj27HWtcnDxa1ngYShMCE39f8HWXgjLELb68qJaP05enTNh/L1?=
 =?us-ascii?Q?0MXmKKl2irRyimP50FBFOREoeUVROiAAaHJRNT5mL4NxGza2anHC0AQ+dWkC?=
 =?us-ascii?Q?witq0tsBt570penzJfdejuGMCn79x0yBqMohZ0gs9sSexUtKiU76B8vqwxMA?=
 =?us-ascii?Q?znAfuoJIqjz6j0lpJNvt/twBYZDV13LZrsXmk1p95jBY20kRwNLErqryd+S7?=
 =?us-ascii?Q?YlQ88z6x+BPk+oVJ82d4XgsqGyLWsrq8CEThC/EmVul6oYI7C57VYHctWccT?=
 =?us-ascii?Q?ru8rE/qSiztIyyqulq9L+irJX2TzqAMha/yUFtTgto6Jnn3AFSN4LSjs88mf?=
 =?us-ascii?Q?kMDqe7SRm47eO0o54pSv4/oz2lxWOterhoWsKrgdc/eviSeSSMdNbrj1U0H3?=
 =?us-ascii?Q?iKJ7kV+qjNrX+bBf7VacbK5zZY34yK3zjZMAqF0px/Wx1gZeFFOZBLubqXNX?=
 =?us-ascii?Q?n2VHd1gB26bSKLOmIRgqACV7OKl6tMX+zc6WVkX0lP/a3q8KpXczWTsgK/+2?=
 =?us-ascii?Q?c1MmmRlApAquROrmwQQxMxkV/JvYOxIHAbWzoeHQ3/F++zNhSiTvvWYwVusE?=
 =?us-ascii?Q?+AUzDH3tD7bw09YFwRu9f60HZFNBisFP9xhfS/gwcQgGsyWeKz6sXwATurdo?=
 =?us-ascii?Q?k/qajq3phkuU/3D4xHgBj4savOaAOppozMgLfYyWvBsZBdpUYuv8O/Sf5dXA?=
 =?us-ascii?Q?7YX6OM2flpCL6tSTuAS87Ggtx6onUjTFbmmIz4ndR9JOyjD7lUPbsxViXVQV?=
 =?us-ascii?Q?h65/LfeFKkuj6dewqtSY1TYD8q3iL4rWMaqdfRhk+mok6UTCJEy6fiMsjVOU?=
 =?us-ascii?Q?bC0laCKgzJPnF68/wsr5vRgHvCFtJcLCo7HtVasN+H/g7vZfnx74bK0yhoLG?=
 =?us-ascii?Q?DiBAq/PpaTgSf6Kniwhp6O6vsS4lKXSIu1wVerLf83FekZFfMqp909Niiuv3?=
 =?us-ascii?Q?CYI1lK3ysE/VIBfJZttt6MhLKFY75wdXsniE2G1PRyL1DzYCHvDm3F7kqDxC?=
 =?us-ascii?Q?QkXwwVqzRLMpEX54DzR9V7S/gLQqXpWACo2W1563J92iLM9YVONeSVgjatWS?=
 =?us-ascii?Q?AbSEX0OWfDzdddB1064IRjFUExsWMZEL52I1yXxu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ea6eb3-69a5-4c94-3c7d-08dbcb56c417
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 19:09:32.2381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jPGbKjVhfdjcPtr+JrGICoIYSaPHvZC0mgxYp5KiVVDuyizn3akpyZbnoDaz7vI8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9176
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 10, 2023 at 03:49:32PM -0300, Jason Gunthorpe wrote:
> > diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> > index 1d3b1a74e854..3e89c3d530f3 100644
> > --- a/drivers/iommu/iommufd/iommufd_private.h
> > +++ b/drivers/iommu/iommufd/iommufd_private.h
> > @@ -234,6 +234,9 @@ struct iommufd_hw_pagetable {
> >  	struct iommufd_object obj;
> >  	struct iommu_domain *domain;
> >  
> > +	void (*abort)(struct iommufd_object *obj);
> > +	void (*destroy)(struct iommufd_object *obj);
> > +
> >  	union {
> >  		struct { /* kernel-managed */
> >  			struct iommufd_ioas *ioas;
> 
> I think if you are doing this you are trying too hard to share the
> struct.. Defaintely want to avoid function pointers in general, and
> function pointers in a writable struct in particular.

I looked at this for a while and I do still have the feeling that
probably two structs and even two type IDs is probably a cleaner
design.

Like this:

// Or maybe use obj.type ?
enum iommufd_hw_pagetable_type {
	IOMMUFD_HWPT_PAGING,
	IOMMUFD_HWPT_NESTED,
};

struct iommufd_hw_pagetable_common {
	struct iommufd_object obj;
	struct iommu_domain *domain;
	enum iommufd_hw_pagetable_type type;
};

struct iommufd_hw_pagetable {
	struct iommufd_hw_pagetable_common common;
	struct iommufd_ioas *ioas;
	bool auto_domain : 1;
	bool enforce_cache_coherency : 1;
	bool msi_cookie : 1;
	/* Head at iommufd_ioas::hwpt_list */
	struct list_head hwpt_item;
};

struct iommufd_hw_pagetable_nested {
	struct iommufd_hw_pagetable_common common;
	// ??
};

I poked at it in an editor for a bit and it was looking OK but
requires breaking up a bunch of functions then I ran out of time

Also, we probably should feed enforce_cache_coherency through the
alloc_hwpt uapi and not try to autodetect it..

Jason
