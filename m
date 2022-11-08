Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEB162046F
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 01:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbiKHAEQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 19:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbiKHAEP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 19:04:15 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1132FB43;
        Mon,  7 Nov 2022 16:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667865854; x=1699401854;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nO7eKx5kmnQXjrU3guukhg9729v25WjdSVHRn8ZvZNw=;
  b=Kmx6vs9RcxTajvnGZtYeSqopg4uez++XLyTRJDUygtllszN13B65KfAB
   IcFE0O7pGWPb1WzqugdknSgULzcYCfmoJoC8gv0C6Ke+rIDObIbsThrlT
   hcFPWgNaKqAtaXydxEOcDLVIUvYj02lWtsGoK7bOKDc0gDOvShkUMSlFp
   Kb7JFFhGXuJ7fd+IsBVARxv9frfKKqI+nYv90/A7cr/5/D0xh3+/UgFWd
   2PsRxHsc7RLdp+1Ok1iPAtgXrMS+J53oMNEBBaRU8AXPNGJA40KfegKhv
   QTujk1DI6uGK3otLNrsIP958DyTwVTsLH4aD+CxFe4xVhPr+67xQ0mBLb
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="311709669"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="311709669"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 16:04:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="638566722"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="638566722"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 07 Nov 2022 16:04:12 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 16:04:12 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 7 Nov 2022 16:04:12 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 7 Nov 2022 16:04:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQAFOOakmxITenZzHIJXEt/dD1i0JLBFtJ1ZVlpZZahakOuVdulXpXBpxGtI2+ezYvENDwCAjIauCtXvaP3SF9lBxkbINzf/CL2VGWvugWu0rd5/zaAwtyl459AvVnVAEFGAXYb12gKRuinkF6sA3z1Ded06WFH5SsNY61ul8Ehtvj/uJIYCCoQPzD7+2cTBJNULQDlF1uLMEfvTqzQvoG/612DGA2kDKSMEj/KffCDKfTu4t1Z/kgrwFbfqotxYQxqRI80dq6b9KInCj1/eqvgrc91wkpRgx5G/MEvdn/ah+IhJwRDpdWn0MbYOlBwALfqzUnCb4DtxfTj5WDCfEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMk4auvaz+bQalSe31yhQnuHXhk3jX1soANS3ASBvyQ=;
 b=MD+Z44XTW1Cb9pSlGFicLIPJibKTaYecYwONie9R7smgbbYyWNB05cH0jIX7AwXSzgjXgyEDCCEhLOQPcIsMCp5KiXbj92MQSFk3VOPUg8LY0b0sCuE8F8AV/W1f4OqgqQhdSf5voaVzPMQK7SLLiI7iYUJ3QYQczqQPH46Yk0hceJ5VrWUulWTYh15dm6WOKvPZhEL+m6uwXa9342C066lkLVbg3AY3arzm85r7cu+GH5rgDTFQ/E1WVLa0leg8nEggI5U2VkUpwTHq8CxKAITdMYufbpMOFH/HZKR+rqIE/I4OEORsJ5nQ2ia6PYCo1IpVFYNdcLPIUr4XT/97hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SJ0PR11MB5007.namprd11.prod.outlook.com (2603:10b6:a03:2d2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 8 Nov
 2022 00:04:10 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5791.025; Tue, 8 Nov 2022
 00:04:09 +0000
Message-ID: <9da9bf85-fcaf-78ac-85f2-584a17a21af9@intel.com>
Date:   Mon, 7 Nov 2022 16:04:07 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
Subject: Re: [PATCH v3 1/5] selftests/resctrl: Fix set up schemata with 100%
 allocation on first run in MBM test
Content-Language: en-US
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20221101094341.3383073-1-tan.shaopeng@jp.fujitsu.com>
 <20221101094341.3383073-2-tan.shaopeng@jp.fujitsu.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20221101094341.3383073-2-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0006.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::19) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SJ0PR11MB5007:EE_
