Return-Path: <linux-kselftest+bounces-8828-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E9F8B1807
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 02:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 796E01C255EC
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 00:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02DF81F;
	Thu, 25 Apr 2024 00:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VS2+FkXu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F90631;
	Thu, 25 Apr 2024 00:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714004943; cv=none; b=bLqqBpSOC60xq43Yx1P+p7C8ReUHFBeJW1S1ImO0TbCjTbAUxEldwGaikIRD67LEEj4gRt4shCjf9DTE5bXGXanFlIf0uQEUscrhtGDw/I0U/TqXWLT1wzbepWNjwPDWKQYokT/weOd+aj1o1gOzHDP5fBj7QuI5G60mLDAPBZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714004943; c=relaxed/simple;
	bh=dfYIhluWI9VFQ+0sliYM+gC/g3orSZlMV5F8bbaGEmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H9xODm+KQKa829y6Y5Ozw2/qKSTj8m14FW24UvUuWN4CN7CyeQMCGyRpqhH539jpPRwJXODcHLHUO8Q0aeioPhWJKqJXlxtye46iVPkvLi0LGSBDlt00IZhBgE8iCHirWdT3sYBOF3qXdTVesw5KQWdiUNUq3IEz9Zm+YVRUCeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VS2+FkXu; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e46dcd8feaso244953b3a.2;
        Wed, 24 Apr 2024 17:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714004941; x=1714609741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBjD5Ob95OzRJ4oN6s6QCeuOKrDd2KPsOMku1YCrrZM=;
        b=VS2+FkXuXhRiMsnNi3qPuOJXzlqpqu2Oo9sILBaWOlIAcFqgJNSVLc+o0iV2ZE3nzn
         Rbt6BN5nmhbcBa6PishwCokxnuEfuJjqsxaX/DECYSd1V9sDzCSBVLf8Xz/H1HH8guZ8
         twjw5W8tmqrWbo+QTdOTE9YzLvrQ8BSvBF5ViZIA3U6yyGmKGGBWN15xgvIIBNsxKVba
         rCWQFXyc916yvZqdhxb3Cmq2I3s3vzmJNy4dMaD6Q+iFUmqv9G0kT42AZr1U/CYWa3Jf
         d4G//aHWXXAuIxsEyUwMVRgzCiPAEMKl3k9Lp20c7bnVev/JzC1OH2JrE4/5MdS2OjfX
         qeLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714004941; x=1714609741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BBjD5Ob95OzRJ4oN6s6QCeuOKrDd2KPsOMku1YCrrZM=;
        b=sOUhhT6hVOF0+Q2aY5Ix/kL/St03FJjQweUDsC6K7mU0hVumVDDOqbr+7OOjXsYYXM
         O76Nfy48JgLJBTF4d577PRe7yUV/D9Nz5rbLolVtpFtAJbY2Uce7YiUZYtnpSklKq7IF
         6Z9KmhYQUYFNvX/pxhHbkly+7jmoklVg+2cqLN7z321FSVxIDD8kMvvVa1DZNFJ66HYa
         INOF4qEfW9rUnX7pv6RgQZoXgZu5Z8rkX3LfMHjjSveOeR+4ZF1T20vhK+/KXUyD/knR
         hCAdaLzNpmAsXr3KySAdCRDY3yXZTumILckHqNLxpKDnRoslME6DyJnOTw9yaan3CWNF
         D2PQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZ271I2ll9lH6IQg3IASW2Eak21jc8OZLCfd0EENRG3njK/7IghlOf0P8B7pG/U0BjXmd4ToyATTfAj3MkE+CaH6D7g4O65ihRjaZEugRbM0+9PA5wcNfJWHaPLnt76jmUmUYTbVCrLzdii6Wymswph1K6ftmumi63nFEH13aS8xSQ
X-Gm-Message-State: AOJu0YzD9rowDyuucbuz94dt9skTtRzSY4rfVdLaKtQbQuWa7hRzk2Ko
	BGeGXiX/cN9ISibPe5dis5nP50y79IUkk8YHqzlvqn84Wcrktu2rwwjgPx5ziqS55ulClkOUYlH
	JYAt3r15olSJVHqi6Ch3mUXRVtY0=
X-Google-Smtp-Source: AGHT+IERSh3vqLDqkb6Kdf7/fBtvb2Q6VMXuHjz6M3uNzuIRzyS3tPf2LjcwjWCO5I0j7e1nTNDzYKEbE/+kJ2EjcPU=
X-Received: by 2002:a05:6a21:2d85:b0:1a9:c757:a22d with SMTP id
 ty5-20020a056a212d8500b001a9c757a22dmr4633205pzb.14.1714004941537; Wed, 24
 Apr 2024 17:29:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240420-bpf_wq-v2-0-6c986a5a741f@kernel.org> <20240420-bpf_wq-v2-12-6c986a5a741f@kernel.org>
In-Reply-To: <20240420-bpf_wq-v2-12-6c986a5a741f@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 24 Apr 2024 17:28:49 -0700
Message-ID: <CAEf4BzbqmrucgeXX9+Hgnhefne-go9nHYPmh_+JwuMHeNNsv-g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 12/16] selftests/bpf: wq: add bpf_wq_init() checks
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 20, 2024 at 2:10=E2=80=AFAM Benjamin Tissoires <bentiss@kernel.=
org> wrote:
>
> Allows to test if allocation/free works
>
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
>
> ---
>
> changes in v2:
> - dropped mark_precise checks
> ---
>  tools/testing/selftests/bpf/bpf_experimental.h  |  1 +
>  tools/testing/selftests/bpf/prog_tests/wq.c     |  8 +++
>  tools/testing/selftests/bpf/progs/wq.c          | 10 ++++
>  tools/testing/selftests/bpf/progs/wq_failures.c | 78 +++++++++++++++++++=
++++++
>  4 files changed, 97 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testi=
ng/selftests/bpf/bpf_experimental.h
> index 3329ea080865..785b91b629be 100644
> --- a/tools/testing/selftests/bpf/bpf_experimental.h
> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> @@ -470,4 +470,5 @@ extern int bpf_iter_css_new(struct bpf_iter_css *it,
>  extern struct cgroup_subsys_state *bpf_iter_css_next(struct bpf_iter_css=
 *it) __weak __ksym;
>  extern void bpf_iter_css_destroy(struct bpf_iter_css *it) __weak __ksym;
>
> +extern int bpf_wq_init(struct bpf_wq *wq, void *p__map, unsigned int fla=
gs) __weak __ksym;
>  #endif
> diff --git a/tools/testing/selftests/bpf/prog_tests/wq.c b/tools/testing/=
selftests/bpf/prog_tests/wq.c
> index 9a07b8bc2c52..26ab69796103 100644
> --- a/tools/testing/selftests/bpf/prog_tests/wq.c
> +++ b/tools/testing/selftests/bpf/prog_tests/wq.c
> @@ -2,6 +2,7 @@
>  /* Copyright (c) 2024 Benjamin Tissoires */
>  #include <test_progs.h>
>  #include "wq.skel.h"
> +#include "wq_failures.skel.h"
>
>  void serial_test_wq(void)
>  {
> @@ -9,3 +10,10 @@ void serial_test_wq(void)
>
>         RUN_TESTS(wq);
>  }
> +
> +void serial_test_failures_wq(void)
> +{
> +       LIBBPF_OPTS(bpf_test_run_opts, topts);
> +

unused leftover?

> +       RUN_TESTS(wq_failures);
> +}

[...]

