Return-Path: <linux-kselftest+bounces-32953-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB396AB7293
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 19:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58EDA1684C4
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 17:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593A227FB04;
	Wed, 14 May 2025 17:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxVmr/ft"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E402750E3
	for <linux-kselftest@vger.kernel.org>; Wed, 14 May 2025 17:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747243058; cv=none; b=DrtGvYRuANI4Ir6UPXgsQAai33a+FIE2xWTjw9ng+Id8jpssnkQ3XIeyeO0bXDQS0KA40rtc4leqi+mgWTJ2yC/Nd4TOZ8cjU4y8N2XUDJa9iaueT5wrLNkWhpgtAJx0kRl8EE0p3xHyhVcm88hE2acLYMh86hRRboYmmyUg92Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747243058; c=relaxed/simple;
	bh=FDhdtyxCTap+04aKrlvv+t4yDmBNbsQsV62cqYnEcWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O9ILbhnNyh2Ky6xlhGlAoTlA056dV0DxNd4E7YNtVKDiE7ROAp7FFfn+rH3KTZrbp0BMdiE+gXt2L9/xVQvC00r+58NvutiCehgbDNY7bkDb+i1gaE2drl64+Xe462L8GxXXV+0Ax7WYwp9CFf2peeaWt4tPON6tyEaVceAci7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxVmr/ft; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97915C4CEED
	for <linux-kselftest@vger.kernel.org>; Wed, 14 May 2025 17:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747243057;
	bh=FDhdtyxCTap+04aKrlvv+t4yDmBNbsQsV62cqYnEcWQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GxVmr/ftS93uarBMKzJWceF4i9WcC7bKkCJh8F6Nhk59cFukYASZ88mOuaxpNBYKj
	 xD1zOe+mXSuBIXQjSjIg8ZUWQRWkLb2GQWLUbD0qmprod5Qoc5C4FmNwZty0XAV8rv
	 LoHWK9XhMs5fGj79eLOUvSiiiLzqeZmpUSkiwBv1Bj7kbhniF7c5+k5A2JBXOyS+Q7
	 YvqzPZYjq0KOnnqvvCiyUyKEfiLf0qqAyUGACDO7AIQwCYWB6rApq9vWnkJ7Ysf5L9
	 URg/w2CjDBbpfqq3YcE+ivuaZsXk/L6ulnw9KwYBHASfYyCiAYu+yeUtuns0F3NQq8
	 YKIQlC8ao2elg==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5fbdf6973e7so62183a12.2
        for <linux-kselftest@vger.kernel.org>; Wed, 14 May 2025 10:17:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXK3TFnQaIRsNaHkismSKQBVinloD6Y8R/x1i5WgQgchng/JanqDc2Mg+Ex5g9rd3ybCo0vk4eUwuZ1sy0PcvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBXk74/akWeZqkh2DB1Fyb2AN4cSVVVS/yBBpvDUZQUsD/y1nW
	2p/6IaFdvxdc4y7dYe2LC7ZSDy2gZIsf8MZBSJ5K4iAXLEpmmWBbAM2NEffzjFqBTiekfQoPaxK
	lsBJRotLotpf3qm/i6m66OFE31yv7LdHWTugj
X-Google-Smtp-Source: AGHT+IEOVd6ylZgHdYkHjW+kgS0JvvQJmlojiJ55yxngXk0tGlu2ur8qbDKzXcFMtelFrk1TuWFTRE31C+Kg7x92aJA=
X-Received: by 2002:a05:6402:238f:b0:5ff:b606:930b with SMTP id
 4fb4d7f45d1cf-5ffb6069372mr1068438a12.12.1747243056124; Wed, 14 May 2025
 10:17:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502184421.1424368-1-bboscaccy@linux.microsoft.com>
 <20250502210034.284051-1-kpsingh@kernel.org> <CAHC9VhS5Vevcq90OxTmAp2=XtR1qOiDDe5sSXReX5oXzf+siVQ@mail.gmail.com>
 <CACYkzJ5jsWFiXMRDwoGib5t+Xje6STTuJGRZM9Vg2dFz7uPa-g@mail.gmail.com>
 <CACYkzJ6VQUExfyt0=-FmXz46GHJh3d=FXh5j4KfexcEFbHV-vg@mail.gmail.com> <beaa81748cf1325df67930bf74ea87e6cdcb3e46.camel@HansenPartnership.com>
