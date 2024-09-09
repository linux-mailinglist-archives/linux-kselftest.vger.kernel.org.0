Return-Path: <linux-kselftest+bounces-17546-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8299722AB
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 21:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E0221F22975
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 19:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742C2176AAD;
	Mon,  9 Sep 2024 19:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULUkcW/T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883DD3BB47;
	Mon,  9 Sep 2024 19:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725910223; cv=none; b=sPJ1hIJ9RaZhtcTFTIND5wRN2FqIE0CMCnYtGo6+oSXO69VQiUO/3ivtLe9tK7BpkCv+RyR7EMUDnTHCJIVMhyimnxlK5moVnB/LogOlNDLqJxKOM9hrEuKwCEdOyR7eAeuMXvpmNCllQvxvFRMuK/EhvyaZ1pdU6gX2C1QUDxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725910223; c=relaxed/simple;
	bh=b6OUbZ3BeHYLYkH/EG1gwVc1JeKidM3XMH3k1TlcRSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ctkY2VjS6VoRSA9p4PKvyFrfJafdyc6ZPioWVaE7miFDVDHqtOntdN06waPJx4BXDSai1Yvuey/TzxWC5xnjxokNxJLB4rYm7haE9w7B+gDXPkRLKWiUUX9rwOeJIN0ZsKi10x/LJycmaeTrv3iq2Nxa09YdEJuSFmpfdQqdMJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULUkcW/T; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f7529203ddso32291041fa.0;
        Mon, 09 Sep 2024 12:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725910220; x=1726515020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=woE07RMIM4YJ88QTc1ZNc52E+GbLSESAkfn/9qs5W1Y=;
        b=ULUkcW/Tyq4KqCECB1ruZOR6QLr/CvsNjbWjzoxyCcU/WhgIWArNgD6Hrw1yhGPll4
         BbZrZgIEZXqbrTyCz5p+C+9Tbi+X0PFqI41IrlA72G7t6jcMWBlXn1hl/BZg+SCsuh2c
         oFKCu0rUDejsyES3ag6UhjvEcR2W1GTzr5kbg0wXWhMPvHEvpxtOwpBcXBjvHTzzGBbu
         sqnxB1pvOEKsPJKaQzg3grdZ0/Uu8bags0D135h3don4qXSmUBQRCU3QRtzVQMfkooF1
         HlLPFTAJvjpI6h/TMpxY4yeeRPn6kNraImImFM5Mm8KKJ4wPN/m+v6YW+2Qfak+UP1R/
         BGAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725910220; x=1726515020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=woE07RMIM4YJ88QTc1ZNc52E+GbLSESAkfn/9qs5W1Y=;
        b=RuCISbepDlc2qBedARrKfy9NIxagwPi9nXmTanbwLrflCXWQRuuhhuWCjQakny5EQ6
         dVVn4dHptaOm7sOC82F3tHTdP09ER5e3SmzGl5ZsrP6YG5scw8HWfaKD0b2EM3uZTBVb
         zNDZ/FRSyRBl/NdqnyDsOVKriOmc3oSg8E0zyIeTs26kUabND98HVKFO4c8bvAy5MmSY
         /2xrIABIyFHJhBCOpicOAc60XfsH0bzYbIbEzZArOYzZD4ZlOrDPYY+bpmUCULTgjo8A
         +8ZspDKPaUIxdWTXnRLt+LcwKTXf1A9B9LG3W6t6t+qk4MMhhspHquyIsUy4pyFfRnSJ
         ISzw==
X-Forwarded-Encrypted: i=1; AJvYcCUWZUWg7h9uqj9H8UJt+bwPgqkz9ZgkEOsaRy9Xy/aV2qKsy+8XQnqzcGCWExklp6l99ypYNpXZjk7A/aY=@vger.kernel.org, AJvYcCVkJBaNvChDqj/ocGvutebX7/uNaojYcx+LCrAzQhZGySAJ5CPLHkLG6JhcOXl+Vqw4ljIl7p+ksTeulYhm@vger.kernel.org, AJvYcCVqSOkSR2NOsReuF7N46EAo+BkFxVNvQTb681abDP6RU50sup1uhTf8Ee9V+GUKaWVR+1s=@vger.kernel.org, AJvYcCW6RDHjvzcTnYUkHiG60PmsMlEL+1K0aIG96VywbwJj+PaH+/MplxHinXKs/VXnOE2RLgbIMHW6lmTayqbgcA==@vger.kernel.org, AJvYcCW7z4bLWIPfIUODOf27F4UUlvJqNNFr+ZCdIzE/r5h8c9z25IpLQMyTsmxQpVR+oJq/Bp60H/RMJQCeFA==@vger.kernel.org, AJvYcCX5yDF3sYA1ZtYht2kOSYOyf041BrFFM9nGnDK/pI8ASZzNgc2DLtVJIRC8fr37XuQplQIvQKnZxgodi9ra@vger.kernel.org, AJvYcCXxIBg5WFf32p7sF9babSrlC+lI60uayhIVZYEUGSYkcS+MLafgewbmBH08LKkYo7url+riZjAx/AQdBlRA0jzf@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo6WQkItdOOzWO3D2oL6Li7uG1OEjihi2C2zNBMMOYUAliiV+W
	zAM9ur2Hpy2RdE/NkwMHvKLS96g7Gqy7U6vBMVuM55hGKWLsCrvhjmlAgd9E0fFYyIeL0ZHI5/Z
	6ffmXiWf2tXPkYBMHWvjEikHVEDs=
