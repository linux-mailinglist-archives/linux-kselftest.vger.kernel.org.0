Return-Path: <linux-kselftest+bounces-26000-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9388DA2C54B
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 15:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 271C51678C0
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 14:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D063923F288;
	Fri,  7 Feb 2025 14:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LWp+7IDC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384C323F267;
	Fri,  7 Feb 2025 14:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738938625; cv=fail; b=dmHKjGxJtoWa7Ia+WUkWgp7+A/w7fmlwaHh3mA+tMM4eoJaYPBOAtCYEdxQKX3PfPTQ6aZyNdatp+hknmCFzN2ggC5nVpsXbImXyNutNmA1FV2DLU2X+x0mocKH3WElw1y3PeWcs3+8lrKnMO6vXr6YuEpX/1Sk6rzV+OwxATvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738938625; c=relaxed/simple;
	bh=aeAHGan8frRSOjjQL9eaRiVKAxx9omZhXzQzeICzgTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dTb4R4vw2HQwZkmWh8PTZmWY7hVPcnsCHx4t5uVV0IVUCTzTgAfLtUkbBJCFAQXxZvzPvM9g5/OITTuku06Natl+PY/6qbhQutj7eh9INM3EiOmYFV/ysCRyO1vGgaa1WH9zkYYFKvypOjHTNYvWk7wwjcabDYlUIrIxyKKRpkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LWp+7IDC; arc=fail smtp.client-ip=40.107.243.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x3P+OJSqv3UlgMPLpQMLVUD164LSHByz4B9WO+JTxwDNVNAKVaxAl1Vn8gEDwYySYTvzJr3NclQqtTExy7nwJCUlEf1ppIvzzgooBG9FJ8xezRy1lIWpmM6DV1fxJw08TLw6UfrmKtPiBnxf0b4kNnl/jOBHyo0Ud7VGK+IebsuMpeF/8Ex6tbW3y1RGj2WMU+KSqMXI5JHYL8bIu0NFE+D9Qv8esRUcrfi+b8LJjpU2MEFvjlHNUy+dLvgdz6gJcaqVbdfXq9t45rRffp0EK5Snnw2N6C53Ok1H/wyBjGm3Fx+rqNEiKM0V7ZNVFtGD2d3Pm1hyrlUNNc/sVHDgOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipOFZTxOZxoj16RgTXZauS2etwkMx8gyHG2OFMi4LKg=;
 b=eSBQ5ezaVRyXfJIj6h7WLy8T1PJv5telPW7h5Jw98n/HPgXt6vWWAW0zCexg5V6K2tF9iIfqoLLwJC6tAekC2axsudpSL413S/sevUFqhCKMwyKn1u6zOQebqqe4qDU6mONo20O/57WmD589tVfVMx8ztHygwhHIa1dAiEN6vox0Ut3wg5scYMRe7ipubsUNma3au2ehb+Tvcel97tT9T+LuapPWx/PLzDE/ynD8rgitEQEqY/pQYwaL+dRyzS+4YoquHkC3bwAOtRLLWBkqf0iu8q0kqbE7ae0ALuVPbQJVqnW5FpG4XnpQi/eDvSSD3uV5S5nWB0OI3be1W7O2ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipOFZTxOZxoj16RgTXZauS2etwkMx8gyHG2OFMi4LKg=;
 b=LWp+7IDCJyQXRTJ8ssjkFgxZXnn5pyw4lg6X6vkfN8+FFNLDkMdVNLKESdoXPzKNZnDceab2jSff7rIdhcnam5oJnStageuAzDaROsMjrDd9gQqA2WgZJrU9IO0nT7xKgw2pHeQDLgavd9grJPSm0LwQDmnO4gn0C1AJqAjk4SaAVRoQGEX9GoexpYIiGG7QCEb11scoBjDm64klsloU/8oPURMLeagik5Y9UF3Kv4dJIVrFn67+CPScIMFarHiQvcpmj/77wpHqMUUCvdajTjyAJeIHabb32w6Q8v1UO2S6N71KOFMqFguVesCv/kWsJ3f8H22LKSpL+lT2nGbs2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV8PR12MB9420.namprd12.prod.outlook.com (2603:10b6:408:200::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Fri, 7 Feb
 2025 14:30:21 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8422.011; Fri, 7 Feb 2025
 14:30:21 +0000
Date: Fri, 7 Feb 2025 10:30:20 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Eric Auger <eric.auger@redhat.com>, will@kernel.org,
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
Subject: Re: [PATCH RFCv2 09/13] iommufd: Add IOMMU_OPTION_SW_MSI_START/SIZE
 ioctls
Message-ID: <20250207143020.GR2960738@nvidia.com>
References: <cover.1736550979.git.nicolinc@nvidia.com>
 <d3cb1694e07be0e214dc44dcb2cb74f014606560.1736550979.git.nicolinc@nvidia.com>
 <0521187e-c511-4ab1-9ffa-be2be8eacd04@redhat.com>
 <20250129145800.GG5556@nvidia.com>
 <Z6WLXTiYVzuN368E@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6WLXTiYVzuN368E@Asurada-Nvidia>
X-ClientProxiedBy: MN0P223CA0028.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::17) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV8PR12MB9420:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fd856ea-a7bd-4702-218d-08dd4783f398
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1EM23bpJ747+QvLN+70Zi8PijeL0eLyAyfG1Ztmx04KWrJ5UhLaB8VXQGYC7?=
 =?us-ascii?Q?HYYj59Dg5Lx5OPw1dpef6mUs+R2wep8+aBP7OeMgui/CApS1615gktjmU24h?=
 =?us-ascii?Q?QcpUNVjGPzckauZPfUXvI+HUXBphWMw5fCgFHfKzpzMDGTDH5WO/6QnV7UgL?=
 =?us-ascii?Q?X4tV6+3Np+5BtN9EDs3oQLafEeOMbYJ2nrMgNwrUCoKrfNzh66Z6JwUfjr0x?=
 =?us-ascii?Q?CUItOMX34Ayh1TVHUcSI4YqmoOZFnSVsygclZDPzP1kb08JIW0lovbBsdO+P?=
 =?us-ascii?Q?qhRJofDxVFnGrCYmCIvvBSf5869sQRX0QVB8afbN/HD1J4mTH6DOI/YqWDPf?=
 =?us-ascii?Q?+nU9qnkVbeYmwFKNhDH4BcabC3B+5QQ4j1Vm3WmfrXhreqp3MAQ+XmGRw6V2?=
 =?us-ascii?Q?yh5jligML9o1CX85nhCk+GYxSKRBfLjw2OKUogXOx5yn8nVNhtC3IFQxL/LI?=
 =?us-ascii?Q?FiygTvkwWGeTMT3FxvYhdmI4a1S6xoIfsI+JQ7i6FJPt4tirCfTL1xTLYL3S?=
 =?us-ascii?Q?VtGQMk77MrFwCSrY28JRSnLQ+fA15Cn35eA+CcmcS0kWUmEauWSVl+Z01Zu8?=
 =?us-ascii?Q?0My6I3zwLPgBDZ5baB0J4j9g5a97MHPl0d4RcF06EeFYiAN631aMNYj4pDr/?=
 =?us-ascii?Q?lMAJnxtEbExpVf42IHm7a4lNwL1ERDbELHwjr+R4+WbZF5hYkWLeJEmStSxH?=
 =?us-ascii?Q?CRsy7XCz5YQLeFOJn921HT3URiNbCecAPo2Jdg/0lCvoBahm9e3Ou4bRgPaO?=
 =?us-ascii?Q?MxvYWsX9HAqgh7azj4mXcIjanYsoU0KW5epqr8ACVbeIeoqYOF6Yhy47hRm0?=
 =?us-ascii?Q?JnlW5+NlSfFz7dJcI6L3UBf4W8lbkPmMxakHpsEz9K9y+Nlg9NpIWXWvnXe6?=
 =?us-ascii?Q?Rus+Uu2oDuNQXe8Eqww+2J2RCSOKcPs8dZ4cllqeKFXrvosFFo+5X7ezyRl2?=
 =?us-ascii?Q?Eo1/H534E3scICEgWWmgKTg6UmV4p+3S2y4DjFOuHSUtEMUgggayIxuh0zYI?=
 =?us-ascii?Q?OIMbeVmrXTMFYOkgIemIA98UHG2dAKacT8wNNkSUP6fcvgCfnvjkv1MnFxAi?=
 =?us-ascii?Q?/tW2cmKeuvT5oHVTzkuTx4lWIH12XT9uhB1g50XCc5fdMmqUZ4n4YGTCl7ZW?=
 =?us-ascii?Q?XXRiGjMAIPLAQ0r51hh2qO/QnLGw/rdGxW0P3EiC4wcXpvOggxYUG3kXh99T?=
 =?us-ascii?Q?uycMz36WGg2EJij3OhM41IyESO+/1kWri0b/JlbIOE4CySZ0g6LOF30V9F8E?=
 =?us-ascii?Q?gkAON3WgRjlraII6bhGL547hGZIV57i69p3LSNBmK724dBs79cHrMMIGRFJq?=
 =?us-ascii?Q?11A2iKzb1KLSNUKavEOGHg4VEbw+g2vMSGRzUeZTLOQtyMoSo4rgBIWKMvYG?=
 =?us-ascii?Q?e2ehri3l4KgBg5kIqbtgLO4xW1Sz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W5pdmYCtMkO5sWUb+fl0d93LW7XDodof8+cGPnIhAB2tX4j1Kzn1Vti2qu7U?=
 =?us-ascii?Q?XcB9slYzc0Vx/Q/mXv2XziLD3TSVLsvWouCKq+O3DBa1FmBMDu6tr28hue3w?=
 =?us-ascii?Q?9U4nqOp5CMXs5b54LTWepFn7wMtA7XKuOH7aIrfvuoJmkc/yqznxLp36dEOc?=
 =?us-ascii?Q?27aEz6FMwiDwoiKjdm04sTzIMry4Cdi2HqdbSo3IDsjBwyaIqfvXaDEQwKf8?=
 =?us-ascii?Q?hRoM6DvYdnxfxTwwjrV5ItkK5dU0G6W0+ksSM7IBvUr1l1uWGDiCEYKuQFdZ?=
 =?us-ascii?Q?Zh5Xs3T9upxPbYaAz75RvV1g5GKBIfhgbWYEWll4nqoZImmSQGjlFw725B7P?=
 =?us-ascii?Q?LTyH1zOFrrRVotVKI4oTzgpqQvavj3OluUYuF2auu345nzF0L8844xHAS8dv?=
 =?us-ascii?Q?qJ5g1dk0L5rr3pkSkm2MxVuiE3AqRUNb+z5NLrAUxreJudp3OY0SDNLh6uG0?=
 =?us-ascii?Q?jYJdpZ6YR9rh8LSHHfoYyf5XlgOB794Oqck6cj5Mi6UoJa0FZoFe81MHOxri?=
 =?us-ascii?Q?tisH6Z994BaksePb9/tyncgpZoVYEfxMZjEogovvgaC3srKZeBEq4D7+mvp5?=
 =?us-ascii?Q?zLe3mXov2HW+0qq6pUzSszT1c/kjuIQaDbFmpAJ9b0KpRvPDK4uoziYJ8SxH?=
 =?us-ascii?Q?OJAANypuVns8POy+nbb3WzcW0rqbuUktGnbvUSxqOujh+3njiEML3iEofkXU?=
 =?us-ascii?Q?+akAg/mCx8SvCQtRz25ZIn1Cmc5wGWRQpp+lD4nHRIBhExniOMoEBnSfXIsq?=
 =?us-ascii?Q?nIXAmgDfQPUFaO0vPr0GEn990coj+6GzPQ3OOotbVNAwYCr/b2kKbgaCnMey?=
 =?us-ascii?Q?5GzOz0uhiz+p96t/0LgP/wjTEECWi29slI+hyArgZeFW0FkW0GhkVwbLE8ak?=
 =?us-ascii?Q?+kjpURl3CHEKQlM4FkKoK3YBZoKIHPo237xieYOkJ2bi85h51mbJ07c20bO2?=
 =?us-ascii?Q?QDipiZ8zncj8dxSsJHNmTNAp79F7qcLaoIJUr2i8rhmGgCW+NtllZdSlyK9c?=
 =?us-ascii?Q?kucqeS3hon3we8YspPbSLnSm2E/ZuU3G+SWrf84wnv206QXIizKWtOVgojHI?=
 =?us-ascii?Q?dJGQlyFyoMDitJZH2xP4gpr1rIJ8+y3s5wLwsiJMjV00PoUNVDtPFrNPAg6A?=
 =?us-ascii?Q?+BhhiGdUiCtnZy1PYfVTba1cYmzFVI8IpTE5vgR//AIkT2f0Z6GugQmXssVd?=
 =?us-ascii?Q?Id4MkNRZOWIckj/n8TOukKx40+lnIPe6bDVi/mInFARjB+7y88nVUGFubnST?=
 =?us-ascii?Q?0kMeTHMyvlXuxU1hX27i9VE2ZGQrXcOFug+Lj1ocs/oFFN50vIz9la+ODScJ?=
 =?us-ascii?Q?dPBZ63KoRAfLudVTwC/+mWLDdMr+/9UTTgn5bdp0HAymGlmMmNHlyKK+n1QN?=
 =?us-ascii?Q?Wj2vyrISSlfAL6H2V4a3a7HOFuI0+SkUOHQWb3i4+ZaeInmEEQ9lUt5r814k?=
 =?us-ascii?Q?gbTNNhc5jr2J75kTZWfseWFhumFcE9ocxlDMorAKQKEOAdp8Treji/lmoaYW?=
 =?us-ascii?Q?gln+f47wDCIAZF29P36e5pJ12PTKl75L8pjFmLzoPCnZbleW87THaUofxGPd?=
 =?us-ascii?Q?YuXbtm39lkoMrrZx2MD9xATuWVfMKmgYVOwzgYHV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd856ea-a7bd-4702-218d-08dd4783f398
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 14:30:21.1569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8/GeIdvHIl3f5Hz5vqSGaxFg6K/f18CDyn++i9rBsB6Rd1T9vMw2p/1rKf2KFEtn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9420

On Thu, Feb 06, 2025 at 08:26:05PM -0800, Nicolin Chen wrote:
> Yea, I found iopt_reserve_iova() is actually missed entirely...
> 
> While fixing this, I see a way to turn the OPTIONs back to per-
> idev, if you still prefer them to be per-idev(?). Then, we can
> check a given input in the set_option() against the device's
> reserved region list from the driver, prior to device attaching
> to any HWPT.

I didn't have a strong opinion, if the idev works without complexity
then I'd stick with that on the basis of narrower scope is usually
better.

Jason

