Return-Path: <linux-kselftest+bounces-32156-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64355AA6F5D
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 12:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56E5E17B1E2
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 10:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC7023184F;
	Fri,  2 May 2025 10:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="DzoasPK4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE5E23A562
	for <linux-kselftest@vger.kernel.org>; Fri,  2 May 2025 10:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746181186; cv=none; b=orJeHEy021PGI0zmKHYaM/Epi/kmuOcorOGTkzAXeovlg+dNwyZu5lqm3O04eijSFFMaeCAPLtsaXeuBvMXIMaJPhrCBVVM2rYf+VU7fyPpjLcrfz/xwaysW2E1xTNlfIcODZL7u8ClO2V4AQnFfeyJjJw9r3izwfiHTq/t3SU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746181186; c=relaxed/simple;
	bh=rf1UbGG3UspPN/9brMtSukZGCz7Qty1bFnxHg1aKkvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lijnk7rOmBs7sii8mHRhZZHaSy8ht+GjMPbvY/eI6+HO7SHbJJCNdAD9VRiPXOu87FxCZvv6ldQrHeFOCEIzDnMAIHQy82XY72I3vf6OHUcLA0otVySO6O0nRvFTbmKnfBovS98UkJjRpTp9jzwDKP0mbcgjRyWmhd/XjIO7OBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=DzoasPK4; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso11197915e9.2
        for <linux-kselftest@vger.kernel.org>; Fri, 02 May 2025 03:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1746181182; x=1746785982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pFP7994sk6Z7ncZJREiDv0qbX6NYWjwXGSgYC1s9l8=;
        b=DzoasPK4sV7RwQNpK7n6mfIw5GhfzsJPvep7nqPwRSRHak2AZlHO9AEPAc2Sut1Gr/
         yLHHKZbRfVwUZZCHX740pkKXAchJS0/Vo6Tz5PtPbm36bNeF5TF+36KcPTuSbzg/vklo
         mZbEekfpVMElKZ99aw4ZH5UF+SZUN9psS6t5RqaABcBFtjSpaBRI5EaDiRVpTET85TK9
         MPlxSBq0cLLyMYpkRuWB2vuGN8XosL8RT17WV8xHzBZuB1+6pzZscnnQckxafjld9ZjC
         LxJ5hUIPEEZOrXiDL67b+ys88MVNwFunTJ+sF8fW7CN0jm6HuUz5sec7r+3+hngk+4qk
         HeOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746181182; x=1746785982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7pFP7994sk6Z7ncZJREiDv0qbX6NYWjwXGSgYC1s9l8=;
        b=hRevv3OJPOT7SQYhXsBAMkf+MA1vM7UCX27nuMo9stakWZHPwL/4Z9BT6A5OLs8qiW
         ZGA/W7obyLpXxHfol5sVynzAXUY1DKXH5QBlYCzGD+2DDK4Ieusfl0eoxg9QhQFiDr5N
         ufe5sdNsDUGs3QLwrTvAQn4TLVRpxt1dRCHCcC1ZccDJvf1zEbXvjZGD4VFXyk9i1V6/
         P+zxTr6pTc4CoPcXxBibQCb0dKXZZrDDuXv6weWJ6h0jjY/wYJYNkXMmvuPj/5D8wouF
         bRlN9KmUwk7xKfENWnZV4hkEyEpd8d4lLo6ph5T5QzZrLoe7aMww/7vHt04sqd2NfJPj
         IlDQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9eDyGG7wrROxi/xaFG5XgFHP0fOkQ8TQDwYCgtlQrHNimbhDiEEpXjMw+M1nd6zH22rP60oO2c6u1xSgOM30=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9FXEXBvXniNtO9Yxn+kRoP3V3DwNFt33nNHb5mozCUvB/a95B
	UDFAFYi7gnw1OwzHkNgPI1vRrjI/8mcCwcXvz+Wjvu+EUMj4owM0nPc3YCgcdBzbb7GpK/mItln
	F0JCjlt+ZsQd07M+FdHGKrutaAsV4tPa7HwxEMg==
X-Gm-Gg: ASbGncuob98Lp4feQ9D1T+zv3xLs80LO8qyee4Rwxdy5FjHRgkEF3EFyiQ0WDxhrt0r
	ULaOYAH28zERBBtkLPZF1lkigu9KLVqw4YI4n119bLM1RV9UwjOSk09CUsYzrb05VkkGnVGqMec
	HFchb/r+jOzldiwAs8Ex+yLgrtkU/WJzaPnf4=
X-Google-Smtp-Source: AGHT+IGc7/7ZFHGC09Y6oPlxiiiAyWXOIhQLSULd58hpmnRmxebelvil7hczjMUB00Kr9zZDZNhsc+5+jzgD4fz6cfI=
X-Received: by 2002:a05:6000:1a8b:b0:39c:1f04:bb4a with SMTP id
 ffacd0b85a97d-3a099ad1b70mr1701591f8f.10.1746181182606; Fri, 02 May 2025
 03:19:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501-vmlinux-mmap-v1-0-aa2724572598@isovalent.com>
 <20250501-vmlinux-mmap-v1-1-aa2724572598@isovalent.com> <CAADnVQK3hSgs_hic2Yuo84vR=2GZNtryki+TDNkNGY_7URsLiw@mail.gmail.com>
In-Reply-To: <CAADnVQK3hSgs_hic2Yuo84vR=2GZNtryki+TDNkNGY_7URsLiw@mail.gmail.com>
From: Lorenz Bauer <lmb@isovalent.com>
Date: Fri, 2 May 2025 11:19:31 +0100
X-Gm-Features: ATxdqUFBpdbdrog4Z53_JyxwTJC7G2efSJ-kkbIOit1-1PBgRel5uCzelrycCew
Message-ID: <CAN+4W8hqyi+MFS3975stXPWOxfMtdWQXPFnuvSieFzReDcV0rA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] btf: allow mmap of vmlinux btf
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 1, 2025 at 9:26=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> > +
> > +       return vm_iomap_memory(vma, virt_to_phys(__start_BTF), btf_size=
);
>
> and this one should probably be vm_insert_pages().
> Since it's not an IO area.

FYI I went with open coding with remap_pfn_range since that allows me
to avoid struct page.

Lorenz

