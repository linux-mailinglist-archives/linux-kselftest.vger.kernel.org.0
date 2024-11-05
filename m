Return-Path: <linux-kselftest+bounces-21459-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BDB9BD312
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 18:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5AD01F22EEC
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 17:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39D61DD0F9;
	Tue,  5 Nov 2024 17:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h/En7o2N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBB17E591;
	Tue,  5 Nov 2024 17:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730826533; cv=fail; b=IWfP4WmDXcihLzhVBWkfaAtrGsDGIOC2hoXT6txbi9TdO6iyF5ze05pnKboyLc99qB8FdNulbge+iA3lHy90Vdfdmnoll8Lo6OyuCuvMup4zLNSxaLWDdt0V9aShNZSOB/wEB+04oYymjh2r7h2Hfe/UhoPEDZ+qNKGHKnXO+sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730826533; c=relaxed/simple;
	bh=3b8Y72lfvSX2c5i/pxazma76hyY54D36gz1MGKDbpNM=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pr36H4pq/J6Q6pJQqqJ4dG+4xhTGiTmeQ+g9pvwwbO7QLUsBtr7DElnzmQ1bZdGHW5hAsWHgw3BVttV2CgbMfVvNvoES95nGdoijR2FSGCjxjSUVITwFxCWK1M8PoQ4HIuk8koeTwRIXzXgahekeYy2rqZqt2XJjSigKOklmNJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h/En7o2N; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730826532; x=1762362532;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3b8Y72lfvSX2c5i/pxazma76hyY54D36gz1MGKDbpNM=;
  b=h/En7o2NvOm0gchNUpVRfLpLipZbikHDG5zEH7yZwyGgZvaSa0+C1Ttf
   tidj88QHWb5Q8wC0DFX0xRQRYZcPAAyCD7ehtA7D3SrDxv9bbIRvgXUgX
   CYHEmOjVv2VZjLiOTGhWZA/zaOPYeP3FrlmZ86tjaZuVFsCS0HWWyBqsq
   Gcm0oksFt7zJ9FEby1G1jcmsSi6N7asASidIrz1ZFzotVJ+Ps6dDYA4zN
   9V1elfB3Ph0wdwBziT4urOTeRnvZBGhQNmEwzgsvNsxzu6+jY+Jh5oEJd
   H/HpODgRpgwPshjyH5FgnndvTbGtW4tMK18OW0aYc/UVc+6Xn4ovc/wvd
   w==;
X-CSE-ConnectionGUID: kb2d6upZQdS3itJrkNo06g==
X-CSE-MsgGUID: QckuNFxMQOGY610tyOlR6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30361755"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30361755"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 09:08:51 -0800
X-CSE-ConnectionGUID: eWhMnoqOS7Kv/r/2AoqPxw==
X-CSE-MsgGUID: cqVTWUphTIyGKPr/5qiG9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="84215259"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Nov 2024 09:08:50 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 5 Nov 2024 09:08:50 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 5 Nov 2024 09:08:50 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 5 Nov 2024 09:08:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HYXRM3YN7GZRA6pKMUs9pmgz1gkzEficylHW0AIgYdferLQpqGG9PyMSzqW6bH2QWpQInMId9I2XNatWa8z7BhZr1fLq6cEkXN90i0mYifOBOisUvt9wlxSkOHl+M31WNoMmcXbf7ZQd6NrqUjBBTuOr/XLqcyxhMidGPavKjdOiXJXXgf0GFw8TZjoUGhJeCw55th8xkA/CbXFHF9iiN2Ke3sqUZRWy/N76nOg17VnRRXQrRpXPuqVlKPGyL9ct4LpFF+ARDw85JEe/w2eNQFvufcG8QV3Vv3DC4yEK8ccEevXf2p4wHaH1GhqRvLErrbKPlzp2kvZiraZWYdg07Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htAvSU8kfeOAZWw1iShhM8Ko28xXgD1Ro7bYfg+5pmg=;
 b=f3V0TE6ZrSXSQTPkjdFGNQiEyR5Z7VMY3UllDX3806AagryP1CDF0VxVFf7Retk7689FBfijt6e2RhZgME2W5rzbPfkH4l495SxMwAxM3Fe4O/ZH7tE4PKpVNAb5/lc3c4GCvWZY32flaRSXxAzITO5z0JOpzhyxIPOhFZcNouFBggfn4meVUeOyaJm6BvKFsq2LUcEMpVBjAv0/7m4DaapUrIKGdR+3GZTeIfW8lCHTSIs7wz4DeWXxoJzM2TSRpD6FH8peeuUXgzuq3TVpVqU/PK4taKNQSZZaJFGOTyyOeMQEQR8+hNVA5ubUS3F9+LRHh4b2gOSNpjvjtAnuJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7765.namprd11.prod.outlook.com (2603:10b6:8:130::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 17:08:47 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 17:08:47 +0000
Message-ID: <a67f01b7-de0a-4ada-b3b0-59b31e330e8c@intel.com>
Date: Tue, 5 Nov 2024 09:08:44 -0800
User-Agent: Mozilla Thunderbird
From: Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH v5 1/2] selftests/resctrl: Adjust effective L3 cache size
 with SNC enabled
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	<fenghua.yu@intel.com>, <shuah@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <tony.luck@intel.com>
References: <cover.1730206468.git.maciej.wieczor-retman@intel.com>
 <06c8f3e64b8e59e031fc16a919373a0dfaa9516a.1730206468.git.maciej.wieczor-retman@intel.com>
