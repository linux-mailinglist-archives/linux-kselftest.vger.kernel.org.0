Return-Path: <linux-kselftest+bounces-7346-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E3089ACFF
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 23:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97E76282120
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 21:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710754EB51;
	Sat,  6 Apr 2024 21:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DZPRGUz3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985474DA0D
	for <linux-kselftest@vger.kernel.org>; Sat,  6 Apr 2024 21:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712438092; cv=none; b=MPpJsKlRYoYpZA6LWlEXwgAEiLZRKACG14wN2sAKmcu4l9sbAMM+5TdUWLIolT/k6VQgJ2ArGNNKOJ1HXdWdx3cagPJZLGNawQPUd6XCbltDmze6+jSG7MaE+0itS1NMjqpWoVXo8box99ZMBZp2z5PrGzoQqPj5soNyxHT8Yvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712438092; c=relaxed/simple;
	bh=dmNNyfbVSsVmGstlEtt+9GFUYC6Tw+gx4nXYmXDUBh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LcRQg97DD8EX2ecUykrFr7mJtuM/OsEY06A0pF/6PR5SPDr8krR6TS0Ps1FLEGktNvy9IQ+3sLQE9DAa6KI6ksY0XhTLrtTHfPEz8XBW8MU73BMTSEiwe9zwFuLCmmixXZVi3zkGSTtu9SWcsz/ubQdDk7R+ne5uEiAmVhLyP+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DZPRGUz3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712438089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oHlEIGlMy5AeytAApxqnvbACljlKOkZKhDAKTWpoYzU=;
	b=DZPRGUz3isSNzRRzBeEcix0QeuhgcVQamI58OfNBwlhqq++4O8wUZCW4BEF3nGQh/I2U1t
	ochdpn43Uu/aNfqNtIe58uKYPXgxD2CyMipoDNp7h0j/3X96nWxcR2W4V/1mzNYCDxH7B4
	64udNuZxfdPG8uVlB2Swo5Eqat7/JAI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-xrmUZh_FPx27M8azjuNlpg-1; Sat, 06 Apr 2024 17:14:45 -0400
X-MC-Unique: xrmUZh_FPx27M8azjuNlpg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0DBCD180A1E7;
	Sat,  6 Apr 2024 21:14:45 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.136])
	by smtp.corp.redhat.com (Postfix) with SMTP id A5BB2100077A;
	Sat,  6 Apr 2024 21:14:42 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat,  6 Apr 2024 23:13:20 +0200 (CEST)
Date: Sat, 6 Apr 2024 23:13:13 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Marco Elver <elver@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Subject: Re: [PATCH v6 2/2] selftests/timers/posix_timers: Test delivery of
 signals across threads
Message-ID: <20240406211312.GD3060@redhat.com>
References: <20230316123028.2890338-1-elver@google.com>
 <20230316123028.2890338-2-elver@google.com>
 <46ad25c9-f63c-4bb7-9707-4bc8b21ccaca@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46ad25c9-f63c-4bb7-9707-4bc8b21ccaca@collabora.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Muhammad,

I am sorry, but... are you aware that this patch was applied over a year ago,
and then this code was updated to use the ksft_API?

Oleg.

On 04/07, Muhammad Usama Anjum wrote:
>
> On 3/16/23 5:30 PM, Marco Elver wrote:
> > From: Dmitry Vyukov <dvyukov@google.com>
> > 
> > Test that POSIX timers using CLOCK_PROCESS_CPUTIME_ID eventually deliver
> > a signal to all running threads.  This effectively tests that the kernel
> > doesn't prefer any one thread (or subset of threads) for signal delivery.
> > 
> > Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> > v6:
> > - Update wording on what the test aims to test.
> > - Fix formatting per checkpatch.pl.
> > ---
> >  tools/testing/selftests/timers/posix_timers.c | 77 +++++++++++++++++++
> >  1 file changed, 77 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/selftests/timers/posix_timers.c
> > index 0ba500056e63..8a17c0e8d82b 100644
> > --- a/tools/testing/selftests/timers/posix_timers.c
> > +++ b/tools/testing/selftests/timers/posix_timers.c
> > @@ -188,6 +188,80 @@ static int check_timer_create(int which)
> >  	return 0;
> >  }
> >  
> > +int remain;
> > +__thread int got_signal;
> > +
> > +static void *distribution_thread(void *arg)
> > +{
> > +	while (__atomic_load_n(&remain, __ATOMIC_RELAXED));
> > +	return NULL;
> > +}
> > +
> > +static void distribution_handler(int nr)
> > +{
> > +	if (!__atomic_exchange_n(&got_signal, 1, __ATOMIC_RELAXED))
> > +		__atomic_fetch_sub(&remain, 1, __ATOMIC_RELAXED);
> > +}
> > +
> > +/*
> > + * Test that all running threads _eventually_ receive CLOCK_PROCESS_CPUTIME_ID
> > + * timer signals. This primarily tests that the kernel does not favour any one.
> > + */
> > +static int check_timer_distribution(void)
> > +{
> > +	int err, i;
> > +	timer_t id;
> > +	const int nthreads = 10;
> > +	pthread_t threads[nthreads];
> > +	struct itimerspec val = {
> > +		.it_value.tv_sec = 0,
> > +		.it_value.tv_nsec = 1000 * 1000,
> > +		.it_interval.tv_sec = 0,
> > +		.it_interval.tv_nsec = 1000 * 1000,
> > +	};
> > +
> > +	printf("Check timer_create() per process signal distribution... ");
> Use APIs from kselftest.h. Use ksft_print_msg() here.
> 
> > +	fflush(stdout);
> > +
> > +	remain = nthreads + 1;  /* worker threads + this thread */
> > +	signal(SIGALRM, distribution_handler);
> > +	err = timer_create(CLOCK_PROCESS_CPUTIME_ID, NULL, &id);
> > +	if (err < 0) {
> > +		perror("Can't create timer\n");
> ksft_perror() here
> 
> > +		return -1;
> > +	}
> > +	err = timer_settime(id, 0, &val, NULL);
> > +	if (err < 0) {
> > +		perror("Can't set timer\n");
> > +		return -1;
> > +	}
> > +
> > +	for (i = 0; i < nthreads; i++) {
> > +		if (pthread_create(&threads[i], NULL, distribution_thread, NULL)) {
> > +			perror("Can't create thread\n");
> > +			return -1;
> > +		}
> > +	}
> > +
> > +	/* Wait for all threads to receive the signal. */
> > +	while (__atomic_load_n(&remain, __ATOMIC_RELAXED));
> > +
> > +	for (i = 0; i < nthreads; i++) {
> > +		if (pthread_join(threads[i], NULL)) {
> > +			perror("Can't join thread\n");
> > +			return -1;
> > +		}
> > +	}
> > +
> > +	if (timer_delete(id)) {
> > +		perror("Can't delete timer\n");
> > +		return -1;
> > +	}
> > +
> > +	printf("[OK]\n");
> ksft_test_result or _pass variant as needed?
> 
> > +	return 0;
> > +}
> > +
> >  int main(int argc, char **argv)
> >  {
> >  	printf("Testing posix timers. False negative may happen on CPU execution \n");
> > @@ -217,5 +291,8 @@ int main(int argc, char **argv)
> >  	if (check_timer_create(CLOCK_PROCESS_CPUTIME_ID) < 0)
> >  		return ksft_exit_fail();
> >  
> > +	if (check_timer_distribution() < 0)
> > +		return ksft_exit_fail();
> > +
> >  	return ksft_exit_pass();
> >  }
> 
> -- 
> BR,
> Muhammad Usama Anjum
> 


