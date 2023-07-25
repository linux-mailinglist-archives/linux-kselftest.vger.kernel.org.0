Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9BF761D57
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jul 2023 17:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjGYP0e (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jul 2023 11:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbjGYP0b (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jul 2023 11:26:31 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062AD19A0;
        Tue, 25 Jul 2023 08:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690298788; x=1721834788;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=x3qfN80qDgzbOxBU0fEvlfDE2usy6nKKjcOzxO3c1Ik=;
  b=Okw/osqh8mLJ3JuaOl1btD6EWl4YuW9VfJhviq6LSaEFtOvx33vTt2Tx
   H2ZGCIGhjUQajbRsMe7kuCBZXxy3lJqo66nHUhA0q0cm7Gg/YbixpRWFz
   YzacjDwNXwde0o4keIkBBdSJ7llqFwrQU65DZe/WK6AjyjUpFziv+nZPG
   /plf9etciKJQ/aX5TMP45DBKiGcG9Wnm5ZmPEZ+FxeBqchtYwBkZZJfp9
   xcnNGcr3QIrOlcLhz/jiQUBMxSULAb9ymEqNM1rTwSUrWiGfQfkiHdf0N
   ahctbvKx9s6qnyAbtAoA/P/kZR4KlrP4p9z1CSXTPht+gYFka0DRE7RVU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="352660523"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="352660523"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 08:26:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="761248022"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="761248022"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 25 Jul 2023 08:26:27 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 25 Jul 2023 08:26:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 25 Jul 2023 08:26:27 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 25 Jul 2023 08:26:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQk0BRmvU/zP/wKncbzX96ce5/ocZkPt8LhuBoz+tqrDgMeOG/hn/PNvSXB8Wj38/spMmQGh+Qn5NcBIdVrIe0wJi6J+gVR7DuzNQ88kSty/prHNPRMPjrD0rtu2jdgChWZV0TgpZIBbnP7l6rdK2BX14GdeBACiTZDL6T21sV9/uAjbUn5eVnvbtwSy/VkghkE/uFmnT+me7/9vbEZprS4MUoWA5XBIWMwLe4N8ZHTH6hTpM/Fyu4hMXQzLEaD9CahLrIeka2YhxgqRrKGv/SJ0hvlCIEzCv87s00iLZDye1WrJ86DwKK5Se6YkAHQ9Lf+2rP/319CA47739siwbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMn/tqmuOlYcbjd5JHWGg6lxhT7o4y/1kTou/WtrvRY=;
 b=ZBEQQeMaFhrehBAaUaw/fCl2t6Xz2ybEoKIG12l5Hm1Q0Rt5rHLqLXrxdNIKo53OiZXUSP0/21SOmfWNb/yzIB9oDH47wigzX4jiwwEUSsFkQWF27VOXucfEm/HxgEXRI6PgOzq5SLaXLYCiCI3LI4BVTNfE7MFpXFO6EowYTSZ+IRCVDJMfv5zrpq+n2r9LQMNIzH2Ko8JzeA9x3/u6bHqzniakrju20e9hhmouN8GVZKBpDAKAS5CZBzOD0lv74V3gNmoRgDqSaMC26qIsXVgbW3aeEJvnX2q7986zGmqq4ZFhrkPH2+sfXp0sv9lNUmLAtC9rLjJhWunXzYnFJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH3PR11MB7769.namprd11.prod.outlook.com (2603:10b6:610:123::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Tue, 25 Jul
 2023 15:26:20 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::116c:1030:6e1a:be28]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::116c:1030:6e1a:be28%5]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 15:26:20 +0000
Message-ID: <856ad175-26f8-90ea-d801-c722d2b19b2e@intel.com>
Date:   Tue, 25 Jul 2023 08:26:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v5 12/19] selftests/resctrl: Remove
 "malloc_and_init_memory" param from run_fill_buf()
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, "Shuah Khan" <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        "Fenghua Yu" <fenghua.yu@intel.com>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        <linux-kernel@vger.kernel.org>
References: <20230717131507.32420-1-ilpo.jarvinen@linux.intel.com>
 <20230717131507.32420-13-ilpo.jarvinen@linux.intel.com>
 <7bba4db8-eaac-238d-b764-89d0ae2a9bba@linuxfoundation.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <7bba4db8-eaac-238d-b764-89d0ae2a9bba@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0161.namprd04.prod.outlook.com
 (2603:10b6:303:85::16) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH3PR11MB7769:EE_
