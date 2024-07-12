Return-Path: <linux-kselftest+bounces-13681-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB79892FE3E
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 18:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EE6B2872DA
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 16:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBF816FF47;
	Fri, 12 Jul 2024 16:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXvBlRaa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC21174EF3;
	Fri, 12 Jul 2024 16:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720800447; cv=none; b=hE+5MZ57PYGUWnqtGkfyyXIpZWFqe4+fzh7PP7eWuqv/O1qAn8LSz2HsyLFXerWFQfwX2OWxmsFprWVDqMbQxtQ1e5cCgjflFDsV0loOCBUXxSoUczHlFfNZVSTRd1XYI7tio9aUv2BsFYOuKIhsLImyBsQoRqnrVRtuEVfDzuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720800447; c=relaxed/simple;
	bh=PYzJEH3bz0eWoZZzdaW3PQCM2rKMs+81ZRYYZ5/64Uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UhoqxBDEKSNQPSybHzWLzdTyGlNfMYUa8qDFm6ZkfC2iLF9l+9ftwOPPfJ5vOXShSXFiLuCf+qch9Zu263XWy7U7gs2/f4h6IzFth+Xji8MN6XemKPu9GVUhJXNzV9cTP3JYUUybxyf3blIHIdZePfw/HLvdu5Q72DfEpkk5lDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXvBlRaa; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4272738eb9eso15888695e9.3;
        Fri, 12 Jul 2024 09:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720800444; x=1721405244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VfXTSKHYgiKIKnm1yADsqkCIonTWGO5KigMaMwOkNUs=;
        b=fXvBlRaaVY144AAz/sizRC6puaihrH7waxdd3JRXPZSzFtwkO+Zh3ikZ47I+dRgRww
         szumngqWsIZy5s1mewI+00taYwgGjsuKLdW3ncb0Xk9kIsTQN6GDp8ZnUJc/6iJb2GPP
         kg+fU/rGUxL4hGpZ2R5vECJVwrAIBWr5JenaoqxqqqrsZ579aCrnaVeo1b2aNJYGypZo
         0ftPzzJ9sE4pZ1m/z/VeiAigsqjgLVTUNTcPBBX5syYaeJBK7anuNYccMV5oi1Dhiei2
         6KtxETnXwaIoAqwqu5B9GX9EUg4qnhtENEPqCmAqiU3DZSu3FED/udecxiRQIb+ol59H
         atTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720800444; x=1721405244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VfXTSKHYgiKIKnm1yADsqkCIonTWGO5KigMaMwOkNUs=;
        b=r0JNPWJ/Oq5f/8hgkfOU7b0iV7tbuz2hUbXlxxM8TnU8kTfhbdbTuSViboNsu9746a
         tFCV6fPG9fMRFlSoO9lmtXdMiYeruSIf+RwBSnVKvmBdAidtySZVyKvPQi6y9S7mvUs3
         mgxSuXMHNnRJNVhbebia/mq9RHNkzYw2zwSH1U1kyTQmXpJQW3YuatYi2Sr8mnScF4bV
         d+xpju+WDxa13STEKE4XMU3SWWZkc5JXQMNeG7ucR9lrAH8y/8y4raRP1PMx8GvIrnsa
         KwdCBVr0NgTXoBkvFvPhfnjLVMBGLL5+D8ITXtQVSw5f2hwwrA/M91DFpgPQkWCvaxHT
         m8CA==
X-Forwarded-Encrypted: i=1; AJvYcCUDBaeevEvQ7kb9fT0zIP8T9I/inn9byy7DZ0beDmQbAcieCMtLpXI4wR0Im/gGgsbo9UbtBQd3HyN9gPTO4i2uCncfyZo3ITRRIFYgXLQA5lWw/H3PsZ2h+93HnpriqNoHVeVcibgAIWj86jTxU6hMI9Gu5NV1VH8aXi9tVi0KnIF1
X-Gm-Message-State: AOJu0YxrGNY0MC9Z/RiWkp9cO1jM0KX4djfOHcauv3IGfbKAquScz2vw
	sX2cvLEuKFYcMW41PdKx5YFLNf6obnMHJrNsTBe2+pvuuYd5ZhHG8QVjvuClX9FuMQjzwqJvudR
	kiCWtEp9tJ8vZg7tDofs+VHj+CfU=
