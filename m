Return-Path: <linux-kselftest+bounces-26551-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E04EA3412C
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 15:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E8DF18900FA
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 14:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF06E245038;
	Thu, 13 Feb 2025 13:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tIJ/Wgen"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F27245030;
	Thu, 13 Feb 2025 13:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739455079; cv=fail; b=cAuR7/y4cpOy1gHVrCobQ4M7XOQUsH9HTrSgQXxCDONzN81hGJX7F3FhkVV37zhKO8oEnSU8c9L6QVYdjBiabVwGg1SrXr8KBQbsiqMp5UG/IdIwOoGdCa9jAHG7RBN0+NVDJ5H8nqmC+UcBUB2gFuT7aoZ4wJIx6BMKqcHSP2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739455079; c=relaxed/simple;
	bh=Q6gsfjuLfOgY8lhI3kcs5BtJDTBUgP6NY4LOYP4ebdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PXTG+cdHTlnpCSukESCmT37vQ7zyx5V9yjuN9yVhwVTsdUQZWnBBNwQjIYKE4y5QYc1al9E595RdhacPkqiKydTxSKUt1qxHs1XMjUZqRwg3WwultyCGONLa+OjMOzxZtMdnJ1cP1w7IAew/2+OsS/tBD/BW4oPF8PGFX9tU7DY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tIJ/Wgen; arc=fail smtp.client-ip=40.107.92.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lYtthaong5eBDBsFkaZ7YHCxgmO/igMxlY2zqn3fUlRph/S3KddU6doo+U6hpjtV+/h+URkx+BZB8kOIxaHjo9EAk+iCSBT7cq2XIpV8yoY87Z4hxPIf2Bu+8x4JNy7JdpqDVcKOXDj7YFJ6KMlWchORTX2ULsSmP7VYVH2JMx/CkjWrL2sRBth5uFBIzPOQWsCj8rMyjiTbPpXwsvzAEmciwZQz6N9UWGRY1eI/Ug97R7XsNs4P4axx2wLkpkerLMtsZ4B3wOSlVs7n0YjIx0JEnwPGRKgML3/tLPOhZAk4/jLpd/o2ZJgJombGiUrQY/u71l4Ki44K5J3bhpPxEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+hoZLne4T93wltH42n2qnq/dWpRdPKq+sLPsjjS1/Q=;
 b=R+k5yeayHHx4iX7mKejD/SHq65qkhRxW8jiBQAf6TalspqrvjeXcfHUNVMsBm+WF7hxNUqzYI+daWel+98FAY+mOTIwGHSO524Ri0xjsDluALrtE48bfEoMc2awgBBUcky2CMGtmhA62xWxhcrifpNyxqgHU7Jke+WrNtgLER8AmerS8eO8yfQXVO35itnEoJPEgiomawQLddjvZb3EBXgCv3m11u4HWi9CnU3wxZVMlGdXesswI2v/Eh1O31gRL8yfUhCnBFwdTqKOod9vXOBClxY79mHzHypqSq9zLORxVpUPsGfdVIRsvfx/0SUhbw4KKgPlu5VK6mnhd1xPpqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+hoZLne4T93wltH42n2qnq/dWpRdPKq+sLPsjjS1/Q=;
 b=tIJ/WgenWz9/Erpvnt1Ut4bOluqG04/JiDqRMHjQE2skos8z2/P2DbBH/jn1S0z413qyLSylC5Jlhn3qWOwmWVpVsK3S6AoAyE08tL1DVo4HO5aqxEsTiDis+HQc2lbDnhlwSKGIDgm1Itzs7KTiFXTsal47tG+XCD1ckQHT1F9O3V3XyAvPk60K1BjwBGD3/hnkE2WL7KIqEEXl8GRP9PQ5WVHmtI/Lvj3M1ZtlJVv6bY6fU1vysNJeXvyOzIQNR5QaDru2wdMyxU49It4NfiqnJRyA6yDrUrAIQDsL/iEZLd7dyPvJCubtQZoC0TKnGgvk6d9thRe0mF+P7ZNTKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA0PR12MB7554.namprd12.prod.outlook.com (2603:10b6:208:43e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 13 Feb
 2025 13:57:54 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 13:57:54 +0000
Date: Thu, 13 Feb 2025 09:57:52 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
	maz@kernel.org, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, shuah@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	baolu.lu@linux.intel.com, yi.l.liu@intel.com, yury.norov@gmail.com,
	jacob.pan@linux.microsoft.com, patches@lists.linux.dev
Subject: Re: [PATCH v1 01/13] genirq/msi: Store the IOMMU IOVA directly in
 msi_desc instead of iommu_cookie
Message-ID: <20250213135752.GY3754072@nvidia.com>
References: <cover.1739005085.git.nicolinc@nvidia.com>
 <a580069c5e494ffffa668218b6fe3a207b01efec.1739005085.git.nicolinc@nvidia.com>
 <87y0yajc0o.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y0yajc0o.ffs@tglx>
X-ClientProxiedBy: BN9P221CA0024.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::23) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA0PR12MB7554:EE_
X-MS-Office365-Filtering-Correlation-Id: dbd6465a-8a10-4478-c503-08dd4c366918
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vIkudUJLFFbTvTrl6esEQQ20lAJ9artoYilah7u9jHFVZwJaok3ry13Aoobf?=
 =?us-ascii?Q?k7HgO9B1AyT8kjG6VQYbvdNBosKTvq+OiSmE8UiasATN2ZVcWqA6yyQeKIXf?=
 =?us-ascii?Q?hD+yuH7JCU8U4uTJ/FQ46SdwskPlA6T5dyigFp5gagWQRyazSYNkj5tvosZ4?=
 =?us-ascii?Q?cNepW3X0wIckdCI33I9sjf7VBcqKY/umwo4zUem8VkRdUYKsvNjDLPHk1NKp?=
 =?us-ascii?Q?kDu/jZcDPLhbjA2TY7xGflnLEyizy6KEOi+r9GLdz/UxawOp2jXtRI9lJkjT?=
 =?us-ascii?Q?MVqkkJlV6+7rCOwbCTOUr7jxcB6nJabJgJECHssGE8TPmA5gfOxOwtjqflBg?=
 =?us-ascii?Q?5kv44OK4fbXJpfAi6gtldIKCdq3e4MaLoqi0jmWxGMeTmtTuMMQi4KPd4M2L?=
 =?us-ascii?Q?r7jBEj4RqBR/TK9BtLQXw/ob2Ht3L8nPub61nWPEvevnQB0jZ+mK4NeTTmHg?=
 =?us-ascii?Q?WdxVRIUtzOrJVHNGsR5uhSVqEzeAJWX5boO8sWdVdV3LaZiOC3Bb8TRhunKM?=
 =?us-ascii?Q?lSaxsS3Gni+nFpJyXy8DUenqOHs+kao1Y78LXHXEei6kZmCc41A+/NpM+S2h?=
 =?us-ascii?Q?37koywZrtBdAKVDqMZWalumdi9KW0boP2qY9WpZP96U/dllSEOVA6pPz7KT7?=
 =?us-ascii?Q?2asCIVtR0T5rB3GJnTXPquOKKWyWIekQHSckuXb1JdPkullfNEFA1Wakeuu5?=
 =?us-ascii?Q?SBaYM+EN1t0pSvKbcYsPnp9EoN6D9SgLlUfCvPYE/BxzOVMWgDEKyzh8BiCC?=
 =?us-ascii?Q?KHkOCp4BBXYVPrXvYO8trcAS4t93a5ivSDOVWIPcGN5qTp+vmIakWDKP1GDS?=
 =?us-ascii?Q?mbTI+Xio6+bF50eWDAwJTrPz29HagWGM6fTlWJbAHu+op98FprOvW6GSKao9?=
 =?us-ascii?Q?i92eA1+0Uw/VaplLwQCNll49wG94qufct21luqJz3zLMXKdmrEFHdY5RrdcZ?=
 =?us-ascii?Q?jnLTnKWTFqV9NBb8VOHk9fI/KQGPctmhIbfpVJq6ArAWcx9a9Ku2kqEndvGx?=
 =?us-ascii?Q?SbcmPSjulCawKk/uuzdWQ19Nyu31+joFlstiHfDHRfLFXaLmge1GLiD7n5fZ?=
 =?us-ascii?Q?14QSa4id5CKqWi7tziwpmIwT/T8Lm0RZdQJHiGtHtpmN7fJkjDuYM9DptUmW?=
 =?us-ascii?Q?eUs/07D+gdz5imipEcaovIj37n6y35humtpS9VyUemAGJEiiULh65AmLSapV?=
 =?us-ascii?Q?ZRiyOcSXuKKaatjVs2JcaPM06DFfiSAEjTXGj+mg38xYMPmLv3b4M04qpdNU?=
 =?us-ascii?Q?ObOKCeXjp2DW4SDcBZigRgD8IaJlgLGcISloUfdp1LxYvEY+IJthO1aQsvTV?=
 =?us-ascii?Q?WiwoIA6fj1Vp/7/4Lmrq3j9MjpcB041+Q5lCMmxJpF/3DinEYWBQKfCwimHe?=
 =?us-ascii?Q?SPWq8fRZmfw1wp/h6WS2OwiHun49?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r1YVsyhqsVxBF48OZB1CCP5dFsCBo3wNNUEIl7KdynwEZUqoFh+X2KEKuxZH?=
 =?us-ascii?Q?3Gc3RwIMwQvrWfaOHyVkNDgsw9cJk5E+E3t69j7VeEObCLekY//5NJqkLEYR?=
 =?us-ascii?Q?lfR8BD3aoQdVJ9MQaIZVYo0JZrF5A3BlPM/JFNYr5CebjuO3Dekr6K3jgk4N?=
 =?us-ascii?Q?q+H8uMIZoVHLT0C1PNBnFla3cTblraXN6drVMnuTInTR0KIdpRwJD22slEjn?=
 =?us-ascii?Q?LoMpib+Dfh4BMba+B5Fk28hKI0r0gjp/rTbcH3fvFFJe2J0zXCTApoDH3o/l?=
 =?us-ascii?Q?QUCphT3Ao88Iegg8xc5pDiq4AGSOpwD6u9zMbeNOA7XzuwH00Y9mCTXxgRu3?=
 =?us-ascii?Q?rEQskLIuDEFsPlF0LBQoN21/MLmU7ntabXfwcIIhZW3vPPjabD4F4FiMsNSG?=
 =?us-ascii?Q?ISyO0H3cpuCssLsJnx8IlMeNj6s+GcNH/DhclJjhkFNcdDyDVq2y4lDMadl2?=
 =?us-ascii?Q?tvVGBNOmZptKmf8UDAiWTQNNRxruP/Ejj9KwjjIddV78qpxcipNGk1Rm783P?=
 =?us-ascii?Q?mUOzZ4COy/OE0Jp4o0LUSo46CderFW//VU3Yp8QD/Uqj0DeyRykG2nD9LKNH?=
 =?us-ascii?Q?yTuEgBPGtTvH/zMMZuR+HLHkR//oxYzzixP572UondXFM4H7W39P97O9pzQo?=
 =?us-ascii?Q?JVwRPrnQQLOnrLojsEUmvbQ2cbh3EzTJ1x9C95HNLnPbsg4SLmbAGMjJXY44?=
 =?us-ascii?Q?oHB9OiTT8wjXCr09VjmKshG9xAye/n9G76hUftQMYXxAgA9SeyxtrAypImpR?=
 =?us-ascii?Q?4LoiR1NzmjeSlbZ7JobfT/o48LZMrvpoiD75oNR4AQ61kRrrcRjloaqxXWFr?=
 =?us-ascii?Q?mHgyhafyWoUUhi8C2qPoPZzHxnXH8hdjlEghC8OgV9JA7vay2VYnlod5egR5?=
 =?us-ascii?Q?JiOOddUJVbVNSX0u4HIJe84aBbsjDhtXrXLC+yqZTlq1kCBe78OHR46z7N2Z?=
 =?us-ascii?Q?QPO7srVZeyG4eMElmJKs0wJ3YQDsSReqoKqthkERdNrY27EVaczM3tuk0fjd?=
 =?us-ascii?Q?5gMCM5PUMCfyJZQfX4S0dUEhVu1k/FFVvUAvZmKp1sa8ce92nShnjskrugJT?=
 =?us-ascii?Q?8/tHmkMr/zRahgzQk0CcNW/qEBz86lqAZ6hVYM4JDjMY0HZ/JTGirYUtnfsT?=
 =?us-ascii?Q?vo1hJhqe7FjjeGJCgOZFm4Gq+8IE6oato/N/otrdI4bF5KMxo+G8VpqM6myL?=
 =?us-ascii?Q?A8RX/lUFNGPLNClX85iwlzng/j+WmToKq/byiLaQ37EuwZ5+A0bh4iHH7Qxv?=
 =?us-ascii?Q?zeJPZ/LIhIWP7bbW5ZDbNg7unlXy03GuIS+QSOXPQ7sNQQg3lBFDbxZdAtZi?=
 =?us-ascii?Q?nvU590mJemlH5tVP4LqXnDCmupKHkCmhlp+GpiNgwxHtPS77EJOxSusxjBKY?=
 =?us-ascii?Q?m9LmJtAkpQe8Jt0HSHz8t7tNjC85xhENPj+ZSGi0XWT3kHQDhr3E7oU8KR+F?=
 =?us-ascii?Q?DjhrjQZZFAdy52PwB683eZxLuXDi7nY89O5Hw9M/GeSq9VLa2Y8oh1T47YcT?=
 =?us-ascii?Q?O6NTml6Zimy/t8rJBNxv/YZbbHMI1cDdUbVH3DYdk6zlHGqxETRwXgga3XvS?=
 =?us-ascii?Q?i3fNneDjmUFd+1IzmnI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd6465a-8a10-4478-c503-08dd4c366918
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 13:57:54.1665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fXVPyjrwkw/JZ+DC+huYP9c8qWtMg8alAALF285hSDi/e8QoCAgVOzE3ztj13X3L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7554

