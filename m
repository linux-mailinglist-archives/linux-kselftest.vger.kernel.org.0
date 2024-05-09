Return-Path: <linux-kselftest+bounces-9898-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0F78C181B
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 23:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B318F1C210CE
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 21:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B86084D08;
	Thu,  9 May 2024 21:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BN+24Cnf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D552770E0;
	Thu,  9 May 2024 21:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715289020; cv=fail; b=kA7lN8xmtnOXoqk3KiObHeMAayzM9L/3ARLcN9FXe/180sD7pmShoiJBIlzSF5cg95g1un06c+lvSohQO4aTG7umxWEe0JvD59iZf2kiZ0r3xUr+SeUwPHM9ATpz0xP+QA1t7XqmuhrCVGnSKsMtC12ZW9BVhKljH1BOv02U8C8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715289020; c=relaxed/simple;
	bh=KAdmhCUeT2KfooVdg6/UA4B02MMO5qa3b9QhVKDINng=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lJHVS+7Q/BWIT3r20rbuuDBZOizx2O+Q970KLT9HrOfxNJ3vBadw5DI1Xs3a0Oidpn4ySb6tXREd0JFNzPp7E3eUAT6IutZ2SSA9fa/TPkTBQQ4w5tZRWkXeFKzbVlF+11gwzphvnzavLoTTUa2CYLyWkZVpbIK3h+V0JR2JyHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BN+24Cnf; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715289019; x=1746825019;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KAdmhCUeT2KfooVdg6/UA4B02MMO5qa3b9QhVKDINng=;
  b=BN+24CnfIL5Li3VGNmKGC5+8NPqRjwKabERaoY3pGS49OjmWhAjWl6OJ
   +chNum1kv/uzznSmrf+jN7FmNA9xvjeJsBqPgMMEP8IADFoPz7ZyPxu8H
   zVrinzAxCsckOPu7RpK+zmpkR/cJF2WaPRQsQyGe5+oTVq61xaJV9y4K/
   OzcrMU3udc2GrLq85Nek2lElLLv44fQ0bIqexV7BP6UgRVfSNM0BmGNM/
   fjsxHTu4mz+IcogMSk6Ddy4GVUbIN3AUZc4oh6Jlg6xA5cWXmBFvA61qc
   Q6nvCeg5j+69vdj75IacSVu6GxwztmwpdZgVhnePimcC9U1hG5/P34y5f
   w==;
X-CSE-ConnectionGUID: pkEJM5a5Rw+mBsfrh9hEVQ==
X-CSE-MsgGUID: d4OBHaOJR/ePIF3KFdidrw==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11083901"
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="11083901"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 14:10:19 -0700
X-CSE-ConnectionGUID: 8iY3PLq0S4C+Y+AeRN0HEw==
X-CSE-MsgGUID: VG/D1SdhTTeliOkoCQQVsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="66822420"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 May 2024 14:10:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 May 2024 14:10:17 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 9 May 2024 14:10:17 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 9 May 2024 14:10:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RV0lyJBusPqP9G7KZR+mE5VInUWd2PnH4xv5/yl2aoCoJdPhkYyxXvgV9Oimw2ZD0fjOJD7zhijrVLL31jgDRg92pZ6MOiaSZHjl2Ibl9Xen34DBZGXZ9Y4dSR8UcoTA5qNhPEIpxRWkzqxRzSald1ULtfNtiSAh1A+wfWyTa13vwqvOzb8Md9xgzQl7dN73vKpbzOhEfQxsgQ7T9RjfXjRy0fKFUlKe85RIDmpcPM0svVNjxrlS1FRVKSo8HrHOYbYgr5xDgc21vbv2GFDoul80+bWksNLouSNLT0JTkkfv42OP1BHlu0p4iO2z49jP4623uXCXMuHPNpTfMkzpTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8jvyrUX7tzGE5xW9YH0afmBPXshfLci2+t0djdqUeA=;
 b=Mr94gKWnaVcS75w3f7WILqwhMBGJeJMr2fxdYbUWVZE9D7hBr+16rvhmvTCmvnrpx0KNZFV5Hsk3KF3sVWP4Wc9PXc8qfT3v4V8WiJLVk6yD3a0hdfcZ4QF5lb0hzNb93ohuMIGSLXE4GPQByRHqfhgvgiCmdNvbZI4f8gRYWDGvJllDf8/iFmdFUyWHU+Qw50h1g7pGtPUb8t9Lj7sLmmljWcHE7Iqj/kBeuwokNG3FgKscgsWqh5tBy/qWjBRXuw2KbqtDDwB8wrl5d4xSixujT9TjQQC3gtU45VH0hvOPZuQzV+pgQbz9RHtLM2yCkPM4WDaQ7kiCgHXyFZQFqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BY1PR11MB8008.namprd11.prod.outlook.com (2603:10b6:a03:534::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Thu, 9 May
 2024 21:10:13 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::b394:287f:b57e:2519%4]) with mapi id 15.20.7544.046; Thu, 9 May 2024
 21:10:12 +0000
