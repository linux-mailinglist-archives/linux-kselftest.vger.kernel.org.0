Return-Path: <linux-kselftest+bounces-14187-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC9D93B9A8
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 01:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4BF01C22AA0
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 23:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B14143736;
	Wed, 24 Jul 2024 23:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knFeOFdX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EAA4D8B9;
	Wed, 24 Jul 2024 23:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721865197; cv=none; b=PxlqCzmBJJeq3xwWxHCcN/paBIr6OhJYAjFKabGzgrecowye6Cdp0rslV+rknw65OuIqb3a/YcoE30Hyl9GLJEk1gZS4OOMQsh+zH7pZACAUnVfToKEaLNSawezDLCmzc/TF6aNyVAtsq7u4YxnOYIS+v6tTjzJQJY3ehbprB7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721865197; c=relaxed/simple;
	bh=3tsiotRAMHlCf8PXx1qqoxjA+dmi0gqodT0kcXlI130=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AQ4EM815gBsT6o94D79F1TxxUvy4URTTKeh3mTSXnB/CRMDo15xjdRoGnIHNo2eW8p/7Veew6arSVaDHeTq4FuGzoQxv0bR+IqTM0IZd2m5SLHVeoFgz7rjlM8k6dMHMD1hewXi8krTPcMjiUA9njTdjU6wml2h3GMj+1ED3F8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knFeOFdX; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7a47e2179dso46282066b.3;
        Wed, 24 Jul 2024 16:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721865194; x=1722469994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66dKSDrdd/EOBhOawAJ4GVlgnLqO1LHBOrAUZa62rU0=;
        b=knFeOFdXN/wQ6bvon+T0knE8S1oH+7NYAFHevOjB/asZ4018PLQAgDng+OWlXKcfFn
         y1O58gwzwChCC/02jIN6wXsJFaHFW62S/XtPuAMzOP4ebGNe9wCdgl2lZM/Qy5IN7XQc
         5fRRfKqOz8S2vC+KSEB4xg7sIzLRrUNngn1YGDZtsU2PP7YIqbEWXVsqflQqCkZG37iS
         B47EfD0Y4YKKt2vnpKLsZVwokq13VofZ4gawNssqY6OejIwsV+vh6nf2+TWYB8bfKW6F
         nICq4f6XME7+FGYbT1MvFzViWVXZc37qftDSd3003TqRKZinrUNvhtUrJ+VCp8osKxq4
         gtuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721865194; x=1722469994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=66dKSDrdd/EOBhOawAJ4GVlgnLqO1LHBOrAUZa62rU0=;
        b=Xgb4+xX9G+Dh+Zm9eISM3bITjHXLQGaxXTH8+VZYU83Vy2+yDUDRNbcgp6PEorvMmW
         fyVKKTD8IpNjS5Z538fNwC1ycY+gyCCFK7j/nMHKa7cXYfv0UE0adsKlX193VhldvIV/
         zPOtuU8Pjyv6M9QrWWht6kQxKOQtiKBPuUgzVRytjSXgJph2uzBsqBlxd5vidKEIcRV4
         fd4xSUEUzoyPA6xj6d5lzWx/ENYjTTV0QFdN9swnCG9HTxlxSrJvDO3URTv2DhoT2zk/
         IXsDoNV5fLfy7r7B48cSYtTtYnCleJeqx+SL0LwMLvwHCMs62+uGqOToYHzd/1aaL8iE
         jJlw==
X-Forwarded-Encrypted: i=1; AJvYcCX/YvQSE/+CZwIPzDRCiZLLGHrc5tJ1I5XzR7jeayJV7P4f3TJ4RL7+PoezGaE1jCmOdpxpLWLf9zek3WStiL/xQKGFBj8FFsb1CuTwtThf
X-Gm-Message-State: AOJu0Yzm45SVZFVv827NDpXNxZ6mVr1ZFNJKDHRaM8A6B49+YrzOWtFw
	Fcv/g8CmGmXnQmtsNMPhzqDQYMQya8SnIoOxBBl/0WwNjkWuSIiwyU10WL2DQyNdKsQ9s0T2JC8
	fzHJMLWqP/71S/GJXxr1OOd9uIT8=
X-Google-Smtp-Source: AGHT+IFRR4qHDV9fmvUkXC57rpDz/xuce1g0rksXsz4OpRC0EAusHQQOQtzI4ighjvVzDWZ3ba23NhFASAy4S8lmuiQ=
X-Received: by 2002:a17:907:6d01:b0:a79:82c1:a5b2 with SMTP id
 a640c23a62f3a-a7ac4d9e936mr70302666b.9.1721865193925; Wed, 24 Jul 2024
 16:53:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1721713597.git.tony.ambardar@gmail.com>
