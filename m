Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B114F6BC20A
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Mar 2023 01:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbjCPACp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 20:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbjCPACj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 20:02:39 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C292823C;
        Wed, 15 Mar 2023 17:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678924934; x=1710460934;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=dEJDM6TPrT1OU/+Ij3a3NJaPy1QUuw4BN+q7iBPdTQo=;
  b=A9V32YJZyJgCPh5kWj4ydPr27Vo6EcypA+5Mt/hv4oTPMLGHs9RkSkdk
   /mRPyKvUAmJbIL5s10UA5tbofKYS8K2DV0111NANwLrA334IkLXEFM2wI
   dxnOow786ezkaW/KT7Gpt9Dq1y/NggaFQaw0TTZ/Cwm7ygsYziNeMHILO
   ynoYohCoit9lneGujaUK+aWibwKoWUR1iac2JOjMrIFbJnqwzs29VOwF7
   zg9vqvU/vC/BGUjG5D+yBaaTqq4bM42ZLz4vQJeToPduLqlDk7YGKEQ9w
   HORBxuL/ZbCJHBg7ybdSRJBfm9LfoG9c/8vptqDLA+e0S3KTRZ22VPvWO
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="321689628"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="321689628"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 17:02:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="822980500"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="822980500"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 15 Mar 2023 17:02:13 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 17:02:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 17:02:12 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 15 Mar 2023 17:02:12 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 15 Mar 2023 17:02:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PwW9QznvH5AYq54Pb3tbbySTvJgZLsV9pLV200sY9UqFSTC4juTOyUn5isLn5TvCkSLZYl5Hfe7vLnw9l94FYwZnaZ2YJF6ZlO0MNJZwFU1wlNv+Q8VS3lApyQixXlosbL1snjZpiGl8dPWUp7sVblKPs6/N5vQo/kwjh8LkbpitvqhQ3ZQFTPzU+x5Lyl5GTOCuA2af0OF/NLvhGCCBo0fm7N7Pd9OJzFkkifKzvjmBT7Lwag/U8I5DrufmMLNl9rmEkGGhzX1xoKhWx2hrZZRSb1t7Qh6o/Hd7oRNOR+R7iuNd6qvzvIIbHbtlS21TqNWgmrL7BVxf4OzSHHQtOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LhevFxUiL83wZuaOqf6rXVVZrFMaZnc6Gvv+SFNfcmU=;
 b=jCNz8JVmqxsBIvCDSy9dgroFpPCOC7YvlVo9jbeq+NGMmg7bj0p24E7M7QMCUCwAejxD9eVPoux3ALtNniWfmfM6yZWqmvPUjGMoXFvhgYWFC5J8ScMFQIZYmUeEUHVYSUR++OAh+8XPbhdCsO+PzY7LrwrpponY5B4e7Ja7dVqrwCm23u5zsuulYxQs8y/+4Uj7e/d9brqXctebIrq3jda0yFDSXZcMJcN9nCoGjAx1pXxghURAgkg5FbquUHFtxwWp+XLN3CAkoGpoqbJiJBpOO1fsCooDWZtRLJIOQDTpvVSKF05VnlUgZfKa0LZyXd7KfsAzeI700KPm+2887g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by CY8PR11MB7083.namprd11.prod.outlook.com (2603:10b6:930:51::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Thu, 16 Mar
 2023 00:02:11 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6178.029; Thu, 16 Mar
 2023 00:02:11 +0000
Message-ID: <c17e8676-61b8-bd00-f8df-8c3a4794397a@intel.com>
Date:   Wed, 15 Mar 2023 17:02:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH v2 3/9] selftests/resctrl: Allow ->setup() to return
 errors
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>, Babu Moger <babu.moger@amd.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
References: <20230215130605.31583-1-ilpo.jarvinen@linux.intel.com>
 <20230215130605.31583-4-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230215130605.31583-4-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR01CA0066.prod.exchangelabs.com (2603:10b6:a03:94::43)
 To CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|CY8PR11MB7083:EE_
