Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCD07AF792
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 02:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235141AbjI0A4I (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 20:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233850AbjI0AyB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 20:54:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C239493EA;
        Tue, 26 Sep 2023 15:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695766484; x=1727302484;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EOj1ziAoE05durNIPoLNWzjUXqsqU5C+elcqXSRu+bs=;
  b=GFVsZT199XsHSQs1NwXLEt1sDMFidg0wG3DkYedAmBRlfP2ntWZeXrrj
   35ItZ6oDGyy1uVUR72KBWxpcHYhanGuL/oyStEHdTwJER0Hoh7p5f1ssA
   9BGRSyT5khIJk10wWB/DF6C+inz8PIHcaQDom6i5T+KRJDO8POEcEEY2a
   GXPMaX8U7jdVWotuTo94THS7DggEiWqpQf5vazrYSQ650ZmPhciDnjmV3
   CnX0yOUe7r7rw38vjhccrULudV/6i5f2dZmRsOf89kR64GG+c94aAormJ
   arQWQaXJLt3U2e7vWECX/eejwma6LYEhHnEpugYBycaKeJWdyOq/7bE9/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="385526680"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="385526680"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 14:39:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="307213"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 14:39:14 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 14:39:43 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 14:39:43 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 14:39:43 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 14:39:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNcdx0hkIRK5JZPSuBSPNeYFZyCRLABlcO/1oP3kJF3rzBoTuOIC3fZAVbO0wlLhhRutsDDs16r7yXwsrpjao1mWwZLmLoGqOl9n0lGDaceLMu9oqrQkmmyzcw4SOxAdB4g/VZ2ffcmopQuN4FJ5a+uxHwi+WyuKW58oHxceaCEbQOGx/qjpKcxBAkcJO44sOTCcGqv7W9wedY2aV5J/1F14Vbq7zCSzw+9FvoKam/sxOMI0wVAi01CNmNjHdDJIMiCDjzeHdmEG69LpTMNLa2I+cyYadj0WVelrnf24i6MjHmdPbmrx/WLUFckdiBOpL+Oapnw8DN0sLgGeLg6SBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=471ulBFORKqmdGLd1wcfdm/ZOP9zbqWJtJOnGYcY+WI=;
 b=J1+RiZPg/hHQeIEotFB+653ryeb8utNxWIusz8wAO7VTu7F4nfYdAnW0juxnEQNoiR+By+OVhSiOvxRV0Nx1qtRv02ATf3FAzzRUMUti4Hy4EyCw8sneFY6qXWtOPF1YJjXMeca6MQoN4OxXgcZEgXVkGzJbRhYN74WOfq3/7ZVQanmEeYC7e7ewWsKWJIKeqTzGD9LPbD3+UQL/5oO07G0ny1YYsJpc/vlPGnv8OmYdklHrqVpKTcJF9V7Iw7i291rERkCYoHWjmepTse30mSO64LuJ/DJ33QGJfedG4/TyWfqOd9Pbpg81gpChzYzdFRYeeUsOQHvSosmwBGmw5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB5131.namprd11.prod.outlook.com (2603:10b6:806:116::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Tue, 26 Sep
 2023 21:39:32 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6813.017; Tue, 26 Sep 2023
 21:39:32 +0000
Message-ID: <81278084-e048-1dcb-872d-ebf7becb0f58@intel.com>
Date:   Tue, 26 Sep 2023 14:39:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/6] selftests/resctrl: Remove duplicate feature check
 from CMT test
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>,
        =?UTF-8?Q?Maciej_Wiecz=c3=b3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        <stable@vger.kernel.org>
References: <20230915154438.82931-1-ilpo.jarvinen@linux.intel.com>
 <20230915154438.82931-3-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230915154438.82931-3-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0084.namprd03.prod.outlook.com
 (2603:10b6:303:b6::29) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB5131:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cb6d04a-737d-477a-e169-08dbbed9123e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LUZEB40QZ2ZtgCpyHjGhYEtSptzp9xnrU4Jsao6S/BgPN/wZwig7apeMcN8NpwS/GnCB6Oh41zM1sVXghXg15WYehAQefSBbqBgGKzAfHqUw9kt5k8ecmhCQFXOpKDHMAOFyWuhoM73RVswvdhs+ZfXdFWPkFA0cwXeDkoOrneBrAN9X4qSB7vLPmKdqEstPwUC5XopsZZ5qR9qY1KIrp3sX8LOikNoCjP11HBaquHXhd4ou5Sv5jiD/pvm3J7lPpWBYCW1svOPlz4nVfZEHoBSnP/OFlZ21yd1v3NS5OyIFukHl8KbQJHJfSc9KRae5185aYCHecNWH7CFfgiab2orED66ASSW9YmWzyhbjPnOkyiynVLjmK0/nFI/VqO9q5W0Vf/biDllLwr1JfX0r3GJjQ6PCUU/zOP4b/08EY+awpFzEeO1I2UEiTABIBS4ytUasIXhU58rs515h1PfFXnRQvajHVm26c/GFYqdNrwllh+O+H/H6TUSBBbg24FNXVCfv77ll4MXAezA+Gjp5V0EPB7WkkHi8SZ8zVfwyyKeNiVjXh/7XbNwyYlsbL0QpYNBqMldQll5k0tEfZ2Fhq14aLRaahyDd6F6CrlPWc8a+En3AlTS36vFs+mR0M09YxAZojIa3pQBqRA8A1DaOEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(366004)(346002)(230922051799003)(451199024)(186009)(1800799009)(38100700002)(110136005)(6512007)(6506007)(31696002)(53546011)(6486002)(44832011)(478600001)(31686004)(66556008)(6636002)(316002)(54906003)(66476007)(86362001)(66946007)(41300700001)(8936002)(26005)(4326008)(8676002)(4744005)(5660300002)(36756003)(2616005)(82960400001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sm5PT3ltaFhXZmJXVEc1d3hZUlpCWVBnbEZ4eEl5cTNDYlAxOGE4OVpJSTA3?=
 =?utf-8?B?VjZlNjZhclFrd2E2ZjVkQmpIQXJhTTdLTTVRMEhRWEVxVktQcGxWbzhJVHVR?=
 =?utf-8?B?UTJCV2pIMFBJUTl0STRhWXc0QjEyZm9YWjdzM0IxZXhyeVBPSEV6d1grclo3?=
 =?utf-8?B?RDhJc0RjOHpqTmFHZy9BaTYydmhPd3BZS1Y4akNrdHRzVnY1dUIvaVNhMzF1?=
 =?utf-8?B?UXA0NXJRNzNBb0l4N1VQV3RSREJZR29UREYxNWN3UmFrdmlvd2svbTkrc3Yv?=
 =?utf-8?B?QzF2SG9HaGErQnM5V0cyWkNlUFM5SzJqOWJMTmdQT0ZObEZ1aFprY1c0cEtD?=
 =?utf-8?B?SlM2UndSOXdoTWZHaTl5TW9Ta3NyTjVvdDFtUVlmU0RES3RKenhxcmVNTUx6?=
 =?utf-8?B?anVtaURCUTY3NE9MWFFqWnRINU4vRUk4MXZPVFV1cGNHMitTRWJ4U1JvQi8z?=
 =?utf-8?B?WVFvb3hTZS9UVEYrRnpMdGVJQWFYUFk1MkNra09PYVdYNnNHa251VlQyQWxq?=
 =?utf-8?B?Nk5ML2Z4UGlLM29POE9IT2k3VDdXYitBQWdndWdKRURJNkJTVnJ1ZjB0MEZr?=
 =?utf-8?B?WU1hanIxb3orcVpJNFpaSjdtdVhOL0RscFZFRGorKzlvbWtWaDZUT2pKS0Np?=
 =?utf-8?B?ajB1dTIyU3kxdFluWWJnUmlJTEdsdUlSNzU3Y24rdUl0cS9jNWo3VUd6Ky9U?=
 =?utf-8?B?aHlsT2xqMkcvbFlOeHZRQjBHOUVrbGVmQ1ZWYU9namhHalhDRlB1TnlDR3VR?=
 =?utf-8?B?em1PVzB0NFJmdGYvY3NqMUU0b0lIcmxFZTVBUlZTOHFKQnBLY01kcW1PcUZZ?=
 =?utf-8?B?bmQzMjdud051RFBUVC9lYnl4UldqQlpJbUtuOVNmd1FreUhYbTJxMml6UVVS?=
 =?utf-8?B?Uk5GcHNsZnF5Vm1XTUpiMXFwdFpaZUZNbHhSYkxPaUZpQUdCTVREUEUzQ1BQ?=
 =?utf-8?B?ZDFzYjdWVnc2NXBLK3U0NGhVQkc4S0pMZ21zdEt5UmRLWFhtbUJBbEgzYmdw?=
 =?utf-8?B?cGV0ODk0c1I5eGtMaG0yWmt6UFJyd29uSXB3dmhjUzRvM250Z1VCc3JMRzU1?=
 =?utf-8?B?ekd2SkVQYkRsUHc0OE9GMlJEZVZlamdUbXRJSFlTWkJGL3FOdFh4K3A0djZL?=
 =?utf-8?B?SlF3ejh6YXo3R1Q2R0NwdGpydjZlUFBFWjh6RW1odU0yY1RlSHd0eGh4Nkw0?=
 =?utf-8?B?NjVlYVFoV1lSR3NHdU9UZzRTV1JtYkx0TENsRHhJcUpJSENNZnZBY1BFTzdQ?=
 =?utf-8?B?a0NIdE9QR0MreXJlWXNVSVdNVWNMcTh5SW5PQmkxWnJWNXVQOSsrOEZNRTAx?=
 =?utf-8?B?YTk5b1NZMFhMN3hTODhNYkdtbllueGdQQ3F1U0NwazVRMDVrNy9NL05MS0VZ?=
 =?utf-8?B?TzJHL0ltWkpMZUdaL2JscU4vTjJTM1VHeGd0RGZhVVNFKzQwQlJSWjg4TCty?=
 =?utf-8?B?emNqbU0rYU4zOHU0ejFvbzNRbzZzZEJmcGZlZmZ5Q0xaQUl3aHBPV3YvVmg3?=
 =?utf-8?B?UGREZ0dvcXkrdHVNSTRIa0ZiVjB4RTZFOEhUcHIrODlXM0F5dEZ5dXNIWksw?=
 =?utf-8?B?QnJDVWpYOGl3NU5aZ1JHWGNVd1NYTVhFOGtFOWdVcHhIMnM0M1dKV2lyV1Zj?=
 =?utf-8?B?MllGZGJVM051ZTNMQ2lEdlNMcGVIS2srYU4vZmE0cjZRc3dRWUtIM29aRSsr?=
 =?utf-8?B?dTdmVnRldjBwY1g0cTBYNVllMGVWL2FoTDRrTW1GMmR1S05ZWVhYNWFzV05C?=
 =?utf-8?B?QUNBZm9MdlBEVURXZ0x0dmxkTkMvT2U5djlYdk5lRE82RGRYb05LQXIwVlZa?=
 =?utf-8?B?TFA1TCtJQVZKNEtKOTNqRGZ0NWRnaklMRFp4UDUyWFkyNG9zdmJyWkMzK29B?=
 =?utf-8?B?ekRSd0FRUTBGVWRubjlDb3ZadzVEVVJTT3lJWUppemprMTRleC9JMXBCdDd3?=
 =?utf-8?B?T2RNVERUZVU0c21SelFLbEZpZXdvYStqOUYrTW50VFB6UXJCa2tqekE5Y2tK?=
 =?utf-8?B?dkNyMGxHelorQUlLdjBHTFVvNkNYWithQy95dkRqQUU3MmF6OTA2cG9IVW1s?=
 =?utf-8?B?MXRsTTZGTXZsUGUyYUJFSkI0RnBrOFlFUUI0OVdwQ1g0RGluNXNIZ0hZelRz?=
 =?utf-8?B?ZE5UUGZBblNSWnBWSUtOUWZ5Ti9IVXN4VnVEVTZsZUx4Mm8rQXlscXpMTWNn?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb6d04a-737d-477a-e169-08dbbed9123e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 21:39:32.7777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IH5BYiLxdjEP1MGtt7prohyJo27zIpAdrF24eYS9FoOrx9M0KNNgqbJ86jHpz4WEnQUAPIr/LItdtjZriJUta/whFXg7beKwGK10OFLeLH0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5131
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 9/15/2023 8:44 AM, Ilpo Järvinen wrote:
> The test runner run_cmt_test() in resctrl_tests.c checks for CMT
> feature and does not run cmt_resctrl_val() if CMT is not supported.
> Then cmt_resctrl_val() also check is CMT is supported.
> 
> Remove the duplicated feature check for CMT from cmt_resctrl_val().
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Cc: <stable@vger.kernel.org>

Thank you.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
