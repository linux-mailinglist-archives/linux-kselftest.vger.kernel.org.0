Return-Path: <linux-kselftest+bounces-32966-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F07FBAB7739
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 22:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 706643B4420
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 20:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD7D296707;
	Wed, 14 May 2025 20:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejCHHdIP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C6929616F
	for <linux-kselftest@vger.kernel.org>; Wed, 14 May 2025 20:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747255303; cv=none; b=khDiyuLMv9svxrjsRnLAi387mYotpmAvy1OCamcDGNbuBbYtItGNETj3FxQ4Uvw1W7U9hXwUkeP/X3TDNGby9cbJVXCM41PjIxPkmZunqmpfDbMHVrLJlVOddTejI8g/nL7qQkopsvMMkSfB/L+YBIQjqXrliVLfccfZZsMxLGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747255303; c=relaxed/simple;
	bh=tOkMF7Bwact06Na7dZKX9/UA7Qz24kXdUH1fectYcHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k4XkaBwNAAsi4fBZEvVKSnQN3Aae6NcRa5++nfD9zbfXv9fOvTbxP+GAhjp6RDwAWkz+iQ+d6spN4DL47nfTWXNxdWzw74UglV9xvsor2DU5gi1L5IRdkZm8Z462o0btSDQAhufTuAXmL79eZ+BddkrZJ6RecDZgi2ESCicOMls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejCHHdIP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6215C4CEED
	for <linux-kselftest@vger.kernel.org>; Wed, 14 May 2025 20:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747255302;
	bh=tOkMF7Bwact06Na7dZKX9/UA7Qz24kXdUH1fectYcHs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ejCHHdIPvsArIINmjUkdvXCJ7syNlJEvwj1fzr4IN2YQDvUlRV4NDcFZG4fWuNPcr
	 6S2twofleFdzX5xbkAHpXQL2Syh+4eBZ5rXWSDILLIrWEOnBFwvJJSRi5rjl1q77hM
	 7w4bS/hkAgXjyGvZyiQ6bCGecy+bMjzaFVBv2NzpFThnjyvQWJ4fSoMkWIgp/T1i3b
	 pjFgqHYRi3FVmQgBjG9z2sQ7zu86UPdLcTQaKd4SQrRyeqAWSgEBePDFOl3ruesyja
	 8fzzQrDe/ZSn3mlqEMRPcrKadEnwnBHBudcHXF6gSSotPKugRoCfNWw/oVraSeMtKh
	 DyHsBcVnwQgug==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5fbe7a65609so491765a12.0
        for <linux-kselftest@vger.kernel.org>; Wed, 14 May 2025 13:41:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVpbZeocZf29TriMQdXuFV+1oLxK3WEW6q5CGITFKjb1ZPlbgAO67niKsfMNq9cgcSvajIxNThYig2OdtHKNbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKqREDIIOr3EkXJKZpF5oL+weov1m7yr7AqIQ22V/GDryjqHY0
	v2VdgHD2m9qHrJGN+csyFx75S2Sv1sxmgBsky40tpb2fFeN6noQSr6ocCl+rguaZAzu3FtxooEX
	LEmVg0fagJhcNt0MlkUXF3o7uj7RKyl0v3fcx
X-Google-Smtp-Source: AGHT+IG3uEVTmfjxY/9iZZiVBkcC3BqC8ZuWsZMesREaLwP/YP638UxFHKWvkWLaZ8NvWpWAPIRDz/WcSvbhhhM7aXI=
X-Received: by 2002:a05:6402:3588:b0:5fb:1be2:270d with SMTP id
 4fb4d7f45d1cf-5ff988def11mr3639855a12.29.1747255301288; Wed, 14 May 2025
 13:41:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502184421.1424368-1-bboscaccy@linux.microsoft.com>
 <20250502210034.284051-1-kpsingh@kernel.org> <CAHC9VhS5Vevcq90OxTmAp2=XtR1qOiDDe5sSXReX5oXzf+siVQ@mail.gmail.com>
 <CACYkzJ5jsWFiXMRDwoGib5t+Xje6STTuJGRZM9Vg2dFz7uPa-g@mail.gmail.com>
 <CACYkzJ6VQUExfyt0=-FmXz46GHJh3d=FXh5j4KfexcEFbHV-vg@mail.gmail.com>
 <beaa81748cf1325df67930bf74ea87e6cdcb3e46.camel@HansenPartnership.com>
 <CACYkzJ5XJOj08+hKheWDcqbPrFAwa+fFvOw+4QPAHBz1u2HgAg@mail.gmail.com>
 <4f92fcfaeffd179ff6ae265822dc79856310d6a3.camel@HansenPartnership.com>
 <CACYkzJ7Oh62u7bHwQ_nOLG54qnhyNU9msF5mWV_vFrBXw1oZqw@mail.gmail.com> <2f71d6c03698eb17d51f7247efde777627ee578a.camel@HansenPartnership.com>
In-Reply-To: <2f71d6c03698eb17d51f7247efde777627ee578a.camel@HansenPartnership.com>
From: KP Singh <kpsingh@kernel.org>
Date: Wed, 14 May 2025 22:41:30 +0200
X-Gmail-Original-Message-ID: <CACYkzJ6PSFORZdSovJxN1+D59eTfyCkhWFsYYgYa=vbO5Tb4WA@mail.gmail.com>
X-Gm-Features: AX0GCFv872xEPuwZl65stdeayBR4vTasOjSF4TX-Op_MckziGdwZlnt80nuf65g
Message-ID: <CACYkzJ6PSFORZdSovJxN1+D59eTfyCkhWFsYYgYa=vbO5Tb4WA@mail.gmail.com>
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

