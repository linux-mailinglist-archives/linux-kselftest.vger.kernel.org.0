Return-Path: <linux-kselftest+bounces-34401-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C12FEACF809
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 21:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14FF51886DFE
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jun 2025 19:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8B71E5B9F;
	Thu,  5 Jun 2025 19:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cCP4Aln5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AF37260C;
	Thu,  5 Jun 2025 19:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749151957; cv=fail; b=nHyb+u+0mbh97XlgeoJWJ4O1J8qXOzr3u7veh96jX6RemZy+8kEhUf2DJkrYZoJjRE5a1Oh/T8gGZpeR/zOmj9D1LJeTynMe0zCUgO44apkTseb+R48oNRP5D/4t1wLq2q0/kym/D4J/b6tm/vCYdhcei/qqT9x1IeZkjjBo0wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749151957; c=relaxed/simple;
	bh=3YDlO2P9LBS6qQ74SaFN3m9F5W7Hj91rSt/XV0XQCao=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S4IWQV1DnRaVrTrulKDwS3I1vLhjz9GsGtMG50cg5awlUeanJ1ZYOcQewUB++TQufU8od/SOdkKuLmIyw98vS1W3lRTztFG8bdl2QSfkkG9Odatr9MvclpfJ3qAKIvEhmgYC5qCmKq+RYYkSyYnGT8CfoLiId2kBgdpgP9iPKxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cCP4Aln5; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749151956; x=1780687956;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3YDlO2P9LBS6qQ74SaFN3m9F5W7Hj91rSt/XV0XQCao=;
  b=cCP4Aln58UX1q7GwQbo+57vVK+VPN02rA5QQfOCa4gGI2dckbJfUMpxw
   BV14XvQjI3D9V/+rfhj+UHKg37K8xRFH8C82K/Pxj4t+jtms+CjMhAzXc
   rWMoPqxIKldjQPPsCqXvuATgWdRJ4/YrK3oElhtZaxqasCXgLmeo3Bi4L
   n23lMbvaMr+WSHMAEjfU5TmgTO1t1aXVhL0gHKivh/CEzmBq2wOpUbpk3
   U7vRbNLxVdFOE5tCHSxETujL2iyFqokVN2yxyWkqZuce7vO/YvTkH3TDv
   jx1mzu5CpeTXcaPbV6Rt3UQ3hh1prjrVwZ9qDZRuSZa7+8H7PkiWslFts
   g==;
X-CSE-ConnectionGUID: zC/zYpY5R9qo/mV5uEXZJw==
X-CSE-MsgGUID: 0JZ11fV6QHW3p2hsWuLgWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="50989788"
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; 
   d="scan'208";a="50989788"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 12:32:35 -0700
