Return-Path: <linux-kselftest+bounces-7459-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0AC89D0E1
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 05:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0EB41F256C7
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 03:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B9A54F95;
	Tue,  9 Apr 2024 03:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jahHa+vy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6CE1428FA;
	Tue,  9 Apr 2024 03:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712632618; cv=none; b=D8mymBfRgZYD5LNtvoldGGSjASHDNsd25O+aW6od8ph1DOqzITCTjdCay1gArYtPHlc5nKSsJfZIJqY9x3O1U1qI0e2BedW8+ms9h7eztG2HpOv+/BFePfnF0dubu9EGlAOWbyeC9T2tGyrtgfeFBMA5RaY7FncmrygC84b4m1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712632618; c=relaxed/simple;
	bh=Qa5NPcUZfbQXi2Sruz1/vVIcu+7nEJfLxk4HgFKqNq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SuszLTmZAH9xOETObsF51RTRTHMzH9ykU6zBwlM4aYu/9rXHbLqQ/ksm/KmC/PZ2cgDLLuFcOG5wWS/VVtPGfO/FTV4/l/tCvpNjxLaAVyh8qwEddPU7JZw4j2zKeTlE2618paJwYeu48noW40887vcdilOiF5TO3Mo7fp3+anA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jahHa+vy; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3442f4e098bso1383892f8f.1;
        Mon, 08 Apr 2024 20:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712632615; x=1713237415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9sowHMZ+pR1GuhNLCPxU7rSfIL1rnaJJWhD78bjuKo=;
        b=jahHa+vyQ2raIjSBvYCTunwjEk41YkrHai/U6IGpdhauDkJq+Bh3Qzw5HBEzC95xP1
         NKMQHd2fhcNLNi1T9MAkJSsqxLn1mN97FeIXqFaH+yzToB+O2xfsbE4pEEz+qu6Y3dQS
         F/MTEoULXh9G9PuWJqFPfOVF53GxxPVVv87mxJlLYozmUUWJVfOoz3fW6Tg4vh3OsW7x
         N6hQmAqRsOg6r++uxrGKl33gf2VYHanPww74fYEMc7SkRVUfCChpJaHpNZLlXpk2ex1q
         EXTO4vWpM0Q6l1Tcl/wPjJ1B8zcgXfbpbwvsU2MH9GaFTVAbtXbDgtsaK7H8tTUmOioD
         jkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712632615; x=1713237415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L9sowHMZ+pR1GuhNLCPxU7rSfIL1rnaJJWhD78bjuKo=;
        b=WP/l2qWM8YrgQCJNFwazK4dDkg3fQJa8Qdf+k1pJwQ4JzeezWh6O7jLcDr2Lk1fT8X
         53ZZATTEIO3759eihaCOuAottFThpAOV+MAMcwFKkdEuSMaQnao3DK/LG64nzxWp6ih7
         cAEPD2bBgkOG1jvsftn1o2BkYv1AU7RILb+kHJAd2UmATwPcmpSDI3HW7Gjz4VNGhqVk
         mF1I6HqgYBOW5hUEWDGaRW0BHfl4dOjvCIjYXrOr80pXYxwgyAIqJzU9FDItWKomdzTC
         B7Qn1oGsRHKaiyn0Q1bKd6q7z12a6mECXSegLvHkgfR/VGR0MqETll9qRW6mcLSXxc0r
         1xVQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1iG2clA/vBCbhh3dupJ/+33OE6hgbV/kfbrGC6pvlOHRhcsOIXrmxABoeFLF/Bo0Fpn3nRqODnvl0/fjPX0gn072SL4ScYzJrLM6PnyBNfl4KPO28mf4rx+WCRNsRsWX26jf+roFo0Pf1GrSIs20ekIOBWBsAi2jBtEXNEsbTJr35
X-Gm-Message-State: AOJu0YyDoDAHP3i7dtyNKAWNwLn5Lx2k576U/D+kmJ3JtCrSP/OBCEKF
	bAbD2V7IyDoZ94ea5Td1hZjA6OqAT6VoioSU74tL3qgMlidtp0NyMtUajAladmLMRr9X2xF6r1D
	PSdF7/jQWudd9J26vsibJcUiiGLU=
X-Google-Smtp-Source: AGHT+IHKM8ltsBKsFHCQ4PHGPc1GwPESwNA7ZqxlJmaA0dwJIa65oMl/neGXNoN7SoIWVMzg+E6noftmHOV4dcGbM/Q=
X-Received: by 2002:adf:f607:0:b0:343:6c07:c816 with SMTP id
 t7-20020adff607000000b003436c07c816mr925290wrp.16.1712632614749; Mon, 08 Apr
 2024 20:16:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408-hid-bpf-sleepable-v6-0-0499ddd91b94@kernel.org>
 <20240408-hid-bpf-sleepable-v6-6-0499ddd91b94@kernel.org> <345cddbdfe8e91dc6395331c838329d02d519863.camel@gmail.com>
In-Reply-To: <345cddbdfe8e91dc6395331c838329d02d519863.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 8 Apr 2024 20:16:43 -0700
Message-ID: <CAADnVQ+AOtxrQ6Oai20CmU=MSW3f+d_ykRZehYdK=pYjBDdYnQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v6 6/6] selftests/bpf: add sleepable timer tests
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 4:01=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> > +SEC("tc")
> > +/* check that calling bpf_timer_start() with a delay on a sleepable
> > + * callback is returning -EINVAL
> > + */
> > +__retval(-22)
> > +long test_call_sleepable_delay(void *ctx)
> > +{
> > +     int key =3D 2;
> > +     struct bpf_timer *timer;
> > +
> > +     timer =3D bpf_map_lookup_elem(&timer_map, &key);
> > +     if (!timer)
> > +             return 1;
> > +
> > +     if (bpf_timer_init(timer, &timer_map, CLOCK_MONOTONIC | BPF_F_TIM=
ER_SLEEPABLE))
> > +             return 2;
> > +
> > +     if (bpf_timer_set_sleepable_cb(timer, timer_cb_sleepable))
> > +             return 3;
> > +
> > +     return bpf_timer_start(timer, 1, 0);
>
> Q: should verifier statically check that 3rd parameter is zero for sleepa=
ble timers?
>   (same question for call to bpf_timer_set_sleepable_cb() with non-sleepa=
ble map)

It can, but that sounds like more work for the verifier.
Which gives more reasons to use new kfuncs and clean start with bpf_wq.

