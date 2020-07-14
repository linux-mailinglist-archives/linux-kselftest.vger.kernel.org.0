Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE94621E4CA
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jul 2020 02:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgGNAug (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jul 2020 20:50:36 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:8376 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbgGNAuf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jul 2020 20:50:35 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f0d01210000>; Mon, 13 Jul 2020 17:49:37 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 13 Jul 2020 17:50:35 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 13 Jul 2020 17:50:35 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 14 Jul
 2020 00:50:34 +0000
Subject: Re: [PATCH v2 6/8] selftests/harness: Refactor XFAIL into SKIP
To:     Kees Cook <keescook@chromium.org>
CC:     Shuah Khan <shuah@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        David Gow <davidgow@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Bird, Tim" <Tim.Bird@sony.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200622181651.2795217-1-keescook@chromium.org>
 <20200622181651.2795217-7-keescook@chromium.org>
 <90fa90dc-7155-6096-678d-b6c103c1b0a6@nvidia.com>
 <202007131705.D17464CA16@keescook>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <9a3ff6a1-de73-08fc-49ad-b68f3b1776b8@nvidia.com>
Date:   Mon, 13 Jul 2020 17:50:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <202007131705.D17464CA16@keescook>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594687777; bh=lR6u9w+8DklpteIoSVyEE9JVQ86HW65/OnXVj0QouQw=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=hMwiQJZmZJDBHu4v2qpYgF5vOwY4dWwRm6sG5IYDnCmwXkVKGf/oxRZxU421ChMNU
         zx/qlDsmwXc1mNgWMD6wDzDaoyfA4AZ5iqIW5RCKeF3EU9qvMIG4BUkFYaDZvT7f5a
         ygD6aafRkAtyHX3R2fmdL5wBtq2HNingIjaSTpgiM5GilKRKR6PGtnP08ZwtV9rOqB
         Zp3+pA8XidZoI8Gl/btFDUpfdKXi4kAluoBEPvkgTM6Do9Vp8LYGR9PthQCJ+Pk3kb
         xmrJ8wCFY2OLKsdoPZQyFJ7PqRdYEfTvquQz6TGF8CPyZMBo5YBCrtA9XUNcubRpyl
         L9A3ShvS13Z3Q==
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 7/13/20 5:13 PM, Kees Cook wrote:
> On Mon, Jul 13, 2020 at 12:08:08PM -0700, Ralph Campbell wrote:
>>
>> On 6/22/20 11:16 AM, Kees Cook wrote:
>>> Plumb the old XFAIL result into a TAP SKIP.
>>>
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>> ---
>>>    tools/testing/selftests/kselftest_harness.h   | 64 ++++++++++++++-----
>>>    tools/testing/selftests/seccomp/seccomp_bpf.c |  8 +--
>>>    2 files changed, 52 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
>>> index f8f7e47c739a..b519765904a6 100644
>>> --- a/tools/testing/selftests/kselftest_harness.h
>>> +++ b/tools/testing/selftests/kselftest_harness.h
>>> @@ -112,22 +112,22 @@
>>>    			__FILE__, __LINE__, _metadata->name, ##__VA_ARGS__)
>>>    /**
>>> - * XFAIL(statement, fmt, ...)
>>> + * SKIP(statement, fmt, ...)
>>>     *
>>> - * @statement: statement to run after reporting XFAIL
>>> + * @statement: statement to run after reporting SKIP
>>>     * @fmt: format string
>>>     * @...: optional arguments
>>>     *
>>> - * This forces a "pass" after reporting a failure with an XFAIL prefix,
>>> + * This forces a "pass" after reporting why something is being skipped
>>>     * and runs "statement", which is usually "return" or "goto skip".
>>>     */
>>> -#define XFAIL(statement, fmt, ...) do { \
>>> +#define SKIP(statement, fmt, ...) do { \
>>>    	if (TH_LOG_ENABLED) { \
>>> -		fprintf(TH_LOG_STREAM, "#      XFAIL     " fmt "\n", \
>>> +		fprintf(TH_LOG_STREAM, "#      SKIP     " fmt "\n", \
>>>    			##__VA_ARGS__); \
>>>    	} \
>>> -	/* TODO: find a way to pass xfail to test runner process. */ \
>>>    	_metadata->passed = 1; \
>>> +	_metadata->skip = 1; \
>>>    	_metadata->trigger = 0; \
>>>    	statement; \
>>>    } while (0)
>>> @@ -777,6 +777,7 @@ struct __test_metadata {
>>>    	struct __fixture_metadata *fixture;
>>>    	int termsig;
>>>    	int passed;
>>> +	int skip;	/* did SKIP get used? */
>>>    	int trigger; /* extra handler after the evaluation */
>>>    	int timeout;	/* seconds to wait for test timeout */
>>>    	bool timed_out;	/* did this test timeout instead of exiting? */
>>> @@ -866,17 +867,31 @@ void __wait_for_test(struct __test_metadata *t)
>>>    		fprintf(TH_LOG_STREAM,
>>>    			"# %s: Test terminated by timeout\n", t->name);
>>>    	} else if (WIFEXITED(status)) {
>>> -		t->passed = t->termsig == -1 ? !WEXITSTATUS(status) : 0;
>>>    		if (t->termsig != -1) {
>>> +			t->passed = 0;
>>>    			fprintf(TH_LOG_STREAM,
>>>    				"# %s: Test exited normally instead of by signal (code: %d)\n",
>>>    				t->name,
>>>    				WEXITSTATUS(status));
>>> -		} else if (!t->passed) {
>>> -			fprintf(TH_LOG_STREAM,
>>> -				"# %s: Test failed at step #%d\n",
>>> -				t->name,
>>> -				WEXITSTATUS(status));
>>> +		} else {
>>> +			switch (WEXITSTATUS(status)) {
>>> +			/* Success */
>>> +			case 0:
>>> +				t->passed = 1;
>>> +				break;
>>> +			/* SKIP */
>>> +			case 255:
>>> +				t->passed = 1;
>>> +				t->skip = 1;
>>> +				break;
>>> +			/* Other failure, assume step report. */
>>> +			default:
>>> +				t->passed = 0;
>>> +				fprintf(TH_LOG_STREAM,
>>> +					"# %s: Test failed at step #%d\n",
>>> +					t->name,
>>> +					WEXITSTATUS(status));
>>> +			}
>>>    		}
>>>    	} else if (WIFSIGNALED(status)) {
>>>    		t->passed = 0;
>>> @@ -906,6 +921,7 @@ void __run_test(struct __fixture_metadata *f,
>>>    {
>>>    	/* reset test struct */
>>>    	t->passed = 1;
>>> +	t->skip = 0;
>>>    	t->trigger = 0;
>>>    	t->step = 0;
>>>    	t->no_print = 0;
>>> @@ -918,15 +934,31 @@ void __run_test(struct __fixture_metadata *f,
>>>    		t->passed = 0;
>>>    	} else if (t->pid == 0) {
>>>    		t->fn(t, variant);
>>> -		/* return the step that failed or 0 */
>>> -		_exit(t->passed ? 0 : t->step);
>>> +		/* Make sure step doesn't get lost in reporting */
>>> +		if (t->step >= 255) {
>>> +			ksft_print_msg("Too many test steps (%u)!?\n", t->step);
>>> +			t->step = 254;
>>> +		}
>>
>> I noticed that this message is now appearing in the HMM self tests.
>> I haven't quite tracked down why ->steps should be 255 after running
>> the first test. I did notice that ASSERT*() calls __INC_STEP() but
>> that doesn't explain it.
>> Separately, maybe __INC_STEP() should check for < 254 instead of < 255?
>>
>>      Set CONFIG_HMM_TESTS=m, build and install kernel and modules.
>>      cd tools/testing/selftests/vm
>>      make
>>      ./test_hmm.sh smoke
>>      Running smoke test. Note, this test provides basic coverage.
>>      [  106.803476] memmap_init_zone_device initialised 65536 pages in 7ms
>>      [  106.810141] added new 256 MB chunk (total 1 chunks, 256 MB) PFNs [0x3ffff0000 0x400000000)
>>      [  106.823703] memmap_init_zone_device initialised 65536 pages in 4ms
>>      [  106.829968] added new 256 MB chunk (total 1 chunks, 256 MB) PFNs [0x3fffe0000 0x3ffff0000)
>>      [  106.838655] HMM test module loaded. This is only for testing HMM.
>>      TAP version 13
>>      1..20
>>      # Starting 20 tests from 3 test cases.
>>      #  RUN           hmm.open_close ...
>>      #            OK  hmm.open_close
>>      ok 1 hmm.open_close
>>      #  RUN           hmm.anon_read ...
>>      # Too many test steps (255)!?
>>      #            OK  hmm.anon_read
> 
> Oooh:
> 
> #define NTIMES          256
> 
> Yes, that's a lot of steps. :)
> 
> I agree,__ INC_STEP() needs adjustment, though it should be 253. Does
> this work for you?
> 
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index 935029d4fb21..4f78e4805633 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -680,7 +680,8 @@
>   			__bail(_assert, _metadata->no_print, _metadata->step))
>   
>   #define __INC_STEP(_metadata) \
> -	if (_metadata->passed && _metadata->step < 255) \
> +	/* Keep "step" below 255 (which is used for "SKIP" reporting). */	\
> +	if (_metadata->passed && _metadata->step < 253) \
>   		_metadata->step++;
>   
>   #define is_signed_type(var)       (!!(((__typeof__(var))(-1)) < (__typeof__(var))1))
> @@ -976,12 +977,6 @@ void __run_test(struct __fixture_metadata *f,
>   		t->passed = 0;
>   	} else if (t->pid == 0) {
>   		t->fn(t, variant);
> -		/* Make sure step doesn't get lost in reporting */
> -		if (t->step >= 255) {
> -			ksft_print_msg("Too many test steps (%u)!?\n", t->step);
> -			t->step = 254;
> -		}
> -		/* Use 255 for SKIP */
>   		if (t->skip)
>   			_exit(255);
>   		/* Pass is exit 0 */
> 

Yes, this works for me.
Thanks!
