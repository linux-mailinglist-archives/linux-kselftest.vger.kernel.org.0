Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E8E59683D
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Aug 2022 06:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbiHQEfg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Aug 2022 00:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbiHQEff (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Aug 2022 00:35:35 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D7E73908;
        Tue, 16 Aug 2022 21:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660710934; x=1692246934;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=o2r4m0Z7ZQVqWFdyWOOig8xLwilADzA0Q/tsySluywU=;
  b=maPR3ZMvMMZX9mZw/vXkAb1FYJKZfr/fLbJjRjKSdefWqDKD5mQS7uUK
   qLJz4hEHxD+aG1bNwA1HAIPy0sHxHsW+8hb+yqH81OxoOFBqw2A0jcn/P
   oNtpsQKmoQZjEjXf6zae+IhyB1w7xRIHJJLDTep0Nuo2JUndot+U7oEjI
   5j/MSfI7zL/nlT6lDA/ffDeNUADsv2puRv5htwLg/2B2ZSMC2ht73KaVA
   rxYs0h8uod7TauFzBRRBzeJpREf7QUvWnGiU/RFxVmaVrgEOWoluHHvPL
   KDRjNISywKL2APAY3Kuhs92AKqinzZ1W0zeec2jCnEGDY38d/qhb/Trrb
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="378688886"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="378688886"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 21:35:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="603761111"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 16 Aug 2022 21:35:32 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 16 Aug 2022 21:35:32 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 16 Aug 2022 21:35:32 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 16 Aug 2022 21:35:32 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Tue, 16 Aug 2022 21:35:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErdyX4q0EjH6Yzq1ENfOpNPHAdJJYxPTyk3fXDxRU0r0OwuAByxGXfmUc4FG31P6tOD67I17M+2WyH1hAo78FrN7N5OXXmKRyIVsMG6uC9ElTFSeFC7vRoOmFHNU/EdKk4ZF6GVbVX/mS5RSUzh3kK1f3ayVbssfAe1NKPaoYbSu4rYjFtq+5jRAjrmf/ov8FX/ka609/sFr7PA9fgZx2+d8YLpr22XXCxBcDto7dTkOaeP7H4k3cSy0L5Tfe6afPrKebFhrslj1G1VRS+FYkr07omjbz6+i5lLMSUJTXYMtUqVc9DcMIQ4Hl04qHNcpI25nfAKixdum9zjm1jQNPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AelVaW66xNhwLNq6OFdFn1frS67fB8PTnn5ob8CyeZE=;
 b=nto/MGktceIj/4mWlI8T0qq2p5iE8odchpJcFkIG7Ya/Jub82woF8VmCz9C6XjhPqJrwFJyTQZxMgln4evj3WLMCCzVxoUh3gk3YxQqzEhBrn9wcsYte1s4OBYWbn23/pw+dOEBCPVsei9z/HXAmviJ5YMTrGfDVR5u/Mqjjb2lgi20SKtlJAf9m5JjLb+afurFJqZ6FqnTcQT7OQB6iXFfS6yaxsx4mnQuwdKkXqbxHqrGswCSCFS/qwIQigMczHcKQTuYx3eRICirnwzUBZk6CRBMVtGBk3eRmCyc5gCWDgyW36C1N/Q7y5utYvnmPRJMu/HrCZ4edf+m6N8fTcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by CO1PR11MB5186.namprd11.prod.outlook.com (2603:10b6:303:9b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Wed, 17 Aug
 2022 04:35:30 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::1cf8:26d2:e93a:9aad]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::1cf8:26d2:e93a:9aad%8]) with mapi id 15.20.5504.028; Wed, 17 Aug 2022
 04:35:30 +0000
Message-ID: <24bd8e42-ff4e-0090-d9e1-cd81e4807f21@intel.com>
Date:   Tue, 16 Aug 2022 21:35:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [PATCH 2/2] selftests/sgx: Add SGX selftest
 augment_via_eaccept_long
