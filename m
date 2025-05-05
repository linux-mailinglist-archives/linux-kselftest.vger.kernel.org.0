Return-Path: <linux-kselftest+bounces-32360-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10893AA9573
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 16:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 218BF7A9635
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 14:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6014C25C709;
	Mon,  5 May 2025 14:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="okN6YNbb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ICA/mb57"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FD125C6F0;
	Mon,  5 May 2025 14:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454750; cv=none; b=WSHvR+AdW/GuTZ7N/nXv9BFaK1+Slh8bIKR3b+253ZdvudKAjjyMccVA4RXtRFU4QWKu92t/tQq2Gvv24cC5upAOYEhELz1+PEWZVQ2TCiqCLsdBB65zgAptQylocOlp4nE8AB6nfOFXn0qlV6WUdiMlnurJ86D+ohDgMXnnHSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454750; c=relaxed/simple;
	bh=vPtQs9sAaTF1CNTuep64ARnwCHzHctxyvtx3FLodeLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSjdCftSDh/60CWaD+b7pgxT7v72qHFnXFalyFOj/Bneypqx4kiyXQRDXwzbTxOMdeJtkywLIK7ySTVXHgP6i58m8zT7Ds2a3/NrlmkxQT+qZyst7NLH3osQFue8iHF5rWHkhcuzQz7whHH6KVlRJSK8V47fKSLipe8KqJnDBa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=okN6YNbb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ICA/mb57; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 5 May 2025 16:19:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746454745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m4d9E/RhAs01h+C/WnRcFB1KLlRmLh6wAYM57gfa6Hc=;
	b=okN6YNbb0wNpafvljVjAGm90LUFp79aB58wgCaT8FuD/s2TryiDJ6I6QuLqfbHGcrubLFG
	luwtqFGkvhnJW2MwnmBTcpT31NDdrIooUFLGurad3VHHSSICxK3ZzvneglogY8OQ9aFQWH
	P/n0xb1Cx3vNW/viy+iSA8mFxulDPjYO4YyvrBJpq9ttQBpPDlC6PZQordj/yOP2DwXA+U
	SS3fkGn7iFKDAmI1G4daXAcXW/zojzpMbG35ogoRtZ/0aFkDq+R6+aa0PfHnEBV3iJSco1
	pklbGJ+tgOIkLFZO+PdGNtnPjPfqhSvBTF537L+8OV80LUG+RAeI4DMfKy2Liw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746454745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m4d9E/RhAs01h+C/WnRcFB1KLlRmLh6wAYM57gfa6Hc=;
	b=ICA/mb57/Nn4GZwrSv8K36SAo1HrUtKDIrwkcC6Y15uFIvD0EagXtCLhJx1V1tOADlRr8L
	RYTDxhermuJJCQAQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: Re: [PATCH v2 4/8] selftests: vDSO: vdso_test_getrandom: Drop some
 dead code
Message-ID: <20250505160801-f45d2071-1337-4275-ae2c-f979996a57f3@linutronix.de>
References: <20250505-selftests-vdso-fixes-v2-0-3bc86e42f242@linutronix.de>
 <20250505-selftests-vdso-fixes-v2-4-3bc86e42f242@linutronix.de>
 <CAHmME9ppP0mAh6HMaHDi+XTuU8E6be9wSPYTYO-GvX=vYJCYeg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHmME9ppP0mAh6HMaHDi+XTuU8E6be9wSPYTYO-GvX=vYJCYeg@mail.gmail.com>

On Mon, May 05, 2025 at 02:58:06PM +0200, Jason A. Donenfeld wrote:
> Hi Thomas,
> 
> On Mon, May 5, 2025 at 11:19 AM Thomas Weißschuh
> <thomas.weissschuh@linutronix.de> wrote:
> >
> > vgetrandom_put_state() and the variable ret in kselftest() are never used.
> >
> > Drop the dead code.
> >
> > Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> > Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> > ---
> >  tools/testing/selftests/vDSO/vdso_test_getrandom.c | 11 +----------
> >  1 file changed, 1 insertion(+), 10 deletions(-)
> >
> > diff --git a/tools/testing/selftests/vDSO/vdso_test_getrandom.c b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
> > index f36e50f372f935e6d4da3175c81e210653bdce1d..b0e0d664508a38d6dde9df0a61ec8198ee928a17 100644
> > --- a/tools/testing/selftests/vDSO/vdso_test_getrandom.c
> > +++ b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
> > @@ -100,15 +100,6 @@ static void *vgetrandom_get_state(void)
> >         return state;
> >  }
> >
> > -static void vgetrandom_put_state(void *state)
> > -{
> > -       if (!state)
> > -               return;
> > -       pthread_mutex_lock(&vgrnd.lock);
> > -       vgrnd.states[vgrnd.len++] = state;
> > -       pthread_mutex_unlock(&vgrnd.lock);
> > -}
> 
> This sort of acts as example code / basic reference code for libcs and
> such. So I like having this function around. Could you just mark it as
> unused with an attribute but otherwise keep it?

Sure, I'll do so.

If it is meant as an example, maybe the test could be extended to show how
to use it?


Thomas

