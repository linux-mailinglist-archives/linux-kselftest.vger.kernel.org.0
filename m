Return-Path: <linux-kselftest+bounces-41674-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6E2B7E9D8
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 14:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1BE0188C7C5
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 12:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C91230CB25;
	Wed, 17 Sep 2025 12:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0iAu4bf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DE3183CA6
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 12:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113460; cv=none; b=Jc8jXpHMLiPpCOVnbtF29CB05qh1mxPmgkLY0aCCCs5NtfQVVBOQRtUY+AC1iQEJUGeAcQeLDbGHZMjGkhzOr2wNttoQ2S+2YqksyqBfSJ1R+RBsloffUt683G78xf6b9/yRc3JqACKtwNvb/oKUZ8IMR8hUbOJedcGe8AOWcsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113460; c=relaxed/simple;
	bh=6W7LdjEg9c75ZY24gbntewQyMFhu8A3a6cFM/hRcPNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OipPSHGofmsFhGrWiuvEYht4NFxDTpGe1r7LtpupI4R3MAQ88Uvhb7NKt3g/8Q5a2OEo9yFZJ7Oxl9a73EVUxleAQ/+mAC+fr2F9jObkfv+Y3hlb/8PKRr3hZQCsQbdheu/m6bPR8cBWY5bwMB7o4dCYLxhRu7dNHYmw30qwjX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U0iAu4bf; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45dd5e24d16so62653195e9.3
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 05:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758113457; x=1758718257; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/eSyRA5oueLfSAHQhBZdQPij9wtIRHuJIzp8LeX2224=;
        b=U0iAu4bfH0MZI/s1RpfV40eEkDSdChd9h8Ei4xeZE4nArzInXYvQv4v6Y5VJFxjfrT
         mkgo3rEf69xPXqy6NRwwmogCC+zgSJLuj0JhpDisPqYzQiFEgR1BbYNTFqEpydKxovCn
         5w+6XcZOHdx/WXxswS5AdcoKtiBOSIz0YkSrwJeYr3Bhz9LALjd8TU5t1l7vBcTqbD0A
         EZj9zC3ycgrkN08CIkmcuBhdYi2NbUFQrA3oZ0yLfr6hTC0EbqFvSSM/JzorPBlE+ACT
         tXCGWfalAvNZm4+flZGsAolY+IPS2X/xToY/Ek6fguVWqTH9gISvNgoxHgOrs6QNpaSr
         MFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758113457; x=1758718257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/eSyRA5oueLfSAHQhBZdQPij9wtIRHuJIzp8LeX2224=;
        b=GMQCsKFFCL/19cj1XAEtk/V1EhYriahzvHrlwuZFT+iryXNh6zZwVfGtFBjGObvAWf
         YgAg105Nmqaoono2gGIox+IsT2yoXhFNZOFQvzJoPx9M9okvvCr7ZKa+6ZuI3KSSiGnu
         kcK0FLAHT9WTCBW/uZvuOQNG2YaQqSxc4vwBu+NMdgZXSNnOFwMyzGihXpCfcaGlvddy
         NxYUKZ8++5wudM6cM+j8iP+/9VFK8+pv7cMgmBUqobpNcDDAE69xDRmW4aesCd2m2pUo
         G34ef9ovcpw1hk7WNiCzknbvqbdJqeBH8t0qiF8kb4vrQeBny+kghVCSHu+sXKxrXIUX
         +0ug==
X-Forwarded-Encrypted: i=1; AJvYcCWuk/GbalinuRerJ0L2QbM/Ur/6/TAuUQxndvZFw7RtkhEuYXNcePQ63qbOcn9KEVqypEHE+5c7EBXJG5byeyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw8Vlsa52IXvSB7ZlmMOddEXnfkQ+FFCzPnKqpHs5lbs1OouZU
	JS4eb+wKUyihotUyPtR309fzSS4p5h2Cdp12AceJshV0YOHvNin/JHr3
X-Gm-Gg: ASbGnctLLmSXzXhCC9y8PqJxSCIYI/tL4JiGLFyVE6e/UJ5jdCVPBA2mL+29gSgZKy3
	2NqFfW8p53Tst4SlXOArygqRlN2ycj0V/OtSwyWu/0sXB4V3xYO2fe0U917BKCze+O6GhqELaV3
	7xQb9rLhbWbQoIABhVFzoaLHRFAA1K7Sl3yatOvG9p+rB1QojEjpvReHU+d0bWbZKnfk1EZUWhe
	vF0ummKHfhnq1OWiJ2oOHl/1d4m/0i9KQp4aLupDMrfr9Nj0qcRM7Gnk2mdlHM4FmzI5txf+slW
	MZDXm5xfvtEwO3KHaVQDiwdbW3M+1FgZP2J20D9YK+vDoXZvDhamoh2JQguAtqal/aVr7+P3grk
	bM8VUkB+vssIas49Pud6gYadY2lrwAMMj5dxenjps9xLkiuAuxjPBSdEyMLkZsby/djiLAw==
X-Google-Smtp-Source: AGHT+IHFSppk996QzBjjlSKFZhWiUI+JlDHTsb1+baHRJATrYU3tIfMGlg87oF6xS1Lygp8exZOqtQ==
X-Received: by 2002:a05:600c:1549:b0:45d:cfc6:5166 with SMTP id 5b1f17b1804b1-46205eb142emr21520885e9.23.1758113456708;
        Wed, 17 Sep 2025 05:50:56 -0700 (PDT)