Content-Language: en-US
To:     "Dhanraj, Vijay" <vijay.dhanraj@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
CC:     Dave Hansen <dave.hansen@linux.intel.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220815233900.11225-1-jarkko@kernel.org>
 <20220815233900.11225-2-jarkko@kernel.org>
 <6b304bb4-01cc-c88a-7299-19217a7a692b@intel.com>
 <YvwpX7pYOW3Jv+vJ@kernel.org>
 <DM8PR11MB55913534E8CE66F63460E707F66A9@DM8PR11MB5591.namprd11.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <DM8PR11MB55913534E8CE66F63460E707F66A9@DM8PR11MB5591.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0061.namprd07.prod.outlook.com
 (2603:10b6:a03:60::38) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e96db263-10f1-47d8-b39c-08da8009ea46
X-MS-TrafficTypeDiagnostic: CO1PR11MB5186:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zh5M1GDQK/TavpAMIGXiKIqut3yuys/C7rQWK4+rYDjQ0bPebdq8S1EGl/SLWciI7EiBJvTldThkBMzqhzjSz5ifK/Y7oaLoee1VK4eIDt5oGpHsb5X0ZG9nWuI4zR/vIZ1LGCT9lrMuDDf7Dr0pnFz+JvYhoJFQ627E4JVoJtr6fkmyI78zGh96zE6B9J1xhKMuBhuBsEuodOwPXIPn/+XgCDmhhHZEO7njcbYjVSA18i7THO72oEQ4GuUX3avy6v6qF8m7w6SVgouQ8aMv0MXsZheKeJDT9XKmRKxi7FHfBTJ0finfvRMdi6QYJ0PADHXl+70/Xsv4Du+JHhD2PRuFBbHjg0fzrYze4WOWtWZ3l3H7ZhHHvK8zweXDi81XqGKv7fu/6Hhy1jZRNxOUyQ0g5JP2Naj7aFDo3fjixwsJPkD2xSZm+AwsrbG5uu/vmK8zjfTqdBJDf2F1hs+u1Q+jXRgj43IeUMbVMhKL3BrJd364FmcWsahjYaEiDdx//o0qyJgxjCZsREPgt0D6k4PWJgZQXJKF06htbgqDbtkWuyC8756yVkkE/ay/VePJHT8cc4rI1UAv5h0VtjjT8xRrXg6K/JT9bm1R04k9cPEPIn2uweRqqXyHX6vYQP+rlDK95NuI4jjMbouFkD1h0x/FV5lKbtSwjUITYvKUWHBPktbbkRmG1m5dbRzqoeQeGkOcF2/uLungJHocCXFliz1Rkcyax8Cj/I2ln0p3ZnVMpVypLDfBpVfPfHExbHbqHpsZjik6Ep0EFHIyuLt8WpL7KRPJu8dMnTyigZXVJM6xA53todT8iNtxZITgNTMyM0VA+iJRgVGk7smqmmqM3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(376002)(136003)(39860400002)(366004)(83380400001)(82960400001)(316002)(5660300002)(38100700002)(66946007)(66476007)(186003)(66556008)(8676002)(44832011)(6512007)(31696002)(2616005)(4326008)(2906002)(26005)(54906003)(31686004)(110136005)(478600001)(36756003)(6486002)(53546011)(41300700001)(86362001)(8936002)(6506007)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVZuQWNxcTN5M1J6ZERtaFJOV0FZblk5LzlPNE9Ba2hFR1dKZTc0QzZOTklU?=
 =?utf-8?B?bWN4N1hnT01JTUUvWDNYY1BEMUlqZ0FUeFc0eldxWDJGK2phZURpL0d4MnAx?=
 =?utf-8?B?QkFMYXpvMmFXS09obVd2akFHd3FoOWZ4cVZaUzdvVWtwbjRQelZtSktFeFpK?=
 =?utf-8?B?blp4MjRtd3dQc29wMkFqMEVqZHAwZk1QYjJ2WDdQZUUvUDQ5L1hNdTFyUmxa?=
 =?utf-8?B?MTFBQm5BVWlhazlPc0FIUFVOMU9BVEd4L3VFMlNBWEJYSUpkNVVtcHBtTmx4?=
 =?utf-8?B?aVZPdWxvWllRME8zUGZFVVhqb0tsZVlxamFWOExJOVF4Ymw0OU45dFZIOE5m?=
 =?utf-8?B?SmtEZTlWV2V5WGdZbWFIaXJ0T0hvYStLZEJ2bWRZOGJzendPcjgzLytiRDBM?=
 =?utf-8?B?QjhyeHphR0VyS21DYWh0UUJONzJuTkszR1ZVT2Y4LzRMczRVK2dsNFZwRG1k?=
 =?utf-8?B?eHlIOFp5a0tKSkF4T0t6cnJQajZ3RmoxbW8rK1B5SHpSMFhWaUNwZ01HNmV1?=
 =?utf-8?B?YzJ4MGEzRURpVEZPMVh5ellLMHRtNTVsVUVXZTQ4N1NaZi9LUmljWVBoSG9r?=
 =?utf-8?B?MUtOZkFyRVhERGdSMFRObG1ac0kwV01KTjNTMm1YUTlFdThEaVlEc2xubFBO?=
 =?utf-8?B?V29XN1AvVmtDSnJPT1djbGppRkgyd3AvTExmZGIvTk5UWWpQSndZek0yN05i?=
 =?utf-8?B?NnhsRG45T0tBd0hCL0pzVnp5elYwYU1lRlh4YUI5THlGV1BKUEI2aWhrbmg1?=
 =?utf-8?B?UWJONThvSVB5MmZUYm1qc0ZpWitZdGgvajBmR3YwUXRTN2VIWXVYbFNrYUdj?=
 =?utf-8?B?REVCeU82Y3ZodjdYSmhNYURtbGtXc0U0YUhoVm0xOEZxK1o0VnBVNUhiS1FP?=
 =?utf-8?B?b3I1aWcyYlArNFMwWDhoR1NSTE1mbmhmTEtYZXhPdmQzK0gzUHJ5TE5vYlZx?=
 =?utf-8?B?V1hVcmFtQU5sNklycTZtYWl6TTljQkg3d1YyblZjWlFWV1hVMEZ0K0o3YmEw?=
 =?utf-8?B?aEhOczl0a05VTkZHUFp0MTY0aGsxMGtpNmJLcFVzT0dJOThzaVVHeGFCSVdM?=
 =?utf-8?B?OFdVY3ZFTkc0S3gwYy95U2x0RU1HRjd2WWhFVS93QnAyQzZTT0JGZUE0RmRJ?=
 =?utf-8?B?K0M3T1QraGVNMmR4TEIyMXd0T3NEaDF3YVZDRkRESjM3NVJ4eXcvRDIyUmFO?=
 =?utf-8?B?VVJhbm1KaThSQlpRSHJwWWlNMnd1bzhqOHBqL29oNmpHL25mOCt4SGE3NDlM?=
 =?utf-8?B?RG9rWWNFY0lJZ01qdHN2R1FyUUtpcklUOHBPSmNoM2c3YlcyNkJWOG5WcldR?=
 =?utf-8?B?V2ovbzg3djBHeEF2WFcrdDluL09ueklKWUEzei8ybDJYdWdsbXBUL3BnQjJ2?=
 =?utf-8?B?bHNkV1Urbjk3Z0NjSTBIWGVQUUVSbUFQRWVDTnAyM1cwcjNtNmZoZnZrSWZV?=
 =?utf-8?B?UExHYnVSWHQ2NkhKeHRBR01qN09ZWU41VUNERyt3aXpzOTlodU1HWHJkNzEw?=
 =?utf-8?B?aFVneGpUUWVWYkEvMGRKa0tjTGpGTnNiR2dPVkR1VGgxR1l5T1l3MXRzc3ph?=
 =?utf-8?B?U3E3eVlDa013bUhBZ253M3ErbFJROE9JNk9uWE1aS2k2QW5CQmRtK0VnSnBG?=
 =?utf-8?B?RmJHVVBveWJTakxsVGdiQ3Z3a3FWM3RudXhwNi83Z2ZqeFhjVE1aU3dmMXNE?=
 =?utf-8?B?OHV2L2tHT2JUYW1LRHg5UUZZblNBWFl1K1JOT1ZUOE5LNGJWVXRtR2tZU0JK?=
 =?utf-8?B?dC81alZMY3B5UktHSGVzRXZjWGlkSXJlYWpnUElQZ240NlQ4S2RQYnhYcm5V?=
 =?utf-8?B?UmVyNUxGbHIzOWM3dkxTb1NyQ1FJMDNpd1RScVJ6eWZYN3lDVThlZjhBSWdl?=
 =?utf-8?B?ZW9WRDRFdXFlS1JLU3I4dm5ONmZWcmhPOU1ja0w3S25ZOHdEaGwvU09WTDN0?=
 =?utf-8?B?VGVqZnlMY1Q2UzljTS9oTEx3aXVVb3RXbXBpcXpKNkxyKzdWVlNUaVVwK2Z5?=
 =?utf-8?B?T3dUNjhHSEFodk9XdTFHL2U4emttYXpDTEdxS3FiTlcxOHR4TVFBck9zVmlp?=
 =?utf-8?B?YWZkRWdLMnVuN3I3MVhzRmNRVDlxamwyQmFSVG5MdlREVTZ4SjdMRWtIZ0kx?=
 =?utf-8?B?ZlBLYU9KVnpabk5McFVHRll3dURDZExTMjhCMDVKR2dTQ0EvZ3JENFNjTkZp?=
 =?utf-8?B?K3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e96db263-10f1-47d8-b39c-08da8009ea46
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 04:35:30.2253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lq28myEMLMtkyAqpfMUaDZxSFVQ4LyoT83ZHM01YIu3CJ/Cp3P4tWZ768tHou7cAdJUhaF+z9mg8SQ2P+LMXi+/lIcY/FmNcNqTERXkKleg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5186
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Vijay,

