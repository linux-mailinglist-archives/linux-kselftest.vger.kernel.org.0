Return-Path: <linux-kselftest+bounces-27780-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC31EA48367
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 16:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BDC51894C79
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 15:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C4D26D5C6;
	Thu, 27 Feb 2025 15:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G2C7bFMZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3AE26B95A;
	Thu, 27 Feb 2025 15:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740670985; cv=fail; b=lMN691gBGD/9/5MProXNwPgbKFtgjl7JAZqHAKdTTTyIE1NyHbN411Ve7qy8Nm3c93pd9AFE5GcV+GBRhHJ9/fY1jr52Mi6v6UO1Qk5mfEFLEhX++wisPuitd0GdRxhqiC1+CTMKfBXDokhi5K/Bmk4yYNBuYiVyzEniOwW4yWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740670985; c=relaxed/simple;
	bh=rLuI7p/v2NyeXSA/4KmQ7dgWmDUKKwqfOLL9nXvGU8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MjsWwSG3VTumHWySGybCmVpDBwujHLH5HLZ+kB6QbOm3fEuXVec99CTPL9xFyIMctpHRIh/4v3DFvFkPFMykAZ1b38KCT6mwuYiPZ85/m3vBp1B7FppYkrozXSPscgu5QH+1954rNV6DMilG2kVMmL9ImlHOhOlbqygQQ+Ng8Ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G2C7bFMZ; arc=fail smtp.client-ip=40.107.243.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vHgQnLZBhK3je/4RGfVt/RIChtamc5P77BsCCaCy3SXBZFfHm8gOrCOMR0+cCsdJzTklv8gKjLdjy98VeFvDF9VicK63YHVWTIR1o3RKri2U86V3PjGMlcF+W5t8rOXpq0bQ1nKxoSaqx0Glhq08KdbIdypxPyvTeFHq247+v0VU5vnoKd0PEzfCq57rnRnbxDVZ3aljGA0ePUg4L40T/9/AfhAeQzPvWwY2Ys43/HeKQfGt/OZ4LbuPjGTvZOjy+fHWTUj3I52/ugfA2EIHkD06fMNEemA0MjQAaXjKrQ6qlm+nfhkEY3gLKrhXGWD7wtA/NcSY3gh6veDVZ0VvJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2oEcN2jTKVVfZf6VrTJeV94dPxmzdAKrKLynh6+4nBY=;
 b=wwvE3Fz2143BafVfZETO09+/cVML5Vk9uo3vBesdi/5eb/z9UBWQRJXPq0p8UJHDmNR9vAQ8XxUHCI7GpOu/ilVTEIXAdUwNLG2nYZ90BSmC36dvNy/GOXsF74VMnuMTqvGueh5J7XFK3K06mQJa+Pl5ZoqCI5jTWynr7osD4MUHatTvacEJDomII/326XQR0gEv9geAfESoKXGDE51XYLUq7f3F/7HhO8//B+lKy1yxwgqi3WhUtDAFiIMxofS/Tm1DyMnBpg6S6koGG4kQszS4MMzHsAnok4tdGUpLHiTTipp/aL8f6vGC4Zyhwg3i5MiNUAGlJTggDcHXFVUcig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2oEcN2jTKVVfZf6VrTJeV94dPxmzdAKrKLynh6+4nBY=;
 b=G2C7bFMZymX1P7BSxz8aunFsa7azsGsIH/e1j9aWf7DaoWQA84dc8TKyEZfh2Cb2GWed5dNy/WiCG+9tW3Yqetm+gxvRheIV2DYZyhU12ljnClVE8pX/DM/1nC+HgnX7qylEPYEfyuje54osVksFcsGPrwBN5iKPlSh2tvcTu2Ws0v1zZYBunZGXrdP41nO7gzX/s9xZTqS2n1AwQV0/DoDwHHnZZujCBpv4x0q0eojA8wBLqRMpnWvpb1l8x1Rt3r/qJHoPeSPzwPLQMMyUNDK55GC9UVL7XP7uSFiMwIPVSrsHCHJn/5DPTZg08+9gbGDYyyzSJIqLw8wG9oQK5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH3PR12MB8536.namprd12.prod.outlook.com (2603:10b6:610:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 27 Feb
 2025 15:42:59 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 15:42:59 +0000
From: Zi Yan <ziy@nvidia.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Hugh Dickins <hughd@google.com>,
 David Hildenbrand <david@redhat.com>, Yang Shi <yang@os.amperecomputing.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Yu Zhao <yuzhao@google.com>, John Hubbard <jhubbard@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH v9 2/8] mm/huge_memory: add two new (not yet used)
 functions for folio_split()