X-CSE-ConnectionGUID: vpeK0l2hQ3CfG1tO18iXUQ==
X-CSE-MsgGUID: tFrrN6RyQ9+Sv+nypB7/DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; 
   d="scan'208";a="146190978"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 12:32:34 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 5 Jun 2025 12:32:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 5 Jun 2025 12:32:34 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.50)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 5 Jun 2025 12:32:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i4Crx9IvXitZ6ymm2NH+tjaSeVb8Lps5TXfhw1i2iyJjVGcQzYls0U82YoSuVEVjYCPZdYVh85OkBzenl9w2/ilow1998JdY2Yj1SlM68WpXNGf9hsULmkkgTiQbNzuQvWGky0aK8Bm/CB2VAgb8wOcjX/je4Hy+AeB/Yt3itA/lCmZ42eEflwYO+Hc28YL03vvrPxsOChGA5b81rVvTiSlwrtccSvIwHYiymMV0V+VXx0hfloC4ACsfvjfGrclP0Q2VJ8kQUHHk9OwhZu8An0UwwKQzqey1u9OPGbK3Senoz/eNTku1qa1PuIXfAmLLxLAtJfzNfD6Yn3o3LhpZGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srJzkkgno/m6M8WFEogO46lcc7Su5tXfvLSFDUINcfA=;
 b=D3mF1c+bWlsQomNnlZqx3GuDWN4SDMVCZWJfBhPYe0zU4k8A248bWCYQYh7NBZanekYSA2pyE4BGdSt4P5+GaXVvxUk3kPtE558fh3sYAQOVZC4kGOmXmTV/o8PZmMkwoyPlP8Cns2JF7PI2se8x51B7hYnbPe/U6nzgkzQMxe8c4TZClKhlLjL0lHtc8HWzvEL76EwSKwiZGsE005cS5eZVHTQwYKnjukUHu6wzpX711H53icMwUIw9EVZfqdUhNVCt7fb9k6CeImv7txpJKMOui6fAypISTA/4yCYdqPwWB5nEHPqcbogQBjyxirwL5DGLzUWpvLQQarJxZxR9JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by IA0PR11MB7308.namprd11.prod.outlook.com (2603:10b6:208:436::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Thu, 5 Jun
 2025 19:32:31 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%4]) with mapi id 15.20.8813.020; Thu, 5 Jun 2025
 19:32:31 +0000
Message-ID: <8264e653-6570-4c2a-a9a7-c4104da26f76@intel.com>
Date: Thu, 5 Jun 2025 12:32:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] x86/fred: Prevent single-step upon ERETU
 completion
Content-Language: en-US
To: "Xin Li (Intel)" <xin@zytor.com>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<shuah@kernel.org>, <andrew.cooper3@citrix.com>
References: <20250605181020.590459-1-xin@zytor.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20250605181020.590459-1-xin@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR10CA0027.namprd10.prod.outlook.com
 (2603:10b6:a03:255::32) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|IA0PR11MB7308:EE_
