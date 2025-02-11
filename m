Return-Path: <linux-kselftest+bounces-26271-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FA9A2FEC9
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 01:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F1811887884
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 00:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2551E1361;
	Tue, 11 Feb 2025 00:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/4b9N2X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C4D801;
	Tue, 11 Feb 2025 00:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739232405; cv=none; b=CeupjLbwBFYFIxa60XIRjcxyP4RRrom0BKRAcHPBdMchdGyM/CKGZbi7/ftvHxDSeXBlS6iwZvHNSolSJcVEnTnW3I5edeXAMekpVZo4qnX80lW5W80E8b4S7Wvio4lhONV4Pp7NKlznbJTRigcPX8tG5aUAGLNtUNvKmWBJF84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739232405; c=relaxed/simple;
	bh=ndRCU9kUZEOJ6DChJUaanLcQB6QwrKKxofqia2w44YU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FcyKYmxuf22Az8EwMRsqD4cIjQV1aI+c4K3ITJ8ccC25ded8SZxyi+YoebfF4MlAGVoVQUjpn79lL4iWjmmNcH7Fd9eI3Oq7R2j+zINvoCMGAFkJCAi3RaBdIrvrHWU0oer7Ek96fO8nL+6nPBTuWDQHzCokuY7lIqRkY+0fS7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/4b9N2X; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaecf50578eso982970566b.2;
        Mon, 10 Feb 2025 16:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739232401; x=1739837201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGG5ngyl14ZIlnl7tSYxVC/wFQzcXTGOTAcki9qZ1og=;
        b=Z/4b9N2XqRnofx1WrmTciErfB53buCZQjo8r1ey27770SH/Xz70n0p8zKI1ENLPDG7
         BEDDvw+j0mLxpmxTkmx1LdaXHlDfl7UhGUMmVMKDb1pu5Pku+v5NSgTKbcDq3x6Sqdq4
         SaUx5WXSPoNM1AhVxLDYbiYPiSS6PcUjfT9WxwutEDmA3GMOq3QlRGYUirkat17zmSy0
         P3BfTI3p/Mftbcpb86N9FONpxXV3mloDR+T1a/pasw/28PPplA/2b7qmLjud/HwPBcn3
         O3irYVFrHZD8315T6e5RD7HYNPpgnyYQIUtaU4d06vZsnPmuHTJsLLLLMXEJ+BK0QiCx
         O8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739232401; x=1739837201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGG5ngyl14ZIlnl7tSYxVC/wFQzcXTGOTAcki9qZ1og=;
        b=SRrUB76ceZBhwaNAzfLMTcF+VZt+Xbk58/UgEZk+KzeRomcuCPZTepP8dZB/4CKbQ0
         X9Q8gWnk1paCQcDTZMRSH/iQvnYc81MVFIMl6Ih72Cgw6Lw6v2nCm9Euba3jVn8O5xhT
         8e2wgGyQmC8qySahoJoJGRu2BZ1V63a45nKNW/eSXPImfMDW2hrp6ZLhrcKgkEeFjuec
         sMvcU117+BQlusbbXz/MExJowvWbN+/otoGmHuf0GjCCsps258zSx91tQJJR7hm/ElUT
         W33EbvMlPnqGZVUWtMaJek2sG39ybRaJeJwV8ecfJ4RL1bGK20nIS6umunkbD6rnjInB
         8Y1Q==
X-Forwarded-Encrypted: i=1; AJvYcCV22k1gyKSRY6RniFpo25WdYj99kPvDH/TxW2Zm3KDepWCWJEQrUNMhnaoTMnMG/ZOb7+I=@vger.kernel.org, AJvYcCVUZ7T/jvomxSmtjvGYqEJh6GYjCH9/beCasaPFMwZIOGWHDkgZlwqOXgoek1BocVNINrNxb8IH9yoojhEYMYEI@vger.kernel.org, AJvYcCWYqUATvuvwc3krnm2vbj+yzyNUzeNnnKki7JqLccusaCez44vlfpZ7+PjxLfF1oEKoAtKvICfe/XY83kpx@vger.kernel.org
X-Gm-Message-State: AOJu0YxCQkkvKKmnV589sIl2R8JNOeG4COx8WiijG5Nk5FxvhbA26WqT
	bMwYG6Oq363MAqZAn82xX6C21vI6nC56nRsDqCHB0HK5L1HjXGBHl+8jzG8BFEmkgUujTCWaHdH
	AKFI29VHS+cxVtId14wbKdzIKUvg=
