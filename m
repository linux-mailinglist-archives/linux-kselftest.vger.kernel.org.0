Return-Path: <linux-kselftest+bounces-15160-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A07794EB9B
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 13:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3094B21CD5
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 11:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161A0175D3C;
	Mon, 12 Aug 2024 11:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UU034jP8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FFC16F907;
	Mon, 12 Aug 2024 11:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723461119; cv=none; b=WPAoqiiHAh/uoPqkfFjGLD64t1wYQdF6JczVLeRN3z3gbCJDxMrxDRjlQi1TpA6Br1vEvjSwBk/JGcMGshvnibdEyf/A0R//cd16iBKTLGY7Jebasy2VyFAfajBtGW9avlux3fXwKhPUPg6HJkXCsU1F5ZrhrW4wY+ZJsCuE1VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723461119; c=relaxed/simple;
	bh=8pf9Uypm5ld1Uay11ZH7uNgxkB3wMfazsKj1MowamxU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvHAsL93uu+CnoEMcXEti/WJUMEcYhL8nBCxuPgIFTB8x9O8WCaiL62ZKgdAiNKhhVG+kAKv6x0bnyrflTJeIBerFceb7tSEQ2qkqKRWUKbwuJjaz2DQUOS2FYbuJRe4/Jb3Jv7pjyzn4kcJ4El7XuTo6UWK/M73krEHvL6KTWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UU034jP8; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5bd1a9bdce4so2134816a12.3;
        Mon, 12 Aug 2024 04:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723461115; x=1724065915; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aWvL/xhpjq2Vod6dZsAqSbr8T2jJCHPCKwa2ZuCvSoU=;
        b=UU034jP8VzdytO6AasRT+hDSoHV8yVEUlp97KPP79rxOFN3FNQj1TQC6fIHfAp2h6/
         bI0OE1MYm1Ntvd/16mZN0wqcifjEynaro5hzxu/FNCMeKyWGTMbIc+zqSaPVw/CPRs9K
         aM1kotQbsqMrx0ac0QmAYr5e7PwvJI8rFE4cE94dECDkzz/8a+9psMXvC1TDsXJcC2BI
         UxMU9J+Dwhy44o5mYPiTmiSnvBOFlTCI/sxVrbhxCSTKQ4v7TbesPOsrZnTd7HLtx1ei
         p8gZy5J70x1qz2lXi4emrrM/tihfKOFFEh2mZl/FbvcEYrDT83x0of3gTMImC+a2WzOn
         4lhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723461115; x=1724065915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWvL/xhpjq2Vod6dZsAqSbr8T2jJCHPCKwa2ZuCvSoU=;
        b=fdMF+mWM2SAdbsKwyg7ZoYhMLxRMVWKs/CR1ffU64dZ86ZqKtwFQGjHpq5i56IoFuY
         AHssbq7WFf9e3VUtvG6VcuRopWSIN8M/CGqeysw3iSc7UIikxa+BenuAIQ4ZspwAm50T
         xS6Nsq2E6YQ7k6hcqHeSQ3T82nmOW8uf/QzGJbhZX3DKgmQlojRGjvGKoTFg6cYl3qMW
         glRBrhsN8GqeGSQ/g+h/x9gY//pvb+BJcgm5PABRRlnun59XS67k5hX4l53NJ339xrY5
         WDRGhAKES4Apze/hmWxdvG7MpQ23Xw6vi8gjOoVYJYPpd7pGZTHtnOALOU38LHHewncN
         9Q9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUnX+VQ4oJct5oubHdOFcP2RlWVW1BCMlXmbWGiaSmUU+eio6wB7ef+1H6N05xn1MFky1c=@vger.kernel.org, AJvYcCVZj7HjqBkt6Isyd2Ki2R8mISnp4c6UPCDlKQ7/xQFjuQB2mopveRr/GN2/ocmCdGXcsmjDPOcg@vger.kernel.org, AJvYcCVbNWCm/UxwWwXAjXt749Ba3VLvSFLcJo1HMIAtHPhGZwW2VaPhlnzatbwOxJ2H6HzBSmvyEWLLWErMlzftayKa@vger.kernel.org
X-Gm-Message-State: AOJu0YwdKTJy1G3gwnyEhxgFYPZ/5/VKCr31qVWWCdPYfdMOUfIPt7ck
	+CQ6jgCa0J69gsyPJJdhM/rjx/80DqwqrXVxMuB1p7bKoOabDgnk
