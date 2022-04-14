Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F75501944
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Apr 2022 18:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238909AbiDNQ7P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Apr 2022 12:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244302AbiDNQ6q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Apr 2022 12:58:46 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9BD9F6EE;
        Thu, 14 Apr 2022 09:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649953941; x=1681489941;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WtMvpSOSqUiDqk13x6O+YfALG9gh3euCT+fVyv9i7tA=;
  b=EqzNcdIKrJE4qbS/5C8V1LSiYeHA+uB/DaE+DhgDCrwAjv6nUiyqnqU6
   3BnP4CotNKarvqq/YWr/Ak5Uho+URl7eRPt3g4l+iY84ztstLWMiHIQMB
   vHi57UQIxC2vBW/RQMAE/yai40gKVNebeqtdZwUkwqBh2ZSZavDMq5ZP2
   SrJUJ/eClg7CtjhyqH1LKComU8tKkK5qB+oYWM8oqGBT0R3huZ8NYZOeg
   349f1Pg6173tG8l11+EJx1N5dGf+kgPICHHJUIx3H9x9x1Y88Vrcu+rGb
   D61n8C1WxJGrPw47oVfx8hbU8/ik2RFv1BAOXk1sbblOtGRzbRqdms9Rt
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="260566978"
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="260566978"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 09:31:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="527456322"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 14 Apr 2022 09:31:26 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Apr 2022 09:31:25 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Apr 2022 09:31:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 14 Apr 2022 09:31:25 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 14 Apr 2022 09:31:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdtJB36vjiILTHjDEXc/h2QGZm6gQpsb0Govin60l+wj9hAaQoS/F4h1jq2e0QBGj6dV1QX6SJVfrYi9zl1pk/ypbJMGWmqsWXirSjSLvQiLlKapcGL6bwl2nXUoAl61sxeubHdRTVRXKICWctxu6gxs51LSgFZPz+OhKnQ6TmRDzhBQSkGTFkpeNG6QD9gTwqDl4D2PyEbAyhCRl13QIy/WAHP5pV0MqODuTL9GSqkz7j0pf2Aa0E/VVVdaxufsQbtlbznBO4kK8JpyQRWV49t9bLyMH/JjCeHnga65f7pxYBxcd7ux7PnOYq04SjQ7Rsd8iPJ8DsNqcmwNqjRCbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hl25e3mepRhP0M0mCMa8DsfhVahD955iyRdjP81xSnI=;
 b=CKyXj3BO+vYjmQebrNViSY/EgK9L2yjzm5pNsZRZIq85ZWUA0ucl6ca/UqTIhHfKoFbEdNibXwkK9z7a4hbXI0S10EXwxL6gQ0QvnDDwA6YItb42aml/4XrFNSJvjdtLPCm/ICRJuS8e6ETqx8lRojhPVOXuPGepV0fKiWCJiYR1nOT9CvxBr2aFMEo5nz4Fd9mz9icbElCga+mcY2d60e6PL1B8i+beR3x5L3dc5kZPIu1Ua438ncOR7c9ZbJq6xAhc/yl/Ql5JWxMAdaeVv2KIxULHYoGCFjoBGDYB+jC8bpmpjx5h208w4p2h65BimuDGiCz/SGBjjYADPdH9kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by BN6PR11MB1443.namprd11.prod.outlook.com (2603:10b6:405:8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 14 Apr
 2022 16:31:17 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36%2]) with mapi id 15.20.5144.030; Thu, 14 Apr 2022
 16:31:17 +0000
Message-ID: <f9979705-d7aa-0abf-5022-776d17dd977e@intel.com>
Date:   Thu, 14 Apr 2022 09:31:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.0
Subject: Re: [PATCH V4 15/31] x86/sgx: Support restricting of enclave page
 permissions
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, <dave.hansen@linux.intel.com>,
        <tglx@linutronix.de>, <bp@alien8.de>, <luto@kernel.org>,
        <mingo@redhat.com>, <linux-sgx@vger.kernel.org>, <x86@kernel.org>,
        <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>
CC:     <seanjc@google.com>, <kai.huang@intel.com>,
        <cathy.zhang@intel.com>, <cedric.xing@intel.com>,
        <haitao.huang@intel.com>, <mark.shanahan@intel.com>,
        <vijay.dhanraj@intel.com>, <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>
