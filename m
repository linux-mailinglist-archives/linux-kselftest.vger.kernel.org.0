Return-Path: <linux-kselftest+bounces-40488-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC17CB3EC52
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 18:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A07131A88311
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 16:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98903064B0;
	Mon,  1 Sep 2025 16:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KP168jN4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E8530648E;
	Mon,  1 Sep 2025 16:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756744622; cv=none; b=V7NzvYTRP+hUDsqq0rqkO3msFHyICmoZOGoqGYcVs0MGt6c3s0shudXnoL9tWhTbZMtoEZl9bE3CNaJzvKq0ZgTbqd870x655LtoGBVtYSuO/6bmQXIfafjmWtj7wp2akKhczy75x/bH8VPaubOHeYwDNCjSo2l9r062a9sErHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756744622; c=relaxed/simple;
	bh=i8e2hhakaEQf5OLmJ6uWXZT1fOlmqpZkOTJjZr8G0Tk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WqheXwSZldQGWEodMqHVARWenS8frRkpeCLSmu11/vMFPjFgJDN8wiJpOT5vJ+Mok6FAZjMGSdc94dtbpjScabx7+mkSVZAE5jb7WSwzgqIDorv1cqBpXOzzM3omUefNMQKtmigblUnfLc6ryY4/SBqVHa66e1ycz2YhrV+bVe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KP168jN4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EED3C4AF09;
	Mon,  1 Sep 2025 16:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756744622;
	bh=i8e2hhakaEQf5OLmJ6uWXZT1fOlmqpZkOTJjZr8G0Tk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KP168jN4rZJEJPbgaO5PDKuNsWaa9NlvUXkTLz+SnzCBy24KyZwmnWwG6ZcwWUMIx
	 gHTVLIvkMXo0hjeqCDF8bjvxMqVv72D5OXG0hRV8Si11NqKAJqYKTCkFxOoJ7CkmbU
	 pAGPpCxATLTSRdncNKBOJKDcY6nw21viFvMFzISy3oeYwIqkfFxMFAlpK2Fiv+V1jA
	 hP3Iu/xqWNF7MLpl8/gxAbNUDtCTep6x9GC/DwGBqHjK/VYW3yw2FqTAcgnXvZ2UwK
	 X/4V0pr0w7vSbR63VJ3xdhAQNSh2YMgTqQqKxwjfi9z4Hu6UU9aMwDCDVeNhtNq1f6
	 eroY+DjG9+LCQ==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-61e482e1857so211255eaf.2;
        Mon, 01 Sep 2025 09:37:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVDOdopAfSDaDo6dEAiyUCA3xZLnj6IUA7c86Ww9z4wpYzWHLxGinGEn997zhxOXG0YG7eXxXor/Nc=@vger.kernel.org, AJvYcCWV7t4VcoouN1AdKNXuKCu0bANHAcQoLrPBjVCnSyUx1hsn6kM4Oguk4vAkpYzQoR4z/eg=@vger.kernel.org, AJvYcCXh7J4Qpbl//LZ8ajiKIHAm5CfP3Cwo7drDLMeI2VkGvQXqZ0xpwlXp7HlcewJFD2FrpqwrtKXkMiavBvEcVNoJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxZIoHnaVVLqcBZZb3g+9plN6yNn0LCWnCusRHZ5FEDOCvdSEU/
	kbwDfl+I2a3RHcNi0FwhgQIMKBS9esodHr/o1NJ04tnDLA5kZe/bIDQ1X04Q38fkIx2Q4kU/5SF
	UcRA3ayf5owObROW2xT9d6+jOdrbq55E=
X-Google-Smtp-Source: AGHT+IGyJisejWOtlN8sqPPQ5pt3qfI/9XoFwmKAFG+q+trpXLSUKt2IawCcQA2riQpDDzA9gbjHxT/z1934KnXfM1E=
X-Received: by 2002:a05:6820:548:b0:61d:a30b:7d5b with SMTP id
 006d021491bc7-61e3370f7e0mr4255143eaf.4.1756744621429; Mon, 01 Sep 2025
 09:37:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901135609.76590-1-yikai.lin@vivo.com>
In-Reply-To: <20250901135609.76590-1-yikai.lin@vivo.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 1 Sep 2025 18:36:49 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hvbirsez==k1g9QEQ9k38OYihwsaDELi0DnO6gLY295w@mail.gmail.com>
X-Gm-Features: Ac12FXwm0_uCuz12fmd8RmTWliF_IZiZIkE2yAYFT2GXsIRzF2hqCAv2RMpT-Wo
Message-ID: <CAJZ5v0hvbirsez==k1g9QEQ9k38OYihwsaDELi0DnO6gLY295w@mail.gmail.com>
Subject: Re: [PATCHSET V2 bpf-next 0/2] cpuidle, bpf: Introduce BPF-ext
 cpuidle governor policy via struct_ops
To: Lin Yikai <yikai.lin@vivo.com>
Cc: Christian Loehle <christian.loehle@arm.com>, Song Liu <song@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-pm@vger.kernel.org, bpf@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	zhaofuyu@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 3:56=E2=80=AFPM Lin Yikai <yikai.lin@vivo.com> wrote=
:
>
> Changes in v2:
>  - Optimized the logic in descriptions. (Song Liu)
>  - Created a new header file to declare kfuncs for future extensions incl=
uded by other files. (Christian Loehle)
>  - Fixed some logical issues in the code. (Christian Loehle)
>
> Reference:
> [1] https://lore.kernel.org/bpf/20250829101137.9507-1-yikai.lin@vivo.com/
>
> Summary
> ----------
> Hi, everyone,
> This patch set introduces an extensible cpuidle governor framework
> using BPF struct_ops, enabling dynamic implementation of idle-state selec=
tion policies
> via BPF programs.
>
> Motivation
> ----------
> As is well-known, CPUs support multiple idle states (e.g., C0, C1, C2, ..=
.),
> where deeper states reduce power consumption, but results in longer wakeu=
p latency,
> potentially affecting performance.
> Existing generic cpuidle governors operate effectively in common scenario=
s
> but exhibit suboptimal behavior in specific Android phone's use cases.
>
> Our testing reveals that during low-utilization scenarios
> (e.g., screen-off background tasks like music playback with CPU utilizati=
on <10%),
> the C0 state occupies ~50% of idle time, causing significant energy ineff=
iciency.

I gather that this is based on measurements taken on ARM-based
platforms because for x86 it is demonstrably not true.

> Reducing C0 to =E2=89=A420% could yield =E2=89=A55% power savings on mobi=
le phones.
>
> To address this, we expect:
>   1.Dynamic governor switching to power-saved policies for low cpu utiliz=
ation scenarios (e.g., screen-off mode)
>   2.Dynamic switching to alternate governors for high-performance scenari=
os (e.g., gaming)

All of this can be done without using BPF at all, so why use it here?

