Return-Path: <linux-kselftest+bounces-5032-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A8185BE37
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 15:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35752B23097
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 14:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CAE73165;
	Tue, 20 Feb 2024 14:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mujb6iD3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BCE71B55;
	Tue, 20 Feb 2024 14:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708438099; cv=fail; b=q/ZCiBT5FvwPZ18nzpK0zTKSbXNoE0IJqYS00c5dcov55Q+lXHAIFMlbIiJvDXYtDGiMer6XqF7ecKgtDAt6CKxLz0vMQytArbvMtgv7fykZuFYFDokr5IvCTqKJVywK8hRWJltb86iSy+BoPyGgVOmf08KlEir8hHb3cFbHv30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708438099; c=relaxed/simple;
	bh=qxvSG0U5SWaN6EtctWKJafVAICLuwrgQ1ytEXaCHS1o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lAQQBx/IsMP+Z3JeotFNZUKcErLfH870pgoY5uDXCgvEPdJEkYo6brNgCGO4HDeJ5/PV6aH0GrsYHTGeoMoRx8j7+1+4ZuT2FfpLEntE5MXU1l2rTeCqovyijey1ACP/P4EbLBm9CapYe0NaAGqXY+Si2i5TdWNShSx7BmIvmBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mujb6iD3; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708438098; x=1739974098;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=qxvSG0U5SWaN6EtctWKJafVAICLuwrgQ1ytEXaCHS1o=;
  b=Mujb6iD3e8BtPVAfT5jrj5R6MZKhasdhsV+aqk31RgD62oNQm+Cj0byc
   x5YGACVrqXTVcT+isCkoJWOzBe9hlOIwNM4ER3geUGf0Vzgyrwan69cd+
   suXO9C4vy5DiVlPrznULD9wukekY2tw+5XHeEVC7Qi6vC5UUPs/EOSr24
   8nYWd+rDCDFi9kslygHOWsmXQYqPrU5QqTmSHlFXqs509zBWsWHvfjeGt
   aaXzyp7oogJj4IndALA8NvBY5vPgaEpsftJjffOTzEWbFb/QQ6P7WlC3J
   vmj8lMCXhfrnrUH7TmtjOp0g5d6jvm8RwUOj36f60PzOG/a0SudA1gtFo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="13099323"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="13099323"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 06:08:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="35806294"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 06:08:16 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 06:08:15 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 06:08:15 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 06:08:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7t0GQX/BGi89lD2m8K/gNFyd06xhVNusXOYgsrrfXmG0TRHClD0ixM+wD4nEGDJ5Mh2GZpBm8s5C7+o8TToEbgnidsNWbx+lATiTF2MnxQ89ddVKmHYBx+6kcFFUVt/ARvkkkmS/QmoUKkymdpx7vewIg5G9wpM/2TZ/RyAukyS3msTZtO05v8FK52Uyh9NDChD/fnMJcImCU+v++eGn1DSGupe2B8LpoCXFhkqb4Jwy3NA6FGmeJDAvaENJlYwWrLMwv+wHXClxVoNygOQih4KKYelawTy62YODJGxe58VLz3SiUoHD9ifnWaU1SaxdAYX3nQncQhfXAx6vsDbAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3wj+yY6YdUkO/JR77bj8nKSPBNBm78Wyi7xlxOWWHI=;
 b=kN3dfCcxrWAHBEv5Px1UBhBTaw19XEvHw5VTC9PD6V0uZnYym+wV2ePLwVnHr9DJ3wZTGnZ1X1QqFWfIPmkmJUtSa318wU+2+HsRoWkK2/Sq9AD/UFl0smwyjNohgvewpNru4YOV9oNr9t3eEABC20vmIieQP84ZVfFRDO8X6QpZZnOmdNDPf8XI4GWVMtDeSoqZ+Z4HeZ7MBdWFrPIIInOOgrgRUkjg12eBrnylg1HBwXbelus08lft7VxTULq6mXZkQJtvweh9wrh8KezoOrvkbRQRbDJpIBD0s9D47x3wyFH3h2DrsB8/Dj5jUdjiq/vp606dQasnamjL7sJaHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by SJ2PR11MB7599.namprd11.prod.outlook.com (2603:10b6:a03:4c6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.32; Tue, 20 Feb
 2024 14:08:13 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::b2fa:6a11:bef7:179f]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::b2fa:6a11:bef7:179f%4]) with mapi id 15.20.7292.033; Tue, 20 Feb 2024
 14:08:13 +0000