References: <cover.1649878359.git.reinette.chatre@intel.com>
 <a1d7820ab5f2e6d21cacb14bafd40a682101c492.1649878359.git.reinette.chatre@intel.com>
 <9abbecc124d61843c27217bf183d7447a281c297.camel@kernel.org>
 <7129163a0565dacc4f4f08c03f2cfe061274d017.camel@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <7129163a0565dacc4f4f08c03f2cfe061274d017.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0144.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::29) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 738447c1-24bd-4a51-f9cd-08da1e343350
X-MS-TrafficTypeDiagnostic: BN6PR11MB1443:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR11MB1443274B5DB83621E7B4E341F8EF9@BN6PR11MB1443.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jZ42umtCbcDBvNu6fogYXKJ65HqfHgYLePQaRywkq8INXBu92NqZ+0R26MEfxfzKCY3QDhwF0C1z0Q8T1WL6fXhp4aXPRgzu8DpyheoKkwm3v0UUEO6a6GgEddjWNHnnlLznaSOpYXa+UJzV9evD1G/oG/61NtmJ3syuhtOzK0eY4fI4GInyyed5UejJ1FKXGeSWIWEfsyJoBFefa+S3gC5Jz79T/wHeqlE8GoXWxeqYw8BZdovt8/m9zjUu1G8oVMqmF7QgobddJwbaxCJUg9Ey3Iu0Zq4il2PIfeO+RtxEN1vgbmofKVS2BBLptzV+NuccoIQPwjLK9iYKhWZTN8aEmLKEshuq5GUSgo3mvAVyaVaTeh1qJa6xDBm9bsWq4yuAKp317THYaAH2ZjR3xnris56hOLdqXfshYw/eEvscdLmii911l3A1CYFEm/0wzUzqILJtBH7UeibXZQTWDBGF/tgZqRX37nsZFKkjmZdfeeaWlTXQI8KQq5s4zhlvGS7DHg2m5gimpKZqquUlKzk2W/oVtAkxa2Ic8OC2lvYfrWbAI+a92/pgv5xwUbrPbHDnS2mxtQ9GRxkjYfusNF+sWfhsPLPdFmUXRigEWYyrtlD5AYl/XUaHZ/tyqPnNGyWthKdORkWOWYbZtiBwCXC2AxQSA+obHqP1NllV/IooC6tMiaFVTDRFevi/Cblt2pMS7Jj2VTaZYtGWbfaSN9QSw79D/R3jWYC/LYNqZOD9jaf+sep9ZQpl7y19oqF6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(8676002)(5660300002)(6666004)(66476007)(66946007)(86362001)(31696002)(66556008)(186003)(2616005)(36756003)(83380400001)(8936002)(31686004)(44832011)(7416002)(2906002)(921005)(26005)(53546011)(6506007)(82960400001)(316002)(38100700002)(6486002)(508600001)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3FxK0FkQ1lQY2dnYllGWG1PTU9YMmxnTGE3dU9NUVNmNzJ6ZTMxRllySERk?=
 =?utf-8?B?eWtzcmRRY205NWNtQjNLSEZHQVFPREh5WU1Zd2dsZXhaeG5PRnAwVVVMRVZZ?=
 =?utf-8?B?UE8wamZMbjE3eCt1SWVLQ1F2b2M4eXF4NTRZWUVYd2IyYzFhK3p5Y2hVaG1o?=
 =?utf-8?B?V2dFcmdrVjlhZXJOQVdiNzVjaWlJL05Xc3VaK1ZYalJicC9RdVNjcnU0L3Ux?=
 =?utf-8?B?Tk9vRWZxeTAwNU5jTGU4V245M0FSS0hiM05pdGE4clg0bFV1RTgzckZmZHNr?=
 =?utf-8?B?NWJuejNwU2N6dHp1bk9JTVdhbWpvaHZ2cVVBRmRpUkkzU1pCTmJkbWFseDBC?=
 =?utf-8?B?cFlPbHVSVE9QSVRwd2lJZnBLZ2RnbW1KdGFuZkZ0WkNidm1pOXU3S2ZVRGtM?=
 =?utf-8?B?UmNwaEUvNEQ3aGVGTk8yR3IzQkkyV0lpejZUa1dJeU9taGYrMCtwei9xR21E?=
 =?utf-8?B?aWNjQjdWaVNEOHZCc2szZmFxaFpRbGROSm5kRHM2Z3FvTnVTZG1KN1pWVXl5?=
 =?utf-8?B?Q0FNU1B1czhGN1lSVDlUeGMySlh4RmpLZVFuSlFyRzd5ZGhkODlFRERTc0NV?=
 =?utf-8?B?QlcxU0VrWE1yaFpHT0NGdlYzSGI5UTFqWXBTNGcrZVdoMHlqT3FCREN6WE5Z?=
 =?utf-8?B?ZFR1VzFEYlQ1MUdWdytFVHA5cHdya1d4S04zTTZudnhuaU52dmt3RTBOeFlX?=
 =?utf-8?B?bzh4WlZjWjYrK0JCR3BxUUhkZEFUeEZFSG9qK2JCR3ZuWXQ1dG9uU2V6S2Ji?=
 =?utf-8?B?emtmS0pWTTVkb2tDOCtiSEVOZUhBdDRuWDJ0aTBzUitKWFJXeDFZblA2SWZM?=
 =?utf-8?B?ZWtraXpDdTlWOVR1OUJ2RTB4VkQrclRwQ3dNaGo1em94dGZBV0xZcmVjNm1i?=
 =?utf-8?B?ZytSbjJvbUNoemd5T2lDQWQ4WjJKd3VBM0JHZ0pQNVFJcHJtWWRBM2c5bGJj?=
 =?utf-8?B?cTJLVU5RclpEYkpIbm5NWW8yaGdpdVcxelB0R29vZXM0bVRob0NpTkpBRERL?=
 =?utf-8?B?MVArSldPYWRlMm4xOXVwN1EzTEdYaHk1eUlRN3ZoU1krVGtWS09uZGFzczNw?=
 =?utf-8?B?OGl1OWpRQ1c5emk2T3Yrd21IYS81Z3k0bzJsaU9zajArTjlzNmd4ZEJoeC9W?=
 =?utf-8?B?emR0T0JYU3UvRWgwSy9EaWYwRVIzMkFvRHd4MUlDaldmSXcxRTBWN0dFMWR6?=
 =?utf-8?B?dDF4NTA1dXYzemNUNmtrNm9pQUtzb3VHNDJKMjNKUUU5czNCTUUvbnp1enQv?=
 =?utf-8?B?OE5xZVNIZlZSTDJGZ3hwQjJQZnJWeVN1QnYvY3BmUU55Tk5nc3lMakpSNTBB?=
 =?utf-8?B?ckkvQUZHMm56allqN0hMUGh0VVh4ZDFwYlI5SjFYUDhLUGZXdkpUV1VqMzRW?=
 =?utf-8?B?dG5Yb2l4MjVXajNUV2QxQ0JRcCtiT3QzUTNrM1lXTHU1aC9wS2c2blZETE9s?=
 =?utf-8?B?M0lCTmhtNzFqb0RFUCtWOUxHbjAvaTdTeTJ1UlUrZCtDWHBjTnNZNlNHUkFl?=
 =?utf-8?B?Q1dqbGdhaFViUHFZT3I2VmhVSHlFVjBZbVAvWnFXSTNYaklvSkxkd1JMYUNy?=
 =?utf-8?B?SWdtdnRZZTJXZ0FaRnlTcVZWUFpndVVpT0tOTXRKYmhLRXRuM3g3MWtIN201?=
 =?utf-8?B?Uk1xWlJiSGZaN2tmMXZzZ3ZRT08wQkN2M1pxU1lQaVhkaUZ0R1E4RmlFa0ZT?=
 =?utf-8?B?NnRWMWxoQWpmdmtlZm5SQUw3MUxOYk5IWTgvdG1oV01QSGFFM3BJaktPL29G?=
 =?utf-8?B?YjF4K01jMmQ4VlQ4OHdxeERaaTlZVkxrWDhIa1lrcklJTzN1Njhya3RhL0J3?=
 =?utf-8?B?MThzenl2TWZlRjlWZWhJd3RGek1jcmU0OFVkV3ZGanFaTG1qN3FRMTVOSXBu?=
 =?utf-8?B?MXpPdGlWRldDUEI2bG9DcUd4M2I1ejZ1QXhORVpmTTdNYXF5eG81WExDOTZ4?=
 =?utf-8?B?VUNiajZVZWR3SmtjUWZraEZXaFNiWGRFK0I3MXBLMWNRcjdwa2I4aWN4RXpJ?=
 =?utf-8?B?S0Fndm1FeEl3M1VEaFJyT2FZeUNaOEpQUHFCK1NyQ2xNcVFHblNMdUJhS2Ju?=
 =?utf-8?B?Uko3UVcyMEw1VlpuUW1yZUFCZ2JhTnMxNHZ2RUphd3oyNXFpMWsxcHRQR1BB?=
 =?utf-8?B?eVZtaUZGVVI4YmdtZEMwRndRa3c4QmZkNEY0eHlGdUpQV2hwcUNSSmZjOEwy?=
 =?utf-8?B?cVlxQjV5cUg4RXFPR0dVaDZ6R3JOTldiWWFSU21DQmFWSlMwNXNmbWZVeDBn?=
 =?utf-8?B?RHZVS25MbVVQYSszcW44QmkyYVZsUm51aTQ0Q2x2dFhQZ1ZiTXhhckRtdGN5?=
 =?utf-8?B?dkNJazM2VUw4OS9EY3RkTFVsV0RydjNsOE5VVFNnT3ZLc05lS0ZId094TzZK?=
 =?utf-8?Q?N7VVUC0N1DrsB20I=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 738447c1-24bd-4a51-f9cd-08da1e343350
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 16:31:17.6611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SZFDQ1yocMmnK/6vHZp4h7sPoe9+eKmbePPnhOBtDLDaSRk+neX4AC2l5jsy+IJqf/fOMOihXUZjP/SSPb88jC0pqqMUy17loyPQEuDkfv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1443
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jarkko,

