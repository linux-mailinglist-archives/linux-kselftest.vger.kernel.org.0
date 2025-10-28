Return-Path: <linux-kselftest+bounces-44183-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A820DC15020
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 14:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99D351AA4B3D
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 13:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADE82376FD;
	Tue, 28 Oct 2025 13:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BxA5Qo0Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE601E1A33;
	Tue, 28 Oct 2025 13:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761659899; cv=fail; b=tmWkh2chVjDxYjxm/dEygDRphMN7c30uQBSYydpHMi+7Tn5zXEaaSbydQPxLpY+QVx81ipVm3AlPErPdAubD5rlOAsOFMCrdonEnxff93Z/PRbQFvDWShDiI4H/e58ryrx78MBBZezPzjcIzDh2rKhP4oPSBd8dHXULvnreKTFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761659899; c=relaxed/simple;
	bh=B/NpB/VyiXjNTBiyamXvx1jVA2ZDWpspB15ewT4l+LQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YspYy2V1/skZQtdlb8YOPEkxuyve2reuR2iWtSI2BzzxQITeqqlTX4s9dB4uCYj5iZbQmSQ8rfhxLpM4bsWyEJRa43slqE7lshWJj/e5JVGhi8h182sRhaLcpyLhZpINxVsQpEbJgc5oau36q05Xwh8YCftZtQka7Ay2LXXY/OA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BxA5Qo0Q; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761659897; x=1793195897;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=B/NpB/VyiXjNTBiyamXvx1jVA2ZDWpspB15ewT4l+LQ=;
  b=BxA5Qo0Q3R3dyQ/WqNT2e29Bj/Tih8uzcSOjgX8VBuYdUpO4TKrkUvhK
   hUP4tK5UamVYcAr/U3+lWAbyXipNQSTkkSkuY6ghjfHPPEsN5l8TNkBvC
   +kbqZ6cRdW4GGcTiNi18l6dgc8JdeQX0erDUc9xd7nN3/lkqZF3sx6Y3O
   wC7FR6S+2gWj58A/sLA7uZ3e6nnSfbmsf7BduRDX9fgaxxHjznqQSlyW0
   Q91yO3w7oCS0oNpLpEs3iEPYC1pZXzO7bdjNQaJdzQFvJY6gNG5PEuz0J
   egCT/UgnKsBBSMQWR8AryyCJNxT2MLmp1jZ3q0o1qOv7HJ6Uprt0bOp/R
   g==;
X-CSE-ConnectionGUID: G15peV90RuuBn8v5nE2URw==
X-CSE-MsgGUID: kIyW1qCMRj6xT7S+f/yZQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62964019"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="62964019"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 06:58:16 -0700
X-CSE-ConnectionGUID: 7WmipuT5QSGn+RvWyTpZBg==
X-CSE-MsgGUID: agA/kxJVTZa+GqQT4NBbRw==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 06:58:16 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 06:58:15 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 28 Oct 2025 06:58:15 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.58) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 06:58:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RkdEJtbwLJzFkCYpqDeSDelBsBaid3Cs6xH+I8wq4t3LjlY0WNSXVvevGiXEyz3GyEe9NaJsKcUJZjLGH6g8FCDz3y7QgaMsBaQWg169jtk0poYgorwJv6O85xcqQD60WmZmlefhQ1y1HVGVU3Mhuyk3MYHtrhWlqNh7F0hGmegBqWgx9TRdCkJDcGg5bh4PbNrd4jjEQD7p02xryWHGNrZbPR1fzzHF0ZtneK+M42132qyLQodn0aNyYgahwmm9if/c3vpGKSaUZGuf38O3aS1c0C6vYCel7heCT2FC5hSrvGqSe/fmeo7YSQjCnA6DyjnWEu4TGat/efebBVFunQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xvnyn5hAOJpHnSz8i3Lnnfnu9U0KiBpXVpX6AZJsJ1Y=;
 b=hGomlaiOVBp2RLLoFvCwnwENnsRmQkaoFx9aOgMNbl8pEZO6EJw62qRVXfdDhQQux3tBIQud0e459kIfmePzTZLhH4UVNAF4K9VhhNFQvSoVtJVsZNZ5id+IRxttdGL/o2aExVrChOoxwJ2IPFAIlV60c7GpSztpqat18T/fkgxYQiA5h7w73chPo0Ffq0UjZisVjnixIXDBhUY9+Hrql/PnUZQf9hJFrBXZ6+Ii2+s5i+PkDiG9dMDPpGTiL3m8r20YDhh59dAXuZ832+HXImntBH6GFXhIF9+n3PMCb+yyjPfws9i8cwAtyaC2NQca8kLPKc0dEOybY89eKqIgAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DM4PR11MB6192.namprd11.prod.outlook.com (2603:10b6:8:a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 13:58:13 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.9253.018; Tue, 28 Oct 2025
 13:58:13 +0000
Message-ID: <010a2743-b732-4e4f-b877-fed340ab3b8f@intel.com>
Date: Tue, 28 Oct 2025 14:58:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] selftests: net: use BASH for bareudp testing
To: <shuah@kernel.org>, Po-Hsu Lin <po-hsu.lin@canonical.com>,
	<linux-kselftest@vger.kernel.org>, <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <edoardo.canepa@canonical.com>,
	<linux-kernel@vger.kernel.org>