X-MS-Office365-Filtering-Correlation-Id: 554b0a1d-6441-42c7-5121-08db25b1b0d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bnbKE2IUO4NciyYIdLKS1N1Kn3tqjuarh7j1ShOR/1cH7QNfGYA8Y267cqcwyzUlcVt7arvYBhLVQIiYEY2R+AdmiRBFEoR8vFx8umfmwpxE9FJJjodLNPO38plT5Hjawagmpp1nmzvv2ubDmsXObfDq6WC6DsoMx7vvc1NT4OVjnhzGaCxbJBHXx4ZFk1F5tbz41fAEMUg6Rlg67PS1y2Aju+VEshOOc/0W+QKF/TQiZRAtUqHUtTVNRbledDHgXPX4v+02TMEJvP2aObfDdIO8Exs88UaGNz0uj200RVMWbdwPSBA+sQmlIKEvRh0xgi9SDwNfxJ4WCIKE3b2bUuFwkaLJt2nmD6Zh4Behw1XBJ4XPzSVPuUP7iu4Ib1+GmP3qQbhHWAlFami4hlWsBuB/Utkyccq3LQNvGFCWc6TPtBjxP2Begiwu/BKIXBc9xuObIWB/x0bSguwCVP8oJZVpiFfkeCg0D1E24AD0MyzqJZXhbZdU0n4H0HbX1W92F7BDxTiUMcTsXxtXnbXdnBlKMTLh5MXKcTbBDEU6B2AuJJmaLGax9BHwNBhT3zbU3HrO+zPKumqA7KbdbZERduCZ3vCwtSWDQWqcSGAlaxV4daeqet6HafTXbSUCFGE/gy/wRSM4ux15x4g1xL/moPUb0aRWp4YmD+sOrfLHbAsqCwA5JLguFI1/fWE7juDmsjlH9IeqqkvK4sEBkzIsj+8IpmFyFgsS3hdhMXGjAG8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(366004)(136003)(396003)(376002)(39860400002)(451199018)(31686004)(41300700001)(8936002)(5660300002)(44832011)(38100700002)(31696002)(36756003)(86362001)(4744005)(82960400001)(2906002)(478600001)(6486002)(6666004)(66476007)(66556008)(8676002)(66946007)(2616005)(66574015)(110136005)(316002)(6636002)(6512007)(186003)(26005)(53546011)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vk9jRFo4Z0huTDJOcGxjUU1MYWRnWm9LSnRYTVlZUHV3aVR3ZGUrN1hsYkpv?=
 =?utf-8?B?WjhDcUNYRE9MeVU1cXQyaWJlLzl5akR4d3BUMngvRStzZjBDeGNXZWplUmhz?=
 =?utf-8?B?bE5ldmg5eExqZ3kycGJWdW9lZjdaU2UwSWlUWVcxek11dUc5VEl4Unl0SXp1?=
 =?utf-8?B?TzZnWWxkWVdKdWc3NWxOMEppaEp6azBqSC9Wemk4VE1HYUdYMmwrd0NNaE9N?=
 =?utf-8?B?NGdoNTVKcXdUVGdmblY4Q1R5WmRnSm5RS21SUzFhZFdOdklqQk9PT3IvWS91?=
 =?utf-8?B?UXJEQ3FNTzB2RG5FNzRTTGRPZlV3ZmgzQ1Q3blNSdjA1MVB1bWM1TXJXY3dD?=
 =?utf-8?B?cVFESlp1Nm5NcVdMM20yVXZmd2NEenFQTFFiR29xeUJZWVhsY2VFeEpxdWYy?=
 =?utf-8?B?UEtjazdZQnFmWTBOUnBObFNMek1OT2ltUmpBR05sclRtZG5yNDdnb0lRNzd1?=
 =?utf-8?B?ay80MVVmUDlKK2ZUS050eEVPTU5hY1B1NlBxVDk3Tko3QnY3Vy9STnh0VEV6?=
 =?utf-8?B?S2NoaGVQTEQ3NTlweStSaWV4QWNXNTRBbStHRmJkT2tjcFVnZ0R5RytBZGNn?=
 =?utf-8?B?a0JzNHJHM3hFVzVML2IvUXhZYUF2OUtDTXhTZkZBY2pGcjhub2M3SW1sL3FU?=
 =?utf-8?B?d3VOWmJ6cEwzVVFxcHA5ZU95UWhmbVE1R2RHRGlnMHpNNk9UZjd0dTZjVFNW?=
 =?utf-8?B?SHNIMW1OQmdXTnZwTjZyaGJ6VitxdThXTC9xUVhKT3MvSlJHVVczallHYUNS?=
 =?utf-8?B?YXI1dnl1dU5OaG1CMDNVQTdkbXRBbi9hM2UrS01zTzFuRWtTUnBmSk1Ja0dw?=
 =?utf-8?B?RWE1aHhzTU9tdFBMMTkyNWdmNkpaU1ArOFJuakxGUXBJUGQ4N2xQYnVaV2ZE?=
 =?utf-8?B?eDFWdzNUMGtkZWZPVmtIN3pYK0dYUTNjVUdHdU56aDVicHVNV2NUZU5pZUZB?=
 =?utf-8?B?NG02N0tFanpVRVB2TWlsTjRMMlUxZFNDTUxqcU5MS0dVRkVBOElQOXYxWXZB?=
 =?utf-8?B?bkJGMm5IdngyMWw2dU5IakdkWmZDTlRDK1NNYnVoYmJzeEI1eUxJVHFDK1B1?=
 =?utf-8?B?VTFWNXV3SFVBNHJ0aGJubzVtdnJ1VWFwcVRudHpld3IvT1NtRjlYVHZwQVNV?=
 =?utf-8?B?b1ZIVjQ4MEpQZUxTazd4ejRQZXQramtyWnpzbjczUkpoc1RndGs5TXhZNmUr?=
 =?utf-8?B?cmtLYUszTTB0WU5LZnVvcUJFdmsyZmhFODgrYnkzL0M0bDdEQTQ5QUkyaWQy?=
 =?utf-8?B?eFRHenNvT1NhSy94QjRsNHdFNzlobHFiRUhXYm5iRy92dHZWMDgvYWxZVk1h?=
 =?utf-8?B?SnduTFk1Uk1sOE9sQk5JWnIva0hTeGxTQnFad3JNY2Z6ZTJTbXJIK1lBZnJj?=
 =?utf-8?B?RloyQjZYeElHM1p4UlZZQUpkbnJ1eFFid21aMnNLNHZUVGc1R3F4YXBhR3cz?=
 =?utf-8?B?Q2dPSDVsbTY1YU5TNFkrQ3MrTFNDVFIvNHZmV3VRemZuSmRTZXBDMUhjL3R1?=
 =?utf-8?B?MEV0YlZVSGpwZEZDMWpRNi9Ea2pVaFg4TVQ5aXZueENuRmJpUGkxOFpOQnJr?=
 =?utf-8?B?THZkbVpWbHBPTWxVcGFnYmlJY0xaOVdyNG5FV25PMjU2N2ZxL3FabzBCYy8w?=
 =?utf-8?B?ZXlhUG8rTDc1ZkFhVXpldkFySlhGcE9DMmsxU3RrMVpSWkxodG9nQ3Z2akYx?=
 =?utf-8?B?bEZyY3NNbEdvQTVUc2FocjVlbCtWcHBleEpPLzVqTitFYU9GRSthQ2thNXdr?=
 =?utf-8?B?VTZ1b0ZJTFMxMnExZUxyRC90YSswYkRjUFhXM3p4NmQ3c3JIN2M3dEwwYnJH?=
 =?utf-8?B?MWgyQytPbzdpb29zVHhYRXo1eHdydTVicWg3VTN1NFpLR3hBMHU5OFoybWk1?=
 =?utf-8?B?aWFtdTNiNUxhUWd3eHVHKzFXUlVMOXFjMThsNmNTQWhkZHJyd1JuYlVZSzk4?=
 =?utf-8?B?WVc4bmxHWVh1WnNlWXZrZ1FQcXNFM3lMU2I1VDIxM3dTTktmeDBMRlNUSURP?=
 =?utf-8?B?V3l0cmVJWTN2RU1FcFJ0dHFMVlhNMGJCc1FWZWU5ODVWbDgxTGZtQ2wrSzBX?=
 =?utf-8?B?VW0vRVM4Z1VOYkJMeE1LZlRzaEdTSG9lN3hvM2MwL3ROZkh3d0xwQXZvUWtx?=
 =?utf-8?B?TThCUlNFbDhYK0JuWHAxQVNMZzI4OGU2NjN1dm1Oc1l0QlFtMk1MSWE1L1ly?=
 =?utf-8?B?clE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 554b0a1d-6441-42c7-5121-08db25b1b0d2
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 00:02:11.1256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9YJ7XvHP3myUD2CIXNcsEzQwQfRhYDrsnxMSKrORNh4C6gnuEfeXJXNgQuCgWtlu8sidcxgo9ri5nyL/a2yVMeSI5d+6NLdSwso2RSCsFvQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7083
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 2/15/2023 5:05 AM, Ilpo Järvinen wrote:
> resctrl_val() assumes ->setup() always returns either 0 to continue
> tests or < 0 in case of the normal termination of tests after x runs.
> The latter overlaps with normal error returns.
> 
> Define END_OF_TESTS (=1) to differentiate the normal termination of
> tests and return errors as negative values. Alter callers of ->setup()
> to handle errors properly.
> 
> Fixes: 790bf585b0ee ("selftests/resctrl: Add Cache Allocation Technology (CAT) selftest")
> Fixes: ecdbb911f22d ("selftests/resctrl: Add MBM test")
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Thank you

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
