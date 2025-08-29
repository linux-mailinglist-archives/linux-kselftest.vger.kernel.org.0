Return-Path: <linux-kselftest+bounces-40341-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BDEB3C387
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 22:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 774CC1CC4161
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 20:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B90118BBAE;
	Fri, 29 Aug 2025 20:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYw0945C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8D1BA4A;
	Fri, 29 Aug 2025 20:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756497635; cv=none; b=vDXMeE+305uEbWo7Xos4E3XpkhhiuRPHqf5Z/19C7D4xLbEb1XBvElu+KbdFuOK1d9y9tVL5Jxi2WK6VZmgt9nhrvEYhJke+nSg2mv9TvQdHjXUJQuD3vAdBvsQQl/dMHWMQM2ZhjZREH0E/Mg4w6JbeqT/ALptHqfCqUo5G400=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756497635; c=relaxed/simple;
	bh=tGu1dFZlkUH2ZlwJr+5eUr2YBcteUSsRt+nkTR5xzCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AwJe4JKwRraOiUwH2v1lVTO+vapohE6SyPKL797mwej74y0/fEAhc9E2AEAmMkHQSuYvcwqykYhzGbuCBqatHAM8Bs5gfC7flijts8oyh+v2ry84bALcNQvIMkzTmX1m7Y9iKa3qNRlgF4BoxqvWqpHTVdSEqabOa+0eHXzvajU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYw0945C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BDDC4CEFC;
	Fri, 29 Aug 2025 20:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756497634;
	bh=tGu1dFZlkUH2ZlwJr+5eUr2YBcteUSsRt+nkTR5xzCI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FYw0945CI6hNsF5qwPXnooPMYvne0iLlVEJyLR/IlhFArD8zid0Ek6XJqpakXnYGE
	 Obyvv0sBS8RQGyaqnISGwN54cz7ETvvTPWYbc2oscIDuWzp+vSn8WzjRX2r0U9khjs
	 0YaTchuuUfC/UI/zbEreTrY5rcU4ar9VrqX+z3saV0ZzSwf91qCORSljdhAicBt8af
	 ZUClTkCBu88X0xdAzbxP7L/frrLjJvStjj2iUl4fyaH+xZ4hDox2NJsEIzxvvUKa7P
	 lNtXFOsc6vsDSvbgzSjHRPc7hiliJ465jHzXE1gwWYjr5sjRJznT4lMuFcc7ucY1au
	 56NmHl8qEqtIg==
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7f6f367a248so225132785a.3;
        Fri, 29 Aug 2025 13:00:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUqmBSbKeJk0L1NLuZvAW1hrFrEBW7kRrnRQi9NDV0zWw9T2MlrrlRngStc2ERQcI1nYz0VS6C8V3Q=@vger.kernel.org, AJvYcCVMpSlcvV1fU02opLeXAMXuk+y4DSUrDFkYo2CH7QLaoUTGy5GvF92cif1FBOud6w/ducw=@vger.kernel.org, AJvYcCXqq1BLLahQWozYT4F/tYO/78c/yHEarMsnL1W9klq6wZbGhErX4WTzq8FJaR4aMfDNTUs6UnHDLziYArFe3ku4@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4wHCH6Wbb4RB8PksqNQP53vkqsTnRW/BJ+BfjK1OMSKsYI0xN
	tE+bs+rfpt8J1W1Jpexk28qGMeSxBt5i8HakqVE3Rwc0nd4Cq8W7c0GbtdTwnA5BYHuu93bMQWs
	21y4Vn+a63j6fHInrbDIzYNcQCiiXVzk=
X-Google-Smtp-Source: AGHT+IHSBIsmxfB4wv0PbjBr9gp8OWigJMigqz+UbJ6LHPcpZ51he76LgiFBpO638pBpXDbTOHsOwY0AxaBuMJZKs/k=
X-Received: by 2002:a05:620a:318d:b0:7e8:3430:dd31 with SMTP id
 af79cd13be357-7ea1107efa3mr3192577685a.59.1756497633622; Fri, 29 Aug 2025
 13:00:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829101137.9507-1-yikai.lin@vivo.com>
In-Reply-To: <20250829101137.9507-1-yikai.lin@vivo.com>
From: Song Liu <song@kernel.org>
Date: Fri, 29 Aug 2025 13:00:21 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4PGfmFnJ-huFFELRQDJ7SpgWOLxYVBhRtsZnsLZhB6rw@mail.gmail.com>
X-Gm-Features: Ac12FXyKOSVX7PJ0uvfGlANZIBgd5lQ9Wdk5Tk9y48U--lJ0AkCGPKEND7MCduM
Message-ID: <CAPhsuW4PGfmFnJ-huFFELRQDJ7SpgWOLxYVBhRtsZnsLZhB6rw@mail.gmail.com>
Subject: Re: [PATCHSET V1 0/2] cpuidle, bpf: Introduce BPF-based extensible
 cpuidle policy via struct_ops
To: Lin Yikai <yikai.lin@vivo.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
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

Hi,

Thanks for the patchset.

Some logistics:

1. Please prefix future patches properly with "bpf" or "bpf-next", for exam=
ple,
[PATCH v2 bpf-next 1/2].

2. Please be specific with the patch title, i.e. "selftests/bpf: Add selfte=
sts"
should be something like "selftests/bpf: Add selftests for cpu-idle ext".

On Fri, Aug 29, 2025 at 3:11=E2=80=AFAM Lin Yikai <yikai.lin@vivo.com> wrot=
e:
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
> Reducing C0 to =E2=89=A420% could yield =E2=89=A55% power savings on mobi=
le phones.
>
> To address this, we expect:
>   1.Dynamic governor switching to power-saved policies for low cpu utiliz=
ation scenarios (e.g., screen-off mode)
>   2.Dynamic switching to alternate governors for high-performance scenari=
os (e.g., gaming)
>
> OverView
> ----------
> The BPF cpuidle ext governor registers at postcore_initcall()
> but remains disabled by default due to its low priority "rating" with val=
ue "1".
> Activation requires adjust higer "rating" than other governors within BPF=
.
>
> Core Components:
> 1.**struct cpuidle_gov_ext_ops** =E2=80=93 BPF-overridable operations:
> - ops.enable()/ops.disable(): enable or disable callback
> - ops.select(): cpu Idle-state selection logic
> - ops.set_stop_tick(): Scheduler tick management after state selection
> - ops.reflect(): feedback info about previous idle state.
> - ops.init()/ops.deinit(): Initialization or cleanup.
>
> 2.**Critical kfuncs for kernel state access**:
> - bpf_cpuidle_ext_gov_update_rating():
>   Activate ext governor by raising rating must be called from "ops.init()=
"
> - bpf_cpuidle_ext_gov_latency_req(): get idle-state latency constraints
> - bpf_tick_nohz_get_sleep_length(): get CPU sleep duration in tickless mo=
de
>
> Future work
> ----------
> 1. Scenario detection: Identifying low-utilization states (e.g., screen-o=
ff + background music)
> 2. Policy optimization: Optimizing state-selection algorithms for specifi=
c scenarios

I am not an expert on cpuidle, so pardon me if the following are rookie
questions. But I guess some more detail will help other folks too.

1. It is not clear to me why a BPF based solution is needed here. Can
  we achieve similar benefits with a knob and some userspace daemon?

2. Is it possible to extend sched_ext to cover cpuidle logic?

Thanks,
Song

