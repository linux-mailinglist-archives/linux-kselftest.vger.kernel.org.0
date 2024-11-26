Return-Path: <linux-kselftest+bounces-22530-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B369D9599
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2024 11:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E37DDB2C06F
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2024 10:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60961C3F36;
	Tue, 26 Nov 2024 10:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ilwl3RiK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1D01C4A13
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Nov 2024 10:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732616809; cv=none; b=US61EW/jcqEV8KNzSPl4f3mYc+jyVw+HnlZbyLdabwddatvJ549u5WVmcvO3roIfs4wbcob4tBr+9BujP86Vv5/6sxcpVNq60fGzjMn9D5NRC+BIEinz6WMxbogA+Qhzc/ehWghFsfX+xSS61bDqzJKY51Y1Ptg7pAZ6LwCxYbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732616809; c=relaxed/simple;
	bh=ppboeZHNZAgsl3RhaZqwKR04EWHSPpBuSfDD3bGtsH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VOQllJUz8rPWBjJnKK/Ca/BwBGaiW2/+XsDLHDldyN6uTdr0jxbaeyTbRF3+69ZDUjbLMGnFEzIgg8pGckAndEQ5J8FMurKm9fs9qykIwoF88sIaEes7g3r3+NW05bxl+eWP0pZ/IaWyZAioChMzvYnDb/wbfn84CVxQkpq22z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ilwl3RiK; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4349e1467fbso18253345e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Nov 2024 02:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732616806; x=1733221606; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rlS1gcEqRGUfSy+lIrkckvowrHGTEr+OuQabeGVfQz0=;
        b=Ilwl3RiKOXjCCqIGnwk5ZqnE9tQTsyr/+mjt46zyPT4kg6NkloYiUeQh6yAivNo8wN
         +lyLx/55oq/X3JZ1B/x0e8OCx80ACUlMWCa2KGsGxk8Iez6K91Z2xFzGY1c+bP+VCBHc
         YICsAMDt7IDht/0RmSRTx4yYKlhEfvVT6b7khiZ4NXeXzfVM3oK1yS9hghgKj/r4BajC
         ukSxe7ARLdK+6u/KyVgtNNF5k6M1+v5tKTtTZNQ7JbC41iV3wbVTxSu9HPGRZ2uC8Ql/
         YV8kUcnDV1RQ9N0Xo/0QkFoG5wR6K7xpBvzXNT050aOOwqk7KMZoHyLKyGckS4h10UwU
         KYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732616806; x=1733221606;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rlS1gcEqRGUfSy+lIrkckvowrHGTEr+OuQabeGVfQz0=;
        b=PINZy99ZsUODLooa4PkXl6XBGdmJzY1Y99z6qFI2/TSY42dz9cKMl6EQlhfjAbpIYS
         9FpPjeWbD4gvpfa1q30KKVvE8mSN4gp3l+8kNRmXKho2fC/itK6pj/UKfbFloWqBAyeJ
         dncNGWhKz9GwajMcJLlmM5LA7B1n70FKgbewY2ii0Czf/Pq+cfOK9KXfubG/2NxvaXqO
         VSM/C9xjdnmNt7hdcmI2bBeCSUS52uhqRGSN0zRuXKgSx70NGu3PuweNyNJ2XQCIkxov
         IiCZbTnKHh+tDwLMoTFoybrH4VxtvUMaa9E0UnEIKeEKz+jYyAoOlIehhrqGX5TSTCUL
         L6XA==
X-Forwarded-Encrypted: i=1; AJvYcCU2ES/h9iGpdbMCHpkd/UYAywP5V/Fh3MhbBcJuGaV8LpiQ7Z4QIOXOIu4nBOC0foczsNCsLT13ZKP4ob7gvRo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/RMc9BN+5wQkthD3Y/KBFSW3wiKNeRXlPD9HPmEK1pSQDA7Tn
	oUrI8uKD8cpaH7+f7qIZQW1YzS31zDEPsJZM+drgKnPNqss7sTv2gFzvheVZB0w=
