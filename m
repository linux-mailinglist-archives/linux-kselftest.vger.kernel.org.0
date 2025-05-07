Return-Path: <linux-kselftest+bounces-32570-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A66AADF64
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 14:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52722175133
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 12:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E36A280028;
	Wed,  7 May 2025 12:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BEsEF7x7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17DC2798FE;
	Wed,  7 May 2025 12:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746621554; cv=fail; b=LQHVEtkhPZ3klsvq7w/XV54dScq7QTGXxzW197Iif+GCUVJkk2SbW5jU34v5e0BbCtEoAKr7yz6ZCqo/ZXaooxo0+j7depBeHPwf1Qv9BMIh0DkrFX3e1wxWp/csgxnS88ceZ6KWiVv6UlvjoKeHTvf9q+iRO8FD5cRVXmIkuek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746621554; c=relaxed/simple;
	bh=m1w/03/MqEGTmAhsZdvxeEx1lozw60PpUMk5bVJo64M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tIcLY30yzLHai7euoZph8omqMokN/m8qEtlkST5lGCVNMit+kRGLnXWSBdRQbaVaItgaE55JDRwDR9atwLnDRtOCa8DJBxGI0d4YDkGkPv+mCndFOxhCdb1jv+3n0ojukK3soGomqF/G5HyuICzpKbCk+tC4QCGfU+jdm7QsrWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BEsEF7x7; arc=fail smtp.client-ip=40.107.92.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FNp0sy4W8kBy8cVxmwASiDfiWW9L4KJa3YRPqAZjwcGNRqos/rLCgg4NpSYN+wZ0wl7BoI/NtaRM85exdDJ4EXkYQ73FYmCB97oERCNpQKJt6wLuJR0ALaMIbfb2Kizv1rnCpnhcXLKzu1SmtH2j0B4jhUJYjmys5auNjj6BCucaeIK4c32kHJx8kiIu1+eNN2qGm6Ek6TlQ7HWwqFd6r42ZC0/9PDtBg/0QtHrTGZWyv5TliHvCnK/JlcNmJJqeGlqbwKc2IRQkuxCGpzT+qD1fyI7vpj9D4jiHFmzHI6P4KmWckP/DBJM0covv9Qcte5KHpsW8PmSoV6VM3qs/RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1w/03/MqEGTmAhsZdvxeEx1lozw60PpUMk5bVJo64M=;
 b=Ne67bjFt694jNL05zOzJUSljQVqx04rffgxNRYZAe9b3lweSORlt7O4sM9oTittwMJytyBe2bcOdVyV9QQQcufKoYSXwPRZbmQYmRNR5+gV6TCB4NzMqOY/gDUzNC9OOQC6jvqQ3FMjSIj0hcNQ5dFO6Os5ccSiYz+jNGBZ/2wTNJsMi5ei25WMxrh7UWFHGRh1fTv+0KLKdm55/gnV8uw/iBThHkejm+U4wyUsvFvcoU0ohEPoQiXPYYcvS8FdNLZkiqWHzmcfQzC9lXgwZt0NTFhVnFbj+4aMTHx57qNxk9rArqPGRmhFFKBhCXDxS5WJwupTK5Eu9o59TBn8OsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1w/03/MqEGTmAhsZdvxeEx1lozw60PpUMk5bVJo64M=;
 b=BEsEF7x7Tbk/C9P4+YNbk/DV8WJPuCZW9lRY1+EQE4+niQvH4KojJk+3ZdRtZLKkP2AbJtvQp5P0CRIt6TAxNxf0/tiz+2EYc6nrVo+MIy4nJbD6FXJdLkEHLmzq828BYIqz8FNM3UkylD8SLEqrAPORyJHSzVsiz4/Vzij5SqOgdqIpxyS/xuPqtkVRvEWr9f/RrdjeOR0p6TlcYgqf/oYC33y0gtVjH/af9etQfLvHZ/QPB+aANCDS50bXbox1mQEOrrw2yCHN44Sgr8zMLIaQRWu2PRw8ljQZ5izJBoeZ1FU99yCD5XALxrnDpw9qky+40dQPqJcSEKAm+trPPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN0PR12MB5883.namprd12.prod.outlook.com (2603:10b6:208:37b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 7 May
 2025 12:39:03 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 12:39:03 +0000
Date: Wed, 7 May 2025 09:39:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Pranjal Shrivastava <praan@google.com>, kevin.tian@intel.com,
	corbet@lwn.net, will@kernel.org, bagasdotme@gmail.com,
	robin.murphy@arm.com, joro@8bytes.org, thierry.reding@gmail.com,
	vdumpa@nvidia.com, jonathanh@nvidia.com, shuah@kernel.org,
	jsnitsel@redhat.com, nathan@kernel.org, peterz@infradead.org,
	yi.l.liu@intel.com, mshavit@google.com, zhangzekun11@huawei.com,
	iommu@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org, linux-kselftest@vger.kernel.org,
	patches@lists.linux.dev, mochs@nvidia.com, alok.a.tiwari@oracle.com,
	vasant.hegde@amd.com
Subject: Re: [PATCH v2 13/22] iommufd: Add mmap interface
Message-ID: <20250507123901.GF90261@nvidia.com>
References: <aBE800DsAOOZ4ybv@google.com>
 <aBE/CD4Ilbydnmud@Asurada-Nvidia>
 <aBFGCxcTh54pecsk@google.com>
 <aBFIsYg+ITU8RvTT@Asurada-Nvidia>
 <20250505165552.GN2260709@nvidia.com>
 <aBj1Av6Xaj8flMN+@nvidia.com>
 <20250505173101.GT2260709@nvidia.com>
 <aBkWoH23VysYake3@nvidia.com>
 <20250506125222.GW2260709@nvidia.com>
 <aBpjbtRgR1nK/LIm@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBpjbtRgR1nK/LIm@nvidia.com>
X-ClientProxiedBy: MN2PR06CA0013.namprd06.prod.outlook.com
 (2603:10b6:208:23d::18) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN0PR12MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: 59767179-c3e0-42d9-0a27-08dd8d642619
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KMhzIoMl9Pl/CIY21TXXHBB5wrLhzFyByZRh0oJDaqXi04+DcevdFihqnaRj?=
 =?us-ascii?Q?9NSfbUB2zkFFSF4JbVA6bYB/wz1KNELQiARg+ksoQTR9h/j3CpPzckAuNAsT?=
 =?us-ascii?Q?NGkY+e2QSbicg73BjygsA5ewSkuCHirVIFPCcle5Xoa1QlxddWZMSPvhymve?=
 =?us-ascii?Q?Ol6WT1PwgG4iMgtaDP0+ukS5j96x0tpbBET9JveZZIXW7oBuaasdvqxcXeEg?=
 =?us-ascii?Q?fztpFLh+mFCcmCPuFPgLJuDETJQ8T7O1PLid8c6VRFM19RtITxFXkMQhrkEs?=
 =?us-ascii?Q?jkHqVcZRADUDp472lOZ5SFZnzlrZjlX7OLh8Vw4K9MnI1XDD7ogZOjhFX+hG?=
 =?us-ascii?Q?HYZVkgfsiARZS9c1rloi1+QCOKqEgqfK+6H4LyYVVNZIAomuH1j+yTqRDE3X?=
 =?us-ascii?Q?2rIDhNFGFfQwJEwp7OFmzrHg/9elT2VQ2+c8tb3FjveAE9OunPLxxN5Ow5es?=
 =?us-ascii?Q?MbwxanWSQQIIxINXtLLBawSc0d72pdj8jfr5SRuDCUo6+nadjEMljOK5K3Ee?=
 =?us-ascii?Q?Vkg0LMRbcNeZNuYNWh7NEzUiy6tJN7XqI4+RrE6V98jCN9rzFTTATcNKmHNu?=
 =?us-ascii?Q?Cbk9UCj3zmVeLbDp08uVhVvvAV0J2DkWbc3GAyk2MQGgqtMwytO6ZyxGfZ2e?=
 =?us-ascii?Q?pV1KvUtmGuWaRmSwC/9MLirvZ9KJZWwbONTACcc0g8XPLJv1VCAv9WC9Gbr9?=
 =?us-ascii?Q?risQKZecdxe/ey1sLcYFbHrgwVBwmkDsJWnEfS6j5knB5flaaeC/6zeqNPY3?=
 =?us-ascii?Q?QmyfAEN0Psao5P1ed1P+LsjiUZoId2pUfc0IVZ9pCcwHai3oMcJ8mCAkgCVH?=
 =?us-ascii?Q?bsGv6bbIw2Vmpxgm5tGxOahmG8gjpuvLYxsydur8zwR7iIiV2dWTsZcl6e1Y?=
 =?us-ascii?Q?sq4wahDkFpxVtpKjezaN1yyzRaoXc2t8A5oFVD0Wy9o/pEFinoEPZLFxdX1R?=
 =?us-ascii?Q?zzGiq/7VWlyqNok/HXFpHXjA+tQFlUejlqpjl1bmEv72SZk+lAAIvh3/eo44?=
 =?us-ascii?Q?ZVNB4vcMUs21SX1+/rOiR3TIyCcTYsM+8uzV5COhcUdvlbCuCQXkJvO4Pggu?=
 =?us-ascii?Q?sP+6S/1d1uKVbRP9HJBDZb08eXs/PXvNNOwPjqYC7lE56QNYFa/xMFM/5A9N?=
 =?us-ascii?Q?N24PGExko0Fq80H736regZ6Cx9RxP6LoYPbpti2bWolPpMFi0A87MfjU1x6C?=
 =?us-ascii?Q?I+D6wUHGElk8oZ+g2s8qB731RU2/trnWZeuopctCKAoaww6HD0kmZdYLYvnf?=
 =?us-ascii?Q?WO89WCNrGJ0cjITwGHZPWEANnaJSR+7hf51G+y+zzCuvvbJrdkvO7usmn8wD?=
 =?us-ascii?Q?gqSlX6CpLg76ez8xAh/K79RAWpIosBk8v5nstiQEm5AD/ANYIUi9OcrPbUIX?=
 =?us-ascii?Q?KvqznBSrY8iFOGb2PP0Pbaw0/3LNpvIGRPcEjxOkrvtTarua6+Um1+2TnC+W?=
 =?us-ascii?Q?2U2I7HNu7o0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gRBBfJSCf9zBrsUHInml9I/5EiSPapAqQcfgP46MCWi7b+cvSknYEoEZWcz5?=
 =?us-ascii?Q?QmVa6aPm1HJjSN15bghhuBgZ9pyHoIeFxKs78+1r+CghbbMoVqm3HnJSjjB5?=
 =?us-ascii?Q?eX79MWNV8gkRGUGMWrkzZJpXeoCH3qNUhK/tPozZu4j0JN7+58JPjgllCXRa?=
 =?us-ascii?Q?Fg0xx6EDVHhXdrRPi4B4Ej3Tmrsif/DjqDYHtjANQ704dh7/Ld99tH2fDEiM?=
 =?us-ascii?Q?l0T13/qW4+M4dGFl8O8LS65pmGHqJFK3KDdGPeJRcfy72mncLNU9hDo+jjCr?=
 =?us-ascii?Q?RgqeLlI41XF10FbRXo70bcRoqRDn4eDYPN9TsyBIMSq2ObMqU1OyjZ4izqdi?=
 =?us-ascii?Q?E+UcmiPOClkdelMq6oRpU+m80OOubjrkCjQ2LxxkQqeMg4gn3Q5WBW6Kwzhu?=
 =?us-ascii?Q?BJ3ZhTSqovnEP2RB0hZxhIJ0xOfAdMyYp6d0Oo/P5+q8PApA89Y/O+Y+6FnT?=
 =?us-ascii?Q?CXrUCWNe2OAhweifDoINgTkQz9fHbefiNAD6iSPFtQ9TD03Aa8fbo2mFUfv2?=
 =?us-ascii?Q?wHNfQ9tTjwist+CXPu7wShPibG+FAAbW2fZe9TnySX7PKnvnO5uw5a79kOoU?=
 =?us-ascii?Q?T0WqjIOh2PEn3OybtMwnBH5frJqnDL/NtR4XBFSer+e/wl675bra+zpf58Ye?=
 =?us-ascii?Q?P+vQm4Hjj25/FETxv/BVkyJjJFOSRv3ijL+TKq3HBdMHankAIO5FjERgi4ic?=
 =?us-ascii?Q?IBEdjJ0qzp21nP0S88FoxNUfE8W2JHCFRFGtPx8b68nZSHGUvLwtGnYsun0j?=
 =?us-ascii?Q?CFhBv9YeFBxUfxKk48HDqpkl1fTtf51XOhnMSYTJ+Pj9lY7alvk+SgXMdlu3?=
 =?us-ascii?Q?X6OIsMgoXnrtiegRXjdIltRAORgYXh+e9PXhCnAisb5L83ytq+2zXsUw/Sdm?=
 =?us-ascii?Q?EUrCLyc4RlrRjzr3tua90Qlp/a7c5b3xhik8bx/8n0OUAgP75eyxqcqZhw2e?=
 =?us-ascii?Q?QXxbcUZ+QjQ0hnagCzE6/fZ7Sx+UW5/CV/WelzxKOoqnmgTYOTQPnUVrAJpS?=
 =?us-ascii?Q?tqqOZHGpTx5icqrCT1melChJSSf+D8AaAsME9uInA+gFUnIBdb5MGNbweP6r?=
 =?us-ascii?Q?8rzo2y+24FrVrOvk2FD4398+IW3iZhdydm+bETsA5V/gJB7MEIMsLHjXPmnX?=
 =?us-ascii?Q?p3swb6bk9DaxmXi/+he44Bsc08WT65cTyPWfJCirHLHGzQf0MB/wwqb7r15s?=
 =?us-ascii?Q?WQaV67kT1nJ64KRC5gxwOHLioRuuARX+mhz/TRGSuBz9MrpqR9wyI+75xpyA?=
 =?us-ascii?Q?lkaF8qSwAabeeJmZ0geiv5KziXI8P5yj8xl/a3AaxU8bGpHl+fDYN1HbrXJB?=
 =?us-ascii?Q?fo+gzhvnleP+nB8ripaHaGrKRfp4eLklgEMtFC/hXrVuZlTWhKCkiPrA+dnX?=
 =?us-ascii?Q?zHo1yQZPvVcvHINTmUs7YScIJFjCz/kT0UKyjpBDMjRvmH/rOPyvMXSb4U77?=
 =?us-ascii?Q?lZ2ZXTX8VEWy7Jp0+9I4ES5/3GEeEC22oYgyuRrAXV4x4qrZARMBtuppqUTs?=
 =?us-ascii?Q?ntraEZblMYdvKcBKcFnPt/6jEZF4aMNKTjMTLWhK2fxzqrE48CuKWuthS/Aq?=
 =?us-ascii?Q?6nEZotfdSQwX0VhT7PIPEvBHcUJ75K1ca0leltYC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59767179-c3e0-42d9-0a27-08dd8d642619
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 12:39:03.4846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QVQjfGo2PVdD6yhOHEXtE0NL1UDA7Wk08zCY4Nx52qqqxl1qs45WZtDuW8USp/LC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5883

On Tue, May 06, 2025 at 12:30:54PM -0700, Nicolin Chen wrote:

> So, if I understand it correctly, what we want to achieve is to
> have maple tree to manage all PFN ranges. And each range holds
> the same entry, a structure that we can use to verify the sanity
> of an mmap? Let's say for PFNs A->B, the tree should store the
> structure between index A and index B (inclusive)?

And tell you what has been mmap'd.

> If this is correct, mtree_alloc_range() that is given a range of
> [0, ULONG_MAX] would allocate the PFN range from the lowest index
> (i.e. 0) instead of PFN A?

mtree_alloc_range() returns a new range of PFNs that does not overlap
with any existing range. It should always be called on O->U32_MAX (for
32bit uapi compat) and it should always pick the range to use.

Jason

