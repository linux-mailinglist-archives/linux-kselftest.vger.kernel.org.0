Return-Path: <linux-kselftest+bounces-44535-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0760EC25F15
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 16:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 804CC3494E1
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 15:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA3F2EDD60;
	Fri, 31 Oct 2025 15:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EqSqlbfn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3862E8894;
	Fri, 31 Oct 2025 15:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761926324; cv=fail; b=JmNHQhis8YFNrSCkoEr3vtZXHyMjhAWvhLKqYNXe5Wb6xPj6Q3OKkkeG0s4JOToYyZR06umbuJqbd8jT6s/bo96/80Qikk2+k5nw5iTJvyAlnLe2RpymgMfzzr+RB8Suc4SrUayaJRYDC+Q8fS50uNs3sCX6Zxlh9Xcycc2b0c0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761926324; c=relaxed/simple;
	bh=bStzgsbJK74yx9LNlZP2TKpyQbrhwryPklQ3QSaY5tk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T6T2K7Go3VsBg8g9V8MHAfd+PwA90ImZ6L2Y+V56RPqFOO7bBOTTnfo5i6j0YGQwkxjxpuk76tAHb+fWkjr2Sc9Y1VXee2y+vdBupOSn9KiFItMPRENPexW5aJcTrvff7TSVzBlAXv/znRAPmL/2jlLMU2KydyJ/Bn2/LiOAyfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EqSqlbfn; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761926323; x=1793462323;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bStzgsbJK74yx9LNlZP2TKpyQbrhwryPklQ3QSaY5tk=;
  b=EqSqlbfnhxdNgsexTqssT9waeu6cfJe4uzu04dGowGcWmxmyvIUfBwdN
   oN1xO88wxD9L8tK+HqVuwyS6Tvl6gL+JO89IdFuqA1Cfm6IzdI72/CgAW
   AdcywCcODpMdjc5Yd/0ePn2Fv3u+1+BkP6Hq8iT4UhmR8kjNMKc8a70vI
   MhPiLi6pwpdYMD8HkLYEBi6dc61qPbGgucfkgVx9InnMHK4G2MrdU//Gw
   ZfLRsIeTFSF9RyajAZd+KPQQ+nQaiykUeJUSAoyxoaT0SuHxmoX0QDIMf
   9Yhg8BxS2ta3eHU9jdb6KmlkWHsaqZfMD65jQf1NqAOnSDQVK759/5Zwm
   g==;
X-CSE-ConnectionGUID: 7NSiPT13Ssu6Gc5N2gmLLw==
X-CSE-MsgGUID: X8gru03CTCqwX+ZxXBeKiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="67927733"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="67927733"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 08:58:43 -0700
X-CSE-ConnectionGUID: pdQhlgJzSyiASNReNRCZIA==
X-CSE-MsgGUID: Wal1GoWvTPm6tIRL6qjODw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="186203908"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 08:58:42 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 08:58:41 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 31 Oct 2025 08:58:41 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.7) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 08:58:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JJtaS1MISpzyM8vUhEkHGyj4SAZFsXlZYOsWlvp9xh1fDbQRMmfYWZoZ0qkGQAjJaumSV1iugAJUVhnrj3PnWJEErMwL4X6fqScF6f7pYtJu663NeLrnCqxEN+/0236GENYxb3npx6fDfuF58ckiDg0ZGKHJ3uK/LYujblQyghQcxDWoWZo5e+7tyLd18Y17GRPaajZOpWvAYnV4RcepAqvnQhicHz5P59nGul7v5b6nfW4+6MUJeW3vY+hqwxYldP9XwNAO6x2zU+nsvOMBG9gFsW54Eev9vKW7KDubsXCnGdlRo8fehrBpdzAcCzK1NV2yPoqvFKi7XGB5SQjmqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgZb3FtjnrEW9JWaZXUhpAHiyR2TfvRc+Ac7jfSxklc=;
 b=FAi8EGEOns/ntXH8mgyFjivy387URInNGFDl7vIBMA13cOyfDg//qxob7QNas/pQffhdnm2FydaBrEIc8Qw73L83BD8XTxLQAlonqE3SeueTsC0Y9LqqzwGM0Js7pFa2JfDHr6Wz/GZ4zSsPwVW7xEJJ/0PO6q7YuLvkMtc7JriBt9D1B0PppgA8nYreCsnGJ/O9gpGxHpPrW0TeR6pwMSftcHEZrXtXu7fmC3g0bbYCncdMv2JzPLL9DDzZtCERpbXUkSa033i4j4YyPxUThJj91jvGemQtdJjGDGZFlcBeWJiJFtjpZDPXlyRgKYYAoTzYRPwfji56DX+eINmxHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB5141.namprd11.prod.outlook.com (2603:10b6:510:3c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 15:58:38 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9228.015; Fri, 31 Oct 2025
 15:58:38 +0000
