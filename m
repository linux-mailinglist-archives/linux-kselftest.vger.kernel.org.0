Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A08054A1EA
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jun 2022 00:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbiFMWFm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jun 2022 18:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiFMWFl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jun 2022 18:05:41 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAFD2B27F;
        Mon, 13 Jun 2022 15:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655157941; x=1686693941;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kfqQdWnf8nyGKmbShbH1jqXSRauX6cTReT0/HMkfsR8=;
  b=DB2grbv2a66FGh3sN/KNWlxZ+i3pw8QobhqhF0Ve8QJZW4zuRGJsRlO7
   31pafMvg1WilufMbZeybNrhK1laRhEr9wkcFwLR38p8vEba7ca+oEX+TT
   gT1B6iozSXYu+3jrZi+mYNc+T2q6nGA3/D42zmYzrUm0lQLwMpjt9jOGV
   X7Khk8t40b5Xu4CjSiqv3C32OYwSefglwXrYPwQ+cHWnyFehE1pk1vtlI
   93B971mrXGExxSDvbMJgsAg1fJ3sQtda5d2T5I9lqVKzuixU7zURn06lF
   kF9JuDNIZwWlNJohaFGv2l9kKdRSD4obSNkfvHmEUnrLUVwA0+AFzHyKZ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="364755169"
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="364755169"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 15:05:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="726475615"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 13 Jun 2022 15:05:40 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 13 Jun 2022 15:05:40 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 13 Jun 2022 15:05:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 13 Jun 2022 15:05:39 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 13 Jun 2022 15:05:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZajYrBppHv+DXyTsjELokrbMnmn2W2j6lIC5IP+9JlgXMXphpocZVjyujmm152nGdkpMep4R9tGWlTL4bTCaNwFWJ2TZ+NT/6VFMFKmg1Bh710SzxDGFitmmFPTM9Bp7Dt4DKxHfSgdLDZteoNemLynJPB2a0lJme/uzvWC39ZcFctZZpvdsUWsFH1b4p9Hv6BeOTHWArcfXD5gOl1P+KfU3Hun/wv2R6FgDWlGzuoHqUeOuNigzWCojx2EfDsMvU3A0BVgTTDrYR8BnuZr3vcQTtd7rhEdJQvofeUFpvGZqGOwtfdSXOsoZkw71toSDpL83J/lPAu4J8TyJYsJlJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4/fJH8U7c0osbyonKmjt7NGcwIKFuupZWWRS/IMlG0=;
 b=cii81jrmete3V/shLN0F3yz6ySUucoHbCCpYkHjE5I50AWN5sCpc9UCa5Gsb+R61/3qvNUKK5WxMAbHkEMyYMLjh5E7BnI4EpXTPSWr7p3s+GWruQCC0skJBHiRkzSyyfzU9APmxIYP6KYV0zk5ml8WoQuKOZO4a/DsdR20b4aa1S4o8Dktvp4fDtkuVDzw2aCklRuyhCX2+b4eh4KujdS3snCQXKxeHFOUnFtrLFJCJy98iMnC/YaFgkAIXBE1HwSifv0Rw55N89Sepn5ti3RKAexBzQlPJ3wdWONVrXnnb2dyFrqn6lk6eOKwte3TuXYESfYyaPCNWVv9IGSGRYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by BYAPR11MB2935.namprd11.prod.outlook.com (2603:10b6:a03:82::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Mon, 13 Jun
 2022 22:05:32 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::a4e0:2e7e:45de:a62]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::a4e0:2e7e:45de:a62%6]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 22:05:32 +0000