On 4/14/2022 4:19 AM, Jarkko Sakkinen wrote:
> On Thu, 2022-04-14 at 14:19 +0300, Jarkko Sakkinen wrote:
>> On Wed, 2022-04-13 at 14:10 -0700, Reinette Chatre wrote:
>>> In the initial (SGX1) version of SGX, pages in an enclave need to be
>>> created with permissions that support all usages of the pages, from the
>>> time the enclave is initialized until it is unloaded. For example,
>>> pages used by a JIT compiler or when code needs to otherwise be
>>> relocated need to always have RWX permissions.
>>>
>>> SGX2 includes a new function ENCLS[EMODPR] that is run from the kernel
>>> and can be used to restrict the EPCM permissions of regular enclave
>>> pages within an initialized enclave.
>>>
>>> Introduce ioctl() SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS to support
>>> restricting EPCM permissions. With this ioctl() the user specifies
>>> a page range and the EPCM permissions to be applied to all pages in
>>> the provided range. ENCLS[EMODPR] is run to restrict the EPCM
>>> permissions followed by the ENCLS[ETRACK] flow that will ensure
>>> no cached linear-to-physical address mappings to the changed
>>> pages remain.
>>>
>>> It is possible for the permission change request to fail on any
>>> page within the provided range, either with an error encountered
>>> by the kernel or by the SGX hardware while running
>>> ENCLS[EMODPR]. To support partial success the ioctl() returns an
>>> error code based on failures encountered by the kernel as well
>>> as two result output parameters: one for the number of pages
>>> that were successfully changed and one for the SGX return code.
>>>
>>> The page table entry permissions are not impacted by the EPCM
>>> permission changes. VMAs and PTEs will continue to allow the
>>> maximum vetted permissions determined at the time the pages
>>> are added to the enclave. The SGX error code in a page fault
>>> will indicate if it was an EPCM permission check that prevented
>>> an access attempt.
>>>
>>> No checking is done to ensure that the permissions are actually
>>> being restricted. This is because the enclave may have relaxed
>>> the EPCM permissions from within the enclave without the kernel
>>> knowing. An attempt to relax permissions using this call will
>>> be ignored by the hardware.
>>>
>>> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
>>
>> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> Also for this:
> 
> Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
> 

Thank you very much.

Reinette
