Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379EC6EB640
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Apr 2023 02:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbjDVALh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 20:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbjDVALg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 20:11:36 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69133212D;
        Fri, 21 Apr 2023 17:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682122295; x=1713658295;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=I1XCOJtKetpHT+g71okvHinqPZ2oOrbFEAwqXu8fIkY=;
  b=g2ZzcOw76y9x+qGNGq2RBXNCBtYeTEH8RmcdC8NY06F3xI8CH7/XWwEK
   jZ5R54g87fAwlumN61YvOMASC0zDl6e9+6XKOvfXKmOEKjmRndYi8qGQ0
   KPV9gfmMUqlngNcgz6wKFkyYB2swopS+tohWUoWm/er/pjRuNZoboINwb
   9CYjxfwAm6GYZ0lVZKhwMu5veCetBYHcZXKPj1gWgdr2a4vqcgeptLvi+
   ypzen7VYSxuyVJm/jEr4hCwUfqo70tNHl9c7TtagFG0oYj/TJ4bu889Ku
   urQOwgggKvJXVQtNH74YnYyzAieszufm38RYq7hpHTKVmxkYe4sCMTXq7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="348905436"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="348905436"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 17:11:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="781775964"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="781775964"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Apr 2023 17:11:34 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 17:11:34 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 21 Apr 2023 17:11:34 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 21 Apr 2023 17:11:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=drBYtoXegvk06NHruVs8JJ3HG9pIiAspkdmzTXEItjVE6x++jOLPWENDjgShhH18T+YnA6YyPAKYZFmdgq1/IeTmrgAfnVLVtjryetApqAVCBNxvKnJ0eqQtDR+KL171LDY6wGz+8JTu52d/XitM0VRD2arAc26RrC+Iar9QMvDdL8IZtTS/EId0im11S8ilU8i+4lPBgFkMOAlRZb/8Vn/1wXbta48MyDnGgpp2OR+G7L+8zAxj89LrwPjJ90kVUN1oyiwtlPza+FdbdCxmuuJtlWQTCThax56XACCV8OfsJfaUeXYhULkiMzlWH00TwYSKGklk5WkbOhMd97Sr/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NhuhTCKuLp2N1txLows8rofDOTH+04ja98hTN3r/Oes=;
 b=BDItJ6u5l2N2LL8BNj/FcpVpTf+wleLtOkc2s7xLPYirEzCkgPxUPzEosysC/6BEKnZTeyKSMk74vYTVr3FLwmAlvQ8/GUUwo+7+s7AKw6xVovC+hj4oOtjhoOJSEbMY9C8oqaY4DSljfdlFm+kY6YK7kjHz5wlYq58aGW6fsT8H/YvVGp5/hC1CBeERLBJ/4ehKV4INbequsdR42j5FV6qJ046sk2uwNmwRp9Rb97RVVtp3T2ebHf820kloMTSoB+iSeqMRoNxFPujXotUIzgHGc5SdhRURUsWZ/+vmWseGKkMhLuJOvfbLjGhhom/aMbJjG4w7cRNxLzjubKckpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by BN9PR11MB5227.namprd11.prod.outlook.com (2603:10b6:408:134::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Sat, 22 Apr
 2023 00:11:32 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::2854:770d:2a43:dbc6]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::2854:770d:2a43:dbc6%4]) with mapi id 15.20.6319.022; Sat, 22 Apr 2023
 00:11:31 +0000
Message-ID: <3df815f8-345e-7089-1c05-f46592ffa393@intel.com>
Date:   Fri, 21 Apr 2023 17:11:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v2 04/24] selftests/resctrl: Remove mum_resctrlfs
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "Shuah Khan" <shuah@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com>
 <20230418114506.46788-5-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230418114506.46788-5-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR01CA0032.prod.exchangelabs.com (2603:10b6:a02:80::45)
 To CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|BN9PR11MB5227:EE_
