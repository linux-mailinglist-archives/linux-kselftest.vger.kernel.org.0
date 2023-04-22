Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E4E6EB624
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Apr 2023 02:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbjDVAII (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 20:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbjDVAIG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 20:08:06 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222841FF1;
        Fri, 21 Apr 2023 17:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682122085; x=1713658085;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CQuW7Kaed/RU1vL2D4nTGYeALvDsICjl8KOwKlVTE0A=;
  b=mkqmRBcj4XuqBCUDCdQO1qri06bQeVz11vfAX6o6tbMupkF7awGtavSF
   TWMdrO1IlDkO9y+//i2/3Kan5ok1C5lAvsMe/RN9UJtUeQGmyHNC0D1bK
   4PTXnxH9fhcExfXXVKkT6mU4GCkzt8XMEpI4PC+QjohyvC81gl0LVJaJe
   GHS73ShAIWux34tdkdNofI732wglop4gOdyowfYquv9kue4GZ17KhI71B
   7MiMRVKtvkWpzVuhDdfEFm6+CxxmsRdwNeBSjTBDT63pjzKrtHM3wduNt
   3qpH3vdH27xgZLSK2c7D8si6W36hJqsQ7jjHzKLLfrH8yj19N0p0+j+L2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="334994304"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="334994304"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 17:08:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="685875093"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="685875093"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 21 Apr 2023 17:08:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 17:08:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 17:08:03 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 21 Apr 2023 17:08:03 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 21 Apr 2023 17:08:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1YWxHKuOgT/Z9jBORt1rI/J9CntNM0HijxF8hJixX3qFgKVWjt5QEVkfBWYpSl4kEtY6O9tKraEVc0DsuzD6B3Y3TkY/fXAVeQ5PT2FNod/QT2zuZrzGkEp7hEOrD0iPl0Ctnm3ZRaVXOu6LCuDI/TQAO4S40lcdCrL61umM6cOzEzGUlc8FiOaN06T/ODR5yU093H85Y6YpM7XopyHBMBynCE1H9K017j8ePqHD+JkFAYdxMEyrWvlOeXCDZlvSTE+2wKEDZ+WqFuE7Z8UAFbBEK/HoPyDmK6Y7b76spfQJd7Xz5WvCFC6ndruOlvQDLXwEwxWsGFLhZ5m/LGcmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HhLw3EjpzQAS5Fp7H+oY4KU+LGeSI5FSLcZUrxlDTnQ=;
 b=joktwYoy+WKigD0ZgJ1FuSctpAFcGe1Jtd4HJKopB2JDqp8oJveiGotlEk1B+LKtl5newVbgqujkN05RoKqH2qmzNck5sKKPXjSZbutwMEYZqqX7Nghj5F2Hjc2tK0s6hoP1r1RcrD9dcyVt8AQEa4VV23wfYtoKQTjPVzwsWC4y8MA7lb7WVmf5K+ceJ8n7fl8vYbYwvq4zKmOH6anMFS1M7XAUD2ajENdcyFWjWz+nmKARnEXu90KwlXBsGs/ME4HfTJ6U4D2cXWIk2HzpQZ6+oSFDKRnSKFZRPy1IjvJopZ1FwBzLnc4oK2bO6JyAxm6mtOFSt9pnCdylMaiyag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SJ0PR11MB5937.namprd11.prod.outlook.com (2603:10b6:a03:42c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Sat, 22 Apr
 2023 00:08:00 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::2854:770d:2a43:dbc6]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::2854:770d:2a43:dbc6%4]) with mapi id 15.20.6319.022; Sat, 22 Apr 2023
 00:07:59 +0000
Message-ID: <a1c85bef-5f41-c49b-a012-1e75e69a3789@intel.com>
Date:   Fri, 21 Apr 2023 17:07:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v2 01/24] selftests/resctrl: Add resctrl.h into build deps
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "Shuah Khan" <shuah@kernel.org>, Babu Moger <babu.moger@amd.com>,
        "Sai Praneeth Prakhya" <sai.praneeth.prakhya@intel.com>,
        <linux-kernel@vger.kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com>
 <20230418114506.46788-2-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230418114506.46788-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::42) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SJ0PR11MB5937:EE_
