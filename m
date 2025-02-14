Return-Path: <linux-kselftest+bounces-26646-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C759A35B32
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 11:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEA861892CD3
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 10:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E95255E42;
	Fri, 14 Feb 2025 10:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwS8nXJA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9BE2505C2;
	Fri, 14 Feb 2025 10:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739527699; cv=none; b=AMTbZtyi7XCN1iRvFvJzxSOPGdphwKYfzFh8SVHyiimNadfuHl2ffqA1eIgQaGCm5CqRBW8VrX5QIl4g9fA+FTNvxE+aAFEH4Yy8oEmzeP+B6lUFAONI/HYvsPnCRx2QLY7yRGn1iF4lbNvgQLNA8FW8ITfeazMBa/j6zLZAZNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739527699; c=relaxed/simple;
	bh=Jogrd7O7L0fZyAc7FlJcz8HqG9ZjCfH+uLAxpQ2sT9U=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aObDIdq7kCVzPQtbNhDiuDMEa38Eqw8HPTgMJH3fAOCrguk3V1cZj0ZsdnzmCx47Uontp0OYzkubEiJMe0nrNOKCP0zu8fyN8p1iYG4LDtQnlhnUwbBN1onedZNTjOkvgURYlFZACmEwQbCN341yLgX4wED+JbPbNVuKOjdgGAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JwS8nXJA; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5df07041c24so525530a12.0;
        Fri, 14 Feb 2025 02:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739527696; x=1740132496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PK881UT06YXsyKuTqU0MnqGvntUnhpOAf0QXivCUVQA=;
        b=JwS8nXJAylYFB6CYGdNrk9l+KL+k6jl1LvFb3DGhHNjlnrp1ZjkRrPpkYHooeGkk6H
         veYqjYAurbg2SNw9Cyj8u1lnZUNQ1h5Qor4H6z0sQ2raclA3D/hvba4X1Nn2lp/Q5LlK
         EjXHSQVBAnbymOpTAqyDTlnxIBQCAA6NVOUweCjtCeS3mOkf+Mod7YVr+c53Ka1EVfpj
         BgvK64a2rLTj2naopA/xokgvilna+xIXWrDBk6PJYNSP7n4r2zlYNWr5q8wQDcoavRWQ
         mlbeMSeFtUTxT/epP52thKvgGVNehOp/2mkX/kpKhZRLhTgSvqxVzk65ectNJ4IQYxVs
         lPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739527696; x=1740132496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PK881UT06YXsyKuTqU0MnqGvntUnhpOAf0QXivCUVQA=;
        b=k6qO9ovJYrPnTePzF5uqtsisvIBjBSj+uFOMzjeXpxhHoT7MDBxh5/OWa/kDKqV/h5
         4yuRACqt0wrpWjWbJFKlYWslaMjx3rZbY42y6I9Wk+D+DSVmRxOr9IxcwpVMMy59TV9j
         hpvaoh2OaLM+pDAuaUSgD3dJTQICVsG7XMHxNuJlyOUBEvCuJ5RB8tUoQ8rVmUIo4OPz
         c6s9QTl+xPAgip/JoMSTzy0iRsX0Q/V0yqX1hfnKobWWb9Fyeio38oIvBkP+bHNMvK3K
         8P2kjT7bPwhuNDeDc6jFhmfHCuXxUnRRCGGQxN9zXV/WvUX6vBtyT2ZrDct0zOU+XL1Y
         hmRQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5ObGWxTq3O6Q+hqlQ/KmUbFa6eyJFzLnvsrNnGyA9+m1lxznePc6sbObmaMlZ1RTDSXKUgodqkzBjxThMK+tm9jh7@vger.kernel.org, AJvYcCWVmG/Eqz+0KyEgCqH0PnCi+uHmg+MXFN5tRByZqVjgfImYEgFxGWnkvlCINfzA6FlZL3k5XhDL1wcFdgs=@vger.kernel.org, AJvYcCWnSSnUNbJj4rzrunOzy28ptVtQdy6o1Wjb0ufCaW0NfBbNYBJX2Sz5w2pdXAhGxNqhBK66VET6hgnN6+MesQ46@vger.kernel.org, AJvYcCWvPkUvlh+9k6IDMXoI2jUMKF5RjVlJCWvKwM9nyg33oI2iY13CLgMwukv5XsF484W2XZk=@vger.kernel.org, AJvYcCX4Rs9h/tj+nxYAhRliR8YQLSBN4zjFAG/9VRyxSOcry5PhDKcku5fo9wGmGFTlQsA62tDduUB6NzE8nw5QwuEY3A==@vger.kernel.org, AJvYcCXH1aMSiGO0gzSKKpFqx5hy571KmA7mvHpK9Zo3/HMI5vJR+SCuzy6zQy5pnS5dpvr96Vo7n/KBL4I=@vger.kernel.org, AJvYcCXyREquk7YhI8rtD5ORCdlOYd0P/YHmVfEbpqKbkVuBQHJGlcIfz28IADOE1/Kb2Ksb2t77FUCAjex1HIvu@vger.kernel.org
