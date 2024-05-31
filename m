Return-Path: <linux-kselftest+bounces-11036-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3908D8D68E7
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 20:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A331F1F22301
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 18:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87FF17D374;
	Fri, 31 May 2024 18:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="biXjitZG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3239617D88A;
	Fri, 31 May 2024 18:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717179515; cv=fail; b=L0dp6O1PjopJ6WNwidO2WRmAnHfSp3vHSVRrpNJeRI/h7lhwJO88wbnP3z+U5cgifRrNUGDSdyMIxspeXRJEh+7aUKa/ZlYJ4jr8SPHm077JoX+iken5IyCDXXXbl24NILr3iazpU19fSuIKv5Z+OvfhtwAVSkWYbnMnhfp2H60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717179515; c=relaxed/simple;
	bh=L/C2qZKN/AVgMa3uQw7v9K35t3YkSq45RkcY2XdR/q8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e7HIvrc1Jyt7bqG/TTZfEuCNcYvRov79RKLA2WReAf2zQ31xIoEIZmGxYDn8CKFRHXSUajEyKLYgZoIC147yMn9rTkQpv6jX2Hg24p7C7VwZrm4gus0kkG2W5KbOsiki5kfoi/T1w3qZXpwuoCNSHsdDmphpuyGFqYmZlCo3jAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=biXjitZG; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717179514; x=1748715514;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=L/C2qZKN/AVgMa3uQw7v9K35t3YkSq45RkcY2XdR/q8=;
  b=biXjitZGaZSnomHPbns+XwjkC+lVPeP1nrdoMRJTGgQ56p8OhjmKPJMX
   W0Ins6FuAmk7It3AA/AQXWbGZMY798Dwg6ZMadLgM0BPdVIp7J5KALRaf
   tjgBYkMxGrd2ncOyVr0MgffQ0xD/9zut/fqzIoWWHHqCrSiXaLgW2jAf2
   DAUB7RERRcxPaQ80qDlThxdTfck9NrQnPvoJfWv0fVWMmZHbWK+vib2BI
   JybqFfGW6oqnGUcThNDKNGR1gR/qJRB+XK7qEbwoZuvOFdpIXHoJzGMsM
   Y2DjSi0lj6+f6Xt3EnvPyLUpktfHfcrVT4DoRSj+cmQqpYPff1hnfrLma
   g==;
X-CSE-ConnectionGUID: wDznFye0QaC+F+sMLNCoAg==
X-CSE-MsgGUID: JaREYEqsRROv/AH44GFo3A==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="31230818"
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="31230818"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 11:18:32 -0700
X-CSE-ConnectionGUID: LBgA45p5QNmE7G6A5zeS0g==
X-CSE-MsgGUID: 6fkMsoX9RLO8GRtwhBkYeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,205,1712646000"; 
   d="scan'208";a="36856016"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 May 2024 11:18:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 31 May 2024 11:18:29 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 31 May 2024 11:18:29 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 31 May 2024 11:18:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kVReMggOV7jvAwsNqH1yCTNKB3zLlm3yTB1ZM3zaX7WieV0m9HzLfke1fjbgZUEOnhh0QhUg85oJbUXZ0L80gFiHXxt0WzSVCS0/fZQX/CheFkmgsovHCMOS79cNFH1erRRxhX6UNDi53T/H+d4/z2He43+asjkCHL1YIlOuA2phrtsv7+E624s1s6SkLUn40LWkD/VZIwe4oHsZV7NTjhzOx/0CG6wlIdoU/LynA9iz8AExJ0r208A6H8KcY82xeur9e4Nu0oLrd0vsfFcluJIWrF/uhJ+M72xYrDV4ylAVOLC7BYnGw/OCH4pNio9AEyS50DYbocQPUvdJ9NGzOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a/hjHyZc4Pt6i6zVIQzo66iPQNQnlYNfyuZKpcDVyqo=;
 b=ezEitA2dwpqR5vTvok7yWPL9AV/+fmr3NRVKRwJ2F869Q5yfwqkm2wX1edALyfD8y3fpjVBuBV6s2Jh6y69Wx56cpNYDiIPaqeeW0TiumP6U8Gx/xUwS79CarB1uQBe4VJkTIzCuu1UcufIMfEiT7laCKbG0BKJ9QFCTZ882T2UxXRR/ROpuObUIHe7iELJPj+sMzeVKWkFTGUSVjKlBCV9Ih1pWHBwgFUbsWio6EQ/9ioUpeNz2Slsb97PZ6dG7eEZMvSuFxWZfyu1o8uq4jY/7ZV5WYD6iZXH74n2/xGtZmTv8iHmqzYbeH//xyeH6lT71x5TCxN7+vKSHlc/fdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH3PR11MB8316.namprd11.prod.outlook.com (2603:10b6:610:17b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 18:18:27 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7633.017; Fri, 31 May 2024
 18:18:27 +0000
