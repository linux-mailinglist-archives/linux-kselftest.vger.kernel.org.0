Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFFFF17A082
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Mar 2020 08:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725866AbgCEHcG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Mar 2020 02:32:06 -0500
Received: from ozlabs.org ([203.11.71.1]:55377 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbgCEHcF (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Mar 2020 02:32:05 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48Y2WQ2xs3z9sPK;
        Thu,  5 Mar 2020 18:32:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1583393522;
        bh=AqqD/7BsFEb+Qk3QF29MUqu1eSjy6ruJUlUW2LliTO0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Dgl84ulZ2LAPoIca7ZyBw2dkmL+xADxZa+I8AfmyYqC1E0xR55k/k9rtG4XzEm26Q
         YWYKS3Mobc+u0snLdNHK+LBL2WlisAtIEUkrZPGX05e+iyyiJ7YzQxjND2ENPiHuvq
         CS/tK+lrFtv6aGmMLp/2UipjzBjCYSjhd9yVbTARL0F8a0eGtASYNDeyfLVhNkMEJ9
         GKVIOrsJwiGAoj1MkK3b9neMISiJc3EcNgFjXznF+F1guSesp9gowucE1VLlRRuHu0
         gkR2MBmYkjVcbc5hFbGCJEnF63iNMHwum8TBdrnJtijG+ivFMeIN+u6l5wE+6EhuHA
         0SCPlU3ykZbdA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Po-Hsu Lin <po-hsu.lin@canonical.com>,
        linux-kselftest@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        benh@kernel.crashing.org, paulus@samba.org, shuah@kernel.org
Subject: Re: [PATCH] selftests/powerpc: Turn off timeout setting for benchmarks, dscr, signal, tm
In-Reply-To: <20200304131553.27582-1-po-hsu.lin@canonical.com>
References: <20200304131553.27582-1-po-hsu.lin@canonical.com>
Date:   Thu, 05 Mar 2020 18:31:57 +1100
Message-ID: <87zhcvp89e.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Po-Hsu Lin <po-hsu.lin@canonical.com> writes:
> Some specific tests in powerpc can take longer than the default 45
> seconds that added in commit 852c8cbf (selftests/kselftest/runner.sh:
> Add 45 second timeout per test) to run, the following test result was
> collected across 2 Power8 nodes and 1 Power9 node in our pool:
>   powerpc/benchmarks/futex_bench - 52s
>   powerpc/dscr/dscr_sysfs_test - 116s
>   powerpc/signal/signal_fuzzer - 88s
>   powerpc/tm/tm_unavailable_test - 168s
>   powerpc/tm/tm-poison - 240s
>
> Thus they will fail with TIMEOUT error. Disable the timeout setting
> for these sub-tests to allow them finish properly.

I run the powerpc tests with run-parts, rather than the kselftest
script, we already have our own test runner with a 120s timeout.

I didn't think the kselftests runner actually worked with the powerpc
tests? Because we override RUN_TESTS.

cheers


> https://bugs.launchpad.net/bugs/1864642
> Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
> ---
>  tools/testing/selftests/powerpc/benchmarks/Makefile | 2 ++
>  tools/testing/selftests/powerpc/benchmarks/settings | 1 +
>  tools/testing/selftests/powerpc/dscr/Makefile       | 2 ++
>  tools/testing/selftests/powerpc/dscr/settings       | 1 +
>  tools/testing/selftests/powerpc/signal/Makefile     | 2 ++
>  tools/testing/selftests/powerpc/signal/settings     | 1 +
>  tools/testing/selftests/powerpc/tm/Makefile         | 2 ++
>  tools/testing/selftests/powerpc/tm/settings         | 1 +
>  8 files changed, 12 insertions(+)
>  create mode 100644 tools/testing/selftests/powerpc/benchmarks/settings
>  create mode 100644 tools/testing/selftests/powerpc/dscr/settings
>  create mode 100644 tools/testing/selftests/powerpc/signal/settings
>  create mode 100644 tools/testing/selftests/powerpc/tm/settings
>
> diff --git a/tools/testing/selftests/powerpc/benchmarks/Makefile b/tools/testing/selftests/powerpc/benchmarks/Makefile
> index d40300a..a32a6ab 100644
> --- a/tools/testing/selftests/powerpc/benchmarks/Makefile
> +++ b/tools/testing/selftests/powerpc/benchmarks/Makefile
> @@ -2,6 +2,8 @@
>  TEST_GEN_PROGS := gettimeofday context_switch fork mmap_bench futex_bench null_syscall
>  TEST_GEN_FILES := exec_target
>  
> +TEST_FILES := settings
> +
>  CFLAGS += -O2
>  
>  top_srcdir = ../../../../..
> diff --git a/tools/testing/selftests/powerpc/benchmarks/settings b/tools/testing/selftests/powerpc/benchmarks/settings
> new file mode 100644
> index 0000000..e7b9417
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/benchmarks/settings
> @@ -0,0 +1 @@
> +timeout=0
> diff --git a/tools/testing/selftests/powerpc/dscr/Makefile b/tools/testing/selftests/powerpc/dscr/Makefile
> index 5df4763..cfa6eed 100644
> --- a/tools/testing/selftests/powerpc/dscr/Makefile
> +++ b/tools/testing/selftests/powerpc/dscr/Makefile
> @@ -3,6 +3,8 @@ TEST_GEN_PROGS := dscr_default_test dscr_explicit_test dscr_user_test	\
>  	      dscr_inherit_test dscr_inherit_exec_test dscr_sysfs_test	\
>  	      dscr_sysfs_thread_test
>  
> +TEST_FILES := settings
> +
>  top_srcdir = ../../../../..
>  include ../../lib.mk
>  
> diff --git a/tools/testing/selftests/powerpc/dscr/settings b/tools/testing/selftests/powerpc/dscr/settings
> new file mode 100644
> index 0000000..e7b9417
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/dscr/settings
> @@ -0,0 +1 @@
> +timeout=0
> diff --git a/tools/testing/selftests/powerpc/signal/Makefile b/tools/testing/selftests/powerpc/signal/Makefile
> index 113838f..153fafc 100644
> --- a/tools/testing/selftests/powerpc/signal/Makefile
> +++ b/tools/testing/selftests/powerpc/signal/Makefile
> @@ -5,6 +5,8 @@ CFLAGS += -maltivec
>  $(OUTPUT)/signal_tm: CFLAGS += -mhtm
>  $(OUTPUT)/sigfuz: CFLAGS += -pthread -m64
>  
> +TEST_FILES := settings
> +
>  top_srcdir = ../../../../..
>  include ../../lib.mk
>  
> diff --git a/tools/testing/selftests/powerpc/signal/settings b/tools/testing/selftests/powerpc/signal/settings
> new file mode 100644
> index 0000000..e7b9417
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/signal/settings
> @@ -0,0 +1 @@
> +timeout=0
> diff --git a/tools/testing/selftests/powerpc/tm/Makefile b/tools/testing/selftests/powerpc/tm/Makefile
> index b15a1a3..7b99d09 100644
> --- a/tools/testing/selftests/powerpc/tm/Makefile
> +++ b/tools/testing/selftests/powerpc/tm/Makefile
> @@ -7,6 +7,8 @@ TEST_GEN_PROGS := tm-resched-dscr tm-syscall tm-signal-msr-resv tm-signal-stack
>  	$(SIGNAL_CONTEXT_CHK_TESTS) tm-sigreturn tm-signal-sigreturn-nt \
>  	tm-signal-context-force-tm tm-poison
>  
> +TEST_FILES := settings
> +
>  top_srcdir = ../../../../..
>  include ../../lib.mk
>  
> diff --git a/tools/testing/selftests/powerpc/tm/settings b/tools/testing/selftests/powerpc/tm/settings
> new file mode 100644
> index 0000000..e7b9417
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/tm/settings
> @@ -0,0 +1 @@
> +timeout=0
> -- 
> 2.7.4
