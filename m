Return-Path: <linux-kselftest+bounces-7200-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEFE898A7D
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 16:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A50C01F2134F
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 14:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A8A1BF37;
	Thu,  4 Apr 2024 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i8agMKCi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430DE1C290
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Apr 2024 14:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712242564; cv=none; b=a3SKSYB4sKKmK5oNuq+9XaJwkXIrwpzaiyS3OA7aIhpW8Ai4OZAfRzGrsDKWxmUtha6KV6ctd3mxUMqDrpl1v9vtT3deL2eulYQIFvo2MdZNvufz53Jtu/GjSzFvSCY1xioyydZlWlJww3NRkwdzZUJFBz/4goH6Q7O9Z3Bojq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712242564; c=relaxed/simple;
	bh=1CavvPgllyAa/15cVaRGGxEOJZQLKhATrB9uOUZKE7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJZFskJNPZWC5Rkc/sYOGW8g/QzT8HGQ7KgM8PfnEIFfKfbx+R3rEPTMwVz5n6k6J+b06rfyBVmluWvq5m5QRbHVab5AIcCtMP8sYj5lJLywjsFVMFmfI2aAU+T/lNE5cnjn2QSUVLnOUfakw0ESovfzWE2LoiJq9owarKPwUHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i8agMKCi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712242562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NQJMd58pUdtgy9XOZ35rBzvDWBc5FSPJawvsuooB2RU=;
	b=i8agMKCihr4fGxGvwqCrMjcZqPrxY6HUJYSiK8KHK/ucoXQOaqXUDwdzmVGWfrd4GCukt2
	Gfw3YnHejZT3exTbNt51W4FWDAytKGm/wudtE9uNlGeonH7r/tcj+TvL+wT+ojvvS3byU4
	akXdYsr0fAYNEdsy9vTxm7lveyHRNOo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-N99Y3y5yNh-I55Dli-sewA-1; Thu, 04 Apr 2024 10:55:57 -0400
X-MC-Unique: N99Y3y5yNh-I55Dli-sewA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1BBF088FBAB;
	Thu,  4 Apr 2024 14:55:57 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.21])
	by smtp.corp.redhat.com (Postfix) with SMTP id 43CDC3C21;
	Thu,  4 Apr 2024 14:55:54 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  4 Apr 2024 16:54:32 +0200 (CEST)
Date: Thu, 4 Apr 2024 16:54:08 +0200
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
Subject: Re: [PATCH v6 1/2] posix-timers: Prefer delivery of signals to the
 current thread
Message-ID: <20240404145408.GD7153@redhat.com>
References: <87sf02bgez.ffs@tglx>
 <87r0fmbe65.ffs@tglx>
 <CANDhNCoGRnXLYRzQWpy2ZzsuAXeraqT4R13tHXmiUtGzZRD3gA@mail.gmail.com>
 <87o7aqb6uw.ffs@tglx>
 <CANDhNCreA6nJp4ZUhgcxNB5Zye1aySDoU99+_GDS57HAF4jZ_Q@mail.gmail.com>
 <87frw2axv0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87frw2axv0.ffs@tglx>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 04/04, Thomas Gleixner wrote:
>
> IOW, we cannot test this reliably at all with the current approach.

Agreed!

So how about a REALLY SIMPLE test-case below?

Lacks error checking, should be updated to match tools/testing/selftests.

Without commit bcb7ee79029dca assert(sig_cnt > SIG_CNT) fails, the very
1st tick wakes the leader up.

With that commit it doesn't fail.

Oleg.

#include <stdio.h>
#include <unistd.h>
#include <signal.h>
#include <pthread.h>
#include <time.h>
#include <assert.h>

#define SIG_CNT	100
static volatile int sig_cnt;

static void alarm_func(int sig)
{
	++sig_cnt;
}

static void *thread_func(void *arg)
{
	// one second before the 1st tick to ensure the leader sleeps
	struct itimerspec val = {
		.it_value.tv_sec = 1,
		.it_value.tv_nsec = 0,
		.it_interval.tv_sec = 0,
		.it_interval.tv_nsec = 1000 * 1000,
	};
	timer_t id;

	timer_create(CLOCK_PROCESS_CPUTIME_ID, NULL, &id);
	timer_settime(id, 0, &val, NULL);

	while (sig_cnt < SIG_CNT)
		;

	// wake up the leader
	kill(getpid(), SIGALRM);

	return NULL;
}

int main(void)
{
	pthread_t thread;

	signal(SIGALRM, alarm_func);

	pthread_create(&thread, NULL, thread_func, NULL);

	pause();

	assert(sig_cnt > SIG_CNT); // likely SIG_CNT + 1

	return 0;
}


