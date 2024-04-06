Return-Path: <linux-kselftest+bounces-7333-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6FD89AB90
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 17:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85179282198
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Apr 2024 15:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E14838F86;
	Sat,  6 Apr 2024 15:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="erp5qJpM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B42A3A26E
	for <linux-kselftest@vger.kernel.org>; Sat,  6 Apr 2024 15:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712416377; cv=none; b=WJxalmyGwhMU9V70NvpTIfwmqJlAOlOAq9I5BQhMI+ZvEINCG4LzCvmvXL2RrnUCx4qtDTVVKdbpBHBkkfBxIuu0t2MA+kvuenhQBAuA+WfbRrLj4dAu57rCGQj3DGdzC3XkZ9FIHR+3QrbzU0TcR0wLBZ1wwzxj94mPn7QqAp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712416377; c=relaxed/simple;
	bh=TGvd7DPOXBnqIHw4CG35kLdg70o6plHtI96anJSdFnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uv+hc+VeFuWoAifNtlBGuea0ZvtgekIT9XJ+P3URJR3Wd/4beSdz7dcL2Eo077f55S689pnVUPp0feMWjQUP0cQgWkUJVCeMkNXTb874qjdBVspXEuie5XFTSg7U81/iddVB4CHOxo3gEUzkgR+5lEU+i0zENlTuovAeJNqmGnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=erp5qJpM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712416374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BGna14aQz4iT3c7nYzBJYPjJNR/JUSUa0PJutHav/fU=;
	b=erp5qJpMYHUHLb/mLqZu7u3cH38sf79MuJ7nfuwKjTMkATOYkiq6y3+BNrnDgJltB/exAh
	jmoO7V//WFu13Dt7ghCVf3AwH1jSr8VdPJYRRSdXoy3dIKk53YgoNHjby4ZUyTkruux/2G
	FaldIklJmLPdLSDvY5aFi9au17lXtlo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-aioIAyOMMAu4xX5FZxTryw-1; Sat,
 06 Apr 2024 11:12:47 -0400
X-MC-Unique: aioIAyOMMAu4xX5FZxTryw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B957A3806061;
	Sat,  6 Apr 2024 15:12:46 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.136])
	by smtp.corp.redhat.com (Postfix) with SMTP id A39DD3C20;
	Sat,  6 Apr 2024 15:12:43 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat,  6 Apr 2024 17:11:21 +0200 (CEST)
Date: Sat, 6 Apr 2024 17:10:58 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <jstultz@google.com>, Marco Elver <elver@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
	Edward Liaw <edliaw@google.com>,
	Carlos Llamas <cmllamas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] selftests/timers/posix_timers: reimplement
 check_timer_distribution()
Message-ID: <20240406151057.GB3060@redhat.com>
References: <87sf02bgez.ffs@tglx>
 <87r0fmbe65.ffs@tglx>
 <CANDhNCoGRnXLYRzQWpy2ZzsuAXeraqT4R13tHXmiUtGzZRD3gA@mail.gmail.com>
 <87o7aqb6uw.ffs@tglx>
 <CANDhNCreA6nJp4ZUhgcxNB5Zye1aySDoU99+_GDS57HAF4jZ_Q@mail.gmail.com>
 <87frw2axv0.ffs@tglx>
 <20240404145408.GD7153@redhat.com>
 <87le5t9f14.ffs@tglx>
 <20240406150950.GA3060@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240406150950.GA3060@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Dmitry, Thomas,

To simplify the review I've attached the code with this patch applied below.

Yes, this changes the "semantics" of check_timer_distribution(), perhaps it
should be renamed.

But I do not see a better approach, and in fact I think that

	Test that all running threads _eventually_ receive CLOCK_PROCESS_CPUTIME_ID

is the wrong goal.

Do you agree?

Oleg.
-------------------------------------------------------------------------------

static pthread_t ctd_thread;
static volatile int ctd_count, ctd_failed;

static void ctd_sighandler(int sig)
{
	if (pthread_self() != ctd_thread)
		ctd_failed = 1;
	ctd_count--;
}

static void *ctd_thread_func(void *arg)
{
	struct itimerspec val = {
		.it_value.tv_sec = 0,
		.it_value.tv_nsec = 1000 * 1000,
		.it_interval.tv_sec = 0,
		.it_interval.tv_nsec = 1000 * 1000,
	};
	timer_t id;

	/* 1/10 seconds to ensure the leader sleeps */
	usleep(10000);

	ctd_count = 100;
	if (timer_create(CLOCK_PROCESS_CPUTIME_ID, NULL, &id))
		return "Can't create timer";
	if (timer_settime(id, 0, &val, NULL))
		return "Can't set timer";

	while (ctd_count > 0 && !ctd_failed)
		;

	if (timer_delete(id))
		return "Can't delete timer";

	return NULL;
}

/*
 * Test that only the running thread receives the timer signal.
 */
static int check_timer_distribution(void)
{
	const char *errmsg;

	signal(SIGALRM, ctd_sighandler);

	errmsg = "Can't create thread";
	if (pthread_create(&ctd_thread, NULL, ctd_thread_func, NULL))
		goto err;

	errmsg = "Can't join thread";
	if (pthread_join(ctd_thread, (void **)&errmsg) || errmsg)
		goto err;

	if (ctd_failed)
		ksft_test_result_skip("No signal distribution. Assuming old kernel\n");
	else
		ksft_test_result_pass("check signal distribution\n");

	return 0;
err:
	ksft_print_msg(errmsg);
	return -1;
}


