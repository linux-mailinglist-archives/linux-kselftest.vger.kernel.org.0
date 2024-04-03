Return-Path: <linux-kselftest+bounces-7115-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A744C897910
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 21:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 445FE1F21525
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 19:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E9F155305;
	Wed,  3 Apr 2024 19:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bf9yguDD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEA014885B
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Apr 2024 19:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712172920; cv=none; b=WTvd6wdcVgu0kB8cPDh4xOmJ3xvq1Fm280VlQ2syNwh44TRVovHJfwCUXv0cdUihPjooC5+OHinbbR1KchtYmAQ3drS7FfAw8YGHAulFWNh0uR01kvywX6zXv8Jj0leSM0lciM3GvelXZyMCE50Sz7I3JHpX2RCRzKQ01wHf+fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712172920; c=relaxed/simple;
	bh=Wz+XAmCjUc8PDsaYphxSsci9OJCLtebQHEYs8FmStqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RyZM3DoX23BzCPxe2pgWA0SE5djJaJxfl2TFrqr/dzp1t2EUozYFI/wpByTd1aBdQwi14Q8DQ2B5f2BmlCrNcede2Uq8xUCn/wBsiHadbhqBAU7SugjT92Qxpg2VoqMiimUhppJaitQmri2NT4efeQdrXlWRP/6jGPvl8KOhT8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bf9yguDD; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-413f8c8192eso21435e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Apr 2024 12:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712172917; x=1712777717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wz+XAmCjUc8PDsaYphxSsci9OJCLtebQHEYs8FmStqA=;
        b=Bf9yguDDXSrI+aNRMNFLcLdKGpG2myuUFtGLECbxeLCXpHJvnMZi2S9citztBNOOFJ
         MDiaUinEQZZZv5uOtBB2gaOvgJ+XDcuk+B5Rq4s+BOlVVLMqvMDew8mKSpStNAjDwmiW
         8wQMX6od3iJZ8VXCmgARiA4BwHcRExdNhmke6dUjnnEiIqqlhuHgDVhxCqhFGLIa8ETH
         EnPwwUzr3TIl5o4MBU65qKD3zzHltVFw8PiEfmrHeQ2r0Zxqo8cgQuksooJNBIlmms5Q
         jojbsGkunr1ibtn1oVX/vKYg8d1zG/Hdxubz0LNB/y88nutoLoo+t8H/dSgzsMqaXhCv
         f5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712172917; x=1712777717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wz+XAmCjUc8PDsaYphxSsci9OJCLtebQHEYs8FmStqA=;
        b=ljS7zEUx84XOv8vviimfjqwnR8lbfuvdwLDXgMpilkrznwfIlQnfHz161kP+KiLEXt
         ypblmlQVPWZzB95QFhFwEmquvjdPnOXIfyX0EmhnwAXRMkPCTaYSaeEt2buYYokn+ErG
         Xv5UTmJt4Tn3SCD1aDf7mw4J7sJP4IH0cicuZLFs7S8uCGdieAww8D2vLHHjqWhQfTxF
         qc6yoMZKnKjqCIvIAQOeI6xpUIfYouI23w6/xjQiaVF22xWOyLnykCZSextLe23jSXbf
         WnDeLq80pZ3DGtPYkQeZ4Gu8hiArdXy6bZP9c3djZqDmJ0zVls+M83hVLzgq4OyDY3QY
         TM7g==
X-Forwarded-Encrypted: i=1; AJvYcCWwgscBOCtITZUdMm2eBB5BuM7mnRH9lBOvyi75agQ5HRWYrK1qIyK4XqLnu5XA4115tLGnTlB2TKThXAhKrsma7XiTyHmlkW7wxIV6Q2Rw
X-Gm-Message-State: AOJu0YxVyF3M/t5PzmwSoCL8/vhPRUy7SNVsb5i2nGL28U3LZUwNdS2J
	YOv1tFFNXvIVSanZCMHjzS6+6+PbXgGmA2logZCIxaAmmC1VmrvHl7m4ot2FQC4srMsox5q/mZv
	4+maDJww4DypcVDNk4Gklfz988fN1BsXFwH4=
X-Google-Smtp-Source: AGHT+IEzkSBTxCD4EO3RWvVhNTCuadU+0PmJnuJ2msK4apHkHqQwAY0UNc4MQ7EFCG3/6oJj5BZZcSRNAnuoqXIEKLg=
X-Received: by 2002:a05:600c:1d25:b0:416:1eba:175f with SMTP id
 l37-20020a05600c1d2500b004161eba175fmr299989wms.6.1712172917250; Wed, 03 Apr
 2024 12:35:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87sf02bgez.ffs@tglx> <87r0fmbe65.ffs@tglx> <CANDhNCoGRnXLYRzQWpy2ZzsuAXeraqT4R13tHXmiUtGzZRD3gA@mail.gmail.com>
 <87o7aqb6uw.ffs@tglx>
In-Reply-To: <87o7aqb6uw.ffs@tglx>
From: John Stultz <jstultz@google.com>
Date: Wed, 3 Apr 2024 12:35:04 -0700
Message-ID: <CANDhNCreA6nJp4ZUhgcxNB5Zye1aySDoU99+_GDS57HAF4jZ_Q@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] posix-timers: Prefer delivery of signals to the
 current thread
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Oleg Nesterov <oleg@redhat.com>, Marco Elver <elver@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>, 
	kasan-dev@googlegroups.com, Edward Liaw <edliaw@google.com>, 
	Carlos Llamas <cmllamas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 12:10=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Wed, Apr 03 2024 at 11:16, John Stultz wrote:
> > On Wed, Apr 3, 2024 at 9:32=E2=80=AFAM Thomas Gleixner <tglx@linutronix=
.de> wrote:
> > Thanks for this, Thomas!
> >
> > Just FYI: testing with 6.1, the test no longer hangs, but I don't see
> > the SKIP behavior. It just fails:
> > not ok 6 check signal distribution
> > # Totals: pass:5 fail:1 xfail:0 xpass:0 skip:0 error:0
> >
> > I've not had time yet to dig into what's going on, but let me know if
> > you need any further details.
>
> That's weird. I ran it on my laptop with 6.1.y ...
>
> What kind of machine is that?

I was running it in a VM.

Interestingly with 64cpus it sometimes will do the skip behavior, but
with 4 cpus it seems to always fail.

thanks
-john

