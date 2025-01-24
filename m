Return-Path: <linux-kselftest+bounces-25136-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FFAA1BD62
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 21:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6229E167384
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 20:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687BA224B18;
	Fri, 24 Jan 2025 20:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RiUBRBBX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2CE18A93E;
	Fri, 24 Jan 2025 20:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737750562; cv=fail; b=mSPzAUARXs7Ip8xwDd8Z7VmDHsq6fCrPa0RZHyzbnaDzebEdeR516pqjHcxdzgoR9OqW6BZOgYcQhnj0XSDlW28huPJusgd+cWwZLovbZW2RmsFthTQGThxSMrCHHbIC8ERiSwQxdDR3X6YoDUU3basygde5YQLg3S2pvpkzVHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737750562; c=relaxed/simple;
	bh=h/PmwGBqqAuZ8ltz0a++KK6/lfZYAuqTct0gaItgSoQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ns6bUjUnvTdEIB+0U0PJzbZ1pxzpim1XWw4ZV6CCEMa07gHNl660AQw9SrxhrkxdMdzODWDQ7ArmNzj2vtbu34QIvZaL8m2xPhSoWlePDiOpAk5IcOjLu02UIH460IrqaL4l1SFNVO7tm+BbGvqlWHvzCzNRwaForSqwi+T8P/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RiUBRBBX; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737750561; x=1769286561;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=h/PmwGBqqAuZ8ltz0a++KK6/lfZYAuqTct0gaItgSoQ=;
  b=RiUBRBBX80/YUxKNBX9rePmRc1Wndlb9ty6u0sQ91CuSYozFe+/B9VlU
   j5y/hgKvj9VK8R5wiPud0YUpcXIfw5s1eXGbZ7FFpL1PB6AEO4KPt8WSI
   voTmi79AKGAhr/jwiUvLiD36nD1AQwL25bRDx7dRJ8iqeR8awdqdeaNdk
   ly7P8LCzFREkTFF3rNfuQw4JMgRAubtBxYLR+gOGIOPos2Dvk0vNyGk0k
   iwmCt/L0WJlEDuQAzvQlaantssSKURp5N5c9ktPHSODeq0Rhrrd78ZQFj
   wuRVDwqdNQgj4RUIiDN0Zf1fWs4ngeoTVf5dYFvyVHQcqdtAOcr9tzkaX
   A==;
X-CSE-ConnectionGUID: mS3r+xoMRDya+ZUrmQnvKw==
X-CSE-MsgGUID: JuIvxjUXSxugjLvEsfAoOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="42057894"
X-IronPort-AV: E=Sophos;i="6.13,232,1732608000"; 
   d="scan'208";a="42057894"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 12:29:19 -0800
X-CSE-ConnectionGUID: VAlNmmWeR3evLEKFCj1e7g==
X-CSE-MsgGUID: 7q81vk/iQFyVFwBZM9XeYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111893531"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2025 12:29:18 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 24 Jan 2025 12:29:18 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 24 Jan 2025 12:29:18 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 24 Jan 2025 12:29:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ux9yLQlODRyCYZ9GjpesIqu7f0luTwJkc5FKpkEP6Q8RuHGC+ayZ9uOuziLVxCVDNhO5a4FNA2X9fHGHAgPUHpLGA2Ef+XHfV2OdfjIfAj7s5RvXVDKRhZIL96ERYsdawI3aah2ZOW5u3PHSMzoBThwX3Mrf2+Ne1pSieAUoM4nwr4xyh9posziCdixq3sdOv2fNJRW3J5D+0hlWiiE4zJ0QA425VTXIOA4e/nFFFdwFKr8fcuEpNr5ehAlXDT3ZGn90ickYEOr4Tzk4LA1ystT/5uSQ+YD0zi4lMUsWC8fWRzz4FeDFLQr9hC8KE6i6LCffaesYnKIvVOIgFzD+/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YzVrgVo/SgrSpxpKZF+gcrubZS3j9aUm+2wzQUuUK3U=;
 b=xgjly/1tIzKerf1AM5ZW1QmC1ZB++JRrJBRstT60eX73bZwuTn5FaB4bKT2KQCbAvNc+u+AZgqKaphCDdjnMrtjYpF29z3xMAhfThr86dJNL3GG1kd0qbWwIPfOE9FNCUMEaSDaH2Kua2IrVKaoasUhVWZR5T7TN7FHea12QEzuMjYa8kDKKetbDcauj9fTh8Y0G0tpSz6NCRn5Duc2097N5zSmAAbtwfSwb9NcbNZc+uIDHQWeZyvCHBtkTJ0S65qNjfBJwK/+7bv8LjACNcDPLDv0MYM95phJLLje34c6Eluqc2s4FcsXNtmx9u2Nn7YaM2xNz8XkRGaHOfBFe8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by IA1PR11MB7174.namprd11.prod.outlook.com (2603:10b6:208:41a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Fri, 24 Jan
 2025 20:29:15 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4%5]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 20:29:15 +0000
