Return-Path: <linux-kselftest+bounces-2760-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8E3828B69
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jan 2024 18:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0DACB2130E
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jan 2024 17:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A433B790;
	Tue,  9 Jan 2024 17:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTN1lVvY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0D439FFB;
	Tue,  9 Jan 2024 17:45:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99345C433C7;
	Tue,  9 Jan 2024 17:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704822333;
	bh=iLrzdYBIYAF2icG88gnfun1VCs7gyCvoUntx2WxcflY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KTN1lVvYt+sxgLnAnShFtOh5SYiXBGLKW201AsN0rLeuIWwyT8JfgC7RkDmfc0Zqh
	 eB/RCuM5yG5AokQ3GaZwrzLdTB7fL7altDzzuFle66ftbVNwalS09GGpSOis/CVuNA
	 XkBLX9n0k6+L4AVD27kQ/uJcKqaFX7YM7tx3wKm9KRII7bgEUQJybwd2Nh7LojBneG
	 40A/a29VBdNxn4699Ckf89MEYJeuYspScPSXB1ulpJp84yzoHK1Wg8SR+wNJF3Bgzw
	 o4AGnCjPT9K+Gss3m1Xt7KFPge+LQGgPsp1jVqvKlcFpAVs/pW7CnWWIFpwGsKaEjd
	 2xLdYq3oDID5A==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50ea8fbf261so3518648e87.2;
        Tue, 09 Jan 2024 09:45:33 -0800 (PST)
X-Gm-Message-State: AOJu0YxUc4uG69dYeBJCQWkFw+Lz0Kg2IrnO3/Pt0WEOX1yKmGSLiZ0g
	xBuNIHuDC63Ly6NlKpevY9fIsyOUQNN+gea35t0=
X-Google-Smtp-Source: AGHT+IE6xl9/11+pJwbRZXMWjfKQh8kCA8gvAM5PMX16ALisz3EF6ZZBwrPXyifXN/8urgCTFvhA6BLsbaCK5mBWCyc=
X-Received: by 2002:a19:910d:0:b0:50e:7846:7acf with SMTP id
 t13-20020a19910d000000b0050e78467acfmr2231281lfd.34.1704822331809; Tue, 09
 Jan 2024 09:45:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109095637.35934-1-alessandro.carminati@gmail.com>
In-Reply-To: <20240109095637.35934-1-alessandro.carminati@gmail.com>
From: Song Liu <song@kernel.org>
Date: Tue, 9 Jan 2024 09:45:20 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4vDX70-n3n0wk4XsX7+-kmG=GZZ5PHBr=EO3A7Ju2kZg@mail.gmail.com>
Message-ID: <CAPhsuW4vDX70-n3n0wk4XsX7+-kmG=GZZ5PHBr=EO3A7Ju2kZg@mail.gmail.com>
Subject: Re: [RFC PATCH] find_vma BPF test: increase length CPU computation
To: "Alessandro Carminati (Red Hat)" <alessandro.carminati@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Shuah Khan <shuah@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 1:57=E2=80=AFAM Alessandro Carminati (Red Hat)
<alessandro.carminati@gmail.com> wrote:
>
> Some aarch64 systems running a PREEMPT_RT patched kernel, needs
> more time to complete the test.
> This change mirrors:
> commit ba83af059153 ("Improve stability of find_vma BPF test")
> addressing similar requirements and allowing the QTI SA8775P based
> systems, and others, to complete the test when running RT kernel.
>
> Signed-off-by: Alessandro Carminati (Red Hat) <alessandro.carminati@gmail=
.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/find_vma.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/find_vma.c b/tools/te=
sting/selftests/bpf/prog_tests/find_vma.c
> index 5165b38f0e59..43d62db8d57b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/find_vma.c
> +++ b/tools/testing/selftests/bpf/prog_tests/find_vma.c
> @@ -51,7 +51,7 @@ static void test_find_vma_pe(struct find_vma *skel)
>         struct bpf_link *link =3D NULL;
>         volatile int j =3D 0;
>         int pfd, i;
> -       const int one_bn =3D 1000000000;
> +       const int dummy_wait =3D 2500000000;

2500000000 is bigger than INT_MAX.

>
>         pfd =3D open_pe();
>         if (pfd < 0) {
> @@ -68,10 +68,10 @@ static void test_find_vma_pe(struct find_vma *skel)
>         if (!ASSERT_OK_PTR(link, "attach_perf_event"))
>                 goto cleanup;
>
> -       for (i =3D 0; i < one_bn && find_vma_pe_condition(skel); ++i)
> +       for (i =3D 0; i < dummy_wait && find_vma_pe_condition(skel); ++i)
>                 ++j;

So we will skip this loop. Right?

Thanks,
Song


>
> -       test_and_reset_skel(skel, -EBUSY /* in nmi, irq_work is busy */, =
i =3D=3D one_bn);
> +       test_and_reset_skel(skel, -EBUSY /* in nmi, irq_work is busy */, =
i =3D=3D dummy_wait);
>  cleanup:
>         bpf_link__destroy(link);
>         close(pfd);
> --
> 2.34.1
>

