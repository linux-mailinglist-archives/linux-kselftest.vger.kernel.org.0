Return-Path: <linux-kselftest+bounces-19016-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B29990237
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 13:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC1D31F225D4
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 11:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89D015958A;
	Fri,  4 Oct 2024 11:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ICHz3/0z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C819157487;
	Fri,  4 Oct 2024 11:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728042112; cv=fail; b=cEaYI1tHL2skxxPNDWvo7RrnVBbugM0vQkPE8ONnxFtLjV0hJgcpKZeiaiefOv46kmvMcvNSUuN4NoCpcHVECPdo4BvJMq5dvuOF+Jpw7Tz+moXZRxa24viFCv6m0aMIzOmKVdpcJU5Etv/dkHPHH8ujFqUNvZ9tK7WOMye0O4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728042112; c=relaxed/simple;
	bh=Gp1nVhvd6vaev/BaFrDo4WZw0CzR3eE8K2JwzapjQ+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XPVzbQGqjgtO5pVtOOQnCmFIBO2Hi7g3ncmaD7vk8HOYjIX1uiy/Bw4MB5SOvToPnTl1RUobrE9z9pbZuJZ9iOiifjNg/CUvKEZqYhpKht89Gz5rri8aACLazLHuUTow+FqsxKBAZFeSRsbQ9fsBvSrbRMdjVMrKWzbTt3omsBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ICHz3/0z; arc=fail smtp.client-ip=40.107.244.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xDjXp5ISSpVdwr7UxTOnBtfLtlsD9THfbYJJAGgrWB4cnn+g2/qk3sQ2TDjCTMskZDMQt9fq45RapgvZ76OHi4ZAFEG6QjpyAV344yYzMYn1hEprfkSxdd1JiMe3ajtCQRW3m4SlSwuWe42HhW919v/sY4ZW/MotSlS/hvU8eA//56KvDzue2JMuujQJVSU37TamrfJ3F0j4wZN506rkVw32ev0ao/iuDl8m/RYKVnmrkcsscXuTiVncihX+aWwQK+J0uFGMg2e5EZhagdD5ikavNW3L+FZc9iVy63bjv2xwU9PrH7mBdPTe3WX8NB/3d23jyL3RGGQxpscsziMMzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCv6+G7n5mtC9z8h/0YGTOeRfn17AcNDDRxLurkMaeA=;
 b=NU7UMSGUDaNQyZtMiVCaGXPlDsmHDDae5W4fftsJmDI59SDj1WBXD6pLKIabn88BI1CzD0i2HhxmPcDWue1h2AwtiUZf0Km0+v5RCpu8F+5GeG//DO56PCaMfZmoZ7TgrfV7EAUnhSjbx4yjYpfLozSYfs52/dvMlTvcDKfXA8VmQGQYwsU53lzOWf+H1nuEuq0Y1OM4Pz8xafZfS/dzlWInfjSTuJww83AqHHpPxunHopGx7AXYuEPEZKHj1Sa2kvDwaQjOM8xojXP4+bRcq3OTHSi259TBdxD5cwKLjEi1hRxbcdB+DupT7gIuvgCwmzF/CgcTrY/xHdu5kn0hnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCv6+G7n5mtC9z8h/0YGTOeRfn17AcNDDRxLurkMaeA=;
 b=ICHz3/0zFjOXaiZMIWqySdK0onUPRe9nIaO3vwAf6tRd1BciaLiV4NgiFNw/FV9ZVzK0gpc+RAb8YdOkZdEJMS4h7wEaB4uJiwt/K2fGSjsmbqjEt4ZBikh8e0mOSofYXrEMaKJDLlPG6hbi7X6D/+5HmVSRWQ8uJpSrVRdo4z03yWmTlJJsYzTPqkg1A1xdWIz3XGBZz4oxI1/pZwEkdXvT8KGsVr6KJHNKFg6yhJayrH6Ot9G9AqcyPEfJXELHFTt4hPMZjBjf+XcKFDy90Wc6wC/Se2go6p4XtHurVmjePLHiOcBiB+hVFYG8Rt/WUmsAboy/BWBf1lo6lFjHXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB6167.namprd12.prod.outlook.com (2603:10b6:8:98::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.29; Fri, 4 Oct
 2024 11:41:48 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 11:41:48 +0000
Date: Fri, 4 Oct 2024 08:41:47 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
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
Message-ID: <20241004114147.GF1365916@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <6348cc7a72ce9f2ac0e9caf9737e70177a01eb74.1724776335.git.nicolinc@nvidia.com>
 <35701c5e-030a-4f52-b6f6-ed18368fb2cd@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35701c5e-030a-4f52-b6f6-ed18368fb2cd@amd.com>
X-ClientProxiedBy: BLAPR03CA0084.namprd03.prod.outlook.com
 (2603:10b6:208:329::29) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB6167:EE_
X-MS-Office365-Filtering-Correlation-Id: 56ef115f-e99c-489a-587b-08dce46987a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qUBDRtdJGLIcxC2jF0oUMQ6mUN1w6H+KLbQPk7ZmAweOgDaMFL5qAbWqF77h?=
 =?us-ascii?Q?ALvzS5ZTh3KNikUKos1nYhSU06X/8t8McCouIna1Rh7mBn8pAVdDkK5Kz1aT?=
 =?us-ascii?Q?Zd6wUmu56B0OX64oWLTli/fUxSvKnEsaPeOvuJWMydCJg4ZZ9rDkTRbq9EIF?=
 =?us-ascii?Q?JYbQHtLojGndn8vyQoAL1MeQ16n12TI16GcsUBKa6ZFQuvAoXDGQuXEAHjVh?=
 =?us-ascii?Q?ZJROXrePfrv213k5o/K53n9F1aC5Qi+fiQjv+p+eN/qIelZAGg+51Jptr4s0?=
 =?us-ascii?Q?bh//pnUHzstHqWuXKxyZChpfNoeHQbxCUCbCzHt8pP91n3Z+ZIkTTq0spDpY?=
 =?us-ascii?Q?8VlLOcUx0VclZ8hx07ZrUG6qtTqs0znxk4DQ/RrFEG2P0cuyqN3j9fXGVe29?=
 =?us-ascii?Q?qTgFzmtS2lY1y2M/dkpniiMwMrLEbbHUHiWaie2AI9GUdzaRUkOd865l6nCv?=
 =?us-ascii?Q?Unr3PCi7CK9ArxZeKHgAs70mT3u55rQXAWnmGzYmHVux/eHC1XPXe4BmYTS8?=
 =?us-ascii?Q?2VZwB8nlnfl9INaJHlU7y8ApAAy8pwoCRL8T4oO4bI8LUL6DqIev5PHNdIwc?=
 =?us-ascii?Q?G3bABUy5njoawZyqJAFKeiD0ljk7dUhlObj6/MVi9QcstxiAdHq980P91Rov?=
 =?us-ascii?Q?nr3EI7YJDWoGwPUlTGEnW/c6oaDrRJKe0OjYhmQQfkyzYe2v6JpL/Phl2VIG?=
 =?us-ascii?Q?+rCLstCEawinE6jBVbJ5ISCxrXcHrQhJ0h6eKXjKIPN8VzpQUJOwr7cJ3KGi?=
 =?us-ascii?Q?jorRH0hGfUYYW6VLlH5C+YlXxRl+iB6D5egKbPFaEDgaxLudPekd8N+EXYNG?=
 =?us-ascii?Q?9C796EKbbWA+EtS/k/vW304Ci3ntQSsbOLoA7KfIyzfOFhPkqT++TqUnwhMM?=
 =?us-ascii?Q?gwPnknzTI1Ev266OimOsnVgbAuq/bBbQJREBo0qeYbZyfHnF1oUPDyNyrI+n?=
 =?us-ascii?Q?mxRl1dogrCleYRLljTZQ+U3g50DJNQ9y3yO5x+twLoUIkjFnkTkRAFZp3rtv?=
 =?us-ascii?Q?Vn//zdyLz+orVJ2V6QR2ERBAbAflWzPudweHAGU8UhstzVSwt9+dlAQ8wWTV?=
 =?us-ascii?Q?ZjRkKyn4f1kQao2aOwD+m7wtlV/aTiOY6PLurnkULdopoIiI6X1Qhx7bGQC9?=
 =?us-ascii?Q?pLc/IhGyLoiSEfDjbNDFe2SU3OlSOyiDv4iRe4lDL5YU+fzQuCctkuxbiVhO?=
 =?us-ascii?Q?R+kxkqyKDks9EeBwaYgeVzckH5aCk4mhJshjggtA+ymeTQ7ogFqarjLk4JsV?=
 =?us-ascii?Q?KJE83rIhcrO2bSvl1S4aEFXpSXukl4czsgcZBOTMBA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6oZK2mrgAEknhWTFe+Sw2taDWd3jECny3o4O2FA6WJewTIR42YFVT7ZGv4Ga?=
 =?us-ascii?Q?ImEQ4Rbh6bhjWiX/09CYgwArbJdUi4OvSSUwRTaAKkvqSs76QtoZmbY9IEyn?=
 =?us-ascii?Q?IVDtwyE3eLj5f5Utl8uayYjTrVaL7av8WAtdjNfq8XvPH0cARlGOz8NE6IpJ?=
 =?us-ascii?Q?gbFhwUSkKK1wh3MCp1/+l+Iyq/kh5DLkGgApfLp6tsx0s7zkYsuEZ4sE+txd?=
 =?us-ascii?Q?SjTfruRkMduQtbPdEHQ6FHMwm36syKa17N51gdLdxeXUvHB0q5DN/bsxiAgn?=
 =?us-ascii?Q?kdPhDvzj3Niapenmr0JsXtY57ugeAiLW/eGa4TT1lV73o59gbjYKoMv6Kabh?=
 =?us-ascii?Q?w946bJkAp2NoixmgHimcq67mJOAeqmYeFrsNBRkkej46Wv9JldT957cfaIrk?=
 =?us-ascii?Q?4VfvAtfQt5K/mGzj8hmjknhMp+HsqjmR6yX8dez1XfNlenkKv+tM1Z6GFRMz?=
 =?us-ascii?Q?g0fden5ewMGPjYkGcbK8qAivXQBUijN8sj9HfYrWORivHHl83PwXVYZNqXf+?=
 =?us-ascii?Q?N5KiqEKDivWQvZyBZ/1ZtscxwpH0Dm1CZX2soUn9RWrx6L10ad9n3+eSSeg6?=
 =?us-ascii?Q?EUuW4dqEXOeLaVw4bZA3VaEm/dSr0ezadlDipHG/UTFrb159Tm5gNouO9X6a?=
 =?us-ascii?Q?v75Nsk6KF8I+GCM4tNtF86eS2j/sRe3LVuRJpGaLlK+0QB1TWNiRK1c4zE0X?=
 =?us-ascii?Q?vykIrpKUNRRYCImkM6h911cR7Qf0jJu9Usvm3D5j10kYco5QGo1cupijQXx5?=
 =?us-ascii?Q?6YilvUBZGSn8WiE4+eBUA/gWi1q2pk59f7haP7BAPNO1ZERYN1ShH4QmALmF?=
 =?us-ascii?Q?nrSljecAC60wRiMfESL2LDzDdeje7YcDlx6INy494/9Si22uVtwlV8Qq7mZF?=
 =?us-ascii?Q?XiJoDROcfTDtaWVKQyOUwhrQal6xTfcJQB9EzhKtACUKEdz5nCB9VZD3vUSB?=
 =?us-ascii?Q?7oxwLU7fSUz1bptZ5D7q9Oocgv4HYfVTNQGZdTwU9yePu+LTZoZXRfpRl4xU?=
 =?us-ascii?Q?dBfZcopQmuCHmb+zGh5+uNC0ys5/iBVXHcoa4/PeraoaSQ0gNXSooxJxs8+I?=
 =?us-ascii?Q?tPxwhMHzV3PtFdef9KRSKm0hZvln0ibc51d9a6OhUpLvKXHdiE9y5/gJ94M8?=
 =?us-ascii?Q?2sdrgTDlkJRR8svLQam7ZahgootJpTDlceor5LeZnzO0nJx0QzH1iK5D9WTb?=
 =?us-ascii?Q?zp87BkOyMuwW3SIAc9fFrp/xo0y0sv/eC21h8DolsB4s0qeGJqY8pQDPwlhV?=
 =?us-ascii?Q?u6KDX03+gVfI938EjDQ/9B9GCpa6IxYK9dBN95XFifmuBpEeuo2AywaniQ7H?=
 =?us-ascii?Q?BphhbGdyqlrSKqzbblmkM2B3b46uZXTxK7SVrqufeZ28vIXofMsvtMUVmnCb?=
 =?us-ascii?Q?jW7pN4+A2qoKYfX+N7/bftCg0FA9aJlPJ6oDthiEs21thPgGAfze4xpp15hf?=
 =?us-ascii?Q?twOV/VSCoemEQZYiqF/f3SzyHo8f6KZTbVMCI5Lizsjc88TOQwl9qyUw53WU?=
 =?us-ascii?Q?T9byCBfOD3kQSBPKe5F/gw9WaTf2rBz7TACojorM21wdM2jjSogl0TVtDXV3?=
 =?us-ascii?Q?w7TQjgJHDMXXZTcbGak=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ef115f-e99c-489a-587b-08dce46987a8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 11:41:47.9777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3WbuQWDfpeui9T8KoOjqGoCuHIDg3yEcdR9P33//4VxEhUPK3y4o3lqLmv3fB9my
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6167

On Fri, Oct 04, 2024 at 02:32:28PM +1000, Alexey Kardashevskiy wrote:

> > +	__u32 __reserved;
> > +	__aligned_u64 vdev_id;
> 
> What is the nature of this id?

It should be the vIOMMU's HW representation for the virtual device.

On ARM it is the stream id, the index into the Stream Table

On AMD it would be the "DeviceID" the index in the Device Table

On Intel it is an index into the context table

The primary usage is to transform virtual invalidations from the guest
into physical invalidations.

> For my SEV-TIO exercise ("trusted IO"), I am looking for a kernel interface
> to pass the guest's BDFs for a specific host device (which is passed
> through) and nothing in the kernel has any knowledge of it atm, is this the
> right place, or another ioctl() is needed here?

We probably need to add the vRID as well to this struct for that
reason.

The vdev_id is the iommu handle, and there is a platform specific
transformation between Bus/Device/Function and the iommu handle. In
some cases this is math, in some cases it is ACPI/DT tables or
something.

So I think the kernel should not make an assumption about the
relationship.

Jason

