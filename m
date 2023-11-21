Return-Path: <linux-kselftest+bounces-381-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6769E7F3346
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 17:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AD6D1C21B77
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 16:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570BF59176;
	Tue, 21 Nov 2023 16:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1iqDLIU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F9558108;
	Tue, 21 Nov 2023 16:09:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B91C433C8;
	Tue, 21 Nov 2023 16:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700582985;
	bh=5M41NCGcjZMhgdurlBjtRlLdvlA9gQfTtgnr20SzQZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O1iqDLIUfkFchTr0uWwZMhQgAuctcM2Lx3snmajtHnpejlh8n+MTWJO7l3nV1CBa1
	 kAHoT3m9q+xRr659OjHWajWVNSlBi0D7Aw+vM7kO4fJqjjqvxeApGS+5nfGJEa78Jk
	 6Y07eattO7dTYl9+mTfkk0M2mD18uYjoBR7K/37EXMdznWu325kyXczTP3GxOGGoRU
	 Xjtnh3hx9nQM2LplH6L1EMqLam1VpAjVMm6H6tloJi/HViAQeJtNGA6mCZIgX9TSna
	 8gmK/ReArU1XZnSjlnmXs2uxwb8xHedROorBMvsdvX6GiHiGeR9Kn3Hg/tbZYz3OVH
	 x6NU13TxFQvNg==
Date: Tue, 21 Nov 2023 16:09:40 +0000
From: Mark Brown <broonie@kernel.org>
To: Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Cc: Christian Brauner <brauner@kernel.org>,
	"Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>, "H.J. Lu" <hjl.tools@gmail.com>,
	Florian Weimer <fweimer@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>,
	jannh@google.com, linux-kselftest@vger.kernel.org,
	linux-api@vger.kernel.org, David Hildenbrand <david@redhat.com>,
	nd@arm.com
Subject: Re: [PATCH RFT v3 0/5] fork: Support shadow stacks in clone3()
Message-ID: <ZVzWRIA9AfXHeWMW@finisterre.sirena.org.uk>
References: <20231120-clone3-shadow-stack-v3-0-a7b8ed3e2acc@kernel.org>
 <20231121-urlaub-motivieren-c9d7ee1a6058@brauner>
 <ZVyg0WgILK35xjBn@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Cu1hqtbNXe1joyHG"
Content-Disposition: inline
In-Reply-To: <ZVyg0WgILK35xjBn@arm.com>
X-Cookie: Slow day.  Practice crawling.


--Cu1hqtbNXe1joyHG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 21, 2023 at 12:21:37PM +0000, Szabolcs Nagy wrote:
> The 11/21/2023 11:17, Christian Brauner wrote:

> > I have a few questions that are probably me just not knowing much about
> > shadow stacks so hopefully I'm not asking you write a thesis by
> > accident:

One thing it feels like it's worth saying up front here is that shadow
stacks are userspace memory with special permissions and instructions
for access - they are mapped into the userspace address range and
userspace can directly interact with them in restricted ways.  For
example there's some thought to using shadow stacks in unwinders since
all the return addresses are stored in a single convenient block of
memory which it's much harder to corrupt.  Overflowing a shadow stack
results in userspace getting a memory access fault just as with other
memory access issues.

> > (2) With what other interfaces is implicit allocation and deallocation
> >     not consistent? I don't understand this argument. The kernel creates
> >     a shadow stack as a security measure to store return addresses. It
> >     seems to me exactly that the kernel should implicitly allocate and
> >     deallocate the shadow stack and not have userspace muck around with
> >     its size?

> the kernel is not supposed to impose stack size policy or a particular
> programming model that limits the stack management options nor prevent
> the handling of stack overflows.

The inconsistency here is with the management of the standard stack -
with the standard stack userspace passes an already allocated address
range to the kernel.  A constant tension during review of the shadow
stack interfaces has been that shadow stack memory is userspace memory
but the security constraints mean that we've come down on the side of
having a custom allocation syscall for it instead of using flags on
mmap() and friends like people often expect, and now having it allocated
as part of clone3().  The aim is to highlight that this difference is
deliberately chosen for specific reasons rather than just carelessness.

> > (3) Why is it safe for userspace to request the shadow stack size? What
> >     if they request a tiny shadow stack size? Should this interface
> >     require any privilege?

> user can allocate huge or tiny stacks already.

