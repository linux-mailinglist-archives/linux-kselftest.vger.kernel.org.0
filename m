Return-Path: <linux-kselftest+bounces-16828-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA161966667
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 18:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BCB81F265AD
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 16:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD251BAEEA;
	Fri, 30 Aug 2024 16:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LjUWfnrh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945341B8EAC;
	Fri, 30 Aug 2024 16:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725033673; cv=fail; b=Tw2twSuS452JnFD5FPDP5j4Qrt3a+YmDKo/b0YOLTurwa6B5C2oo3qXW7b3qUh4EyjnTnVpUZjjGrjPujb8u2aduC+QAc86/vL+A+Vm8By3DMi3DlaxHqjDtRg6wE5pTAO8OoutQl0wpdHT/lajRyQvBB4ZgYBimWyKpnIsDCug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725033673; c=relaxed/simple;
	bh=hbJ/SxQXamIoWpz1Phbw8R2uiaTVkbXItOyR8T8TCdo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XxEwDAyLPiJ/I1aiZbDKuV23rw5Fmf6xmWEkKIJDiJzweaVelIuwPfIh9S8mCnzjBlNJHke1hz5HxlRnfngnOsTE51bmf7JtmEeAzNEPzofz0mI5e2q3kKzI6lF0HsuD9RCwmeijcIOPDI8M1mgvOlf6UDBMj2vZy3fmbQdCnhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LjUWfnrh; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725033672; x=1756569672;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hbJ/SxQXamIoWpz1Phbw8R2uiaTVkbXItOyR8T8TCdo=;
  b=LjUWfnrhww2DknCbfcEH4cnft5vncQvdEc9dbqp1K1gQo4bNy4AzVawS
   /d5F64KU2jZqpmbJpSNdf2r88uOlyER2R37a1ymc2CIapaGzeIljSBCgr
   2nUxpXiq9oe/ljzlUV0oi7DRJex2Qf3AFXbnv20NlP5GQPtKwiN3Eo4mK
   IoMvT+w4zjC2DZlG7b8pOM+EzONiGzNSj3JIAk0V/N45o7EvXNpXpNuU+
   iMYgCA0H+4X+2BJjsrY4B2sPK69W20YYs0WaNO0E/w/YIyrRngPYH6eXf
   IpV+AxKGW5dmQbqAfedvbRHCYwpnLH2f5rpYBvAhlG8L5ew3Yt+PsSTyD
   g==;
