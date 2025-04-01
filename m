Return-Path: <linux-kselftest+bounces-29995-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBCFA781E2
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 20:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEC153AF55D
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 18:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9AD20E32B;
	Tue,  1 Apr 2025 18:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6m9HUo5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDD81DDC28;
	Tue,  1 Apr 2025 18:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743530747; cv=none; b=FkSB8jH/hyGqH349sw90/QrEcOvJOCJwx+kc+ybhL1yS3bfIglPlZ+vJdmhirdtJ20lmUmvB6N+tN+3UmikqXMe9jfcNlzcNI2pOgcBdT053ZEeW4BIIe6FKQtDXadkCr+9HytKAZ3tUu6cR+ZaCTi0VIqjrD5/RXGYoLuMwAdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743530747; c=relaxed/simple;
	bh=j2ItC74CeCbbouvYFRtSAcPYoXQuBDkBa+rmnRCUvxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aNb+m8bO1ODQI9O4teyPlHO3PYhfxK1/Q8ZbHm67osihkfqbi3cZcx5M656p/6Zw4AoPCjUHRCKoYiMEdI/F6fPg887Zro5yenLnjtXRQIdyUZ4MS+9US8GvuSjqVi/6tJjbDkxeX56W9Mthx0iMjGKcD4wVPvlpNGRdk/YaAdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6m9HUo5; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6f768e9be1aso1178137b3.0;
        Tue, 01 Apr 2025 11:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743530744; x=1744135544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BoYrBmUYS1Fjt2+nydhXunhJyD1+jrRmHYe/TGOnFFw=;
        b=V6m9HUo5QtlwnncsBN2a+dve0mRJ7Jm+z6zVKmaBZWv9XLbNmYnuzTyHKmJBN1nBAI
         fXAMwb9BquR7v9ui552zr7zwkszwk8+Ioon33VBiX7E65OiwIRzEFVw/S588Xc52tsXj
         Pwzo1RjU5eD1reN1YTxFmnvtXqZmACxt4pS38zpO8RohGG4LBIxf8MLzpcsffxAFisKw
         tyr/TV7rlL05L5P3O8w3OTF44MkijQUKHfmf9oF7/8ZTapTz7OuAcKAQrCYCa9NRbelg
         +eaKcbz436Pyd0a4h48E9u2TlXP8AS+WH26skeKxW3BVbENuEGp3hT6i2OgaUFvnHjw9
         DNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743530744; x=1744135544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BoYrBmUYS1Fjt2+nydhXunhJyD1+jrRmHYe/TGOnFFw=;
        b=IL9uXmEYyx8R7M5zH72NjYxgB/EBWU1i8RllcD/MJJy8zxk5aGHVNq9aovPZekpoSN
         L/0RxJP9Ehmr29HocPrUIT5csWU1NLtA2wycNkWoyfI34M+cTkPpw6Ao3CgoCm6banm3
         uqJc6hGdszqEIJkwR8LK7xCTbkWBq5hUoduQSAFVkoI0A7MG2tgudtDw81Yk2vwI0Ml7
         oL+5bezjLZppQGKB5BuSksdQ+7RcxCaKPohkH5rb7zl91Z+tRY0U63HmlOTLtZNpx9a1
         rHD7WQCDmKNPB0yHYQ8nucyL1GvUNzradiGk2UxaPrT7TXDx2gLfEdEvgQCg2wN7ZVjJ
         /Eeg==
X-Forwarded-Encrypted: i=1; AJvYcCUOVaFd2/blGxUt3qUgO838E5EGCAn3mGJ7Z6TAv1v47VWD0LrB30glHBgs2chf7fGmc9qdV7bbQ8zsiqv5YoZX@vger.kernel.org, AJvYcCUvmestSby/KlXmGMPmbj6fvFI51cqnxwioOD+n/oObo4NHPK///bd7/H/SRlHcxcJMMqba9AJLi3/6MUur@vger.kernel.org, AJvYcCVflJoGEku45pYnUJXKojnQZDc8PDNMPHV4U2bcEcKYf52/3UAg8OtAPl/dLzEuFeiDwkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe9fUBehoqPLnoz1fmBP30Gnl/NWeg8IwITZehqV3gE1SOybyB
	iBWt8JZ7jHtq5KzsmbwmV34e9i1HdisASsr5HooGHKJkbC4Ti/tmETx36AR9NUaXbRIeQNZG4DM
	6E3b9tEFm80y363sFg9DlcJAnHTA=