Message-ID: <f65c35a9-1b77-41cd-95e0-38ae2e4ced24@intel.com>
Date: Fri, 31 May 2024 11:18:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 16/16] selftests/resctrl: Remove test name comparing
 from write_bm_pid_to_resctrl()
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Babu Moger
	<babu.moger@amd.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>
CC: <linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>
References: <20240531131142.1716-1-ilpo.jarvinen@linux.intel.com>
 <20240531131142.1716-17-ilpo.jarvinen@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20240531131142.1716-17-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0101.namprd04.prod.outlook.com
 (2603:10b6:303:83::16) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH3PR11MB8316:EE_
X-MS-Office365-Filtering-Correlation-Id: 39b44cef-331e-43c3-be98-08dc819e1138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWVvdW4wOVhkSDMzamRFVjBTV0paVEVTUFlPbDkvd3Q1cG8vUk9Fb2JTenpn?=
 =?utf-8?B?NmdhQnVtLzFqdVVXa0RIVnNFMUZ5WnVmZUFKOUprdEkrOXBjUlp0MnR6ZGlh?=
 =?utf-8?B?RHZCR3FtWTV3NEFDRXlnSHBaQnhFbzFkcVRrcXd1clpHVytNTEtLWGZkenJo?=
 =?utf-8?B?UGZHdDMyeFRzQlZOZzBnUnJwdlNYZEdVeXJ4ZWtRZEt3VDdxMmZKUHR6aW83?=
 =?utf-8?B?OHhCRTVGSjVaMCtJRW9GUVdtR05HaTdsSGY0L1NVMXFGMVFuaHdTQm5UdmhM?=
 =?utf-8?B?cGJ5NW5tY2lMYnFTVmg1MmdCcjRxelk3WS9RcGRUOFliK1VJR3RvTGk2LzI3?=
 =?utf-8?B?V0JKdGtRMVhCOEtuLzR4NmZSZ0ZqQXRiRDBhM3hJdWlBbDBUcjI1UTZGVHlT?=
 =?utf-8?B?NHg3Ky8rbUZvVUlmSXdMMlVjV0JRQ09IYTVIY2E1ckRYQnFPOFp0M0VNLzdm?=
 =?utf-8?B?NE1BSkxPWjFGbFhEcVNrN0NUUkd6cHo1bjE0N1RrMyswK01ncUsxWWozRWR4?=
 =?utf-8?B?dnJ5a290K3B0STVPUnUrY1JpemdjTG1oQ1dhQXJVSGJSQ291YTRLZDZ1TE5N?=
 =?utf-8?B?TjE0UXRHeUVRdkxJSUNBRHNKWndXOUFsbkp6akxLNUhsaWlrREo1amFXSUFU?=
 =?utf-8?B?TzZDYkxEQjZ2bkFzZkF3S2d3N2JHUDRrRVg0c0dYYmFlcVpDLzNTTVdIOEor?=
 =?utf-8?B?dndZYWhNRmdldnpvWUN1MVdLTTcvNGNtSmxYZTcwUmJpcGFzdlN0TTlMQ05x?=
 =?utf-8?B?Ym13SExXWDVndm5WTnpYN1JZa3JkYW1ZeTZCMHBVTWtneTBzTThidm5QZ3Vo?=
 =?utf-8?B?ZmNWQ2VFN1VkT01aMnVlVFBvS1dNL3pFSGxuZXNuOU9WdDUzODdoUGhYZDA0?=
 =?utf-8?B?OHhWUTM2UlFYS1hqeDJobnBxVW5ZeG5jZWVZZGhXN2l4QUNsUVBhZ2p2SCtL?=
 =?utf-8?B?d0FFblVrL1d5bW4zUjBmOHRUZDhwbExEU05YaTlDVTd3MHVxWDFrSWVDVjlW?=
 =?utf-8?B?UE9nUE9jV1l2MGhBNnJHRTNxdVU0WkcyQTNuaXAydHhxV3VZOXBkS2Nld0Rs?=
 =?utf-8?B?V3I3TUtoaDBFbDdKUkVRb3ZjRjFtaFNOeGkrSVRyVnc3UUJDQWdRVUhCOE0x?=
 =?utf-8?B?VGVpUThlK0JtWnNMek5PRWkweFQvdG9Oa2RETXh4L0pFZ1Qvc2tGbXZXbkgy?=
 =?utf-8?B?UUMxWTdUYU1uelVoSi9PYlVUMEZBWjRyc3BYeGJBVy9ZT0NpeHk4NlhodnVr?=
 =?utf-8?B?bnZUUnhNWnVoMzhMVVQ5YmYwTUJmM1FqRmViL2tiNmh3aFl6SVFTOGFWallm?=
 =?utf-8?B?OWZ6MXQ2R2ovK3c1SFZQL0phQWVmL0x0dXN5WXlGWDhjbHdEMWhCRTVXNDg5?=
 =?utf-8?B?MVZDWHpNcHc4VCtlTHN0Vk1tYjJycWxHZW96SEpjN3dYN0tUUXFkeWZacitH?=
 =?utf-8?B?MUorYzFrcmIwYTVpb0NkUlZ3M3JJRnpNMUVJMnBETjJMckFDQkhiVDR0cVZt?=
 =?utf-8?B?YWNCZnllV1FsMU9Ma0toMllSZHhEdmlWeC9XUm80aEdMWEJrTWJpOWVRa1or?=
 =?utf-8?B?WS9oM25jOWtxVmQxZ2dyNGRqTGRUek8xcHNZbFp3MUVJRHlYZzB2aHN2ejZ1?=
 =?utf-8?B?QU1IaXVWdGJONDJYRS9SRWJOMnZ1Q1JGUm9mY3ZPNnVDeHRrUUN1Y2YxTDZF?=
 =?utf-8?B?aHRBdzZpSFAyNlVSNWdsOGF0cjNUVzc5bHhGSFB6WXV5WnJoK2J0eklRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2lRS1N1SjVHTzJ6L3RIZThDRjlkVzZ5OEcvdUxpeERmZldhVjZyK1l3eVpZ?=
 =?utf-8?B?dWdpZXRLWWRER2tvUW5WeVFEMVhvMzJnVDcra0haQ1dyWGlyRlNhaHdPTFBz?=
 =?utf-8?B?cXRtKzNpaXRkODVnWU9iRWc2ZzJwaU1Hd25lNjJCbk8xMDYwZ2s4c05DN05o?=
 =?utf-8?B?dVc4M0ljdDAwejBQMzFnc1FPWmdFWUdxNlV3VVFKQnBUZkhBc25nN1prQ2dF?=
 =?utf-8?B?UlhUNGRtK3czVk9aeFhERDloRWkveklkSDV2UGtRcTBLcUpiS2Y3bjNmTWd1?=
 =?utf-8?B?azBKaW1JYTU4VFVNb0d2NzU1Yk9Pa1JPVzZHWnFjRytPSUhxbUhFeXljaEtC?=
 =?utf-8?B?ZzRiaUhBbkxNUDBrSGZMTnhTWWdmTDhMOUd0c3h1NEVmVDV6bm5HVy92MXE1?=
 =?utf-8?B?VFYzK0pqTlg3V0FmNDVlbWE3Q2tLM0JxM2d1akxoOXNTQXY2d0F2ZmErTkdy?=
 =?utf-8?B?UWZQQnhuZ2tlUXZCMkFtOXlwTlhteEd2ZzdMRXNRN0tKMGdacGNqdGpCZlM5?=
 =?utf-8?B?dHVuVEczczlXdEU4OW9pZjRrN0FaWUU1VEVMTlBuQk84YWxXdHByNnVORGlm?=
 =?utf-8?B?V1h4eUlCRUVJWVlIdzBIU2hiUEVUMVY3dk0xSTQ0R3pjMkNZMVJscm5JUmVu?=
 =?utf-8?B?MHZRUnZsWEdVdDFjR094ZkgySFAxelJZdmdMYlZUTXo2ajFjaGEyRmlpMzFH?=
 =?utf-8?B?M1A1dkpVd3EyUllZYlF0cXFWQ3lkVHpKcmpiU1dxdURDLzFmbFFFd2lmQmpE?=
 =?utf-8?B?aU1LYlBjQWZ1VEhMVlJDSlVTRmlub2xtTlluYVF2VTJRZHA5TW9TVDkzU1RZ?=
 =?utf-8?B?ZVhuRm5iWENCSmRWUTh0ZENsdnpLY3VIaEFTMkRacCtSUjBDRVZZdjlTdjE1?=
 =?utf-8?B?U2sxejlENlhZcHgrWHlJN09ZVEtaV2JyS3hZWkgvVmVDQ05vbEh6ZnNKZmFq?=
 =?utf-8?B?SGhDMGhqSDZtc2R6bGhMQnh4WlpOZUswL3lza01McG0yQzErU2lRSzBWY3Mv?=
 =?utf-8?B?TC85dTBLZmVJVEpOUlBtekpVVjBiYW01Sm8xQS9BN0RYSlB2b1EybEh3Njcz?=
 =?utf-8?B?bGlUUTZBQ1YxZHBTWWFFcTR0cmxENytWN240emNXeUIyU0g4RllEem5DYmJY?=
 =?utf-8?B?YTYxVERrN0s2cE9KSDYzeGRhNHVaS3lWTEpNR3VXdUg4RDdRU2oyMW1adXFN?=
 =?utf-8?B?ZFhIU2NibERtdFQ5SGpKajlaYk1ubGVyVVk1dW8xWnpqcVhNM2tuUTEyZmMw?=
 =?utf-8?B?QVpMZVV5Z2Vwb0l0bVB5WW52SzMwR1dDVjFxMTBwTnV6VzJVemM2cU1jOVk2?=
 =?utf-8?B?NTFXU3VxblNIZTlBNlZjdEZyU1ZKdEVJbW1LQXRoTk9wWkZrSjNtbUtRNzAz?=
 =?utf-8?B?V2dSclU0VXVzTWxXUktRSVNxWWhnRDVuSm1ZVmRucUFsNDBhQStVS2JTeE4z?=
 =?utf-8?B?Y2h4cjg3L3VubmEzSmxKRWR0aWRFMnFWdUZRcmkwZUQydUxNMUdCbzlEcVRh?=
 =?utf-8?B?RlZZZDNqUWVFcDRUVmZIeXhma1hPVVJadEMvR0J5bFhHR1VQRytmMDkvWkQz?=
 =?utf-8?B?cW52c0NXeCtwaGJvWGVLTWFDaDhzRFluL0xHVHRFVkZ2d2V0aG5wUVdaQk4v?=
 =?utf-8?B?VjNqcFZqUnNweUtRMWNpWGVqdDJiaitiTExXUnA4bmhnVVdUNmk0VUxYSjJ3?=
 =?utf-8?B?WWNnRk5nVGx2VWhhanAwMk9KSWFpV3Z5K3AxM2F1d3BXb1hBY2NxaStDQjNl?=
 =?utf-8?B?UXRIMDhzWW9SWlBrbWk4OEpXQjVtQ01CTUYzTmRxaXVoYTB5bzNZT0pRemVj?=
 =?utf-8?B?cXk5ZDhWdGJ1SkNwZnNpM1RUR1crYU1QdTVDeWdBd3VVYlJ2aGlnaHhhRnBw?=
 =?utf-8?B?dlNYakxTUEhZNHZrZGlENms4ZC9PeEVNc2tGU1krWnVNNW1mY21sMWV1dlJz?=
 =?utf-8?B?QzQ2Z0lIRFlrWmZsZTF1OVUzdlRHeDN4elY2a0RDamlXc1VHQnNtaWIzc2I2?=
 =?utf-8?B?SWpoK0VGZ00wZDJpSGtkNHpLR2FSeFBJdCtMRjdyR05mZG9haDQ1cStyc0k4?=
 =?utf-8?B?Nno2MHRuZktqa2J1OEc5d2U2bmJLTEtMNE1CV1BGWDkydVFuSkh6UXZJY3NC?=
 =?utf-8?B?NXV0T1BwdGkyMnE1aDlOazY5cHh5SWNnNjFZMTlhOCsyV0o5Z3pGMlNJQ3JN?=
 =?utf-8?B?NVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b44cef-331e-43c3-be98-08dc819e1138
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 18:18:27.4495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tbhrg2R6sR/uW/1EC2EFB/4lXncAsWEOXsGLtovaphqN87gzOrC0/viHH7b3bvEo22wMBvs37eUM1aIDbryHHse8ojdp/cpJsb+ID5EosHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8316
X-OriginatorOrg: intel.com

Hi Ilpo,

On 5/31/24 6:11 AM, Ilpo Järvinen wrote:
> write_bm_pid_to_resctrl() uses resctrl_val to check test name which is
> not a good interface generic resctrl FS functions should provide.
> 
> Tests define mongrp when needed. Remove the test name check in
> write_bm_pid_to_resctrl() to only rely on the mongrp parameter being
> non-NULL.
> 
> Remove write_bm_pid_to_resctrl() resctrl_val parameter and resctrl_val
> member from the struct resctrl_val_param that are not used anymore.
> Similarly, remove the test name constants that are no longer used.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Thank you.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

