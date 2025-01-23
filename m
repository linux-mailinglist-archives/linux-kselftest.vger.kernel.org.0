Return-Path: <linux-kselftest+bounces-25030-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1BFA1A9D5
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 19:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E23F216389D
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2025 18:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB70415746B;
	Thu, 23 Jan 2025 18:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ur/uM5g/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2080.outbound.protection.outlook.com [40.107.212.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515BC170A1A;
	Thu, 23 Jan 2025 18:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737658207; cv=fail; b=Zby+f1Q0HEivbDN/FdZWch7U4UDK8CwpHPfkeTmb931tL1LmOsmprBDZzqqLuiQQVew5LVGgncslUk6SH5plgeRRjL7QzbLyhlet4gOyvzJJFIfEdim1ZiICG9HYsY+im5k7gnqZizZHzsI6NDpTBtYlzOzlDT4hi8jx//TGios=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737658207; c=relaxed/simple;
	bh=sRuRUeqUS7kcLLvjupqEN7t+4p5yG1f4A4//v0ZkfWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NFKNLOQz9sjCgYCmvyuXPYkMAE6oR1EaipGz0IAMQ23uBShVMHYlIFwqqi6B14YejqXxUwGXc4JBXQ4Xbs4GoRsMNbEi9MB20u7P1XtZCFWHCnw5fWGCVBDvXkp5HxNXNAHwKgjGRNkzrzSwawtFS6oSMdk/9K+8XB7boaDmerM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ur/uM5g/; arc=fail smtp.client-ip=40.107.212.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JmNs3tL6Xq4VJd7m8y8keBs7BzH0ra4rSBjzBNzvwAldfg76TkLitZ0Sh0DddC/9AC3lkbs1y+8mGpGBnnibVBXMczk7rq9HW/oRA5XzFufA5nubPrkI22YVjIW1LBQpeV7DB6z3T5ct78oiFF3a4GuDJQRXSoSWop25aeSxKHDanMPXLlcFtsbEVwaAlyPv3TqKDw+ZALNbhJ+/SD8IpjW8wLo5tqJOg5djQsnWw61e/LFYigm4+R6Kl3/7x5Yx+KHIkBvKoaGDl10UCXBdJvx81/BnY5NPy8htnXsONE7Sz0ghbjg6zgAo5O0BcD5U8qQm/OPTVomcf+mZ9BwvYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1b1Q8GmaSF0vEswf5jRaS2PZltp1UUDo3HsfwD/dx8=;
 b=UPEb92ZxJS+5Q0+UxCJ+SlIffa4k4S6dgKcVf76eNbgl/d0ryxJaJevvckQufPIhcJOGZTFF98d4+V2tNhzWgL3uZTDdXDTPFEqwOfGOv7pSe77ZjzlbP9uKX1JW5snB6mvV2E5WQ1LK+PUp8192ZKXITs///lpHL3hoHQPthbj8LCE59Bu2kR2wzbdiDfJDox7EEQHb2oO8HCQ3krt3Q3azifA4Q/UCvUcQl+WIu6O+mVVJrBruhDwRRkxSuLdsTHoXrhA9FR4Z1up4GPJuwPXcl2tucy7LTznVcOffZzxSUkWJPmbfBfmzcmz1eRrrg4T1g1nK2QEWS+snDSasbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1b1Q8GmaSF0vEswf5jRaS2PZltp1UUDo3HsfwD/dx8=;
 b=ur/uM5g/ANCR4TeCI6Lv+nnidtzaMSsJdQWY7tmhn5mLHFPNbBeM51kF22P6UxAj/qwZSnIe19osa/Ok5pCuDvbLQAtjFtnWwnaItuvwDpF6thJCflDAAGTD9Py/jf+9InKDMw6guTv8AGPq13Gxz86J78jVUqo3QbPgFYqZFTa1G3jWQt67GRhoLGgDjeX7eEKUCDnGqJOY24MitHWKUk2HS9vqJ/f7cmZsVc1ACMjvPXG4cXCDvygFuUVUSbPcI6AmFdd/6a9V/euV3CSFKzzNO3d5sqUlRewp3rwx821JUmTTqgKWgCFzCX6+a9+YgqI5/Kl9T32RsOFXSF9U8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA3PR12MB8437.namprd12.prod.outlook.com (2603:10b6:806:2f5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 23 Jan
 2025 18:50:03 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8356.010; Thu, 23 Jan 2025
 18:50:03 +0000
Date: Thu, 23 Jan 2025 14:50:02 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, kevin.tian@intel.com, tglx@linutronix.de,
	maz@kernel.org, alex.williamson@redhat.com, joro@8bytes.org,
	shuah@kernel.org, reinette.chatre@intel.com, yebin10@huawei.com,
	apatel@ventanamicro.com, shivamurthy.shastri@linutronix.de,
	bhelgaas@google.com, anna-maria@linutronix.de, yury.norov@gmail.com,
	nipun.gupta@amd.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	patches@lists.linux.dev, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com
Subject: Re: [PATCH RFCv2 02/13] genirq/msi: Rename
 iommu_dma_compose_msi_msg() to msi_msg_set_msi_addr()
Message-ID: <20250123185002.GV5556@nvidia.com>
References: <cover.1736550979.git.nicolinc@nvidia.com>
 <242034456c0bfcd7ecf75cb29d8e5c99db0675d6.1736550979.git.nicolinc@nvidia.com>
 <fa9b443d-e068-41bc-ad03-9f04818c72e0@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa9b443d-e068-41bc-ad03-9f04818c72e0@redhat.com>
X-ClientProxiedBy: BL1PR13CA0002.namprd13.prod.outlook.com
 (2603:10b6:208:256::7) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA3PR12MB8437:EE_
X-MS-Office365-Filtering-Correlation-Id: f72c4579-7850-4049-dc47-08dd3bdebf1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yELQgnN1FMny2TrdEJgKxUKVt3hKtjxqggAKg2hv08MlUldMWCt/lJJgHkIf?=
 =?us-ascii?Q?vOT8d9m9qJxMUJ8AqfJD2FM+3IMQVpMBaMjwXbGZ4yuFmgXLnldLaZjBCpiP?=
 =?us-ascii?Q?PEnCWu38v7n3052QfSPT6QT/ytTKmMJ/XH0YeOdTMacSGbFOJLgPIHemeH+S?=
 =?us-ascii?Q?pPpiqRVf7NGDoxIoIonQ4lsJFbT0yjhmVBkFaRJ1RMWJGhlN33YTczzYXahR?=
 =?us-ascii?Q?JB4VEtG75I/aRQG6iREPc09NFtHOoLTfkA69MIIm1RwUdJGzRctulZIYy48L?=
 =?us-ascii?Q?OR9c2VEBAi2Ejs2aDlCS1Wn8xwXGNL8cSUwtDAzFISraqk7bDMg5065dTC/l?=
 =?us-ascii?Q?Uyx1Nm+K3kW7FEAtGbQQI1t8C/tj3j3uw9C6oLQgDERbcCI3L2VuBMvqZTZO?=
 =?us-ascii?Q?6HtYgXHPAtUfBSwi7CFDWqOv4O8wZ0c7DWUJrwWh0hPrs4E+q1wyiQSjTe2Y?=
 =?us-ascii?Q?/tFFsiat5ZporpMJk+d038XJpik0OjKoZJOyKIcTqM4K5ln+ioWQfb0pjvPa?=
 =?us-ascii?Q?ExJHELL46dQUVCoBx8hagS2vlyLxJu0GJisdH68053dootaFhX5BfPgIYPOZ?=
 =?us-ascii?Q?m79zf7Ju52/ElZNbvtTdLPvt5cgzc94WvHqwtLT2+EOQR40IU4kx94NCpqmP?=
 =?us-ascii?Q?yCuajStV75r70EPdQ475iYOzQ/S4Vdk+XijpppWI2wIl++5gL+Pf2F+zV6zK?=
 =?us-ascii?Q?2kqHwGwFSen4yg0HDIC3tj6IG1cYVlq3kOs9Tmr0RjAZBJYzaRvgtvqE6uyD?=
 =?us-ascii?Q?ozcwodGoj6Nghz+j9i7KfvB1SbJXoMV1qCKZd1VaAg5Bnm0Z2Ckh8Lu0ePgP?=
 =?us-ascii?Q?2BJQuOFIzXWx0KArtfvXCxXnl1URuz5UrinJwTaSy1ZO4+QTFTMi/FeATWoO?=
 =?us-ascii?Q?HGalFpWBkszFxXyhs0lKuCzOw8CVO0Mu6qmZ6z58nwpJMxNw0gJQMdR1ICJm?=
 =?us-ascii?Q?Jq2zVqrqou/MUgFwIzu6GcJNnoXFomqNVBPhsV3CbhWfPkmdl9kKftNmx6DL?=
 =?us-ascii?Q?YdJN1dyLg04Fuwkqaep6gq2JUXHkAAnnyQMjtyF9ots2e2Dxpbc77pYFjR7x?=
 =?us-ascii?Q?KqDO2mO5feEwjfAk0X2UNRjpHUQIA7+AfsOphOwXLGbbuofyYKy/libfHR5V?=
 =?us-ascii?Q?+Y19+M2Igz3RXmHgW4PTcTIdHksbe386VBFGySHlhrPWzDDOwCwQHg8Nlu4v?=
 =?us-ascii?Q?ZF21Wt0lFGVv4zlz8RZcK8Mb3vx20ZtwJLhyuOfE1dYxQ6KHgbK0mKOOBq04?=
 =?us-ascii?Q?l5StVj2YQAYkcggJYIvHos7967H4NWrcHnyziOjlfivpm3Rsj+eXFss+28rS?=
 =?us-ascii?Q?raBCVoA7GnaAGpq9vEi44pWdCugAtbbYUV0IcJrPnr/jwDjUNorEGG4ylovn?=
 =?us-ascii?Q?tr69z6/0N49jdpycDVItIowE5yTO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pG0x440yM0Zllv8u225NZRNTkbPqXkXjkeGTcVGomBsUmBdnITXwxuHalfz6?=
 =?us-ascii?Q?BAE+q+63zPnnCsHeYibaZD1qdlldeZUMVs3yQtAl2jgQs8b1vLeS9RwNjppZ?=
 =?us-ascii?Q?3Z087iwhsVIAzi+SbV93VOmPe4RzNU4NXyq5avhBIBKAgVT02YUU8DC8AInI?=
 =?us-ascii?Q?WngqMraSyKMCkYZsf+fI4RN1IgbJezGHCcXXI8YE7/5srAFxGP8otvqHlGdw?=
 =?us-ascii?Q?o4nxvMrDgdbs5F5Z3Q+Mqgtkv+AF7wtbCGfMDkbE4lHgtz18ZFw7L87NXyo+?=
 =?us-ascii?Q?ddvI9TiR0JSIqEblaF9ESshGXHUJL6C6SUYGSnEmWbzMYSSLaM4tJkhKoWwc?=
 =?us-ascii?Q?p445m3EISpvfEKMHX6+QnYFmOUdcE9DZ1JvohShyrtlPGwSwc211s4u5ZCSi?=
 =?us-ascii?Q?p1u60CV7W6rWgh34Nu1EpEM4nxkDTPQ+wmU0MRmkqaID50jGRFSZhKOb37jz?=
 =?us-ascii?Q?xf0Hv9hvgDL0irzJYHABrMuPvhy2SPEq+oCv1GJDWDo2QiPvX95AsECoqrsc?=
 =?us-ascii?Q?/aI9ml6FOFhNBQYessGwBZq3k17eLmheQoRDxQCRLRNTgC4gdZyO9l1I4wYr?=
 =?us-ascii?Q?zZgfnoH/IPDwcCGusOempKNIwShHib387lCrLKARmhCsPqfdHPR748zZLp3V?=
 =?us-ascii?Q?fxqsEAFGllZ1hw3fK5u/q/N2JF+kacTgoX7D8hnyZQdpLWz2LV4SVSFGRbs/?=
 =?us-ascii?Q?1S2iTyD8ccRd1mtsVEoXl3B4MBxGUrEkfn0wRHUzdgObj6i9sir0S82vTXJy?=
 =?us-ascii?Q?WRPgogaj2u1UuSDT+s1MHyu4wFXB+/72lfjdiTDrBd7VaLoJOgSjdPfxlVn5?=
 =?us-ascii?Q?wOF70jC0jC6CMf0jcGeoDuSZT11CwzMtMCPvyVQNYbcmUzjaDJsM3S9KqWM+?=
 =?us-ascii?Q?0Yf09kZR2KKmOw08+16sE6WgtREkP6inCwtoVxh9PQcCPeFLUx3doPiT9NBq?=
 =?us-ascii?Q?vAvWQOJEQg4EAE1D/Vd6N9lLfDP68uPQpn+FcsViXC4YLUwkOXQU4XvFCcNq?=
 =?us-ascii?Q?jZQ3p5RuvEyLAsMh7/hK4Lxkrw5aPYeffabXmusvQPZFsDZ93Kn4DpYF0d5Y?=
 =?us-ascii?Q?+5R8ZzL5F33neaEAigbgBovvz521I1ojkhJrDBqB3FlnISPv+rUmEkXRjqoo?=
 =?us-ascii?Q?3WyMF9a4eDroteA0nCpSIv2WkKfcAstRoy2muZOYwMcTgW0ex8ikNb5KZwZG?=
 =?us-ascii?Q?yPz/gWBNYPgP9BK/XJtfRSJ9tAWjYxpBKNnEJcpXoujrApay7aZc6ksryu0z?=
 =?us-ascii?Q?TfVx3IZRXsY+MKAtkyBbL3y8pa7JBDramIeBCZEvbxtsSB3+tc4ooh8l+Gb6?=
 =?us-ascii?Q?Ovz7fhy8cct6T9tG/0Rth1zXGLVEfIAKdvtfuasb/iqUnfE1p+B86OAPlHkm?=
 =?us-ascii?Q?qe/uDiJOZZhO3st2QE/SP66WXNLDUTBes96cVKMPqxCiVYIPe+9+Sk/q/bfs?=
 =?us-ascii?Q?c1oiBB7Z8dM6eKHJ6h00xsxdUDLUnlTmoybYibihDVurw9AtfqmOsayJBh67?=
 =?us-ascii?Q?JOlNi6uTNN9b75VHedPyzLVW7M2sjX08810tyDPmKA9pZjjO08XKV7JAvNWU?=
 =?us-ascii?Q?Hes7iNHdKUi6gb5gdDIm4MSUSf9QU6EW87e6hRDZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f72c4579-7850-4049-dc47-08dd3bdebf1a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 18:50:03.2800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4XbKEvABu4/8zWLDeT/LpAZlrcr5qLIthsDZQX1MAhIoSa8PgvmQHofRxXItgXgk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8437

On Thu, Jan 23, 2025 at 06:10:54PM +0100, Eric Auger wrote:

> > -/**
> > - * iommu_dma_compose_msi_msg() - Apply translation to an MSI message
> > - * @desc: MSI descriptor prepared by iommu_dma_prepare_msi()
> > - * @msg: MSI message containing target physical address
> > - */
> > -static inline void iommu_dma_compose_msi_msg(struct msi_desc *desc,
> > -					     struct msi_msg *msg)
> > +static inline void msi_msg_set_msi_addr(struct msi_desc *desc,
> > +					struct msi_msg *msg, u64 msi_addr)

> nit: msi_msg_set_addr(ess) may be enough as the populated fields are
> address_lo/hi

Not sure I follow, you suggest to use msi_msg_set_addr() as the
function name? Seems Ok

Jason

