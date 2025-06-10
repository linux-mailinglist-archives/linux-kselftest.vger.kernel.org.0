Return-Path: <linux-kselftest+bounces-34552-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 097F0AD34FF
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 13:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCDC0170EB6
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 11:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF62E284B45;
	Tue, 10 Jun 2025 11:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DeL3CZN/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21D422618F
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Jun 2025 11:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749555167; cv=none; b=KcTUHJWWC1x0cOdYxIp+C3c6UTzwpEPJFmWmXmpRfcp1OYjKnbvDPo6cC4wJn9eO9Zn5kHQjpFR0hFNkbSn1gr+eXfirR5W/EGoOlsis7sf1N4jdpqMi54x1Te3tdjQifO6cdVST193CBxyrl1KNs+n1s9+qBGm078Yos0FRyyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749555167; c=relaxed/simple;
	bh=efC6ujhURBe1LNU/whdigYOIEGZMKVHBT8P9GDnvjew=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UXzEDjTt1S9hAruvSztTbwzG2WIx7Bh9BdCUQGSi+9HWS27by8yz/4kfI7yspQeRkbVEHJpawXkIkWYGedijZYWYKunz7OeLRUic9kee8MACdEtsDIdPtaKZ5rGhpVvN6XiUxyMYMqAOAPd9zhdySCRRgm9QccE0S8OCwlDQUNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DeL3CZN/; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-450cb8ff0c6so26899235e9.3
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Jun 2025 04:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749555162; x=1750159962; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8h4+gPMuoCrrBlMZnw5tNBVBaNd2ktMqdpZbc7FNAG4=;
        b=DeL3CZN/zhgsckG3J758+Y2R8jjZyfCPNeQdkh8vM2V7gM+6F5HbdI6saH3ig/cQok
         IF0HHfg73z+AGF1oMMi+yepV2sLYgVPkFhFngcaUssakDz4Gt+hxTI0p60FEZ9z8+8mA
         3fbsqNAMnuMjTI6i09MTupRnrehQI/DVEYpQCgethdKOkdD5DnMKEl5RhRm3H7wHQz3u
         F1Tt51VW+HOxsw9XLsjzll7szWUzB5iOtxiKHZ/TozsnHoNKqiTGkUCv5k73UCNnFqT6
         uSe5a2sLKhQ8ONhoiDWfKslvAfRUvEJF53xGrcwUovgEufN+Kk6upA+h/J9XCPfMpK1B
         79Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749555162; x=1750159962;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8h4+gPMuoCrrBlMZnw5tNBVBaNd2ktMqdpZbc7FNAG4=;
        b=hw4Mt7gmzYmmwfu6CtOB8W7wJVVyKeRkc2FbV+XtxClLPh2O0Zc16Pt1yU41OBfNXf
         evTbX+Ys499/eLkDP9ZcBc/bAeo83U7SJEcbaVRA8AQzRHwg9bhrVPwVn7jmwiXKuVJe
         v0XTn95cxU31oyIkqSbUHcsHWr5oJCwcbO+fs1x8vcfy5w5Ak8e/NQzu//gPN0al7ZXL
         zZkUaRB4SLU6eb6xNAJTySNZ8MSGmgZGEg1aJ5E1gzj+7urYAWRvmw1MH8wgf6NMjjus
         YppKV1zQ8ZTGF5TrYNrV9Z9juGtERXqeYe1RIu5JPTNjE9brkzA4CjPPjNA6BdwtSjdt
         HK6w==
X-Forwarded-Encrypted: i=1; AJvYcCV4+Ql2YIExW3D6zWILvPnXLhX9HmV2IgbA3p/cC7WZ94w1mToTkup77dABR/7ZCZ4Gs8XGtxkbUY6+MrF6lLI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq5BUSL/pWPrTVhJ94PsaU7UWfK52/lN0PsvV2GRdlPN0vuKRH
	m9hr8285gulomIRMQsAiVSsS6p5lo3jbmDeFlYoLQS42P+Gt2wGOO5GGSMtHxUBgrsnGPbrn+R0
	oe43Hl2TCgQPeCg==
X-Google-Smtp-Source: AGHT+IHDbuxXqBl4mQsgCjgbX+PslEMVOxQLNWRbMdPmFNaazytU3kBsz7rpI2bUgpGx1Z086Ftr3fgo1gjUHg==
X-Received: from wmbay35.prod.google.com ([2002:a05:600c:1e23:b0:43c:faa1:bb58])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5395:b0:439:9424:1b70 with SMTP id 5b1f17b1804b1-452014ea7edmr161216955e9.30.1749555162193;
 Tue, 10 Jun 2025 04:32:42 -0700 (PDT)
Date: Tue, 10 Jun 2025 11:32:40 +0000
In-Reply-To: <20250531074625.478-1-ujwal.kundur@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250501163827.2598-1-ujwal.kundur@gmail.com> <20250531074625.478-1-ujwal.kundur@gmail.com>
X-Mailer: aerc 0.20.1
Message-ID: <DAITJKYRQMFD.OLOUWS7UPGVD@google.com>
Subject: Re: [PATCH v4 1/1] selftests/mm/uffd: Refactor non-composite global
 vars into struct
From: Brendan Jackman <jackmanb@google.com>
To: Ujwal Kundur <ujwal.kundur@gmail.com>, <akpm@linux-foundation.org>, 
	<peterx@redhat.com>, <shuah@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, 
	<linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"

On Sat May 31, 2025 at 7:46 AM UTC, Ujwal Kundur wrote:
> Refactor macros and non-composite global variable definitions into a
> struct that is defined at the start of a test and is passed around
> instead of relying on global vars.
>
> Renders the implementation / use of test_uffdio_copy_eexist
> vestigial and will be addressed in a later patch.
>
> Signed-off-by: Ujwal Kundur <ujwal.kundur@gmail.com>

I applied this to f09079bd04a92 and tested it using this janky script:

https://github.com/bjackman/linux/blob/github-base/.github/scripts/run_local.sh

With this file modified to un-comment userfaultfd:

https://github.com/bjackman/linux/blob/github-base/.github/scripts/test.guest.sh

And I hit this:

# -------------------------
# running ./uffd-unit-tests
# -------------------------
# Testing UFFDIO_API (with syscall)... done
# Testing UFFDIO_API (with /dev/userfaultfd)... done
# Testing register-ioctls on anon... ERROR: munmap (errno=22, @uffd-common.c:277)
# done
# [FAIL]
not ok 6 uffd-unit-tests # exit=1

It reproduced on a second run but I haven't dug any further at all.

> ---
>  Changes since v3:
>  - more formatting fixes

Thanks, code LGTM except for the below...

