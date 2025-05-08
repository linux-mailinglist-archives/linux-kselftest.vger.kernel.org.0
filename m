Return-Path: <linux-kselftest+bounces-32668-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D18A5AB01A4
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 19:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 044BC7A44E9
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 17:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836D2286D4A;
	Thu,  8 May 2025 17:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeeWSROO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A0C28368E;
	Thu,  8 May 2025 17:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746726311; cv=none; b=JYcIlKwXZMuvSZSLbhJKzCRLLeRLKloOJHRrFszZImv8hN8wAmg/IfKcYLxgaS1jexGjCxGMYKAYhEvcR2sqI3pYvhEU45RL71IDHDt8NZwBG/lk57pCmAmriwy1VCRkpWUdLy9kJepCMM7pYjdy1rPOF98hE6emo90XkpRfJ24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746726311; c=relaxed/simple;
	bh=ST9+r5v9jVHM9V2BO1pSGjhK08Eo7rnudQCQ2tjZ3B8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mqv18FJ1fDuisiUlHfSwX/IrixqNVGTfe/S8MfBZ1ckKuJLhZAqwRfingqhCBOTWwJLa1wjItEg+hP33WadImMt1jCqE0173iDPgZziq6Q+1gLk93rNrKvuzmqcT1Xr9UKyPQWiYuYC1nmVAY4n0wnvvp0y+3GNkTa9GthescKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DeeWSROO; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a0bdcd7357so795343f8f.1;
        Thu, 08 May 2025 10:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746726307; x=1747331107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5jDPsrDcwS9BJssTepvRYRoVCU1h0FZ0niZLyBZi4I=;
        b=DeeWSROOJHVHCe5Xw2CqHsKb8cTA0rqeGM0iWrd99qLOjYxzjZAyw6UCMFzOlbNGXx
         dcztHu9Z+L21Y3Fi3zyu3KYYPWV+qcRr/PAtmG09gBS2egOpgWkHgdCp+nBzSKF4mNbv
         RtRWNhf5DdxfR9VMfaaNew2sXV2k49R1H8sTuWbwCAllKJRkUAHyTkSoxbJuM4AKrCo6
         8SIGv0+m6UFOL5meBY7XqsiphOtdAFwbjhA9ZMujAKXa5edpo9AvY2xsbhX8PxFM8pSR
         0jdppYsx4k2/ZXszhdYpCxxRpEqDei4yO0tDtHM+xGwmqyKiphfyfe2WyweOnup26G3z
         qmag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746726307; x=1747331107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5jDPsrDcwS9BJssTepvRYRoVCU1h0FZ0niZLyBZi4I=;
        b=wkn1CiyRGkfQAOim1j1bQ7O8yrZox4ydS35txaumYPXtAJIDkx6+KUG0WBhI7jcNqu
         Xi8TZmpUcYOfsXaqRPcAFjOoBtJbSxtPz+D3/UjvgxVSKeiiiX0Pl4QuzKTkFYvTeHcE
         jqK0laX66nFl2hiGKwm1AUVRklDlyizOEYnK8CmZ0ZQkJ3TvSHGY5AWjIFezxvDq+P8x
         wQUQ5UMTnRbr4NZgHpaaIJNC6a4GDnN/XMS1f7s3IlTL2rFBPMO3xpYmRLegfx/8tAPF
         RQH5oNr11FaRantjl7ZoYyrSpL3jaYS9Gdq8l77RvHQSLgMRd7kj/eO9R+n2hdNzbo9f
         bKMg==
