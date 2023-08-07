Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE84772E74
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Aug 2023 21:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjHGTFq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Aug 2023 15:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjHGTFo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Aug 2023 15:05:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CE5172B;
        Mon,  7 Aug 2023 12:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691435140; x=1722971140;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=QDOtC1m7tfoYLA2r+Ol3xGD1Z1+b2P6FTYidR5HXYnM=;
  b=bCseYpTzP3KiHhoSZIxgDrDnJ36RsmHH7LXJD0q2BuE7jJ+kcfmFJLa9
   kH3F4cEPzoroAmHiLM+tuT8xw/qQ26/vA+7psv/Jpk1tLbpD4iaiOvaE3
   rfMNte5oxfon4BTDaampeAGJ8QxUnAc+Uxd7Gt3irvYTFINx6r5/2OuiR
   aVxtc8mLlpN12o3hY2fMEjvETkH5z2T+jGLpj0rfdUkRdeNuLs+8I6ZVN
   QFR8OmQg2+xqVIX6EcDIZ/+Q5x+ZAitk9z+IepuXyt1e8C9aoL9Mx37zv
   dG7ETk2x9FAgeJ+ToqnCq8y0sDlbPRzM13PebidZN/gEu7NUtxcYujdHJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="373382394"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="373382394"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 12:05:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="904902611"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="904902611"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 07 Aug 2023 12:05:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 12:04:35 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 7 Aug 2023 12:04:35 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 7 Aug 2023 12:03:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAeP1P29DQmAaT7bQYQ5RNH4nBewBPCsrnJdwtWEl2rsMibVzlM//mH3Q1Xqx7B+i8CCWQGEpo0VWwbl5hsChC5UbkMvSKV/oK52zGNZoanZdVSdSvHzzkTO6hFTs6bLlNPYPk7Zo4Awk2vBr7TyI74nfxId818tkc82zfea85FZL0u2r7Y8sTe38BJ78HqKvpmSIkBKjU2eF+v83ocw6cZQtxmd3nDM2sGRHbqhg8mBetdAenWFpyMa82eidiicYof3TmG7TULA2qyoIsZ2FUFMKrBZmoMJw6TG8iY5mMxq8l5SheVEf50w/4sZsO9b3BpGvR3a9YMfZ2xtptWoqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CB5SDDzx1b6WeVYf8pqI8RIkvUp1/v82X7u5v0dtIE=;
 b=h4TaTAsW7s9EKNKIy/x2puqyU3RT0sWCpdRXftS2tJVvtCNA2NGWq/rTboQAuPJX7xiJhJG/XlVwf8hzWQCt8KmL/RAulv6pV6w/yAYb00DAefNXNkQM4Hl8D+wDBNy/uTGrDLomiLsY+74hNfv/503vmUQUEyU0LXfLs16sBo31R0yqXspxAYDsy/Y2cCcaDPJ3v5TlL3Mnrf2K9NwnlColJ0srtUYSxL0ZFX0GrokM/f+fdAxKbq/4wDQH9D72J+XJCSibmZgK3TetqcpX/Usy1on9VY5qKVy3CrpgDN46BU3fbxgnWDEdidGtmTcDEvAF29tKv48RZKifMR+jMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BL1PR11MB5955.namprd11.prod.outlook.com (2603:10b6:208:386::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 19:02:56 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 19:02:56 +0000
Message-ID: <50a395fd-68a0-67ab-faf0-ba027b2e6cc1@intel.com>
Date:   Mon, 7 Aug 2023 12:02:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
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
 <856ad175-26f8-90ea-d801-c722d2b19b2e@intel.com>
 <dd320704-a923-2e0e-a8ed-0693d294ee33@linuxfoundation.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <dd320704-a923-2e0e-a8ed-0693d294ee33@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0209.namprd03.prod.outlook.com
 (2603:10b6:303:b8::34) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BL1PR11MB5955:EE_
X-MS-Office365-Filtering-Correlation-Id: 50912782-3983-4df7-1274-08db9778e8f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kKWWH2QQjFcHOvmsOtk92BCqMveXI3hCXO2BPCV3o5shMmv7lOQ6/kywiKSPDbAt0bwqFewpsdeEWXmKwCF5gU8/clZBtefZuyDwAO4+U6v+pygwSFsWyf5XE4D8whf4b4TSoPypipDj9t9udUfnqBvrp3yLjqmQKy+DGETMg9mPdOrxY5uI9XrtTassmeiFcYnUQLeW7/NhjGpvHnc7jYtY0DVCmahQyNZjK8D1vcDwyJoG+umFokRRQtU8j6KTiEIaFZk0CDpgM5/jILPr3uU4lbvREg9VSwVahW9xd1N74wLqr4tHDFXMRFhIzQmBbN3ILZOWPezSSXs5DjrJMcdHNybhl0a7q4qN6vFkBGjRXeSBFXFCSrTngCBaA4D/wP4dk5TNu66YkNVwFrAF1wBWvnnIc4NxIM+qh1F4lEcn1T8R1C01eg3g+BbqCwC8+l1U08G34ec+Ole7+1v+XUWZOYeAMft+weocO556m4VjONlbicdkWCdWkm2K8Q0aE118HpbXqLiTDhGge7FTJpUCkb0EwpuvT7OkTZIAr3ZA633FGvZhz8dQ0FJ6nji8EiRNBpRNT/ctEbj8IF+XtUCfhUbo/+MF8rrRYrEWmoLVJGcfQJspuwJ2aNIajEYdojXL6T/fZwTGlWzDut7R4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199021)(1800799003)(186006)(6512007)(26005)(6506007)(53546011)(36756003)(110136005)(38100700002)(558084003)(44832011)(5660300002)(86362001)(31696002)(2906002)(66556008)(66476007)(41300700001)(66946007)(8936002)(8676002)(316002)(478600001)(82960400001)(2616005)(6486002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a29tQzVONFBtSFRYejZUT0k1QnhVREw2aDlwU01OY2tVZ1FHNThJNm1idFB0?=
 =?utf-8?B?QURVM3VLc2t3UjFIN2dOZUVaWldJOFZnaStPM3F6a3hVMjRzOXFOV0loUWZk?=
 =?utf-8?B?WExZb3hNS21IUVZ0ejd6MVprRWt0QUhMSEFjU3lpM1gxdXQ2M1RHeHJsSVZR?=
 =?utf-8?B?dkxEcTM3Sk9XVDR6NkJkb3dGSmFXMDUwTC9hdWFqbHpRS2p6MWRMbUVhaXZD?=
 =?utf-8?B?YWEvR2Y1NmlyS0wzbkhqR2tXNE1KenhvRE1RUjlMR3R3SEhycjN0RWRpM2xi?=
 =?utf-8?B?aWZOZ2NOTFlzNHV0YWZ4NTBhOWlUWFoxbjhYWG5lZ1F4ZG84WHl2UVFUZnhV?=
 =?utf-8?B?bURyaUpiZGdlWlBiejZQSGxPdEQ2aFVXNHpxSk84bFpPOVd3RXcrYjFlRTRO?=
 =?utf-8?B?bUVaNithbmxaNHp1VzNydHNIUU5URjN3cnBLaVorTHdramVGaDhEL3JxZkNI?=
 =?utf-8?B?YWszSm5tOCs4amhyZHVRQXNyWHErSVcwcDBtZ2d4WFB5ZVdPTU5iQVlkdHRY?=
 =?utf-8?B?TnhKaldtREdsTWJEM2I1YUFGMG1hSm5Ic3Q1aFNvOEtGRjVTa3dpOVV2ZTBq?=
 =?utf-8?B?L3I2QmhiMk1naFgvbEZUMVpjUlR1M0UwMjZIOHpHbUNEa0kxbXFTdWI3NnRy?=
 =?utf-8?B?czZDMThuZ3ZUejhJdVZYRjczamJtR3RiOXpyaFZ4eVZELzUvQlBFaEJRRTZr?=
 =?utf-8?B?VDlMejJhUElFeEpPVkpCalIwalpXSlJvOStPM3pzcE9PbTB6WldCa3ZhRVda?=
 =?utf-8?B?b2pLOXF0MDhTWWZxeG1EMTlQWHlzYmNGSEZGcUhmN2xmNk8yelNqendRd0Ni?=
 =?utf-8?B?eGRQYVQ0WUxDVno1MmZWeU1XR0NHd3JFZHVmVWQ3QkN3SSs2OFBzOEV0bVR5?=
 =?utf-8?B?aTBrY1loMTZwbnZkUlJSd09la0pvYzJ6MWo4MXljaW5VejRaMitWMVhBYTRC?=
 =?utf-8?B?V1hyYTRBTnZSNTBBU2dhdW9iaWx0TEdTZXBOZ1plTkRlUVh1QzNVYXJYdDBs?=
 =?utf-8?B?bHR1ZXpGelBzQVErSS90TnZlMDZVY201SjRPWlM1ME5kQWtEYnMvU0luSWNk?=
 =?utf-8?B?eXYrcFkzMzMxWDg5Ri93QkI1K09MTEkyYjRSZ1BnK2l1dGw2bVdmaElZVkJ1?=
 =?utf-8?B?ejEzdTY4a3dLeWlCemFRK21OaXRCYlROd3F5UFU4emZzcHdDTmVuVFlRUEdL?=
 =?utf-8?B?ODI1a0ZFWk9KZFNlWlFOTzhOVTdoYUtFNzJ5RUdFRGhCNHQra2FqZ1RvYjNT?=
 =?utf-8?B?VVlOUmc2RGRxd3lPZWxBck5TKzFKSk4zRkN2OFIrNlFpSWJ5SmR0OG5TZi9x?=
 =?utf-8?B?dFliSmZtWXkycWVLa1RCTWNEVlNRZzNNZm8yenpQd24yRmsxNldQSENuZ05O?=
 =?utf-8?B?dS9aa0RFbWh4Z1FPTm95YU5FWUV2SDdBTW9adWI0dlJtWFlJcVZPUmVZaC9F?=
 =?utf-8?B?RnVoUXZvKzFZNG5FMHlsRDBJMGNaSy8xeTRzN0xZTStjUUlMWXFYRGNMWWFh?=
 =?utf-8?B?c3lwU1IrNlNzZi9BVHJJOTUwUUYvSUxjU2NtMHpWUE9rb05ubHFMUFNPb2lt?=
 =?utf-8?B?VlJpdjRmTCtSbFRDcjVkY255WGpxS2p0d2JIR2hsYnFUZmJxZGY3ZWo0TE5L?=
 =?utf-8?B?b2Q2L0cxSUh3ZExoQ1krREQzZU1ubnhaS0RrREt0Q0xqdzJlS2d0aHNCNU0y?=
 =?utf-8?B?SFNhUTQ1aEgzODhrZFBXYVhJR3R0UjRZNXE0ZVZzb2VVR3FGRll5MlFSVG40?=
 =?utf-8?B?WmRGTkpNSUJaUlczZjZCbGM4Z2lNckx6L2NlQjhZMFNQR3daZGI0QW0wQUtI?=
 =?utf-8?B?eFpFVXhFS2UrNi9iZlN6TlZydCtzb1ZQTEFRUjNvWHpHSjAyd3crdWtiQ09Y?=
 =?utf-8?B?eGMzV1VuRk1UVkJqVE9EWUVlUW8zSUdKbUpuUk54NzAzUmtkYm50TGFCNUth?=
 =?utf-8?B?RUFoTmV3bGpwV3h6UDBQdHVPK1g4Qlp2UGRsY2ZBQmpXcjdzZ0xGTlQyZ01O?=
 =?utf-8?B?TW90MGJIQ1p5WHQ0bC9WM3UwVzRvSjY1eGYxT0JYb2swVjFiN3JxY2Q4NmNR?=
 =?utf-8?B?dGhKTUY3YkFJb0JxM0c1OUh2cmF4Qnc2N0F2UUo2ajlkampFcllBWFdJYjJQ?=
 =?utf-8?B?QlNHVW8rODBpUS9xZmVTd2lkZUR3dTk1K0ZKcGZORWR6ZDhYT3U4RGZWNlph?=
 =?utf-8?B?N3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 50912782-3983-4df7-1274-08db9778e8f1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 19:02:56.4699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5HKo/spx2igERpJJfdO9ycxeXWdvAOKNR94DY8BmHjuvzIz4VKS7XkWV9+Ctqg0lNLw4uKFW//5yal7HArP8OxkdJMegSAKNe8b2fAKQHDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5955
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 8/7/2023 11:47 AM, Shuah Khan wrote:
> 
> Very likely. You can ignore the comment. I already applied the
> series anyway.

Thank you very much Shuah.

Reinette
