Return-Path: <linux-kselftest+bounces-17274-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 231E496DE7D
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 17:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A42E5B21894
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 15:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE2219D8A2;
	Thu,  5 Sep 2024 15:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZL7et96C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01905D529;
	Thu,  5 Sep 2024 15:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725550707; cv=none; b=cy7nRGaX8emWd9XJ+iBytQ4Nv+VLkjY/SG217PojCvCdXn9Y8sAZRhKG57YMQpIxl9IW5Ko1i9q+wfZB5KDAyTHIpXvezyqyjX8b9G07IT/gKgD5tSx9wKMLvHa/J7lKd/vKCw0wKcb0EbPjP7Z8i5NeRsLqC68GrbS1lg1Iz4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725550707; c=relaxed/simple;
	bh=WqFaPHVKKRJUrSjh96WSLvDVpyIouu48maZXtKVDdA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQxW//+TdknK4qkMH4FF6Z3NCnFrEwDXHYOHGZG2W5KMRoEEgDwLYXM9zqr2AMldYHGnFH/eJcx/DaV1priaNxFwBdsc5+I4y7EDBE1TmmeDW5l8Vu4fmipdZc4m8n4bgWJAR1nmlsJM1SWwYn8SkyJqxTAik3LOZ+EdsA6AETU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZL7et96C; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725550706; x=1757086706;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=WqFaPHVKKRJUrSjh96WSLvDVpyIouu48maZXtKVDdA8=;
  b=ZL7et96CyclWcaV/rUWyaKuP6rjiZ4h1X35yswQHZlRHP3wy4C5XCgQ2
   qagDmoKCyALxG/sh/8X3cutjc0UqYnNQylP+hm86fwZ//a9/Cxdte9XtV
   m9/ZyvDgkdzBUgv/r+tiDaOBTFfze86wzpzw1/vdURTo6NcStabz3zEZj
   ACktAIHaB/AXbcmW/4yZcKMHS1l0xHpA8udADXg0oZUWuXcywXJ1ptPK/
   KR0WTvr1d95s4r8EE/pJkL/Nfo/4cWEsZCnSbdkXrs6rJihbn1IKGvWk1
   oxHHuts0cTTM809srTnMVWszISKeuxWxFJENrpT4ZAJ5pFZyrS5mX3D8l
   A==;
X-CSE-ConnectionGUID: 5/rMy3f1RSaamTkTe02B7A==
X-CSE-MsgGUID: tjC8H3pbQW+aduLjmxWO7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="35634032"
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="35634032"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 08:38:24 -0700
X-CSE-ConnectionGUID: u6pWWqheTeempRaYMfBO/g==
X-CSE-MsgGUID: pKR7g3A+S6q/KP0BCfW6iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="65652927"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 08:38:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1smEWm-00000005Rhy-32CS;
	Thu, 05 Sep 2024 18:36:08 +0300
Date: Thu, 5 Sep 2024 18:36:08 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
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
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-fscrypt@vger.kernel.org, linux-scsi@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Subject: Re: [PATCH 00/18] random: Include <linux/percpu.h> and resolve
 circular include dependency
Message-ID: <ZtnP6CK-Zd8SJAgY@smile.fi.intel.com>
References: <20240905122020.872466-1-ubizjak@gmail.com>
 <Ztmm00eLBQGtiwRM@smile.fi.intel.com>
 <CAFULd4bzyNGcJqeg7w2ZQ0Xmw-HsBhczf8yPna7mSgG4NmdcWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFULd4bzyNGcJqeg7w2ZQ0Xmw-HsBhczf8yPna7mSgG4NmdcWw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Sep 05, 2024 at 03:03:24PM +0200, Uros Bizjak wrote:
> On Thu, Sep 5, 2024 at 2:41 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Thu, Sep 05, 2024 at 02:17:08PM +0200, Uros Bizjak wrote:
> > > There were several attempts to resolve circular include dependency
> > > after the addition of percpu.h: 1c9df907da83 ("random: fix circular
> > > include dependency on arm64 after addition of percpu.h"), c0842fbc1b18
> > > ("random32: move the pseudo-random 32-bit definitions to prandom.h") and
> > > finally d9f29deb7fe8 ("prandom: Remove unused include") that completely
> > > removes inclusion of <linux/percpu.h>.
> > >
> > > Due to legacy reasons, <linux/random.h> includes <linux/prandom.h>, but
> > > with the commit entry remark:
> > >
> > > --quote--
> > > A further cleanup step would be to remove this from <linux/random.h>
> > > entirely, and make people who use the prandom infrastructure include
> > > just the new header file.  That's a bit of a churn patch, but grepping
> > > for "prandom_" and "next_pseudo_random32" "struct rnd_state" should
> > > catch most users.
> > >
> > > But it turns out that that nice cleanup step is fairly painful, because
> > > a _lot_ of code currently seems to depend on the implicit include of
> > > <linux/random.h>, which can currently come in a lot of ways, including
> > > such fairly core headfers as <linux/net.h>.
> > >
> > > So the "nice cleanup" part may or may never happen.
> > > --/quote--
> > >
> > > __percpu tag is currently defined in include/linux/compiler_types.h,
> > > so there is no direct need for the inclusion of <linux/percpu.h>.
> > > However, in [1] we would like to repurpose __percpu tag as a named
> > > address space qualifier, where __percpu macro uses defines from
> > > <linux/percpu.h>.
> > >
> > > This patch series is the "nice cleanup" part, and allows us to finally
> > > include <linux/percpu.h> in prandom.h.
> > >
> > > The whole series was tested by compiling the kernel for x86_64 allconfig
> > > and some popular architectures, namely arm64 defconfig, powerpc defconfig
> > > and loongarch defconfig.
> >
> > Obvious question(s) is(are):
> > 1) have you seen the Ingo's gigantic patch series towards resolving issues with
> > the headers?
> > 2) if not, please look at the preliminary work and take something from there, I
> > believe there are many useful changes already waiting for a couple of years to
> > be applied.
> >
> > Because I haven't found any references nor mentions of that in the cover letter
> > here and explanation why it was not taking into consideration.
> 
> I am aware of the series, but the patch takes only a small bite of it
> and specifically resolves the inclusion of <linux/prandom.h> from
> linux/random.h. The series fixes the missing inclusion of
> <linux/prandom.h> in files that use pseudo-random function and it was
> not meant to be a general header cleanup. The end goal is to allow us
> to include <linux/percpu.h> in linux/prandom.h - which uses __percpu
> tag without the correct include.

Thank you for elaboration, it's all clear now.

> Thus, the patch series is only tangentially connected to Ingo's patch series.

-- 
With Best Regards,
Andy Shevchenko



