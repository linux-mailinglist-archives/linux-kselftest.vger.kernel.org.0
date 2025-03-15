Return-Path: <linux-kselftest+bounces-29149-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 281ECA632EE
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Mar 2025 00:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B2A73AEF46
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 23:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8221A5BB8;
	Sat, 15 Mar 2025 23:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EFVB5mBM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E260A1A3A8D
	for <linux-kselftest@vger.kernel.org>; Sat, 15 Mar 2025 23:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742080968; cv=none; b=pL6PW/kfjyuG99Xkm+b3ZrxKi6JJ9y9/x1d8vPuI1GQhovVG+T7Oc5Q3OuIyxtrIMFir/T+8mkDbEr2GQFnTHB7XcgZs8IKw1k96sxhfHymzaIgZB1545B3LFxSn552Bu6fz6V5/e8cfDZFCcU2wO37xeCoosmhPVkGD7CZ2uY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742080968; c=relaxed/simple;
	bh=yNaoFHNvsRgrKLIIXbY1OLgrHQAve7Ng1Ej6GhX1j/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gqlMnn2K0NhpO7DABKv6Bjsn4xB8WJKhQq2eH3vJG0hC71+poGpoipO7n5SsaAyjkMscT7DiAs/3sA3o+zHvbhkY6WUrpb57R37IEuttg0lhA7VYHEy+SqxTHVIyk9zec819kvK0l/hK/htOfZ6NtTr7IPz86jYb1Ko8gsEqLWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EFVB5mBM; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54993c68ba0so3479493e87.2
        for <linux-kselftest@vger.kernel.org>; Sat, 15 Mar 2025 16:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742080965; x=1742685765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EefKwIQk/c3BzKg46/rkLNUtfV5M7e4WxDiNJGdBaK4=;
        b=EFVB5mBMqJtdcY+i2Xpu6vGS6nZNLKupBzMlN1wH5ASUYoFVv3FxHdyZSEUKWqpQfV
         1aIbVUrym2YHK4nSwbES05CS4qxqDUTmI30D6Jy//m1j6Lrz+ma05l/bNdyeuZJhhArE
         /wzH90Okn9rKuxfueMigMFctpv/T0biQUUjv83amYlIiJAGJh96VLhgEO9S1SQxvPwzp
         iXxuOOPJtU8kIdJKyXisAZvnZxERWcMyaiDn5Dcylu0TifBz3zYROT/FZlCObR++FS9s
         +zyKUGybzOD0USyAeGM7sr8RZJoq+GhASGUQUiYdPcfw1HTSODRdbwRhlp3n+n/P5VEK
         LVJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742080965; x=1742685765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EefKwIQk/c3BzKg46/rkLNUtfV5M7e4WxDiNJGdBaK4=;
        b=od8pVjoRSVJJVzWQtHt86x+yfkINrZxFwfwqK3zanhsZu43OooyEeZ84xIIdgGV2y8
         IJDW7w0GPXIpla/apaPByWPQhrBpfbKzDR/+ITltz/FWuBbiDAnvZmnU4zj7FtfFBmQq
         f3W9VWUcd/uDyAo2RO2tUAzonu7EMcHLZy81AGBCl0EuKn0KtZz+oUSjI0kdoZtouYa+
         GRytOhBYGOEtPBhErvI0b0rMApoBkikQvJQACHTD6H9/5ey6v4stvvMbydmXma7pptRP
         te9evnon5QN/EVoy0mjaz5nXqx7blERx3FV4EelK5n7TyMiq6Rhq8AZFzdL+FcShJ+UD
         kVxw==
X-Forwarded-Encrypted: i=1; AJvYcCVrw2DCm9/PSeTr3bTO8/Mltj00ajGeAH5Fi02+cSl3v8MAZ8MkyhGCxQ4dHTNix9VcKWodpyO48JBsRixx58o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/ZRYX2+fxfXh0zNYL+OFBGAeWn56tB+73fjONAokzaqSVhMWP
	chGqYDmwykDaPZCpyGxddVu5e3LwpCQM8/DlLJ/n2Kt/0dN082s/WAD6YfErD6C4U3+tZ6GxqnQ
	kqfgXxn/wT1EkvzT2j6/1xJJNQ2gCz6X9cLU=