X-MS-Office365-Filtering-Correlation-Id: 64ba2591-315e-465b-9385-08db8d237f18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dddI7F2tD1UI1qpOAUByAF1pK8Hpgrqo7s/AOSTfuSlacJOKKKGJik6ZpChE/gkntH40xeo2zKwzN8Fa1DXI8hlyGUYjuJhjLsLLO6lSY2ejqrA+lZmdQlnu47yTJPs8i96fq5/EsetktfERAZcdZ67uzjNFaFLsjMKksuP8NDpDpzTW4Ti9jtZCf6oJEUcJAZChGoJbt9Ro0m1vnRHr0eamM0vt48IgfrhGeGov+XFF8Dm580253n9z9kOVTmszSHAGlZTNSRA0XhKsK/rA9MXQ04D7I9p7lsk2mifTwAipoRHAQUxvXourgEkB/yxPmoC6f1uUKFEpZtIsXbY4qIlkJ3p+ZmUK7kdqwH1DjG+LElRL2lHEfMRFgropJUdAh98sU/+hmyopB88Pxm4Cwcf0wKd9lrZpSI/5QE4MnWT47g/mMloVpwFOQhRC2DquTES5dJfD7xVTYvnKxoWt7l0P7ZAFafByPJgmnxtF+4KLEtNLM4+Pjbqt8+6Lmb2ClU84lxfXmX3mejyY/uwXH1TTTYsRpQZeyFzE0h5rK0OrEmjeIM8ijVzSKpue2g3H5m/QBl8OOpzrXemQubJp4ZRQAWyhZfTToElC/lEzu8bfJG5q/qjKSlsPFy9W5xWHvd7xY0obpFGlnXwifoo+wA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(136003)(346002)(366004)(451199021)(966005)(6512007)(82960400001)(31696002)(5660300002)(6506007)(83380400001)(2616005)(186003)(38100700002)(41300700001)(53546011)(26005)(4744005)(8676002)(8936002)(44832011)(36756003)(6486002)(2906002)(66476007)(66556008)(86362001)(316002)(66946007)(110136005)(478600001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWhKL3RYTnF5dFNjeHNSaG9RdUE5ZFQzUm5rSXVjcHUwZHFPR2kvZjR6MXpQ?=
 =?utf-8?B?Nnh3NStJdER6UVMzNSsyem1vMnEzcmkvL0VJTTM2S2NqYTloUVp4MzRiWkEy?=
 =?utf-8?B?VkYyMHZUeStvc3FIMVl0MEpqY1hhdGx0bEdCYXV1ekRISUIwb1dIVnVRd0Rl?=
 =?utf-8?B?R21Kdlh2THV0VEszbUtwVUJseTAzaG1RUlVFTlFjRXl1Tm9WK3pVcTFpZTVN?=
 =?utf-8?B?Vm8ycGRIUW4yL3o3cXF3TjkvMFAybkdyN2ZVK1FtOXBOZlV3OGNRbE90MFFV?=
 =?utf-8?B?emU5emNaQ3MzMkNINWxjRlRyWUR3aThUNWkzeHZWcWo4WkpIdzZqQ3V3VndI?=
 =?utf-8?B?QzZ6Qi9OZUFiVFpibEUvUnhjV1B5UEljZU5GckRQbWRkMm1UNkR6SlllQ1lD?=
 =?utf-8?B?ZE1saE95Z1BrNmFHQk5OdDc3RDBsdTNXU0VNdlVYSjRneWVReUdhS0hzWEpL?=
 =?utf-8?B?NmJ1NDMwaVJveEZkU3VJTnZRWjFOMjlaTmtMS0ljQS9LTEtON2lZWnZWdnZX?=
 =?utf-8?B?V0d6TW5oOERzQWZNSTVsOFUvalFmOU9CUUxrZ0lQWWt6R0VnWU01N1MzR0RI?=
 =?utf-8?B?N2JEM2lQSFZFc3pPQzVRcXpxYUhqTjNBU0ZDa1p1aWY1QVk3TWpldDR4Y1N5?=
 =?utf-8?B?cXQrbUhyWnp6cUJxVk4yTkRzWUpkcFFMclNnUUhMaTNmM29ZYXlNOTJjelY1?=
 =?utf-8?B?dDgvN2dCQTk2d2ROeWk2M2U3YXRTMUZxbzh1em4zYXEySXNJbFp6V3c1bGw3?=
 =?utf-8?B?aHZzZmVhd1NqVi95TlFzVjNqNEhFajllVWJraVR5UDBoYXFmaSt5WS91RUJS?=
 =?utf-8?B?cnVNeHdmcE9DQXBFK0YxWEZ4b3cxVk1YeUVMNmVWS285aEhQRE52aG1Cb3dl?=
 =?utf-8?B?YWJGMjZvR1VZb1BRdHRYbXRIQVQ3Z1NRaU5GWWMvc0ZnRDUxMEFxclVHUllw?=
 =?utf-8?B?WTlJQnBMTXVNWmN3aDRhdnRQMjhhZ1lEbTR5WTNvS1haVUI2dmtVL3A3L2lU?=
 =?utf-8?B?REp2TUZXdVFPK0JsN2lxUjVsWVVuMDZSUEJPVEtFbElzVVl2N3JEVDNFeWI5?=
 =?utf-8?B?aHdpVEkwNzRRQWdGRUpBU0lQZXQySVRSd0szMlNGOGs2THAwODBETXFzdUVT?=
 =?utf-8?B?ajZwNmpVMU9HUmtKQUE5SStCNDd5NjVaVHdPdS9RbzNoQXBKSGJCdld3YUlU?=
 =?utf-8?B?RmxSaS92ZjIvd0kyRXo0KzZ0ZXZtQWxlcFl2eGxlYStVRGw4M2xmTGdLY1Ba?=
 =?utf-8?B?NW5EODZPWWkvdndZSis0Z2UwOXd4QXliK21VUld2S25QNmc3TGZ5WnBUaEJu?=
 =?utf-8?B?ZVY3R0FtOVFFSHpWUGRHVC9qNHFjbm44Zk5aV0N5V29palA0RHFxR3lXaitM?=
 =?utf-8?B?SzBSZGZLRGhoYmRlNFdzbnBUaDJVbUkvQWJ4S0pVQnFMK2xFdFFrelk5Wlhz?=
 =?utf-8?B?dHVXUjZTOFUyUjlTVlZIZ1RFcjBVVUVMeVNPY2xKcExpQTJ2aTRzeThZQjF6?=
 =?utf-8?B?cTVTREx5YWo4NkhGYU9PUUlvOU1uaGRQbWZzbHd3VStjNWQ4RjNBTE9sYlp5?=
 =?utf-8?B?ZlNFbnJmZ3VibGpVZWF3eEZtK2tlSDlHUWNKWkhacGZzNjZzWXpZbGNUZXR3?=
 =?utf-8?B?a3FMQXdmRU4xVVZaVEVuZlM3aGEyRmpJYkdZRzNPdkxLM1FSODBQdHhRSEJQ?=
 =?utf-8?B?NXgrVEYvbVQ5TDM5NzBoekZLVmwxRTVweVpNV1FDc1lEQUJHcStVVU11V25a?=
 =?utf-8?B?L0lEcEM4YitseUVtejFicmQ3aTY4SDRXU1dxN3c5aVZiWTdvVnhoUXMxRnFt?=
 =?utf-8?B?ZWIwYkQzUk1HbUZ2YWtFc0g0eTM2V283aFk0RmgzcjhleUpMZE5OZmNCY3Y3?=
 =?utf-8?B?V0x5WmxBWWJsY1ZMNWFnSElmL1dMZnVyZ3NtaHI1eTR2WU94eWl6TTFnQ2FN?=
 =?utf-8?B?SjBxem9LQ3I2NFh2eHJtN0hPUE42ZjRFV3VCZE9xK0twYk1lVnBDaUFpN1RO?=
 =?utf-8?B?amE3UlVyUW9vVHYycWJ0WVc0SUo5Zld2eFZOT2Rjd2gwVkovQzI0ZzhNb3pr?=
 =?utf-8?B?VlV1TWFNbG9ZZlNUbjZlL0Q5WHU0SGpsVE0xbXN6bk9UMEhrSlpqbXJucE9B?=
 =?utf-8?B?d3FsK1V5blEwbk1ZSDErNjYzaVZQQ3QzY3FMOFR5K1NRMDBURXB3a2F2ZGs4?=
 =?utf-8?B?dFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ba2591-315e-465b-9385-08db8d237f18
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 15:26:19.9936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y5SCRhlUUml1Pl1KWHrnr5w4D4XpBpB1qRzIsdciNnepEA69scCf2f/temLcV4jFX8yJTI9APM+B/J1voaf6/k3tz1jpv8fVPw0SmoYvZnc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7769
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,

On 7/25/2023 7:49 AM, Shuah Khan wrote:
> WARNING: Prefer strscpy over strcpy - see: https://github.com/KSPP/linux/issues/88
> #233: FILE: tools/testing/selftests/resctrl/resctrl_tests.c:276:
> +        strcpy(benchmark_cmd[3], "0");
> 
> WARNING: Prefer strscpy over strcpy - see: https://github.com/KSPP/linux/issues/88
> #234: FILE: tools/testing/selftests/resctrl/resctrl_tests.c:277:
> +        strcpy(benchmark_cmd[4], "");
> 
> total: 0 errors, 2 warnings, 142 lines checked
> 
> I am applying the patch set to linux-kselftest next - please fix
> the aboe and send a patch on top of linux-kselftest next

Is strscpy() available to userspace? I found lib/strscpy_kunit.c
that makes me think this is currently only available to kernel code.

Reinette