Message-ID: <a1eaca6a-ed3d-4bc2-a5e8-5c43bbef49dd@intel.com>
Date: Thu, 9 May 2024 14:10:09 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] selftests/resctrl: Enable MBM and MBA tests on AMD
To: Babu Moger <babu.moger@amd.com>, <fenghua.yu@intel.com>,
	<shuah@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <maciej.wieczor-retman@intel.com>,
	<peternewman@google.com>, <eranian@google.com>
References: <cover.1708637563.git.babu.moger@amd.com>
 <cover.1714073751.git.babu.moger@amd.com>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <cover.1714073751.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0228.namprd04.prod.outlook.com
 (2603:10b6:303:87::23) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BY1PR11MB8008:EE_
X-MS-Office365-Filtering-Correlation-Id: 84edc3f7-ef34-4c47-0334-08dc706c6a2c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RzhaTkc1M1NhMG5vaGllRHlEMWk2ZVJQbEtpUEFXK2hxcUVTejNERjlDSnFO?=
 =?utf-8?B?R0kxTG12ZVNJbVVma2ovd21VcndVaUg1Q3lveG9Pdmk5UVB5Wkg1Nkw1UW9J?=
 =?utf-8?B?M1lqbWlQYmJZa24yK1ZSTzhUS0F3bXUvaUk2ekU0ZDFLMlhIdmh3OXFRNjhD?=
 =?utf-8?B?Z1VNUnB0Zk5RVGhYVjVWWGRFZUgyWkQ1YUs3RFliRFROMzBuMFppZnBFbnZN?=
 =?utf-8?B?YkZzSndiekg0SDRTNUhVaGIwbmdBR2c4OEw2WmluelIyVHJnc2x0dWFWc0tw?=
 =?utf-8?B?VDhRWkROSGF3S1pObThxY3Y3Unpqak5Zb042T2ROWmFRbndTZ2htMFkydzFp?=
 =?utf-8?B?ZTRadVhPb2s0Wk5ZL3hBcHNndjVJSlJ5c3NiSTJWWk1XaU1JZU5VUGVTSlR3?=
 =?utf-8?B?aWlnU0hKWjRZYmI0djJvM3huUXN4NWQ0YmhoUUNGQ3FOLzg5enZlV0hWd09m?=
 =?utf-8?B?OXVWWkFSNy9nSHduZlEranExRUNiNkc3VzNXVWhIUXF3aUNqOXJBK2lKMFlk?=
 =?utf-8?B?aUlHUWJMOEdraWJINTRrSEp5N1NMakpIOVhXekNqa0g1R2svaWlZajVLZUxy?=
 =?utf-8?B?YzQ4QnZUaklHU05zRDdFbHlNWWxFM0xHZXRyN1dYSllHZG83S1V6bUhwdmZD?=
 =?utf-8?B?SUJwak0wSiswb1JVM3dpaENwRTNMVVd4Smo5ZUlVcUtIK1Fvd2JjWlJneDNq?=
 =?utf-8?B?a2NXNjkrUVJwN2s4OWIrMDRBSFVXUE9peDVFKzRQMktMSVZVbllGRUFuVkVy?=
 =?utf-8?B?QkRUMU5BUVFWQ25xMXlPUjZLRnZibi9UWS9nUFVmZjFrbk52emJ3WFdhZ0xh?=
 =?utf-8?B?Q0lXMmlINWF2MWgvbDgwUDIvdzBRRnZIOEVDb2xWeEZOT1pLUGttb3YwYURD?=
 =?utf-8?B?WVRIZU9NcUx0SWZLVzVERkJLekdIeWVxblo0ajAwNVMwSnVjL3dCOWttSmlu?=
 =?utf-8?B?MTR1S1J6UzYxcmo0ZndmNkhRYTVMR0ZFdjE2aU03SVpQWE85dlltd0RnN2Nm?=
 =?utf-8?B?eGFoZWZwNDdQWjVQSWtjcm1QOUxmQmVvNnJkRGltTTJhM05LVVpGN2kxMkwx?=
 =?utf-8?B?c3ZGN0dDM3ZkeVdSbzRScGNHb1FnVHhwcUF4dWdkQ1NxM3RFbStraVNKMlBW?=
 =?utf-8?B?U3oyZlFkeG5tL2hBRmREMytiaGlnU0VYYjVob1VGTnM5eHBEbmFrNkxxMGQ0?=
 =?utf-8?B?YUNTbTBadjhTSkVLTXJJcmtBQklMdkdxeVEzUmRnaHBGZGt5SjJ3aVNCNGht?=
 =?utf-8?B?MjhtWUoyMm5WSjZYeW1yVU1xbFZhYVlFVFFwWDRoTVV1VXRkR0tFY01LV2l3?=
 =?utf-8?B?UGtBT2FoL2R0ZUh4UkRJZ2ZESjJjcms2TzA5SHhMUXhSVVNlalI2bTdmVGVt?=
 =?utf-8?B?clFmTHduQlFOdldQOEFpd0FKWm8zbjdxSDhLeVNVMUloT3M3VGZQa2xtV3Ur?=
 =?utf-8?B?WkNVQTZwNTBzK2RZQ0U3Q0ZONUxZNk9Gb1VTNGNaaWxaQ1RWVlN0Y2pOL3kr?=
 =?utf-8?B?NzVoNENKUnNoYzAvM1VzV2N5clE2VjBKN2oyZDl5cnBPWGZ3ZDFhUlBhVzhL?=
 =?utf-8?B?WFhjWCtHeHJReHNab0ZyUXZ1RXphbE1hcXA2VzVqWXM5L2pwclQzZ1hUNWlj?=
 =?utf-8?B?Q1dod1lCTEFUb0VtcmpwcnRXcFNTN1ExQXRVWEcxNUdnWXRFbGgxQzdLNFlW?=
 =?utf-8?B?OG51WWlvQ1dyaG5CNUYvanlySm9lUFpqNGFFWGFtU1d5bjVUOGVIQTJ3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZSsyVDE2Q0h6YXNxWGZqWEtIUmZpZy9POVlqZXlvSHFDeHc3d3lEMVhLWDdZ?=
 =?utf-8?B?L2N2L3Frb2MyOHMya0loWmdaa1JBbG5HWXJHL0o4VnJFZHdOaWpZVkJSS2ZH?=
 =?utf-8?B?ZC9wbE5HMDRPSHJ6eC9Vc3NhWmY1Sm5Oa09PcnJRSzZDZmRoUndVaHZyVzZV?=
 =?utf-8?B?WkVnT3NtK1lQQlAxMnlvNythSkJQWnBDc2pTRktaOURST3h5VzBZT3ZmVG50?=
 =?utf-8?B?b2JVK3hCVHNxVERtM3FTSC9BU2lMb0VhcWJwN2xZbmZ0d2Q0QTlNa2lIeVRZ?=
 =?utf-8?B?OUJzSEt3ME5tem16ZmFlYkFWbmFpcUxPbmhMM3UxVTlvWStKTVo3SGE0RExL?=
 =?utf-8?B?N0hlUFVmbUFqU2tQQS9BZW1IbXlYODdQdTNoam00ako0RjEyQTk1WS9xZ0Vm?=
 =?utf-8?B?YU5IQkI0dHkzNjBUTFZzay9lMnppOUNYU3B3QS93TTM5dzliL0F6bjFPM1A3?=
 =?utf-8?B?dzBVa0tMMldUckxUbEY2cSt2dmMvOXk1ZmZSNEJtMk5seDAzdjBBeTJSTGZp?=
 =?utf-8?B?ZjRad0piM1hnSlljd29FMSt5elUvalgrNU1yUnQ4TW1vbGQvd0d5OVhBdFg2?=
 =?utf-8?B?VytCSHA3bVE2aXJtZEN2TXFEL0dwTGY4V0o3eTVPZWZrR054L09FbzZnSGt1?=
 =?utf-8?B?MDVjSy8wWXhibHpZWC84ZEVIb3BYTnRPT3N2SWF4MnJkcGZnYkV4VkdhMUVp?=
 =?utf-8?B?OGF3bHk2RE9taW1Oc3R2N1o5MEpaVkFoSGZsVjdiTnc3ejR6TnFhTlpDM2FB?=
 =?utf-8?B?Z1dOc016Z2Q3L3VCa1BBSEl6R2lFenhORC9hbHM5NmZuUGZQcjJZNlJJQXNZ?=
 =?utf-8?B?L0hmQ0xYY0lINm1jYnRUR2t4dVB5TTUzaS9DWGVlZ2tBcTRJRU5ZL015T2J3?=
 =?utf-8?B?Qy9SRDVuTTlDTm5DSmdra0NUdlFHdWxpL3drTWk4QUNZV2FZMXNtYUIzUFZp?=
 =?utf-8?B?czZHQnVjK1JwM2RPQTR5R3g4ZWlCejA3aGhMRGtYMm9SRkhYL2M2a1BhVzFo?=
 =?utf-8?B?a3g3Z0p2NHUwZnFLYmRhTkdaczNVeWRDMkpVa2MxajBFNnNIQ2RTOUNsdXFk?=
 =?utf-8?B?VDVYRzdPdW1VQ1BJTjJBMHlFaHkyNU4wWlJVbnh5ZWZBM0FyVml5RUo4bnJ5?=
 =?utf-8?B?djVCcmRjQ0dtVkcvMXQ4dHIxQ1pGOUZTSnM2NjFaUG13QTFrS081MU4vQ0Jm?=
 =?utf-8?B?MWptRWJXM2VZQ2Q0akUrZGN1c1RhaU9WYVg2U3JGZHMzc3pIODQwbjA4Q3Av?=
 =?utf-8?B?TGpuUjFqeU9sWURoOUJJakR5dEZhL1dDVEZHNzFEMWE4aWxQTjlvVUNIVkVK?=
 =?utf-8?B?dEhKQ2dWOGZ6NUZyUnpRUGpzY0pvWFc5YkxmM3d0ejZZcjNpalkrcDVDWGUv?=
 =?utf-8?B?MnFMZ3ladFZjb2lUc08zNHFSWlBzMXdCMGlUek4xNGtLcEJDY0E5QTJmMndt?=
 =?utf-8?B?TXhNQm9tL3d5MFJMVWM3WmdVYSt1MytmRDVBWXd6aUFNRjZlU1hwb2lmTFVR?=
 =?utf-8?B?b1l5aFhMUStWci9vWEJIbkhEUnNjY0dvL25SSnNoUW5PaU5lUFJVL0srYVV1?=
 =?utf-8?B?RlI3K3pYKzJUK2VlSVF6OTEvTUl6akJUTUpUODFNZGFESC9GU1ZyQjJtNG9t?=
 =?utf-8?B?Ry9ITnhPOGVwVkNtbkpvZ0hNTlBBaFlDWEQ0Tmo5a0V0TDVya2xlSVlkTklK?=
 =?utf-8?B?V1g3V3c1ZFY2MGxidjRTVzhMRjdFSldnbzlHSXpOMnZIOVZGa2gwTEtzWlhh?=
 =?utf-8?B?MFRBRHl1eHlxanRBd3c0RUVMOUFWY0hzUVZuU1QrS3lzK3lzY0svNU02ek9C?=
 =?utf-8?B?cWJGa01FT1ZCWTRYTEJtNElNcmFTOTdpZGwzQmZWbnJnMjR1VmhQNnFrZC9P?=
 =?utf-8?B?cnRDLzFYeVlMVWxSOXVxbTl6MHpVeHNBL3Q2V1JKVkxoVDJnV01oK2xOaExD?=
 =?utf-8?B?YVBOcW1pTFpqL0xBSlA3bkl1blpaTHczaitPN0U0blEwaG00RnM2aUNXWFUy?=
 =?utf-8?B?Y2RiblFVOCtIeStEclBEWnRNK3Q1bklIWmladXMrNDNpNGZsUjEvbUVKOGVJ?=
 =?utf-8?B?OXR4S21ickpqQktHU2FIU1o0SUJHWFJiUmxJWHdQUUNBNXl1TDFEZXZZNWpx?=
 =?utf-8?B?d1BxU25ZQlg2dk5lQStaNm9ZZTIrYy95YUVxSTR4bnA5VUtUZVdMZElSbDhw?=
 =?utf-8?B?cGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 84edc3f7-ef34-4c47-0334-08dc706c6a2c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 21:10:12.1047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R71XK3/Zf7EbHvHj1KYi1nJAtCnqJDvudmWNripow/hHeKNyK/pDhAJaDJ3dSh+iObKG/IEhZassGY7WWIGJQeNGRE+85iXNpW2CJ7luqfE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8008
X-OriginatorOrg: intel.com

Hi Babu,

On 4/25/2024 1:16 PM, Babu Moger wrote:
> 
> The MBM (Memory Bandwidth Monitoring) and MBA (Memory Bandwidth Allocation)
> features are not enabled for AMD systems. The reason was lack of perf
> counters to compare the resctrl test results.
> 
> Starting with the commit
> 25e56847821f ("perf/x86/amd/uncore: Add memory controller support"), AMD
> now supports the UMC (Unified Memory Controller) perf events. These events
> can be used to compare the test results.
> 
> This series adds the support to detect the UMC events and enable MBM/MBA
> tests for AMD systems.
> 
> v2: Changes.
>     a. Rebased on top of tip/master (Apr 25, 2024)

Please note that resctrl selftest changes flow upstream via the kselftest
repo. The latest resctrl selftest changes can be found on the "next" branch
there.

Reinette