X-MS-Office365-Filtering-Correlation-Id: ed2e0aba-7aa5-4395-c88b-08dda467b6a2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vk9JeVNpSnRKZFBnRzJ5NHgwSUNuUTBNZnduY012S3kyUHJiNFZId3gvM2xF?=
 =?utf-8?B?ZkhyTzB1a1JLancvcnc5d1RnZ3pXWDUxblhGVEFLemdzUEt0cVlaSWNWNExl?=
 =?utf-8?B?U3cvSWFXOWg3LzlyN1RBSzEwQWFPNk1jWWp6Lzh4VHI4bGllNHpaRVRBcno2?=
 =?utf-8?B?Nm1pMWZtWWlUUEtJbE5kdWJmK251TnB0L3hDTURZZ0p3eTU4dDlDSTdqTlpG?=
 =?utf-8?B?cVdTWWlON0Q3TXgrUnc4dUxBVjdoT1FkMnUrWHhRKzlYWm9qMmEvNldvR3lw?=
 =?utf-8?B?dEdVRk44WHNVQnBnSE9wSmJ6V3oweUF4dGg2VGFESEl5V2FqQWF0WGpjUjNK?=
 =?utf-8?B?VlFiSG5RalpjUklURTBZdnpMYllvRVZCNm4xRnR0eXpQRzdWZHg4cC9pWjE2?=
 =?utf-8?B?K25MZVBRLy9ORGNLNnJTNmRNTUFmYUIxSmpwcloyakVKdDhwY3Z6MmVEL1JF?=
 =?utf-8?B?S0pQZnNCT0xzUytEdUk2K1pyOEhLUVBDd0VtWitycFh5K2x0WVBjU3E3SVR0?=
 =?utf-8?B?UldVY2dzd2RpdEprQUc4d0hqeE1ZWFVmcXRRckhmakMrVDlFc2xlRzA4U0JK?=
 =?utf-8?B?cThndUJFT21rdnVXSW5maUpKb25PQ3pkNFY0aDFObzlmQ2duUFFmSDZ2bVRl?=
 =?utf-8?B?cjcyd0JUK0hZUDlQMGdTbkVCem9JWXhHRUNsZVBvc3h5a2p2S2E0ekQ2Z1Rm?=
 =?utf-8?B?TW5WQzAxZ1dRZFZYZ1RKM0hFUng3VHovQjV2WEEyVnNlbmJTakp1elk2Y3VP?=
 =?utf-8?B?T1lHcEQzVklJSDRtWXlBU1pWVjlPYXBKbEhNWTBudWJBUUwwWm8zZ2UybnZz?=
 =?utf-8?B?Z1g2ZUJ6UDlsbVFmcTdyaXNwVHNhS1RDUk5LZ2FabXZ0VGJDd3d5SkZHUjdn?=
 =?utf-8?B?OVJIU0h6bnlyNWlUN1NCSG9PM1pLSDN4S05iK3dsQXdGdmVOcWIxV01rcmNU?=
 =?utf-8?B?NlFSTDU3SkxBbVMxbHVPTlptTWhiL0lZZlRMRFNZMk1IUysrTHQ1YVpVNmhm?=
 =?utf-8?B?SVU5dkxHejNrS0I0Y240QmNkcjFRSmhkSzFBMzZMaEVNY0pNczVXOCtDbXBk?=
 =?utf-8?B?dkZXZUhNRlFQRGNDVTBFZW4xQldmRzFHb2NIeDN0ZllmRmZSd2JSQ3MvRkJT?=
 =?utf-8?B?R1ZBa2RpWkJQV0R6ck5QaFdFb2Q3VG9jc1F5aURxR2dpVFg2c21IVlN0SlIy?=
 =?utf-8?B?N1prOHNlRkpOSWVzRXM2aXlIdkJENysrNGNVekVha0VlU3BwZ2d3MHBaN293?=
 =?utf-8?B?cXpGZVFUaWVLUzE1RGdubzdvNDR4RmVSZHR2MHNLcGpwWFBiWnFNTkVsbUpv?=
 =?utf-8?B?WkZJVDZIUEM1WnJwbk9GcWdZck9ZS2ZHcmdJZWVzSDVhd2RwSHAvQzhIMi9w?=
 =?utf-8?B?YitRQ0hKV2p5djcwMGFCTzBPby9CbnNMOThqTHlVaEtRNzBHRWM4YW11Q1Jl?=
 =?utf-8?B?N2NJVktwU28reHI0YUYxbmIxL0JvUUlKU0dQUTNDbDZXc1JYQm42cllFMk5U?=
 =?utf-8?B?Y3RndFk4bzBldWRpYkowYTUzaUx3RkFwVVU3djBVbnk5R1pRT1BaYmZBMXhr?=
 =?utf-8?B?QXk0K0hsZXZndmtnTERrODM5blhVQ2draXdGc2JGbWM2dVV0K0QvQ05xZEc2?=
 =?utf-8?B?akxxM1dFMXpwaVU0cEM4RzAyQlVpSjIyVDg4cE1jdE05SGZVSGVGT08rci90?=
 =?utf-8?B?cDJ1aUR5U2tacmV1bWExOEpaRDZHMnhDYXJCbEIyaXdPK05JbkV6ZEJiRkJL?=
 =?utf-8?B?MG1vekpLNjcxa3FZN3RSTlFZaHNubzQrWnlTSlEzVG5SQU5UalBrb2srVFhO?=
 =?utf-8?B?eTAyM0tWM3M3ZFpCejJnK1A0NmI1KzBzOG9HQUR3R2ZXa1AyK1VtdE9tNWlh?=
 =?utf-8?B?UzJ4R1JKTzdvZmRRM1ZkOEp2eEFwYUNQdHNBQUY3Y1FKMUQwNE4rUko1L3A5?=
 =?utf-8?Q?oh8frzdl71g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkZjSWxpbVlmRzZsZHgvdGFmK2pPTGRpeUFTQWR5VVd4TXRhT2ZEUHkzNXd5?=
 =?utf-8?B?elVETW42QmRBblY3R1FDc21aakJzbnhJNjA0MnU5Z1k1NGlQdWRWekViVmNa?=
 =?utf-8?B?cG83eUtsL1A3ZXVKMmRYV21USlkrSFBXRWk1d3BsZmhkaG0xWXRJWkx2VE0y?=
 =?utf-8?B?VzNZOVk3SWFFMmg2Qk5iOEd2MFc3OFNINFNiTzBKZGtzYTBUcEg5Um5wSHRn?=
 =?utf-8?B?dmk2dlBCaWc3VmdOdFk5UWlja1JFS2dOeWs2TUF1NTBEOS9nMlJLUFlzMGVm?=
 =?utf-8?B?L3BIbXZJSW00aDlVYmQzNkJrTTkrWjBjUU1zS0piM01KTUxIWWlWNC9RNkF2?=
 =?utf-8?B?d1RYNitKSEFSM3diRUNLOFkwRzFGZG9HUmJuaVlTQm9nTjl2QzBJRklYcjlN?=
 =?utf-8?B?T29sTTR2OWNkM1dJWGVkaUZ4dFV3MCtCeGhwTTkwdnhUYk5kSThIcTZhTzdH?=
 =?utf-8?B?WlRQQnhsbHdEN2xuUU52aGN6MmhGZllpUzEwUFp3Qnh3TTc0aWZUNitSdlVv?=
 =?utf-8?B?OWFKRDBDai9zdGszOGs0UHB5dVRaL0FOUWVoRW5iN2xINjFQTjlYdDZ5UjY4?=
 =?utf-8?B?cFZqaDNWSGQ4TkFLQUJJcVBGU0Y0QWhyWVU0dEZuK3dySzhNRkVNTTBiR2kz?=
 =?utf-8?B?NUhtdEVQcVF4VlNQdXo1Z2oxSyt2THlxM1BpUTh1b3FSK0toa01XaElEeHlS?=
 =?utf-8?B?RHhRekhveTR0ZG9CVWVDQ3pwZUNpU2VxWDF0bnozNDNwQ1ZRbW44dFg3RDhn?=
 =?utf-8?B?bWxQTjhrOGRCVFRQRWM3aDh6TmxlR09vYUlWYWZGY2xmci9YWEpvM1NXangr?=
 =?utf-8?B?dVpoS2JRV3ZwbFdaUnl6RDBpL2xNUnJrUjFLdTNDd084cVhHSTRheDh5UmhM?=
 =?utf-8?B?ckdBSVJGMWtjWlg2dmN4cEJVVEUwZ2x0TjV3NlM1QjdNYTdRc3Y4UXFZbUM4?=
 =?utf-8?B?TzYwdGFHTk1vcWJlVTBhTm9nZjhmNHpoc0ZpaHlQbkIyaERmbHQ0dU50TDRB?=
 =?utf-8?B?L3ZkN3VnUTMvNUUwRW1wbXY2eWJobTc1UjZtTm1tRjBxMDlVTldWUy9uRzBk?=
 =?utf-8?B?bDh5UWxFUjN6TVBreitLMWhJTlpxQ3NIQndFWUdoVnhDakhhRFhJNGlVZHFq?=
 =?utf-8?B?S25wUDBQVDd2WmVEd2ZBZW4vZHJsVk43SkpGeGttc2dlQVZSRlNnSUoxVktN?=
 =?utf-8?B?aVF3T2hleGNCdlYvdDFDaWpxTWR5T1JtazJzSFBDUHp2ZWxrZm9BSHVsZXhG?=
 =?utf-8?B?Z1R1Y3BuMnVTUVFYN3pMR28xNWhwb3ZqMEJsRlZuVFlJRnFWRmZ2TDRrQUt4?=
 =?utf-8?B?cy80Y1l6eTlSd0pYTUtjWTRTU1Q2SG1VREdIdXppY2ZESmNZckpadXdiT1N0?=
 =?utf-8?B?R2FNd1RKWGFzckZJUFR3K0xHZ0xhZm5mRi9VZEc3UlNhMWFuNWxKYkkxcXps?=
 =?utf-8?B?UjVaWjhON2tJbDYrYXNOK1ozaUIrUmtqVzBlMS9rQ2IrcVpoMjVXeGtZTWJp?=
 =?utf-8?B?aGxrL0RzbWJwcU05TXpreWxwQTlZTHVheDF4R1FJMlp6dUZMZ0tnUk9hODVi?=
 =?utf-8?B?NGRVVTZYcmxQa2MwY1NOT21WS3RzbWllWW5CUVhwR1BlUm43NjhGdmxVOVFG?=
 =?utf-8?B?TkJpQ3J2Ynp0ZnI2RCtNaDNldTUwbytCZFBmUGlaYWxWMXVldzNwTkJScmxz?=
 =?utf-8?B?RFBFaEs4Y0dUUTQ2NnRsdFVueVhNSGk3VjBFSlZKbmlCK0svTkZCVmxhNW80?=
 =?utf-8?B?Tk4rTzNnQlpFTUVvQzNVVGs1U1JHVG9hNDM1SzVDMHZEVEkyUE1xMHVlYUVT?=
 =?utf-8?B?ZGpFS2FleHFCMjFGaG9qaGhpd2FWTnNkYzdhbE9NNFI0dHp3VW5KOVJVenRB?=
 =?utf-8?B?V2p6bWZrSnp3Q09yY0NMa1hiWk9RMC8zSTQ1bTcwRERJbDFMQ0hJUUk5dnlK?=
 =?utf-8?B?SnVlT1RlZ1J2alpxV053K2FZSGhSNm1TWWx3TmpCYXZ3Y2VaUTgraUM4elI3?=
 =?utf-8?B?aDNhdXp0d1J1dUg0b1BXdDhWME5hUmozTmJTL1NYSDQzU3hZa1ozSHhrNSt4?=
 =?utf-8?B?VDh2MHVpWFJ4VzBiL2ZXS3ZNWkl3a05MV1FKbTJyNkRZaFVlS2t6MmhFSWhm?=
 =?utf-8?Q?qyKGO4CEuZom+xu7LZzgZ3qKh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ed2e0aba-7aa5-4395-c88b-08dda467b6a2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 19:32:31.0356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5nQOvyaEq6db1nxOyHjRTSU5+Uq+PdL6EZCTSwVhq8ErQw0gCWoiyPSe8l/7dqW03osbRHpwv6+R+EdbTrrbmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7308
X-OriginatorOrg: intel.com

On 6/5/2025 11:10 AM, Xin Li (Intel) wrote:

> 
> Xin Li (Intel) (2):
>   x86/fred/signal: Prevent single-step upon ERETU completion
>   selftests/x86: Add a test to detect infinite sigtrap handler loop
> 

I tested the patches on a machine that supports FRED. The results are as
expected:

FRED on  — no Fix   => FAIL
FRED off — no Fix   => PASS
FRED on  — with Fix => PASS
FRED off — with Fix => PASS

Tested-by: Sohil Mehta <sohil.mehta@intel.com>

Though, I haven't tested the 32-bit version of the selftest.

>  arch/x86/include/asm/sighandling.h         | 22 +++++
>  arch/x86/kernel/signal_32.c                |  4 +
>  arch/x86/kernel/signal_64.c                |  4 +
>  tools/testing/selftests/x86/Makefile       |  2 +-
>  tools/testing/selftests/x86/sigtrap_loop.c | 97 ++++++++++++++++++++++
>  5 files changed, 128 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/x86/sigtrap_loop.c
> 