X-MS-Office365-Filtering-Correlation-Id: d1ba7943-b69d-485d-5f63-08db42c6203a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IkyzzHMUWrcBVUIvZgOCmLhsSjQ/6abKNgu7EyCE/azrPF7WksXla2WTxK0Wx0YXkBbYoyaxqJtJINCrGPVECe0iExu6yS2stU2rba113DijBKXoL4guByFGDv7FNX4qwqSuwkat08mNzvTWTJifXPaKhajeZdTit1B8K9cTn7cpiO3+QhuiMGc38pIzl2Em6ye914Y18gBjPmcWMZE+WpBziz0GYqA0GCuD1Q90EK42q5HlHBgtZq0ugEpwfgDTsSqttFmbu9rFbpvadHbMYLZ2ofXFQnBbvsPsOzDmPdSui8WMG/ThZSZPiJylyfVKnFF4HvVJ91RyOD9XNhr0i4yxT7P49LnTMMky7g0A6es3MAxyx4KZkBpitH3ej1q4AJbJMsmv2mp5wIsYQOsuj+881UsN0i3CCG1BDR/UqVydvY9HEGpystzHWx8VkWiobabBjVil37VNABEbMjfUz1KI3GXs7J+q6dPiLBcJVwLcr4HWzc0+7dnOrva4MM8um89Ow8yDrB2ulbPxjA6ut5GoHyUYg/GHE/QDefXe243fvGlV+RgXmu3QCw70rlXpGP6rjhzDm55mWMVOWx1MLQI/bJPjIifnNhbFlQ+pHWGV5orpolEZS4fvjVYVXW9rZKXU1NttZFkMObaSelS1+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199021)(2906002)(8936002)(8676002)(38100700002)(44832011)(5660300002)(36756003)(86362001)(66574015)(31696002)(6506007)(6486002)(6666004)(6512007)(26005)(110136005)(2616005)(31686004)(83380400001)(478600001)(4326008)(186003)(316002)(53546011)(82960400001)(66556008)(66476007)(66946007)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUhDYTlZMUNSOUJFelUxd0d5SjB4Nkl4QUkvcFl6MG5FL25oMWpSZXZ3N3pz?=
 =?utf-8?B?VWhqa0cwQWljeDNPaWM5OVBNOXZLVkJFZTRFMHV6eXQ3Q2NuY1pvYm1CVFhq?=
 =?utf-8?B?NmVZWUhpOTFoZDFoalR6aGRFNGRlZFl2SnNEeTNmUE5MWlhEczBIczJxejV4?=
 =?utf-8?B?YjBrQlBaV0hFV3ZxbjIxQ1JjVUw3Wmc0Qm41b3hWQ3VZNHZMdlp6WlhlSW5E?=
 =?utf-8?B?azRjeGhtZitCamM2TDcvNnc2bklIQmxQZ1RJWk5ncEt4OFo3eVNxYmp4OEE5?=
 =?utf-8?B?MkxWVjdQUFovYm1senhwZ3FsUkRWSHNCanY1ekk0OWhCejdLZk1YMS9KZ0Ru?=
 =?utf-8?B?UTgyWk1KSkpBNEJSdnJYQitJWlYxYng1OStiUW1iYjFlRWVSZnA5OVBkV0g4?=
 =?utf-8?B?UTM2ZG1HQWRSalFXRnVkUWJRSHlzamJaQjRiNlJOWWhwNUFxdE5pQzg2ZC9E?=
 =?utf-8?B?WElwRGsvcUtpQ2FyRjdIWk1ZWFhuY1JOZWFTaVhBZS9uU2dLTlZ4MzVEMElq?=
 =?utf-8?B?Mm8rYndTaWlibkV1bHQ1MDBqNFJiY2ZJb0c3dW9OQVZNQ1MyWGQya1JZdmk1?=
 =?utf-8?B?Vk1lWEtFZDI5Y1R3VWd0d3dBdDFwWUtRZURuSWNPWEtlSkppRVJldFBKaEdN?=
 =?utf-8?B?U2lzUmdhQmtCS2hudjdGYlFYNTExQXpYd3p4cCtJbXh2cm9oTFptWks2cDNX?=
 =?utf-8?B?ME9zYUd4VW5xV09CZ2VVeUFhQWdDUStPY055YW82QkVvb2VvbFZQbnFOR2NQ?=
 =?utf-8?B?ak1UOGpydnMwSjNvbXByM3o3d3QvWDRIV09raVZHSVFKSWgwUEJwbVpvTVVy?=
 =?utf-8?B?cVQrTHVaN2cxeEVmM05aeEQ2Y1BSOTc3a0JXb1AzaXNzS1dmTmp4cW5wQVp5?=
 =?utf-8?B?Z1FZckRoelJwVUl5aDVYL3JpWk9heXl5ZjBIRmJBd0p2WHJ4RnRseGo1VEo1?=
 =?utf-8?B?dEdsNGt6R1JmZGxhb29mS2J5Y1dONkpVdVVpTXRjSXhVbCtZVk9XZzVLaDY4?=
 =?utf-8?B?dzZvK2V0L3lIQTZyV0t6RVcrYWNiMy9SaThpY2U1eW4rbTBueC9uTnZteW0z?=
 =?utf-8?B?OFJwalo2bXc4cGhqS1djQjlkNUFOeUVsV1BTd3pvWGppczFKVDNDODBtanp6?=
 =?utf-8?B?a25KOE41eXUySmgwMkZ6R0hXeGxxZFA1MXNMbVZUK1ZUR0lRV0p6cm1HVVJG?=
 =?utf-8?B?cTBkcTBOaURIYnZLR1doZlcwVyttdjMwZGdmeVk3MEUwdHdzNlFkUHh5bmhu?=
 =?utf-8?B?c3lQSGx0SHVpZWMvNWpSZHVCM1c4NG5jck5GZktlZ1ZrQ2xYa0pIQ1l0clJu?=
 =?utf-8?B?M2FxMnE2MVJpN0dzUWNZVjNhNmwwNm45YXNkR2NZTmx2a3l3aEdDUTNJTHRW?=
 =?utf-8?B?YUQxVFVic1M5cDM1MUFwM0pISS9qUDUwdFlyelhUSFdOTHBIUWdJMmpiUFBq?=
 =?utf-8?B?RzkxSjFYOGY5OFBJUk5nS3d6c01ISldYNjJrbWkxWGhHTldIMFIyM0QrWnhM?=
 =?utf-8?B?WUFHdUxhWDFwT1lFUmZKUys3d3RoaGtkelo4Ylk3SHZjNmxwMWR3TGRzMk1C?=
 =?utf-8?B?czh1MXFSNlIrVk5ickFFY2U4bWsyNU1CRXIrZ055a1Y0SW4raEl5SzZxalVy?=
 =?utf-8?B?NUxub2tLaHErQW5aOEJ0Y1U3YmhtbTdxSjZSNFRxL2JzU2tkYmQ4dzRMN0dG?=
 =?utf-8?B?NC9lS0p4YkRoNm1XcmtnR3lML3pjVm1icS80MDkyc3d0aDlDcEZmY1Fvamwz?=
 =?utf-8?B?UWdUK3loNzA4aW04WWNOek9NajBmRXlONTRUZW5RY25ENkRVY1c3WXZDNHgz?=
 =?utf-8?B?eEFYay80d3U0dUtQTXBTcDU1OWs5YXRadis3ZHFOMEFqM3ltWXRpT3dVK2E1?=
 =?utf-8?B?VDhmY1NpaGZqVzliR1JkNWM4dmVuQUtvTnc0Y1haZ0NEb1d4d0RacjZhMVJT?=
 =?utf-8?B?cXlKUDI0U2IweldDNjhpSGw5ZEx0cjhOZHlROUlSQmVzblh0ZGh4SVlsRzNn?=
 =?utf-8?B?V1BTb3JQQ1IyMGY3K2lpbk9sRnNDV3Y3Mi9zZFZYbEljbmNBTld0d1U1dGNj?=
 =?utf-8?B?L05RNm5aQ1VRakY1RzhHZTRPbTN1eWFNSzB0SmZVczlPTlJxVkR3OVk5Mll3?=
 =?utf-8?B?aW5ZcUg5RlU1bjdCSkZHNEdMT1JxT2w1YnhPSXlyVExFRTRIMUhENUxKdzlN?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ba7943-b69d-485d-5f63-08db42c6203a
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2023 00:11:31.7310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gFnl24zu365se5VJyXUT5BFSqxlXZ70zFgGUGb+mwl+phNhULTvgTFa/z7jcKyJZ6Sb7xyWxJRbQu9cD3SmYeg8JJj1HO/6towX9CRimopY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5227
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 4/18/2023 4:44 AM, Ilpo Järvinen wrote:
> Resctrl FS mount/umount are now cleanly paired.
> 
> Removed mum_resctrlfs that is what is left of the earlier remount
Removed -> Remove?
I am not sure what is meant with "that is what is left" ... 


