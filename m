Return-Path: <linux-kselftest+bounces-32099-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D30B0AA64F5
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 22:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49B2A4C3E58
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 20:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00583253B4C;
	Thu,  1 May 2025 20:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKhXoJPk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BDB7083A;
	Thu,  1 May 2025 20:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746132944; cv=none; b=SKNYjEG0A4TdBRRX1JAdt2V0O6TpTjdxjc3M2n+0JJJiBdQSLA8FQLmsmyJmpOqDDUqYhg9lN1sm10n75Ca2+lMbAuO1Ki4sbk+yVYoVJxwtiOEDzsK2vzppu04+npV6RyQmLAFvYubnKj3PVOxqdzeoyhFP1VsEZ/rroXO33eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746132944; c=relaxed/simple;
	bh=I+dEedf1pTJyAwoEmIwbwG0wBXM+8Q+YWSy8/oH3exQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PfH3juIrRI8H92q9286l3l4JMo1qqNEErlzivpbBxksGsRmrXssyHRE/m/TkCX41vlnWz6S5rOXrxdswM+bFBNBNqR9BHCkLGibImNdXmPuvoOaCqppsJ3fA8v90NS1GjYznDGsE1HfU0imCjhtzi8PJ7ItN/YDwWF0wsuSvhEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKhXoJPk; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-301918a4e3bso1599667a91.3;
        Thu, 01 May 2025 13:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746132943; x=1746737743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DpiuHUeq5me2qFWhjdsz2hFxFCDha2ue8NZc3ijvfAY=;
        b=RKhXoJPk2TMB4+b295fSUerabPW4ZT2nMP3GZcRRQfmlG3iiBX7jJjU0gA748y5PQz
         EXhWq7SYGPvcv75HLE+sFMojxP5wPTihZQsF5YkOGKIssLnBtK+yproa63Am6ptrA4v2
         2fx0XxKG3W2E9YVSWLfMwJW8/KL2NQFfLGca8AWVAeuWVPoZ1QCsoROq5uN5STXlkqZT
         YwJvJSYp08dfKdShbI32u1DnNgwfhgqFYdhf++omusVGFAY5GPiGWWJiS2BJ6q48yrG+
         8apvLXre8RnjTmu9JdFNoIZR8v73fz1/n4xeIZVVqzD+6lcH/aN1q0ImK/7Ema601EQi
         ug7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746132943; x=1746737743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DpiuHUeq5me2qFWhjdsz2hFxFCDha2ue8NZc3ijvfAY=;
        b=CTjebm9+gUHAUbLHMYuTDuJpPKaSUf2JGG3YOq5F9E4I/b8WbrxAoEyeWiWHnMtI08
         slcg5srcj4TTnvARZkLypZtbFmuzKUpWuAP1mzPP2WqzpV+tKx9prEdnqDjPos5Wm9e9
         tR4BI4xzPmRKxNJS9q5oG7+L7lA+gWsA4J78plcaseGEr5M0l37hKLV065HiNnAPtwNg
         8rExIBIDR4edy7mb913CkLuy6rePOqtvWdhK4jtSmpL6dsZQuHF9SwhBELG7zFWzo5BT
         VBTMqJQ+DEZk7QVwNqkrFkd51AW/rka3tLWYxGS7fBgavolH+RgexCwAtZjf2g7WGP3c
         Y4zA==