On Thu, Feb 13, 2025 at 12:54:15PM +0100, Thomas Gleixner wrote:
> So this change log really fails to follow the basic structure:
> 
>    The context, the problem and the solution

The IOMMU translation for MSI message addresses is a two step
process, seperated in time:

 1) iommu_dma_prepare_msi(): A cookie pointer containing the IOVA
    address is stored in the MSI descriptor, when a MSI interrupt is
    allocated.

 2) iommu_dma_compose_msi_msg(): The compose callback uses this
    cookkie pointer to compute the translated message address.

This has an inherent lifetime problem for the pointer stored in the
cookie. It must remain valid between the two steps. There is no
locking at the irq layer that helps protect the liftime. Today this
only works under the assumption that the iommu domain is not changed
while MSI interrupts are being programmed. This is true for normal DMA
API users within the kernel as the iommu domain is attached before the
driver is probed and cannot be changed while a driver is attached.

Classic VFIO type1 also prevented changing the iommu domain while VFIO
was running as it does not support changing the "container" after
starting up.

However, iommufd has improved this and we can change the iommu domain
during VFIO operation. This allows userspace to directly race
VFIO_DEVICE_ATTACH_IOMMUFD_PT (which calls iommu_attach_group()) and
VFIO_DEVICE_SET_IRQS (which calls into iommu_dma_compose_msi_msg()).

This causes both the cookie pointer and the unlocked call to
iommu_get_domain_for_dev() on the MSI translation path to become a
potential UAF.

Fix the MSI cookie UAF by removing the cookie pointer. The translated
message address is already known during iommu_dma_prepare_msi() and
can not change. It can simply be stored as an integer in the MSI
descriptor.

A following patch will correct the iommu_get_domain_for_dev() UAF
using the IOMMU group mutex.

Ok?

Nicolin - lets change the patch structure a little bit can you adjust
this patch to leave iommu_dma_compose_msi_msg() in dma-iommu.c and the
next patch will be all about renaming and moving it to the MSI core
code instead? Easier to explain

Thanks,
Jason

