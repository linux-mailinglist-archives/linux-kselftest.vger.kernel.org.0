Return-Path: <linux-kselftest+bounces-7114-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6058978D4
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 21:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4C151F2378A
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 19:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1196154442;
	Wed,  3 Apr 2024 19:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xShiaKJt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yQTIGrSR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24853154BE8;
	Wed,  3 Apr 2024 19:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712171404; cv=none; b=W/iUOQEB1uwwdbPSld8qxzu8u/7TUHqTRtlu3v9lQjJWfJpBcJS1NaBPq6ceViNh6P6OmSG//NU2gJQ4SzxFHGwvPAtEiCAH9vBlIwY0lqKcQRxZj+6wOWDTNmdAJIvrSoF+x1WIb4WqdGb45d+0Tvo+smKnpCWN9KJ6lehXjPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712171404; c=relaxed/simple;
	bh=pzIK4B66bc749NQfKqD2bPVYkt2kauVqKBN7X+SGq3E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TaXQj+65uaiikNzYDAYXElADaBjuj0aYe9TVteR12RGRwdGbYaHuyZDwo/btgGPCOquXXOQqN8YyFrqQvLhDwnPs9lzbvvaiyVXngAfd6UuunuoM6nVD8NxC4I03lELXb3A4a8aU6ql0f9k6ij5tipDw0+DO9WCX2ErnbEtyNjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xShiaKJt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yQTIGrSR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712171400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pzIK4B66bc749NQfKqD2bPVYkt2kauVqKBN7X+SGq3E=;
	b=xShiaKJtyR1gQrMBFejJXh9EOxZcQKqLRlqUo2VQSNyezhFjw8uL7AgQVFFH3WoL8UWVoM
	qqUbWmOt5mj7xv+xIIlInxnDutryQDoqKhi5UaxGJfp76YuXAoBb3PoIvdcL0ctW6D/KoS
	8KOCCzs68MUSN4ArjooctEz4Fa3elbUWdBF1j8MIzrtezNp3EWgUqixRTFk8TMs3U/ygR1
	Lx/T82SO6tQXwLAOb2sNpdKoxFe0QY8FToetMe5ASjJXWTJW+CviQKSAyKq7zvO1ci2aRb
	R+tfAvHyWCd/4SnXMxiT0h/An0GqR2l7yUeNNoSymJbC/q2By6Qput9Hss7KTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712171400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pzIK4B66bc749NQfKqD2bPVYkt2kauVqKBN7X+SGq3E=;
	b=yQTIGrSRROvqb/a+uelr9JkgAlV+FG5YEN1BnUHIl/D0lqJpMHfdH1p9uU2wBTSg+ans0g
	Vl3NTnuxa6I1+TBA==
To: John Stultz <jstultz@google.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Marco Elver <elver@google.com>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, "Eric W.
 Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
 kasan-dev@googlegroups.com, Edward Liaw <edliaw@google.com>, Carlos Llamas
 <cmllamas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 1/2] posix-timers: Prefer delivery of signals to the
 current thread
In-Reply-To: <CANDhNCoGRnXLYRzQWpy2ZzsuAXeraqT4R13tHXmiUtGzZRD3gA@mail.gmail.com>
References: <87sf02bgez.ffs@tglx> <87r0fmbe65.ffs@tglx>
 <CANDhNCoGRnXLYRzQWpy2ZzsuAXeraqT4R13tHXmiUtGzZRD3gA@mail.gmail.com>
Date: Wed, 03 Apr 2024 21:09:59 +0200
Message-ID: <87o7aqb6uw.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03 2024 at 11:16, John Stultz wrote:
> On Wed, Apr 3, 2024 at 9:32=E2=80=AFAM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
> Thanks for this, Thomas!
>
> Just FYI: testing with 6.1, the test no longer hangs, but I don't see
> the SKIP behavior. It just fails:
> not ok 6 check signal distribution
> # Totals: pass:5 fail:1 xfail:0 xpass:0 skip:0 error:0
>
> I've not had time yet to dig into what's going on, but let me know if
> you need any further details.

That's weird. I ran it on my laptop with 6.1.y ...

What kind of machine is that?

