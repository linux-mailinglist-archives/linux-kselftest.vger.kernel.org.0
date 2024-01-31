Return-Path: <linux-kselftest+bounces-3820-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B7C843BD5
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 11:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 570721C26C7F
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 10:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE98269D28;
	Wed, 31 Jan 2024 10:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VOfljFt9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08A669D08;
	Wed, 31 Jan 2024 10:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706695573; cv=fail; b=kwpJtstpwgHXoGCF6alfKcEIjPz+tK6MPznRZR4kaTV2J4rnyrhobTKX89McMdfEgYVZ5f/3PKSkGe8+hkAJ4NYfFYIRjFCTf6rcF5dPTHNIEzfFptx4gXpnfHWu5BvFvYnBIQCZNJHcyAgoB7RWBmJ6vjDqFHbhzkOPicqyAk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706695573; c=relaxed/simple;
	bh=2PGeXFF1AsFbLjYHI9UA7MuiT7HIDXq8qyQFKihYLmw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Cu472jDA7Q/RAb+A8rlpgdwQ6RYmq2Qb3aSyXq5fUptZ+vEhnKc6+mlDetfKV8MHYbzv9bOlX3PQ6HSQOqGlkRWT9GEeC+wuczvcVAEhGb/oPxgltQWe+rTWGJoXMMoTdS6s6pcL10bySCirXg141XzFiLmw1mqqEEC0D5rVrGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VOfljFt9; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706695572; x=1738231572;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=2PGeXFF1AsFbLjYHI9UA7MuiT7HIDXq8qyQFKihYLmw=;
  b=VOfljFt9Wj8wnXQ057FTdB/FgdtXLPJB+88onz08X0juuvW4462R3QMv
   sV5MlFWpPlAm9vQRFhUViIqdldnCxpCs3KCIZts66l97yQKGOM+OxenmG
   6TZwhvPCj5PecbfEYZdvNAFvJbhdhBqavnWPEoYBdbVrvokrbXbD4K8yv
   E95vZVUlIsvk3gzpr1tX8POai7/3YLN2yEvaUTIXTu12QnS6Ld99iXp0e
   0O0e+sVRBEeGeTp1M+Ar3W6qwj5nTFUcOhEf5Ey+Ou0XdsvJhoWIJb1ee
   hfDLok6+aMWzVwPYXwQkxcWiTsGJK1l5qoZGH26z6i0+EzZ2H8XJ9wpL1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="16935142"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="16935142"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 02:06:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="788524992"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="788524992"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jan 2024 02:06:07 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 02:06:07 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 31 Jan 2024 02:06:07 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 31 Jan 2024 02:06:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bhq2Nv5lpzUfQnWRdWNj3CTUUirVd6DvdrYHvYfVo9iOCfHEoLTI+ViCWnvGs9lSAW0Ni9R39ZOZI0qHTKNOP4AJ8fhnMfOqGZGx/iy86D7IEo+RLAFpFGQ8BBcerws8HKlK6r5TKP9Jn3meCNN9RQl4RlMJ25NRv5NfNOrVoxXc+IXfQYRD5tcVItF/+48v0A6yJ+riJ0JS1XDEPldUiGoqXj/D+3w2+RE5QtH62nhpvMItI7aBPud1wPkZmujeMb5QrZSnFgFxCqmd1olPNJiUG1AV0CSDH8ZtCMSkar3ckFxj34CvuGuyYopxVHK1z2CpkkjOePbiw+03peIcSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/WBTxESdCnt8KhPNCgHB/oaLkUeTv7HwmoDr6NJbXM=;
 b=msRHXb5ms5ij96bbJPUZaCfyzkPmi2c/6DEGaeid2G+tkURD7NfAv7NIaVbePFcZ6IP/rEWKc7OtMxNUCcFe8UJAzuq26PKcsFZAeh8xmoJOySq3fWOWc5Y8GX8bSuulpgh0TtYzVLoYohklzmkiWLbjpElBEt7ySvSOJTCcWRv2BQRY+MDozzF7l0bk8ykn3AREL9K0/6l6pT692EEFiYv3Q21MylUdf2Gvc3Jle7DTSGmFxv7N0PKe/H8IZ/lk05hLbrg4pc1GY9/n7re+jj6uyom3eCcps8Wi9dBJhQc9uQftv+I3JGSn1iEo0vRE/cnQAf3EARQC8KPGIib/2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by CH3PR11MB7764.namprd11.prod.outlook.com (2603:10b6:610:145::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 10:05:59 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::c554:bc40:8b5c:9530]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::c554:bc40:8b5c:9530%4]) with mapi id 15.20.7249.024; Wed, 31 Jan 2024
 10:05:59 +0000
