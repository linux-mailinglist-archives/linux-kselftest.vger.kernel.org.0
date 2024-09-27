Return-Path: <linux-kselftest+bounces-18456-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7D79880DF
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 10:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C949B2596B
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 08:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DA919AD8B;
	Fri, 27 Sep 2024 08:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oiKgNKyA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB40E18A6D4;
	Fri, 27 Sep 2024 08:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727427064; cv=none; b=kcpwpd5LxKIpE3fMKpmlu27Nrr0Y7ET5u8uhHculrBHWDgixCMSxXHPEgg/9M2mYZmQeFnuFEgpzA0UdPfrwJ0cklkQjU7SvmOW5l/SVP9itx5ytblxSA0i+3ddi4+irymx0/vmXFP8s82b6lPBovPoxL9c4LRfX0+DccktQvUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727427064; c=relaxed/simple;
	bh=ZS7qEvVw496gTTHBBfaO9Q0B9LG9f4l3Ug+UJrrcxIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ihdc7QQH1y62MMYqO8o7Ul2JpLb9HkOxvght8zIypMsaRvWofNDW7mU49xzeUh04MWp6EmdVGkgt6FCA7tkgUCaeS88D+vkyde0+WorZeu0hsz3YbAMy4x89NoJtMn5Efg6e9Zb4xFe6w3zZFGciGegzshVs9kw7KpUmPJnSB7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oiKgNKyA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133CEC4CEC4;
	Fri, 27 Sep 2024 08:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727427064;
	bh=ZS7qEvVw496gTTHBBfaO9Q0B9LG9f4l3Ug+UJrrcxIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oiKgNKyAuozxkJ4aw99WvTjdIEU32l/G//lPxrBlhWPnJkcAPzg7F8xkYQR+McS0z
	 uZSS/ZBc2WTrwhEBLeRwiGOmX/hI4B4ssGnvIc7u8AjdmVwT+uuHo62DN7ZsN056W7
	 VyrmCHRGWDm3vEirAQpgNANgNNmDo/sHFm1WoygmaZRFccWqww4YVsbiiwmiLNdm1V
	 z//TsU7yIkKaAniDTr8UHaS9544Ws4Gm8k2RNvf3UKWNvKRLbuuUgFC72rdQKX8Pf+
	 aFpgeF7HWSPYrH9gHh+4bbfvjdCZsRlpZhJzAyO2Ey9Y/znY6ZvH8NSLChgMRfZot0
	 BYl7NmJea25YA==
Date: Fri, 27 Sep 2024 10:50:55 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, 
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "shuah@kernel.org" <shuah@kernel.org>, 
	"Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"debug@rivosinc.com" <debug@rivosinc.com>, "mgorman@suse.de" <mgorman@suse.de>, 
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "fweimer@redhat.com" <fweimer@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, 
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "hjl.tools@gmail.com" <hjl.tools@gmail.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, 
	"vschneid@redhat.com" <vschneid@redhat.com>, "kees@kernel.org" <kees@kernel.org>, 
	"will@kernel.org" <will@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, 
	"jannh@google.com" <jannh@google.com>, "peterz@infradead.org" <peterz@infradead.org>, 
	"yury.khrustalev@arm.com" <yury.khrustalev@arm.com>, "bp@alien8.de" <bp@alien8.de>, 
	"wilco.dijkstra@arm.com" <wilco.dijkstra@arm.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, 
	"bsegall@google.com" <bsegall@google.com>, "juri.lelli@redhat.com" <juri.lelli@redhat.com>, 
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH RFT v9 4/8] fork: Add shadow stack support to clone3()
Message-ID: <20240927-springen-fortpflanzen-34a303373088@brauner>
References: <20240819-clone3-shadow-stack-v9-0-962d74f99464@kernel.org>
 <20240819-clone3-shadow-stack-v9-4-962d74f99464@kernel.org>
 <dc8328dbaa01ca7443eeb75024752c673904e3a4.camel@intel.com>
 <cc2e7d86-c890-4cb1-8cad-1cfaa9f53dc8@sirena.org.uk>
 <82be9ec6e43a018add8d9bbc6ba67feee676f32e.camel@intel.com>
 <5643761f-cc38-4e41-9ddd-f0a1934f8724@sirena.org.uk>
 <9f022aa4cd3e2dc82d0c963e9d2bf5c7ddd5b92a.camel@intel.com>
 <77bc051d-b2c9-4e3a-b956-be8879048e20@sirena.org.uk>
 <5464b915b52bf3b91ec70201736479a5347838af.camel@intel.com>
 <158190d9-a4a6-4647-84e8-f4ae036d984b@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <158190d9-a4a6-4647-84e8-f4ae036d984b@sirena.org.uk>

On Wed, Aug 21, 2024 at 06:23:18PM GMT, Mark Brown wrote:
> On Wed, Aug 21, 2024 at 03:54:49PM +0000, Edgecombe, Rick P wrote:
> > On Wed, 2024-08-21 at 13:45 +0100, Mark Brown wrote:
> 
> > > It's entirely possible it just leaked.  My own attempts to dig through
> > > the archives haven't turned up anything on the subjecti either, it seems
> > > to have been there from the get go and just gone in without comment.
> > > Equally it could just be that people felt that this was a more tasteful
> > > way of specifying stacks, or that some future use was envisioned.
> 
> > Ok, well I'm suspicious, but won't object over it. The rest seems settled from
> > my side. I may try to attract some other x86 attention to that CMPXCHG helper,
> > but otherwise.
> 
> OK, I'll post what I've got (with the current ABI) today, incorporating
> your x86 fixes and the tighter validation and we can see what people
> think.  Perhaps Christian remembers what's going on there?

The legacy clone system call had required userspace to know in which
direction the stack was growing and then pass down the stack pointer
appropriately (e.g., parisc grows upwards).

And in fact, the old clone() system call did take an additional
stack_size argument on specific architectures. For example, on
microblaze.

Also, when clone3() was done we still had ia64 in the tree which had a
separate clone2() system call that also required a stack_size argument.

So userspace ended up with code like this or worse:

     #define __STACK_SIZE (8 * 1024 * 1024)
     pid_t sys_clone(int (*fn)(void *), void *arg, int flags, int *pidfd)
     {
             pid_t ret;
             void *stack;

             stack = malloc(__STACK_SIZE);
             if (!stack)
                     return -ENOMEM;

     #ifdef __ia64__
             ret = __clone2(fn, stack, __STACK_SIZE, flags | SIGCHLD, arg, pidfd);
     #elif defined(__parisc__) /* stack grows up */
             ret = clone(fn, stack, flags | SIGCHLD, arg, pidfd);
     #else
             ret = clone(fn, stack + __STACK_SIZE, flags | SIGCHLD, arg, pidfd);
     #endif
             return ret;
     }

So we talked to the glibc folks which preferred the kernel to do all
this nonsense for them as it has that knowledge.

My preference is to keep the api consistent and require a stack_size for
shadow stacks as well.