References: <20251027095710.2036108-1-po-hsu.lin@canonical.com>
 <20251027095710.2036108-2-po-hsu.lin@canonical.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20251027095710.2036108-2-po-hsu.lin@canonical.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZP191CA0011.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::9) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DM4PR11MB6192:EE_
X-MS-Office365-Filtering-Correlation-Id: c10ddf8e-2af6-472f-3b41-08de162a094b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MkQ3d0VIMWFvOHdUYmpzYkxQRk45ZHpzcnlHbVVDYjZJU3V3WGI3SmN6UG5j?=
 =?utf-8?B?dnkxZFZIS3lzU3c3WnZ6dEFPVGliVGxocTllMTgrcUpseDFYOGMzcVMwUEdV?=
 =?utf-8?B?VjJNN1dtZUFOSjJLaVpLNVo5ZUZkc1U4RlMyd0FRbno3RU1SUGFwa3E3OHRS?=
 =?utf-8?B?d3VpOVBWMndISkxmWFJOSFpya2lDOWpFVG9vVHV6QXhtcFB3SU1DTXVmLzJD?=
 =?utf-8?B?M1R2UmZmdDd4aFdCRjlIUGlucFdNNER5VlhWaFBJWkl6UnQwNFAvbUJqeXEw?=
 =?utf-8?B?aUpwMDFoblVMRU9aalYyTjlTbkh2aXJrRllVNEVPeit4SUFQNEdGWi9OalRS?=
 =?utf-8?B?dFJVUmVQQkpsclhKTE9xS3kyS2dBWXkwYmN2dTZLTnBLQnhId2pmeHdISExE?=
 =?utf-8?B?QkZqNEJkVk56SlZ2bkxZVkN4OFhCZnFQOVpxOFVQY2o0aGNKWmlydkpWSExF?=
 =?utf-8?B?cFVPQ3hobEV6NnpOU2F2Z3d6eTVnTVZnNUYrZkM2bURvMjJTYWYzSkdPNnhi?=
 =?utf-8?B?WDlUMDhvaXJrRVo5SzdqQXR6QVpBTCt5YVFoVWpUUVl2MGNYUTRVNFNBZCtS?=
 =?utf-8?B?TkNuWDRwMWJ5VVZHMVBKOEFJc3F6SHlFV3RqWTNLNzVBeXQxN3MvbXRuYlVV?=
 =?utf-8?B?RTg0UDkrRjlzK0E1eTFGS0ZCbGdXUUNFcjdFTll5dzFaR3Rvbk9kblBPV3NY?=
 =?utf-8?B?TDNtMVdHSXJqOGNMSHlyRlo1eFZnYTlKMEI5aml0WENrbnlJVU9BdU95VkNj?=
 =?utf-8?B?TVl1TFJkR25vZ0JPbFErYjNBbVpQVGpYMHpJOERCSGVFQXZmYnJsYUxPUFRO?=
 =?utf-8?B?ZFJWWWJkei8ya01QaWxWSXcwTzUyTnJaZzlTMi80TkVHQ1lOcFRCak00YUFx?=
 =?utf-8?B?c2dCVUlCUUhaQkV0ZDgycEVvVXZOR2RDZE5qM0M0Nk1pVTdHSUdWejV3Tzhv?=
 =?utf-8?B?VUF6L1JnWEdMMkNZcE5Vd2NkaFd5TWVncjJBRUtRWUs3ZE10b1E4N0t6cUtV?=
 =?utf-8?B?LzFRN1hoSmFnbTZ0Mk4yRXRpbVpiMjdyRTJ3ZGFkWnkweTl2Y0tDNSthQ0Ra?=
 =?utf-8?B?WXJKUGRzSUVOR0RFdU95M3ozZkRsakpmOGNUQlA3bnJIVjR5TzFrd2RlaVFv?=
 =?utf-8?B?RDZFYW5kdlVQT3o5MGtzY1hiQzY2ekFVT09rZHhpTkU3R1diNHRUVk1HQ0ow?=
 =?utf-8?B?SDh1eE5peXpxL1lCWTExK3pic2JQcmVpZWZKalhNY1ROandkNnk4YzNyQnJw?=
 =?utf-8?B?TTF0RXhUQ1RjbE1RUFJ2UkRoT2JSNkVqVHJvRUtIL1pHcTI0b29td2NTQzR0?=
 =?utf-8?B?M2hZajdkVXpiU2RmLzRSNlpncGRvT2ZLayswVUlldGpRN2Fnc1F1YWdkMUt1?=
 =?utf-8?B?U0FRd2tzQnc4dHFabjZTb0pPK1N0Tk12bHU0SVBrN0tjRnFQNldhZ05NaWdL?=
 =?utf-8?B?ODUyYnl5dVZ2dEdFcEtrWGdGNnZpM0VFQ0FQK2VJcHBQd2hJN0dNamU0ZEVB?=
 =?utf-8?B?SGlxZDBYTmp2NnZTZFVkcXhxbktUb1ZHTGtzdXEzbExkb2N3WUhsWVBlb21w?=
 =?utf-8?B?aXVCMTdmZVNFbGxCeFQveUdreDVQNlVlbmk5R216M05UTE5oSFRVR1JVV1BH?=
 =?utf-8?B?QUpHTW5vWVlCTlI2VlREczFXemlUTjVDR2pCTFFyNDFiWkR1T3Q1T3hMNmZ4?=
 =?utf-8?B?NEhqVERHSDVYZUM5TE9lbi83N0psS1lWS0pHWDBqMzdFcWxMTEVzdHFCY3ps?=
 =?utf-8?B?cEpCLzllWnBUMlRNSVBRZUNXMEkyQ0R4SGJBMkk5VlBIT0FIV2pGWnV0T2VX?=
 =?utf-8?B?Wlh2enRobEpoLzA0aGdiM3R6NVNVdGorRjJGcGt6cnRVWFgzTDF0cDgxZHJJ?=
 =?utf-8?B?ZGJyMjRNc1dOM0dDN1NSdXk0eml0K2RpWmpGZTJPK0x6TEE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmVxeWlXdjJhVnZhZmZDSkpGRXZ3WkNrRlFXNVNZOHRRMzh4T1ZlRFZJeWNt?=
 =?utf-8?B?YmJwZE9HQmU3SEd4cGtTRXEwVDhhOWsxbmNzYklkZHlqeFhZZDhKNVk5aHU2?=
 =?utf-8?B?TjlMUWZGNERvdjBDamxHelVBTkJESFlaVUFydjEwa3Nmakc2UDdkOVNrZjN4?=
 =?utf-8?B?TG1pNHArYjArdTR6REJtN0YvMFJuUGhGNDlaYzN5SlAvc2pPOGpLSkl4WDZj?=
 =?utf-8?B?QWp0YUZIVjhST2tXbHUvdG1yYWh5c0QxY3VlWXdCVFJ4OGpZV2xtVk1iakFp?=
 =?utf-8?B?UjU2U0IzSXl6cEE0eXkzT3FXekd6UnJJUnF1MHlhSkVXREJFR0lXdzRza0Y1?=
 =?utf-8?B?eGpQcnp1RHI0RUN5b0FHaC9wdHN5L0pweExzRm1FbW9XeDdlUVJHVmtNNTdX?=
 =?utf-8?B?L3puanUyZGNobUQ0TkhsV0U4QThUNjdyNkR4WjdkWWpwaEdCSGF0TEprM0Q3?=
 =?utf-8?B?UHYwL1FCVUhKdmdqaDVzVUpWNzBWbThnL2x2cG81cGFWODFPWFBJbWhZcHpt?=
 =?utf-8?B?Ly9ZUkxYbllEdjQ0azlTNnFITTNjeWpBZU4wZmRsVmZaRFVVbHJ4Y282cW11?=
 =?utf-8?B?bVQwczEvdkw4bGJab0ZhOUMyd2hxdVd0d1ExVDJ5R0ExMXByZVYrTC9veTAz?=
 =?utf-8?B?Mk4ra2dsTktab2o1V2cxL00wdmVTZGFNUWxsOTJyZ1pPcnBqdS9vNzZPNmlU?=
 =?utf-8?B?QWhYUVlyS2NqOEV0QzV2RnFURXNaZ0NoR1BveDVqNHJqdVpma3l0TGUxWFcy?=
 =?utf-8?B?OXIwYmtvc0w3Q0pmZTZTT3d5MnZacFpiNlVuUlN3S0R0NnluaWpHaXNrSEdy?=
 =?utf-8?B?Z1I1WTI3TVJwZnRZdlh1NUlsc000V09jL04yNDhjdyswOUpNRHJhcDJ6QzBU?=
 =?utf-8?B?Tnp3a09OVk5CK05sdU5YSFVROXhxT0Rmc1BCYjNJQysxQnJtVnNXaENvenp5?=
 =?utf-8?B?eDBEdlc2WlowSXd1WDB1N3lEVVZQeXJvQ1VrUE9ONy9kZ0kxaGg3RXpKQ0VI?=
 =?utf-8?B?UmFPWWhDM0FETFJPTU4zd09hMHhnZ1ZMYW5oSUh5VG5Hb25oVmZmL1lITURR?=
 =?utf-8?B?R1ZKeDVLWGRrYk8vL1RLRm5TQ1BYSkludGNkY1NXQjZxMUdIeVJ6bkxkaXp5?=
 =?utf-8?B?dFNqVWlCMDFoWmtHekJsRWh4UzU0SEdmVGJLVkUwQlFSa0gwRDZEcUlXRlpG?=
 =?utf-8?B?dURISGtaWnZWVjBodUl2RENRS2R1L3N3UmpNNzAxSFVYZ1pWaFFSZmVObWYy?=
 =?utf-8?B?Q1ZiMTYyWXozN2J5Q3BIWktwNEt2ZW1zRkVld283RmlwN1pCZGw5a1A1RFND?=
 =?utf-8?B?OFhZWVpNUFk2bEwvdytXS3gvQ1FZcnV5YURRUUl5ZFV6blB0UFZ3ekhSOUpS?=
 =?utf-8?B?ZkZScGVGN3RzdzVNd3FmWlk3OHlXeDcyVjN0NEt1OVJ4RDNWR0xkbTF5SlAz?=
 =?utf-8?B?MERsNnFVUjZxTDNRNHBEaHRLTXFjd1lhNlhHcmdzbGJSTkcrS3RSdE5SSnZF?=
 =?utf-8?B?WTB2M0ZzejcyQ0lneW55NEVXUSs5TnZxTWFKZ2RmUmtxZmJsRFZjUlNpempz?=
 =?utf-8?B?MU1iK1hjT0VESk1IVmIrOXBZRER6WlBTd0IzMDJrZG1NVTA5ZlJmVnN5OHM0?=
 =?utf-8?B?OWRVTTZvNUZxTFN4VjI0OG5zTG1xbUdyd0FwTmpVZFYraU15QzJuVkVnMUxD?=
 =?utf-8?B?L003ZE10bU5wUDE2Z3JERjNPL2dReXFTM3ViM05nSUZBanc5L1Y1b1owZ3VC?=
 =?utf-8?B?T3JqNUxjN1lpOXBwbDZkMzRobTZqL1JvWDlMcGllbTVZN1BIcEtKekk2T2Zs?=
 =?utf-8?B?UG5ML0RkRjFOeHdpanJOTnF5NDREK1B6OEw0eS9ubFpob3ZITHRzdllXQjZo?=
 =?utf-8?B?WVZyQjZiOGtLeDh2VHpFeGNUTmdQcmJxOW15b2F3R0tYNXhrdE12YnVGK1ov?=
 =?utf-8?B?N3lIT29SZGFKYXdLYkp2WnNMNnVmZy9lNUthdHlnRW1VcnJPd3NxQUIzNjlm?=
 =?utf-8?B?MTBQZ25KMXM2dkVORExJMlpncG85VCtmSFlhKzNPR29xMjJUSUhsNEQ2dGZU?=
 =?utf-8?B?SzhWZlFUeWc2VE0zY0JKVmlVYXJaemlVenkvR251WHM2STlpcWdhcmUzcVRv?=
 =?utf-8?B?MW5TRXM2TGFJcEhNa2EyTUE4aDQ2YlZCWWYvNWZzRFdyQmhOeGM0OVQ2bVo4?=
 =?utf-8?B?N2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c10ddf8e-2af6-472f-3b41-08de162a094b
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 13:58:13.5833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zmONnlh3qlAYIShJqezLp5s7LYuHtBo/P4b1PT7OIidCIe9xgzEE3SD8/XkorYKymf0RHbB2Bo3k24/HfbxeRO2VZWCvxv61Zdh1gaTCILI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6192
X-OriginatorOrg: intel.com