On 8/16/2022 6:27 PM, Dhanraj, Vijay wrote:
> Hi Jarkko, Reinette,
> 
>> -----Original Message-----
>> From: Jarkko Sakkinen <jarkko@kernel.org>
>> Sent: Tuesday, August 16, 2022 4:34 PM
>> To: Chatre, Reinette <reinette.chatre@intel.com>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>; linux-
>> sgx@vger.kernel.org; Dhanraj, Vijay <vijay.dhanraj@intel.com>; Shuah Khan
>> <shuah@kernel.org>; open list:KERNEL SELFTEST FRAMEWORK <linux-
>> kselftest@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>
>> Subject: Re: [PATCH 2/2] selftests/sgx: Add SGX selftest
>> augment_via_eaccept_long
>>
>> On Tue, Aug 16, 2022 at 09:26:40AM -0700, Reinette Chatre wrote:
>>> Hi Vijay,
>>>
>>> Thank you very much for digging into this. A few comments below.
>>>
>>> On 8/15/2022 4:39 PM, Jarkko Sakkinen wrote:

...

>>>> @@ -25,6 +25,8 @@ static const uint64_t MAGIC =
>>>> 0x1122334455667788ULL;  static const uint64_t MAGIC2 =
>>>> 0x8877665544332211ULL;  vdso_sgx_enter_enclave_t
>>>> vdso_sgx_enter_enclave;
>>>>
>>>> +static const unsigned long edmm_size = 8589934592; //8G
>>>> +
>>>
>>> Could you please elaborate how this constant was chosen? I understand
>>> that this test helped to uncover a bug and it is useful to add to the
>>> kernel. When doing so this test will be run on systems with a variety
>>> of SGX memory sizes, could you please elaborate (and add a
>>> snippet) how 8GB is the right value for all systems?
>>
>> It is the only constant I know for sure that some people (Vijay and Haitao)
>> have been able to reproduce the bug.
>>
>> Unless someone can show that the same bug reproduces with a smaller
>> constant, changing it would make the whole test irrelevant.
> 
> I tried with 2GB and it always succeed and with 4GB was able to repro sporadically. But with 8GB failure was consistent. One thing to note is even with 8GB Haitao couldn't reproduce this every time. So not sure if it good for all the systems but on my ICX system, I was able to consistently repro with this value.
>  

