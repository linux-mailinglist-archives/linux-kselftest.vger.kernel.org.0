Return-Path: <linux-kselftest+bounces-370-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B797F2A1C
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 11:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 964FB1C20A06
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 10:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABF23D394;
	Tue, 21 Nov 2023 10:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjToqBuy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6681E523;
	Tue, 21 Nov 2023 10:17:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26C7C433C8;
	Tue, 21 Nov 2023 10:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700561875;
	bh=qobUWG625nNMvTACmwygc8zMctgjS+7q0tONS6bD3mM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PjToqBuyTQmRxcOTpKMOibzwbIIU483uxDJ6znRdu6UBqMjietLC8muKhIlGB8xo8
	 S+p+JRjAld3Mi6g5nL8qf0l9t1iJxofoEKpqhqU6zgcVnlfk8zBA6M926p5lHgdmoX
	 YhhJNcpTMOHmiXy7XQ5xIRSf+9dbsbMkRtHzxzeVwAK97ZUNDG1CXT56lQg6/zR1J1
	 BuG9AQXCkt6IBqTHRe1AoX/cBHNUJZT7iZsdsLPypv4hbw+vLiwQkqEOE3jm/zWxi6
	 ebvlokFppiTSpgIQFU7lK7N940pGkNIvFjEzPmtNlTVDl7Zgk7HPnBwvy/8lOKPJvE
	 Rn0BA/kch9+fQ==
Date: Tue, 21 Nov 2023 11:17:45 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
	"H.J. Lu" <hjl.tools@gmail.com>,
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
	linux-api@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFT v3 0/5] fork: Support shadow stacks in clone3()
Message-ID: <20231121-urlaub-motivieren-c9d7ee1a6058@brauner>
References: <20231120-clone3-shadow-stack-v3-0-a7b8ed3e2acc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231120-clone3-shadow-stack-v3-0-a7b8ed3e2acc@kernel.org>

On Mon, Nov 20, 2023 at 11:54:28PM +0000, Mark Brown wrote:
> The kernel has recently added support for shadow stacks, currently
> x86 only using their CET feature but both arm64 and RISC-V have
> equivalent features (GCS and Zicfiss respectively), I am actively
> working on GCS[1].  With shadow stacks the hardware maintains an
> additional stack containing only the return addresses for branch
> instructions which is not generally writeable by userspace and ensures
> that any returns are to the recorded addresses.  This provides some
> protection against ROP attacks and making it easier to collect call
> stacks.  These shadow stacks are allocated in the address space of the
> userspace process.
> 
> Our API for shadow stacks does not currently offer userspace any
> flexiblity for managing the allocation of shadow stacks for newly
> created threads, instead the kernel allocates a new shadow stack with
> the same size as the normal stack whenever a thread is created with the
> feature enabled.  The stacks allocated in this way are freed by the
> kernel when the thread exits or shadow stacks are disabled for the
> thread.  This lack of flexibility and control isn't ideal, in the vast
> majority of cases the shadow stack will be over allocated and the
> implicit allocation and deallocation is not consistent with other
> interfaces.  As far as I can tell the interface is done in this manner
> mainly because the shadow stack patches were in development since before
> clone3() was implemented.
> 
> Since clone3() is readily extensible let's add support for specifying a
> shadow stack when creating a new thread or process in a similar manner

So while I made clone3() readily extensible I don't want it to ever
devolve into a fancier version of a prctl().

I would really like to see a strong reason for allowing userspace to
configure the shadow stack size at this point in time.

I have a few questions that are probably me just not knowing much about
shadow stacks so hopefully I'm not asking you write a thesis by
accident:

(1) What does it mean for a shadow stack to be over allocated and is
    over-allocation really that much of a problem out in the wild that
    we need to give I userspace a knob to control a kernel security
    feature?
(2) With what other interfaces is implicit allocation and deallocation
    not consistent? I don't understand this argument. The kernel creates
    a shadow stack as a security measure to store return addresses. It
    seems to me exactly that the kernel should implicitly allocate and
    deallocate the shadow stack and not have userspace muck around with
    its size?
(3) Why is it safe for userspace to request the shadow stack size? What
    if they request a tiny shadow stack size? Should this interface
    require any privilege?
(4) Why isn't the @stack_size argument I added for clone3() enough?
    If it is specified can't the size of the shadow stack derived from it?

And my current main objection is that shadow stacks were just released
to userspace. There can't be a massive amount of users yet - outside of
maybe early adopters.

The fact that there are other architectures that bring in a similar
feature makes me even more hesitant. If they have all agreed _and_
implemented shadow stacks and have unified semantics then we can
consider exposing control knobs to userspace that aren't implicitly
architecture specific currently.

So I don't have anything against the patches per obviously but with the
wider context.

Thanks!

