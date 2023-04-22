Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7394A6EB646
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Apr 2023 02:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbjDVANJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 20:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbjDVANI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 20:13:08 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175AF2682;
        Fri, 21 Apr 2023 17:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682122380; x=1713658380;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TpmzVMQXYAablWgtdn+OqzbCdKJeNp5VhZI0asy1j70=;
  b=AsrlZZf0qvdzErv+ws/TG7p4pboGFyeWqnxN8Swh61ryMx7RrEniqhrb
   wYrI2KuzHvgLSxACblSUSsHIBvGddJrcNYm9zCeq2jLzZIh2m2Q3ALXDx
   Dpd60aaR8rI5OSgqdltTo6GdGec5FRfRs4VdIaDkSU4Zqsu/QGpoEAvak
   G7noWSiGJilG00rZKR8VJPuhwwRuw2po75x6ZX2Ro4G4PphgSLdRTd7n2
   TI0ZvXmryfiy4AB+WG7wYht3CRT6dL9lxgoseY2IKjLAl0a0AXa7jRLaL
   lrM9YsIpdDmGtZ0lHmo63iCYydqaoPsVl1etDTUOt2BYiD8f2dSHFQNFh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="348020919"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="348020919"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 17:12:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="642690734"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="642690734"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 21 Apr 2023 17:12:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 17:12:58 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 21 Apr 2023 17:12:58 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 21 Apr 2023 17:12:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZ3z1jXTJgH5JO55OWztP0FfMI3r/PVDW3hI2nA3atBT2RqxzSsCj7R44axrMFJ3iKcd68vuxs0rUv0BEiD+0RW4OwQfx9xvcjkULROSmrQQXHVmVXCvF66V/CepO4wiYahkcSFQdqctLhiNZZTgI4TqLDkSHApxpgmnxPD6ttrrot/XrTOM9XIQ7tpXEHZem5pSEqrmET+kmr2hIDOHqwCNPnSCZAPInyt//qmyq6QJNYCLzE+ume0t3UB9Okb9sMSZPPAKM6zoaVcbcvLdWu/02xFQZ6KBjoBrDOVKvxklpQCpynyHxlW3HIzKXmfly02j5newQz4Ax48VFjIe4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fXIy810E+h4R145s0XsbL/XeCRqzveLdC7/OsSDXGc=;
 b=I+CQ9SU5PRyJRZ401+nXgRarjVRywKf5mjDf1SfCicrXEDS3/a6Unkh6AuX1U2BTpABxhXTtB3lDEtOBiUEFMt7eLHlsLlOReaC1+cxSVp5OYYl533vllQZWy4eptzuWofROsrJfC0NzH6MEEC+gTDobbzjRG3HS07SMzwEkig6DJBBpDB2Qf7cv3wBG7nhtXlUqmOI66ZRmxebFT4H4Cgg9W0lzjAEmxLSxHINoxLgWvpIQen3KndUbyGjZYs9DRxw3UVbpPoR2RTHHo5mQO42/QTpDtZRNzMnODyqPM+md5FS1++lEiBmaEa05aH8baD9eSKptEQ+Sj5DvcdBrwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by BN9PR11MB5227.namprd11.prod.outlook.com (2603:10b6:408:134::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Sat, 22 Apr
 2023 00:12:57 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::2854:770d:2a43:dbc6]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::2854:770d:2a43:dbc6%4]) with mapi id 15.20.6319.022; Sat, 22 Apr 2023
 00:12:57 +0000
Message-ID: <500854b8-f070-37fb-40c9-47715744f451@intel.com>
Date:   Fri, 21 Apr 2023 17:12:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v2 06/24] selftests/resctrl: Express span in bytes
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "Shuah Khan" <shuah@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com>
 <20230418114506.46788-7-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230418114506.46788-7-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR21CA0007.namprd21.prod.outlook.com
 (2603:10b6:a03:114::17) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|BN9PR11MB5227:EE_
