Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C5B501958
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Apr 2022 18:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241005AbiDNRBU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Apr 2022 13:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241808AbiDNRBI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Apr 2022 13:01:08 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC4C4FC4D;
        Thu, 14 Apr 2022 09:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649954074; x=1681490074;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hN9eZV+Xv3yF4wsPKc6KrbSRPU+E4QXD9oQ3KgpYc3Q=;
  b=hbwf96Z7Q/Sb5icfroroJj+yNPbLUPnUrz8EG4HAtF9cE+EK7ULO2jDc
   VPIKCx61gNwjY6qXKGBvYxiq9jodYwWuQiZU3Wnk3NXD7mxfwrGaohBm0
   TvT1yeA7wR2N+9Y2vRs7MuhzwcDJKxSGKIwm1t9HtNqUEVCMYaxyPrDEn
   F3EewuqdxRd8L2BFqx4jGpNYd87oTrByPTrzY43GitQOg32ML9QwflxR9
   K/MR3uUp3T6V+ZDjsQNgM57aQX71UHs3Y+eMsxGupJ4SFytBlxEVrIXPL
   cmvv5YuoQCYc2Bt/FmVn77ccYz/DPJIHFZ4N/JzxZp82A3YazbywGNg5E
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="250270417"
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="250270417"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 09:34:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="612395458"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga008.fm.intel.com with ESMTP; 14 Apr 2022 09:34:32 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Apr 2022 09:34:31 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Apr 2022 09:34:31 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 14 Apr 2022 09:34:31 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 14 Apr 2022 09:34:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BvV35C4rpYov2DfVfRmbc5hmeYKvyDcj76826AaSoi00u55iqyRRpHx79SDq6mmIwz73v5pYwzC7Lfdf+CHcWggpHBkbzllq3iRii0q1PA3oo+pbBhYtxILGVKaKmXMmbn+13kIHbnX39XjRSfp0K/5i4xb5fyNIQGlBf+3Z8B+5cdvR2+KNECW3VsFio3O2dp/d8+V+Xj3hzupGWYgrldk0awSnvL4YGOezQjjItBCdACj3tRj4lBigISkjHyQaNAgMUXw+vHkVmtIhtBz65cftL/BJeRmbdwW1aMdRearAbfIlfshfLZQzXZEYNzG+aKhIGalriL3v7pfcUX+w9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNO6LuMHXwTMSiqeZVYhyE7mK10FaQIhkbEPz8TBSM8=;
 b=jK5mXPfesZOpzbuRzD1C1lIxU7klP1l2zllY4B/VAwB4BGTer0EJm95Fv8ublQH05PDVmAGr7RC2hoHxWnC000ah1hxxZnXKLQ8lHZFVYc2IZb5GYRTcwb1tbEXRrZeQIkOujV+OrWezFnXYlVs95A/MZvW6qxrqNTtgzb8k/iV6kPC/mfMsc8SM4iJgfEThB6Ppnyos4J+pebE2alhRGZWytIJ2V+F0W1j1zGQj95ccNBTKJzITEDRfVOyhfMMqK3Ptd3Z8BzSXHLY2hCeD0LJUC3ooGt5ZPZ0E9RvF0UuRuG6BGIO2wpGTK9O9LoSx0COc7LJyeOJuf+J1dYh/jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by MWHPR11MB1552.namprd11.prod.outlook.com (2603:10b6:301:e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Thu, 14 Apr
 2022 16:34:27 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36%2]) with mapi id 15.20.5144.030; Thu, 14 Apr 2022
 16:34:26 +0000
Message-ID: <9fbf26c8-5808-20c5-8653-d4f36bf398a4@intel.com>
Date:   Thu, 14 Apr 2022 09:34:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.0
Subject: Re: [PATCH V4 00/31] x86/sgx and selftests/sgx: Support SGX2
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
 <2f4338f37943c2b067db16ae65c9af665d3b51d9.camel@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <2f4338f37943c2b067db16ae65c9af665d3b51d9.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::30) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4588cb4c-726e-4596-978f-08da1e34a3d9