X-CSE-ConnectionGUID: pcNWKmTpSiaMd0koKFwGYA==
X-CSE-MsgGUID: cPB1aLAuQ6WSw0c86Fm+mA==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="34254059"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="34254059"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 09:01:10 -0700
X-CSE-ConnectionGUID: b1avlIoGQ1esHAhkSo5xiw==
X-CSE-MsgGUID: 08Y1HePlRMO7UfQzGsGouA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="94673215"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Aug 2024 09:01:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 30 Aug 2024 09:01:09 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 30 Aug 2024 09:01:09 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 30 Aug 2024 09:01:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SrakEUAQM+6FUrArfKwTjEMKbjBhAYRHu7XxwDZ//MAk200s8MOUAob+tpMLUnUznrbqa0jRx7Ugk7Mn8foATrZ5QpVeRRjsqX2CzqbPkltZdwJz8EzpG3Hck/fIY7uT9KfYFJZtkc+vrJCS6iYzIa/Oa+m7oUIhs/UvDLma3O6nIzUo2f7SCZ+HRZpT11nuZEdPf6pVApa48FrbyT1CWMbM5IDaSsP/IX+smmZywlLrf0dEGBaVGBKTRL0R0BmrOVhrGRJObtFckONU9ETpWdzc8mxmYXFGr/Mo3eFwircT8QcQ/HnKvQ/xI6JOE5SdqMz/Plg92WVr5l7bXFAfjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HzrLq0G87lBSR+CmyKW8NSjMAJJHWDfLQs5ojospWOY=;
 b=Wea+0BOjdn1u7atFfWsZdNMRziz+JzQID5Up6bvF2XMFKNSgrDzaVBRIY/4OgAB9kUrbfpgBmMD/LfNW/uQ5cqkwjEHDjZgpmiay6Q6/FwwlCkU9oIsSfsN4bZWFPQ5OxDXwd9lYPpr2H9ERZzwL7See0Ph20n6zDPLT0rTzxTgzmftJLAOZF21U1YsZplscOU2Y43xfELVwPuq2siKi8K7F5hVSvQWzM7w9aeEYP6dq6Mu9hIt/zK94JPEljdlTrmE2wGBoLHP4WIdjS/pbsInffMTnBmdeGZHYYjNVmbpiMLmiNTP5SPhIGWMbK97P1US3EQbhySEasN319UbAag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW4PR11MB5934.namprd11.prod.outlook.com (2603:10b6:303:189::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 16:01:07 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7897.029; Fri, 30 Aug 2024
 16:01:07 +0000
Message-ID: <8f0fe5d7-d40a-4d04-ba19-3966505bd140@intel.com>
Date: Fri, 30 Aug 2024 09:01:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] selftests/resctrl: Simplify benchmark parameter
 passing
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <fenghua.yu@intel.com>, <shuah@kernel.org>, <tony.luck@intel.com>,
	<peternewman@google.com>, <babu.moger@amd.com>,
	=?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	<linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <cover.1724970211.git.reinette.chatre@intel.com>
 <fdedc12d44db62d85d1345e35a133983ed0af1ac.1724970211.git.reinette.chatre@intel.com>
 <da0741fa-463f-ca3c-0731-241f5c97dab3@linux.intel.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <da0741fa-463f-ca3c-0731-241f5c97dab3@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0289.namprd03.prod.outlook.com
 (2603:10b6:303:b5::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW4PR11MB5934:EE_
X-MS-Office365-Filtering-Correlation-Id: ae07b877-8833-4d84-3d60-08dcc90cf529
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1QraFFxTEFTUjFDNnM2WjNoeGQxVnd1MTJhRnNsMlhnMmZzL3U3b1hOaW9X?=
 =?utf-8?B?VkdmV0RDbHV1MDF1Y3YwV1Vwd1NuSjBjaWl0VlUwQ0gyOWF4bzFCUWFaMGcx?=
 =?utf-8?B?Ym8yeUJqK0s2VmpQMithNUJpZ2hhMk9OT2N3Qk44dld0bDFOUVQ0K3BnZDZx?=
 =?utf-8?B?ZjJnU2VxaVY2aGNJYnlzYnNMRkhHTXdPelFJU002alpPMmxhOUVnODlTY2I3?=
 =?utf-8?B?dWx3eDZEQ09EUjcrelRUNUpMNzdkZFhEOHlUZnRZdUpoUUpnUEVGUHZhL0dY?=
 =?utf-8?B?aHdNekFtcWlpY3owVWJsWXBTMjYrd0lZcjBNQXJqTU8rb1AyM2N3VlZqYmVY?=
 =?utf-8?B?cC9CNy9uVFBuNElDM2FsUlRuVzdaOVM1TjdQR3NqbDZMTVhlUTBMUERZSy9y?=
 =?utf-8?B?eTR4SHI2K2wyRlQyZ2pqZ3VsTHdXclVBNGlUV0krS1Y0TFhiRFcrUWRQZmJ0?=
 =?utf-8?B?aGFkdXZvRlVLMWcwTlFZbkVqdmVmWkpRdjMwUDAvRktEMFEySUV1dm5oREhM?=
 =?utf-8?B?M1IrOHBRYnAwbjFLZmJQUlFqUGtJMTh6RWkwK3Y0aWw3dHZJMkliNVBNWVR0?=
 =?utf-8?B?OXczOHlxL044SnU1VU9RV1FqUmpvVWN1SkNFSVprNm56Ly8wcithdlVRa1l2?=
 =?utf-8?B?My9VTmFyc3hhS2NndFpJK01FMGx1bTJLMjZXV2QzdlBLcVl0NXFLcWFIa2Mz?=
 =?utf-8?B?UFhRQ09VdURMRFcvTlBEdjd5NXUxZ3loV1lrU1hhcDhuU3l6dWJvMVVHdXJD?=
 =?utf-8?B?UnBOT0NVS0NCdDRmbm1sVzA1R2Q0RVZQRVB6RWd2eExubG9wR0dMcGkwV25k?=
 =?utf-8?B?andaZXN3VFhHWGtRZkhNR1h3TzBkcjk4aWUxZkNlUzNxNnZuUXJyQ2tPU00v?=
 =?utf-8?B?S0V3bEJCVzU5bWJZZjRCOEVaY1VMYmhwcTU2a3ZpbTM5NlFHV2Y3ZTgra0lO?=
 =?utf-8?B?K0FEeHZhTUlpZG1EbFpqT0s2dWthSk5Kd25acWN1aEp4ZHJwb1VGaG5mT0RL?=
 =?utf-8?B?M2xNNnlqSTdpa0hJUkxRcHN6aitUOXZVN0dBQ1NRZWtpbjBoOFZ0UEVzbDNp?=
 =?utf-8?B?UVRzdmRqY1ozRHBiQXAwNWNKRGxROW1rYVJSdHRML0J2VStTajBadzJWZWlL?=
 =?utf-8?B?MTNyMjVRQ0hpTjNUeWc2YkdRRlY3TUtkdFJ2SGFQWkdkSjFqcjFvd1dCdnN4?=
 =?utf-8?B?UzJFUnVEdjgybEtVOUJtMldvTm9DTkRkV2pOMm82dDdYVFUyeVdob1prV29h?=
 =?utf-8?B?VE5DMW9qZWZHaTdKNjk4eU8vM2pKemRSc0huYUlPaDJDUnZ2SXIzUUdaTmdR?=
 =?utf-8?B?eXNtTXF3MmxST2VHSCtqdlJYTG1nMldkcDhUbEt5cUJaYjNnMFUwbWk4d1dT?=
 =?utf-8?B?WHRKNXptYUJlR3FLSng5dWJIWnhBWXFoNjVackFUMXFsVUx3bGJNbFE1dk4z?=
 =?utf-8?B?UFErSE1SZVQzS1JUbU1TaUdFTHl1RFlLYTlLeDVGdGNhMW1LMk9GemRZblRJ?=
 =?utf-8?B?bW5QSDdoai9ZTnNnZ3NTZ3loK0U4S29lTk9nY2ZobkhCTlB4aVh6ajFGcjFO?=
 =?utf-8?B?Wk5aSStjTDBGdFBpNHFVNUdZQ1kreFZIMC83aUhVdnFsczVSZG1aMW9teis3?=
 =?utf-8?B?bk1lNFdKMmNHWEFBZ1ZQb2VmVlJRRzBJanV0MDN4aGR3ekcwMDltZ05JZnNI?=
 =?utf-8?B?ak5HenMzNkxhUHlVNElaS3A3TTBrZUhLUzBHOGNyZWk2WlBvK0hUbklyZEtj?=
 =?utf-8?B?NGp6NnY1SXNXQXFVMHFQdWJ1TDJhSVpsaUYxeHIydG04WCtaSlMzK1NtWXlh?=
 =?utf-8?B?bTlZc1NGcEhVcjlVWVpGQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RENwVXlETlRMNU13d3p1U1d5MnRZTWRXSlAyWWlrUkh1MlptWFd4cVgySkRZ?=
 =?utf-8?B?Rm1NKzRpaXdQMjc2YWdQRS9SYzVnVENSeUluSWcrVHhra0xZM3lPZUw3U1JS?=
 =?utf-8?B?SmFhZjROOWR0UUdYM1g3V0VQQ0dmRGtkUnV1ZnloaEthYjFSTW5COGZ1bVY1?=
 =?utf-8?B?K1pxNzhxb3czNFJ2RHVTUkFIa3VPUzNBa1JRVURwOXFBTjJ5bG05Q2dHYkNI?=
 =?utf-8?B?VVFPUmJEWmNEbkxSK3cyVjB1MVNoM0tOQU0xNjA1eGFMaTV3N3VJc1ZVQXhI?=
 =?utf-8?B?N0Uxd0ZncThuaCtLZ3ZTZ01pRmFZYnB3dWVLRnY3MTBVQ21GcW5mamtZNlF2?=
 =?utf-8?B?UjdxZEJhTktxeUpKejNnRS9GblQraWt1VDVzMW0zUHViMnhXTFFJV2dNVmJV?=
 =?utf-8?B?dlJnOEIxOFBOcTBBSzgyK2VJc0pSN0VjeWhLN2ZQd0hMekkwaXhZbzU0Zm53?=
 =?utf-8?B?R2xSL2lpancwUDZ0bVdOV3g3OFl3Nm9nN2M3eHhrc2pPakRuMzNRVXJ5ZDdn?=
 =?utf-8?B?MmZyejV4SmxUU2VWUUszYXZzNWF6UENWV2s4bHBIVVV0VkdxVzUxVksvdTdW?=
 =?utf-8?B?ZWdzeUlFaEFnVTgxeFFjdUtmQ0cxaENVNHlpaDBqYTFOa0w5OGFBWVo4Yjla?=
 =?utf-8?B?ZzhpVEh3Y1BCaUM2S2NDbzd3clI4eGR3Yjc0QXRRUzduZkxWZjBOWitra3Ey?=
 =?utf-8?B?RVkxZFpYejdwNU45a1p0c1RweHpNOXkwN0FOR1djR2tSQWFWNVBMMEFkMWV4?=
 =?utf-8?B?Z1ZSbjdDcHVhVCtpR2NHZy9WMHRqSlFmeVp0YWdBVzlhYXFQSEl4TkJXb0NR?=
 =?utf-8?B?MDV5SFBwMnk0cVZSWUtwaDBJZFpNcDNseWtHbGxhK1pxZ3ZOWWhJa3d1cSsz?=
 =?utf-8?B?K0tZcDd5V0JSeEhuaEdnYUZJOTdhRGlyQWwvQWUzaXh3SG5seHR6ZWJmMTVE?=
 =?utf-8?B?cThtRy82dFhBUGZ3UTlFNGhRdXlNU2NLSkcrWW1RMy9FWUNtKytTVWp0M0do?=
 =?utf-8?B?b2FhNTUwOVAvS3c2TGJKajlEMEFCb0lHZlNYbklkaWhma0owTDk0MnRCN083?=
 =?utf-8?B?VlljWFlhb0FwdjEvanFvTlh4dEtqbWtEZ1ljSHZMVE5oVzgwVkt0alExZkIv?=
 =?utf-8?B?UnJGNWlFUTgwQzlvc0hQNEJIWVZMa1hXN2hRQytpK09LSTZzZG05MCtsVGp4?=
 =?utf-8?B?NHVmSVdkWmdsZTBHTURCZ1JKY1pLQ1NkR2xFMGozWUZxTkdyL290dzNSYjdp?=
 =?utf-8?B?RW5ydnFBZEZMeU5KbEpGS0xJSGlEbHhjZUtNQUFFNWx1K1g3ODNVRTN3WEFQ?=
 =?utf-8?B?OVpKditPQWNVNFVpQVI2NGJ6cHFXekpETFcrYkFITW5GamU2RytJbVV4MnRx?=
 =?utf-8?B?Y3l3UUFXaG9RR2haRHhRQU1IUVF5MHZxTUF3M2k2RUV4K0s3MTMyVFFQenp0?=
 =?utf-8?B?M0phRGEvbGRvOVFLdHhRSnFkcjlOZlRDV3owb2ZkMklzQnJGMGRadUt2emEr?=
 =?utf-8?B?ZkIyYWJBRmVBVEpWRk9oTC8xVGs1VTdJeXQ2NGVlclcxbVNxdWh5T2NnQUxu?=
 =?utf-8?B?R0lWVi9EdUg0TVFmUnBhUUlzSHg3NjdyWXVBSDN0bXpkbnhVTnNTcEJITUh6?=
 =?utf-8?B?d2JwcXJEMi9haFFJMWxMbjd0bTNGTFhFU1hJNVI0N0l3QW9GRlJMZGNDSFFI?=
 =?utf-8?B?NXhKd0tjRXpFeEhtekhObGM3bWdTT3ZBNlE0YnBjWm11aWFZZnRidm1NU2NO?=
 =?utf-8?B?cHoxYmtaQkM4cTFxUUx3TEgxMnlIZExSaUhLc0QwOWdZaWJ6LzhGN0pEMDdQ?=
 =?utf-8?B?bHEyemFmd0l0aHg2OXB6cXhpalpiaG4xZjJQZGR3YjRURmtWeUlaTXZDdXNE?=
 =?utf-8?B?OUFBMVN6d1Vpak1MVFU2azRMRVFyU3dMT0lVbTdhbjNHZEExWk5wYnlIL2tx?=
 =?utf-8?B?SisrcXlhL3ZjMlV0R21sZ3dXZXRYZGh6UzZlZTZCeHlCNy8zdHMxZlNEZ2NS?=
 =?utf-8?B?M0FtRXU0VDduSllLY0hTZjhUK0NRZkNPWU9ickRnSG0zQTVzeTNMM3ZYZzRL?=
 =?utf-8?B?RjhiWkNyQkQrK1UvZWNKM3YvbWtCbVIxYjdWZGtCaXA5YTZJajhud091Wmh6?=
 =?utf-8?B?c1V0KzF4THk2NnNWYTBqYjErdFhFaExwL0R6TytBRWg3UVFoRWFxOElWcHVo?=
 =?utf-8?B?cGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae07b877-8833-4d84-3d60-08dcc90cf529
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 16:01:07.0772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rp1dtD/bzJUHEn3mANHWI0IqLDfiTjBIhcYIZBO82eR0Okih4JrfvcTgjubLDViO+5FlFzxJhuJuasAllOWLYpoI4jnYYRD/9SStEyvgCOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5934
X-OriginatorOrg: intel.com

Hi Ilpo,

On 8/30/24 4:13 AM, Ilpo Järvinen wrote:
> On Thu, 29 Aug 2024, Reinette Chatre wrote:
> 
>> The benchmark used during the CMT, MBM, and MBA tests can be provided by
>> the user via (-b) parameter to the tests, if not provided the default
>> "fill_buf" benchmark is used.
>>
>> The "fill_buf" benchmark requires parameters and these are managed as
>> an array of strings.
>>
>> Using an array of strings to manage the "fill_buf" parameters is
>> complex because it requires transformations to/from strings at every
>> producer and consumer. This is made worse for the individual tests
>> where the default benchmark parameters values may not be appropriate and
>> additional data wrangling is required. For example, the CMT test
>> duplicates the entire array of strings in order to replace one of
>> the parameters.
>>
>> Replace the "array of strings" parameters used for "fill_buf" with a
>> struct that contains the "fill_buf" parameters that can be used directly
>> without transformations to/from strings. Make these parameters
>> part of the parameters associated with each test so that each test can
>> set benchmark parameters that are appropriate for it.
>>
>> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
>> ---

...

> 
> If I didn't miss anything important, this change takes away the ability to
> alter fill_buf's parameters using -b option which to me felt the most
> useful way to use that parameter. The current code of course was lacks
> many safeguards for that case but still felt an useful feature.

hmmm ... thank you for pointing this out. I did not consider this use case.
I have never received feedback on how these tests are used  and
if folks even use "-b", for "fill_buf" parameter changes or something else.

> 
> I suggest that while parsing -b parameter, check if it starts with
> "fill_buf", and if it does, parse the argument into fill_buf_param in
> user_params which will override the default fill_buf parameters.
> 
> While parsing, adding new sanity checks wouldn't be a bad idea.
> 
> It might be some parameters might be better to be overridden always by the
> tests, e.g. "once" but specifying "operation" (W instead or R) or
> "buf_size" seems okay use cases to me.
> 

Will do. Thank you for the suggestion.

Reinette


