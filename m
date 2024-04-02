Return-Path: <linux-kselftest+bounces-6978-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB533894E57
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 11:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C2D21F2318B
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 09:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A2E57302;
	Tue,  2 Apr 2024 09:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2QX5B+0D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2598856763
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Apr 2024 09:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712048872; cv=none; b=MBREC+klIoZwiIKEsatnxCSsPuSga+M1GEswKzX9ZA0F4lPk8sDxSlQ9aV3/4jKqDdJCqlYwfcig0IR2Eu0EXI1xVSFl6uVIr+FgVZ5sjGqSs6G4qU2oSnPwr1n6DTuJIS8jfDPclCs4geB7hFjxHeMyTRuzRw6yJYbRtoH49HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712048872; c=relaxed/simple;
	bh=BmiFl2dlvUSQbFQDIWYMV3yfnVRwHbjvGePU4GqEhN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WWdJvBCA1M40wBxzEmBeepLtDf8H3U8IpUhJa0Zb8j8flH8E6rT4+mFT1hIn2lsIf1WOAMhM68nSL6jzgTWMsZXgErLNVSAX6oxnMLv+55xvj5CD5RX3/pFddqglMM4E3VeEMZIie2IrYKcPCqQa4dsEzB/YbeU4dtUqCH95N8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2QX5B+0D; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56c2cfdd728so43471a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Apr 2024 02:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712048868; x=1712653668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gj2lIs7j0qMeOLAI9CgIcyOVJL5/QjEQamjTy+gS40c=;
        b=2QX5B+0DXiqwvck7Z+42zwaJpGf2S/dkfH9YaQC/K9cAKOiFssmHJLmlkl+5F/J5So
         1XFmATGk41aWRmthoO9NWyqxcV+fZ/CR8oNkHWt/N1/rcRcrQF4/QSwm9H4hbVZERs++
         Al5miBvPdIUBtoFuXc/h0JViqMAylpJi89knJVNWZOpZ2um6osfOH3HKBgwflhXH2oxL
         BlqTHhFSKzJy1weiirQ8XGHu8FkBonBjid4Bodx0R6GdXZDRROkKOSxEJRHMiZnSEmJB
         6O3yAC0ZQMnD8JCq39xiDrTYizilHKrGCdNLhc4s3dPP4b1bzcbh9kqmkpvoTupFIGMz
         xhpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712048868; x=1712653668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gj2lIs7j0qMeOLAI9CgIcyOVJL5/QjEQamjTy+gS40c=;
        b=A79hTTr1IUvjku2x85h38RGfryU8bPFEJ8A+1DIdkWJ7WQgsnblj0+ox5ELsZx3Nz2
         QPbwglDeITcBDcjKNWzNX0MmN4OiyD157p5w+EJ5X3ugccpUvuD+CYsJK3hI+3G/AxKF
         /iKqBl8iIoDvXIHvbQXtrJY5tok143UP50+hlzXZn2LiXO9i42HYqu1zwIQJyiAGGyB/
         dXLwut2s7XfaQ1ot0IHYiUZIvqgPtHGTluqqXxWbICUbL+5xB0RKNRoPvUrTbW9cqb1E
         0oELueNl/UjESRGzTTso8RHACXAlQdR028+Z9F8enJAdG9+t70fDDVJkLsPdcdWlDxNv
         I8AA==
X-Forwarded-Encrypted: i=1; AJvYcCWsqq5b0aIeTKfSvPvK3J3Q3OADc/Rj5pskxPJpa8Gqd3lwTqt9k7K8CCjfNjzBloAYuMXRUHMOygy84774/Pw2u3F7yWVvV4NBrFdjlxcr
X-Gm-Message-State: AOJu0YyXQPqYI+JGCTW90xHr6jwSM71ckr3NLY8y9vgbqFyEC8RrqgnH
	tv8gMZqvOJADhmOoeKDiRfqFegJpOqKRiwhoBXvrCpHnk3iCCGYL7PN+kefN8m4KDNYCAeYiNIw
	/Zbn+Hk1g83NlG86AbsyIQn5vmBvysyTznfp8
X-Google-Smtp-Source: AGHT+IHoV8vKV4c3GSfLunloGPf6EZQrAdvAMSsmbrytkJD9bd1jsE0BDkfwvXFHjbexFnUTzHovVRHCTH/mcV7A2qE=
X-Received: by 2002:a05:6402:5253:b0:56d:eeb0:c76e with SMTP id
 t19-20020a056402525300b0056deeb0c76emr60307edd.7.1712048868331; Tue, 02 Apr
 2024 02:07:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230316123028.2890338-1-elver@google.com> <CANDhNCqBGnAr_MSBhQxWo+-8YnPPggxoVL32zVrDB+NcoKXVPQ@mail.gmail.com>
In-Reply-To: <CANDhNCqBGnAr_MSBhQxWo+-8YnPPggxoVL32zVrDB+NcoKXVPQ@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 2 Apr 2024 11:07:32 +0200
Message-ID: <CACT4Y+a6E8wg3PZhG_AoZtZwozhqUC+LPgMV3G_gQZXkr1rGzw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] posix-timers: Prefer delivery of signals to the
 current thread
To: John Stultz <jstultz@google.com>
Cc: Marco Elver <elver@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kasan-dev@googlegroups.com, 
	Edward Liaw <edliaw@google.com>, Carlos Llamas <cmllamas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 1 Apr 2024 at 22:17, John Stultz <jstultz@google.com> wrote:
>
> On Thu, Mar 16, 2023 at 5:30=E2=80=AFAM Marco Elver <elver@google.com> wr=
ote:
> >
> > From: Dmitry Vyukov <dvyukov@google.com>
> >
> > POSIX timers using the CLOCK_PROCESS_CPUTIME_ID clock prefer the main
> > thread of a thread group for signal delivery.     However, this has a
> > significant downside: it requires waking up a potentially idle thread.
> >
> > Instead, prefer to deliver signals to the current thread (in the same
> > thread group) if SIGEV_THREAD_ID is not set by the user. This does not
> > change guaranteed semantics, since POSIX process CPU time timers have
> > never guaranteed that signal delivery is to a specific thread (without
> > SIGEV_THREAD_ID set).
> >
> > The effect is that we no longer wake up potentially idle threads, and
> > the kernel is no longer biased towards delivering the timer signal to
> > any particular thread (which better distributes the timer signals esp.
> > when multiple timers fire concurrently).
> >
> > Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> > Suggested-by: Oleg Nesterov <oleg@redhat.com>
> > Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> > Signed-off-by: Marco Elver <elver@google.com>
>
> Apologies for drudging up this old thread.
>
> I wanted to ask if anyone had objections to including this in the -stable=
 trees?
>
> After this and the follow-on patch e797203fb3ba
> ("selftests/timers/posix_timers: Test delivery of signals across
> threads") landed, folks testing older kernels with the latest
> selftests started to see the new test checking for this behavior to
> stall.  Thomas did submit an adjustment to the test here to avoid the
> stall: https://lore.kernel.org/lkml/20230606142031.071059989@linutronix.d=
e/,
> but it didn't seem to land, however that would just result in the test
> failing instead of hanging.
>
> This change does seem to cherry-pick cleanly back to at least
> stable/linux-5.10.y cleanly, so it looks simple to pull this change
> back. But I wanted to make sure there wasn't anything subtle I was
> missing before sending patches.

I don't have objections per se. But I wonder how other tests deal with
such situations. It should happen for any test for new functionality.
Can we do the same other tests are doing?