Received: from f (cst-prg-88-146.cust.vodafone.cz. [46.135.88.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46138695223sm35987005e9.5.2025.09.17.05.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 05:50:55 -0700 (PDT)
Date: Wed, 17 Sep 2025 14:49:43 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Khazhismel Kumykov <khazhy@google.com>, Willem de Bruijn <willemb@google.com>, 
	Eric Dumazet <edumazet@google.com>, Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] eventpoll: Fix epoll_wait() report false negative
Message-ID: <aflo53gea7i6cyy22avn7mqxb3xboakgjwnmj4bqmjp6oafejj@owgv35lly7zq>
References: <cover.1752824628.git.namcao@linutronix.de>
 <43d64ad765e2c47e958f01246320359b11379466.1752824628.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <43d64ad765e2c47e958f01246320359b11379466.1752824628.git.namcao@linutronix.de>

On Fri, Jul 18, 2025 at 09:52:29AM +0200, Nam Cao wrote:
> ep_events_available() checks for available events by looking at ep->rdllist
> and ep->ovflist. However, this is done without a lock, therefore the
> returned value is not reliable. Because it is possible that both checks on
> ep->rdllist and ep->ovflist are false while ep_start_scan() or
> ep_done_scan() is being executed on other CPUs, despite events are
> available.
> 
> This bug can be observed by:
> 
>   1. Create an eventpoll with at least one ready level-triggered event
> 
>   2. Create multiple threads who do epoll_wait() with zero timeout. The
>      threads do not consume the events, therefore all epoll_wait() should
>      return at least one event.
> 
> If one thread is executing ep_events_available() while another thread is
> executing ep_start_scan() or ep_done_scan(), epoll_wait() may wrongly
> return no event for the former thread.
> 
> This reproducer is implemented as TEST(epoll65) in
> tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c
> 
> Fix it by skipping ep_events_available(), just call ep_try_send_events()
> directly.
> 
> epoll_sendevents() (io_uring) suffers the same problem, fix that as well.
> 
> There is still ep_busy_loop() who uses ep_events_available() without lock,
> but it is probably okay (?) for busy-polling.
> 

I'll say upfront I'm not an epoll person, just looked here out of
curiosity.

I can agree there is a bug. The event is generated before any of the
threads even exist and they only poll for it, none of them consume it.

However, the commit message fails to explain why the change fixes
anything and I think your patch de facto reverts e59d3c64cba6 ("epoll:
eliminate unnecessary lock for zero timeout"). Looking at that diff
the point was to avoid the expensive lock trip if timeout == 0 and there
are no events.

As for the bug is, from my reading the ep_start_scan()/ep_done_scan()
pair transiently disturbs the state checked by ep_events_available(),
resulting in false-negatives. Then the locked check works because by the
time you acquire it, the damage is undone.

Given the commits referenced in Fixes:, I suspect the real fix would be
to stop destroying that state of course.

But if that's not feasible, I would check if a sequence counter around
this would do the trick -- then the racy ep_events_available(ep) upfront
would become safe with smaller overhead than with your proposal for the
no-event case, but with higher overhead when there is something.

My proposal is trivial to implement, I have no idea if it will get a
buy-in though.

> Fixes: c5a282e9635e ("fs/epoll: reduce the scope of wq lock in
> epoll_wait()") Fixes: e59d3c64cba6 ("epoll: eliminate unnecessary lock
> for zero timeout") Fixes: ae3a4f1fdc2c ("eventpoll: add
> epoll_sendevents() helper") Signed-off-by: Nam Cao
> <namcao@linutronix.de>
> Cc: stable@vger.kernel.org
> ---
>  fs/eventpoll.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index 0fbf5dfedb24..541481eafc20 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -2022,7 +2022,7 @@ static int ep_schedule_timeout(ktime_t *to)
>  static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
>  		   int maxevents, struct timespec64 *timeout)
>  {
> -	int res, eavail, timed_out = 0;
> +	int res, eavail = 1, timed_out = 0;
>  	u64 slack = 0;
>  	wait_queue_entry_t wait;
>  	ktime_t expires, *to = NULL;
> @@ -2041,16 +2041,6 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
>  		timed_out = 1;
>  	}
>  
> -	/*
> -	 * This call is racy: We may or may not see events that are being added
> -	 * to the ready list under the lock (e.g., in IRQ callbacks). For cases
> -	 * with a non-zero timeout, this thread will check the ready list under
> -	 * lock and will add to the wait queue.  For cases with a zero
> -	 * timeout, the user by definition should not care and will have to
> -	 * recheck again.
> -	 */
> -	eavail = ep_events_available(ep);
> -
>  	while (1) {
>  		if (eavail) {
>  			res = ep_try_send_events(ep, events, maxevents);
> @@ -2496,9 +2486,7 @@ int epoll_sendevents(struct file *file, struct epoll_event __user *events,
>  	 * Racy call, but that's ok - it should get retried based on
>  	 * poll readiness anyway.
>  	 */
> -	if (ep_events_available(ep))
> -		return ep_try_send_events(ep, events, maxevents);
> -	return 0;
> +	return ep_try_send_events(ep, events, maxevents);
>  }
>  
>  /*
> -- 
> 2.39.5
> 

