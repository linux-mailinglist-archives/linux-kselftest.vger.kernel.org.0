Return-Path: <linux-kselftest+bounces-976-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A518011B8
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 18:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D274C1C20942
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 17:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460344E616;
	Fri,  1 Dec 2023 17:30:31 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA7A4E1DB;
	Fri,  1 Dec 2023 17:30:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A19C433C8;
	Fri,  1 Dec 2023 17:30:25 +0000 (UTC)
Date: Fri, 1 Dec 2023 17:30:22 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
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
	Christian Brauner <brauner@kernel.org>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>,
	jannh@google.com, linux-kselftest@vger.kernel.org,
	linux-api@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFT v4 0/5] fork: Support shadow stacks in clone3()
Message-ID: <ZWoYLs2STGA1LZLU@arm.com>
References: <20231128-clone3-shadow-stack-v4-0-8b28ffe4f676@kernel.org>
 <ZWjb6r0RWPo199pC@arm.com>
 <fce4c169-5d19-40e8-bc32-0abec9bb008e@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fce4c169-5d19-40e8-bc32-0abec9bb008e@sirena.org.uk>

Thanks all for the clarification.

On Thu, Nov 30, 2023 at 09:51:04PM +0000, Mark Brown wrote:
> On Thu, Nov 30, 2023 at 07:00:58PM +0000, Catalin Marinas wrote:
> > My hope when looking at the arm64 patches was that we can completely
> > avoid the kernel allocation/deallocation of the shadow stack since it
> > doesn't need to do this for the normal stack either. Could someone
> > please summarise why we dropped the shadow stack pointer after v1? IIUC
> > there was a potential security argument but I don't think it was a very
> > strong one. Also what's the threat model for this feature? I thought
> > it's mainly mitigating stack corruption. If some rogue code can do
> > syscalls, we have bigger problems than clone3() taking a shadow stack
> > pointer.
> 
> As well as preventing/detecting corruption of the in memory stack shadow
> stacks are also ensuring that any return instructions are unwinding a
> prior call instruction, and that the returns are done in opposite order
> to the calls.  This forces usage of the stack - any value we attempt to
> RET to is going to be checked against the top of the shadow stack which
> makes chaining returns together as a substitute for branches harder.
> 
> The concern Rick raised was that allowing user to pick the exact shadow
> stack pointer would allow userspace to corrupt or reuse the stack of an
> existing thread by starting a new thread with the shadow stack pointing
> into the existing shadow stack of that thread.  While in isolation
> that's not too much more than what userspace could just do directly
> anyway it might compose with other issues to something more "interesting"
> (eg, I'd be a bit concerned about overlap with pkeys/POE though I've not
> thought through potential uses in detail).

Another concern I had was that map_shadow_stack() currently takes
a flags arg (though only one flag) while the clone/clone3() allocate the
shadow stack with an implicit configuration (other than size). Would
map_shadow_stack() ever get new flags that we may also need to set on
the default thread shadow stack (e.g. a new permission type)? At that
point it would be better if clone3() allowed a shadow stack pointer so
that any specific attributes would be limited to map_shadow_stack().

If that's only theoretical, I'm fine to go ahead with a size-only
argument for clone3(). We could also add the pointer now and allocate
the stack if NULL or reuse it if not, maybe with some prctl to allow
this. It might be overengineering and we'd never use such feature
though.

> > I'm not against clone3() getting a shadow_stack_size argument but asking
> > some more questions. If we won't pass a pointer as well, is there any
> > advantage in expanding this syscall vs a specific prctl() option? Do we
> > need a different size per thread or do all threads have the same shadow
> > stack size? A new RLIMIT doesn't seem to map well though, it is more
> > like an upper limit rather than a fixed/default size (glibc I think uses
> > it for thread stacks but bionic or musl don't AFAIK).
> 
> I don't know what the userspace patterns are likely to be here, it's
> possible a single value for each process might be fine but I couldn't
> say that confidently.  I agree that a RLIMIT does seem like a poor fit.

Szabolcs clarified that there are cases where we need the size per
thread.

> As well as the actual configuration of the size the other thing that we
> gain is that as well as relying on heuristics to determine if we need to
> allocate a new shadow stack for the new thread we allow userspace to
> explicitly request a new shadow stack.

But the reverse is not true - we can't use clone3() to create a thread
without a shadow stack AFAICT.

> > Another dumb question on arm64 - is GCSPR_EL0 writeable by the user? If
> > yes, can the libc wrapper for threads allocate a shadow stack via
> > map_shadow_stack() and set it up in the thread initialisation handler
> > before invoking the thread function?
> 
> No, GCSPR_EL0 can only be changed by EL0 through BL, RET and the
> new GCS instructions (push/pop and stack switch).  Push is optional -
> userspace has to explicitly request that it be enabled and this could be
> prevented through seccomp or some other LSM.  The stack switch
> instructions require a token at the destination address which must
> either be written by a higher EL or will be written in the process of
> switching away from a stack so you can switch back.  Unless I've missed
> one every mechanism for userspace to update GCSPR_EL0 will do a GCS
> memory access so providing guard pages have been allocated wrapping to a
> different stack will be prevented.
> 
> We would need a syscall to allow GCSPR_EL0 to be written.

Good point, I thought I must be missing something.

-- 
Catalin

