Return-Path: <linux-kselftest+bounces-18756-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E5898C147
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 17:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D64E21C233BB
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 15:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3191C9B76;
	Tue,  1 Oct 2024 15:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8KtUs35"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D106CC2E3;
	Tue,  1 Oct 2024 15:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727795567; cv=none; b=rCr9K9u8bKnwxSuEtOAXoZjRTlpgKgdxwZgBqjmAwt7EwzhYr9svxIHOHdaNUQFBaVL/TEp9aSOA3r74Rsdfc8HoHLkM26T73Wd0VCRpM2JYi2uYBJU6CQIyQ3IxN2+jdsaTrn1msJoVaegYKclPefYhpKbFUETyEDkJttIk+fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727795567; c=relaxed/simple;
	bh=3M5R3aHg3xERtwZKfjTx22n2xMrDolENmdNB/EM3IQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYcA13o6rBbohpD/h4ZNYyir1PZoNh7Vig4vzc+EIUVr1sYKho3+SqZN0n7XHpLdw9I9MjCYxWzPwBL94PfE6ronpaJfGIAjg9F71ns5ViDot09CEXErcGT1Lrv3ZbyD6SrJsysKHaIfGZgCV48emjWXU84YzH2oxFtnFZd9R7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8KtUs35; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B0FC4CEC6;
	Tue,  1 Oct 2024 15:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727795567;
	bh=3M5R3aHg3xERtwZKfjTx22n2xMrDolENmdNB/EM3IQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k8KtUs35gDoRTP23Rh4QX6UerYWHCzT0X91Iy6A2k1VzCalnEksE2aKpy0rNPwQyL
	 t2JDs4Por0gXn/vSdhhUPSqvTik7P6IZyMDAhDyQZES0vbiZNYLPc8P125f2r0S5ij
	 5EcQoaqnHP1MdjA9SrSnFEHMN8yP1SUWqLPLP9uGpXzQUD+imYTPD6r+pCFA+SHlsE
	 n8y0Kt2/Q6+xMCtOzY9vkLdcKODPVS7yzTF9sRa6sFHWuTJvQogj/j8a/2ETyLvaWm
	 xdKwSN6QxHwodVuZ7F4HGTptD3wKXGGUZdyrlUWNWLAuDzm9Yk7PQkefIGjqQsaPZv
	 Eltp9y8MM4iow==
Date: Tue, 1 Oct 2024 17:12:38 +0200
From: Christian Brauner <brauner@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, 
	Florian Weimer <fweimer@redhat.com>
Cc: "broonie@kernel.org" <broonie@kernel.org>, 
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, 
	"debug@rivosinc.com" <debug@rivosinc.com>, "mgorman@suse.de" <mgorman@suse.de>, 
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, 
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "hjl.tools@gmail.com" <hjl.tools@gmail.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "fweimer@redhat.com" <fweimer@redhat.com>, 
	"vschneid@redhat.com" <vschneid@redhat.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, 
	"kees@kernel.org" <kees@kernel.org>, "will@kernel.org" <will@kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "jannh@google.com" <jannh@google.com>, 
	"peterz@infradead.org" <peterz@infradead.org>, "yury.khrustalev@arm.com" <yury.khrustalev@arm.com>, 
	"bp@alien8.de" <bp@alien8.de>, "wilco.dijkstra@arm.com" <wilco.dijkstra@arm.com>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "bsegall@google.com" <bsegall@google.com>, 
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH RFT v9 4/8] fork: Add shadow stack support to clone3()
Message-ID: <20241001-atheismus-stetig-4f6f3001715c@brauner>
References: <dc8328dbaa01ca7443eeb75024752c673904e3a4.camel@intel.com>
 <cc2e7d86-c890-4cb1-8cad-1cfaa9f53dc8@sirena.org.uk>
 <82be9ec6e43a018add8d9bbc6ba67feee676f32e.camel@intel.com>
 <5643761f-cc38-4e41-9ddd-f0a1934f8724@sirena.org.uk>
 <9f022aa4cd3e2dc82d0c963e9d2bf5c7ddd5b92a.camel@intel.com>
 <77bc051d-b2c9-4e3a-b956-be8879048e20@sirena.org.uk>
 <5464b915b52bf3b91ec70201736479a5347838af.camel@intel.com>
 <158190d9-a4a6-4647-84e8-f4ae036d984b@sirena.org.uk>
 <20240927-springen-fortpflanzen-34a303373088@brauner>
 <727524e9109022632250ab0485f5ecc1c1900092.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <727524e9109022632250ab0485f5ecc1c1900092.camel@intel.com>

On Fri, Sep 27, 2024 at 03:21:59PM GMT, Edgecombe, Rick P wrote:
> On Fri, 2024-09-27 at 10:50 +0200, Christian Brauner wrote:
> > The legacy clone system call had required userspace to know in which
> > direction the stack was growing and then pass down the stack pointer
> > appropriately (e.g., parisc grows upwards).
> > 
> > And in fact, the old clone() system call did take an additional
> > stack_size argument on specific architectures. For example, on
> > microblaze.
> > 
> > Also, when clone3() was done we still had ia64 in the tree which had a
> > separate clone2() system call that also required a stack_size argument.
> > 
> > So userspace ended up with code like this or worse:
> > 
> >      #define __STACK_SIZE (8 * 1024 * 1024)
> >      pid_t sys_clone(int (*fn)(void *), void *arg, int flags, int *pidfd)
> >      {
> >              pid_t ret;
> >              void *stack;
> > 
> >              stack = malloc(__STACK_SIZE);
> >              if (!stack)
> >                      return -ENOMEM;
> > 
> >      #ifdef __ia64__
> >              ret = __clone2(fn, stack, __STACK_SIZE, flags | SIGCHLD, arg, pidfd);
> >      #elif defined(__parisc__) /* stack grows up */
> >              ret = clone(fn, stack, flags | SIGCHLD, arg, pidfd);
> >      #else
> >              ret = clone(fn, stack + __STACK_SIZE, flags | SIGCHLD, arg, pidfd);
> >      #endif
> >              return ret;
> >      }
> > 
> > So we talked to the glibc folks which preferred the kernel to do all
> > this nonsense for them as it has that knowledge.
> 
> Thanks for the info!
> 
> > 
> > My preference is to keep the api consistent and require a stack_size for
> > shadow stacks as well.
> 
> Did you catch that a token can be at a different offsets location on the stack
> depending on args passed to map_shadow_stack? So userspace will need something
> like the code above, but that adjusts the 'shadow_stack_size' such that the
> kernel looks for the token in the right place. It will be even weirder if
> someone uses clone3 to switch to a stack that has already been used, and pivoted
> off of, such that a token was left in the middle of the stack. In that case
> userspace would have to come up with args disconnected from the actual size of
> the shadow stack such that the kernel would be cajoled into looking for the
> token in the right place.
> 
> A shadow stack size is more symmetric on the surface, but I'm not sure it will
> be easier for userspace to handle. So I think we should just have a pointer to
> the token. But it will be a usable implementation either way.

Maybe it's best to let glibc folks decide what is better/more ergonomic for them.