Date: Thu, 27 Feb 2025 10:42:54 -0500
X-Mailer: MailMate (2.0r6222)
Message-ID: <DEA9200F-AC1E-42E4-8876-404179BCA465@nvidia.com>
In-Reply-To: <Z8CBPF9_gDZuDjED@casper.infradead.org>
References: <20250226210032.2044041-1-ziy@nvidia.com>
 <20250226210032.2044041-3-ziy@nvidia.com>
 <Z7_-XweaPpfdRz1h@casper.infradead.org>
 <Z8CBPF9_gDZuDjED@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PH8P222CA0010.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::8) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH3PR12MB8536:EE_
X-MS-Office365-Filtering-Correlation-Id: 848a4231-4938-4b6e-9e7a-08dd574569b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NEJQZ213aC9kZmRGdE55T3RNSXE4Wnh3UlRmYzlhem5vcTIza0xuZlFkVVJU?=
 =?utf-8?B?UmJoWE9CTzlRRkNtQ0NDTzEvWlkrLzZWTlkzQUNUeW9zOFVnamZ1Sk9lWWZt?=
 =?utf-8?B?RkVtK1hZR3NRTkVnT0YzN1Ryc2F5My9rWmlIa2J1RC94VS96VWdUQWJReHE0?=
 =?utf-8?B?SkFqeFlDWmMwSUVVWHhBNVhLSlhZMmxmeUd3amJzNSszdkpYelA4OUxtWm9k?=
 =?utf-8?B?K2dON2tkVStQOS8vanpra1VrVTZWcG5oL2tXazlnUSs1ODZBVGVuT1NXUy80?=
 =?utf-8?B?QzRZdFNLUW5HcTFmK2ZWMUlmQkx5RkplZGd5OXlqYzJqQjZ4VDF5Q0h6dmFC?=
 =?utf-8?B?THZtVjRKWjR1NGx0NjllWDBjSXJNUC9LckJXKzB1aVBsdWtyOWxZT3VkZ3BS?=
 =?utf-8?B?Z3FvYlBMajRJSG1adEM0Skppb0RmQ1c3cE5oaWxXWXhZRWozc0FzTCsza0Rq?=
 =?utf-8?B?LzRqVDcvNmtQME5EMVhYVG5mQlFaOFpnUjJieUpVb1JyYVh1Z2tsamdYa1RJ?=
 =?utf-8?B?ejdiVks5Rk9IMTY0QnFqeVVxd2xkaGhnSTF3MEtSN2tzcjVlZ05qTk83WTFk?=
 =?utf-8?B?Q3NBSUx2bjBDZGRiTEtva3dRM2tpR0c3ckhaYW9EeitaVXV0d2tnK3RSaEc5?=
 =?utf-8?B?NU1RSVJkMWZodGdIMTBJNUpiSmhOY3ZGUjdiOFQzK0RsUWdNS0JWWkhodFJH?=
 =?utf-8?B?V215V2VlK28xV1ZoeFhTUlJNbzJlcnN5dWVZS0htMFluWmpFNFJoVTNBOEhW?=
 =?utf-8?B?Rm1YanpRMWdhc2thc1oySTVnc2Jtc29TbkZEbG0vemN3cWhhTHp2ZnIwYjdL?=
 =?utf-8?B?b0RNQmQ2djZ5Z2tQd3BYdTRnUUlhZDY0SHRUQnZVLzBTVHVrSTFwdENCR3Fv?=
 =?utf-8?B?Y0VpOWV6N3VFbkV5ek1pbVRlaW1kam40Zml4UDR0RnRGakpVczF6QTJ2OUlY?=
 =?utf-8?B?bGNsbTFpbC9ZOWJrc1p3MTd6UW1vSWFVZ0VYaGlpTFJwR1ZYdnhlczRWZDZZ?=
 =?utf-8?B?eEFHbmY2VlNpQzdPTGdEcmsxMDIrbnJrUitpQ0o3bGpJNGRPTWFsN21xZ2hX?=
 =?utf-8?B?SVdUWVFTTTJtdnpsSGQySjVtK0lKVm51ejRUbUFsT0RLYVZ4TGdCeDU5MzlL?=
 =?utf-8?B?SjBzNVlWdWN1YXIwZUdLOUlIZ1pvZ2JNQUxxTHNQUkZtam4ycmhvZWRnWE13?=
 =?utf-8?B?Z3I4b21MdUZTWm01VGpyRkZJT3h5TXNld2U1TEZzL2VHaStrWDZWZ2hpWGtF?=
 =?utf-8?B?YzBnSW42Z2xoTnQzam51V1NSc0U2RUpCK2J4bk5xdlZjM3JmNE9NdFo0dW12?=
 =?utf-8?B?d3EyU0lDZ0RIY3Y2eE5ZZ2NYak04RWk1YUQ0cUdzQ2g1bC95MkM0ZXI2ekhF?=
 =?utf-8?B?c2RmOXVveW4vUTBJOHlWOU90OTJ5SDhlVmR6cWRIQUsyQWlMZkJrSHM5T09U?=
 =?utf-8?B?ZUMzZElnczVLMS91RXd4dnRWQWl2bVFrSm5PcUN1MWZTT0EyYzVQYUxES1RZ?=
 =?utf-8?B?UGo3V0g2em1DK3lqdE5USUxsTGNtUXllWXN0WjBidHF5Vkd1OGpMMjFMc2Rq?=
 =?utf-8?B?STdqQ1VLMGtVbUtVQWRaUnFOdmZqOXo2TWdVZEE2T29aUHJNck9lTGQxZGwv?=
 =?utf-8?B?Y0UxMWZrd1Y5aEpDeTkrekt4bDhhT0J6TkpQNWxpRk5acklyV3ZtZHFkcWFM?=
 =?utf-8?B?eEFzakhRSDZkNFlvQnpHZk9Ua1RPcTRLMkJ5aEViRzZZS1ZkOEc5YkVDMEdM?=
 =?utf-8?B?UU5xUXJ3cnUvU2RRRk9NaUhWZDhVWGRmeTZYbUVlR25JRjdHanpKalhtT0o2?=
 =?utf-8?B?b25uZE9vVG14S2JhY3ZFUkp5SnE5dXFrRk9PV1lUbmtGOWlWNHhubWZHTlN4?=
 =?utf-8?Q?R2h+O4p411elE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QTlQbmJyWjEvR0owbHUvbHZZdm5JZU56NXA4amVPVFRIVTNsTkJiNWN2R0U1?=
 =?utf-8?B?a245MWRTaE9MRFpmODE0WXFZL3V6WmpwRkhzTWdYNU4vUUJuMUpQU3F1SEc2?=
 =?utf-8?B?Nm9rdjdQU3U0bExrbEhUaTBOcHhTdDIxcVRNTDhjaWdwSzlGNzBGalRZTGxF?=
 =?utf-8?B?ZGJXZEM0djh6cFBLQ0QydlB6Q1diQ2tZd0pSRjNGNnlzU2lUTldxLzdXYlRn?=
 =?utf-8?B?RUl3aWpYMWJwUGlBM2p2U0JEQXc5OFhqMUdWaXRZUHVYaGpVTkY3M0o4ZlJX?=
 =?utf-8?B?eC81VGJNbHc5S25WaWpCNEVIaDZGeGNUaFZQNUgyNkhnd2d0enQ4eXdiNmF0?=
 =?utf-8?B?a3JKdk4vbFVQZmNJZTYyU2d3MGx5TDJ5RERTVjdDNmJKbjRuSDROY2VNUHVS?=
 =?utf-8?B?RGpGdFRqWUNwOWlWTnNEZTF0bjNuK0tMQXhnR0RXcERKNjJDc3lmZXYvcG1o?=
 =?utf-8?B?ZEFoYXJpRmFFSUJ4cEUwc3l0bUhPcEdLQUFkK0dEa1U2SjdXdHRNd3dLRmF0?=
 =?utf-8?B?cWdOZmJXS2VaWEdpOGJMMWxHSUI5OUtvb3N0MTZzUUZkS1gxWnhLR1BnV0RC?=
 =?utf-8?B?MWZuZm9nZXlscnptWEJGSm5QYkFHWlJiWGFqRHp0TVFKNEFXK0ZINXRkdDIv?=
 =?utf-8?B?SE0wRUUwS0ExUGhvbHBSUlMwYmM5a05zdW5sUTJvL1RINUtnTFZ6cjdvcGxB?=
 =?utf-8?B?dCtIWndxSklwOWljaGtqNEowWUN0emp3NmVmNmlnNnllN1h1cHFlM2NsSTlL?=
 =?utf-8?B?c2VUYVZkbU81ckptSWV2Sm9lNVA4N2VWQm81QVJnYXRzak9lMTVSOUJ3RzRk?=
 =?utf-8?B?Wm9JdDRlYTM0NldWU3NuekVRR1J5anhTN21iWm5PS05XR2c5YzJnK2dNV1ZN?=
 =?utf-8?B?M3ZxbmZHSjNLTHlLRVVPcmcyWTF0ZnhNeEFMR3I2NytjazRiNmdkd3dsTXdq?=
 =?utf-8?B?OVlKMnRMb1pzb1l1UDZXcUlHVzhxYlVxNXIvK1V0cHRsckVzK3lGdUxQN0Z0?=
 =?utf-8?B?NStNTVhMd2lWUmVKTDBSUlJwU0o1KzZMcWc3MlpTVWN6M2Nsb3pkUnhGZC83?=
 =?utf-8?B?MExDUDlIRVp3UFkwZC94K05vaHNWQ3VxWkhsZnEycGdjZ01MUzhmVGR6VUVi?=
 =?utf-8?B?R3lFYWNJTXRiRUZpZ0pqUjRCZGVNMmg0L0tPV085RkV0Z0MvT2hEeHVJT2hy?=
 =?utf-8?B?S0h4L080ZVF2K0R5eUFTQ1d3OFhnUWxHUDVIb1RKdzZVS3lwdnlXR2xSZVJJ?=
 =?utf-8?B?Q1JlQjYzMmZvSXZaeW0xd0NQYUpVcWJtSEt0cGV0RXhLWmZxaFBvWTJWMnBJ?=
 =?utf-8?B?UkVDSTNGNGdaQTFWaWRINXB6TDVOQlZ0bFRBVERvb3VBQmd4WE9PckcxTVhz?=
 =?utf-8?B?SEZtUElzeGdHQ0VKNFFpSmtIV0NOcnMyRGEra3ZMUkVFUHV6Z1p6S2VlRVIr?=
 =?utf-8?B?cm1FS2NpRG1MZlkvK2lhV0hJOERlTlJwcVk2QVJJMzA4Q0ZoOEdNRHpsUVRE?=
 =?utf-8?B?dXR2NnhsaytWSkE5RytabHVtTFl0TUY5UWh6Q2trck1ERVRQcmdjeERndEVj?=
 =?utf-8?B?bjJUREltTzZic3crcWgrVmhVdUVQUStrQWU4OEZhT3FpQlI4R1NtdEFyN0U0?=
 =?utf-8?B?aFdiYjdWQ3NsempGZHVqVWwrMGxYUUp6UTFIcGg4UzJheDZvTkkzTTJaSGhl?=
 =?utf-8?B?YWRVVmhjR2ZCVXE5Yk8vU1JhQW9KRUF2ZExTbC8rTkIyYy8rMXRpYStDS01U?=
 =?utf-8?B?a2dnc1BFSWx5QXZxd002aUw1RGJPeDlrR3RSKzllV1FOdGhmc29pYTk4Vmtq?=
 =?utf-8?B?aVg2WlBselVsQ2hjTzdkYTFZdkhKT3ByTVhxdUZBbUd2cXI1aXIwUWZsZHBj?=
 =?utf-8?B?d1Vyd1dkVHlVSUhFdW1QMWtLYjRBM0ZlWU03eVc3UHRHQ3VTRnJuTGdQMGYz?=
 =?utf-8?B?bVVxc3Z4YmNHbjNzWmt2L3c2cWtHdG9ONFRZQU1JVGtqN0Iza1RIVWtWVWUv?=
 =?utf-8?B?NCtPS3U5SndZT1BmMlZGT2ZWc0RUZ3lMemk0OCtBRGRSZWlwT2dwaG9ETVE3?=
 =?utf-8?B?enZzdU9BaCtqK2tXS3RqWDgza0FkYjVzYlhPSUxhUU5WdCtLLzAvb1dNaTll?=
 =?utf-8?Q?fFQSlgYSQC4aVK1F584N1DEAC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 848a4231-4938-4b6e-9e7a-08dd574569b5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 15:42:59.6010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8PEwUII/WmGsmJrYNrFw5NQzj5fq8cSwqf6Rsa/SBUzosCzFnkQ2yOsuMI2tdy2t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8536

