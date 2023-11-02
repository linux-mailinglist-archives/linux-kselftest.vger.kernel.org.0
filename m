Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A4E7DF91B
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Nov 2023 18:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbjKBRrZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Nov 2023 13:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbjKBRrX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Nov 2023 13:47:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F591111;
        Thu,  2 Nov 2023 10:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698947238; x=1730483238;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s6re4iezuwikdPWnFspnwcOO7MRghLZNU4ST1uadiK8=;
  b=hCLhUuAfD2+rScrY85mC8+/EBDD0o+bAccVH9HLhtipNuXj5w2A+Hp3C
   W+oqu202DYPyoSY2PlDaZXq6rC5sInueWxVaSMocj09sPltiMDrE2Fpb7
   aEJ7PGUyqR6D8NHw7R5xDHcRmkcvJ26lyK3MBNTtT0bVarwvVMGdxC0sC
   zImxwT4SZ0GP7RGHiHXPZQu36NvxZRVV0ttoXIjgFIPqs4G/k0xb39R1B
   4mwpU2lAYeN1nbx7wNs+T2h6wbBUvPVOVU1MeADm42tXH4wd1GMM2Xdg0
   nLK3ZrTO1o45wS4CWV3M0HYFj2OjU49Iqb+4RcS3Khskw6dWO56m5OADr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="419880057"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="419880057"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 10:47:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="884961908"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="884961908"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Nov 2023 10:47:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 10:47:16 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 10:47:16 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 2 Nov 2023 10:47:16 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 2 Nov 2023 10:47:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c67+PCSwfC8hvnnsjy7sG3kuWt5mAivzDE5BdFrQ9vxkUc1sZdYrgAlnN7rZZBpdgynX9xmtNHYzj39/w0xg7u2QfRqMeE4ex8wlZKmVSJjQa4oa8lGQhi1Gfgn3E7DJqGoPJOOlVBe7lSuOI2wSWPr5svlbILWJA7GoH/KtmAv2ieMBj5a7q/vAfdrqe/7FXBB8jAyfUw4N/oBEX6zBBqVmodgqvtaZR0Dvox6v5FP4i9FLmBplu+Uo8W1YEScUP+mXdPHfkQClUxodvGU0lQ+vUIaAf6Q9/pES/2BiHQfHXtp3e2j9Sc6U5WE86ISExV2hO4bonok+jP/BRRvWMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4ircPJEp6fsduzuTS0eoFcDyYo15fxf2dO6MCfNLmQ=;
 b=Un4AwJSI62Xz6uZXBjqCh22GxET0kduip2sStAQKse57P5vBJdlHSb6RozDfm2Emmntu0DFZbdFshtdiEsw39j5x30IlWuryPa142ozrW14qNh5R3k+ixByzreC9orMiU58wMLre9g4eRGDrWz/+kRnVtk83ZB6N6TT4F7tExxwrkZki/nvAwqGufs38lLu1n9aRhu5Ap/P+FUTha/PzomF2yHrJktkyuZQpVU0t2EDe79m+oBvN9OdiMgRIU1QJtJG/ZxnD3PVnyCNxxfRZJkTitAJ1CclWZwyzp8EI1KLnMf5g347OPwiWzdupwqLh9GZTkX79633MtlFaq9QBuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB6857.namprd11.prod.outlook.com (2603:10b6:510:1ed::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 17:47:11 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 17:47:11 +0000
Message-ID: <575b4c53-34c4-48ed-906d-b9dedb80e0ef@intel.com>
Date:   Thu, 2 Nov 2023 10:47:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/24] selftests/resctrl: Refactor get_cbm_mask()
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
CC:     <linux-kernel@vger.kernel.org>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
 <20231024092634.7122-4-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231024092634.7122-4-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0314.namprd04.prod.outlook.com
 (2603:10b6:303:82::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB6857:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d7dc331-3848-4723-7f9d-08dbdbcbbd9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EmKnlrAPuSsBvyfs/AUk0FGhll61MQHphb8MLDaf78RoJE4KQNQogrPAo4LAo0gE6y6ddEx9bcuPs3tcZgbbU4t0/EyGaQ6tr5CpC2C5MVZsgn+3CEYrUDDSg4xLOJSjNK4CavusURzq2OifTbZI07N1j2+LWOfl7rkg64w3B7pnjE1u0DHoyXncR5STLx8P6j6H0j1bPZ2ySfgbTwKy3oPWqg5ZmxEmnGI2rsRHwexjYw58vrRM7EIQauVEywhfdBxKYbIN2jy+iXH3Y2x31b1Dm8PPRh+eXU17wS84hwgQ+cASO7uTw5B6otHyMOGykqK5oraFcsaSEi8A28WxpHkK1DSu9ErS3GAtgpTYlNwGI2QOc43jRaHekJW06x6uqyHfV5v9/uPGww1SPJcLtirfPx2kE46gH2uuuMBbsW6V728TrusTUq+zlbnNLuiEanxnoyJqSJYSW9HINBeDr6JrYUmRyPzB69qNe4olXKMljy4mPmxZYs/BezlELGR0yPP2DNZ28RGTnd6bk2YGuCStdXB4gMbUv/gWn+tM4yib24gsYKG6cmqfQQcQk+I//NHl41VbZj+v9m7GQnUx152eUJNybzJXxhvwyH0dEjTPGN7yIa43/11BU3fY5qAunO9+oCh6thSF3CZGZj29vw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(366004)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(478600001)(6506007)(53546011)(83380400001)(31686004)(38100700002)(82960400001)(2616005)(66574015)(6512007)(31696002)(41300700001)(86362001)(2906002)(36756003)(316002)(5660300002)(4326008)(8936002)(44832011)(8676002)(66946007)(66556008)(66476007)(110136005)(6636002)(26005)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnFHVkQzam1LYlhYajRBV3VmZ2V1Y3JsTFRtWnErWVBHRGw4ZjZ4dGVsYUJs?=
 =?utf-8?B?YmtER1VXZ3pmUE5wWG83VFpsbWpEOUsyQ0Fqc1AxRFBhQWRyMVdsVERzcmlM?=
 =?utf-8?B?VHJCNXUyejZEVlVsQTZSSDJYYWxOaXQvNlFQL2xBaEptNzZzNExVM0JEbGFt?=
 =?utf-8?B?ZFlXSWY0aGpwVVVvTytIekNsS0lja1FRYjkvVVYxa1RyaW1oWGQzUjZocTdC?=
 =?utf-8?B?TkNlVmhMUC9ydjlSdTlxT3d1dW1tUmdubDhLZGh1K3VOcXpqZ0NEK2p1S0kv?=
 =?utf-8?B?M2oybkhGYmhBOXpDNHN2Z1FQa3FrOFlrekRnSUlvLzJvckFvOXFZcFl4UEJL?=
 =?utf-8?B?NVJqWkczeWoxYkFJb01RaW9nOG5rdUlYVmFFbm9DR2dTVkJsQS8zUzdoTzdC?=
 =?utf-8?B?SGdiL1RXUXNMcmNCYkVqQ3hUWU5BMWIzbFZqS1JqdUMvUE5vdUcyQ1JmRm1n?=
 =?utf-8?B?R2FnQVNYOXNlUHBtSEg0YnZVTTN1QXYvMWE4Q1BtNGlRZ2YrZGx6WnN3YVNa?=
 =?utf-8?B?dmdIRnhEZnJUVW9ETFZ5UDErTlZLMkZzdDk2NTFxUUhoS0F4Z3U1T0hJeiti?=
 =?utf-8?B?TTJTNVRxckE5MU5NaFBpQ2J6cnJIOExnMjhoeVZFVjNZVlVmZFBzOVVQbnJ2?=
 =?utf-8?B?WlFsb0IySTlqRXgzYXFxeEFUTFZPMlhxZndzMHh1K1dyTVNiOXBpaUdLYTVr?=
 =?utf-8?B?WWx0T1g0bkZnK21BbnlsN0pmc0NIaW9iMzlCOGVXMXFtb0lONWhVdXZGMEV1?=
 =?utf-8?B?OXRBc21kQ0RNTU9vM21RaXM4ZHppanZDUTIydkIyaEZ2K2pLeWl0SlI0RkZV?=
 =?utf-8?B?R283M1VmbmVkRDAxTGZkeVJld2hPa2ZEVU5kUVRVMU1pM0hxclNESWxzTzYx?=
 =?utf-8?B?eThwUi91QzZTWmp1T2tVaDIyaFNZSDd3V2g3KzAvSnhidXJnK1dkYVVJZDhs?=
 =?utf-8?B?cUNoTi9PdWZnUHo0Q3lyWE5Fb2E1dEhPSVNDQ3BDbWRYbzVRMWMzYVkxNnhi?=
 =?utf-8?B?UkVGOUkxVVFwYnRlYWpSYjdtUTJ4SWtWQ2laeFplc1ViLzYwRlZaenYramRj?=
 =?utf-8?B?TVh4c3c2SWgza3VmU0V3ZXpvejNuZU01S0FCVkJ0L2hjdUJIV0hVZDRZYnQw?=
 =?utf-8?B?VTZUdG1lYkhlTW9iUGZnZUtCZlBzby9CTTRpa0t2eEs0eStYV2lMNVZESGdq?=
 =?utf-8?B?WFNhaHlJWXpuYm5mRnRhNFFYL2VIMVkyY3FSTktOak5lZS9uNXpuR1V4Tkl4?=
 =?utf-8?B?U2pJS0pycUg3NnoyK3N5eVVxQzhLK2ExbFhsNk1ibCt2T3piYk85dGd2Rkhp?=
 =?utf-8?B?djQ1eFFYaWRKUVFvemdjdGRESTViU05JVmx2NnkwbGlqY1o1N3BRL1pJZ3FY?=
 =?utf-8?B?MjVnM0p0R0dLWThIcDV6YnpPUTkwb1VySmdwbElVZmxEdnpFZEJVWEoxbVVT?=
 =?utf-8?B?VEthd1U1cUVJU3F4c2ZzeE5SNkxxdERpcUh3WEpCSmxCRlc4Q2pNVkdaa3Ev?=
 =?utf-8?B?Q1Z3TWVYQzhhZGpYZC91VkMzRHBCL3FSYm9vYkxIcWpnNEVNcWtsSWlrWmd3?=
 =?utf-8?B?WFhNaHRoQU9adkM5dDdhbDM4WmcyWWV2ZlRzTmRCVnVIR3ZkS0lUQ29HdDlY?=
 =?utf-8?B?L2VmU2piMjBpVkNFS1MzaFY4NiszTkJ5c1BGYWVkZlZwbmhWRUlLMGpwZ25D?=
 =?utf-8?B?K0lrb05VZ2VOS1lvMEJIMzhybnVrR2VtbFFxemk4UzlIVE5ld2djZTF6R1lE?=
 =?utf-8?B?ajc2bDhxeTJQbmQ0MXZCQ243eGxDRGtxeWx1Uk0zeHNDdDE1OFdoR3FSK3Zq?=
 =?utf-8?B?emM0ZGo1UG43MUxqdC9FTW8rWTVSQ0tCS09wMTZzNEpwVVNIajZsM2xtL2N5?=
 =?utf-8?B?NDJYSVZDTnhuWUF4eUI4V0I5b2hpazJsMVVTcGthaUU5TlFORGd2MmhYQWNp?=
 =?utf-8?B?bEpGa3hCczhTWUg3L3QwcGpDeUpQeFN1N05sZkpCVEhQL0xTdXBmN0tRMFhL?=
 =?utf-8?B?WXpaUkNIQzc1NXNyOEFDRmJlS1ErMzV2bUl3akFmVWwwYjlnTGhkdklQTkJC?=
 =?utf-8?B?K01saUk5VDFBQThrOGs5TG5jNEtUakdwWDZjc2dsZFZUdzZRSmpUK3cwNzRh?=
 =?utf-8?B?UHByQTFRZFR0MldRYmExRDd0YXJnM25RY1pMSDJ5VysyZlFNeGlhTklvMFRU?=
 =?utf-8?B?eUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d7dc331-3848-4723-7f9d-08dbdbcbbd9f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 17:47:11.1003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tl8+8S0JbGsmYvrBDdQFU5Imd1dWpGI/A2c8TMWRACKSLZqlxBdLgrZMqkE6nncAOcsYTLGwD08rzSmjda1D7kUWyXI1POmkLYcXtNjyCEA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6857
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 10/24/2023 2:26 AM, Ilpo Järvinen wrote:

...

> @@ -229,6 +228,31 @@ int get_cbm_mask(char *cache_type, char *cbm_mask)
>  	return 0;
>  }
>  
> +/*
> + * get_cbm_mask - Get cbm bit mask

I know you just copied code here but please keep an eye out for acronyms
to be written in caps.

This needs not be named to reflect verbatim what the function does.
Looking ahead I wonder if "get_full_mask()/get_max_mask()" may not be a
clear indication of what this does?

Something like:
	get_full_mask()/get_max_mask()  Get maximum Cache Bit Mask (CBM) 
	@cache_type:	Cache level(? or should this be "type") as "L2" or L3".
	@mask:		Full/Maximum portion of cache available for
			allocation represented by bit mask
			returned as unsigned long.
	

> + * @cache_type:		Cache level L2/L3
> + * @mask:		cbm_mask returned as unsigned long
> + *
> + * Return: = 0 on success, < 0 on failure.
> + */
> +int get_cbm_mask(const char *cache_type, unsigned long *mask)
> +{
> +	char cbm_mask_path[1024];
> +	int ret;
> +
> +	if (!cache_type)
> +		return -1;

Just to confirm ... error checking on mask is intentionally deferred 
until get_bit_mask()?

> +
> +	snprintf(cbm_mask_path, sizeof(cbm_mask_path), "%s/%s/cbm_mask",
> +		 INFO_PATH, cache_type);
> +
> +	ret = get_bit_mask(cbm_mask_path, mask);
> +	if (ret)
> +		return -1;
> +
> +	return 0;
> +}
> +
>  /*
>   * get_core_sibling - Get sibling core id from the same socket for given CPU
>   * @cpu_no:	CPU number


Reinette
