Return-Path: <linux-kselftest+bounces-4147-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B80D6849BAB
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 14:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C325B2114F
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 13:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D321CD01;
	Mon,  5 Feb 2024 13:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z7J/uQ0A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D70728E22;
	Mon,  5 Feb 2024 13:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707139462; cv=fail; b=CFJQTZtJy02VA9P8Wohi6lAZK6lTDN/mhjnzhcNIHFBcGHiEiO7E2/vYgbotQdgvpCk+gtFMkVgOedsFo/xWbayLUSt2MZMZ4SxWFsaZIba6PUSo/gdWeCMKYwjHsAk8fg9WOskOorfrCtBCEjdlVAHBnSeFkSlgmzVp8bNeDZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707139462; c=relaxed/simple;
	bh=LSkn7S5UO2+iMwqf9i2RZRxBgDyX4F0n9zg59QY/LpQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OFOTJwmUuZau0jMYgXN0Fsb3OriATc7HfBRkvGAzZG1nlCWWVRIZGhWEkcPyxj+kOSOv5xkMQWingZGN8nnGElETtnKoERUVbGYnmsRSmvg62xwNBE5YvQxIMgnucYuWE6jgjS1e2eaSja/ODoFZ+ZebrSnGNXAT35E1MlScvX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z7J/uQ0A; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707139461; x=1738675461;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=LSkn7S5UO2+iMwqf9i2RZRxBgDyX4F0n9zg59QY/LpQ=;
  b=Z7J/uQ0AvNYhNKzqtfyEw2gCyUbrkVdei3L6UqpbiV03Tmv7ivrKRNFb
   JxbLL8D9A0RGwBRZzOwtx/XYKzb88KPvWNAOL08CfUk5lclx1W8loBhFY
   tgVyBkRX9y+unFe87OlCnwZwwBRNJ1Ekp800NrlejGcdO3OtxHj5hbram
   tsPLzkypA0CXVYRRWMusYH+4h/7mVz0rJzPkzGhs/QlIDroDxSaW7ktIa
   dk6FkP7H1YiXWQNQg3sSeQNlFsMOGbZwyvNCBRq/C09jI/yuo+EmKcBCg
   TlYaIDv3GcunGWN49X03hEYG12GnSw8TB4KADYh1WB/SOEAnfm0au9wKt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="11875525"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="11875525"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 05:24:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="5327826"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2024 05:24:19 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 05:24:18 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 05:24:17 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 05:24:17 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 5 Feb 2024 05:24:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3UtXuM4r6yk88ummk0jtuUfUVK4B8EJwHMfUNG6qSmJ0jntIS3TXLc86TcTbu0U2C1QsSFO7l6NRW7NylvdCcXn1nnRXZDjrUYob8oaAszrSnkp/s5doSRai2MXYy1IARNVGHZoZ4P1gN5N6iazOI+fatxEXdA2WsbjIhh4Mf9TyrItFlRdNWtz04nwi8nwi3DCiYappNnnK56FcBpdzUQS0jEC5Ms3XatAbjm4hXZJIzsS1qb1k/ud9GJxFX9VCfel0hCxPRTkslVKFFrpVkI+enRjJDrFbUWC0CfAtVE1aQt+BqGMRwKmCyja0GVsBOcVCg6DroKEUVQOS+9i5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPMCvkFBlQKeIJhtVTtWlNu8arSTsgFfAdzxXw4yeIk=;
 b=mVOuTrIM9jsCK8Wg2QhKfcQVfwxyknKn9kv/JdRzgPFpmitEPyyVvUPXZ5WFMaEWtDIjcF2sJvHEDJtneDINtcK+0zhFBFqBDp0pEWSlSaTgVfbYEmbvCd9W44x3ASGIfi2P4Qqj+14OKMvTNgTrDFFIaMk0k4/LTOh1RMjdwuyrBH11/wESIyo6XrCmJsv6a5wblneUELi1OGTygU/2dmHL1MtzTVVVvsLNRPtfQvmgBnQdISn6X7MMi5gi871IjJmTkWUZoL8l0hqliTm/5VKyPqd1hGlnHvEwvZwH7nlxnXhZzifUAhEcVSOcYvHDiKaJqh8tG9rXbxTFawROxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by CH3PR11MB8657.namprd11.prod.outlook.com (2603:10b6:610:1ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Mon, 5 Feb
 2024 13:24:09 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::c554:bc40:8b5c:9530]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::c554:bc40:8b5c:9530%4]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 13:24:09 +0000
