Return-Path: <linux-kselftest+bounces-27207-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A10A3FDAE
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 18:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C6D63A2D38
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 17:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E2F250BE0;
	Fri, 21 Feb 2025 17:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjGENyva"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A672505D7;
	Fri, 21 Feb 2025 17:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740159653; cv=none; b=feSZz4jZ6YQnIS53iy0YMOkqqhbKCZAw8lY6+fa8NjzOzsR98/fllV8QaMtCX6C8Clg6lqm0zZ5hVQnacTmn7sd41Oahs1OLIFgTr4ViyC/Qn0mFdacEVtViZyv3SsNEiZRykgQWFMJXZDqnRrnHA4Y4M9T+8oV/6hbka7IZ4UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740159653; c=relaxed/simple;
	bh=51abtb4G25xQbbr/J+RXcL4o16pvtYICBzOFpWSlHkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kifuVG7kmZZ5e7xC6oJotS3B/vy/wryO+jF9/p8h0kZwwdSn/Bu6kOP6HWHl2XuHsJCr+pe+FhnNw5OspfUC8g9oiBqIYjVp6pwI+KcHtdIlJI8LP69Yi2/1C+urenbdHW2pg6NOtSUN30A40k369n2nUA1SEjy9ckUFRTIWtwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjGENyva; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fc20e0f0ceso3761602a91.3;
        Fri, 21 Feb 2025 09:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740159651; x=1740764451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=51abtb4G25xQbbr/J+RXcL4o16pvtYICBzOFpWSlHkE=;
        b=DjGENyvalEwUvXyIFhDKTBfNxZXL7MNnWYRRQ0gvVHNZoseyAe8g7Nb2ekNWBHBM1L
         ETsp0MY/2UsvqafLxUtlUusSeryKsVi5c8tke3l5MfCl3Q4EpkvozLZE1nQFKEHdzLHF
         60O8/R8LCyWbpptIq/MROuiK26PybBAEOQfAz7sUqLqvDUD3lwJ1nxzrzO2dvpLEze+r
         xxnBTiLOQOqYXNjl6ddKgdtq8PW3rAN5CmWE5HkanFegfZFot3KDtcahC/EYNxiPQinN
         SmXmbKFInGm5o4dzT+XgQFGvLgAkjNL0XCsfcS5qvVp1QygjxlFGvz5x+CnOVpkzEczh
         ApMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740159651; x=1740764451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=51abtb4G25xQbbr/J+RXcL4o16pvtYICBzOFpWSlHkE=;
        b=FwCeAezWIiaSiq6f7iZAiFHkwLNkNevl6zlAT2Up083AutnSOJ9H1tqWIfqn98KWxB
         VNOM5jxnFv9b8Q+66kt/FVSHk/JT2+sIHZSNTvqqyWoVAqRlSKuYLsyhyJXTHygIJLd3
         YhR4mm9W45FHDzXHnh7rnwqTLcnu+nDY9v/YgQ7wA6xq25VloFHN1Gu8BWYTyijMDT1+
         BOgHWx2OUzbeOACwSvG2bCnGxGJcSQvteMga2mCehjHJxhNBnp2CKL7YffKMi8HLK31H
         wmt3TzlI3ypzvLz2QCudwDMsL3USWdJUWbRY/RPWIP4IkdkznXx/MawbbeHoYafFIrWn
         v4iA==
X-Forwarded-Encrypted: i=1; AJvYcCWkxVUfevf3T+8BB43OLLKuJVK5eIZXauyMXDlHjSpvqc2I21+T6X+xcV8fjKC0Awj4pMs=@vger.kernel.org, AJvYcCX99R5i+A5vXJvuLIIrn5sD6JUMvwZzm71gk9FD20jrz7O667I1bFYJjiGXLZ8kgbOxKJAlStV1FHSiQ2A2VVx6@vger.kernel.org, AJvYcCXR7Fndz+cZ/Q42GaPZlSMGCQ8P4xEpmg4HSvznD0jceMzQsMmAbKnaETW7ALMFiTeARTQpyxqSE2RKI8r3@vger.kernel.org
X-Gm-Message-State: AOJu0YxdMqCc/ehOTZBMKyiXdOxo8J8rx6p32iJEnDhViW5bgugskAlE
	Z+8VzazRSsyYylxlTFTgg4plADGlOqlxKhfDeqIeFuo4Vg3b/P6nw/yLyf0hNMxx7CkiyMdd/uk
	0HBXEaKIf8bwIpg0Kp8sjVriLE54=
