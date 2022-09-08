Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3A55B298B
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Sep 2022 00:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiIHWn3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Sep 2022 18:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiIHWn0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Sep 2022 18:43:26 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B150114A67;
        Thu,  8 Sep 2022 15:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662677005; x=1694213005;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AuJ0rdmRqXR9fVwE+LNA5Pfivm9/tD6dOHveic1nR98=;
  b=KfjQNatwzSn8p9RaC4dJwmVEE9r+vWsLmaypSMO42EUdubuD22d57E/w
   KqEdqDCzBE751RI9ziPeHTkkO6WuxitRsRVVP2fChd8gmrLG8gObjnE5t
   OqEHJFkejMzWb0tlPlEQT1b7G/+IN02ahkHI6KsFVPq1MQdIzoMr+eLk3
   zOhHkFQfl6US+qRLTqIha6WWXlyVc6AnG7SAZJDXVkNjP4QtLvmlY0CDk
   /UFupCVxejI2q0k965OxWJKwz+nKDTuUFPXtTk5vtECQHYq7FZKc5NEx0
   kIGCURk7kmz/L68aMIFjXKXZXYrW/GmFVbUTneaiRAi6HZdDeYm4fpc4W
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="280368563"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="280368563"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 15:43:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="645289456"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 08 Sep 2022 15:43:24 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Sep 2022 15:43:24 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Sep 2022 15:43:24 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 8 Sep 2022 15:43:24 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 8 Sep 2022 15:43:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjZqwttmyJIlFh9W4K8M2we70K7OJWF4KJsm99YZ0/tItcHS0ReRZne1FWwAQsstJJkiV5yp89/MW/BwrPC1ZVDUUWhsy3IVS0iUc8Kuqde7RfsOOBML87/JvXkvJlwZMdWzNpW3poaKeW9Ziw23mTpAn1KK5vpSvt/1Qb6mb5WrHpEeX62b9QZ6s4osKpZezrTBt5ZQJkhd9txogpwWPRYjTa+Nv26/myNEn/qZ1qmcfGW5w24z7uJ/BNZHAGomJ1GuMhJ4O4RuvSfNe+llCHdmJiQFIXC/K4ZCo6FmN2u1EGmt+SYcea5khKzqzISl6gC4vTpf1wynbYR8QFmX0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yg6ayvNeZr8XwR7n6AC3PGMx6/dxF4JqIa/CEVzjMmY=;
 b=mrrCQbo3xa/Mzb+5NSz+Digg3+JobGS1SRQh3xWK4a8xr+x6k80yejSVTx+VpZe3135JgFjddOGVGmIop/IVM1cxHdTdm1vPaOUbi4JTayJFAlMJOEqDnp7abmuzexqeFuZf2uWV2KUA29beHZhKjZyTeqBoEvevGsg7RXNZFfviP+/bg8/ioJPpL6U4w7DaJcwfKpW+LlUU5ef+/LwgWRUI79v6TIRrz+Wve9EE4m5qz8tdm0MlJ2v+lkodyUyZjcYovRmsisgX5iSRZ6eHMZ+ynAiHleZXZwrN+5pd1wKOV80YgRR3DNNrlkdmEBdbmp9oGA6HZgFI6kl2csr6aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DM6PR11MB4075.namprd11.prod.outlook.com (2603:10b6:5:198::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Thu, 8 Sep
 2022 22:43:22 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743%12]) with mapi id 15.20.5588.014; Thu, 8 Sep 2022
 22:43:22 +0000
Message-ID: <7daa7a8d-f125-5d86-6537-68551319157c@intel.com>
Date:   Thu, 8 Sep 2022 15:43:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.1
Subject: Re: [PATCH v2 2/5] selftests/sgx: Move ENCL_HEAP_SIZE_DEFAULT to
 main.c
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, <linux-sgx@vger.kernel.org>
CC:     Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Shuah Khan" <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220905020411.17290-1-jarkko@kernel.org>
 <20220905020411.17290-3-jarkko@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220905020411.17290-3-jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0047.namprd05.prod.outlook.com
 (2603:10b6:a03:74::24) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02118759-9fb7-4f00-c7fd-08da91eb8888
