Return-Path: <linux-kselftest+bounces-26683-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4DFA366CA
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 21:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD13016DD34
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 20:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2FE1C84D1;
	Fri, 14 Feb 2025 20:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AxrNtJ8b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8F2193079;
	Fri, 14 Feb 2025 20:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739564127; cv=fail; b=KrYf4W7e4QRDaRFsJ5prgtcbW+sqf2tO23TEfeGcQC/mJZe783KbSQo5EovpPcYSOxfbAm9acZUDLmXr+SISOjPooWQ10eG7FYeYxRsNKBXzq4SSet4IeMhT6HHxt++GSIiWxSjqFCnCvk6/bwhb78+GY8VN0OzcyArQmWQLtn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739564127; c=relaxed/simple;
	bh=Hbc7g0QZxGRwlAC3XVNjZWJcybuHyYbzJOUwUnMaCjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DRDihZcPq7vzFTuHiuQp0rl8cG4njGx+2w8PzouUNh3uAQLLmkEXd9U7zSnzysjRO8Bf7HhTO4nSOiE6b4UCb1LzN4ncQ180i7r67q9CE9yw/rR+ld1ewwPKlZExgr9UKJnXnNsXeLrHHyJGsYkk0dUR6EIoOVesr42Q0L8iOmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AxrNtJ8b; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xXa4c0Q+sv3qLv1Qclk2k/8Bcv1NqYjmU2g3N9PSeBW4TF0jAbNIaB92x6lov5gqm3EUqCZnd9BiMAinmGOTG0bUTKKt0iWGNoNekAl0eKu8EbPucyy0CzTsu3IAeaV3ZSPvFd8/584LlsFjINZezsP2pkKHVEksA3iyg/DrSBNbONWbbQ0TU8mX7gnI3r2FJ7dv9lCjj28vV6LpwSmjBlvUr1UvFAPM1c5bfM1OfQxqBqfY7hekK6NHL15jCNQHzc+00eX2uSSAVFMXXXfMXQroOP2BNzX73+bKBwJGQciKEqNDlXfUN/gwDmH2DeKxONbbD8GvNhgGbWmLZN4cvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zUBJ2RXXtCnuTCtbDrnRwIcfeHJ4e1DE9WxBzBw2JIw=;
 b=kyOeSiZIRVwBOwHXhf9a31HGqTKiEPYz3C/ixrXl3WeFzPpEHM59PkU7jIeeIxng/vuPoliX1Vrib+7m8/oe00Gj8E5FiFYdDglP9yQcdfTcsAnkpKA9J99ha7qtQEZHNO/mZb4CmPTjWvHIUv+wEBm3Djbw7HnK2X72cO1q+Ima85Nwg0nEzEFhPkq2YVwK9FgX3Bk+C79U57YqxsO4dLup3+d4b72h/sfwrnxFkG/uMo+FCUHAJXNIPVpb+OrS/B6E18tILE6rVk5tJXM496IyP+v0Cb2iaNicWzO2f2dk3Ejlgw6X0v7O3rHNTlkK1Dbh+tg7NH/2YjQoiOgLgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUBJ2RXXtCnuTCtbDrnRwIcfeHJ4e1DE9WxBzBw2JIw=;
 b=AxrNtJ8b3RCsP/L3cAtWWLDzYqJFiQVL94JKJdKVZleT2/DZFuwsv6LVACVbjUZdiaFO5tY1E8pGELFMktcjx6SR4Hm95syf3I+pCIKDg4rpEoVqW6+ASvPULQ3Fdgr4jR2ErCQ71rdcEiGlcUbvjKkTBieVO3LbGOkBWRBUkiyKkOZw9gZ4IHpa35/AHN1fXO0WPHalaRoO1ch1AlGXh/ruWXBbDpo0Fyg3N2FcxGmRQK1mIqEcxEEWgcV5UYivNQpDgoWTLsYwZx1qalypfYEucjo3ZAnxSQXuEdG84ID/wbnkclRuD15KXvt/arX/+q6vdEpOPWvU6Tfr33fJiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB9528.namprd12.prod.outlook.com (2603:10b6:8:252::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Fri, 14 Feb
 2025 20:15:23 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8445.013; Fri, 14 Feb 2025
 20:15:23 +0000
Date: Fri, 14 Feb 2025 16:15:20 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	patches@lists.linux.dev
Subject: Re: [PATCH v6 01/14] iommufd/fault: Move two fault functions out of
 the header
Message-ID: <20250214201520.GI3886819@nvidia.com>
References: <cover.1737754129.git.nicolinc@nvidia.com>
 <d47fb648e36a6a5f04e0d98d02fa71e47c4a77e8.1737754129.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d47fb648e36a6a5f04e0d98d02fa71e47c4a77e8.1737754129.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN0PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:208:52c::22) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB9528:EE_