X-Gm-Gg: ASbGncv6Aci5V2ArOC1SgPgIGxQxz/IfpU+1hWPyrrK1+cSdaCGn1Gn4dhrDzienOGR
	B1DqYc30qc352imtlpu0ZNO7J/dHYivses6FUhuXQGIY4M73vWACwXzCu4Ok6NIsbg4mH+k/L0j
	+JDz8Fdsg9gvEmEiNSsvfpzLc=
X-Google-Smtp-Source: AGHT+IFqXySBquMSOg3NeTSpFmh8r8wJRIdEXBekJ8c/KO3XV5blNMGC43iqUJn5zChXka+JzIh80b8UmBY8qMw2EuE=
X-Received: by 2002:a05:6512:ac6:b0:545:225d:6463 with SMTP id
 2adb3069b0e04-549c3989a09mr2309850e87.42.1742080964693; Sat, 15 Mar 2025
 16:22:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANDhNCoueki=keYNcNr4eXqgLFPh3VupDJC0hFqxm4FNKfGzYg@mail.gmail.com>
 <20250315003800.3054684-1-jstultz@google.com> <877c4q5c9i.ffs@tglx>
In-Reply-To: <877c4q5c9i.ffs@tglx>
From: John Stultz <jstultz@google.com>
Date: Sat, 15 Mar 2025 16:22:31 -0700
X-Gm-Features: AQ5f1JqZOBd0eK-IeI1kmw23yAU3IShwRh1wrzTVoSYG74q1BSpXea1M-rNonf4
Message-ID: <CANDhNCqzHYJfaap5-TYPmtbaPm6AkS85hKdeSnprhEqMCAYcPw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] time/timekeeping: Fix possible inconsistencies in
 _COARSE clockids
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Miroslav Lichvar <mlichvar@redhat.com>, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Lei Chen <lei.chen@smartx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 15, 2025 at 12:23=E2=80=AFPM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
> On Fri, Mar 14 2025 at 17:37, John Stultz wrote:
> > Here because we did not accumulate anything, we have a window
> > where the _COARSE clockids that don't utilize the mult*offset
> > value, can see an inconsistency.
> >
> > So to fix this, rework the timekeeping_advance() logic a bit
> > so that when we are called from do_adjtimex() and the offset
> > is smaller then cycle_interval, that we call
> > timekeeping_forward(), to first accumulate the sub-interval
> > time into xtime_nsec. Then with no unaccumulated cycles in
> > offset, we can do the mult adjustment without worry of the
> > subtraction having an impact.
>
> It's a smart solution. I briefly pondered something similar, but I'm not
> really fond of the fact, that it causes a clock_was_set() event for no
> good reason.
>
> clock_was_set() means that there is a time jump. But that's absolutely
> not the case with do_adjtimex() changing the frequency for quick
> adjustments. That does not affect continuity at all.

Oh, good point.  I wasn't thinking clearly about the semantics, and
was being a little paranoid there (as most calls to
timekeeping_forward_now() have clock_was_set() calls that follow). I
suspect I can do away with that bit and avoid it.  I'll respin later
this week.

> That event causes avoidable overhead in the kernel, but it's also
> exposed to user space via timerfd TFD_TIMER_CANCEL_ON_SET.
>
> I have no really strong opinion about that, but the route through
> clock_was_set() triggers my semantical mismatch sensors :)

Yeah, it's a fair point, thanks for raising it!

> > NOTE: This was implemented as a potential alternative to
> > Thomas' approach here:
> >    https://lore.kernel.org/lkml/87cyej5rid.ffs@tglx/
> >
> > And similarly, it needs some additional review and testing,
> > as it was developed while packing for conference travel.
>
> We can debate that next week over your favourite beverage :)

Looking forward to it :)
-john

