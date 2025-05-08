Return-Path: <linux-kselftest+bounces-32678-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FBDAB039C
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 21:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE5247BD01C
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 19:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1AB28A414;
	Thu,  8 May 2025 19:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Tyxz/fox"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A146A28A1D0
	for <linux-kselftest@vger.kernel.org>; Thu,  8 May 2025 19:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746732223; cv=none; b=XQ5npnbjakK6c8jM1JNDDpXY6fDbfWdS8MuILkcddSTWzmMWNNeFWVO8ota1tAoIwJigTRQ8nZwd9k4N50p26Q5knwNH4LLih8G7r8wt3b4NewkdT6DJojBFGKO21VGANJ1kmIARfx5WQT3aenPR9S6WoYi2fLzRcoWmkxoSvZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746732223; c=relaxed/simple;
	bh=HeIkrf/DTlLp0c59YdqAg+bDkVLnbRSgjhYsmzND7tI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C55HZQmeqsJ/u8xTJxy0MunIvo87G/BDBAxSGFeJ+sUm+24RRQ9dWn49gzZ3K32f19eaZdCr5hNI4twgD/nqk352WoFT05S3QoUxguWHcTdy3d/O7FaXdYhBE/FQpCFuGZb/lDoggR3ClQ42p5ou5JwV9KRvbATcYINNDe3KoCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Tyxz/fox; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-708d90aa8f9so13268327b3.3
        for <linux-kselftest@vger.kernel.org>; Thu, 08 May 2025 12:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1746732219; x=1747337019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRhUkqEtn8po9SOqhjXsORJmLCNwN2s1m7eTeLsarYo=;
        b=Tyxz/foxfwZ4j6csDDPw8SfNzdqM6hx0uRJrzTvmrqBu1gyw+UtQm+RqkDQ2t2y9kZ
         RXc8vdyGNE2T96ys79BRYJEqAoMadivU5a0hb7k9cHf/V0RWsqrlZbW4DwSssaxpDKKC
         dCgT9orpLEFjhDDlzBRQNtHlRbdZZoYZ/Dr2WuOjJkfVrwssJ9FqBMGBMiV0DbL3gl0V
         IvT6Ryd86G7aSljGIQ7LUlGcvQPq/lXWSEFv2EBs462pHpf31Wc/wZf1dVv1xutRr1QG
         aanSsvP2Z0iOlx8vjJSwZC/75Y/YzYVUeDnbd65E9wH8TtjQCQGqVjDvcBe3g4LMJo64
         JPdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746732219; x=1747337019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yRhUkqEtn8po9SOqhjXsORJmLCNwN2s1m7eTeLsarYo=;
        b=ZobKdjPw1SrGScDe+cdDPOwTvF8sLeiS4zNW2N9qBD84SBhncvOdxcaYIAuP3xrFRD
         BzlPs1ZjfEw3G5ZX5L2jbTivIFy6usJB72aaYHfilBXcDr6Lbv2E7WrfjEfIgX++ajdQ
         XRz914QfaPgDyhO4VYXekmBQumqT6EkuSJ22V5qdGtgQAYbb95BtcrUdgvkxTnaOJwlI
         JAkTyeRXBIl9eLwblkPeL55KiULooHROhAOTGBvvueiP3r/oyBJHnuMHSddQLIqx2Pjg
         FRYwg+ej7gO3Vbza8aVe88ARxZUYWbOw44Aa1fz4lJGcGZKYpvQAhBpalQRh4OREZggM
         eQzA==
X-Forwarded-Encrypted: i=1; AJvYcCXkIvumgPm5ECXLDOyA3/pK897kqlm1TWHzhgKWpKCEQlpKUZexrhsk7en73didTPrSywkOQLxJlDJSobqrLBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAyDuNvxkQ2ujxLphOzikq0rx3z2nTX020tAGVKtINiLJCeINH
	gtE+4eim87nD1Adn/RO2QsQzNJ9ZTmWvoLjwu9a/XRcd7qc/Lz9F1oVgYPMh8KiIjKzkK8wNnao
	XsuMUSDZN3qkotvNeanWdN9RxcQw+//U4BrJm
