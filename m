Return-Path: <linux-kselftest+bounces-32958-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D25E1AB746D
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 20:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D79618C18A8
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 18:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9E42882A6;
	Wed, 14 May 2025 18:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzFXTm6p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A09287518
	for <linux-kselftest@vger.kernel.org>; Wed, 14 May 2025 18:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747247753; cv=none; b=n7j+jaMK2L0kKLcL0isyLA22NkbmfCey+GtUf9dmjtGBlEIMqyddDoNZ363WUN01oohRuQkgpGP5cCfGAtrUq6NfzScjTnbqhxbO06gmB++4XKFdhtJI0hjsoQDwt1/LTlziBRCNeOBcegG3GAaw2rv2O/e0Hfdz4k6MRmdfIHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747247753; c=relaxed/simple;
	bh=FXR+yoHky+nwxXWGDuzeNtD0Pl66EDMCJYYq1hhFKLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bBEeJYvGf3yRIZPDbFQ7K8k8e/AeyENauxGkgVIELhNRRJfQM26eWSIolXM/8mJRcJnCCMjnvQej1EoqPfrSUoepsi7QYyCYqCJIJ/MfEuvwIy1AMjXOwS8pFMKivk2B0eFmkN+kL7gph/Bh/GViGoW1IjL518FQxZUlhqhTOqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CzFXTm6p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D803C4CEF8
	for <linux-kselftest@vger.kernel.org>; Wed, 14 May 2025 18:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747247752;
	bh=FXR+yoHky+nwxXWGDuzeNtD0Pl66EDMCJYYq1hhFKLE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CzFXTm6pYTm3IvFXuLGBNTrojvDZ4pcyUIX/pniAZRBOfJIUdCk0nVWmfzi0m5TgT
	 nOsOV+uLSOiTCgJcA7Ey208+W5NAFvE5v3OpSg1O7e7KtSduzo1K1RHjJ3HMO6Trej
	 hyGN4OY1HiyBWHZbcThBH3f4ibd99Jjn5p0T7ELy/XJH8sml9xFDczT6GsYyTDnkMR
	 NW7az8rjYgR3YqCPqNOInJzDSiOJ/xM5huA43kuwW6WciZfacZtThoOIkfKnjfAVnh
	 pnAm+gZgzhY96ILzfg6OdszsrSCRM1eTcolG9UIn3XEFAJT4k6KaZWWdOZwGw8rm3G
	 5an1Jlur3hW6A==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac2bb7ca40bso18758966b.3
        for <linux-kselftest@vger.kernel.org>; Wed, 14 May 2025 11:35:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWeKWPEXMbCsKTs5a6Hj4MEaPz1Uyu9JFl7lt4Pi74vD4qf9RiKUNHsfzI2jyPvotBOTZGN6cUTTIpEDzC9rNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIxzZAJVAADSeFeP+TO09OsBBxnDq0vRyNzBhJbHVw/N3OpStB
	mUbUdsgUC94KnKTUO5HH1EUICMwRePJUFdruPLHTtwKbqJmn0y4rgeYQQTFDHp9SHctKlLvnfHN
	8RK5T9O5b+QQdhtPIGGyXA9CBVyURyO2p9r1x
X-Google-Smtp-Source: AGHT+IFtQMXy9LFulSzKje1GuSuGBtYynlXEWPAAMjiUP2194GFK8Vq6VYTuT87LMKZh7Uff3AMO5FsjIgB/BYZJ9Bw=
X-Received: by 2002:a05:6402:2553:b0:5fc:3f48:a673 with SMTP id
 4fb4d7f45d1cf-5ff98897f75mr3681731a12.2.1747247739543; Wed, 14 May 2025
 11:35:39 -0700 (PDT)
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
 <CACYkzJ5XJOj08+hKheWDcqbPrFAwa+fFvOw+4QPAHBz1u2HgAg@mail.gmail.com> <4f92fcfaeffd179ff6ae265822dc79856310d6a3.camel@HansenPartnership.com>
