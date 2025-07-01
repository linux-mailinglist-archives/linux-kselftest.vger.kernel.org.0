Return-Path: <linux-kselftest+bounces-36191-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5A9AEFC8F
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 16:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8769D3A80BE
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 14:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B619277006;
	Tue,  1 Jul 2025 14:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="efF7AS6P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4AA2737FB
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Jul 2025 14:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751380281; cv=none; b=O15DciNyxhd3qgaUDOLNZevsnfQLKBPXFzPUPhXbPz5zAcHua6+mVKwW7O/OUATOBpbJAnJoVKg4K8AAX4m3q732sZkAqwTOd6QEg/kzHbx/eEX4kOGx9PNIBjDQILg8b1y8L2FwowDPjDeizpb/aYemZd9T9o4omY1Y6+FG+2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751380281; c=relaxed/simple;
	bh=Vyaw3SbBUxgSTTI9AeYN82yvnlhmafU1DKbDbWX2Gxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R1nO4VsD+8qd0VpMoTkvq2G/6bPdDsHRKkzju3j35mE/9bNlauFmaqPkjooZ5kQCWV2oWj45Dwk+ZoOu99v1hpdlYJcyFgI9ip2TmO5d9febcy2m9GFtonunFQ7DigVAsSpQQc17yEeW/RVWJ1JkMghpQqIZQ1BfcQqJpMEuoxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=efF7AS6P; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7115e32802bso33619797b3.1
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Jul 2025 07:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751380277; x=1751985077; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TQpP4/sk5UISbR4PxoNCsU4Q55EXCGohsAJif2KUhLk=;
        b=efF7AS6PoWTQN0bacqPpWZORTkzqbQ0o5sEhaPGgu2BWKgVGSDb2joWMl2mhLzIvmR
         x0UrlBfaicNfLJCdFnGTiVSNtedEPVOgTklmN3afXi9nlyEZ/3laMY2ZgrNyMmgh5aM9
         eelL1DOS/VwiyS7g84uRnfbJ7ncDB2WbqBI6rNYhJOsgQV9foagkOJxmrDVmMuL3Qwrp
         nA4i6DUL8hAS0czzXUcA6O0t1taDngCZ4sqy/p3d6bG9J1QgTkCMrGBSH2zwAI4RVxcN
         QiN/459QpyuicB972tjp3tGTzDh6D4iGk3812KjybHoEuzaaNJf2CUBKBQWxLIDJkd4s
         kVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751380277; x=1751985077;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TQpP4/sk5UISbR4PxoNCsU4Q55EXCGohsAJif2KUhLk=;
        b=RHbxytd53lbXpZUjy5zQTcYamudJqSTwMPpUhetJyJAnCsDItdWEPgQGqLtNd01MId
         MIWd50l5qWkm8mt9yAM/xjPALYXfiiFoRtNzS09DGWY6UcNAgK9wj8DJOF8hdNRsje1M
         E6R/n+QVPj4Fjb3rGg/NvK8ScYCqHjgEmZ4D3ZRApL+Eahwa4ODiQRIb4Nx6ZkoBd4EI
         IH1qKg8l9w3clW4rqGfgPKY6l62S05NpipDGnmTNa9tGHQZYfaKwVkmeIfCV1t1YghYM
         dn0LwsmUgvvre1Bw2kFzMJNc9mS0BQoykC88jZHSsoh/TDnltb5n0XNHq/TCZvMG5CB7
         Q8ZA==
X-Forwarded-Encrypted: i=1; AJvYcCVIaEknEEVjQiZGyLAFy6it7i4o2FCSeuc95dIl1aDbz5568jAH4o1/NGduTDwf7A1NKBwp2AkKTZ/iZSdFTUs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj5gPKQXlPlSBINxA9pAS0f8pRgWvhbi8qlcPTJ/5w+vBQ1Lp+
	RXZaN4Z5Z8eE3aD2wez+5PCNbNQP7VbKg36bCwXzKBiuNnnUTYy4aVMDzpjNJJmhwQcbIimbd8m
	9AtG++De8Xrk5SX+YVj/Pc6LEIioEfsGU3sq8a1G35Q==
