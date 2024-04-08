Return-Path: <linux-kselftest+bounces-7384-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 079A189BC83
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 12:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 704C1B21968
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 10:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61EC524C3;
	Mon,  8 Apr 2024 10:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RwSIqjLx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kB1agHNu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6EA53387;
	Mon,  8 Apr 2024 10:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712570473; cv=none; b=irF1+zdXxt31O1ldBV8K/o2UvBnvlmyvzP0bjy5lDS5rCbeeBpXltUy3wW5gQ+euvXL7Z30TSEi+vbSdj6tTqrC9d1zx+UjKlgnWBlqZWHKqV4wr4kcFLfPx6CYlQ9lBchoNxvJoRAUiBbxWlkp59bFPmv4yjsBFkhV1is6nRdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712570473; c=relaxed/simple;
	bh=Ef4dm1OsKI3RFHkFRrSSSTKWavV3bfSOGzccWu8X3Jo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mb/2FbDvDZ2G2fnr7qdTm9nwODMfbFaHitTZ1/XHWJblnYOZCE4Vc7hDJZa/1jsEoqbAGM76oOs/FlGe8ns/OBJNp80Jf2TNdb/x08wqLOFsyCS1eHbYQKDGz/PqWexWuXNZVln9ZryBALPrpmMMetoHX2n9cZp+Xs5NB85WdOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RwSIqjLx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kB1agHNu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712570470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tytVrNkppEDDbZ2QmPPIzRlo6qH+BZiddFSHis9hHWU=;
	b=RwSIqjLxaUFHxpqyRn0QmW+HCGF8oWwOmS7ZDRtboyFczXhF29gy+V+GOJyXQY7K+dcSSm
	7aKIUBBDKL4Q1RguJRwOTjaD3x1yCxMumFUymSP1IyHrrVqziFXpMMfgEYU5dQ+ohD4eUQ
	kjQU20ogDvVh6QGiOdRmBuFdKyqYQGClAUMzMM3vzANXsF/VeN+UfFUDUvEYcKiKUWgePO
	vgKMOs31+QygA4ktVN2+zPN5HhGHBSM8GolejQAlGfyedJaEQxQK/yX/ogICOMDmoLtQz5
	wekwgFA4h+EXrCmxte3u4l+AMOhlJEyH/HHEikHdfStWJQBT0PXVxgNIeX3wdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712570470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tytVrNkppEDDbZ2QmPPIzRlo6qH+BZiddFSHis9hHWU=;
	b=kB1agHNuR84TFc2Lh1zQnfShdOFEnt6WAtTbVkmlCTT0K/uAn070MrPzbCki5DODPkXAxs
	XbkWASRMh2T867Bg==
To: Dmitry Vyukov <dvyukov@google.com>, Oleg Nesterov <oleg@redhat.com>
Cc: John Stultz <jstultz@google.com>, Marco Elver <elver@google.com>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, "Eric W.
 Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kasan-dev@googlegroups.com, Edward Liaw
 <edliaw@google.com>, Carlos Llamas <cmllamas@google.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] selftests/timers/posix_timers: reimplement
 check_timer_distribution()
In-Reply-To: <CACT4Y+Ych4+pdpcTk=yWYUOJcceL5RYoE_B9djX_pwrgOcGmFA@mail.gmail.com>
References: <87sf02bgez.ffs@tglx> <87r0fmbe65.ffs@tglx>
 <CANDhNCoGRnXLYRzQWpy2ZzsuAXeraqT4R13tHXmiUtGzZRD3gA@mail.gmail.com>
 <87o7aqb6uw.ffs@tglx>
 <CANDhNCreA6nJp4ZUhgcxNB5Zye1aySDoU99+_GDS57HAF4jZ_Q@mail.gmail.com>
 <87frw2axv0.ffs@tglx> <20240404145408.GD7153@redhat.com>
 <87le5t9f14.ffs@tglx> <20240406150950.GA3060@redhat.com>
 <20240406151057.GB3060@redhat.com>
 <CACT4Y+Ych4+pdpcTk=yWYUOJcceL5RYoE_B9djX_pwrgOcGmFA@mail.gmail.com>
Date: Mon, 08 Apr 2024 12:01:09 +0200
Message-ID: <87wmp86umy.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Apr 08 2024 at 10:30, Dmitry Vyukov wrote:
> On Sat, 6 Apr 2024 at 17:12, Oleg Nesterov <oleg@redhat.com> wrote:
>>         if (ctd_failed)
>>                 ksft_test_result_skip("No signal distribution. Assuming old kernel\n");
>
> Shouldn't the test fail here? The goal of a test is to fail when
> things don't work.
> I don't see any other ksft_test_result_fail() calls, and it does not
> look that the test will hang on incorrect distribution.

I have a fixup for older kernels. I'll get to Olegs patch and the fixup
later today.

Thanks,

        tglx