> and i think userspace can take control over shadow stack management:
> it can disable signals, start a clone child with stack_size == 1 page,
> map_shadow_stack and switch to it, enable signals. however this is
> complicated, leaks 1 page of kernel allocated shadow stack (+reserved
> guard page, i guess userspace could unmap, not sure if that works
> currently) and requires additional syscalls.

The other thing here is that if userspace gets this wrong it'll result
in the userspace process hitting the top of the stack and getting fatal
signals in a similar manner to what happens if it gets the size of
the standard stack wrong (the kernel allocation does mean that there
should always be guard pages and it's harder to overrun the stack and
corrupt adjacent memory).  There doesn't seem to be any meaningful risk
here over what userspace can already do to itself anyway as part of
thread allocation.

> > (4) Why isn't the @stack_size argument I added for clone3() enough?
> >     If it is specified can't the size of the shadow stack derived from it?

> shadow stack only contains return addresses so it is proportional
> to the number of stack frames, not the stack size and it must
> account for sigaltstack too, not just the thread stack.

> if you make minimal assumptions about stack usage and ignore the
> sigaltstack issue then the worst case shadow stack requirement
> is indeed proportional to the stack_size, but this upper bound
> can be pessimistic and userspace knows the tradeoffs better.

It's also worth pointing out here that the existing shadow stack support
for x86 and in review code for arm64 make exactly these assumptions and
guesses at a shadow stack size based on the stack_size for the thread.
There's just been a general lack of enthusiasm for the fact that due to
the need to store variables on the normal stack the resulting shadow
stack is very likely to be substantially overallocated but we can't
safely reduce the size without information from userspace.

> > And my current main objection is that shadow stacks were just released
> > to userspace. There can't be a massive amount of users yet - outside of
> > maybe early adopters.

> no upstream libc has code to enable shadow stacks at this point
> so there are exactly 0 users in the open. (this feature requires
> runtime support)

> the change is expected to allow wider deployability. (e.g. not
> just in glibc)

Right, and the lack of any userspace control of the shadow stack size
has been a review concern with the arm64 GCS series which I'm trying to
address here.  The main concern is that userspaces that start a lot of
threads are going to start using a lot more address space than they need
to when shadow stacks are enabled.  Given the fairly long deployment
pipeline from extending a syscall to end users who might be using the
feature in conjuction with imposing resource limits it does seem like a
reasonable problem to anticipate.

> > The fact that there are other architectures that bring in a similar
> > feature makes me even more hesitant. If they have all agreed _and_
> > implemented shadow stacks and have unified semantics then we can
> > consider exposing control knobs to userspace that aren't implicitly
> > architecture specific currently.

To be clear the reason I'm working on this is that I've implemented the
arm64 support, I don't even have any access to x86 systems that have the
feature (hence the RFT in the subject line) - Rick Edgecombe did the x86
work.  The arm64 code is still in review, the userspace interface is
very similar to that for x86 and there doesn't seem to be any
controversy there which makes me expect that a change is likely.  Unlike
x86 we only have a spec and virtual implementations at present, there's
no immintent hardware, so we're taking our time with making sure that
everything is working well.  Deepak Gupta (in CC) has been reviewing the
series from the point of view of RISC-V.  I think we're all fairly well
aligned on the requirements here.

--Cu1hqtbNXe1joyHG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVc1kMACgkQJNaLcl1U
h9CDlwf+IhkEGdyJ2fiqfKcNpafPMwN0aeTMjOPP/L7jiP8Td42ADOhD2xjnT+hO
Hf4eTNgjFZn8jmQkkctS/BiOWjx1ktNT1b8YW7/uOElZ8ecMmwGy9oTLihIuFTfk
y2jC8/Ih1LfS6Uj493lNI7ozpbPqSAtCppeVWDnoB+YaEw476ZsNl7xnEBcx0k0U
EXcsMSe9AD3vgV1zZ9oCnSdvG0+HdxwO6yzaKjdJOnd3MMtp7tSeuokr0OehZUDk
nd/mDzROewzF8DHGFPo0D8UlOhNE3JV2sZPm3AExh/fsrah3JFrj2DDQOQpuoekP
2nh2I0Rc8Jsn11q+EnefpA8nVFch3w==
=+tkg
-----END PGP SIGNATURE-----

--Cu1hqtbNXe1joyHG--

