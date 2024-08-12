Return-Path: <linux-kselftest+bounces-15161-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB4E94EBA0
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 13:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6259B1C20CFB
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 11:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B92171E7C;
	Mon, 12 Aug 2024 11:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWaFTBCr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDA014D6FE;
	Mon, 12 Aug 2024 11:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723461161; cv=none; b=QngWUIt/3lKnmTeuswF7k4oNqoMXzg/UcpVuefMHAgl+sgVeJ7XRp8UiwaWy7Bm7wYGpVVbFq4nOFrmAxXE3LaW6X/AhLypEsYxW3Mu5SsBZ+IMPFGxYbuxtmnhkXhlsFX3YY0Exc6hSQw01k0IkZDVCPG1EfbY29g9iqaxK6T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723461161; c=relaxed/simple;
	bh=8gzxHnC8TW+palX3fTsK8NO/D2daZzFDQ3tyaoGvrFY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlJWnJYolsal4M7tZCXjHDXmtMKGiDeU9DMIs43o7A7VqJJGLnhDK6stUQY8JdHtTjaJWFfdOLxNZt0IqatpsjR2RMRGpIz5+vPbmlUhK3kT4g0LwcDoLQZtGsqOAns8SQSv7oSjwyzzekD75c1x01FA//nhHO4LKta312gJcHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWaFTBCr; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5b01af9b0c9so4389635a12.3;
        Mon, 12 Aug 2024 04:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723461158; x=1724065958; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X0KgYFZyfKhyz9YZWOWythgKk/bxgs+baFLpJbQtejY=;
        b=KWaFTBCrTnYIKf6yjHT5O4kEfNZEWOwj16/aP+gQBqDSPVEOwyZ9qwbpEuJwFtNBf3
         7A43hs9MrGON/g78t3mNU3l1VltckDnELIdGPXBkjKfYMb5FtyGJQvwdGsgEN+R8O/FJ
         uB3LBdjPfxZ87aX6ExltkZTgMQmmZ/QT+kVm3sCZh9dCDUbglY9ChcZNfr8+89VIAcm5
         FX6nNiXgY/uKRzozlLvREJNQI35RE5NV7VqsB/2qEVqcTzRCYgw44MGpx3ERe/2UKdbQ
         R8sn2DNyQNpDSVlkTpwp5369ezlrCy2zMa0mH0Nr8sU0WOTNNkDN+T0QqhvI2xnuT8jL
         S+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723461158; x=1724065958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0KgYFZyfKhyz9YZWOWythgKk/bxgs+baFLpJbQtejY=;
        b=FT+6WqcrVhb6QUPnTPhceXXs8QjfRCj5akX7F9r+v72XSBowD41NV3DXm0ev7NN8kL
         ikS+q0d/FnAupElHTQhlNlTvDhhttMWt7V+XQ6xg1GAPTzCEUjVsOe0xldxCGv0ORoQ4
         xwRlH0sq+wi9zfqPHuw5rjPQXAuUZVHexYrSMAzeOqbHH5kEmuuegYD3sIz4VHsmYrgd
         cLSoaaqI9x+GAgcZOZGTAuDcTY+OTO8kohN8Aip64Q8JX938PpkbPMcNpbAUwMClYePx
         wcS/jnydC5TQC6ZcQ7gBx06Py54vHMwHUciUKDkqeVDcUfSW4XkeI29HjQaLng5cIWUS
         PjGw==
X-Forwarded-Encrypted: i=1; AJvYcCVRTeFbCjFgIUwlJEmmZpT2chr9MGw1yaa+94cyySyZSaKuGHi3QhC99WCv1rQ3wVQdVmE8IoL+bKljtb21Ih3i1du0WGAmEoUhCi1xADPKoevHmJ1F7XEzAAADubI7DhoODfHmhq2ct/UM8OKF8OejHlUMIaaPTgYsWFe8
X-Gm-Message-State: AOJu0YwsUPOOet8kx2FMYucFi8+5mnNf6+SiPVXGgXcjlLz6tAaxHWCQ
	dvvSrYxFYGAqgiVS+k+dV7vEUxniMPfweXRbX55AsFA95pKGIadR
X-Google-Smtp-Source: AGHT+IH66lieLVA5Dmdz6L9GXlFt8BBHmuVzvvUH+Z76vmR5aUmhxrDOmCg/5/VMCLTEMAgclXgoJQ==
X-Received: by 2002:a05:6402:2792:b0:5a2:8f7d:aff6 with SMTP id 4fb4d7f45d1cf-5bd0a5bdc65mr7250763a12.17.1723461157416;
        Mon, 12 Aug 2024 04:12:37 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd1a5e074csm2003728a12.67.2024.08.12.04.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 04:12:36 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 12 Aug 2024 13:12:34 +0200