X-MS-TrafficTypeDiagnostic: MWHPR11MB1552:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <MWHPR11MB1552C9ED4211F1DC17438C29F8EF9@MWHPR11MB1552.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ARLGIGouowHz7ZV0Uf5J7mXZQtvSYwsfdhqmf3w3htosjtmo6m2L/QKPP2Nna02M0zWZGRYVQtD+Llz1tZRm6W2BqPAYUsoR2bDIKhjrf879fXZjWXViqNoqyoMn7HS4aCSWg4RjFUUotNl7glIoCYog6u2uZjCMMWsLaTNAUFVJfN+EQb/7smUupVC7DYTPAbJUWdEaU2oTxPjOuMD+vuhRxg27FSTxiMQJWhv6gCInpNEL0qPEppw5Y6+1xIzZpJxevJq4MWvbtJm63cPf+uBNENhgKwWSXASJ4WNnSGbYaphU/wRFULiYkKF0Iv6a1ATgqjzburD9EBx/5Ha6c091y6QNbk1KRqX3pjQgI6e5B+WAvR+mzLANNdDT5ozwtfq324mvZvN7apQpcPg6OP7V5avfpWFKX88zEDnDHrwo2cbzXLlFYsuuvPFcg6tQDXZ+a44OUnBuOoFemmlXn4pTuhH0mJIgPls81DnMVrMpx2mq0io18sYQ72kG0aUkLZMARekysL7owinhpAqU52UmevmWHqb1HEy2yFbPZrrgd2UbquyMPQKD4jKihKCuG6FW7rdX2ZXrqt2uT1uVbvRyJAoQAC7MMp9HFl7fv+q7P9uWXa/foTXv/DXOqyLcjgQq9F4SHHRSEjIHBi9IjPOWg/kW6Jlz9yqeVzUxXy95G83ih7DAQHAOrRUfcr6WOHfdgcozDHe9QWe7cubVncD4U4854oentTzrM9VLaOJbB70M1QdvTWjN5eyqkBn5CFL1F6WkeNhUqBydWInuGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(8676002)(6486002)(4326008)(66476007)(44832011)(66946007)(53546011)(508600001)(66556008)(5660300002)(36756003)(31686004)(6512007)(6666004)(2906002)(7416002)(316002)(26005)(186003)(82960400001)(921005)(38100700002)(31696002)(2616005)(86362001)(4744005)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWY4VVU5czlUUGNCK0g3QjZCa0RxS0FjeEtuMm9EQ1ozWTY1bHJvdGJ1MXRV?=
 =?utf-8?B?bDFMSXZIV2JLOGpZWVlTMzlrVzZkOSs3WVlrbGZZZGxtTWoxclRYckZ0SWpE?=
 =?utf-8?B?dEErdjVJM1ZidDVzb3VQbUNxejVRY0pPNlRBb2tkVVpYekYwY2ZhSWMzRVNR?=
 =?utf-8?B?NEQ5L0VnRDdkWEVlZjNPZGtiSHpKTWN2VWRxYkxiRmNZRTZOcTZZK2h6Wmtz?=
 =?utf-8?B?ZGJuY3djY2ptT3I4WmxqV0xSdGYxL2N1T1VrdzA1NlJIZ0UzbUJNb1h1NmVz?=
 =?utf-8?B?THMyQjVNa1F3NGZvU2o4TzZueW1qQ09ZQWhpNnUyTTZGM3RTakJIdDR0MS8w?=
 =?utf-8?B?Ly9zMGJSbU55WVl6U255N0JhOXJxSUc1blRFeW1CdU5sa1FJYVNGVDAzcWhR?=
 =?utf-8?B?a2xyU3BTNmp3bXEva3B0NlBLVzZiR2R2Rm11Z0U4c1F6SHRzRVlMK2VjN1hy?=
 =?utf-8?B?Yjl1WWJHZ2UvVnZ1WWVhcE5DMjNjSDE5ZXhKajY4QkZIcGlsdWVxeVZWdUZ6?=
 =?utf-8?B?TXFvR3lCdXV5SU9NUlRwVm9jWHFxRFVVWkNLMmtIeUQybXo3cjd5aEJkQVoy?=
 =?utf-8?B?dXdjUTdTNVUzei9KYUdLZnJDUlo2OVpLc1Q4dFpIcExLWmVUcmRNaGRPMDBv?=
 =?utf-8?B?UkIxeG9RVU01eTlZQ2x0SFoyVU9HZ2g0aE1BelBJQlVCSlVmaFd3TzJLZjhs?=
 =?utf-8?B?OHhiK285MGcwMkhaTm5OaDcxbzZTNi9ZMzVtNCs0VXlGVkQ0cEExWnlBeE9J?=
 =?utf-8?B?dnNoUm1HV1grTkMxOE9FaCszSE5yL29IK3RRQzZuVWRTYmtNcnlJSnlPcmpl?=
 =?utf-8?B?Y1I2ZEtJL1VhMnR2aXR1c0xiNWMwT1JML3dDaTlYM3czZG81MUtkQk50WXBT?=
 =?utf-8?B?R2trOElTL1hQM0h6MnZJYjhkdlBaTU5pM014RnZOT3AyQ09hNnVzSW04dkNt?=
 =?utf-8?B?TVdldFU2czRrRHpLU3R5N0xpbEVwTk1VcUJsbWs2cy8zS0l2c0lYTlFTT1Vr?=
 =?utf-8?B?RjMvR3N1ZWJTVVY4MWF4L1VkcmljTUVMZjZ0UjFGb0VDYmZRY3AxUjVlTVBT?=
 =?utf-8?B?V055WmZHMU5XTWdSK2JNTVVudkV3TDN3OEEzcUQ0MUREWGxDUzVGWnVLTUpQ?=
 =?utf-8?B?QTRKUXFRZndGQ0gxWDhLdnFXellpUEtrbEU3THdJQy9rVTVGSTUxbWdzaHYz?=
 =?utf-8?B?WHNGdHpwa2MxQ0R0Y040eEpPZjhSUFNka1o5MWE2YnVoVVhoRDNhbGplT0Iv?=
 =?utf-8?B?cmFJQzJLZ0NsV1JDeGtIQTNqbnhZYTN4QjR0VEt0ZHc2eVNLOHMrZkR6Q1Vv?=
 =?utf-8?B?WlJZWTlkdzMrcWpwN2F4WnlTT0NYVEtSdkd2ZURUOXJ6T1I3NVBWdXdlT2hL?=
 =?utf-8?B?VDFHOG15WnNWSDJGMDlodXNBc1VneTlub0ZyQUdBbHl3aWdxKy9YVmdQdkFi?=
 =?utf-8?B?b2xvZlNyUTRQbDIvanZScEM3T2R3b05ybEpFT1BYY2UrcUZ2d1Q1ejYwQW5P?=
 =?utf-8?B?VFJBVWlWaUFaL2R5cmxZRXhZMGNSYXJRcG5ra3hGQ3VlcEFSQVg2bW80Z1hI?=
 =?utf-8?B?eWR4bWRFK2N2M3ZZRW8zUmtSaUtiKzJ3VEI5NHFSbmIzRi9FUDFFODFMamZ6?=
 =?utf-8?B?UDdMUzN5ZWxrZHJRUmFYUzViM1ppVGl6OElFV3ViZjVxQ25EeEZyQnpKbVRj?=
 =?utf-8?B?OURUQzFCVDUwTzNjK0tRVldxb2UxVkZBUWtVbytmclZIbzhVOENHQ0Fha3dx?=
 =?utf-8?B?WnZUNEIzMXphWS9weGMrYXhOQTYvMkoxNjF0RUVmRHpPcGNJSFp6UDF2U281?=
 =?utf-8?B?UzgvMlEwUEVVeCtheXRPQStJRXB3VEpPYnU1bUFXWW1FVjZXdCthcThxQ2lD?=
 =?utf-8?B?NllwWnZUSDN5dmcyMFFuMGQ4MEhyVHRORkZBNTVwNFpodjlIUjcrU0lrUGl4?=
 =?utf-8?B?RWt2Rm8rcXZvSmNkV3hrRWVIbjBvTTdSNXdxUVFiUzNEaEdSVjNic2ZZQlk0?=
 =?utf-8?B?cHpQUkFBaG90K3QzRTNiU1g0Q243ODV5OHcrdUZDTmFpQi9WVmZnUno5SWly?=
 =?utf-8?B?VWVBTlZTUVRsM0Q1TExvRTNUWVNESTMwaXVQMklqbXc5cG5XSGxpLzBIQmxq?=
 =?utf-8?B?V2NvY3pLdkVTU1VhdXVSRDVPMU4rYXc1bDVPdDlhS25EdWdmYlQ2RjVBSWNp?=
 =?utf-8?B?OHBLSlEweTh1YkRWb0trSlNaR2ZMNEdZbUlrdXhZVm9rTWdabWU3Y3BBejlO?=
 =?utf-8?B?OEc1MlZKZk9zQkhRaThWY0F3OEJtamU5ckF6V2FZbHBxSStBN3pGUjFYSTNH?=
 =?utf-8?B?TldWU1o4dWJqUEVFb0l3SGttZmovM09CeVQ2ZTdaVjdYcFFXemtOWmV1ek5u?=
 =?utf-8?Q?X2A7CwY/KZ3aVQLk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4588cb4c-726e-4596-978f-08da1e34a3d9
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 16:34:26.4612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yz8uuUST4ckVrVUH7Jd8kh8KZTdK2v+syaXkSB4CYpi6Kpbr9N3DIPzrIBRWtBImk9nK7GlFgrtxjmhXtVLdded4KF024o1n+ZbigZ3nqNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1552
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jarkko,

On 4/14/2022 4:25 AM, Jarkko Sakkinen wrote:
> On Wed, 2022-04-13 at 14:10 -0700, Reinette Chatre wrote:
> IMHO, we can pull this after +1 version. I think I had only one nit
> (one character to a struct name it was), and I've been testing this
> series *extensively* with real-world code (wasm run-time that we are
> developing), so I'm confident that  it is *good enough*.

Thank you very much. I am aware of other teams successfully building
on and testing this work. I do hope that they could also provide an
ack to help increase the confidence in this work.

> 
> Reinette, for the EMODT patch, as long as you fix the struct name
> you can add my reviewed-by and also tested-by to that patch before
> you send it! It's so narrow change.

Thank you. I will make the struct name change and also plan to
make the same change to the function names in that patch to ensure that
everything is consistent in that regard. 

Reinette