In-Reply-To: <beaa81748cf1325df67930bf74ea87e6cdcb3e46.camel@HansenPartnership.com>
From: KP Singh <kpsingh@kernel.org>
Date: Wed, 14 May 2025 19:17:25 +0200
X-Gmail-Original-Message-ID: <CACYkzJ5XJOj08+hKheWDcqbPrFAwa+fFvOw+4QPAHBz1u2HgAg@mail.gmail.com>
X-Gm-Features: AX0GCFsMtrdPzfS33E-5H3itP3YDxJJoQNEUvaPpI7wNO1nxLfvV3IZXpPdMWT8
Message-ID: <CACYkzJ5XJOj08+hKheWDcqbPrFAwa+fFvOw+4QPAHBz1u2HgAg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Introducing Hornet LSM
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Paul Moore <paul@paul-moore.com>, bboscaccy@linux.microsoft.com, bpf@vger.kernel.org, 
	code@tyhicks.com, corbet@lwn.net, davem@davemloft.net, dhowells@redhat.com, 
	gnoack@google.com, herbert@gondor.apana.org.au, jarkko@kernel.org, 
	jmorris@namei.org, jstancek@redhat.com, justinstitt@google.com, 
	keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-security-module@vger.kernel.org, llvm@lists.linux.dev, 
	masahiroy@kernel.org, mic@digikod.net, morbo@google.com, nathan@kernel.org, 
	neal@gompa.dev, nick.desaulniers+lkml@gmail.com, nicolas@fjasle.eu, 
	nkapron@google.com, roberto.sassu@huawei.com, serge@hallyn.com, 
	shuah@kernel.org, teknoraver@meta.com, xiyou.wangcong@gmail.com, 
	kysrinivasan@gmail.com, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 5:39=E2=80=AFPM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Sun, 2025-05-11 at 04:01 +0200, KP Singh wrote:
> [...]
> > >
> > For this specific BPF case, we will directly sign a composite of the
> > first message and the hash of the second. Let H_meta =3D H(M_metadata).
> > The block to be signed is effectively:
> >
> >     B_signed =3D I_loader || H_meta
> >
> > The signature generated is Sig(B_signed).
> >
> > The process then follows a similar pattern to the Alice and Bob
> > model,
> > where the kernel (Bob) verifies I_loader and H_meta using the
> > signature. Then, the trusted I_loader is responsible for verifying
> > M_metadata against the trusted H_meta.
> >
> > From an implementation standpoint:
> >
> > # Build
> >
> > bpftool (or some other tool in the user's build environment) knows
> > about the metadata (M_metadata) and the loader program (I_loader). It
> > first calculates H_meta =3D H(M_metadata). Then it constructs the
> > object
> > to be signed and computes the signature:
> >
> >     Sig(I_loader || H_meta)
> >
> > # Loader
> >
> > bpftool generates the loader program. The initial instructions of
> > this loader program are designed to verify the SHA256 hash of the
> > metadata (M_metadata) that will be passed in a map. These
> > instructions effectively embed the precomputed H_meta as immediate
> > values.
> >
> >     ld_imm64 r1, const_ptr_to_map // insn[0].src_reg =3D=3D
> > BPF_PSEUDO_MAP_IDX
> >     r2 =3D *(u64 *)(r1 + 0);
> >     ld_imm64 r3, sha256_of_map_part1 // constant precomputed by
> > bpftool (part of H_meta)
> >     if r2 !=3D r3 goto out;
> >
> >     r2 =3D *(u64 *)(r1 + 8);
> >     ld_imm64 r3, sha256_of_map_part2 // (part of H_meta)
> >     if r2 !=3D r3 goto out;
> >
> >     r2 =3D *(u64 *)(r1 + 16);
> >     ld_imm64 r3, sha256_of_map_part3 // (part of H_meta)
> >     if r2 !=3D r3 goto out;
> >
> >     r2 =3D *(u64 *)(r1 + 24);
> >     ld_imm64 r3, sha256_of_map_part4 // (part of H_meta)
> >     if r2 !=3D r3 goto out;
> >     ...
> >
> > This implicitly makes the payload equivalent to the signed block
> > (B_signed)
> >
> >     I_loader || H_meta
> >
> > bpftool then generates the signature of this I_loader payload (which
> > now contains the expected H_meta) using a key (system or user) with
> > new flags that work in combination with bpftool -L
>
> Could I just push back a bit on this.  The theory of hash chains (which
> I've cut to shorten) is about pure data structures.  The reason for
> that is that the entire hash chain is supposed to be easily
> independently verifiable in any environment because anything can
> compute the hashes of the blocks and links.  This independent
> verification of the chain is key to formally proving hash chains to be
> correct.  In your proposal we lose the easy verifiability because the
> link hash is embedded in the ebpf loader program which has to be
> disassembled to do the extraction of the hash and verify the loader is
> actually checking it.

I am not sure I understand your concern. This is something that can
easily be built into tooling / annotations.

    bpftool -S -v <verification_key> <loader> <metadata>

Could you explain what's the use-case for "easy verifiability".

>
> I was looking at ways we could use a pure hash chain (i.e. signature
> over loader and real map hash) and it does strike me that the above
> ebpf hash verification code is pretty invariant and easy to construct,
> so it could run as a separate BPF fragment that then jumps to the real
> loader.  In that case, it could be constructed on the fly in a trusted
> environment, like the kernel, from the link hash in the signature and
> the signature could just be Sig(loader || map hash) which can then be

The design I proposed does the same thing:

    Sig(loader || H_metadata)

metadata is actually the data (programs, context etc) that's passed in
the map. The verification just happens in the loader program and the
loader || H_metadata is implemented elegantly to avoid any separate
payloads.

> easily verified without having to disassemble ebpf code.  So we get the
> formal provability benefits of using a real hash chain while still
> keeping your verification in BPF.
>
> Regards,
>
> James
>
>

