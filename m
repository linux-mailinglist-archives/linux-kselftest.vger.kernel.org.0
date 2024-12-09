Return-Path: <linux-kselftest+bounces-23092-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A58199E9F45
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 20:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B6A61886894
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 19:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE2F1714D3;
	Mon,  9 Dec 2024 19:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cDZbHeF2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE165157A6B;
	Mon,  9 Dec 2024 19:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733771931; cv=fail; b=MkNqDt9AMb+1YAQWKFmeXrZCCTYjBDaQq5yxta9HsLNNcPNppad2Wc7QGu3cg3JHJv1NVriyJIrJKDuCspD+Mmo39of/Hje1CkpXgJBh1eA9sZ6FgQ6m1pmeXF7lAKbBZHka10zShtTrqsa1XLUkudJ9LALX72pQk0yx8USYnuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733771931; c=relaxed/simple;
	bh=/Yt25BbkwOV+4UQsMiD/2BQ0/FohGThVuWspfzYP5t8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q9+1OzqBskCL4KtR85XJx0BuJD3tbEMUnH/TtDR0gQeDAICjr17X0YpGn1fBktGumL9VfOSDpcJBABwGIgxQKJskInx5DQCaPL/V7BsFgJpvtlLHzufcMaaWsLzJS2UQwbWIBG3hp/Is23537K/PiaJ4LCm2vhqKq+GPc/Ix3vI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cDZbHeF2; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733771930; x=1765307930;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/Yt25BbkwOV+4UQsMiD/2BQ0/FohGThVuWspfzYP5t8=;
  b=cDZbHeF2+taQHVu46dSGMreIhgcSvcYvZrgiio5thqIbNBAngCFnUDQx
   qxTur+bhSvOz6cKIVOuU9JR2XoKUgEc6G0e9o4A+mdrwNuUSjlvZuLngs
   B7vJIFV0TtmwqqSazN9TCfB8P4ZwrDdFoe+oeBJThu1ZtK1xAfBw40qk7
   de8IiLOz9Pdec/SHFAaAoNDte0YQL/qAlfvsp5YZOkuJIKZPP3i6rKNdC
   OuUE8wd9JvkmLyU3ChJbRzRTeyYMRqxDY+SrkVdcFvGLl3q7Y6kpX5VWs
   n0te9ojezvTcvAcqJTIuGFFsl7qpADeLYRyFxe6I07vDywQGtS8UpvRyK
   A==;
X-CSE-ConnectionGUID: OdVvCsXNQ0+b7lWmiTJ9yg==
X-CSE-MsgGUID: YJ6s3lt0RdK4CQPRRX2lkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="36926738"
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="36926738"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 11:18:48 -0800
X-CSE-ConnectionGUID: ZCbg7tJGTh6aLRUsbwiTQg==
X-CSE-MsgGUID: RbK4guNcQeyEaC+fnOrQcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="95615731"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Dec 2024 11:18:48 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Dec 2024 11:18:47 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Dec 2024 11:18:47 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Dec 2024 11:18:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f552XaFl/Zh7NCFtoEIHVBQktUPmcoK7QzIGlSd7vgrdHKaTzEh4+DaXfV3WMx/jn7gdbMOSWG6l30f/9PbhIZdlr4A5lu0Op0EwU5AqDpEul7NpQ5xoRnzmnsrmwlwGV6YNr4ZGpBy9SwFMMBVQU6t3FvO3GD9Awd4DmZ4ZCFEv1FWZDYTLPWuYMATKLqGfSt1Sav75i21jzqYEF8rqp0WtiDmXHdN53eo7eyfvieGl2t40TeauQ5WosDxdeThDibe9DPE8q3KpxYDS4Cix6P8M9DYA7VXJNpToM/yVmR2MIUU/pqdNnjJkXlYzw50yTUDVSLWiL4nDO4bblnARSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/4px/4e9wkmnQMSTY7nzbwXOslDKcBDvb2ZBRZnJ+8=;
 b=AlL1HYTpHragJ++3QIzyf9uqF8M1aG0faU+FaE/+vGPcfifThycxNNz0kOiJhqS1BkMBXVEaaIrhDZ7C5SKStSvv/O7RMci4hasF05/uqhhg9BVFzyB4ThTarJ7BRocpPbnn67PZaZVm7ZU/UcwAcDwjatz06fy/uckixmnQAW0qHopyC0I0hARVdYSHGAJNh2ZNhEuOvZzvClHfVse4kjnHBIqtvjf73XsXMNxbdg6P6YhVBzUpt7JlC5OD5uEg6rW8dLgJDe5RGUfatXM9PvPVHHnIl6OW9m1na8Pt8itkVmYzn7ns64SdkBUpn0svMMxHbq2/jNnY8WF13VOmcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY5PR11MB6464.namprd11.prod.outlook.com (2603:10b6:930:30::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 19:18:41 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 19:18:39 +0000
Message-ID: <4c1ac17c-e50c-4387-8512-e82e99f4ce4c@intel.com>
Date: Mon, 9 Dec 2024 11:18:37 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] selftests/resctrl: Adjust effective L3 cache size
 with SNC enabled
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	<shuah@kernel.org>, <fenghua.yu@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <tony.luck@intel.com>
References: <cover.1733741950.git.maciej.wieczor-retman@intel.com>
 <0adccb86b3bd1b8ae75cf8fdcddac7d1d79f49a4.1733741950.git.maciej.wieczor-retman@intel.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <0adccb86b3bd1b8ae75cf8fdcddac7d1d79f49a4.1733741950.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0003.namprd02.prod.outlook.com
 (2603:10b6:303:16d::30) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY5PR11MB6464:EE_
