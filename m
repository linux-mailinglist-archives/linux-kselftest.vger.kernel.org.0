Return-Path: <linux-kselftest+bounces-21234-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A88E9B809B
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 17:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EAD62886EA
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 16:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E3F1A3BAD;
	Thu, 31 Oct 2024 16:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z/KkbUPq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8F11465A5
	for <linux-kselftest@vger.kernel.org>; Thu, 31 Oct 2024 16:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730393550; cv=none; b=hmDKciG0p5k5IGwh8c5LL5RT7oJYmV+4sVJUTnUiiORdiPVc8G4Jwct+gQh9C0kRX1MNACoVFRm7jJi864CNAH4ncVVAP10BWut1kVvYkkgcpVNuv/ET5sPO04OeveBWJ0l+4BzZmemtgqgs7Qy2Zoi3PxgQxZavLBX4ljnwpYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730393550; c=relaxed/simple;
	bh=bhL4cOeg9flmh6w4Ly4dWviaxvaiLy9YFueelUOhFHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mKyp0g0xKCtXX0x8Xft9/AY/FFQ2axWTHHMQuiCPwqxBHVgD9sejG7CeS5G7iACQdGH9CO/3eE6mYx07lszuzhtFsI9Kc4goPjuILLHYWdjX1duQdcMVc6Rr72xeU1pSFWSIZsaL4Rl2FBeNLxC4OVQ1A3UfJ99XpgeOwjohe9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Z/KkbUPq; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3e603471ee5so32262b6e.1
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Oct 2024 09:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730393546; x=1730998346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1sBy3DYerOKb4FnVVXzpV5n8XBDQBztfPs4tu9WoeU=;
        b=Z/KkbUPqRh6zC/bH+dBsZYlgktFUeoocJ6SpwYw2PM4AfsFks60SfnWr1AtKbPcsc4
         l0b0VJ8xY3iLp0SeOaEq8mVv26W2iG3jRP2mCh+qG4k2t9dDkG89XPOzuciSKYqgsKMD
         /zeChCrE2WJQafm8BjKtYLNnZZ2uUvWgkkbS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730393546; x=1730998346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d1sBy3DYerOKb4FnVVXzpV5n8XBDQBztfPs4tu9WoeU=;
        b=Y1I4wN+MMbs58eYN0rEasfeNiwSr4dZiEutmikCtGcYCzlPVHkCBek/T+ZTMJ6uj03
         yaris1KWe+/T+T+bCjyN1onK+tIyWYexVuuIazBpT1ZIeWcpOc8htZiYTpIjRnuD50I0
         xTJdrjty4zcN3OHyVtBvmJBee30nKIpkDqMYCIW1FDq4911KCgsGF4mNfw9Lgf764xbm
         w4+t1dKZSEBtw5imeb6uGTFdGdZRUWcOGoH0jLkhLH+Uo9joo+F3yq6+H8KUafIy2OZR
         hWM9lckqxbSBIXyh8nWbHJMB0vnkNqIZ8cDr+M/fZI8nRpcGsmtsvUPSnX0bALGpbdL7
         BQdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsHwzxnuXDrOahDp678eJxPGD0QebsfVZ5EaZG4yDlV7WqL+ptDnAgKDUJejspFPzoWwaCIRBoT2zgswEdYkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwUdG9fuxut/Ux0+fKR+oY640JFPl9sffJEizUTR0Pm1hE3x/B
	2R9IkjmaDWdViL/PWBff4SU8nBjIQu3KqJLCEaebgdUJR+D9ACw0MGLKZ8xFt7epZuyZK+aTs3z
	MsQ2XUWVIXLIAi7F/mLHQPZvWLWWIJ9pT+Awi
X-Google-Smtp-Source: AGHT+IEAc6edM0Ncjo4EdyB2oQgViyyGObGsOoppoSaK1T1bY27hlzIMoMglFogdGkL86bjLnDp1j/GSYVW4BQfnyQQ=
X-Received: by 2002:a05:6870:c088:b0:27c:a414:c22d with SMTP id
 586e51a60fabf-29051d59b42mr5165035fac.11.1730393546203; Thu, 31 Oct 2024
 09:52:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029144539.111155-1-kevin.brodsky@arm.com>
 <CABi2SkW4Utuo3qGKodTQn7VuFrRa4hpwrik7WaorS4=wm_cS2g@mail.gmail.com> <8dcc7e49-ec95-4d7d-8ded-d4f7202d623d@arm.com>