Date: Fri, 24 Jan 2025 21:29:10 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: <shuah@kernel.org>, <hpa@zytor.com>, <x86@kernel.org>,
	<dave.hansen@linux.intel.com>, <bp@alien8.de>, <mingo@redhat.com>,
	<tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <kirill@shutemov.name>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>, Shuah Khan
	<skhan@linuxfoundation.org>
Subject: Re: [PATCH v5 1/3] selftests/lam: Move cpu_has_la57() to use cpuinfo
 flag
Message-ID: <jedwquwueotqbxdecgilxcci7bl5olfxb5gsc65qlkce2wzgt3@xo4xmh2jpflf>
References: <cover.1732728879.git.maciej.wieczor-retman@intel.com>
 <63f8fa8ac016f9f294230657e9069a616bce6141.1732728879.git.maciej.wieczor-retman@intel.com>
 <e1aefeca-8f85-48c9-8972-1c23b34aea7b@intel.com>
 <yu3pbemophlzqgd67xongzdflsj2yp722x5brj5ikaiyprxckm@b4vmk4kajxlc>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yu3pbemophlzqgd67xongzdflsj2yp722x5brj5ikaiyprxckm@b4vmk4kajxlc>
X-ClientProxiedBy: DU2PR04CA0287.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::22) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|IA1PR11MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: 95219db7-188f-4baa-00cb-08dd3cb5c54f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?psvavzqDj26ght7GUGgl5bdl3rRm+iVhXFJiRbWzOkkzUNZ5o2Pqy8sRMg?=
 =?iso-8859-1?Q?uxtlUEdn4L4GW0xHoFcM0M3aZAPUandOfkGsKXWaTjopSkGZfCnLxE693U?=
 =?iso-8859-1?Q?n2VffJOHXTlXa3eNWDHUhco+EL15RBn92GaQkIu9v//xfP7xWwz0UWQ0+T?=
 =?iso-8859-1?Q?JUCtD/z6sls1OGR+QukecjZvyzrC+eWL1P0CWgX45QfzWfiBYlzPTIqYfd?=
 =?iso-8859-1?Q?aP1xoqiZQyQ6cWq/Gs581q0yC5OEdMtZ6O2yM/h30JI852KHmwjk4WSKgc?=
 =?iso-8859-1?Q?5PKEM71JeUYuv7Mj45nCW1VWr3z+UHAioUmnwm+hTTExRgYcfiZxa2PtAZ?=
 =?iso-8859-1?Q?mFJl5ffnqnLtlz/AXwqW5LBYPmcgMUa8qkXaeLHlihZBwMLTseIVSZvu2O?=
 =?iso-8859-1?Q?ah7qxPFsZh+HprABmj9fw0dZtSXseSYB/A9qLC2aEbjOHK/8wnfebptGuk?=
 =?iso-8859-1?Q?vv6QqWLIRiepApdbQIgm07LjqVk4lx+H0S7oWldaxOHAceZ2fc2xU23OtA?=
 =?iso-8859-1?Q?w8Rh2kbxN6M3gVaqQ4CivWKZiHv+YonMr+35Y1ERgw81W8huiZhqq3Ogh7?=
 =?iso-8859-1?Q?Y4/xyL4PGGstZztSJJ1ihmKkzeDeqk5buQWNTBckHrON0BMga7b6FXMv78?=
 =?iso-8859-1?Q?SBxSY4IuuKVcGeDOBSbYGJDGpo7IlbsAPQG4K5ONU3/KD1bkfd34RHn5CY?=
 =?iso-8859-1?Q?NkT3iBqi2M4u4/57xulkB7XuQinFJ0gdzLuYoLPbj7N3aDGle1citQ74JA?=
 =?iso-8859-1?Q?P9gQQuOP1SHtqMv7P1y+6WAQghfgFCdc0sxsVG5kkWjqcq/qcAxgiC4fR+?=
 =?iso-8859-1?Q?MioGGcDU1tJy1vNfF/VtlBeQdpuWqxIjntmxvbeuuHesxGpRXKul9rFccm?=
 =?iso-8859-1?Q?8hcpU9mthx1OyVNwg4DVag65bXrsE2JDm9oo6ACoc8kMFT7O7xyqqWEn5F?=
 =?iso-8859-1?Q?IJ+Ymzq9OL2J4Ckow+p224huqW7v2pOoKZjMokQhbRn3nILhzgy3fu0n9c?=
 =?iso-8859-1?Q?XBlSyYqCcJZ8TqRzzdNGUf8YVwGuhDNE27h7JJpkleZgqfcZ/epoMRlZ9y?=
 =?iso-8859-1?Q?qB2aXfeMDX+VseK6TFymrx1kbCH1cNpkuSBjpq3qXmwYfZ1JSdcFbEzuUf?=
 =?iso-8859-1?Q?GJzrWj7ymzyur9vDAuNWGHFtzXPzQ/LbfMyv/+yP2V+ZOUBWYm5QyrhJVA?=
 =?iso-8859-1?Q?T83hiQhNmPWAnbJSURuXOdVV2iBp8dlc1+yZGymX3UL4mJIwy0j0cSudz9?=
 =?iso-8859-1?Q?5gKX/DQaRkKfwhHHv0zRtfTnmIsu1uLsCxTzciDukXoKo/dBHJBA6WGtqT?=
 =?iso-8859-1?Q?28dCGCNcn+e5Su06rn+3zwDQjRXS5Dyv+h68xpAeGXw5WppHlgsDvW32cx?=
 =?iso-8859-1?Q?Mq8XlMULs1YA/zYaCsVGoSAfv3uR1h1SqN++q51fsWKafy4btAV4SURGH8?=
 =?iso-8859-1?Q?yz68PkBblyMkU+Kh?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?+EPBr6mReW6bbGHTp3WhP1TIh3ni3aIgCGQRcHUnMzHda9OXAYLa4QX2r8?=
 =?iso-8859-1?Q?DYR6WPad0AKE1gDuBD/CjzRWNxWo53BazRxh8EZeT1/Xm9rPMpBZIYHprW?=
 =?iso-8859-1?Q?lWW7cGrs3UoLMpx5m6kvlVddMo4s2/NyPQTzS0UghdAy05/UsF2dL5fRuP?=
 =?iso-8859-1?Q?iNchmUApghaP+I2xMMP1lnT8BdKoP7pV2xVHW1S0YB8YCi7bJpU7ijx0lL?=
 =?iso-8859-1?Q?NwJB9gWV8+4AibsEoiEJlhVp8JS0NKBTZMAZOVpHTwD0YtC4UK/+vINWDd?=
 =?iso-8859-1?Q?iocViCc76vjyoL5ykCEbBKrcG3PNyFrmh7lDMn5/Dayz2ewx7Y39gOwHuf?=
 =?iso-8859-1?Q?DqkQNzHq2e6AE/5D8zqWteoA3y1THcUN8h7IubL85+OX6g7azl0lBbfhoc?=
 =?iso-8859-1?Q?CxNbh4YsVlH0feZTltxZne3FTivKdefnnKIspcHiQQpkgQdn2n7/zANTfj?=
 =?iso-8859-1?Q?vgEDKAbr5og5Y53dOiXNJskq4yQqOFaK6w6vYjmTIhs/62c6KHIZq2QW+A?=
 =?iso-8859-1?Q?hRINMqT4TxKsK0heSSJjZkhOe9tIH/XP0b4DY/ifKZRFLMQEFRAraD6b4g?=
 =?iso-8859-1?Q?Fe9DCAPvdfskREXI9r7gYM7C0Mw99XwGP/x7wtXjZjhHzSsuQ7IBfpOZtm?=
 =?iso-8859-1?Q?BmAHXujM/uUCRYYtQnUS/19dHdf/HoMJLQSnvlS9ILNU4kiY/9Msj6eCgz?=
 =?iso-8859-1?Q?Zoy4IDx7dMhMq6eSysunZGybgcqIDlbOkSTrLdmpS6xcx+C8AZ5RhRk7YV?=
 =?iso-8859-1?Q?8PYpSJs00eLWLZ/7MbN8Pyk2oXfnKROqTxR3WCOB0AvDZhiN9zaBtdPqEy?=
 =?iso-8859-1?Q?inz6UI8cWrUgkRQEvG0Izs8b0yvIV/XYKRcMUFMnbBpxDpvHrs/ggShX1p?=
 =?iso-8859-1?Q?qg0FJ0DZ5dxawhq5mdN6/3vXV5G9dAuUFU9MMxguk+lRUVYls5nMOiJ/1F?=
 =?iso-8859-1?Q?qVks8LFhSmWZt4c0KscucH3MBEIUobPlUi7FnKuw1Nkx19exLaEYY1hXA9?=
 =?iso-8859-1?Q?aqy5K8JOPlSDjth1N2g9bQ4NGEhWIIlcWo4R6KCfc7MTwcvYaPjSJcD6Rn?=
 =?iso-8859-1?Q?G92eFpi8/Jen+4nspLkDcyGsn31GPVUrHu/rp+qwLCeiH0K+cw3FU+Q9E2?=
 =?iso-8859-1?Q?zJtTRgW9Y9I9CYVFLeqoggRnWpLwcIQ9J65UX60omGPrS1qfUet64HcQcQ?=
 =?iso-8859-1?Q?aLyaICkxLdzEddyKeIdxOK8cujKq7ibUOKhjj96if5nZyddNJ0r6iV5ER/?=
 =?iso-8859-1?Q?7I8YsG0hCpWuyi7yjoyY/RLfpMKU5P4GRZcVMOqVSAKs/wpudAbMLM/F/p?=
 =?iso-8859-1?Q?P0QPv9Ur2UNusl92KTGHpTM2gl5sz7AfX1tbt9TiZGOYBY+nNqW91Sr6BN?=
 =?iso-8859-1?Q?nyvl4svyvfpKgkpCzbRYCjDmbHCpU6z2OvxVy0NafPjEKIkt5zM3tTF1oX?=
 =?iso-8859-1?Q?6NoKLoQpGPJgOII3t+Lsp34TZbi1EQnt/cXVDDjuU/EApHcig0ezBctDkR?=
 =?iso-8859-1?Q?+Eqf6jbR8Xg/c9aJJQgkrEZY4k3HQaUfcy0khddVmv9JGPs2ZefDW2BkVK?=
 =?iso-8859-1?Q?3TKEToBabwit2AiocSCgKJFpm8sdxs+5x7yJMT56Kr3bWn57iWqt14VYql?=
 =?iso-8859-1?Q?Ywxkl2tkBXoZN8llSC7akLJS7TovPkCt8vkap67vs574cAPaapNPnOe/sy?=
 =?iso-8859-1?Q?s06tJBEbV8theK6fBt8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 95219db7-188f-4baa-00cb-08dd3cb5c54f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 20:29:15.4530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qGOhf5mRZh0enDzJPDiQWR+2ZKF0AMzM+wcfYKes29FY44nDUOW5uRcOUneV+kyugurgWXEEySHcKPFj+TUebIZRgp1WqsbpvR9WQtv52X8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7174
X-OriginatorOrg: intel.com

On 2025-01-24 at 21:17:22 +0100, Maciej Wieczor-Retman wrote:
>On 2025-01-24 at 08:14:41 -0800, Dave Hansen wrote:
>>On 11/27/24 09:35, Maciej Wieczor-Retman wrote:
>Sure, I'll try to find some other way.
>
>My previous tactic was to munmap() a high address and see if it works. Does that
>sound okay in case there isn't anything else would indicate la57 to userspace
>reliably?

Sorry, meant mmap() not munmap()

>
>>
>
>-- 
>Kind regards
>Maciej Wieczór-Retman

-- 
Kind regards
Maciej Wieczór-Retman

