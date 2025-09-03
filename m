Return-Path: <linux-kselftest+bounces-40671-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E74B41161
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 02:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 935EE4885ED
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Sep 2025 00:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8266712FF69;
	Wed,  3 Sep 2025 00:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPPYkJHE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46A129CEB;
	Wed,  3 Sep 2025 00:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756859937; cv=none; b=C+NkcevQSEe5VJT2FQWxqQcmUIhkw9R8fAIpmEzHk31/RXDMTCaGbrbZ67QPteAQeaO/6Ry6YetzSLplc71gjks+IWEiRskLwRK3VoCNIXOaufEJ741HkAue5yAjmcCnigoPDAUa2a97XtUZTcmuIcT58f4l1akzCrabFlcLf1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756859937; c=relaxed/simple;
	bh=bQ5P0TRtfeMCqFKYa4GZQ4TLIAFW8wAzvRz7MT19Sh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RBKxefT/ICDJotfige364SQ4FBM5b7WRR9FRy51E2rZs+IMtrV5chPLvi8yDQ2nE33TtpXcw6dUlItJtrjxJcz01jmONW9dwvHPBQJ4GSwQEh6S2KvH1BDRzIFfIc7VWsOWi2xg2M26mAq5O7/LXowuaJhQthAigV9RRv5xLtHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SPPYkJHE; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45cb5e1adf7so769595e9.0;
        Tue, 02 Sep 2025 17:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756859934; x=1757464734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzaSJEDDfxV3rlsTLegpkKoIznmaYx9gbH4pD2Ij04E=;
        b=SPPYkJHEArfvzF9uIS/FxjbealpcNlkOWU8FqYlmE44CBZenkaOoJuiSIIxu02g/Vb
         bR97OFM34e81wvzdhF7T6kuz7rqjL8Cdn6D2xGJIl4q/ibJNXjrr16wgxxvP5lrPAnO1
         qcptcDxkQU7qHdUQe3d6EXOaE4lCQb6cZh6++czVrwhlECEvJp2VnOyp39tvF486uqJj
         mboZhlcVtsFOYc3exk0vaKpVSMX3t9hWmeWWfTgPKzsuodfZJKAI0B1S227tGF7t2D+Y
         rdcDOsesRbR9zPhOoDJM0dZMOAM/3ukdLDJJ+5KhebFgucUKBSVE0eNLnKcY1x1cu6hS
         pboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756859934; x=1757464734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bzaSJEDDfxV3rlsTLegpkKoIznmaYx9gbH4pD2Ij04E=;
        b=nqugKHbvOutSO0Dcc2q9+lj4NCZBrDaDeURN2QyZr2EO0zctBH7yq6BUOXcxKh4wWB
         dDDOX9/DzKbTtk8kiQb95sKMwTTjGHPEWdctdVOgm8H5X911lqvZQHYN2AjwclqAKx9o
         D1ifkc81K+Ln5Luhrvm/zoFtObS0O0igkjsysalE01uRXSU6mgd/ak4Rhn0UVYK1XYRj
         0ody4KATcGlSU6UHbyT85jI9xSqBZOF46MkziAdTNg4qNL7RnMtnk/gW70TV3A+t164G
         B8HUwiE7Qv0YTc0Uu6Ai/qj9RUsHouDxc1ona9gn3Sr8E/F5QAA6y7EbR7ulmM/u8T0a
         Jp9g==
X-Forwarded-Encrypted: i=1; AJvYcCUagLRJpBm2D83B8f9b2SeAvIw4qjZUQTr1NXEPbx2frKf8v7QQwJvlsPYBqljjA4JmL6JyquVW7l1u3UEFaVQC@vger.kernel.org, AJvYcCWB7Ncdma+mIBcunIuDQXWzHKiAV5FIKBVtlKvTLZhsWNO4chjv413uFDlAnC6Zo3Qrt8ZB8zCSApw=@vger.kernel.org, AJvYcCXEr0PZeeYObiaYrZNEmS0cZRnuPcst7Y8t+LdpnU26xvgvBWj+BOPveI5++JZIPdAV6ao=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPznU23aPqWGy7i4Lr+zOjjF6GPXXUR/qlzyhYU+6WE4KXR0K1
	RASwPHZljE1CnYfTs+LsH6LEerPhd4RaGXFLIzWvyV0eKeAhfJuxT3EywllyCCTAEgmuVWExn+r
	/Ows1ya3rYxbTe7qk962/pH8fQL2FYzg=
X-Gm-Gg: ASbGncsN+jZ5Wu+DlwneCqCrjPGnkVf6YPZSMLpFkQC8I0uLlf6kT7renzD/ltayWjp
	dFUhyDHzgwddva8X+gEAxJcJH8lZ5PHRJ2Qi607D2apG6eJimMX7ZQHBZHTjBe6z1q0UjhShcPS
	SpVndS8qQ614eO5K9HqVwYCbgDVHLKixHWYSfJwo2/0UpLQJ6HUbCidrO3MUoGaE9p+Z90lme4P
	zH4yXm8GlFp+CgosRu3oU4lgHLgLHKufWLBng55a69kbbs=