Date: Tue, 20 Feb 2024 15:08:03 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre
	<reinette.chatre@intel.com>, Shuah Khan <shuah@kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 2/3] selftests/resctrl: Simplify cleanup in ctrl-c handler
Message-ID: <uck6k4upde5642uarjjyoeyt76ju7f3ympqbnugnv3ufaw65k2@wdh2chxqsooo>
References: <cover.1708434017.git.maciej.wieczor-retman@intel.com>
 <8c4fcfb6b4e38a0f0e400be88ecf1af0d20e12e7.1708434017.git.maciej.wieczor-retman@intel.com>
 <5f251bcd-a343-bb6e-a947-7605dc59f9ea@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5f251bcd-a343-bb6e-a947-7605dc59f9ea@linux.intel.com>
X-ClientProxiedBy: WA2P291CA0043.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::28) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|SJ2PR11MB7599:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d700e24-8545-42cc-c498-08dc321d601b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qZRceEj+LKHMftqSy+Xj3Oo4iLjOzj36Lvxu9rAoY4TrwHN7wx5zpFlMOxunA47PyfWyXtUfyDPh8JQ2DipjvhSKJqp6+Du9xGzjxVnZE+0VogfQ2MnkoplemVhxvbne3WoltNDlbs8J5qunEPC5/Jf5IAZFTDekaRxVOVYlMirFIhVNyazR4UV4FUbpoRjaTggkE6gIbbqpf5uu4e7a58tPzfNc3+yEpUf1fMKPCP3aPT1EQBvOVpSGQDaBbgNCUZQjHyGFe5/PvIKjvLjIy7m2PCBF6dYIhEt1yyINmta5ZSxL51rAWaoGFuJxxJwXkgQtP8W0IAXNs/Y97kAE+ivaJONyawPDDBF19hlpJhyrgEbdtGf9MBnSDMO3lHoCNVYNjTVEqCG30glcH/AisvoJLPZaLv2mr0Nve2D9bWA2SlDhxUY2zjWPIXCeibf+Vv6YSq9KP1uam92PdMFOO0T4JF9bfrvAobngPR3D5jiLedrGfjVIrSXX8QqGVnxfgh68kXMJg5uywB9dCWFUUEU/YQKTzSfVUILz6lg2GIytd0LclVTZigy1YCXL/Evw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?zmO3FydwVbOuB/3tB4Uc6H3JadeVYwzrtDqbVAzVnTPxsHWkmGM1nRxZob?=
 =?iso-8859-1?Q?AAARQY7KB10fEGrZO8h9wyhHVAFiOZct4KGRF7cqKgt47q1ZjCjLjSgUEx?=
 =?iso-8859-1?Q?HA0Qf7JG0cN9jtfE46hGKtPBndlmhO0Sdw263VeW3npHXXoMx/N49w7Dkc?=
 =?iso-8859-1?Q?OtjCHUwnuY8JkSTeFBQOxqBMSP7xItuBJkLYYlRVUST85ix/lL7U9w+k+v?=
 =?iso-8859-1?Q?jisitESVUFCT+baH43OIExSAM1T7Ib6YtwRp6bO6d6IZmG65VWSkBT3T5S?=
 =?iso-8859-1?Q?0IDPtaBMzHkiiF47vNYWs1MrVKHbDvlpHqENakEmEeFHL0M0iqa8eh/qX9?=
 =?iso-8859-1?Q?dPuoIyWL58+U8kogGkgZuy52FIbtl4h2dctX1pBx6P8L06LqtlBvDA4lAz?=
 =?iso-8859-1?Q?Hurb2NGM29O2y2VC9P9XB9avq1RmEvibcSigUVh0OmdvmE/60hK40V28rg?=
 =?iso-8859-1?Q?5FQ9oZ2dfp2Bk85a9bVm43sm6Yr6g2W83jOoBlAmuTBqzn2LXUOCkwWLIv?=
 =?iso-8859-1?Q?MhJ/kyYPNg/0QapH4EpqtYwmdxRt0kke3uYR8+SSlVxRY6JaEmwCZOCtrQ?=
 =?iso-8859-1?Q?wiaMJuI8T26rQYmJNWWaxmIsRoGxFK6TP90IytIAwQVmmS8xenau+sYbvg?=
 =?iso-8859-1?Q?eXfUnoYutg2DFKwRpZhDJ1SKn81fioyuoWV7eahtSN3CTQab+GKX+BB7bH?=
 =?iso-8859-1?Q?gqwS1X1HxKISHTCFbgcg/3EMKT0lDBEvV5xQx4v/OrR42dXY5v5YGNlgKN?=
 =?iso-8859-1?Q?kr1twha9LualjIp1u8jI4vP7yHOnMTARQhXEJUif0PZsGIM44v9BuFPPho?=
 =?iso-8859-1?Q?ruZajybk4c9KEqFNpVQoeeWlrCud34jH1A/U89WxE6pLwiA4CgmNEfiQmX?=
 =?iso-8859-1?Q?RGeNp0bR8H706DFMRSulpD3ZbyjBRFt1dlgJjDB3twvryj7WcQFnLRZ6mv?=
 =?iso-8859-1?Q?6E0uyfDHdqWBIna5nhS55qqEJOOsAE/Feu7xmsI4JBma/7br8GUnJ2Q+aD?=
 =?iso-8859-1?Q?frQExhGyf+ZLwMRZvm499AWLcVMMxfxocEmyDFC17MgU00BqbMA+QacCC4?=
 =?iso-8859-1?Q?v1ClWjtQIRotaGwfgOwhl9pqYc7CYScX12K7uixcjgvHX9SN65nE2eapb4?=
 =?iso-8859-1?Q?kuVFs6yvAqAkVWKRwKkOfvX1Qrcee5wQAjdaTXN59Dd2gkWdjZTYZcZS74?=
 =?iso-8859-1?Q?iRg0eKGADYQLFRZlOI/ytDM97OrbOmRTTqAeYPQnAUUL82clZr7fy6j51h?=
 =?iso-8859-1?Q?++hRMeCIuMjqLTEfUqAjQtTVfgb5Acz6aw2Aaft0JtKgRgOXwBYgO1Riy3?=
 =?iso-8859-1?Q?gQon5NXHQLAiEaqCRKfe1rBrK1bPusa9yUJefq+65dQX99UrlH/Ckkp+7b?=
 =?iso-8859-1?Q?XZsuXbj+YTU59zETH1CQqvtm1GXIAKVZ3r76x/oTaue09XMMCscWTR7C+M?=
 =?iso-8859-1?Q?aHHk3pUcnZUyK8sXCRR6FTTEEzm/EMv79q8CwvO6vt/XORcDsGho8X27DL?=
 =?iso-8859-1?Q?SqoV9d+LWxQLmYMgdd8qOLdmL1rU8QYVT5r61C/0dRyNhwV6DTzS2iJBXz?=
 =?iso-8859-1?Q?lMysUVhRSgR6Gw7NvJG0Gi71y7L51ILp/wDFVMenB3iG69AZJI/bd4r0e4?=
 =?iso-8859-1?Q?9mFXLEyRzxyVdbabAPaZ/rrk2oBcbEdZ53SxukskeLZfzHCE5aHlNgbiy7?=
 =?iso-8859-1?Q?NHTd3ujFemcHu/j9c/A=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d700e24-8545-42cc-c498-08dc321d601b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 14:08:12.9471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: itpdDqh1HLEHaFXviaZWPJkqJcQYZkIOTZW3Uc6m+HaNj7bYV1FOGCoI8pAjFo1CrqRs8SdZouK64GIZuYqtPXpXaSkpA1XYjjyngnrY/JQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7599
