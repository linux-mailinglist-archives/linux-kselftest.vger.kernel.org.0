Return-Path: <linux-kselftest+bounces-3146-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B458830643
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 13:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBB85285C8D
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 12:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F341EB21;
	Wed, 17 Jan 2024 12:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S+r25kXy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2065.outbound.protection.outlook.com [40.107.102.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D121EA78;
	Wed, 17 Jan 2024 12:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705496190; cv=fail; b=m55zW9/v0I3DOBr3CjeyQzhIZluaeUBURpu6iCJrOslINjTMOnrtCNyQQLpDOEAVKWKDuKgYQNyUp9AZAnl2EfIR2Ttr4Kt0rZpccl9LyPikJNQ4wEA6KI5O1qTfimxX/ZDJ/I4QdmbeulcGCefn8b8i6xrH0JMGC8GoxgJhe8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705496190; c=relaxed/simple;
	bh=KoDD4llfu78nlxn5vut/+6nKX7wTa5EBiBRiLYCud9w=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=nPt3LZ/3+r+rKEGdSm4bPbbSCoxVIA39C0m2dSDyr/Vz+H9XBf010v97mf3aZCavyuZqbqDKO/nAz2bis8Q3Bn2S4AvOGG2qNhOpKVm2+TzlCAwQ+nB5abgJaGxArSJ03KwD8be3A+Jgoe4sYnMoNZFOE87LGWOIWn7/hhGI+Wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S+r25kXy; arc=fail smtp.client-ip=40.107.102.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ofqZhqF8UDzVvfgouiyBUKKwPVLC+mWbk9quIXQ9dRwUAVldiJCVheSH3peyN5+ICl66k0gnKnVnNi1/8V1z6JOLF8yIov2ssOwZKsAU3AST2BZqX3rEI+x7iMBskb4Hjg1GoqoD+YPcciB0qwlds3MaSSs3MTb/lAUsDKua13WVuzAyAXnhbahpUo6RoaGjc6BZ7zXpsch97/IdYfPbwDS4Ui0IeJizTJOHUdjKJ+mPyFWR+IbNV6YQdmQAh8T4xfc3YD+2KuFJt2aYGvd0UsB6fT4EN3ifrlbsnZq2Y4ZPn/b6/MdHeKOB3ecFoQT2LsuG1IaIXDFOlOfNo2++2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KoDD4llfu78nlxn5vut/+6nKX7wTa5EBiBRiLYCud9w=;
 b=EpQBStVqYJtzAHNxczYb6ny6/SyNckX7NM1HhsiCODzMRK7f/RPEHCkKzoo20u8sya3z3T26trqwy0879KzdaEGd/0QBn9Cs+OHi6Hni6jnt+YN/R3/9jwB9Tzgt8b5TyxCZ5A36jq0lSow04Rvq4N0JIsxk6IxdZNshNGrNP9QRaKdpovUl9X1pumowUIweUwDChh8IDsXhfFbfcExd1gm3OJ0egBkjBBlCRHjU5kx+GNjwuEjEsxHAPh2S9OhvlOlNA0paLWE5UjENzDYcWHpLmk0OrSCb50tpwWjtjWefusFJ42/+NNQhDdjMyFCOBzDVWVQlIz8EfYzYaPiltg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KoDD4llfu78nlxn5vut/+6nKX7wTa5EBiBRiLYCud9w=;
 b=S+r25kXy1KzOxcuVGMSBuVPZ46vyj2O+Gd96yZ0T1rqS4cT5d7oB4vE0l4GPcP/U3nOV2XZ+Ra0utaeBrnvYSnveU7lgkem3nLNkBe4b0emx5A1MwyArRgnu6QjHa0Lkt2O+POysAzjc7iSdaPZHzzCGBuiFOfHLDoFMBRxQ6DHoOPGLE+sCrcSjkvsKmGb4zlQUTO0wmr+KnetbATUNBsLBox6SI9PN/huLBnCKm52lLdlv3VUCkvNMGbwUbG0RKownyFeZbKVeVkpGSEOgBd0QtgDfzspXT0IyekFOKKWGEJZEZ5iAat5qYAIp10tOaRZrthvd1S3zOB/NX0cOaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB4934.namprd12.prod.outlook.com (2603:10b6:a03:1db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Wed, 17 Jan
 2024 12:56:26 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7181.020; Wed, 17 Jan 2024
 12:56:26 +0000
Date: Wed, 17 Jan 2024 08:56:25 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
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
Subject: Re: [PATCH 3/8] iommufd: Support attach/replace hwpt per pasid
Message-ID: <20240117125625.GF734935@nvidia.com>
References: <20231127063428.127436-1-yi.l.liu@intel.com>
 <20231127063428.127436-4-yi.l.liu@intel.com>
 <20240115172430.GN734935@nvidia.com>
 <BN9PR11MB52761349DFB5DAD2797C3EBF8C732@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240116125756.GB734935@nvidia.com>
 <BN9PR11MB52763DDDE39C211E761A05168C722@BN9PR11MB5276.namprd11.prod.outlook.com>
 <88e46f6c-4d64-4357-be2a-833797e6de15@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88e46f6c-4d64-4357-be2a-833797e6de15@intel.com>
X-ClientProxiedBy: BL1PR13CA0225.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB4934:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e7feb9f-1aba-4aee-9876-08dc175bb717
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tejRDgVKHFKB+8XnKmyLJ3yobcMxgC8jYiqVR8mrg1vUpQonACFbk/omdLs1MCVcFy5W0vJve+gkxTsBZxpVfS8K7e+fe7Xmp1/mIVhxyvl3eb21/OhYjMUBKAAZsn0A6euXdyWERVzqwt4iD82sRNNYGEJlSVPKJI8W63qEnc58TwcgFnWs81Gc3Yb2ffM1PKkweOpnHo7vFOBENh9mjj1rqTHLN3CMi8HCZ6Pro0GOu+q4qZt04Z8zq549RPaYP7t8rzx0VTi/o0ThkiFvJayY8WjYWMh+hAjBQkicdlzdbD1XHz1/jBmqqca1crAiGgyj6i3ACV/Chz6PkOF5QSQMVToBb/KwGhs2JzxKRhVwJmbuSFa/zMOn2rJUJ5/XADM5G0WXY8JmcFSTf5livyu/athHgzx5tSVWZlfbWEdM8+D/eO+mTGCw6jJHzrMtr58QZ53ZCbY9C+bQubW464CXkw6BL0ZEK8nzY29CNGZBkTzvN9cs4LkShReGPGy0oslSjylni40O/Yld7sbAPjqnu2q2sGJF7spIpAnNVLT4l8Eqtdj8q8Js261vj/43WbYsUdTFm/AyBATICY4459477UyZpx/Y4o4YiRP27Rm6++t34vjZr9di3SPmnxKW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(366004)(396003)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(26005)(1076003)(83380400001)(86362001)(33656002)(36756003)(6506007)(5660300002)(7416002)(8676002)(4326008)(2616005)(6512007)(38100700002)(54906003)(6916009)(66556008)(66946007)(66476007)(316002)(8936002)(6486002)(41300700001)(2906002)(478600001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d43FTabOT0V8ojAC6fhjlKqv5ThPoiGYIyOhnWZVBUDtcsicHoY4nrJXgG0u?=
 =?us-ascii?Q?OTW83G8jeTQ2A3NXC2zYDRZwYZsgvPmqpPj2lLn3/CUrWdr/dADe43O2uZnm?=
 =?us-ascii?Q?MUpAWugtBWz0L2Zxo9qQpdLzjC7AlI+gHFtlTdlzjWxAUJeV8g891whs8bx8?=
 =?us-ascii?Q?gTJV/AuIrf1Fqw4rqM4YPdFvRUtCxllZC9zSxmpkReoBHWpN83B824Q0GB3k?=
 =?us-ascii?Q?tybSaId+ARARITsVyG4SuUZrBiC5WzlU5fRZMDugZXVXWxLAIzO26AKMqPOu?=
 =?us-ascii?Q?sP9XQ9wGdPEDM9p4XYUu9LFQMOgMi4Z9450wm7lBhh7/8vQq7WypANXqffCK?=
 =?us-ascii?Q?67akWyOVUCdwPdzm4zBggZTzFTFSrQjJ9HGT3gKfsp3OKUnOwPB/0ehWI0Tz?=
 =?us-ascii?Q?zOGBkkGLB2HB/GYl0T0mjXZrGPUNUUB0sBxdSDkuNUY5bjiWnCeajHCPawl8?=
 =?us-ascii?Q?F5GnpulqrysVE583F3gbSBLQibOLJimrJIX235J9F+RxshOqwMDIdZmFYmi2?=
 =?us-ascii?Q?zd8wcydP303jfRZ+xNfM+GU4tzfx0LLNG3IxVXhCR/a9noDUTQdJzTiHiNlq?=
 =?us-ascii?Q?ATlEVMVhUPMcGK10tnkrJMFLm9VLHVMX2ZWcxmgkcdPQgaOVwAWSDbACdwzW?=
 =?us-ascii?Q?rlFwqo6y8OkAxYcBf+2gp8G/frqv9tx1nDAOh+Rvr7tP/b342okbUxdAwSlF?=
 =?us-ascii?Q?hTZvuWp+VZonv2UbPLmeueTNvzTMFxPCwogTMcCJtHCEoZClcJc7CTxM7bar?=
 =?us-ascii?Q?VKPublZJnJucctR14U+Yhd7KZIAuj9hcp+dCcLW4jxjwen6bPY5g9jurw6zX?=
 =?us-ascii?Q?gVrerEe93r0qIIU0GCcD98tWdHxB8+4205GbHT0kEU5SLjJ6mqBY6i4Ln6hz?=
 =?us-ascii?Q?wBo0pdmUoqPjldPE3HR/P6nKnQbssEJ7V+tEVQTaNb+tSVFmfan1lPQhSnjN?=
 =?us-ascii?Q?q7MrNPi+lu1UFWVIhdG2+w3QtfXr06fjluzonf3WikkRu1DEXvHWbkXDsD+n?=
 =?us-ascii?Q?c1qeP7SSx0o9j1tLkJ+WQk9JQuZQUWYDxvNNq6GsuqZhUuWlBXkcrAVcY1RH?=
 =?us-ascii?Q?ZB0z/RPPowWJ5rayjn7W2XGvNB3RZEg/qH8dwbdEsKgsIuix1kGvaB9Hdquy?=
 =?us-ascii?Q?NZpYm4xzIT2NgGtVznYeyVHyIzWhjP3DIdd92SBUAnel9oZY2U8V7wvpj+pK?=
 =?us-ascii?Q?GZW2ImWh+9b7M0QGIXbR992xD3hq9lh4Y1CmnwhawQ6moDUpL4dcbVillsba?=
 =?us-ascii?Q?FZjthfcXYZkwHuNjunOEli2UiK6pZdcWEj+KUaMvOc0+249H8ZesiZeGx36g?=
 =?us-ascii?Q?KkI7iXtkHT9bs7/+IhbKiP0hMrHbyiovARXo6qm5SsRP5YSwxvbo8fqzjbwr?=
 =?us-ascii?Q?zvXPeN7vvnD7iftDtxtpTMPP6eH7+tcyOYpG1TJfUwbQVLgpXMaRgvNW1/Xq?=
 =?us-ascii?Q?w+Mxzvj8k3mnuUeo1mk6GgFxr3e38LMrm6Jmb0rdigVg4iZO7Y5fSWU9WeM4?=
 =?us-ascii?Q?zg0Dv+Hu3ik3YcJbBYhWIj/dVqODNwSlJ7LYCzpiRheyUtoTvZf5Cqg400xy?=
 =?us-ascii?Q?9jNJnSRq07uga6onTOQuire6kAV09K7Nw5hJxO0Z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e7feb9f-1aba-4aee-9876-08dc175bb717
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 12:56:26.2018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZzQCauS/ybDS3/zRBs2E0/jpAlM0MODsDGlfh9MSfzpovoOsZNJYPHTxBWVWa0/H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4934

On Wed, Jan 17, 2024 at 04:24:24PM +0800, Yi Liu wrote:
> Above indeed makes more sense if there can be concurrent attach/replace/detach
> on a single pasid. Just have one doubt should we add lock to protect the
> whole attach/replace/detach paths. In the attach/replace path[1] [2], the
> xarray entry is verified firstly, and then updated after returning from
> iommu attach/replace API. It is uneasy to protect the xarray operations only
> with xa_lock as a detach path can acquire xa_lock right after attach/replace
> path checks the xarray. To avoid it, may need a mutex to protect the whole
> attach/replace/detach path to avoid race. Or maybe the attach/replace path
> should mark the corresponding entry as a special state that can block the
> other path like detach until the attach/replace path update the final hwpt to
> the xarray. Is there such state in xarray?

If the caller is not allowed to make concurrent attaches/detaches to
the same pasid then you can document that in a comment, but it is
still better to use xarray in a self-consistent way.

Jason