Content-Language: en-US
In-Reply-To: <06c8f3e64b8e59e031fc16a919373a0dfaa9516a.1730206468.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0121.namprd04.prod.outlook.com
 (2603:10b6:303:84::6) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: 292e5c87-ee82-41f6-f4df-08dcfdbc82a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bnd4R3BHMUlPSnNaRDA5R0JUQktJQXJlcDBEbzlHOXc3Nmx6NThKdVJtdVUx?=
 =?utf-8?B?ZXhQa1RRa3VGbVJ0YmxWejQySUphdlFyZ01VcFFUcnlpZW03MzQwbTZDdGto?=
 =?utf-8?B?VW1Qc2J5YWJsRGw4blRlaGVHNGRHMDJUMHZSVDNRUFIxYnp1M21oSlQ3WEZo?=
 =?utf-8?B?bU9lSm52YWZIbitWd25tekZyOVB5c0d4cE9TSHVpSG45VkJDVE1rcm9xK1dh?=
 =?utf-8?B?N09zQmVJMVVscFRYRXgvSkRoVkQ1eXNIa1B0czRSUmRZM20veVZUbHprMHhl?=
 =?utf-8?B?ZG1MS0lRcmFQeXlpUFFWdEZoMmkwMHIySlFrOWZKaWp6WVZubUtGTDVRUUMx?=
 =?utf-8?B?SEhuNHluZEJlRmpPZHJJaFFpdXg2dTVxeFpvU0lMaTJLMitvbCtEam82QU16?=
 =?utf-8?B?OGZQOExIaVdIL0FmMHFMZGhzMiszUmFQVThSY1hXdUpoMzhaK2pua3lKRWZW?=
 =?utf-8?B?UHJZKzRZNlZycHY1S0ZQM0l0UG1CU2RtRERRQmUwTjFEbVFrUGxVTDJuc0tv?=
 =?utf-8?B?YUxyck5sYVJjSlhTdFdmaVQ2NUZqazY0bVJFamRKN0k1RTlURjJDL2hxTzZL?=
 =?utf-8?B?alZlVFR0UG4rS3BjUk1aUVppemlXeGhyMnNEbEQ2WmVZWm02WkhnS204dlhM?=
 =?utf-8?B?Ymp6ZTdocnNWZndjOVJONHVDQnh1a1M4TE5HVS9iRHhQQnlaWHdMaDdoTHFk?=
 =?utf-8?B?Ujk3ckx1cXRkak9MZnRNQ09Gd1NaNnpNOVl0VkZFVkRYWFhSRWhQV25hb09r?=
 =?utf-8?B?V09LOGVVS3ZVTlZ2RXd0c1B5YnVBditpUDdGb1pZSURPeWxpaDhLeGJ4bENt?=
 =?utf-8?B?WkY0YzRNeUszVVlUVVVBbVZuMEFxU1RMeGJheXBXNGNNNGF3LzNBd2IrQTBz?=
 =?utf-8?B?bUY0cmdJUGZQQWMxbWJHRjUwUUYrUFRNV3VNZWh2Tm9VdE1xL0lDTUU0cGc4?=
 =?utf-8?B?V3hlcmJoaFZLcHNpNXdxRWgxTFJqaUt2dFo5SWdKM0FuRkljVE1BSi81Zm5D?=
 =?utf-8?B?SzRqcW9tN2psSEFvVGxBelZRdHZzdmRmekkxN2dadytVb004dTR6TVFLclFP?=
 =?utf-8?B?YmExRVR0bDByOE5TSnFrS0M2Y2NCS20rbTFxdDVzMGExTEdLZkplVXlFdzRU?=
 =?utf-8?B?c1BvdHBKZ1RRTGZIWXprek9NdmRWUWFUc0VYNS9LSHNNUmpzTytBTEpIRkQ2?=
 =?utf-8?B?Qmd6Q0lUdDFqZXJFc0VkZTh1eFg3Vy9RcmJPV3ZLZVBIWnVOL2YwbXNRQzgx?=
 =?utf-8?B?KzhubklFTElrb2JaM1hPNnoxWHVJQkdEWTBsNTE2V3NBdU94NTR2M2lxMm9o?=
 =?utf-8?B?TWt2YWlURlRUNVVnZWxLVXVtQ05QclZyK0hTMWpxRWkxckFWREc2MnBid2M3?=
 =?utf-8?B?SHM2bXdkS2RFd0gwelkyQVVnUnRwR0g2dkJiQngvVWg5YUdVMGpHd1NVL09t?=
 =?utf-8?B?cndJN1BBeFpqS01NTUsyZURxK2tZUkJLZWZxbWUzaVZSSk5jT05xZEtJbEdM?=
 =?utf-8?B?RFo2bTJlWUpGV3BxSDdCWGl6WXVJTUkrK3FkYThBMU9RSmdnaVVqTzdEbWNt?=
 =?utf-8?B?eFIveUZ6ZmROSi9TRHB6ZG5FTEtzVTZhU3dDWi9yWDdEZVgrajF6ZXRQRXN3?=
 =?utf-8?B?UjRWaGpMMnRLbi8xZVE0YTRmdGN1RS9ML1JnT0NCSG5ZWTBQSm11eW1VTlN5?=
 =?utf-8?B?a285YXhqdnA2dWMzN0hyd0sxMGpDOTdCMURNb1U5cFFKTE1TNTZiNWZLeE5D?=
 =?utf-8?Q?Ve0OUD1BpIpTRpSwRkttTSZUQu2dawG0hxOFm0S?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWQzazVsbFVqZ1pQMEZQUDNFcXRnZVBvYS90T28vRElNaTk2T0VWcGhXdnZV?=
 =?utf-8?B?anhmdlRYcy9zMXMrT056UjYxaWFIcmJ0VzB4anBFcDI5VDEyczVIVWFEOXlD?=
 =?utf-8?B?TzdRbDdndmxmUGN6cmJOZUN4LzdzRnZYK1dKYmJVWDFWVVFON1orTG5ha2Ew?=
 =?utf-8?B?Nk42QUh2ZmlBcUhsbkJWOGpqby9odG9oTjZwR3JQZ0pscUgrMHVWeVdKNVli?=
 =?utf-8?B?aHB4U3ZFNnFlb1BaU2tQU0gzYnRsd1hoME9zZURYSzNzVVRGbnRLU0JZcDly?=
 =?utf-8?B?bnZCV3BJcWp5ajBWOTJxYzQyMFVRRVZxMXNpSWhvbVF0REZ6N3NFbmZCei9q?=
 =?utf-8?B?VllxdE5NUFBIOVRRbXVkSGtldFFGaTFTVm50a25uSWFPSmxVTVRRZENWRzVi?=
 =?utf-8?B?OFBhSkpKQmlnSk5LYWJiK2JmQmdqYlRJdzdmcmZmYWhVNFBEZEkwcWc5ejlu?=
 =?utf-8?B?SzVzRDBvTEJ2VTdPcStGZkJNSkR1bWptRjk1Mk1rZlhnZzhzTkJPNEk1NUEv?=
 =?utf-8?B?cnFSMllTcVZJQm9JQUlodUQ5a3NPSGVzTnU4OTlscnk4aG1zbTdxSG9HY2N3?=
 =?utf-8?B?dWhYVWpNb01YbHhFTW1rOVVVeW1rNWt2QzRHR0IyWlk4MDZiRXRPdmNWSllr?=
 =?utf-8?B?MlRCNElVMTVHeXhVckhlWnIyRU1mN01jbVhlNVRqSVIwZU5OSml4WC9kTjBj?=
 =?utf-8?B?bGprczRrSk1pQkFoWlZMODZROUkzZDdSVlYyQkRwc1k3KzMxcElpdnJhVW9V?=
 =?utf-8?B?cjhwYThGcktvWVZaL0pEV3FNV05vMHVDREVqcVRlTVh5dWEwM3ZRcUpKWGxm?=
 =?utf-8?B?K0dvbFNXWmpQb0tFNjg1enlzOW1RU0pLRzl0VE5oVkN1TDIvdjJkb2lOZmFC?=
 =?utf-8?B?MERiMlJlVmtySHNVSEpZVGxsOEN2R285THV6YnZESkMrL0hZeVlSUmFZRWxD?=
 =?utf-8?B?MHJPUUpJZWZUZ2hNSHBNN2RNdk90dndlRkJBMU5hQnRxREtIRDJSRUlVczFj?=
 =?utf-8?B?MTJ0STgwUFRxZG9MdkhHQU12bUtaSkxjTklyZlRpQkhoclpUeUxOVHdqU1FO?=
 =?utf-8?B?ZWJzODBJeDhwNzVCTG9BQkJIZ2F2NzZBTTZneEJaNWI4bzZUQ2puRVJUN2tL?=
 =?utf-8?B?RkxKbStiWERaTnpFcnoxVUJsTHlhUEFCbklGUUlMR2tXbGN4Mnd1RTA2ZlVv?=
 =?utf-8?B?Q0poYmJ1UXp2MFJqYXMyM0JsNTRYWVFnYzZvRlpXcWlybExXcVBuRU1WbkRT?=
 =?utf-8?B?K2g1WGVKUnVOS3l3b2dteGJuRVJRYVY1NENTNms5WU1sSExrNEJRbUJUZy8w?=
 =?utf-8?B?ak1xbnlSaWFmYVU1M0RLRnRJTTRqUEdmY1M1WVhkblVDMHRxMTlaUG1Ga2Ru?=
 =?utf-8?B?b3oycktUNkdqUHhXWDMwd0RrTEwyOVVJb3dyMnJsUkVWcUlMaFVHbUdFYkRm?=
 =?utf-8?B?Ly9aZG5KZVErNExIcHVEMDdPTWlxZWtjdjlZa3o4eDlLT0VQSEFTQkh2akEz?=
 =?utf-8?B?TUtzSFhtaTY1RUYxYVlRNlk4QnhNWGdvRVVoeW9ZNjhQRXJPUTVURHVzSUlk?=
 =?utf-8?B?cHF6UkFRYVZ5NjNjVUpPTm55a1BEK2s3NUF1UEd4UDZuQU8yRzBVQzlUR1Vv?=
 =?utf-8?B?L3BFMnhlcWVYRlhZd294U2M0YUxCQnFVOGJDWjY3V0R1a0pFRklxT1pTZWZ3?=
 =?utf-8?B?VTZsRG10Z3B3RWhDTTF6ZERjUjN5UjlIQUlYSkVSTHM0UjhtYXNOOFZyS3Ra?=
 =?utf-8?B?VkkzbmdKTnp0ZE1PeFJxdklOVVcrb2ptV3JXNGlCMnQ0aFY4S3preVBGbU96?=
 =?utf-8?B?V3BBU1NrT0xBNFJ4dGpoOWdOQ2RBV2RWZHFLN2s1UXZpUHlIb3I5eExiY2Vx?=
 =?utf-8?B?ZDZiOGE4SWtCWktyTUJTdzJGbmwyZXYzYWhBQ25uSjAzYnkrejNGcTNPc3M4?=
 =?utf-8?B?d0J1aU1TN05lZFA0OGMraEZnZ0JWYzJMMDRyUCsvYUQ1eXM3c1JmUHlhTzZi?=
 =?utf-8?B?RG10YmJEZ3VwQVBndGovdGFZMlpLVlNCSmR0Qk5jRHZ5cUZtUUpyaXVXbVFM?=
 =?utf-8?B?R1QzRy9OeFRjRTBHd3lPM0xZTTZFTlNyT01Mb01MN082VjErNGdEbkZxTXU1?=
 =?utf-8?B?cG1KTlBDbG4za3NTaDdsc0xTcExGek1Td0ttL0ptVHlVZVpoUjNnazVuSG9l?=
 =?utf-8?B?QUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 292e5c87-ee82-41f6-f4df-08dcfdbc82a9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 17:08:46.9886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iX0CeUQVTQ/bOUQNROwvGT3o95x2aX0parddI/gThx9fZVAsPexyMzRc0SqU8N+jpmw/xAqeXETIHijF2EqnC8T/OnxUlUa9ssjw01dfu1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7765
