Return-Path: <linux-kselftest+bounces-2234-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13556818FEB
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 19:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 375941C212C6
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 18:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DD01E53F;
	Tue, 19 Dec 2023 18:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NswedWTY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BC039844;
	Tue, 19 Dec 2023 18:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-54cd2281ccbso5882484a12.2;
        Tue, 19 Dec 2023 10:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703011335; x=1703616135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCrX3qiI8WCM7ZsJgc9YWSG5N+XDfTNhl1gXS8XnkOk=;
        b=NswedWTY9XVuJQo0FdIAtQCL/Cb9R+Za0gnUs9X1mwcyrirnmAjMbz+86W6VoHxww4
         666ggrUArSeBZxSilC5gg18834dYINcAlpNXanr5g03CaqXZB19stO8AgP6lCzfPFTdj
         TRXS6Tylh9C9lPOISFYcOwS0UR7Ei2sVxsj7yq5mvt6tQRICGhC31G1SM5MGaaZ0gwV+
         1MSR4fSd4eFhwDlROKlLdyvzDxCeGK5v4dKBMWSP70YOb+e2LId4kJgkmRS2dWZDW0Y/
         vFeQnG/glAcbYXe3xOfwCP/a40OuIc41LTbUxwAyzCoXTkSW4nfHiO9IEmtYql5J0McG
         FTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703011335; x=1703616135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zCrX3qiI8WCM7ZsJgc9YWSG5N+XDfTNhl1gXS8XnkOk=;
        b=CQdgSil41qDpEeYx5mf58DB3ewNbmR8/f6JCZ3LSsC3WunPtvaYAL75xLlZLWPyB13
         RIXZ7c6t8eQy3Zbkdc20dxeouGFf1WPqRZiHvYdyht7/6tpCFzhVJx9Dtx/hkfv/RLzL
         udSfoRb8S+lGHGKGAhswtPqYIIl+WBnPtmi1BRF8vmu6jmzIG7LZUPTxIFoBgiIwUFoo
         fQ/844NbpNQI3Z97DinBP+vt1cLy4Q5KzMQiKzrH4MXcsIESuJToB8mnlYCIeEbuHKwv
         NYk9tAsTLXvQenlSxaKYuuYIV9+Qsu26452ucvuCPbcJfxDyy6hyyhK5noeZThYRQG2/
         FLtw==
X-Gm-Message-State: AOJu0YyTE2ps4Yl3yh3uA7+AdqYaHWbmeoVxIYazgKlrCwZbP7iIDKDx
	S1jyQX0vNeayP2fttlqfCvOkLdWFihb8QUMPu8DMwk6b+tQ=
X-Google-Smtp-Source: AGHT+IFqy1ss0sMOr41W+1UaXtmSUn5QowHwgPrtGgzUF+fIe+nNJQ1fW5EThcRquYfibrKxpTMs1nmS1GdtXWSaWEc=
X-Received: by 2002:a17:906:81d2:b0:a23:74a3:b6cd with SMTP id
 e18-20020a17090681d200b00a2374a3b6cdmr720028ejx.148.1703011334814; Tue, 19
 Dec 2023 10:42:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219134800.1550388-1-menglong8.dong@gmail.com> <20231219134800.1550388-5-menglong8.dong@gmail.com>
In-Reply-To: <20231219134800.1550388-5-menglong8.dong@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 19 Dec 2023 10:42:03 -0800
Message-ID: <CAEf4BzYN2Mdx6zY01Uq3Kod41j96H3WfuN=PjCcOO=ZrUbVB9w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 4/4] selftests/bpf: add testcase to
 verifier_bounds.c for BPF_JNE
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev, 
	alexei.starovoitov@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	mykolal@fb.com, shuah@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 5:51=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> Add testcase for the logic that the verifier tracks the BPF_JNE for regs.
> The assembly function "reg_not_equal_const()" and "reg_equal_const" that
> we add is exactly converted from the following case:
>
>   u32 a =3D bpf_get_prandom_u32();
>   u64 b =3D 0;
>
>   a %=3D 8;
>   /* the "a > 0" here will be optimized to "a !=3D 0" */
>   if (a > 0) {
>     /* now the range of a should be [1, 7] */
>     bpf_skb_store_bytes(skb, 0, &b, a, 0);
>   }
>
> Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>
> ---
> v5:
> - add some comments to the function that we add
> - add reg_not_equal_const()
> ---
>  .../selftests/bpf/progs/verifier_bounds.c     | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/=
testing/selftests/bpf/progs/verifier_bounds.c
> index ec430b71730b..960998f16306 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> @@ -1075,4 +1075,66 @@ l0_%=3D:   r0 =3D 0;                              =
           \
>         : __clobber_all);
>  }
>
> +SEC("tc")
> +__description("bounds check with JMP_NE for reg edge")
> +__success __retval(0)
> +__naked void reg_not_equal_const(void)
> +{
> +       asm volatile ("                                 \
> +       r6 =3D r1;                                        \
> +       r1 =3D 0;                                         \
> +       *(u64*)(r10 - 8) =3D r1;                          \
> +       call %[bpf_get_prandom_u32];                    \
> +       r4 =3D r0;                                        \
> +       r4 &=3D 7;                                        \
> +       if r4 !=3D 0 goto l0_%=3D;                          \
> +       r0 =3D 0;                                         \
> +       exit;                                           \
> +l0_%=3D: r1 =3D r6;                                        \
> +       r2 =3D 0;                                         \
> +       r3 =3D r10;                                       \
> +       r3 +=3D -8;                                       \
> +       r5 =3D 0;                                         \
> +       /* The 4th argument of bpf_skb_store_bytes is defined as \
> +        * ARG_CONST_SIZE, so 0 is not allowed. The 'r4 !=3D 0' \
> +        * is providing us this exclusion of zero from initial \
> +        * [0, 7] range.                                \
> +        */                                             \
> +       call %[bpf_skb_store_bytes];                    \
> +       r0 =3D 0;                                         \
> +       exit;                                           \
> +"      :
> +       : __imm(bpf_get_prandom_u32),
> +         __imm(bpf_skb_store_bytes)
> +       : __clobber_all);
> +}
> +
> +SEC("tc")
> +__description("bounds check with JMP_EQ for reg edge")
> +__success __retval(0)
> +__naked void reg_equal_const(void)
> +{
> +       asm volatile ("                                 \
> +       r6 =3D r1;                                        \
> +       r1 =3D 0;                                         \
> +       *(u64*)(r10 - 8) =3D r1;                          \
> +       call %[bpf_get_prandom_u32];                    \
> +       r4 =3D r0;                                        \
> +       r4 &=3D 7;                                        \
> +       if r4 =3D=3D 0 goto l0_%=3D;                          \
> +       r1 =3D r6;                                        \
> +       r2 =3D 0;                                         \
> +       r3 =3D r10;                                       \
> +       r3 +=3D -8;                                       \
> +       r5 =3D 0;                                         \
> +       /* Just the same as what we do in reg_not_equal_const() */ \
> +       call %[bpf_skb_store_bytes];                    \
> +l0_%=3D: r0 =3D 0;                                         \
> +       exit;                                           \
> +"      :
> +       : __imm(bpf_get_prandom_u32),
> +         __imm(bpf_skb_store_bytes)
> +       : __clobber_all);
> +}
> +
>  char _license[] SEC("license") =3D "GPL";
> --
> 2.39.2
>