X-Gm-Gg: ASbGncsgWpQI+lAAdjjhNhv4t36w0ipxytrrvmEa1OO3FBMnuV+w/cvqWcqXFobw1KM
	l1vmCNM5C7mMRCMuXSHK33FLj6gRAvbmZ0E4dOnK0BqpQv0NeS/4p0NRBj1RI85FePuLaPYfKoN
	m5A9X6QxH3kM7Tg6G/4OAik69E7N9wY+g9
X-Google-Smtp-Source: AGHT+IED/fFzObiqlk4Rt9s6INYP5yEdYEWukKq9oUrT2cbOt6YSVHmtA8/2kHDXPkHkmR//EUTs9/SW8Ppo8a3d4F0=
X-Received: by 2002:a05:690c:201f:b0:702:5134:aaac with SMTP id
 00721157ae682-70a3f9e40bfmr7935957b3.2.1746732219206; Thu, 08 May 2025
 12:23:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502184421.1424368-1-bboscaccy@linux.microsoft.com>
 <20250502210034.284051-1-kpsingh@kernel.org> <87o6w7ge3o.fsf@microsoft.com>
 <CACYkzJ7Ur4kFaGZTDvcFJpn0ZwJ9V+=3ZefUURtkrQGfa68zLg@mail.gmail.com>
 <5dbc2a55a655f57a30be3ff7c6faa1d272e9b579.camel@HansenPartnership.com>
 <CAHC9VhSPLsi+GBtjJsQ8LUqPQW4aHtOL6gOqr9jfpR0i1izVZA@mail.gmail.com> <CAADnVQ+C2KNR1ryRtBGOZTNk961pF+30FnU9n3dt3QjaQu_N6Q@mail.gmail.com>
In-Reply-To: <CAADnVQ+C2KNR1ryRtBGOZTNk961pF+30FnU9n3dt3QjaQu_N6Q@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 8 May 2025 15:23:26 -0400
X-Gm-Features: AX0GCFuAJrhkB_YivBhm4MSlZcxwdgMv-eoNvShg9MjoBr-qIW4iuPknLt97V1o
Message-ID: <CAHC9VhRjKV4AbSgqb4J_-xhkWAp_VAcKDfLJ4GwhBNPOr+cvpg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Introducing Hornet LSM
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, KP Singh <kpsingh@kernel.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, bpf <bpf@vger.kernel.org>, code@tyhicks.com, 
	Jonathan Corbet <corbet@lwn.net>, "David S. Miller" <davem@davemloft.net>, 
	David Howells <dhowells@redhat.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Jarkko Sakkinen <jarkko@kernel.org>, 
	James Morris <jmorris@namei.org>, Jan Stancek <jstancek@redhat.com>, 
	Justin Stitt <justinstitt@google.com>, keyrings@vger.kernel.org, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	clang-built-linux <llvm@lists.linux.dev>, Masahiro Yamada <masahiroy@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Bill Wendling <morbo@google.com>, Nathan Chancellor <nathan@kernel.org>, Neal Gompa <neal@gompa.dev>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Nicolas Schier <nicolas@fjasle.eu>, nkapron@google.com, 
	Roberto Sassu <roberto.sassu@huawei.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Shuah Khan <shuah@kernel.org>, Matteo Croce <teknoraver@meta.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 1:45=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Wed, May 7, 2025 at 4:24=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Wed, May 7, 2025 at 1:48=E2=80=AFPM James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > >
> > > I'm with Paul on this: if you could share your design ideas more full=
y
> > > than you have above that would help make this debate way more
> > > technical.
> >
> > I think it would also help some of us, at the very least me, put your
> > objections into context.  I believe the more durable solutions that
> > end up in Linus' tree are combinations of designs created out of
> > compromise, and right now we are missing the context and detail of
> > your ideal solution to be able to do that compromise and get to a
> > design and implementation we can all begrudgingly accept.  In the
> > absence of a detailed alternate design, and considering that BPF
> > signature validation efforts have sputtered along for years without
> > any real success, we'll continue to push forward on-list with
> > refinements to the current proposal in an effort to drive this to some
> > form of resolution.
>
> It sounds like you're asking for Linus's opinion.