X-OriginatorOrg: intel.com

Hi Maciej,

On 10/29/24 6:00 AM, Maciej Wieczor-Retman wrote:
> Sub-NUMA Cluster divides CPUs sharing an L3 cache into separate NUMA
> nodes. Systems may support splitting into either two, three or four
> nodes.
> 
> When SNC mode is enabled the effective amount of L3 cache available
> for allocation is divided by the number of nodes per L3.
> 
> Detect which SNC mode is active by comparing the number of CPUs
> that share a cache with CPU0, with the number of CPUs on node0.
> 
> Co-developed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---

...

> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index 2dda56084588..851b37c9c38a 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -11,6 +11,7 @@
>  #include <signal.h>
>  #include <dirent.h>
>  #include <stdbool.h>
> +#include <ctype.h>
>  #include <sys/stat.h>
>  #include <sys/ioctl.h>
>  #include <sys/mount.h>
> @@ -43,6 +44,8 @@
>  
>  #define DEFAULT_SPAN		(250 * MB)
>  
> +#define MAX_SNC		4
> +
>  /*
>   * user_params:		User supplied parameters
>   * @cpu:		CPU number to which the benchmark will be bound to
> @@ -120,6 +123,7 @@ extern volatile int *value_sink;
>  
>  extern char llc_occup_path[1024];
>  
> +int snc_nodes_per_l3_cache(void);
>  int get_vendor(void);
>  bool check_resctrlfs_support(void);
>  int filter_dmesg(void);
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index ecbb7605a981..4b84d6199a36 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -118,11 +118,17 @@ static bool test_vendor_specific_check(const struct resctrl_test *test)
>  
>  static void run_single_test(const struct resctrl_test *test, const struct user_params *uparams)
>  {
> -	int ret;
> +	int ret, snc_mode;
>  
>  	if (test->disabled)
>  		return;
>  
> +	snc_mode = snc_nodes_per_l3_cache();
> +	if (snc_mode > 1)
> +		ksft_print_msg("SNC-%d mode discovered.\n", snc_mode);
> +	else if (snc_unreliable)
> +		ksft_print_msg("SNC detection unreliable due to offline CPUs. Test results may not be accurate if SNC enabled.\n");

As I understand none of the tests can be considered reliable if SNC detection is unreliable
so skipping the test can be done here in a central spot without duplicating it in each test.

> +
>  	if (!test_vendor_specific_check(test)) {
>  		ksft_test_result_skip("Hardware does not support %s\n", test->name);
>  		return;
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index 250c320349a7..d6384f404d95 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -13,6 +13,8 @@
>  
>  #include "resctrl.h"
>  
> +int snc_unreliable;
> +
>  static int find_resctrl_mount(char *buffer)
>  {
>  	FILE *mounts;
> @@ -156,6 +158,93 @@ int get_domain_id(const char *resource, int cpu_no, int *domain_id)
>  	return 0;
>  }
>  
> +/*
> + * Count number of CPUs in a /sys bitmap
> + */
> +static unsigned int count_sys_bitmap_bits(char *name)
> +{
> +	FILE *fp = fopen(name, "r");
> +	int count = 0, c;
> +
> +	if (!fp)
> +		return 0;
> +
> +	while ((c = fgetc(fp)) != EOF) {
> +		if (!isxdigit(c))
> +			continue;
> +		switch (c) {
> +		case 'f':
> +			count++;
> +		case '7': case 'b': case 'd': case 'e':
> +			count++;
> +		case '3': case '5': case '6': case '9': case 'a': case 'c':
> +			count++;
> +		case '1': case '2': case '4': case '8':
> +			count++;
> +		}
> +	}
> +	fclose(fp);
> +
> +	return count;
> +}
> +
> +static bool cpus_offline_empty(void)
> +{
> +	char offline_cpus_str[64];
> +	FILE *fp;
> +
> +	fp = fopen("/sys/devices/system/cpu/offline", "r");
> +	if (fscanf(fp, "%s", offline_cpus_str) < 0) {
> +		if (!errno) {
> +			fclose(fp);
> +			return 1;
> +		}
> +		ksft_perror("Could not read /sys/devices/system/cpu/offline");
> +	}
> +
> +	fclose(fp);
> +
> +	return 0;
> +}
> +
> +/*
> + * Detect SNC by comparing #CPUs in node0 with #CPUs sharing LLC with CPU0.
> + * If some CPUs are offline the numbers may not be exact multiples of each
> + * other. Any offline CPUs on node0 will be also gone from shared_cpu_map of
> + * CPU0 but offline CPUs from other nodes will only make the cache_cpus value
> + * lower. Still try to get the ratio right by preventing the second possibility.

Similar to v4 this "try to get the ratio right" is unnecessary because of the explicit
check for offline CPUs.

> + */
> +int snc_nodes_per_l3_cache(void)
> +{
> +	int node_cpus, cache_cpus, i;
> +	static int snc_mode;
> +
> +	if (!snc_mode) {
> +		snc_mode = 1;
> +		if (!cpus_offline_empty()) {
> +			ksft_print_msg("Runtime SNC detection unreliable due to offline CPUs.\n");
> +			ksft_print_msg("Setting SNC mode to disabled.\n");
> +			snc_unreliable = 1;
> +			return snc_mode;
> +		}
> +		node_cpus = count_sys_bitmap_bits("/sys/devices/system/node/node0/cpumap");
> +		cache_cpus = count_sys_bitmap_bits("/sys/devices/system/cpu/cpu0/cache/index3/shared_cpu_map");
> +
> +		if (!node_cpus || !cache_cpus) {
> +			ksft_print_msg("Could not determine Sub-NUMA Cluster mode.\n");
> +			return 1;

Unclear why this is hardcoded "1". If this is an error then it should be negative so that
caller can consume as error. If it is intended to represent SNC mode then it should be
"snc_mode".

> +		}
> +		for (i = 1; i <= MAX_SNC ; i++) {
> +			if (i * node_cpus >= cache_cpus) {
> +				snc_mode = i;
> +				break;

As I understand this complication is no longer needed because of earlier cpus_offline_empty()
check.

> +			}
> +		}
> +	}
> +
> +	return snc_mode;
> +}
> +
>  /*
>   * get_cache_size - Get cache size for a specified CPU
>   * @cpu_no:	CPU number
> @@ -211,6 +300,17 @@ int get_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size
>  			break;
>  	}
>  
> +	/*
> +	 * The amount of cache represented by each bit in the masks
> +	 * in the schemata file is reduced by a factor equal to SNC
> +	 * nodes per L3 cache.
> +	 * E.g. on a SNC-2 system with a 100MB L3 cache a test that
> +	 * allocates memory from its local SNC node (default behavior
> +	 * without using libnuma) will only see 50 MB llc_occupancy
> +	 * with a fully populated L3 mask in the schemata file.
> +	 */
> +	if (cache_num == 3)
> +		*cache_size /= snc_nodes_per_l3_cache();

