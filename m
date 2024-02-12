Return-Path: <linux-kselftest+bounces-4494-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B625A850DE1
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 08:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAF711C22866
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Feb 2024 07:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BDD747D;
	Mon, 12 Feb 2024 07:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M8nyrYr2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EC979C6;
	Mon, 12 Feb 2024 07:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707722178; cv=fail; b=sa0+KXYq8Yt7H3YZ353kR92JwWtT/cmAOuzQm8QaHKmvbFTy1tWKYeSwslcbkAA43AOAT2z/33Eo/tfDxoYqjnTEa4vexWfixRuYpGOb3XIhI1G8O5Qftv4b8zUbvmcMLkU5rtEDoqJDGf/Lvl+RglgxbTMUYhEJB+M2ItOl77o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707722178; c=relaxed/simple;
	bh=Pgl7Idl91aXuIa2eebWu3roHDpqYeGNnbe8wG8ah9o0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VU/9N8krOGpSdNzxVsxXN6UarKiIUbT4DG42deYoi0d2H5PtmiR/MF1GhtllEVpmKluLNRTFEx1xYr1Jugn4sjqaV98o79qjm/fqd9YlDSErHsxheH41sHk3V1rzhGlUAaXff1yGCQVJPwig/rf0mpvXkBtfUp7HYaGW580b5eg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M8nyrYr2; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707722177; x=1739258177;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Pgl7Idl91aXuIa2eebWu3roHDpqYeGNnbe8wG8ah9o0=;
  b=M8nyrYr2vrv/nsfeFTiPyTECFYBn/uoE470OnrqiGAwX5dZz3k4YTaLB
   fg8Df9psKw/keLVDVH8DZvJfPjiDkJcQJZP1nFNNdFQsPnjE7EqUOjRJZ
   RnRm83cv4Js4L52MXZYS52gKuT+ddmsk1VZwRRzzyiIAXc3yOTTAOaMvG
   75CQN6SyzBB1XcFM5C79KDaiirGJjOMBSseka/PHMLm/fJB1p6/vnzaml
   JLwxlzqdofVm7j1kKB0z2EvpjuBJGIuC4E4hxzqHjW2WnD5445H1Ff93f
   1fI6R/sTUoXhT3QdXJNRWcbYdKu09FaWR9omiW9qbkdVugyoB91LiP/JO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="12773490"
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="12773490"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2024 23:16:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="2830371"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Feb 2024 23:16:15 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 11 Feb 2024 23:16:15 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 11 Feb 2024 23:16:15 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 11 Feb 2024 23:16:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOt1JQiHHaheOmdpBTIoU8wiiAYQo9NF9u41GgbXFWB+ai+KRfMjkvr/uQL8WLNyaaT5upacaoQkcltOAec4l2x8/pAiuNBxWextIoaOrYQlr+x3r5mlhXwEjcSidS+sbRNRDigGFisNvqbxe+Hu3pdoYrVxRyN/4UhHIY9MxHmooZJ5jDRBDn0dBu03u36HPLEYcf2aDXBguj4ZebyuDYhp4iRKMLdZWuTLIUK4cpIQmuwgCAEKgAF3YU1YU3M2kuD7Dgr67y8052zjKGydQ4RA8/Zz/V69XDjmGpKcLBHWOHvG+pEMcc6Gs0k8pTg2Zuxutgk3sigfSbkVqT7T3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=horCdcEqE9jEvB+NIJdaBFFm+JAcemaIVDgwmtfWeOk=;
 b=lSZx7BntUn4VByYBVyen/xDx65eaXN9C1qpd2+VgkqaiiWUkmjHBKFiFdsdNjhA7zp3uTUlOxSMW6fSo8Dz6EKMkBT/nzKBhdxN743agt0CWMcryxKAzIeVfYs317yhi0JWVzzuJOjsWds8M/0sSRYxzDuBKIiiT2OCq0rdYlbtpVyIs6Q5IVyfYSATtQ+a6sgI4krMJ+8VYYNybfvAm0u3ndpBdPfUjsKadHykA6uCOirVlvd4wfhC6vq3H7Stft4B7JwWSb8ZC8cbuxLl5kYwCasfoo9udjAHVWdTRaZ+j5jF1/yD6198woSD219fQT/UugeXVLiPmaZutUFwjLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by CO1PR11MB4788.namprd11.prod.outlook.com (2603:10b6:303:97::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Mon, 12 Feb
 2024 07:16:07 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::c554:bc40:8b5c:9530]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::c554:bc40:8b5c:9530%4]) with mapi id 15.20.7270.024; Mon, 12 Feb 2024
 07:16:07 +0000
