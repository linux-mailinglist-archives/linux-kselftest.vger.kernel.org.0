Return-Path: <linux-kselftest+bounces-18740-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB85298BE4F
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 15:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 576271F225BD
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 13:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2073F1C578B;
	Tue,  1 Oct 2024 13:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ul3yUYC9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F801C4626;
	Tue,  1 Oct 2024 13:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727790504; cv=fail; b=CTHQpOYQ/vAuyWcNBZJvU4JPG8ugrPNYUnzna9j0eSOE+ir5RUK9iyKvJNTAZmbTKLrFnV+zio9zY/5wTRo40pGwDU2bWaBltdjvNoxu65F090Pu7/bFinNJwJd2SaTkRCcb37oEEgl5EY1aKyiz+MXdB3g/g53hCUTqiiGO6dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727790504; c=relaxed/simple;
	bh=AYW+Ho8BZGuNHlnLhSpIi9r7/yTrRU0R0nl2v798le8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LjQdGxdReND8v/1dLFPhaAc5S9FTCAjnqO6sqNnNa+pHxgnEJVyqPJgvwSzStg7HVzdex5U8phAss6qfCNQxwygMmzZdRLa/RugN+3ZHpl8RYAfK7Mo9YdRiTkl5YIYfNHA70D49b3p+0csYLfJkA28NiUOemyvbAplB87a/LVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ul3yUYC9; arc=fail smtp.client-ip=40.107.237.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F8KT546EocfUoXFGQ8G8oFnEXuhECu+syzsFR3DobfiGkRKHfo5FDaDMRAc6Due+oUJ6d0YukwLzduLqDkFfktg+grnIbzxNtxJWj5pQwFmaC+KUE9CFOvuVkNNCf08xM7dly/mBPBYNORNtAO/CgbVOJR0guXskZ05J71Awx24bObVSm/+FpktEn9JYBGoU1eyqplp7GJUuf9MHjh/dzZGsVACL4njixDH6P2iFe24PILzEs7fYNq39Kq/ElOfpIlI+BR61Xlom6HKl5bRE4dgJ1F9s04a5b5zKZSJ+QPSvfld5qKkv7sXI5koTx1VKolKbd6hYxKtvR0Q3Td2Dmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aN0/R6umbYpmKaAJqL2htW+LZKdjyczJqnux8fVIhiU=;
 b=ePizXkcuXEldcOH7rFkVo5gN8yWc/+jICoWkOKO6vDYIKCaKamUul4Xj/ENAtq2k/84r19rpzfGOcX3LYedYB2sSlKYYbKUXZo8lrcYKWBx/pY7xWjy6jYi0ERUuGhBbMsRF1tX+KuGyLtYRptbicJWyP88PmUPFVPZJDw4qcXZkNduI0nIK4/coyfzEO61h/YiUsTS8yE41SHRk62CcBcgxUrOnHRzsAm72K2Onm3651E8zhU1GIp+U2JdcpDv/WV1zY6GgojFWbSgoITEeWVGyHG95Yojdd49YsPscw7daCT7ZcPNMPPuDMVO2sgQNBv5+zhxDcvkHVeEbacbYsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aN0/R6umbYpmKaAJqL2htW+LZKdjyczJqnux8fVIhiU=;
 b=ul3yUYC9jKxYuPxzz8wbe+6X1zLMXtPoh02WuGCQr4bS3b9IRjrtJmVntaIdH1AVCWaaHqyLnJSI/CL89zymnuTfdLwwWKRScPlmW7520wnO+c7i/7kiMXPYNB0nDsOMtlToH9d5zXOfmv//aEocMs91PCaVO6PcaTa+OhgcpmQn1n450EcDgg+9kPGofsVFlfsePsKAnD9bB02LyXElx/UbfFmFbMk5V3jN6SMEPDnTtyl/tz5yAc9GSdIH3btcgsX5LmiON3Taz2vdFBJZMM7yAICvcGBm606EsrDAFHNBnuX+1MRAV2UoHYnim90k4T/2hc9ELBUwHD4YCmGq5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by BY5PR12MB4212.namprd12.prod.outlook.com (2603:10b6:a03:202::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Tue, 1 Oct
 2024 13:48:16 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 13:48:15 +0000
Date: Tue, 1 Oct 2024 10:48:15 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
	will@kernel.org, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
	shuah@kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com
Subject: Re: [PATCH v2 00/19] iommufd: Add VIOMMU infrastructure (Part-1)
Message-ID: <20241001134815.GG1365916@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <bf95f910-e837-4d79-8218-18d234ece730@intel.com>
 <ZvRcskGx2u94Vs+R@Asurada-Nvidia>
 <82632802-c55a-4199-b685-8b594a8e7104@intel.com>
 <ZvW+BoovlyJ/wziX@Asurada-Nvidia>
 <ff35efa5-ba7e-4974-94be-59bf794a14e3@intel.com>
 <ZvZRapZlAsEGDIge@Asurada-Nvidia>
 <8440cd72-ced6-4887-b724-ce6a1650db13@intel.com>
 <20240927122051.GY9417@nvidia.com>
 <d5fe4c4d-fde9-4d25-a580-0dae63c62ba9@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5fe4c4d-fde9-4d25-a580-0dae63c62ba9@intel.com>