X-MS-Office365-Filtering-Correlation-Id: dff18273-eaf4-41b7-cb4c-08dac11cc2b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aiogoVFBEmZBpRqJcxxbAG4ShxhT3UcrHSs0CWo1SjbRoHcss5Ou2KDpjentUfBNERF3kslbafPLQilOFbSkn3dRzzEmEkV38nkXhluaBuW59x+4IS6Qo9lxEYpSDl93PIHBoQxyFLSW4Vkf863/Usrz+8qZT1P8hIJG3vLZYLZXORHFHEKXoO1UYz9koIpcVz5zL2s7R/UnvnvRLmLyrL86s3K3bBPZioW62wJE20ED3XYMsfeOkmLCY0BKXI1CfBOsl8CMovNZDpLqFaaPWRKYHuTGLjKaH353tkbzpA+SP4NG+w9zqkGn2ju9M4Y2Wdeg9yF8rvJ9qlcWCkuJyOmWkEV15tP+xvD+Teq2RZZdBEl8ILymt3KHszsTVtvDLLicaTsIIqk3w5r+bHCUKpcLbye0BIVPiu605vP1oW/CUdHmUCkXmuqvdIw4OB6fDIjBW2PUWyXL/+n5exvUrGG0fhAzr05xAWWCLXRjTH2ND9AQ46u9LvtkHNKO/QfQ240fHMNUj+HGAwxnRTAwR4/odblRCQiBCTLEt/2Larv8pLJbgWsYmlHXn7ZZyq7/mP9vdvc52siPhQd1fG+a0qNWkJJyJYnLqNgjwMV4ifZrp3CtFIv8G/OVywEZyzN9RvIQX25SZpmPSuUgHjeJusN3rOHq5x2NKVFzGM3cbRN7iGjjOuBpGAFnWMvUE3eJ7dGsLtpxcAFIYIbgWQZ3+f2Z4cvjosCLzGoaASAvO2b8hTtu9DB7cMpeEANjmiB8wshv8KdV6k5hV84OqPUE6sdtbMUKZ5uWKnYKiGj5ALc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39850400004)(396003)(376002)(346002)(136003)(366004)(451199015)(31696002)(86362001)(31686004)(36756003)(5660300002)(8936002)(2906002)(6512007)(186003)(26005)(66556008)(2616005)(82960400001)(38100700002)(316002)(110136005)(66476007)(8676002)(41300700001)(66946007)(44832011)(53546011)(4326008)(6506007)(6486002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0hLa2tXOUUvOW5qWFF4VklJd0w5aGNEelJtMGJMWmhpWHAxRmVudlhlNzBN?=
 =?utf-8?B?eDBTZ081V0hldXlHdUp3RGdTelRhanlMYjVLT2JqbVk1VTZ6KzZzSmlpT29Q?=
 =?utf-8?B?K3BjWmNQWk93MlZSWnZqK0Zja3hHTVBHUkJyYkJiUDhMa1EzRjMvd1krSEJl?=
 =?utf-8?B?WWRHWlRzRFZtaG1mU0lEWG05ZCtEY1ZZNmVaZ1Z5U3EwOHVpM1ppTzJrV1JX?=
 =?utf-8?B?Z1BEVjMydTdoVk1DcS9RK3Qyak5EV01WOXNHM0xtZ1g1RnZZWkNRblBQSlR3?=
 =?utf-8?B?UFlOZ3pyUkRIZEVBaHE0VnV4eUYxMWswZjZZa3NuNXRxVm9qSEpkaXVDQTdO?=
 =?utf-8?B?U3VqaUNsVExFNXBsa25EdnMwRzg1NHh0ZU9FUjcwMFRyQzFSaWVrSFhFN2RX?=
 =?utf-8?B?dXFPSXQrK2RSOU1kM0VRZVRPRnpJeGlaSWlDRjNlU25JYmVmNktxUjVTc0ZN?=
 =?utf-8?B?MWVjQmdLbVhMZFRYZHM1dnljNzRoalg0VjVSWWhjM0F1RERLQ0V4cVp2Y0lP?=
 =?utf-8?B?cDZkelprUWpyNzd6YXQzNHczM2hVU3B1Q1BTSVVYdEI1cWx1Nk1oaTgzNisx?=
 =?utf-8?B?NVk0K2ZZWCtaZFg0bXYzcGhVWUIxRjBHczBRTmNjOGNPMU13RFdIdW8xbUdF?=
 =?utf-8?B?VHlRMVFpNGtEQzFYUitNQXR2ZUZFREhqTGI3cnF2QnZadW1WaE1nM3d2VWd4?=
 =?utf-8?B?K3NzeTEyUlNXSHlMTFU4aDhTcmVKTVhCT2VkRDI4UGNLdlp3ejc2NExGNFJF?=
 =?utf-8?B?bisxeURVNUdmZVpwNGV2L2lSVDZVSExNK1hEazFHaVg5SmQwdnV3V0Yrdi9W?=
 =?utf-8?B?QXBwVjFsTmt5SnQ0UHQ4UkptWUtKeG5wdUxkczVETTJwaDhFZndHT1pOc1Bl?=
 =?utf-8?B?V1NMaVFVTHF4ZG1xbUVWSHpzVFBIR3YxMmNxMVZ5VjhUS1dUbGttNE1jeExh?=
 =?utf-8?B?V3NXTVZ4dGt3Uk1DTEtRRjc5VkNIQk9lL0dXQUFuTUNpUXFROFdkakorRTUr?=
 =?utf-8?B?YnpXVnRVZW5RT1UwMDBIMmExS3hXZkJtUDl2NnYvZHZYaTk0QVFxMHlzSEpS?=
 =?utf-8?B?T2hpa00xa0Fkb2hVN3dqZVdOdTNVUGZkMnEwUlROblpKWFBMaFlSU2JxSm5B?=
 =?utf-8?B?NllUWVphdlAyWmI0L3JQZDJwY1JMNU1hS0diNjNkeDdsY2FuemgwM1cwU3dw?=
 =?utf-8?B?ZVAzMkxTdVVkajJoN3RrNW9UdE9BYmpKL29oVW1sUnFsbTBHdmNZNElZRFY0?=
 =?utf-8?B?bGplUlZBVHlyYVBGLzBMRnB5SEI5VzRJQ2tyc0hNY0taWjc5TVY5OVJYcDJ5?=
 =?utf-8?B?aElXVCtqaDdMdlRHWFBUUkJhYkM2MFpuWkJQbXJXV05zM3VJeDlsUkFySTRG?=
 =?utf-8?B?UWJPdWI3WTZ4RXg2cVR6eUdZUDJiNU5wOVdBOVdEZzNPSStsb1MxckEwbmtT?=
 =?utf-8?B?RXBxTFB1bjV5cDV1Z3FBYmFwRGVLTFVGWkVSQTBnQVE1QmtIdW5YRkRkQ0tz?=
 =?utf-8?B?d3VYbDd4Q2VTQTNvbkJqSEE1bGlvWUNPVVlKZW5zaWpCOWZ5V2M3Wmp0OXBL?=
 =?utf-8?B?N2lvOTFjeFpXUWRPMFU4T1JlUjdiRmJwbFc5eVdIYXljR1d3cnA5UmpiN0Uy?=
 =?utf-8?B?K2VWM21rR3dNUGZzS1p2dU16U05ZTHUxS0ZjeXVRc0ZKNFZZWEFUUXJSRUl1?=
 =?utf-8?B?UllxVlNwMVd6UnJVTWp2cWp1VHJUZlFPZ1lyUm5uTnplLzd3cVc3TllhOTJD?=
 =?utf-8?B?QUpYa2tJSll5cEk4NXdXR1kvcndiVTRFbnp3MWwrd2trcDN6VDVWYTlIK0Jq?=
 =?utf-8?B?S0JaWnNOODg3Y0JRWDNIOUREcjFyM0RpR1NhbnhUK0FYNldTNHNsU0xyNUd0?=
 =?utf-8?B?MkVkZmREbHd6NEMvcjZyOVAvWHR5bXltK0RlUStuSnRSWmgwUVl4SERUeTZI?=
 =?utf-8?B?QUVhN0lYWktrczVEZzdSbnVoV0lXUS92L3ZzU3RxNkFLQVQzMml2V3kxQ3VH?=
 =?utf-8?B?Skw1a3Yvc1g4UnFrcDVIenI2dEdmRkowN1ZJTVMyL0hLOWRSTDFOV1F0YVB6?=
 =?utf-8?B?OHorVkVCUkRSUjdxYzFWT2JYQmx1NXE0dTZYQStoa21TMU1tc2VoNmJIcFBZ?=
 =?utf-8?B?MWE4dmNMTTVTb3pvNHZGZXl5eWlXajdHb3NobDN2eG1zK2hQRG5xWG5kWW85?=
 =?utf-8?B?T1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dff18273-eaf4-41b7-cb4c-08dac11cc2b3
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 00:04:09.7716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +CHHZZn7KnyeNOPbDTyZOauUE1a1GSe/hDOYH4TBcD8k5VoLmO5wXfNYnf9vIZNo2TZph47vrP1+nDllTTBbvr384Qbb1U1xusEnx3r5CFs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5007
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shaopeng,

On 11/1/2022 2:43 AM, Shaopeng Tan wrote:
> There is a comment "Set up shemata with 100% allocation on the first run"
> in function mbm_setup(), but there is an increment bug and the condition
> "num_of_runs == 0" will never be met and write_schemata() will never be
> called to set schemata to 100%. Even if write_schemata() is called in MBM
> test, since it is not supported for MBM test it does not set the schemata.
> This is currently fine because resctrl_val_parm->mum_resctrlfs is always 1
> and umount/mount will be run in each test to set the schemata to 100%.
> 
> To support the usage when MBM test does not unmount/remount resctrl
> filesystem before the test starts, fix to call write_schemata() and
> set schemata properly when the function is called for the first time.
> 
> Also, remove static local variable 'num_of_runs' because this is not
> needed as there is resctrl_val_param->num_of_runs which should be used
> instead like in cat_setup().
> 
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>

Thank you very much.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