Message-ID: <956e884c-4827-4833-b701-8aa74a5a7f11@intel.com>
Date: Fri, 31 Oct 2025 08:58:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 14/23] KVM: selftests: Add helpers to init TDX memory
 and finalize VM
To: Sagi Shahar <sagis@google.com>, <linux-kselftest@vger.kernel.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, "Sean
 Christopherson" <seanjc@google.com>, Ackerley Tng <ackerleytng@google.com>,
	Ryan Afranji <afranji@google.com>, Andrew Jones <ajones@ventanamicro.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>, Erdem Aktas
	<erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Roger
 Wang" <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, "Oliver
 Upton" <oliver.upton@linux.dev>, "Pratik R. Sampat"
	<pratikrajesh.sampat@amd.com>, Ira Weiny <ira.weiny@intel.com>, Chao Gao
	<chao.gao@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>
CC: <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
References: <20251028212052.200523-1-sagis@google.com>
 <20251028212052.200523-15-sagis@google.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20251028212052.200523-15-sagis@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0003.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB5141:EE_
X-MS-Office365-Filtering-Correlation-Id: 8240e52f-1c94-4dbc-f089-08de18965b0d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S3hVanVOZWJNbk4zanhDYmI4TUwxcGVoZ1ZiNy90TFBRS2xvMW1JcGRCazR0?=
 =?utf-8?B?TnIvOHdjMVBES2NXdDFXZGs4ZXVJd0ZOKzBxL3dncjV0a0puQU9XR0Qwa3dY?=
 =?utf-8?B?V0dac0FSQkxVc3JHU1kvKzh1RlU5Z0Foam9qcUF6a1czRGFBeG5SYW5aM2d3?=
 =?utf-8?B?UGxpZnR4VG1aeHVJUTAzWllXenRpZ0NoYjNOeWV6cENPZ2Rpb0JISEdFQnV6?=
 =?utf-8?B?UEQwVW5nMi9LZ0sxRVh3NzI2Q2hRV1hhOVlqVGpKU3VOd3p5bkl5YldaOXBa?=
 =?utf-8?B?aVY3ZFZQRElHbXRsVVNWL0ZYMzNxaVc2SHkvSzRPNUtNajU1K0pyNkNzS2dJ?=
 =?utf-8?B?eDR3V1ZMRlBCMkRWT003L2JIemJUZzFsRE9kbjdKb3kvc1BLZGpVUmhJa08v?=
 =?utf-8?B?TFA0ZzBrSmNPWnRwTHZjQmliUlVZcGdpVy9NUitKOFM2ODRCQkR6TWRXZEM5?=
 =?utf-8?B?MmIrVHY2S0JKM3lzaGowWGZmbGl4bWZ4b0hmOWRtdWlSWkVZSkRTajd2VmQ0?=
 =?utf-8?B?cC9iVGRZVUVXcjRxMC9vVlcwRzllaUlSNGpCUytGN0Y4bXlBWlNpQlhubnE3?=
 =?utf-8?B?c21xQVlCWFY4NUk5WkhKTHMrT2pEQXVlWkRJQU8wcVJSNTF2c2ZJYlVxUW8x?=
 =?utf-8?B?QkZZZFNpa0RFL1pXRkhnclJGVTBmc2V3T2tSNXVqU3lraytjY2tNOTZKVUlE?=
 =?utf-8?B?bXFRMnZuelNWWXBGTUhKcmpkRjB6QnhxVkFyUEUyYStOU1lFZkRpL3pVdWp4?=
 =?utf-8?B?UFZFcFhyU1FHN3FIVTJQalNWTWFaUjlEVUFTS3J1cGdkbUN3SDdRMXVHemdt?=
 =?utf-8?B?YW1hUWJ5MlYvZTNCcFloeDBsZVJTR1NDZWRidkQyYko0WmVGZW1CYXIxd1Nr?=
 =?utf-8?B?Sk95d01IN0taSzJTSkFFekoyV1BoK3l5R0JoNzN2SjkwcnBTdzhIaVNqT2pE?=
 =?utf-8?B?Vk1OYVY4RTZGcnlEbXVrcnQzSGVvZWZhQytZbS9kbkx1ZTZDbjUzSWpUbGxx?=
 =?utf-8?B?b1dMeVBGQnQzbnFMRmFiZDdPenNWVnV4NE5sc2VkN1hSRUY2R1k4b2taSGo2?=
 =?utf-8?B?S1h2Q1AzanBVODFaNkRocTNtQmJta2tNaDVOZGlENHZ1cFpDSWp2aS9CQmVG?=
 =?utf-8?B?U1BsbzVXM2V5aGJaNDJVbEVVd2M4SE90dGo5OTNGNTc0UFhubm83QmhNa2g2?=
 =?utf-8?B?ZDh1M2R5aXdkZ212MUhRV0RBR1BLL21rZXJpQ2dTUHBmQTJTWUFheWVlY2NT?=
 =?utf-8?B?c1dQekVJV2luUTFPTXJpNUlLdUpxeGZNZmRJNmNyQ1Z1bFJSaDFXTEtjNEVs?=
 =?utf-8?B?aDRPdkpLaUljTUYxb1VnLzNldC94ckxRRDBrYjlUUU0zdTFLd28ycGJaSVFn?=
 =?utf-8?B?ekpNaTVVRDJJcDlwTFBycnhHVjJ1YXdWZ1J4MkdkbjJiUWNYU3UrUmRXa0M1?=
 =?utf-8?B?aEVydDFPbE10dHVpSFRuQzVKcmZQdUphdHRJWHg5MXVKTkQ2WjE4L0g2V2tk?=
 =?utf-8?B?YnBiWlJXVmE3OFIvaXhVVytDSHQ1UFhqU2JBVGRjbGUvNXoycGorYTBrUURB?=
 =?utf-8?B?aVc5TGZOMGVaalJNdWY0VHk2VTR0Q1Nvd1M5aWFncWhHdDJsWnpETEprZys2?=
 =?utf-8?B?NTZTSEIvSHBBMmdzWWYwRmt0R2p6V2g0QzkzaHU3c0xjdGFJSXVzSFFFS0tP?=
 =?utf-8?B?ejMySUN2YUZtak5OZzRTYXlNU3hOZEdIOVBSWUJZY2FJY3ZQcEl4bGEwMWZU?=
 =?utf-8?B?N2JkdHpZNjFheFN1S2hUMDluamdmamUzSmc4MktpUXFvanFaa2F1eFBmanBB?=
 =?utf-8?B?QUMveUUzbXowOWRGQVZSSVlOZll6bEFFNVlxZXNvblZPR0hzWnhYaExvMEl1?=
 =?utf-8?B?QmNEL2JnM01MVGlwV0NVbDFVODdpYmlIdkN6WlQwM0pCN3hxaDJ0QlEvNFEx?=
 =?utf-8?B?bnNtSC9QbWFuME5KOVNHT000emJZQ255aVo5YXc3YVY2QitoRU5DSldzYXZB?=
 =?utf-8?Q?6E6A9NQZIKS3MzFr2FOg+3ZnsIWXo0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWdVdHNieWpWWGxraG9TSEVYNjBoWEV0eVlYSGw1T1lvQVNRbm1XOWM0Nzkv?=
 =?utf-8?B?bEg0NFlnYVlvcDBYNkorTnRmdERQQml6ekdFOE9nbmJwSEhNMjFEb3dxZFhu?=
 =?utf-8?B?YnUxZ3Q0aHdxVklLRFNRbVk1d0NQMTF5YkxRZHBXREhZM0hXT2NjSkdacklZ?=
 =?utf-8?B?Z0ZCdXMxOEJlUWZDVXQ4OW5HR2dGMktHL3E4MlRwVS9TQjlqazY1N0ZYYllv?=
 =?utf-8?B?WmJXN3o4TzRpSGV0bEtuY1MwdXVzOFVQS0VhRkJReDVmZFA0cE1mMTNNbVo4?=
 =?utf-8?B?TGM3bEVHMnNVQlhMQ1EvRkV2OUFrbmNCODhWVzdZMkkreXJVMjYvRGhuWEJh?=
 =?utf-8?B?YXNXY0xCbzE1TU9IbkZsVElEaWQwb0haRWR5SUJ6WXI2dUJnTVkzSWVQdE5J?=
 =?utf-8?B?c2dCeU8waE1SbWRKT1cyaTgwVituU2J4M0gzdTlELzdhazh3Wkw5T3pzKzhv?=
 =?utf-8?B?UDg3OE1iT2ZHUHpTRkpoQW03aGFmT0RMSlFoZ1FLNGFBV0d2aGd4MXI1NmNV?=
 =?utf-8?B?MW1GVmRyWEFSMGllSmVuWXQzZXVuSkM2eThBSXdIbTBBQUNKemFDMlVhbFhP?=
 =?utf-8?B?R0ppMzhWWEsrdmpBUUd3UmpVSGNUa3Z4bDFHQk9UUVRpZDF5akRERHl0ZnU5?=
 =?utf-8?B?TGFGb2VKSTh6S1lKamJRaUN0amJZVjNmNlRiZ3FFRjQ3WmZDb3BtNk9Nbk53?=
 =?utf-8?B?cmZOc2w1bWdrSHhzT21FTjNGSE5JSUlTQUZBTWVrWmFCVUVmNEZsK1g4a3dS?=
 =?utf-8?B?eUY4NTgrZkcyVnJWenR1VGpKZXY4M2w4QndHTDZHTEtiTlBEd1NlRFRsYXpo?=
 =?utf-8?B?NE5SN2kydnZLd1JEcWd6eVMrT1VwSm8veDE0SlZoN0VrWFZzdWtQYjFoZm9K?=
 =?utf-8?B?OHJqaWF0MmRiNmJ2RHBoUXU5NXhtOXZSckFsbWZ0dzdNZWZhODZOcFpHWjc2?=
 =?utf-8?B?N3VyUWhQbTZ0RjMvZGFjQzgrRitrVGppeUFTQVM5TVdKeEh5Y1BGblBmOVF4?=
 =?utf-8?B?dVZWVERodnFidXVacjgrSGU0bksvOFlxRTJ6NzFSZmM1RkZpa1I1dWg3Uk1T?=
 =?utf-8?B?NEY0NzY5cm4wZzY5NzRQRENHVjRGNitCSkNIQ1FoWFRVS1M2NCtScklwTVhu?=
 =?utf-8?B?OVNablJyaTcwYmNSUll3eTJFUHRZVTRnR05jaFhMenZGR2k3UUdaSFdHc2VW?=
 =?utf-8?B?ZWhlTmFzRy9Pc2NkUXBsWFlnTGFWK0M2OW16RlJXN3orTkdtM1RtU08vOWRQ?=
 =?utf-8?B?ZGtKUzMxbXgxNzBiRm1qMENCZDArdVNtdGVRNVp5Z2N3eklzWUdzUnVQTTRT?=
 =?utf-8?B?aVcvblVnY3crci9ZelJ3aVJjU1lQQSs5aU9jMG0relhYQ1dTdXlBMmNKQ0c3?=
 =?utf-8?B?dFlISGNnMGl6SDVrWjVuZ2NtSUlZRU1pNXdWU0VOUU1DOVl1bGJNOTZCKzYr?=
 =?utf-8?B?RUUyTGJkNThXcWFGblQvK3VUa0U4VER3bndzYXgzNzNDd0xVdUhqeFlGTFhi?=
 =?utf-8?B?dTJKdDdyL3lhQWkzOENrSERxNEhab1E1dldCK3dKYldGWllZSlNtVEFZdzNa?=
 =?utf-8?B?RW5wa3REZU1QN3FSUmgxUVFWdTBxa0thOTBTZStuR1FVcXhIcmNUeXMvRytr?=
 =?utf-8?B?MUN5Y0ZpL2FVRnFJSnRzUXI4amlkNi85aG5SYksvVFU4UnZCNGhYcEg0UitH?=
 =?utf-8?B?U0c1bHZoNDhjekJTeEttZTdwWjIxOWViNWQzQXN6OVo3azNmdUFxR3pTcWhL?=
 =?utf-8?B?ck5ZeHZ2WlMvRHZPRFlzeU1LbWdWQmFMWUhWQ1BhQzRYYXlsaDkzQXFtdXlt?=
 =?utf-8?B?cXlOcDI0bDdYV29pelZWNVdEY2xtWU9zUmRreW5RRFdpYkw0RmQrUGNOckpH?=
 =?utf-8?B?d0hQYlpZQ3NrRWw5ck5neDdGRGZzZEFrUkVGc3YrRWZhWHlaYnFzemIvaVVk?=
 =?utf-8?B?RjYxaGo1cG43a0lGdDQ2Z3VOaGtPYnVRaDFYaGgwNkFoUTNqSEZCTWJvenVo?=
 =?utf-8?B?WFRVZUZRRzIwR2RVYTZxQkc4RFVpRlBVQUJMQ3F3QSswb0hNa1g2VkFySkVG?=
 =?utf-8?B?WGxsSk15VTgzcGZhMmtrdStaMXZXOHZQVWkzNGdBRm05c0JZazY0UklkMHRE?=
 =?utf-8?B?eHVpMUdXUmlkYlp4Q0hYU3FLYzcycXV6dS9PRTNMeVByUUpvOUw1VUNLWS9t?=
 =?utf-8?B?U1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8240e52f-1c94-4dbc-f089-08de18965b0d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 15:58:38.6343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n5mqnSXh++hDYnY/5K+NMDlZC7Ykm9HN09Am1+X3J/2kAtV5WI5wyKGirk+McajZ1Ei42KItJII8O5KrSDIry57BXd73pzYaLDigEWTt5F4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5141
