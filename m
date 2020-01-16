Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1970D13D23E
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2020 03:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbgAPCiA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Jan 2020 21:38:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:47878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729043AbgAPCiA (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Jan 2020 21:38:00 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 387642084D;
        Thu, 16 Jan 2020 02:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579142278;
        bh=vacKQWKRT4moqnpN5dBJ+7DYc1ik3c3rNIubWECBtk0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=M2Q9yLy6x27d7jJZuSYEBlI+q0wkTmQEqP63PDJo10kpXcDEzV3TVjfxJk9SO+itl
         +wvAkQ9xGY4ugd6YxhnH/n4raklHRTb7R4U7analnjp42m2yZXoTEG0iAIklfrFL+B
         lYEH1ailn+5v3RlWf+JWDQIymazllURnCDeLnrNU=
Date:   Thu, 16 Jan 2020 11:37:49 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, jaswinder.singh@linaro.org
Subject: Re: [BUGFIX PATCH] selftests: Fix pthread link option
Message-Id: <20200116113749.3a815c124dce18028d3d7f8a@kernel.org>
In-Reply-To: <157907976750.14189.12829891067375600434.stgit@devnote2>
References: <157907976750.14189.12829891067375600434.stgit@devnote2>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 15 Jan 2020 18:16:07 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> To support pthread correctly, it is better to use -pthread
> instead of -lpthread.

Oops, this should be refined, since LDLIBS will not be
passed when compiling. -pthread is complier option but
-lpthread is linker option.

Thank you,

> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  tools/testing/selftests/bpf/Makefile               |    2 +-
>  tools/testing/selftests/membarrier/Makefile        |    2 +-
>  tools/testing/selftests/mqueue/Makefile            |    2 +-
>  tools/testing/selftests/net/Makefile               |    4 ++--
>  .../testing/selftests/powerpc/benchmarks/Makefile  |    4 ++--
>  tools/testing/selftests/powerpc/dscr/Makefile      |    2 +-
>  tools/testing/selftests/powerpc/mm/Makefile        |    2 +-
>  tools/testing/selftests/rseq/Makefile              |    2 +-
>  tools/testing/selftests/rtc/Makefile               |    2 +-
>  tools/testing/selftests/seccomp/Makefile           |    2 +-
>  tools/testing/selftests/timers/Makefile            |    2 +-
>  tools/testing/selftests/vm/Makefile                |    2 +-
>  12 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index e2fd6f8d579c..419f58c53d12 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -22,7 +22,7 @@ CFLAGS += -g -Wall -O2 $(GENFLAGS) -I$(APIDIR) -I$(LIBDIR) -I$(BPFDIR)	\
>  	  -I$(GENDIR) -I$(TOOLSDIR) -I$(CURDIR)				\
>  	  -Dbpf_prog_load=bpf_prog_test_load				\
>  	  -Dbpf_load_program=bpf_test_load_program
> -LDLIBS += -lcap -lelf -lrt -lpthread
> +LDLIBS += -lcap -lelf -lrt -pthread
>  
>  # Order correspond to 'make run_tests' order
>  TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_lpm_map test_progs \
> diff --git a/tools/testing/selftests/membarrier/Makefile b/tools/testing/selftests/membarrier/Makefile
> index 34d1c81a2324..19d657d966e3 100644
> --- a/tools/testing/selftests/membarrier/Makefile
> +++ b/tools/testing/selftests/membarrier/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  CFLAGS += -g -I../../../../usr/include/
> -LDLIBS += -lpthread
> +LDLIBS += -pthread
>  
>  TEST_GEN_PROGS := membarrier_test_single_thread \
>  		membarrier_test_multi_thread
> diff --git a/tools/testing/selftests/mqueue/Makefile b/tools/testing/selftests/mqueue/Makefile
> index 8a58055fc1f5..9986b778b8b3 100644
> --- a/tools/testing/selftests/mqueue/Makefile
> +++ b/tools/testing/selftests/mqueue/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  CFLAGS += -O2
> -LDLIBS = -lrt -lpthread -lpopt
> +LDLIBS = -lrt -pthread -lpopt
>  
>  TEST_GEN_PROGS := mq_open_tests mq_perf_tests
>  
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index a8e04d665b69..6ad8571bb0ed 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -25,5 +25,5 @@ KSFT_KHDR_INSTALL := 1
>  include ../lib.mk
>  
>  $(OUTPUT)/reuseport_bpf_numa: LDLIBS += -lnuma
> -$(OUTPUT)/tcp_mmap: LDFLAGS += -lpthread
> -$(OUTPUT)/tcp_inq: LDFLAGS += -lpthread
> +$(OUTPUT)/tcp_mmap: LDFLAGS += -pthread
> +$(OUTPUT)/tcp_inq: LDFLAGS += -pthread
> diff --git a/tools/testing/selftests/powerpc/benchmarks/Makefile b/tools/testing/selftests/powerpc/benchmarks/Makefile
> index d40300a65b42..0d7c82d520ce 100644
> --- a/tools/testing/selftests/powerpc/benchmarks/Makefile
> +++ b/tools/testing/selftests/powerpc/benchmarks/Makefile
> @@ -11,8 +11,8 @@ $(TEST_GEN_PROGS): ../harness.c
>  
>  $(OUTPUT)/context_switch: ../utils.c
>  $(OUTPUT)/context_switch: CFLAGS += -maltivec -mvsx -mabi=altivec
> -$(OUTPUT)/context_switch: LDLIBS += -lpthread
> +$(OUTPUT)/context_switch: LDLIBS += -pthread
>  
> -$(OUTPUT)/fork: LDLIBS += -lpthread
> +$(OUTPUT)/fork: LDLIBS += -pthread
>  
>  $(OUTPUT)/exec_target: CFLAGS += -static -nostartfiles
> diff --git a/tools/testing/selftests/powerpc/dscr/Makefile b/tools/testing/selftests/powerpc/dscr/Makefile
> index 5df476364b4d..90c744592d1b 100644
> --- a/tools/testing/selftests/powerpc/dscr/Makefile
> +++ b/tools/testing/selftests/powerpc/dscr/Makefile
> @@ -6,6 +6,6 @@ TEST_GEN_PROGS := dscr_default_test dscr_explicit_test dscr_user_test	\
>  top_srcdir = ../../../../..
>  include ../../lib.mk
>  
> -$(OUTPUT)/dscr_default_test: LDLIBS += -lpthread
> +$(OUTPUT)/dscr_default_test: LDLIBS += -pthread
>  
>  $(TEST_GEN_PROGS): ../harness.c
> diff --git a/tools/testing/selftests/powerpc/mm/Makefile b/tools/testing/selftests/powerpc/mm/Makefile
> index ed1565809d2b..4cda9b0b3dd4 100644
> --- a/tools/testing/selftests/powerpc/mm/Makefile
> +++ b/tools/testing/selftests/powerpc/mm/Makefile
> @@ -20,4 +20,4 @@ $(OUTPUT)/large_vm_fork_separation: CFLAGS += -m64
>  $(OUTPUT)/tempfile:
>  	dd if=/dev/zero of=$@ bs=64k count=1
>  
> -$(OUTPUT)/tlbie_test: LDLIBS += -lpthread
> +$(OUTPUT)/tlbie_test: LDLIBS += -pthread
> diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
> index d6469535630a..3a17f5b74b9c 100644
> --- a/tools/testing/selftests/rseq/Makefile
> +++ b/tools/testing/selftests/rseq/Makefile
> @@ -6,7 +6,7 @@ endif
>  
>  CFLAGS += -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=./ \
>  	  $(CLANG_FLAGS)
> -LDLIBS += -lpthread
> +LDLIBS += -pthread
>  
>  # Own dependencies because we only want to build against 1st prerequisite, but
>  # still track changes to header files and depend on shared object.
> diff --git a/tools/testing/selftests/rtc/Makefile b/tools/testing/selftests/rtc/Makefile
> index de9c8566672a..d075ecfbe846 100644
> --- a/tools/testing/selftests/rtc/Makefile
> +++ b/tools/testing/selftests/rtc/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  CFLAGS += -O3 -Wl,-no-as-needed -Wall
> -LDFLAGS += -lrt -lpthread -lm
> +LDFLAGS += -lrt -pthread -lm
>  
>  TEST_GEN_PROGS = rtctest
>  
> diff --git a/tools/testing/selftests/seccomp/Makefile b/tools/testing/selftests/seccomp/Makefile
> index 1760b3e39730..3e35159f709a 100644
> --- a/tools/testing/selftests/seccomp/Makefile
> +++ b/tools/testing/selftests/seccomp/Makefile
> @@ -9,7 +9,7 @@ BINARIES := seccomp_bpf seccomp_benchmark
>  CFLAGS += -Wl,-no-as-needed -Wall
>  
>  seccomp_bpf: seccomp_bpf.c ../kselftest_harness.h
> -	$(CC) $(CFLAGS) $(LDFLAGS) $< -lpthread -o $@
> +	$(CC) $(CFLAGS) $(LDFLAGS) $< -pthread -o $@
>  
>  TEST_PROGS += $(BINARIES)
>  EXTRA_CLEAN := $(BINARIES)
> diff --git a/tools/testing/selftests/timers/Makefile b/tools/testing/selftests/timers/Makefile
> index 7656c7ce79d9..70461befa338 100644
> --- a/tools/testing/selftests/timers/Makefile
> +++ b/tools/testing/selftests/timers/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  CFLAGS += -O3 -Wl,-no-as-needed -Wall
> -LDLIBS += -lrt -lpthread -lm
> +LDLIBS += -lrt -pthread -lm
>  
>  # these are all "safe" tests that don't modify
>  # system time or require escalated privileges
> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
> index 7f9a8a8c31da..afb35febd7b6 100644
> --- a/tools/testing/selftests/vm/Makefile
> +++ b/tools/testing/selftests/vm/Makefile
> @@ -31,6 +31,6 @@ TEST_FILES := test_vmalloc.sh
>  KSFT_KHDR_INSTALL := 1
>  include ../lib.mk
>  
> -$(OUTPUT)/userfaultfd: LDLIBS += -lpthread
> +$(OUTPUT)/userfaultfd: LDLIBS += -pthread
>  
>  $(OUTPUT)/mlock-random-test: LDLIBS += -lcap
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
