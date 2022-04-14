Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED06501942
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Apr 2022 18:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239898AbiDNQ7J (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Apr 2022 12:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240792AbiDNQ6s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Apr 2022 12:58:48 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3F7193;
        Thu, 14 Apr 2022 09:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649953951; x=1681489951;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MjqsHGWeRq6+7tUpMtFKaAyK/wKVBEWhhe63FdSKCDM=;
  b=L3Fiuh/cd+EkRWjRqZGGxyocUuu6oRmzjvZYqQkMFSG6NqcGzYf5WCgV
   IICV/dcRV06eNaswTlHMChxSSMvUwl1GuubnhUOjzXwn7pHxGhwyz6uh0
   E4T7s913Jk6KJtnO34TxH9QMrd4uvsTrXw56t7u8z+4ANvdAWeh4EdOa2
   eY7EWQ0kBkvp4SkG2RfZGZ6HJEFe0Py5958fHaF+DqkV0JtOkCPKSqsGK
   cxaacC/o6lDEypEIKszo5W3bqBhJLLwc1fn+hTAAmyBMAFRDGzpM+tvH8
   RjD5FBavOx5e5XSMs6nLO7r1BVr2HaG3Yx5wNMJ/szD8uHihUi/OOHIZO
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="262416025"
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="262416025"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 09:32:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="573877077"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga008.jf.intel.com with ESMTP; 14 Apr 2022 09:32:29 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Apr 2022 09:32:27 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 14 Apr 2022 09:32:27 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 14 Apr 2022 09:32:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ed5iwbcPdjQ2ipZr03JcfSiZgNpEQfLzp9tMkG5FCicKahEtawTxQPTBYmNJTGYjKBsXkK88DQRCXfCHNkyw40uDxFbepj5qCw5At3HzpHSdhZhOZLm2GQY+GmR/xVzZUNi/EdO9Dywe4kciGrGFwfnSdH5ykBXLxwB1gB6MBXVHbEQkUWpId35Bc/QQHxKCB9s6P1xekhIgHCvb6Mc5ifZqq7ijhYGzENznXxgGRxnv9jlOPuZrZMY8Ph6haSnPrDQ2D3rQ6jHcIBDe3kUvMvm+jOmzsxSZ/soYXim4fx80wLYio4iQIkr/U7F2NnT1ohcFydifEAyNKe/jRMNacQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Zd2S7PVabFyvlhbc5MtVXM7m1qI/vLjAK5fk+KHuZI=;
 b=Nsfabd/XW5KZIemUjVHl02ygHCp4tCE+7oAHWmWu8uZ58vDiIRSkVEqLwXWvkoCpMzv6XfWGCquB1vSzoSNmnlw3PSFS8lYuzK9t2PWKyzO16tBtpT8pACPv1+WdDSUnUKsohG2YxPSA70NUapkW4or/zFZ2iKWgtbOKAj+IqAV9InYVeZ+H7ibyBqBKaxSiUqxIQWDwG5yk+Fvks1/22a8l065W66XTeGuMoq+EBnLWa8NUFdtw6nus8SANQm5qD00ezWBNX90JLK+nxTguspNEyvk7SogAwQDUA8iiTy41TCJCCnUUAtHRXrsiem6xh78EI0rDTz2CrvgcbkTIMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by MWHPR11MB0032.namprd11.prod.outlook.com (2603:10b6:301:63::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.30; Thu, 14 Apr
 2022 16:32:19 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36%2]) with mapi id 15.20.5144.030; Thu, 14 Apr 2022
 16:32:19 +0000
Message-ID: <4b24f781-7571-fcc4-1ba9-e77c3eaca3aa@intel.com>
Date:   Thu, 14 Apr 2022 09:32:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.0
Subject: Re: [PATCH V4 18/31] x86/sgx: Support modifying SGX page type
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
 <bd6442f4b0d5bd380664a9e5abaf41637cb298f5.1649878359.git.reinette.chatre@intel.com>
 <a152c99f80d1e12b0ab0ff1882a4dc0da3950423.camel@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <a152c99f80d1e12b0ab0ff1882a4dc0da3950423.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0167.namprd03.prod.outlook.com
 (2603:10b6:a03:338::22) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8275edae-818b-4305-f2a5-08da1e345836