At this point no, although of course he is welcome to comment if he
likes.  What we've been asking for is some detail on your preferred
solution; all we've seen on the various threads thus far has been a
small number of short sentences that leave far too much ambiguity
around important parts of the design.  Without any clear direction on
your ideal solution, Blaise has been continuing forward with proposals
that we believe solve at least one use case and can be extended in the
future to support others.

Blaise started this most recent effort by attempting to address the
concerns brought up in previous efforts, you and others rejected this
first attempt and directed Blaise towards a light skeleton and LSM
based approach, which is where he is at with Hornet.  Once again, you
reject this approach with minimal guidance on what would be
acceptable, and our response is to ask for clarification on your
preferred design.  We're not asking for a full working solution,
simply a couple of paragraphs outlining the design with enough detail
to put forward a working solution that isn't immediately NACK'd.
We've made this request multiple times in the past, most recently this
past weekend, where KP replied that he would be "happy" to share
designs/code.  Unfortunately, since then all we've received from
either you or KP since then has been effectively just a list of your
objections on repeat; surely typing out a couple of paragraphs
outlining a design would have been quicker, easier, and more
constructive then your latest reply?

> This 'hornet' LSM attempts to implement signed bpf programs by
> hacking into bpf internals:
> https://lore.kernel.org/bpf/20250502184421.1424368-2-bboscaccy@linux.micr=
osoft.com/

I guess there are always two sides to every story, but "hacking into
bpf internals" is not how I would characterize the Hornet approach.
Hornet reads the light skeleton BPF loader and the associated BPF maps
(the original BPF program) passed in from userspace into a buffer in
order to verify a signature across the two BPF programs (loader +
original).

Hornet does this to verify the provenance and load time integrity of
BPF programs, two very basic security goals that people have wanted
for BPF programs for years, Blaise is simply the most recent person to
try and get something into Linus' tree.

> It got 3 Nacks from bpf maintainers.
> Let me recap our objections:
>
> 1. Your definition of attack surface says that root is untrusted.
> Yet this "hornet" LSM allowlists systemd as trusted.  Allegedly,
> it's an intermediate solution ...

The Hornet proposal is not the first thing to implement a transition
mechanism, but if that is really the blocker you want to go with I'm
sure Blaise would be happy to back out the change.  My understanding
is that it is really about reducing warnings from systemd and nothing
more.

> 2. you propose to mangle every binary in the system that needs to load
> bpf programs with an extra "signature" at the end of the binary that
> breaks ELF format.  I already explained earlier that such an approach
> was a border line acceptable solution for kernel modules, but
> certainly not ok as a general approach for all binaries.

Let's just ignore the "borderline" comment on kernel module signing;
the fact is that kernel module signing has been an accepted part of
the upstream Linux kernel for years now, which is part of why Blaise
used that as a starting point for the Hornet approach: keep things
simple and build on something that works.  This is especially
important as we are still largely guessing about the details of your
ideal solution.

Based on some of the vague feedback from you and KP, this week Blaise
has been experimenting with passing a signature via the bpf_attr
struct, but until you provide more detail on-list it is still a
guessing game as to what you might accept.  The kmod inspired
signature-on-ELF approach has the advantage of being much more
self-contained, which is the reason we saw it as a good starting point
that could be augmented with additional schemes in the future if/when
needed.

> 3. To read this mangled ELF you do:
> file =3D get_task_exe_file(current);
> buf_sz =3D kernel_read_file(file, 0, &buf, INT_MAX, &sz, READING_EBPF);
> A malicious user can give you a multi gigabyte file and your LSM will
> happily read it into the kernel memory. It's an obvious DoS vector.

The LSM hook used by Hornet happens well after all of the BPF based
capability and access control checks.  If anything, the ability of a
malicious user to tamper with the BPF program being loaded helps
highlight the importance of validating signatures on BPF programs.  In
the worst case, if the kernel can't allocate a buffer the
kernel_read_file() will fail and an error will be returned to
userspace.

> 4. I said multiple times it's not ok to do
> bpf_map->ops->map_lookup_elem() outside of the bpf subsystem.
> You did 'git grep' and argued that something in the net/ directory
> is doing that.  Well,
> ./scripts/get_maintainer.pl `git grep -l -- '->map_lookup_elem' net/`
> is your answer.  net/core/filter.c is a part of the bpf subsystem.
> The bpf originated in networking.

