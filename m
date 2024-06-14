Return-Path: <linux-kselftest+bounces-11978-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8B690926D
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 20:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA21828CDE5
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 18:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A90819E7E9;
	Fri, 14 Jun 2024 18:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FcG+QZka"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD08E19ADB3;
	Fri, 14 Jun 2024 18:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718390423; cv=fail; b=jCxnJ7uKFPLl6RNoSBIOI747OSlV9L/OWD/qouNVmQugxMDEJftNnoVUMI/7CBf9eNLgy+l1ieu6+jrb+60K/Ag2mRR0Wk33oGith7T0reWWYa+/v57kJztHKx5HwCAaTDPHq1TOG7+s4E7og61Vf+6YILAECGT6+J5SRFAGGCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718390423; c=relaxed/simple;
	bh=nBKwbdDGIgFrXmxt2QuBg8h4WbR5xVpN4trmnPxbudI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ennNpQ56yTF7qislgOevLBtT0f3vdB1uzPnAYit8f8ctpqLYSRQNaMjw9nJ9GYWsFyxYBgT4NoP39dwOOhzbZ/QGwsZgrR0P++AbTUJow0LYC0wsbj7JLV9GLYlzO98KvzzTJKXb1RZJUJLFJuD6tcmcNNImHen0fnuzUNncpM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FcG+QZka; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718390422; x=1749926422;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nBKwbdDGIgFrXmxt2QuBg8h4WbR5xVpN4trmnPxbudI=;
  b=FcG+QZkaeKuyrDS1ARtXvp7Ltb6aV05CXtVjvsrV3uSFQaCRe5KNvO5k
   oCIdC+h3ZjtQW+ZCz8VgbHiLUKjnHPG0/jPxQsQ3KpSJDuOo6Eco94jE4
   X/c2N22rWhgIVDl0gplVYHgokuQZCxX3YDx0N8DL/SvwT8u17vTb8FtqP
   PitvDvFoNbWeHvqH6atnYc41sK/ZXIsAQbEmhQa0CHCU5k+A2GCB8e58Y
   blXPu57GG5pE0OEXuOH8ZMzmBhMvyXgW5ENlXm4F1qo8oRk1Vre6V0GCR
   v5Dg9GcruLrMfaIEn2/tIK668J9TK3t/8uAMt/ZAseZUmsXZmqRQsYdlx
   w==;
X-CSE-ConnectionGUID: 9x5EoFFSTJ+FVfXUuuOiYQ==
X-CSE-MsgGUID: P1+K6BVvRXq2kiUqz+jFEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="32835677"
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="32835677"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 11:40:21 -0700
X-CSE-ConnectionGUID: B0HvGhpAR5q1hguQeWbAKg==
X-CSE-MsgGUID: mRZ/ARf1TiSi+Ek1qskUNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="40730414"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jun 2024 11:40:21 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 14 Jun 2024 11:40:20 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 14 Jun 2024 11:40:20 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 14 Jun 2024 11:40:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XwryA8YfjhI34yjb1hl1zHVOE8Nm2EJ5rYefKZXMkZ1JQh5B2fR4HIjhOuUTxAiZV3EffhnZ8IukGTOA7XHv61ySvYhxfVcYxE3MoQPrJHFjmK7bbqg8l+KEqmZXF/5QH3fZUupvgE+TFMO336/14B1Y+zjM4Wcpjn6jJMDLbR5gTAtvLzJhydbwnJSlL+U71J67EccsgdN/D7mYuATDxZguAfzMZuiJ2xQNJNn73541jwHQ1yeTZkIT86dI8+1MWXn50Td29AUbVQAmzaRpcyyuC2NEISOGBQ5j/bQvDVfYSstbgUPyxU1V5Aeh2p1c+Xhhz0QJ050vtFWwkSl9jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBKwbdDGIgFrXmxt2QuBg8h4WbR5xVpN4trmnPxbudI=;
 b=OIycn5jwDFqAdfpcxgB9dawXN0tmqltTgq/jHlGhHF30hfxYex6rPhSUtOUy5eb4mlUx+DGNJIhbCldOYyZzPWaZ2dbQzl4A2iMIZPOiw+Djq/bMBnTO20rLa2+Kif4Uj17YXFe/67vwyQjkqPo002tkBoj0q2Me9PO1kRaScKFL9VS3cmNDJpikCoIy2JyVVb2xYcyCMtIXWADlVUS4NE/tPby+TStPAE+P0Rfe3Nr0ezef5zAKMXbBZ6rf3WhTcmQxcXwP+eqrgwkhwMPAmzgT0UtmAdpSdmccFkSvR4v+ds5aY7H3goVvNctl1wOeFrRf2/vpbfRvKnLs/UrC4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB5159.namprd11.prod.outlook.com (2603:10b6:510:3c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 18:39:35 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7677.019; Fri, 14 Jun 2024
 18:39:35 +0000
Message-ID: <5b9588f7-9bd9-4fff-b363-099160ca657c@intel.com>
Date: Fri, 14 Jun 2024 11:39:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] selftests/resctrl: Enable MBA/MBA tests on AMD
To: Babu Moger <babu.moger@amd.com>, <fenghua.yu@intel.com>,
	<shuah@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <maciej.wieczor-retman@intel.com>,
	<peternewman@google.com>, <eranian@google.com>