get_cache_size() is also used by L3 CAT test. L3 CAT test is thus also impacted
if SNC cannot be detected reliably and should be skipped.

>  	return 0;
>  }
>  
> @@ -869,3 +969,35 @@ unsigned int count_bits(unsigned long n)
>  
>  	return count;
>  }
> +
> +/**
> + * snc_kernel_support - Check for existence of mon_sub_L3_00 file that indicates
> + * SNC resctrl support on the kernel side.
> + *
> + * Return: 0 if not supported, 1 if SNC is disabled or SNC discovery is
> + * unreliable or SNC is both enabled and supported.
> + */
> +int snc_kernel_support(void)
> +{
> +	char node_path[PATH_MAX];
> +	struct stat statbuf;
> +	int ret;
> +
> +	ret = snc_nodes_per_l3_cache();
> +	/*
> +	 * If SNC is disabled then its kernel support isn't important. If SNC
> +	 * got disabled because the discovery process was unreliable the
> +	 * snc_unreliable variable was set. It can be used to verify the SNC
> +	 * discovery reliability elsewhere in the selftest.
> +	 */
> +	if (ret == 1)
> +		return ret;
> +
> +	snprintf(node_path, sizeof(node_path), "%s/%s/%s", RESCTRL_PATH, "mon_data",
> +		 "mon_L3_00/mon_sub_L3_00");
> +
> +	if (!stat(node_path, &statbuf))
> +		return 1;
> +
> +	return 0;
> +}

Reinette

