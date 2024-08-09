Return-Path: <linux-kselftest+bounces-15097-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EECEB94D8CC
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Aug 2024 00:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AC891C218B3
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 22:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BB516A92F;
	Fri,  9 Aug 2024 22:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jk0Fll7W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2088.outbound.protection.outlook.com [40.107.101.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FCE2232A;
	Fri,  9 Aug 2024 22:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723243757; cv=fail; b=EbtLH71gK3uUBCrz9wirogZ2w4+RH2dI8OERj1DbTj+DM5LNfx5cuFn1LI6kh0BKRlJIKUJ1BqfwXxp4wspWzfp2ZO3MYNYhdt1eDnY22D+snuxmDxoaNC4lwCMACfaHHT/ntxznGoLCwpkxvFrixP2kpwXcBJg9vyvdNuPj8iQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723243757; c=relaxed/simple;
	bh=o5Ywyv+XPBuC+eMkOgTAGonBwfBjmXSX00DkhjSolUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WuoAOLC3tDDdYdZVMWci9n25N2CLYb27KZTitVuBottkNfQ51IazPgPj+VLbbPUZN2gr7RXyQYomqYN7byfnefbZcS4TrAKgkEPzat8qnwq8Ci9WJQTW0QKPne84rj43XR7MHT/vUvIep1lrtcVlPulPDCnzHtiE+fYNGEs/lYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jk0Fll7W; arc=fail smtp.client-ip=40.107.101.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qap2y0U1HW+T4tJocS96lgmGTMV3ZUzsseSt+5Via6JlRS8isHiz4Boi3+Ymcotnf41fJOP4tf3wL4G370oZmwt888zIg0ztsg/27HD+6vh3+aBsIfV7GfdnDgdIAAv9mizNuC42duYwmXsZvJW7uvYBi5kaEqTmEPEaDaKCeGYywlxouh70oE64mDE2pPb7BZVr7VvPeSAEirbQ6LkonTXVNLq/vynH21DwYNlPRdlpFlf9oDDbwL4rytcxFDXcxll90g5uUvxCJxThYE7G79dkurxNXj/rJqUvpHlZzxjzijqrWjB1Kp96C1qQouXc1kouhAj7vzYTzSie329ZoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0awsxYJ6lvsop/iPV9IREAqtvO9n29xLjcjidJhyT0I=;
 b=wZza/T6tCEMboIk/k++w69SPs9wIcZ1fkhKXpWK/AamkqUSa/EasoB/dtnFDEv+7up9d/k7Pg4bqMh1BDM+vETJ0J5Td7SIwbEC0GWe8s5siXKCpugiyomWYyLoDWU1QAVmCgd6bum5PoC7Y+M2S+lua/q1Yw0GhxksdLgs27OQY42Ge3Lj6HUk+or6LxI7rXSdX1qHRjNr7w4YNQHgumTv0J/eyYo9PzhK745XQNKIFzHKSm5MHPxql9QTmEONGGHeUvNUwUfc701QQkwUhGpVic5Sp7NskvBlgc3cOdniPqPjmMjDbiO18dfXKT3HqczJaV3hRJkfzFC4Le2Kn7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0awsxYJ6lvsop/iPV9IREAqtvO9n29xLjcjidJhyT0I=;
 b=jk0Fll7Wg8AS7LYtNhDdi93acYJINcjDFZCyVzuPgk7R40IFfZ8yP6fX53wr7IUri6XVGU3o3iO+lmCyo12Jd2DsqteCGMp67o6H42QUudKlvNQJZhnSL8MW0OrIA6Q1Z1GCCJV2hPJ7vWaFi7vio8AUaOgEv5WdOeyxgRpVsH0h3dRxsDDzx1AbrMFvOBEnvu6cLdRyDJKCcieQAr1o6fggRKrGsQbbTY21l7JE7bIC0Ly8QPB9vYe7SxlNB7KiTLJsJ8QbuBTnFtpL2XTkqHjToTRMnm1Ud/WIXv30u+C3sCtwwo8nWrcZtaARZH2ut5t/sRx9l7Nc4CIY0fdS0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by DM4PR12MB6349.namprd12.prod.outlook.com (2603:10b6:8:a4::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.13; Fri, 9 Aug 2024 22:49:11 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7849.014; Fri, 9 Aug 2024
 22:49:11 +0000
Date: Fri, 9 Aug 2024 19:49:10 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] iommu/dma: Support MSIs through nested domains
Message-ID: <20240809224910.GM8378@nvidia.com>
References: <cover.1722644866.git.nicolinc@nvidia.com>
 <b1b8ff9c716f22f524be0313ad12e5c6d10f5bd4.1722644866.git.nicolinc@nvidia.com>
 <BN9PR11MB5276E59FBD67B1119B3E2A858CBF2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <6da4f216-594b-4c51-848c-86e281402820@arm.com>
 <20240809184136.GL8378@nvidia.com>
 <ZrZrku/Av/y7ID0w@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrZrku/Av/y7ID0w@Asurada-Nvidia>
X-ClientProxiedBy: MN0PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:208:52d::33) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|DM4PR12MB6349:EE_
X-MS-Office365-Filtering-Correlation-Id: 3936daf6-3080-4715-c311-08dcb8c57c57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BetaDwj0/23pCE7hhzVEmiR0d40wMfSWtvGrUnd4ZjJECY32iTYlj1p8LXmJ?=
 =?us-ascii?Q?88Pu+dMpe2WoYbaVDhenRC8RqqR6Bqv0J9dDHO5KIv4JN2f9yMewAjCZA9qG?=
 =?us-ascii?Q?YOsoaIRDGltfrK9IGOipf9VDIMUckEyZldn8bge+4lEvUuM54rKZguOzyj8M?=
 =?us-ascii?Q?vo+LtDr9oFWEPd2oYyHmZ8v70KVHUsQ6RfOWPjDcKXYEHChiMaNYMRO/SiT8?=
 =?us-ascii?Q?YKalQhBC24W9paVRStoQPgLDmOf1fziQpUbWh8rL9IGni/guweI+5I54DNZe?=
 =?us-ascii?Q?KNOavjQHf4XA3+/mnURBdoLaECNWoCkCDfZdWJsji67NeyOAWOXHucc+pyHq?=
 =?us-ascii?Q?tnWi77gDkszLTgnndiOYTm/3GkIXmBwFkw4py00kHSVQr4XpGtiATxnddpA0?=
 =?us-ascii?Q?RFIprHt0x56t1qjPx0cPD4NErj2ZXk33LfsK9XTXp2t+qdJBjVFihxIxYuVJ?=
 =?us-ascii?Q?WfvOCJHtTwVT38jNYAi9WuhWtD9dGUm83YtvsTI9jpuXPjWOGN5leqhVByr/?=
 =?us-ascii?Q?Vs1Ac53Kp9p477/rugZ/n9xB273uigD6mLeV+E9WSW3w89qzfub+8Su7P83O?=
 =?us-ascii?Q?H3gvuyNThe++FHk/ZZfkMv4wx4nTTlq2LPOYbxQ4RHz8aEXdQ6/gMQEuu/a+?=
 =?us-ascii?Q?MbrV6ugwGjYIRotuW9oYhcy+qdI5WoXUskk+nC+VAn8AmmNTFiI/ZRB4Y4QK?=
 =?us-ascii?Q?2qjXYkdZEcMm4dNOnOJr9/AJNpgbGy1vWnG/gTnjn+2qVDjIEhHUw+A7tRJy?=
 =?us-ascii?Q?u2IHsbWQ5VRj2qPTX9gzHPv3GXRnZAGSg1W2U1bez2guNzUbhOAmuJkZO9PG?=
 =?us-ascii?Q?DgaP4Gn4GJK2CEmG8OeAyxZl48C6uN4czkrepvQjJ/HlSJQuBpIb+wgASMqC?=
 =?us-ascii?Q?sd/gObl6dG+e7BI5UmIr58vQylgqPrwgDs6hXYWpJttFBDGE67MR9CQ4TEL6?=
 =?us-ascii?Q?z4uYN/nYs2VQtB70FooJB4ozjX7jexMknCUdmCflQAF/aY9YTcw1i8x079xm?=
 =?us-ascii?Q?A9gQSXUhDGJvq12Ox1kTWkKP96dCVYwqjzghECisnwVUdiHzDkt0ZX8aCNCz?=
 =?us-ascii?Q?d5xKGtEjajs6Ihrw2NkTVZhmEj9QxIPuJvsK4+5MPcK3gRBcTdxA4miiGExu?=
 =?us-ascii?Q?wg0U/c+81/Bqc+zWZAWYYdW1ut0eqLXmHxujY82wLl8B7CWM0RV0uAiJ/nRT?=
 =?us-ascii?Q?WBgQ28HLCnuTwfYFUJKWa25/T2AgbIMfOabeuAoyosaoxJqS1rprnODHhIO2?=
 =?us-ascii?Q?dAtY/4etFODqXGhGfc0kTpCQGC9TPgllFL1noWsokBPQu9e8Bhbsd8xCwmzq?=
 =?us-ascii?Q?ON5AmcSkeQxYFRXNs3vTSUKAAki9mywjU5YSvWI/H7vBZg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZiM3hlOPTXPeSC52WYI2Xnm/ayEASD9OVggaOy4uO4fXRhEMIuE8ux+1U8Jz?=
 =?us-ascii?Q?7J5ca64DiyODG/DscRc7xnGqHO0SmuwY1OeKNBSpsszyqRpJ21mZrv0Fxqa6?=
 =?us-ascii?Q?YgWXeoPPiNpijwza57BYGlbITw0BoOEaZDj7B6cX68ZEu6wgO2gS/61/mEQ7?=
 =?us-ascii?Q?MpW64tpO/V84FFn91Om56bA4JOtOeugYCshzS7CHFt8Kayx/6I9Iqer2W2QA?=
 =?us-ascii?Q?7qpiMkTtrubU7u5OxKI0hDxi7BqzZO/L/9cAtd/nLv3Mgjnze3BuRdxARqIh?=
 =?us-ascii?Q?LC+VPveoyCAjVKZ8xsPiwbwoIvk3CI7kIopPBJcKO+43aTkCSL2DMhTyBm4t?=
 =?us-ascii?Q?3Wf6npe+svBrE22G9j35CJJ6qTnBxWq8lH4R5K03euqoMa+MDCtrV1nDDBaO?=
 =?us-ascii?Q?ZovWHK5LOGfhHnwkg/4FkeMfmEQkQbXDZWN5N6XhtVtS08b338dTk0EyshrG?=
 =?us-ascii?Q?DjdN6SZO7BTmUJwTl0YklMidnt0C2O27LQBXTwpBExjh0gTq6oT6oDhSKuJ8?=
 =?us-ascii?Q?1ukkdjFP72plIgMnyZIWlJAIr3gzfSDUn62U6A9MCpmY3uqDBJcFRUd9Hv+g?=
 =?us-ascii?Q?VmSO+U+aC3SXaBDA8S9MUFW3AKSoOoysZnJuceE2YBu5YmVLmAjIFNxMDuQp?=
 =?us-ascii?Q?8VOy+hmlik7drb/rmpyMCTsBsKLaPkG8FnQQ0uZCo8MJyqQL8KNeKb7jw4Hl?=
 =?us-ascii?Q?XwKZlTWyB+II9UkSPkpU9SC2uKjKd6F20iwcO2sceu30TpTJ7yp+hpRO0VE0?=
 =?us-ascii?Q?v4cxGI7anZbul/GkJrQ7zewPFBIVX3jKYmXzoMmjZGXRWZ3WLkaK1E5bEsgU?=
 =?us-ascii?Q?x2cpQeLgt6Y649RPxHOeP5cVv/dOLR34dfxTzWRehc9NJx9VjX44WW0aRtl5?=
 =?us-ascii?Q?0jacDR4jZLZ6/OBmXhEf39da8Ts7k5TszGMo315gK+/LGCrZ42m5vjxwU9J0?=
 =?us-ascii?Q?gNMQxHB+BXY8Ed78cvNu/Bof4ORRdvG22AmMrumXDhIcQUF/GAghf4FkOl8m?=
 =?us-ascii?Q?NqohDVxfrAIgqMjrj2GKUuWwpHaYNL8CFU2ybt6VPeMIlKGmq6+bZCYEadPr?=
 =?us-ascii?Q?yr/ATgCNedWw/qlsWJsOe4wfAaHWUYib8iuKQTsYH2TgtpAeAQ8Xuji5jIS8?=
 =?us-ascii?Q?TFOR28EPg4W9E33lyYTgIHdXt79TUgFE4FR6NCD83XfUZaa193/xKAN6XWbM?=
 =?us-ascii?Q?fCKsl1HIDIN5AC148to704wz2RPfS8JaqNHZXh+kPArA6SfSYUmuxUdK27QE?=
 =?us-ascii?Q?wGaiwxlVaWEEQOJlQL7uniVE5qu9GXIqU3VwpMB+61C1wpTRKwKNZQNrAlD1?=
 =?us-ascii?Q?OMqW8QeSjUzZxGP3AEs+Mn+7rPf06Sa7Ii/B6R4dRAsQhz8cM9qkLYdC35xy?=
 =?us-ascii?Q?EklN8pVWnsnuakm5UNLm/QInE/XZ4JFTHHBga6VaegDql0gRGBUvM5jyMHgc?=
 =?us-ascii?Q?H6AcmgYLRqu5zDHCkJU5Q2sjLERb7cXIjEE1A4+tRCdpz83oktkgNA2IZxoh?=
 =?us-ascii?Q?YGWO4tThoGvrwMQKg2Sci1UJA8VQIHjhegdydhkmlrKP3gP3NJMSiMtjn4zB?=
 =?us-ascii?Q?LAEUj/a30w9aQw81PJk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3936daf6-3080-4715-c311-08dcb8c57c57
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 22:49:11.4977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJcWmAbzWi6b1czx4y4Ruj2O7H2riN5RzV1TUrJaja6FLr5dfm71BnJyB29WYeZm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6349