Could all of this information be placed in a description of this constant? At this time
it appears to be arbitrary.

>>>> +
>>>> +	if (!sgx2_supported())
>>>> +		SKIP(return, "SGX2 not supported");
>>>> +
>>>> +	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self-
>>> encl,
>>>> +_metadata));
>>>> +
>>>> +	memset(&self->run, 0, sizeof(self->run));
>>>> +	self->run.tcs = self->encl.encl_base;
>>>> +
>>>> +	for (i = 0; i < self->encl.nr_segments; i++) {
>>>> +		struct encl_segment *seg = &self->encl.segment_tbl[i];
>>>> +
>>>> +		total_size += seg->size;
>>>> +		TH_LOG("test enclave: total_size = %ld, seg->size = %ld",
>> total_size, seg->size);
>>>> +	}
>>>> +
>>>> +	/*
>>>> +	 * Actual enclave size is expected to be larger than the loaded
>>>> +	 * test enclave since enclave size must be a power of 2 in bytes while
>>>> +	 * test_encl does not consume it all.
>>>> +	 */
>>>> +	EXPECT_LT(total_size + edmm_size, self->encl.encl_size);
>>>
>>> Will this test ever fail?
>>
>> With a *quick* look: no.
>>
>> Vijay, what was the point of this check?
> 
> Yes we can remove this check. I tried to copy from `augment_via_eaccept` and just changed the request size.
> 