X-Gm-Gg: ASbGncuBYQYsV0Wi8TeSYtc6+zUoydI2iNy9fllruXI0rgvYNTc+9rZ8DS8NA7a+YdH
	SkaF+4EbdKXZTdvKzqW6Q/8C3HXFEcta5T8PDFsFXH95MwxVTG8x1PSkmiiFvoSvANVW7QhoLIr
	BttXIgEPlCJGZx
X-Google-Smtp-Source: AGHT+IG8RjLeGYPoss2EA3HXx1Elc1kGh8E1ib6/lNJ3+X88DmzqaCCkoGpCiqcBRKMjg1RimYN0rWwd9w978kACMes=
X-Received: by 2002:a17:907:d389:b0:ab7:dec1:b368 with SMTP id
 a640c23a62f3a-ab7dec1cfdemr46071366b.36.1739232401017; Mon, 10 Feb 2025
 16:06:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122215206.59859-1-slava.imameev@crowdstrike.com>
 <20250122215206.59859-2-slava.imameev@crowdstrike.com> <CAEf4Bzajxh4xvg-aCaBhLQdNOZdhwceYUD2UsCcWku4ZBca_Hw@mail.gmail.com>
 <8831ed8fa183f76fefd71244360fa0ca35b11910.camel@crowdstrike.com>
 <CAEf4BzYWe0KCzA4-qwAGp5n_ydJ0_zyLSO=Crr_vewFHzZ0t6Q@mail.gmail.com> <e55a1441252079e73b2abdf3635efcebda6b47c1.camel@crowdstrike.com>
In-Reply-To: <e55a1441252079e73b2abdf3635efcebda6b47c1.camel@crowdstrike.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 10 Feb 2025 16:06:17 -0800
X-Gm-Features: AWEUYZnGim-q59AbQiZ9KCmoSthQdPC6EDh2PHdQ6isbMTZWAMyZo5ZVx9OZ878
Message-ID: <CAEf4BzZ8H0nQMEMaDGMfyngb15zMFEduy_R_ajakrdjGGtiOQA@mail.gmail.com>
Subject: Re: Re: Re: [PATCH 2/2] libbpf: BPF programs dynamic loading and attaching
To: Martin Kelly <martin.kelly@crowdstrike.com>
Cc: "mykolal@fb.com" <mykolal@fb.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"eddyz87@gmail.com" <eddyz87@gmail.com>, "song@kernel.org" <song@kernel.org>, 
	"andrii@kernel.org" <andrii@kernel.org>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>, 
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>, Mark Fontana <mark.fontana@crowdstrike.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"ast@kernel.org" <ast@kernel.org>, "martin.lau@linux.dev" <martin.lau@linux.dev>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "sdf@fomichev.me" <sdf@fomichev.me>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	Slava Imameev <slava.imameev@crowdstrike.com>, "jolsa@kernel.org" <jolsa@kernel.org>, 
	"haoluo@google.com" <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 5:13=E2=80=AFPM Martin Kelly
<martin.kelly@crowdstrike.com> wrote:
>
> On Wed, 2025-02-05 at 14:33 -0800, Andrii Nakryiko wrote:
> > > > >
> > > > > I see two ways forward for you. Either you can break apart your
> > > > > BPF
> > > > > object of ~100 BPF programs into more independent BPF objects >
> > > > > > (seeing
> > > > > that programs can be independently loaded/unloaded depending on
> > > > > configuration, seems like you do have a bunch of logic > >
> > > > > independence,
> > > > > right?). I assume shared BPF maps are the biggest reason to
> > > > > keep > > all
> > > > > those programs together in one BPF object. To share BPF maps >
> > > > > > between
> > > > > multiple BPF objects libbpf provides two complementary
> > > > > interfaces:
> > > > >
> > > > >   - bpf_map__reuse_fd() for manual control
> > > > >   - BPF map pinning (could be declarative or manual)
> > > > >
> > > > > This way you can ensure that all BPF objects would use the same
> > > > > BPF
> > > > > map, where necessary.
> > > > >
>
> I think this approach *could* work but could easily become complex for
> us because we'd need to track all the dependencies between programs and
> maps, and anything missed could lead to difficult refcount bugs.
>
> Further, splitting into objects incurs some performance and memory cost
> because bpf_object__load_vmlinux_btf will be called for each object,
> and there's currently no way to share BTF data across the objects.
> Having a single BPF object avoids this issue. Potentially, libbpf could
> cache some BTF data to make lessen the impact.
>
> > > > > Alternatively, we can look at this problem as needing libbpf to
> > > > > > > only
> > > > > prepare BPF program code (doing all the relocations and stuff
> > > > > like
> > > > > that), but then application actually taking care of > >
> > > > > loading/unloading
> > > > > BPF program with bpf_prog_load() outside of bpf_object
> > > > > abstraction.
> > > > > I've had an almost ready patches splitting bpf_object__load()
> > > > > into > > > two
> > > > > steps: bpf_object__prepare() and bpf_object__load() after that.
> > > > > "prepare" step would create BPF maps, load BTF information,
> > > > > perform
> > > > > necessary relocations and arrive at final state of BPF program
> > > > > code
> > > > > (which you can get with bpf_program__insns() API), but stopping
> > > > > > > just
> > > > > short of actually doing bpf_prog_load() step.
> > > > >
> > > > > This seems like it would solve your problem as well. You'd use
> > > > > > > libbpf
> > > > > to do all the low-level ELF processing and relocation, but then
> > > > > > > take
> > > > > over managing BPF program lifetime. Loading/unloading as you
> > > > > see > > fit,
> > > > > including in parallel.
> > > > >
> > > > > Is this something that would work for you?
> > > > >
>
> I think this API could work, though I think we would need a few other
> modifications as well in order to correctly handle program/map
> dependencies and account for relocations. At a high level, I think we'd
> need something that includes:
>
> 1) A way to associate each BPF program with all the maps it will use
> (association of struct bpf_program * --> list of struct bpf_map * in
> some form). This is so that we can load/unload associated maps when we
> load/unload a program.

