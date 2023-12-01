Return-Path: <linux-kselftest+bounces-960-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2003800B4C
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 13:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52DB52813B9
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 12:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A2325543;
	Fri,  1 Dec 2023 12:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j/xi5Ru/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2057.outbound.protection.outlook.com [40.107.101.57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F3091;
	Fri,  1 Dec 2023 04:55:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EEpFcH6ineAx8EIbTDqaERvZuh2AH512q5R3qIPOtnpbF+MTr4autZrn99NmzmYK9x/q4PFqpU2nZYFi+2Cg7bt2lkZSYI1GQkrUNGa9SlRjWI3YA3S1/o7xMS7MhOrzAvQu/I9xfiLOSvb0et6nqojhUCjt5KTh/nee1ql1VKbPMrq0nXZ5Nsmjau5XRAIwQkmr6SdbKUOBrnKq6Lq3n+CiEdmH+cZFqGsnNhtb6Y8ptPErA/7aVMShKe69coiQqb9Q0+Fv0Ewk6a4PuFmydmBrLfDhDFkFLeOikGp2VUwbygB2dmJsMDiYZADc3/wA9HTOps7qDISRTyDlRpoOJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9brPDbBrTZeraQwpu1L7QVYslCLELEMD4eYfQti6JQ=;
 b=E6ZHPsOphB1ncpgpLsDqSwqMMMRcWIHmqjAX7W2Rhz+16xYMFHD1PmbY3Swf+ubzlRCzaxNh3cTZHqmjHvM/sEwM1ax8BBccpt/WLJOTiCJHUdjQxQn8+YVEbhmMezlqBLs5X94Gy7EVpCE1tuHAmUeHuNdp05QwC5CmSZEg44cr08EEmb07Zz2a/tqKkyha2BdFtKYIIyVx/5s3flEYPyCW/5J7U+hSzk+p5BAMLI6M8LuLxPEA6ZhLj6bqyFrDXuCd0ky5JlnNKMwH394aSvUXZwBlwoQRLoVigHRAQ5Tw/LHKBAjwxCYQMJ0jarhlwrgI9a38tTMcjx1zxYJ/Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9brPDbBrTZeraQwpu1L7QVYslCLELEMD4eYfQti6JQ=;
 b=j/xi5Ru/wV3tl5dHCH+xCgE/u7oQBZKBOO/L7pPW7uuv/1j/113lm6ylefd1vU0dy5E7Qy4SSKpk5wkT+gtNCddhGmVPgOi04lzrWQCSD4CPRp1CI9Ug8QQ0mflKz9JD7QSu5cExu/HTnlE6AI4TMoF+KUxQ2OFYByqMHV40Gx0IFTqtWYvEmJ+D0rZSX30I7b5JnfRr5I3x1DRP7WOHHsEzdLRlbyhv3hYMqcSRHMXb+xV7zHgtSoGdpnD2GliFx1MeO3Xs0iEFlfPNkO4b22uR8zGDS/ds5mPvjWMeSwCp1NM4i45BHESRjUKJnSe6rK1/ND0IYglTpaWTwPs7Mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7936.namprd12.prod.outlook.com (2603:10b6:806:347::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Fri, 1 Dec
 2023 12:55:40 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.027; Fri, 1 Dec 2023
 12:55:39 +0000
Date: Fri, 1 Dec 2023 08:55:38 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
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
Subject: Re: [PATCH v6 2/6] iommufd: Add IOMMU_HWPT_INVALIDATE
Message-ID: <20231201125538.GK1389974@nvidia.com>
References: <BN9PR11MB5276FD60A0EDF8E3F231FCC88CBCA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZWaLCSAMIOXTlghk@Asurada-Nvidia>
 <20231129005715.GS436702@nvidia.com>
 <ZWaPM4p7yjJ0sEKk@Asurada-Nvidia>
 <20231129195804.GF436702@nvidia.com>
 <ZWe2PvatTkkyNCY5@Asurada-Nvidia>
 <20231130000816.GB1389974@nvidia.com>
 <ZWjzcEAAg8ptVH4A@Asurada-Nvidia>
 <20231201004523.GJ1389974@nvidia.com>
 <ZWlhLk3JVwX0hRt/@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWlhLk3JVwX0hRt/@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR07CA0022.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7936:EE_
X-MS-Office365-Filtering-Correlation-Id: 356c53a2-2503-4f5e-2194-08dbf26cd194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gsbYIrVqKmCwOpJHMICsL9kdYOawqjEpp/t7MccEvytJUk9QeIH4OO++L+kr9ztPAK8pnfm77E0UkaBzzrNS06qHmzcWxD3Zey8PoFLGlLlsepmmkSwBz9bBnZz5nCkE1HhKzxAk6YQYiKRigyZF11/3WVJNVBCVC53hYXQ3sIFKdPeRgGDMIS8H88smRlfuonqBsXy16eqpNwX9VzaQWUi3vQui0TqH1aZRiL6RlQWfy5Jiw1e5AylK4pCNd+kGvCC+Py/o4CU55YG9BROvOmkPBmLwQQDSMzW+R2TmMer9u+un6PP2Wy6xfDUNqu+iS8/zGfTzxpOohJFo/688TBRzmbwkJzpArMZeaI9wPv9hRg81RfXd1AGxNl15xWxwjA0YXKHRnnlyVOTdE4uC0iX6fagsbrXKVGr0TZRFxF9ShE7Mpemu0zIjrrfavqatcYJ+xSLmH8wPdBhkQPTIoZNfotvUWSIenPsFnUZLDyvqSKEUZYMKy9Mgl5M3riyytU6AEE64021oolmBtjszt4SCNSiO6k74RAesAqXyU6O/yl5W3z1p7jWMBswbK2q8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(66556008)(8676002)(6862004)(8936002)(37006003)(66476007)(316002)(66946007)(4326008)(6486002)(86362001)(41300700001)(36756003)(478600001)(54906003)(6636002)(7416002)(5660300002)(2906002)(33656002)(38100700002)(2616005)(1076003)(6512007)(6506007)(83380400001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e1O9J4d2pew4P3gOPbBf3DVsVTIPwL2eao2hKr6BXQMYNEI9ZKPIHpBoE3DU?=
 =?us-ascii?Q?t/PMALcIWZJ93wf6uo5a5R/G2LTKQ8UNoFKJYs2ASxGPKgxd2BY9ju2nk4aB?=
 =?us-ascii?Q?FAfao+kroEjuS0dJfV/y7NZei8xmqmQllepeGUJFY7ryh8dSwkDBTxiqH14e?=
 =?us-ascii?Q?cUR3YQpw/yejWGtGoOfJij0NrDFpNbXhs73VXeBeur8vERDSxSFeRLsGND7D?=
 =?us-ascii?Q?skgSwtMh0kFCBEPMk6/oNC9hFHR9AEcL3oFDY3DpUaY2YJPJG4wgMDaKv/0f?=
 =?us-ascii?Q?SKd9aseNIrTxb17vmmZKg8E9O2VQxLC1CWIjMTEnaBkccHGcHevFr7AHwnwS?=
 =?us-ascii?Q?CA0AptLZKveWy90RpWQCojfFiDyntNJ2/kz5p24H6DXhxcJdIQQgGW1/tR14?=
 =?us-ascii?Q?t0NtZAPevUMCWeqWmwLsOvSevSWhfPPpTfPEFBMMMiVlWp71eqNIbKCcmSN8?=
 =?us-ascii?Q?uJe4ufcvpWbYmOGtUPkqPkz31RqFEIkK0AZyPzFnPHWqS9xu3zygkSOH0XNt?=
 =?us-ascii?Q?jjppHYwMYpWlA3L6KPnAR+2+Y9gSihGlt2PXclAJ6WW1+RVo9XS3jEZFFGFE?=
 =?us-ascii?Q?CHGZzs/twPAu+0JKdhaGT5zZ+tU1r8q3vpqZ7WD/oURIcHwvUWzmWIPbWCM7?=
 =?us-ascii?Q?QPVAI080hP4rQqHPKOpw7OoN6ITFL7fmD580pu+zAUwcziz2zJVu8V5C3ZLF?=
 =?us-ascii?Q?V/d0m8gXhEGU4NfkU4w5hSf7xtHeGQPrZT1fKRtZWcdaCiHEke0JQrzSjld9?=
 =?us-ascii?Q?JaoB7TeVl9flunKrv+WTb7ZQiV6qpietdeze8XEqJwWaD3trldmhoTb/qwPa?=
 =?us-ascii?Q?3foGuaER/E/4+Uwt+g2DTvBEbX0E9BnyoQNFniuFyc/7qNJ1VaZHogfjjILF?=
 =?us-ascii?Q?8FR0tI0XxDGZHRS6ngKZa5N4A3Lw2LQdnyFZ0OPSDBPcuQM0R6S1Kym6iVIV?=
 =?us-ascii?Q?ImGizmAPiUN+xzDwLSp+kgXwXb3DdPIXiH62yRYPxBSIAQ3XZOO5Qx5gD+eP?=
 =?us-ascii?Q?jgwtQOVeJ9PphXbH6n+uzoylAinPKa2vQ6BNQlYd0J8atNN+qY87IMGwjnAh?=
 =?us-ascii?Q?50fadkpkEtIyxwb56QH23jwdFU3bcv87GsWJU3RTvtcVbfwEaIz2JZgTyyuE?=
 =?us-ascii?Q?zW7n10soQzmGq4c1t6aJQRccY/2NV2yBTQOu0pFhO6te99+yLz8WW9kuRyms?=
 =?us-ascii?Q?JQZReWpaaD+PlVs0wtFmioI6ccoKNsByPVwemrGx3qg8SIaK+aov8pj0i9OB?=
 =?us-ascii?Q?OtqbWtHyEa+io04J2FWYNLcBGxJEqM1m66C+fDOKqG5CDaYdkBOaMMtQuA4D?=
 =?us-ascii?Q?UGgiG1Bg+nSjPsYSDYNHbFb/7OtiDcxuJv0KwZfd30DngGdGbu7vJe8Nkd8Q?=
 =?us-ascii?Q?67aXt/swtTGydWQ8axWqj0Vwjb59aAe8yhA3rPD0fxg/LEPiME8qeN5t30S8?=
 =?us-ascii?Q?gCzwy0yfiOtL0aeDFGZ8xhzp/2Yyy+iHDmtAtGkamEjs+gRKt7MurRUhyKZx?=
 =?us-ascii?Q?qOVZc6sD+18ETdVtrJBtH2FBVgKpwK8Ci2b7ZNR+ILieE4PxBnWpkqwSoPD/?=
 =?us-ascii?Q?boImrxqh/VbxaBZ1woUB1XpvwQrlrZu5jQmT5wOD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 356c53a2-2503-4f5e-2194-08dbf26cd194
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 12:55:39.1019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kYIYY0hxlU4d8Cc3iHCGF1T0KvuCIQeQZRfT/66dLBsSPHt52Uahb6xLJlZJVE/8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7936

On Thu, Nov 30, 2023 at 08:29:34PM -0800, Nicolin Chen wrote:
> On Thu, Nov 30, 2023 at 08:45:23PM -0400, Jason Gunthorpe wrote:
> > On Thu, Nov 30, 2023 at 12:41:20PM -0800, Nicolin Chen wrote:
> > 
> > > > So userspace would have to read the event FD
> > > > before returning to be correct?
> > > > 
> > > > Maybe the kernel can somehow return a flag to indicate the event fd
> > > > has data in it?
> > > > 
> > > > If yes then all errors would flow through the event fd?
> > > 
> > > I think it'd be nicer to return an immediate error to stop guest
> > > CMDQ to raise a fault there accordingly, similar to returning a
> > > -EIO for a bad STE in your SMMU part-3 series.
> > > 
> > > If the "return a flag" is an errno of the ioctl, it could work by
> > > reading from a separate memory that belongs to the event fd. Yet,
> > > in this case, an eventfd signal (assuming there is one to trigger
> > > VMM's fault handler) becomes unnecessary, since the invalidation
> > > ioctl is already handling it?
> > 
> > My concern is how does all this fit together and do we push the right
> > things to the right places in the right order when an error occurs.
> > 
> > I did not study the spec carefully to see what exactly is supposed to
> > happen here, and I don't see things in Linux that make me think it
> > particularly cares..
> > 
> > ie Linux doesn't seem like it will know that an async event was even
> > triggered while processing the sync to generate an EIO. It looks like
> > it just gets ETIMEDOUT? Presumably we should be checking the event
> > queue to detect a pushed error?
> > 
> > It is worth understanding if the spec has language that requires
> > certain order so we can try to follow it.
> 
> Oh, I replied one misinformation previously. Actually eventq
> doesn't report a CERROR. The global error interrupt does.
> 
> 7.1 has that sequence: 1) CMDQ stops 2) Log current index
> to the CONS register 3) Log error code to the CONS register
> 4) Set bit-0 "CMDQ error" of GERROR register to rise an irq.

Which triggers some async mechanism that seems to restart the command
queue and convert the error into a printk.

It seems there is not a simple way to realize this error back to
userspace since we can't block the global command queue and we proceed
to complete commands that the real HW would not have completed.

To actually emulate this the gerror handler would have to capture all
the necessary registers, return them back to the thread doing
invalidate_user and all of that would have to return back to userspace
to go into the virtual version of all the same registers.

Yes, it can be synchronous it seems, but we don't have any
infrastructure in the driver to do this.

Given this is pretty niche maybe we just don't support error
forwarding and simply ensure it could be added to the uapi later?

Jason