Date: Mon, 5 Feb 2024 14:24:01 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
CC: <fenghua.yu@intel.com>, Reinette Chatre <reinette.chatre@intel.com>,
	<shuah@kernel.org>, <linux-kselftest@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/5] selftests/resctrl: Split
 validate_resctrl_feature_request()
Message-ID: <zo7bbgj4f367g6bxpgyqs4tmkwqzimjqgcrx32ywoylrsc7v7k@kkqaqby6fueb>
References: <cover.1707130307.git.maciej.wieczor-retman@intel.com>
 <e4b1887682e8262a3416dbd7bc63695af0d63ee0.1707130307.git.maciej.wieczor-retman@intel.com>
 <65652533-8333-064a-c446-95232c7da76c@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65652533-8333-064a-c446-95232c7da76c@linux.intel.com>
X-ClientProxiedBy: FR0P281CA0071.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::10) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|CH3PR11MB8657:EE_
X-MS-Office365-Filtering-Correlation-Id: c405975c-0c1c-46e7-f690-08dc264dbc5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MS0t/nuQsfPI8zd4tUPfJKphOiPgfYoZec8Y9rEi+OKZpfv9KW6Z2SjQq+7vYwlQ/ILZ5idTo1sgeRzwLFK6cWbLKxVDc87JWqNiI2q6DfJXaziRoXftTc2h+KlMJG7CdAzF3xdquf9nmljCmatBHmVJ+H/8yLKjmes6c9Zhr3RJxYyc8f9g6HULVzWNqRuM7UB7G5AZ1BuHdCtUGXglSZtsfx1GOv+6Ow2LiGWPlYWpbR3SDYocG8jvBJjMDWG0YCCNyMDI1mjANcJDnRU1BzlrmtPAwb5QlWKmjTmVNbedS2E3ILG/qNaMtl1KmribSLaY0GsC6b3ZBy6yCb4ATnSyEcFPylw3G1ObrGHT8fB+ZvAXCe9Od8qUwXYMULKRpVKsbuQpCekc70GO/sb0Q9+POEOH9FmGh4pNJAnQsADbcitcU/D+WRPJm9C0c0SdZG35vekzg/B7Hg1R6FcqcD7RQtTmbP6UHOtCtF2QuSkVms77Oz97nr/NKrPBzrbRh4BX1dXU+jT4n2ianpS6uhxRmAdX4Kc/+UD+znG/e4Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(376002)(39860400002)(396003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(41300700001)(33716001)(6486002)(966005)(316002)(54906003)(6916009)(6666004)(6506007)(53546011)(478600001)(8936002)(8676002)(4326008)(66476007)(66946007)(66556008)(38100700002)(82960400001)(66574015)(9686003)(6512007)(26005)(86362001)(83380400001)(5660300002)(15650500001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?YePVuwDHYnrUCDeEzIEKSFUNwEILr45MTUn6XNMF9J3/zKZCWbzIl+p/4P?=
 =?iso-8859-1?Q?Lkxz6Z1jJfLmL+PDsfpHierinBSTnrZraEaZzKewUc9HVqR7eEuzuEfRW7?=
 =?iso-8859-1?Q?XEIQHs7QOHwEmpQX3ub9BYp6V2yP5FukPELBpPYJQDa+frTT43fdAjbhUW?=
 =?iso-8859-1?Q?2uLBtfLh1VfPYy6PWI8CefTGkNk9P0fY+XhJ56halWv7nbls2K4qrIoCeS?=
 =?iso-8859-1?Q?aFm6o2j+y4+TZNmk29aHm8V2HbiYl8VroKJOwfzgFdNGUjGpfGbS0w1f43?=
 =?iso-8859-1?Q?CY5SmcIT6yk32vM5RQsMeT6dSZNcikjBjersmXPK3iZ7iFrFGZL9NyfRCK?=
 =?iso-8859-1?Q?84IQ4P7Wt4Rtqh50/rSS0+Q7vILPnRVCVMDJFK0XA7+GRrRccaQPwnOKGv?=
 =?iso-8859-1?Q?s3UvT6dn0PMmYbmTI4GrP/OElt+wgA8lseVmgXyeChCqk/Yo3DYXoTM01T?=
 =?iso-8859-1?Q?+v/vey8RGwkbYU+f7WYOdw0gmC+UU77afyVs9gPkhRVFnl1sR5C601oq1n?=
 =?iso-8859-1?Q?N7PIqeLsS/y9QZj5yhiLncZBosy+V4oOBLoMBbT2jbrNemQM9qL+/QpyRw?=
 =?iso-8859-1?Q?xYnUdpIHR55V82incBRdhZvUvuwMUNY9AR2D2kJ7ewT6zLWD8rgd53L8Uv?=
 =?iso-8859-1?Q?Ke5Qo5diy9g21A3F4jtTj11V3sTmDPWivrxTWefmYoC74LtqNZlk51/TQS?=
 =?iso-8859-1?Q?V82Ci8xY/3yvbOaFpao2PeA5QI5B+CXb4JtVDsLq58VOHTQu6el5IsE3W5?=
 =?iso-8859-1?Q?kyq7p2jnsZcEnk7VRkzK42uxdg94v3PcCnFixGf5mrj4o9kTgqh4SM1p7T?=
 =?iso-8859-1?Q?QfEhNs360J+lQJxiLFCtOtdhVBYrhOkPhP6NiFcoD+7zvPzNhP9WFt45hZ?=
 =?iso-8859-1?Q?KezITvfSZaaiB+u33OMRTHKw6SLYEegn5EZwaTZBNXQJoAdVHZNAEkwlrh?=
 =?iso-8859-1?Q?ZV/ACdgrCdeniCdQwfge5R5va7YaTv014nT+lYQ+xdImCnmLu4XynM18Yg?=
 =?iso-8859-1?Q?fcWmRj0ZY7P90+Ip1a3El2XBZdf/IhL6YAZSb4XBBBCKyILvm9L4bdB4JY?=
 =?iso-8859-1?Q?N/VwCSDpyK5ArY9I4pbBUPdEK5mqzKReHZW+KyjMX66w8DBsZJu5G/mHhJ?=
 =?iso-8859-1?Q?zRlOTwdKwzfvd1qZqxJXBfvXqg1eepS20rKoXPkAzhgw2g59jklRc6htib?=
 =?iso-8859-1?Q?RQiEuUUDrVnEYYwO0/UCnQn/DzuWorJoqVrr18VF9vJkZ0tAp0G/n+E7cf?=
 =?iso-8859-1?Q?Ll5m4NwwFWsRnCaXgp0siAaivdexuN4k1yLAMqfJdTikkDFhaa+/dtxbl+?=
 =?iso-8859-1?Q?XR7xYRErlrRYbf48VfYSD8cVQP15j3ONQ1lvGJxMkRUdHG5IWXpYZ7EmKm?=
 =?iso-8859-1?Q?MJ8xxssUh+H4zBzeiG19gHL4GxQ6jKc8A6B7nw7HOLBMT3DFdzNYcPtMr1?=
 =?iso-8859-1?Q?XhZrARToKPir68OtFE8OzRHgOhBHdScJTqdDUP8v4L1JVtVH+7sDJUSr4Z?=
 =?iso-8859-1?Q?9GJsHR7jdhupgucChQFgmbD0hlLO6g4S0PIu/izfk3CqaPTu344WZu1Jnq?=
 =?iso-8859-1?Q?yLywkawcgfeCOBQbKIFfhUqmF6qdkf+Kej0WPmi/bGpYcEGO1UwjagCELL?=
 =?iso-8859-1?Q?ZTuQlQlIHd3QhJZkeB2r6Y3yEG9tRuHC/reJHQI4qAMf8sjn4JhBiqpoTM?=
 =?iso-8859-1?Q?NNH7NHqn+I4/cNqYMgg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c405975c-0c1c-46e7-f690-08dc264dbc5a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 13:24:09.6256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8GpWlcQqLHjuxv8RawWI9hu/DBMIsMUsyz/YrqgYhKWDRVqfTt8Wk7r5x/uSjiqY0Bbc8LXffd5TriKuAVKRRwZZaS/lnQllkSIRzUmLZXU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8657
X-OriginatorOrg: intel.com

On 2024-02-05 at 14:41:30 +0200, Ilpo Järvinen wrote:
>On Mon, 5 Feb 2024, Maciej Wieczor-Retman wrote:
>
>> validate_resctrl_feature_request() is used to test both if a resource is
>> present in the info directory, and if a passed monitoring feature is
>> present in the mon_features file.
>> 
>> Refactor validate_resctrl_feature_request() into two smaller functions
>> that each accomplish one check to give feature checking more
>> granularity:
>> - Resource directory presence in the /sys/fs/resctrl/info directory.
>> - Feature name presence in the /sys/fs/resctrl/info/L3_MON/mon_features
>>   file.
>> 
>> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>> ---
>> Changelog v4:
>> - Roll back to using test_resource_feature_check() for CMT and MBA.
>>   (Ilpo).
>> 
>> Changelog v3:
>> - Move new function to a separate patch. (Reinette)
>> - Rewrite resctrl_mon_feature_exists() only for L3_MON.
>> 
>> Changelog v2:
>> - Add this patch.
>> 
>>  tools/testing/selftests/resctrl/cmt_test.c  |  2 +-
>>  tools/testing/selftests/resctrl/mba_test.c  |  2 +-
>>  tools/testing/selftests/resctrl/mbm_test.c  |  6 ++--
>>  tools/testing/selftests/resctrl/resctrl.h   |  3 +-
>>  tools/testing/selftests/resctrl/resctrlfs.c | 33 +++++++++++++--------
>>  5 files changed, 28 insertions(+), 18 deletions(-)
>> 
>
>> diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
>> index dd5ca343c469..c1157917a814 100644
>> --- a/tools/testing/selftests/resctrl/cmt_test.c
>> +++ b/tools/testing/selftests/resctrl/cmt_test.c
>> @@ -170,7 +170,7 @@ static int cmt_run_test(const struct resctrl_test *test, const struct user_param
>>  static bool cmt_feature_check(const struct resctrl_test *test)
>>  {
>>  	return test_resource_feature_check(test) &&
>> -	       validate_resctrl_feature_request("L3_MON", "llc_occupancy");
>> +	       resctrl_resource_exists("L3");
>
>This not correctly transformed.

Oops, sorry, I'll fix it for the next version.

>
>> +/*
>> + * resctrl_mon_feature_exists - Check if requested monitoring L3_MON feature is valid.
>> + * @feature:	Required monitor feature (in mon_features file).
>> + *
>> + * Return: True if the feature is supported, else false.
>> + */
>> +bool resctrl_mon_feature_exists(const char *feature)
>> +{
>> +	char *res;
>> +	FILE *inf;
>> +
>>  	if (!feature)
>> -		return true;
>> +		return false;
>>  
>> -	snprintf(res_path, sizeof(res_path), "%s/%s/mon_features", INFO_PATH, resource);
>> -	inf = fopen(res_path, "r");
>> +	inf = fopen("/sys/fs/resctrl/info/L3_MON/mon_features", "r");
>
>This became less generic? Could there be other MON resource besides L3 
>one? Perhaps there aren't today but why remove the ability give it as a 
>parameter?

During v2 discussion [1] Reinette made me realize this functionality only
interfaces with L3_MON/mon_features file and the 'resource' parameter isn't
needed. The 'mon_features' file is only mentioned for L3_MON and I don't know of
any plans for other MON resources so I assumed it doesn't need to be generic.

But sure, I can make it use a parameter if Reinette doesn't mind.

[1] https://lore.kernel.org/all/2o7adr2cos6qcikcu7oop4ss7vib2n6ue33djgfeds3v6gj53f@uu45lomrp5qv/

>
>
>-- 
> i.
>

-- 
Kind regards
Maciej Wieczór-Retman