In-Reply-To: <8dcc7e49-ec95-4d7d-8ded-d4f7202d623d@arm.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 31 Oct 2024 09:52:14 -0700
Message-ID: <CABi2SkXQnzDnmMcM8YOW9tSeNwgPBhjWi4FO8nuHEuPA_RHNuQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Improve arm64 pkeys handling in signal delivery
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, 
	anshuman.khandual@arm.com, aruna.ramakrishna@oracle.com, broonie@kernel.org, 
	catalin.marinas@arm.com, dave.hansen@linux.intel.com, Dave.Martin@arm.com, 
	joey.gouly@arm.com, keith.lucas@oracle.com, pierre.langlois@arm.com, 
	shuah@kernel.org, sroettger@google.com, tglx@linutronix.de, will@kernel.org, 
	yury.khrustalev@arm.com, linux-kselftest@vger.kernel.org, x86@kernel.org, 
	Kees Cook <keescook@chromium.org>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 6:00=E2=80=AFAM Kevin Brodsky <kevin.brodsky@arm.co=
m> wrote:
>
> On 30/10/2024 22:59, Jeff Xu wrote:
> > Apologize in advance that I'm unfamiliar with ARM's POR, up to review
> > this patch series, so I might ask silly questions or based on wrong
> > understanding.
>
> That's no problem, your input is very welcome! There is no fundamental
> difference between POR and PKRU AFAIK - the encoding is different, but
> the principle is the same. The main thing to keep in mind is that POE
> (the arm64 extension) allows restricting execution in addition to
> read/write.
>
> > It seems that the patch has the same logic as Aruna Ramakrishna
> > proposed for X86, is this correct ?
>
> Yes, patch 1 aims at aligning arm64 with x86 (same behaviour). Going
> forward I think we should try and keep the arm64 and x86 handling of
> pkeys as consistent as possible.
>
> > In the latest version of x86 change [1], I have a comment if we want
> > to consider adding a new flag SS_PKEYALTSTACK (see SS_AUTODISARM as an
> > example) in sigaltstack, and restrict this mechanism (overwriting
> > PKRU/POR_EL0 and sigframe)  to sigaltstack() with SS_PKEYALTSTACK.
> > There is a subtle difference if we do that, i.e. the existing
> > signaling handling user might not care or do not use PKEY/POE, and
> > overwriting PKRU/POR_EL0 and  sigframe every time will add extra CPU
> > time on the signaling delivery, which could be real-time sensitive.
>
> From a purely functional perspective, resetting POR to allow access to
> all pkeys before writing the signal frame should be safe in any context,
> and allows keeping the handling simple (no conditional code). The
> performance aspect is a fair point though, as we are adding an ISB
> (synchronisation barrier) on the signal delivery path if POE is supported=
.
>
Yes. The functional level is the same.
Having worked on a read-time system a bit in the past, I'm aware that
signaling handling paths are real-time sensitive.

> > Since I raised this comment on X86, I think raising it for ARM for
> > discussion would be ok,
> > it might make sense to have consistent API experience for arm/x86 here.
>
> And indeed this is what I think is most important at this point.
> Considering that Aruna's series resets PKRU unconditionally (sigaltstack
> or not) and has already been pulled into mainline during 6.12-rc1 [2], I
> still believe that patch 1 is doing the right thing, i.e. aligning arm64
> with x86. If the concern with performance is confirmed, and there is an
> agreement to reset POR/PKRU less eagerly on both architectures, this
> could potentially be revisited.
>
Oh, I didn't know it was already in main. My information is out-dated.
It does feel a little rushed because my comment on the performance
perspective isn't addressed/responded.

 -Jeff


> - Kevin
>
> [2]
> https://lore.kernel.org/lkml/172656199227.2471820.13578261908219597067.tg=
lx@xen13/
>
> > [1] https://lore.kernel.org/lkml/CABi2SkWjF2Sicrr71=3Da6H8XJyf9q9L_Nd5F=
Pp0CJ2mvB46Rrrg@mail.gmail.com/
>

