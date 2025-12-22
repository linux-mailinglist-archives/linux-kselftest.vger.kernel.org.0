Return-Path: <linux-kselftest+bounces-47862-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5479CD6F81
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 20:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C3DA301E141
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Dec 2025 19:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903D23254B6;
	Mon, 22 Dec 2025 19:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Je6SUgB+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2653016E7
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Dec 2025 19:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766431772; cv=none; b=jHpkzDSw+MuwVATsXkyo0rahRPBAess7Q7r5b4fQRo/HzZe/SS5r5V1/yXPJDh63fWT45lHICvwnyBuSjOwam2fsid3SXQgXJDt4KO4sPIjOc+s3yio/tksbrDMLazNfX6LqFnIJ3Z/nCDcJ9opsXOdIbt5K3foKki73QkZS8xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766431772; c=relaxed/simple;
	bh=CyShxEjbMhDuuoeaYBTednz/l/07QYESM4eZ3C+wF0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TYHSzpmaqUjWeUjdUP+jFQ20SyqNFWFbKxoezGyiBbzhomvrccHZ+VbTnYmc/k0XGNobJ3IWsCIg2JCyIDtc5NEclu+2rHwfCNo60zkvRRwVBUjm3jYWvOgGw1IisCxP5aEE8rFhQhoRqZDEmGjbj5i7tgobMmoOxoGCEsDRENE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Je6SUgB+; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-78fb7ab7562so23450077b3.2
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Dec 2025 11:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766431770; x=1767036570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y0HZvemBGrTiy88qS3/KTaFBN6UnJEpXmvRl4aHyOPA=;
        b=Je6SUgB+JDe6nJ1mq+9ijAa8jFXKa6vizIJpnUYBsRPQRHwc+fEP1KdA5eBxchItn6
         YZwvyZnidf6mecrWOI/fyGPvLDqXvBuW/uamsshoEsvp4DIobzXYn4lLfe2nmuLGwhgs
         RczgVcWwNgXIcNXARRup9BcQ9NejEaN4J15p4wPMs0NtIQbckHW4WMpR1t/lMpJm0AJ8
         dUR+Lp4fLbjdv+wlX/53mJ6UZkjd75J7FVQ9+GIywPkne8U8Leqq8UdXXVboOgO/1IKP
         U08Cv9uIlGnX8z1/XDZXsMnVw74bypyeQw1fLTDSY95M9BEn+UINFxsgXt/r6KE15Ljt
         30Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766431770; x=1767036570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y0HZvemBGrTiy88qS3/KTaFBN6UnJEpXmvRl4aHyOPA=;
        b=DcCR20xDuUVu8smAVcGWxNCnQ1XgtFUstscHGBHiOn/VDjNHlki5PS/dqzaaOLWm+k
         JxujAeoQRfCTuRMHaK+K8gtCulTivX1tpEXX10+0LwPIc397o599WDYKrasc3mRv2G/Y
         VMKpcbxxHXrIBIyGnOxjEUYcSEzCyiKyPYrIVGKkXRhsfpAB3ahjP5HNupdPzNDfTqrS
         Nbs4vJIalGw1pMo2F5GdPRD2i+6SixHqLFtp0O2/FI+fEfjcmBOk9epiyKsosKZS3Rd0
         eMqdt5wGlHX82BdKdB5vJCztlZDRI6pwq3cs4IGd2jWd1L/pDxqZLImcdtrNJYlQOuB1
         j0NA==
X-Forwarded-Encrypted: i=1; AJvYcCWv9Hv/n9CKLVk0e7oe3jL+rnY2mBM5f3h1SWDzIFlRLm+v0jO+TKnLH6Zb14T/FHImaVi4Oj5IOgWVQapvpuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxsVgZCBDjytXCb5HvHJOUMoO5c0vAtIQ6+puunxF7iiQhCezw
	Q4l9uPBENfLktBoZ5yVdbkO/hojOGk6iWaSRF3ghXVWilQ+zxu6eBKXfFvH59y6qFcO7k2NqR4/
	AmLhSE1nNuRSUtiYC9LG0jHwe7fmweR4=
X-Gm-Gg: AY/fxX5lBD45Nv2sBf/EWBgcuW0SgP5/qZDSr8BjGG0lg3pU81qOP9SzYzgnU05jE2q
	jQ0H06SncNMceW+H5IhLMrA1BIHiv5Uuj9Ns6W8EJRkP8cVAEQV9+isFkKQ6bZlAHG9grufZbRx
	w3tr12v5fyE7uf8pNA7NjvXmi7LBRg4BjfTOro3Ln62FQ91UezpqgIPwjM4jdRHYUX24iwn2TQA
	SRHcbloItvxU2zt+7C0X9YU0WQq0N64XGrrK9ciJ6xjp6LJl4zp413xIHrt3/SFWfam98Q=
X-Google-Smtp-Source: AGHT+IFN7r6MdsN+3u+BWquyqDiAUfI+IXjZ78DS8TNKJjhl/MtcmlawVNvxSFgEW+f6oLFDkN8lhc1JOLCQ/pq1OA8=
X-Received: by 2002:a05:690c:6187:b0:786:62bb:f6f5 with SMTP id
 00721157ae682-78fb3f36848mr215482237b3.17.1766431769660; Mon, 22 Dec 2025
 11:29:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251220-helper_proto-v1-0-2206e0d9422d@gmail.com>
