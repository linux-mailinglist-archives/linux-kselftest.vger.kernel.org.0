Return-Path: <linux-kselftest+bounces-21188-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F209B6FA0
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 22:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 828CC1C2168B
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 21:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8FB1CF7BB;
	Wed, 30 Oct 2024 21:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aB1yuZfK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE16E1BD9E8
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Oct 2024 21:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730325561; cv=none; b=tVb1IF5TbqyXXya2Q+wIRHSxh/pUjYdaFFKSHFvnpjrjf9K71SamyD0YUe0zTfeU7XRUenMfCAQ0Mp1ZBHVWEJlYo7UO5EvWQYSbvkmif9z6NEKcCfRZiwWJHCBP1YqH1F3vjd3udfRJb5V0qUW6AOr1UMAiR8qiGThHQjpGZOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730325561; c=relaxed/simple;
	bh=8KIpkspwrFcPiAUikPXMt7TXm1e8ZXGdPzNK1qrZzZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=auEFtYM86IBwKMctqYub7xJEfRBSigre6CjUSaQJSgjuBxLtP8XUYNWpcfFG8LQlmYZ69gxBRmWMHJ162avsOiz/BCNin/hl3Qls+Uk0lkBgI3ujA3tNtJtEGcbEaznMHvXK/7J86lnlW5Ac+Vq5Ac46LAnqr7AZ8iZoMsq+iEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aB1yuZfK; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-28921224030so31425fac.2
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Oct 2024 14:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730325558; x=1730930358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KF0Kmn9RfLVFl5d+nc887Jbm4zho3aMlnGh/BRkWbjg=;
        b=aB1yuZfKc8DSZOQEldBYa1mzLwpid85CMyIwz1H5j9Sv8nWFyqN4KIwpELn8Aw7Y84
         j8I8enVldIwdKtSAO+PGW4summlOycp/Gu903p4IOLGQLS0AxT+T1x3mYD+3Y/ZZ1SPU
         6mUJ2IaxcjB6ExGS5elhzxfU5fXmBzYbp8r08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730325558; x=1730930358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KF0Kmn9RfLVFl5d+nc887Jbm4zho3aMlnGh/BRkWbjg=;
        b=ekOGjn0G+B6pRFhnyxJd27vzma/MVeUdoDonmMKhja4XRGCaP2Acg7bkEwQtm1HKdz
         CvTh8JQXsCAiRCs7TAn3rUkcA0gM4AZxwzgd5CKD9ZBXGXCqayHj0MCkyI5vwjifZElU
         KnJpvTuT7kScGX1FFeYuiGAx5H5V3ykC5l61gdiL61rG5tthv/G7DJOxDfaD1DzjDxkQ
         nN67RY0Ui5nR12sscdpq0b6rIv7pyPok/AvcKAH7SyEu1Bov82+hTLQ/9HtSVvL8HvgT
         CvBTetJyw9sEpTDt81WxACrRaGkbp/LoIwh3zqk3yAynMY29t14vYn7X7NlEdb7ffcch
         S4Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVTrZ9TwH0CXZl2QQyQv91JOJACgcmg3nH22JLoJjcpKDH/94M8wqR5wea4Uy7/W9dq06HRNRL5IPda13wI9UM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa3Mf52ZaON0VPykpsJJPyu8wAqI2MeBEcG1UjZ4wXIEkrFB5t
	UrTOC7cJsdSzxGPPTstP8fAgFN3sSf4xzStIUIO3lwRUqy79vqQRveJZnyFN3uJrHDaOmyZwGmV
	H4xRsHiovUELNBBJuzPDt9JF7hTFsfuTkr41P
X-Google-Smtp-Source: AGHT+IF1wAKKjsN2iV3MTS8Pdrj+X9BWtdPUNQq1ShgB2qMvbD4fOXM5ZINa1FfnKg2bL289c/aWd/ZKah6jdjkF2+Q=
X-Received: by 2002:a05:6870:c088:b0:27c:a414:c22d with SMTP id
 586e51a60fabf-29051d59b42mr4505798fac.11.1730325557790; Wed, 30 Oct 2024
 14:59:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029144539.111155-1-kevin.brodsky@arm.com>
In-Reply-To: <20241029144539.111155-1-kevin.brodsky@arm.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 30 Oct 2024 14:59:05 -0700
Message-ID: <CABi2SkW4Utuo3qGKodTQn7VuFrRa4hpwrik7WaorS4=wm_cS2g@mail.gmail.com>
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

+Kees and Jorge and Jann

On Tue, Oct 29, 2024 at 7:45=E2=80=AFAM Kevin Brodsky <kevin.brodsky@arm.co=
m> wrote:
>
> This series is a follow-up to Joey's Permission Overlay Extension (POE)
> series [1] that recently landed on mainline. The goal is to improve the
> way we handle the register that governs which pkeys/POIndex are
> accessible (POR_EL0) during signal delivery. As things stand, we may
> unexpectedly fail to write the signal frame on the stack because POR_EL0
> is not reset before the uaccess operations. See patch 1 for more details
> and the main changes this series brings.
>
> A similar series landed recently for x86/MPK [2]; the present series
> aims at aligning arm64 with x86. Worth noting: once the signal frame is
> written, POR_EL0 is still set to POR_EL0_INIT, granting access to pkey 0
> only. This means that a program that sets up an alternate signal stack
> with a non-zero pkey will need some assembly trampoline to set POR_EL0
> before invoking the real signal handler, as discussed here [3]. This is
> not ideal, but it makes experimentation with pkeys in signal handlers
> possible while waiting for a potential interface to control the pkey
> state when delivering a signal. See Pierre's reply [4] for more
> information about use-cases and a potential interface.
>
Apologize in advance  that I'm unfamiliar with ARM's POR, up to review
this patch series, so I might ask silly questions or based on wrong
understanding.

