Return-Path: <linux-kselftest+bounces-6210-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF031878412
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 16:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E24911C21805
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 15:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18FA44384;
	Mon, 11 Mar 2024 15:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZfIFWm0y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C6F446AB
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Mar 2024 15:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710171849; cv=none; b=d0sgwmR0a4n/+NRCQU4ey3LVqMte0vDbMT9f4X/2fqjXq5K2PAqNiXvLERwEDnNItWQ4+CKAet58isLrfuP8cT7fgQs47sl5Qmd2LHdLvAqIDrfLuq+rJUODQIJjaK5StN1mBL2w0Y/xZOdNy14aQBvjuJQ+YBlFuNFj+sOXbNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710171849; c=relaxed/simple;
	bh=3Oa3RsGSvdw9ieQI+DuMhaX+rlnf3IE/372p879XosA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXk4HTe/sxlpdmHWuPh2zqnya2ju0PHB7ngyiNyGhJiSXBDTpn2X8J0hXhgQhlHsxz/kLqAPh2DFliDzEQv+n0YdYjRPlgWvHMcoepeWqZU8hcahWAKOLpOMmJiRY24YeAA7cM9WtJb66GKqgkWQ6j5WZyn4emtAXEGmeDCBAGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZfIFWm0y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710171846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rjRB5OEegz21VQZYCihNrER37lmrZj8xbtZTO42XG8I=;
	b=ZfIFWm0yknduE+ec2ndnl4rnIu1xL3Y1ckUu9cU6I97aVEWkiggSWNksvW4KBSfDRj4nE9
	GNcDCksvEGYpURH03r+e5JUS1g2FrhpW1rDQqVwmfVlSzit/GoPISnHwxdFjI2hqqkKc6M
	iKd3pesKIcXnkIwyyDIe8zu/obFTdxU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-uo38N0ngN8mpz0kfr9q_vQ-1; Mon, 11 Mar 2024 11:44:05 -0400
X-MC-Unique: uo38N0ngN8mpz0kfr9q_vQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4132a5b38adso5259045e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Mar 2024 08:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710171844; x=1710776644;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjRB5OEegz21VQZYCihNrER37lmrZj8xbtZTO42XG8I=;
        b=E6D1eO5+VB8JTa/7TXtwEo2XX/jN5dw33L3ftCb7b60dU3ZwbevLTEt7N6FTSqUKR7
         GbNbRsowGOL2jgE/45Oq7ikc5bMzXt1SxDJi/Q3DefJ0PTcbNwp2bkbcikqS0+XFIFor
         brZSuuomYI6iYKEumgpV2NW/ta9m4GQYtBeCtmy62hs2HK+FiQbLqOEoMy5/ooasgFQP
         +ajwjox1GkrhzuByu2Aa/wHA2MmqB/r7Ph56mjWVe0/bc2p1zhZMmIRYyGTs2vyStjYN
         FmgLUPvA68Th68erdncbTgUOK+sJ5yhoOqBecd4DXOjctv+HHXdhKXifo1EabQmjMX4q
         KKVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKh9FgXN6ves/SRT+zYDy2nk8yrLG4aBbHWxt2gvSWd85Vx3/KYravse/3pUbUXuPRb1yDS5JiB6lFJCDqeGlIAG9wpa6oUeqW7FsIQ2o6
X-Gm-Message-State: AOJu0Yy8fpWWi1VQp/2WVyz88QK0VROv99Z71rBfz1tr1FacdSKsYsLI
	pa0TN0Ra2LfpWZzAMl/LqzMhhDCPPny+45FnUCAHKrdjzHp2zIAFwQxZitsV2HAdKpg0dtX/H3+
	XvpJnNCQR7QitqvoodtCp1ElEuLdFDcWRyAWKXFXCxOsBnAwCvq+b43x8cI5+zZjvJg==