X-MS-TrafficTypeDiagnostic: MWHPR11MB0032:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <MWHPR11MB0032776E645BC700731216F6F8EF9@MWHPR11MB0032.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 92JXj8YXL6DFg33eFPHX9eG/+r2t5PVfAyrfycTURFYFZI3L1wjn5f9UnFWEG3nUSq/iWRPy+rP/7yTz72ngR/wQltzHAjD7QZTP/m5yRjTfa6Ez3vDvy+Ln4rtoDtf8nn7G6ZdATUgMsRUrtfF196nn2eJXVSMi+OHe5xC7wYW6RblyP9UM5Gaa1aH+WQ1g4JSslNHLzgU8+yDB167PuprQBXiiWpuOBjDddg8ZnbvBcFYBQqI2uigk67Ta88EsKxLmhHDJLkYxpfqAkYLDCzIoRNV2MIlZquSWpXs2mRXcES6R/q56RPMhn+YWWSlKzEI6m9m14+ESRscU+nWQhygBumLvcXcQn/qMUc0OdpuvbVxqeteUyq4732EqRI5zKyj7VcXBmLG+nBFZ0DUn7fHZ6Aya64tede8LrFn+00MexyM/o3WeSR/zGwWQyyLNvUwJp2Lo2hN0KEeQz9wQNgrhdtB/IZbpPxJYy4lz/cIqs4NepiHuFGphu3JS7q63veoeYgwBvZYeXym3h3XLyz8Jcc0UNHHOBRDe7O5ECrBy0WWtloCn9TTgefTZ9Z311um0XLhyGK0OIUvV3nQGSrRZkIwYXVVhldo287nI8wzjHtnKAxoay/U+ays+Ep1BU2RpcNysU2U9L9cFbcgCweyWFWAedxtPYdAk8/nybKohR6WHJJ8vGdkYqLYkIg8iq0DUWscJZWKANl4pmkbkXu+mj3hC47dmY+0CUzOpabjziU6ODO51fTDttVrIz++XgFA89ckivR3Tuk0+kwVeCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(6512007)(2616005)(4744005)(38100700002)(26005)(86362001)(5660300002)(44832011)(6666004)(53546011)(6506007)(2906002)(921005)(8936002)(31696002)(6486002)(82960400001)(7416002)(8676002)(36756003)(316002)(31686004)(186003)(66476007)(66556008)(66946007)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnNWNlJlMTBQbHU0YXMwdmpBWGNCWERITWVxMHBIMThxMTM5bHdibmF5K29i?=
 =?utf-8?B?VzVmRWNlQXQ5MThuUyt0SGxhQUwwTnQ5TUtjRHNCSmM5SGV3UmtRTzBUb1Vj?=
 =?utf-8?B?OW1VMlQrNHR4R0FsdEhqK1RwZzQrRUJDUjEzeEg1SUNSOHhNWHFXUnZ6T1E0?=
 =?utf-8?B?NGdxKzdvMHRseFhYenFWV2k3bzk2dFRySEo5cTZHMGQzRTAwb0lIYUhkczlH?=
 =?utf-8?B?enk0YUR4VUNNai9xRDcwSUI3VEtsMkprTEcxREk3QWRiWWcrMTJ2dUJlTzd5?=
 =?utf-8?B?UGY0dktYS3RsSDhpUWR5cXcxV1lORC9KZTN1WXNFY1JlQkhIdFRzTnlhQktB?=
 =?utf-8?B?QlN6UHRhL05oTThyY29haWFlbDYxZ0wzZHdXbUNVcm9Lbm40SE9JZklIeldu?=
 =?utf-8?B?NmdTN2hhSkxzZzFwT1Y0czVldHZaVlFCck1mOHBEK2w4b2VuTkEwWi9ZVHd1?=
 =?utf-8?B?b1ZZQjJueHhlcHVVeHNTUU9sSDd3Y2dETHJyZCtWcHJLcFlrczlVcjFQeHhF?=
 =?utf-8?B?ZDZpWmZ1WDFvWDRTZU82TGcxUDh0bFRNZnludjk1NGVIYXl6TWhvTjVZYkQ1?=
 =?utf-8?B?clBOSDFTemJzL3ZIa3NKMjYzSFlaVVdQOEUwcXljNlYzbzFHWEFrWHZDSnNv?=
 =?utf-8?B?RHdKQlRaVlRqaVlWZzM1YXZpcjl3YzQrQURtU1ZmTDdDZjUydHBiZ1hDNUhL?=
 =?utf-8?B?RWtOc28rUnpNNWlLekNnR2QxNEN6dW01UmthbG05NlRXK29PNlBIREN0V0d6?=
 =?utf-8?B?NndERWZtS1pyS1k2YUl3Ym9SYzFyenJTa2FGWVJiUkVrMjFpSDVibnJQa0Yr?=
 =?utf-8?B?eGlTaERCK3lyR2QvR2JkYjlscytwZGFPYkdERE1PdlJtM3JMRFNvVGRWMldk?=
 =?utf-8?B?dk1sQytzYTVmZzh5SDMzY3EyYUNwZHBkYVlkUUlIM3J2UzhuMVBUenprM1F4?=
 =?utf-8?B?YjRPbzAwWFBsVnpWellNdS81ZXJPQWw1azdKVU9PUE5sZkc0cXlVVjh2OVhE?=
 =?utf-8?B?azhSc0dKcWwwV21qQktQemNiTjRRV1BMbWw4TWhqU1kyMFdvU2FTWDBWUVA4?=
 =?utf-8?B?ckJDbXpFbjcxZi9uV3dFbGVGK3lWSjBDejdHcXlVSzJaM3lmdnRJQ3NGZzdu?=
 =?utf-8?B?ZlRZcGIwS3F5d280R1V6UHdsMUFsNzFVSUc5UEFpNmN4cllKTVk2L3pvS0Rj?=
 =?utf-8?B?YWM4RGxCOGVUNzJwZXZDazNIVi9mT3hFUzVVS3BlTjZTdFpzbndmRHY3TlUz?=
 =?utf-8?B?c3JjZVFmYTBicktIV05Jc2pDT3cvSGxyUDlvVkNUOThLTnVqVmp5OC92RXhF?=
 =?utf-8?B?NEszcjd1UHJ6TFN4aCsvMUxhUzUvTndvbmZaNXpMeXEyRGszVytBQ0lPNzlz?=
 =?utf-8?B?SzZpYzRhTDJUWEs2dy9iRGZUc1cweG5ud0RXQWRFYzkrLzljcHE3eTRENzNk?=
 =?utf-8?B?Y3kvSUNYditkN2h4YTlvL0c3ZXZWZDhCN0RFczMvMHF1UE9SRnVFT3RQZWQ5?=
 =?utf-8?B?eGJOUFBGVEhXUE95UG9TVkVkT2hDS0MvRWcvOURMSkdLbjRIWUlocUlXcGx1?=
 =?utf-8?B?TjdNdWo1NTB5R3dpdkNpRThGbGlmTzcyZkZQSWkvaWE1MFRkaXczS25NbnA4?=
 =?utf-8?B?YXVYbDFVa2p4alErUGtZQWVYVlJHS1N3UWc2LzBsRStJOGt6OUVTKzJlUUlV?=
 =?utf-8?B?eEdTY1JwYkVxMmpEWU1vUGZCclBnWTJxSlNwemk2RTZQQVFsVjU2OFhpM1ZD?=
 =?utf-8?B?emRPNFhHUTQ5RXU3djlTR3BkNFV6eTZHVmt2c3IwVXJ4NFpob09VNy91NWJR?=
 =?utf-8?B?bXF5QVpMa1pwb2dJdWhZc3BpZTBUMHdaMHA4MUZaSlhGVnRNaG1pZGQxL0cz?=
 =?utf-8?B?cXltTjR4Z0hTRUJKU0liZFAyb0NGM0c0b3Q3alcxMVZIOGxXWkxLWEhUcVhx?=
 =?utf-8?B?MTh6YU5sM3BYOEUvemJYQXlrY3B3cHBFMm1LbUEzaisrUEkzcjVmeFZGVmd2?=
 =?utf-8?B?SnZDUzVEZGFBRWNKRTVsYURPQUhHbUxOQmxIRDdNc0pxVlFWazJWdHk4UXZr?=
 =?utf-8?B?S1ZMRUZIUXA1R3VyeFBXT01ZTDJ0aWt3WS9RWkJVNjR2SVlkWmxSMnBZK1VW?=
 =?utf-8?B?d1J3V2lGQUN0TnF1OFhpQ3JSb3dSTjFETlNTZVloK0lhOVB5bVdEcEJ5aHRr?=
 =?utf-8?B?WEo0ckpNMVRHQlZMaUxjaHFlMk5Rd2JVcFRUdE9aUGRkZHI2cmZ2S0ZlZHpE?=
 =?utf-8?B?NWlSS3dOaG8zWEtFeVYvRE5WdjlMdnBYZ1JIVmZNMjQ3R29oZ2pYV2srd0p6?=
 =?utf-8?B?VmZkenBBOG5ieWZOVGZEa2xNR0thd0MwSkNKSjQ2ZGsyYVh1U1NXNGlDWVhB?=
 =?utf-8?Q?Jf6omX6Phjybx/VE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8275edae-818b-4305-f2a5-08da1e345836
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 16:32:19.5504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lXkt7R57sexYxkF+QrXYhwOOE3b1HbwsqSwunHBhwlqMJnN5hLV/kgkNG/gy/sGCMJLhnAerHoS9xiKpFqd4EjfLlzPA/DGG23Ovdlb7eSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB0032
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

On 4/14/2022 4:11 AM, Jarkko Sakkinen wrote:
> On Wed, 2022-04-13 at 14:10 -0700, Reinette Chatre wrote:
>> @@ -97,6 +99,23 @@ struct sgx_enclave_restrict_permissions {
>>         __u64 count;
>>  };
>>  
>> +/**
>> + * struct sgx_enclave_modify_type - parameters for %SGX_IOC_ENCLAVE_MODIFY_TYPES
>> + * @offset:    starting page offset (page aligned relative to enclave base
>> + *             address defined in SECS)
>> + * @length:    length of memory (multiple of the page size)
>> + * @page_type: new type for pages in range described by @offset and @length
>> + * @result:    (output) SGX result code of ENCLS[EMODT] function
>> + * @count:     (output) bytes successfully changed (multiple of page size)
>> + */
>> +struct sgx_enclave_modify_type {
> 
> This should match the ioctl name i.e. "types".

Will do (and also the function names).

...

> 
> Other than that LGTM

Thank you

Reinette