Date: Mon, 12 Feb 2024 08:15:58 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
CC: <shuah@kernel.org>, <fenghua.yu@intel.com>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v5 3/5] selftests/resctrl: Split
 validate_resctrl_feature_request()
Message-ID: <ikd2opu75n66j4a4rafz5garz2kuozssx4v73legg3prsh7m6n@v2frrzizkjgt>
References: <cover.1707487039.git.maciej.wieczor-retman@intel.com>
 <f914c55b9b9f635cff082b0b4a8b636598580821.1707487039.git.maciej.wieczor-retman@intel.com>
 <f65f7c8a-e2d8-444b-abbc-d28eba0f86f5@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f65f7c8a-e2d8-444b-abbc-d28eba0f86f5@intel.com>
X-ClientProxiedBy: FR0P281CA0226.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::19) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|CO1PR11MB4788:EE_
X-MS-Office365-Filtering-Correlation-Id: e8496a22-d461-479a-81de-08dc2b9a7b6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ywQtMA1voqRJajhMYNRaFT5VgJetH2AlxSp1rU7DPQuy1Op/FkEorFaK8kX54OEXERhHgrZpvLWLYxR7gea3U+XIl+gK6voJAwCDkcE2w9YwP9MC+cJg9BIe15GV7J2n4ZfVzdq7Ed1eEe29JbtSLIYhnVNLcOCOoxsyaVI992hJWpQ3PvAEslmZBRH6ianHNdPHfoNScGLv8DlCiwfDuFjbTNiF0TcC4dAbEXxIwh4EsQYwV+tVnyanoTh4symvd8qfSMzOPZYwiceOIPskK1a0XabeEdCpajz79t7hEyc7fqvDyPxkfZ0Kz87XAjU1sIiQCVpwSWlxMrx0EPRLAb1HMEyr2PVmmagpyNrHPa2GFhSxpvFXjNh+6m2heUQUFT5m6DFJqjcrsbwXUXD7RD+SMl3Rw/yqBilysZFCTjcJrrkw9T81vqmcqi3bpqzF6Z/SanrRj9AqdfbKDNzoQQCmVKJJbyvtssGcB9CgX9s/zYGhJtniL/REE7L3l3NrhhL/+kwrXxpUbCvXbmXzEgyhyA/gmnqMJOdo8tNC/LDp7v53AdRAhaio80W1wAvF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(396003)(346002)(136003)(376002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(2906002)(6862004)(8676002)(8936002)(4326008)(5660300002)(15650500001)(33716001)(66574015)(83380400001)(82960400001)(38100700002)(26005)(86362001)(66946007)(6636002)(316002)(6666004)(66556008)(53546011)(6506007)(66476007)(6512007)(6486002)(478600001)(9686003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?h2L7k0mqnPy0V8gSs368U1dxwTTmY7UcYk+T7ijEnKnRCZtMUzpBDUquyp?=
 =?iso-8859-1?Q?8L43UnnYB6DjFaraZ+BmylaOrQEZFX3jDDLw16sQ6lKfOSIn0oFmjdXsZF?=
 =?iso-8859-1?Q?LorBKyBstcPC6nKnukbGGGV3vPC3QbowVarQjUlc2xsm88yvpq6ncA04kX?=
 =?iso-8859-1?Q?t7x0FlWdbDAjjiDXJHXo8/HLK9OsJM22RMz/0wCdRlO0D2elvxseYwxzpT?=
 =?iso-8859-1?Q?C1RuedYCBz7qxfCZHCx6nlck3mP8f51X/vsr4z/ywabRE+Y7L4dzJcNIiU?=
 =?iso-8859-1?Q?I2PsKC/5LVzW9d8Y7oesq2eKtkKCbtCpaCh3lgSDXR4mxPLDC0bVWNWEI5?=
 =?iso-8859-1?Q?MuLgu03pD+IuB7Uxy+FtxNh8l3Q/Dfz7V17f+VoNVOucvG8GMzvdU1j/jb?=
 =?iso-8859-1?Q?yy6xSnjxCQJI6dIPHDEPxC8YKCwTdkzLtszKrhX6H792awkY1zckPgsGY/?=
 =?iso-8859-1?Q?NS23He+1Eje2WI6xJIrwmhcEN+DnE10Lj19t8Afb2BQyWLmIxD9/XqPGzr?=
 =?iso-8859-1?Q?wZVdTrkF14Uf+MTGDmSI1HkRjC3ys5v9j59rA0OD5NcyohbsfYcjVRdxcB?=
 =?iso-8859-1?Q?WVR0e6KjKWTYIVEo1/YihhkThZdR5tV6sSrD7J7oQh3+ly0sVoXMLXngNG?=
 =?iso-8859-1?Q?S9zAF96Dh2QLCeGIPY1PyGaYbmUdtTxZyxn0rgh7CtWWmIhCi/V5cDVW9J?=
 =?iso-8859-1?Q?QHg5Y/BDSoIoEqwCH1fB34qEVo1VEsieAUqIEbcQP4tVKSHdb1ZVJU+Bu+?=
 =?iso-8859-1?Q?gUdRDC1WRf9Z/OdC4nQH0QlpXIPkBDWx4qrUjR3/Fz4vn65KPuUMefSlJz?=
 =?iso-8859-1?Q?ukedTIwhKSEJzY0Vc2hI8b1r2ehVVQHEH5vwyeyHAoofv4bqpcEqcuTutp?=
 =?iso-8859-1?Q?OhMgx5yfUiGw1N1eztaJ/KeFQGZd6VvN/9GG7nleS3aNDtiga5bSzYSkPI?=
 =?iso-8859-1?Q?qSbtBBdjD4eXQ36VKke6Qo01qsbRhgX5hZg4lyIxrZGmimojv4VYlrDWMW?=
 =?iso-8859-1?Q?bMtEB/tdhL1Wc6+QxDPb9rXx72FxA0IyswVb7W9wUq2FfhsKwWDU8H53JW?=
 =?iso-8859-1?Q?h8BR6wPKxi/MmH2s/NDqMJLHC6tZijlK8Im35eNaSwlbTQ24XSu7QkOVRJ?=
 =?iso-8859-1?Q?2zqsZ0CTBqMog5icTMd41YQiRitu4eOgtXq/2Y3pHV9rslZERlWOvZ/hKz?=
 =?iso-8859-1?Q?KXT+xSCn4QNTrdlEgN4b/LX4T72hXmU3Cb5vKyYbqd302woEuMrEIXqQ4a?=
 =?iso-8859-1?Q?D1G8sL5S7rSbKrBOFq/Ndh3fK1d3y5iFtNRh3N6wIyhaBNwU+hSI07K/uC?=
 =?iso-8859-1?Q?fpgZE1bMmfFpXl1hbJDsNG2LrDCtDF0JMbvsVyDUwLZiy3jYJCzlg2Y0k9?=
 =?iso-8859-1?Q?sgZv6tQQcDzszUr+eN0CNXXpC9r0OwizX/93NtIyM21Tjt+t6Z5RLc4DCV?=
 =?iso-8859-1?Q?IxEP0VzwCp1nkVEUA1YV7Dw2M8gvNak1xfjDzQ4jzwUpbd2p4yQwjvPjkG?=
 =?iso-8859-1?Q?nHk7LvCkf8o567ZPxbJkltMieWy4n3/i6SnCuDwzozRH+mGMBBcq4LlkQA?=
 =?iso-8859-1?Q?ryDT3u15D/zdVM1GSY+pmMwvOz2xxm/jNWA9Mzc40AKrWLJrQEI4MzEef5?=
 =?iso-8859-1?Q?pRL9sctYl+9YL235lHqXYzLHTcUMsqoIzcqska5iSnBkS0DhfyGWLz+/sI?=
 =?iso-8859-1?Q?I5o484+r7lmW8LukN64=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e8496a22-d461-479a-81de-08dc2b9a7b6c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 07:16:07.7474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Khh5TrvPhP3A3IqnMjold4DiMIABl+vGNYUjdbavh/0Exu65iTNfz1kbdJUgWqKLJmLSbLqaTBjXIhdT+ZYYPWISlL8zuGg5C5Q5tmVEw7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4788
X-OriginatorOrg: intel.com

Hi,

On 2024-02-09 at 09:20:27 -0800, Reinette Chatre wrote:
>Hi Maciej,
>
>On 2/9/2024 6:01 AM, Maciej Wieczor-Retman wrote:
>
>...
>
>> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
>> index 5116ea082d03..f434a6543b4f 100644
>> --- a/tools/testing/selftests/resctrl/resctrl.h
>> +++ b/tools/testing/selftests/resctrl/resctrl.h
>> @@ -136,7 +136,9 @@ int get_domain_id(const char *resource, int cpu_no, int *domain_id);
>>  int mount_resctrlfs(void);
>>  int umount_resctrlfs(void);
>>  int validate_bw_report_request(char *bw_report);
>> -bool validate_resctrl_feature_request(const char *resource, const char *feature);
>> +bool resctrl_resource_exists(const char *resource);
>> +bool resctrl_mon_feature_exists(const char *resource, const char *feature);
>> +bool resource_info_file_exists(const char *resource, const char *file);
>
>Portion of next patch sneaked in here.

Missed it, thanks for pointing that out!

>
>>  bool test_resource_feature_check(const struct resctrl_test *test);
>>  char *fgrep(FILE *inf, const char *str);
>>  int taskset_benchmark(pid_t bm_pid, int cpu_no, cpu_set_t *old_affinity);
>> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
>> index 8a183c73bc23..af4f800ab23d 100644
>> --- a/tools/testing/selftests/resctrl/resctrlfs.c
>> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
>> @@ -708,20 +708,16 @@ char *fgrep(FILE *inf, const char *str)
>>  }
>>  
>>  /*
>> - * validate_resctrl_feature_request - Check if requested feature is valid.
>> - * @resource:	Required resource (e.g., MB, L3, L2, L3_MON, etc.)
>> - * @feature:	Required monitor feature (in mon_features file). Can only be
>> - *		set for L3_MON. Must be NULL for all other resources.
>> + * resctrl_resource_exists - Check if a resource is supported.
>> + * @resource:	Resctrl resource (e.g., MB, L3, L2, L3_MON, etc.)
>>   *
>> - * Return: True if the resource/feature is supported, else false. False is
>> + * Return: True if the resource is supported, else false. False is
>>   *         also returned if resctrl FS is not mounted.
>>   */
>> -bool validate_resctrl_feature_request(const char *resource, const char *feature)
>> +bool resctrl_resource_exists(const char *resource)
>>  {
>>  	char res_path[PATH_MAX];
>>  	struct stat statbuf;
>> -	char *res;
>> -	FILE *inf;
>>  	int ret;
>>  
>>  	if (!resource)
>> @@ -736,8 +732,25 @@ bool validate_resctrl_feature_request(const char *resource, const char *feature)
>>  	if (stat(res_path, &statbuf))
>>  		return false;
>>  
>> +	return true;
>> +}
>> +
>> +/*
>> + * resctrl_mon_feature_exists - Check if requested monitoring feature is valid.
>> + * @resource:	Resource that uses the mon_features file. Currently only L3_MON
>> + *		is valid.
>> + * @feature:	Required monitor feature (in mon_features file).
>> + *
>> + * Return: True if the feature is supported, else false.
>> + */
>> +bool resctrl_mon_feature_exists(const char *resource, const char *feature)
>> +{
>> +	char res_path[PATH_MAX];
>> +	char *res;
>> +	FILE *inf;
>> +
>>  	if (!feature)
>
>Now that resource is a new parameter should it be checked also? It is not obvious
>why only one parameter is checked.

Right, I'll add the check there.

>
>Reinette

-- 
Kind regards
Maciej Wieczór-Retman