In-Reply-To: <20251220-helper_proto-v1-0-2206e0d9422d@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 22 Dec 2025 11:29:17 -0800
X-Gm-Features: AQt7F2pDre-9Uf33VZRt52PeSiSug36qR3S9wTTSvNriR_c0NcOhfhR59Bftfrw
Message-ID: <CAMB2axPpB7Km=_7J_QTcQV8SvuFMKqg-_fCyRHEZKNfr7WL2Gg@mail.gmail.com>
Subject: Re: [RFC bpf PATCH 0/2] bpf: Fix memory access tags in helper prototypes
To: Zesen Liu <ftyghome@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Shuran Liu <electronlsr@gmail.com>, 
	Peili Gao <gplhust955@gmail.com>, Haoran Ni <haoran.ni.cs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 20, 2025 at 3:35=E2=80=AFAM Zesen Liu <ftyghome@gmail.com> wrot=
e:
>
> Hi,
>
> This series adds missing memory access tags (MEM_RDONLY or MEM_WRITE) to
> several bpf helper function prototypes that use ARG_PTR_TO_MEM but lack t=
he
> correct type annotation.
>
> Missing memory access tags in helper prototypes can lead to critical
> correctness issues when the verifier tries to perform code optimization.
> After commit 37cce22dbd51 ("bpf: verifier: Refactor helper access type
> tracking"), the verifier relies on the memory access tags, rather than
> treating all arguments in helper functions as potentially modifying the
> pointed-to memory.
>
> We have already seen several reports regarding this:
>
> - commit ac44dcc788b9 ("bpf: Fix verifier assumptions of bpf_d_path's
>    output buffer") adds MEM_WRITE to bpf_d_path;
> - commit 2eb7648558a7 ("bpf: Specify access type of bpf_sysctl_get_name
>    args") adds MEM_WRITE to bpf_sysctl_get_name.
>
> This series looks through all prototypes in the kernel and completes the
> tags. In addition, this series also adds selftests for some of these
> functions.
>
> I marked the series as RFC since the introduced selftests are fragile and
> ad hoc (similar to the previously added selftests). The original goal of
> these tests is to reproduce the case where the verifier wrongly optimizes
> reads after the helper function is called. However, triggering the error
> often requires carefully designed code patterns. For example, I had to
> explicitly use "if (xx !=3D 0)" in my attached tests, because using memcm=
p
> will not reproduce the issue. This makes the reproduction heavily depende=
nt
> on the verifier's internal optimization logic and clutters the selftests
> with specific, unnatural patterns.
>
> Some cases are also hard to trigger by selftests. For example, I couldn't
> find a triggering pattern for bpf_read_branch_records, since the
> execution of program seems to be messed up by wrong tags. For
> bpf_skb_fib_lookup, I also failed to reproduce it because the argument
> needs content on entry, but the verifier seems to only enable this
> optimization for fully empty buffers.
>
> Since adding selftests does not help with existing issues or prevent futu=
re
> occurrences of similar problems, I believe one way to resolve it is to
> statically restrict ARG_PTR_TO_MEM from appearing without memory access
> tags. Using ARG_PTR_TO_MEM alone without tags is nonsensical because:
>
> - If the helper does not change the argument, missing MEM_RDONLY causes
>    the verifier to incorrectly reject a read-only buffer.

Perhaps you are conflating one of your proposals here? This is fine
currently. ARG_PTR_TO_MEM without any annotation is viewed as BPF_READ
so passing a read-only buffer should work.

> - If the helper does change the argument, missing MEM_WRITE causes the
>    verifier to incorrectly assume the memory is unchanged, leading to
>    potential errors.
>
> I am still wondering, if we agree on the above, how should we enforce thi=
s
> restriction? Should we let ARG_PTR_TO_MEM imply MEM_WRITE semantics by
> default, and change ARG_PTR_TO_MEM | MEM_RDONLY to ARG_CONST_PTR_TO_MEM? =
Or
> should we add a check in the verifier to ensure ARG_PTR_TO_MEM always com=
es
> with an access tag (though this seems to only catch errors at
> runtime/testing)?

I think it is better to make the MEM_WRITE, MEM_RDONLY annotation
explicit and check it in the verifier.

Flipping the default MEM_RDONLY semantic to MEM_WRITE does not prevent
a similar bug in the future when we have helpers/optimizations/checks
rely on an implicit semantic.

>
> Any insights and comments are welcome. If the individual fix patches for
> the prototypes look correct, I would also really appreciate it if they
> could be merged ahead of the discussion.
>
> Thanks,
>
> Zesen Liu
>
> Signed-off-by: Zesen Liu <ftyghome@gmail.com>
> ---
> Zesen Liu (2):
>       bpf: Fix memory access tags in helper prototypes
>       selftests/bpf: add regression tests for snprintf and get_stack help=
ers
>
>  kernel/bpf/helpers.c                                      |  2 +-
>  kernel/trace/bpf_trace.c                                  |  6 +++---
>  net/core/filter.c                                         |  8 ++++----
>  tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c | 15 +++++++++=
++++--
>  tools/testing/selftests/bpf/prog_tests/snprintf.c         |  6 ++++++
>  tools/testing/selftests/bpf/prog_tests/snprintf_btf.c     |  3 +++
>  tools/testing/selftests/bpf/progs/netif_receive_skb.c     | 13 +++++++++=
+++-
>  tools/testing/selftests/bpf/progs/test_get_stack_rawtp.c  | 11 +++++++++=
+-
>  tools/testing/selftests/bpf/progs/test_snprintf.c         | 12 +++++++++=
+++
>  9 files changed, 64 insertions(+), 12 deletions(-)
> ---
> base-commit: 22cc16c04b7893d8fc22810599f49a305d600b9e
> change-id: 20251220-helper_proto-fb6e64182467
>
> Best regards,
> --
> Zesen Liu <ftyghome@gmail.com>
>
>