X-MS-Office365-Filtering-Correlation-Id: e3ef3ae4-b0ee-4df0-9056-08dd188649b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V3hXbEFTYklTdG1WQU9zSGhaUnlhdVNHeGhoRWhWREdGNEhhU1Jodm9vSDlo?=
 =?utf-8?B?VWVPeDArQXVhN01DZzdBSDJaV0lqSjVlbnBvc1I3TFR1by9aZjl2VjlIaVVl?=
 =?utf-8?B?eWlyUzBlaE9lK045U3dOWGVuSUxEbDBxMWVTY2RPbmJOWmRTRi9SMlZETmJW?=
 =?utf-8?B?TjhjVjdudEhUbVBwQit0MnB4M1ZLSityYWhYaFhkazMzMVgveWVwa1A5Tldp?=
 =?utf-8?B?SWJDTFc5OUgzU3BubnAxR2pKYmprMHk3a0lzcUo2VUtIN3c0V3VqeEtlcm9m?=
 =?utf-8?B?QnJEbTJ5cFRkWWZTWnFqUG5UYnk5ME5EZldQdnIyZnh2MXNDalplVnppQ29K?=
 =?utf-8?B?WkNXRWJ6dnZQWElXOUt2N29GL2FXODVVVEV5M2pOWmJyQjlEcTVzbkJrOUFx?=
 =?utf-8?B?UFl6Y3V1ekx3WGpDZnlXNm5UWDdHRUgxVzZ0YVh6WGpKMEJEQld5TDJ5cUFD?=
 =?utf-8?B?Ujhab2c2b2VSbGNPUzNVQWN2amxSbmF5dzBNOHpYQzJEK3pwM0ptOS8vTnJT?=
 =?utf-8?B?SUtPeHZINEZOakdVbmhnYnUyd2kwOUZFSnpwcy9WY3FERG05WllXRWI5OEpq?=
 =?utf-8?B?eUxucnU2cVEzbE9xclBOaEgzN2tDNUV1U3RzbmdDNEltSW1xRmppQTdLU25Y?=
 =?utf-8?B?ajl0YitmS3djYkExWXZWN0dRZGNLcnVoQ3RLWDZSeENsTlIvMVp4RFJ2czM0?=
 =?utf-8?B?YTNCQVlIaTU1L0lqSC9CT2Z2cFN3YlA0a1AwSDFhRjNibklNMFBJVmhLZnFZ?=
 =?utf-8?B?aWRIejgySVNFL3dLL0laQnY4K0NVWC90TWtJWGl5MkRXdFJER1V3dG5WUVox?=
 =?utf-8?B?aFVLalpNRHJoSzFKSFpMNnltNWgyaUh5Rzd2Z0Y2MENUc3R5cm1jSURCTXpC?=
 =?utf-8?B?Z3JlczlYRnp0VFV1WU1oQm83R1A4d2s5RVJWbUxiOHRKMFpkbXN6Q0pnUXVh?=
 =?utf-8?B?UG45cmhQV2tsZ3Y0MHdpQzJIcVBrbEo3WEd1NXNZOC9NeTFOUWV4YWY4S0Mx?=
 =?utf-8?B?MWhadXhRYUtmNk85WEEwMXhxSThrbHFPeDA3d2RLRERiWXFqV1pDSkRUSVpN?=
 =?utf-8?B?dkFSVElpalVndjdKa0ZjRVBTVXM2L2pLQmxUTXp3VUFCYXh0L2RoYXRSaVhQ?=
 =?utf-8?B?L3k1Lzl1NjB3OTJ3WnZHRUppUDVFTitVdGlMMG96Qk9wR3RMb3BqRjJOWGRx?=
 =?utf-8?B?RnBGQUZLZ0NKNnk2eUJoVFd0cmZjT2VMd0FWK3NWSWRuczk0MmhJTTBzWS96?=
 =?utf-8?B?NXFsR1NsZHNoSm5UY29uWjNOa1ZuSXhkcjBabHkvRE5Cc0N1Ull1MndNbkxT?=
 =?utf-8?B?MzFSWkZtVGlPekJDcGFKc2xpTk0wdGxuc0F6NU9OTVBjcURveFoxblh0bXFv?=
 =?utf-8?B?MFpHR05OZkxJUC94NmY0M2FPb2xIN3ZSU0FZazNpVjVHSDZ4TVJmSXJMalov?=
 =?utf-8?B?T3hLRVdvbm5UVEtXYldDdDZYLzZOZFBOQzFQNE83NllTbmdTZ20yQitWdm0x?=
 =?utf-8?B?Wi9XSEVHR243eEV5bzBkQ0g0azdtQXR6ZkdHN1RINW1yeHdBTmExNnBiS01C?=
 =?utf-8?B?dldMbCt1VmFrU2lqNTg0aEtOYWgrYjFvcFdNVHYzTFFHRjZzYzJXV2FxKzhq?=
 =?utf-8?B?NTlZM0VMcm8zWmtLVGcwRGU2RUV5cFNwbUgraVBpeXFpc3FzQnpkaFVSdy92?=
 =?utf-8?B?T2dCdDNHd3JkQ3lEQ2FkYmFSTVpDUlNSeUJQbk9pQXQreUROZ3lBK1BNU3hZ?=
 =?utf-8?B?NzdTTFo5Z3hxWW5pNmU0TDRVcXpEa3JkUEZ6K0VPOHJCK0RqZmFmTXBxSVpQ?=
 =?utf-8?B?ekpFVVYxSDZjaVFZNTI3QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDNWQU1hVXVhY1FxaEE2Q2hSbXY4b3cvcjNucGV5U0kvMVNVR2REeG8wNnBQ?=
 =?utf-8?B?QjBJbHcwK3NZb3JtaDB3cGFTYXBHdzZ5N1ZDUE1PUmNyejFEc3RtaUsyZnh3?=
 =?utf-8?B?TVFzbmFNTGN4dTE2UDRzWlQwem04allZOUxIMVRzSExsS0xaV2ZJWUxaalAx?=
 =?utf-8?B?ZlBhbHVrcW1KcGkxWWZtSHpCcE14MDcva01XVjFETjN5c1BtNkdrNzBubjU1?=
 =?utf-8?B?ZXZBZ00yNUxrN3VnaUdiekdEaURRUnhzTjlOYVpldlpvVkIrdldEMlhZQnhB?=
 =?utf-8?B?bUo3c0lTSTc5a2dBVFAwN0U5Q0FoelpkelZDR3N5M2pySHJFUUN4SlBtUHFC?=
 =?utf-8?B?YW1jVTcvdkxQQktlT1NTU1hMWWxVQnN4Y0tTS2NpcnNnbmo3eU9VbnJTdytW?=
 =?utf-8?B?TlJkMnVSZzhFZ0JiN3dhUm1UVktJbnRONG1DWEl3cUl0a3FaSHpZVGNMY0RD?=
 =?utf-8?B?NzJBRWdtU2FwdFJhRnV4ZlVoSVNjYVdaZzBrajJodGh4L01GNlo3V0lWL0NX?=
 =?utf-8?B?R3ZNVVliWUhsLzRhVHR1eFozNTRDMlZvSTlNY3VWREVNa0MrTnV1bysxKzcr?=
 =?utf-8?B?QTZmNUMxOE5NL3hnUm5BS1NJdEMzMTdHZHJpQXcxZCtWMEhvK0czbmw2ay9R?=
 =?utf-8?B?NUM4d0tGUlg3cFA0eHNuQlQ5NW9uZEhkWStiZUJHQlA3RWttMkZ6WE94VVhO?=
 =?utf-8?B?QkV1RCtraVFXcDgwV3JVczhIQ1gzSHp4UTVSOGRER29hL1lCUDFTaFQ0RUk2?=
 =?utf-8?B?SC9pdEl0S0U4bmxPRk9ZU21NelJsVG5RSVpmUThocnJPRExPQ1MxZTFPT0ZZ?=
 =?utf-8?B?VkgrV2R1Tm1DcHVtK2NVS2J1YW5nMVJ4WFo2d3hkejJJSmdPT1I2Uy9YMGZv?=
 =?utf-8?B?K29VQThYQTlYbWNqTVdKQzRXQ01HQXBXek9nNzEyRnVKTXJRUHdMc3NlUVB0?=
 =?utf-8?B?T3hKNDl0T2tpaGpkYk9UTnhrSFJ1WDZKR09uZFdQYWtLaVgyZG1aUTFkUVZI?=
 =?utf-8?B?VGEwYlBvaDBoMldaaDlsV1hDcG10TXpIU3ZqeVIyTVJWNS9BWHB6am54bzBN?=
 =?utf-8?B?RS9DNTVCSzEvbGNkVWlYL0NjV3BvZ1RDbC9iSE5UUEFOYmVWRXNRaHV6Qjcv?=
 =?utf-8?B?VC9lVVk0cHJxMUFCMGt6d3FENDNteFJ1ZVY1d0I2bEg5WHd5V2gzWGFkUW1m?=
 =?utf-8?B?K2VkMmZuNkdwMnN2TEtLYXdCdjRVaE1idkk2QVNvemE1czFDTUdyaXFGN0dq?=
 =?utf-8?B?QnIvS05ETHhHcWlQaDBZSnBOeGZ2czR2YW5aaVBtNDdWZFJnMzltWkJGSTJ6?=
 =?utf-8?B?Nk5QQnllN0xxeDdyVHliaFp5TmNJclN3cU5EeG1zbmEvMkhRRUtudjc0NVdP?=
 =?utf-8?B?eStCWDFxVmxrUUQ4ZlZ3OGZZbU44Mkd5Wk82Tm9JekkyVkE0TzVEVVVkKzdO?=
 =?utf-8?B?NlBOTlV2YlhETVFhMlJwRTh0cEhraENTUEo0cGNOa1lGUEJCYXNHNWkxTklJ?=
 =?utf-8?B?OUNlNzhxVXFtRjBrVTd5VkszYkcwK1B3RkVyemQ5Zzc2QWk4NnJuSm4rQnNa?=
 =?utf-8?B?NlRoLzlrc0xGTTR4aE5iZmJDZWpuYmp2TnEzbnlHN21jTWFtbFU2UEhQMENp?=
 =?utf-8?B?ODJqVU9PVXg1aGJJTjdaY1ladE56QXlTZVFYdWp1MzlaZnh3ay90M3ZDTE9T?=
 =?utf-8?B?SzZjR0hwWCtZdlo5cjc2M2p4MG5BSlhlcW1tbmVoUFpUSjR2b0lLaEh5cU13?=
 =?utf-8?B?MDJFNXYxT0JSVUtHM2sxZXBsRXVSUE4rVDhKWWQrbFlkUnAwRDdIby9nbDhj?=
 =?utf-8?B?Yml4RmFXUWJEUUxwejlBaVo0RXUvT2hnUm8wdlBUZXpLdHhRNVRCMDJvc0VS?=
 =?utf-8?B?dWZnUWFYL0lZdlNwTGUvNDBkWkFId1ZPOUlDVE1uc042NWhTUHlUcHFLdWlx?=
 =?utf-8?B?NHM4TFlNWXhtZjZLTjdYWjY3NDZiNzFaNmdtazI2R2twNXZubTl2MStvalY0?=
 =?utf-8?B?a3dBeWlyVWVteDFBMWU0dWRBYjhxMXZtYlRTcGo4V2RzL3FtUjJlVzBBUS9n?=
 =?utf-8?B?eU8wbW1CYkdBM1QvS3J1NkcrdDJVSEpydWM3Z2t6ektOZzFJcWpvZlR6M1pH?=
 =?utf-8?B?TVRtYXhrYnU2cklFa3dGWUdWd2VxR3haQ0ZNcXp4R3Q4bG4xaVBuL3pCVzdH?=
 =?utf-8?B?eWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ef3ae4-b0ee-4df0-9056-08dd188649b2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 19:18:39.9345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yTRDyWxb3tbX3dxjECOo10GAT8F6sZ4Vd1vX0xcq+FHQvNRe1y+JnjMNxNG2CO8N95ua0Ui+gGW3absS1zOCExeYWsfgVTBemSwlR6F4lKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6464
