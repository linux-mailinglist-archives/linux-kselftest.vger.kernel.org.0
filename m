Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4D65AB559
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Sep 2022 17:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237129AbiIBPgk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Sep 2022 11:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237059AbiIBPgD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Sep 2022 11:36:03 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80D93B6;
        Fri,  2 Sep 2022 08:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662132182; x=1693668182;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JMbpvdlWvFdqrghw7TfeL/77CwMxk2vJU4mwoxZKRaY=;
  b=NnqSoFWDC6T8xaEw/dbFG6iSbIA1PR5RxAieOj0jGo68R6hJbrAwOkIR
   ephCZFhDD4n6UWA2DWkrJO9yTl4E1WUcFju4nY5kPQydTTIFuXg+phMDu
   JIt0fde6wNN+Ey8eZzx6siceNnO6MvV2P1EjQb1sUZfZBdV3BgW6Mj6ZW
   U/QJ4jr7jrYMFsBxscqjUKt6AJsBFjYBgh/Y+HrNqCyqhgO8s/y2NIZIK
   Fg3vQCyOTatlxA+xvpy586TX1MfD+svhrGLr+hfd9fh2KXx2PbO8CgJKB
   MIsMiYCRmUyWeOJFcWVF1AjrWYX9cbL1XBHkI57DrreZfpkcNAb+NHHRH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="382300721"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="382300721"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 08:23:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="788690623"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 02 Sep 2022 08:23:02 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 2 Sep 2022 08:22:46 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 2 Sep 2022 08:22:42 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 2 Sep 2022 08:22:41 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 2 Sep 2022 08:22:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZiDdpzOfbh9/xRCnSNd6N3wdOi3GSYjmTn1aJ8IES228ruHJLzgfZWYPAnBdqwDU5hq0qn5bUu243Bm9UL/rOS++0TmK/vWaJa3j3OlI666C2HW+elwIRh2mGD1CwWYIYIw8zhVolCsGuT2QdWBZgemHYMPihqFVCMGqaFmRD6hYUHe7WMnqgmpUFEM76/wzKK8DsWKkF0IbmjdkMZMv45Y1T3XmgkaCzh2C2JKFgMYp2SPOokKbLrBFQLsaHNsFxUfAmynnHB5pz/vJgxp1X/HkVqc4AqVf+4rBzwWUDXxaC2+SAKrLuJIa4VKU/cXzmeujgtYcIH8saHjaXGtTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gcdPnmsJNSIxp2YsTa4jH7ANYZAr5oBt43y5z/S1IQg=;
 b=fzUJmMu8Z5zQe6ne89LWkiPQfdXSptEXdaEV12L+C7+TXZ8+iBriQpmHziKwnuLQ8lFVEEQStXscbQ7wpWXmamowGkbPAL082aH8lbJ0dPEwjXm4BMO6A/MjIezmJhHLB9dmoe13PND7r/4/0A78sTxvRK72gRfYg5EPmch4ujlx8wkOarDYNBhs1RqAfu2T0JOA2P3nsMaItT5pbru4zIJ3CgO0idrPnbuE5IgmZRvcqVThLtzk/BGQXQAXLWaZAjfHP0c6zOSrimS2uoMgdGEow2maT5euRsYF0hPvLM+p07jdcZOxH+9u/PuNh+UwigYLU00sUDEVcvogZwqr5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by MWHPR11MB1743.namprd11.prod.outlook.com (2603:10b6:300:114::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Fri, 2 Sep
 2022 15:22:39 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743%12]) with mapi id 15.20.5588.014; Fri, 2 Sep 2022
 15:22:39 +0000
Message-ID: <8f7c676e-952b-3409-312a-be4cadaf7194@intel.com>
Date:   Fri, 2 Sep 2022 08:22:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.0
Subject: Re: [PATCH V5 15/31] x86/sgx: Support restricting of enclave page
 permissions
Content-Language: en-US
To:     zhubojun <bojun.zhu@outlook.com>
CC:     <bp@alien8.de>, <cathy.zhang@intel.com>, <cedric.xing@intel.com>,
        <dave.hansen@linux.intel.com>, <haitao.huang@intel.com>,
        <hpa@zytor.com>, <jarkko@kernel.org>, <kai.huang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-sgx@vger.kernel.org>, <luto@kernel.org>,
        <mark.shanahan@intel.com>, <mingo@redhat.com>, <seanjc@google.com>,
        <shuah@kernel.org>, <tglx@linutronix.de>,
        <vijay.dhanraj@intel.com>, <x86@kernel.org>
