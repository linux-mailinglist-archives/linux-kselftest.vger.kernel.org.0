Return-Path: <linux-kselftest+bounces-10842-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 370948D3D92
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 19:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B67D51F22A5A
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 17:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95A615CD46;
	Wed, 29 May 2024 17:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H263nyzN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F91033C0;
	Wed, 29 May 2024 17:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717004654; cv=fail; b=TkpWC5zIPr3TF9QiPsJl/Wd4aL5VO2apmrDNCMuYebkYtpviCGgT1vcuhJdaoX7Ckbx0E9FEegTubWpulVLaszGKsPoDskGq3JxVJp0/32v4/iyrcyZTAuod3+zBdp1pgiJtffjoGnTpXAQ/63bgm2zWpMmpEB+OYl8r5efWhyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717004654; c=relaxed/simple;
	bh=u28I7Y5R+lle5Oj8bnQ+xDd+8w9buFql1nzoS3/YrjE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F/DFXW6UsCRgXXm8DgrtwvtMZMVXVvqvhEBQSZDiZmGmZYbloBnYqBornqpHjadTQu9NMYDSxwrYS5TNJUXxsXyqFj22Tud0C7CbGoRhW5MWT2sQ+NIIUIao8AH60EMgIq4P+0oEYd2ZEObMrxvh0ApBEQmdRChYh0auaRCmcpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H263nyzN; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717004653; x=1748540653;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=u28I7Y5R+lle5Oj8bnQ+xDd+8w9buFql1nzoS3/YrjE=;
  b=H263nyzNhfbbvSwA6UwyhCoQM4ACnxrdcDBrtnEOFaeyIy0D2VNKpwVj
   6hj24CennOp3+oBP0jSqHUXHn18ZhhjCFmHIj/w3SGRYP7IyxSO3CB1vB
   4DxkBQoOjljVJjrzEe5O1Fu1DwRJ86ZLG05ivQlZAsDEsX7G4kMf73MGv
   yn5puE6zGAJbunQJEqc3NI/TK+7baw43VpthOX/mgNR0T3Zsp00x0de90
   GXBuqakiP4/PHg/L6j2Yy9tgcrsjwPQyoZ+PKNZzxVuIK+P6esFhJpqWe
   Nj40Tuqt9zdM/epwJdYf5kKklpzUtcuXGut7+56ehfzYOFZi8OK4LKbhO
   Q==;
X-CSE-ConnectionGUID: oHpeXbbMRISG4Ecva5ZY1g==
X-CSE-MsgGUID: g/F3njlhRS6cwyh1XSDXxQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="16377355"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="16377355"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 10:44:12 -0700
X-CSE-ConnectionGUID: KzpzWYovQmCzl/BbS7vxCw==
X-CSE-MsgGUID: St/JAqxfRwSY1Rgpujb6Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="66391943"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 May 2024 10:44:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 10:44:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 10:44:11 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 29 May 2024 10:44:11 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 10:44:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WRiMQnB0ZE/FU/CxUgP4dbO+Ms1+lKub4VGO+Y1yKqCuBmtWYZW/tVYmabqCeEZb8Sq5+d0t+zuG/pCzK9f46gJmOui4b/AmGAB2X8qLoG/z49fL2CrK/l2DOYkPU0RIQ3GLLZXUWx2Ex3pUEaAcrV0aXPkkNe0jAzkZzue8g1+RGkUdT3Qb1znrj0oSIUjop/ft21UzbLrgkSE0oFdapSzCjt0wXvBhE1dil931mVENQfA8XXvWnpCzgSL+QZtI1GqKDigRTvATJUUPl83zu3QvPUXF+64yM3cnNuOVcUMp55i7KLF6RpdS7ohjzlA3cl/Np4qzabrD8Fi7mVjECQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/EJ3UYPolauVAJtd0U4OE0ZMPeDo/zaeUTk4khIkmbs=;
 b=dvoFPZMvMLLuGbWmtVCjqMi3fUHEg0X16HANY9IaJcUuJkAM8QhAMfk5kwSDwU7FmFpv6K27BQc0GvE9JFiX1SMvk9/A+r85tQb/TbDWR5ccND3lVXF/+ZCm3JjQqQ0pVCCFq1WIGEDGax2Td92jm/mMy1VfE3pCjYSzBgAadULv088q6JRB39aMgYK5OCzeHNzeYvMTjAvA8nSAcCzJ1ElXdNUnyKOLx76hGOrOvcNz4MBaYYqYuETRL/RzqDz+Hp3Y/5vd3GYs4TWCYZoM0uFyl7NEcFcA5lhl0pLRQ5/wwWlmYZLS1ZeZ7BPDuFz5zto4zLirx8g4wgjQmuXKtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA0PR11MB7378.namprd11.prod.outlook.com (2603:10b6:208:432::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 29 May
 2024 17:44:03 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7633.017; Wed, 29 May 2024
 17:44:03 +0000
Message-ID: <80b08de1-fa61-4c20-aad9-1844d2303df7@intel.com>
Date: Wed, 29 May 2024 10:44:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/16] selftests/resctrl: Use correct type for pids
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Babu Moger
	<babu.moger@amd.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>
