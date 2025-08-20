Return-Path: <linux-kselftest+bounces-39351-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0233B2D59D
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 10:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CE1E1895895
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 08:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464172C11D2;
	Wed, 20 Aug 2025 08:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w00Abl7L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CBC27B33A
	for <linux-kselftest@vger.kernel.org>; Wed, 20 Aug 2025 08:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755677053; cv=none; b=qfcjsQL576HhusfwFpwBwv6Q2MZqEOeWgcBlYECe55DgOBxtEv7nMevi9iNzlEPO8G5s//AqDdPeAXg4icnouKw4Hrdi2ihPVWe5ODtbgO3ehNhwR0eQgoOQz1/f9XGy+6tpj/mje0rH1WHEf5LmhC46S8TdmIZmdV9p3DbfQgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755677053; c=relaxed/simple;
	bh=rbFXFjw4n1QivhuWIRmAWtZ9fMtej7RhLcACXFP/i3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nno0qkxSgyxQ3QgQUfbbJGQbzh/LhY4qDSIax+DWL6o5YSRV+nGSUcbpqj2XAfTLtcGXw0wzPDNERKkm77R0/kQlyih2IM6/TXJbHRrgdw690Z0N+qmKIberEbvQfWLXDsqdHF0DqEIT5DsYKXf+robG4FqSpyw+PQEtP+Q9RjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w00Abl7L; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55ce510f4f6so6590256e87.1
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Aug 2025 01:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755677050; x=1756281850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rbFXFjw4n1QivhuWIRmAWtZ9fMtej7RhLcACXFP/i3Y=;
        b=w00Abl7LIysvda5RITxZ3gyLq4xfappFa16LgbiYLPykC4dnMwAOUnsC/xSBnq7nW/
         qUU3yqZBVi7rfxH90gQ5a7pra1XDv1lIB9MS8r8MxKzWYF5GS7awXgROujXmCF47gCrQ
         oksu2jb1sZCFRD9qKTPEqZ5HuMy4Kbw2u/mkPXuU2jenNXN9aPtMsHjkibtHPMvB/CsQ
         7yhAuqMmnf7vf+MIYqZQKHI1F02/kuJAZ7nKGF56KGmtIDTHeliKk7HlaFFSEcLm+k5x
         W/XI1SLMshLnGDimdkgy23AeeBscKCQ22lJlFHJWoRCpgqH4jlGnbjcoE2HdMJpHbwdE
         zu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755677050; x=1756281850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rbFXFjw4n1QivhuWIRmAWtZ9fMtej7RhLcACXFP/i3Y=;
        b=RlhkBLRXy+YHqKcXciZl97C8wBqlr4oGuCprZC194PytVezAbxLX8q5NUSJ0G0UH2f
         zKIb42yq7hiD2xL9GPr7a0ZcNlVEYm2NVDnN/iHzhjd8knZTPDeeBFGGRhQmWKVFOs96
         6FVq9Z+ybvSNtmqOzMvrPc5Pm33NIp4q2PL/8AGaK6dSF2Q9ODlesoDR9X84fY/LSu1u
         bHueA6G6e6J6dfVlc2LxQSzBhTfBBHTkaQgvuF/D60/b/E4nxs8Dj2cdkXfQAEXt+EHo
         3TFIos3YVeeWKMDQ9tKKUysn4ozPhnDP3qlXGKzCA4fGaKHqlNoYGUyJ9UEFeTRl/OlO
         O93g==
X-Forwarded-Encrypted: i=1; AJvYcCW5hjFw10+5XXkOduJFtArvQL3ooc22xERdehvqpoihQY4/PXyD57hYV++11JX0c2gZt9g0PIRSJHB3qwNJHgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyZcxNpVQltm5LD4tde8EUMisHFzI/+Yz5YsVq97wEhaGBy9gu
	JCOeveQ4GZawatCt/sn9hVDP0/iSM8EDDGUdOSeB6GaoQw+/NvQeinGosyCsp+K1LhZ5YFRm2l6
	Hv8dry7QMFgYypHLsYOzJKYTnel4viKsTq052fQc=
