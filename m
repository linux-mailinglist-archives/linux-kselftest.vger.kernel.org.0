Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 158CB26C779
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Sep 2020 20:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgIPS03 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Sep 2020 14:26:29 -0400
Received: from foss.arm.com ([217.140.110.172]:35106 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727999AbgIPSZl (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Sep 2020 14:25:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 676C230E;
        Wed, 16 Sep 2020 05:11:18 -0700 (PDT)
Received: from [10.57.10.184] (unknown [10.57.10.184])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 876B03F68F;
        Wed, 16 Sep 2020 05:11:15 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] kselftests/arm64: add a basic Pointer
 Authentication test
To:     Boyan Karatotev <boyan.karatotev@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     vincenzo.frascino@arm.com, boian4o1@gmail.com,
        Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
References: <20200831110450.30188-1-boyan.karatotev@arm.com>
 <20200831110450.30188-2-boyan.karatotev@arm.com>
From:   Amit Kachhap <amit.kachhap@arm.com>
Message-ID: <2e89a5ff-738b-5484-bd00-9ccdeccf9f60@arm.com>
Date:   Wed, 16 Sep 2020 17:41:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200831110450.30188-2-boyan.karatotev@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Boyan,

On 8/31/20 4:34 PM, Boyan Karatotev wrote:
> PAuth signs and verifies return addresses on the stack. It does so by
> inserting a Pointer Authentication code (PAC) into some of the unused top
> bits of an address. This is achieved by adding paciasp/autiasp instructions
> at the beginning and end of a function.
> 
> This feature is partially backwards compatible with earlier versions of the
> ARM architecture. To coerce the compiler into emitting fully backwards
> compatible code the main file is compiled to target an earlier ARM version.
> This allows the tests to check for the feature and print meaningful error
> messages instead of crashing.
> 
> Add a test to verify that corrupting the return address results in a
> SIGSEGV on return.
> 
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Reviewed-by: Vincenzo Frascino <Vincenzo.Frascino@arm.com>
> Reviewed-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
> Signed-off-by: Boyan Karatotev <boyan.karatotev@arm.com>
> ---
>   tools/testing/selftests/arm64/Makefile        |  2 +-

[...]

> +
> +/* check that a corrupted PAC results in SIGSEGV */
> +TEST_SIGNAL(corrupt_pac, SIGSEGV)
> +{
> +	ASSERT_PAUTH_ENABLED();
> +
> +	pac_corruptor();

With 8.6-Pauth extension merged in arm tree [1]. It makes sense to 
verify PAC corruption for both SIGSEGV and SIGILL signals.

Code something like below handles both the cases.

-----------------------------------------------------------------------------------
  int exec_sign_all(struct signatures *signed_vals, size_t val)
@@ -187,12 +188,29 @@ int exec_sign_all(struct signatures *signed_vals, 
size_t val)
         return 0;
  }

-/* check that a corrupted PAC results in SIGSEGV */
-TEST_SIGNAL(corrupt_pac, SIGSEGV)
+sigjmp_buf jmpbuf;
+void pac_signal_handler(int signum, siginfo_t *si, void *uc)
  {
-       ASSERT_PAUTH_ENABLED();
+       if (signum == SIGSEGV || signum == SIGILL) {
+               siglongjmp(jmpbuf, 1);
+       }
+}
+
+/* check that a corrupted PAC results in SIGSEGV or SIGILL */
+TEST(corrupt_pac)
+{
+       struct sigaction sa;

-       pac_corruptor();
+       ASSERT_PAUTH_ENABLED();
+       if (sigsetjmp(jmpbuf, 1) == 0) {
+               sa.sa_sigaction = pac_signal_handler;
+               sa.sa_flags = SA_SIGINFO;
+               sigemptyset(&sa.sa_mask);
+               sigaction(SIGSEGV, &sa, NULL);
+               sigaction(SIGILL, &sa, NULL);
+               pac_corruptor();
+               ASSERT_TRUE(0) TH_LOG("SIGSEGV/SIGILL signal did not 
occur");
+       }
  }

  /*
@@ -265,7 +283,7 @@ TEST(single_thread_different_keys)

                 tmp = n_same_single_set(&signed_vals, nkeys);
---------------------------------------------------------------------------------------


Thanks,
Amit Daniel

[1]: 
https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/ptrauth


Regards,
Amit Daniel
> +}
> +
> +TEST_HARNESS_MAIN

[...]
