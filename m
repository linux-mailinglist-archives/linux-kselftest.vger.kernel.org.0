Return-Path: <linux-kselftest+bounces-8842-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2B88B19F5
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 06:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DD751C21FD8
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 04:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7035381BD;
	Thu, 25 Apr 2024 04:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y4N4mf5E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2329374C4;
	Thu, 25 Apr 2024 04:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714019859; cv=fail; b=CAYDXcRsjXipVLSa1DmWHs3vg9Rjz8znOsIZorhTPUPLwfyskdzwkD3aTw0lna9+b1XVNZxxJpjPT2JvAX9fw68kTL6m2eLxyM/GFcsR2ziOwwkbhkqtpzhPLAt+NGD4Dli1hTPI+xk1Ff9UdOaOv7jwMomN50/Wm6SWpZIKTNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714019859; c=relaxed/simple;
	bh=dtx1mevYPHK9kKZAq5oqvVuhVFuKlCpBL00hQLIZlWo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KGcjyEg4XfZ2EQVuXHpNRa6n5GYzr5HWiA09YNWbd1L6l/r2jnTktN6uKs7ARba8HseWnVukQygIs6JBnGK6Z4dtsUTqVZ+jxSZpkUStFedwPY+M0cMY3T78fcUY7+i1or8S0tI/WtZs9ou6IEGCp7MpbO0JqR75VngWrxtCNF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y4N4mf5E; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714019858; x=1745555858;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dtx1mevYPHK9kKZAq5oqvVuhVFuKlCpBL00hQLIZlWo=;
  b=Y4N4mf5E6OJk8tZp50fVxUsS3kQbu8eQ04EiQRmQlj9DOz3mPG2NUDWq
   ZXrgEuGI4GTLSTggWQAU6cQSQJlR0r5ywHwq93A+eoP7IuCbDyeVpoCO7
   6ULC1A5ACopoZo1f4rQikPNO1KmcuiLegovfgFRPH6RHOxWNZ7/KnMl2Z
   oSDDUhMzwoZoGU6KRyuaKy1ZGnwltOFqMpo6NStYi00GJqAZ9SvbgMqB9
   xsvluMSPULBJsp3vIaI4HhfDwqhsC3De1ddKc981psDwlQJegY0L0vid1
   V9DoQcYjsJfCLabmf3qEVOvX5QUWQgd6ECKCbxGN93kfJL8Xxo1MPb8h+
   g==;
X-CSE-ConnectionGUID: STd12iUbSEGvSKyZYNtgqA==
X-CSE-MsgGUID: GJyrBPPvQfezBBCuqx6CzA==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="21094304"
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="21094304"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 21:37:37 -0700
X-CSE-ConnectionGUID: FKWPzn/zSHiM63wJsLCtYQ==
X-CSE-MsgGUID: q5fq4pgfS2qUX2rIyURUfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="25366516"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Apr 2024 21:37:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 21:37:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Apr 2024 21:37:36 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 21:37:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsTOEJ1JxnZZ0PyrDlapT3ViHAYrH7G64OKb4POcsoROm5alyTMkU5qw2uCFflZBRiMsaMeGgFBcKLgzGX3owS+J5EUtHpXBrnTp/5TtKJFhlxD0i2YUqmzeG0F+BxPBR/RSz/rsCth4ldF26V+oe2krIE3K1uchjS6xbsKls+Ok2DwqOPs7kioWTLoOKZakQZr3nBn1jNWjALQsSZPPD2nzqk8jOtTvH9qC6D0KgCkXNKXuVSSjJORWWhBVIjqcyj8B7MVeWH0nZf7pmRJiDAgM756VaRTw8vVelsqST/XzwRY01shGxvQFD67GvS5WZCiZaKvpXqdT15qD4jwfHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Hubukcjm+9sNQfXqaHTZ9+vjHIXWc4s3FiyHcliAnE=;
 b=CXmwnVNJ64P708iGeKInZy+wKnA/pIMEW+0GwgEVKHuM5Mi/LU6G4qjUk2CTWnMd3XiK6IX/PI0LuxKaDU14sP83IGJnPg9WHFLsvgIn4q4w7hvZaJmVRtnyxZvfrx8+1SSxTOhURZ50nJ1nFG/3hfi8TzYZiidJhkkeStJuSKdQhoAtbYHj6LO5FLpPjIvmZuFRDfC9AdMDVG/PvUcpIZnzYT4yhQsIsrtyvK+JT+2GMHmyWP9gOGUbmR/DI+BokbhjVIjKrVKyGVxDNiqwBm67nCqcAlMvEqstgZNVyHpyQTQERjBeUXhDCMosFjxphHYrOiVoGnR0pMslranNaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA0PR11MB7330.namprd11.prod.outlook.com (2603:10b6:208:436::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.49; Thu, 25 Apr
 2024 04:37:28 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::d610:9c43:6085:9e68%7]) with mapi id 15.20.7519.023; Thu, 25 Apr 2024
 04:37:28 +0000