X-Gm-Gg: ASbGncvbPCl57muW9INrenCDBsuFjtxfgTwyTH50BkWXbE28Vu4U4K4LDzaYCabhSPh
	GEMGM3KrB1TW4hVqnaelem1ynuH8wkpdS5WdB5e+haeX/TSh7U41NelouZbD2HvZokP04Lo26Q+
	XHzG1ciSC1KaAUCFoMOla8cPVW/WUJSRdeVJ4hrOOtMcHM9CcHuKy5f67nJOkDrBw70iyWQ+CVq
	SrtUBPD3O6O8uQDzgLUThgauf+g7f8d135Lq9Po4DgZtnSg4AU6hg==
X-Google-Smtp-Source: AGHT+IGVK1oPtxH4WR1xR8qF9qbjjy/dcR0lYEGwtgT9scAs4HhXg+zq6box8q/WjPnqcqOrs9UAS7T3jjVlqulmz2U=
X-Received: by 2002:ac2:4ca9:0:b0:55b:732d:931 with SMTP id
 2adb3069b0e04-55e06b2dd6fmr405525e87.12.1755677049307; Wed, 20 Aug 2025
 01:04:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701-vdso-auxclock-v1-0-df7d9f87b9b8@linutronix.de> <20250701-vdso-auxclock-v1-12-df7d9f87b9b8@linutronix.de>
In-Reply-To: <20250701-vdso-auxclock-v1-12-df7d9f87b9b8@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Wed, 20 Aug 2025 01:03:56 -0700
X-Gm-Features: Ac12FXwkxxvaSnLooTWKfhclqEnR_RwAuKEDNHPFBz1DnCC5Fudpwl3wjm0bVsk
Message-ID: <CANDhNCqvKOc9JgphQwr0eDyJiyG4oLFS9R8rSFvU0fpurrJFDg@mail.gmail.com>
Subject: Re: [PATCH 12/14] vdso/gettimeofday: Add support for auxiliary clocks
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Shuah Khan <shuah@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arch@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>, 
	Christopher Hall <christopher.s.hall@intel.com>, Miroslav Lichvar <mlichvar@redhat.com>, 
	Werner Abt <werner.abt@meinberg-usa.com>, David Woodhouse <dwmw2@infradead.org>, 
	Kurt Kanzenbach <kurt@linutronix.de>, Nam Cao <namcao@linutronix.de>, 
	Antoine Tenart <atenart@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 1:58=E2=80=AFAM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> Expose the auxiliary clocks through the vDSO.
>
> Architectures not using the generic vDSO time framework,
> namely SPARC64, are not supported.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Just as a heads up, I've just been bisecting and this commit seems to
be causing problems on arm64 devices, running 32bit versions of
kselftest nanosleep or inconsistency-check tests. Running the 64bit
versions of the tests are not showing issues.

From my initial digging, it looks like clockids that aren't vdso
enabled (CLOCK_PROCESS_CPUTIME_ID, CLOCK_THREAD_CPUTIME_ID,
CLOCK_REALTIME_ALARM, CLOCK_BOOTTIME_ALARM) are somehow getting caught
in the vdso logic and are *not* falling back to the syscall (stracing
the test I don't see syscalls happen before the failure), and the
values returned don't look to be correct.

The inconsistency-check output looks like:
# 5983032:0
# 5983317:0
# 5983561:0
# 5983846:0
# 5984130:0
# 5984415:0
# --------------------
# 5984659:0
# 2009440:0
# --------------------
# 2009724:0
# 2009969:0
# 2010253:0
# 2010538:0
# 2010782:0
# 2011067:0

Which hints we're returning nanosecond values in the tv_sec field somehow.

Reverting just this change gets things back to working.

It's pretty late here, so I'm going to try to dig a bit further to
understand what's going on tomorrow, but wanted to raise this in case
it's more obvious to less tired eyes. :)

thanks
-john

