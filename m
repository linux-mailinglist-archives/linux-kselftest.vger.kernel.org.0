Return-Path: <linux-kselftest+bounces-15982-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDCF95AABF
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 03:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1E192812DB
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 01:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4798311712;
	Thu, 22 Aug 2024 01:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TH3F0Pma"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C65412B64;
	Thu, 22 Aug 2024 01:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724291773; cv=none; b=Fd9sKwCzQlo0hBHSQxk8ltcw97aEe79A5hIzR/VvrcegEZVAMNKwKslK9VwCtOqGCB67NHmsowh8mg04MZUMAmCr8dFe2crwE/LX9R38xwYKagPl1FwZxYbu0JdjPc8Eh4EtMxBllfV02I6diAmf6Zo5WzTqjj0nTeehGG1grDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724291773; c=relaxed/simple;
	bh=Ki+uuNliTSRz+n/S8TmqqO+GXqDsD0Z1+MPVzlJZDD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PS6pTz9PrxIJ2WYOy4ewCtF6sSTglOhQf7658vEHGUEkTQ6//li/PHJEF9EA2UI7iPX/qqwN6iTlpBVFkYK+ZaAyhXNM7y4zzab6yYoGk3lZZXKaabXW0RhnQgDNfPsN56DeAn/Wa1duD941RHBVggkSfViiMtJDchQ2d4ZDBfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TH3F0Pma; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4281ca54fd3so1625245e9.2;
        Wed, 21 Aug 2024 18:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724291770; x=1724896570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EqLZ5AiejzNGykZtRwZ2mwTEdbcNMWwbVMbeONPG0f8=;
        b=TH3F0PmaPxr3hS3cy/Ceir0tcJ4x5fJ/FBk/rEJPxNVrw1Zj6IiyC5LztTsY8rtO3R
         J6OgDEDJdTIw1Yboep2Oq2z6BAn/cx9mxqcIU6UisN9fiAglzIMYELtbA6wMvNWa1OdG
         cpI4nUzjmZpoxzzyQHQ6l+Z8U6bGw6uE3xr0tgpqDBMs1AICO00v4W3MayybIjYAZE/z
         fEUyIsbvu037Zu3xe960mPAqdgZGRZEimYEzR+aTlb2Vty2AOrl/PATYVj3BL86OTSMR
         iXuFj1+WPdxAdn5uXlekMAlb+iV7NbJSc4/lJkitQQRssS/lMLXNsrz4DDAtQNKhO8JW
         78EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724291770; x=1724896570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EqLZ5AiejzNGykZtRwZ2mwTEdbcNMWwbVMbeONPG0f8=;
        b=nxogOMLPFOYKWRYasnpgDc7vlio8DTG0HtFt+yPlpt6tMBG1kaIO8Ms4jMudabTRhc
         hMqguRO7lGLdYSsLQ58hRZENUldN3aGqN02EQdyrqv0HLrwVkmnm/EHgOHOErHIjqjdb
         KOmj46O5o2vPzR9s/5l60w7/xly2L4B5EqhaBzhrxVysmdMhbgS8FufO04ttF0vQ930C
         QdYCIrRXGD3Qkt4UQkZUFfaJhOhfDyIFn0iYYifFi3/t890alQ46YvTfu9NWY8ISrICP
         K2Wq/dSWAa9AHs4FcIrH9Rsx6K/oPuMO4myiogj60VginlVVL+AxX8xAn5Vw8pfuUa+V
         7QYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMA9Q8bi6uLCofmJTqoI6QP8Q/ELy5B7+K6sypNHF79oEH0y6mXR8KvMk6ATielfsF7cNnYS5dL1wEyujBl/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhsLKED6AqFv0dSdWBub868cIHqeEjtP2HA7DQJK1q6H02rx2q
	9mjkXHPls/PrpYtDK9JOOCnoUMb9FmCmodCG+SvwlTtbIN+wP3Nyfofk+4eVXh9HeuiM+1c+hOL
	wxhsjwE7RopqjBAbq70pzPXUo7Bo=
X-Google-Smtp-Source: AGHT+IFWpXNoDjmxs4Yt77ioTJnh981UbqwO+V7BBtqQoCtRfR5Pfe7Fn6trBzm8ym+7ax9E+OP61r3v0dhxLgDlkeE=
X-Received: by 2002:a5d:525a:0:b0:371:7009:c26f with SMTP id
 ffacd0b85a97d-372fd8319a9mr2523583f8f.63.1724291769473; Wed, 21 Aug 2024
 18:56:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1724216108.git.tony.ambardar@gmail.com> <62a2ef41629ad5ef7db48d720959527462e1beca.1724216108.git.tony.ambardar@gmail.com>
In-Reply-To: <62a2ef41629ad5ef7db48d720959527462e1beca.1724216108.git.tony.ambardar@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 21 Aug 2024 18:55:58 -0700
Message-ID: <CAADnVQJ2XW0QwSGAaqzEUY4jozF6ML3dxr0mE7hGct0-6hKNnA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 5/8] libbpf: Support opening bpf objects of
 either endianness
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ilya Leoshkevich <iii@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 2:10=E2=80=AFAM Tony Ambardar <tony.ambardar@gmail.=
com> wrote:
>
>
> +static inline void bpf_insn_bswap(struct bpf_insn *insn)
> +{
> +       /* dst_reg & src_reg nibbles */
> +       __u8 *regs =3D (__u8 *)insn + offsetofend(struct bpf_insn, code);
> +
> +       *regs =3D (*regs >> 4) | (*regs << 4);
> +       insn->off =3D bswap_16(insn->off);
> +       insn->imm =3D bswap_32(insn->imm);
> +}

This is really great!
Thank you for working on it.

This idea was brought up a couple times, since folks want to compile
bpf prog once, embed it into their user space binary,
and auto adjust to target endianness.
Cross compilation isn't important to them,
but the ability to embed a single .o instead of two .o-s is a big win.

It's great that the above insn, elf and btf adjustments are working.
Since endianness is encoded in elf what's the point of
extra btf_ext__endianness libbpf api?
Aren't elf and btf.ext suppose to be in the same endianness all the time?