X-Google-Smtp-Source: AGHT+IF32vFJxANmPRrUxCMgCkra/7STs7BgsYNFEHlezE8W7xVbjO9Ray13hGkBLVbJOOW7weVJAA==
X-Received: by 2002:a05:6402:1d52:b0:5a3:f5c6:7cd5 with SMTP id 4fb4d7f45d1cf-5bd0a629902mr6991779a12.26.1723461115266;
        Mon, 12 Aug 2024 04:11:55 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd196a59ebsm2004878a12.48.2024.08.12.04.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 04:11:54 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 12 Aug 2024 13:11:52 +0200
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
Subject: Re: [bpf-next 1/3] selftests/bpf: migrate tracepoint overhead test
 to prog_tests
Message-ID: <Zrnt-BNkIY1HSqkO@krava>
References: <20240812004503.43206-1-danieltimlee@gmail.com>
 <20240812004503.43206-2-danieltimlee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812004503.43206-2-danieltimlee@gmail.com>

On Mon, Aug 12, 2024 at 12:45:01AM +0000, Daniel T. Lee wrote:
> As part of the cleanup of outdated test cases in sample/bpf, this
> commit migrates test for tracepoint overhead to selftest prog_tests.
> 
> The test_overhead in selftest/bpf focus on the 'raw_tracepoint' only,
> and do not cover tracepoint-specific tests. To support this, this
> commit utilize 'vmlinux.h', and additional test program for tracepoint
> has been added.
> 
> Signed-off-by: Daniel T. Lee <danieltimlee@gmail.com>

sure, let's have it complete

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  .../selftests/bpf/prog_tests/test_overhead.c       | 14 +++++++++++++-
>  tools/testing/selftests/bpf/progs/test_overhead.c  | 11 +++++++----
>  2 files changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_overhead.c b/tools/testing/selftests/bpf/prog_tests/test_overhead.c
> index f27013e38d03..06153602a859 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_overhead.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_overhead.c
> @@ -61,9 +61,10 @@ void test_test_overhead(void)
>  	const char *raw_tp_name = "prog3";
>  	const char *fentry_name = "prog4";
>  	const char *fexit_name = "prog5";
> +	const char *tp_name = "prog6";
>  	const char *kprobe_func = "__set_task_comm";
>  	struct bpf_program *kprobe_prog, *kretprobe_prog, *raw_tp_prog;
> -	struct bpf_program *fentry_prog, *fexit_prog;
> +	struct bpf_program *fentry_prog, *fexit_prog, *tp_prog;
>  	struct bpf_object *obj;
>  	struct bpf_link *link;
>  	int err, duration = 0;
> @@ -96,6 +97,10 @@ void test_test_overhead(void)
>  	if (CHECK(!fexit_prog, "find_probe",
>  		  "prog '%s' not found\n", fexit_name))
>  		goto cleanup;
> +	tp_prog = bpf_object__find_program_by_name(obj, tp_name);
> +	if (CHECK(!tp_prog, "find_probe",
> +		  "prog '%s' not found\n", tp_name))
> +		goto cleanup;
>  	err = bpf_object__load(obj);
>  	if (CHECK(err, "obj_load", "err %d\n", err))
>  		goto cleanup;
> @@ -142,6 +147,13 @@ void test_test_overhead(void)
>  	test_run("fexit");
>  	bpf_link__destroy(link);
>  
> +	/* attach tp */
> +	link = bpf_program__attach_tracepoint(tp_prog, "task", "task_rename");
> +	if (!ASSERT_OK_PTR(link, "attach_tp"))
> +		goto cleanup;
> +	test_run("tp");
> +	bpf_link__destroy(link);
> +
>  cleanup:
>  	prctl(PR_SET_NAME, comm, 0L, 0L, 0L);
>  	bpf_object__close(obj);
> diff --git a/tools/testing/selftests/bpf/progs/test_overhead.c b/tools/testing/selftests/bpf/progs/test_overhead.c
> index abb7344b531f..6dc1f68180e0 100644
> --- a/tools/testing/selftests/bpf/progs/test_overhead.c
> +++ b/tools/testing/selftests/bpf/progs/test_overhead.c
> @@ -1,9 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright (c) 2019 Facebook */
> -#include <stdbool.h>
> -#include <stddef.h>
> -#include <linux/bpf.h>
> -#include <linux/ptrace.h>
> +#include "vmlinux.h"
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_tracing.h>
>  
> @@ -39,4 +36,10 @@ int BPF_PROG(prog5, struct task_struct *tsk, const char *buf, bool exec)
>  	return 0;
>  }
>  
> +SEC("tracepoint/task/task_rename")
> +int prog6(struct trace_event_raw_task_rename *ctx)
> +{
> +	return 0;
> +}
> +
>  char _license[] SEC("license") = "GPL";
> -- 
> 2.43.0
> 