X-Gm-Message-State: AOJu0YwKn/DWsz9nGJ49EMr4qjGzAvusowzPO9Wo3LxG7JucMndGg/kW
	Cr+69FXxSdoZzNbVrv8S2PBGntSIaigPqedwtMh37c3BSpX2InbQ
X-Gm-Gg: ASbGnctjLX8oQ9BRgk+soUDkzQula6M/uGbOmsAZZFj9OWVmFoR8IPKk18/nL0VOFBs
	W0tb8nufufyOADI8s2b6dmTuIEFuhIvrRbkBqn1kppmYxoz/ommmYaIrnZnR/mjtIVP/Uv/Ia52
	w4qrtGyM1yjKbJQTy5HX965e+3IehI8DELwsX2FVL98JD/Hwj3yurO6ufScoub9j/SkKaCbMXKL
	Vp7Lo+SjNWfNc2pgKmBwZvPCKjU9ynBFShNC1SWjySl6311FPHjO6Df5Qn/RJrQ+JGyGaEdKmdh
	ZA==
X-Google-Smtp-Source: AGHT+IHfUA9MbFKK0cGZxcq1fnHrJJMJoWr8y/oBmtSB3GGdubTXz3Fdqd2b5Ipl+F4XZpRsok2xqA==
X-Received: by 2002:a05:6402:4616:b0:5dc:d8e6:62a7 with SMTP id 4fb4d7f45d1cf-5deadd84b7bmr9556320a12.14.1739527695955;
        Fri, 14 Feb 2025 02:08:15 -0800 (PST)
Received: from krava ([173.38.220.59])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1c43a0sm2672253a12.28.2025.02.14.02.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 02:08:14 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 14 Feb 2025 11:08:10 +0100
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Quentin Monnet <qmo@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-input@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] tools: Unify top-level quiet infrastructure
Message-ID: <Z68WCtRqdrgqC5iN@krava>
References: <20250213-quiet_tools-v3-0-07de4482a581@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-quiet_tools-v3-0-07de4482a581@rivosinc.com>

On Thu, Feb 13, 2025 at 01:06:20PM -0800, Charlie Jenkins wrote:
> The quiet infrastructure was moved out of Makefile.build to accomidate
> the new syscall table generation scripts in perf. Syscall table
> generation wanted to also be able to be quiet, so instead of again
> copying the code to set the quiet variables, the code was moved into
> Makefile.perf to be used globally. This was not the right solution. It
> should have been moved even further upwards in the call chain.
> Makefile.include is imported in many files so this seems like a proper
> place to put it.
> 
> To: 
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
> Changes in v3:
> - Add back erroneously removed "silent=1" (Jiri)
> - Link to v2: https://lore.kernel.org/r/20250210-quiet_tools-v2-0-b2f18cbf72af@rivosinc.com

Reviewed-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> 
> Changes in v2:
> - Fix spacing around Q= (Andrii)
> - Link to v1: https://lore.kernel.org/r/20250203-quiet_tools-v1-0-d25c8956e59a@rivosinc.com
> 
> ---
> Charlie Jenkins (2):
>       tools: Unify top-level quiet infrastructure
>       tools: Remove redundant quiet setup
> 
>  tools/arch/arm64/tools/Makefile           |  6 -----
>  tools/bpf/Makefile                        |  6 -----
>  tools/bpf/bpftool/Documentation/Makefile  |  6 -----
>  tools/bpf/bpftool/Makefile                |  6 -----
>  tools/bpf/resolve_btfids/Makefile         |  2 --
>  tools/bpf/runqslower/Makefile             |  5 +---
>  tools/build/Makefile                      |  8 +-----
>  tools/lib/bpf/Makefile                    | 13 ----------
>  tools/lib/perf/Makefile                   | 13 ----------
>  tools/lib/thermal/Makefile                | 13 ----------
>  tools/objtool/Makefile                    |  6 -----
>  tools/perf/Makefile.perf                  | 41 -------------------------------
>  tools/scripts/Makefile.include            | 30 ++++++++++++++++++++++
>  tools/testing/selftests/bpf/Makefile.docs |  6 -----
>  tools/testing/selftests/hid/Makefile      |  2 --
>  tools/thermal/lib/Makefile                | 13 ----------
>  tools/tracing/latency/Makefile            |  6 -----
>  tools/tracing/rtla/Makefile               |  6 -----
>  tools/verification/rv/Makefile            |  6 -----
>  19 files changed, 32 insertions(+), 162 deletions(-)
> ---
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> change-id: 20250203-quiet_tools-9a6ea9d65a19
> -- 
> - Charlie
> 