References: <PSAPR04MB416734EEED145D832A04B936E97B9@PSAPR04MB4167.apcprd04.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <PSAPR04MB416734EEED145D832A04B936E97B9@PSAPR04MB4167.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0191.namprd05.prod.outlook.com
 (2603:10b6:a03:330::16) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7dc39510-563a-4905-3947-08da8cf6f8f9
X-MS-TrafficTypeDiagnostic: MWHPR11MB1743:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9uiQRycDKNfUFC/x14oT4GSOcd2bW4cLA2QPbyP3lFlZqI9S6hYN1er160zxey4UD8jVphNZZgrK80VlNpgfAR22WJyZYPq2NiCSEqn1Hh8BywadWqeTZChzGn9GcSe3wz+mnoIAaVh5ODBo/wDC5X+1t2ufxhp21sKxpH9B1rM69518oOhN0S3MzVp4nlmhGdDjDRViKRrRitAEP9+Q6oLxnLlFUjeSax6ZNBxnmyp9rVxdqjL80V5d9VkW5uuwusC3DYwvpcCcTvEzQDZ6FMyv/YrtU+UbGXGlQbmoV0Nx5zLgNZeI4gCUMgacm1WGA6OP9hs3OCQ6mgVNYJSwyKPJc7cyzeF8QWwbrO3y7TB5i+iw4lkDLeIFJcBbiPKjkAQBCy0Zoui0/diPP67pj3ePB0Vpj+mx0HqXDjQ4dV0qcCZIBV1nKilAE+uFU+trWmIy++qcCFGkI9pN2wJjGJrUwLxylGlVAImo8eKclHIb3T3vWetQ4yIO/aMF6i6Xi5gKwmgfgZtnezsxdsF+RaPhghPPJ0umdneWfve4+i/tJxqK4P1+jHOZgupnCbQ68fCVjTHCea0I/fKmrVLMVfmfjvFq8fBzUj9iP/5oLWSgqPUpS8cF4niTjslV+qnoeIGcUIdR/jEqxgIUE9liCiwZnberVidBQitrcOLA9kpZhZtWIS8ozMA7R/baW1ce9s49LQWDLs6DUT6WlrgLWhkAxNxjyTvL+MgGOFXcWNHRbanShAodW4XpzUcfWoTMTMlLbkdSuCk49X9QELYdYWFNAnpcET9Bl9SxaM10USo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(346002)(396003)(366004)(376002)(26005)(6512007)(53546011)(2616005)(38100700002)(186003)(83380400001)(82960400001)(5660300002)(8936002)(8676002)(2906002)(66476007)(4326008)(66946007)(66556008)(31686004)(36756003)(7416002)(44832011)(6486002)(478600001)(31696002)(6666004)(41300700001)(86362001)(6506007)(6916009)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTdYVXBTbldJZnZuNzhUazV3YkdlRzAwQ1dPb3pwSUVKbUF3TUxRemloUWx4?=
 =?utf-8?B?ZElUVVRscGdMTTN5WTlvTlQ1SmEyNUF3VitlMTNkaEMwbyt0YnFQSW5qcThk?=
 =?utf-8?B?UnhCNVNYR0k2THViSWtodDE3QUI0L3hsaU45VHdBVXZPVXRyZDJHOEl4VXdo?=
 =?utf-8?B?RkhhN25uMm5VVW9kWlIvS0JYbVMzMUp3bGxrSFdXNVEza1pGQ0lxZHV0Z29j?=
 =?utf-8?B?cG10Z2xIYytDNmJ0MGlqY1l5U2kvTDF6Z0wrM2hlVVJkRisrVFZzbm5zbDd2?=
 =?utf-8?B?WmFDR3R4a0puaDJZWUUrUkpvRks1YlRBKzZhcDNHNVJRYnVGV2pXbkMwckdo?=
 =?utf-8?B?Yjh0a2wybjc5ZGxCUFlmNElmWk9tTmJBaytHbkNxVG1jQW5DVHZIVmtJQll1?=
 =?utf-8?B?UXR3U3lMMnBHMzkzMzNsOUZpODY3QkxzZTdqV3lkMVVCaWU1Z3VNNzFDN0hS?=
 =?utf-8?B?S0NGUXJ1bDZuUXV1NCtwalNQZXdiZVVVVVZRaUt5YVVhODRPR3B2NGRjVzZn?=
 =?utf-8?B?RkZSaytuV0xqMGV3OWpORXozY3NYakxCdzUvSVJtTEV0enppdHVhNmhUNUo2?=
 =?utf-8?B?cGZiUDdUcHhiNGIxdjFUMzRHQkpsalNuRFp6T2ZKMlN3MWJRNFAyWWpDWGwy?=
 =?utf-8?B?aWNuR3JxRDhYV0F1cjU2bjlldU5xU2FCV2NMUzYwMmlEdmVXS21GOWZjdjlu?=
 =?utf-8?B?ZXBKUlJWZHFQSGlESkJtSlF3TGtsUndJWnJmUmp0WWZTREZLczRMdGFjZHZp?=
 =?utf-8?B?K0VXdURQZmFXdVNMSHBUbVgyWEhjWk9zcDRqallsUU1JMWNZd0J5NTdWVTEx?=
 =?utf-8?B?M0NrT3phMms4akUxekNoS0d5L01yVkJtUVgxQ0VFWkl2Yko5NitTS3o2RDVI?=
 =?utf-8?B?Lzk3Z0ZaZDBWZWh3WTZkTUNFM1VldjNtUHFkTmJBTjBFUzFjQ1JvWlNqcDFk?=
 =?utf-8?B?QjlEZk5ZN2lEV0tzVjZzaTNNS0hKeFRjWm9xS3dtRTFwS2JobkM5SktDWVgz?=
 =?utf-8?B?WE9Tckh6SDdWVjZoK2dvNVEwREhHQWhQS0lPYkZrT2M3SXBoelk2MjBIZk41?=
 =?utf-8?B?Sjk1OHNjQ2pqT1lUdkl0SzRDSFZpZmZQVkxMbW41Njg2RGl2ekxTSmxOK0NB?=
 =?utf-8?B?alNGZnducU1MYzZGRG03K3pTOUFMWlZZanhqR0U2QXBDU0gwSFdjd1FSaFR0?=
 =?utf-8?B?VjBZRTVic0ZsU0pQT1hocFdUUWUxL1ZwcU1KNWNlUm5GbVY3VCtWS1hFZ3dJ?=
 =?utf-8?B?dUZlaXFJSFNrdGF1eklqRVU0by9SM1A1SW1sdEtRNEN4RGtIaUc4WUk5K1J6?=
 =?utf-8?B?SnhCdHdNWlRlSmVMbjUwWHFPQXpEdlJCNnh0Tkp5eVYycHNDWnZ0NWdPblI2?=
 =?utf-8?B?UUtmeU9iZmNIaWdkTHVYaWZDWVZBU0QzdURoMk9yK2VLTDBZTGNxYzFkN0k4?=
 =?utf-8?B?TW9oMXgrL1ZvRnRjNll4d2xFMUdQQXRCTFFoY3k3VGFydExyc1BMQmdFeFU2?=
 =?utf-8?B?Nk9YazRDL3ZJSHBtUSs2K0NhK1ZRQkFQQ2JpK1BONUMxNUxxdTZVck5hTFlk?=
 =?utf-8?B?NkJ2M20rcDliT3oxMUNBL0k5SzhjOWx3ODNpclhaRDNWTjY0dTljRCtlNGxv?=
 =?utf-8?B?QWMyNTV0RFFoMUpKY3p6Wjc0Q250R29kN0VOTmY5azl6ajdmakw0SzRPb2Jt?=
 =?utf-8?B?NEdkazJWNVZDNUNoWHg4ZXlDanR6SFN1NHNzd05qZjIxSzJXOWtNQnFwdm91?=
 =?utf-8?B?R3QwaCtRc1gxUm55QlNzVm5VWnNUWCtOZWVReWFESlRhSGhKVC9GM3JrSC8r?=
 =?utf-8?B?MEIwMGpnSHVQRkxYMlVqSUNCT1FoRkVWZWpjRWRyT2ppaGM3REhkN1NVOWdu?=
 =?utf-8?B?V2RCTlNLdHJyaE1XMTZzOXBkSE5lbXVVem9hMU9kOS9uNGtGNWZ2aDIwYVls?=
 =?utf-8?B?TzZvcEc3cXBiUGlwZnIrWTdYeFJlanlCLzVUc2dsNjAvZ1lyU2hDc3RRSDBr?=
 =?utf-8?B?blMvbG0zYndIc295RWFtTzM1MzFyQjNmM09sVDZ5NXBlTlYzZ3ZOYllXWVdY?=
 =?utf-8?B?MWttdVp5eHVQa213eEg1YXZadzJDTk5jWk9iZTNuUGI3RTZTSE9XQWVhTEky?=
 =?utf-8?B?aDVXSGhXOU5mM0IzYitlNTNzbU9qQytqMW1VMUl1RjhvZTQ4Mi9VNlZ1UUNV?=
 =?utf-8?B?Qmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc39510-563a-4905-3947-08da8cf6f8f9
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2022 15:22:39.5772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xNvAh6Nq9ObWM3u/egy9iP3TcUOsj468MtRQGzWH0Mh3RrYCTOFusShoSAmCYZzgaFigHwowor5hH66pNG8txuWbqIWTRoKPdByqP77f7Js=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1743
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Bojun