X-Google-Smtp-Source: AGHT+IGjt3Seiom+fEIKYjnNnbJm13OQMDvMA4L7fKAByybsoTA43NUC5VMhJJG7x72r0smtxjxuSVJ1TkH2cwV00rc=
X-Received: by 2002:a05:600c:3153:b0:458:bda4:43df with SMTP id
 5b1f17b1804b1-45b85570996mr139409705e9.17.1756859933744; Tue, 02 Sep 2025
 17:38:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901135609.76590-1-yikai.lin@vivo.com> <20250901135609.76590-3-yikai.lin@vivo.com>
In-Reply-To: <20250901135609.76590-3-yikai.lin@vivo.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 2 Sep 2025 17:38:41 -0700
X-Gm-Features: Ac12FXwsB0RPqWE7renRRPw-WrdvYCrmWnv4rC0XwGG-GxE2-E70WtLP8kdCAfo
Message-ID: <CAADnVQ+iazLpRWtt219MqGD0LHVoccahG=Cf1w+Ow5xOjRd_Lg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: Add selftests for cpuidle_gov_ext
To: Lin Yikai <yikai.lin@vivo.com>
Cc: Christian Loehle <christian.loehle@arm.com>, Song Liu <song@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	Linux Power Management <linux-pm@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Tejun Heo <tj@kernel.org>, zhaofuyu@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 6:56=E2=80=AFAM Lin Yikai <yikai.lin@vivo.com> wrote=
:
>
> +
> +/*
> + * For some low-power scenarios,
> + * such as the screen off scenario of mobile devices
> + * (which will be determined by the user-space BPF program),
> + * we aim to choose a deeper state
> + * At this point, we will somewhat disregard the impact on CPU performan=
ce.
> + */
> +int expect_deeper =3D 0;

...

> +/* Select the next idle state */
> +SEC("struct_ops.s/select")
> +int BPF_PROG(bpf_cpuidle_select, struct cpuidle_driver *drv, struct cpui=
dle_device *dev)
> +{
> +       u32 key =3D 0;
> +       s64 delta, latency_req, residency_ns;
> +       int i;
> +       unsigned long long disable;
> +       struct cpuidle_gov_data *data;
> +       struct cpuidle_state *cs;
> +
> +       data =3D bpf_map_lookup_percpu_elem(&cpuidle_gov_data_map, &key, =
dev->cpu);
> +       if (!data) {
> +               bpf_printk("cpuidle_gov_ext: [%s] cpuidle_gov_data_map is=
 NULL\n", __func__);
> +               return 0;
> +       }
> +       latency_req =3D bpf_cpuidle_ext_gov_latency_req(dev->cpu);
> +       delta =3D bpf_tick_nohz_get_sleep_length();
> +
> +       update_predict_duration(data, drv, dev);
> +       for (i =3D ARRAY_SIZE(drv->states)-1; i > 0; i--) {
> +               if (i >=3D drv->state_count)
> +                       continue;
> +               cs =3D &drv->states[i];
> +               disable =3D dev->states_usage[i].disable;
> +               if (disable)
> +                       continue;
> +               if (latency_req < cs->exit_latency_ns)
> +                       continue;
> +
> +               if (delta < cs->target_residency_ns)
> +                       continue;
> +
> +               if (data->next_pred / FIT_FACTOR * ALPHA_SCALE < cs->targ=
et_residency_ns)
> +                       continue;
> +
> +               break;
> +       }
> +       residency_ns =3D drv->states[i].target_residency_ns;
> +       if (expect_deeper &&
> +               i <=3D drv->state_count-2 &&
> +               !dev->states_usage[i+1].disable &&
> +               data->last_pred >=3D residency_ns &&
> +               data->next_pred < residency_ns &&
> +               data->next_pred / FIT_FACTOR * ALPHA_SCALE >=3D residency=
_ns &&
> +               data->next_pred / FIT_FACTOR * ALPHA_SCALE >=3D data->las=
t_duration &&
> +               delta > residency_ns) {
> +               i++;
> +       }
> +
> +       return i;
> +}

This function is the main programmability benefit that
you're claiming, right?

And user space knob 'expect_deeper' is the key difference
vs all existing governors ?

If so, I have to agree with Rafael. This doesn't look too compelling
to bolt bpf struct-ops onto cpuidle.

There must be a way to introduce user togglable knobs in the current
set of governors, no?

Other than that the patch set seems to be doing all the right things
from bpf perspective. KF_SLEEPABLE is missing in kfuncs and
the safety aspect needs to be thoroughly analyzed,
but before doing in-depth review the examples need to have more substance.
With real world benchmarks and results.
The commit log is saying:
"This implementation serves as a foundation, not a final solution"
It's understood that it's work-in-progress, but we need to see
more real usage before committing.