>  static void sigalrm(int sig)
>  {
>  	if (sig != SIGALRM)
>  		abort();
> -	test_uffdio_copy_eexist = true;
> +	/* TODO: Remove or fix this test */
> +	// gopts->test_uffdio_copy_eexist = true;

Er I still think we need to clean this up before merging.

I am still being very lazy here and not researching this properly, but I
would suggest that we just leave this SIGALRM logic in place (as I said
before I don't mean I _like_ that logic, I just mean we should not
change it as part of an otherwise-straightforward refactoring series).

Since signal handlers are truly global I would say we should just keep
the global variable for communicating between main() and the handler,
e.g:

/*
 * A SIGALRM handler will set the test_uffdio_copy_eexist field of this struct
 * to true every ALARM_INTERVAL_SECS.
 */
uffd_global_test_opts_t *sigalrm_gopts;

static void sigalrm(int sig)
{
	if (sig != SIGALRM)
		abort();
	sigalrm_->test_uffdio_copy_eexist = true;
	alarm(ALARM_INTERVAL_SECS);
}

int main(int argc, char **argv)
{
	unsigned long nr_cpus;
	size_t bytes;

	uffd_global_test_opts_t *gopts =
		(uffd_global_test_opts_t *) malloc(sizeof(uffd_global_test_opts_t));

	if (argc < 4)
		usage();

	sigalrm_gopts = gopts;
	if (signal(SIGALRM, sigalrm) == SIG_ERR)
		err("failed to arm SIGALRM");
	alarm(ALARM_INTERVAL_SECS);

On the surface this has somewhat walked back on the "get rid of global
variables" goal but actually it's still a massive improvement, the
global is only in scope in the places where it's actually needed so it
doesn't create a maintenance mess, and note in particular there' no
longer any references to it from a header file. Commentary can be used
to discourage people from expanding its scope.

Then in a later series it could be removed by one of the methods you
mentioned in:

https://lore.kernel.org/all/CALkFLLK19Uqr2veWCn79cbLLgde5f+otf9Qx0xSPGdhdnekGrw@mail.gmail.com/

>  	alarm(ALARM_INTERVAL_SECS);
>  }
>
> @@ -438,6 +451,9 @@ int main(int argc, char **argv)
>  	unsigned long nr_cpus;
>  	size_t bytes;
>
> +	uffd_global_test_opts_t *gopts =
> +		(uffd_global_test_opts_t *) malloc(sizeof(uffd_global_test_opts_t));
> +
>  	if (argc < 4)
>  		usage();
>
> @@ -445,11 +461,11 @@ int main(int argc, char **argv)
>  		err("failed to arm SIGALRM");
>  	alarm(ALARM_INTERVAL_SECS);
>
> -	parse_test_type_arg(argv[1]);
> +	parse_test_type_arg(gopts, argv[1]);
>  	bytes = atol(argv[2]) * 1024 * 1024;
>
> -	if (test_type == TEST_HUGETLB &&
> -	   get_free_hugepages() < bytes / page_size) {
> +	if (gopts->test_type == TEST_HUGETLB &&
> +	   get_free_hugepages() < bytes / gopts->page_size) {
>  		printf("skip: Skipping userfaultfd... not enough hugepages\n");
>  		return KSFT_SKIP;
>  	}
> @@ -459,15 +475,15 @@ int main(int argc, char **argv)
>  		/* Don't let calculation below go to zero. */
>  		ksft_print_msg("_SC_NPROCESSORS_ONLN (%lu) too large, capping nr_threads to 32\n",
>  			       nr_cpus);
> -		nr_parallel = 32;
> +		gopts->nr_parallel = 32;
>  	} else {
> -		nr_parallel = nr_cpus;
> +		gopts->nr_parallel = nr_cpus;
>  	}
>
> -	nr_pages_per_cpu = bytes / page_size / nr_parallel;
> -	if (!nr_pages_per_cpu) {
> +	gopts->nr_pages_per_cpu = bytes / gopts->page_size / gopts->nr_parallel;
> +	if (!gopts->nr_pages_per_cpu) {
>  		_err("pages_per_cpu = 0, cannot test (%lu / %lu / %lu)",
> -			bytes, page_size, nr_parallel);
> +			bytes, gopts->page_size, gopts->nr_parallel);
>  		usage();
>  	}
>
> @@ -476,11 +492,11 @@ int main(int argc, char **argv)
>  		_err("invalid bounces");
>  		usage();
>  	}
> -	nr_pages = nr_pages_per_cpu * nr_parallel;
> +	gopts->nr_pages = gopts->nr_pages_per_cpu * gopts->nr_parallel;
>
>  	printf("nr_pages: %lu, nr_pages_per_cpu: %lu\n",
> -	       nr_pages, nr_pages_per_cpu);
> -	return userfaultfd_stress();
> +	       gopts->nr_pages, gopts->nr_pages_per_cpu);
> +	return userfaultfd_stress(gopts);
>  }
>
>  #else /* __NR_userfaultfd */
> diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
> index c73fd5d455c8..bed96f41c578 100644
> --- a/tools/testing/selftests/mm/uffd-unit-tests.c
> +++ b/tools/testing/selftests/mm/uffd-unit-tests.c
> @@ -76,7 +76,7 @@ struct uffd_test_args {
>  typedef struct uffd_test_args uffd_test_args_t;
>
>  /* Returns: UFFD_TEST_* */
> -typedef void (*uffd_test_fn)(uffd_test_args_t *);
> +typedef void (*uffd_test_fn)(uffd_global_test_opts_t *, uffd_test_args_t *);
>
>  typedef struct {
>  	const char *name;
> @@ -181,33 +181,6 @@ static int test_uffd_api(bool use_dev)
>  	return 1;
>  }
>
> -/*
> - * This function initializes the global variables.  TODO: remove global
> - * vars and then remove this.
> - */
> -static int
> -uffd_setup_environment(uffd_test_args_t *args, uffd_test_case_t *test,
> -		       mem_type_t *mem_type, const char **errmsg)
> -{
> -	map_shared = mem_type->shared;
> -	uffd_test_ops = mem_type->mem_ops;
> -	uffd_test_case_ops = test->test_case_ops;
> -
> -	if (mem_type->mem_flag & (MEM_HUGETLB_PRIVATE | MEM_HUGETLB))
> -		page_size = default_huge_page_size();
> -	else
> -		page_size = psize();
> -
> -	/* Ensure we have at least 2 pages */
> -	nr_pages = MAX(UFFD_TEST_MEM_SIZE, page_size * 2) / page_size;
> -	/* TODO: remove this global var.. it's so ugly */
> -	nr_parallel = 1;
> -
> -	/* Initialize test arguments */
> -	args->mem_type = mem_type;
> -
> -	return uffd_test_ctx_init(test->uffd_feature_required, errmsg);
> -}
>
>  static bool uffd_feature_supported(uffd_test_case_t *test)
>  {
> @@ -237,7 +210,8 @@ static int pagemap_open(void)
>  	} while (0)
>
>  typedef struct {
> -	int parent_uffd, child_uffd;
> +	uffd_global_test_opts_t *gopts;
> +	int child_uffd;
>  } fork_event_args;
>
>  static void *fork_event_consumer(void *data)
> @@ -245,10 +219,10 @@ static void *fork_event_consumer(void *data)
>  	fork_event_args *args = data;
>  	struct uffd_msg msg = { 0 };
>
> -	ready_for_fork = true;
> +	args->gopts->ready_for_fork = true;
>
>  	/* Read until a full msg received */
> -	while (uffd_read_msg(args->parent_uffd, &msg));
> +	while (uffd_read_msg(args->gopts, &msg));
>
>  	if (msg.event != UFFD_EVENT_FORK)
>  		err("wrong message: %u\n", msg.event);
> @@ -304,9 +278,9 @@ static void unpin_pages(pin_args *args)
>  	args->pinned = false;
>  }
>
> -static int pagemap_test_fork(int uffd, bool with_event, bool test_pin)
> +static int pagemap_test_fork(uffd_global_test_opts_t *gopts, bool with_event, bool test_pin)
>  {
> -	fork_event_args args = { .parent_uffd = uffd, .child_uffd = -1 };
> +	fork_event_args args = { .gopts = gopts, .child_uffd = -1 };
>  	pthread_t thread;
>  	pid_t child;
>  	uint64_t value;
> @@ -314,10 +288,10 @@ static int pagemap_test_fork(int uffd, bool with_event, bool test_pin)
>
>  	/* Prepare a thread to resolve EVENT_FORK */
>  	if (with_event) {
> -		ready_for_fork = false;
> +		gopts->ready_for_fork = false;
>  		if (pthread_create(&thread, NULL, fork_event_consumer, &args))
>  			err("pthread_create()");
> -		while (!ready_for_fork)
> +		while (!gopts->ready_for_fork)
>  			; /* Wait for the poll_thread to start executing before forking */
>  	}
>
> @@ -328,14 +302,14 @@ static int pagemap_test_fork(int uffd, bool with_event, bool test_pin)
>
>  		fd = pagemap_open();
>
> -		if (test_pin && pin_pages(&args, area_dst, page_size))
> +		if (test_pin && pin_pages(&args, gopts->area_dst, gopts->page_size))
>  			/*
>  			 * Normally when reach here we have pinned in
>  			 * previous tests, so shouldn't fail anymore
>  			 */
>  			err("pin page failed in child");
>
> -		value = pagemap_get_entry(fd, area_dst);
> +		value = pagemap_get_entry(fd, gopts->area_dst);
>  		/*
>  		 * After fork(), we should handle uffd-wp bit differently:
>  		 *
> @@ -361,70 +335,70 @@ static int pagemap_test_fork(int uffd, bool with_event, bool test_pin)
>  	return result;
>  }
>
> -static void uffd_wp_unpopulated_test(uffd_test_args_t *args)
> +static void uffd_wp_unpopulated_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *args)
>  {
>  	uint64_t value;
>  	int pagemap_fd;
>
> -	if (uffd_register(uffd, area_dst, nr_pages * page_size,
> +	if (uffd_register(gopts->uffd, gopts->area_dst, gopts->nr_pages * gopts->page_size,
>  			  false, true, false))
>  		err("register failed");
>
>  	pagemap_fd = pagemap_open();
>
>  	/* Test applying pte marker to anon unpopulated */
> -	wp_range(uffd, (uint64_t)area_dst, page_size, true);
> -	value = pagemap_get_entry(pagemap_fd, area_dst);
> +	wp_range(gopts->uffd, (uint64_t)gopts->area_dst, gopts->page_size, true);
> +	value = pagemap_get_entry(pagemap_fd, gopts->area_dst);
>  	pagemap_check_wp(value, true);
>
>  	/* Test unprotect on anon pte marker */
> -	wp_range(uffd, (uint64_t)area_dst, page_size, false);
> -	value = pagemap_get_entry(pagemap_fd, area_dst);
> +	wp_range(gopts->uffd, (uint64_t)gopts->area_dst, gopts->page_size, false);
> +	value = pagemap_get_entry(pagemap_fd, gopts->area_dst);
>  	pagemap_check_wp(value, false);
>
>  	/* Test zap on anon marker */
> -	wp_range(uffd, (uint64_t)area_dst, page_size, true);
> -	if (madvise(area_dst, page_size, MADV_DONTNEED))
> +	wp_range(gopts->uffd, (uint64_t)gopts->area_dst, gopts->page_size, true);
> +	if (madvise(gopts->area_dst, gopts->page_size, MADV_DONTNEED))
>  		err("madvise(MADV_DONTNEED) failed");
> -	value = pagemap_get_entry(pagemap_fd, area_dst);
> +	value = pagemap_get_entry(pagemap_fd, gopts->area_dst);
>  	pagemap_check_wp(value, false);
>
>  	/* Test fault in after marker removed */
> -	*area_dst = 1;
> -	value = pagemap_get_entry(pagemap_fd, area_dst);
> +	*gopts->area_dst = 1;
> +	value = pagemap_get_entry(pagemap_fd, gopts->area_dst);
>  	pagemap_check_wp(value, false);
>  	/* Drop it to make pte none again */
> -	if (madvise(area_dst, page_size, MADV_DONTNEED))
> +	if (madvise(gopts->area_dst, gopts->page_size, MADV_DONTNEED))
>  		err("madvise(MADV_DONTNEED) failed");
>
>  	/* Test read-zero-page upon pte marker */
> -	wp_range(uffd, (uint64_t)area_dst, page_size, true);
> -	*(volatile char *)area_dst;
> +	wp_range(gopts->uffd, (uint64_t)gopts->area_dst, gopts->page_size, true);
> +	*(volatile char *)gopts->area_dst;
>  	/* Drop it to make pte none again */
> -	if (madvise(area_dst, page_size, MADV_DONTNEED))
> +	if (madvise(gopts->area_dst, gopts->page_size, MADV_DONTNEED))
>  		err("madvise(MADV_DONTNEED) failed");
>
>  	uffd_test_pass();
>  }
>
> -static void uffd_wp_fork_test_common(uffd_test_args_t *args,
> +static void uffd_wp_fork_test_common(uffd_global_test_opts_t *gopts, uffd_test_args_t *args,
>  				     bool with_event)
>  {
>  	int pagemap_fd;
>  	uint64_t value;
>
> -	if (uffd_register(uffd, area_dst, nr_pages * page_size,
> +	if (uffd_register(gopts->uffd, gopts->area_dst, gopts->nr_pages * gopts->page_size,
>  			  false, true, false))
>  		err("register failed");
>
>  	pagemap_fd = pagemap_open();
>
>  	/* Touch the page */
> -	*area_dst = 1;
> -	wp_range(uffd, (uint64_t)area_dst, page_size, true);
> -	value = pagemap_get_entry(pagemap_fd, area_dst);
> +	*gopts->area_dst = 1;
> +	wp_range(gopts->uffd, (uint64_t)gopts->area_dst, gopts->page_size, true);
> +	value = pagemap_get_entry(pagemap_fd, gopts->area_dst);
>  	pagemap_check_wp(value, true);
> -	if (pagemap_test_fork(uffd, with_event, false)) {
> +	if (pagemap_test_fork(gopts, with_event, false)) {
>  		uffd_test_fail("Detected %s uffd-wp bit in child in present pte",
>  			       with_event ? "missing" : "stall");
>  		goto out;
> @@ -442,79 +416,80 @@ static void uffd_wp_fork_test_common(uffd_test_args_t *args,
>  	 * to expose pte markers.
>  	 */
>  	if (args->mem_type->shared) {
> -		if (madvise(area_dst, page_size, MADV_DONTNEED))
> +		if (madvise(gopts->area_dst, gopts->page_size, MADV_DONTNEED))
>  			err("MADV_DONTNEED");
>  	} else {
>  		/*
>  		 * NOTE: ignore retval because private-hugetlb doesn't yet
>  		 * support swapping, so it could fail.
>  		 */
> -		madvise(area_dst, page_size, MADV_PAGEOUT);
> +		madvise(gopts->area_dst, gopts->page_size, MADV_PAGEOUT);
>  	}
>
>  	/* Uffd-wp should persist even swapped out */
> -	value = pagemap_get_entry(pagemap_fd, area_dst);
> +	value = pagemap_get_entry(pagemap_fd, gopts->area_dst);
>  	pagemap_check_wp(value, true);
> -	if (pagemap_test_fork(uffd, with_event, false)) {
> +	if (pagemap_test_fork(gopts, with_event, false)) {
>  		uffd_test_fail("Detected %s uffd-wp bit in child in zapped pte",
>  			       with_event ? "missing" : "stall");
>  		goto out;
>  	}
>
>  	/* Unprotect; this tests swap pte modifications */
> -	wp_range(uffd, (uint64_t)area_dst, page_size, false);
> -	value = pagemap_get_entry(pagemap_fd, area_dst);
> +	wp_range(gopts->uffd, (uint64_t)gopts->area_dst, gopts->page_size, false);
> +	value = pagemap_get_entry(pagemap_fd, gopts->area_dst);
>  	pagemap_check_wp(value, false);
>
>  	/* Fault in the page from disk */
> -	*area_dst = 2;
> -	value = pagemap_get_entry(pagemap_fd, area_dst);
> +	*gopts->area_dst = 2;
> +	value = pagemap_get_entry(pagemap_fd, gopts->area_dst);
>  	pagemap_check_wp(value, false);
>  	uffd_test_pass();
>  out:
> -	if (uffd_unregister(uffd, area_dst, nr_pages * page_size))
> +	if (uffd_unregister(gopts->uffd, gopts->area_dst, gopts->nr_pages * gopts->page_size))
>  		err("unregister failed");
>  	close(pagemap_fd);
>  }
>
> -static void uffd_wp_fork_test(uffd_test_args_t *args)
> +static void uffd_wp_fork_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *args)
>  {
> -	uffd_wp_fork_test_common(args, false);
> +	uffd_wp_fork_test_common(gopts, args, false);
>  }
>
> -static void uffd_wp_fork_with_event_test(uffd_test_args_t *args)
> +static void uffd_wp_fork_with_event_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *args)
>  {
> -	uffd_wp_fork_test_common(args, true);
> +	uffd_wp_fork_test_common(gopts, args, true);
>  }
>
> -static void uffd_wp_fork_pin_test_common(uffd_test_args_t *args,
> +static void uffd_wp_fork_pin_test_common(uffd_global_test_opts_t *gopts,
> +					 uffd_test_args_t *args,
>  					 bool with_event)
>  {
>  	int pagemap_fd;
>  	pin_args pin_args = {};
>
> -	if (uffd_register(uffd, area_dst, page_size, false, true, false))
> +	if (uffd_register(gopts->uffd, gopts->area_dst, gopts->page_size, false, true, false))
>  		err("register failed");
>
>  	pagemap_fd = pagemap_open();
>
>  	/* Touch the page */
> -	*area_dst = 1;
> -	wp_range(uffd, (uint64_t)area_dst, page_size, true);
> +	*gopts->area_dst = 1;
> +	wp_range(gopts->uffd, (uint64_t)gopts->area_dst, gopts->page_size, true);
>
>  	/*
>  	 * 1. First pin, then fork().  This tests fork() special path when
>  	 * doing early CoW if the page is private.
>  	 */
> -	if (pin_pages(&pin_args, area_dst, page_size)) {
> +	if (pin_pages(&pin_args, gopts->area_dst, gopts->page_size)) {
>  		uffd_test_skip("Possibly CONFIG_GUP_TEST missing "
>  			       "or unprivileged");
>  		close(pagemap_fd);
> -		uffd_unregister(uffd, area_dst, page_size);
> +		uffd_unregister(gopts->uffd, gopts->area_dst, gopts->page_size);
>  		return;
>  	}
>
> -	if (pagemap_test_fork(uffd, with_event, false)) {
> +	if (pagemap_test_fork(gopts, with_event, false)) {
>  		uffd_test_fail("Detected %s uffd-wp bit in early CoW of fork()",
>  			       with_event ? "missing" : "stall");
>  		unpin_pages(&pin_args);
> @@ -527,49 +502,50 @@ static void uffd_wp_fork_pin_test_common(uffd_test_args_t *args,
>  	 * 2. First fork(), then pin (in the child, where test_pin==true).
>  	 * This tests COR, aka, page unsharing on private memories.
>  	 */
> -	if (pagemap_test_fork(uffd, with_event, true)) {
> +	if (pagemap_test_fork(gopts, with_event, true)) {
>  		uffd_test_fail("Detected %s uffd-wp bit when RO pin",
>  			       with_event ? "missing" : "stall");
>  		goto out;
>  	}
>  	uffd_test_pass();
>  out:
> -	if (uffd_unregister(uffd, area_dst, page_size))
> +	if (uffd_unregister(gopts->uffd, gopts->area_dst, gopts->page_size))
>  		err("register failed");
>  	close(pagemap_fd);
>  }
>
> -static void uffd_wp_fork_pin_test(uffd_test_args_t *args)
> +static void uffd_wp_fork_pin_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *args)
>  {
> -	uffd_wp_fork_pin_test_common(args, false);
> +	uffd_wp_fork_pin_test_common(gopts, args, false);
>  }
>
> -static void uffd_wp_fork_pin_with_event_test(uffd_test_args_t *args)
> +static void uffd_wp_fork_pin_with_event_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *args)
>  {
> -	uffd_wp_fork_pin_test_common(args, true);
> +	uffd_wp_fork_pin_test_common(gopts, args, true);
>  }
>
> -static void check_memory_contents(char *p)
> +static void check_memory_contents(uffd_global_test_opts_t *gopts, char *p)
>  {
>  	unsigned long i, j;
>  	uint8_t expected_byte;
>
> -	for (i = 0; i < nr_pages; ++i) {
> +	for (i = 0; i < gopts->nr_pages; ++i) {
>  		expected_byte = ~((uint8_t)(i % ((uint8_t)-1)));
> -		for (j = 0; j < page_size; j++) {
> -			uint8_t v = *(uint8_t *)(p + (i * page_size) + j);
> +		for (j = 0; j < gopts->page_size; j++) {
> +			uint8_t v = *(uint8_t *)(p + (i * gopts->page_size) + j);
>  			if (v != expected_byte)
>  				err("unexpected page contents");
>  		}
>  	}
>  }
>
> -static void uffd_minor_test_common(bool test_collapse, bool test_wp)
> +static void uffd_minor_test_common(uffd_global_test_opts_t *gopts, bool test_collapse, bool test_wp)
>  {
>  	unsigned long p;
>  	pthread_t uffd_mon;
>  	char c;
>  	struct uffd_args args = { 0 };
> +	args.gopts = gopts;
>
>  	/*
>  	 * NOTE: MADV_COLLAPSE is not yet compatible with WP, so testing
> @@ -577,7 +553,7 @@ static void uffd_minor_test_common(bool test_collapse, bool test_wp)
>  	 */
>  	assert(!(test_collapse && test_wp));
>
> -	if (uffd_register(uffd, area_dst_alias, nr_pages * page_size,
> +	if (uffd_register(gopts->uffd, gopts->area_dst_alias, gopts->nr_pages * gopts->page_size,
>  			  /* NOTE! MADV_COLLAPSE may not work with uffd-wp */
>  			  false, test_wp, true))
>  		err("register failure");
> @@ -586,9 +562,9 @@ static void uffd_minor_test_common(bool test_collapse, bool test_wp)
>  	 * After registering with UFFD, populate the non-UFFD-registered side of
>  	 * the shared mapping. This should *not* trigger any UFFD minor faults.
>  	 */
> -	for (p = 0; p < nr_pages; ++p)
> -		memset(area_dst + (p * page_size), p % ((uint8_t)-1),
> -		       page_size);
> +	for (p = 0; p < gopts->nr_pages; ++p)
> +		memset(gopts->area_dst + (p * gopts->page_size), p % ((uint8_t)-1),
> +		       gopts->page_size);
>
>  	args.apply_wp = test_wp;
>  	if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
> @@ -600,50 +576,51 @@ static void uffd_minor_test_common(bool test_collapse, bool test_wp)
>  	 * fault. uffd_poll_thread will resolve the fault by bit-flipping the
>  	 * page's contents, and then issuing a CONTINUE ioctl.
>  	 */
> -	check_memory_contents(area_dst_alias);
> +	check_memory_contents(gopts, gopts->area_dst_alias);
>
> -	if (write(pipefd[1], &c, sizeof(c)) != sizeof(c))
> +	if (write(gopts->pipefd[1], &c, sizeof(c)) != sizeof(c))
>  		err("pipe write");
>  	if (pthread_join(uffd_mon, NULL))
>  		err("join() failed");
>
>  	if (test_collapse) {
> -		if (madvise(area_dst_alias, nr_pages * page_size,
> +		if (madvise(gopts->area_dst_alias, gopts->nr_pages * gopts->page_size,
>  			    MADV_COLLAPSE)) {
>  			/* It's fine to fail for this one... */
>  			uffd_test_skip("MADV_COLLAPSE failed");
>  			return;
>  		}
>
> -		uffd_test_ops->check_pmd_mapping(area_dst,
> -						 nr_pages * page_size /
> +		uffd_test_ops->check_pmd_mapping(gopts,
> +						 gopts->area_dst,
> +						 gopts->nr_pages * gopts->page_size /
>  						 read_pmd_pagesize());
>  		/*
>  		 * This won't cause uffd-fault - it purely just makes sure there
>  		 * was no corruption.
>  		 */
> -		check_memory_contents(area_dst_alias);
> +		check_memory_contents(gopts, gopts->area_dst_alias);
>  	}
>
> -	if (args.missing_faults != 0 || args.minor_faults != nr_pages)
> +	if (args.missing_faults != 0 || args.minor_faults != gopts->nr_pages)
>  		uffd_test_fail("stats check error");
>  	else
>  		uffd_test_pass();
>  }
>
> -void uffd_minor_test(uffd_test_args_t *args)
> +void uffd_minor_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *args)
>  {
> -	uffd_minor_test_common(false, false);
> +	uffd_minor_test_common(gopts, false, false);
>  }
>
> -void uffd_minor_wp_test(uffd_test_args_t *args)
> +void uffd_minor_wp_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *args)
>  {
> -	uffd_minor_test_common(false, true);
> +	uffd_minor_test_common(gopts, false, true);
>  }
>
> -void uffd_minor_collapse_test(uffd_test_args_t *args)
> +void uffd_minor_collapse_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *args)
>  {
> -	uffd_minor_test_common(true, false);
> +	uffd_minor_test_common(gopts, true, false);
>  }
>
>  static sigjmp_buf jbuf, *sigbuf;
> @@ -678,7 +655,7 @@ static void sighndl(int sig, siginfo_t *siginfo, void *ptr)
>   * This also tests UFFD_FEATURE_EVENT_FORK event along with the signal
>   * feature. Using monitor thread, verify no userfault events are generated.
>   */
> -static int faulting_process(int signal_test, bool wp)
> +static int faulting_process(uffd_global_test_opts_t *gopts, int signal_test, bool wp)
>  {
>  	unsigned long nr, i;
>  	unsigned long long count;
> @@ -687,7 +664,7 @@ static int faulting_process(int signal_test, bool wp)
>  	struct sigaction act;
>  	volatile unsigned long signalled = 0;
>
> -	split_nr_pages = (nr_pages + 1) / 2;
> +	split_nr_pages = (gopts->nr_pages + 1) / 2;
>
>  	if (signal_test) {
>  		sigbuf = &jbuf;
> @@ -701,7 +678,7 @@ static int faulting_process(int signal_test, bool wp)
>
>  	for (nr = 0; nr < split_nr_pages; nr++) {
>  		volatile int steps = 1;
> -		unsigned long offset = nr * page_size;
> +		unsigned long offset = nr * gopts->page_size;
>
>  		if (signal_test) {
>  			if (sigsetjmp(*sigbuf, 1) != 0) {
> @@ -713,15 +690,15 @@ static int faulting_process(int signal_test, bool wp)
>  					if (steps == 1) {
>  						/* This is a MISSING request */
>  						steps++;
> -						if (copy_page(uffd, offset, wp))
> +						if (copy_page(gopts, offset, wp))
>  							signalled++;
>  					} else {
>  						/* This is a WP request */
>  						assert(steps == 2);
> -						wp_range(uffd,
> -							 (__u64)area_dst +
> +						wp_range(gopts->uffd,
> +							 (__u64)gopts->area_dst +
>  							 offset,
> -							 page_size, false);
> +							 gopts->page_size, false);
>  					}
>  				} else {
>  					signalled++;
> @@ -730,51 +707,53 @@ static int faulting_process(int signal_test, bool wp)
>  			}
>  		}
>
> -		count = *area_count(area_dst, nr);
> -		if (count != count_verify[nr])
> +		count = *area_count(gopts->area_dst, nr, gopts);
> +		if (count != gopts->count_verify[nr])
>  			err("nr %lu memory corruption %llu %llu\n",
> -			    nr, count, count_verify[nr]);
> +			    nr, count, gopts->count_verify[nr]);
>  		/*
>  		 * Trigger write protection if there is by writing
>  		 * the same value back.
>  		 */
> -		*area_count(area_dst, nr) = count;
> +		*area_count(gopts->area_dst, nr, gopts) = count;
>  	}
>
>  	if (signal_test)
>  		return signalled != split_nr_pages;
>
> -	area_dst = mremap(area_dst, nr_pages * page_size,  nr_pages * page_size,
> -			  MREMAP_MAYMOVE | MREMAP_FIXED, area_src);
> -	if (area_dst == MAP_FAILED)
> +	gopts->area_dst = mremap(gopts->area_dst, gopts->nr_pages * gopts->page_size,
> +				 gopts->nr_pages * gopts->page_size,
> +				 MREMAP_MAYMOVE | MREMAP_FIXED,
> +				 gopts->area_src);
> +	if (gopts->area_dst == MAP_FAILED)
>  		err("mremap");
>  	/* Reset area_src since we just clobbered it */
> -	area_src = NULL;
> +	gopts->area_src = NULL;
>
> -	for (; nr < nr_pages; nr++) {
> -		count = *area_count(area_dst, nr);
> -		if (count != count_verify[nr]) {
> +	for (; nr < gopts->nr_pages; nr++) {
> +		count = *area_count(gopts->area_dst, nr, gopts);
> +		if (count != gopts->count_verify[nr]) {
>  			err("nr %lu memory corruption %llu %llu\n",
> -			    nr, count, count_verify[nr]);
> +			    nr, count, gopts->count_verify[nr]);
>  		}
>  		/*
>  		 * Trigger write protection if there is by writing
>  		 * the same value back.
>  		 */
> -		*area_count(area_dst, nr) = count;
> +		*area_count(gopts->area_dst, nr, gopts) = count;
>  	}
>
> -	uffd_test_ops->release_pages(area_dst);
> +	uffd_test_ops->release_pages(gopts, gopts->area_dst);
>
> -	for (nr = 0; nr < nr_pages; nr++)
> -		for (i = 0; i < page_size; i++)
> -			if (*(area_dst + nr * page_size + i) != 0)
> +	for (nr = 0; nr < gopts->nr_pages; nr++)
> +		for (i = 0; i < gopts->page_size; i++)
> +			if (*(gopts->area_dst + nr * gopts->page_size + i) != 0)
>  				err("page %lu offset %lu is not zero", nr, i);
>
>  	return 0;
>  }
>
> -static void uffd_sigbus_test_common(bool wp)
> +static void uffd_sigbus_test_common(uffd_global_test_opts_t *gopts, bool wp)
>  {
>  	unsigned long userfaults;
>  	pthread_t uffd_mon;
> @@ -782,25 +761,26 @@ static void uffd_sigbus_test_common(bool wp)
>  	int err;
>  	char c;
>  	struct uffd_args args = { 0 };
> +	args.gopts = gopts;
>
> -	ready_for_fork = false;
> +	gopts->ready_for_fork = false;
>
> -	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
> +	fcntl(gopts->uffd, F_SETFL, gopts->uffd_flags | O_NONBLOCK);
>
> -	if (uffd_register(uffd, area_dst, nr_pages * page_size,
> +	if (uffd_register(gopts->uffd, gopts->area_dst, gopts->nr_pages * gopts->page_size,
>  			  true, wp, false))
>  		err("register failure");
>
> -	if (faulting_process(1, wp))
> +	if (faulting_process(gopts, 1, wp))
>  		err("faulting process failed");
>
> -	uffd_test_ops->release_pages(area_dst);
> +	uffd_test_ops->release_pages(gopts, gopts->area_dst);
>
>  	args.apply_wp = wp;
>  	if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
>  		err("uffd_poll_thread create");
>
> -	while (!ready_for_fork)
> +	while (!gopts->ready_for_fork)
>  		; /* Wait for the poll_thread to start executing before forking */
>
>  	pid = fork();
> @@ -808,12 +788,12 @@ static void uffd_sigbus_test_common(bool wp)
>  		err("fork");
>
>  	if (!pid)
> -		exit(faulting_process(2, wp));
> +		exit(faulting_process(gopts, 2, wp));
>
>  	waitpid(pid, &err, 0);
>  	if (err)
>  		err("faulting process failed");
> -	if (write(pipefd[1], &c, sizeof(c)) != sizeof(c))
> +	if (write(gopts->pipefd[1], &c, sizeof(c)) != sizeof(c))
>  		err("pipe write");
>  	if (pthread_join(uffd_mon, (void **)&userfaults))
>  		err("pthread_join()");
> @@ -824,28 +804,29 @@ static void uffd_sigbus_test_common(bool wp)
>  		uffd_test_pass();
>  }
>
> -static void uffd_sigbus_test(uffd_test_args_t *args)
> +static void uffd_sigbus_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *args)
>  {
> -	uffd_sigbus_test_common(false);
> +	uffd_sigbus_test_common(gopts, false);
>  }
>
> -static void uffd_sigbus_wp_test(uffd_test_args_t *args)
> +static void uffd_sigbus_wp_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *args)
>  {
> -	uffd_sigbus_test_common(true);
> +	uffd_sigbus_test_common(gopts, true);
>  }
>
> -static void uffd_events_test_common(bool wp)
> +static void uffd_events_test_common(uffd_global_test_opts_t *gopts, bool wp)
>  {
>  	pthread_t uffd_mon;
>  	pid_t pid;
>  	int err;
>  	char c;
>  	struct uffd_args args = { 0 };
> +	args.gopts = gopts;
>
> -	ready_for_fork = false;
> +	gopts->ready_for_fork = false;
>
> -	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
> -	if (uffd_register(uffd, area_dst, nr_pages * page_size,
> +	fcntl(gopts->uffd, F_SETFL, gopts->uffd_flags | O_NONBLOCK);
> +	if (uffd_register(gopts->uffd, gopts->area_dst, gopts->nr_pages * gopts->page_size,
>  			  true, wp, false))
>  		err("register failure");
>
> @@ -853,7 +834,7 @@ static void uffd_events_test_common(bool wp)
>  	if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
>  		err("uffd_poll_thread create");
>
> -	while (!ready_for_fork)
> +	while (!gopts->ready_for_fork)
>  		; /* Wait for the poll_thread to start executing before forking */
>
>  	pid = fork();
> @@ -861,39 +842,39 @@ static void uffd_events_test_common(bool wp)
>  		err("fork");
>
>  	if (!pid)
> -		exit(faulting_process(0, wp));
> +		exit(faulting_process(gopts, 0, wp));
>
>  	waitpid(pid, &err, 0);
>  	if (err)
>  		err("faulting process failed");
> -	if (write(pipefd[1], &c, sizeof(c)) != sizeof(c))
> +	if (write(gopts->pipefd[1], &c, sizeof(c)) != sizeof(c))
>  		err("pipe write");
>  	if (pthread_join(uffd_mon, NULL))
>  		err("pthread_join()");
>
> -	if (args.missing_faults != nr_pages)
> +	if (args.missing_faults != gopts->nr_pages)
>  		uffd_test_fail("Fault counts wrong");
>  	else
>  		uffd_test_pass();
>  }
>
> -static void uffd_events_test(uffd_test_args_t *args)
> +static void uffd_events_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *args)
>  {
> -	uffd_events_test_common(false);
> +	uffd_events_test_common(gopts, false);
>  }
>
> -static void uffd_events_wp_test(uffd_test_args_t *args)
> +static void uffd_events_wp_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *args)
>  {
> -	uffd_events_test_common(true);
> +	uffd_events_test_common(gopts, true);
>  }
>
> -static void retry_uffdio_zeropage(int ufd,
> +static void retry_uffdio_zeropage(uffd_global_test_opts_t *gopts,
>  				  struct uffdio_zeropage *uffdio_zeropage)
>  {
> -	uffd_test_ops->alias_mapping(&uffdio_zeropage->range.start,
> +	uffd_test_ops->alias_mapping(gopts, &uffdio_zeropage->range.start,
>  				     uffdio_zeropage->range.len,
>  				     0);
> -	if (ioctl(ufd, UFFDIO_ZEROPAGE, uffdio_zeropage)) {
> +	if (ioctl(gopts->uffd, UFFDIO_ZEROPAGE, uffdio_zeropage)) {
>  		if (uffdio_zeropage->zeropage != -EEXIST)
>  			err("UFFDIO_ZEROPAGE error: %"PRId64,
>  			    (int64_t)uffdio_zeropage->zeropage);
> @@ -903,16 +884,16 @@ static void retry_uffdio_zeropage(int ufd,
>  	}
>  }
>
> -static bool do_uffdio_zeropage(int ufd, bool has_zeropage)
> +static bool do_uffdio_zeropage(uffd_global_test_opts_t *gopts, bool has_zeropage)
>  {
>  	struct uffdio_zeropage uffdio_zeropage = { 0 };
>  	int ret;
>  	__s64 res;
>
> -	uffdio_zeropage.range.start = (unsigned long) area_dst;
> -	uffdio_zeropage.range.len = page_size;
> +	uffdio_zeropage.range.start = (unsigned long) gopts->area_dst;
> +	uffdio_zeropage.range.len = gopts->page_size;
>  	uffdio_zeropage.mode = 0;
> -	ret = ioctl(ufd, UFFDIO_ZEROPAGE, &uffdio_zeropage);
> +	ret = ioctl(gopts->uffd, UFFDIO_ZEROPAGE, &uffdio_zeropage);
>  	res = uffdio_zeropage.zeropage;
>  	if (ret) {
>  		/* real retval in ufdio_zeropage.zeropage */
> @@ -921,10 +902,10 @@ static bool do_uffdio_zeropage(int ufd, bool has_zeropage)
>  		else if (res != -EINVAL)
>  			err("UFFDIO_ZEROPAGE not -EINVAL");
>  	} else if (has_zeropage) {
> -		if (res != page_size)
> +		if (res != gopts->page_size)
>  			err("UFFDIO_ZEROPAGE unexpected size");
>  		else
> -			retry_uffdio_zeropage(ufd, &uffdio_zeropage);
> +			retry_uffdio_zeropage(gopts, &uffdio_zeropage);
>  		return true;
>  	} else
>  		err("UFFDIO_ZEROPAGE succeeded");
> @@ -950,25 +931,29 @@ uffd_register_detect_zeropage(int uffd, void *addr, uint64_t len)
>  }
>
>  /* exercise UFFDIO_ZEROPAGE */
> -static void uffd_zeropage_test(uffd_test_args_t *args)
> +static void uffd_zeropage_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *args)
>  {
>  	bool has_zeropage;
>  	int i;
>
> -	has_zeropage = uffd_register_detect_zeropage(uffd, area_dst, page_size);
> -	if (area_dst_alias)
> +	has_zeropage = uffd_register_detect_zeropage(gopts->uffd,
> +						     gopts->area_dst,
> +						     gopts->page_size);
> +	if (gopts->area_dst_alias)
>  		/* Ignore the retval; we already have it */
> -		uffd_register_detect_zeropage(uffd, area_dst_alias, page_size);
> +		uffd_register_detect_zeropage(gopts->uffd, gopts->area_dst_alias, gopts->page_size);
>
> -	if (do_uffdio_zeropage(uffd, has_zeropage))
> -		for (i = 0; i < page_size; i++)
> -			if (area_dst[i] != 0)
> +	if (do_uffdio_zeropage(gopts, has_zeropage))
> +		for (i = 0; i < gopts->page_size; i++)
> +			if (gopts->area_dst[i] != 0)
>  				err("data non-zero at offset %d\n", i);
>
> -	if (uffd_unregister(uffd, area_dst, page_size))
> +	if (uffd_unregister(gopts->uffd, gopts->area_dst, gopts->page_size))
>  		err("unregister");
>
> -	if (area_dst_alias && uffd_unregister(uffd, area_dst_alias, page_size))
> +	if (gopts->area_dst_alias && uffd_unregister(gopts->uffd,
> +						     gopts->area_dst_alias,
> +						     gopts->page_size))
>  		err("unregister");
>
>  	uffd_test_pass();
> @@ -987,26 +972,27 @@ static void uffd_register_poison(int uffd, void *addr, uint64_t len)
>  		err("registered area doesn't support COPY and POISON ioctls");
>  }
>
> -static void do_uffdio_poison(int uffd, unsigned long offset)
> +static void do_uffdio_poison(uffd_global_test_opts_t *gopts, unsigned long offset)
>  {
>  	struct uffdio_poison uffdio_poison = { 0 };
>  	int ret;
>  	__s64 res;
>
> -	uffdio_poison.range.start = (unsigned long) area_dst + offset;
> -	uffdio_poison.range.len = page_size;
> +	uffdio_poison.range.start = (unsigned long) gopts->area_dst + offset;
> +	uffdio_poison.range.len = gopts->page_size;
>  	uffdio_poison.mode = 0;
> -	ret = ioctl(uffd, UFFDIO_POISON, &uffdio_poison);
> +	ret = ioctl(gopts->uffd, UFFDIO_POISON, &uffdio_poison);
>  	res = uffdio_poison.updated;
>
>  	if (ret)
>  		err("UFFDIO_POISON error: %"PRId64, (int64_t)res);
> -	else if (res != page_size)
> +	else if (res != gopts->page_size)
>  		err("UFFDIO_POISON unexpected size: %"PRId64, (int64_t)res);
>  }
>
> -static void uffd_poison_handle_fault(
> -	struct uffd_msg *msg, struct uffd_args *args)
> +static void uffd_poison_handle_fault(uffd_global_test_opts_t *gopts,
> +				     struct uffd_msg *msg,
> +				     struct uffd_args *args)
>  {
>  	unsigned long offset;
>
> @@ -1017,17 +1003,17 @@ static void uffd_poison_handle_fault(
>  	    (UFFD_PAGEFAULT_FLAG_WP | UFFD_PAGEFAULT_FLAG_MINOR))
>  		err("unexpected fault type %llu", msg->arg.pagefault.flags);
>
> -	offset = (char *)(unsigned long)msg->arg.pagefault.address - area_dst;
> -	offset &= ~(page_size-1);
> +	offset = (char *)(unsigned long)msg->arg.pagefault.address - gopts->area_dst;
> +	offset &= ~(gopts->page_size-1);
>
>  	/* Odd pages -> copy zeroed page; even pages -> poison. */
> -	if (offset & page_size)
> -		copy_page(uffd, offset, false);
> +	if (offset & gopts->page_size)
> +		copy_page(gopts, offset, false);
>  	else
> -		do_uffdio_poison(uffd, offset);
> +		do_uffdio_poison(gopts, offset);
>  }
>
> -static void uffd_poison_test(uffd_test_args_t *targs)
> +static void uffd_poison_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *targs)
>  {
>  	pthread_t uffd_mon;
>  	char c;
> @@ -1036,10 +1022,12 @@ static void uffd_poison_test(uffd_test_args_t *targs)
>  	unsigned long nr_sigbus = 0;
>  	unsigned long nr;
>
> -	fcntl(uffd, F_SETFL, uffd_flags | O_NONBLOCK);
> +	args.gopts = gopts;
> +
> +	fcntl(gopts->uffd, F_SETFL, gopts->uffd_flags | O_NONBLOCK);
>
> -	uffd_register_poison(uffd, area_dst, nr_pages * page_size);
> -	memset(area_src, 0, nr_pages * page_size);
> +	uffd_register_poison(gopts->uffd, gopts->area_dst, gopts->nr_pages * gopts->page_size);
> +	memset(gopts->area_src, 0, gopts->nr_pages * gopts->page_size);
>
>  	args.handle_fault = uffd_poison_handle_fault;
>  	if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
> @@ -1051,9 +1039,9 @@ static void uffd_poison_test(uffd_test_args_t *targs)
>  	if (sigaction(SIGBUS, &act, 0))
>  		err("sigaction");
>
> -	for (nr = 0; nr < nr_pages; ++nr) {
> -		unsigned long offset = nr * page_size;
> -		const char *bytes = (const char *) area_dst + offset;
> +	for (nr = 0; nr < gopts->nr_pages; ++nr) {
> +		unsigned long offset = nr * gopts->page_size;
> +		const char *bytes = (const char *) gopts->area_dst + offset;
>  		const char *i;
>
>  		if (sigsetjmp(*sigbuf, 1)) {
> @@ -1066,27 +1054,29 @@ static void uffd_poison_test(uffd_test_args_t *targs)
>  			continue;
>  		}
>
> -		for (i = bytes; i < bytes + page_size; ++i) {
> +		for (i = bytes; i < bytes + gopts->page_size; ++i) {
>  			if (*i)
>  				err("nonzero byte in area_dst (%p) at %p: %u",
> -				    area_dst, i, *i);
> +				    gopts->area_dst, i, *i);
>  		}
>  	}
>
> -	if (write(pipefd[1], &c, sizeof(c)) != sizeof(c))
> +	if (write(gopts->pipefd[1], &c, sizeof(c)) != sizeof(c))
>  		err("pipe write");
>  	if (pthread_join(uffd_mon, NULL))
>  		err("pthread_join()");
>
> -	if (nr_sigbus != nr_pages / 2)
> +	if (nr_sigbus != gopts->nr_pages / 2)
>  		err("expected to receive %lu SIGBUS, actually received %lu",
> -		    nr_pages / 2, nr_sigbus);
> +		    gopts->nr_pages / 2, nr_sigbus);
>
>  	uffd_test_pass();
>  }
>
>  static void
> -uffd_move_handle_fault_common(struct uffd_msg *msg, struct uffd_args *args,
> +uffd_move_handle_fault_common(uffd_global_test_opts_t *gopts,
> +			      struct uffd_msg *msg,
> +			      struct uffd_args *args,
>  			      unsigned long len)
>  {
>  	unsigned long offset;
> @@ -1098,28 +1088,32 @@ uffd_move_handle_fault_common(struct uffd_msg *msg, struct uffd_args *args,
>  	    (UFFD_PAGEFAULT_FLAG_WP | UFFD_PAGEFAULT_FLAG_MINOR | UFFD_PAGEFAULT_FLAG_WRITE))
>  		err("unexpected fault type %llu", msg->arg.pagefault.flags);
>
> -	offset = (char *)(unsigned long)msg->arg.pagefault.address - area_dst;
> +	offset = (char *)(unsigned long)msg->arg.pagefault.address - gopts->area_dst;
>  	offset &= ~(len-1);
>
> -	if (move_page(uffd, offset, len))
> +	if (move_page(gopts, offset, len))
>  		args->missing_faults++;
>  }
>
> -static void uffd_move_handle_fault(struct uffd_msg *msg,
> +static void uffd_move_handle_fault(uffd_global_test_opts_t *gopts, struct uffd_msg *msg,
>  				   struct uffd_args *args)
>  {
> -	uffd_move_handle_fault_common(msg, args, page_size);
> +	uffd_move_handle_fault_common(gopts, msg, args, gopts->page_size);
>  }
>
> -static void uffd_move_pmd_handle_fault(struct uffd_msg *msg,
> +static void uffd_move_pmd_handle_fault(uffd_global_test_opts_t *gopts, struct uffd_msg *msg,
>  				       struct uffd_args *args)
>  {
> -	uffd_move_handle_fault_common(msg, args, read_pmd_pagesize());
> +	uffd_move_handle_fault_common(gopts, msg, args, read_pmd_pagesize());
>  }
>
>  static void
> -uffd_move_test_common(uffd_test_args_t *targs, unsigned long chunk_size,
> -		      void (*handle_fault)(struct uffd_msg *msg, struct uffd_args *args))
> +uffd_move_test_common(uffd_global_test_opts_t *gopts,
> +		      uffd_test_args_t *targs,
> +		      unsigned long chunk_size,
> +		      void (*handle_fault)(struct uffd_global_test_opts *gopts,
> +		      struct uffd_msg *msg, struct uffd_args *args)
> +)
>  {
>  	unsigned long nr;
>  	pthread_t uffd_mon;
> @@ -1131,11 +1125,13 @@ uffd_move_test_common(uffd_test_args_t *targs, unsigned long chunk_size,
>  	unsigned long src_offs = 0;
>  	unsigned long dst_offs = 0;
>
> +	args.gopts = gopts;
> +
>  	/* Prevent source pages from being mapped more than once */
> -	if (madvise(area_src, nr_pages * page_size, MADV_DONTFORK))
> +	if (madvise(gopts->area_src, gopts->nr_pages * gopts->page_size, MADV_DONTFORK))
>  		err("madvise(MADV_DONTFORK) failure");
>
> -	if (uffd_register(uffd, area_dst, nr_pages * page_size,
> +	if (uffd_register(gopts->uffd, gopts->area_dst, gopts->nr_pages * gopts->page_size,
>  			  true, false, false))
>  		err("register failure");
>
> @@ -1143,22 +1139,22 @@ uffd_move_test_common(uffd_test_args_t *targs, unsigned long chunk_size,
>  	if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
>  		err("uffd_poll_thread create");
>
> -	step_size = chunk_size / page_size;
> -	step_count = nr_pages / step_size;
> +	step_size = chunk_size / gopts->page_size;
> +	step_count = gopts->nr_pages / step_size;
>
> -	if (chunk_size > page_size) {
> -		char *aligned_src = ALIGN_UP(area_src, chunk_size);
> -		char *aligned_dst = ALIGN_UP(area_dst, chunk_size);
> +	if (chunk_size > gopts->page_size) {
> +		char *aligned_src = ALIGN_UP(gopts->area_src, chunk_size);
> +		char *aligned_dst = ALIGN_UP(gopts->area_dst, chunk_size);
>
> -		if (aligned_src != area_src || aligned_dst != area_dst) {
> -			src_offs = (aligned_src - area_src) / page_size;
> -			dst_offs = (aligned_dst - area_dst) / page_size;
> +		if (aligned_src != gopts->area_src || aligned_dst != gopts->area_dst) {
> +			src_offs = (aligned_src - gopts->area_src) / gopts->page_size;
> +			dst_offs = (aligned_dst - gopts->area_dst) / gopts->page_size;
>  			step_count--;
>  		}
> -		orig_area_src = area_src;
> -		orig_area_dst = area_dst;
> -		area_src = aligned_src;
> -		area_dst = aligned_dst;
> +		orig_area_src = gopts->area_src;
> +		orig_area_dst = gopts->area_dst;
> +		gopts->area_src = aligned_src;
> +		gopts->area_dst = aligned_dst;
>  	}
>
>  	/*
> @@ -1172,34 +1168,34 @@ uffd_move_test_common(uffd_test_args_t *targs, unsigned long chunk_size,
>
>  		/* Check area_src content */
>  		for (i = 0; i < step_size; i++) {
> -			count = *area_count(area_src, nr + i);
> -			if (count != count_verify[src_offs + nr + i])
> +			count = *area_count(gopts->area_src, nr + i, gopts);
> +			if (count != gopts->count_verify[src_offs + nr + i])
>  				err("nr %lu source memory invalid %llu %llu\n",
> -				    nr + i, count, count_verify[src_offs + nr + i]);
> +				    nr + i, count, gopts->count_verify[src_offs + nr + i]);
>  		}
>
>  		/* Faulting into area_dst should move the page or the huge page */
>  		for (i = 0; i < step_size; i++) {
> -			count = *area_count(area_dst, nr + i);
> -			if (count != count_verify[dst_offs + nr + i])
> +			count = *area_count(gopts->area_dst, nr + i, gopts);
> +			if (count != gopts->count_verify[dst_offs + nr + i])
>  				err("nr %lu memory corruption %llu %llu\n",
> -				    nr, count, count_verify[dst_offs + nr + i]);
> +				    nr, count, gopts->count_verify[dst_offs + nr + i]);
>  		}
>
>  		/* Re-check area_src content which should be empty */
>  		for (i = 0; i < step_size; i++) {
> -			count = *area_count(area_src, nr + i);
> +			count = *area_count(gopts->area_src, nr + i, gopts);
>  			if (count != 0)
>  				err("nr %lu move failed %llu %llu\n",
> -				    nr, count, count_verify[src_offs + nr + i]);
> +				    nr, count, gopts->count_verify[src_offs + nr + i]);
>  		}
>  	}
> -	if (chunk_size > page_size) {
> -		area_src = orig_area_src;
> -		area_dst = orig_area_dst;
> +	if (chunk_size > gopts->page_size) {
> +		gopts->area_src = orig_area_src;
> +		gopts->area_dst = orig_area_dst;
>  	}
>
> -	if (write(pipefd[1], &c, sizeof(c)) != sizeof(c))
> +	if (write(gopts->pipefd[1], &c, sizeof(c)) != sizeof(c))
>  		err("pipe write");
>  	if (pthread_join(uffd_mon, NULL))
>  		err("join() failed");
> @@ -1210,24 +1206,24 @@ uffd_move_test_common(uffd_test_args_t *targs, unsigned long chunk_size,
>  		uffd_test_pass();
>  }
>
> -static void uffd_move_test(uffd_test_args_t *targs)
> +static void uffd_move_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *targs)
>  {
> -	uffd_move_test_common(targs, page_size, uffd_move_handle_fault);
> +	uffd_move_test_common(gopts, targs, gopts->page_size, uffd_move_handle_fault);
>  }
>
> -static void uffd_move_pmd_test(uffd_test_args_t *targs)
> +static void uffd_move_pmd_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *targs)
>  {
> -	if (madvise(area_dst, nr_pages * page_size, MADV_HUGEPAGE))
> +	if (madvise(gopts->area_dst, gopts->nr_pages * gopts->page_size, MADV_HUGEPAGE))
>  		err("madvise(MADV_HUGEPAGE) failure");
> -	uffd_move_test_common(targs, read_pmd_pagesize(),
> +	uffd_move_test_common(gopts, targs, read_pmd_pagesize(),
>  			      uffd_move_pmd_handle_fault);
>  }
>
> -static void uffd_move_pmd_split_test(uffd_test_args_t *targs)
> +static void uffd_move_pmd_split_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *targs)
>  {
> -	if (madvise(area_dst, nr_pages * page_size, MADV_NOHUGEPAGE))
> +	if (madvise(gopts->area_dst, gopts->nr_pages * gopts->page_size, MADV_NOHUGEPAGE))
>  		err("madvise(MADV_NOHUGEPAGE) failure");
> -	uffd_move_test_common(targs, read_pmd_pagesize(),
> +	uffd_move_test_common(gopts, targs, read_pmd_pagesize(),
>  			      uffd_move_pmd_handle_fault);
>  }
>
> @@ -1287,6 +1283,11 @@ typedef enum {
>  	THR_STATE_UNINTERRUPTIBLE,
>  } thread_state;
>
> +typedef struct {
> +	uffd_global_test_opts_t *gopts;
> +	volatile pid_t *pid;
> +} mmap_changing_thread_args;
> +
>  static void sleep_short(void)
>  {
>  	usleep(1000);
> @@ -1329,7 +1330,9 @@ static void thread_state_until(pid_t tid, thread_state state)
>
>  static void *uffd_mmap_changing_thread(void *opaque)
>  {
> -	volatile pid_t *pid = opaque;
> +	mmap_changing_thread_args *args = opaque;
> +	uffd_global_test_opts_t *gopts = args->gopts;
> +	volatile pid_t *pid = args->pid;
>  	int ret;
>
>  	/* Unfortunately, it's only fetch-able from the thread itself.. */
> @@ -1337,21 +1340,21 @@ static void *uffd_mmap_changing_thread(void *opaque)
>  	*pid = syscall(SYS_gettid);
>
>  	/* Inject an event, this will hang solid until the event read */
> -	ret = madvise(area_dst, page_size, MADV_REMOVE);
> +	ret = madvise(gopts->area_dst, gopts->page_size, MADV_REMOVE);
>  	if (ret)
>  		err("madvise(MADV_REMOVE) failed");
>
>  	return NULL;
>  }
>
> -static void uffd_consume_message(int fd)
> +static void uffd_consume_message(uffd_global_test_opts_t *gopts)
>  {
>  	struct uffd_msg msg = { 0 };
>
> -	while (uffd_read_msg(fd, &msg));
> +	while (uffd_read_msg(gopts, &msg));
>  }
>
> -static void uffd_mmap_changing_test(uffd_test_args_t *targs)
> +static void uffd_mmap_changing_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *targs)
>  {
>  	/*
>  	 * This stores the real PID (which can be different from how tid is
> @@ -1360,13 +1363,14 @@ static void uffd_mmap_changing_test(uffd_test_args_t *targs)
>  	pid_t pid = 0;
>  	pthread_t tid;
>  	int ret;
> +	mmap_changing_thread_args args = { gopts, &pid };
>
> -	if (uffd_register(uffd, area_dst, nr_pages * page_size,
> +	if (uffd_register(gopts->uffd, gopts->area_dst, gopts->nr_pages * gopts->page_size,
>  			  true, false, false))
>  		err("uffd_register() failed");
>
>  	/* Create a thread to generate the racy event */
> -	ret = pthread_create(&tid, NULL, uffd_mmap_changing_thread, &pid);
> +	ret = pthread_create(&tid, NULL, uffd_mmap_changing_thread, &args);
>  	if (ret)
>  		err("pthread_create() failed");
>
> @@ -1380,26 +1384,26 @@ static void uffd_mmap_changing_test(uffd_test_args_t *targs)
>  	/* Wait until the thread hangs at REMOVE event */
>  	thread_state_until(pid, THR_STATE_UNINTERRUPTIBLE);
>
> -	if (!uffdio_mmap_changing_test_copy(uffd))
> +	if (!uffdio_mmap_changing_test_copy(gopts->uffd))
>  		return;
>
> -	if (!uffdio_mmap_changing_test_zeropage(uffd))
> +	if (!uffdio_mmap_changing_test_zeropage(gopts->uffd))
>  		return;
>
> -	if (!uffdio_mmap_changing_test_move(uffd))
> +	if (!uffdio_mmap_changing_test_move(gopts->uffd))
>  		return;
>
> -	if (!uffdio_mmap_changing_test_poison(uffd))
> +	if (!uffdio_mmap_changing_test_poison(gopts->uffd))
>  		return;
>
> -	if (!uffdio_mmap_changing_test_continue(uffd))
> +	if (!uffdio_mmap_changing_test_continue(gopts->uffd))
>  		return;
>
>  	/*
>  	 * All succeeded above!  Recycle everything.  Start by reading the
>  	 * event so as to kick the thread roll again..
>  	 */
> -	uffd_consume_message(uffd);
> +	uffd_consume_message(gopts);
>
>  	ret = pthread_join(tid, NULL);
>  	assert(ret == 0);
> @@ -1407,10 +1411,10 @@ static void uffd_mmap_changing_test(uffd_test_args_t *targs)
>  	uffd_test_pass();
>  }
>
> -static int prevent_hugepages(const char **errmsg)
> +static int prevent_hugepages(uffd_global_test_opts_t *gopts, const char **errmsg)
>  {
>  	/* This should be done before source area is populated */
> -	if (madvise(area_src, nr_pages * page_size, MADV_NOHUGEPAGE)) {
> +	if (madvise(gopts->area_src, gopts->nr_pages * gopts->page_size, MADV_NOHUGEPAGE)) {
>  		/* Ignore only if CONFIG_TRANSPARENT_HUGEPAGE=n */
>  		if (errno != EINVAL) {
>  			if (errmsg)
> @@ -1421,10 +1425,10 @@ static int prevent_hugepages(const char **errmsg)
>  	return 0;
>  }
>
> -static int request_hugepages(const char **errmsg)
> +static int request_hugepages(uffd_global_test_opts_t *gopts, const char **errmsg)
>  {
>  	/* This should be done before source area is populated */
> -	if (madvise(area_src, nr_pages * page_size, MADV_HUGEPAGE)) {
> +	if (madvise(gopts->area_src, gopts->nr_pages * gopts->page_size, MADV_HUGEPAGE)) {
>  		if (errmsg) {
>  			*errmsg = (errno == EINVAL) ?
>  				"CONFIG_TRANSPARENT_HUGEPAGE is not set" :
> @@ -1448,13 +1452,17 @@ struct uffd_test_case_ops uffd_move_test_pmd_case_ops = {
>   * Note that _UFFDIO_ZEROPAGE is tested separately in the zeropage test.
>   */
>  static void
> -do_register_ioctls_test(uffd_test_args_t *args, bool miss, bool wp, bool minor)
> +do_register_ioctls_test(uffd_global_test_opts_t *gopts,
> +			uffd_test_args_t *args,
> +			bool miss,
> +			bool wp,
> +			bool minor)
>  {
>  	uint64_t ioctls = 0, expected = BIT_ULL(_UFFDIO_WAKE);
>  	mem_type_t *mem_type = args->mem_type;
>  	int ret;
>
> -	ret = uffd_register_with_ioctls(uffd, area_dst, page_size,
> +	ret = uffd_register_with_ioctls(gopts->uffd, gopts->area_dst, gopts->page_size,
>  					miss, wp, minor, &ioctls);
>
>  	/*
> @@ -1485,18 +1493,18 @@ do_register_ioctls_test(uffd_test_args_t *args, bool miss, bool wp, bool minor)
>  		    "(miss=%d, wp=%d, minor=%d): expected=0x%"PRIx64", "
>  		    "returned=0x%"PRIx64, miss, wp, minor, expected, ioctls);
>
> -	if (uffd_unregister(uffd, area_dst, page_size))
> +	if (uffd_unregister(gopts->uffd, gopts->area_dst, gopts->page_size))
>  		err("unregister");
>  }
>
> -static void uffd_register_ioctls_test(uffd_test_args_t *args)
> +static void uffd_register_ioctls_test(uffd_global_test_opts_t *gopts, uffd_test_args_t *args)
>  {
>  	int miss, wp, minor;
>
>  	for (miss = 0; miss <= 1; miss++)
>  		for (wp = 0; wp <= 1; wp++)
>  			for (minor = 0; minor <= 1; minor++)
> -				do_register_ioctls_test(args, miss, wp, minor);
> +				do_register_ioctls_test(gopts, args, miss, wp, minor);
>
>  	uffd_test_pass();
>  }
> @@ -1734,6 +1742,28 @@ int main(int argc, char *argv[])
>  		}
>  		for (j = 0; j < n_mems; j++) {
>  			mem_type = &mem_types[j];
> +
> +			/* Initialize global test options */
> +			uffd_global_test_opts_t gopts;
> +
> +			gopts.map_shared = mem_type->shared;
> +			uffd_test_ops = mem_type->mem_ops;
> +			uffd_test_case_ops = test->test_case_ops;
> +
> +			if (mem_type->mem_flag & (MEM_HUGETLB_PRIVATE | MEM_HUGETLB))
> +				gopts.page_size = default_huge_page_size();
> +			else
> +				gopts.page_size = psize();
> +
> +			/* Ensure we have at least 2 pages */
> +			gopts.nr_pages = MAX(UFFD_TEST_MEM_SIZE, gopts.page_size * 2)
> +				/ gopts.page_size;
> +
> +			gopts.nr_parallel = 1;
> +
> +			/* Initialize test arguments */
> +			args.mem_type = mem_type;
> +
>  			if (!(test->mem_targets & mem_type->mem_flag))
>  				continue;
>
> @@ -1748,13 +1778,12 @@ int main(int argc, char *argv[])
>  				uffd_test_skip("feature missing");
>  				continue;
>  			}
> -			if (uffd_setup_environment(&args, test, mem_type,
> -						   &errmsg)) {
> +			if (uffd_test_ctx_init(&gopts, test->uffd_feature_required, &errmsg)) {
>  				uffd_test_skip(errmsg);
>  				continue;
>  			}
> -			test->uffd_fn(&args);
> -			uffd_test_ctx_clear();
> +			test->uffd_fn(&gopts, &args);
> +			uffd_test_ctx_clear(&gopts);
>  		}
>  	}
>
> diff --git a/tools/testing/selftests/mm/uffd-wp-mremap.c b/tools/testing/selftests/mm/uffd-wp-mremap.c
> index c2ba7d46c7b4..c286b1015f32 100644
> --- a/tools/testing/selftests/mm/uffd-wp-mremap.c
> +++ b/tools/testing/selftests/mm/uffd-wp-mremap.c
> @@ -157,7 +157,11 @@ static bool range_is_swapped(void *addr, size_t size)
>  	return true;
>  }
>
> -static void test_one_folio(size_t size, bool private, bool swapout, bool hugetlb)
> +static void test_one_folio(uffd_global_test_opts_t *gopts,
> +			   size_t size,
> +			   bool private,
> +			   bool swapout,
> +			   bool hugetlb)
>  {
>  	struct uffdio_writeprotect wp_prms;
>  	uint64_t features = 0;
> @@ -181,21 +185,21 @@ static void test_one_folio(size_t size, bool private, bool swapout, bool hugetlb
>  	}
>
>  	/* Register range for uffd-wp. */
> -	if (userfaultfd_open(&features)) {
> +	if (userfaultfd_open(gopts, &features)) {
>  		if (errno == ENOENT)
>  			ksft_test_result_skip("userfaultfd not available\n");
>  		else
>  			ksft_test_result_fail("userfaultfd_open() failed\n");
>  		goto out;
>  	}
> -	if (uffd_register(uffd, mem, size, false, true, false)) {
> +	if (uffd_register(gopts->uffd, mem, size, false, true, false)) {
>  		ksft_test_result_fail("uffd_register() failed\n");
>  		goto out;
>  	}
>  	wp_prms.mode = UFFDIO_WRITEPROTECT_MODE_WP;
>  	wp_prms.range.start = (uintptr_t)mem;
>  	wp_prms.range.len = size;
> -	if (ioctl(uffd, UFFDIO_WRITEPROTECT, &wp_prms)) {
> +	if (ioctl(gopts->uffd, UFFDIO_WRITEPROTECT, &wp_prms)) {
>  		ksft_test_result_fail("ioctl(UFFDIO_WRITEPROTECT) failed\n");
>  		goto out;
>  	}
> @@ -242,9 +246,9 @@ static void test_one_folio(size_t size, bool private, bool swapout, bool hugetlb
>  out:
>  	if (mem)
>  		munmap(mem, size);
> -	if (uffd >= 0) {
> -		close(uffd);
> -		uffd = -1;
> +	if (gopts->uffd >= 0) {
> +		close(gopts->uffd);
> +		gopts->uffd = -1;
>  	}
>  }
>
> @@ -336,6 +340,7 @@ static const struct testcase testcases[] = {
>
>  int main(int argc, char **argv)
>  {
> +	uffd_global_test_opts_t gopts;
>  	struct thp_settings settings;
>  	int i, j, plan = 0;
>
> @@ -367,8 +372,8 @@ int main(int argc, char **argv)
>  		const struct testcase *tc = &testcases[i];
>
>  		for (j = 0; j < *tc->nr_sizes; j++)
> -			test_one_folio(tc->sizes[j], tc->private, tc->swapout,
> -				       tc->hugetlb);
> +			test_one_folio(&gopts, tc->sizes[j], tc->private,
> +				       tc->swapout, tc->hugetlb);
>  	}
>
>  	/* If THP is supported, restore original THP settings. */


