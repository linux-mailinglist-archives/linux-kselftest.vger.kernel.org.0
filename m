Return-Path: <linux-kselftest+bounces-7619-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2669F8A040B
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 01:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFF281C2105E
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 23:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11652381B1;
	Wed, 10 Apr 2024 23:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fXrj4RLu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDEC1D558
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Apr 2024 23:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712791715; cv=none; b=QVHyE4KAJ6Nus3LvrXuXMQbd6HnhPq2EuD0JBdHyLKL618f6S9wnbzw3uog4LZVO49zy70JLmczykWIO9OgVkJp3EH0InwgerIsEaxQvcXKd0VXmyARytxhto29CiQr5DK/1am7LyyTwrsl3E2vAEYNtf+3AdYl5/OIgY9i/CpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712791715; c=relaxed/simple;
	bh=IskzSE1OOdWxLV4wEIgj5iiPGJft461h1onztXKb1j4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=poe/GKkhepcYcRbGLCDVOxZgjPovgykp/KbsGcmvFlaD8Fw+0DQqPH5hkwLKc6TNEoDPMeY7Wa74yFTa653B8yWVHHSuW9TiOGlTodPPRYBnf3Ya4/6RhZilabDO+HrLDcvyzpyHXavsxIn+HT6ckPCt1Jutq6kLEkCV1wbLtyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fXrj4RLu; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56e1bbdb362so8966906a12.1
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Apr 2024 16:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712791712; x=1713396512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xY8IaUaFZA+Gv7USloz4HDmI2WsvnF1MlA0Fl2dmZs=;
        b=fXrj4RLu9sAbZ7sPAQd32d1M4R4GFFtoFGqGHumpuco1APIGovQQ3ZCrddAMz0qADz
         G3mM9QrLb5lBhszOKSHy7fy18jZEzwi5lXlsqc0pCo1cluQTqPGzKQ3zI86LCAGJ6a1r
         gwaNU72pQeBZFqq7cy8I2qu3w2Whu02yKxnexdPQSKqGKqj4FusJ05jHAvRaA/scixFe
         +NthHyjYmN66k7EUDDQgOxDqXew/jeIMaKbHFFAJXoMPtQBMu8QNUNrGmBGX4kxFSbvs
         1feVp9/fpGC8pCrdFmzdF3hL6oVWB2HCKOk+5kcaZyuZdbCzP6zZeLutKv9ug5EvXiYi
         W2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712791712; x=1713396512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8xY8IaUaFZA+Gv7USloz4HDmI2WsvnF1MlA0Fl2dmZs=;
        b=wv+SIYu6ewBH3KIyEj93EPzpaXmSPZ4m1GieJ6AxPqmMjWkbyUeIoBTyIVKeXYkav7
         gfG2PuevSxujWwydSFcTMg9QfiDEg8PsSwjNhtALArZw6WnLHcSqSS6yqKig86Zooq1V
         ILi0bVxWOq1TMH5uPTOXu7nt03aXXxvOTQtc0cFp0ebGKzxC5ejnk8mCOZx+3ThIokbp
         dSx0jCIM1mUMYx3BdHUWt7/WYDV4W+1w03S4YS8bam/0TAHzC7BZFEfzCLznh6myoCPX
         MA7dJIeCT4DnnRcHUXf59NgulaoFhreOkOhXOlZPhKkXnHJgTz4IrtbZdZw7URM+PhQb
         JGGw==
X-Forwarded-Encrypted: i=1; AJvYcCX8urbU3LCBcrtmJSBicElU/8UjJL4uvNfe8NM9JD1BK3/y8t+3jztlFyvJZ/Wm0aD/MOmAmqNaLCMgPQrPO7Tyu31iCxMDKd4wCzig/xrh
X-Gm-Message-State: AOJu0Yxj9+CTzccmz9KLK39Qri3uJTU3REcNz8hhVFGE/XTL6+dnAKJ1
	xPyw43uzB2FW2wzrPyXtFzExOSUIjVHlj96xNBZ4etoSoUypVCWnvyuGnfZNoAhfwyU1ZP2AXQ5
	pI1PnAond7L8jFxUOc07suTULWgMdT/RA0fvn
X-Google-Smtp-Source: AGHT+IFmOsrz5Hq/L8KjpOuaXMrNhjFmuTtpfw3wP32V8jN+t6rexPb4kfOSRskN6xAUqM5KYt/4+RS5HeJCyNqNRcY=
X-Received: by 2002:a50:9512:0:b0:56e:3172:20dd with SMTP id
 u18-20020a509512000000b0056e317220ddmr3084056eda.27.1712791711605; Wed, 10
 Apr 2024 16:28:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410232637.4135564-1-jstultz@google.com>
In-Reply-To: <20240410232637.4135564-1-jstultz@google.com>
From: Justin Stitt <justinstitt@google.com>
Date: Wed, 10 Apr 2024 16:28:19 -0700
Message-ID: <CAFhGd8oRJG6Amrr8VxriXP11NgVPbPBdaKKWbuCSowSxrGEcMg@mail.gmail.com>
Subject: Re: [PATCH 1/3] selftests: timers: Fix posix_timers ksft_print_msg warning
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Edward Liaw <edliaw@google.com>, 
	Carlos Llamas <cmllamas@google.com>, kernel-team@android.com, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 4:26=E2=80=AFPM John Stultz <jstultz@google.com> wr=
ote:
>
> After commit 6d029c25b71f ("selftests/timers/posix_timers:
> Reimplement check_timer_distribution()") I started seeing the
> following warning building with an older gcc:
>
> posix_timers.c:250:2: warning: format not a string literal and no format =
arguments [-Wformat-security]
>   250 |  ksft_print_msg(errmsg);
>       |  ^~~~~~~~~~~~~~
>
> Fix this up by changing it to ksft_print_msg("%s", errmsg)
>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Bill Wendling <morbo@google.com>
> Cc: Justin Stitt <justinstitt@google.com>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Edward Liaw <edliaw@google.com>
> Cc: Carlos Llamas <cmllamas@google.com>
> Cc: kernel-team@android.com
> Cc: linux-kselftest@vger.kernel.org
> Fixes: 6d029c25b71f ("selftests/timers/posix_timers: Reimplement check_ti=
mer_distribution()")
> Signed-off-by: John Stultz <jstultz@google.com>

Yep, makes sense.

Acked-by: Justin Stitt <justinstitt@google.com>

> ---
>  tools/testing/selftests/timers/posix_timers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testin=
g/selftests/timers/posix_timers.c
> index d86a0e00711e..348f47176e0a 100644
> --- a/tools/testing/selftests/timers/posix_timers.c
> +++ b/tools/testing/selftests/timers/posix_timers.c
> @@ -247,7 +247,7 @@ static int check_timer_distribution(void)
>                 ksft_test_result_skip("check signal distribution (old ker=
nel)\n");
>         return 0;
>  err:
> -       ksft_print_msg(errmsg);
> +       ksft_print_msg("%s", errmsg);
>         return -1;
>  }
>
> --
> 2.44.0.478.gd926399ef9-goog
>