X-MS-Office365-Filtering-Correlation-Id: 66f14d58-cd12-4723-f201-08db42c65312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IpMPW8jVKWotEOJVsxC8Tw9nrN/HBNbAAis4ywIer7nJ9synYcPV4VbmvBnu+ywa1Kpy4Oc4+dAM/lR6EC3fvvjk0RzDAyn2w1R+r80SesyhOlobhaMy/AoN8D/58lWprW0B8ACNazLebyV4+J6TqcxCRZrku7qHXwimW4MJQFACdvzIIQmK4bRRm2pfxD+LCoYlpUZJksiELv/eKKgXtIkTIxMgr0HNKJJ0hy0ZRyzl1qBN4hzfNyjJ57tW2QS3kDxzuL3Zx4mB90QlRnyFNaB3qZVsRJNTmty1hsqaewSCv35yjmdYquSl/1VllZes41pfCLqV9f7j+s76D/PGTOfiAczhLpoWQC54VXvlLRzYRwCnXhNkDklZKNFML+p51hVrDzjILquGKe3wHKe8tTmt5SyS2bMU2db9L3I3CXxey8wuZoMKjbD451Sem2hoEto7l0DAoeVTkPcRfUnimgJWNnpnhN8vM1aruV1T4AYxVWM1aBZ7HiUCtNVQ/ISxHg1EtCiPpS+iw22VCIidTz0l2lzQMU7paf6rKZeK9w4Ek31PnlHYOH7jVQFNNpthGCOjvBUKfZq94zF58fG8RuWOk/1RjHaLKawg5D6uN0TvkDyfFvgeQrLfB8MikDsuT8WiUfp7Jq4OsLI1MSkP7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199021)(4744005)(2906002)(8936002)(8676002)(38100700002)(44832011)(5660300002)(36756003)(86362001)(31696002)(6506007)(6486002)(6666004)(6512007)(26005)(110136005)(2616005)(31686004)(478600001)(4326008)(186003)(316002)(53546011)(82960400001)(66556008)(66476007)(66946007)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGUvUkpMSDJSN2VXTW95cTVleHhweW9kbEI4bnFoK0dvMVRBSnBwNmY5d1Fj?=
 =?utf-8?B?VWJidlVTZFdkcmZtM2NvblBTUmJNWGl0WTdiUTZMYmhoUkVmbTFWbzBwaExL?=
 =?utf-8?B?ZThZNFRhRDVDdkhPeEoweThSMkdJWnZiTHJjZktid0NnRWxzN0JGWEhJOEJS?=
 =?utf-8?B?eiswblBXa0crWmhjUXNCK1BWSkFwNThwdzZFWW03UVdqcUtzNWpVTXlIUkp3?=
 =?utf-8?B?d1Zta3NmRFdnQnZITmtWVjcxaTZPV0hFQjQvcnlsSlJrQzhxcnNGZC9uVzE2?=
 =?utf-8?B?OWhLbXJwbkU3emFlVkllKzMrRklQamo3MHkrbFowcExhbXpmUzcyakFrek5i?=
 =?utf-8?B?RHdqSFdGazRVRm1kMHZWVzJEUDVvU2ZDMEVWUkRQbTdCVitNWk1TVkJsNWlw?=
 =?utf-8?B?eVQvUGdIYWhRYUpGTHJERDdxbHNaQjV0R25GKy9uVHh2T0Y2dE15Z1cvenZS?=
 =?utf-8?B?NSt3U3hxN28zSkNYMFoyNzUrd2RmU05vWkxHaTBIa3VsNWhvL29TMnczeDUr?=
 =?utf-8?B?TzBWY21HZXZMTWg4dnFvWGZEL0RTcUw3OWJGWXNHTVdNS1FDMGNQd3Rqemhh?=
 =?utf-8?B?NkZsMERBdVZjU2h5MWNzNE9YOW9BRlAvOWxsSE1NT0F4QWxTbElJQmF1Wklp?=
 =?utf-8?B?aEdlNzFsRTJzTk9aUEQ2SlE5M2FnTGNVWkUzKytQN2tzRTBqQmRHMkxObHFk?=
 =?utf-8?B?RVFzK2pJSEJnZlZHOUhFeW05RStQeHpOSG5nTDlFMlg3a084amVhTXQzaXFJ?=
 =?utf-8?B?cnpkN2xkUUxHdUtyQW1kbGVHTTIxd1owVEk3UTBPWmNZSEkwL1lmVEpTMnhk?=
 =?utf-8?B?OTNyeDBOZEVjRCs0OVduRHhKWXhCa2tSRWpwSnBra1BUUmY5a3Y2Nnk2V0ty?=
 =?utf-8?B?d2NGS0hidFBNQUE3U0FoMkxDV3pnanlldkF4Y3FXYWhlSytEUDVSL2xuaE9z?=
 =?utf-8?B?YWhIT3VpUWc2ZHlTK25neHF2SSticEpqZFhxSjJDKzRQMU5EQWpzVVlueXZw?=
 =?utf-8?B?ZVpQK2lncmJMK0VBQmVKSlpnTC9SK1NBR1BaaHBUVXNlV0NNV3BFYy9SalpZ?=
 =?utf-8?B?RVhJT1BmOExieno5ckcwZERmNkxrR0c4OTkyWnhRVjlTUko1MThxS2tKQk9E?=
 =?utf-8?B?QzhvMWw5S0VGN2JsSURJRWU2NjNSbHFnQzN2dE5UZWZBYjd6S0tQVmo3Zjda?=
 =?utf-8?B?UDhIeWQxV1VHTVB4MXFURlZHS3FFaGNqN2xqNzNCREhjVFVnMTlkckJXYkNG?=
 =?utf-8?B?YVpDOFlrRUI4V0tkR3pvbnM2djArN3ZvTkdBbTI0SWtIditDbEZGQXhodlNJ?=
 =?utf-8?B?MXppNzBCOXhRQi9mMTJOWjhMSHpiSkFGQkNxdXcvSjNpblo4N0tVQXA1R041?=
 =?utf-8?B?Vmk1WGRXczEzeEVXY05hVkZpMTZKQ1N6eDVxUTlLVGNPT3RzTUxYcWwrdUwz?=
 =?utf-8?B?ZlRSMC9sd2ZiL2NnRngrRXdSVlE0cnJFSmV4eXprSjJ3cGorRXJXd1J0NWR0?=
 =?utf-8?B?RUxPQjMxYTh2NUNieGZrSkl6YUVjQ2UxWVJPYlYrSysybFhvbkpuUHZiYmd2?=
 =?utf-8?B?c09XbFVHLzV6dmRrMVpRTVIyODZrVkhsbDRWNUxvMlpPcmpPUmVyNUdhdEI2?=
 =?utf-8?B?bVBXdEpOcGswQnlLVDEybTBsWlMwL1VRYThJODBxTFpIOXp6V1RuLzJyeWhn?=
 =?utf-8?B?ckJpdUNvbXFYTi9tK0FxRVB6cW4wbW5WaTgwNk1aTTBJd2g4NnpmVlNGZUpX?=
 =?utf-8?B?N2ttZTZKbGZ4UE1TdGkyaVZ6cldxMjloa1pWVjRIaFE1cHNBV2hMb3VMVjd2?=
 =?utf-8?B?dXlFVURpVW5JMzBuOWVqT3V4TnQzd3ZvaFR3eFk1QVV4bHd3dW9CS25jQTZT?=
 =?utf-8?B?WjV5NGZ6TDkyZWNaMkpvTWgyaXVYcUVIUExsQks5U1lSVkpnT3B2TTAvRTJS?=
 =?utf-8?B?TmtxZTZ3UEplbE9BTGMxNC9GSUE2YzRuYkhobTVZUVBxZTB3TzR2S0NBc3Nq?=
 =?utf-8?B?bFZGZXpabm1HQlp6Qk9xU2dLelJYcXg0MVJES2dWRnFPTHlvWUZBM2thM08w?=
 =?utf-8?B?a2trbSt2SDF1S2IwWHBIMkh0ejA2MWF5WjZobHoyaVdGSWxxY1FLYjNXdTBF?=
 =?utf-8?B?RWEzTGZGOGJwem5NUzEzZmpTeStTVFpjajFtNEhEY0R2R042UUhDTW03ZTBr?=
 =?utf-8?B?cFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f14d58-cd12-4723-f201-08db42c65312
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2023 00:12:57.0094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NnY1aQWMkztqAvalSs5C2tEWHAivnB1vAHqpp+P4XVAdZ+NgDL4uqLPwR94ticBvikeve8oppkto10JyTCmokVflh16XZALIvSJzf497aIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5227
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
> Make MBA and MBM tests to use megabytes to represent span. CMT test
> uses bytes.
> 
> Convert MBA and MBM tests to use bytes like CMT test to remove the
> inconsistency between the tests. This also allows removing test
> dependent buffer sizing from run_benchmark().

It is not clear to me how this patch achieves this goal since after
it show_mba_info() still displays results in MB.

Reinette