Message-ID: <948bc7f4-f1c0-9b79-0eac-df8659b22753@intel.com>
Date:   Mon, 13 Jun 2022 15:05:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH 0/6] User pkey minor bug fixes
Content-Language: en-US
To:     <ira.weiny@intel.com>, <linux-api@vger.kernel.org>
CC:     <x86@kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>
References: <20220610233533.3649584-1-ira.weiny@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20220610233533.3649584-1-ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:a03:180::26) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc619bae-ba1e-437c-758e-08da4d88d5b0
X-MS-TrafficTypeDiagnostic: BYAPR11MB2935:EE_
X-Microsoft-Antispam-PRVS: <BYAPR11MB293574AAF82559844777CE0CE5AB9@BYAPR11MB2935.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8fnE2FD+5/VBPfo5PzRsbhpgaRXrFKrV8OQjaxGTtWjcJkYEFMpnxLoegtsZMgDHjy3QxJZEw3yJFW39CtYIr7lc4P5JwV7/ASJ28yUAe9DEhVjRxq73oBehp21LNM6UV+HNnxPuJ8Flde8dBeLdB3kFUz39bWjKJN6S1tN12VQSSCBmIOTuJB1dvxnwDT2xUH88xOXpUmbinJCYcGz5Vx0JM68/5bqiVCEPqnmkOAcobBEIJTlo/4Qj7uL7j3+h6SgwVILz7jlOVBWQO06JryjGoZwhrJCwhVIw47IeFkSI2f4xE/HvebSn65W+rcgwQ4ZOrbbmkndzcI99YfDToSto0+sb/SxVgEdrNrWBkFCI8MqQN71oeQrRtRYeKdrAKkrWbkPGU0GDkDw1hKQ3xW1nhmd25tUZxz41kUokqtFIUYp3kDROfc8Zot+QRAsQpjDh2GuLc/i9wh/AE7TV1orFDXu5i/BAG5vxYA1vNVmPhFvCCtIn4hSc58vayBxTMYd3MailBaf56SvoWEnik1z+CM9ZR5sgjyTZVCD1AFATx4oqDfyO3mkgHapUVtoJ0tCqxOQcCrg8iZXedDJyBUF+BVdDJ8yO73mJt+J5h1iRlHD2/pxRgn30UY8c7D5ExkFt+SMxFkn29vW1e46y3KMvwauiCncbiKQEvqje9oj71dRif0LzTF9mLHTHvs+ASawj6zaYYAakv52Oy4GXxjxnSD6HUl/XdtpQvsf2aEw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(508600001)(2906002)(66946007)(6486002)(8676002)(66556008)(316002)(53546011)(86362001)(31686004)(6512007)(6506007)(26005)(66476007)(4326008)(31696002)(38100700002)(36756003)(83380400001)(186003)(2616005)(8936002)(5660300002)(82960400001)(4744005)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkZQcHNJV1lwRVpXZW0vWW5IakFINDhTMnYzWkJpMVpwKytPUWtZcEd0OUhP?=
 =?utf-8?B?N090MUlqdndHVGtIWW1Wb281S2c5VHZJdW1pVkFTUUIzSlN0dk01dnFxN2ha?=
 =?utf-8?B?amRuRXJxQ1k4c3pmQmNOQUlhajdtQ2FPTjZLY0lNbFI2L3E4U29RVEJCQ2p3?=
 =?utf-8?B?TTUxRWhqVGVTOGZlbjhwV2p0V0Q1cFJ5Q1FnaDhuZUw3d3F6QW5HM1A4emkz?=
 =?utf-8?B?QXN6S3lFU1dML0xISGt0WlZaMVhNNG0wS1UwbHJ1YWU2dlV5SWRRdnowbFVj?=
 =?utf-8?B?QzQ4M3pwL0p3TkFpUlM4ZEY3WVFPSlJmdDdnN2VCVFEvN2R4T1dtemt0bUJo?=
 =?utf-8?B?RGl3SENFY1dOMWtsYmhLTHdFdm9MaHp3Z00xOGw1c1dna2Z0QmpnWUxFQnhL?=
 =?utf-8?B?ZlprbkE5eGlUOXhKSVE4MkFOZDRZdUNIWnhyQlA4RHFHcjlOYldxQWZ0cHJt?=
 =?utf-8?B?Z2Y5MVFmdEJJQVY4VHNLaEU5c21iaDkzU2IrVk43eEtTRHAvUHIzOHhNZkNL?=
 =?utf-8?B?WUloZ0tTWW5ISC90b0N2SkdyclhQcFp0ckRMcmhpQ3VDSUpqR0xvTWdVV0NU?=
 =?utf-8?B?dVZrMldzclBadDJBcW9IY1JoNFc4NmpXL1M2cGhBeVRpcEFxREwwMmRscWtQ?=
 =?utf-8?B?SzBTc1RBeTdkS3V4WTRRbllKOXZxZ2w3azBkYWhqc2lMaHVDTThIKzhPK1V6?=
 =?utf-8?B?RTJWR3N0MmovUmJ5QWZubitFV2pvVnI3ZXJaRFVwbGFCeGV1V3pwZUVhNkVT?=
 =?utf-8?B?ZlhMcUpCc2haWUdOdEpObXlnNTRVYm02Ty9kRWxJRDdjVnVrd1BWZStLSzNp?=
 =?utf-8?B?ZU5JaG15QnNmYm1oUG55MU9tamVxSmNveUhqN2swQXFUVTJqQVVNaHBwZGJZ?=
 =?utf-8?B?L0xzSlY1Z3V2VUV6QnFXR1ZNa2pUVU13MXpidVFtaXNETHRndDkrOHhxdHVN?=
 =?utf-8?B?VGM5b0wxSnhJcUgvWlpMTU9wOFhFelEzcFVlSGJWM2lSRnB1aFhZUXZveXM0?=
 =?utf-8?B?dEpRbUVIMjl2MkhseW0xcnMraitSTzlwYW83cHFJYWtIVkw5cHYvUElVbkZZ?=
 =?utf-8?B?M1FDZW9PL2NuYWRPM1pOSGlSMU5HZW5NTTl2WWJHRmkyeGdZUWh6RDYxdHc3?=
 =?utf-8?B?OUQwbnhHNk9BdU9mNVZqWHNpUlhrQlh2Vzc5UzZ0bktienUrYmd5NkpnT203?=
 =?utf-8?B?ZktLOVlYVUNObkVFSzJjZzRXNXVlekN1ZzE3VEVYWG5NVTZyMEV1VXo2U0hE?=
 =?utf-8?B?b003U2FLd0JiTEc3SGFVRkMwaUNub3JNRTFoT2Jta1hPb1RGb3RuY0h5akt2?=
 =?utf-8?B?VDMxTUZCQ1gwaThaTEJMMmdXalRYa3dickxENDNMTElRelVMWXdjQlR5NmFF?=
 =?utf-8?B?aTc3d2M5TzlqL1NTWFlLM0V2eHk3T21CVkVralRQOTMwbkhXdjQ4amtMZ3VG?=
 =?utf-8?B?SSs5WmtuRjNic1g5bkxYa3B5U0NkNUNmdFREdTVNbG9nSWRibXNvaWxPN1Vr?=
 =?utf-8?B?amdZMUlaQXhGZFkwenU2VE03Y1lNa2U4SllOVTRoTW1NTDVvZFJkUHRaYlhh?=
 =?utf-8?B?VE13UFl6LzFYNnhQd0NsSkFJV2VCMm91OU1zOG9vN0FPRk4xVCtZNkMvaC9Y?=
 =?utf-8?B?d3F3Mzd1Tlh5MXNRRE1od2RTTDNCeDJHTFJySXZvVDFsZE5vN05GZy83VFdQ?=
 =?utf-8?B?Y0VDNWVhb0prOEh5RkROeXZtK0hhVnFDajJUYUp5UUVlRVROYzY5T0dUYjJr?=
 =?utf-8?B?emdrZGlzWko1UHh2cVkxY29VNjlZWkQxRXpHSXdMcWtQUmZxRmJTTElLd3Zj?=
 =?utf-8?B?eHhERmFNdlJGcTVUMTJBZndCdUNYbUxLbFEwZ0o1UTAzbi8wZis1U25TM0w1?=
 =?utf-8?B?OGQ4ajg4RSt3RWozVEVwc1dzYWZzeGtLRDM1ODJiMjloTHJBdHhGeXBUTFJm?=
 =?utf-8?B?ZFJxamtrZHBkYzM1c0FFNkZRVjNrUkpzYXVKVEtMcHhsZjFRSzdPeFl5bmdm?=
 =?utf-8?B?cE1FbEt6Y1RQYmQ0bUpVQUlxYXd2L2dTY1JaSVdmbEx0MUoxWVhGdXJiN1d5?=
 =?utf-8?B?STNHcUd0dnM0NlZLT1F6eXg5clFxcDB1R0k2bmZYYVp1WitucG9NcTBnaHlx?=
 =?utf-8?B?WkhYbmplaHZ6ZUF1ak5pcDRtVHdmNlFHOVVMS0dCUzBDUDhDRlBPL29tWTY0?=
 =?utf-8?B?R29idVpvODlCVlVudEwyUk1TdnRUdE81dGJEek9hYU90UXJMbFNLTzBiNGxt?=
 =?utf-8?B?dXJsbWRmYk5EVmR1RTZvY0NSN2JIbUt4SUhpQkkxcExUZWQwQmdBR0tZWjRK?=
 =?utf-8?B?NFg2elFCZ2J4UFZRTC9OVENacHY4WEwxKy9xV0hDUXJqbXMxdlA3UT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc619bae-ba1e-437c-758e-08da4d88d5b0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 22:05:32.3755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: glKFweOdkMjJyP0pg7K2iSXu7Z43FlHsvJx7LR1bvZVpkVfJ6z6S/AWwHtiCsPepCkOERaedan5Lj4uywvpWsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2935
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/10/2022 4:35 PM, ira.weiny@intel.com wrote:

> 
> glibc says it returns ENOSYS if the system does not support pkeys but I don't
> see where ENOSYS is returned?  AFAICS it just returns what the kernel returns.
> So it is probably up to user of glibc.
> 

Implementation of the pkeys system calls is arch specific and 
conditional. See kernel/sys_ni.c

glibc is probably talking about ENOSYS being returned when the 
architecture doesn't have support or the CONFIG option is disabled on 
supported architectures.

Thanks,
Sohil