On 9/1/2022 8:55 AM, zhubojun wrote:
> It seems that `sgx_enclave_restrict_permissions()` is able to do
> permission restrictions for multiple enclave’s pages. After driver
> invokes ENCLS[EMODPR] to restrict the page’s permission, it should
> then invoke ENCLS[ETRACK] and send IPIs to ensure stale TLB entries
> have been flushed. Only in this way, ENCLU[EACCEPT] inside enclave
> can only succeed.

Correct.

> 
> Current implementation invokes `sgx_enclave_etrack(encl)` after every
> `__emodpr(…)` in the for loop. My question is:
> 
> Can we move the `sgx_enclave_etrack(encl)` out of the for loop? After
> doing so, `sgx_enclave_etrack(encl)` is invoked **one** time for
> multiple enclave pages’ permission restriction, instead of N times (N
> = `modp -> length / PAGE_SIZE`). We may gain some performance
> optimization from it.

How important is the performance of page permission restriction? How
about the performance of page type modification?

> 
> Please correct my if my understanding is incorrect. Looking forward
> to your reply and Thanks for your time!

From the hardware perspective, a single ETRACK can be run after
EMODPR is run on a range of pages.

Some things to keep in mind when considering making this change:

Note that the enclave's mutex is obtained and released every time
an enclave page is modified. This is needed to (a) avoid softlockups
when modifying a large range of pages and (b) give the reclaimer
opportunity make space to load pages that will be modified.