> trickery to make the code cleaner. Rename remount_resctrlfs() to
> mount_resctrlfs() to match the reduced functionality.

These two logical changes would be easier to review if done
in two patches.

...


> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index 5c9ed52b69f2..f3303459136d 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -77,7 +77,7 @@ static void run_mbm_test(bool has_ben, char **benchmark_cmd, int span,
>  
>  	ksft_print_msg("Starting MBM BW change ...\n");
>  
> -	res = remount_resctrlfs(false);
> +	res = mount_resctrlfs();

As mentioned in previous patch the way I see it remount is still needed.

>  	if (res) {
>  		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
>  		return;
> @@ -106,7 +106,7 @@ static void run_mba_test(bool has_ben, char **benchmark_cmd, int span,
>  
>  	ksft_print_msg("Starting MBA Schemata change ...\n");
>  
> -	res = remount_resctrlfs(false);
> +	res = mount_resctrlfs();
>  	if (res) {
>  		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
>  		return;
> @@ -132,7 +132,7 @@ static void run_cmt_test(bool has_ben, char **benchmark_cmd, int cpu_no)
>  
>  	ksft_print_msg("Starting CMT test ...\n");
>  
> -	res = remount_resctrlfs(false);
> +	res = mount_resctrlfs();
>  	if (res) {
>  		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
>  		return;
> @@ -160,7 +160,7 @@ static void run_cat_test(int cpu_no, int no_of_bits)
>  
>  	ksft_print_msg("Starting CAT test ...\n");
>  
> -	res = remount_resctrlfs(false);
> +	res = mount_resctrlfs();
>  	if (res) {
>  		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
>  		return;
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index 42f547a81e25..45f785213143 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -48,29 +48,19 @@ static int find_resctrl_mount(char *buffer)
>  }
>  
>  /*
> - * remount_resctrlfs - Remount resctrl FS at /sys/fs/resctrl
> - * @mum_resctrlfs:	Should the resctrl FS be remounted?
> + * mount_resctrlfs - Mount resctrl FS at /sys/fs/resctrl
>   *
>   * If not mounted, mount it.
> - * If mounted and mum_resctrlfs then remount resctrl FS.
> - * If mounted and !mum_resctrlfs then noop
>   *
>   * Return: 0 on success, non-zero on failure
>   */
> -int remount_resctrlfs(bool mum_resctrlfs)
> +int mount_resctrlfs(void)
>  {
> -	char mountpoint[256];
>  	int ret;
>  
> -	ret = find_resctrl_mount(mountpoint);
> -	if (ret)
> -		strcpy(mountpoint, RESCTRL_PATH);
> -
> -	if (!ret && mum_resctrlfs && umount(mountpoint))
> -		ksft_print_msg("Fail: unmounting \"%s\"\n", mountpoint);
> -
> -	if (!ret && !mum_resctrlfs)
> -		return 0;
> +	ret = find_resctrl_mount(NULL);
> +	if (!ret)
> +		return -1;

This seems to assume that resctrl is always unmounted. Should the main program
thus start by unmounting resctrl before it runs any test in case it is mounted
when user space starts the tests?

Reinette
