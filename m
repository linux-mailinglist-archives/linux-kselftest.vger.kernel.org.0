Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B423640ACB
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Dec 2022 17:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbiLBQbB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Dec 2022 11:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbiLBQah (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Dec 2022 11:30:37 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2622CA3239;
        Fri,  2 Dec 2022 08:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669998572; x=1701534572;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5WEWQ182tijciZhJEHbE6U7O4aW1+eanu0nh4FpV95E=;
  b=M151U2VRqa1tLxK7bjVQxdWSqKy1OIuS17Q8mDqYZ6qJeFlLxNkWhXxX
   SMY2ZINBs/C+QhmjBth+FJfi26Q3Cs/klQSqjUWwMVtuvvqb9zxfg2lRa
   064B7n8u3ID3oX7oRLAqtNTKiCuF1kgGQOdWMc+UkfTmTkmCDQYRiiZCl
   NRy6MkyMScC8cXMJ9fWuaPRjd+YXaTe0l7GQPofWQe4LMqRHI8t1PWXSv
   v6KDw5udzOxfMrjRvE2WLESSRaFE7xStMtY9x9X0wqulxUrmDy9CUTpH8
   woiAlP+k8zJLqz11tKgYBs2HV52sCSacXUjEhAZjnOWqDNcJOvOQsA8h7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="317842198"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; 
   d="scan'208";a="317842198"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 08:29:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="622748479"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; 
   d="scan'208";a="622748479"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 02 Dec 2022 08:29:24 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 2 Dec 2022 08:29:23 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 2 Dec 2022 08:29:23 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 2 Dec 2022 08:29:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aN9y+DSCzo4fE8rB2Y72HjXqSojT1tvlH7XxMhxznZj6TSO0S2myhrkzPsdq+39DQPg8suW1s+XkDBXwp1gcwGbGQx/A0c8pmGM0Kluom3vktWHyoTTIQNOp/tlahdctNlE7Z1h7qcD+fKrMdcGmXInHDoA5fhvcfYsitL2+2xnC3F6tPW5tcvCJvsCObDbC3DAaESCetnuhZnNyk8WMe5+ANUmogtvygRD+kzjWnBI/fGH0xWQUMZC7jE+E3qjfyWrY2VmX5IbwclWTeYuHtfCEf2AkwA0Q0frjDLyphgtRZHv2snzZU4xWHphdEiUvgGlcMmKpx5ohMMXIPjz5mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qoI3yJB2odRtQnfdBswF4h7KYt8xFBHttgAtWlQsdk=;
 b=ofkDZBqb9s5vuO//fhs6xBRzgVz4SNYYroii4jmoBmf5BfIBgP43UuwHxzEoheKoygv+hEPqqin5smahj8N7UgxDGdSHNYyKuRZ0GwmYAp9ikfNBHiPoqRzgWA9zfCHXbnDQuujLkEK8iwdXfro4iegNGqued0mRTOqL3vSkPz6dxWyphiZgYnH4f+k4rc3K20o2U8pDn9H3s7avnyxN+TIWYDIAkhf7Oj7DBQnXo7D6klwPvrqa/5Vccvsfe/6lMBX/VSdSijbgC+dPC4i/igLzLyi3CBbDwuEOwvwdlrRrMYgZpQkt95aiaJ+vcd0hhf0jGl3HPFWj2+6SmCGeDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by MN2PR11MB4711.namprd11.prod.outlook.com (2603:10b6:208:24e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Fri, 2 Dec
 2022 16:29:21 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::eead:b901:ac48:7680]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::eead:b901:ac48:7680%9]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 16:29:21 +0000
