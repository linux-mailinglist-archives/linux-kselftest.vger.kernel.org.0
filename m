Return-Path: <linux-kselftest+bounces-10847-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC2F8D3D9C
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 19:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15B56285C58
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 17:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE89181BB1;
	Wed, 29 May 2024 17:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i2YhwJ1k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80027492;
	Wed, 29 May 2024 17:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717004824; cv=fail; b=FOhInUtF9fHPu2X9cm1H2Vhc1D1P74SNl5rpRML35ZRS27aHOi/mi68zapg0HIHPGKVkNU6MjIUJ0pB7G0yxo6qMH3/9ntSbx7rhuc82CkhNkRefVGTWHWzT8rWoLNnLbpW2Q9QeXWR59gUBcj5IbmZwSS8jHtO5Ki5bCf+NeZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717004824; c=relaxed/simple;
	bh=UG2VO5tk1g6IRGeFmEJ3gY9jMam0qmOO0iXQmURY6uQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PxQuUjNMXcHZTfTcRWIcm5ESxmO8r671fquA9i0n8TKVUI3YZayDF1BkVvQajfUjqBL0tBKiVbYpK/14CD6kVIcBSJ1mQF6bAuQLPN8C3kH+k4RA6WaJy7lj+ltHR5WsXIXL6NtMxANgYWuRiRPeza9ghuASNgHypsSKodbGBcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i2YhwJ1k; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717004823; x=1748540823;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UG2VO5tk1g6IRGeFmEJ3gY9jMam0qmOO0iXQmURY6uQ=;
  b=i2YhwJ1k8MW3+Eq5OMIlH6eRm5NelvraWqCiORIDz2Bu0BKzGpF/7V20
   hZqiKtQwpyjzJVhGdbzqdKFAfBQ/biHrg/W+AkhOmpMJ3m5jr77TJ5+iV
   M0NROABdWxyFmpweFu0edmYmHaoMNmTR/EKXJJl2b2hw7lZVIfOTMgoEM
   qbRA/iv7rF2tH7O+mhyKLIwaMoj4JYfCHH6I+h3lgkKN1NpVxRJqSVmQz
   kTIZ68pxd0cM3HCCBP5VS0+r8CJX+Ezpcwm6mJfq7frOi7Zjw/+KMD1iY
   3X5zcs2iR/Hv0MZfL3DImVjB2x4+w6pCCYjZsEev4SESzq5L+aD8VO6xf
   Q==;
X-CSE-ConnectionGUID: MK7RNtVXTV+Ym71U8SW7hg==
X-CSE-MsgGUID: 0TtGPQbES8+mDyc94pJy0w==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="17263551"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="17263551"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 10:47:02 -0700
X-CSE-ConnectionGUID: 9k59+KXLQcKxDxIzF9gUXg==
X-CSE-MsgGUID: wAt2+tZfSXa/Gpq5Ddf9mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="35475965"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 May 2024 10:47:02 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 10:47:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 10:47:01 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 29 May 2024 10:47:01 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 10:47:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m76pnwTqUk+v6anJW2G7kB2LEqDTwNEusfDLYLepd7mvDHbvM1dVJqycQ0JYjfUcaqyaHHTsqTZ5OFUXrkTLq8fwSBMxgQV5Cj92QusU8TqRjKrXoGNT8csp25nvpIQsNND128p9YExTwRw7+Zx2G+9yvMHFmRtQJShSxQRQ4kY1YgVUEVk+iSOo6OC/i8zXKVq9srEI5qXngUDOC5/agwvfJR96JuUvwiYRJSbij6ScWfJHZQFvhaQxEb9mCaXppanyajWFgiN+ln81Yp3Tcy4D8/W/ZRidp0arHHBhrIqoNw5NGhQjkCoqSsCsq409vOmcbwbApuohOvq+qy4Dmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhwUPlvYIuc5Nhz8ULin9UABzC20uKgF5jljAO/NwHI=;
 b=UIV2hs8amKAlLJo1hQieWZb35m/3X+1xrkTpBZc9kPaGefZEsT6Yo4wWTMGA2a5AV0054Qf5LXMTwr7mTXicPVBoHOP6RUiwoZCi18k4qt42Jm0QEK5nWordyoTKveNEWduEhyjqB2yLnU6vxYbGGFSVWcTizc4X4VKVu0nCxSai3A3Gv39gj96krDdJAP8aKBlp3qRVCq/CtmovOc/dKO4PExtMs90bZtakNOMMd+F6EBonRX4gW4/9+EsazfV2d0LrPSlN9h8v68gTL8CIWvpVhK/v0S2z72I691ePZfcuczXW/M+MVFbtXW6VdYGiGCd4nhQqJ1dBTgGdfJXhOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW3PR11MB4587.namprd11.prod.outlook.com (2603:10b6:303:58::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Wed, 29 May
 2024 17:46:58 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7633.017; Wed, 29 May 2024
 17:46:58 +0000
Message-ID: <446beadc-d334-4f80-b8d7-53b51b85816b@intel.com>
Date: Wed, 29 May 2024 10:46:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/16] selftests/resctrl: Simplify bandwidth report
 type handling
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Babu Moger
	<babu.moger@amd.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>