Moving the ETRACK flow out of the for loop implies that the mutex would
be released between the time the page is modified and ETRACK flow is run
(with enclave mutex held). It is thus possible for other changes
to be made or attempted on a page between the time it is modified
and the ETRACK flow. The possible interactions between different
page modifications (both initiated from user space and the OS via
the reclaimer) need to be studied if it is considered to split
this flow in two parts.

With the ETRACK flow done while the enclave page being modified is
loaded there is a guarantee that the SECS page is loaded also. When
the ETRACK flow is isolated there needs to be changes to ensure
that the SECS page is loaded.

It needs to be considered how errors will be communicated to user
space and how possible inconsistent state could affect user space. In
support of partial success the ioctl() returns a count indicating
how many pages were successfully modified. With the configuration
and ETRACK done per page and their failures handled, the meaning
of this count is clear. This needs to be considered because it is
not possible for the kernel to undo an EMODPR. So if all (or some of) the 
EMODPRs succeed but the final ETRACK fails for some reason then
the successful EMODPR cannot be undone yet all will be considered
failed? How should this be reported to user space? Variations may be ok
since EMODPR can be repeated from what I can tell but I envision scenarios
where some pages in a range may have their permissions restricted
(and thus have EPCM.PR set) but which pages have this state is not
clear to user space. I don't know what would be acceptable here.
Looking at the EACCEPT flow in the SDM it does not seem as though
EPCM.PR is one of the EPC page settings that are verified.

Reinette



