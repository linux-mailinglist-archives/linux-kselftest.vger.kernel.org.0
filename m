Return-Path: <linux-kselftest+bounces-17235-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD0096D9A9
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 15:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46A411F225DF
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 13:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E712819B5B8;
	Thu,  5 Sep 2024 13:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/ZXTcgJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6141993BB;
	Thu,  5 Sep 2024 13:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725541420; cv=none; b=T9UBic5fVDBbKTCmFhUtEO7NM4/HcgSdmTGLHZDUR2bh998n1llsvWkx6jNs9lHPC/l3ZIJy8MWAWuYqTqasZmNy8ykL8gTImgDpl7o3W3Z4hDWdlFjpfoSn9IznKjRk/gAtyL9X06j5Bzi9jjcNcfY7t9To4km2QfEJpexPQqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725541420; c=relaxed/simple;
	bh=l78Es5LyXO8HlshIKyFCw3FJ6WY+74TWTtLCFZ5ilak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ntAY1OYQ+8RVMNx2lUVilDLDZBM9TqAcnQRYPMSAFjVt1GrB0V0pcDQBRS4uNve7AJ14lV0qWOIl1Dx0Uh0VVZ8g0EiwLeou79eEbzK2TXlOLrORBgvFXq4sPZJ75whNLcbZglExLXrfEDJ0OhrM49yPX9735jjDaSu7NAwH+Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/ZXTcgJ; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f5064816edso9474641fa.3;
        Thu, 05 Sep 2024 06:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725541417; x=1726146217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4Ap3iChcCI6LjI4bbXEj5UiVcIZisPfcA3U2HCE+kE=;
        b=N/ZXTcgJgQvqOmuoSDu2t9zqSR+SP8MvXeKtyTg6aegtm2CmP0sgw6KdCAnke6NVo2
         VKZ2KMmg1PcoVinBpBmpYN1Ws/j7cPRVzR3byNCK3V6nESbyrvKuJ7elMAT9/EJeuOvp
         6ol1ZgYXSbgiCiYAwLnxReN4e3/1+tWJiIWVBoTidz+n/Avb24ELVUWg3iNOowUSg11x
         CnDiOVdbpPiVQrs3X79OmdmjnY2UCq2AF+JUsIq+6+LYyYUqirpiyzv06CDlsuTqzJfM
         DxiPra1hV9Re//fkUacf6tAZhhkRUqCZjzOsdr8gl8iF7D0hNOR5D9i1BpaYRx3aIsIL
         uJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725541417; x=1726146217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J4Ap3iChcCI6LjI4bbXEj5UiVcIZisPfcA3U2HCE+kE=;
        b=tboGEHH5240337ouZbYSQ78cpZWsOKvh47ARcYvYCyetvbZwfon3UmNdro7XkpLddL
         SdIYMU9apBV4X6iTgPluWzzRIRomrCeEyYMOwj1aRv1nl8Pe6iqOaczqzmdxZaJMnMfO
         WhgpXmwFQj8yoEGkx8N2smLGZVkEEB4RqOw60pX9zCmiFTyWcy7T4BjaMjDDoRUe9mFS
         m4w+4MkZF85CD9zwUlfWrqCv92XnQYUt+Ci2A2G8Mih3LgoEhZCHXdQ4YpgN1Tp3+YSa
         TC2NZwh365/JGt5E5bb6daJlTv7Kdzlbgph93KO3tpdkLvw6z96rKG1hSx0azSm7c9Jo
         Afyw==
X-Forwarded-Encrypted: i=1; AJvYcCUkyFrzYmpuqkqVsDiPbl3lOA+6rCni+zDR7ARNVRFSXuV71vhY2+T3fFwNBnDlWZ277GLSAT1sQDvuWSO2AjyN@vger.kernel.org, AJvYcCWufdhOIaHz6KcofWICqoqHk46mmJbddJKeQB4TxoSuV/B+aF4JLXSsssjuUDpzKnR/IV2rbwr4e4iPfZI=@vger.kernel.org, AJvYcCWvGoNmouFtKUQuWnodJJLfzrWex0ZOsQ4BHp54TG6fQScQmf+qjfK6Gl8eckxxHdC+Ib4q4RjJ/jvZcA==@vger.kernel.org, AJvYcCXHXiXkAhHf82kKasSd0CQPScF/ydK4Kwhsq7GcSCAkUUoL40iLTbagxjBA+HNNxcVuWcsU0iqFUZpBmzekcA==@vger.kernel.org, AJvYcCXIt+F9I5NFwSwUDFROOlHorVzn7d4xpfjiBrohH5pBlHWzsCkMxcxuZJAGWtv2R+VyrWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxoOpphJ9TXyvlU12VlgbACh8KswjDsRvt2rG377ix88dA7kRs
	Hw8kUwYFzczBsxBGHNV+udnseSWoJKRJv+zW7Iz43BdzI7+FqdSiLJ1F3Cl6poHpbmzv2zClCi6
	vsznHksPH+ZoAQb7SaIzfbVv7Ims=