X-Forwarded-Encrypted: i=1; AJvYcCUNQJQskmmjRLrxHfguRrWBPR9W6yeJovn/yyggEDylgVfKrEb+amF7lxOYlUDJiQLKeQEBGlbL8W8LREkAHFM/@vger.kernel.org, AJvYcCVL1J5tcx8ai2ly420lRXAoOpYnfUdQE5hH902jSz5qUr1iU4t5hzIgZ92K8J6nXESiIUSKzeacoNIfMGpPXCIqapsf@vger.kernel.org, AJvYcCVsjWQBzxSMID+rCBil9Xq6nPXfCtR2p4ZIHnSJ7/aDxlT9rFtzkYdu8FaMqzFTEcTg8sc=@vger.kernel.org, AJvYcCWfZc2vyd+HYAQ6HYfLmdQgCCmikLob54sWnQJi3b9JJW9Js+cS3liCAGg6h6R0JgsWBAOmRtu5iNdbjDPA@vger.kernel.org, AJvYcCWiWWEc4Ft2tLUI7ZgJi2/lTNCJt7ndkb7+nV8qw6ZNcKLROKKMuhUwa2xxdN9KeAz0Hyei9Mqj@vger.kernel.org
X-Gm-Message-State: AOJu0YwnURbIPrW4rFByusZ5MwKKEt2js2ve8gZZPtpnMBvgv+Gx3PHx
	PLwZ8IOqazXPl6YS2SD4TPglzKhcyZ129y5hmBj/o/7UlLcjSzr3A+Kj75FPoP4Zhrvpiwqj21S
	HHVe5FeFtEZZxQKQv1HkkZB3X6dc=
X-Gm-Gg: ASbGncsI6LUkHgmRAz7jW7KLYKRqZakgbLCCQaplwcCAQACy6ZNKF4yslwdOk7gbCnW
	3r3DOXQINn41EdV8KcXR9n0aFuBYKcMFp/gHZAk+31jbAGK3YCe8orGwKHf0mCPSv090Aq3+LY1
	YPv2jjCkQKG/l8y84/c6ZsiWx2N2JT/uPvZZJIKA==
X-Google-Smtp-Source: AGHT+IGh50s+zJtysu2S6f9XjTktMRBtIt9lP5pMNu2Xa/D/taBoYtZM0t3nGA+Oq3ZGw2IWtnMnbRD+96VEn4T3D6k=
X-Received: by 2002:a17:90b:5252:b0:309:f407:5ad1 with SMTP id
 98e67ed59e1d1-30a4e5aa540mr917882a91.14.1746132942788; Thu, 01 May 2025
 13:55:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250426160027.177173-1-mannkafai@gmail.com> <20250426160027.177173-3-mannkafai@gmail.com>
In-Reply-To: <20250426160027.177173-3-mannkafai@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 1 May 2025 13:55:30 -0700
X-Gm-Features: ATxdqUG7m5lxLrm2WirOZ_o4hAMDhe7XKZ74AQNZzGPIJbnzyR-uo9LZrBb5eSk
Message-ID: <CAEf4BzZM_SrdpjnVr9ytAm_hpAW-WEvZ2EptAqwut_1jeAmyzA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: Enable BPF_PROG_TEST_RUN for tp_btf
To: KaFai Wan <mannkafai@gmail.com>
Cc: song@kernel.org, jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, mattbobrowski@google.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, mykolal@fb.com, shuah@kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, leon.hwang@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 26, 2025 at 9:01=E2=80=AFAM KaFai Wan <mannkafai@gmail.com> wro=
te:
>
> Add .test_run for tp_btf. Use the .test_run for raw_tp.

Hm... so now you'll be able to pass arbitrary values as pointers to
kernel structs (e.g., arbitrary u64 as struct task_struct * pointer),
not sure this is a good idea...

>
> Signed-off-by: KaFai Wan <mannkafai@gmail.com>
> ---
>  net/bpf/test_run.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 8cb285187270..8c901ec92341 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -690,6 +690,9 @@ int bpf_prog_test_run_tracing(struct bpf_prog *prog,
>         int b =3D 2, err =3D -EFAULT;
>         u32 retval =3D 0;
>
> +       if (prog->expected_attach_type =3D=3D BPF_TRACE_RAW_TP)
> +               return bpf_prog_test_run_raw_tp(prog, kattr, uattr);
> +
>         if (kattr->test.flags || kattr->test.cpu || kattr->test.batch_siz=
e)
>                 return -EINVAL;
>
> --
> 2.43.0
>