References: <cover.1717626661.git.babu.moger@amd.com>
 <24ac6e8dba1b42aec8c33bd3c26f58344dad34f1.1717626661.git.babu.moger@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <24ac6e8dba1b42aec8c33bd3c26f58344dad34f1.1717626661.git.babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0210.namprd03.prod.outlook.com
 (2603:10b6:303:b8::35) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB5159:EE_
X-MS-Office365-Filtering-Correlation-Id: 513c053c-fa64-47a4-a001-08dc8ca15674
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WE9jMXp1M29RYytwMEYvWjgrQ1lORC90NUtBdXJDTHlEdi8zRWpFOFNNRENy?=
 =?utf-8?B?UE5YWkNIUjF2YVVBY1VVK0xvaXJmSkR5TUt0SFB6VEFiUXVDb1k3emRzbzV4?=
 =?utf-8?B?WmNMTzQrYnN2cHlmclQ0aWFSU1oxeTBlU3ZlT1dkb01Pb08vZTVQUHlDR0hY?=
 =?utf-8?B?eXYydDVub1c0R3dISWxCWDJwcEh3UDhEZjlrUzZ1SHl5L0xscDNXVitEMXR6?=
 =?utf-8?B?T2dKdXhvMDJYcWJIZ1liL2h2dVdFWTlHaDh2STl2Z2dWTS94VWhNU3Z4bHNW?=
 =?utf-8?B?NENYTE5CU1l4YkNucDBOSzZqUlRRdU9ZRWFLMFlRakJoSWl5ZzJESGpvNko2?=
 =?utf-8?B?amtPZU51L0VxQVhSSWdHSFFJU25laWlKOThkcWo2cHA0RTNaZGtTek9PZTJm?=
 =?utf-8?B?ZXV0SDc1VExyQUpvMXdMcThRSVpvNDRDRVlOWlcyY0RkTDdYSFdjUDZlUGZ1?=
 =?utf-8?B?M2JVaUpOMEtsdmZibTY3bE5pZTM1OThOVFdUUHJxdFpudWtBNmVIZnZUOXMr?=
 =?utf-8?B?SWwzR1lHaWMwRXF2d1hUQ3EraHNTVldqNkN2L0xITERNZzVpVzJOY0RkVmRX?=
 =?utf-8?B?NFVaUkU3S3k3blJsc1ladlBHWTNHNnovdjV4a3dtMTgzRktTZVJ2dXZ0M1Vo?=
 =?utf-8?B?MkZmMHJlSGZWRTU4eEppdU9Bc01aS0dVTjdEN2J5bzIwU08xcCtLa0IzOEZh?=
 =?utf-8?B?VVFCT2NjUTZ6WFN0S0ZjSC96NHgwNDdoeVFIeWRXcm9SODl3U3RCMHgzVkZY?=
 =?utf-8?B?ZWg5UkZVakNSK0hOd21peFA2U1RqTmJhWWlEKzZjVVd1T3ZJUWcxUUFVVzJX?=
 =?utf-8?B?VkM4dExSZEc2aVdjeTlpSkJEWWZyaXBmRVphNkMreEpyKzJRZlUrZWdPeHNZ?=
 =?utf-8?B?V0RZcnRWTk45NTNmaG05N0ptRTEyb1k1Yi81OWwrcTZiYStVVGU2VUVROUNk?=
 =?utf-8?B?cEd0bk1oa1RnM2xMZFVOZkppd3Byc0VkdVpiUFRTcG8yYkNuUkFCOVNjQ2ov?=
 =?utf-8?B?emFVa3Y4WVQ5M1dONzF3eWRvbnlWK0txcTBmU2RVMFBWRkNmdDVmbkRMeUJS?=
 =?utf-8?B?ZXZtNGYweGFBdDVmSXZ6cW1lZ1FiWFVDeUhXRW0zcU4rQi9UU2hYeGZ4aVJk?=
 =?utf-8?B?ZnNyZmVGcVlhQmZnREV6Tk90Q09BVTlxS2RiWk9VbGRvajNpWnBMRERFMTFj?=
 =?utf-8?B?amU5WUF3eXFFSWRIa0srdVJHSFljVVBvc1EvL0lmTHFIYUVUejRkUjFkVkYr?=
 =?utf-8?B?TCs4bG5rSVhVSDloTG1EMWx2MHNBanRVSzBwbEFiRHNxM2Q1V2JqUlpOZUN4?=
 =?utf-8?B?b0pjVlJkcHVSQk5wTnk4OXV1bVR5L1dBcURRc2NSQzNibnNuUXF0RWFmcUNH?=
 =?utf-8?B?cGlWT2crcXdXeXRqeGo3M2NsU09VMFp4L0xobi8wZmNHMUN1NXBSMXV6NU9V?=
 =?utf-8?B?SDdraWphbkpUOWQ2OFlEY24zRG1GMlVQc2F1WXhsblNyYVExSEtrMUQ2Mi9s?=
 =?utf-8?B?U3lKZmw5NXYxTTE0RldnTWM1K1Z1WDFFRUUzWVlTVmdKa3dzR2hEeVRZdHRi?=
 =?utf-8?B?elFMaUtMNzZzOHJKeDZIZE95WVFjZWZOSWNxNzZ4Ny85WTlFdEVXMTh5aWFt?=
 =?utf-8?B?WE9INCtxL0FKRjlURmpudjZLbmFLeFplYWVlQzI2NXNBUk5vYUc4MFpjN2tq?=
 =?utf-8?B?WmRMTWR0TzgyaDZSRUpXelFaRVZwZmtaWHBhOEFIa3F4NTEvMERMT2F6dHJz?=
 =?utf-8?Q?vqsY1yIIt7TGN1WlUk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVRScithTWxBbzMxbUZGSVUwRXp2KzZoU3NvalNrdlA3T09OM1EwYnFvQ2RQ?=
 =?utf-8?B?SzczL00yNTdTKzhqV1VDY01VYytHK1Fqa2tpVmhvTm9NZGZDSi83NW5NNFVy?=
 =?utf-8?B?UGhjN1J1UVh0ZWNWbDlLVHhpajYvMU01V1U0S2l4MmNZbDdKZkZySzVzM1Qy?=
 =?utf-8?B?d09na0h1VXhKRjV6TndaSWFQay8velUrVTJRTUtHWkZqUEpKMDJCTDFQU2pX?=
 =?utf-8?B?ZEZYWW4xdlJwOHA4azdjanVoVmU2c240dERtQkh0d3NFaTdjTnV5c0JDbEdi?=
 =?utf-8?B?VEpNSEhSc2lCc25FeXFLR2w3dTArQmM4ZTQ1MnhoOWlETmxWYVZXdTNMS3g3?=
 =?utf-8?B?MjJqeWpVcUNQbHlpZVJyTUpkdU1DdDRiRUYxeGEwbThDZmVsUVNaVjJTRlUw?=
 =?utf-8?B?c29haFVPbmcxdUtxSDZVY0YwUk5BOURBWmx1RDRka240K2VITVI4MndiUnlq?=
 =?utf-8?B?RU4wdEFLS1hyN0tBejZmT2R1cVlJZEVsaTVwaTBJSFZ5cEIwb1FyR2JmYmFX?=
 =?utf-8?B?VEp1TVZLL3hYd090Kzk1SituVW1WQytsK2d4Z1gzVk5lRUZDclV1eEUyNlU0?=
 =?utf-8?B?enI3MmMrMDJEd0xRNUVlOWVuMUpLQ3JrWkFDeGZlMmZ2c01ic2dONjlHcEV2?=
 =?utf-8?B?aWJrT1FIem9OZDlCZlIwRCtGMHVSdU05YkhEdnNPNzFPbWp0dlVtV2xxa3ho?=
 =?utf-8?B?VC9NVUgvT3VzdHR6R0J4MWZnZ1l5VXlEVUxnQTdXVlRFVkJ4eElLQU9kZmRq?=
 =?utf-8?B?RUFvSlpQdkNFNTBDc2hBY2s4VnNHQlR6QTJQWXpCakdkdXQ5em4rck1ZQkQ2?=
 =?utf-8?B?VklxdUFBend3eTFVdmxoRlcyN3VGelgvTEFjZnIzczBWdGx0a3VPc0dBRlR0?=
 =?utf-8?B?WmFBNXdBa1RlczA2bkxXRUFVNmtQSmxVdk1ONGdkRFBpNWFPMHZxZzBnRUhS?=
 =?utf-8?B?NVR5bmZGVUU4ZUdJdXdrMmtkbFI0MWh6T0ozYWwzVWJicmNJVjRud1YrOXp0?=
 =?utf-8?B?QVJWeWpVVmFzTVVqOWFMSm9aenpGdjV3ZWV0c2dKWUdXaU9MV0Fham5OUWZJ?=
 =?utf-8?B?KytqZTZjdG16T1RyM2RIeUhQQnpaanRXMTA4WGhSZXYvOUQvT05WTzE2dE9m?=
 =?utf-8?B?eVA5Z0Z3ZFdheWdTMUdkdURqSy9MWStkcTJ5Y1EwWE1HWkF4NXlqNjBjMndw?=
 =?utf-8?B?OHBnZ2FiYjZVdnB1RWJCbTFOMW5rbnRVMDdlSU5UV3kwbFFPVU1KRkJXUG9R?=
 =?utf-8?B?aWVtOG9ONXdTQ29sMENnRHE0eDJRYkxkcnRXYk9qRUlRL0dJV3dXTTNjZDZT?=
 =?utf-8?B?M042eGRQVG9SM2FNUFdocTZYL0phN3IyT2hSK3grcUtEYlZDL0pldmJUTFky?=
 =?utf-8?B?OEpKSjVEYzhtdi9BWVdnMnQ2WlM0RWViTzFOTEhRSTlhRWNmdHFwNEZQS0px?=
 =?utf-8?B?ODZ3bXhseWNkbmVuTXlCSnBhb1J0bTJTcUp2dHVtQ2VKcXRRWEZlWnRiRXIy?=
 =?utf-8?B?b3Y3SlRrNGZoeFgvWVUvSHF3TFZzOE45TGROZ2FwbkZicEthcVVEZkNsZXox?=
 =?utf-8?B?TURpN1hsMkd2aVBoNXd5Wm5ibnlaNFFQampwRitIVGFwQkNrK0RSNDRFNEYy?=
 =?utf-8?B?dGVMM2FNOEFuNU9lMkdEdC9pVnVnRUdDL3NDdGZNMlg1anAzQlhpNkM0RTZz?=
 =?utf-8?B?cVlwd0FQSWxkZ1I1UTFQMk1vdWtiUTVTVVplVjNkTHBBa2M4T1VyYnFqSHN0?=
 =?utf-8?B?QzFFRTVBblFSTmd6dElGYzNUMzJaM2J3aEtpd0RveVZCcjFYY3VOQkNlQkU1?=
 =?utf-8?B?QmhlZVBwNXluUnRiaVpsbGR3clZNWlJBOC9WS2s2VzFLUE40VmtrOENGRXdk?=
 =?utf-8?B?Mkh5VFI0Q09ZMjZqOW9UZzlNWDVMeWsyL1dOZ3ByQkpvUWZERTBpak16RmZM?=
 =?utf-8?B?TUQ5ajQwUmQrdHg1czUyOUtaS2szM2NIQ2k2RnYwNjl0TnBUSHdXK1psNlB4?=
 =?utf-8?B?Nmpzd3NwS1lIaVZSZW0wQU1WVVpsS3VtTVk4N0VmVUlhdjF4cS9ZOFl6dlow?=
 =?utf-8?B?d1lPRFZLUUpXbzMzQ3Z1ak4zSFRuN3E1RnVQV2lOcUFTSWg0NzkzREUxYUxq?=
 =?utf-8?B?bm5kTlhnN3hXMHh5dDdlbklXTUVvTy95Z2dYYUhpemtINzBCVyt3T2tDbWds?=
 =?utf-8?B?alE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 513c053c-fa64-47a4-a001-08dc8ca15674
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 18:39:34.9438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 75RPV/bPx9b9YvWGkyGD3yw+ERPquYx9R03Se8Y6NFDCGjWmzhzuy25gKJaigUrXX0ZgW/BcUbwIXKa3Z+0uKgWEJLGg5ZtxZreVhDw9p4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5159
X-OriginatorOrg: intel.com

Hi Babu,

On 6/5/24 3:45 PM, Babu Moger wrote:
> Enable MBA/MBM tests if UMC (Unified Memory Controller) support is
> available on the system. Tests will be skipped otherwise.

Could you please point out where the test is skipped if UMC is
not available?

Reinette