X-MS-Office365-Filtering-Correlation-Id: 39ec07ee-ab29-4c38-d4a6-08db42c5a0f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fcbhB+zTYVCfQOZnyDJNsHN6O0cLeUt+viSAd7udrCDfHwyz5+DhxAZ/QYldp9f8sE0+uH01auPcNEScBFyVSRM1M56oiJkboCt7MgDtbgZSMjMPbwnuyvqXr40fPXkWkWxp3qKByJjqS+JrRHuS4doDedD8aJ2HMraaGdkrTzgYO6tmjpV/S7E2PpuKSFwdXDUVMh8nUkRiV85b8hedNk06OPJxhxl863rDJHPH4aYdJq6V9pkn/TQNOW/WEqaXtWOLn8xo1WECS19rVfhrCkRDTus/ZPcC4oZGemBugcGPK72LgYRxp5evvXGRqfps4/EQdjZxn8oNcZEaxEqMesw5NQScnPrKuDAkntj/PoXCYS/2EsDC/KKA1afewbbmKxspQ+U9SB3w7RVHVb5llMUEEppDuiZgucQm7lN3HHd5wq7t1SsY+BQzGVhCnYX4y83S74sU7Gq3FFdIKiUaV39jPoFu+xVM5iJdltRayjsVy6pHlceVhKTFkD4b6h1X7AWCgYo3ImXG8H4n+12GJdint8PoQOkElays/ANeq3jGKLBXz0DXPHxY1ABtebNfS4+QfquvfJ4yUl06NXse+GoGK75BkeLrP6MxMT0aG8KUNAfRJjz/psF0ikLPAK9olwE/nZK38lAyiOX5XAqrUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199021)(66476007)(478600001)(5660300002)(66556008)(66946007)(82960400001)(8676002)(8936002)(38100700002)(316002)(110136005)(41300700001)(4326008)(186003)(53546011)(66574015)(83380400001)(2616005)(6666004)(6486002)(44832011)(6506007)(6512007)(26005)(31696002)(86362001)(36756003)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3loYWdxczBrOWdmeVR4MkQwRFl2Z1E0Um1CVllVcFlHYytFWHhwUE1RTWgv?=
 =?utf-8?B?OW51WkQvSnppWE5QVnFNOWVMM2xzOFJzOUVjOXNDR1NnZmcxZnJCNnc0L2ZD?=
 =?utf-8?B?cWhpZnFPTWx1Y0RNVEpDVVVGRG1vbjhmbHJCMUpacFk3VjFrYWpwd1ozeXBB?=
 =?utf-8?B?S1FBUW1GTlpFQy82L0hFVTlaVlJlZDdIZmFnWWQ2UHNOT0tPQ0FOdWIxMGlF?=
 =?utf-8?B?NEpoTWV2V0RLcG9wM2xpM0xrdmxqamhLeUpnVVQ4UzNqSkpKQS9jSUVSakMy?=
 =?utf-8?B?cVl6anlOL1dYV1JaVW9mN1g3aFhHOTdMZFMyZ0p4MVljZUt2Nk9ZYnN3RTlx?=
 =?utf-8?B?QmZXUWtjOUNxTWZGUUdDK1NyVzg2NnhGKzNvRVlQMWhvV1NJeXV3UWcweFB0?=
 =?utf-8?B?U1Z5S0NhUHpENFZvVnROY2VockxXQ0FGb05TZEVlZHhhYlhncExNN1EzVTgr?=
 =?utf-8?B?ZmplMjd5bkxvbmRpYlp5WVNMbVl0dENCbXJEYWViaGJJT0NKTFJxZllJTWdP?=
 =?utf-8?B?T2RwQk1SNGxnd2F6cEUyNGpXa2w2UkJVK1VpZy9aZXpaRHlrY21xejU2Q2k0?=
 =?utf-8?B?SXNLQThyWTJ0dUR1Y2tSb1NlcDlCUHVtSFVZQUtDR01qM3YxdDNpSWZWUmRq?=
 =?utf-8?B?OCtRK2QzL1dYVTh6WkxadnV0WVg3WGRRdlNndy9MOEVUbExJSUFjY2dhMU1L?=
 =?utf-8?B?YTRvdUJPSU5sMlNkcnRVUzV5WW9YWE00R1dQNXJiRVR0RDhDVzVkVk1LZDht?=
 =?utf-8?B?eTJXRkp3T0Fia2VQQzkrUXNaOXdGdFBISjlueWJCOXFWUkNMVDcxNmZLNy85?=
 =?utf-8?B?aUZReWVLbE5BVmNxS3gzblp0WDAxQ2JCQUk5SWxaeDh6aWtCbTBVMWxKUzdL?=
 =?utf-8?B?bDJ1RHl5eU05ZHJ3ckYyWFpaNVVxT1hRTnhNTzloNVlhWlFtbUZHMU9kaWpD?=
 =?utf-8?B?eVpiM2FGNW9sVmRIREVJRG03bENWczNGVjh5d04wbmVqU3l6THNOZmZvaWxT?=
 =?utf-8?B?bmN1dVVjbHhzREV1c3pzZUZSMkFmYXB2eUlKS1VHTlVGeW9qN1IzYnpUTU5P?=
 =?utf-8?B?S2lqY2hWR1BBYlZ6ZGtabEZHQUcvUUlTZVcvLzFVeGNrOGsza2t6VHVnMUFm?=
 =?utf-8?B?V094YlA0VnpWQnFpZjR4MEUwdW9GZjkvSjZBSUZQOW12eEtiL3RWbCtJNWVt?=
 =?utf-8?B?cVlrT1RPamJOaSt1RkxpOVQyWHlYS1VIK2Y1RW42SWxzZitZMVBOUjZTQ2dB?=
 =?utf-8?B?RExGdEQvTFYwcUtvdlJ3Z1JLV0xQcHhkN090V1h0eWtkSFovczBpcVNySUhO?=
 =?utf-8?B?NnE4R1gxd1djdmpFakNFZ3p4VmtKRFduRWprMDhWNlVMMEFLU3pRY0pqL2N2?=
 =?utf-8?B?ZDgzMG1WU0VWSzA1OGtSV0NSMG13WjgwSUhiOWd2RUJ2QUw3Q0pLaGd1VXNi?=
 =?utf-8?B?YkVjcTNHQklKVGhlOXV4bmwxSGpqaUZuWWZPWnB5MzU5bXQzK1lEL3BRS3Z5?=
 =?utf-8?B?clQ0NGd6MGVIWWdWd2hDUWpwUDVrVk1FRXZ2SjE5Y3V2ZVJYakVLUWdHNjM1?=
 =?utf-8?B?WHNRN2JtcTQxM3JaT1Avdkt5ZmNTRnBTcENRZ0UvbDdGWWNhZldOOFVUZzhr?=
 =?utf-8?B?R0cvbnFRbENyZ1N4UERwczN4SWFua3JBZEtXbEc1NWx2T0JnM1dTTkRuTnh3?=
 =?utf-8?B?aUJBQlNqc3ZBVktBSElKTDZUY3F3ak9jalNKVFpoS2x0aU04ZkpmcmxqcDkw?=
 =?utf-8?B?LzdkTlAwcWhkR1hacjIvam5jOFFjUlFQdGNnMUdKT1A2ajhxMHo5eVZPZjh2?=
 =?utf-8?B?STFaZi8xZjdjbTNjeDBMWkx0V2xqdVRvQWZ6UXVnakJweXJNbitseGNsN3hC?=
 =?utf-8?B?ZUNyV29kM1hsSEdaeUdjRVkvb2lwb25JSEUrd2dycFA2c3BZR0hDeGhlMnR2?=
 =?utf-8?B?K2lwUERnSUZ2Z2MyRkZTc1BCTk5mZEdQci9SNUt1ZnRUODZFQUVJaXdsREpP?=
 =?utf-8?B?TnJ4S0l5V1B5WnhRdlJxMC8zY2o4dW9ud0xHTVVXTyt6akRXbEJockE1WDZr?=
 =?utf-8?B?MlFOTE53UFh1MGd5RGZFUExwMm9zMjVvSnoyN2VUZTZKTldqL0RBNFRTM01o?=
 =?utf-8?B?eHFhai9Gay9xVTBSeXIrbHI2RkNKRy9jTU9kREI1U1ZHZUpQQTlDbFJTV1BO?=
 =?utf-8?B?ZkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 39ec07ee-ab29-4c38-d4a6-08db42c5a0f6
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2023 00:07:58.3265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: arrfbAcX12kRHo8Nmz7QCrphNkj0K8RmME7JD9FL09Z25n+8bFOg3rvhSO08YDb+wKxw8YeeJ6Ca25qIBOAelGSYCK5iT2URQ8B5XCsRZX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5937
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 4/18/2023 4:44 AM, Ilpo Järvinen wrote:
> Makefile only lists *.c as build dependecies for the restctrl_tests

dependecies -> dependencies

restctrl_tests -> resctrl_tests

> executable which excludes resctrl.h.
> 
> Add *.h to wildcard() cover also resctrl.h.

I find this a bit hard to parse. How about
"Add *.h to wildcard() to include resctrl.h."

(considering the problem statement indicates that
resctrl.h was "excluded", having it now "included"
seems to match)

> 
> Fixes: 591a6e8588fc ("selftests/resctrl: Add basic resctrl file system operations and data")
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  tools/testing/selftests/resctrl/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
> index 73d53257df42..2dc7da221795 100644
> --- a/tools/testing/selftests/resctrl/Makefile
> +++ b/tools/testing/selftests/resctrl/Makefile
> @@ -7,4 +7,4 @@ TEST_GEN_PROGS := resctrl_tests
>  
>  include ../lib.mk
>  
> -$(OUTPUT)/resctrl_tests: $(wildcard *.c)
> +$(OUTPUT)/resctrl_tests: $(wildcard *.c *.h)

How about a simpler *.[ch]? Seems like this pattern is
popular in selftest code.

Reinette