X-OriginatorOrg: intel.com

Hi Maciej,

On 12/9/24 3:09 AM, Maciej Wieczor-Retman wrote:
> Sub-NUMA Cluster divides CPUs sharing an L3 cache into separate NUMA
> nodes. Systems may support splitting into either two, three, four or six
> nodes. When SNC mode is enabled the effective amount of L3 cache
> available for allocation is divided by the number of nodes per L3.
> 
> It's possible to detect which SNC mode is active by comparing the number
> of CPUs that share a cache with CPU0, with the number of CPUs on node0.
> 
> Detect SNC mode once and let other tests inherit that information.
> 
> Change top_srcdir in the Makefile so fallthrough macro can be used in
> the switch statement.
> 
> To check if SNC detection is reliable one can check the
> /sys/devices/system/cpu/offline file. If it's empty, it means all cores
> are operational and the ratio should be calculated correctly. If it has
> any contents, it means the detected SNC mode can't be trusted and should
> be disabled.
> 
> Check if detection was not reliable due to offline cpus. If it was skip
> running tests since the results couldn't be trusted.
> 
> Co-developed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---

...

> diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
> index f408bd6bfc3d..6b03bab6fc20 100644
> --- a/tools/testing/selftests/resctrl/Makefile
> +++ b/tools/testing/selftests/resctrl/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
> +top_srcdir = ../../../..