In augment_via_eaccept the check is required since augment_via_eaccept assumes
that there is enough address space in the existing enclave for dynamic memory addition
without needing to change the enclave size. If anybody later changes the test
enclave to break this assumption then that check will pick it up.

In this new test the enclave size is set to accommodate the planned
dynamic memory addition and thus adding a test to check if the enclave
has enough space for the dynamic memory is not needed.

>>>> +	TH_LOG("Entering enclave to run EACCEPT for each page of %zd
>> bytes may take a while ...",
>>>> +			edmm_size);
>>>> +	eaccept_op.flags = SGX_SECINFO_R | SGX_SECINFO_W |
>> SGX_SECINFO_REG | SGX_SECINFO_PENDING;
>>>> +	eaccept_op.ret = 0;
>>>> +	eaccept_op.header.type = ENCL_OP_EACCEPT;
>>>> +
>>>> +	for (i = 0; i < edmm_size; i += 4096) {
>>>> +		eaccept_op.epc_addr = (uint64_t)(addr + i);
>>>> +
>>>> +		EXPECT_EQ(ENCL_CALL(&eaccept_op, &self->run, true), 0);
>>>> +		if (self->run.exception_vector == 14 &&
>>>> +			self->run.exception_error_code == 4 &&
>>>> +			self->run.exception_addr == self->encl.encl_base) {
>>>> +			munmap(addr, edmm_size);
>>>> +			SKIP(return, "Kernel does not support adding pages
>> to initialized enclave");
>>>> +		}
>>>> +
>>>> +		EXPECT_EQ(self->run.exception_vector, 0);
>>>> +		EXPECT_EQ(self->run.exception_error_code, 0);
>>>> +		EXPECT_EQ(self->run.exception_addr, 0);
>>>> +		ASSERT_EQ(eaccept_op.ret, 0);
>>>> +		ASSERT_EQ(self->run.function, EEXIT);
>>>> +	}
>>>> +
>>>> +	/*
>>>> +	 * New page should be accessible from within enclave - attempt to
>>>> +	 * write to it.
>>>> +	 */
>>>
>>> This portion below was also copied from previous test and by only
>>> testing a write to the first page of the range the purpose is not
>>> clear. Could you please elaborate if the intention is to only test
>>> accessibility of the first page and why that is sufficient?
>>
>> It is sufficient because the test reproduces the bug. It would have to be
>> rather elaborated why you would possibly want to do more than that.

That is fair. An accurate comment (currently an inaccurate copy&paste) would
help to explain this part of the test.

>>>> +	put_addr_op.value = MAGIC;
>>>> +	put_addr_op.addr = (unsigned long)addr;
>>>> +	put_addr_op.header.type = ENCL_OP_PUT_TO_ADDRESS;
>>>> +
>>>> +	EXPECT_EQ(ENCL_CALL(&put_addr_op, &self->run, true), 0);
>>>> +
>>>> +	EXPECT_EEXIT(&self->run);
>>>> +	EXPECT_EQ(self->run.exception_vector, 0);
>>>> +	EXPECT_EQ(self->run.exception_error_code, 0);
>>>> +	EXPECT_EQ(self->run.exception_addr, 0);
>>>> +
>>>> +	/*
>>>> +	 * Read memory from newly added page that was just written to,
>>>> +	 * confirming that data previously written (MAGIC) is present.
>>>> +	 */
>>>> +	get_addr_op.value = 0;
>>>> +	get_addr_op.addr = (unsigned long)addr;
>>>> +	get_addr_op.header.type = ENCL_OP_GET_FROM_ADDRESS;
>>>> +
>>>> +	EXPECT_EQ(ENCL_CALL(&get_addr_op, &self->run, true), 0);
>>>> +
>>>> +	EXPECT_EQ(get_addr_op.value, MAGIC);
>>>> +	EXPECT_EEXIT(&self->run);
>>>> +	EXPECT_EQ(self->run.exception_vector, 0);
>>>> +	EXPECT_EQ(self->run.exception_error_code, 0);
>>>> +	EXPECT_EQ(self->run.exception_addr, 0);
>>>> +
>>>> +	munmap(addr, edmm_size);
>>>> +}
>>>> +
>>>>  /*
>>>>   * SGX2 page type modification test in two phases:
>>>>   * Phase 1:
>>>> diff --git a/tools/testing/selftests/sgx/main.h
>>>> b/tools/testing/selftests/sgx/main.h
>>>> index fc585be97e2f..fe5d39ac0e1e 100644
>>>> --- a/tools/testing/selftests/sgx/main.h
>>>> +++ b/tools/testing/selftests/sgx/main.h
>>>> @@ -35,7 +35,8 @@ extern unsigned char sign_key[];  extern unsigned
>>>> char sign_key_end[];
>>>>
>>>>  void encl_delete(struct encl *ctx); -bool encl_load(const char
>>>> *path, struct encl *encl, unsigned long heap_size);
>>>> +bool encl_load(const char *path, struct encl *encl, unsigned long
>> heap_size,
>>>> +			   unsigned long edmm_size);
>>>>  bool encl_measure(struct encl *encl);  bool encl_build(struct encl
>>>> *encl);  uint64_t encl_get_entry(struct encl *encl, const char
>>>> *symbol); diff --git a/tools/testing/selftests/sgx/sigstruct.c
>>>> b/tools/testing/selftests/sgx/sigstruct.c
>>>> index 50c5ab1aa6fa..6000cf0e4975 100644
>>>> --- a/tools/testing/selftests/sgx/sigstruct.c
>>>> +++ b/tools/testing/selftests/sgx/sigstruct.c
>>>> @@ -343,7 +343,7 @@ bool encl_measure(struct encl *encl)
>>>>  	if (!ctx)
>>>>  		goto err;
>>>>
>>>> -	if (!mrenclave_ecreate(ctx, encl->src_size))
>>>> +	if (!mrenclave_ecreate(ctx, encl->encl_size))
>>>>  		goto err;
>>>>
>>>>  	for (i = 0; i < encl->nr_segments; i++) {
>>>
>>>
>>> Looking at mrenclave_ecreate() the above snippet seems separate from
>>> this test and incomplete since it now obtains encl->encl_size but
>>> continues to compute it again internally. Should this be a separate fix?
>>
>> I would remove this part completely but this also needs comment from Vijay.
> 
> If we restrict the large enclave size just for this test, then the above change can be reverted. Calling ` mrenclave_ecreate`  with src_size esults in EINIT failure and I think the reason is because of incorrect MRenclave.

From what I understand this change is needed since the enclave size is no longer just
the size of all the segments at enclave creation. I think it is incomplete though since it
still recomputes the enclave size even though it is now provided as parameter.
This change does not need to be part of this test addition.

Reinette
