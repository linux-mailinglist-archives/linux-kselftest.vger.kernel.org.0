Return-Path: <linux-kselftest+bounces-15258-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E994950B89
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 19:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 368ED285E9D
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 17:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83301A2C16;
	Tue, 13 Aug 2024 17:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1fTvT0C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B5D18C3D;
	Tue, 13 Aug 2024 17:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723570793; cv=none; b=mnu4jkvz2UNmXDNF0TtqWa06ReQexHfsqGhI+XTpVKm1LdnGk9yTzcXc1zJ7eRO4B2JojQwJMzMkLq/l4G+8GzYqqdckv+8nu9z7b9Vcyh/m7ni+ZB2dDWdoDHbqwh7/NhMwBY9QQhh1VaMSli+6NkXDDrJ1TdKBj3kJXCL3sH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723570793; c=relaxed/simple;
	bh=DJq9kjbIzOVRgUeTLJfGxppcJGxEJfJ+p/jj5GHFgQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UxajcZWFSrmdztxji3XZs1CgVVbGD5u17af4y9caVr2GshPJhnlPzmKQ9h1CT+RypCzq5xcFy+xAQeVfszziMjgT09Ecmgl6f6Xy2L8s9MHuMPGgJn5La0Y0Q47NTOOiYWRri8G8yQgcMgUPxP01uGtpGXXaR2XKnpnvqHoNBto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1fTvT0C; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so3984550a12.3;
        Tue, 13 Aug 2024 10:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723570791; x=1724175591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HE5r/HJMJZgTTMlLXtLllz4r3gH1IYPGCs8AltB06Yo=;
        b=k1fTvT0ChiZ1ChDOOJ5vmb60Hxi4/TDWKLDsVkJ+ydJrNar9dHCNOfvd87lJsJD10j
         XJIIhwxp0pqg/xJ+AiiaNzsPGKzVcw54/eU1FtnVBFWOHulk4whKbkcKnI+v4cnbO1qW
         2UTO2DNwUAF9F4haOOz1djaowRQlOSUJ2/GodsriyqIhcObuij8BSLlwFaJpKDnI9o+R
         Sz/AIcnTLgUXv8qJMGcCHyN5o1H2X8K8o8rtkCdeIQBuOC/rqKrqMvZzWnDFIWTBnZsf
         b5zszPTvKu3J1OOM8QOt0l/0tcyXjEVcHacV5Zdp//GHBolC/jF8oBWgxLGm/A/7qQw4
         H3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723570791; x=1724175591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HE5r/HJMJZgTTMlLXtLllz4r3gH1IYPGCs8AltB06Yo=;
        b=KqglnadEEE0YRC9AQNzeHcv4yHY/9sxweGAMFQGPnUCWyGnqXhuC1XQ1kaKm41kfHQ
         utcytVXDMZNd5Gqx59p8qqsQ8ePqlFEreIN5Smj6cJgujqHHCJojYtZGpmR7//MURT/t
         5wpFciTQpkgaXw3YwtYtrEDrqYa2shbwJCO3mIjmar94UiiQsO7YckD4iwpoKi9+FZwu
         wjuwYNUgEABrUcF7BvqkJ7iO+/Jm8gyS5Rh1FJGXDaYnEKVvQOcQIbBQCGrYhycLiXWK
         fEWsU2Ia82er4AbRy7hxGNKZJBvJ8uSOnPYv4lzhvRbALqchrX3Z23HjeQngObZrVyLB
         dZCA==
X-Forwarded-Encrypted: i=1; AJvYcCVnw9/BmkEFCbtQpjoBxr1Gpo2vsN0SfqWfkzv7kCKb6LVgLSvNWVKXJ/BCMnMDtPFWDxD5YJ+1S2N5pZC21QWYkLCCQF6NChZAiHjfeW4hTQrfu/hyqoTvxrzPlPQjKVHC/A5wc4ZXMObzOZailD/sdgJyIvmc4/Axe6Dq
X-Gm-Message-State: AOJu0Yw2wKfhfIdOas/bIoWGMNg21e2Yrnb699Dt39KTsiNn5ZYFdaFm
	r9q6UuT3XfXdcWDl73f5aqabWEU+QSyNmDEpgjg8bQS1nRuBDRDEimMBSpoVtgM4NcMbMrgjYIh
	BsDS6bUL12KopRuzsxOmbYieKsw==
