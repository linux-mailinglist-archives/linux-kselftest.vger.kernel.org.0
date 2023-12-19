Return-Path: <linux-kselftest+bounces-2233-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB34B818FE8
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 19:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A78A72871C6
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 18:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D233837D3B;
	Tue, 19 Dec 2023 18:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrFAo0fA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC8737D1D;
	Tue, 19 Dec 2023 18:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2cc6d9b4c6aso35549621fa.3;
        Tue, 19 Dec 2023 10:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703011288; x=1703616088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMdZ40wSCenjfx+wg1kZyop7OZDfIHjeq7ht6ib7e58=;
        b=LrFAo0fA0GVX+TjvOog9lx+hzp8u5RcsMeJjpmMbJI5wUCN2x59foAyHCPN3EYAynp
         L+atLSSgqUaM191nmGK0VnmZeAlC732EDczeukqSFqDRSi2E+H/vB6y9mmjHVAmZ2fJx
         qw8sWgEE2pOah9i9Y+pqOuTDznNOdy47EMCeyqnjc5ozvWmBq61O6kC+VSrILSGX9GLF
         8bFyVAGCJIvE4Nm/0/146r2OztdjNjVaFTfs6rsvMmk6zdwfhmhtJEkuUgkLvXwjt4hc
         tGVZVMhmyDzM7mJiz2Wjo3HDbWs+I1IpYfSzgo7raJvKOJOChAdog1W99KeTuiZ71Uun
         w9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703011288; x=1703616088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kMdZ40wSCenjfx+wg1kZyop7OZDfIHjeq7ht6ib7e58=;
        b=AcAWjZVNkjudOwJ0fklc40Xf60ndEkqAT1Y61NPq92xoeMivGoX95RhqssilY2yNzQ
         wOEBG+Ig5ODsIRsoo8CM5pqZp3T7qKRWQq96FhqDs2Vs31Na0pA+QnY6k8La8eQIDPFk
         w9Tl80F+UsawKTl0rQH65M8KEzNztzRI0rLMTVTuXR1Sjy+knEOrSTHMdpd4CsIb4l46
         H8CDqWw1lHCsCcQ2GPT/3XtYD/hEg1/hr/QmDgquPZqeiyCpr+a2/zd92z8zEs/EDmQw
         EGmtBg3HyH5ZXz0BZPjGeIqsv/MPR/+jA28PIk0VD+qM9bkIWhZjVTQcjdjQJ5IGckj9
         aMoQ==
X-Gm-Message-State: AOJu0Yyk8IRqeA6Ko5lXIb5dTTRRdfS2dcJAFw+9ENkrXpZ+Nn8Q5DE2
	+ubzjhVTOrGqUO4DbCf47XcPnqqK5Nukv+Ub3QI=
X-Google-Smtp-Source: AGHT+IHUw0CcZFkNLywf6O690h0anpGra+BYQP/c1DIrce93Wvjw6YbdNc2ityhdz7/V+zUNFbIxmlChXCzghuqE9Kk=
X-Received: by 2002:a2e:b0d6:0:b0:2cc:84ea:d2b0 with SMTP id
 g22-20020a2eb0d6000000b002cc84ead2b0mr639945ljl.72.1703011288002; Tue, 19 Dec
 2023 10:41:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219134800.1550388-1-menglong8.dong@gmail.com> <20231219134800.1550388-4-menglong8.dong@gmail.com>
In-Reply-To: <20231219134800.1550388-4-menglong8.dong@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 19 Dec 2023 10:41:16 -0800
Message-ID: <CAEf4BzaUJq7ekynLgGZyMfe3cmoQaRs+0Hfpk_12KpLfXN_6iw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 3/4] selftests/bpf: activate the OP_NE logic
 in range_cond()
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev, 
	alexei.starovoitov@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	mykolal@fb.com, shuah@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 5:50=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> The edge range checking for the registers is supported by the verifier
> now, so we can activate the extended logic in
> tools/testing/selftests/bpf/prog_tests/reg_bounds.c/range_cond() to test
> such logic.
>
> Besides, I added some cases to the "crafted_cases" array for this logic.
> These cases are mainly used to test the edge of the src reg and dst reg.
>
> All reg bounds testings has passed in the SLOW_TESTS mode:
>
> $ export SLOW_TESTS=3D1 && ./test_progs -t reg_bounds -j
> Summary: 65/18959832 PASSED, 0 SKIPPED, 0 FAILED
>

Thanks for running SLOW_TESTS=3D1 mode as well!

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>
> ---
> v5:
> - add "{U32, U32, {0, U32_MAX}, {U32_MAX, U32_MAX}}"
> v4:
> - remove reduplicated s32 casting
> v3:
> - do some adjustment to the crafted cases that we added
> v2:
> - add some cases to the "crafted_cases"
> ---
>  .../selftests/bpf/prog_tests/reg_bounds.c     | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/=
testing/selftests/bpf/prog_tests/reg_bounds.c
> index 3bf4ddd720a8..820d0bcfc474 100644
> --- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> +++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
> @@ -590,12 +590,7 @@ static void range_cond(enum num_t t, struct range x,=
 struct range y,
>                 *newy =3D range(t, max_t(t, x.a, y.a), min_t(t, x.b, y.b)=
);
>                 break;
>         case OP_NE:
> -               /* generic case, can't derive more information */
> -               *newx =3D range(t, x.a, x.b);
> -               *newy =3D range(t, y.a, y.b);
> -               break;
> -
> -               /* below extended logic is not supported by verifier just=
 yet */
> +               /* below logic is supported by the verifier now */
>                 if (x.a =3D=3D x.b && x.a =3D=3D y.a) {
>                         /* X is a constant matching left side of Y */
>                         *newx =3D range(t, x.a, x.b);
> @@ -2101,6 +2096,18 @@ static struct subtest_case crafted_cases[] =3D {
>         {S32, S64, {(u32)S32_MIN, (u32)(s32)-255}, {(u32)(s32)-2, 0}},
>         {S32, S64, {0, 1}, {(u32)S32_MIN, (u32)S32_MIN}},
>         {S32, U32, {(u32)S32_MIN, (u32)S32_MIN}, {(u32)S32_MIN, (u32)S32_=
MIN}},
> +
> +       /* edge overlap testings for BPF_NE */
> +       {U64, U64, {0, U64_MAX}, {U64_MAX, U64_MAX}},
> +       {U64, U64, {0, U64_MAX}, {0, 0}},
> +       {S64, U64, {S64_MIN, 0}, {S64_MIN, S64_MIN}},
> +       {S64, U64, {S64_MIN, 0}, {0, 0}},
> +       {S64, U64, {S64_MIN, S64_MAX}, {S64_MAX, S64_MAX}},
> +       {U32, U32, {0, U32_MAX}, {0, 0}},
> +       {U32, U32, {0, U32_MAX}, {U32_MAX, U32_MAX}},
> +       {S32, U32, {(u32)S32_MIN, 0}, {0, 0}},
> +       {S32, U32, {(u32)S32_MIN, 0}, {(u32)S32_MIN, (u32)S32_MIN}},
> +       {S32, U32, {(u32)S32_MIN, S32_MAX}, {S32_MAX, S32_MAX}},
>  };
>
>  /* Go over crafted hard-coded cases. This is fast, so we do it as part o=
f
> --
> 2.39.2
>

