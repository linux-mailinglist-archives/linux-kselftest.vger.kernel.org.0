Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFAC6DFCC2
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 19:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjDLRcN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 13:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDLRcM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 13:32:12 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5201F40FB;
        Wed, 12 Apr 2023 10:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681320731; x=1712856731;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yoY4y5iffGHWaYrlhuVaoom0IIHk0rkcvLqRxmiCreQ=;
  b=AE6MBkmd27f1M/YtW3xGczbwLgjIjBFsDCf1h6vehurydLJo1igq+Dsh
   Dj2bWPxLqEq+lDKIsjX92CJO7B1nJWEcQu0QmOmE7C0xNmSJ3xZ4wNFic
   3ZAeUe3tBKHYI5vMKhSF9bnOj0mgAvYdGtO0r0AFDqsRndt/B/yKCTnt6
   8p5qRs2JHdXxCiOyh3o/RRLVtDpN/KOw5jGn/9Ps4fA2SkfrIcwzn/zI8
   EYQJ08wR/YS0e7j2mVUg0l0xhE2sVqxNw8+Wa1StEOvgwlVmJPvGc7fTo
   wxgPOO/UlODMrlAjhhE7TxJvvn+i6gkMy49tacv47h8fR5QqtMx7ZM3ds
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="406796848"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="406796848"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 10:30:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="832764255"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="832764255"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 12 Apr 2023 10:30:53 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 10:30:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 10:30:53 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 12 Apr 2023 10:30:53 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 12 Apr 2023 10:30:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8XfyvXZwn2lovQRlCGAsgijoGSPD/gQqD8z6rWoKYb5xC+n7jeXSHgTIkMNX0La1wI+//mhruLbUxjXkYyUIQnMD89Amqipg6d/nbT8gt6UHMisBMphFPrKJ0BMgtYwB7UClAzEZg7L+btI9FFqxTDkEDY0FIRGH3SfzvP1SDka9VSOH3I5RVhM4HsJmHUhuklRXA444i3P8yvzao1jwLMIgyGFB6p4SrwO9oy1za9SrORgr52FMl3bO31Nxtv5aw/i2E1KMf25JrA3ieFkxSfC59c8GDtahQiTzUSLaSnlz41KVA392iuwvHvbDWQ5efJ2j0+SCW8VBL0XmgXFGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jR9dycKWQZglscvn1YcmVwrmrxKz9hRxIFB2sHoZyDw=;
 b=dkLVdyDKI6jaLoJKiWaRsjdy47lgW+K2rWJKA6LO6VU7NIQ2gEiJPiWRmJmWo+hcblF2Xu1nAfyeUqkAOsUZn5T+DBL92dQ0RoQlKBHJT7j/nvC906QPPhByFVqaCw6XYlxMTcMs6jLIEyjq700eJoIytHT751Jo1XtYkMgDwJ8nEF7lckdVY3geFoO/65WgMpIGkd2AF9ocesnegjnXhwWuj5xKYh2a4a86sBwo0BIHp7aoGth6D8pzD1O4nEmo2tAj2DaU8TVI+Qp9qD3sCcoupcBiMzV2FOe9fZjI59nOMykfJ+8kuU8PXBARWBS4UaNp1lRUGbWj4wGEPg01yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by CY8PR11MB6817.namprd11.prod.outlook.com (2603:10b6:930:63::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Wed, 12 Apr
 2023 17:30:51 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::4bd:cce2:58ce:cd6b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::4bd:cce2:58ce:cd6b%3]) with mapi id 15.20.6298.030; Wed, 12 Apr 2023
 17:30:50 +0000
