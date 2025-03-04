Return-Path: <linux-kselftest+bounces-28218-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E7CA4E65E
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 17:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 175F31882E81
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 16:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A443829DB98;
	Tue,  4 Mar 2025 16:11:11 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7381D29DB83;
	Tue,  4 Mar 2025 16:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104671; cv=none; b=GdqCnIHwF+tGKdtpHZOLLc7VmQEsDYd7UkHcA19CoXmvrcdzAJyq0NQYcgmeWY6zXb+7EmWC9fk4c2Y8H6cuVpFXKorMja5ZqHCfPGRopDOaasY1v6o1p1i3v/7bVunHT6a0l9FxkavGxZP+JAml7b7wi4j5BgNayK7aQnGtHcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104671; c=relaxed/simple;
	bh=Q5OfRyL0oHBW1Tz9ez/ZaLR+7hn1+yu8saErb1C2CCw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ucC1SXYzZtf6XG58ox1tajIPtt3u/SWB6vNDA2JNo8BFQQk92VKhdkz7TDixd54xAMLVkcvMSLMlZsQYJuUx4lxNN0dOgmW7K4MgqWYsKy6I1hzj54r0tEUCuYuGzVi0JlpVEBGDacTWV7PQmLyLRqUxlEDmGQ5dsIGmCq+cF50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157ECC4CEE5;
	Tue,  4 Mar 2025 16:11:06 +0000 (UTC)
Date: Tue, 4 Mar 2025 11:12:01 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung
 Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers
 <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Quentin
 Monnet <qmo@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel
 Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, Jiri Kosina
 <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-input@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] tools: Remove redundant quiet setup
Message-ID: <20250304111201.59ed8cc3@gandalf.local.home>
In-Reply-To: <20250213-quiet_tools-v3-2-07de4482a581@rivosinc.com>
References: <20250213-quiet_tools-v3-0-07de4482a581@rivosinc.com>
	<20250213-quiet_tools-v3-2-07de4482a581@rivosinc.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Feb 2025 13:06:22 -0800
Charlie Jenkins <charlie@rivosinc.com> wrote:

> diff --git a/tools/tracing/latency/Makefile b/tools/tracing/latency/Makefile
> index 6518b03e05c71b4fa84498f9628adf81a38c9f56..257a56b1899f23837de533353e9c2cebdb6035bd 100644
> --- a/tools/tracing/latency/Makefile
> +++ b/tools/tracing/latency/Makefile
> @@ -37,12 +37,6 @@ FEATURE_TESTS	+= libtracefs
>  FEATURE_DISPLAY	:= libtraceevent
>  FEATURE_DISPLAY	+= libtracefs
>  
> -ifeq ($(V),1)
> -  Q 		=
> -else
> -  Q 		= @
> -endif
> -
>  all: $(LATENCY-COLLECTOR)
>  
>  include $(srctree)/tools/build/Makefile.include
> diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
> index 8b5101457c70b48e9c720f1ba53293f1307c15a2..0b61208db604ec0754024c3007db6b2fe74a613c 100644
> --- a/tools/tracing/rtla/Makefile
> +++ b/tools/tracing/rtla/Makefile
> @@ -37,12 +37,6 @@ FEATURE_DISPLAY	:= libtraceevent
>  FEATURE_DISPLAY	+= libtracefs
>  FEATURE_DISPLAY	+= libcpupower
>  
> -ifeq ($(V),1)
> -  Q		=
> -else
> -  Q		= @
> -endif
> -
>  all: $(RTLA)
>  
>  include $(srctree)/tools/build/Makefile.include
> diff --git a/tools/verification/rv/Makefile b/tools/verification/rv/Makefile
> index 411d62b3d8eb93abf85526ad33cafd783df86bc1..5b898360ba4818b12e8a16c27bd88c75d0076fb9 100644
> --- a/tools/verification/rv/Makefile
> +++ b/tools/verification/rv/Makefile
> @@ -35,12 +35,6 @@ FEATURE_TESTS	+= libtracefs
>  FEATURE_DISPLAY	:= libtraceevent
>  FEATURE_DISPLAY	+= libtracefs
>  
> -ifeq ($(V),1)
> -  Q		=
> -else
> -  Q		= @
> -endif
> -
>  all: $(RV)
>  
>  include $(srctree)/tools/build/Makefile.include
> 

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