On Wed, May 14, 2025 at 10:32=E2=80=AFPM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Wed, 2025-05-14 at 20:35 +0200, KP Singh wrote:
> > On Wed, May 14, 2025 at 7:45=E2=80=AFPM James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > >
> > > On Wed, 2025-05-14 at 19:17 +0200, KP Singh wrote:
> > > > On Wed, May 14, 2025 at 5:39=E2=80=AFPM James Bottomley
> > > > <James.Bottomley@hansenpartnership.com> wrote:
> > > > > On Sun, 2025-05-11 at 04:01 +0200, KP Singh wrote:
> > > [...]
> > > > > > This implicitly makes the payload equivalent to the signed
> > > > > > block
> > > > > > (B_signed)
> > > > > >
> > > > > >     I_loader || H_meta
> > > > > >
> > > > > > bpftool then generates the signature of this I_loader payload
> > > > > > (which now contains the expected H_meta) using a key (system
> > > > > > or
> > > > > > user) with new flags that work in combination with bpftool -L
> > > > >
> > > > > Could I just push back a bit on this.  The theory of hash
> > > > > chains
> > > > > (which I've cut to shorten) is about pure data structures.  The
> > > > > reason for that is that the entire hash chain is supposed to be
> > > > > easily independently verifiable in any environment because
> > > > > anything
> > > > > can compute the hashes of the blocks and links.  This
> > > > > independent
> > > > > verification of the chain is key to formally proving hash
> > > > > chains to
> > > > > be correct.  In your proposal we lose the easy verifiability
> > > > > because the link hash is embedded in the ebpf loader program
> > > > > which
> > > > > has to be disassembled to do the extraction of the hash and
> > > > > verify
> > > > > the loader is actually checking it.
> > > >
> > > > I am not sure I understand your concern. This is something that
> > > > can
> > > > easily be built into tooling / annotations.
> > > >
> > > >     bpftool -S -v <verification_key> <loader> <metadata>
> > > >
> > > > Could you explain what's the use-case for "easy verifiability".
> > >
> > > I mean verifiability of the hash chain link.  Given a signed
> > > program, (i.e. a .h file which is generated by bpftool) which is a
> > > signature over the loader only how would one use simple
> > > cryptographic operations to verify it?
> > >
> >
> > I literally just said it above the hash can be extracted if you
> > really want offline verification. Are you saying this code is hard to
> > write? or is the tooling hard to write? Do you have some definition
> > of "simple cryptographic operations".  All operations use tooling.
>
> As I said, you have a gap in that you not only have to extract the hash
> and verify it against the map (which I agree is fairly simple) but also
> verify the loader program actually checks it correctly.  That latter
> operation is not a simple cryptographic one and represents a security
> gap between this proposal and the hash linked chains you introduced in
> your first email in this thread.

Sure, but I don't see this as being problematic. If it's hard for
folks who do theoretical work, then I think it's okay to push this
effort on them rather than every user.

>
> > > > > I was looking at ways we could use a pure hash chain (i.e.
> > > > > signature over loader and real map hash) and it does strike me
> > > > > that the above ebpf hash verification code is pretty invariant
> > > > > and easy to construct, so it could run as a separate BPF
> > > > > fragment that then jumps to the real loader.  In that case, it
> > > > > could be constructed on the fly in a trusted environment, like
> > > > > the kernel, from the link hash in the signature and the
> > > > > signature could just be Sig(loader || map hash) which can then
> > > > > be
> > > >
> > > > The design I proposed does the same thing:
> > > >
> > > >     Sig(loader || H_metadata)
> > > >
> > > > metadata is actually the data (programs, context etc) that's
> > > > passed in the map. The verification just happens in the loader
> > > > program and the loader || H_metadata is implemented elegantly to
> > > > avoid any separate payloads.
> > >
> > > OK, so I think this is the crux of the problem:  In formal methods
> > > proving the validity of a data based hash link is an easy set of
> > > cryptographic operations.  You can assert that's equivalent to a
> > > signature over a program that verifies the hash, but formally
> > > proving it requires a formal analysis of the program to show that
> > > 1) it contains the correct hash and 2) it correctly checks the hash
> > > against the map.  That makes the task of someone receiving the .h
> > > file containing the signed skeleton way harder: it's easy to prove
> > > the signature matches the loader instructions, but they still have
> > > to prove the instructions contain and verify the correct map hash.
> > >
> >
> > I don't see this as a problem for 2 reasons:
> >
> > 1. It's not hard
>
> it requires disassembling the first 20 or so BPF instructions and
> verifying their operation, so that's harder than simply calculating
> hashes and signatures.
>
> > 2. Your typical user does not want to do formal verification and
> > extract signatures etc.
>
> Users don't want to do formal verification, agreed ... but they do want
> to know that security experts have verified the algorithms they're
> using.
>
> That's why I was thinking, since the loader preamble that verifies the
> hash is easy to construct, that the scheme could use a real hash linked
> chain, which has already been formally verified and is well understood,
> then construct the preamble for the loader you want in a trusted
> environment based on the hashes, meaning there's no security gap.
>
> Regards,
>
> James
>