X-Gm-Gg: ASbGncuLDCb/d/91Wgv8EgjTmK/TLU5cuf53tIgxZhT4/vKmAXMezNVcUAb6qgdTqjB
	taJqdDTPkGrxhPQAx6JFpfrhxOwcEbus1oSNeBKJ5WaekIv6Y/2wgbOxrCnzf0b1l7awoCRFlhq
	mhTIoeM9D+aev5X073FU2uE3ObgNAxSysH3lboW2q0sw==
X-Google-Smtp-Source: AGHT+IGMVbGaGvOYTg9+RQ9IAGG98GOlapvtbp7KooxcYZhgqUbq/MrtYvN7WFBm50vXzage8iz9PVqJmEAJFgznsZo=
X-Received: by 2002:a05:690c:6913:b0:6f9:47ad:f5f1 with SMTP id
 00721157ae682-703b66ed874mr14693837b3.17.1743530744515; Tue, 01 Apr 2025
 11:05:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401061546.1990156-1-nichen@iscas.ac.cn>
In-Reply-To: <20250401061546.1990156-1-nichen@iscas.ac.cn>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 1 Apr 2025 11:05:33 -0700
X-Gm-Features: AQ5f1JpOwg2Qo4yi4MGTCZ1zyArShoCogVd4mypKFbNMujca6CF07ZTLq3Qc6vY
Message-ID: <CAMB2axOa6D757_FGsW2i4xCDzNP7h+QUGMDvRtnx6EyNfjRBFA@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: Convert comma to semicolon
To: Chen Ni <nichen@iscas.ac.cn>
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, peterz@infradead.org, 
	juntong.deng@outlook.com, oleg@redhat.com, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 11:17=E2=80=AFPM Chen Ni <nichen@iscas.ac.cn> wrote=
:
>
> Replace comma between expressions with semicolons.
>
> Using a ',' in place of a ';' can have unintended side effects.
> Although that is not the case here, it is seems best to use ';'
> unless ',' is intended.
>
> Found by inspection.
> No functional change intended.
> Compile tested only.
>

Oopsie. Thanks for fixing it.

Reviewed-by: Amery Hung <ameryhung@gmail.com>

> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  tools/testing/selftests/bpf/test_kmods/bpf_testmod.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools=
/testing/selftests/bpf/test_kmods/bpf_testmod.c
> index 3220f1d28697..f38eaf0d35ef 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> @@ -1340,7 +1340,7 @@ static int st_ops_gen_prologue_with_kfunc(struct bp=
f_insn *insn_buf, bool direct
>         *insn++ =3D BPF_STX_MEM(BPF_DW, BPF_REG_6, BPF_REG_7, offsetof(st=
ruct st_ops_args, a));
>         *insn++ =3D BPF_JMP_IMM(BPF_JA, 0, 0, 2);
>         *insn++ =3D BPF_MOV64_REG(BPF_REG_1, BPF_REG_0);
> -       *insn++ =3D BPF_CALL_KFUNC(0, bpf_cgroup_release_id),
> +       *insn++ =3D BPF_CALL_KFUNC(0, bpf_cgroup_release_id);
>         *insn++ =3D BPF_MOV64_REG(BPF_REG_1, BPF_REG_8);
>         *insn++ =3D prog->insnsi[0];
>
> @@ -1379,7 +1379,7 @@ static int st_ops_gen_epilogue_with_kfunc(struct bp=
f_insn *insn_buf, const struc
>         *insn++ =3D BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_6, offsetof(st=
ruct st_ops_args, a));
>         *insn++ =3D BPF_JMP_IMM(BPF_JA, 0, 0, 2);
>         *insn++ =3D BPF_MOV64_REG(BPF_REG_1, BPF_REG_0);
> -       *insn++ =3D BPF_CALL_KFUNC(0, bpf_cgroup_release_id),
> +       *insn++ =3D BPF_CALL_KFUNC(0, bpf_cgroup_release_id);
>         *insn++ =3D BPF_MOV64_REG(BPF_REG_0, BPF_REG_6);
>         *insn++ =3D BPF_ALU64_IMM(BPF_MUL, BPF_REG_0, 2);
>         *insn++ =3D BPF_EXIT_INSN();
> --
> 2.25.1
>

