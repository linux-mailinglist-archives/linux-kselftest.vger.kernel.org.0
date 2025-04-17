Return-Path: <linux-kselftest+bounces-31036-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1611EA912A9
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 07:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 801DD5A153B
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 05:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0265C1DE883;
	Thu, 17 Apr 2025 05:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gppObXx0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394EA18DB2B
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Apr 2025 05:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744867799; cv=none; b=bwZ2nrAIoJkIW+rYxzA3O4iUI04rEhTa825LS5Rk+3kDZtiK/01JZfkbkhTn90HUxyqYntqpAAi4LIdI/kFRtOXAeBwH+QLAHDDhTBjcL9NZIg8VrPKyiCgHxUrNZ3KL9jBUs+/vwiE0o53GzfK3ba8kRSVGaF6J1OKuNIPl/Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744867799; c=relaxed/simple;
	bh=8IRUAWuyG9XC3pN0aPIS/KTtqadjkSf+Hpg2rRtqp40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pexqnnGWbb81gTl2W2tI34xr+ZrHh8Guy6Hu6HUXCS2VmDonS9CXaCyL9NEhnSiVqdWhXwZCZWjqht8ZnjxlkEr2CtESw0ODj70w+rgW0vS0FW9rjsjlfRlynAD8KmAlX0sGa61eBoiPoyNz2lmX612zI1uL7o43aou6yu2b3DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gppObXx0; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54addb5a139so437451e87.0
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Apr 2025 22:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744867796; x=1745472596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tbq98NwkRxfOjYm7weOTRHKupXkAEHniDZUVgeT5NY=;
        b=gppObXx0daXauwXNinllK3Gn5/8vH1/XDhdrvtczv3r5m85tD/P4XNDAG8qKqqzI7v
         SgBkJaM0n5jWXojlSPGtEJqjMjwFSI2ol4261qFU+0nDK2QjM3t+VtNZra/NvHUSv71I
         yUH3QytrnFSb8ht2kdViEA2pEoO3/DrfJ1WiDST8DfCRfDiikGVCQIbhQkCs5jGTfbhz
         UA4ksWjT4kYLVS6MN1QbtQKzLIJ5o+ZjWBplpaffynqDccHD/cV5VENt+hAOhjXkJSbz
         G94oMUc59HPkeKZXatG7eApGmJwseHPUNEREA6LpbTyqXumRFUkeIPGCH4iMxa6pUo4w
         n0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744867796; x=1745472596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/tbq98NwkRxfOjYm7weOTRHKupXkAEHniDZUVgeT5NY=;
        b=PRB4Ck0THpq1eBNwlQT1j+SGSLExKmf/IAlUmbjkz7+MStvu6gm/5CUr3mIu1xx+0M
         /yJKSIdRAPBQC6RpanJAfTafDyw7hj5bp5jBN1+zHoxIwymZFAMkeq6JotyIBX6YGmx8
         o5w4YJ137LBN5nGAPmQojuMVdJLCKP53atuTmULg5Ve6Pjt8ngoGHr0YsUSOMuLXTHoY
         daXRyhzy9KW4xgnKATkmbxdL0n3tPszanLu0lfyWTE832l1SC5kDR5LiUUFFfszh+bCF
         ksq++mq9WjJF3xYmIY3xcLHgEnUbfgX6j7d9yhrLAS3kF3xuOBKwlRIRs/QbtWzLQVxX
         ep3A==
X-Forwarded-Encrypted: i=1; AJvYcCU4mpFoC1LTNW9iI6ABdUvsjKu6APIVcDOaJUxcX2k9s5NiCntNrnWUohypVPJnLlMOv0mnqPZNJCRN2DpCcpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLeQjla5ipkgRqjH7+ie/twJxLP2qBon1ZnYHUxPR4oPKaXi9z
	Of64XCrhQDaL0BWKdDpyUc0ZQehaAgYqlJGhvVjgv48iSMBfD95xDutgifWoeWASoyZNpEWasQE
	RLLnD4Opz/sdp6MuD8jS7pBWgEZv2EeNQLEJhpZmzwnTxTdNWY5g=
X-Gm-Gg: ASbGncuy7byM4sHp35he0mDBLRmmE7hJ9/rP9dkR62ni4z7dd82YCAZAwMDQC+Coxoh
	+BdXDVeqfpM532PX/QwMvwxq3b0yMUMc21VUb0LPnNQl3fx9tZKtSnhlkpnTvqnQvJh5Lqxx4cZ
	T/ZjF0q8O2evR4a/w84rQX38CEfL9OOnMHypS+gv7c+B2fPiOZ+/hdgq6/DkB1WQ==
X-Google-Smtp-Source: AGHT+IFJsMYdvqU27gQJon+URzkUuZBB06ki2I46tRCTIgHeKrXMiYT2i6HfyxRplJ+POPGp9j0hKgQgUp4Pj9Dsnbw=
X-Received: by 2002:a05:6512:ac5:b0:549:903a:1b3 with SMTP id
 2adb3069b0e04-54d64aea494mr1431419e87.42.1744867796065; Wed, 16 Apr 2025
 22:29:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320200306.1712599-1-jstultz@google.com> <Z-KURRE_Gr72Xv_n@localhost>
 <874izezv3c.ffs@tglx> <Z-Vx8kV4M3khPknC@localhost> <Z-qsg6iDGlcIJulJ@localhost>
 <87o6xgwftc.ffs@tglx> <Z-vL3cVZuQ8XQXhG@localhost> <87iknnwxa4.ffs@tglx>
 <Z-5HlSUEh1xgCi4f@localhost> <877c41wkis.ffs@tglx> <87h632wals.ffs@tglx>
In-Reply-To: <87h632wals.ffs@tglx>
From: John Stultz <jstultz@google.com>
Date: Wed, 16 Apr 2025 22:29:43 -0700
X-Gm-Features: ATxdqUFRIk__GaYDInAsvbeQ0YVaEScg1GGtg38lyC7CTsJPCjHDcqn17UbtfGY
Message-ID: <CANDhNCpAVo7FsmGhTVRMkazUT18dZG42M82O3QPQE8XobsWOaw@mail.gmail.com>
Subject: Re: [PATCH] timekeeping: Prevent coarse clocks going backwards
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Miroslav Lichvar <mlichvar@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Lei Chen <lei.chen@smartx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 5, 2025 at 2:40=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> Lei Chen raised an issue with CLOCK_MONOTONIC_COARSE seeing time
> inconsistencies. Lei tracked down that this was being caused by the
> adjustment
>
>     tk->tkr_mono.xtime_nsec -=3D offset;
>
> which is made to compensate for the unaccumulated cycles in offset when t=
he
> multiplicator is adjusted forward, so that the non-_COARSE clockids don't
> see inconsistencies.
>
> However, the _COARSE clockid getter functions use the adjusted xtime_nsec
> value directly and do not compensate the negative offset via the
> clocksource delta multiplied with the new multiplicator. In that case the
> caller can observe time going backwards in consecutive calls.
>

Hey Thomas!
  Thanks so much for reviving this version of the fix and my apologies
for apparently taking us down the wrong path with the earlier
solution.

Looking over the patch, it seems ok to me, but in a test run with it,
I've seen an error with CLOCK_REALTIME_COARSE during the
clocksource-switch test  (as well as some seemingly unrelated test
errors, which I need to investigate) so I'm looking at the zeroing
done in timekeeping_forward_now and will try to look more into this
tomorrow.

thanks
-john