To: "Daniel T. Lee" <danieltimlee@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>, Yipeng Zou <zouyipeng@huawei.com>,
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [bpf-next 2/3] selftests/bpf: add rename tracepoint bench test
Message-ID: <ZrnuIgIMjNp1HARW@krava>
References: <20240812004503.43206-1-danieltimlee@gmail.com>
 <20240812004503.43206-3-danieltimlee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812004503.43206-3-danieltimlee@gmail.com>

On Mon, Aug 12, 2024 at 12:45:02AM +0000, Daniel T. Lee wrote:
> In addition to migrating the tracepoint overhead test from sample/bpf
> to selftest/bpf, this commit extends benchmarking test with rename
> task.
> 
> Since previous commit migrated tracepoint based on rename task, this
> commit updates the benchmarking program to utilize the newly added
> 'rename-tp'.
> 
> Signed-off-by: Daniel T. Lee <danieltimlee@gmail.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  tools/testing/selftests/bpf/bench.c              |  2 ++
>  .../testing/selftests/bpf/benchs/bench_rename.c  | 16 ++++++++++++++++
>  .../selftests/bpf/benchs/run_bench_rename.sh     |  2 +-
>  3 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
> index 627b74ae041b..e3d17b9b78cc 100644
> --- a/tools/testing/selftests/bpf/bench.c
> +++ b/tools/testing/selftests/bpf/bench.c
> @@ -495,6 +495,7 @@ extern const struct bench bench_rename_kretprobe;
>  extern const struct bench bench_rename_rawtp;
>  extern const struct bench bench_rename_fentry;
>  extern const struct bench bench_rename_fexit;
> +extern const struct bench bench_rename_tp;
>  
>  /* pure counting benchmarks to establish theoretical lmits */
>  extern const struct bench bench_trig_usermode_count;
> @@ -552,6 +553,7 @@ static const struct bench *benchs[] = {
>  	&bench_rename_rawtp,
>  	&bench_rename_fentry,
>  	&bench_rename_fexit,
> +	&bench_rename_tp,
>  	/* pure counting benchmarks for establishing theoretical limits */
>  	&bench_trig_usermode_count,
>  	&bench_trig_kernel_count,
> diff --git a/tools/testing/selftests/bpf/benchs/bench_rename.c b/tools/testing/selftests/bpf/benchs/bench_rename.c
> index bf66893c7a33..48cd9556ddf8 100644
> --- a/tools/testing/selftests/bpf/benchs/bench_rename.c
> +++ b/tools/testing/selftests/bpf/benchs/bench_rename.c
> @@ -106,6 +106,12 @@ static void setup_fexit(void)
>  	attach_bpf(ctx.skel->progs.prog5);
>  }
>  
> +static void setup_tp(void)
> +{
> +	setup_ctx();
> +	attach_bpf(ctx.skel->progs.prog6);
> +}
> +
>  const struct bench bench_rename_base = {
>  	.name = "rename-base",
>  	.validate = validate,
> @@ -136,6 +142,16 @@ const struct bench bench_rename_kretprobe = {
>  	.report_final = hits_drops_report_final,
>  };
>  
> +const struct bench bench_rename_tp = {
> +	.name = "rename-tp",
> +	.validate = validate,
> +	.setup = setup_tp,
> +	.producer_thread = producer,
> +	.measure = measure,
> +	.report_progress = hits_drops_report_progress,
> +	.report_final = hits_drops_report_final,
> +};
> +
>  const struct bench bench_rename_rawtp = {
>  	.name = "rename-rawtp",
>  	.validate = validate,
> diff --git a/tools/testing/selftests/bpf/benchs/run_bench_rename.sh b/tools/testing/selftests/bpf/benchs/run_bench_rename.sh
> index 7b281dbe4165..131e5e6ea8ec 100755
> --- a/tools/testing/selftests/bpf/benchs/run_bench_rename.sh
> +++ b/tools/testing/selftests/bpf/benchs/run_bench_rename.sh
> @@ -2,7 +2,7 @@
>  
>  set -eufo pipefail
>  
> -for i in base kprobe kretprobe rawtp fentry fexit
> +for i in base kprobe kretprobe rawtp fentry fexit tp
>  do
>  	summary=$(sudo ./bench -w2 -d5 -a rename-$i | tail -n1 | cut -d'(' -f1 | cut -d' ' -f3-)
>  	printf "%-10s: %s\n" $i "$summary"
> -- 
> 2.43.0
> 