Tracking associated maps for a program is not necessary. As long as
the last BPF program using the BPF map is unloaded, the kernel will
automatically free not-anymore-referenced BPF map. Note that
bpf_object itself will keep FDs for BPF maps, so you'd need to make
sure to do bpf_object__close() to release those references.

But if you are going to ask to re-create BPF maps next time BPF
program is loaded... Well, I'll say you are asking for a bit too much,
tbh. If you want to be *that* sophisticated, it shouldn't be too hard
for you to get all this information from BPF program's instructions.

>
> 2) An API to create a BPF map, in case a new map needs to be loaded
> after initial startup.

bpf_map_create()?

>
> 3) An API to allow unloading a map while keeping map->fd reserved. This
> is important because the fd value is used by BPF program instructions,
> so without something like this, we'd have to redo the relocation
> process for any other BPF programs that access this map (and thus
> reload those programs too). This API could be implemented by dup'ing a
> placeholder fd.
>

dup2() or dup3()? (heh, and yeah, you did ask what I was anticipating above=
 ;) )

> Alternatively, if libbpf could automatically refcount maps across
> multiple BPF objects to load/unload them on demand, then all of the
> above work could happen behind the scenes. This would be similar to the
> other approach you mentioned, but with libbpf doing the refcounting
> heavy lifting instead of leaving that to each application, thus more
> robust and elegant. This would mean changing libbpf to (a) synchronize
> access to some map functions and (b) allowing struct bpf_map * to be
> shared across BPF objects. Perhaps a concept of a "collection of BPF
> objects" might allow for this.

bpf_object is the unit of coherence in libbpf, so I don't see us
refcounting maps between bpf_objects. Kernel is doing refcounting
based on FDs, so see if you can use that.

>
> > > > > > > > >
> > > > > > > > > This patch set also permits loading BPF programs in
> > > > > > > > > parallel if > > > > the
> > > > > > > > > application wishes. We tested parallel loading with
> > > > > > > > > 200+ BPF > > > > > > programs
> > > > > > > > > and found the load time dropped from 18 seconds to 5
> > > > > > > > > seconds > > > > when > > done
> > > > > > > > > in parallel on a 6.8 kernel.
> > > > >
> > > > > bpf_object is intentionally single-threaded, so I don't think
> > > > > we'll > > > be
> > > > > supporting parallel BPF program loading in the paradigm of > >
> > > > > bpf_object
> > > > > (but see the bpf_object__prepare() proposal). Even from API > >
> > > > > > standpoint
> > > > > this is problematic with logging and log buffers basically
> > > > > assuming
> > > > > single-threaded execution of BPF program loading.
> > > > >
> > > > > All that could be changed or worked around, but your use case
> > > > > is > > not
> > > > > really a typical case, so I'm a bit hesitant at this point.
> > > > >
> > > > > > > > >
>
> I can understand where you're coming from if no one else has mentioned
> a use case like this. We can do parallel loading by splitting our
> programs into BPF objects, but unless the objects are split very
> evenly, this results in less optimal load time. For example, if 100
> programs are split into 2 objects and one object has 80 programs while
> the other has 20, then the one with 80 programs creates a bottleneck.
> >

Is 100 just a nicely looking rather large number, or do you really
have 100 different BPF programs? Why so many and are they really all
unique?

Asking because if it's just a way to attach BPF program doing more or
less uniform set of actions for different hooks, then perhaps there
are better ways to do this without having to duplicating BPF programs
so much (like BPF cookie, multi-kprobes, etc, etc)

