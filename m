Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607FC6BC20F
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Mar 2023 01:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbjCPADc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 20:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbjCPADZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 20:03:25 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C2A7D54D;
        Wed, 15 Mar 2023 17:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678924973; x=1710460973;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=7twALgv3EQKDq3ao8Hlk0OdSMMr9adwunOlln7VH8+w=;
  b=Lq01BCrqSK/1cdD+2QZKyMayRz13T8y+x3oBhpuUN+uFR4NBcRU6IV9R
   fWKMuDcjmeaKUHwN1v6xXPGIPOdV6yTYdEEWC1O+NUJtd49227aboqe6M
   2mojQb2GczLW4swpfP9LD2NZAdY+1rzhuElpYxrT05T2b7Q7uaocmcpXn
   QwiFZIt7jZj9QQN5DhpqGcsavrvvz+xkoyStaPctLpVMywevSRzOEoQz1
   e5nSt9j7BU0jrtwcpCNwMeqH2AoZ625vPkoV7DOSRCjaNHX3X1dkcu3EI
   +uZVk0G+g6gu0Wq8cQuxQHT9ihbRjxrJ4m9EjpuqKmdZulOxMRCtb805J
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="340210951"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="340210951"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 17:02:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="629642293"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="629642293"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 15 Mar 2023 17:02:36 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 17:02:35 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 17:02:35 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 15 Mar 2023 17:02:35 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 15 Mar 2023 17:02:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXkSzVsXQJAkEuG1ifh8caXGKWlQTKUZng8aMMh2Rbc6MPp0ZCTz999bkcq/vsuKsmi2d2O2KGp9O9J2X+6yraYg1ERH8KR9g2O5UDVxjUOig71qS8x2ZpLVCVCU1ILw8JgdXzlkPFnRLMj9MNujWz1x1K60MfG0uX1P75iH5dHbz2vJ/u1V93TMaEiAUGA1WwRdopIAv5Nc14UKPR6ZoEMEh+EnXs6P+t1ewYz5EJQQaROZlz/tsfMLWUEDGIrv9TXO8CDM6mH3+itxNE0VdeN7MmQULVXXM05m1E1baz3xW/TFIksRTKk8iLujLHggNNT5p2thO0v80KXQ0ZL+PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sw9TftXY/4GEEs7nS4kP5zNOvf0+Yd9bnuVohv945us=;
 b=EOPN7m6sYVdmmDN3sCME8DdC7ni5Tjzgu1nn9dW1Q3JmXD/Wy8jSTkxf4vIopK/Z/7D7wcGcdXGEvXCsWjWzF0wIFCOH0doIVxkKXSrQRhKhNuHLASn3mETANaE122rZyr92/Qn74w5iGJGs8TvgHHVkmzI93oSpM3IiuLOtZM5qydc6PMaukgorUlKS4N7glBappw3gQolGk5wAg2h6esjrJY8v4NRxQlviEs2wD/ZO7/qphcrucVnJB4wlhHnqsbk2mzdGIgWLX5dR91UMeMU2BYFPgwzX7kR0qlBCNNZXmYghWaoiJLNc8kQk03uJg3UOIAoO2Uku1k37UmMmsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by CY8PR11MB7083.namprd11.prod.outlook.com (2603:10b6:930:51::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Thu, 16 Mar
 2023 00:02:33 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6178.029; Thu, 16 Mar
 2023 00:02:33 +0000
Message-ID: <26867b28-df48-20ea-96f5-df28c4c57b79@intel.com>
Date:   Wed, 15 Mar 2023 17:02:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH v2 4/9] selftests/resctrl: Check for return value after
 write_schemata()
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>, Babu Moger <babu.moger@amd.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
References: <20230215130605.31583-1-ilpo.jarvinen@linux.intel.com>
 <20230215130605.31583-5-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230215130605.31583-5-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0238.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::33) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|CY8PR11MB7083:EE_
