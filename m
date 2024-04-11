Return-Path: <linux-kselftest+bounces-7725-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAC78A2076
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 22:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ACEC281F45
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 20:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCA125575;
	Thu, 11 Apr 2024 20:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VqJhLmnH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA38B17C95
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 20:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712868827; cv=none; b=oQBhP62b+KJd7MsFd35iUuVONyhp1sx9+y6gGnaWEX26JHLArOgvRJU2iKsLtrY/34JarZBKKmFteAdA/Ra0vRvd+eDwElTX0Bv9S3vlgACQgvdlGi2XumdgN+/l5haNxa+4Varan3immUW5mKCZFdYTJiNRa3S4lbpwyuI4N9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712868827; c=relaxed/simple;
	bh=wikPBXNvRaP7dm32yt7e6Ihb8KGKHWzps7ctauTrGaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sr2iWsCVdnLwgRrPePlSymepQpKbNfY4yu0+VAyogreAlEGkIpVm+4fN+ipc6EgBPxOaJ9gxsNeR2BtLqPkhpHpfbrynF9n3gxjvZU+LA0M64hNk5a5bY0s51H/tk6Wt/BFTHDwtbtl07G8EGQ/oJ/8Hgk/4YI+1hyIKvSmsbGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VqJhLmnH; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56e5174ffc2so853a12.1
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 13:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712868824; x=1713473624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wikPBXNvRaP7dm32yt7e6Ihb8KGKHWzps7ctauTrGaQ=;
        b=VqJhLmnHsm4RYtB9r0u1KJiFuCiM/ZPDxXHWL0If4X5/hHB+jq7DrKXSsKnTCMsYuS
         gTYMsC3mrwqOJC2QVdRCcVF5pZzcDgl7RoXWBkWIR8PpyQRWMoYXbEhve0j04r94baZ8
         GswR2JbzyiUEu1iAYJQI1VXT9htHbN5Qz+S7s+n6BTIlKT0Mb/ANwkj7Bvn23+DvaxOd
         DlrO28PAl3DXycCJyTK2HWgCCj0V6YxOYZdvkdIrapVqawyTYD+8dBye+R27/Yc1nx6A
         6IF+B8m06SlNawH3S2W33ySN+vOW19skPVTjdRYErepg6PVg9tBoCjnvFdxpRHalFh/4
         Lfwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712868824; x=1713473624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wikPBXNvRaP7dm32yt7e6Ihb8KGKHWzps7ctauTrGaQ=;
        b=aVZJOJ4w6kunt2BFVyCGxSil28/+CVSDzowQvENV4l0M6syiJclPeIwZs8ZdBPm1q6
         3aeA3mH/RanVvfr2XtYsX4w1hBMHQnY5aKAngBmVIuEEDKdymaDfMBpjNmO3+GlqlRa/
         ygdKxKhBn2z4103O7sRM9jqbkepMdAdO9tfC5FFG0wDrMTV4/5m6JpuEhDYRMNarh0uO
         6iTXZUBm3OINzNCiNrnY9Y+OITAzK8bLPW3eDIiyujqS9T96v+Kw46U+fqNFt0WGr7ez
         aGQpDXtOOdjA0x0kH1nBmXIm5JIPfyh+hIThHXj6lFuC32iPvrmmpA14uM1M3svapFP3
         rrbw==
X-Forwarded-Encrypted: i=1; AJvYcCWaerDwVoGohXBiiEDBtekxTvzXyaOtEFWUgZoMLGy5RE0ox4opAWemDbSidywIJUlOWIETzCNUAHSGqkib2R3epwky1ToEjqHe5r5ffeJk
X-Gm-Message-State: AOJu0Yx8KEWIqUHsbZTaMxe9wyJXGg3d8s/P2BA5cig9wuSzlGgluvfo
	ncA2IrLNQzb4Q+wTzI8W+15Pjh5Tl8gzzALW1wjW/L/vOOfvN99Eb8AlsbOq6xDRfJDTOuEKHSK
	Dd4vgC6bUD/9qDw4idbOamhDozd84WOk9T+Q=
X-Google-Smtp-Source: AGHT+IGEX1dRoNOR15JYK2wRIn+J5CZqjGJEpVJLUWr3LZIUpF8+RG/LVgT3KHjTQGfe2VKlBJ4miA5X0wsoJMGQlLU=
X-Received: by 2002:a50:ee9a:0:b0:56f:3a0b:8e05 with SMTP id
 f26-20020a50ee9a000000b0056f3a0b8e05mr45568edr.0.1712868823843; Thu, 11 Apr
 2024 13:53:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410232637.4135564-1-jstultz@google.com> <001f99f4-9463-451d-ac16-0cda91e37e67@linuxfoundation.org>
In-Reply-To: <001f99f4-9463-451d-ac16-0cda91e37e67@linuxfoundation.org>
From: John Stultz <jstultz@google.com>
Date: Thu, 11 Apr 2024 13:53:31 -0700
Message-ID: <CANDhNCoXW2=1nGXYyck6e-CztCjDpC15_qwNk_+dOc8PvB-b4A@mail.gmail.com>
Subject: Re: [PATCH 1/3] selftests: timers: Fix posix_timers ksft_print_msg warning
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Oleg Nesterov <oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Edward Liaw <edliaw@google.com>, Carlos Llamas <cmllamas@google.com>, kernel-team@android.com, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 1:45=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.o=
rg> wrote:
>
> On 4/10/24 17:26, John Stultz wrote:
> > After commit 6d029c25b71f ("selftests/timers/posix_timers:
>
> Tried to apply this for linux-kselftest next with Nathan's patch.
> I can't find this commit in Linux 6.9-rc3? Is this is timers
> tree?

Yes, it in tip/timers/urgent.

thanks
-john

