Return-Path: <linux-kselftest+bounces-10839-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF508D3D82
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 19:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42F3BB24D82
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 17:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9D515B99C;
	Wed, 29 May 2024 17:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="in64U4rF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813811581E7;
	Wed, 29 May 2024 17:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717004578; cv=fail; b=MtIF//XWuwvGSVxTKGQ7QPbiUjmQG9ybtb5Jpxoh7zisL8y0Ik9wjj01jIL9TGyVhE2SXAZsSRhskMc8AY77QsBt+wlWT2j5A1WoWyF2DDnNRThaisZMgQmds0LkxbKjvuFjs7IzmyXuvazDKwC5A6ETsr7N8SsnFthbTX5w7+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717004578; c=relaxed/simple;
	bh=zssctieAaIBJ/reg3ymtEaZr2VsO8fyRGXRtXNpda0Q=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UX+og4sZNnbCeMphOt00E+fCwrVslYkg9GCf3ajEPd+lYHbN2uvoHn2L56PzswWNOKHa1UqXavUhX2LuU6GFZg/3zunrZDpL63kaozihLksHnH37lTfDJjT7uLxgDC8DhsCNdEg3DuHFM1SCUsvywKcggX/PjZ7H3aiyJT+8A8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=in64U4rF; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717004577; x=1748540577;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zssctieAaIBJ/reg3ymtEaZr2VsO8fyRGXRtXNpda0Q=;
  b=in64U4rFEmNwaYlV+PMWoRC0tHPH1Jasb1rtoKw3fLty2XpVhh42geLM
   p300+hd2s3ZTT+58Js8StA9ew9YRdfgTu0nWGX9HWSDKZCi35oHl5Zux4
   9/j6Yn25q6m3Sn66teidA4okUQA4SpVSTX6j0qMJnEQIngXUeF18BPX6s
   Yufa2NK1jhyooCO7px5mZ9GW4We5n/n8U5+M4w2T6lCAO6U7X3YwGH4Xw
   uRjLU7tKf7nud9TSyeaI7RUQhkIb47MA3DS49lziN1muwhljLXS64tcnc
   IHRE5Hrk9N0dTfaynfWtt4rRgjz3CFwE6jGb2wl2T8+L8bAawOqtF8ifK
   A==;
X-CSE-ConnectionGUID: fLbdCaWKTyOwDPVRIza4lA==
X-CSE-MsgGUID: VGGkAtx/QTKagPioZ7wndA==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="11755255"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="11755255"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 10:42:56 -0700
X-CSE-ConnectionGUID: e24UJaoYRr+8voio7aq0hw==
X-CSE-MsgGUID: j4A2Ifg3SsGsr1TdaKitqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="35582536"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 May 2024 10:42:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 10:42:54 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 May 2024 10:42:53 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 29 May 2024 10:42:53 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 10:42:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QuuDyLlkD2pJuHFWN+S2vjHnzjoUhx2HJB+0rXRUoxlGH1vAuA2HyECXBFAm9HVxDLg7gbcqdbt5ItJ87pHpO9Nw87mkfiZo78CfbvX8E6bpue0R7qlyURH7sSRC2ZC9/r6HJX2lhPpCGcxjOIrGNy+8UUVdswyDGob5yLcMFav2cPl4BdMV9vXEtUo1u+uqku3WarlEvUKeHatcvxbGrQoyop2FKE8wvDq9mEpDSrenw3LR/TmR9At/IBCv6w+cuDwVW1H2PVPO61GAhgk6vK6QEt9d+TbkUuP/mMuOTQ9pVVRuLZRfHI55J8xU2eRfrgnVrkL9/hxVoUiUiTP0JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9HpvaN4VuRoP9aIWz8qGubW63XKvTZTQZ0h/fkQPjQ=;
 b=DZeFjR5flZvirGw2XAlh0cu/rXVgOSwFN5oaF5953b4INyXnNeUFbvM1qq/wZFccsBu+nvKix3SGUTG+71JIMV7KE/3ybVX774C98nXXgMH9L/RtJFEx1Gc3SuNX4C86o3AOtqxUjxRP4mM8INwVFWapzALR/UmYY37RMsi19miLwoYq+aaDUB/m8Gb1XvoBHfDm2Ft67XMOMaOfs7kmSqmqdSbz15cl9928u//SeOpvj4fYmNZHfqXdP5h2MNO6iNf0YWijaspEE4/DhFle86w/4YE9VotJNL/5WMDhbWvrLwDof6G1f4TMpYJXdwkh1OrOHXN1eHf2GhsTPLpcBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB7854.namprd11.prod.outlook.com (2603:10b6:208:3f6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 17:42:51 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7633.017; Wed, 29 May 2024
 17:42:50 +0000