X-OriginatorOrg: intel.com

Hi Sagi,

On 10/28/25 2:20 PM, Sagi Shahar wrote:
> diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> index 2551b3eac8f8..53cfadeff8de 100644
> --- a/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> +++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdx_util.c
> @@ -270,3 +270,61 @@ void vm_tdx_init_vm(struct kvm_vm *vm, uint64_t attributes)
>  
>  	free(init_vm);
>  }
> +
> +static void tdx_init_mem_region(struct kvm_vm *vm, void *source_pages,
> +				uint64_t gpa, uint64_t size)
> +{
> +	uint32_t metadata = KVM_TDX_MEASURE_MEMORY_REGION;
> +	struct kvm_tdx_init_mem_region mem_region = {
> +		.source_addr = (uint64_t)source_pages,
> +		.gpa = gpa,
> +		.nr_pages = size / PAGE_SIZE,
> +	};
> +	struct kvm_vcpu *vcpu;
> +
> +	vcpu = list_first_entry_or_null(&vm->vcpus, struct kvm_vcpu, list);
> +
> +	TEST_ASSERT((mem_region.nr_pages > 0) &&
> +		    ((mem_region.nr_pages * PAGE_SIZE) == size),
> +		    "Cannot add partial pages to the guest memory.\n");
> +	TEST_ASSERT(((uint64_t)source_pages & (PAGE_SIZE - 1)) == 0,
> +		    "Source memory buffer is not page aligned\n");

IS_ALIGNED() helper may be used here?

Reinette