On 10/27/25 10:57, Po-Hsu Lin wrote:
> In bareudp.sh, this script uses /bin/sh and it will load another lib.sh
> BASH script at the very beginning.
> 
> But on some operating systems like Ubuntu, /bin/sh is actually pointed to
> DASH, thus it will try to run BASH commands with DASH and consequently
> leads to syntax issues:
>    # ./bareudp.sh: 4: ./lib.sh: Bad substitution
>    # ./bareudp.sh: 5: ./lib.sh: source: not found
>    # ./bareudp.sh: 24: ./lib.sh: Syntax error: "(" unexpected
> 
> Fix this by explicitly using BASH for bareudp.sh. This fixes test
> execution failures on systems where /bin/sh is not BASH.
> 
> Reported-by: Edoardo Canepa <edoardo.canepa@canonical.com>
> Link: https://bugs.launchpad.net/bugs/2129812
> Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
> ---
>   tools/testing/selftests/net/bareudp.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/bareudp.sh b/tools/testing/selftests/net/bareudp.sh
> index 4046131e7888..d9e5b967f815 100755
> --- a/tools/testing/selftests/net/bareudp.sh
> +++ b/tools/testing/selftests/net/bareudp.sh
> @@ -1,4 +1,4 @@
> -#!/bin/sh
> +#!/bin/bash
>   # SPDX-License-Identifier: GPL-2.0
>   
>   # Test various bareudp tunnel configurations.

this is of course a correct fix,
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

what about extending checkpatch to avoid such issues in the future?
I remember at least a few such cases fixes, and I don't pay that much
attention