X-OriginatorOrg: intel.com

On 2024-02-20 at 15:45:23 +0200, Ilpo Järvinen wrote:
>On Tue, 20 Feb 2024, Maciej Wieczor-Retman wrote:
>
>> Ctrl-c handler isn't aware of what test is currently running. Because of
>> that it executes all cleanups even if they aren't necessary. Since the
>> ctrl-c handler uses the sigaction system no parameters can be passed
>> to it as function arguments.
>> 
>> Add a global variable to make ctrl-c handler aware of the currently run
>> test and only execute the correct cleanup callback.
>> 
>> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>> ---
>>  tools/testing/selftests/resctrl/resctrl.h     |  2 ++
>>  .../testing/selftests/resctrl/resctrl_tests.c | 20 +++++++++----------
>>  tools/testing/selftests/resctrl/resctrl_val.c |  2 +-
>>  3 files changed, 13 insertions(+), 11 deletions(-)
>> 
>> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
>> index 0f49df4961ea..79b45cbeb628 100644
>> --- a/tools/testing/selftests/resctrl/resctrl.h
>> +++ b/tools/testing/selftests/resctrl/resctrl.h
>> @@ -128,6 +128,8 @@ extern pid_t bm_pid, ppid;
>>  
>>  extern char llc_occup_path[1024];
>>  
>> +extern struct resctrl_test current_test;
>
>Why this is not just a pointer?