X-Received: by 2002:a05:600c:4f50:b0:412:ee33:db93 with SMTP id m16-20020a05600c4f5000b00412ee33db93mr6523003wmq.3.1710171843996;
        Mon, 11 Mar 2024 08:44:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/5sktpvpegVaASCOlK5EL5Vy2leF+9Us9Eqe6bRgnyxbBqI746LRD6lji5z/jRDmgA1oOjQ==
X-Received: by 2002:a05:600c:4f50:b0:412:ee33:db93 with SMTP id m16-20020a05600c4f5000b00412ee33db93mr6522955wmq.3.1710171843276;
        Mon, 11 Mar 2024 08:44:03 -0700 (PDT)
Received: from redhat.com ([2.52.134.16])
        by smtp.gmail.com with ESMTPSA id fc20-20020a05600c525400b00412ae4b45b3sm15756072wmb.30.2024.03.11.08.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 08:44:02 -0700 (PDT)
Date: Mon, 11 Mar 2024 11:43:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ian Rogers <irogers@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Liam Howlett <liam.howlett@oracle.com>,
	Miguel Ojeda <ojeda@kernel.org>, Will Deacon <will@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	David Laight <David.Laight@aculab.com>,
	Shunsuke Mie <mie@igel.co.jp>, Yafang Shao <laoar.shao@gmail.com>,
	Kui-Feng Lee <kuifeng@meta.com>, James Clark <james.clark@arm.com>,
	Nick Forrington <nick.forrington@arm.com>,
	Leo Yan <leo.yan@linux.dev>, German Gomez <german.gomez@arm.com>,
	Rob Herring <robh@kernel.org>, John Garry <john.g.garry@oracle.com>,
	Sean Christopherson <seanjc@google.com>,
	Anup Patel <anup@brainfault.org>, Fuad Tabba <tabba@google.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Chao Peng <chao.p.peng@linux.intel.com>,
	Haibo Xu <haibo1.xu@intel.com>, Peter Xu <peterx@redhat.com>,
	Vishal Annapurve <vannapurve@google.com>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
	Christopher Di Bella <cjdb@google.com>
Subject: Re: [PATCH v1 13/13] tools headers: Rename noinline to __noinline
Message-ID: <20240311114009-mutt-send-email-mst@kernel.org>
References: <20240310020509.647319-1-irogers@google.com>
 <20240310020509.647319-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240310020509.647319-14-irogers@google.com>

On Sat, Mar 09, 2024 at 06:05:08PM -0800, Ian Rogers wrote:
> An issue was reported with clang and llvm libc where the noinline
> attribute [1] was being expanded due to the #define in
> linux/compiler.h (now in compiler_attributes.h). The expansion caused
> the __attribute__ to appear twice and break the build. To avoid this
> conflict, rename noinline to __noinline which is more consistent with
> other compiler attributes.
> 
> [1] https://clang.llvm.org/docs/AttributeReference.html#noinline

Following this link, I don't see __noinline there - only __noinline__ and
noinline. What's up?


Als, pls add an empty line before tags.

> Reported-by: Christopher Di Bella <cjdb@google.com>
> 
> Signed-off-by: Ian Rogers <irogers@google.com>


tags should not have empty lines between them.