Message-ID: <c17774d8-11b3-4f59-a995-329bf2300fce@intel.com>
Date: Wed, 29 May 2024 10:42:47 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/16] selftests/resctrl: Fix closing IMC fds on error
 and open-code R+W instead of loops
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Babu Moger
	<babu.moger@amd.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>
CC: <linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>
References: <20240520123020.18938-1-ilpo.jarvinen@linux.intel.com>
 <20240520123020.18938-2-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20240520123020.18938-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0339.namprd03.prod.outlook.com
 (2603:10b6:303:dc::14) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB7854:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e782216-d14b-4ab0-4673-08dc8006c25c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NlpVRXBjZ2hTaWQvSHJUN08wZVZCOGJsUjg2OEJ0aG5BdzdQT3ljd1R3OXY1?=
 =?utf-8?B?WFJGVzg2d3FQeVdNTnVjUkhmU3I4ZWIwdjEwb09FYzVsZmlzVy9mSFpuVHVW?=
 =?utf-8?B?U2cwMml5Y3ZUV3pGdlN5VVhEU1JLaThCNnZ5RE02dUhTMi80OUQ0NVFuaUhY?=
 =?utf-8?B?NkdqRTUva1ZydzMwQ0FBWVIwWnlLWFBKVXNhVkkrbzBSYVRVeUFycGxRbUph?=
 =?utf-8?B?R2p4YXVzbEZVOU5GOGRlbS9IczFqekpYSEVJKzNETTh6VWdIN3VJM1F4R0ov?=
 =?utf-8?B?Y2tkNmNPd2VIaE9YNDkramxMTVU0Ui9NOXBsRTNUNlEvYUdZR3ZMMlRUR2Yr?=
 =?utf-8?B?ZDY3N3ZVMlUrREZnd3FhZWxQNXRVZzY4NHQ3Uy81SVBRQ2taU0I2R2xQNU5m?=
 =?utf-8?B?anJKOEh2bUNyT21DaFUycHN5ZXpJSG9tbmkwd3IyMXhlK3F4MFlrODZpcStG?=
 =?utf-8?B?bHRlREgxK1JUbDRVM2EveitoV3pWOWF4TTNYRUpJQzg1TjFEaGRQYWV3SEVO?=
 =?utf-8?B?QUFxZG45RnBseXF2cExIUktFZjMyWVUrTXFGdG92WVplYUtDaE0xTnhCc0Zz?=
 =?utf-8?B?aVllK0FCamJKenRrZFZDOWdwQTBpRlRhcCtlbE5qZ3RaRDlMVHkzUDlrUzhm?=
 =?utf-8?B?NUhJWXFvUk5KeUJiNUN2QzBUWFp1VDhiSU5aWTFwSE5QV3p3L3gxTUFwTS8x?=
 =?utf-8?B?MXV5RUdMQXd0ZU9rVExqQ0laa2FnSE9qYWJjNlduYUlReUNXa3JndzBGNzFZ?=
 =?utf-8?B?emtZcXVoNlh6V0Fmaks3bHIrdllZVHBnbnZlRXFFYnppR0tJMmtEUk9oUzVk?=
 =?utf-8?B?MzFpaVB0Ky9GTzRoRVZ6UENmVWZlak42R2RwVEdkRnhzeHlyUWxoQ2Fvc1Fh?=
 =?utf-8?B?OGxHMjNiQWxDUzNlL2JDNEc4Y1VCYXphZjczcUlxcjlVZHE2MUE3blp0b1Er?=
 =?utf-8?B?N3h1V0JmOHppOFlaVXpxUzVGUEpUUE9CWHVVOElQNGt5eW5wREJQbFJoZUFq?=
 =?utf-8?B?ZENGdzR6a290V1RCbyswVlBqQVFYam5HREFvU2RiTnllN1JpZUhpOGZSbDA2?=
 =?utf-8?B?SGUvejJEZGJtNlpkYlR3RTBZZk9Hb3NHWG5ISVM0ZHNFUXgxbzU4U3NOaWM4?=
 =?utf-8?B?TE1Td29GVjMyVHFjaEhwYTUrQkNpSjlBQTFyMlIwbFRrVDBxcllPK1U3VXJl?=
 =?utf-8?B?OEJ2WkhxWjhEY25ROXFwV25EN0xlRFdicjVNejI4Skl3NnN0dGZDR0tGVFhC?=
 =?utf-8?B?MUhOVk5iTmFnSXROMndKdHVoNlQ2QVhiT1JtazZRRDNFY2xGSUw0MFBwU0w5?=
 =?utf-8?B?bStuWDFUbGEvZzBIbmJCaURYcmtCTTNuUmRJWmt4cmlCZVp2WHBsYUhzcytK?=
 =?utf-8?B?em1Qek5mVnRtRTZVcGtHM0VhY0ducjJjenF3Sm9oT3BEL2EyOGZsR3ZlQk5w?=
 =?utf-8?B?Y1E0eERXNWZkUHF1N0UzYUFnMXRucFpOUUVSbDNXcTYrenB0a1Z0cE1VRSs4?=
 =?utf-8?B?QUFyK3EyRmFXWXhuVHdvS3JrcFhzZmVkcXhWenpRWVEzTnBsTURQbnRZVk9R?=
 =?utf-8?B?b0VNZVBya29YYzJKQ2tQS291RVoxSmJwM1NIVnUxeXBkaVdOMDVNV1pHY2s3?=
 =?utf-8?B?b0xET0hHeWNybTl5K3FkM2lGcWRBbGxHUDE5MWdmd3NoZCtpZGN1NDc1M2tC?=
 =?utf-8?B?TmlkRlN1NkFHQVZZelo1OThCMmdXeEpaZ3l4cXZkZUdlYVZSNTBwcE5BPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHBoaU1Qc0VMZ0g4enpGLzFGSmxkRkRSUHhZV0xTQ2ltNEUxbnBUZmYrelk1?=
 =?utf-8?B?dGpENEZvOWdUSjdqZ25MV2w2ckFMNXpyell5R056L1IyaE1nbXZKc0U3MEE5?=
 =?utf-8?B?M1duOUhqYnd2U3l1Yk9Ta3FLRWNSYjd1cnIxVzR1RFErVUhJTWM4NUNyclNJ?=
 =?utf-8?B?TzBSTzdodjhiU2w4amEyKzNkV2ZGQy9Ob1J3WHhrSmxwUXY1dkhub3ErK21x?=
 =?utf-8?B?OVhuMU43aCtSOExGSGoxakVFbjA5djBvaWx6cGViY0xlUDBtQWx0YkJsMEdU?=
 =?utf-8?B?WnZveHROcTJYRWt4YlAxN0kzaUdLdEtjL01yYWM5Z3IzNkMyQ3ZIajgrY2dY?=
 =?utf-8?B?S1RwaTN3OVEvSlVjMjYzNFNBSzhjdklMaGtxUmFKc1hGVHJxVGcvS2NDVkFu?=
 =?utf-8?B?Y25Id01iSDBzVDNZUFVkenpFNVNuaHBvUkQrWWxsZC9rb3ROczRyakRyVDE3?=
 =?utf-8?B?bEw5T25TSHZoNnRQM0ZSKytES2ViSk42UEdDd0F3d2kva0FDSUppMHhlTmZM?=
 =?utf-8?B?cTR0bkRmQk1zTFpkcU5wb1htaWs1QTNtL2tSMWdjdnN0RFVYdTlxUEIvcmVF?=
 =?utf-8?B?TExFK3hIbFNoS1NaUW52M29ETHRDeWVxVU5CZDNmdWxZWjBLbW0vaHFRdzdt?=
 =?utf-8?B?cmx4OHJxazdFNFJ3cC8wbTl0Z2h0NzlwaHJORnYvczM1VkNKNWNrTytGUXg1?=
 =?utf-8?B?M09mUUFpc01pdHM0c2x6cENaMWVzbzQ4ajhDS1NkVVlZdjZNRm9uWVVNejM0?=
 =?utf-8?B?YWFMYklmSXQrQ25MMVo4S0RKTG9PRHM5MVNJTEZyWFdwbHoxcVNzRStzOThh?=
 =?utf-8?B?aVIzTFRIZlNUaktjdndVMlZTNjNUSjMxeU9QYm5pZHJhYnh5TXlDaVhRdG5j?=
 =?utf-8?B?SkJlajB2U0pNVjh2V1FlWmgyOU1lUXE4T2lUb0xKSWhvSmxrWlpHeDhxNkNE?=
 =?utf-8?B?Smx2NE5sWjhrZXN3ZXlJTzlnbHg4U2ZaMU9rT1kwdkhpSXBWWHlPalU1WTFT?=
 =?utf-8?B?dWZpUEJlR3JOTnM5SXo1bDdsM2Z0UXIzSk9ZNWFpN0ZhMHJsdFFQMnlOWFo0?=
 =?utf-8?B?YkFRK0NVRXF0VkFsVkI2b1p6a25HNE9IMWd0MENMbEEzWjJkQjBESWszWkpy?=
 =?utf-8?B?djJtYkUxSE94MlFBRGRTT2RHeE1kdVNRZjgwcXRnM0Y2VHIrSEtoaVd1OXo0?=
 =?utf-8?B?WlkzbkFqODhyU1JJN01uM3dZc1drM3R6WlZrVkF2OHRkOVdzVk05NHBKVHBW?=
 =?utf-8?B?R0hEK0R1T3ViSGxRaDZ2dlRrSnBMdXF6dnpSTnM5Y2w2UWl1WGY1a0hSbWg4?=
 =?utf-8?B?UHc4dERzOUlwQ05VUEg5VzM4NVJKdm9vc1g4V1ZCUVVhcUNlWGo3MFNYaVRR?=
 =?utf-8?B?ckdmV1BJRlgrVmVxQnpWVHZxYklIYTJSS25FQjdJK2ZnNkliWUZtbXpMSFp2?=
 =?utf-8?B?dDMvZmZXMVQ0eXZJNzNFMDVJbGVsZk1ORDd5cnM0M01DeThTRDFLMlZNdytt?=
 =?utf-8?B?WUVEbGRlODVSTlJFWkJkd2NMaFZWQWVRZHdVTE9ZSjBFbVlYVnppMDdReUly?=
 =?utf-8?B?L256TExFTGxYSlhTRUg5NjBKcUtNWDdReCtsTWVDbUFaY0ZEcTdiNExjMEVV?=
 =?utf-8?B?QmZmdjRqN2xTOFYybGpRMEl1b1lBRWlmM1NDZThQZGNUM3Q2NnZFMDZQZXQ2?=
 =?utf-8?B?QnBhb1NjN250SEhSTXZobVNPZ2p2Zzhwb3pUb2tLNnVYZ0JBSDJoc2FXNUdj?=
 =?utf-8?B?c296MkxUaXZvYTdZQlI5OUJTYnNaSlRscWJzZnVCMENyeEJYMjlPSU9VSTFm?=
 =?utf-8?B?UzBzVHRvRjI2Nms3WTFta0lmSG1hOHlySDFXb0l4SFBrTmloTU4rZFppS0hv?=
 =?utf-8?B?QWdyN3lFOVRRNW1XRHR4ckJWUk9Yc3hCa09sQzhGaUZQSDdmK0xtYWlGZ0Jv?=
 =?utf-8?B?RmFGbm4vSmFpWkJma0tSKzBFbFg5U0w5ai95aS9iakV2NVdmb3Mzak9tSy8v?=
 =?utf-8?B?YzdLRU5aVmptc3E0d2NOVzFmSDBzbWN1OVlGY3dIZEFsRENrUDQvZDU1eDhB?=
 =?utf-8?B?dEFnQ1htMHI3aFZxbG00NlFGUEgrSFZPVG5GZlE1N1o4ZUdvQVJsS2xmK1BR?=
 =?utf-8?B?Um9LNUZGcVd0OTNFcWdSSXEwdElDSnFpWUF0UGk0NWJLZFo4MFVjdFc5TGFm?=
 =?utf-8?B?RVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e782216-d14b-4ab0-4673-08dc8006c25c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 17:42:50.0471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hw+0Aj/uOSiQdyMiHlnEcDMTHv2l2qcrV1Hgg3vS8Xd3jtg5QLuSiGGnt583OtyFktb4KYZfiCNeRJGhlCTn2+0HL3IHbsm9v5KhX2NMkTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7854
X-OriginatorOrg: intel.com

Hi Ilpo,

On 5/20/24 5:30 AM, Ilpo Järvinen wrote:
> The imc perf fd close() calls are missing from all error paths. In
> addition, get_mem_bw_imc() handles fds in a for loop but close() is
> based on two fixed indexes READ and WRITE.
> 
> Open code inner for loops to READ+WRITE entries for clarity and add a
> function to close() IMC fds properly in all cases.
> 
> Fixes: 7f4d257e3a2a ("selftests/resctrl: Add callback to start a benchmark")
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Thank you.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