On Fri, Aug 09, 2024 at 12:18:42PM -0700, Nicolin Chen wrote:

> > The bigger issue is that we still have the hypervisor GIC driver
> > controlling things and it will need to know to use the guest provided
> > MSI address captured during the MSI trap, not its own address. I don't
> > have an idea how to connect those two parts yet.
> 
> You mean the gPA of the vITS v.s. PA of the ITS, right? I think
> that's because only VMM knows the virtual IRQ number to insert?
> We don't seem to have a choice for that unless we want to poke
> a hole to the vGIC design..

I mean what you explained in your other email:

> - MSI configuration in the host (via a VFIO_IRQ_SET_ACTION_TRIGGER
>   hypercall) should set gIOVA instead of fetching from msi_cookie.
>   That hypercall doesn't forward an address currently, since host
>   kernel pre-sets the msi_cookie. So, we need a way to forward the
>   gIOVA to kernel and pack it into the msi_msg structure. I haven't
>   read the VFIO PCI code thoroughly, yet wonder if we could just
>   let the guest program the gIOVA to the PCI register and fall it
>   through to the hardware, so host kernel handling that hypercall
>   can just read it back from the register?

We still need to convay the MSI-X address from the register trap into
the kernel and use the VM supplied address instead of calling
iommu_dma_compose_msi_msg().

When you did your test you may have lucked out that the guest was
putting the ITS at the same place the host kernel expected because
they are both running the same software and making the same 
decision :)

Maybe take a look at what pushing the address down through the
VFIO_IRQ_SET_ACTION_TRIGGER would look like?

Jason