X-Gm-Gg: ASbGncsbym96kBORaAgobmuisB9cPZGqHYSd1HMUm0zqmwZ4PVkSCPBEtj1uniagdQC
	Lgi0YxwQfhA/mGmJoho0gibla4e8i5uDmgfJWQLSsyaexDmeZ+liQPcT8p7dHQANsonS4nYttnc
	20do3doh2JDae7lpKAwHzu7XBNAj0FunRNrskZHEDPx6MY7S1XcBcc/q3U4vVt6W+0/Rd4v54sy
	CLu3q+BdUYzlvvktej//mp75yjXe1d+s4LxAF120D1kw5k+t1o=
X-Google-Smtp-Source: AGHT+IE5rhU82doolaLzHWQn4vMsgFha4pzFQWsdiWATqAHNe3NgVVqwna3wvVb361bNLk1MQEcsGg==
X-Received: by 2002:a05:600c:4f84:b0:434:a805:1939 with SMTP id 5b1f17b1804b1-434a8051d18mr6989095e9.33.1732616805813;
        Tue, 26 Nov 2024 02:26:45 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434a12e33a4sm49415705e9.22.2024.11.26.02.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 02:26:45 -0800 (PST)
Date: Tue, 26 Nov 2024 11:26:42 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yoann Congal <yoann.congal@smile.fr>,
	Alice Ryhl <aliceryhl@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Jens Axboe <axboe@kernel.dk>, Mark Rutland <mark.rutland@arm.com>,
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH printk v1] printk: ringbuffer: Add KUnit test
Message-ID: <Z0WiYr5eB1-MD0V0@pathway.suse.cz>
References: <20241121145034.123367-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241121145034.123367-1-john.ogness@linutronix.de>

On Thu 2024-11-21 15:56:34, John Ogness wrote:
> From: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> 
> The KUnit test validates the correct operation of the ringbuffer.
> A separate dedicated ringbuffer is used so that the global printk
> ringbuffer is not touched.

Thanks a lot for upstreaming this test!

> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1576,6 +1576,18 @@ config PRINTK
>  	  very difficult to diagnose system problems, saying N here is
>  	  strongly discouraged.
>  
> +config PRINTK_RINGBUFFER_TEST

I would call it PRINTK_RINGBUFFER_KUNIT_TEST to make it clear
that it is a KUNIT test. Also it helps to find KUNIT tests
in .config.

Anyway, Documentation/dev-tools/kunit/style.rst suggests the
FOO_KUNIT_TEST name.

> +	tristate "Test for the printk ringbuffer" if !KUNIT_ALL_TESTS
> +	depends on PRINTK && KUNIT
> +	default KUNIT_ALL_TESTS
> +	help
> +	  This builds the printk ringbuffer KUnit test suite.
> +
> +	  For more information on KUnit and unit tests in general, please refer
> +	  to the KUnit documentation.
> +
> +	  If unsure, say N.
> +
>  config BUG
>  	bool "BUG() support" if EXPERT
>  	default y
> --- /dev/null
> +++ b/kernel/printk/printk_ringbuffer_test.c
> @@ -0,0 +1,350 @@
[...]
> +/* test data structure */
> +struct rbdata {
> +	unsigned int len;
> +	char text[] __counted_by(len);
> +};
> +
> +#define MAX_RBDATA_LEN (0x7f + 1)
> +#define MAX_RECORD_SIZE (sizeof(struct rbdata) + MAX_RBDATA_LEN + 1)

It is far from clear what the two +1 are for here.
Also 0x7f is hardcoded below once again.

I would personally do:

