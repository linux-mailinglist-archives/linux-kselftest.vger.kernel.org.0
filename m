Return-Path: <linux-kselftest+bounces-18739-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A7498BE42
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 15:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF0A71C231EA
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 13:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6601F1C231C;
	Tue,  1 Oct 2024 13:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rw90CeT2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA42017FD;
	Tue,  1 Oct 2024 13:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727790387; cv=fail; b=fuNs8YFmbcn2bUDaONoYKhfEFcGr3g+xusRvRdRH072CnPmWlS2NiNOo6kgrbbOiIIp5nhddnCRu9quCHRj67trFEAC6mWF9GX2lBPXsuVL0TY8AVDrUnFdDqAOPz+92BFZqSdkjBXyQxfisEbrhD0pUAMSP4YoUIKgFXPqQtik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727790387; c=relaxed/simple;
	bh=3GWZlbaOImhMSv8guM70fTDOEjjOOSMQ5dR1SR1GCyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tJ7ZBFD+2QdSVMMIfuF1I+G9N0CDz3jD3s1CkQ4hNtbP4FwBKC6mB9/1QPkO9W4yDvCFom4X9WcupS+X7qH1RANte1f0/argf/L5BC38QlC33+rdBIXgsm+dhNUvecssRoBPnRbNLtHgmS1R2SqyjkoqR+xg7j+NDS7+vVTpyuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rw90CeT2; arc=fail smtp.client-ip=40.107.243.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HeJlw5WWOC/srmbmpp6fjamEi7dobDdTp6Ss5ln4ly/sLcIjuer3abS7JeLyqj8k5BhQM/pI7JYJlXWk822Kb1EK+9JOVAkXZyzpD9QVplzqTHJvnC62wmct9y2NzyvIC9bQDONvI6UWkA21qcdbmLFU/1MjHgOpvKoRH5l5/PXd4ZCmSQJ0KzRv8UEAzu98aFuQEsBSqUQ+sS0uNUHts3/V7YWSv6UcXQpatkLwSR12ZCKnflFijGxc89X9ebEf9z5Ch/V7xJyKIbX0e11DSaC1PtFZISe6qwM83Wh8g/v+U1UXZNSeZrYkyvTipYC7D2xKVXHItblODJdp2ocMtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTs/Qmh0P9AjUyTvwStlTS0/KVTtiNlQCHDR8wnbEEQ=;
 b=H5um3rJ6doGD1nsXWyon+UniKTLkHvjQbskIKSDQwJzGTp9M2S+dqmid5sRBxDogY3C6Byy5qm9lK0EuSkmQ/5/UnayWA2c1amZB19c+nIC5zdo2+lGyy0X0hNxWdgb0F+SgMI9oGtS0R88D4O9Hyl7snISLXR8c6gsBMWipWZWbOoHECnrBDrMEwby8Hna3nBFhSOogKGIH/lxWWLwzsfT3eTgPXPXq4I8nRSTBMSNFDuxSzLalb0OdR5pZ6l5y3Ak5e3iAJr5TfO9ZiXhvZ2N+FsyfR7XUjVEPJy8lnJdBd4C8K8oik7bydC6UmjHHRQ+Zxgk9Q0Yv5Se+0puvzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTs/Qmh0P9AjUyTvwStlTS0/KVTtiNlQCHDR8wnbEEQ=;
 b=Rw90CeT2IM6FH0Qd/dCp61NMiw86vcutDVx1iYu/A3QfoTdnoMiONeSTwtgqoqtqOFUPh6TlYFHwxs4p+hFwLv2LnQIt6cDtYVvaFVHELnVo1aqPC2aP3mOU3PMCnovfqNkIEij20wERQYBgxpREbhZB8MoCC6ANpD1V5O4lilqEARV23hx89cMx9WmQT3/OHod/HQYr0fGswNlpCHVKkTD0NjvIhVvYFCNa8WWgtvcvpxu2xy+JzXgh3A8OUHybbMYrznCN2pXQ1Du5qGWJKE4rYwOy2dnNi02EGpo8kSNSu+Q4TxTCPJQD4fL8960zIZhzDv1zm71RO1RN5fk44Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB8772.namprd12.prod.outlook.com (2603:10b6:806:341::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Tue, 1 Oct
 2024 13:46:22 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 13:46:22 +0000
Date: Tue, 1 Oct 2024 10:46:20 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Dan Williams <dan.j.williams@intel.com>, kevin.tian@intel.com,
	will@kernel.org, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
	shuah@kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com
Subject: Re: [PATCH v2 06/19] iommufd/viommu: Add
 IOMMU_VIOMMU_SET/UNSET_VDEV_ID ioctl
Message-ID: <20241001134620.GF1365916@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <6348cc7a72ce9f2ac0e9caf9737e70177a01eb74.1724776335.git.nicolinc@nvidia.com>
 <20240905160353.GP1358970@nvidia.com>
 <ZtnsaWgeuuy7+cJG@nvidia.com>
 <Zvu4rZosYFjCuEC/@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zvu4rZosYFjCuEC/@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR16CA0057.namprd16.prod.outlook.com
 (2603:10b6:208:234::26) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB8772:EE_
X-MS-Office365-Filtering-Correlation-Id: 83979c34-11ec-4bca-8112-08dce21f6f40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+khQ0ah8bcq5ij7Mg8oPrEISu3oE/A9if9UINq57ysjea4r6DXld8irGMs9U?=
 =?us-ascii?Q?A+jYlGcGUaz4BNluBHod0mi6xd6JQZKETEx1Ckfc1W+WXDEa2ftNRgw9YNGb?=
 =?us-ascii?Q?/hSJObllV875U5B80KZ1yDNqSFonRAIr6lkg/h2Etm04nKQjNIxb1n/2Whfa?=
 =?us-ascii?Q?0xS+RB85pDMOsgebQA3awRB8Xrs0JoSi80wi6Wx0n3py6lBCBSxnM6AZwaPB?=
 =?us-ascii?Q?j0ExEKsJjVuNybIelxieqn9u3ghmSURzK4C9WjaJ9Q+hM1D/i8ob48aV+GEZ?=
 =?us-ascii?Q?CeTlNpAFt35JUGmUwRLUz51gnibCFsHyLB0yTIMCaSybkxweybgN/4iHg/XX?=
 =?us-ascii?Q?TvStbOHoKtCmSZP48MQJAOyF8Z8YkCi/q4uJtu6KXv7tL+RamlkhZcgnzObz?=
 =?us-ascii?Q?WFibUw1p6CDNR93WalHRbLPNNddp8GgrYH8Uy8nh17iVatdBzlBes59BVD94?=
 =?us-ascii?Q?0sS11iMr6CQAU5MBCO8LjPv3Br8qKbi52lMAY0qqOC4ymprHfR1SzOneE9JA?=
 =?us-ascii?Q?2ip3rYnSgygtxFhN6zcu8MM8cQ9I5zCEBQZHKWQwYcfOj7p8nlqBqbTK7Z92?=
 =?us-ascii?Q?ZJe3Ms6vS9Gn4YFyq5WGRAe/Dm6Oa2N8ezrTIDqPpWPMt236mh+5ZGDy5VDl?=
 =?us-ascii?Q?oafLB5mLxnp637ST75rdNkreinUCW0CI+swvE0646AVKJfQ8a29enHGXy2Wx?=
 =?us-ascii?Q?wZyB2Nk0rJx4DaQJ13KlD+GwUkA65cJhTMVvH6+6qRWsznSMP2qQbRcGndNF?=
 =?us-ascii?Q?5IXsdS+jJ8sMP4iOVW2f1ccEaZK+A7REoPX9P9KkbGYyrbqPv9NlFvl+9jUc?=
 =?us-ascii?Q?KALxMEaHzaKxSdKOWbUflcU5FvC7HvzAPbdHY+SIKn0m6o6FVVlXqo7eRw+k?=
 =?us-ascii?Q?0xIBzoW5gBULYZnzo3n1r9QQPKglvWcXjWpflswJ6va1liGFpvID9gyPZAnX?=
 =?us-ascii?Q?el/nOmwOIzTtup/m6EFDed3UZrTyI6vJZyA/DHHChA5z1+8ss3m4N/3S09t7?=
 =?us-ascii?Q?NhjXjL0xF7rWlZSAvRTA7PYZfh3SRehytNBECd/G+Ga4mx201YU/6hNDyLAx?=
 =?us-ascii?Q?kG9xMH++6OAM3WLyaClFu8mR+E5z6ujoQ5c2TzE5eLGXsPzNbOagjq7JvtRY?=
 =?us-ascii?Q?hHB1LSeE64I8bOxWx+FIhU2vORfTLuNuPbSY30DLOoumdxHZvacogr0YVFOU?=
 =?us-ascii?Q?SBsNcahNlFJpIqS79O50NPkYZ8Kim/zXn0hlumP0YQ05dfaE2wjpYjrpKU90?=
 =?us-ascii?Q?UEQ66CjSAhl5VWDFUAvnjBoVh607h+8VcAaJHX3+qDoYZ9X7AER+kFmKCfoh?=
 =?us-ascii?Q?jZJELveQyQ3Jr3GD6DCICSqIh2uaM0nKQ6pu29eCi5V1ZA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uW4JE6pITr8WmGYv7pAmmFag5pOHFoSZlehbXyV1wb+1jx4S64aqBdUXxFgp?=
 =?us-ascii?Q?52o/Ar1gNu75tN/5UDKmOh7+yhv/25Ajt8svs+izebOgAICKVK+IN5nyrHD+?=
 =?us-ascii?Q?b3mZhT62aHja8V+QwVVdjl2VtRh3ofmmsZNkav9CtFUPV/eBfWsAl+zC5ymE?=
 =?us-ascii?Q?Dt70DxFB9aTQ/pB7fxWDuVOIqAVBspdwIvbWIItehhpsRxTn9iGWIhkogoLi?=
 =?us-ascii?Q?VIsr36fljw9M3h6T2OuBW37rg2ZpJxSYZRItxStyCWF/Ohscd9+mQ7EbBAHS?=
 =?us-ascii?Q?ylS/FnxNY/FHZda5EP8EjUIrsCaQum1DII1hLKSuEIUT/v0TNJBZxXZzJe45?=
 =?us-ascii?Q?6pJE82e4Zv+LynTzf8MgQliygBG6nj72LpI9WC+l5rZ/Mzaeg+C6X7+nrgNd?=
 =?us-ascii?Q?S1RjyEhLfIhtZvvtp4U8puT7I0ClNIggphuGsdUVJhDUATZOlm5cmcGZE7Vr?=
 =?us-ascii?Q?3fI9ZdgyZ4FDiwJAfv+On+Ukx8se9Ni/ouZOkXIXlEK+/AkMEQ5QbRY8WSRH?=
 =?us-ascii?Q?fHRKwFdXnHLODpQmmf5oJ9SBAyar7q0lJACPpW+hW8eQNNrIP+4MVktJwg84?=
 =?us-ascii?Q?ZQa1YUOa9VOiykwGpj6Yc7qQmHUtsdtUk3TWz+IRvKhkSrZ3x04AL+mXxOiD?=
 =?us-ascii?Q?SDCXAKSZmfpxHFE9RbYazc0L8vwmyYmAsBokqM7Yoc5mVkI2lk2TqNAgp2Xl?=
 =?us-ascii?Q?Z3u1Xn/5ahtpeV1EqSf4HFdYwzWQ8foH8UQfkTvPxmRs6C9dGhUzxcvyPZJu?=
 =?us-ascii?Q?SEC0zTfhv7ksiMfkskR3FIdOSfZCwsOLP4sUUMK5dQPgVQHPxRYePNXTV5P5?=
 =?us-ascii?Q?mC2nbHfRkFjrg0haEWAAxxDTb7mPIvmqEQh+zaY5j2IDkAiLYeyi0Sx9MrGJ?=
 =?us-ascii?Q?SXoaKQpTdZwctgsoH5tmN/KtndW/ZhVqTcpjhkS1aubQjQ5SnbILdB3VIFFy?=
 =?us-ascii?Q?DinhF9lDBbicG1voazXvv6KcEbsWlRAE3VofSFOD3C3QM779HR/IZlhopnzs?=
 =?us-ascii?Q?c4h90h9+Jrgi1+4s5iRL1iF76DZkRPTEq5d8dOFdEU8M0in6t7aH1jypuJEa?=
 =?us-ascii?Q?G6uiiu1npkHFxm5dOM8ZgnrnEtePK8XFdpE3ENwy0KRWAZkol43kusTQ83Rx?=
 =?us-ascii?Q?CGbzySCf0kfAil0HgHQlzW8YhUEdQGulb/Y8wS310ihMv9A/Q40p+7PpUS7C?=
 =?us-ascii?Q?c6WeQM9DAgOibJApTpmD2r48qU/z/iT8a3p7I9hW1Ns7yrXbQGym80ChrFrC?=
 =?us-ascii?Q?z0IjKjfxrQ/Rzk9zG4NXwkx34xpev3THREEbfikESG5oFEaptHX3BT69QHcT?=
 =?us-ascii?Q?WIAOUTvx4fbnWViaPTfRQbi0grponyJm83J5/N5mRYkhrUpUqVY0qx1B0oPD?=
 =?us-ascii?Q?ATcTcBTBgQ9GU24IRZ2Us1b5mdQVXHqZPL1LP+WOGPJZZagopOkSLPJ6qOYQ?=
 =?us-ascii?Q?wo4sfdYYtnhLzMcZfHTcKem7XVMWhBUqlZ8HuSqbJrvTzKCAYOcu3hTG5kdG?=
 =?us-ascii?Q?hA329HJnoNPLndIUeCdAYsdu8wMTuj8rclbssnEVWW/JQGD0OVFSoC9/Xoo3?=
 =?us-ascii?Q?F3fzQuqm/W7OXkkpBZ0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83979c34-11ec-4bca-8112-08dce21f6f40
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 13:46:22.2358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jLnykIV1zgwqv8Mw5z3K1VzWMGfQDU+DdlLSqXjZ5aDOEr6m7xlacQ3pU9w79RhE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8772

On Tue, Oct 01, 2024 at 01:54:05AM -0700, Nicolin Chen wrote:
> On Thu, Sep 05, 2024 at 10:38:23AM -0700, Nicolin Chen wrote:
> > On Thu, Sep 05, 2024 at 01:03:53PM -0300, Jason Gunthorpe wrote:
> > > On Tue, Aug 27, 2024 at 09:59:43AM -0700, Nicolin Chen wrote:
> > > > Introduce a pair of new ioctls to set/unset a per-viommu virtual device id
> > > > that should be linked to a physical device id via an idev pointer.
> > > 
> > > Given some of the other discussions around CC I suspect we should
> > > rename these to 'create/destroy virtual device' with an eye that
> > > eventually they would be extended like other ops with per-CC platform
> > > data.
> > > 
> > > ie this would be the interface to tell the CC trusted world that a
> > > secure device is being added to a VM with some additional flags..
> > > 
> > > Right now it only conveys the vRID parameter of the virtual device
> > > being created.
> > >
> > > A following question is if these objects should have their own IDs in
> > > the iommufd space too, and then unset is not unset but just a normal
> > > destroy object. If so then the thing you put in the ids xarray would
> > > also just be a normal object struct.
> 
> I found that adding it as a new object makes things a lot of easier
> since a vdevice can take refcounts of both viommu and idev. So both
> destroy() callbacks wouldn't be bothered.
> 
> While confirming if I am missing something from the review comments,
> I am not quite sure what is "the thing you put in the ids xarray"..
> I only added a vRID xarray per viommu, yet that doesn't seem to be
> able to merge into the normal object struct. Mind elaborating?

I would think to point the vRID xarray directly to the new iommufd
vdevice object

Jason