X-Gm-Gg: ASbGncs/0zs5XvdU3mS7u8gaeDz0sfsdQq24S/K32jg8O2Zfh6EIEbk2tmLr+AKKtCz
	WtITNjQhNx/xMZa4HlUoWA3QXDzRw2bPqVzEmkuxq/kQ978RrXfKHTl2WwYR/UHdKteaMjl8Tsv
	VjMr8sJMQelcuSj5Q9x0uzD68=
X-Google-Smtp-Source: AGHT+IF0wvO6nfjhFNyrRaqFKb0R8TES6IvyDZZ2RRaEdEPeYGHy7fTD5oobMg7SXrr5e7wPV9/OWPniyDlc5SIHNw4=
X-Received: by 2002:a17:90b:2b8e:b0:2ea:3f34:f18f with SMTP id
 98e67ed59e1d1-2fce78cbeaemr6175693a91.19.1740159649264; Fri, 21 Feb 2025
 09:40:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122215206.59859-1-slava.imameev@crowdstrike.com>
 <20250122215206.59859-2-slava.imameev@crowdstrike.com> <CAEf4Bzajxh4xvg-aCaBhLQdNOZdhwceYUD2UsCcWku4ZBca_Hw@mail.gmail.com>
 <8831ed8fa183f76fefd71244360fa0ca35b11910.camel@crowdstrike.com>
 <CAEf4BzYWe0KCzA4-qwAGp5n_ydJ0_zyLSO=Crr_vewFHzZ0t6Q@mail.gmail.com>
 <e55a1441252079e73b2abdf3635efcebda6b47c1.camel@crowdstrike.com>
 <CAEf4BzZ8H0nQMEMaDGMfyngb15zMFEduy_R_ajakrdjGGtiOQA@mail.gmail.com> <7727e5d4f035c04d03ba274ad8b7fb8bc7da696c.camel@crowdstrike.com>
In-Reply-To: <7727e5d4f035c04d03ba274ad8b7fb8bc7da696c.camel@crowdstrike.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 21 Feb 2025 09:40:36 -0800
X-Gm-Features: AWEUYZmrHlpwSSF-oG8LZ8mihpEMSqMTy8rAUnz6iKydBzQ5cX3pjuinhtRb2Kk
Message-ID: <CAEf4BzZ=-r7AkSGhru_NMxPcXDLmkVpTiQrBxUvsgq-LE0Lk6w@mail.gmail.com>
Subject: Re: Re: Re: Re: [PATCH 2/2] libbpf: BPF programs dynamic loading and attaching
To: Martin Kelly <martin.kelly@crowdstrike.com>
Cc: "mykolal@fb.com" <mykolal@fb.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"eddyz87@gmail.com" <eddyz87@gmail.com>, "song@kernel.org" <song@kernel.org>, 
	Mark Fontana <mark.fontana@crowdstrike.com>, 
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, 
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "andrii@kernel.org" <andrii@kernel.org>, 
	"kpsingh@kernel.org" <kpsingh@kernel.org>, "martin.lau@linux.dev" <martin.lau@linux.dev>, 
	"ast@kernel.org" <ast@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"sdf@fomichev.me" <sdf@fomichev.me>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	Slava Imameev <slava.imameev@crowdstrike.com>, "jolsa@kernel.org" <jolsa@kernel.org>, 
	"haoluo@google.com" <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 2:31=E2=80=AFPM Martin Kelly
<martin.kelly@crowdstrike.com> wrote:
>
> On Mon, 2025-02-10 at 16:06 -0800, Andrii Nakryiko wrote:
> > > Tracking associated maps for a program is not necessary. As long as
> > > the last BPF program using the BPF map is unloaded, the kernel will
> > > automatically free not-anymore-referenced BPF map. Note that
> > > bpf_object itself will keep FDs for BPF maps, so you'd need to make
> > > sure to do bpf_object__close() to release those references.
> > >
> > > But if you are going to ask to re-create BPF maps next time BPF
> > > program is loaded... Well, I'll say you are asking for a bit too >
> > > much,
> > > tbh. If you want to be *that* sophisticated, it shouldn't be too
> > > hard
> > > for you to get all this information from BPF program's
> > > instructions.
> > >
>
> We really are that sophisticated (see below for more details). We could
> scan program instructions, but we'd then tie our logic to BPF
> implementation details and duplicate logic already present in libbpf
> (https://elixir.bootlin.com/linux/v6.13.2/source/tools/lib/bpf/libbpf.c#L=
6087
> ). Obviously this *can* be done but it's not at all ideal from an
> application perspective.
>