X-Google-Smtp-Source: AGHT+IETBLGAu3Qd00jjqcPIw+YbfEw8PL6KVZG3phkN8mEHyaiFDy+b4h0Zi/X597x+B58/kQSA12RjAv0BY7eFUFU=
X-Received: by 2002:a2e:a54b:0:b0:2ef:2b06:b686 with SMTP id
 38308e7fff4ca-2f6103a565bmr183794191fa.17.1725541415766; Thu, 05 Sep 2024
 06:03:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905122020.872466-1-ubizjak@gmail.com> <Ztmm00eLBQGtiwRM@smile.fi.intel.com>
In-Reply-To: <Ztmm00eLBQGtiwRM@smile.fi.intel.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 5 Sep 2024 15:03:24 +0200
Message-ID: <CAFULd4bzyNGcJqeg7w2ZQ0Xmw-HsBhczf8yPna7mSgG4NmdcWw@mail.gmail.com>
Subject: Re: [PATCH 00/18] random: Include <linux/percpu.h> and resolve
 circular include dependency
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Hans Verkuil <hverkuil@xs4all.nl>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Hannes Reinecke <hare@suse.de>, 
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
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Stephen Hemminger <stephen@networkplumber.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-media@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-fscrypt@vger.kernel.org, linux-scsi@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 2:41=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Sep 05, 2024 at 02:17:08PM +0200, Uros Bizjak wrote:
> > There were several attempts to resolve circular include dependency
> > after the addition of percpu.h: 1c9df907da83 ("random: fix circular
> > include dependency on arm64 after addition of percpu.h"), c0842fbc1b18
> > ("random32: move the pseudo-random 32-bit definitions to prandom.h") an=
d
> > finally d9f29deb7fe8 ("prandom: Remove unused include") that completely
> > removes inclusion of <linux/percpu.h>.
> >
> > Due to legacy reasons, <linux/random.h> includes <linux/prandom.h>, but
> > with the commit entry remark:
> >
> > --quote--
> > A further cleanup step would be to remove this from <linux/random.h>
> > entirely, and make people who use the prandom infrastructure include
> > just the new header file.  That's a bit of a churn patch, but grepping
> > for "prandom_" and "next_pseudo_random32" "struct rnd_state" should
> > catch most users.
> >
> > But it turns out that that nice cleanup step is fairly painful, because
> > a _lot_ of code currently seems to depend on the implicit include of
> > <linux/random.h>, which can currently come in a lot of ways, including
> > such fairly core headfers as <linux/net.h>.
> >
> > So the "nice cleanup" part may or may never happen.
> > --/quote--
> >
> > __percpu tag is currently defined in include/linux/compiler_types.h,
> > so there is no direct need for the inclusion of <linux/percpu.h>.
> > However, in [1] we would like to repurpose __percpu tag as a named
> > address space qualifier, where __percpu macro uses defines from
> > <linux/percpu.h>.
> >
> > This patch series is the "nice cleanup" part, and allows us to finally
> > include <linux/percpu.h> in prandom.h.
> >
> > The whole series was tested by compiling the kernel for x86_64 allconfi=
g
> > and some popular architectures, namely arm64 defconfig, powerpc defconf=
ig
> > and loongarch defconfig.
>
> Obvious question(s) is(are):
> 1) have you seen the Ingo's gigantic patch series towards resolving issue=
s with
> the headers?
> 2) if not, please look at the preliminary work and take something from th=
ere, I
> believe there are many useful changes already waiting for a couple of yea=
rs to
> be applied.
>
> Because I haven't found any references nor mentions of that in the cover =
letter
> here and explanation why it was not taking into consideration.

I am aware of the series, but the patch takes only a small bite of it
and specifically resolves the inclusion of <linux/prandom.h> from
linux/random.h. The series fixes the missing inclusion of
<linux/prandom.h> in files that use pseudo-random function and it was
not meant to be a general header cleanup. The end goal is to allow us
to include <linux/percpu.h> in linux/prandom.h - which uses __percpu
tag without the correct include.

Thus, the patch series is only tangentially connected to Ingo's patch serie=
s.

Best regards,
Uros.