In-Reply-To: <cover.1721713597.git.tony.ambardar@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 24 Jul 2024 16:52:57 -0700
Message-ID: <CAEf4BzYaOVDitzcY+j=vpAqeNC+KZXk9pcTVht=npCmnPpoKmQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 00/19] selftests/bpf: Improve libc portability
 / musl support (part 1)
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, Yucong Sun <sunyucong@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@amazon.co.jp>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Dave Marchevsky <davemarchevsky@fb.com>, 
	David Vernet <void@manifault.com>, Carlos Neira <cneirabustos@gmail.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Willem de Bruijn <willemb@google.com>, 
	Yan Zhai <yan@cloudflare.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	YiFei Zhu <zhuyifei@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 10:55=E2=80=AFPM Tony Ambardar <tony.ambardar@gmail=
.com> wrote:
>
> Hello all,
>
> This series includes the bulk of libc-related compile fixes accumulated t=
o
> support systems using musl, with smaller numbers to follow. These patches
> are simple and straightforward, and the series has been tested with the
> kernel-patches/bpf CI and locally using mips64el-gcc/musl-libc and QEMU
> with an OpenWrt rootfs.
>
> The patches address a few general categories of libc portability issues:
>
>  - missing, redundant or incorrect include headers
>  - disabled GNU header extensions (i.e. missing #define _GNU_SOURCE)
>  - issues with types and casting
>
> Feedback and suggestions for improvement are welcome!
>
> Thanks,
> Tony
>
> Tony Ambardar (19):
>   selftests/bpf: Use pid_t consistently in test_progs.c
>   selftests/bpf: Fix compile error from rlim_t in sk_storage_map.c
>   selftests/bpf: Fix error compiling bpf_iter_setsockopt.c with musl
>     libc
>   selftests/bpf: Drop unneeded include in unpriv_helpers.c
>   selftests/bpf: Drop unneeded include in sk_lookup.c
>   selftests/bpf: Drop unneeded include in flow_dissector.c

I squashed the above three patches into one, as they are the same kind
of fix with the same reasoning. The rest at least have a specific
error example, so I didn't touch them.

But generally speaking, I think it's fair to combine the same kind of
fixes across a few files (for the future).

Applied to bpf-next, thanks.




>   selftests/bpf: Fix missing ARRAY_SIZE() definition in bench.c
>   selftests/bpf: Fix missing UINT_MAX definitions in benchmarks
>   selftests/bpf: Fix missing BUILD_BUG_ON() declaration
>   selftests/bpf: Fix include of <sys/fcntl.h>
>   selftests/bpf: Fix compiling parse_tcp_hdr_opt.c with musl-libc
>   selftests/bpf: Fix compiling kfree_skb.c with musl-libc
>   selftests/bpf: Fix compiling flow_dissector.c with musl-libc
>   selftests/bpf: Fix compiling tcp_rtt.c with musl-libc
>   selftests/bpf: Fix compiling core_reloc.c with musl-libc
>   selftests/bpf: Fix errors compiling lwt_redirect.c with musl libc
>   selftests/bpf: Fix errors compiling decap_sanity.c with musl libc
>   selftests/bpf: Fix errors compiling crypto_sanity.c with musl libc
>   selftests/bpf: Fix errors compiling cg_storage_multi.h with musl libc
>
>  tools/testing/selftests/bpf/bench.c                          | 1 +
>  tools/testing/selftests/bpf/bench.h                          | 1 +
>  tools/testing/selftests/bpf/map_tests/sk_storage_map.c       | 2 +-
>  tools/testing/selftests/bpf/prog_tests/bpf_iter_setsockopt.c | 2 +-
>  tools/testing/selftests/bpf/prog_tests/core_reloc.c          | 1 +
>  tools/testing/selftests/bpf/prog_tests/crypto_sanity.c       | 1 -
>  tools/testing/selftests/bpf/prog_tests/decap_sanity.c        | 1 -
>  tools/testing/selftests/bpf/prog_tests/flow_dissector.c      | 2 +-
>  tools/testing/selftests/bpf/prog_tests/kfree_skb.c           | 1 +
>  tools/testing/selftests/bpf/prog_tests/lwt_redirect.c        | 1 -
>  tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c | 2 +-
>  tools/testing/selftests/bpf/prog_tests/parse_tcp_hdr_opt.c   | 1 +
>  tools/testing/selftests/bpf/prog_tests/sk_lookup.c           | 1 -
>  tools/testing/selftests/bpf/prog_tests/tcp_rtt.c             | 1 +
>  tools/testing/selftests/bpf/prog_tests/user_ringbuf.c        | 1 +
>  tools/testing/selftests/bpf/progs/cg_storage_multi.h         | 2 --
>  tools/testing/selftests/bpf/test_progs.c                     | 2 +-
>  tools/testing/selftests/bpf/unpriv_helpers.c                 | 1 -
>  18 files changed, 12 insertions(+), 12 deletions(-)
>
> --
> 2.34.1
>