CC: <linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>
References: <20240520123020.18938-1-ilpo.jarvinen@linux.intel.com>
 <20240520123020.18938-6-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240520123020.18938-6-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0341.namprd03.prod.outlook.com
 (2603:10b6:303:dc::16) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA0PR11MB7378:EE_
X-MS-Office365-Filtering-Correlation-Id: e8659c14-d252-45b4-8408-08dc8006edef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L2pvNGJjNUo3THREdXorNloxN0JTTWxGd0t0d3dacXpkRGRFQ3loeUo0ZFZ2?=
 =?utf-8?B?bEtpNXRmVEZQaHlOZU4zM2xyZDFQVHNvc2dJU1hsMThNdzQ0eWM1ZHZLNVJE?=
 =?utf-8?B?QWZ6MmN0eFBkelBIRDU2a3VzcW9tRGNZQUdhTGpEVkh4LzAvOGpvKzl1Nmg4?=
 =?utf-8?B?Ykg5d0hBT3RZTnExOW1vNEhvTFp5YytNYnZxcTJsYTlsbXZUb2Y4aTVydkk2?=
 =?utf-8?B?UTVzZklXam1BV3p4RGl3cjkxelpkbEtRRHV4UlNDYzlrZXBGVnJ4THEyYU1P?=
 =?utf-8?B?akNXSWlBVi9rNWhOTGxqRHdpTjEvUUtRV0YxN1hBQlpnUU13U2c0VWkwTzRN?=
 =?utf-8?B?NzdkOE1MalMzVmVUUTdmd2xWSW9VK2ZSc1h1bVdxcXIwbEpsYjJldmduTWZP?=
 =?utf-8?B?QURDc1JKSitzbG1aa3BTRGV0Z1V5cjhHczhYVHVHMHh0RDB5Qy90TytXeUVL?=
 =?utf-8?B?VXhrQ2p5dlp6NktidndJZXRYNVdCdGZHTG9VdGtLVFBmaTAwdVNaWUJRaStW?=
 =?utf-8?B?dGEzQ0x0Y1Z0L0FMOGR3T3lab0EvbjJ6aDZVZUhFMnJkMjBBMmNkbkgxdnl5?=
 =?utf-8?B?UXo2ZVdHc1BCNmxqcFg2M1l2MGtySVYrSzdVdTlzRlUvR2xjV29NR3p6U2lt?=
 =?utf-8?B?R1lXa3pSdithTnltNnZMOVZaUXhqV2dWbndKUC9CejNIUWR5bURPNEVlUDY4?=
 =?utf-8?B?N3hnTTIzaGhtMktpemtZOUtDMWcxRnZDbUQvSEplTTY2dW5iNmVGMmJ6RlZ1?=
 =?utf-8?B?UDJuNkNpb0NYUkFrVTd2ZG5MTFBSbmpnYm4vcThCdEo3MWJiVmFUQnhoT0pP?=
 =?utf-8?B?VlhhTFA0SngzNTNudUJNRzd5ZEJjNjlyNFNXVkI0WUEyVTNSUExKQjRsbm1D?=
 =?utf-8?B?d2lBd25tR2U2a3RubzRjdjY1QlRLTTVmWDFzMWdxVURlZzFvT2E3dnFSODh4?=
 =?utf-8?B?cG02TFNrMjRCVy9sdFdpMGIwaTFsbVNHck9EOEdIZTg1SjZiTFRLbmZIa2Qz?=
 =?utf-8?B?Y2pPM0tXdWhIOUFnVDlhbHFuM0w3bW0xZkVoZGhocU9qaEJYSG5xL1lhdVlL?=
 =?utf-8?B?V0g1TGtkZjBkeWdDaFJseThYSXdWQUVqS0JYS09vSnpCelRzOFgxQWZTRkcx?=
 =?utf-8?B?SzVtVk1aVXFRb2JtWTVyam55Wm5Jc3BLMkFoZnpLQTNON1lFTTV4LytJaURh?=
 =?utf-8?B?M1pEeDBsbEdBVmNyeWtGOGpqbnVSU3I5RXJkZ3BzangxREU5VlkzRXNhcXRY?=
 =?utf-8?B?aUsvek4vNDlGK1IrcmtWOTNJUFM2RlZUYmxPK1d5UFpFT1N5ckgvR1BvZFg5?=
 =?utf-8?B?MUs0VjQ1S0JFSmNqNzlOT0dJZjJXSHF0SHNZU0tsZ0tjR0FXSGJvcW4yUzZX?=
 =?utf-8?B?eGhUT0FBdHhQNnJrQ3dtcSt5cXQwYSswOEloc1RjZHFiUGpwRlVuTEZjQ0JP?=
 =?utf-8?B?dWkzSnhnbkQ1d0FabWtadk56YzdJcTNHNGpUNVIxRHZFNzRvQzY0OU5IM253?=
 =?utf-8?B?VmhVKzdSUHo0ZFdaMFV6N1lPR3dPc1hnN0lXR3RyNUJYeEw2SnplTUphbFp6?=
 =?utf-8?B?bElVUzlERU1EQVh3am16UnJ4RWRZZ0RwbW52MXY2enY3MktiRGRya0dTaXZZ?=
 =?utf-8?B?S0g4ZjBNVmV2UnJMN0FydSt6Ym9ZK1FUcEowT3FXdGU4UUEyS0VpUmVhNmJ1?=
 =?utf-8?B?amVNald5aEU0bGJGUUVVR1EycHBLdmNtcWRoTFJSTGNqdnI3d0VxSlVnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emEvUkFHcSs0c2VRb3VINXFUbXZtcDlYamhGMEsrR2xLMElRMXJoNGIyMzBo?=
 =?utf-8?B?QXIwU2p3ZmhKTzRNbHJDTE9vYmtVSTdTdWhsSUREMGd4a3lYYisycnVyV2M3?=
 =?utf-8?B?SjZzeEx5VEFLQjhpVmlpaWUvd3hsRmt5K1UwdnlPdVJWam1HQ1QvdlpRdmpq?=
 =?utf-8?B?K1YraUxrek5IQzNHaG40eEdickF2ZHBib3hubFdjVDVoZFN1encrQ0xONWY1?=
 =?utf-8?B?aDhhbGdXeGljWVFpSEtIeFNuZWdsOHRnYkQyOTVFQ1FVa2F1VlkzeWVMQ0hk?=
 =?utf-8?B?RDY0ei9mdExVYzdYMnpLRTR5UFNmOGRoRTRZanF6ZWlMSzJzaEc4OGVhRUR3?=
 =?utf-8?B?cmZYaGV4alNyZ2t2NUtqTmZoTW9RbUFDVEcxNGJQaStpTWJXRGhkRzlTWWs5?=
 =?utf-8?B?WGJ4UlNFYXhScVRZUmk2M1QwLzRjMUxzMWovcXVaQkl0cU05Z3N3NXVBMUdY?=
 =?utf-8?B?bUVqTDh5TEEzK0RRa2dVSUUxUC9aajVFcWxjU0xlb3FtYW9ndVN5bnVaais3?=
 =?utf-8?B?WUYyKytCVkZpeVk4dlROUjdWK3llSVRCallHSHhiNTFPWkgrd1l4K3FhWGZG?=
 =?utf-8?B?eEF2RGdKT3F2WE1qallqTDFGTEtrdU5jK2xTVEdxRzJoZE9Ua3FDbFVxMnpQ?=
 =?utf-8?B?cWVjQlQ1Q2xrWStPNHRUWTIrK3ZwR2NUS28vOWFKVnpRc1ZjQW9JWHhpNFVS?=
 =?utf-8?B?RkF1N2hOVUF4bHVrakRWQldSNmdRZUdzTXJha3AwQU4xaXI5RDBUenRSUHFM?=
 =?utf-8?B?QkQzem42MXdkbGlKcVZ0VU5hY1hYbHo0S3Jmc3cwRThnc3gwamNKM0tCTCtv?=
 =?utf-8?B?alFQVzFvMlk4RkhEQzExQk1DL25nelJYcTZVSzZDQXdoOGNQU3RJazh5MFVM?=
 =?utf-8?B?Vk9qNzlMQmJKRHg2dDc2WDNHTGVYaFJWUDRFdWJYNmVrcmlNQ0h6eU9CbU1k?=
 =?utf-8?B?blhBSGlFNVV6R1Z1bEY1M1E3M3BPckd5MHM4dUE5cmQ1eFRiMVNueE1EZzMw?=
 =?utf-8?B?Y29oNGVnZ0NJOUtZTGc5WXRZOWRHVC95bzdIK25lY0dvUnpKY0g4K0R6dVBY?=
 =?utf-8?B?RFJuUHhMd3Zicy9NeTh0eitNZ0crYjBJOXNCdjRqcG9FOFJkMGNyZkhHMHBI?=
 =?utf-8?B?TXU4bTVGdEl2elZLSTUwUFhLRzY1Y1pRanlnbWVYRkM4Q1NoNXVnN2RYMlgr?=
 =?utf-8?B?UjlROUV5ajFTK0pIL0xselRYeHhERU9aZFBFS1R6SlZCKy9aR2RPWm51VS9N?=
 =?utf-8?B?eGMyZEE2UFc3TGdVMXhvdnR1YmJWMStwa1dkam1QbUVxZ1V2Rk54b3NGM3ZH?=
 =?utf-8?B?ejM0SkRGZ1VIT0ErTFc5bXY4dU0zdmxVN0Y2SWhLRUErdE9vanRnSGFvM0VD?=
 =?utf-8?B?TXFnWGFlRGZDcUVEN0d1TXJ0dzhBVlFZWjhDb09TYkZCeGI5SlZQZHpSaFNh?=
 =?utf-8?B?OXFOUERldS9CRDF1QVBHZmVncUNHTjlWb245Ykh5UlQ2bVNSa2FmNE02ZG5G?=
 =?utf-8?B?ckxldmY4QWYzSkVoeE1TWVA5RDFWZmxqZ00yWDQzUSt0RzIzYUFKMkRzV0x6?=
 =?utf-8?B?WlArRGgxNll1eTQ4K2NHRlFuYWxRUzg3b1RBTWlodExyeUx2RDJWWEx1dWRB?=
 =?utf-8?B?RVBqc3pBNFd2Y1QwS3ZiaVNNUkdJSXZ2djQ4U2l1OHBqeXpBNk9zQW1mYWV0?=
 =?utf-8?B?cFdQcUFzMFJvZ3RFbFlaRWtpdkErNW92WTUxa254K1MvdnhNeGdNSytBSGxH?=
 =?utf-8?B?Z2FRKzFnc3R5UGt5MDZuS09BNm9NZG9COUJ3WVZtWmpnbjZBVTBoTjJPVFZB?=
 =?utf-8?B?M2N5N2RtWUFxTGJHbXhwRE52UmdhU1BLRFpRVGlLVDFjVENGV01CNW1YU2ov?=
 =?utf-8?B?TkFwcWc2VDFlUklwUkx3TGllbHp3ZTFwNVR5bDhiblVVeW95STR1cDZSZTgz?=
 =?utf-8?B?MGh0RkhMN2xQVUl3MFZ1bmxDRURHSkY2OGRnZ3Exa1poVzBkNUR3QkYzMkQ2?=
 =?utf-8?B?ZlNNakVra1pXSEg4eHd1UFQ1eEVpeDFSRWFFRkN0NTgxQkxBMGVja2dxeEJJ?=
 =?utf-8?B?ZXRuU3J6S2REMStXYmxsa1hlMnFhUHMyK1FOc2UwTVhNSWlhaXFYajR4UjZO?=
 =?utf-8?B?cjVpT0VpSytLdGZtZkJsZDB6U0dpdW1tSjJVaDBscFBwZUpNMkJ2V240ck45?=
 =?utf-8?B?N3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e8659c14-d252-45b4-8408-08dc8006edef
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 17:44:03.0912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VD4WL1D5jdMBB4dbzf9qAlaFzZVAEjp+qvrnA8vYQUhPkYIP/aJWvE3GPxhcJXT8pdA1tIWxp0KqhWC7vlTiLP7NK/Nkt5oS+HlJWva3izE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7378
X-OriginatorOrg: intel.com

Hi Ilpo,

On 5/20/24 5:30 AM, Ilpo Järvinen wrote:
> A few functions receive PIDs through int arguments. PIDs variables
> should be of type pid_t, not int.
> 
> Convert pid arguments from int to pid_t.
> 

This looks good to me. A couple of places remain that treat
pid_t as int ... that is via the %d format specifier
used to do the printing in print_results_cache() as well as
print_results_bw(). I understand we do not see any warnings
since these are indeed int. So, I wonder if an explicit (int) cast
would not make things obvious and match the stated goal of
not treating pid_t as int?

Reinette