I tried making this as a pointer but the 'test' in test_prepare() is of type
'const struct resctrl_test *' and there are warnings about dropping the const
modifier.

>
>> +
>>  int get_vendor(void);
>>  bool check_resctrlfs_support(void);
>>  int filter_dmesg(void);
>> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
>> index 75fc49ba3efb..b17f7401892c 100644
>> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
>> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
>> @@ -14,6 +14,12 @@
>>  static volatile int sink_target;
>>  volatile int *value_sink = &sink_target;
>>  
>> +/*
>> + * Set during test preparation for the cleanup function pointer used in
>> + * ctrl-c sa_sigaction
>> + */
>> +struct resctrl_test current_test;
>> +
>>  static struct resctrl_test *resctrl_tests[] = {
>>  	&mbm_test,
>>  	&mba_test,
>> @@ -75,18 +81,12 @@ static void cmd_help(void)
>>  	printf("\t-h: help\n");
>>  }
>>  
>> -void tests_cleanup(void)
>> -{
>> -	mbm_test_cleanup();
>> -	mba_test_cleanup();
>> -	cmt_test_cleanup();
>> -	cat_test_cleanup();
>> -}
>
>This should be removed from resctrl.h too.

Thanks, forgot that it was there too.

>
>> -
>> -static int test_prepare(void)
>> +static int test_prepare(const struct resctrl_test *test)
>>  {
>>  	int res;
>>  
>> +	current_test = *test;
>
>I'd prefer to keep this internal to signal handling functions so that 
>either the struct resctrl_test or just the cleanup handler is passed 
>to signal_handler_register().

Okay, would moving this assignment to signal_handler_register() be okay then?

>
>It'd also allow current_test (or the cleanup function ptr) to be static.
>
>-- 
> i.
>

-- 
Kind regards
Maciej Wieczór-Retman

