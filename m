Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2EC3BF151
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jul 2021 23:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbhGGVWs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jul 2021 17:22:48 -0400
Received: from mga02.intel.com ([134.134.136.20]:46708 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230439AbhGGVWr (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jul 2021 17:22:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10037"; a="196556023"
X-IronPort-AV: E=Sophos;i="5.84,221,1620716400"; 
   d="scan'208";a="196556023"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 14:20:06 -0700
X-IronPort-AV: E=Sophos;i="5.84,221,1620716400"; 
   d="scan'208";a="645512505"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.209.124.120]) ([10.209.124.120])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 14:20:05 -0700
Subject: Re: [PATCH 4/4] selftests/sgx: Trigger the reclaimer and #PF handler
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-sgx@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20210705143652.116125-1-jarkko@kernel.org>
 <20210705143652.116125-5-jarkko@kernel.org>
 <715ed555-5044-6fee-1d09-1c4cfa827af3@intel.com>
 <20210706235016.uucukyrr3ckk57pi@kernel.org>
 <16505466-e001-c4b0-ec41-5384ddcf194b@intel.com>
 <20210707091736.6wzemgmtzuegk3uf@kernel.org>
 <10664754-7e53-d9d1-f00c-f9dbd4a2d877@intel.com>
 <20210707205019.6jy64s4uqcw65q4h@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <64b1cac8-75b9-8549-8499-60b4d72cf9ef@intel.com>
Date:   Wed, 7 Jul 2021 14:20:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210707205019.6jy64s4uqcw65q4h@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jarkko,

On 7/7/2021 1:50 PM, Jarkko Sakkinen wrote:
> On Wed, Jul 07, 2021 at 08:02:42AM -0700, Reinette Chatre wrote:
>> Hi Jarkko,
>>
>> On 7/7/2021 2:17 AM, Jarkko Sakkinen wrote:
>>> On Tue, Jul 06, 2021 at 05:10:38PM -0700, Reinette Chatre wrote:
>>>> Hi Jarkko,
>>>>
>>>> On 7/6/2021 4:50 PM, Jarkko Sakkinen wrote:
>>>>> On Tue, Jul 06, 2021 at 11:34:54AM -0700, Reinette Chatre wrote:
>>>>>> Hi Jarkko,
>>>>>>
>>>>>> On 7/5/2021 7:36 AM, Jarkko Sakkinen wrote:
>>>>>>> Create a heap for the test enclave, which has the same size as all
>>>>>>> available Enclave Page Cache (EPC) pages in the system. This will guarantee
>>>>>>> that all test_encl.elf pages *and* SGX Enclave Control Structure (SECS)
>>>>>>> have been swapped out by the page reclaimer during the load time. Actually,
>>>>>>> this adds a bit more stress than that since part of the EPC gets reserved
>>>>>>> for the Version Array (VA) pages.
>>>>>>>
>>>>>>> For each test, the page fault handler gets triggered in two occasions:
>>>>>>>
>>>>>>> - When SGX_IOC_ENCLAVE_INIT is performed, SECS gets swapped in by the
>>>>>>>       page fault handler.
>>>>>>> - During the execution, each page that is referenced gets swapped in
>>>>>>>       by the page fault handler.
>>>>>>>
>>>>>>
>>>>>> If I understand this correctly, all EPC pages are now being consumed during
>>>>>> fixture setup and thus every SGX test, no matter how big or small, now
>>>>>> becomes a stress test of the reclaimer instead of there being a unique
>>>>>> reclaimer test. Since an enclave is set up and torn down for every test this
>>>>>> seems like a significant addition. It also seems like this would impact
>>>>>> future tests of dynamic page addition where not all scenarios could be
>>>>>> tested with all EPC pages already consumed.
>>>>>>
>>>>>> Reinette
>>>>>
>>>>> Re-initializing the test enclave is mandatory thing to do for all tests
>>>>> because it has an internals state.
>>>>>
>>>>
>>>> Right, but not all tests require the same enclave. In kselftest terminology
>>>> I think you are attempting to force all tests to depend on the same test
>>>> fixture. Is it not possible to have a separate "reclaimer" test fixture that
>>>> would build an enclave with a large heap and then have reclaimer tests that
>>>> exercise it by being tests that are specific to this "reclaimer fixture"?
>>>>
>>>> Reinette
>>>
>>> Why add that complexity?
>>>
>>
>> With this change every test is turned into a pseudo reclaimer test without
>> there being any explicit testing (with pass/fail criteria) of reclaimer
>> behavior. This is an expensive addition and reduces the scenarios that the
>> tests can exercise.
>>
>> Reinette
> 
> There is consistent known behaviour how reclaimer and also the page fault
> are exercised for each test. I think that is what matters most right now
> that the basic behaviour of both the page reclaimer and page fault handler
> gets exercised.

I believe the basic behavior of page fault handler is currently 
exercised in each test, this is required.

> 
> I don't understand the real-world gain of doing something factors more
> complex than necessary at a particular point of time,  when you don't
> really need to hang yourself into it forever.

Your argument about "hang yourself into it forever" can go both ways - 
why should all tests now unnecessarily consume the entire EPC forever?

If I understand correctly adding a separate reclaimer test is not 
complex but would require refactoring code.

> This patch does increase the coverage in a deterministic manner to the code
> paths that were not previously exercised, i.e. we know the code paths, and
> could even calculate the exact number of times that they are triggered. And
> without doing anything obscure. That's what matters to me.

On the contrary this is indeed obfuscating the SGX tests: if an issue 
shows up in the reclaimer then all tests would fail. If there is a 
unique reclaimer test then that would help point to where the issue may be.

Reinette