Yet BPF was extracted out as a standalone mechanism that has grown
well beyond its initial use as a socket data filter.  From my
perspective either BPF is a standalone entity and the
map_lookup_elem() API is necessary for at least one current user, the
socket fitler, or map_lookup_elem() isn't an API in which case BPF
isn't the general purpose tool that everyone claims.

This touches on another issue that I've brought up before in this
thread which is important.  The LSM subsystem doesn't care about how
the LSM is implemented; C, BPF, and Rust (work is obviously still very
early on the Rust side) are all valid implementation languages, and we
make it clear that if you can do something in one language, you should
be able to do it another.  While I don't believe you or KP have
explicitly stated that your objection to the Hornet approach is
largely due to it being written in C, Daniel did make a comment that
Hornet should be written as a BPF LSM.  From the perspective of the
LSM, something is either "legal" to do in a LSM, or it isn't; we don't
qualify that determination based on the source language of the
implementation.

> Also, do build 'hornet' LSM with LOCKDEP and see how many bpf map
> lifetime rules you violated with that map_lookup_elem() call.

I'm sure Blaise will look into that.  I'm sure that if you, KP,
Daniel, or anyone else in BPF land wanted to provide an alternate API
for map access I'm sure Blaise would be happy to rework his code.  As
we've stated multiple times, don't just say "no" say "no" with a good
description about how to move forward.

> 5. I also explained that map->frozen =3D=3D true doesn't guarantee that
> the map is immutable.  It only freezes the map from user space writes.

For this initial use case, we believe that is sufficient and is inline
with kernel module loading, which is a good analogy.  The most
critical part as far as we are concerned is that userspace can not
tamper with the BPF map once the signature has been verified.  Yes,
another in-kernel component might be able to tamper with the BPF map,
but in-kernel components can do a number of bad things; this is yet
one more reason why validating code that executes in kernel context is
important.

> 6. Though bpf instructions have standardized format LSMs shouldn't not
> be in the business of parsing them. New instructions are being added.
> We don't need a headache that an LSM will start crashing/misbehaving
> when a new instruction is added or extended.
> bpf instruction parsing belongs in the bpf subsystem.

The current Hornet implementation ignores things it doesn't know
about, sticking to parts of the BPF instruction set that is currently
defined.  Who knows what Hornet might look like in another few
revisions, or if it is replaced with another approach, but if it
becomes part of Linus' tree it should be trivial to update it along
with BPF.  There is precedence for this with other LSMs and other
kernel subsystems.

> 7. You do: copy_from_bpfptr_offset(&map_fd, ...) then proceed with
> content extraction, but this is a user controlled address. It's an
> obvious TOCTOU bug. The user can replace that map_fd after your LSM
> read it and before bpf verifier reads it. So the signature checking
> from LSM is fundamentally broken. I already explained that the
> signature check has to be done within a bpf subsystem.

As mentioned *many* times before, please provide more information on
this.  To start, where *exactly* in the BPF subsystem would you accept
a signature check.

> In the last kernel release we added 'bool kernel' parameter to
> security_bpf_prog_load() LSM hook assuming that you're going to work
> with us on actual solution for signed bpf programs, but so far you
> ignored our feedback and accused us of artificially delaying a
> solution to signed programs, though we told you that the "light
> skeleton" (that you incorrectly attempt to use here) was designed
> specifically as a building block towards signed bpf programs:
>
> See the cover letter from 2021:
> https://lore.kernel.org/bpf/20210514003623.28033-1-alexei.starovoitov@gma=
il.com/

...

> When Blaise volunteered to work on signed progs we pointed him to
> light skeleton assuming that you're going to work with us to finish
> this complex task.

In order to work effectively we need a more detailed explanation of
what you want to see with respect to BPF signing.  Thus far we've only
seen rejections with very hand-wavy explanations on how to proceed.
KP indicated almost a week ago that he is happy to share a couple of
paragraphs on a preferred BPF signing approach, but we're still left
waiting with the only feedback being a repeat of previous rejections
and more vitrol.

--=20
paul-moore.com