CC: <linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>
References: <20240520123020.18938-1-ilpo.jarvinen@linux.intel.com>
 <20240520123020.18938-12-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20240520123020.18938-12-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0231.namprd04.prod.outlook.com
 (2603:10b6:303:87::26) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW3PR11MB4587:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a1c1167-cc3c-4a2a-5381-08dc80075697
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tzdrd3JuNzdmbWovdEQyQWlCUVE0Ymg4YnFMN1NkdjN1Ym1iaWhNdmhYQnlj?=
 =?utf-8?B?dDF4RmtaaTRlQlBkRS8vejFOVzJpMnkrZXovSGJLYjY0UHpsSUZ5alhvaXhi?=
 =?utf-8?B?WXdCWVc5TkJDRmxTQWJpdVdLZ0o1aXB0b3JDM05nNytFUWc4a0w4YW80TXdp?=
 =?utf-8?B?eXVqR29xV3NJNEphb1VGaCtSbDgxUnNBeXBFMlg4SEZYeTYwQzVobllMcGdO?=
 =?utf-8?B?ZWJCMW1ndWMrRVRTM2N0Y3RRSElGZ3V0RXVuNXBQUW9DN0NiUTlZdTI1SEhM?=
 =?utf-8?B?OUthNUpmYkJCYXN2aTZmV0wxcWp2UStlVzY2MjE3TVRRQ1hlbTd4Zy9Ua3ow?=
 =?utf-8?B?M20weVEzUThjeFdGRjZ0bDVMV0VYbUdnOWtma3d2S0pQVEtuUFUvL3h5UWJw?=
 =?utf-8?B?M2R5TkdjT3pnUVM5YWozRzVWVGR2TnN3blgydWtiQUc5M1JnMm52cWJqL1Fh?=
 =?utf-8?B?S2huRDYzdmg5eERFMkNMblVuRkNPdEZoOEpqTFZkTE1mVm0wM0IyVVdweTR4?=
 =?utf-8?B?bUd6TCtuNnM0bFJVSFJRSDBERm5lZzl1NFYraXZVSmZIZDVXdHExaTdzZnR6?=
 =?utf-8?B?OFV6MHBSTHhpelVyeVROQXl2NmNFdVNtc3dZS21SZ0FRRGFsN3dPL1lhYVVt?=
 =?utf-8?B?SkFVZWxJOXNCUmd2RERMdGl0cnZoeUtMU2s2UGJwcDh3cjYxeXJ0bjBGdUVG?=
 =?utf-8?B?TlRJQVJQNDRwSW4vekt1MXUvSVkxcklyU0N4Z0RlV0Z4MGk5azd1UURJOGpY?=
 =?utf-8?B?NStHNHA4amZRVHlhc3BRTDNiNlpIWnFpMXdLOVZUTWZROUN4OGRiN2pIcEl4?=
 =?utf-8?B?empLWXhBcEljQzYwOUFDQk1McEFKMXhnZmVyNU81Z1FSK212bTQ2aXU1TU9i?=
 =?utf-8?B?cWNqUU5yMHA3VkZVTHh4bVo0WmVXSHhHcHZWS3lOd2tDVWlFMzM3S0dFZzdS?=
 =?utf-8?B?VFJVUzlLRFdZbHpBVFdWcmhNdUJWQXFhdGJ6dGtOQkhKUUJHNDh5RnhzL2o3?=
 =?utf-8?B?bXlkUE5NajU1cWNPcnVtazJOdysvVUFnT004SGRTNVJRNjBSNWlTZm15NnNT?=
 =?utf-8?B?S0FsenpLUFBBTjVIL09Ea21hNlRJQ202c0pkTVNISFJFY2taR1dhNm5NVnVq?=
 =?utf-8?B?NUVXeGpHcDF6Z0pNREV3QkxIbGR0WVI4NUpxS0J2YlhadTBkME9jWVVxNTZR?=
 =?utf-8?B?cFhVcmFyelByaUFSSnFhQjNCa2doa1YvcTdoZ2tkOVYrOUljMStuMXR3NHEv?=
 =?utf-8?B?RnZJME50cnZtVnlhb0NwVlhtMEdzTzVmNDQ4R2xnM1JIV1haMjFDNkd1SWFk?=
 =?utf-8?B?MFRGSGFGTk1YTjRnOEM2OHdtOWZkNzExMFVzQ1lWMFlNNndjVGdyVXlSR3hv?=
 =?utf-8?B?SFRoT0YxNlNEV29yMDRONjRwSmxQQjViK1pidFlycTMraWM4aDZiVlo5OUth?=
 =?utf-8?B?emlVQkVWUitYREVZTmZMK2FsUFBSUmRhVGJCRkJ3Wmw4MEJiL1NWa0FZNmFC?=
 =?utf-8?B?a05FRSs4QWVweGxEWnJyd04yYUJLWlVOdmI1NW9UcC9yNDI4RXVIS1R4VGZy?=
 =?utf-8?B?VTY3ZFJwdWkwc09uL0x2ZVJUUmNZWVY2S1JQN1BaZHZJOXkzQ2xOWmUyNk04?=
 =?utf-8?B?YVI4Z2hmRXNxRVFOZ3NNaEc5ckxsMElseFBMZGxJOUIxbzhuRkRjNys5dlhy?=
 =?utf-8?B?Y3IwZjgwaFMvTFVnUmozb05rTjl2UEw3dUw2L2pHTXovWFFLbnVPNkFnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0dPOWtqK2UrU1BTRVUxZ2czdEsvT1JRZmFQSFRCNVJCelNxdTMvQjdqRyty?=
 =?utf-8?B?R2FLTFpNRi9GRXdVNEhDTzNBQy9BQ1Zqb3ZIb2hPc1cvcFozVlpSbkYvTkVz?=
 =?utf-8?B?cG5CU2FGNy91aDFNeXpOZDBMS0pxNy8yNVppRzl6TDJYZEVOOFZvMGlWOGlP?=
 =?utf-8?B?ZWx3OW5YdDR6TXZOcXFhUmEvVTBTNTRQR2U0RzM1aFBBU213bGRwRllKZVJO?=
 =?utf-8?B?UmlhOHlucTlldGNhS0Z1WnE5UjVCOERrMlJHWDhnMDRuaWtobzZ2eVRmL2xv?=
 =?utf-8?B?MjU2ejRhSjdFMUU3N0VGNmpxRG1YNW1ZMWxuQUtuU2ZqWFptVTdReEl3K2E2?=
 =?utf-8?B?cGZCU050QnVNQ01vZ2xDVktyL1AyTUNqVnpmWmt2Tnp1MnFoTnNCSktGU0w3?=
 =?utf-8?B?dTA2Q2xLa2JhQzkzZHhYMnkrOVJVbzhPd2FVZXJ3ejRkb0s4dVZQUXgzbzl4?=
 =?utf-8?B?VDY2cE5xbkNBaU5wSHJTVWRBdFpDWmZmWS9EQTdncDJCdmZyaTgvejlWLzhE?=
 =?utf-8?B?Rml5Vjc5NE5wTC9ldEh2WmdPdm8ycy95OTI5cGFNRFloaFNkQXUyYTFGMktB?=
 =?utf-8?B?QXV0d09zckdsUDROTWhnVXh5MFNIdUgxM0xNdGgwQm9sYStCcEZsYnluM0lw?=
 =?utf-8?B?blNmdjFkWC9Cc2p6WUxLck5oOW1tL0tTMTJzWW50dVVvYlpEcVpJSjFjdFBP?=
 =?utf-8?B?bVVCYzliWkNEWDdJUFMwME9NS0tUd1dUczNwUGxxMVNiTkZOMU43NFFKV3dN?=
 =?utf-8?B?bEZsS0FVREFFV1dJT3FEQ3lFT3hSTFg5SkNkVzJGS29qTGxBdFBSVHBqRDZC?=
 =?utf-8?B?NE85RU5ZUE12WWwyZWsvaHhhL2RER3doZmVHZDFkRjQ1a0dqWCsyL2xuN2xN?=
 =?utf-8?B?MlRLSzU3NTcvUS9kVEdiUnA4ZkdRc0pUM1VPWVo0NzM3bkFvVUZkN2lLeFdL?=
 =?utf-8?B?a1Bvd3Rha1pVcVQzenZvTGNwdUNOUVg5MC9XNmR0WGtsM2JWVzhIT1RXeDZs?=
 =?utf-8?B?Z2pXbUxNbHFlSkVOKzZkU3FoeUlydXMzbjZNZTRYK2cvRm5nZHJZME00UGlo?=
 =?utf-8?B?ajJpZ2JYLzdkdXgxME5vc0w5Tk5IOS9jTkVCczVCMm12bWkrRXVrS29PMGFV?=
 =?utf-8?B?V3kxRzRiZ2E0U3RNRFppT213MHhKVFJrZGZQbWRLMkFoZkljc0hIZnpRRURT?=
 =?utf-8?B?QzB6WHpaNHZoakIzenBmdXh5NzNzZGgrR1BRNiswVUxTMHFLYnROYjFIY0pR?=
 =?utf-8?B?SEFZMG84YnloZisraVh4VVhXZEJ5czMxck8zTzQrNlNTQTBLL055dm9nZnpj?=
 =?utf-8?B?bHk1aUt3dUFUZFRkR1N4eDg2TExUSGFtbnBLeCttMXBNeFhoSkJNbm9CNnJw?=
 =?utf-8?B?WXVnS1FtUHh1cTlKVytrSk5JU0hjMjU5UlVMU1FuRkh0ZVdZVW5nbCtLZ1Vz?=
 =?utf-8?B?dU11eTdtdWZmdkZ5d0lVVWFnWUNwMDYxVU44M3pmdlV6dGJJS3hoZlAzMVJt?=
 =?utf-8?B?RS9wYWllYWJTMW1MZDZHS3ZuVUpCZ3hCenlHQml6V3BYS0V4MVAyenR4cGM2?=
 =?utf-8?B?TCtsUStYak8rY3puUFNUSmdQYmd5a055ZXJSS01TMTRhL2loSW1oVlNEczQ0?=
 =?utf-8?B?QXNNOVNucW9LTTRuT2tBUTRWa3AvWVZTU3M3Smc0MVFnQW1RZW1Db0xTVk1m?=
 =?utf-8?B?YlJuOThJVVVjNUVRd0NUeVZhUmYwRGdhT1RVTGZmRFRQOG5YT0JNdnljOFR2?=
 =?utf-8?B?TDVlcGtrWDc4TjNCWHQxTWtrQXFlYWRGSEJoUnk4Um9FWGxjVjFTaTB2anpy?=
 =?utf-8?B?Qno2SktLbCttQm5CNG9QQzRSdFNIMnB0ZmhSaGw4MldUV2c4Q09haUExMUFV?=
 =?utf-8?B?dHVCQ0lHVzlGYlJGaFFFS3BYM25lWEtFQzFIRGFsUm1nNEdhcmJEb2JPaHVv?=
 =?utf-8?B?a2t5WStrZXQ5ZWxlVjdZNTIzbnVkZm1YczA5SXlsTmMxd1NZSnNiekl5b2Mz?=
 =?utf-8?B?MlFwY1lhNzhRSVoveWVlM1JvK2V0RC82TGdkTWpDcE4yMjlUL2RoNFRqYTdl?=
 =?utf-8?B?UzU0c2o2M00wRVhyNk1hSGpUUmVEOTZYS29tTFU0UFM2ZC8rYXNmc1NTcGp1?=
 =?utf-8?B?bkF0dTdoSHU5K0w0TzlNSzY0NnJiclNadWs1Ny9yNjdUbm45ZDNWeEVkK2lR?=
 =?utf-8?B?ZWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1c1167-cc3c-4a2a-5381-08dc80075697
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 17:46:58.6803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l2Q2Kag8BORQhC3E3hFuaxFpRYtOL4sDDwvwB5TYyX7Eh+Edin9uA0Plgw6YuWBKMn5akC6dccq7cIPifRahv8WFIgmwUaHvQnYWq988pgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4587
X-OriginatorOrg: intel.com

Hi Ilpo,

On 5/20/24 5:30 AM, Ilpo Järvinen wrote:
> bw_report is only needed for selecting the correct value from the
> values IMC measured. It is a member in the resctrl_val_param struct and
> is always set to "reads". The value is then checked in resctrl_val()
> using validate_bw_report_request() that besides validating the input,
> assumes it can mutate the string which is questionable programming
> practice.
> 
> Simplify handling bw_report:
> 
> - Convert validate_bw_report_request() into get_bw_report_type() that
>    inputs and returns const char *. Use NULL to indicate error.
> 
> - Validate the report types inside measure_mem_bw(), not in
>    resctrl_val().
> 
> - As resctrl_val() no longer needs bw_report for anything, it can just
>    be passed to measure_mem_bw() by the ->measure() hooks.

Needs imperative tone

> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

