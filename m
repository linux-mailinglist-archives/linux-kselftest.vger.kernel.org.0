Return-Path: <linux-kselftest+bounces-2775-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8A78290DF
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 00:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31D0B282861
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jan 2024 23:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8423E47B;
	Tue,  9 Jan 2024 23:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwcmJ5H/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601F93EA62;
	Tue,  9 Jan 2024 23:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a29058bb2ceso384788166b.0;
        Tue, 09 Jan 2024 15:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704843259; x=1705448059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qX1ewcRi9+LjX0JTHbz7fHSdfXgrgBVhsz1cgwry0mw=;
        b=TwcmJ5H/CCBejHsbSJsUIIXXe1NoJWDPThyVQL4Hj1qmh6g2vH3Wl2lRPaZOErBxN7
         wJa1PuKdk2/LpZtycgbFIBOrKMhbDK7VcMxzjCs1F+u0ToKnMnS0PREEXUYn+jOxewY4
         ULQCUgwwYVjXkGr6xvRz0AMKu6Eoo0lIvAr67OtXzwFVHBkNIz0nIgOAH3IdThf4b0ay
         BLwirky1BzLxATdplPprCeOb3eWgpYyab+SYrSw9QwHYuOHrkw4MIXA9INLsxSexs0Wr
         FoadUIPKeNgKjHRulboWNMYZunLHrueit+lwWAyA8utnK4tAiLaqxxG1lliNIcOIrhJK
         X5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704843259; x=1705448059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qX1ewcRi9+LjX0JTHbz7fHSdfXgrgBVhsz1cgwry0mw=;
        b=IZVYc0JA+HBu72/dG61uKj2ThP0cxNtVOqaIjs0kEa7NgRzN7XghPXoPwQgIlnv7rQ
         cJndTgN+XgQv9vUdmUpqXUe+oQg4NH2ZnXWcPcB2rlEchpv2nTfgzNWmNfZPYKrPKeBH
         CPSVsEOTMcvTyl3/wBwWwqqwTUfoxx6jMAwdJtieQGL777EaYIgcXaINFqu3oQ57eYYa
         krxhgCFM4tLFeJswCAgIVvIxG0zA9ZX3jHYmA24i/bNBtdpNgLnwz2GAc9Qh6cs8Eda8
         87Yqt/FrZoEaLHlSvse2QKZ7f5xwpK3YYCaJGFsPaLNKq7nE6K58PlyAR46PAzTMW/zx
         fzag==
X-Gm-Message-State: AOJu0YxJpZTK2Kr5x6JcGny0/JxMgpf7kSbLBhlS45peJF5CJcFz2kyn
	WtiP53JY0G/99sN42lsxs4sCTZ1iznZ3IWWEHWs=
X-Google-Smtp-Source: AGHT+IEolD6rNbK/9LXoRCkzJISyZmEC/n35sT5Uk5TZ3EjiNF6a8fznWwfsfr1WTmumc14WcGyOsNBDBULSDfyEVkc=
X-Received: by 2002:a17:906:e095:b0:a2a:c162:4e8b with SMTP id
 gh21-20020a170906e09500b00a2ac1624e8bmr58196ejb.207.1704843259335; Tue, 09
 Jan 2024 15:34:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108205209.838365-1-maxtram95@gmail.com> <20240108205209.838365-10-maxtram95@gmail.com>
In-Reply-To: <20240108205209.838365-10-maxtram95@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 9 Jan 2024 15:34:07 -0800
Message-ID: <CAEf4Bzb4Gy1CTE7ebjA6b2vtZ7dhZnpsw25YnGTx6y2rYYFmcw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 09/15] selftests/bpf: Test assigning ID to
 scalars on spill
To: Maxim Mikityanskiy <maxtram95@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, Maxim Mikityanskiy <maxim@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 12:53=E2=80=AFPM Maxim Mikityanskiy <maxtram95@gmail=
.com> wrote:
>
> From: Maxim Mikityanskiy <maxim@isovalent.com>
>
> The previous commit implemented assigning IDs to registers holding
> scalars before spill. Add the test cases to check the new functionality.
>
> Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  .../selftests/bpf/progs/verifier_spill_fill.c | 133 ++++++++++++++++++
>  1 file changed, 133 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/to=
ols/testing/selftests/bpf/progs/verifier_spill_fill.c
> index f303ac19cf41..b05aab925ee5 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
> @@ -766,4 +766,137 @@ l0_%=3D:    r0 =3D 0;                              =
           \
>         : __clobber_all);
>  }
>

[...]

> +
> +SEC("xdp")
> +__description("8-bit spill of 8-bit reg should assign ID")
> +__success __retval(0)
> +__naked void spill_8bit_of_8bit_ok(void)
> +{
> +       asm volatile ("                                 \
> +       /* Roll one bit to make the register inexact. */\
> +       call %[bpf_get_prandom_u32];                    \
> +       r0 &=3D 0x80;                                     \
> +       /* 8-bit spill r0 to stack - should assign an ID. */\
> +       *(u8*)(r10 - 8) =3D r0;                           \
> +       /* 8-bit fill r1 from stack - should preserve the ID. */\
> +       r1 =3D *(u8*)(r10 - 8);                           \
> +       /* Compare r1 with another register to trigger find_equal_scalars=
.\
> +        * Having one random bit is important here, otherwise the verifie=
r cuts\
> +        * the corners.                                 \
> +        */                                             \
> +       r2 =3D 0;                                         \
> +       if r1 !=3D r2 goto l0_%=3D;                         \
> +       /* The result of this comparison is predefined. */\
> +       if r0 =3D=3D r2 goto l0_%=3D;                         \
> +       /* Dead branch: the verifier should prune it. Do an invalid memor=
y\
> +        * access if the verifier follows it.           \
> +        */                                             \
> +       r0 =3D *(u64*)(r9 + 0);                           \
> +       exit;                                           \
> +l0_%=3D: r0 =3D 0;                                         \
> +       exit;                                           \
> +"      :
> +       : __imm(bpf_get_prandom_u32)
> +       : __clobber_all);
> +}
> +

Can you add a test where we spill register of one size and fill a
different size? And what should the behavior be? Should we or should
we not preserve linked IDs in such situation?

>  char _license[] SEC("license") =3D "GPL";
> --
> 2.43.0
>