X-MS-Office365-Filtering-Correlation-Id: a014c085-77cb-4cc4-3eae-08db25b1be3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uoFGiHbN9+bkIzXPELAYdFeIveGZtj7Knh/QG9x1F2YGztHIB2Uiy+pL++QYVKn1oLh0oTceXTuui5WqI5wewyixF2LwFtfKP7z13VLhuXfK/bE4qpSsEYoZaAvMTnA31TuMmNCZxZ1/jPdjlM2ATmVNcne97eXVPeaa3tx3K3uGO+lP97Uo3FTiGSOKYHfGD8fxarU6/SnY3zgJ7wd1bYbURFhlR6RtoxSjIDms2D2tyes8aVoooaOXzzdPs5O2kiBxlHxudgnT814g/R1cwtK8fWesvAPjoFgjqfdA/GPb53jwcUpBilzRaFfIR+OtFwWrpBx6wJFyQGlUZxV5pxNXnXf6ApzQw47gInr1JoaHQpgEisJPUZ9vDdKofaOafKCkQ6s1ofUajWgkT/DoQYVr6sZroHrKc09vkyrlYHLF2QDildR7TnA6ZfWxXJYCSxXdZUN4qn9J4KvejtJzy3+EpBC4RzwLKBpRYInJXTPMgt1Uer9L1WO+bvoxo7uu3PcbHLnDx4Var45s+8jmRu9j1VUxk8jZZIRMWhGxA8AIVjSMXzruSVls35ikZ13cnrvCYpwFbZmWphqAMqhABa480VC8zZgL32iR4CGHTvDnify9Z5AP35SmH2op8sMcMWLyI4G1DJKn2gBWA5bYPXD9U4l6QG0xWSuONOsvEt/+nBzNV7IRLVYGaNWEWrmo9k5kSihGeNjEtAz25jYde3YkiHxzRmngdd+YH5da9WQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(136003)(396003)(376002)(39860400002)(451199018)(31686004)(41300700001)(8936002)(5660300002)(44832011)(38100700002)(31696002)(36756003)(86362001)(4744005)(82960400001)(2906002)(478600001)(6486002)(66476007)(66556008)(8676002)(66946007)(2616005)(110136005)(316002)(6636002)(6512007)(186003)(26005)(53546011)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0ZhVnZpanNjdGVtMVRONmxLTEZadEFIZHp5Y1NCaVJQWnAvNTluL2ZEWERq?=
 =?utf-8?B?N3JzaDhZbEhidUgrMTZNb0laczVuWmVtanRsVUdXZDFnTTRUaXFnb3VvNkRS?=
 =?utf-8?B?NGY0djBBcGFoM1J4d3VkT3YzbXpkUmxmSTFmVWs0YVAvTUYvcWJ0d0wvL01t?=
 =?utf-8?B?THh4Q0VPM2FmbU1XWEE5Z3pQWDNTMUIrd0tKenIybnhWc2RwZVNjYVZhYTV5?=
 =?utf-8?B?aDhReEQ5VTc4ckJ0R1FHTFB2U0tOeXJiV3VoTXpRVjBibGJFL0VSQU53OG1H?=
 =?utf-8?B?T29RbGJMaFVsRDJhSVVka1JabUc0WjEvSG5CemI4TFVDakdqZFZEdzh6bGYw?=
 =?utf-8?B?QVNNODV5TVFXVG5TdyttVHIrWmRycjlIamI3ZjBIZWduV1VpbnBkRmhkdkZz?=
 =?utf-8?B?VXFPdXJrNlJoalRoWE93dHBSQkhVQmZuMloyc1ZXY3JyTUQxSDBxVzlVa28x?=
 =?utf-8?B?emhwbHgwcWl2YlI0dkJheW5IaUdTUmVzQVdLZ0M4cUxWOTgrdHgzOXVzRm9n?=
 =?utf-8?B?SU44OG03S3lVbUlPQ1A1SUNIMGxQclZhVzhoQWNaOXpxU29UY2VkWjdlU0V4?=
 =?utf-8?B?SVZzdTM0QmZ5cUphNU1XeHVaU2xBelNCTVR0M2s4T3hRb2ROZ1dQM0hQMUNy?=
 =?utf-8?B?TmdLVGgwVGNBNGQ5eFhOVllmUUFzMkZIcEVzdHRibk1oSHBDNGVLT0lMK2FC?=
 =?utf-8?B?ZFhHSFhZSWJKWS9TeXZPVmV2NC9LalJHOWNPYTBNT2V6QXJxa0tnUWRSZVJ6?=
 =?utf-8?B?UHpLNGlya2JlK29kdkNmMDVVL0luVGszcVdsTEJFakN0cStUQkY4ZWFxNExi?=
 =?utf-8?B?WUJabTRkNlNQYnlCd3YrSzZtZnhESzdFRDdaTkxmZGJ3MURFb3ArTmlyYjYw?=
 =?utf-8?B?ZEpqOXZzYS9KTk9FbVROYjdHbXdHTjczY0VEdFQxdEc4bDM0bHpkbWRKTThw?=
 =?utf-8?B?ZWNWR25jS0RhWGFDaXNaaXB3bk9kOVZUSjlVeG1Ya1k1dkIyanU0ZCtjZXk2?=
 =?utf-8?B?SHQ4ZjBxTmF4S0FUd3U5bCtKY0xCL1N5ODY5V2R1Q00vdVFwT3dCRGc4a3lS?=
 =?utf-8?B?YjBJbzRpTUVrSnlVMDhVUU44YUpFSzR2U2ZKcjNNSHJwZzZpNHlhdmN0Qnpu?=
 =?utf-8?B?dTZFc1hLeU8vdGNjSGNCUndwdk81Q1lEWHhSRFNvWTJuQi94bDlyaGxEU2hX?=
 =?utf-8?B?MmhmWVU1UlF6cHRhOUdXTmYzVmR1aDJobUdGM1RheEJ4R2RrUW5IODNnRzRP?=
 =?utf-8?B?b3Irak95a0dNcUFDVFJmL0Z6TVNQeHVFYzg4dXRzaVpYeVRjTEl5SGZFSHZs?=
 =?utf-8?B?Q0p2SGtnRzVvU3AyZ1JEWFFCaFVMMGJiTlgvbldnQmVXUm5RSHZvYmxoc2RL?=
 =?utf-8?B?aUQ1Z3pJaytBYlFETmhjZjRxdTZ2M3hLejBMWUdxRzZPM09BWEZzQVYzN2hq?=
 =?utf-8?B?M0VuRVFIMjNKWmU2OHQ0SWNwa3llRTY1d2dMZXM3SklhazA0RG12VGVQajV2?=
 =?utf-8?B?SnZzRjA3ZzRtaEMzbjhJakxhYTg5cWRJWmZqclZUNkhic3Y3Z2E4ZE1hWElt?=
 =?utf-8?B?YlpzdG5jaVJ1UlJJSDZ0TXNRNC9YYXh4aVEwUHdtdmcrVkNzNHhKcEU5Mkxu?=
 =?utf-8?B?cDYyZXJSWDloYmRtNUNLTzc3UVYxaDd0d2RGR0oyMXl1RXhsT2c4WFg3OHI2?=
 =?utf-8?B?NDJIaysvbjUyQVdUMmd3ZzlWalJackdOdHdyL2R0MURWQWdPK2phbnUzaGZI?=
 =?utf-8?B?TjhpNnZiK3BhNkRkejA3a0xScVpWT3pLdFVoNlM5aXphNlB3S1BiY3EzVkRq?=
 =?utf-8?B?UHNneWhlMlhCYjh3ajdTUmE5eEdCZThmSHpnMWRDUEVibjJPcnUwVTlWQnRL?=
 =?utf-8?B?RHhqNER3M3lPUEtOd3pLN2RrVVd6eVQxRUJpS0YzRi9nUVgvYWJQOGZnOCtr?=
 =?utf-8?B?TUdZSE9MQ3BWaWZObERzdzdOWmNlU3R0MkZFQjJ6clA4YklKVTZTMlR0Q0tn?=
 =?utf-8?B?ZDNobDNzTUU5djNNN2ZKRWV1MW9zdmlGQ3Z5a3F5MUFRb2psd3JBZVhrTURM?=
 =?utf-8?B?UUlPRmVqdDlXSHVrM3U1TjlvVFpPNHJFMEhReWR6cnpOZlZnLzc0VlRhekRN?=
 =?utf-8?B?T0M4NGlabU41U2U2NFAyTVpJbW1MUlFEaWZ6RHQ4Z21NUXgzeHJCSUdkQXFS?=
 =?utf-8?B?aFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a014c085-77cb-4cc4-3eae-08db25b1be3b
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 00:02:33.5924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xs7Poq9EGarAV8TJEE4gVXOVXbNYCvezXroJZ3BwHzNoWLow9PhdRIgoNuFVzbUwp/MF1G/gxF6Lu8kqPqeWz6ReXUdsEJHF7lq8gpUcZN8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7083
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 2/15/2023 5:06 AM, Ilpo Järvinen wrote:
> MBA test case writes schemata but it does not check if the write is
> successful or not.
> 
> Add the error check and return error properly.
> 
> Fixes: 01fee6b4d1f9 ("selftests/resctrl: Add MBA test")
> Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Thank you

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