X-Forwarded-Encrypted: i=1; AJvYcCU6In/ezWLZliVgpWXAv+jPn8Ihl6czjvxg0Q9izLJiaHdXCUA8TfbIK5TQn6KIXKjuTn4=@vger.kernel.org, AJvYcCU8bUtQ/noGjzZ8/r0UjK41ANvr/LZcya6ECYEkTAFFGwXVTHfRMnTWMkUYtNawbzecovzU4kNtxBJvDHlkTRQrw75XHuzs@vger.kernel.org, AJvYcCUXfPhL0vWPkwLfQQfRNZEqPhx5TecZ+fpSVqoi985rZ692M4pDbiXJfGHvuhT62VUVqMbOcVnsC2VxxkxiDDEN@vger.kernel.org, AJvYcCV3zS88cDfSt5b97QC69onQoJXpDacIZRQjLQT8tuQr5NiwKsGlp/cckGfoLbmHBV6gnJbsSsCBF03BIKyK@vger.kernel.org, AJvYcCVpGTJiMmzeAR0OKh/FNzSKBOMmrk5QIVTtIy4XlBzV7U0pJDQ7ax+1hafvW6uZ0hinYXE0JjCtWnevxa7l@vger.kernel.org, AJvYcCVzBTis/PxIOLSgmR+rUgNivGkkok8KTV7A8lMxvGnfTqoqU9b9x2E+aY1A9pG8pzE5zuRxeyX0HaVP@vger.kernel.org, AJvYcCWN+Y7Ca4m7PTkCR7Ydjb82ZCdKpOGBbYYLXXrAHcEAWvji/i9ZrIjOgJ47rEeLzY7bnp6OMfSZL7w=@vger.kernel.org, AJvYcCWYivTnNV66uwbLSRAqWzKnbZcAu2lWQ5//5BtqA9HKpBeYiv2Sqt+HZC57rNrOZMcW3WaAR/NU332UO6Br@vger.kernel.org
X-Gm-Message-State: AOJu0YxlbZi1EB5reB3zt3y6fPcX613y1jtzAunFv2JDZOEUdkaPYyob
	QF+94aqFISX12uG+FmWc08Hkhj2YaxHe42a7cpGkhBBzeIEkRiEhpdRaKID6uHIWiFFF/tP/Pqa
	xQ29QM3kKnSaut7HJRDrJpP3flsE=
X-Gm-Gg: ASbGncuILJiBse+c1itjefuMg3TRF38KAJuF7f3W7dV8F8hkFs00c9Ho3Cm1yjFSKI1
	5ujAsZZasxmpRm9gWbtRzSMo4ZTV0MrDKizWY1gYjsHzUCef4lzOWUhMsa+1joWuy36EXhU1McH
	TEJD0sAzwnHQa/qnhkGmwBZRTIvvfYTZqqnzFDyg==
X-Google-Smtp-Source: AGHT+IHe461aO8mZ9fFWh74KBbLfKfcAIhBBbyjbCCLnMQLIDi1uoV7mXyivqZ7W9O34gIJIVYoRcOvwE359gadgiic=
X-Received: by 2002:a5d:6ace:0:b0:3a1:f6a5:7b4f with SMTP id
 ffacd0b85a97d-3a1f6a58014mr115089f8f.14.1746726307157; Thu, 08 May 2025
 10:45:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502184421.1424368-1-bboscaccy@linux.microsoft.com>
 <20250502210034.284051-1-kpsingh@kernel.org> <87o6w7ge3o.fsf@microsoft.com>
 <CACYkzJ7Ur4kFaGZTDvcFJpn0ZwJ9V+=3ZefUURtkrQGfa68zLg@mail.gmail.com>
 <5dbc2a55a655f57a30be3ff7c6faa1d272e9b579.camel@HansenPartnership.com> <CAHC9VhSPLsi+GBtjJsQ8LUqPQW4aHtOL6gOqr9jfpR0i1izVZA@mail.gmail.com>
In-Reply-To: <CAHC9VhSPLsi+GBtjJsQ8LUqPQW4aHtOL6gOqr9jfpR0i1izVZA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 8 May 2025 10:44:55 -0700
X-Gm-Features: ATxdqUHJoN2Qk0990kd-BX0DQUOkB4RrlJVBzzRkS3CyzYL2lmu2a7G8UY9kepw
Message-ID: <CAADnVQ+C2KNR1ryRtBGOZTNk961pF+30FnU9n3dt3QjaQu_N6Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Introducing Hornet LSM
To: Paul Moore <paul@paul-moore.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: KP Singh <kpsingh@kernel.org>, 
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

On Wed, May 7, 2025 at 4:24=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Wed, May 7, 2025 at 1:48=E2=80=AFPM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> >
> > I'm with Paul on this: if you could share your design ideas more fully
> > than you have above that would help make this debate way more
> > technical.
>
> I think it would also help some of us, at the very least me, put your
> objections into context.  I believe the more durable solutions that
> end up in Linus' tree are combinations of designs created out of
> compromise, and right now we are missing the context and detail of
> your ideal solution to be able to do that compromise and get to a
> design and implementation we can all begrudgingly accept.  In the
> absence of a detailed alternate design, and considering that BPF
> signature validation efforts have sputtered along for years without
> any real success, we'll continue to push forward on-list with
> refinements to the current proposal in an effort to drive this to some
> form of resolution.

It sounds like you're asking for Linus's opinion.