In-Reply-To: <4f92fcfaeffd179ff6ae265822dc79856310d6a3.camel@HansenPartnership.com>
From: KP Singh <kpsingh@kernel.org>
Date: Wed, 14 May 2025 20:35:28 +0200
X-Gmail-Original-Message-ID: <CACYkzJ7Oh62u7bHwQ_nOLG54qnhyNU9msF5mWV_vFrBXw1oZqw@mail.gmail.com>
X-Gm-Features: AX0GCFu6wgKt8ns7B4WmAYl1fFIsHpTPOSXa547IdWuqOMoeu6YVbaSdA5YH5n0
Message-ID: <CACYkzJ7Oh62u7bHwQ_nOLG54qnhyNU9msF5mWV_vFrBXw1oZqw@mail.gmail.com>
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

On Wed, May 14, 2025 at 7:45=E2=80=AFPM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Wed, 2025-05-14 at 19:17 +0200, KP Singh wrote:
> > On Wed, May 14, 2025 at 5:39=E2=80=AFPM James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > > On Sun, 2025-05-11 at 04:01 +0200, KP Singh wrote:
> [...]
> > > > This implicitly makes the payload equivalent to the signed block
> > > > (B_signed)
> > > >
> > > >     I_loader || H_meta
> > > >
> > > > bpftool then generates the signature of this I_loader payload
> > > > (which now contains the expected H_meta) using a key (system or
> > > > user) with new flags that work in combination with bpftool -L
> > >
> > > Could I just push back a bit on this.  The theory of hash chains
> > > (which I've cut to shorten) is about pure data structures.  The
> > > reason for that is that the entire hash chain is supposed to be
> > > easily independently verifiable in any environment because anything
> > > can compute the hashes of the blocks and links.  This independent
> > > verification of the chain is key to formally proving hash chains to
> > > be correct.  In your proposal we lose the easy verifiability
> > > because the link hash is embedded in the ebpf loader program which
> > > has to be disassembled to do the extraction of the hash and verify
> > > the loader is actually checking it.
> >
> > I am not sure I understand your concern. This is something that can
> > easily be built into tooling / annotations.
> >
> >     bpftool -S -v <verification_key> <loader> <metadata>
> >
> > Could you explain what's the use-case for "easy verifiability".
>
> I mean verifiability of the hash chain link.  Given a signed program,
> (i.e. a .h file which is generated by bpftool) which is a signature
> over the loader only how would one use simple cryptographic operations
> to verify it?
>

I literally just said it above the hash can be extracted if you really
want offline verification. Are you saying this code is hard to write?
or is the tooling hard to write? Do you have some definition of
"simple cryptographic operations".  All operations use tooling.

>
> >
> > > I was looking at ways we could use a pure hash chain (i.e.
> > > signature over loader and real map hash) and it does strike me that
> > > the above ebpf hash verification code is pretty invariant and easy
> > > to construct, so it could run as a separate BPF fragment that then
> > > jumps to the real loader.  In that case, it could be constructed on
> > > the fly in a trusted environment, like the kernel, from the link
> > > hash in the signature and the signature could just be Sig(loader ||
> > > map hash) which can then be
> >
> > The design I proposed does the same thing:
> >
> >     Sig(loader || H_metadata)
> >
> > metadata is actually the data (programs, context etc) that's passed
> > in the map. The verification just happens in the loader program and
> > the loader || H_metadata is implemented elegantly to avoid any
> > separate payloads.
>
> OK, so I think this is the crux of the problem:  In formal methods
> proving the validity of a data based hash link is an easy set of
> cryptographic operations.  You can assert that's equivalent to a
> signature over a program that verifies the hash, but formally proving
> it requires a formal analysis of the program to show that 1) it
> contains the correct hash and 2) it correctly checks the hash against
> the map.  That makes the task of someone receiving the .h file
> containing the signed skeleton way harder: it's easy to prove the
> signature matches the loader instructions, but they still have to prove
> the instructions contain and verify the correct map hash.
>

I don't see this as a problem for 2 reasons:

1. It's not hard
2. Your typical user does not want to do formal verification and
extract signatures etc.

[1] alone is enough.

The key user journey is:

* Build the program and the metadata
* Sign the blob once (as explained)
* A simple API to verify the sequence of operations.

The user builds a program and signs the blob, they sign it because it
contains the hash of the metadata. It seems like you are optimizing
for the formal researcher but not for the tooling. The user just needs
good tooling and a simple API which is exactly what was proposed.

- KP

> Regards,
>
> James
>
>

