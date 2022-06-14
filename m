Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9312054AC9F
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jun 2022 10:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241884AbiFNI5c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Jun 2022 04:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbiFNI5a (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Jun 2022 04:57:30 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC8319FA0;
        Tue, 14 Jun 2022 01:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655197048; x=1686733048;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b5hLXTac+jrKZQH4ADEird2K80IKgrHmERqu5UTmzR0=;
  b=fqgi8DtYWKHJdWFywhcMN3U+Yi/xB3IHtkeoLxa86H4z5/qglyecPXSG
   7X9CJdB+gMZ8jEu5hOK8INtr5ETyvGQ5A5Q2Fej/sLzHZY+0KMYowupCW
   /3jjTpFUm2LquhwPRKo0vFK2hRCqVONAHaGKGvNfkMN9EOBTebYGwK6hj
   u5H4GsUTUvAhB7GjQnOhLxO5Cw76o+oIHleNT8oyOSzDUBKZXG7TxzwaU
   hNMrtff4W9gZDSfRnYAWQDp8JT/eGyT8cV0uL9R3z5VVO/3R+PsphfBT2
   yrRaC4tbP2ltwz+0ld9iRcJcOhQJdt3/8z+JavZOrsLhPdmBWiodEG2Ec
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="261587870"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="261587870"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 01:57:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="673772663"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Jun 2022 01:57:27 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 14 Jun 2022 01:57:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 14 Jun 2022 01:57:26 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 14 Jun 2022 01:57:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwWpCjn/l1hsOq9kh6ZJ/q10MOHXSaocwQPuTGVjHQ2JkVQk7ZxCGEIHgg+kqiRxW+Bsqh5kUW+1MK+RQWLreQ64K8RzyYUFqEj1K/Bw37T24OJiDUzNKG1JoXW5q4e8Db9dKlMFHn8MvOqrMPlzdI/Bys7b0Qpa/tnpkbsR9/A4Nq6rFZI9H2xm2xysY+Krfg788CL69ZJxQDUd/sauiYOuFBb0BoA+PWKdHHQalp55iGOkbhmirlqz+x5+mWNa0u9Qh6jqkp7JR5Hs/5bEF167VsMjvDJKNoDA6KtJICUlsVqRmAZJlVK7tLnQom9yLLEs5OyjRuIJWGhWaKbnwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZA6EBy3K8xA9PZqfzw3mgVtkoj1/D7Frl4YzpBH3rEI=;
 b=fC55HQznmEGm9vfj0IPl+vBu6ZJPn4Y2dplqhav2FBAOo5EcEz2gBjGbUV9/+If0pZGB/kL22uFpcB0NPDKlB5Rh+yzsKEvauDlnse26xxscYLzYhJGgmG/6fkJke5s/AQZpWANQQHUZY2SdaduTTrFFOmdUX5VrOyadLZDs9Sa9A+JG1G6PweharnNi/VHFb3CDK7fI+LqalUcsNCQYEZ53s4tUrkE3VFcYpGmWUtuE/9OAaV0wbEj9W2GZtduk1zuV1aArbgZ8dPr3H0yBcSF5M0EdpIfUQ2KHJ6me3lfCF8ldCmSdO+MeQuGauICcisNvTYAvzGViLsFcQr3zjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3870.namprd11.prod.outlook.com (2603:10b6:208:152::11)
 by BYAPR11MB3144.namprd11.prod.outlook.com (2603:10b6:a03:8f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.19; Tue, 14 Jun
 2022 08:57:21 +0000
Received: from MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::e819:fb65:2ca3:567b]) by MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::e819:fb65:2ca3:567b%6]) with mapi id 15.20.5332.020; Tue, 14 Jun 2022
 08:57:21 +0000
Message-ID: <ed9acc40-00eb-d2f5-f6a8-bf09cc8493ec@intel.com>
Date:   Tue, 14 Jun 2022 16:57:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.10.0
Subject: Re: [PATCH] KVM: selftests: Remove the mismatched parameter comments
Content-Language: en-US
To:     Andrew Jones <drjones@redhat.com>
CC:     <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oupton@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Wei Wang <wei.w.wang@intel.com>,
        Peter Gonda <pgonda@google.com>,
        David Dunn <daviddunn@google.com>, <kvm@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220614224126.211054-1-shaoqin.huang@intel.com>
 <20220614074835.qto55feu74ionlh5@gator>
 <20220614082839.a5iqpk4td2allbwu@gator>
