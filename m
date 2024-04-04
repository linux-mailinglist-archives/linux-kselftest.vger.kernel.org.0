Return-Path: <linux-kselftest+bounces-7162-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56359898394
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 10:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBCCD1F20F77
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 08:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02B673539;
	Thu,  4 Apr 2024 08:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WXjoiXjF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232A273531
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Apr 2024 08:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712220930; cv=none; b=c7Dbs2DpyD4BaXKljzK2oYrclBmEjHbS0Xd8xkb2ANhxZzEL+FCj5twKH0SHQ56puAplhSSZIOhwlzqUeSINFkeRC2DLx5UzsMWUERtvEDg3wuiysU7lfSPtUQGn+9tMu6wwG+LOHoY0FF5+SE1FIncc7ENn2CerCQXIYNX3ga8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712220930; c=relaxed/simple;
	bh=SjMW750EWieLC8GssjE4d0VybyGyABsFnQu1IQJUPVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pm/aooHf2rHAHqKX+po3DvqM5uhkptcQcxd9KxHhy8vPK2sPIFRE7KPj/z0uQpFrf3m8ywhZwogqWEi4yv/514qWfNbu6hB9rESnZh+nC02lcVI42psflLKR+8iqsnyK94YVm75DEGbonNe2i8k9OoitiDviQzmHrj3AA3giP9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WXjoiXjF; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-516d0dc0cf7so128e87.0
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Apr 2024 01:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712220927; x=1712825727; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t3+/tCR4hiyQCc/kSu8Ua48ZwM/P/iLQrVfSfzYNWog=;
        b=WXjoiXjF2YiauGR68sxn9HKCQXTVcDAafgWJUuCe44boHfEYw3YzUtTwCyZghzEfPQ
         2t5FWQcnUOs8EWAFBKs5ST7YgY4dwrLnRRqPuIFwyVgdStXVNf1p905/+yHpKT+Vfu1I
         bcZXA3xDi2ZiFURYzLX2Sgh/oh0i5QxASyzeVUVwfkrkd+vEI0stfppUMh5iJK1Ko26i
         n2as/pYnv29bEmiaAyKGP4vT448kwLnql/uGhq0AyeYjn/Yzc2WfkHeXE4AMLoxGEdpV
         H662na+m5IuzTxqvEAKWqZe4vtuZR1SudVMIwSoMIiV4Fw6mgQEA65wCm/CVozZGAvg5
         M2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712220927; x=1712825727;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t3+/tCR4hiyQCc/kSu8Ua48ZwM/P/iLQrVfSfzYNWog=;
        b=gvAQjL4csuIwN7Oe367z7iAAQ6OCd7KddaL2Z2XVbFBy1asjOznXzH3CZN1RYOi1YG
         kOOqCe32GR1JOdOfy1Spe59+2sTnQTq/3kZfZwBG6K2KRnDrCUQpe7qlfETobvvsqruI
         vh/52xLgTtzQJF8X24JG0zi2XOkAEjeGqqFACYMuBNXiZYLJLJN8To2/9ee8zbdQHnjR
         Hck88FpzDeMM4fcKWFLguz0mObigCyHwFZeFAdsD8xes1V/6cAHwQvvqc1LkM71EYESB
         NfXFtp6YaMC55RtSDgRezTFgq8f5GXtYwHV0HjD2xZkSHSioN7hS3y2Wt36l/4mT8q97
         gGSA==
X-Forwarded-Encrypted: i=1; AJvYcCWWS/wlzAN+rHNY5WMw3gyoIKYlp7nOBWDOVwjwptEn4zKEAwkFlAVVrosEKwLVpDtLjbOLVj0QbOIVcfGWQP5nA654xJrqqgzf6ZRtwg3c
X-Gm-Message-State: AOJu0YyCFVl195AZ9Ete9W3xmub9Mxe2rwy8eAyuCjU1htNRHbvQqQdg
	eZipVMPQiJONr50IAPDknP2AHzkLD5HNkIIkNjTiLiSTfQrPLg8hgtDRZH9ijgjl+zUbYJrd9qy
	2vezU5wIanATLX6+wes7ZHb2my2wJ3dO9I2iR
X-Google-Smtp-Source: AGHT+IHJuCYcyRMZpQyAeKjDxXlQBfy8VLfzxYkxcBYpE2K0tzGDw3ORQEU59JjeJQMIq/kex/86/JdyqlrA8FkmdAE=
X-Received: by 2002:a19:4342:0:b0:515:b9de:e444 with SMTP id
 m2-20020a194342000000b00515b9dee444mr25478lfj.6.1712220927041; Thu, 04 Apr
 2024 01:55:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230316123028.2890338-1-elver@google.com> <CANDhNCqBGnAr_MSBhQxWo+-8YnPPggxoVL32zVrDB+NcoKXVPQ@mail.gmail.com>
 <87frw3dd7d.ffs@tglx> <CANDhNCqbJHTNcnBj=twHQqtLjXiGNeGJ8tsbPrhGFq4Qz53c5w@mail.gmail.com>
 <874jcid3f6.ffs@tglx> <20240403150343.GC31764@redhat.com> <87sf02bgez.ffs@tglx>
In-Reply-To: <87sf02bgez.ffs@tglx>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 4 Apr 2024 10:55:13 +0200
Message-ID: <CACT4Y+a-kdkAjmACJuDzrhmUPmv9uMpYOg6LLVviMQn=+9JRgA@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] posix-timers: Prefer delivery of signals to the
 current thread
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Oleg Nesterov <oleg@redhat.com>, John Stultz <jstultz@google.com>, Marco Elver <elver@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kasan-dev@googlegroups.com, 
	Edward Liaw <edliaw@google.com>, Carlos Llamas <cmllamas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Apr 2024 at 17:43, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Wed, Apr 03 2024 at 17:03, Oleg Nesterov wrote:
> > On 04/03, Thomas Gleixner wrote:
> >> The test if fragile as hell as there is absolutely no guarantee that the
> >> signal target distribution is as expected. The expectation is based on a
> >> statistical assumption which does not really hold.
> >
> > Agreed. I too never liked this test-case.
> >
> > I forgot everything about this patch and test-case, I can't really read
> > your patch right now (sorry), so I am sure I missed something, but
> >
> >>  static void *distribution_thread(void *arg)
> >>  {
> >> -    while (__atomic_load_n(&remain, __ATOMIC_RELAXED));
> >> -    return NULL;
> >> +    while (__atomic_load_n(&remain, __ATOMIC_RELAXED) && !done) {
> >> +            if (got_signal)
> >> +                    usleep(10);
> >> +    }
> >> +
> >> +    return (void *)got_signal;
> >>  }
> >
> > Why distribution_thread() can't simply exit if got_signal != 0 ?
> >
> > See https://lore.kernel.org/all/20230128195641.GA14906@redhat.com/
>
> Indeed. It's too obvious :)

This test models the intended use-case that was the motivation for the change:
We want to sample execution of a running multi-threaded program, it
has multiple active threads (that don't exit), since all threads are
running and consuming CPU, they all should get a signal eventually.

If threads will exit once they get a signal, then the test will pass
even if signal delivery is biased towards a single running thread all
the time (the previous kernel impl).