X-Google-Smtp-Source: AGHT+IGMzSKM2bdnuT/c+oYMrtTjyVQTc1oN6ctNxnHjJehIoDruTX5c8H5k+7pGEx9Y8Jlol+Cpyhz3rhSXR1KWbMk=
X-Received: by 2002:a17:902:e84a:b0:1fd:9420:1044 with SMTP id
 d9443c01a7336-201d63abdfcmr2857755ad.16.1723570791336; Tue, 13 Aug 2024
 10:39:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812004503.43206-1-danieltimlee@gmail.com> <CAEf4BzZsZYNx_mV0_0RrWvQS+Y7ixvtzv3SmTTQkOveeZeot+w@mail.gmail.com>
In-Reply-To: <CAEf4BzZsZYNx_mV0_0RrWvQS+Y7ixvtzv3SmTTQkOveeZeot+w@mail.gmail.com>
From: "Daniel T. Lee" <danieltimlee@gmail.com>
Date: Wed, 14 Aug 2024 02:39:34 +0900
Message-ID: <CAEKGpzgnQ+=W==EQ56CKXYCpDx=kLHMhoo+3KZQy9sOUKNeYtw@mail.gmail.com>
Subject: Re: [bpf-next 0/3] samples/bpf: Remove obsolete tracing-related tests
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Yipeng Zou <zouyipeng@huawei.com>, linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 6:17=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sun, Aug 11, 2024 at 5:45=E2=80=AFPM Daniel T. Lee <danieltimlee@gmail=
.com> wrote:
> >
> > The BPF tracing infrastructure has undergone significant evolution,
> > leading to the introduction of more robust and efficient APIs.
> > However, some of the existing tests in the samples/bpf directory have
> > not kept pace with these developments. These outdated tests not only
> > create confusion among users but also increase maintenance overhead.
> >
> > For starter, this patchset focuses on cleaning up outdated 'tracing'
> > related tests within the BPF testing framework. The goal is to
> > modernize and streamline selftests by removing obsolete tests and
> > migrating necessaries to more appropriate locations.
> >
> > Daniel T. Lee (3):
> >   selftests/bpf: migrate tracepoint overhead test to prog_tests
> >   selftests/bpf: add rename tracepoint bench test
> >   samples/bpf: remove obsolete tracing related tests
> >
>
> We already have tracepoint-specific benchmark (see
> benchs/bench_trigger.c), try `./bench trig-tp` (it will pretty recent
> kernel due to reliance on bpf_modify_return_test_tp() kfunc).
>
> So maybe instead of adding code to selftests, let's just remove it
> from both samples/bpf and prog_tests' test_overhead? Either way
> test_overhead isn't very representative anymore, given big chunk of
> its overhead is in write() syscall?
>

Thanks for the insight!
I'll just drop these two and resend them.

> >  samples/bpf/Makefile                          |  12 -
> >  samples/bpf/test_overhead_kprobe.bpf.c        |  41 ----
> >  samples/bpf/test_overhead_raw_tp.bpf.c        |  17 --
> >  samples/bpf/test_overhead_tp.bpf.c            |  23 --
> >  samples/bpf/test_overhead_user.c              | 225 ------------------
> >  samples/bpf/test_override_return.sh           |  16 --
> >  samples/bpf/test_probe_write_user.bpf.c       |  52 ----
> >  samples/bpf/test_probe_write_user_user.c      | 108 ---------
> >  samples/bpf/tracex7.bpf.c                     |  15 --
> >  samples/bpf/tracex7_user.c                    |  56 -----
> >  tools/testing/selftests/bpf/bench.c           |   2 +
> >  .../selftests/bpf/benchs/bench_rename.c       |  16 ++
> >  .../selftests/bpf/benchs/run_bench_rename.sh  |   2 +-
> >  .../selftests/bpf/prog_tests/test_overhead.c  |  14 +-
> >  .../selftests/bpf/progs/test_overhead.c       |  11 +-
> >  15 files changed, 39 insertions(+), 571 deletions(-)
> >  delete mode 100644 samples/bpf/test_overhead_kprobe.bpf.c
> >  delete mode 100644 samples/bpf/test_overhead_raw_tp.bpf.c
> >  delete mode 100644 samples/bpf/test_overhead_tp.bpf.c
> >  delete mode 100644 samples/bpf/test_overhead_user.c
> >  delete mode 100755 samples/bpf/test_override_return.sh
> >  delete mode 100644 samples/bpf/test_probe_write_user.bpf.c
> >  delete mode 100644 samples/bpf/test_probe_write_user_user.c
> >  delete mode 100644 samples/bpf/tracex7.bpf.c
> >  delete mode 100644 samples/bpf/tracex7_user.c
> >
> > --
> > 2.43.0
> >



--=20
Best,
Daniel T. Lee