> ---
>  tools/include/linux/compiler_attributes.h |  4 ++--
>  tools/perf/arch/x86/tests/bp-modify.c     |  4 ++--
>  tools/perf/bench/find-bit-bench.c         |  2 +-
>  tools/perf/tests/bp_account.c             |  2 +-
>  tools/perf/tests/bp_signal.c              |  2 +-
>  tools/perf/tests/bp_signal_overflow.c     |  2 +-
>  tools/perf/tests/dwarf-unwind.c           | 12 ++++++------
>  tools/perf/tests/workloads/leafloop.c     |  8 ++++----
>  tools/perf/tests/workloads/thloop.c       |  4 ++--
>  9 files changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/include/linux/compiler_attributes.h b/tools/include/linux/compiler_attributes.h
> index 9bfaec783e48..1ff3d85f5af3 100644
> --- a/tools/include/linux/compiler_attributes.h
> +++ b/tools/include/linux/compiler_attributes.h
> @@ -267,12 +267,12 @@
>  # define __flatten			__attribute__((flatten))
>  
>  /*
> - * Note the missing underscores.
> + * Note, the kernel version is missing the underscores.
>   *
>   *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-noinline-function-attribute
>   * clang: mentioned
>   */
> -#define   noinline                      __attribute__((__noinline__))
> +#define   __noinline                      __attribute__((__noinline__))
>  
>  /*
>   * Optional: only supported since gcc >= 8
> diff --git a/tools/perf/arch/x86/tests/bp-modify.c b/tools/perf/arch/x86/tests/bp-modify.c
> index 0924ccd9e36d..65493ff7a76f 100644
> --- a/tools/perf/arch/x86/tests/bp-modify.c
> +++ b/tools/perf/arch/x86/tests/bp-modify.c
> @@ -15,13 +15,13 @@
>  #include "tests/tests.h"
>  #include "arch-tests.h"
>  
> -static noinline int bp_1(void)
> +static __noinline int bp_1(void)
>  {
>  	pr_debug("in %s\n", __func__);
>  	return 0;
>  }
>  
> -static noinline int bp_2(void)
> +static __noinline int bp_2(void)
>  {
>  	pr_debug("in %s\n", __func__);
>  	return 0;
> diff --git a/tools/perf/bench/find-bit-bench.c b/tools/perf/bench/find-bit-bench.c
> index 7e25b0e413f6..dd97a51649bc 100644
> --- a/tools/perf/bench/find-bit-bench.c
> +++ b/tools/perf/bench/find-bit-bench.c
> @@ -31,7 +31,7 @@ static const char *const bench_usage[] = {
>  static unsigned int accumulator;
>  static unsigned int use_of_val;
>  
> -static noinline void workload(int val)
> +static __noinline void workload(int val)
>  {
>  	use_of_val += val;
>  	accumulator++;
> diff --git a/tools/perf/tests/bp_account.c b/tools/perf/tests/bp_account.c
> index 6f921db33cf9..459f61752a71 100644
> --- a/tools/perf/tests/bp_account.c
> +++ b/tools/perf/tests/bp_account.c
> @@ -34,7 +34,7 @@
>  
>  static volatile long the_var;
>  
> -static noinline int test_function(void)
> +static __noinline int test_function(void)
>  {
>  	return 0;
>  }
> diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
> index 1f2908f02389..484a7e7f96ee 100644
> --- a/tools/perf/tests/bp_signal.c
> +++ b/tools/perf/tests/bp_signal.c
> @@ -59,7 +59,7 @@ static void __test_function(volatile long *ptr)
>  }
>  #endif
>  
> -static noinline int test_function(void)
> +static __noinline int test_function(void)
>  {
>  	__test_function(&the_var);
>  	the_var++;
> diff --git a/tools/perf/tests/bp_signal_overflow.c b/tools/perf/tests/bp_signal_overflow.c
> index 4e897c2cf26b..9436bf2973f8 100644
> --- a/tools/perf/tests/bp_signal_overflow.c
> +++ b/tools/perf/tests/bp_signal_overflow.c
> @@ -30,7 +30,7 @@
>  
>  static int overflows;
>  
> -static noinline int test_function(void)
> +static __noinline int test_function(void)
>  {
>  	return time(NULL);
>  }
> diff --git a/tools/perf/tests/dwarf-unwind.c b/tools/perf/tests/dwarf-unwind.c
> index d01aa931fe81..a669c69a9242 100644
> --- a/tools/perf/tests/dwarf-unwind.c
> +++ b/tools/perf/tests/dwarf-unwind.c
> @@ -109,7 +109,7 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
>  	return strcmp((const char *) symbol, funcs[idx]);
>  }
>  
> -NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__thread(struct thread *thread)
> +NO_TAIL_CALL_ATTRIBUTE __noinline int test_dwarf_unwind__thread(struct thread *thread)
>  {
>  	struct perf_sample sample;
>  	unsigned long cnt = 0;
> @@ -140,7 +140,7 @@ NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__thread(struct thread *thr
>  
>  static int global_unwind_retval = -INT_MAX;
>  
> -NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__compare(void *p1, void *p2)
> +NO_TAIL_CALL_ATTRIBUTE __noinline int test_dwarf_unwind__compare(void *p1, void *p2)
>  {
>  	/* Any possible value should be 'thread' */
>  	struct thread *thread = *(struct thread **)p1;
> @@ -159,7 +159,7 @@ NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__compare(void *p1, void *p
>  	return p1 - p2;
>  }
>  
> -NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__krava_3(struct thread *thread)
> +NO_TAIL_CALL_ATTRIBUTE __noinline int test_dwarf_unwind__krava_3(struct thread *thread)
>  {
>  	struct thread *array[2] = {thread, thread};
>  	void *fp = &bsearch;
> @@ -178,7 +178,7 @@ NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__krava_3(struct thread *th
>  	return global_unwind_retval;
>  }
>  
> -NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__krava_2(struct thread *thread)
> +NO_TAIL_CALL_ATTRIBUTE __noinline int test_dwarf_unwind__krava_2(struct thread *thread)
>  {
>  	int ret;
>  
> @@ -187,7 +187,7 @@ NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__krava_2(struct thread *th
>  	return ret;
>  }
>  
> -NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__krava_1(struct thread *thread)
> +NO_TAIL_CALL_ATTRIBUTE __noinline int test_dwarf_unwind__krava_1(struct thread *thread)
>  {
>  	int ret;
>  
> @@ -196,7 +196,7 @@ NO_TAIL_CALL_ATTRIBUTE noinline int test_dwarf_unwind__krava_1(struct thread *th
>  	return ret;
>  }
>  
> -noinline int test__dwarf_unwind(struct test_suite *test __maybe_unused,
> +__noinline int test__dwarf_unwind(struct test_suite *test __maybe_unused,
>  				int subtest __maybe_unused)
>  {
>  	struct machine *machine;
> diff --git a/tools/perf/tests/workloads/leafloop.c b/tools/perf/tests/workloads/leafloop.c
> index 1bf5cc97649b..89d2cec2f461 100644
> --- a/tools/perf/tests/workloads/leafloop.c
> +++ b/tools/perf/tests/workloads/leafloop.c
> @@ -4,18 +4,18 @@
>  #include "../tests.h"
>  
>  /* We want to check these symbols in perf script */
> -noinline void leaf(volatile int b);
> -noinline void parent(volatile int b);
> +__noinline void leaf(volatile int b);
> +__noinline void parent(volatile int b);
>  
>  static volatile int a;
>  
> -noinline void leaf(volatile int b)
> +__noinline void leaf(volatile int b)
>  {
>  	for (;;)
>  		a += b;
>  }
>  
> -noinline void parent(volatile int b)
> +__noinline void parent(volatile int b)
>  {
>  	leaf(b);
>  }
> diff --git a/tools/perf/tests/workloads/thloop.c b/tools/perf/tests/workloads/thloop.c
> index 457b29f91c3e..e252efb76203 100644
> --- a/tools/perf/tests/workloads/thloop.c
> +++ b/tools/perf/tests/workloads/thloop.c
> @@ -9,14 +9,14 @@
>  static volatile sig_atomic_t done;
>  
>  /* We want to check this symbol in perf report */
> -noinline void test_loop(void);
> +__noinline void test_loop(void);
>  
>  static void sighandler(int sig __maybe_unused)
>  {
>  	done = 1;
>  }
>  
> -noinline void test_loop(void)
> +__noinline void test_loop(void)
>  {
>  	while (!done);
>  }
> -- 
> 2.44.0.278.ge034bb2e1d-goog