X-Gm-Gg: ASbGncu1F3PnUIShlP8q8AyPw2bQ9jVSnAwzvuzLQ0BFaKtiueZkWg2c37nMjlxKKV4
	bv63ylvCLa5CpefptXGq8vwC1G816rS9QcGPN5BJM87kl+JnDx8qAMiQ344isto/Og8Q+Awevji
	dDWDhTdFAdb3Z7iQwOezqEyDIrhZbOQGc629dte/QYr+8=
X-Google-Smtp-Source: AGHT+IHLzuypKr5+dQZzwd42pEKbEhbfN4QvfGGBYNmqENm7MgpYzk7kFsFxKSU9PQLvgxInKK0kKJIRrLIS9ZY0Xrc=
X-Received: by 2002:a05:690c:f8c:b0:70e:2246:1999 with SMTP id
 00721157ae682-7151718b978mr245629467b3.21.1751380276931; Tue, 01 Jul 2025
 07:31:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701142313.9880-1-terry.tritton@linaro.org>
In-Reply-To: <20250701142313.9880-1-terry.tritton@linaro.org>
From: Terry Tritton <terry.tritton@linaro.org>
Date: Tue, 1 Jul 2025 15:31:05 +0100
X-Gm-Features: Ac12FXxLXB1RyvUmPau1KOm3_EHbxZPmugbEEKi4qfRF9Vdw1FA3L6wYKz2GY7s
Message-ID: <CABeuJB3QYKqEb2YZjCicGVFkrZTCgdU+dMM90B6OHUuvUSrWaA@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/futex: Convert 32bit timespec struct to
 64bit version for 32bit compatibility mode
To: Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: ttritton@google.com, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="UTF-8"

Sorry forgot to save the change log before sending.
v2: fix Signed-off-by chain

On Tue, 1 Jul 2025 at 15:23, Terry Tritton <terry.tritton@linaro.org> wrote:
>
> Futex_waitv can not accept old_timespec32 struct, so userspace should
> convert it from 32bit to 64bit before syscall in 32bit compatible mode.
>
> This fix is based off [1]
>
> Link: https://lore.kernel.org/all/20231203235117.29677-1-wegao@suse.com/ [1]
>
> Signed-off-by: Wei Gao <wegao@suse.com>
> Signed-off-by: Terry Tritton <terry.tritton@linaro.org>
> ---
>  .../testing/selftests/futex/include/futex2test.h  | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/tools/testing/selftests/futex/include/futex2test.h b/tools/testing/selftests/futex/include/futex2test.h
> index ea79662405bc..6780e51eb2d6 100644
> --- a/tools/testing/selftests/futex/include/futex2test.h
> +++ b/tools/testing/selftests/futex/include/futex2test.h
> @@ -55,6 +55,13 @@ struct futex32_numa {
>         futex_t numa;
>  };
>
> +#if !defined(__LP64__)
> +struct timespec64 {
> +       int64_t tv_sec;
> +       int64_t tv_nsec;
> +};
> +#endif
> +
>  /**
>   * futex_waitv - Wait at multiple futexes, wake on any
>   * @waiters:    Array of waiters
> @@ -65,7 +72,15 @@ struct futex32_numa {
>  static inline int futex_waitv(volatile struct futex_waitv *waiters, unsigned long nr_waiters,
>                               unsigned long flags, struct timespec *timo, clockid_t clockid)
>  {
> +#if !defined(__LP64__)
> +       struct timespec64 timo64 = {0};
> +
> +       timo64.tv_sec = timo->tv_sec;
> +       timo64.tv_nsec = timo->tv_nsec;
> +       return syscall(__NR_futex_waitv, waiters, nr_waiters, flags, &timo64, clockid);
> +#else
>         return syscall(__NR_futex_waitv, waiters, nr_waiters, flags, timo, clockid);
> +#endif
>  }
>
>  /*
> --
> 2.39.5
>

