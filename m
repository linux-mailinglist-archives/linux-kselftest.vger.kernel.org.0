Return-Path: <linux-kselftest+bounces-7111-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6BA8978B0
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 20:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40567B28648
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 18:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2AC153511;
	Wed,  3 Apr 2024 18:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rGrjwiBa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8CC152DE7
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Apr 2024 18:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712168188; cv=none; b=qsimzhLygESzl/FxFPcv6bTMy9snXRrUnHbiRVd9srBkW6uyN7pYH9qry2iYDTvik0NSNII5V0u2a/wrL8PdNoLTDsEDZj2ytwYSkKMF+CsnxiEEOWBWO7eAWrdb8sXgImY+XtHXhJlxifDm0z1KRSIjGqeObRNGQLXlZxhgNUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712168188; c=relaxed/simple;
	bh=VFiK45j2Q+k25OG6ST/L3ExJ/1D7WWKaEd9JXrngPjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oSKV4Q8UNVlRf6Eqt4Hjv5i2kEmkRZcTsptnbhazjCK2sXbdIuE8QAnnltOMEYokLKLLzhB3ZP0QUj2fJBLi11JLNA16mVIys+Jlkf7fBf1GxwaPcwgRn31XtKhVcKLx4uaAjFRwzUgqfJxVdLqaXy+xLURe5zMQXOL3aL6invY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rGrjwiBa; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56e0c7f7ba3so2915a12.0
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Apr 2024 11:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712168185; x=1712772985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNELuWdWa80XXRXdRCDWUU8putHnEOf7PvgbPFwUh3I=;
        b=rGrjwiBamwokjHSr0LoUryiPjR1nKxLARzz67P808l9jQ0HOgpcvi+wqRkEFN80JU4
         ne6A6MOVWyFM2YNKc7Jqm9COE5RJ4oFlWmxc97Vpe9H9tNJaz5JFZi0Ab3ciswUvuzAF
         jJsNkx1QIiuRCFzJ0Kl7bU3rh1txCUtoxIK+Y0vatw6B4UFn0UjC+eJlBnp9nIDK1EGy
         3dVyy+k9XTg7PMT/RABZeOBWYDNbn9+S+1CV2BVEyQNg55GKXup1urMZxdS7/3XF7OYp
         qEOAaBeL/7aO4xAq4Nh1Jp76tSIxyt70HoiiAQXUz+6e1+6HvXZyyISPRDtF20+HuEri
         aF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712168185; x=1712772985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wNELuWdWa80XXRXdRCDWUU8putHnEOf7PvgbPFwUh3I=;
        b=pJzSWA2sMjB/dZbeUwrRFWIn9XwkDsuC/r9ComT1cQRFeIpusTT0pi1D6fUGfmxDOe
         hPrsdGgicb7yUmfnVuGkHYmbkm9pg6XW/qw3mm827BS0wbMZ/X7rLD8of4V+CMySJ72D
         i30noEwybLYF9oQ0jQJoLHLPRzNSFfsS3Bha2hAjzKcCXrawM8k6S1pBGzqN+k8dJZ4l
         lRcxsZKOKj+Obz7vCJ3yAObGDhLVsXdxoJRcnXAp5ojaWCN1skYHb0HCox+EjaEvfsKx
         e6FuRJwb/6XQCYJNjwePZrX3u1dCYN2TIH3yby7p2KUb3X9EqPyBptHmGOjWZy/2ZGaW
         qf2w==
X-Forwarded-Encrypted: i=1; AJvYcCUdS7N9ShIuGLn0bQ00g/wMkPyUWrRsZBrUERW4cGTyU3acI9CJieS50y3lNgVz9r89rRgWt7traZxQbJ6cgFevx25M10N4q/8PoyD1dgdz
X-Gm-Message-State: AOJu0YzLlKfYtL7/LTcLOy5NJ/ZUSzzL3uW8MMmuU2dqnWXElR+ZBON0
	fkwxnBHpntpXRaDTwQZMGodlbqaLMlmd3hRHQEJ/2/jy4TQ2xrO1mzCpfhOWznUYkYiGBn7Rtew
	l9sHdvWaBXONL1OOtUdmqoAzf/lTm3LxPxlg=
X-Google-Smtp-Source: AGHT+IGfHejWu5qYzjBmQ79n3dfe2V1iyaclIyCvbL1++S3ixo7/rHPVQXjlJIE+9sKOojX5U+IOl4Fuki4ckmOFfxc=
X-Received: by 2002:aa7:d645:0:b0:56c:5a43:5a66 with SMTP id
 v5-20020aa7d645000000b0056c5a435a66mr236161edr.7.1712168184752; Wed, 03 Apr
 2024 11:16:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87sf02bgez.ffs@tglx> <87r0fmbe65.ffs@tglx>
In-Reply-To: <87r0fmbe65.ffs@tglx>
From: John Stultz <jstultz@google.com>
Date: Wed, 3 Apr 2024 11:16:12 -0700
Message-ID: <CANDhNCoGRnXLYRzQWpy2ZzsuAXeraqT4R13tHXmiUtGzZRD3gA@mail.gmail.com>
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

On Wed, Apr 3, 2024 at 9:32=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
> Subject: selftests/timers/posix_timers: Make signal distribution test les=
s fragile
> From: Thomas Gleixner <tglx@linutronix.de>
>
> The signal distribution test has a tendency to hang for a long time as th=
e
> signal delivery is not really evenly distributed. In fact it might never =
be
> distributed across all threads ever in the way it is written.
>
> Address this by:
>
>    1) Adding a timeout which aborts the test
>
>    2) Letting the test threads exit once they got a signal instead of
>       running continuously. That ensures that the other threads will
>       have a chance to expire the timer and get the signal.
>
>    3) Adding a detection whether all signals arrvied at the main thread,
>       which allows to run the test on older kernels and emit 'SKIP'.
>
> While at it get rid of the pointless atomic operation on a the thread loc=
al
> variable in the signal handler.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Thanks for this, Thomas!

Just FYI: testing with 6.1, the test no longer hangs, but I don't see
the SKIP behavior. It just fails:
not ok 6 check signal distribution
# Totals: pass:5 fail:1 xfail:0 xpass:0 skip:0 error:0

I've not had time yet to dig into what's going on, but let me know if
you need any further details.

thanks
-john