Message-ID: <4e5bbaf8-58ea-5ebe-a585-496ee7b51bce@intel.com>
Date:   Fri, 2 Dec 2022 08:29:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: fw_fallback.sh test failed in Debian 11
Content-Language: en-US
To:     "Zhou, Jie2X" <jie2x.zhou@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "shuah@kernel.org" <shuah@kernel.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "Zhang, Tianfei" <tianfei.zhang@intel.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Li, Philip" <philip.li@intel.com>
References: <CY4PR11MB1320DAA7D7972E738EDA754EC5129@CY4PR11MB1320.namprd11.prod.outlook.com>
 <Y4W+/TfM4F9TdSnZ@kroah.com>
 <CY4PR11MB132092589F9270FB559B01D8C5159@CY4PR11MB1320.namprd11.prod.outlook.com>
 <0e688462-7f22-118e-6cb1-de8b582e3973@intel.com>
 <CY4PR11MB13205F799D0A30BB011E4334C5149@CY4PR11MB1320.namprd11.prod.outlook.com>
 <217b7959-facc-1028-19be-1040898a705c@intel.com>
 <CY4PR11MB13206A6918FFDEB5B3D3794BC5149@CY4PR11MB1320.namprd11.prod.outlook.com>
 <57b8f45b-da8c-e9ae-6b3f-ba82f936c9b2@intel.com>
 <CY4PR11MB132068A19AF9704D1B14814FC5179@CY4PR11MB1320.namprd11.prod.outlook.com>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <CY4PR11MB132068A19AF9704D1B14814FC5179@CY4PR11MB1320.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0025.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::30) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR11MB1899:EE_|MN2PR11MB4711:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cbf2e98-79d5-45c5-4c0b-08dad4825d0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E1oF/wBKH/dwTJ/hwsNcSTNzzsb7BprTyEQkgy1tmg7Wp3ZxJi89x4TPkSJEB2NGUbDhs2Y99BHklei1lldJyD5uRQP+yL5HQPFa843cYg6xt4755spUUllBehH2aKfIgZNgjT0ui4LQP9slaiUIYYm4w31PcCEiRVt5A5P4iGNJ1W9qs76YBZerR6dZLi5QEb8OMXGW7qyhfwaOjgzVUv/bf7cYujG9t/WdCahVw++xaKIdhoiRck70h98+fpyFCGjDeevATd6uqfLb+FjjTK5oikq1AHuaRLUO09YVJapPR82Tgde0LVKNfRT06xjXhzcc+EweGFqRfvezNqdyQDVSeg5FU9YhRKDjyIjHBZS1gtiZlPFHXAVZ5CUFMVb58zPFA8+oRkMyJluJ7QvsW/5lErVPoMP8cqlejQexd0ODTqHfYKtokAhJwjhz9pZ8ZP5IPbh1LkwtwUZeugy+ng9gJSjsev7a6xGnUPYhtGv1OQcVnFfqWQk90h7mKDJtVKjqYdYODmWuuOPru0paYmhLFTsz3NftPPoqEehu3QkaDPEyYqkl5deEaFfgdRY9os1ypJywujL/T2yOeCWJ4t9IksY07fobvYo6HxbvOdweoHgAFLJgHrMkEcvStXwyxVdH4Lk8D4sIb8owHdCRAuRA5+wa6KmUzzXBwePRLNJi/WMAunZ4meBIK322hPGoGPoHZcthyH7C7pTxZB9obBpnGU1Sxl/vpTXV06EsNP7dyMrJ2mtQiJRZttBD9LL/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(376002)(366004)(39860400002)(396003)(451199015)(66946007)(66476007)(5660300002)(2906002)(8676002)(66556008)(31686004)(8936002)(41300700001)(4326008)(316002)(54906003)(110136005)(966005)(6486002)(478600001)(36756003)(53546011)(26005)(6666004)(6512007)(6506007)(107886003)(83380400001)(186003)(2616005)(82960400001)(31696002)(38100700002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXhLWjZPVkpiNHRxRnNnNGlpb3VhUXhPZVlLd2NkK0NZdU9rM3k1alpZZ2lp?=
 =?utf-8?B?bndTYlFBUjVNbHhqeGg0Q3VlaXRCU0VOOFFLbzdqZ1NkTTZoY3FkdXZlSEJK?=
 =?utf-8?B?TVFRUWdhR21peldzRHhGZWh4OGFVSHNxc2QxaXVGK25IQ0lSOVBDajVxc3Uz?=
 =?utf-8?B?WVNPVkVIVDFUNVk3Y0Z6MXdYb2JJZGxkZnlDWnFDNnBJVU1xRWJWM2VUemo4?=
 =?utf-8?B?ZEFvejlQaklpSWJWS2JueG1KamRyVVFFZ3plRG9oMjFGdnc1eVNDNUN6UW9i?=
 =?utf-8?B?YkNHVU04cUpBSVIwNTlsVjNoQXhucTZLOFJsWHFDTzc0dUVPMmx6Z0VPNUpz?=
 =?utf-8?B?MFl3aTVLMWhlTEkvWFdYQlhBeDdXQTRBUEI5d2wyMXlyVmVYRGpRcjIxODVm?=
 =?utf-8?B?OEYyUkpoWHNlY1hhVzNxbFFCd3VJT1pvUEZwYnh1eVU4c2lXNGFZRmp4M09L?=
 =?utf-8?B?NXRXMHR3VklDRkZWMnM1MmFBQ0xiemFIdngvK3JQelFLODZKNlFEN2xUamxk?=
 =?utf-8?B?WEZPRjgvbmhuWjk5dW1RV0U1RXBFTmdyYUpTRk0vZ3Nib3VtVUljVGJuMTFZ?=
 =?utf-8?B?blFETXdsZ21xeXF5b1dGWVU5S01BWDY4VEFQejR4dTJqWGdBT1FCTVF3OVdv?=
 =?utf-8?B?VmpXWXlidmZJeGE2S1phWU1ybDUxcjhOcERON0dodm11SDE5ZEdOd0dzbUNi?=
 =?utf-8?B?NTRhR0E2QzN6NEE2RmIvL244SFI0R3g4YklFWDdicy9UU3d3LzFHN1dDWk1N?=
 =?utf-8?B?THhmOVRqUnBKN1hNanQwMFIzbWxUNUJseHcyVlBudkRPREhZQ0tCK2dmL253?=
 =?utf-8?B?U09kQUhwRE9QQ1ErWDVNaFhOZDV5UVppYnNHYzJDdWhENHc1R3JJOUdya0RT?=
 =?utf-8?B?ZmtPKzdpQ2tSSWN0ckowMXQwTVEweWpudlNwK00vOEtEbCtQNUQvVndnU1Jz?=
 =?utf-8?B?TDFSZlM4SU5SL1YwVXI5VWN4b28rek05aExIdFJVMTJDNERFdXdSTU1oQldk?=
 =?utf-8?B?QitXTk5CaTdBMWtsbTJnU09ZZEhOV2VEaEk3N3BDSldWaktzYnl6VVZyNytp?=
 =?utf-8?B?anBUcFJTRUJDS2RqMUdqK0dTNFRIamxpOUZuV2pmNFhrbkZmdzlHMTk3eWRZ?=
 =?utf-8?B?aHIyK2pYNEM3UW9jbEVwZXgwTnA1cU1NRDlzT3pXVi9WSmx0MldOckhHTnlB?=
 =?utf-8?B?M21ma3FSeEs3ZDlnSzR5eGlpQkduMmprb05yUUFMYVRPWU1MQXpRZ3JrS2hT?=
 =?utf-8?B?ZTRTMndZejNZZDZZR0xKVGtvTHBZR2VobEZ4NUgvMjZ5bVZ1SU43a2NxU0Rn?=
 =?utf-8?B?dXRCM3Q4Tm9qR2t6MGFQblVBZUE4YUxFSWE4bmlIZXUvTU15L200SnE0dk9s?=
 =?utf-8?B?Q1h2YU1TZCtPTDRCWHJhWTh0a1kwNG8waGk1blJJKzdkUTdDU0dwb0JHTmd6?=
 =?utf-8?B?VzJSd1ltTzlKR082RjRBcHh0V1l1VDZZNXRNejlxK0Nlb0U3NkZ5Z21oNzBr?=
 =?utf-8?B?NTRIRXBnMkkyUzdxZ0R6dkhJd0FobUJlKzF3U0x1Nnlja3pGTGlsVGpvWVoy?=
 =?utf-8?B?UmZKY1RranQ5d0I0aWNuT0VMZmNDVk5uUXcrNmw1a1pqc3UxS3RUM1V6WFhp?=
 =?utf-8?B?L1BGdys0L2dnYUdTYXM0dHRiVzljTCtjdTNkYXhUYk9CaHNPTTJybUV1SmVa?=
 =?utf-8?B?WWZCckhhaGNndGNINnV3YklHSEIyVndsbkpEaHpTNGh1UWFVUkF0M0tQSFdI?=
 =?utf-8?B?Vnd4TEw1WVNENFBxd3hqN3prQ1FnV3gzR1dONklWVGFta3R0RVJRNnhoenNw?=
 =?utf-8?B?M1Q0ampESnBMbkZmdkNLUzVuL0xsU2piNlVRUXlqeDZJL3ZaVXczMlhMOXJF?=
 =?utf-8?B?RjRCRXZlYlYvTHRoN09oKytGanpZNmV0TnE2RWxLN2g3ZXJGSnViNlB5RXh6?=
 =?utf-8?B?Z2M5V0RwMjVkbWpMVkRNTEFWTHlKMCtnUTd0Q0hKUFA1ZEIrcnBYcUtmdGU4?=
 =?utf-8?B?QnhLSHlXTlRvNE84S1IxRFNJNDA4UkdPQ2NkYlU3R3liV295bUszOCt5bUZw?=
 =?utf-8?B?cWJSMVZKMFhQd0FsbFczUVV2QzJDME41MlU3S2VvU0JlbnNYWGl0VFFzb1FS?=
 =?utf-8?B?RVZpMkxmUnU1RDl3WnV0YzUrdDVJbXZxQVh0eXhQRjBqWENzamxBYUF6SUgw?=
 =?utf-8?B?a3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cbf2e98-79d5-45c5-4c0b-08dad4825d0f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 16:29:21.2059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IxFtCP3bkwlJrb48akbROJAeClnWSeKj7Seb+Sg04mQK/cab1DcMGHGxKlLehAXN35hc44bRjO7JMFKSzC7Y15TkN9/99DC8hzOAIa9vlqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4711
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 12/1/22 22:02, Zhou, Jie2X wrote:
>> The above message looks like the problem. Firmware sysfs fallback has been turned off
>> on this system using sysctl. Can you try turning it on and rerunning the test?
> Sorry, I don't know how to turn on firmware sysfs fallback.
> Could you tell me?

Take a look at the kernel documentation (https://www.kernel.org/doc/html/v5.0/driver-api/firmware/fallback-mechanisms.html) which says, "This syfs fallback mechanism may be disabled completely on a system by setting the proc sysctl value ignore_sysfs_fallback to true."

Also refer to the sysctl man page: https://manpages.debian.org/testing/procps/sysctl.8.en.html.

- Russ

>
> I search the firmware fallback options in kernel config.
> CONFIG_FW_LOADER_USER_HELPER=y
> # CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
>
> best regards,
>
> ________________________________________
> From: Weight, Russell H <russell.h.weight@intel.com>
> Sent: Thursday, December 1, 2022 10:37 AM
> To: Zhou, Jie2X; gregkh@linuxfoundation.org
> Cc: shuah@kernel.org; mcgrof@kernel.org; Zhang, Tianfei; linux-kselftest@vger.kernel.org; linux-kernel@vger.kernel.org; Li, Philip
> Subject: Re: fw_fallback.sh test failed in Debian 11
>
>
>
> On 11/30/22 17:28, Zhou, Jie2X wrote:
>>> How much of this path exists on your machine?
>>> /sys/devices/virtual/misc/test_firmware/trigger_request
>> This path exists.
>>
>>> And is there anything in the dmesg output that indicates a failure associated with
>>> the test_firmware device?
>> Yes.
>>
>> kern  :info  : [   77.858068] test_firmware: loading 'test-firmware.bin'
>> kern  :info  : [   77.864705] test_firmware: loaded: 8
>> kern  :info  : [   77.874250] test_firmware: loading 'test-firmware.bin'
>> kern  :warn  : [   77.880672] misc test_firmware: Direct firmware load for test-firmware.bin failed with error -2
>> kern  :info  : [   77.890106] test_firmware: load of 'test-firmware.bin' failed: -2
>> kern  :info  : [   78.896662] test_firmware: loading ''
>> kern  :info  : [   78.901059] test_firmware: load of '' failed: -22
>> kern  :info  : [   78.907422] test_firmware: loading ''
>> kern  :err   : [   78.912278] test_firmware: failed to async load firmware
>> kern  :info  : [   78.918594] test_firmware: loading 'nope-test-firmware.bin'
>> kern  :warn  : [   78.925405] misc test_firmware: Direct firmware load for nope-test-firmware.bin failed with error -2
>> kern  :info  : [   78.935260] Ignoring firmware sysfs fallback due to sysctl knob
> The above message looks like the problem. Firmware sysfs fallback has been turned off
> on this system using sysctl. Can you try turning it on and rerunning the test?
>
> Thanks,
> - Russ
>
>> kern  :info  : [   78.941934] test_firmware: load of 'nope-test-firmware.bin' failed: -2
>> kern  :info  : [   78.962155] test_firmware: loading 'test-firmware.bin'
>> kern  :info  : [   78.968232] test_firmware: loaded: 9
>> kern  :info  : [   78.986063] test_firmware: loading 'test-firmware.bin'
>> kern  :info  : [   78.992269] test_firmware: loaded: 9
>> kern  :info  : [   79.023611] test_firmware: reset
>> kern  :info  : [   79.028466] test_firmware: batched sync firmware loading 'test-firmware.bin' 4 times
>>
>> best regards,

