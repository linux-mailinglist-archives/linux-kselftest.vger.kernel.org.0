Return-Path: <linux-kselftest+bounces-7252-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 323FB89941A
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 06:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 682BB1C24B4A
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 04:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A6C256D;
	Fri,  5 Apr 2024 04:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IyKnm3Lv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6007A179AE
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Apr 2024 04:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712291304; cv=none; b=Tqfw9xUWNAthyfY1n3HeHuO1sTMXzbn25dfZ6HQpPk+znTMpL7lVbQ7Vcqso0sAgXLOTnnsuG1fEfEbKWbSAD8cip1Qv2hVXlrfClxckaNVwBm00b5z88M3uAFJThS//lp9QknbOzRW5rY5nyGvp77x7NCKehmPQDhE4eNl739Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712291304; c=relaxed/simple;
	bh=n+JLyTEvPZL/Mt8+rCrTxgDV7jqVCeyX64y3OK1/JtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HJ1ES8+vauF/1MOilJFB5m5i6nflDqGp0nYSdNsHnnfGgfzRlfK1m15LdBb2TDu3lzxu7eamU0Tow/+n8JrD73pl3xBSu+8XooB4nkz15MI+RJO0z8KLfld0jwLStuKuPRBV1DM8i7kUyblCt9JeCJXp+FXPel+q8sdvYoAx2L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IyKnm3Lv; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-513ea2d73d0so981e87.1
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Apr 2024 21:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712291299; x=1712896099; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n+JLyTEvPZL/Mt8+rCrTxgDV7jqVCeyX64y3OK1/JtU=;
        b=IyKnm3LvJbgSEri0NROgMmhxC5WXwn/8TehMhEPWG5yN3xftGAN7dtbix8HRB8Bgdo
         A0qj4WSKz6E5KMr3QBaRAK+1gZfpNrIB5txUHKZM2tDZFyZvXIyyFmXPi3rqt16jTfDP
         QhKXt6DyOw2PckRZHFCihSEDxV76l32g5eE98jrMsOF8ygoj0gJ+cWjZmdEK78L307/s
         NDwGLymg2xmhzKUCUwVtdMEVI5DpF0ufIZ9/LJkqB+HMeY8xAUCPqODcyOE+KAeflUza
         FBeQGFFCBHPLNwHla5a0zVuH/f/Bw6AJtNppwlydoc6yuKXMk94PAWe8jxpyljw+vRd/
         fZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712291299; x=1712896099;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n+JLyTEvPZL/Mt8+rCrTxgDV7jqVCeyX64y3OK1/JtU=;
        b=T1uWeHBqx06s2Li471l8vjZvp9J6oYw9kFro54w9lhR01pXd4oOPLREbQuOWkYZtP2
         w88BKcAWulgR9O6q2CccrPEkTttj3BZO9pzYaPZkkmJ/mNFc0folJabyczHXGwB6NtQH
         wc7Oni88Hg0gMNRaXiON6ZV7v3RyLVtGQ60hVsMw4KsPmNyNuQ46XuelEYQHXyUXS+As
         4Tf3Xg2iWt43qEGV56Aa6t4EyTL02cqBE+wj0az2EgK8HH9bTtsefwTJlQ9bm3XSCofi
         UEOKvPptFX+KscBe4dnt8EHjfl3kAJbJ9FIsVQ4wzugYpZh6z+Okq55iLsIUYiOU9a+g
         DncA==
X-Forwarded-Encrypted: i=1; AJvYcCWTWFCNoNou9ZiahZJTyb+Dz2sEREGkvxQK4tK1ZLZo35HLOdansWTiUqQK5znlfZy0X7jpJc/P9B/Q/F5LhVllUPTTcoa/T4y3uEQLo65q
X-Gm-Message-State: AOJu0YzFN1pQZ8eRNLt3sI7Z2tDVK56ro4lemve+hZwids/AW2eFUtyj
	y2Caq/YcKsucOVSJUvoXYY13TN6uOQq1Jq1Y9CmchgXHS842Jfh8r3NExiEUmTkxIkSiOmvHBP5
	Q7u8KoHfu0+0DNDur19f+BxCAqyLb3c+Kgsg5