This 'hornet' LSM attempts to implement signed bpf programs by
hacking into bpf internals:
https://lore.kernel.org/bpf/20250502184421.1424368-2-bboscaccy@linux.micros=
oft.com/

It got 3 Nacks from bpf maintainers.
Let me recap our objections:

1. Your definition of attack surface says that root is untrusted.
Yet this "hornet" LSM allowlists systemd as trusted.  Allegedly,
it's an intermediate solution.  What it really means that as presented
the security is broken, since an untrusted root can poke into systemd
and make it load whatever bpf programs it wants.

2. you propose to mangle every binary in the system that needs to load
bpf programs with an extra "signature" at the end of the binary that
breaks ELF format.  I already explained earlier that such an approach
was a border line acceptable solution for kernel modules, but
certainly not ok as a general approach for all binaries.  The kernel
modules are consumed by the kernel and user space doesn't touch them.
It's not ok to mangle general purpose binaries.  The user space
tooling relies on well formed ELF files. 'perf record' and any
profiling tool will parse various ELF binaries to symbolize addresses.
If ELF is corrupted such tools may crash. So far you've been lucky
that ld-linux.so was able to interpret such corrupted ELF.
It's not something to rely on.

3. To read this mangled ELF you do:
file =3D get_task_exe_file(current);
buf_sz =3D kernel_read_file(file, 0, &buf, INT_MAX, &sz, READING_EBPF);
A malicious user can give you a multi gigabyte file and your LSM will
happily read it into the kernel memory. It's an obvious DoS vector.

4. I said multiple times it's not ok to do
bpf_map->ops->map_lookup_elem() outside of the bpf subsystem.
You did 'git grep' and argued that something in the net/ directory
is doing that.  Well,
./scripts/get_maintainer.pl `git grep -l -- '->map_lookup_elem' net/`
is your answer.  net/core/filter.c is a part of the bpf subsystem.
The bpf originated in networking.
Also, do build 'hornet' LSM with LOCKDEP and see how many bpf map
lifetime rules you violated with that map_lookup_elem() call.

5. I also explained that map->frozen =3D=3D true doesn't guarantee that
the map is immutable.  It only freezes the map from user space writes.
You argued that when all bpf programs are signed then the non-signed
attacker cannot mangle the map.  That's broken for two reasons:
- you allow systemd to load bpf without signatures
- even when all bpf progs are signed, the program actions are not
controlled after loading, so signed bpf prog that uses map-in-map is
subject to an attack where a malicious root can add loader-map as
inner map-in-map and an unsuspecting program will mangle it.

6. Though bpf instructions have standardized format LSMs shouldn't not
be in the business of parsing them. New instructions are being added.
We don't need a headache that an LSM will start crashing/misbehaving
when a new instruction is added or extended.
bpf instruction parsing belongs in the bpf subsystem.

7. You do: copy_from_bpfptr_offset(&map_fd, ...) then proceed with
content extraction, but this is a user controlled address. It's an
obvious TOCTOU bug. The user can replace that map_fd after your LSM
read it and before bpf verifier reads it. So the signature checking
from LSM is fundamentally broken. I already explained that the
signature check has to be done within a bpf subsystem.

In the last kernel release we added 'bool kernel' parameter to
security_bpf_prog_load() LSM hook assuming that you're going to work
with us on actual solution for signed bpf programs, but so far you
ignored our feedback and accused us of artificially delaying a
solution to signed programs, though we told you that the "light
skeleton" (that you incorrectly attempt to use here) was designed
specifically as a building block towards signed bpf programs:

See the cover letter from 2021:
https://lore.kernel.org/bpf/20210514003623.28033-1-alexei.starovoitov@gmail=
.com/

"
This is a first step towards signed bpf programs and the third approach
of that kind.
...
Future steps:
- support CO-RE in the kernel
- generate light skeleton for kernel
- finally do the signing of the loader program
"
Later in 2022-23 we implemented "CORE in the kernel" and "light skel
for kernel" steps.  There are a few more steps to do that we didn't
anticipate back in 2021.  Like the exclusive map <-> prog relationship
and error propagation through the loading process.

When Blaise volunteered to work on signed progs we pointed him to
light skeleton assuming that you're going to work with us to finish
this complex task. Instead you went with this broken LSM and now
argue that your insecure approach somehow should be accepted by
upstream and microsoft users.
Sorry, but users deserve better than this.

The only path forward here is to:
- stop pushing broken code
- internalize the feedback
- work with the bpf community

The problem is difficult and a truly secure solution will take time.
You cannot short circuit this path.