X-MS-TrafficTypeDiagnostic: DM6PR11MB4075:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b4wf78YgODAFYHxNSHsvJqbBTvzXlIyb3HZqoG9MYPAavgNkySkCYxSNJikwzr9JTAQrR3yRVa0iQjUe3SeHSKNGk4njCE0sLUEaDkfPrBYy36Xg/Y882Sjiv5bvjChVB6T1+MSHiF8OFQFcQqwIGd/vktsnmyMnWKOfdg1nOjy86Tuqx4vYxWviul97Ap8t2IoGzahce+Eyso+jFCw/Gg0tX/tJqvnrPoIVZ3JCISoERBUpaNqroec0IuQG6+nnirYj2B7F9GLVJH7I+KhnyODHO8bfDftClhaej7W/2hIuqBFDMnY4BL+uhyWnWMymR/WAg3/WEeBit7LvOCdV4g5mKaQCuzGKKA7B1iQ3+BnGvDljdbGsGnSUvDXwS4Q4mZRkHyMXFaX/YL5dacFUj0G6UUfsDp+DxBaY9Gli0lg32ggWeojqRt7xs5lVuJwyFW2y6eFTy3XjLrYYvIlrRPFwH3eq6h4P3oKpGly99lFp5sy6OKjgJqckICLCtt+EcHh0xNoEfBla44CiMOuPde85i7ZOU8/qlMxAAT16Kx0VpEQ0Yo+ZiKe3aRmvtwFdJDDz+G/QP2LA4+yfuWC9ViRCa0ACNSjHWEiXuFdn/KLlIf8gYf+LsmVjUSnnGDe9WDoPkH04YdSmkdx9pMbv4QjR8u6mw2cJf0/AzPFs5RyCem8SMMT9O9ATIXMD+CJM0I99rOzvS6BoD4z2ZkuaLYrm/m6A7jO4smLi2A2keeqoxFW7Q2XPz+34pQ7h3GBPGydkxx12Ytb4U8kx5Mgdhc4I8bgP19AZgM9MWgLqTbE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(396003)(346002)(376002)(39860400002)(54906003)(478600001)(316002)(6506007)(6512007)(26005)(31696002)(8936002)(36756003)(2906002)(558084003)(53546011)(5660300002)(86362001)(66476007)(66556008)(4326008)(8676002)(31686004)(66946007)(44832011)(186003)(41300700001)(82960400001)(2616005)(38100700002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUlXeEhvWTZET0hneDdtUzFUZFQ1ai82bnlndUxLY1ErS2ZPQmRva3k4Wkp6?=
 =?utf-8?B?M0JFN2psQWpkNmYybVJVYXhBaXFkRVk4VmR4MDRiQ21reVBFZm9sNnd2TFVH?=
 =?utf-8?B?S2VFK2xhUFBLaDNuTDFNUitHWXFDOTBIS1k1TWxBVUFDQkZRekdNdTd6ZlpV?=
 =?utf-8?B?b2F1SklaV2tmYWZGbitZejJMQzZaRGN0ekFWTS84UjJDT0tDVzdyRldDT21n?=
 =?utf-8?B?b3pTRzlsTittV0ZuTHNaNHhXdmRCVXEzbXZBRHZheURFMU1IRnFsTEk1Vkpz?=
 =?utf-8?B?TUpXV2p0K1g1U2ZJT21YcDNMT1hFRkZSNEk2NGF6Y0NkbHBhblVjVFZQNlYr?=
 =?utf-8?B?Nk1ERmNjZWk4UkEwMEtaamdiVm9RMUhZVkpSZ05qeEFleC9vN1U0TzFxQ3pX?=
 =?utf-8?B?RXREZDBrRmRLQUI3dXpNbi9CR2JNcGxSemlNVzFPNk5pVlF0SzI3cExoT3ky?=
 =?utf-8?B?a2VwNURkWVladGhoNXduUSs2bGh4ZkNhbGVKd2l5eHpPY3ZIRExCQmlyT3Bl?=
 =?utf-8?B?ZkNlamlwRExVdVRuOWxiV21OOWNYQjV6NjZITUdWZ3R6N2ZxMTNubldNUzhJ?=
 =?utf-8?B?T0J3RVZuSTN3UmFOa3p5anI3cjNhejFKUlpYZFcwRkR6cW9FK1hDbnFKdUlQ?=
 =?utf-8?B?Rm8wSUtpLzlvOEd5T09vVnhvWkRSN0pZZTVadytzMzVwb3UwUXRZMG83VHFX?=
 =?utf-8?B?M3poOTgzUU1yUEd6TkppdFhNeWpHa2UyOC9zQUJkSlZHdS9hR0Q0U2RpaXR1?=
 =?utf-8?B?L3FGaWZPV1k0TUdQK1Z4bWQxRS9tNllpZHBzMjVydmF4MUo4RTFEdGxBYlV1?=
 =?utf-8?B?WUxFT0oxVlZheVQ2bjE4cDN6RjFDS0lETklDV1ZMRWlhVXZVQU1nWEtEaVQr?=
 =?utf-8?B?VnBwb2MwRHZYTmVRaGIzajZpS0RuOHEyYVRibHFZcEdsZ0hFcVNIN2hYZWNG?=
 =?utf-8?B?Y1Q1SW00NU9HYmpGMHFteWhBbVRFdkpoREZjQnJQRE9EbmtRaEVUOTNDbFkr?=
 =?utf-8?B?ODluMFo0OGNCcER2UHBSQVpPTXZObHgvQWltRG9qTmtSSmZDME45NmdDUjE5?=
 =?utf-8?B?MnZhVUVPcmJxbHhDRDBpNlF4eU9ONnNDaDVRSkZUUFQzcUhRcGxzYmxvVko5?=
 =?utf-8?B?NE5udTVxODNGWHRUUG4wcGVycWtuZXBCbG1ybDVvcmRad292TGNrSHYwVHZW?=
 =?utf-8?B?VmRBKzduNVJkNTk4d2V5bEpQbEZhakhLSzlab0JxOWlibE1qRDJTejVxbU9Z?=
 =?utf-8?B?VjJpelFFNjZJcEFsdkc5bVR1ZWhDMGJadERub1FYS2FTYTZrRGNmWVF4cUQ2?=
 =?utf-8?B?S3hKYUlIRHpUKzM2bEJiSEJoMXN0eWYxZjVJbGFuTUE0YVdVNDIyTEhYZnlO?=
 =?utf-8?B?UnhXQ2NKMmlHM2MyOHpwNUY2dDhkZTM5QnpSM1B5NElyS1l4R3pJbTljelBN?=
 =?utf-8?B?VUFPbEZ5bmw3WXRidXdrYzVXNjRLNzNYc0QydmN4NGRBSWk2eWI4dmE2dVdO?=
 =?utf-8?B?c3hzSjc5MWJMdWVoNlNJeFNoZ3YrNC9PT3Y5U2FEODJrZzFSYnJid3p2cWVq?=
 =?utf-8?B?N1dpNHcvaGkxcVJZYjlLQVRjOTFnbWo4WFhrNnM2OFZ3QXV3NXdVQmttVEp5?=
 =?utf-8?B?TmdldWlBZ2dMMTN0RC9SVWZNMERyWklvN05qWCtaTzdZaXlIYXE4WDFmd2dv?=
 =?utf-8?B?anlVSHVkeTIvM2NnSERrTWdidUpqUUxKRWppYVlqMi8yVUpoRWx5eUdaMnVN?=
 =?utf-8?B?b3hLWXE0ejZIdE1rZWR4V3RNajhLUktMUkpWNmZUbDJlTVF1dHJwbzRjVmRM?=
 =?utf-8?B?VmdrZEZrZHJUZW90T3Z0Z0dkSzl4SU0yMTlZNm9Ma2dwNFVxbkx5Tm5nZzlp?=
 =?utf-8?B?cDN2Z0hOdFNHVUdFR04xQmxaOXoyQW1CS1B0VXM2UU9aRWdDbHhYVzl4QVV3?=
 =?utf-8?B?amxyRVQxRWtkREN6NnQ3UmkxK3ZUd2dwcEJ5TDBuZVdacmNxcFFnM0psWmRL?=
 =?utf-8?B?cDBLTGliWkdBazFWTnBtd291UnB0YjBwZUFoWmRwU3hUVndIakNDMW9WOTlv?=
 =?utf-8?B?UUVDT2YrRElLeExFSWt4MmppaTJLSHBMblZwTkRGRTlVRnJJVDBGNURaVndS?=
 =?utf-8?B?R09TM3A5S0cyYm5vb0pVOTFRV0MwYVJjYzQzY00zRkJJNklERXBweUlMdFhG?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02118759-9fb7-4f00-c7fd-08da91eb8888
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 22:43:22.2228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wtdz3X0+XjkZRzBNhYXd7fawa0EJQWhs4m+xNrKoCrDzdArwpnMieeFqPzjucbXXQtDq/qlXPBnqFOI1jzFo8rsVS/2ris4m/P0Ex/Cghuk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4075
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 9/4/2022 7:04 PM, Jarkko Sakkinen wrote:
> Move ENCL_HEAP_SIZE_DEFAULT to main.c because all the other constants
> are also there, and it is only used locally there.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Acked-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