X-Google-Smtp-Source: AGHT+IHGDlZWsmVxtU6Y46aEXfBA2sgXqI4naIhOyyLQHvnhEyR7+3HqFvBi8W+gcZkb/4A25yABw4d/bXms0qX89pY=
X-Received: by 2002:a05:651c:549:b0:2f7:6277:f2be with SMTP id
 38308e7fff4ca-2f7727190f4mr2037391fa.22.1725910218656; Mon, 09 Sep 2024
 12:30:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909075641.258968-1-ubizjak@gmail.com> <Zt8a6_RwLG2pEnZ6@zx2c4.com>
In-Reply-To: <Zt8a6_RwLG2pEnZ6@zx2c4.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Mon, 9 Sep 2024 21:30:06 +0200
Message-ID: <CAFULd4ak3n1x0tGrqiNoxvDBRw6AWgchfBO_k4aKps34DomPvA@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 00/19] random: Resolve circular include
 dependency and include <linux/percpu.h>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: x86@kernel.org, linux-crypto@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-media@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-fscrypt@vger.kernel.org, linux-scsi@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Hans Verkuil <hverkuil@xs4all.nl>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Hannes Reinecke <hare@suse.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Stephen Hemminger <stephen@networkplumber.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Kent Overstreet <kent.overstreet@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 5:57=E2=80=AFPM Jason A. Donenfeld <Jason@zx2c4.com>=
 wrote:

> On Mon, Sep 09, 2024 at 09:53:43AM +0200, Uros Bizjak wrote:
> > a) Substitutes the inclusion of <linux/random.h> with the
> > inclusion of <linux/prandom.h> where needed (patches 1 - 17).
> >
> > b) Removes legacy inclusion of <linux/prandom.h> from
> > <linux/random.h> (patch 18).
> >
> > c) Includes <linux/percpu.h> in <linux/prandom.h> (patch 19).
>
> Thanks for doing this. That seems like a fine initiative to me. (I'm
> also curious about the future percpu changes you've got planned.)

As explained in the cover letter, recent GCCs are able to track
address space of variables in percpu address space from the
declaration to its usage site. There are certain rules regarding casts
of variables and their pointers (when this named address space is not
considered a subspace of the generic address space), so it is possible
to create much more effective checks for cast-from-as type casts than
what sparse can achieve.

Besides GCC, clang can define various named address space via
address_space attribute:

--cut here--
#define __as(N) __attribute__((address_space(N)))

void *foo(void __as(1) *x) { return x; }         // error

void *bar(void __as(1) *x) { return (void *)x; } // fine
--cut here--

When compiling this, the compiler returns:

clang-as.c:3:37: error: returning '__as(1) void *' from a function
with result type 'void *' changes address space of pointer

Although clang currently errors out when __seg_gs and __seg_fs named
address space designators are used, we can explore its named address
spaces functionality to implement percpu checks for all targets. The
percpu address space checks patchset, referred to in the cover letter,
also supports this functionality when per_cpu_qual is defined to
__attribute__((address_space(N))).

Perhaps we can use different address spaces to also handle __user,
__iomem and __rcu address spaces. This way the compiler will be able
to handle address space checks instead of sparse.

> Tree-wise, were you expecting me to take this through random.git? And if
> so, what timeframe did you have in mind? For 6.12 next week (can you
> poke folks for acks in time?), or punt it for 6.13? Or did you have a
> different tree in mind for treewide changes (in which case, I'll send
> you an ack for the [p]random.h changes).

I think that the best approach is to target this patchset for linux
6.13 via random.git tree. I will prepare a v3 after 6.12rc1, so when
committed to random.git, the patchset will be able to spend some time
in linux-next. This way, there will be plenty of time for CI robots to
do additional checks also for some less popular targets (although
individual patches are dead simple, removing these kinds of "legacy"
includes can be tricky), and I will also be able to collect Acked-by:s
in the meantime.

While the patchset is an improvement by itself, its inclusion is not
time sensitive. The follow up percpu named address checking
functionality requires a very recent feature (__typeof_unqual__
keyword), which is only supported in recent compilers (gcc-14 and
clang-20). Besides compiler support, sparse doesn't know about
__typeof_unqual__, resulting in broken type tracing and hundreds of
sparse errors with C=3D1 due to unknown keyword.

So, I think we are not in a hurry and can take the slow and safe path.

Thanks and best regards,
Uros.

