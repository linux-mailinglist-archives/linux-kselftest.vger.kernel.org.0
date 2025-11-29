Return-Path: <linux-kselftest+bounces-46731-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AC8C94601
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Nov 2025 18:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 568453A4ECF
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Nov 2025 17:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110D7238C3A;
	Sat, 29 Nov 2025 17:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjiZmaza"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B4F1DE8AD
	for <linux-kselftest@vger.kernel.org>; Sat, 29 Nov 2025 17:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764438379; cv=none; b=m9d1S5S5l7ddrXu+LIVXvaZ8QGl5TCUTwFd2BjwfyzspcKL5wHEE8TvnPcv+ho6ylUOEpANyA5DfTENI/k2U4GgXL2qNuMrRUreI3cN4CQEpckEkvU2pZ3Oa4hBM5FpkYT7DHzRnX09Z7FSIA9v0BTBPtiCWKqqmZ1iiIp1esGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764438379; c=relaxed/simple;
	bh=+e/eZVcBB28RWBlJln+qbh3+2ENwV4DxayEE9vzJnzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SkKo5ycFnL3Lf0fUPSFgUrPIhvYXCBRJOJGqx4eoV3WwOYqhRbc061+0hgA4uZTxJsKi7kXjDxxblVWAYQAaaYiXloaWo/z/TUisAQB9hHFVUqOP3+4H5DOGO+akmMzH6dVN1bcyAMAXUWzOaqt9e/B4FjnxRU15FzZkQyI4+hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjiZmaza; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42b38693c4dso989414f8f.3
        for <linux-kselftest@vger.kernel.org>; Sat, 29 Nov 2025 09:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764438376; x=1765043176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BK02Gj40Ipgon+FYL3/xxXrC+aefU7VF2fGvgYnZiE=;
        b=VjiZmaza1f1OtIgRp+ArIxhegXwJ9nnF/W5I1rlZAwALsNhPusCeWNRgdMslPeh3TG
         PqpyCrydvu/olSgPEr9NuoxaCaxGcnErZzH0RVRrSpqRYqgOjS5glH/ULP1oULBiBiQe
         61uCz52zzv8RYGJawzuE83tNWsO2HzN8tllupmsgOwRjvmWQ4PguyAPGRRu9buwBcVP0
         cloKF2Jy7cyntVkRoPEuNLM3za4/5F86Pz/zOkERyyRt+kgdwd3J79GnOH8Dyn7sLWjf
         6zUfb6hmxfM1u/YokR4tZ3oGT9w5KUrWBRi38tgfVhutLv4KecXCAtR+O2yeq534Sjbe
         HXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764438376; x=1765043176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6BK02Gj40Ipgon+FYL3/xxXrC+aefU7VF2fGvgYnZiE=;
        b=cgdMAX3M1DYf4S7Y3Yw7gBmWZrSAR1s/64hJpyNoQpni7xL9QeNYsv0EmX2AHT8q3t
         M3XVArUSFh6buB4o46WkLdx0MU8A7x6EFikjRrMgWXgwoYVgLFN2iEdE6Q5SGdR2s7CT
         z+jte9L7aZUK7USjcLWP+x5/xWc0SZqi82UB0bhyu+9h3pGDCpAck3VcFp2iEFJfj1Fg
         +SPJ1gzz7j5jMArPLX7Wd3HYOlGl9Z3vCmT+530gJdqE5G8o6LDliFfqMgUIGj1ahMcx
         7/G4bm8y3IisAVFJhytdaaHxtLjr/476uCMp7xVdaXZJiJ0DUeZ2B/VMg4v6WlMuD5W9
         /y7A==
X-Forwarded-Encrypted: i=1; AJvYcCUvOcynXBZdAJ/i6vO7Hb8244mqew7rrbma7/VxJ//u0cVu+y8tWZIJcDggzc2evTvyfig0qsleHf0sS6As4d8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcU+lgKY1Axb67IhzPDuHuv1QaUqMeai/G8XCRL0cM7qCnsAPb
	feMWxD5WF7g7vHptIIjGvBCyD10yudQpGXSIPZiADMV7eUbo7+moihm0wQWph0Purz2h+2BsKVJ
	c22rnWkqhUzPpOSG/TxeRCTAFFSXl2FQ=
X-Gm-Gg: ASbGncvfd+cpFb2YVVkwuQgo53rxlIxOx/dzOmjo6xY6iggxhDWQWzbLBhAr6xmKUt4
	WbQYA+00pSMQBqwYYWL8tv2Dnd0oUquwsLWzvwj8AsblDcV8bEgwqgEcpillBx2qbBYmxiRFzjJ
	WQpk3OUm6NFUelbkhNe/ngXc5pyHotoq6VuzV448Q4Gy9K02ZKs20zzEZ8MY2Xp6LejxbG7HH1O
	5rTB4xFft+nf1783xXTnHlo+fsoleAywgUSHYzWBkpaL+bwGXUZUaWeCpsXPkwtQ23zju0=
X-Google-Smtp-Source: AGHT+IHi1EbPf2XcnNw/AZkQD5V0ZbEdgvu62N6xh7tmRZOCg2d2WNmqL/C3biu5rz5gjBEJUclo/rhyLXl7TZKh2Mc=
X-Received: by 2002:a05:6000:1841:b0:42b:3b4c:f411 with SMTP id
 ffacd0b85a97d-42e0f344618mr20683071f8f.36.1764438375594; Sat, 29 Nov 2025
 09:46:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128-tc_edt-v2-0-26db48373e73@bootlin.com>
In-Reply-To: <20251128-tc_edt-v2-0-26db48373e73@bootlin.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 29 Nov 2025 09:46:03 -0800
X-Gm-Features: AWmQ_bmz9kT8GjYleiR944RQKTsQjsoQlx-W1ouMgequGe9jw4vXqwmEa8sY5To
Message-ID: <CAADnVQJwjFcZ8Uz_WZrhrh6QEOHHNsVt7ARQRR8iL2O9DhREpw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/4] selftests/bpf: convert test_tc_edt.sh
 into test_progs
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, ebpf@linuxfoundation.org, 
	Bastien Curutchet <bastien.curutchet@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 2:27=E2=80=AFPM Alexis Lothor=C3=A9 (eBPF Foundatio=
n)
<alexis.lothore@bootlin.com> wrote:
>
> Hello,
> this is a (late) v2 to my first attempt to convert the test_tc_edt
> script to test_progs. This new version is way simpler, thanks to
> Martin's suggestion about properly using the existing network_helpers
> rather than reinventing the wheel. It also fixes a small bug in the
> measured effective rate.
>
> The converted test roughly follows the original script logic, with two
> veths in two namespaces, a TCP connection between a client and a server,
> and the client pushing a specific amount of data. Time is recorded
> before and after the transmission to compute the effective rate.
>
> There are two knobs driving the robustness of the test in CI:
> - the amount of pushed data (the higher, the more precise is the
>   effective rate)
> - the tolerated error margin
>
> The original test was configured with a 20s duration and a 1% error
> margin. The new test is configured with 1MB of data being pushed and a
> 2% error margin, to:
> - make the duration tolerable in CI
> - while keeping enough margin for rate measure fluctuations depending on
>   the CI machines load

Applied, but it's still a bit flaky in my setup.
Fails like this from time to time when run in parallel with other tests:
run_test:FAIL:rate error is lower than threshold unexpected rate error
is lower than threshold: actual 6 > expected 2
#450     tc_edt:FAIL