On 27 Feb 2025, at 10:14, Matthew Wilcox wrote:

> On Thu, Feb 27, 2025 at 05:55:43AM +0000, Matthew Wilcox wrote:
>> On Wed, Feb 26, 2025 at 04:00:25PM -0500, Zi Yan wrote:
>>> +static int __split_unmapped_folio(struct folio *folio, int new_order,
>>> +		struct page *split_at, struct page *lock_at,
>>> +		struct list_head *list, pgoff_t end,
>>> +		struct xa_state *xas, struct address_space *mapping,
>>> +		bool uniform_split)
>>> +{
>> [...]
>>> +		/* complete memcg works before add pages to LRU */
>>> +		split_page_memcg(&folio->page, old_order, split_order);
>>> +		split_page_owner(&folio->page, old_order, split_order);
>>> +		pgalloc_tag_split(folio, old_order, split_order);
>>
>> At least split_page_memcg() needs to become aware of 'uniform_split'.
>>
>>         if (folio_memcg_kmem(folio))
>>                 obj_cgroup_get_many(__folio_objcg(folio), old_nr / new_n=
r - 1);
>>
>> If we're doing uniform_split, that calculation should be
>> 	old_order - new_order - 1
>
> umm, old_order - new_order.  Anyway, here's a patch I've done on top of
> your work, but it probably needs to be massaged slightly and placed
> before your work?

Wait. uniform_split is the existing splitting one order-9 to 512 order-0
approach, so split_page_memcg() still works. For !uniform_split,
split_page_memcg() is called multiple times,
each time old_order =3D new_order + 1, so what split_page_memcg() does
is:
1. two order-8 folios get their memcg, and ref count is increased by 1;
2. one of the order-8s is split into two order-7, each of which gets
their memcg, and ref count is increased by 1;
=E2=80=A6

8. one of the order-1s is split into two order-0, each of which gets
their memcg, and ref count is increased by 1.

At the end, the refcount is increased by old_order - new_order like
you described above. Let me know if it makes sense to you.


>
> From 190e13ed77e562eb59fa1fa4bfefdefe5d0416ed Mon Sep 17 00:00:00 2001
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Date: Mon, 28 Oct 2024 16:23:30 -0400
> Subject: [PATCH] mm: Separate folio_split_memcg() from split_page_memcg()
>
> Folios always use memcg_data to refer to the mem_cgroup while pages
> allocated with GFP_ACCOUNT have a pointer to the obj_cgroup.  Since the
> caller already knows what it has, split the function into two and then
> we don't need to check.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/memcontrol.h |  7 +++++++
>  mm/huge_memory.c           |  6 ++++--
>  mm/memcontrol.c            | 18 +++++++++++++++---
>  3 files changed, 26 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 57664e2a8fb7..155c3f81f4df 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1039,6 +1039,8 @@ static inline void memcg_memory_event_mm(struct mm_=
struct *mm,
>  }
>
>  void split_page_memcg(struct page *head, int old_order, int new_order);
> +void folio_split_memcg(struct folio *folio, unsigned old_order,
> +		unsigned new_order, bool uniform_split);
>
>  static inline u64 cgroup_id_from_mm(struct mm_struct *mm)
>  {
> @@ -1463,6 +1465,11 @@ static inline void split_page_memcg(struct page *h=
ead, int old_order, int new_or
>  {
>  }
>
> +static inline void folio_split_memcg(struct folio *folio, unsigned old_o=
rder,
> +		unsigned new_order, bool uniform)
> +{
> +}
> +
>  static inline u64 cgroup_id_from_mm(struct mm_struct *mm)
>  {
>  	return 0;
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 1e45064046a0..75fa9c9d9ec9 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3401,6 +3401,9 @@ static void __split_folio_to_order(struct folio *fo=
lio, int new_order)
>  			folio_set_young(new_folio);
>  		if (folio_test_idle(folio))
>  			folio_set_idle(new_folio);
> +#ifdef CONFIG_MEMCG
> +		new_folio->memcg_data =3D folio->memcg_data;
> +#endif
>
>  		folio_xchg_last_cpupid(new_folio, folio_last_cpupid(folio));
>  	}
> @@ -3529,8 +3532,7 @@ static int __split_unmapped_folio(struct folio *fol=
io, int new_order,
>  			}
>  		}
>
> -		/* complete memcg works before add pages to LRU */
> -		split_page_memcg(&folio->page, old_order, split_order);
> +		folio_split_memcg(folio, old_order, split_order, uniform_split);
>  		split_page_owner(&folio->page, old_order, split_order);
>  		pgalloc_tag_split(folio, old_order, split_order);
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 16f3bdbd37d8..c2d41e1337cb 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3064,10 +3064,22 @@ void split_page_memcg(struct page *head, int old_=
order, int new_order)
>  	for (i =3D new_nr; i < old_nr; i +=3D new_nr)
>  		folio_page(folio, i)->memcg_data =3D folio->memcg_data;
>
> -	if (folio_memcg_kmem(folio))
> -		obj_cgroup_get_many(__folio_objcg(folio), old_nr / new_nr - 1);
> +	obj_cgroup_get_many(__folio_objcg(folio), old_nr / new_nr - 1);
> +}
> +
> +void folio_split_memcg(struct folio *folio, unsigned old_order,
> +		unsigned new_order, bool uniform_split)
> +{
> +	unsigned new_refs;
> +
> +	if (mem_cgroup_disabled() || !folio_memcg_charged(folio))
> +		return;
> +
> +	if (uniform_split)
> +		new_refs =3D (1 << (old_order - new_order)) - 1;
>  	else
> -		css_get_many(&folio_memcg(folio)->css, old_nr / new_nr - 1);
> +		new_refs =3D old_order - new_order;
> +	css_get_many(&__folio_memcg(folio)->css, new_refs);
>  }
>
>  unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap)
> --=20
> 2.47.2


Best Regards,
Yan, Zi