Date: Wed, 31 Jan 2024 11:05:50 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
CC: Reinette Chatre <reinette.chatre@intel.com>, <shuah@kernel.org>,
	<fenghua.yu@intel.com>, LKML <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v3 3/5] selftests/resctrl: Split
 validate_resctrl_feature_request()
Message-ID: <imaqlenxrw3rfjlwlfnyhs4cc4cf2c7ibid7r7jeuqu5brsqdu@xpngruljfhrs>
References: <cover.1706180726.git.maciej.wieczor-retman@intel.com>
 <415cc65c113143c833ca2eaacd3a03c285c2e841.1706180726.git.maciej.wieczor-retman@intel.com>
 <62310cc5-7756-61a2-9529-8ae0fc247c21@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62310cc5-7756-61a2-9529-8ae0fc247c21@linux.intel.com>
X-ClientProxiedBy: FR5P281CA0056.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::19) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|CH3PR11MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bd478a0-2271-4552-36a1-08dc22443903
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ezuv6sN29UIc46bH18hQ7acr9Wu/BNDvMJcnpgxmULzdR2w+mDYNpzfjAJ0awMuFDHxAqHnmxls++oea9IDH8vG5tfRHWiLHr2eBR2itJcYIiekfreWk8eInkyklED2XlLTBgOhbGo/MTYb/N1zcT3Dmy2cEFQrQ3k+ny56VFmA6AH/ZKLLLWNy8AXhzxifGWPnGz90oGG7NTOje4fNw9KgnVu/Ka04Nylqgm85UL80IiF1Pg3IQ4oiDkOKf2ih2o8gObc0FkLUscApGoydXrJ5wjkndmWLPbbUhq0tHoh8pZq68b8jOlJJND/cf8JcQa6JdPTPC1y9CECej6Kl1O9tduNlV1c9MpVHZM8+CTPojJxtU7kVW+lqM6uqjmnIxcCk33R8dmZIetY14NmHHJvr+iPeDTTGTHgwQd2jNcP5TwZ5sJtacPvW6xtFySPh9rDD710rTHAjgQM3vms/UJ/xrV80oIjlPaN4pnTX+ocPw7Gbr6ADX59270M9FFO1bZmarftEtL8DRXTXzuDZCQYPQaa9mtakCfUKpstYR9UbjVCRb8HgQWdPhhGxnxsv6GG3BNjOIyzQmlItEUrRzZZ5cNiCdSanV2SEaDu43XE4UtdosEEZ9i2Bwou9qtWUn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(396003)(376002)(346002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(41300700001)(83380400001)(86362001)(82960400001)(66574015)(26005)(38100700002)(33716001)(9686003)(6512007)(6486002)(6506007)(53546011)(2906002)(478600001)(6916009)(316002)(66946007)(66556008)(66476007)(54906003)(6666004)(8676002)(15650500001)(4326008)(8936002)(5660300002)(27256008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?AHibciji51ZvMjWyYWw2dq/u92rCy0yfqAcTl+KVTqd/LNx1gBQgDZdvSB?=
 =?iso-8859-1?Q?5D+KNvqSJxpfIJ9NkGX8jHywe05kxS3J0vPqitbW9BzGSdbF7Tpywa+IJN?=
 =?iso-8859-1?Q?cfq2qoaJSC0vS+ryYpI18EZJXZd/HL+JyXvy7XAo+8vDL8pr5ffqoDeuyM?=
 =?iso-8859-1?Q?AlvMCdxpqDbq1fjG3O20g6/jeC9gJLD+cu8eh9I5NTkfWAw0hVW7tvdXI+?=
 =?iso-8859-1?Q?qSktQGV98ZKQSf4/uDHGlwLUfUVWcI8jPvgIyx4v+8aAz/U3YfzpMmaUlG?=
 =?iso-8859-1?Q?jqnT8caHB6SVFhwCD8o1HXlvePbfzcCAG99Of8FXz4HwmL5KYQ+wctGUTl?=
 =?iso-8859-1?Q?WSmmpcCUDhp77KdFFSQjqd/4qVpABwrOKRoeOR3bGlXEkIfwuQkDjv/w1Q?=
 =?iso-8859-1?Q?CMuB1f+H6WPfM2nDja3eL1tloefHY4e47gKaeIvZLJaO0OgzBXhVnf0xgr?=
 =?iso-8859-1?Q?SeJH/S4xmBWAxiv1dgm8us4GashDpHYkxS5wcF9yC4Ru/+6zq+RHJ6h+nQ?=
 =?iso-8859-1?Q?HH6bBpnhfmQnMqgdoRKMfgb69aRvhnYPk9BovSb1uDPPJwAk6Sd03QdG7m?=
 =?iso-8859-1?Q?etrtg1AlA8ZHXUH2P95CF5xmLME+5VB18UxBkJbwer8Pq7ZpyeNBP4puZF?=
 =?iso-8859-1?Q?ZaZmPeoIPBcITWhcZ14Qv5NK0I4VN/V3JrhzvtN0UU++gX9vfCjjruH+gK?=
 =?iso-8859-1?Q?76PA3UFaI/OKfqnQKhkknLdXSuyp7q3X33Japww/JKiXTX7xryO8iCRD3o?=
 =?iso-8859-1?Q?AemfFEr/jsi9njkuXyrMKx7JcqsJhOm+D+4UU+08GpT8t9t01isEbcokFc?=
 =?iso-8859-1?Q?/ZDkVJvpEUdjbQhRcrCLT9t7qUIZIlZFjpIDSfKbRbJBE9gSXrLawig3MS?=
 =?iso-8859-1?Q?kHtSxtrr5fP1ON7yp4zI3JTxTnG/1vKW/kQWXbXWagaHLZavaQgxG5jDWk?=
 =?iso-8859-1?Q?8JXy/FHMV6DWT42ZNyKkQdCkWVNDE9oAGt3xLtb35woaJ/7s1UODeQ7c9D?=
 =?iso-8859-1?Q?EAIGhOWaT2xdvfHKrrzRCPWoygC1LivecbFM4IlreNQnRT7amBpJJijKGp?=
 =?iso-8859-1?Q?JoXIlRL/P8B+Is7p9rpTxgpJmneVt5Q2zq9tPv8y5YtkKPwWFEZbeLE+Gh?=
 =?iso-8859-1?Q?Fr+mlIys0NFpQOgUGCkncBgdoVjCNenFe8eA8xmDzBfyGf2zVmRnl2pfMs?=
 =?iso-8859-1?Q?pPqVtk7HKxdAV/1TAIyDg/UKu+MEJ6Kt8WEx5e7rAt/UDQ0vkB26hRifN8?=
 =?iso-8859-1?Q?nQGPr/AADQzpZChqU9OFnbjrdKMLwJ1KmPgLSyvs5xYP2ZzLn8IN3dxQoF?=
 =?iso-8859-1?Q?n5vSIbT69NYJDuWRMNO7cE9ubwKCss1VXlGr8PyL5m5XobrZ8JPV0u3ZeR?=
 =?iso-8859-1?Q?r+Kf2mj0O7ea1BfNuEj9repP7H+m6P0pOYtfcsuuEOFTReJ62Qz7kuRS17?=
 =?iso-8859-1?Q?jlIeI9UgBytZkxbGDhFveqTRbUcKaw/CdoCZjxqoQBvSNjVjVS/M7WAqX3?=
 =?iso-8859-1?Q?dRFXib+oduF9Mw/i1jUd/Vu1K2ms9NYNytjJw4Vgzv4C1gSGZgT+6yph+c?=
 =?iso-8859-1?Q?/p/GyLdAKxeSIaafGTyljJ4YMv4J6ryBysHB7M6K4LdyvNYWEp7uXg9jS0?=
 =?iso-8859-1?Q?2JYOvPtSnfSdAAR49yhCqVKTa9MD1D3rr8w3qhumgdgryvDaGDQAUuYVr1?=
 =?iso-8859-1?Q?A1iO1h1AgfxaJkTQqQE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bd478a0-2271-4552-36a1-08dc22443903
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 10:05:59.1525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3dz3rjScslaE/cdPuz+U6rGNDVA/N0NsiraUp5yJh4fJ4JExEB0fiWB1m1Y7ot2pb/F7dZ0YAPdz5uEgOgv765ESGXTMzkfb17OuUusRQ34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7764
X-OriginatorOrg: intel.com

Hi Ilpo,

On 2024-01-25 at 13:46:51 +0200, Ilpo Järvinen wrote:
>On Thu, 25 Jan 2024, Maciej Wieczor-Retman wrote:
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
>> Changelog v3:
>> - Move new function to a separate patch. (Reinette)
>> - Rewrite resctrl_mon_feature_exists() only for L3_MON.
>> 
>> Changelog v2:
>> - Add this patch.
>> 
>>  tools/testing/selftests/resctrl/cmt_test.c  |  4 +--
>>  tools/testing/selftests/resctrl/mba_test.c  |  4 +--
>>  tools/testing/selftests/resctrl/mbm_test.c  |  6 ++--
>>  tools/testing/selftests/resctrl/resctrl.h   |  3 +-
>>  tools/testing/selftests/resctrl/resctrlfs.c | 33 +++++++++++++--------
>>  5 files changed, 30 insertions(+), 20 deletions(-)
>> 
>> diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
>> index dd5ca343c469..428de9df81c8 100644
>> --- a/tools/testing/selftests/resctrl/cmt_test.c
>> +++ b/tools/testing/selftests/resctrl/cmt_test.c
>> @@ -169,8 +169,8 @@ static int cmt_run_test(const struct resctrl_test *test, const struct user_param
>>  
>>  static bool cmt_feature_check(const struct resctrl_test *test)
>>  {
>> -	return test_resource_feature_check(test) &&
>> -	       validate_resctrl_feature_request("L3_MON", "llc_occupancy");
>> +	return resctrl_mon_feature_exists("llc_occupancy") &&
>> +	       resctrl_resource_exists("L3");
>>  }
>>  
>>  struct resctrl_test cmt_test = {
>> diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
>> index da256d2dbe5c..e22285b80e37 100644
>> --- a/tools/testing/selftests/resctrl/mba_test.c
>> +++ b/tools/testing/selftests/resctrl/mba_test.c
>> @@ -170,8 +170,8 @@ static int mba_run_test(const struct resctrl_test *test, const struct user_param
>>  
>>  static bool mba_feature_check(const struct resctrl_test *test)
>>  {
>> -	return test_resource_feature_check(test) &&
>> -	       validate_resctrl_feature_request("L3_MON", "mbm_local_bytes");
>> +	return resctrl_resource_exists(test->resource) &&
>
>I don't understand what's the advantage of converting away from 
>test_resource_feature_check() in CMT and MBA case?
>
>> +	       resctrl_mon_feature_exists("mbm_local_bytes");
>>  }
>
>> @@ -756,7 +765,7 @@ bool validate_resctrl_feature_request(const char *resource, const char *feature)
>>  
>>  bool test_resource_feature_check(const struct resctrl_test *test)
>>  {
>> -	return validate_resctrl_feature_request(test->resource, NULL);
>> +	return resctrl_resource_exists(test->resource);
>
>...The replacement in MBA open coded test_resource_feature_check() 100% 
>and CMT even replaces the test->resource with the string matching to 
>what's in test->resource?
>

You're right, I got carried away with refactoring a bit. I'll keep
test_resource_feature_check() for CMT and MBM. Thanks!

>
>-- 
> i.
>

-- 
Kind regards
Maciej Wieczór-Retman