From:   "Huang, Shaoqin" <shaoqin.huang@intel.com>
In-Reply-To: <20220614082839.a5iqpk4td2allbwu@gator>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0248.apcprd06.prod.outlook.com
 (2603:1096:4:ac::32) To MN2PR11MB3870.namprd11.prod.outlook.com
 (2603:10b6:208:152::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b40af874-a667-43cc-1735-08da4de3e47c
X-MS-TrafficTypeDiagnostic: BYAPR11MB3144:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BYAPR11MB314476157891E2FF8966CA15F7AA9@BYAPR11MB3144.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nos7LDzz1v+LU8YkqJQV0Q8UYwWuSvopcmh26nXeJUiAsI61VDaYpFWiRWuPM98BKKAI7CMrpfqC9WtU4ODRM5C22UfNtq/06KH1jdmULKv2GfotfIJCjZ76qM3d4TxOsnNWEI1rS2LQCMU98Z2ZJnWTAG1ULGW1gqTTqnKv1NfHF/04bgg/5U5RYVuEYjjSrk5mM9NeRX+kqEcZLQ1FIxKQrpziJB+pIl8UImiuGLM7UH7A+5Lh78GDEPtKgbY8efvdQB8Kv767PnheEwbNd6AogOcqtnjfzKAMkHV6gRJzcagjjPzfYJgrT6XPkH8veZEeH8vVGmaYLNYL3YfLYoZzT84J8XHDqBlzHa8vN/YnsKcfVbvjip5fgPsXYtm0bDTcvAaa8P30KAWJNg0pqF0Q3cZq0Bu8Ks2Ejx5C+bmMrgRVAIMiJ2h8l7puVHuz8A9gWxtGyYaDNcY1rI6nD8wcB02uYh1f0d4vma3Vn/9LZVB3QJ6MEGZgtlCcn5LoAREoWrPfMsQVKSDM5xe3gXDBJPZE2vBw+t4/FKdY6BMmm7u27rrh6cuia3b4A5oJGw2V+Am0gEj5U/RcJeP0MUx6JfTkSERbRxF/+fWkU1nTfAyomnfH+6rgYicGolgtfWzT10eooJLd6FBGk2vMu8ENl2Dp+to2G/Z1AsJTXj/ATopFdbL0d6d7oQ81ruSPekjEG/IhqKg39S6nd7g6q/xxJqKdB1rmKKtRRZzGNnQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3870.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(86362001)(31686004)(36756003)(4326008)(8676002)(5660300002)(8936002)(7416002)(82960400001)(508600001)(6486002)(6916009)(316002)(2906002)(6512007)(66946007)(66476007)(2616005)(54906003)(66556008)(53546011)(6666004)(6506007)(31696002)(83380400001)(26005)(38100700002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXQ3bk54V2lWY1RTbmExUm5iRXdyRkV4bzVIdHVuQ2ZhRk5KVDZKd3RESmFy?=
 =?utf-8?B?eWNqU3FMejB0dnBmaGdyN1pId3M5WmV6UmpuVUw2QjI0SzBpeUx0bmdaMVhs?=
 =?utf-8?B?ZkFHTGJ6dzVFTXVnYU9VTmhiOStZaHFtTkNIVmZGM09aQk9scUJ4bUlhc0N0?=
 =?utf-8?B?RHQyK1pyREdQcEUyclVHdUJhdEZEQ1VzN1JiUFIzY2xmaitxRnV3NmUyMlIr?=
 =?utf-8?B?ZFhIa3FKQ0hncDg5TTh4SzFzZFBUVFViT2dNL05BN3ZBLzhTdmlHVldJMHo3?=
 =?utf-8?B?NEwrVFFSUXBVOFlQamRueU5uN0EwN2VEMjdvZDEveGxEdDZnTzNSczRoUUx2?=
 =?utf-8?B?LzJYVE1WVU5uSEdhVzZQakowbDBGQzVtNFdKUUY3VGdCVThRa2JvcWNzaGxh?=
 =?utf-8?B?RDBYcnV3WngyYWw5Y2FQVDdEZS83b3FHK2wzWk9jSndkaGJRRG5vQitDVzUv?=
 =?utf-8?B?TVJlN2h3dVZBbEQwU0tGMmRGMko0RnI1d0ZTR1oxaVhNTmI0MC80NXFKcEhv?=
 =?utf-8?B?OGM0VTN3Y2tMYzhHak9kbTZ1eXBLYkhmMlZZTkZLM3pGcWtHSmpXNWt3Z3cx?=
 =?utf-8?B?S04xRURyZU9oT0tHT1lPV2xhWURrWkk4QmsyZmV1RTl2THRVMVRnUTlTN2ZF?=
 =?utf-8?B?TlE3eTZKM3hnd0huaDg2blRvL210SlBWZWgzRE5JWXpRazkzUkxkZ3VpakFk?=
 =?utf-8?B?OTNCN0kzTk1Ya1RWRFFqQlF1cmVvNThqWUg3V0ZCTW1VN2hST3I3bDAvdXdp?=
 =?utf-8?B?NlpiUXpwL2dEaDZWQU14cGgvbElieXhuelZ0UUVXYWM1eFNibDM0a1RiUXEw?=
 =?utf-8?B?ZGJxTk5mNGFJQ2lGYlU0MEpxRVVNeGZMYWZMOE1acHYrV2l4WWw1SWp2WU54?=
 =?utf-8?B?Znh3N0ROWGxaVjg2clJkM3A4MkNTK0lVMXpJY2w4b1h2TFRnd080VnFjdmkx?=
 =?utf-8?B?TFZaUnlCL2JobnU2MzVrN09IVHFQSTlFejVVWVZlM1QyREwxTFFZSmMyRXUz?=
 =?utf-8?B?bzg3dVk3Zy9DZ1hrMVhqZmx2bUV5ODd3a0dGRTR0U2d1YmNldVpOcXp0Y291?=
 =?utf-8?B?UzQyQTl1VHFXblM0ZitEczEydFo3UHJBcVlOUE9KWERkbElpQjUveWdjbmhr?=
 =?utf-8?B?TlZJODJ0MTNzanByQmo0WFYrN1p0dGNTS3ZEZWdrWmlqWHlBTjRKb2lWZWcr?=
 =?utf-8?B?MWJESVNEVGlFeFBZempGZWZmeWNRSFpnV3FScTN5Y251bHlCVStWUzlWakhr?=
 =?utf-8?B?TENVTTM4VXFyQ0lmQk5HUXhKN1p0V0ZBdUV2eDV6TDVaKzU3RU1TM0VzTzZS?=
 =?utf-8?B?SHdDOWpZeTExZXB2WDQ1aXJiV3k4enpKSVBydm1XcEhJWTBmZDcrVitCNzhi?=
 =?utf-8?B?QUc5QXloanlsWU1wb3RibFpIbXByTTJ5SG5SYVNwUlo4UkcyUHZETEpzNllh?=
 =?utf-8?B?dDEzSi9GMFpBOUNNYTVnaTJnQWg4UWpBY3NVeVNoUUUvVWJ3d3RkcjdCWWJN?=
 =?utf-8?B?VEprS3NIK2plMEFsTWhtNnV5U0NtU3c4eDJ3dU5OMjQra3VER3Zxc2JqTUlE?=
 =?utf-8?B?OEdpYlJwMW9ORWJHRUx0V1FQeDUyNHdCSmgrQmMwTHJHZHlQWVpTL2Qxa3Br?=
 =?utf-8?B?SWg0MU1uOUN5eG9LbHF2VG9tR2ZRNDBySGJaYVJhaUJRclIwMGlUbzJmaGYx?=
 =?utf-8?B?V1JaRERYeTQrQy9OVDZUbE5NUm4zWGRTUXFQU25zTm4vMTd1MjlEcWNpejll?=
 =?utf-8?B?WTFwdzZncTl0VktjVjQ2eVFrbGM3c3BRZ3pmaFhmaEw0aERSYUF5a0gyaU5M?=
 =?utf-8?B?aVRneXZiUDJIbUVMZy9FdmRVeWR4N1BDc0drVitXeUNXK0VPcDM1eGIwSXZJ?=
 =?utf-8?B?a3lOYytmckFLWlN0TFJKNU4vUXBlU2xMS2VwVHFwa2VVN2hDa2VDbUlSd1pm?=
 =?utf-8?B?QmNFYXpDbkNnL2tTVnpRaVE3NTV1dFNOMDF4Nzlsc2pCYUR3Wk5JQlBCUStJ?=
 =?utf-8?B?bllTQnliUFl4cEVPUmxZYVdRNXpRbEdyQUg0elFhYVJDV2VETk5hTEN1Tk94?=
 =?utf-8?B?REt0ZmV0Q05iQ1ZXUW5YdndHOGI5MEoyTjN2ZUlEcXNjYmsvVHhjcFpBcDNz?=
 =?utf-8?B?MWwrSzZHaHFYNFFkMXpCNnA0ZEhwS1BCUVgrTDVJbTFPRVUzekdaUE41eHQ4?=
 =?utf-8?B?Qlg3VnB3QVNCaSs2UDlEL0VoaDk5VWFVNTRtUTRHaDBXcjRRa2lTU0JVYkx4?=
 =?utf-8?B?cmxJWVd5SEJDekxROVo2aDloUlhHdDBkUDFxdUxoV3VacFJUS2JaYzFBU3hK?=
 =?utf-8?B?bGVYeXMxWWx2amFvbG4xR3FMV3VqRDF5UG83RXFtbDEwdzRhMERjOXVpZkwx?=
 =?utf-8?Q?tX1fGpYHEhmXrfJ0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b40af874-a667-43cc-1735-08da4de3e47c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3870.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 08:57:21.6348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: svZRyrOgm9SQejX7YwtxpuadIo1dSZtHfYw27TyjWidEF01ZEKWKSOmiuHQujAusnu2pM/BCe3PRAvc9AQVCUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3144
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Thanks drew's review.

On 6/14/2022 4:28 PM, Andrew Jones wrote:
> On Tue, Jun 14, 2022 at 09:48:35AM +0200, Andrew Jones wrote:
>> On Tue, Jun 14, 2022 at 04:41:19PM -0600, shaoqin.huang@intel.com wrote:
>>> From: Shaoqin Huang <shaoqin.huang@intel.com>
>>>
>>> There are some parameter being removed in function but the parameter
>>> comments still exist, so remove them.
>>>
>>> Signed-off-by: Shaoqin Huang <shaoqin.huang@intel.com>
>>> ---
>>>   tools/testing/selftests/kvm/lib/kvm_util.c | 3 ---
>>>   1 file changed, 3 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
>>> index 1665a220abcb..58fdc82b20f4 100644
>>> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
>>> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
>>> @@ -1336,8 +1336,6 @@ static vm_vaddr_t vm_vaddr_unused_gap(struct kvm_vm *vm, size_t sz,
>>>    *   vm - Virtual Machine
>>>    *   sz - Size in bytes
>>>    *   vaddr_min - Minimum starting virtual address
>>> - *   data_memslot - Memory region slot for data pages
>>> - *   pgd_memslot - Memory region slot for new virtual translation tables
>>>    *
>>>    * Output Args: None
>>>    *
>>> @@ -1423,7 +1421,6 @@ vm_vaddr_t vm_vaddr_alloc_page(struct kvm_vm *vm)
>>>    *   vaddr - Virtuall address to map
>>>    *   paddr - VM Physical Address
>>>    *   npages - The number of pages to map
>>> - *   pgd_memslot - Memory region slot for new virtual translation tables
>>>    *
>>>    * Output Args: None
>>>    *
>>> -- 
>>> 2.30.2
>>>
>>
>> Hi Shaoqin,
>>
>> Please check kvm/queue, the extra parameter comments have already been
>> removed.
>>
> 
> Eh, never mind, I looked at the wrong functions. Your patch does indeed
> apply to kvm/queue and is indeed necessary. Sorry for the noise.
> 
> Thanks,
> drew
> 
