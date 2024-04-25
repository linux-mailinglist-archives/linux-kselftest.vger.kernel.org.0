Return-Path: <linux-kselftest+bounces-8875-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEF58B286D
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 20:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ED651C20F66
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 18:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B661509A0;
	Thu, 25 Apr 2024 18:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/pJNHaD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547FB12C463;
	Thu, 25 Apr 2024 18:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714070841; cv=none; b=kiDNUvko9cdYhfInhT6Z19NBXZOkh1rp3j6UoNNign9//PrOF/g3fgzYxgCE2Qe6uTJ1I/i7W5ymu7EOKRxOrLxfNfA3VlREdseVH+8UbX1Fd+J88+495M5JuQSbcOm/fh3/pp/2t1ufyQumlU1NTlMMvgtVHb50XdD+Z863dMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714070841; c=relaxed/simple;
	bh=S4xvnHUvBB90xjVzYpSENySerWGU9OH6zu0+wXBxrtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eSA6pu2lT7o2/xQiGPUPpW5TUffi8GaChLQP5SRhdKyxUO/hAtzwFI2wVxfxhMDPL04PKj5gIkve1Hy+IHON300DzG0TWhMPK9aIyLPiUNcDSbsORb8fyTwqvLbTDq1rQ10FOrpGIYPjZhqFq/kOfWSS1Mi/uiWwTy1UmdnElBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/pJNHaD; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2a55a3d0b8eso1020313a91.1;
        Thu, 25 Apr 2024 11:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714070839; x=1714675639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPaljcKfIZZBXdn83CKlOXDtgwIFt/u/P7+aDOyMeQQ=;
        b=P/pJNHaD0M334bS2InRVGioqYJQLIs6naDkNXZSCOTGXTMDcC37mEwEXeIxf41gpbd
         UwuRO1r6gefBm8odn7MsRqET2ERun1IfZO20PKKkaJUZ8Omp0qm/s4JqLIPM/8TdlI0q
         OToQ/iiWKkWi98Bh5u77Hxtp+W6Wtp7dBqQBWP8xUgWyw/rlDyoKZKGctIZd3p2o2wqf
         Tvv+gcw25uEkv7vQKFMGhiq7bfqWJoZfU92JhYm2942NwnweYlZNG1PyngM/hXQ6iBaC
         N9zcFUbEmL7SsZCXn9I5FQq+Ek9IUuhUvb/OZOxOqx1sxM2pqiNpQG6qQvmRo817Lilo
         Zz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714070839; x=1714675639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SPaljcKfIZZBXdn83CKlOXDtgwIFt/u/P7+aDOyMeQQ=;
        b=GEb60q2/X5fGS8XJBav77VgaEpIkmqDJJBRGuH7XMfv25NoKOW8TDc7EgGcbwN9Il0
         MlmnYrk2/ibTLjhkBXEvpD3ZViSIuOueRViRf+FCCn4PX2ZNd9nxljJIJDCp39u6jeFf
         /tSdqHYtOPuaKmtPpQspNlVrzl5hXP1JJaAwDs7NBku5hwxsXsZOIGsKtcPGYEWu5jKx
         1FkEUi5i5zg4c83U+ARqYotVcuzZLMoRO54+GgPOBq5u5fTckrEJXuDxj7tNsHy005Fm
         Ks6p/v3W255x5BbFYuHBAPy+iFBpx+sLPZwYnm0W/WXEofHEx0s/w7l+IYrHL+tO3Nbo
         HkEA==
X-Forwarded-Encrypted: i=1; AJvYcCUnuAgyemmeXYORXX9Tg3H03KwTXybSDp4s5Y+YhaZAgzR9aRzYwCHLQH4fxuGGNbdmrIyZPwhz7WCpjHnkNZp7J1fOwCAs9Igrypv+xnEJUYUWHfnJXZHHckSzg0Bt1umu2XwAuypCJ/OPHCYXIvwujQkh9DZcFAUrVh7R9uj0AWO/
X-Gm-Message-State: AOJu0YzARLtm9axhyp/2xrQIoaPrTx2OYFQJxQCcRMOC/6QzgEGHXRHd
	fr60F1nuGtiuCbWO8ixa/pqfePjVQTKZ0Qz9Z54ocTmjQZNj7SwvG/bmloqgFxJryzFE5bvy9Vd
	rDyusFO3yiXXjM0KD8Rouhk3oFcA=
X-Google-Smtp-Source: AGHT+IEf5AiTIISI4IuWekz5lxkvpRfzZpLQqNfqfJZSF8RWgRQKvMfXouSG3cGPr473IFjFX56hSJUmBPMRKDOcYUU=
X-Received: by 2002:a17:90b:1d8f:b0:2a7:8674:a0c8 with SMTP id
 pf15-20020a17090b1d8f00b002a78674a0c8mr5307305pjb.1.1714070839451; Thu, 25
 Apr 2024 11:47:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425140627.112728-1-andrea.righi@canonical.com>
In-Reply-To: <20240425140627.112728-1-andrea.righi@canonical.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Apr 2024 11:47:07 -0700
Message-ID: <CAEf4BzYO=yo15WidtJqe_QaMrj+h7VUyufw7xN2XS0GG8Xh8fQ@mail.gmail.com>
Subject: Re: [PATCH v3] selftests/bpf: Add ring_buffer__consume_n test.
To: Andrea Righi <andrea.righi@canonical.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 7:06=E2=80=AFAM Andrea Righi <andrea.righi@canonica=
l.com> wrote:
>
> Add a testcase for the ring_buffer__consume_n() API.
>
> The test produces multiple samples in a ring buffer, using a
> sys_getpid() fentry prog, and consumes them from user-space in batches,
> rather than consuming all of them greedily, like ring_buffer__consume()
> does.
>
> Link: https://lore.kernel.org/lkml/CAEf4BzaR4zqUpDmj44KNLdpJ=3DTpa97Grvzu=
zVNO5nM6b7oWd1w@mail.gmail.com
> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> ---
>  tools/testing/selftests/bpf/Makefile          |  2 +-
>  .../selftests/bpf/prog_tests/ringbuf.c        | 64 +++++++++++++++++++
>  .../selftests/bpf/progs/test_ringbuf_n.c      | 47 ++++++++++++++
>  3 files changed, 112 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/test_ringbuf_n.c
>
> ChangeLog v2 -> v3:
>  - move skel_n inside ringbuf_n_subtest()
>
> ChangeLog v1 -> v2:
>  - replace CHECK() with ASSERT_EQ()
>  - fix skel -> skel_n
>  - drop unused "seq" field from struct sample
>

[...]

> +       /* Produce N_TOT_SAMPLES samples in the ring buffer by calling ge=
tpid() */
> +       skel_n->bss->value =3D SAMPLE_VALUE;
> +       for (i =3D 0; i < N_TOT_SAMPLES; i++)
> +               syscall(__NR_getpgid);
> +
> +       /* Consume all samples from the ring buffer in batches of N_SAMPL=
ES */
> +       for (i =3D 0; i < N_TOT_SAMPLES; i +=3D err) {
> +               err =3D ring_buffer__consume_n(ringbuf, N_SAMPLES);
> +               ASSERT_EQ(err, N_SAMPLES, "rb_consume");

if something goes wrong and err is < 0, we might end up with a very
long loop. I changed this to:

if (!ASSERT_EQ(...))
    goto cleanup_ringbuf;

to avoid this problem

> +       }
> +
> +cleanup_ringbuf:
> +       ring_buffer__free(ringbuf);
> +cleanup:
> +       test_ringbuf_n_lskel__destroy(skel_n);
> +}
> +

[...]