X-Google-Smtp-Source: AGHT+IE8PsiqBW8Yj2TgQm7IoY28oNNdZcX7ptSufM8Tf7FBHgqjG08QzyktF8LWe+RG22trUxeT6mtfitDJxeiX39s=
X-Received: by 2002:a19:9108:0:b0:515:c2ad:6cac with SMTP id
 t8-20020a199108000000b00515c2ad6cacmr156054lfd.7.1712291298951; Thu, 04 Apr
 2024 21:28:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230316123028.2890338-1-elver@google.com> <CANDhNCqBGnAr_MSBhQxWo+-8YnPPggxoVL32zVrDB+NcoKXVPQ@mail.gmail.com>
 <87frw3dd7d.ffs@tglx> <CANDhNCqbJHTNcnBj=twHQqtLjXiGNeGJ8tsbPrhGFq4Qz53c5w@mail.gmail.com>
 <874jcid3f6.ffs@tglx> <20240403150343.GC31764@redhat.com> <87sf02bgez.ffs@tglx>
 <CACT4Y+a-kdkAjmACJuDzrhmUPmv9uMpYOg6LLVviMQn=+9JRgA@mail.gmail.com> <20240404134357.GA7153@redhat.com>
In-Reply-To: <20240404134357.GA7153@redhat.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 5 Apr 2024 06:28:02 +0200
Message-ID: <CACT4Y+a1RRx-NK1H-iyuqwEs1kHfUsQBHRU7OsK7zHPmjVHSzw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] posix-timers: Prefer delivery of signals to the
 current thread
To: Oleg Nesterov <oleg@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>, 
	Marco Elver <elver@google.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kasan-dev@googlegroups.com, 
	Edward Liaw <edliaw@google.com>, Carlos Llamas <cmllamas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Apr 2024 at 15:45, Oleg Nesterov <oleg@redhat.com> wrote:
>
> Perhaps I am totally confused, but.
>
> On 04/04, Dmitry Vyukov wrote:
> >
> > On Wed, 3 Apr 2024 at 17:43, Thomas Gleixner <tglx@linutronix.de> wrote:
> > >
> > > > Why distribution_thread() can't simply exit if got_signal != 0 ?
> > > >
> > > > See https://lore.kernel.org/all/20230128195641.GA14906@redhat.com/
> > >
> > > Indeed. It's too obvious :)
> >
> > This test models the intended use-case that was the motivation for the change:
> > We want to sample execution of a running multi-threaded program, it
> > has multiple active threads (that don't exit), since all threads are
> > running and consuming CPU,
>
> Yes,
>
> > they all should get a signal eventually.
>
> Well, yes and no.
>
> No, in a sense that the motivation was not to ensure that all threads
> get a signal, the motivation was to ensure that cpu_timer_fire() paths
> will use the current task as the default target for signal_wake_up/etc.
> This is just optimization.
>
> But yes, all should get a signal eventually. And this will happen with
> or without the commit bcb7ee79029dca ("posix-timers: Prefer delivery of
> signals to the current thread"). Any thread can dequeue a shared signal,
> say, on return from interrupt.
>
> Just without that commit this "eventually" means A_LOT_OF_TIME statistically.

I agree that any thread can pick the signal, but this A_LOT_OF_TIME
makes it impossible for the test to reliably repeatedly pass w/o the
change in any reasonable testing system.
With the change the test was finishing/passing for me immediately all the time.

Again, if the test causes practical problems (flaky), then I don't
mind relaxing it (flaky tests suck). I was just against giving up on
testing proactively just in case.



> > If threads will exit once they get a signal,
>
> just in case, the main thread should not exit ...
>
> > then the test will pass
> > even if signal delivery is biased towards a single running thread all
> > the time (the previous kernel impl).
>
> See above.
>
> But yes, I agree, if thread exits once it get a signal, then A_LOT_OF_TIME
> will be significantly decreased. But again, this is just statistical issue,
> I do not see how can we test the commit bcb7ee79029dca reliably.
>
> OTOH. If the threads do not exit after they get signal, then _in theory_
> nothing can guarantee that this test-case will ever complete even with
> that commit. It is possible that one of the threads will "never" have a
> chance to run cpu_timer_fire().
>
> In short, I leave this to you and Thomas. I have no idea how to write a
> "good" test for that commit.
>
> Well... perhaps the main thread should just sleep in pause(), and
> distribution_handler() should check that gettid() != getpid() ?
> Something like this maybe... We need to ensure that the main thread
> enters pause before timer_settime().
>
> Oleg.
>

