Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4645EE0D2
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Sep 2022 17:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbiI1Ps4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Sep 2022 11:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbiI1Psx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Sep 2022 11:48:53 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA08DC10A;
        Wed, 28 Sep 2022 08:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664380130; x=1695916130;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UJxfHKwSUW5GGakd9PdaxGQ6jxvbZwKnrYa03YR18E0=;
  b=TgVoq5UQdh99EGpE/QfLKufLaT07U/FDGKm0h2jCMKnhUiy78PZ9iHjH
   MkqnAsZwoWgiJkXO78T64po2aMlGb9JBRrdFlqYUk9FbD5nZzt91fq40i
   SkQvB0oh6dIYqL1YU8trwWnsP0PO/N/sj/nR/IsOyZpZBzZBKTHXS0Bpv
   zR2r861bQ20b6quJBxRGRULiyq2qdaaBwY7E0+uZ3GToCj4qzjfJH8Q9W
   kE6UUIAU42oHZAXGncaxI60z9XrIGVu97MzvQKAKRPEqjBZMwaQUARUmD
   5I68fY5JJSCGO7ib8J1Hz5numfsMhkIFI2j1RXQCya7eKwaiwM1tmdPgr
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="300355042"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="300355042"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 08:48:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="867017826"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="867017826"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 28 Sep 2022 08:48:50 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 08:48:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 08:48:47 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 28 Sep 2022 08:48:47 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 28 Sep 2022 08:48:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJi/mlV0zdK/TptOvrGxaJe3cdxXk+iYE4tPbZ/waiXLuW3uBfKiELuBXvOJpH1udoFAQW28P5QWP+G4KU8R6V92qEakXeexqzkrw6Am3bejDrqsjxgKAu9uNNJ15NLQNxByr31+h+g8wPr1SRtw6N2WUpWlMt3I4QAomEkW/wCbZHMPraJ4hyVnAhNDeMLHw5JC/TZnOoRg1Ii6QEzOCdVSkhX0DOEDTWn9KTaNWFzNSIFdNGjJvrY0FOy7kLsSrvBK9YaDHpPal+TMoBWr9SL1D+hH5kx6Lc5MDDRVpfLKZjmtiXdHsuYKwowYfq1wi0n+3P0J7SnHTff6+LeZZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djSLrhdmX5gSTskjhqGZ4p5YxMRIQX8r7TBOMAaRT2Y=;
 b=gHkyUyKbLRqHtrfJuUOduaTw/AzBjDvFor0wPZ3Qa+ptzfx5mRxSAYdDuacWU5Se3iRdHYa28vNbrYB9SezPukdt7koU648gjERC5uSdO3m+ctwsNgMmMu8X2WAb7HjNZ8BI8rHgXUrbLD3XAncCmrmTLv0o6Ce0iWxTBjkRflkodUA/b5YdmQijcki4zSuwkZEacmjPfq1+hsliWMLe8L1sYf3nKa4fDGlsHRN+dg1FA8fmTqRiZ2sdbEVVCutY4PR9xt2R7NTTvGZ/qR15gpWz5AhWMFhXeMilOa74iOjonZLdw7iKMqXLt2I4W2NBgFqR1jX+yjIljCJ8h5veRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by MW5PR11MB5930.namprd11.prod.outlook.com (2603:10b6:303:1a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.22; Wed, 28 Sep
 2022 15:48:43 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5676.015; Wed, 28 Sep
 2022 15:48:43 +0000
Message-ID: <a0841d1f-fcc1-f307-7e2d-b9cce534455d@intel.com>
Date:   Wed, 28 Sep 2022 08:48:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.0
Subject: Re: [PATCH 3/5] selftests/resctrl: Remove duplicate codes that clear
 each test result file
Content-Language: en-US
To:     "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
References: <20220914015147.3071025-1-tan.shaopeng@jp.fujitsu.com>
 <20220914015147.3071025-5-tan.shaopeng@jp.fujitsu.com>
 <bdb19cf6-dd4b-2042-7cda-7f6108e543aa@intel.com>
 <TYAPR01MB6330988D96E4CD00C9A03DAA8B559@TYAPR01MB6330.jpnprd01.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <TYAPR01MB6330988D96E4CD00C9A03DAA8B559@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0036.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::49) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|MW5PR11MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: 4246948d-84e4-48d4-4ed8-08daa168ebc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KJWOJ1kZWES5Ero/MxVFL3QPZZ6G+2HvO4G/IGuC5Z0itj1dTJdi1GsIN75r9+3IQHucf5kzfGfGi4kI7dQed6VhWcVarGqA11s1F97PGtiFjtRvKDAC6uUgKIyNyTQjInbCcx7724P1cmZAl++JU1ocnoPzoLQR3AnarkVaClI/t/JYnXoLeCWgZMCFzzt+6MA68S5o8aL0f4MJrG3AeNdRsZelaVVZ2tuZAPiJQZsEjCNcHswxBAb5vujsn9rQN13dlyk+XFs/V0G7Xhy+QzDr+JDyydojUXOR+cqhG4pi3NdOpzOvHIZLofyo6ftnQhVtJ53BS3x4mtSM59oLL/odIZS1es5KZlDZMI3e9yUzhjEGbUqr9KSW8T4GzS7g380QzB+g0037sT58fQU+9w/vaIWaQykX2jxzgK8P/iOpTa+HNOMk3LQMmLNdeLQtHJve5SSryPhpEN2qciUy14gkLhrx2OwcN+tV6bYaeZMhQzhP3sZ6AbI2VbPuAXnBAAOBqOy9uUe8EzHXxTJiErf4ztIaaMsSo/QXI9iZ++uFzUfpCtCg1cOcb4pdNVj41X5pOqssl3dfF8T/aGjtQTgPlcSx++YNwwoFft+CrEVyFksjikAYzgo+qGl8X/p062I4upC6/rEhYboPepp1ZXW13zGTcNl/oNHEjdW1W5zsowoyLC6yrJerinmzbU8neN2sbyodpFPU1d/s8K1rpLBCzZsVzRHYaF+Z//WUmIC6x+ZXNB1BRLTwT23AdWwIPsq+s+55vK2zKP4yyw5xrvTDjM6zIJTg6Am1mflpbHg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199015)(44832011)(8676002)(66476007)(66556008)(38100700002)(66946007)(36756003)(31696002)(4326008)(6512007)(41300700001)(26005)(6506007)(86362001)(6486002)(31686004)(186003)(110136005)(4744005)(8936002)(2616005)(316002)(5660300002)(53546011)(54906003)(478600001)(2906002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGxqbVRaN0gvL2lIbXpyN0dhUi9xZXhvM3Y4ODF3TXhSU251MW1TZ2pzcG9z?=
 =?utf-8?B?WFRoSzQySmgvR21uZUcyTWZjV1UwV2h4NWNyOUlkYk9zSWh6VVNseTBPMkNJ?=
 =?utf-8?B?bWd5SUEzRnovSG1iOTBwYVZRbFFuWTZrbGRtMXREVGlXeWFjc0ZGT09UN0lz?=
 =?utf-8?B?di9ZZXNNRlI0M1RKeEE1UE0xWFQ5R01JV0VxYXlHK0hybitLb2cyZlNtUDJJ?=
 =?utf-8?B?VDVtVzZHYWU5YVpjTDEvK2pyUFNWQXliamxBRjlhbEcvRmo0Uk5SaFZtN2VP?=
 =?utf-8?B?UnlhR1h4eXZxUlhCOTM2WEhFam1lRmdrdDdlL3lobmZuSkNNOC9LS2RHM05a?=
 =?utf-8?B?OTErT3pDWkZldnBack1xRGp0UU1BNWF4YTd6QTh1eHNPUWsrTTdEbFRqeHBR?=
 =?utf-8?B?S1Ftb0s1akV2UU54L0FYd2VSdG9nTEIwQVpPU3dreVp0K0EwOStFbGdSM3RW?=
 =?utf-8?B?UE1iUENRcGJ0OHVnamxnNVAwaE84MnpsalNIYml1ZEVyMmhtekJydjhWTkMr?=
 =?utf-8?B?NjNLUHJpZURzeVBXZm43UnFVd0xldmpWdytkRWE3d1hzRTBlaXJUQm1YakxY?=
 =?utf-8?B?cnI3LzFPdWpqSXk0K0NEVGpMRnBPcUNxenE2SnF6SlNYVlhLejNLa2gvWjJS?=
 =?utf-8?B?M1p1ZWFVd2V1UlRZaldBckJuTXpoUkFVT0Y0RSt5SUZwRDI4U2xWWEJDOTRy?=
 =?utf-8?B?WjlkVVdIN1pHdUcxcFRzSC9jSjMwekxFK3FaZnFWRlR2eEJaTzFDc1pRajNW?=
 =?utf-8?B?SVhjcGU5Z1EwNU9RYit0MnRSWmtVQlZtK2FBM1QyR3FGS1J0bnhaUHJyT0xU?=
 =?utf-8?B?RVRwUmdYbHRJWk9BcjF3WlpnV0p6clFjWFRpN3JYUXl5dkg1OGthcnlQZnAw?=
 =?utf-8?B?UFNvYkVGQkVPVzVhV0taSUordVN5K3ZPWm9NUENnUkE2NEVSbndqY2lwNzFp?=
 =?utf-8?B?dGNCZlBDb1Y4eElMcWQ5dWVwT2FiMlMxT21xVUJyVDRVV1pBczlaZWFkRkJC?=
 =?utf-8?B?YUVDekJ1a0ZBZ3VrZkZzTkkrc2VMb2tnZURpUG43N3kxN2NvaytCaXNWTloz?=
 =?utf-8?B?Mkd5TXpsUk00MHNPaVhPSkJ5aW5sWllNdlVRNzVhUVQ2dFBOYWVkN09RaVRO?=
 =?utf-8?B?NC85dXNjWkUvWmxmYWsvc1VXSUFjWUZqQUFLMjkwN2JSSEE5c1p6SzV5WXYx?=
 =?utf-8?B?VlRGZjNqbVVuVWxOWnJkNXpvemJwMkxsYzdOd3pCb2Q4UHFUZ2Fjem5vbkdM?=
 =?utf-8?B?WU1tRnUxWHVzT093cm9NUFczclBya3BqRXhLVllwQmY5SnBFTk5ZTTAvWml2?=
 =?utf-8?B?ZGZESXNCcDB3SE8wSlNaa2NoVUJzZXN4dWtQZmpxWHIrVHVFNmtabFlCMDFy?=
 =?utf-8?B?anhjNkU1SlBXclBYT1I2S3dSVUpUTUdXSXJMdUhHb0orYUxmZUNTVlh4cm5u?=
 =?utf-8?B?QSs0dGJCV0ozb3M4cjhCdWxrcU93cGtJanBRb1hXUGlxZEREL0NXOFI5d3NG?=
 =?utf-8?B?cjdxcHFTUU9oNjZHV214bGFWL2R3UU1zeVhrb3ExaWtDYlZtTzJDMkRyMXVw?=
 =?utf-8?B?ZG5Kdm9iMmExOEFaRkIzZTFFUUdUd29LeWJoT2puR3RPbWVZVC9CZXRGV3hs?=
 =?utf-8?B?VHRmZmw2ZmxHbzN2SmhoakZVVjdmRFBQSDFTK2xsSTdYWi9hVkZzRWZIZ1py?=
 =?utf-8?B?RlV2MFBVVExkTFBSYlh1c0pwYmZpQzN3bkpqQjd0OFlhQVpiTEhQMzMyN0kx?=
 =?utf-8?B?QVh1d3ZVeENLQlBsYm16eTVKMEZpcjdjS1N5ajZOYnduQ1hNZ3V1ZkpIMkFE?=
 =?utf-8?B?Nmk4NEM2S2ZkbVdZc3c4Wnlla2EzUGUrdjgvbmd4MjRpQ1BRK0lSZmNleG5h?=
 =?utf-8?B?WHk1R29FQkYrYVA0L3ZzTlFDSDcwYlFoZFpoN1JUcFVHSUwyMGtGbEc0SXF1?=
 =?utf-8?B?OHUvSCs1QS90VXl0enE2bFBYdURweE53dWNLTnhVUjhDRUR1ekwrZW0reG1r?=
 =?utf-8?B?ZjBpWElCeDB0UmN2SjE1bGs3Zis0bnl5Q01SL1VyM04xb0NSdGtHWFd2aHM4?=
 =?utf-8?B?QSsyR2pwTkdaZXJLQWtoVGVDMldZc29ZZm9zQlBvcFFGZ0J0K0Z1NHhXcHYx?=
 =?utf-8?B?YVlOWURVSU80NDZ1UGVxajhubEZzL0lsc20vY1c2OGpGSW9XbGdKQUN0RUZi?=
 =?utf-8?B?dnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4246948d-84e4-48d4-4ed8-08daa168ebc8
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 15:48:43.2352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rkHXcupSxqJ8o+995ND930EIgqSo1Vzxn+dwqmBv+7a7MfLVTyGmQhUgBSy2zDKegHL23T4VvPks/XpB3PcGxenvf7aUVGUEuCrYMMno9yw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5930
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shaopeng,

On 9/27/2022 2:01 AM, tan.shaopeng@fujitsu.com wrote:
> Hi Reinette,
> 
>> On 9/13/2022 6:51 PM, Shaopeng Tan wrote:
>>> Before exiting each test function(run_cmt/cat/mbm/mba_test()),
>>> test results are printed by ksft_print_msg() and then temporary result
>>> files are cleaned by function cmt/cat/mbm/mba_test_cleanup().
>>> However, before running ksft_print_msg(), function
>>
>> before -> after?
> 
> I think it is "before".

hmmm ... if cmt/cat/mbm/mba_test_cleanup() was run before
ksft_print_msg() then there would be no test results to print, no?
The current implementation runs cmt/cat/mbm/mba_test_cleanup()
after ksft_print_msg() ... albeit twice.

> 
>>> cmt/cat/mbm/mba_test_cleanup()
>>> has been run in each test function as follows:
>>>   cmt_resctrl_val()
>>>   cat_perf_miss_val()
>>>   mba_schemata_change()
>>>   mbm_bw_change()
>>>
>>> Remove duplicate codes that clear each test result file.
>>>
>>

Reinette
