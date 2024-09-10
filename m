Return-Path: <linux-kselftest+bounces-17558-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B823972637
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 02:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 018FC1F24B09
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 00:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C413B27269;
	Tue, 10 Sep 2024 00:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ZKwT+fr4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B87DF4EB;
	Tue, 10 Sep 2024 00:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725928677; cv=none; b=roBtr6YVMxxBHugMO7V01Nj0qpD8GIGjcynrr7zTEnPomHlqCJawXU7+dFPxc+dWJa6MzNykBa9CAnjxlH0Hua4ZS/XKv4hCpGFV+rHT1Zh/zxpRL0Zy579gKQWxkL7Fdf1lasqRNA2RnfG0Abj54G7j/CMkbdCt3osTyV71WEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725928677; c=relaxed/simple;
	bh=jr5zVGRGboL5XtozuVLN38ByT/dg4+14+mi3ttijOhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IynONVi+VOwrI3/gTULrbtV3ITfxXPKwt8SH9fjxBcCU9wekCYDu8OFfhQdxn4sqzNTd6wnWuZcyKegnqQkwXm8wDG+IQhmVuqIgJzXiv2N0FFUD6Qo6RYjMARTMErkgADVWFpAys88AA4J3W+hHrlScP790oCFP2qgAx9Qnam0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=ZKwT+fr4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51DC3C4CEC5;
	Tue, 10 Sep 2024 00:37:50 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ZKwT+fr4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725928668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OQLtanPdpI6IiO92yLD4QK+WpMduqZbfYjfvTA4Wjlg=;
	b=ZKwT+fr48l6iq8LtejYrRYTAB9HVjSoYl2w9SIS8taTr8eJGaMN+UnDXFn2Y+3WPqB/R/F
	rRaSffSolaALbBnXYJobLzN3VpV4Ezx51BMaa/1NhCLY3oqj42i7Mx1nH5OoYZ9G42zSuF
	N4doRAUS+Xs6qZlnbpNizLgjSg5FNi8=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 9dac766c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Sep 2024 00:37:47 +0000 (UTC)
Date: Tue, 10 Sep 2024 02:37:38 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-crypto@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-fscrypt@vger.kernel.org, linux-scsi@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Eric Biggers <ebiggers@kernel.org>,
	"Theodore Y. Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Hannes Reinecke <hare@suse.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH RESEND v2 00/19] random: Resolve circular include
 dependency and include <linux/percpu.h>
Message-ID: <Zt-U0opo2EW8LSRJ@zx2c4.com>
References: <20240909075641.258968-1-ubizjak@gmail.com>
 <Zt8a6_RwLG2pEnZ6@zx2c4.com>
 <CAFULd4ak3n1x0tGrqiNoxvDBRw6AWgchfBO_k4aKps34DomPvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFULd4ak3n1x0tGrqiNoxvDBRw6AWgchfBO_k4aKps34DomPvA@mail.gmail.com>

Hi Uros,

On Mon, Sep 09, 2024 at 09:30:06PM +0200, Uros Bizjak wrote:
> Besides GCC, clang can define various named address space via
> address_space attribute:
> 
> --cut here--
> #define __as(N) __attribute__((address_space(N)))
> 
> void *foo(void __as(1) *x) { return x; }         // error
> 
> void *bar(void __as(1) *x) { return (void *)x; } // fine
> --cut here--
> 
> When compiling this, the compiler returns:
> 
> clang-as.c:3:37: error: returning '__as(1) void *' from a function
> with result type 'void *' changes address space of pointer

Super cool. Looking forward to having it all wired up and the bugs we'll
find with it. 

> I think that the best approach is to target this patchset for linux
> 6.13 via random.git tree. I will prepare a v3 after 6.12rc1, so when
> committed to random.git, the patchset will be able to spend some time
> in linux-next. This way, there will be plenty of time for CI robots to
> do additional checks also for some less popular targets (although
> individual patches are dead simple, removing these kinds of "legacy"
> includes can be tricky), and I will also be able to collect Acked-by:s
> in the meantime.
> 
> While the patchset is an improvement by itself, its inclusion is not
> time sensitive. The follow up percpu named address checking
> functionality requires a very recent feature (__typeof_unqual__
> keyword), which is only supported in recent compilers (gcc-14 and
> clang-20). Besides compiler support, sparse doesn't know about
> __typeof_unqual__, resulting in broken type tracing and hundreds of
> sparse errors with C=1 due to unknown keyword.
> 
> So, I think we are not in a hurry and can take the slow and safe path.

Okay, sure, that sounds good to me. I'll keep my eyes open for v3
in a few weeks then.

Jason