I agree it's not ideal, but it's also not some complicated and
bound-to-be-changed logic. What you point out in libbpf source code is
a bit different thing, reality is much simpler. Only so-called ldimm64
instruction (BPF_LD | BPF_IMM | BPF_DW opcode) can be referencing map
FD, so analysing this is borderline trivial. And this is part of BPF
ISA, so not going to change.

We need to double check, but I think libbpf doesn't use FD_ARRAY
approach, unless you are using light skeleton, so if you don't you
don't even have to worry about FD_ARRAY thing.

>
> > > > >
> > > bpf_object is the unit of coherence in libbpf, so I don't see us
> > > refcounting maps between bpf_objects. Kernel is doing refcounting
> > > based on FDs, so see if you can use that.
> > >
>
> I can understand that. That said, I think if there's no logic across
> objects, and bpf_object access is not thread-safe, it puts us into a
> tough situation:
> - Complex refcounting, code scanning, etc to keep consistency when
> manipulating maps used by multiple programs.
> - Parallel loading not being well-balanced, if we split programs across
> objects.
>
> We could alternatively write our own custom loader, but then we=E2=80=99d=
 have
> to duplicate much of the useful logic that libbpf already implements:
> skeleton generation, map/program association, embedding programs into
> ELFs, loading logic and kernel probing, etc. We=E2=80=99d like some way t=
o
> handle dynamic/parallel loading without having to replicate all the
> advantages libbpf grants us.
>

Yeah, I can understand that as well, but bpf_object's single-threaded
design and the fact that bpf_object__load is kind of the final step
where programs are loaded (or not) is pretty backed in. I don't see
bpf_object becoming multi-threaded. The dynamic program
loading/unloading/loading again is something that I can't yet justify,
tbh.

So the best I can propose you is to use libbpf's skeleton and
bpf_object concept for, effectively, ELF handling, relocations, all
the preparations up to loading BPF programs. And after that you can
take over loading and handling program lifetime outside of bpf_object.

Dynamic map creation after bpf_object__load() I think is completely
outside of the scope and you'll have to solve this problem for
yourself. I would point out, though, that internally libbpf already
switched to sort-of pre-creating stable FDs for maps before they are
actually created in the kernel. So it's conceivable that we can have
more granularity in bpf_object preparation. I.e., first step would be
to parse ELF and handle relocations, prepare everything. After that we
can have a step to create maps, and then another one to create
programs. Usually people would do all that, but you can stop right
before maps creation or before program creation, whatever fits your
use case better.

The key is that program instructions will be final and won't need
adjustments regardless of maps actually being created or not. FDs, as
I mentioned, are stable regardless.

So, not ideal for your (very complicated) use case, but you still
avoid dealing with all the ELF and relocation stuff (which is the
annoying and rather complicated part, and I can see no one wanting to
reimplement that). Map and program creation is relatively
straightforward matters compared to that.

> > >
> > >
> > > Is 100 just a nicely looking rather large number, or do you really
> > > have 100 different BPF programs? Why so many and are they really
> > > all
> > > unique?
> > >
> > > Asking because if it's just a way to attach BPF program doing more
> > > or
> > > less uniform set of actions for different hooks, then perhaps there
> > > are better ways to do this without having to duplicating BPF
> > > programs
> > > so much (like BPF cookie, multi-kprobes, etc, etc)
>
> 100 is not an arbitrary number; we have that and higher (~200 is a good
> current estimate, and that grows as new product features are added).
> The programs are really doing different things. We also have to support
> a wide range of kernels, handling cases like: "on this kernel range,
> trampolines aren't supported, so use kretprobes with a context map for
> function args instead of fexit, but on newer kernels just use an fexit
> hook."

Yes, this is typical, and bpf_program__set_autoload() and
bpf_map__set_autocreate() are meant to handle that. It's the program
loading after bpf_object load is what is not supported.

>
> The use case here is that our security monitoring agent leverages eBPF
> as its foundational technology to gather telemetry from the kernel. As
> part of that, we hook many different kernel subsystems (process,
> memory, filesystem, network, etc), tying them together and tracking
> with maps. So we legitimately have a very large number of programs all
> doing different work. For products of this scale, it increases security
> and performance to load this set of programs and their maps in an
> optimized, parallel fashion and subsequently change the loaded set of
> programs and maps dynamically without disturbing the rest of the
> application.

Yes, makes sense. You'll need to decide for yourself if it's actually
more meaningful to split those 200 programs into independent
bpf_objects by features, and be rigorous about sharing state (maps)
through bpf_map__reuse_fd(), which would allow to parallelize loading
within confines of existing libbpf APIs. Or you can be a bit more
low-level with program loading outside of bpf_object API, as I
described above.