/* A mask used to generate random text len. */
#define RBDATA_TEXT_LEN_RND_MASK 0x7f
/* +2 to ensure at least 1 character + terminator. */
#define MAX_RBDATA_TEXT_SIZE (RBDATA_TEXT_LEN_RND_MASK + 2)
#define MAX_PRB_RECORD_SIZE (sizeof(struct rbdata) + MAX_RBDATA_TEXT_SIZE)

Note that I used the suffix _SIZE because I counted the terminator
in both definitions, see below.

> +static struct test_running {
> +	int runstate;
> +	unsigned long num;
> +	struct kunit *test;
> +} *test_running;
> +static int halt_test;
> +
> +static void fail_record(struct kunit *test, struct rbdata *dat, u64 seq)
> +{
> +	char buf[MAX_RBDATA_LEN + 1];

	char buf[MAX_RBDATA_TEXT_SIZE];

> +	snprintf(buf, sizeof(buf), "%s", dat->text);
> +	buf[sizeof(buf) - 1] = 0;
> +
> +	KUNIT_FAIL(test, "BAD RECORD: seq=%llu len=%u text=%s\n",
> +		   seq, dat->len, dat->len < sizeof(buf) ? buf : "<invalid>");
> +}
> +
> +static bool check_data(struct rbdata *dat)
> +{
> +	unsigned int len;
> +
> +	len = strnlen(dat->text, MAX_RBDATA_LEN + 1);

	len = strnlen(dat->text, MAX_RBDATA_TEXT_SIZE);

> +	/* Sane length? */
> +	if (len != dat->len || !len || len > MAX_RBDATA_LEN)

	if (len != dat->len || !len || len >= MAX_RBDATA_TEXT_SIZE)

Note that I have used >= instead of > because it is the _SIZE.

> +		return false;
> +
> +	/* String repeats with the same character? */
> +	while (len) {
> +		len--;
> +		if (dat->text[len] != dat->text[0])
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
> +/* Equivalent to CONFIG_LOG_BUF_SHIFT=13 */
> +DEFINE_PRINTKRB(test_rb, 8, 5);
> +
> +static int prbtest_writer(void *data)
> +{
> +	struct test_running *tr = data;
> +	char text_id = 'A' + tr->num;
> +	struct prb_reserved_entry e;
> +	unsigned long count = 0;
> +	struct printk_record r;
> +	u64 min_ns = (u64)-1;
> +	struct rbdata *dat;
> +	u64 total_ns = 0;
> +	u64 max_ns = 0;
> +	u64 post_ns;
> +	u64 pre_ns;
> +	int len;
> +
> +	set_cpus_allowed_ptr(current, cpumask_of(tr->num));
> +
> +	kunit_info(tr->test, "start thread %03lu (writer)\n", tr->num);
> +
> +	tr->runstate = 1;
> +
> +	for (;;) {
> +		/* +2 to ensure at least 1 character + terminator. */
> +		len = sizeof(struct rbdata) + (get_random_u32() & 0x7f) + 2;

		len = sizeof(struct rbdata) +
		      (get_random_u32() & RBDATA_TEXT_LEN_RND_MASK) + 2;

I would add

		WARN_ON_ONCE(len <= MAX_PRB_RECORD_SIZE);


> +		/* specify the text sizes for reservation */
> +		prb_rec_init_wr(&r, len);
> +
> +		pre_ns = local_clock();
> +
> +		if (prb_reserve(&e, &test_rb, &r)) {
> +			r.info->text_len = len;
> +
> +			len -= sizeof(struct rbdata) + 1;

I would add brackets to make it more clear that we actually substract
the "1":

			len -= (sizeof(struct rbdata) + 1);

or even better might be to create two variables:

		/* +1 to ensure at least 1 character*/
		len = (get_random_u32() & 0x7f) + 1;
		size = sizeof(struct rbdata) + len + 1;

> +
> +			dat = (struct rbdata *)&r.text_buf[0];
> +			dat->len = len;
> +			memset(&dat->text[0], text_id, len);
> +			dat->text[len] = 0;
> +
> +			prb_commit(&e);
> +
> +			post_ns = local_clock();

I think that the counting of the time will be misleading in CONFIG_PREEMPT=y.
We should disable preemption or even interrupts to get right numbers.

> +			wake_up_interruptible(&test_wait);
> +
> +			post_ns -= pre_ns;
> +			if (post_ns < min_ns)
> +				min_ns = post_ns;
> +			if (post_ns > max_ns)
> +				max_ns = post_ns;
> +			total_ns += post_ns;
> +		}
> +
> +		if ((count++ & 0x3fff) == 0)
> +			schedule();

This won't work as expected with CONFIG_PREEMPT=y.
IMHO, we should use simply use cond_resched() here.
a
> +		if (READ_ONCE(halt_test) == 1)
> +			break;
> +	}
> +
> +	kunit_info(tr->test, "end thread %03lu: wrote=%lu min_ns=%llu avg_ns=%llu max_ns=%llu\n",
> +		   tr->num, count, min_ns, total_ns / (u64)count, max_ns);
> +
> +	tr->runstate = 2;
> +
> +	return 0;
> +}
> +
> +static int prbtest_reader(void *data)
> +{
> +	struct test_running *tr = data;
> +	char text_buf[MAX_RECORD_SIZE];
> +	unsigned long total_lost = 0;
> +	unsigned long max_lost = 0;
> +	unsigned long count = 0;
> +	struct printk_info info;
> +	struct printk_record r;
> +	int did_sched = 1;
> +	u64 seq = 0;
> +
> +	set_cpus_allowed_ptr(current, cpumask_of(tr->num));
> +
> +	prb_rec_init_rd(&r, &info, &text_buf[0], sizeof(text_buf));
> +
> +	kunit_info(tr->test, "start thread %03lu (reader)\n", tr->num);
> +
> +	tr->runstate = 1;
> +
> +	while (!wait_event_interruptible(test_wait,
> +				kthread_should_stop() ||
> +				prb_read_valid(&test_rb, seq, &r))) {
> +		bool error = false;
> +
> +		if (kthread_should_stop())
> +			break;
> +		/* check/track the sequence */
> +		if (info.seq < seq) {
> +			KUNIT_FAIL(tr->test, "BAD SEQ READ: request=%llu read=%llu\n",
> +				   seq, info.seq);
> +			error = true;
> +		} else if (info.seq != seq && !did_sched) {
> +			total_lost += info.seq - seq;
> +			if (max_lost < info.seq - seq)
> +				max_lost = info.seq - seq;
> +		}
> +
> +		if (!check_data((struct rbdata *)&r.text_buf[0])) {
> +			fail_record(tr->test, (struct rbdata *)&r.text_buf[0], info.seq);
> +			error = true;
> +		}
> +
> +		if (error)
> +			WRITE_ONCE(halt_test, 1);
> +
> +		did_sched = 0;
> +		if ((count++ & 0x3fff) == 0) {
> +			did_sched = 1;
> +			schedule();
> +		}

This won't work with CONFIG_PREEMPT=Y. I would use cond_resched()
and detect scheduling by checking the switch count. I think that
it should be:

	switch_count = READ_ONCE(current->nvcsw + current->nivcsw);

It is inspired by check_hung_task().

> +		if (READ_ONCE(halt_test) == 1)
> +			break;
> +
> +		seq = info.seq + 1;
> +	}
> +
> +	kunit_info(tr->test,
> +		   "end thread %03lu: read=%lu seq=%llu total_lost=%lu max_lost=%lu\n",
> +		   tr->num, count, info.seq, total_lost, max_lost);
> +
> +	while (!kthread_should_stop())
> +		msleep(1000);
> +	tr->runstate = 2;
> +
> +	return 0;
> +}

This is what I have found on top of the review by David Gow.

Best Regards,
Petr