X-Google-Smtp-Source: AGHT+IF6ZNG0e7VBRFn8Jo4Veuf9S6Gx9/mMQC7eXZ0waKvqEHjRcpk0233q2iTCyqx9oD9OpZ5JMcv8btE2MLb/NHE=
X-Received: by 2002:a05:600c:6a17:b0:425:5eec:d261 with SMTP id
 5b1f17b1804b1-426708f1999mr81459165e9.34.1720800444199; Fri, 12 Jul 2024
 09:07:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705145009.32340-1-puranjay@kernel.org> <c0ef7ecf-595b-375a-7785-d7bf50040c6b@iogearbox.net>
 <mb61pjzhwvshc.fsf@kernel.org> <CACYkzJ7d_u=aRzbubBypSVhnUSjBQnbZjPuGXhqnMzbp0tJm_g@mail.gmail.com>
 <224eeadb-fc5f-baeb-0808-a4f9916afa3c@iogearbox.net> <mb61ped836gn7.fsf@kernel.org>
 <d36b0c2e-fdf2-d3b0-46a8-7936e0eda5a8@iogearbox.net> <CACYkzJ5E+3xYkNsH7JoVkjabzSwnZZCzzTz5B50qDB7bLYkmMA@mail.gmail.com>
 <890d23f2-636e-12d1-31cc-eb6469f2a9ac@iogearbox.net> <SJ0PR15MB461564D3F7E7A763498CA6A8CBDB2@SJ0PR15MB4615.namprd15.prod.outlook.com>
 <mb61p5xtcyqo5.fsf@kernel.org> <978e127b-4967-950d-ccca-8575d1a885ae@iogearbox.net>
In-Reply-To: <978e127b-4967-950d-ccca-8575d1a885ae@iogearbox.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 12 Jul 2024 09:07:12 -0700
Message-ID: <CAADnVQJXcGB69o1s5GcLYV=OYS+hmqxGJVvtDH3YrVQc1o_=Tg@mail.gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: DENYLIST.aarch64: Remove fexit_sleep
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Puranjay Mohan <puranjay@kernel.org>, Manu Bretelle <chantra@meta.com>, KP Singh <kpsingh@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@meta.com>, 
	Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Florent Revest <revest@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 6:50=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> Hi Puranjay,
>
> On 7/11/24 4:00 PM, Puranjay Mohan wrote:
> [...]
> > I was able find the root cause of this bug and will send a fix soon!
> >
> >> Unable to handle kernel paging request at virtual address ffff0000c2a8=
0e68
> >
> > We are running this test on Qemu with '-cpu max', this means 52-bit
> > virtual addresses are being used.
> >
> > The trampolines generation code has the following two lines:
> >
> >               emit_addr_mov_i64(A64_R(0), (const u64)im, ctx);
> >               emit_call((const u64)__bpf_tramp_enter, ctx);
> >
> > here the address of struct bpf_tramp_image is moved to R0 and passed as
> > an argument to __bpf_tramp_enter().
> >
> > emit_addr_mov_i64() assumes that the address passed to it is in the
> > vmalloc space and uses at most 48 bits. It sets all the remaining bits
> > to 1.
> >
> > but struct bpf_tramp_image is allocated using kzalloc() and when 52-bit
> > VAs are used, its address is not guaranteed to be 48-bit, therefore we
> > see this bug, where  0xfff[0]0000c2a80e68 is converted to
> > 0xfff[f]0000c2a80e68 when the trampoline is generated.
> >
> > The fix would be use emit_a64_mov_i64() for moving this address into R0=
.
>
> It looks like there is still an issue left. A recent CI run on bpf-next i=
s
> still hitting the same on arm64:
>
> Base:
>
>    https://github.com/kernel-patches/bpf/commits/series/870746%3D%3Ebpf-n=
ext/
>
> CI:
>
>    https://github.com/kernel-patches/bpf/actions/runs/9905842936/job/2736=
6435436
>
>    [...]
>    #89/11   fexit_bpf2bpf/func_replace_global_func:OK
>    #89/12   fexit_bpf2bpf/fentry_to_cgroup_bpf:OK
>    #89/13   fexit_bpf2bpf/func_replace_progmap:OK
>    #89      fexit_bpf2bpf:OK
>    Error: The operation was canceled.

Let's denylist that test again for now?