It seems that the patch has the same logic as Aruna Ramakrishna
proposed for X86, is this correct ?

In the latest version of x86 change [1], I have a comment if we want
to consider adding a new flag SS_PKEYALTSTACK (see SS_AUTODISARM as an
example) in sigaltstack, and restrict this mechanism (overwriting
PKRU/POR_EL0 and sigframe)  to sigaltstack() with SS_PKEYALTSTACK.
There is a subtle difference if we do that, i.e. the existing
signaling handling user might not care or do not use PKEY/POE, and
overwriting PKRU/POR_EL0 and  sigframe every time will add extra CPU
time on the signaling delivery, which could be real-time sensitive.

Since I raised this comment on X86, I think raising it for ARM for
discussion would be ok,
it might make sense to have consistent API experience for arm/x86 here.

Thanks
-Jeff

[1] https://lore.kernel.org/lkml/CABi2SkWjF2Sicrr71=3Da6H8XJyf9q9L_Nd5FPp0C=
J2mvB46Rrrg@mail.gmail.com/



> The x86 series also added kselftests to ensure that no spurious SIGSEGV
> occurs during signal delivery regardless of which pkey is accessible at
> the point where the signal is delivered. This series adapts those
> kselftests to allow running them on arm64 (patch 4-5). There is a
> dependency on Yury's PKEY_UNRESTRICTED patch [7] for patch 4
> specifically.
>
> Finally patch 2 is a clean-up following feedback on Joey's series [5].
>
> I have tested this series on arm64 and x86_64 (booting and running the
> protection_keys and pkey_sighandler_tests mm kselftests).
>
> - Kevin
>
> ---
>
> v2..v3:
> * Reordered patches (patch 1 is now the main patch).
> * Patch 1: compute por_enable_all with an explicit loop, based on
>   arch_max_pkey() (suggestion from Dave M).
> * Patch 4: improved naming, replaced global pkey reg value with inline
>   helper, made use of Yury's PKEY_UNRESTRICTED macro [7] (suggestions
>   from Dave H).
>
> v2: https://lore.kernel.org/linux-arm-kernel/20241023150511.3923558-1-kev=
in.brodsky@arm.com/
>
> v1..v2:
> * In setup_rt_frame(), ensured that POR_EL0 is reset to its original
>   value if we fail to deliver the signal (addresses Catalin's concern [6]=
).
> * Renamed *unpriv_access* to *user_access* in patch 3 (suggestion from
>   Dave).
> * Made what patch 1-2 do explicit in the commit message body (suggestion
>   from Dave).
>
> v1: https://lore.kernel.org/linux-arm-kernel/20241017133909.3837547-1-kev=
in.brodsky@arm.com/
>
> [1] https://lore.kernel.org/linux-arm-kernel/20240822151113.1479789-1-joe=
y.gouly@arm.com/
> [2] https://lore.kernel.org/lkml/20240802061318.2140081-1-aruna.ramakrish=
na@oracle.com/
> [3] https://lore.kernel.org/lkml/CABi2SkWxNkP2O7ipkP67WKz0-LV33e5brReevTT=
tba6oKUfHRw@mail.gmail.com/
> [4] https://lore.kernel.org/linux-arm-kernel/87plns8owh.fsf@arm.com/
> [5] https://lore.kernel.org/linux-arm-kernel/20241015114116.GA19334@willi=
e-the-truck/
> [6] https://lore.kernel.org/linux-arm-kernel/Zw6D2waVyIwYE7wd@arm.com/
> [7] https://lore.kernel.org/all/20241028090715.509527-2-yury.khrustalev@a=
rm.com/
>
> Cc: akpm@linux-foundation.org
> Cc: anshuman.khandual@arm.com
> Cc: aruna.ramakrishna@oracle.com
> Cc: broonie@kernel.org
> Cc: catalin.marinas@arm.com
> Cc: dave.hansen@linux.intel.com
> Cc: Dave.Martin@arm.com
> Cc: jeffxu@chromium.org
> Cc: joey.gouly@arm.com
> Cc: keith.lucas@oracle.com
> Cc: pierre.langlois@arm.com
> Cc: shuah@kernel.org
> Cc: sroettger@google.com
> Cc: tglx@linutronix.de
> Cc: will@kernel.org
> Cc: yury.khrustalev@arm.com
> Cc: linux-kselftest@vger.kernel.org
> Cc: x86@kernel.org
>
> Kevin Brodsky (5):
>   arm64: signal: Improve POR_EL0 handling to avoid uaccess failures
>   arm64: signal: Remove unnecessary check when saving POE state
>   arm64: signal: Remove unused macro
>   selftests/mm: Use generic pkey register manipulation
>   selftests/mm: Enable pkey_sighandler_tests on arm64
>
>  arch/arm64/kernel/signal.c                    |  95 ++++++++++++---
>  tools/testing/selftests/mm/Makefile           |   8 +-
>  tools/testing/selftests/mm/pkey-arm64.h       |   1 +
>  tools/testing/selftests/mm/pkey-x86.h         |   2 +
>  .../selftests/mm/pkey_sighandler_tests.c      | 115 ++++++++++++++----
>  5 files changed, 176 insertions(+), 45 deletions(-)
>
> --
> 2.43.0
>

