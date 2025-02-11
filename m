Return-Path: <linux-kselftest+bounces-26270-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C56A5A2FEAB
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 01:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66F091666EB
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 00:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24CD2CA8;
	Tue, 11 Feb 2025 00:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bo6HhKy4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A7D380;
	Tue, 11 Feb 2025 00:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739232064; cv=none; b=ia2sn+vLnJ1BGnIbMKPUkyz9SogH+1WNXwF0rCLt3FHk+Qn/oQCQ0KKxwaVAyAYvLtenOrcGxP7GIkWlchgA0f+9uzTLc2IzrUQinDXw5PS4O5OJKdpXSrU/FUhVror136OgMq52jnbnBe3s0mx3EDaYwBFfXWeLXRr8wAIXyYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739232064; c=relaxed/simple;
	bh=KJAXYKFfcDTkKPOe7RLg/h85JfAGZ7OLrRd3HvGoHPo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rVp6f8oNEkdAOKEuOK/QYyVuSl2PWPl2Wq0jDzbAQojPiMmCxVGOUbKnmYrCpx8MMn1xMfjtWrYzlM3oM42IA1f1DV/lS12+GJ4p75d5shUW9wceqxJQth64dpTNGtxY4x4BcpMNQxhwiHWBILcFL/CgPTXvXPK2sFAbNvezRfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bo6HhKy4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EACA0C4CED1;
	Tue, 11 Feb 2025 00:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739232063;
	bh=KJAXYKFfcDTkKPOe7RLg/h85JfAGZ7OLrRd3HvGoHPo=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=Bo6HhKy4FsJamOKzCtjqK8uo3ZdPNN7akmZSAOEg1QBxFGF+Ia49S7UgP5MLfHEw6
	 VV13dCI0D8/e+E3yeKI7FJknC423IhA3c+FCZMiuXff703v5eLHiF+vI+WrSf6uV/Z
	 E4GRMlzSd17XEfk39LXUf8ByV/zJydc+A7dQkD9nFG1g0yTm47zdcqcPbN+1LxXaAD
	 xLEbWuk6mUpoG0mikMzcpi58EbTNuqx5ozW/aIUDnR2AL86oA4ZOx9MYiUj1S7PpHM
	 Ywl98ZAAtikOMJ1qz9yTuXtvfoM0Vg+UhFXqGMJpzuAsVLPrKkAyYr8jYReK+/cMjD
	 kT8e776dGaSjA==
Message-ID: <21f98687-f715-449c-86f0-c095ea499450@kernel.org>
Date: Tue, 11 Feb 2025 00:00:49 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH v2 2/2] tools: Remove redundant quiet setup
To: Charlie Jenkins <charlie@rivosinc.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-input@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20250210-quiet_tools-v2-0-b2f18cbf72af@rivosinc.com>
 <20250210-quiet_tools-v2-2-b2f18cbf72af@rivosinc.com>
Content-Language: en-GB
In-Reply-To: <20250210-quiet_tools-v2-2-b2f18cbf72af@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-02-10 10:34 UTC-0800 ~ Charlie Jenkins <charlie@rivosinc.com>
> Q is exported from Makefile.include so it is not necessary to manually
> set it.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  tools/arch/arm64/tools/Makefile           |  6 ------
>  tools/bpf/Makefile                        |  6 ------
>  tools/bpf/bpftool/Documentation/Makefile  |  6 ------
>  tools/bpf/bpftool/Makefile                |  6 ------
>  tools/bpf/resolve_btfids/Makefile         |  2 --
>  tools/bpf/runqslower/Makefile             |  5 +----
>  tools/lib/bpf/Makefile                    | 13 -------------
>  tools/lib/perf/Makefile                   | 13 -------------
>  tools/lib/thermal/Makefile                | 13 -------------
>  tools/objtool/Makefile                    |  6 ------
>  tools/testing/selftests/bpf/Makefile.docs |  6 ------
>  tools/testing/selftests/hid/Makefile      |  2 --
>  tools/thermal/lib/Makefile                | 13 -------------
>  tools/tracing/latency/Makefile            |  6 ------
>  tools/tracing/rtla/Makefile               |  6 ------
>  tools/verification/rv/Makefile            |  6 ------
>  16 files changed, 1 insertion(+), 114 deletions(-)
> 


[...]


> diff --git a/tools/bpf/bpftool/Documentation/Makefile b/tools/bpf/bpftool/Documentation/Makefile
> index 4315652678b9f2e27e48b7815f3b9ddc70a57165..bf843f328812e10dd65a73f355f74e6825ad95b9 100644
> --- a/tools/bpf/bpftool/Documentation/Makefile
> +++ b/tools/bpf/bpftool/Documentation/Makefile
> @@ -5,12 +5,6 @@ INSTALL ?= install
>  RM ?= rm -f
>  RMDIR ?= rmdir --ignore-fail-on-non-empty
>  
> -ifeq ($(V),1)
> -  Q =
> -else
> -  Q = @
> -endif
> -
>  prefix ?= /usr/local
>  mandir ?= $(prefix)/man
>  man8dir = $(mandir)/man8
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index dd9f3ec842017f1dd24054bf3a0986d546811dc4..6ea4823b770cbbe7fd9eb7da79956cc1dae1f204 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -7,12 +7,6 @@ srctree := $(patsubst %/,%,$(dir $(srctree)))
>  srctree := $(patsubst %/,%,$(dir $(srctree)))
>  endif
>  
> -ifeq ($(V),1)
> -  Q =
> -else
> -  Q = @
> -endif
> -
>  BPF_DIR = $(srctree)/tools/lib/bpf
>  
>  ifneq ($(OUTPUT),)


This is OK from bpftool's side, the GitHub mirror has a Makefile.include
included from both main and doc Makefiles, and where I can move this
definition.

Acked-by: Quentin Monnet <qmo@kernel.org>

Thanks