top_srcdir is already defined in lib.mk, it should not be necessary to
redefine it.

>  
> -CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2
> +CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2 -I$(top_srcdir)/tools/include

It is not clear to me why my suggestion to set this after including lib.mk
was ignored. I am thinking about a change like below but looking at the other
selftest Makefiles I do see very few actually modify CFLAGS after including
lib.mk. Closest one I could find to this problem was
tools/testing/selftests/vDSO/Makefile. Do you see an issue with modifying CFLAGS
after including lib.mk?

diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
index 6b03bab6fc20..984534cfbf1b 100644
--- a/tools/testing/selftests/resctrl/Makefile
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
-top_srcdir = ../../../..
 
-CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2 -I$(top_srcdir)/tools/include
+CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2
 CFLAGS += $(KHDR_INCLUDES)
 
 TEST_GEN_PROGS := resctrl_tests
@@ -9,5 +8,6 @@ TEST_GEN_PROGS := resctrl_tests
 LOCAL_HDRS += $(wildcard *.h)
 
 include ../lib.mk
+CFLAGS += -I$(top_srcdir)/tools/include
 
 $(OUTPUT)/resctrl_tests: $(wildcard *.c)

>  CFLAGS += $(KHDR_INCLUDES)
>  
>  TEST_GEN_PROGS := resctrl_tests

Rest of the patch looks good to me.

Reinette


