Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBE237C9C3
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 May 2021 18:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbhELQVL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 May 2021 12:21:11 -0400
Received: from mga11.intel.com ([192.55.52.93]:17410 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238059AbhELP5O (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 May 2021 11:57:14 -0400
IronPort-SDR: 7+Axw4a2GdTdJZYGr5p+xK+EevTTfQcb2LyJ34mdjWtG82rszEa9lKmLiCK/oMKVeRgKQvmVdi
 Hmv7vfvJGpeA==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="196646154"
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="196646154"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 08:56:05 -0700
IronPort-SDR: UWeTj3jQdhWF1YEWQNpBm0lw4wCt6SSJLjjdVbtjgKaH+1h5T0zsfunZVjXASgzqZfYXdSAkpD
 6nq/IoMY81KA==
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="392799988"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.251.0.238]) ([10.251.0.238])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 08:56:04 -0700
Subject: Re: [PATCH v4 2/2] selftests/sgx: Migrate to kselftest harness
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-sgx@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210508035648.18176-1-jarkko@kernel.org>
 <20210508035648.18176-2-jarkko@kernel.org>
 <960f1cd8-d805-8ed8-6af0-eed1f49e3c65@intel.com>
 <YJsrDc34d2vbc+At@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <0b68cf8e-994d-3c85-cb93-5701722d9336@intel.com>
Date:   Wed, 12 May 2021 08:56:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YJsrDc34d2vbc+At@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jarkko,

On 5/11/2021 6:10 PM, Jarkko Sakkinen wrote:
> On Tue, May 11, 2021 at 11:42:49AM -0700, Reinette Chatre wrote:
>> Hi Jarkko,
>>
>> On 5/7/2021 8:56 PM, Jarkko Sakkinen wrote:
>>> Migrate to kselftest harness. Use a fixture test with enclave initialized
>>> and de-initialized for each of the existing three tests, in other words:
>>>
>>> 1. One FIXTURE() for managing the enclave life-cycle.
>>> 2. Three TEST_F()'s, one for each test case.
>>
>> These changes make it easier to add tests and I think it is a valuable
>> addition.
>>
>>>
>>> This gives a leaps better reporting than before. Here's an example
>>> transcript:
>>>
>>> TAP version 13
>>> 1..3
>>> 0x0000000000000000 0x0000000000002000 0x03
>>> 0x0000000000002000 0x0000000000001000 0x05
>>> 0x0000000000003000 0x0000000000003000 0x03
>>> ok 1 enclave.unclobbered_vdso
>>> 0x0000000000000000 0x0000000000002000 0x03
>>> 0x0000000000002000 0x0000000000001000 0x05
>>> 0x0000000000003000 0x0000000000003000 0x03
>>> ok 2 enclave.clobbered_vdso
>>> 0x0000000000000000 0x0000000000002000 0x03
>>> 0x0000000000002000 0x0000000000001000 0x05
>>> 0x0000000000003000 0x0000000000003000 0x03
>>> ok 3 enclave.clobbered_vdso_and_user_function
>>>
>>
>> The output claims to conform to TAP13 but it does not seem as though all of
>> the output conforms to TAP13. I assume such output would confuse automated
>> systems.
> 
> You mean
> 
> 0x0000000000000000 0x0000000000002000 0x03
> 0x0000000000002000 0x0000000000001000 0x05
> 0x0000000000003000 0x0000000000003000 0x03
> 
> ?

Yes

Reinette