Message-ID: <3135e3c2-9d29-427b-8e6b-c0b627c7890f@intel.com>
Date: Wed, 24 Apr 2024 21:37:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/16] selftests/resctrl: Cleanup bm_pid and ppid usage
 & limit scope
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, Babu Moger
	<babu.moger@amd.com>, =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?=
	<maciej.wieczor-retman@intel.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, <linux-kernel@vger.kernel.org>
References: <20240408163247.3224-1-ilpo.jarvinen@linux.intel.com>
 <20240408163247.3224-8-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20240408163247.3224-8-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0272.namprd03.prod.outlook.com
 (2603:10b6:303:b5::7) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA0PR11MB7330:EE_
X-MS-Office365-Filtering-Correlation-Id: fd07ff16-58d7-4a43-f9bb-08dc64e169cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dXJNWVJMMGlRRkFVUDYrUHhQbzArcHpOZHdpRnBhTzR0b3M1N2pQVzJFQ2J1?=
 =?utf-8?B?NEFrSHBXL0t6UzI3bC9hS2lRcUlIS3B1eFdDNk5BMXNCUTRkay9sUXdKYXFa?=
 =?utf-8?B?QWhNS3U5T3R4N1ZHekNxOUlVYlJJNC9jSXk4WjB3VDNTb2xWWnh2aGF2V25r?=
 =?utf-8?B?Y3dnMitwN1NRVllZbm1NNmQ0Z0FVVEZjWUZDMXpEYjF1b1JsU29lSDZQTDZt?=
 =?utf-8?B?OTNmUlJzM0d0N3lRQlQyOEthaVRROUczY1QxWWp1S0piaG91QTJ4STQxbE03?=
 =?utf-8?B?S1RaVitQZTI3d2VyNzZlQmJLdFpidEpLV0wvUU9XdHJ2QXZoMktwNUUrcHRk?=
 =?utf-8?B?WENQNEdWQ3gzbVhwN1drbm41WmdsS2VwbHEzODZXallZYUErU0pkKy9ja21C?=
 =?utf-8?B?N3FWbi83SzdlZjJ2eXJ3bkVpTDVLTDl5bFgxRXAvWHZHcVU5ck1vOHlpN25B?=
 =?utf-8?B?cXBFcUhZNktPMThNU3RsRGNPcTNOY2lGYkdJQjdVVzhtRVY3SCtOZlJxOGhs?=
 =?utf-8?B?YmEzSTVYT1RVYnZENGpoWTI1QVdvODRwMDNxSzNkbWdzRGV2RUJGR2h4Ylll?=
 =?utf-8?B?REg5VzZmZzJMZWF6MHVsWHNuOUNyanp0dVhZcTh2c2NsZXJyd1BLb05IQTdw?=
 =?utf-8?B?MDlqZGVuUHErcGpEOVE5TmNQQUNDcU5HWUdiNFFCQU5VVk4yZURxUDRyMkpV?=
 =?utf-8?B?bjdoQjZzTVdzMTU5TWhpQWRiSHRUc3AyQTFvd3MxTTMrRFI2d0NlaHpMczc1?=
 =?utf-8?B?djJMODBrcEo3MzJmYzA5QlJiTVE1MHJ0a2s4Q0ZVLzdJWVVtQTd0TEVYQzlG?=
 =?utf-8?B?WHR1U0pZUWlQUnZDNGU4Ky9QZGZFMk1NcDVRK3hvcHlMOGNXdExuVEhTalFY?=
 =?utf-8?B?Rk4xRGVGcGREdzZzYTNoZ2wyVlAxcWdkaFRuN1NyMlUzaTVYRWxDSFRjT3VW?=
 =?utf-8?B?K3NBZVA4R0R1cHVTc29tdVByQldSRDRMbXhNczUzdVNDQVBhdWxrcFpsUlFu?=
 =?utf-8?B?cDZNY2tvYk9KRUtVRVBSM2N3QjhOWGFERWhrTThaSE5SSjk4NkFqTW9PMmx5?=
 =?utf-8?B?RUgrQTZLdzN0Y0VySWhuNFQ5U1VFc2NDanFPMEJ6OUZOazJhT09BNnZmSWFs?=
 =?utf-8?B?NXVxb2dvejUwRlZydnQ5cGRRSy92ZXpTamhZSlBHbXJMREp1NWdhU0xYZDBE?=
 =?utf-8?B?Z2c0ZHErUGUza3gzNEQ0cDZlNmt3MlRQRVVNampibDRCODNrQmIyZFp1bDNQ?=
 =?utf-8?B?a1g3YVU1S05MemcxbWkrVnV3ZXdXU2RjcWtIVzdiNFd5TThESXo4U2ZPeTZa?=
 =?utf-8?B?V3BFb2ZjQXdrVnpoVFYxeS9ubUZNMFZDZkZES3VWZGlxY0kzbzNqa2FCNzhG?=
 =?utf-8?B?UjJKVXBSZDhoUGJ4dVRTUUlrNGJRenJnRHZKcmp4a09Lc1Jwc2dXUEdqazd1?=
 =?utf-8?B?NVg4OE9vcXlJMTZ2UzR2SHJzMWNVUUkvS25GK1lBS1JsVnVOb2dLbGtPMUhL?=
 =?utf-8?B?Z2VJNTdrVFVpSGIzVTVycnJVNlF0M2NwQTJTNVlwbGlZU0hxU1pVM1FNWW1J?=
 =?utf-8?B?c2NyVXFPbFlhdDZhOGpYUjJwdnNSd0ZYNlA2RWNTM2xYZy92ZmZOTkFjaTB3?=
 =?utf-8?B?QlJLNE1iSGpEWndINitIeE9CVXI2YkUrQVJZbkNnRHFaM1daMnh6NWdXRWdG?=
 =?utf-8?B?V2d5aHZFQXh5RGEwK045ZGhWMGRheTdYWDZEU0J6MnE2SHBsM1l6dERRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckc5Si8xR0R0VlVyek9GN0xUbmwxSHg4eWJZTlJxQncxTEorQ0NqeCtnTEJC?=
 =?utf-8?B?dG5NVmljMU05VWk1UkEvcU1neXdSQWNzejB5VDlHMUs2WUcrNXcweDhUS2d4?=
 =?utf-8?B?WCtUTHAzN1N0Wm1sZXRFWUcyemN4RHk4blRjZzNsK3cvdVc1RVBqN0ltdUk1?=
 =?utf-8?B?UjZJRmszdEljUjBrZ0syNG51R2Y1bXdBM0JUSjRxYm1ueEdGRnI4NnNPRVN6?=
 =?utf-8?B?SVpnTDJsNTBwN2FPWkFiTUg0S1JmZWV3aEY4YTNPK01lTFU1bFIwVmprRlpv?=
 =?utf-8?B?RDB5anBtdUFyK0VUTW5kMzFtUlRkMkJGb1hzSEdheGRhS29FZU0wc3NRU202?=
 =?utf-8?B?RW1qS0s1SmswZnlsSDRlTmhFMCs2ZzhTZ3ZDa0xaeDR0MXJJcUtuZUNNVFpj?=
 =?utf-8?B?M3R3bjZCL2NCd3BJU3ZwWmFxOU5Ed3crQTQycjlVSVBVWW13MGtjZlFvNlJE?=
 =?utf-8?B?WSt6bnQzNmJKelBFVzlKQ1NnK1RERldiZnVhaHl2d1RycXIxYkpFOFJ5djcy?=
 =?utf-8?B?d1RMYmJObEFwOUVhRzRMckpjWm5jbWN1LzZ6SkFieU1aRXZaKzk3Uk54d2wr?=
 =?utf-8?B?Z001dVRCamZ3RG1mR1J0bFlhN2t6WFRpNVZrY3N5Q3VRYU1jemtjbDF0QWNt?=
 =?utf-8?B?eUZLWHIwYXYyMTk0QXBXUDB5aEE0YjZ4Q09MUW1Jbmw3NFlPWG9HWW82NnVB?=
 =?utf-8?B?VWtMNXlTK1dtN0tjdVcraGRGN2lvWVRGQzRqV1RiWForMktja1pVRkR2Y3A5?=
 =?utf-8?B?aUFyOUdjVnljYnhDTnR5bnhnVWtYeU16Z2xaYXRwS1hQRjVvL2NxNnZ1ZnBF?=
 =?utf-8?B?dVhaSSt4eHZqNDhJR09xWkQxd1FDYzh2WUFFRG4vaGdEREZ4R3ZSN0hpT0FO?=
 =?utf-8?B?Sk9zSVNQbHZQRUlyOVYyMkpQN3Nmald1UHJyaW1CNkNXNFRQME5XSkwvTDV6?=
 =?utf-8?B?RmNFZ1FWcG15ZVFmaGZrLys5eEFLRmJ1MWRjYUovaUNBTlByUG9kU3VYNHB1?=
 =?utf-8?B?NFJDNDVDUDZjMndibGV0Z2RqVEpKaHhYM0pPeEVHdlNtMmlzVnRYUmxTSUFp?=
 =?utf-8?B?YlBDbWtkNCtqczdnUzA4Z2srUUJUNjNWSFdpV2lLbkNFcU1DbllraWhNMkhr?=
 =?utf-8?B?VFpLWjdHVlcvcUl5dGZiVnMyQjFGZGVDYy9Wa2tiSzBiOXo0ZkE2RG40bzJZ?=
 =?utf-8?B?Q3FHbkd2NVdOa0hqelA5VmNJemd4WFZidW03R1o0b0NtZ3J3R0JNRFV6VWRX?=
 =?utf-8?B?bXdoSkhHbmJLdWs0STFyNjFnMzRFM0tuT3N6S0NFN2o1MVdjSldveS9IdklO?=
 =?utf-8?B?Um1KRUJPcHZ6MlJsUU9MV1ZWa0tmUDBGaEhsRWIyK3QzOUZJOG55VUFNOFA4?=
 =?utf-8?B?Qi8xTnhUV3BHa1kwTlZGZThOK216c294SzlQa1NLZktzMjdnNE1BVlJIemlR?=
 =?utf-8?B?MjViQ0h3UXBJNlgrMDh4VHhEbTdPVE9RSXR1K2ZSOGFXTStOM1hZTi9TcC9u?=
 =?utf-8?B?WTcyOVJ6UkE1S0hMaTdmU1VaWTBwYjJmL0lUenh0S2hPMWlMa203RXgyWk5W?=
 =?utf-8?B?Y0IxZGU1VVhuTFhGTitWK1ppeWo3MXYyUkRYU1BSMXBweDRaUDI4K2FZZzls?=
 =?utf-8?B?T0praVBmYnZ1dTJLYW8ySmZpV244dDF1dmVKR1p4cjlqTXZ1bEY2OERpd0dk?=
 =?utf-8?B?WUdwaGlqWFBrMjRVWDR3MFFSTm82bWM5YzhXUWp1SURLYjhWcUFDeDlCWUVR?=
 =?utf-8?B?bEJGWUVKU0JoNjViUzQ1T0JvbHZxZGlOZ0hod09OMXBSUTdyR3NUTXIxYkNr?=
 =?utf-8?B?eUpDQUZqb0tyeVRDVElxZkFPMTROaEhBU3lzdHc5N0JwakR4MW0ray9rMS90?=
 =?utf-8?B?MXM5NnRCNWhrWklsNXQwZ3V2MEYwYTVOVXNVY3JQdU8yRXB0UGNZSVJNOVlo?=
 =?utf-8?B?aXRWMEM0Mk9nVTY3b0N2UHRWOUIyV0psRTAvR1lVc2oxMFZUeThOUTFHVFVv?=
 =?utf-8?B?bHF0TDA1WWxKdG5iZU1SN2NNY2tlYUdrYkd3VGFNL1hjUURTWEFtZ2pZZmpz?=
 =?utf-8?B?ZXRzVHhwdTY5T1BPRXAvbUdVRjJtWEVKa2V5MWtGUzJEVDAxOHV5a3J4Mkl2?=
 =?utf-8?B?U2M5ZjIxY1IyaSsxVXJ1ZWFPYnhhZzBVUm1RR0htbWNNaVByT0VhQ3FOVGRs?=
 =?utf-8?B?WlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fd07ff16-58d7-4a43-f9bb-08dc64e169cd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 04:37:28.6639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: snGJAlF7bKHjmcTq/PKzvzE86LFOl3kCLd8Zl6ZR2S0xBnEEI1Q2Cq32IJrjCAs5t/YMrEoja0esHL36LTyRkA62Qgzp2BILoBuFTG+a2kg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7330
X-OriginatorOrg: intel.com

Hi Ilpo,

On 4/8/2024 9:32 AM, Ilpo Järvinen wrote:
> 'bm_pid' and 'ppid' are global variables. As they are used by different
> processes and in signal handler, they cannot be entirely converted into
> local variables.
> 
> The scope of those variables can still be reduced into resctrl_val.c
> only. As PARENT_EXIT() macro is using 'ppid', make it a function in
> resctrl_val.c and pass ppid to it as an argument because it is easier
> to understand than using the global variable directly.
> 
> Pass 'bm_pid' into measure_val() instead of relying on the global
> variable which helps to make the call signatures of measure_val() and
> measure_llc_resctrl() more similar to each other.

nitpick: measure_val() -> measure_vals()  (two instances above and
also in the changelog of next patch)

> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Reinette