X-ClientProxiedBy: BN9PR03CA0435.namprd03.prod.outlook.com
 (2603:10b6:408:113::20) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|BY5PR12MB4212:EE_
X-MS-Office365-Filtering-Correlation-Id: b6ae9dbf-966e-494b-09ba-08dce21fb334
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uj00mCtsKfz28h2dv23KZOQmgCsw79+e2Jl6K+6HIZ5FEz94YmsV7xWYb4wO?=
 =?us-ascii?Q?uHmsga/vJ5Z5s85rjDEWdOz+jiTeFn21PHkdSQcmY8GXZc3kRD6k3mKghUri?=
 =?us-ascii?Q?clSZGr7NRTiPw9LVOKO8gONJ2Hd575yc9Da8ThTF+Wa4dbH/LihGruuBD3Zl?=
 =?us-ascii?Q?KolAbdxJnV1Q2pMe2hM0HgOIRZs+xC96NDenZ9JCR1sGjB7sOzIj4urY5foo?=
 =?us-ascii?Q?njWcxSwTjmdmx9XsWhZoIt99j7vQfGQg44ot1BnxvIgW1+zSIX3aWrwiSlJ9?=
 =?us-ascii?Q?un04QskXuyumjtRIjH2dQ+9UPAwIIRH2pWxZ3PNZaqzuStKbiTm/XGzU3O3l?=
 =?us-ascii?Q?Nog+CcprT9pNk+n/VNVt7SRoAOmeUIExyn2nIJIjAKeeIMcCFlbSYJp5RbV0?=
 =?us-ascii?Q?0hfn1zuoFeYpHDYsB5tUK3zHr0by/qDc7XcqtJat/1Apax+GaCqeflkeZhub?=
 =?us-ascii?Q?hgzRYSzv8ppIchNX+Z7uJdVs0qbRVHlgbXgd2+DZFdgdE5OEDTRpa3Njz7z7?=
 =?us-ascii?Q?zL3IP1Uz3Ki3unpD6yx8wqMT1qTi3tpFEBUI1202MMPC2lQqdT+D9sipNqWG?=
 =?us-ascii?Q?McZWvP7IFbgDcpRwxiTDD9QPrA63MEkC5WXnAsp4c9QLqd6QHB56uOIzW3oc?=
 =?us-ascii?Q?xUsVZlSqCm5+ROvwaXBf8/WJkSCHNZcLcerkFxV3wBd40zPtVG+AcR5ibPNx?=
 =?us-ascii?Q?2EaqDBUwYZln/vUlzbeNPbuYAQoMHT5kghgYUPb+/vsd/CnP/6XMFsvtbvqR?=
 =?us-ascii?Q?8BTv72q0GUULzsq1Ar7DsFh5a5uFjTFC84azKl2cZWTVgI8xXjBuxuvYOHsm?=
 =?us-ascii?Q?rON9NXk5cTUpIYdsVddjx9BzBqXUD6c8cojCq/eynQHrkD94CiRikD8C3I3w?=
 =?us-ascii?Q?01x7vwBrDx6BO2XXbewuFY+xscEGvHg0p5C8WP16J60Fc7RalenMPnWGXoAZ?=
 =?us-ascii?Q?rIfSI4YVeb+Ei44NWKyvL8TiAfh8vbl00ae+hxHF2WtkyBldDxP1wWfv9OoU?=
 =?us-ascii?Q?EX1JKAAFdhELJZd05WO2oKtlnbgbCrzulv8gXHrwmb0qyP1+THPIc/dQOR4v?=
 =?us-ascii?Q?hoUnKXS7zD8CN4ILrxRxAhJq3DmhdPDlH+S3cOUecCTRlYW9NFC6KQ8Ls7yz?=
 =?us-ascii?Q?NkwwrOCnoG75+443PCTPSooLOT30nl2Gii+HQIxIoUN4EV8I0CYNFdHqLnTG?=
 =?us-ascii?Q?v6cDa3C41wi4RmAx6l4EOtifsUOWdwyz6zH+xGLBrAuyXHKSH2S1oqbEBkDp?=
 =?us-ascii?Q?rB154E7JSBdeIIHr+rloUKEi5xYG5HGk/1IgxkVvRg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6dKZofLP4OZOR6BDNECLvOvOdKZ8S0Xw8e8nglC4CQjcaXREwGWDVK8BJVYv?=
 =?us-ascii?Q?s6J1B8BRifN+fVmmjmbgzGX+ZXgbm4++vgY4Abc8Ho2F32lqwVsP+qyh7u/D?=
 =?us-ascii?Q?f0BeFhDcYbbv15gPI74mDRT/DAmcZfhSjz+Hl+aSIo7mAu9Al0lJ/FWhBu34?=
 =?us-ascii?Q?AjZZGejRw9trFJCxW+BAnNDkHwzUa/CXuqwwJV1KjIK+lZq5pWYx89EwPMh3?=
 =?us-ascii?Q?Qmt00t64A8tOMe3sD1+tRW5w41Ep8287GotmOHYo0KaWbgN+OVfZKKCsNmFX?=
 =?us-ascii?Q?TgbJmTx5PkxhM5PfMJotWQ+snraEet0raERZnqMWS69wkdVC/6Vgp8sYOV68?=
 =?us-ascii?Q?qpCfW4YbG1YiLOIF52U7zQ4Y4KAz36/tCg5QTSmYS9SnogjezIFvLq/fC+80?=
 =?us-ascii?Q?7EXKLnrrMivFsbC+T5wMQRo7iOWCLOFaiuz6oNgglIw/vUbwgTRDh4n1zSzB?=
 =?us-ascii?Q?74anLcGbP4M4wjtr2ZMaC9sX3DZvS00C00Kr6gmOWLKADxGNxIA0vIITbP/Y?=
 =?us-ascii?Q?YMf6kRNWxRj0HiOUXnRs1LSGeID5MWUdLmVcVpFXIAu3Kz2O8ci/YFsOPBBV?=
 =?us-ascii?Q?qjswIgH1sTXaEnZnoK8TZZuAL9Uz0jyO4exay12s3cua8Sia7laEUaZcItf7?=
 =?us-ascii?Q?dV/VCoqF1bvyCnZvObCsXSGFgIryFeJQtoj5MlsDK6oRBQo2Q1r+NxQ8Y7e0?=
 =?us-ascii?Q?TeMSzQps5gWc1DZEGy4mm+kTmZoQGAze2zvAgc2grqKGn9o/xyGrUTBv2Ivm?=
 =?us-ascii?Q?TzzsW/CeAG0gbURj3lDVn6eA9fLlMLFlhA3Dm4kfgF0wg4CQWsxDVrXfiU82?=
 =?us-ascii?Q?ynwIQt3+vW5ogOyiDujeKIn4LTCioac7cNrnfIisq3MsADBLdREnCaMOnLLw?=
 =?us-ascii?Q?6Tx1TWWO54JBMS3gWw6YkcZmOKsx6eaNHAVj2uk6JTXhkztSOgy9ltxaAchy?=
 =?us-ascii?Q?DdV99Fhrb3CWDgBjVupRPCemr8+yOfBgrwzpLy/JoTPTY9M/EjTJZXZbuRaD?=
 =?us-ascii?Q?7qLPmoA33vu1uhSpwXXQMYY1K+rPqWFPLmdaEU42AiuNCmj2OFZyxsWK/o1D?=
 =?us-ascii?Q?EJ5H+JfRuEIkulrqHKkiWSeoUSNYATm+Gc0knCkeDNOunBIz8piybaXotp+0?=
 =?us-ascii?Q?iLZ02iaroPhGTq+b6twO9nfnjnUq3Ve0M44Be77mtjKPzQ8K3/6Z80Ym2zv9?=
 =?us-ascii?Q?FO7Fqre4RU1lL7c1a4Hu97Zs3gi8A/wG3BmifiGT8pXuiTcogTO40urF9Yxm?=
 =?us-ascii?Q?cisiKY1Al+WTcN3a8j80zauoB6EzzoltZ0XZ55RufWSIAY7oKIo/80emGU+N?=
 =?us-ascii?Q?iKXPeBYG1Z/n8d65sTcJgkwcodsMo5HpXDDkKst4GbyTkcEW0iIp/zyI1Pk3?=
 =?us-ascii?Q?WhdESaWXO6IMn9goG3I6w3x4XRnkOiAQ/hq2Yb6nnNzB5eUN874XFEpdazCE?=
 =?us-ascii?Q?DtVbPaIYNOu7FRYMaGezgBqc3IBCbJZ776m+GvF0NNy7nosYGFjOV91idZlN?=
 =?us-ascii?Q?9Q1LJViYM7E1TCvxOWH2edUOMk9SewlEFzNCdYN8Dj1eybYgIy17cyynoS/8?=
 =?us-ascii?Q?qSt290mDxu6pycmumYE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ae9dbf-966e-494b-09ba-08dce21fb334
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 13:48:15.9128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XgE7bO7T/SMV2PIyEHM1dK95X8jDxhyjJjiEQYHjAkcty+GFWdO6frsudQOXIRTD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4212

On Sun, Sep 29, 2024 at 03:19:42PM +0800, Yi Liu wrote:
> > So their viommu HW concepts come along with a requirement that there
> > be a fixed translation for the VM, which we model by attaching a S2
> > HWPT to the VIOMMU object which get's linked into the IOMMU HW as
> > the translation for the queue memory.
> 
> Is the mapping of the S2 be static? or it an be unmapped per userspace?

In principle it should be dynamic, but I think the vCMDQ stuff will
struggle to do that

Jason
 

