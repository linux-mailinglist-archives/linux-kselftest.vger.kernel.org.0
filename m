Return-Path: <linux-kselftest+bounces-342-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFD37F2133
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 00:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58C1528282A
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 23:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16C53AC25;
	Mon, 20 Nov 2023 23:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fgX3BeSv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2079.outbound.protection.outlook.com [40.107.100.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D424C1;
	Mon, 20 Nov 2023 15:04:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/RcysxpdrAaZag9VyciFic8V/67KATr8PXQ1e+QSs07YNb6jM+mdKqknSXOkvd9Jtcj7M48YYiVu+558yAc+lzCM0TAWTHamdPyeJZqGe21bE8M0L6Dq+wa+pfNJM7aad6DciV//VGkympjjm1LUnjmwAkwQPdBpe276Ih7nnonrjK7ZPJCmmOqejid+576F1AkfHlpv7kprY+k/SrEPZKj30ABnHYHotFUfA/7Xon0andZ7TZR62onxB4gSNsfsxfRLD19i5A1A50JPNoR6PV4mMpkm85rSBPT9RUOyETzxclPvYZMOeL+Mw3ZtKGRSf5EBserTbpWYZVuyp7zyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fy/RLVkEEhn5AXPraWWXROUme8GNg0nQ20J4lsejpz8=;
 b=KckO11G8UIS96zfy5EXg3gBjdMPs2SXPbyBS0u16GJLRzLFVPhsL8hfDPlz9QBi6Kxsz2blq8jrCkd94Qn/XZd/Wp55zFYKUqT0lN4y3pFQTNOMYyk6/85fp3fZRBXyb3iddwDplWivXpoSsy8Q50CVuB8N7bnxrXeXfBPJNAKmFzAp3Ip7ei82OecVuE51M0vZG8Rkghuv/MHGPYhwoDYSk2aF+qfCHNZTiSurqnWPnlV0UYlSRmxTVx8VO6ekwEFuWsHwLBR5ZDk4OzgNzAS+4X8G6yUupqrmEN8EMot2WXYt7MwkcRD6LTix0nC/0ioj3gWpn08f4P5W44C0Adw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fy/RLVkEEhn5AXPraWWXROUme8GNg0nQ20J4lsejpz8=;
 b=fgX3BeSvH59VXENYefOBrIYDMOMq8A4fh0/z9TlieSLuvGxdWEK6Rp/EpUWDiCF9qA5zGInyVx5OkUe6IMi9y35VWk6DMOs5McaCvlST5LT4aE09IUBXzaIjRc3poopNLLy2WJn2oGwSg5PMDywb1S6oVXOWjlwAU7djUMVOaxwRCMocxGnSU5ASmpUU+ZJxL0IFs9Th41IdmASHM/u1Xct2DLF/jgIdfCfrPPYeNzBDrqH1Ij+MnwSVzgFs8q+nsjMGelovoBPp9JvgMmsaTjaQ6Yv/iIQXigg3hMGJF/fyA6yx11QRDqcVcKG2Qbr0qefr6oj482G9cnsF/xdGyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6330.namprd12.prod.outlook.com (2603:10b6:208:3e4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 23:04:53 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 23:04:53 +0000
Date: Mon, 20 Nov 2023 19:04:51 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
	"peterx@redhat.com" <peterx@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>,
	"lulu@redhat.com" <lulu@redhat.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
	"Zeng, Xin" <xin.zeng@intel.com>,
	"Zhao, Yan Y" <yan.y.zhao@intel.com>
Subject: Re: [PATCH v7 1/3] iommufd: Add data structure for Intel VT-d
 stage-1 cache invalidation
Message-ID: <20231120230451.GD6083@nvidia.com>
References: <20231117131816.24359-1-yi.l.liu@intel.com>
 <20231117131816.24359-2-yi.l.liu@intel.com>
 <BN9PR11MB52761D7A88BB2F655355A7728CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52761D7A88BB2F655355A7728CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: DS7PR03CA0142.namprd03.prod.outlook.com
 (2603:10b6:5:3b4::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6330:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a681d29-5f57-4df7-d5c1-08dbea1d1b09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	srDN/Ua/+x1TbyoEJEMczf01PyVDqhOWOXhwZ5QLK7/HJjmwtZQVfvJCmt39W7Q1m3GfB2Ie/7qR9EL36vTPDcCGFj4PQqDzFK40+1n4AOBR9M/PDF4UXrN7Kph356gKq4LNNXhCmpTVaIt14I0mThmRwi+cG+Bd7Sfxp4KbaUB1El7/TETPK91fs96YDoSRyOPNXhqyY5tjZwF2i3yqa/az3Qo2wvzqWX4v3ZqtgWGFDpBQnQ9zU72oPLCz1qRjElB97nVBS3o8NKQ5ngBFsXXgkwGkFvvb9XOyNyiX4r6vecyGWB+4sGChO7eUmm+7vGSuWLgP+hVb8u0+HbYFjuOB9Z1wECOhKCYYU7dg/gf5VAsuf20hCIJPr4OyENAk5fGxSz1dcf+CYRBxjsAlWIudHY/dIwPXyyjiC1LgoSsqqePmpiA+KayYFPeORTLcizQvLAcOzgczMCPcG3cj6BBdQpWKqMi2T8Xwf4qdieN2Wt1kkwZULeP4lYoT2tCQ6W81kXquS/vREj6YfhssJqcqnB8BeqqB2604k0HJOaGU4h9IXXcTukoWjgHI6wqb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(39860400002)(346002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(41300700001)(36756003)(5660300002)(86362001)(7416002)(4744005)(33656002)(2906002)(6512007)(1076003)(26005)(2616005)(83380400001)(6486002)(478600001)(6506007)(38100700002)(4326008)(8936002)(66946007)(54906003)(316002)(66556008)(8676002)(66476007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ny01FvjZ+O8Dvujqz8QT0pmwbtk8UMuwCL22cuDOgzvZc6w5e6lFSdPNIuB8?=
 =?us-ascii?Q?faci6gzEBNwArLcS9x+SztW5028SghWuX8dtKjlETANcGbQ+3MjIZ8fYMka7?=
 =?us-ascii?Q?VrYmvcdVVirqtZ1sakYawv7VJ7RQBikNycnCgRGC/q4G2Zh0GoRO1ucjifVe?=
 =?us-ascii?Q?PTM4tpretCwZqE4z8xJyxkGdy3lafa0qJVAxa1xvPh6++HOWBheZkElQcxJt?=
 =?us-ascii?Q?nsuQSf38K25FHu5QzBaqWIILQgM3pT8z/r6Jle6QYfhXQTCW2DLW+ggGZzVs?=
 =?us-ascii?Q?S9WkDoNIUWUNTe5GZaHQ6lR7ysSs9qLjKVAFlY74YPYcg+idQp8SE2l9KfP6?=
 =?us-ascii?Q?s/JwDaMuuBC4Q0hg9HjrEFjZz4MEDitrg/Dh+NP6iL9ggWUSPN3cmb/8vcm9?=
 =?us-ascii?Q?h4tW4aBzfbm2zjvrwt5KD4WG3iof5gfbfgPSrmlZtPIthjZJuahZznjmOFI0?=
 =?us-ascii?Q?/9/dApTJ+QMSjvCJPuC6t3Or+aq92DMM7TWEsUfyVfLG6aXu8jrjaq+PfzJP?=
 =?us-ascii?Q?eYaSGPEhv2xhIv25Kt9WLU86wXYT+GwR3/yQkRx3uWC8IXTd8/s0LcVSmUKL?=
 =?us-ascii?Q?b7u/LXZ4O4/atHiBp/sngQeXKSg7rRfe/b0Sf+NQHg68g3yOFYssFQxgAQxH?=
 =?us-ascii?Q?TnMoEqCZpiK967o7FT/FRerHxyn8lMi9EVYSEAsPiP7WzbYUdDp4Y4KVwugE?=
 =?us-ascii?Q?e0QTPMcXsQt0wO6IeWz4DRn7jPsmnHum4o54n4qYQDFsPO0f0JpCJxkHZeoR?=
 =?us-ascii?Q?1CPCOfltfViHJM7KNypmonNOzZB4QeHitBMAK2dELMX/gqFiQO8OdfIC+GEp?=
 =?us-ascii?Q?H31tPW6c0vrNWomuMkW71zoKHZ/rMmOeLX5OivRJx7xQ3wu3yXkcFrn2TBu1?=
 =?us-ascii?Q?m1b5K2FD3UspobrXogpByMd9MwybXNbZFpxwG0T7S9abRzNLIbkZhPEgNF4x?=
 =?us-ascii?Q?CAr/U5Y5qjCyK8tYXqsc385lQQJifAGs90xSFt/FjgjEtEzQwyvGoHPQvjV0?=
 =?us-ascii?Q?6SQlgMPpVD0GfrVVKUktG3e6fK5iHu6OTnnBtNNMDweqTYao3ZnNrCsSu4sW?=
 =?us-ascii?Q?3MqOUtr4v+8hAPg9Nc6X7rSVPC8C10l+0C8Kp+zkwziOlZPNEWMpz63bT393?=
 =?us-ascii?Q?yEacotRYESNkGxwuQ4F0hGhsiP82P8cSFDJ5xSn17/dYjpyIvQC23U97+UtI?=
 =?us-ascii?Q?yxeHlT/ilzqVRbr+ojD3x8N2YR7WIDUJSITAkPmxxf/lLQpcfMph+cUBlAh6?=
 =?us-ascii?Q?PJQRc3XTRgBrT/9RaJZT6a0efFOH397NTVawQHreSWGSrffNMxqlZnED9MEf?=
 =?us-ascii?Q?PPMaVGpm0iu/x8vGgGyLf/TuZ5Q/Yui+3kp11a4KG6kU6v03Q4GCX1ivzynS?=
 =?us-ascii?Q?/adrseeA0/5RN/tGTKn9LNRovOQewtnFfKPZ2qJLZuXsYswmDRAENvXJqUel?=
 =?us-ascii?Q?hXRp+ZrMSRDeQLRiNomwJiwLU+/QS8xdFAmKCDAN2TmSPoZDQRLnALABajTb?=
 =?us-ascii?Q?WPJVNMHtT/xzqjw++79MEbcuBeYVVyhMbtP15SaIVNm09U848aKnLlp65zts?=
 =?us-ascii?Q?4s/VNjBMPh49buBQE3A8EYZK2Agw1znSypKKPDEC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a681d29-5f57-4df7-d5c1-08dbea1d1b09
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 23:04:53.2964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IKIXqzYKbAchjfsCxaAvoLziro9mtBLAqI28k95vbWKNNMx3AIDKaUyQne/z5zpS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6330

On Mon, Nov 20, 2023 at 08:26:31AM +0000, Tian, Kevin wrote:
> > From: Liu, Yi L <yi.l.liu@intel.com>
> > Sent: Friday, November 17, 2023 9:18 PM
> > 
> > This adds the data structure for flushing iotlb for the nested domain
> > allocated with IOMMU_HWPT_DATA_VTD_S1 type.
> > 
> > This only supports invalidating IOTLB, but no for device-TLB as device-TLB
> > invalidation will be covered automatically in the IOTLB invalidation if the
> > underlying IOMMU driver has enabled ATS for the affected device.
> 
> "no for device-TLB" is misleading. Here just say that cache invalidation
> request applies to both IOTLB and device TLB (if ATS is enabled ...)

I think we should forward the ATS invalidation from the guest too?
That is what ARM and AMD will have to do, can we keep them all
consistent?

I understand Intel keeps track of enough stuff to know what the RIDs
are, but is it necessary to make it different?

Jason