X-MS-Office365-Filtering-Correlation-Id: c7b83640-991c-4a7a-29b9-08dd4d344f58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?663E0sEcJCp4QcGFqVOSm6D2AlbxhRzq2oLDkqUKsnmBnvvId/OwTwEZXnSZ?=
 =?us-ascii?Q?lP1A2AzwE0ofDzEWnVvQ3L6nUY1eyyNWf4oTOMHT1N1it/wwQekXWKDitSpL?=
 =?us-ascii?Q?TnoB9P6sJTXxVIaI49dnm30IIuEqyCYvywQKK9/+bY1G+nOyY0XH7O2S5oe5?=
 =?us-ascii?Q?yu5YmbPVExr6vQHq0PdyaWOVERDyTEz5GWZi8Er8J6OTc6UERmPjN/Y3gPs8?=
 =?us-ascii?Q?tBA8C8VcABYI4VXPfFhgKYWAuahQC+JKOcRnPSlr8fCKH2nJp/usOS8OOkAP?=
 =?us-ascii?Q?uxtcEEF5NoCvOnwDvuIDLn0TmIzsB7knc3dy/ru37T/3xB7cXZJxd93WIzNv?=
 =?us-ascii?Q?KjgCJY3zhEo+b88aPg2Gi6Gb/RYoddhekqp2U/84vealqI4kW7brdVWNrccN?=
 =?us-ascii?Q?Y4htXhmgN3x1J6ppzZrWk9gzeYuv+/rrFe/4C2IxRoAg2CrL/BVCC/t+wS5g?=
 =?us-ascii?Q?auJFPLRYdrIZZlvq52Pe678S485IazeKFBnEjcOP/2MUwOVw4PfwX0+jdUBC?=
 =?us-ascii?Q?7SmUXQHUEUrQVKq6NaTwASiCLGJq/O67x70EVZNv8Y7T7dqI14T0PzcTxKBt?=
 =?us-ascii?Q?QNfy5KisOxvzDTK4EHcX81pvEoMf4GQ4ktL+KdTAn2PWwIflIYDepyikfFLo?=
 =?us-ascii?Q?X/wkH6qcyyFe7O0SEJnY13bkLjXOh/3OoLQPFHMDTJ9uRiDN0LqEYffhXHv9?=
 =?us-ascii?Q?Rni3o+r0ZqWCQFc/qJlTKbzpXtt5dP6O/pcw0XYG7tkHZ+XPtJXVtlkNfaDg?=
 =?us-ascii?Q?vWc4NHWkJN0M0xqq/crCmkUdVC4ND8ARTDvfE58qkzeCD9sPJvtPAmP7ZsWz?=
 =?us-ascii?Q?+4TgdanA1YZ2glpmh/1nJ1sMVAw9WjoZvOu+4iYnmDclxff7t9FOG/wmqhQE?=
 =?us-ascii?Q?OQH77b93736/0ACXNlAVpTPSHd5hd5vk+HrdXJ7Ho7LxPR62XB6TWwRf1MkC?=
 =?us-ascii?Q?5wm+76RXIZByBsP3AjVXTl9/hukguQ+NAqtQ4HxH6gGYxuTuD4D+cSRQ5/pt?=
 =?us-ascii?Q?ZXUl/ZVplGag3g5+NH8Lt/Pk/bytw/IbUiqJyq9M5u4wwD1FbWqnNmEH7hjH?=
 =?us-ascii?Q?qopXMYSPBofSnsAmMeAgL+9FWZS4Q0umud92Og41fEPj3Vrp8ORThZ4r7cU3?=
 =?us-ascii?Q?BDw/nTx59ztvnVHy5AR4yAM+ngaGQWaP7eyN0N3u0kPDUiVHebmqEYFFHbxD?=
 =?us-ascii?Q?kxEfRAmPuSLzo1ZfRMM16cMWYi9pPLLrSHwQ/xfFwRZv9hyGX+FhqjjeLnUd?=
 =?us-ascii?Q?EsJL6Jtk7XH2GyOGmdpl2uHtJXK5CCFKu7/CqU/CrCenyWUSXJXBbzHDVdLX?=
 =?us-ascii?Q?bOX6nhp8Z6H85yTwkI3KWlCQaEnWFDSaByDJ6jVjscdnn6JfQvKZVXU7tWa6?=
 =?us-ascii?Q?a9OXJ37ZLnZkyCOl4WBGgXmMIyEk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QwV2qHW7LiiBC+wTtwLRnvBXuNGrPJKC975u5aUUg3304Rfy58RQZgoLUVMf?=
 =?us-ascii?Q?TrCBWVcEaFZnyD/7g2wO1Y51WmbxyURZPQHxJu+oRjKNcC9mWxrr/nP7x0QZ?=
 =?us-ascii?Q?YGC9bfyq1AP8gL9uG/mDyyuPgHM24nxyg9pSojk+mljS0eBPM5TvSO+L02in?=
 =?us-ascii?Q?lILsz9W3tkzhwH/bAi1Jm2JsZHl+/wwC25iWrfdAPSjsNT264kc4mozmjnZY?=
 =?us-ascii?Q?l6mTo04P8g8pgUWjtV9mcmBCqH9C9RrmTpNC8fuTZMqyj4RMRHGb/08IgV95?=
 =?us-ascii?Q?EHdmPsPsoqfAy1T1zC10OWQhvvnVifDviVhttzUkDS/jEBRP2EPtxHegXei0?=
 =?us-ascii?Q?k/cEoCeUR3EpxHoUpIAQBrSXMi0Bqu1K4TcyLiEJFSniPXP++Z9YZkN0TNI5?=
 =?us-ascii?Q?BNa7YnR+i4k513ypi6QR5BDJXzAfUZ0LRPKKacq08PDutz14vZjWsXwOCHeh?=
 =?us-ascii?Q?pr521bTE9QnW2d1zwmMzCNoL8jri6Rv6bdKeU6K67D/PLwS0ypwJ/XVR1mM2?=
 =?us-ascii?Q?1R4PTp7LvcvQ0ybJVQeeRIzoZEzBl2QAnnDaicfLW6tjhpikt3mbUTNPOWcn?=
 =?us-ascii?Q?TOBpgNR61tn2tbbgZfaraaxeVmvuib19hqU7db1KEYgd0whtlVIPtIsbFWOG?=
 =?us-ascii?Q?gPy5I59yOK3j7ZrcxuYk+qOLR4EP+ROHcEGKV1kj4rt+CWSKJc3Z3dCN3Bt6?=
 =?us-ascii?Q?ZpXuOy1Ngv4I7WG97eEXUSDktvsbJbLtpskjWv5KBhPuoeAf4p/LF6B4cr2e?=
 =?us-ascii?Q?zc79R0wIVTctOib4ZPtQEXi3yLcASK4mgevbf8WO1Gr/x8enH+dtlvuJqbGx?=
 =?us-ascii?Q?RARFmFvA49zGzNhHqakXijCcsbfG83xRRhL1UL6BD3y+1hK/zrdqJpXxMlwi?=
 =?us-ascii?Q?PbdVuVrYLKQrf0QC8Hcvm958yU2IoBeZHQIeJ3X3X9ImwIIDcBI7vt9N7F0M?=
 =?us-ascii?Q?cg8byzR5eJZp9DaNN+aMqYxNxDPWAebyI3PzxVGTWziGNQ75osdIST87MqhZ?=
 =?us-ascii?Q?u64tZPRV6RshaQZEQJQzSAKYx8dssLCAzD019ECbyaLbMnmhNeU0eKwk32SD?=
 =?us-ascii?Q?Wvn86yj89T1Q2Os2gtczYYSBblKs0T/nB468hWoBf4tvA3QgiD5xB0LDW16v?=
 =?us-ascii?Q?UFeX2nbziY3sLbLdtxjgUlSXubeewNjYQngX2xMSRquiO/l6BqzGDuZXXjnR?=
 =?us-ascii?Q?Y19w/5xLwZaq+NOOmNLL08G+zUsPHysLfZZCtmaQ3Ue0uyiPXem8sUekO3KR?=
 =?us-ascii?Q?8pqGBIEFK6cbC6u06kcRw7gDj6kwTFyDI+c7uVxFgXFS+d0t6MreaHBhsrfn?=
 =?us-ascii?Q?YVz/Edin9T0BMbE3grbOM6SGWytLquL+LU5Q/po31fXgKM58BHRHnUzBPaVK?=
 =?us-ascii?Q?/4rnNedFoE2S/xGIMqxsxtxq7edD6ls/l8GmuEN+rx7pM8afFIlY5nUfKCkf?=
 =?us-ascii?Q?47D13qzggWRauNUyB8pckM7S0tofAjMOo1aTwriJr30QUx1DXAEetEoVdSY6?=
 =?us-ascii?Q?cLwpPCI8QaLv2+55pNdIpAhxo7ye/6fVczBuqdQOI83s2UESZZRgYWeCksFU?=
 =?us-ascii?Q?QaM3VEsCvPfmfTNzOrI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7b83640-991c-4a7a-29b9-08dd4d344f58
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 20:15:22.4814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NheWwpdg78emlYa/L7Xt6H/on6U7apyd8SRBWUp0fSYcYNRiyx8fp5Kh/jHBmLAf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9528

On Fri, Jan 24, 2025 at 04:30:30PM -0800, Nicolin Chen wrote:
> There is no need to keep them in the header. The vEVENTQ version of these
> two functions will turn out to be a different implementation and will not
> share with this fault version. Thus, move them out of the header.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/iommufd_private.h | 25 -------------------------
>  drivers/iommu/iommufd/fault.c           | 25 +++++++++++++++++++++++++
>  2 files changed, 25 insertions(+), 25 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

