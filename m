Return-Path: <linux-kselftest+bounces-26001-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1C0A2C58F
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 15:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FB621889E9E
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 14:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535D523F287;
	Fri,  7 Feb 2025 14:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z6WGl80F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53BA220694;
	Fri,  7 Feb 2025 14:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738938849; cv=fail; b=ACZcvVXiX0MROiOFls5/MCScRMF9Dfm7cBVyz94CczSR0S5m+f8J//Mq6x+8cMqYVLiaE+lt0BUg9tO/xk1es5qh631LBDouqpdIqYc7VuN74MWXntH/1fAmG8lk9Fymxofr1+bnkRSdLqjA9/UBR5i2gdSB39fiv8iNSR3vrcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738938849; c=relaxed/simple;
	bh=+kbgJC017g2ILK40V3elfCSDbWR50I2bVJXyRtU8dMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q0QmdhqpJ168auJbyU/RFm3YE6Ff3Tz+UdMsCDEm6j5B5kLolr7XSrOGaOZoSRx5Vap1WvcYVZL7Xhkl8kJ30df0hXUTWxv4nlejUPYQGOkwm0udtIVmRd6kn3tfOluaEZVepJMeyO0dhAPwwcMbya+EpTQzd9LeL/1QUXnvkJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z6WGl80F; arc=fail smtp.client-ip=40.107.237.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g94vFdS4G3LbBsFHBrctWKj5CXGrEHDWzBLvMksq5QpNs62S5xLfVR/avOyI5AFO9rWhbjgHjmGS3AesdDWIko3BbKY6g1UK6sCVR/iYQamq8SHoph12suhSGtq5M+ypXTrUcACFKMZ1kXp88zOThUU7+rRqWNw1TNNUypy6z1C9N5smkOLkJoS1ru1/Xa7Vo6exck+4rsC0D9dFjOw6zj8+yHm51eanoYcTc3rdPyfDdE4+gRsY/CFzJK0nkwiz9TxJlLEIWtx9rEXyXBKpV3m7j6FaFK4s92q3s1FZ+TMZtYl7Bugcy5D236suYVV9oAwlgep9lSXe1SHcg60K9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vhUFLifbDhPyaK5qxkCezVvTgghT9R402V/MKr7OpGc=;
 b=rCmQGrsFgDD703bwOuZKKZmelRtTzc2sWSOWtG8cSqliRpAoB9mZwMJ0575zXA33TIenHx3lGESLaFFwMhY0VVUDuApAMutemzcUciGu5wFmF0H2IDY4rEN1Za3YITK4vYB65vL80SAhi1tycGn7eoNsdJbG2TBZ1Yi0kBihHHTb0IlnV0O+Crg3PMSekNuJrcAaihvLOsT7cVIwW8FCWQSju50FrVun/RnDE5zvPijd5a/zooblygp/9sSQAx2UPXgoCdAvVxecKblNaI1OIcLNipJZDMLRHgW3MY4R7dX6THY+2DKvzd3A1FYO6No9rR6L60fTdrqJb1/qrgvseA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vhUFLifbDhPyaK5qxkCezVvTgghT9R402V/MKr7OpGc=;
 b=Z6WGl80FhDhkBbBZJGHmY4T3qDfdOGECTU/vIpi/FlulJ/Vy6vpUP+tlRTAHyTj70IMGov3eXBcHlJpKJbHj11MezSmNGqFsb8YxzBRDQOB4LyzJCPAU5S2QMUSisvEXlcR5+kdpnhKUPosIU3SBH6HsjKah1BZzkwfIZSiLmb5pFTvoXWbYKzrT6qLDYO+rjPbi3gqATGO1HhGu2sFrsM9hBhYPJuaqZw5G0BksSdZZfODV4iGSDaf2MEnczZsvnKWngJbdUEONrRdmTlh9i/zgTtoSQNlaNbX/DTiV0k+0u/vC9JGYwKazIK6fy6862Ej8y7Sa0hpOiAweDknR/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV8PR12MB9420.namprd12.prod.outlook.com (2603:10b6:408:200::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Fri, 7 Feb
 2025 14:34:04 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8422.011; Fri, 7 Feb 2025
 14:34:04 +0000
Date: Fri, 7 Feb 2025 10:34:02 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>, tglx@linutronix.de,
	robin.murphy@arm.com, maz@kernel.org
Cc: will@kernel.org, kevin.tian@intel.com, alex.williamson@redhat.com,
	joro@8bytes.org, shuah@kernel.org, reinette.chatre@intel.com,
	eric.auger@redhat.com, yebin10@huawei.com, apatel@ventanamicro.com,
	shivamurthy.shastri@linutronix.de, bhelgaas@google.com,
	anna-maria@linutronix.de, yury.norov@gmail.com, nipun.gupta@amd.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	ddutile@redhat.com
Subject: Re: [PATCH RFCv2 00/13] iommu: Add MSI mapping support with nested
 SMMU
Message-ID: <20250207143402.GA3651395@nvidia.com>
References: <cover.1736550979.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1736550979.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0628.namprd03.prod.outlook.com
 (2603:10b6:408:106::33) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV8PR12MB9420:EE_
X-MS-Office365-Filtering-Correlation-Id: 23c67f63-06ca-4f88-516b-08dd4784788d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AWbRW6+YrIbBZzuTYwg05pV2v2H8Q1N86Y94WAeYvR0gQ/KtVcD8AJ1kYAhp?=
 =?us-ascii?Q?ckSgP6kCRrA6tqmwGnlRYFrBUeoTn3B6bWXwueF3Av1V1IRvzIWeKB9NfskZ?=
 =?us-ascii?Q?5kyejuFhbNhzhi4bO+KJNOWp/TRTFfYLZpoWWYiO1HulkJ6qZg/GhGGCNdg0?=
 =?us-ascii?Q?glHJ9QN8QY+4mpoD3/xIJBM+luSF0lbD0VvR/0QV3IxxjxXZFAVX5nVI+J6d?=
 =?us-ascii?Q?g8p43U4YFmPVyYjMcZa7ySnTsbHyyU1MvzG3RgMKRJpW0NhK+9GYGDQwHQmz?=
 =?us-ascii?Q?ACvbaFT2iWzWf+ZaV/JFkknQP8r+C4MFtZOE1bIlQnzoN3jq9XA0c8Nl6UO+?=
 =?us-ascii?Q?SnM6LzX7udgMDtv3CaYGwQnsirsBQjogGw1P6IozDSYJTdpaeDkvw5VKoFzA?=
 =?us-ascii?Q?ZPUt0sycxU3UOesP2SeoClpsS+9uVkerWWuH9DYY9QXR+DvuwcADeQIUs3Oe?=
 =?us-ascii?Q?J2oP4TmuC869BE254jY51zuP8B0wor3Ro1wKVya0BpExpBbUnWZWqevo5jxq?=
 =?us-ascii?Q?SnOQ9soJHoa4Yrym1J1r5AkhYouBGKlS8eNiU/JPGvygWIZAizU0iLzC/xdI?=
 =?us-ascii?Q?IG6xa2YfhSPYNjYy6FJHdqiGCk3gs+amIo4buUiSYAeAqUBD1y+5Oqa5vD8R?=
 =?us-ascii?Q?kj5DooyHgBebCD7cxEwRaI4Pp0nxYfXyJpRUFL2USQ+VhQOCvqjo2b6U8yc3?=
 =?us-ascii?Q?tlO0HAYIviEgQlVIohSNQaqgbHNw1jUycZbAm8yD8M/8XtlcJ58EF/04D4DR?=
 =?us-ascii?Q?Qy/wLRhJMnB6Wlf+HsRa+6/bSVIW3jlJrrTBv8S3J+ua6CqA6Xj9KstZpjpK?=
 =?us-ascii?Q?B13wUYb5WkVFkgHTRvAsKB3ys/JtlaTnNf9mpqJUMpuN8vABIsszenKUvf/N?=
 =?us-ascii?Q?brJph6J5Eg3TktcomPdXeppHcifFYrlhiojtnhLNN1o/GPE5U6DN2QXGhFPe?=
 =?us-ascii?Q?u0fmLzx+x+rydL8VZnrdLwLNhrUxDV8ex9ntaOgaDL4uowQ2uJM9LL/cNHxn?=
 =?us-ascii?Q?+6oPZPQOxCd7rghwwUrwOr2JMpPrqqAJdVnQIAcHLIBAZzzRU7ZINkU/eII0?=
 =?us-ascii?Q?2XYABOnKdyzFZnrCQ8zppgdft3vekJ+txzYM9V3Mq2yzBXYx+PNakVOVmg/P?=
 =?us-ascii?Q?48wqQz8hf6T04iMzuvqT1zvahLAuVuwj8Fu6F8m+WV8KkUSUre80XhsiAu7n?=
 =?us-ascii?Q?B0K+PvydQGjb7Cs1B63fjlQn2INe6L38kHz8qaikFZ5RD6oEpc02sO17Dw4/?=
 =?us-ascii?Q?MslhXyWh6g3uo50549CxUV3WYFftjOTJ95taU0DywIG/EUNyERS8UYbxUKP3?=
 =?us-ascii?Q?WqxsfD0Ri8RUDAW8Rve2Z03oGB4OsOSq12i4v3JVrRNUo8RwwYwkYabZjWiC?=
 =?us-ascii?Q?hMW6OlEd1ZDktrry1RfAqa7SkZTj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T9UGiyZ+k45SaI9YAVT+rXQcoo1g6SOlnhQ93bikOTYB8JcX6oNB/4/a+7L7?=
 =?us-ascii?Q?3oglH/pG7E2L+QQ0sVsBoIAd60ciEtifnAfHRMw188Ghxy3BsbaPimlDzZHF?=
 =?us-ascii?Q?cK3phJnZKkfvDh/amCawQfgIKy0+bxO/ldobQvnONe7BrjrXokb/shthEgPF?=
 =?us-ascii?Q?OWv20gCo0BMymDlTxHb3jowMB/RSCMYDEYWUQSVRgq4xcvHJZVTXCeHEAZyp?=
 =?us-ascii?Q?RtwvVgRkhZFPIwLW9eyZy/y+tQ5MSSg1KDbUsgwhfLgyxBxsruW9troH2bkl?=
 =?us-ascii?Q?wlNofGqNMqVIkBhUIgd2r8f6QEKNGs1T778f1HVgvJVQn3TUanel5DdT/kgS?=
 =?us-ascii?Q?Xqbri1md5WqvAKWHLqwMvOIGU8g6OK6RZKZFEE9PDLrLyPttx1/dvRL776FL?=
 =?us-ascii?Q?vADmpWksbTKXRXMa28b3aAyM03hpiNtCqq179i+pGnhU3Emkacyai/BWmA/Y?=
 =?us-ascii?Q?9YM7wmSW31kZ15T+dEBR8VKUAeRq7HVau38c8Jt8gQV+qlS00hq3LcC0xsve?=
 =?us-ascii?Q?hDK5lOC3sOIxwIqDSxwIv7bQ8dBbWLl9vyOL41eDjiU8kzHOQJBi9BS+pawo?=
 =?us-ascii?Q?SvHImmYDrIDOVP6KSeKrVgPQyA+A/VerMeoGXlSaVP+vi7VBNiPeXnWqUpJe?=
 =?us-ascii?Q?sfBXheizXZkIAt3fCNvCB3nf5osbAHy2W9AJVvgJ5iujJ2Khs/r2dQ6M1Hih?=
 =?us-ascii?Q?8NBd8yxEg081d/63Pv0bjcNU5jcudwWRri1qtaQz4bwst0Lhv5WUM5hohMvX?=
 =?us-ascii?Q?bFG3+H8q3pjD3f+OflHwtCyx55c1r+E4Z/Hpe3Mr4Fz3cShIIkKAcx3hOJgX?=
 =?us-ascii?Q?ip75hhHSAZBiU1Gkc0z98uAADvfL6JzzpuCnqkflHhFq5k7pUWWjr1eXSr5u?=
 =?us-ascii?Q?o7N4+X/9hqSy7uAxI2UvopyP56H050Qeg15Kzh3M4tGi+XbbS/hQzYXEGhe+?=
 =?us-ascii?Q?9Ut6rInW/yiWeyT3y76EmalPbXvBof45PWs8CIoDDUFhnSfUIwzfU+krBnj7?=
 =?us-ascii?Q?lRYZqStj8TzhVVrimxZf4eTBxbDLIq6Ku8PLmbxveNJkoQ+EFJ9kflbn7iwo?=
 =?us-ascii?Q?/Mnpnv2xTMrhHCXJKuvj6ZUvFVRrUhSLCG3i51Mgc45WxrWqF+bKR6sxgMcl?=
 =?us-ascii?Q?e3Z/9VT0gu5zRK22YCMlWnHZ/qH41MOFGWRWrgsvCJ1ZF8IvLJjUBZ2Y9ShQ?=
 =?us-ascii?Q?1ZI+RaRrBtI9F+aE4FuLbNMZf5OfV8ee9vdXktLDxHkFU6hGsJr+TMz1IXOE?=
 =?us-ascii?Q?7Qi7XlFYmok3cRyIdSQsbSeLev4ecgKJLJQ7CSS4IyI34EQb8upFge4IaYoF?=
 =?us-ascii?Q?AngSz+15INYQcuB5nWfp0WhZx0kHIeYLK1i3pZKAYqoUQW5coNyrbk9DVU3g?=
 =?us-ascii?Q?TP2b524zL+tlMomY/eTsBm5zjU1omY1j54AN29/1Kbk35XE1OolXbDePbBwN?=
 =?us-ascii?Q?XadgGFhZv5hcfrp4YsrMlcz3rs+C4Nzb9ceePt5PmKHaIa6pbL/M8cxsFqsO?=
 =?us-ascii?Q?mUOc5Lj/TVvPhqWQ8cVFyDzBnzLJgsepqKP+0SEecEu0b97jYQg4+t2o1XdN?=
 =?us-ascii?Q?5xCmppzaNl1LTqipH7RZQuNgg1jRhsicO9n4g1UV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c67f63-06ca-4f88-516b-08dd4784788d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 14:34:04.2806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z2nUEYB2ZlQodiU6+mRXrf+NkNM/+wAOz9ZwOBpkMkBw1TTpdkqmPGLJ3hrOd7Xl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9420

On Fri, Jan 10, 2025 at 07:32:16PM -0800, Nicolin Chen wrote:
> Though these two approaches feel very different on the surface, they can
> share some underlying common infrastructure. Currently, only one pair of
> sw_msi functions (prepare/compose) are provided by dma-iommu for irqchip
> drivers to directly use. There could be different versions of functions
> from different domain owners: for existing VFIO passthrough cases and in-
> kernel DMA domain cases, reuse the existing dma-iommu's version of sw_msi
> functions; for nested translation use cases, there can be another version
> of sw_msi functions to handle mapping and msi_msg(s) differently.
> 
> To support both approaches, in this series
>  - Get rid of the duplication in the "compose" function
>  - Introduce a function pointer for the previously "prepare" function
>  - Allow different domain owners to set their own "sw_msi" implementations
>  - Implement an iommufd_sw_msi function to additionally support a nested
>    translation use case using the approach (2), i.e. the RMR solution
>  - Add a pair of IOMMUFD options for a SW_MSI window for kernel and VMM to
>    agree on (for approach 1)
>  - Add a new VFIO ioctl to set the MSI(x) vector(s) for iommufd_sw_msi()
>    to update the msi_desc structure accordingly (for approach 2)

Thomas/Marc/Robin, are we comfortable with this general approach?
Nicolin can send something non-RFC for a proper review.

I like it, it solves many of the problems iommufd had here and it
seems logical from the irq side.

Thanks,
Jason