Message-ID: <96b6b5ae-078f-fbde-7cd9-d64d766f6727@intel.com>
Date:   Wed, 12 Apr 2023 10:30:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.1
Subject: Re: [PATCH v8 0/6] Some improvements of resctrl selftest
Content-Language: en-US
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20230215083230.3155897-1-tan.shaopeng@jp.fujitsu.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230215083230.3155897-1-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0020.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::33) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|CY8PR11MB6817:EE_
X-MS-Office365-Filtering-Correlation-Id: e10f9553-a05e-47bf-a6b4-08db3b7ba8e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C/MZb+Sa/b0SGgktI4YGcQhUl7x7isjIOG4kzbwoM2q0S7O+YvcYhQjfG0CVO2V4PNQWnbWv0AWC8t4LNARpdPz9iUHvhS7hM4C3aCmQ5vcRrLTiWcYvPLCzNfrl4K0JrIaIQhmvWqFMozG4MmEu3grJUO6DyiIezlr71fkETjUpILOUXChugBF7/2JxZ3Tf08RISuVot6cckODXM0eyO0hw5Ukt8NY8fAX6JXJS9I4LosqefkJ1EZlvTZte2CxIFzXjdyGSil/CB98mZILoiVcXwyFCY0hynXTXX98G+YFqTqRhwiPB5DfASnfGUaItBiNgX0Vj3jj/7xvCSYuWHmoV3evMzCewOzzSNJrxIhJvb39BCJTxr64BlpGSvRnfWQ5hHTYYcZUHOHtbQy1RSHAzfYI62222itpOp1Ao5M/eAyncpfqHaZEGy15Hv7wbogMFar3yIVKJEKqsvCwzb0DcoLI/xM8PYGoD6Ye4qxhXbAu6JdaGPZkOx5ijMmP/mAO54MJb2e7u4PbjyGFHXOEgWW56tZgFZF+bQzEM/dubELQJd60RZ/CgvGzFyzq06bT1j5vWnfrCZnEKluy/0Eh8dzHrTEbCas9c/AQ8vzFb2kS8b06fsh1y8ALu7q/E/1WpFOjdF7WiLOpCS8x5Zg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199021)(31686004)(478600001)(31696002)(83380400001)(36756003)(86362001)(82960400001)(38100700002)(2616005)(2906002)(44832011)(53546011)(6506007)(110136005)(316002)(6512007)(66476007)(26005)(186003)(5660300002)(66556008)(8936002)(6666004)(41300700001)(6486002)(8676002)(4326008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEFNdllxcGIveU9IZlV6akJSMGxGcEsydHJwQkVpLzV4dDBJeDhWbjVaTkgw?=
 =?utf-8?B?YXlCRmZQMzNSQkQ4ODJGMUE3RVJPdmdpZCsyVnhERk5Ocnc0alFON0svY1BK?=
 =?utf-8?B?YXJLMlRNZFBwamdZSFlOU2xidjdkRGo5VEVYUUNvOWZNZ29ETFZMa3l0ejky?=
 =?utf-8?B?Wkd5RnVTRUc4Q24wZWkzQWZidTE4cTV2ZGNJZUpSZ0FpdXJVZ2ljbFVobDFG?=
 =?utf-8?B?Q0pDMkNXSWdBYjdzMUFCYmlvU0djZkVPc0ZQcXZNUC9KVEJHSUdaR3cxOG4x?=
 =?utf-8?B?RllxVnN2QTVoa2FrUE5hbDU5ejJpRGJBVTJOTStIZ1ZDNE5TcDVMM2dHWWE0?=
 =?utf-8?B?cG9TeUwyUXZ2YTJKd1ZIUDgyWEpvUUR4SVJMSTJoaWhidVNyalZlL0wvZGo4?=
 =?utf-8?B?WEFBUVQwV01LUDFDa0ovTmdUNzBBZDgzR0pMQ1ZEcnhpTDlGeFdvSDRBZVJr?=
 =?utf-8?B?djQzWitDeWhTRFVKSVBqRkFUTzBtOE1SWlg3MHdZREFsdGxFeUdVR0hsMmlM?=
 =?utf-8?B?dGIvR1NQS2ZZV2RXY3JucWpjL05nVDVlNE9EMmdWbmV1RXMxMDZkNmRQUDFx?=
 =?utf-8?B?eHo4NDU0M1FSWVNZQ0pCdnhtdm5UMmdvMVR3cmVvNFRYYmp5cXc5TDBQSC8z?=
 =?utf-8?B?L0gzM2ZiMEFlcVdsRUpvRk16a2FqYnQvWGx2YWk3TXQ2VVNQL0VjNEMrTksy?=
 =?utf-8?B?cjcxdXlLWVJqRS9iWGhFUUFZa3RNeVozT3B2NmhRWmZHTzdmOXQ3cFRGajFT?=
 =?utf-8?B?bkdxWHhwNTdXb2U1azNkZlBHQUhJUXVKZTFyWDFiWG9RWUxadVlpeFFmbXpt?=
 =?utf-8?B?akp0ZGYrTzc1TDZxd3FObFpUMVBvTXpUOGhuV2tua3dabjdtNDltb2N2R1BL?=
 =?utf-8?B?eVordFhCdmRaVjkrL3ZVcjBaMENPZTVEa3J5WWxjR3hFVElQRitNTTdhcE5S?=
 =?utf-8?B?blhWa1pMdzVwUVJ6QWwvZ2NjZ054ejV6bzRuTTZ0dEFXTWdXbENLaDlVNitB?=
 =?utf-8?B?bDMzVkNGaHcrQ0FRUE95cGZ6dHdaOGc0SUtRREptOTdlamljRitFWlZFN21G?=
 =?utf-8?B?L3BqVlI3MVRJbkdhZUJEVnRPVi9Zb3o2blBuNjFPMzdzaVdQNFNBVTE0OVFK?=
 =?utf-8?B?ZFVJUmYxdUg4MDhWQlg5YjZjbEluNmdsZTJVLzhhd3lVeWoxQXNsQ0FNWWdW?=
 =?utf-8?B?bVhMbkY5Q0EwUzBiNXA3c04za2dXSElZUmZrbTRoR1RTNU1EeC9wTFhCTWtU?=
 =?utf-8?B?VW90NDhEZU9UeE5QWmNKS0YwMEdWRHdPMHR5TUlJeHdtdkREUDhKTnE2UW8z?=
 =?utf-8?B?Uy96cWFqMS9NOE9xbjhwVHVtdjQrTjM2YWZrT0x2QUphUDFLZ0k2MXNGWE5D?=
 =?utf-8?B?azk1cnR4d01MR1AwT1I3blVYTzNIc3crdHk1VUY4ZnV5Z2owSEp5Y0xUY1gr?=
 =?utf-8?B?NFRyMmthd3R3bzg5KzJzREFMQ3JSWktIUDEwdEZ0YmRaRFlZN2J2eTk5Q2Rm?=
 =?utf-8?B?K1pQVkh0bngvM3lpazZtRm1WQTdIRlBiVS8yM1c2eXBqdFVIdlJBSTFrSFdS?=
 =?utf-8?B?ZjhGQkIrcXNpSWVPbFJycStmbURtNzEzRVlJMkpCSDMzV3pvWmY2djIraXh1?=
 =?utf-8?B?a2kzNzhwd0ZJNjBjSTBKT0ZTNmVmYVdCd0NHd0p6UWhGcjFhV2JaV09OeVpQ?=
 =?utf-8?B?NGFrOVlOd3Z2dFhPRFNOb3RYQ3lmbkRrbHFrMEgxSWhsOHNCcElMMDFjNnpn?=
 =?utf-8?B?UVEyQ3h2djQzbzFHRWxMcjY2VlZTdkxJanMxRkd2anJHUkExdWJVZ3Z3blhv?=
 =?utf-8?B?d2oyR0Ura3VOOXI2dVJMN2xibG5pSHBxRUdJaFk1enhNM3lGNFhCNlVFenM4?=
 =?utf-8?B?aDBXVnRPNnU0R0xHTHBLdUxGVFNoRVVOemU2Um00eFFyYlk5R0lETnZBN25X?=
 =?utf-8?B?TTB1OUluZER3ZW9nR1dLREQwK3J2SDZRejBIY3Q0NFM5VTBsNEJFZ2RtSERS?=
 =?utf-8?B?WEhwRGszN3BmeXVoMk5iemhvM09JV0dZc2w3WUFVZlVnYWxaYlRva2JueTFK?=
 =?utf-8?B?dEx2QlJpazdsSTdVS2ZMVU1YQ1NESFUrcERuTzFLU1lRbytFcW1QTWhya3k2?=
 =?utf-8?B?Mlhjb3dkVmVHUWlPdlNUZnduZzZ5dlJTcjFrazB1Vm5vYkg3NTVQTXJ5ckVl?=
 =?utf-8?B?QUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e10f9553-a05e-47bf-a6b4-08db3b7ba8e0
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 17:30:50.5682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LY3tRC+Rj8NMQ+9sV4wfztgWGe5o6twkAmPA32Ub9RT6dBQDILhTTUi5oiAlMr3notOwwl9quJi9/iKpZ3K+7OlmPv/qeHnVL8uonyG5ZG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6817
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shaopeng,

On 2/15/2023 12:32 AM, Shaopeng Tan wrote:
> Hello,
> 
> The aim of this patch series is to improve the resctrl selftest.
> Without these fixes, some unnecessary processing will be executed
> and test results will be confusing. 
> There is no behavior change in test themselves.
> 
> [patch 1] Make write_schemata() run to set up shemata with 100% allocation
> 	  on first run in MBM test.
> [patch 2] The MBA test result message is always output as "ok",
> 	  make output message to be "not ok" if MBA check result is failed.
> [patch 3] When a child process is created by fork(), the buffer of the 
> 	  parent process is also copied. Flush the buffer before
> 	  executing fork().
> [patch 4] An error occurs whether in parents process or child process,
> 	  the parents process always kills child process and runs
> 	  umount_resctrlfs(), and the child process always waits to be
> 	  killed by the parent process.
> [patch 5] If a signal received, to cleanup properly before exiting the
> 	  parent process, commonize the signal handler registered for 
> 	  CMT/MBM/MBA tests and reuse it in CAT, also unregister the 
> 	  signal handler at the end of each test.
> [patch 6] Before exiting each test CMT/CAT/MBM/MBA, clear test result 
> 	  files function cat/cmt/mbm/mba_test_cleanup() are called
> 	  twice. Delete once.
> 
> This patch series is based on Linux v6.2-rc7.
> 

A later patch series was picked up by kselftest causing a conflict with
this series. Could you please submit a new version that is based on
the "next" branch of
git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git ?

Thank you very much

Reinette
