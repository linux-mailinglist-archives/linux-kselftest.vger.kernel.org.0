Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 359443880EA
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 May 2021 22:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351983AbhERUIh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 May 2021 16:08:37 -0400
Received: from mga17.intel.com ([192.55.52.151]:15798 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232377AbhERUIg (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 May 2021 16:08:36 -0400
IronPort-SDR: 28vornXhaiRvCI6fNyQbmQzCB5gLsLlgEvpTe1Zcm72MMAWryOcHtjNqV1L9NUItrMUAg2SYwN
 TNi4TAUAfhqw==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="181086085"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="181086085"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 13:07:18 -0700
IronPort-SDR: 8q7naH9q2EARr2Rc3CCYtIkYtCRSsVB8z+M4OQIkW3EPg5koHNgJqDne4Wg2bQpZ9IoJgUaNbo
 q6Cri0sDs4vQ==
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="439268002"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.164.215]) ([10.212.164.215])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 13:07:17 -0700
Subject: Re: [PATCH v5 2/2] selftests/sgx: Migrate to kselftest harness
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linux-sgx@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20210512215323.420639-1-jarkko@kernel.org>
 <20210512215323.420639-2-jarkko@kernel.org>
 <3b920525-694c-a8e4-93f5-7b1a3f9ad009@intel.com>
 <YKP+CavM21klDHH8@kernel.org> <YKQcH2/5ENIp2Bps@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <16d7588e-a44c-90c1-44be-3a9cca1dc913@intel.com>
Date:   Tue, 18 May 2021 13:07:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YKQcH2/5ENIp2Bps@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jarkko,

On 5/18/2021 12:57 PM, Jarkko Sakkinen wrote:
> On Tue, May 18, 2021 at 08:49:00PM +0300, Jarkko Sakkinen wrote:
>> On Mon, May 17, 2021 at 10:03:42AM -0700, Reinette Chatre wrote:
>>> Hi Jarkko,
>>>
>>> On 5/12/2021 2:53 PM, Jarkko Sakkinen wrote:
>>>> Migrate to kselftest harness. Use a fixture test with enclave initialized
>>>> and de-initialized for each of the existing three tests, in other words:
>>>>
>>>> 1. One FIXTURE() for managing the enclave life-cycle.
>>>> 2. Three TEST_F()'s, one for each test case.
>>>>
>>>> This gives a leaps better reporting than before. Here's an example
>>>> transcript:
>>>>
>>>> TAP version 13
>>>> 1..3
>>>>
>>>> ok 1 enclave.unclobbered_vdso
>>>>
>>>> ok 2 enclave.clobbered_vdso
>>>>
>>>> ok 3 enclave.clobbered_vdso_and_user_function
>>>>
>>>> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>>>> ---
>>>>
>>>> v5:
>>>> * Use TH_LOG() for printing enclave address ranges instead of printf(),
>>>>     based on Reinette's remark.
>>>
>>> Thank you for considering my feedback. The motivation for my comment was to
>>> consider how this test output will be parsed. If these tests will have their
>>> output parsed by automated systems then it needs to conform to the TAP13
>>> format as supported by kselftest.
>>>
>>> In your latest version the output printed during a successful test has been
>>> changed, using TH_LOG() as you noted. From what I can tell this is the only
>>> output addressed - failing tests continue to print error messages (perror,
>>> fprintf) without consideration of how they will be parsed. My apologies, I
>>> am not a kselftest expert to know what the best way for this integration is.
>>>
>>> Reinette
>>
>> It's a valid question, yes.
>>
>> The problem is that only main.c can use kselftest macros because
>> kselftest_harness.h pulls
>>
>> static int test_harness_run(int __attribute__((unused)) argc,
>> 			    char __attribute__((unused)) **argv)
>>
>> which will not end up having a call site (because there's no
>> "TEST_HARNESS_MAIN").
>>
>> The whole logging thing in kselftest harness is a bit ambiguous.
>> Namely:
>>
>> 1. There's a macro TH_LOG() defined in kselftest_harness.h, which
>>     "internally" uses fprintf().
>> 2. There's an inline function ksft_print_msg() in kselftest.h
>>     using vsprintf().
>>
>> To add to that, kselftest_harness.h internally prints by using
>> ksft_print_msg(), and provides TH_LOG(), which does not use
>> ksft_print_msg().
>>
>> I don't really get the logic in all this.
> 
> I tried to split TH_LOG() as separate entity but it's not possible, as the
> macros access a static variable called '_metadata'.
> 
> I'm not exactly sure how to proceed from this, if we want to make logging
> consistent.
> 
> I would personally suggest to leave the error messages intact in load.c,
> because there is no way to make them consistent, except by removing them.


It is not clear to me why ksft_print_msg() cannot be used but an 
alternative to it may be to just prefix all existing diagnostic messages 
with "# ".

Reinette

