Return-Path: <linux-kselftest+bounces-7193-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3139A89890A
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 15:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB1691F229DA
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 13:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0878128384;
	Thu,  4 Apr 2024 13:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B/6yTEiq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D90E128361
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Apr 2024 13:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712238354; cv=none; b=gm9jSvgfCMvO9vvOGCdTbH+EYVKJwl7ct0JJvInAXC5f9RhNlbZgT7xUJEhPANP4JXjHpArkggIjAfdB9zG7Y3wLDtaWUIWowXC4KtnCZoiw2WVdhRi37Cyjp1r2GfDQEBc7slOlSh+KiaP6FL3yRKKOg9S42JSJfazz2ZS7uEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712238354; c=relaxed/simple;
	bh=rIJ5gF+bcRTkcUlaZMOl88O4Cd9tIV5iHXQOl87YQrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQ0k0CkkiEY6fKn9f0iQU3ypnoNqPKs1QNNryT1pmv1k2FNhsCE2eL7RXv6U2ctxEPUCtH8Y1DCoC36VwsPmZXuUIs26C+EPVyCCpGmKnX/wtn1l2qVM+JWzKWNavBlWdPEzXDa2tmH1J5WlvfRzb8MQ3D3vPQga2X3hCUpGYdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B/6yTEiq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712238352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rIJ5gF+bcRTkcUlaZMOl88O4Cd9tIV5iHXQOl87YQrE=;
	b=B/6yTEiqq0HnLD+kRMrGG0eH4mG9CZdN3UeR2CucS22b8Owf7g7ZUdqCw+/AKaqrOFX6Zn
	q/epV/fWlgjdLiSj8rGfjY7IgDbmoQua42WHn2ODkSaq97cCjvXmPoQf0IIlIXyPRGmJwr
	arxtwLU2yHaW+kaK1K1NxHqDpG4L9pM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-xFKJxaPUPkGlWmgqta_Asw-1; Thu, 04 Apr 2024 09:45:47 -0400
X-MC-Unique: xFKJxaPUPkGlWmgqta_Asw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E69F85A5B7;
	Thu,  4 Apr 2024 13:45:30 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.21])
	by smtp.corp.redhat.com (Postfix) with SMTP id 8942F492BD1;
	Thu,  4 Apr 2024 13:45:27 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  4 Apr 2024 15:44:05 +0200 (CEST)
Date: Thu, 4 Apr 2024 15:43:57 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
	Marco Elver <elver@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kasan-dev@googlegroups.com, Edward Liaw <edliaw@google.com>,
	Carlos Llamas <cmllamas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 1/2] posix-timers: Prefer delivery of signals to the
 current thread
Message-ID: <20240404134357.GA7153@redhat.com>
References: <20230316123028.2890338-1-elver@google.com>
 <CANDhNCqBGnAr_MSBhQxWo+-8YnPPggxoVL32zVrDB+NcoKXVPQ@mail.gmail.com>
 <87frw3dd7d.ffs@tglx>
 <CANDhNCqbJHTNcnBj=twHQqtLjXiGNeGJ8tsbPrhGFq4Qz53c5w@mail.gmail.com>
 <874jcid3f6.ffs@tglx>
 <20240403150343.GC31764@redhat.com>
 <87sf02bgez.ffs@tglx>
 <CACT4Y+a-kdkAjmACJuDzrhmUPmv9uMpYOg6LLVviMQn=+9JRgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+a-kdkAjmACJuDzrhmUPmv9uMpYOg6LLVviMQn=+9JRgA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Perhaps I am totally confused, but.

On 04/04, Dmitry Vyukov wrote:
>
> On Wed, 3 Apr 2024 at 17:43, Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > > Why distribution_thread() can't simply exit if got_signal != 0 ?
> > >
> > > See https://lore.kernel.org/all/20230128195641.GA14906@redhat.com/
> >
> > Indeed. It's too obvious :)
>
> This test models the intended use-case that was the motivation for the change:
> We want to sample execution of a running multi-threaded program, it
> has multiple active threads (that don't exit), since all threads are
> running and consuming CPU,

Yes,

> they all should get a signal eventually.

Well, yes and no.

No, in a sense that the motivation was not to ensure that all threads
get a signal, the motivation was to ensure that cpu_timer_fire() paths
will use the current task as the default target for signal_wake_up/etc.
This is just optimization.

But yes, all should get a signal eventually. And this will happen with
or without the commit bcb7ee79029dca ("posix-timers: Prefer delivery of
signals to the current thread"). Any thread can dequeue a shared signal,
say, on return from interrupt.

Just without that commit this "eventually" means A_LOT_OF_TIME statistically.

> If threads will exit once they get a signal,

just in case, the main thread should not exit ...

> then the test will pass
> even if signal delivery is biased towards a single running thread all
> the time (the previous kernel impl).

See above.

But yes, I agree, if thread exits once it get a signal, then A_LOT_OF_TIME
will be significantly decreased. But again, this is just statistical issue,
I do not see how can we test the commit bcb7ee79029dca reliably.

OTOH. If the threads do not exit after they get signal, then _in theory_
nothing can guarantee that this test-case will ever complete even with
that commit. It is possible that one of the threads will "never" have a
chance to run cpu_timer_fire().

In short, I leave this to you and Thomas. I have no idea how to write a
"good" test for that commit.

Well... perhaps the main thread should just sleep in pause(), and
distribution_handler() should check that gettid() != getpid() ?
Something like this maybe... We need to ensure that the main thread
enters pause before timer_settime().

Oleg.


