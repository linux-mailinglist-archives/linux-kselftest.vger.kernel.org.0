Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449FD7DF933
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Nov 2023 18:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbjKBRw2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Nov 2023 13:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbjKBRw1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Nov 2023 13:52:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07F5186;
        Thu,  2 Nov 2023 10:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698947541; x=1730483541;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lg3uvcVT7bmuiL/PtFsQQrijb0AjLHtzA/6IktEN+2A=;
  b=UVj9Zxr/upCJis4Miodv1ntTSrrsAgihm7x9envQREj/3HChX2FFnv9u
   5jBaz8wO7M3EOztuc/fQN4txJRSCTw54ULu9pKQDumNuYQkB+M5pYLQh/
   LbXpY7gSYEo5L/ppPhSxQ4645lsciZPzLacs53vXcd+brM6hZ8ECzDn0h
   6ueumx4CALdGkyIFu7/kp5vhGz5gy2H9WhJcinJ39bk2EK4tUIWyrDgfo
   k5dOZdw+2JgpSO5R0trSeZe0aiF4XafNqhQDOh/6oIa1R6/EcNvZvT0IF
   YysTt+hGaZT57W+N/kbv3Gn1zD+Y73Nt6EkpPxDd7PaMv7h5WVzWQik3+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="7413659"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="7413659"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 10:51:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="2631872"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Nov 2023 10:51:54 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 10:51:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 2 Nov 2023 10:51:52 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 2 Nov 2023 10:51:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcKKuru2JE+mVlWAQzSokXTjrDn2xvb93ZFnFv8q8g2VA2ZD0Yq7+Eq50d21cOma4mZ1fC/uTpG6ODIAh6GWNCOYJMSZIaou6zIgsHmFT0ws3ST6lw1zhF855l+Z2KxLS2q3jod+vO0BXqwFZALECk5i/FVdJLj9yksDLm5rvu8S8RvUDUE5CRFJJkWUVhcBXWKDe+ku0D98MPzlFuLOJcBjeZ4mt4dPGI5gW0oBMjIyxsYyGM6inV40Rt5WEurjZbHBAhmJS8q7KCgdzP65vqayuCdBVEEFTZP2okWL9mt5OqV/6HJWFAFnBvrCpqVHKBQn1SvQ24a430cMA01JPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HakhhWJ5/4RwJ9BYo1W/mI8OWtFeFFHSaa0CKPoURf8=;
 b=D14VLadBG/rtAO2b6h9Oqj72siZrT3pRIFZQQJDwca6G2dUJMX7LNVmU3xAH0fJkhufBNiJB5Y1uN/tFIFnd3q4MlcDc/9Od4ADElHF/RvO6kmk9NUHDlHryTBMiZUp6AWDyemi7YOHmU0sAjsLd3mo0vvoRfZF9lJhkxLcJCqD0OEhmBPmDqa/crMvgqCUjsOl16AYKmXaF/UTKUOZJQmbj1JttOXl0i5TOKRo+0GA68UeenLRpYesASfOCne9mRe1X7PICWJ3wkUplTpTojXfKfTczefsXQ3oJKXu4Ol1tSZ6r3rL6kZaIJQHkGd7RX3UfhtmwA/3UXmVAiHt9XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH3PR11MB8361.namprd11.prod.outlook.com (2603:10b6:610:172::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 17:51:49 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 17:51:49 +0000
Message-ID: <d22a4ce2-9e81-4d65-8381-e5ab5fa706ed@intel.com>
Date:   Thu, 2 Nov 2023 10:51:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/24] selftests/resctrl: Create struct for input
 parameter
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
CC:     <linux-kernel@vger.kernel.org>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
 <20231024092634.7122-18-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231024092634.7122-18-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0359.namprd03.prod.outlook.com
 (2603:10b6:303:dc::34) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH3PR11MB8361:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cea3d09-a2e4-4077-6cfe-08dbdbcc6366
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UdBjXui75AugWnhHuMB6Xxd4wroiyVj8bmHd1uBeBuV4eHhZCKgCL8KIwgz0S3C3GAV6KOYtPvVVfEwv7yXus+h8SIT++x8+gj9Qv2HSE44HAB83lendjLpmgeJwe/++vqDoSm4qcjBtFgkAVzJIDo8EGuaXGWLHQJcucOH9Sv/ybjWOIFqV8bkUUsL6BjQ/BIATQsNXuOj3HZbq8sQJL1+2oK9IjY9dFx9AuPD0wXJIQHySlSAX8jaTMvhVncqjsiYpHrKeZkJMeYPtnyMYz7QmlJ+fS9NacrkqQWpDSx9cefbqBklq5KADbvHNwUaEx9WLmoIaNAnX3L23lm2Lp8uzzzPmepHMus/O3XUTygfo9w1BABNCNNAnKAJQMOW4X9ZmOzUdpiynPPDk5/SbQSqgi9fJGUznkPn6a3TxHylwMt23/xqAifFVoXUH6rUh0P6ALrLHrMAcC1m/aTvkJLZNFBOvmMIwOicglIAZDJ0l9xTcp80P3R5I2aMvQ36SAcSNJNPwXZOopC5BerU5FByGr6mHmpaxuVzrjoOjv6WVgd/aLNOQN4+f8RfU2OkDN0HzD9t7Ushgngc3ttPnwy9Bl/a93Erdlg1p66Ccvruh4hLoOmmWwSiDYAT4zxHAhc61Ygu0dTNaMchNGEWARA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(376002)(39860400002)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(2906002)(36756003)(6512007)(6506007)(53546011)(26005)(86362001)(2616005)(31696002)(38100700002)(478600001)(82960400001)(41300700001)(6486002)(31686004)(316002)(6636002)(110136005)(66556008)(66946007)(66476007)(8676002)(4326008)(44832011)(8936002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFp4NDhYd1F6bFdMTElwYVhMcVdhbFgvZG0yTVhhNU9oZys1K2VVTkVTSVdR?=
 =?utf-8?B?dHgyM0JaNVBnVFVzV3EwOFBTaFY3dEV6U01KOWxTMHJ6U1N2NDJ5dTArbkIr?=
 =?utf-8?B?T29XY2h2WjVzS3J6TmhSeENmTDluQXh5dFR3RW5VS1c3aDh0cFhBTE9wZzNY?=
 =?utf-8?B?RDNjMzZpeWZxT0JabW1qbmdITit5eExJRmJmWnFMMm9EVUt4UUphYjYxN0Ni?=
 =?utf-8?B?VDBCMWIwcTFvVzVWb0xuM0FhYzZsUDNOb2RZRkRFNGJSTzA4VkxST3lLQUh2?=
 =?utf-8?B?UGJpRWV2VEhlNjlEZzJFeDFRekljeHZGbG5FVnp4S1FKZXlZRm9IN2Z2djY4?=
 =?utf-8?B?M1grOGJCMzhwVEVsT2d3RVluR1M3VGRvTUY0dnpJUSsvb25zY25USmp3VTNh?=
 =?utf-8?B?UDJZbVMzN1Nya1VBZ2VXTDVWSkRmL0l3UTdtNWVqWUpteWV4SVBWdEFJNTNt?=
 =?utf-8?B?REc5cnJRU21rSFA4WGR1NUZWeDNYNDNwbW5EQlhmdnY3ZHhYdC9lblpJbVlR?=
 =?utf-8?B?UzU4b0RNU0F2aEpVMG9TVG9oLytTWWl6NTlVYTRQNnhJcWZ1Q3YwU3krc3J1?=
 =?utf-8?B?RGJZZDdEU2RxT0RiMmFmaHBudnBaZGMyYXZNc0h5M2JPK1lRZDN6MHQweVNF?=
 =?utf-8?B?WmM3d1liRXlPNEFuV1l6VDBUR2dWWnlQdDZNd1BiN05Wd1NVdE9acGQvbDRH?=
 =?utf-8?B?REREaWR0OU45SlB0SmRKWkc0MGdIQ2dpdzdFZTFzajNtTkVFcG51dVpSQWxh?=
 =?utf-8?B?YjFIRnF1ZDI3M3FFMlc0K1RNVjZ3bWlTbmxCRWtiQTBIenhaSVprU20vWktG?=
 =?utf-8?B?MHNFWkhOSnJIZFFsWmZuT0FRVVQxK05QZFlzOUJLUGNPTTZQVktUSEZDZEw5?=
 =?utf-8?B?Y3lpTGpjU3l0T2RJMkZjd0E5UnNxWGpaWDlZeExNV1BldlhhWkdvRXlLYW4v?=
 =?utf-8?B?OWV3SGtZbHdvWWpXWmI2d2Izd3gzVDh2MnpFemVkN1h2WC9USGFBUkMxTDQ1?=
 =?utf-8?B?SytuTzdoZFFYaGcxdmRYSHpyeGRvV2hHT2ZvOEgyNHlLNzM0Y2hPMG9tRW45?=
 =?utf-8?B?ZVVkQzFQbXZ6NEZlU3Z2MnkxbHNMT2VSU0dOMk1vSUJ2UTJoaG1yUEM5Mnhm?=
 =?utf-8?B?MWJuZjgxUk84bjAxbHo4T2ZheS9wQjR6WkZwcHBTL0RXYnhxdXJja2RmaEpx?=
 =?utf-8?B?L0F0TWgrMmg2bWZTZDd6VWNFS3JqOExiYWlIV1J6UUtWSW1mTWVmQ0c5cFFW?=
 =?utf-8?B?WTZYUnFoeG83aHNPT2puV0c5aGIwRnAzejJEam0zRWhRL1NwbXhzWVpTNTV3?=
 =?utf-8?B?bnM0SmZ6MGlZWXlDY2lsbHRaVnNpNmVvR2l0TW1RVnRDVitDZnNNWityd1Rv?=
 =?utf-8?B?Y1dBbStMZjlsOC9PbWx0RDJOcG42ajZlWG4ySUdYZUpKMVB2VEJncUZFZEFv?=
 =?utf-8?B?eG9UUUMvc3FBblhTWjd0R0VuUVRaaWdzcXl0UGRhc0NvanF6TU8ramorR2xC?=
 =?utf-8?B?YnU3UGpPazVqUWgxeWpRdndmYlJ0V0tyL3dIRDBmSE1FSEdKaTZGWWQwVDYz?=
 =?utf-8?B?ak5TeGZJN2JCM2ptTStSR1loYzVjMWsrL3h2MXNNR1Q4eHlJSVl1Q1hBTGNt?=
 =?utf-8?B?Q1pOL2pqRmhPKzAvT1R1bWpWeWdaOWo5WXlwSTM1Zm5teExGYW1TWDF2b0RP?=
 =?utf-8?B?WG1yRzBkaU1vOGRXNTNDdy96S29CZFNMQTBLTnAvY2FtMVorNWFmay9xY1VK?=
 =?utf-8?B?d3ZtQndVSHhkKzNEV0M2VEkwQkt4WnpLeUpJcmROTWZlMmM1ZUlEZ0wwanVO?=
 =?utf-8?B?allUUFhmK3NWWE5pci9oM3dmL1ZYZ2UxYW84T2dWVTF2d1pVMWNlRk9EUlNC?=
 =?utf-8?B?ckdWVGNTaDV3R0o4SDlTMnFDMU9QcTVraTMwWU1aaUJPK1pxSjRqanFCc0Zx?=
 =?utf-8?B?MkVjQVRxZnlFek1BNWJ1b1N5L1pmN21ZUW52aUprVisrb092V0Uwa1Z6elk1?=
 =?utf-8?B?QUZjOWpSYVp5T3FWSkZ0aXk1S2o4VHdXY3FoTWtxQlN5SmRwRllwSys4SFps?=
 =?utf-8?B?ZU84ejdQN0RYUG9DT0pHVnJHSVdPaitlMmFRRVV5NWhZejVJdXkyTVBuLzJ5?=
 =?utf-8?B?UDlZbk1vd1JLeE03UXp4aGFpM1VSLzdUSkpWakJHUUpseVFheHRQTWlxMndK?=
 =?utf-8?B?NGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cea3d09-a2e4-4077-6cfe-08dbdbcc6366
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 17:51:49.1926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aqjjmay1dP4kBhz4VI8yjay57B4CvSwycEnxUUOhaOhhOlnu58nl60BQAR7Y6eZLQMmQR14u2cQ+s30l8t25pY7p6RtakweS1WbKGlN1dlQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8361
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 10/24/2023 2:26 AM, Ilpo Järvinen wrote:

...

> diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
> index d3bf4368341e..5157a3f74fee 100644
> --- a/tools/testing/selftests/resctrl/mba_test.c
> +++ b/tools/testing/selftests/resctrl/mba_test.c
> @@ -141,13 +141,13 @@ void mba_test_cleanup(void)
>  	remove(RESULT_FILE_NAME);
>  }
>  
> -int mba_schemata_change(int cpu_no, const char * const *benchmark_cmd)
> +int mba_schemata_change(const struct user_params *uparams)
>  {
>  	struct resctrl_val_param param = {
>  		.resctrl_val	= MBA_STR,
>  		.ctrlgrp	= "c1",
>  		.mongrp		= "m1",
> -		.cpu_no		= cpu_no,
> +		.cpu_no		= uparams->cpu,
>  		.filename	= RESULT_FILE_NAME,
>  		.bw_report	= "reads",
>  		.setup		= mba_setup
> @@ -156,7 +156,7 @@ int mba_schemata_change(int cpu_no, const char * const *benchmark_cmd)
>  
>  	remove(RESULT_FILE_NAME);
>  
> -	ret = resctrl_val(benchmark_cmd, &param);
> +	ret = resctrl_val(uparams->benchmark_cmd, &param);
>  	if (ret)
>  		goto out;
>  

How about a new member of struct resctrl_val_param that points to 
uparams? That would remove cpu_no from resctrl_val_param
and have everything available when a test needs to run ... not copying
some user parameters into struct resctrl_val_param and passing
others as parameters.

Reinette
