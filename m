Return-Path: <linux-kselftest+bounces-15486-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6299544B0
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 10:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EE121C20EA3
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 08:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D72B13A25F;
	Fri, 16 Aug 2024 08:44:54 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A63F1DFFC;
	Fri, 16 Aug 2024 08:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723797894; cv=none; b=VmRbHFi8F/7bRLfxdAOdiBpTXR8ErboTHCRaaf49NaWsDW8Bzyjzw+SA1G1IiDlmYc2rtg1SxECWSHSM6TNzp6bk16U3wROp6lznB07O3+Dlm2eW5WGoOts5aJQMLL5GW5Y2CQLm4l+UcgajtVgDal7rxO8w2hG8+L+o7Lv3ytA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723797894; c=relaxed/simple;
	bh=BRboGjlwfrQPVVn2+h18CtHj+ByyxIEMBAs2xzz/N3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XwnorFS4oJE/Svhxm7Qz2zrP0oqvIY0rr0ZDqDrf1/3WczHMX0XuXeUlMYDA+3tIoECiSGuk6B0RlPhSJyhTrJQl0+EN1ZDHfjTV8aDSf1dVSRe0I0n409kVAAi5XLTth/L9UpYOO55XPhyYPUhpdYNKu9CTfnEHHSGtwNcQ3A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C85C32782;
	Fri, 16 Aug 2024 08:44:48 +0000 (UTC)
Date: Fri, 16 Aug 2024 09:44:46 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"broonie@kernel.org" <broonie@kernel.org>,
	"Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>,
	"mgorman@suse.de" <mgorman@suse.de>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"fweimer@redhat.com" <fweimer@redhat.com>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"vschneid@redhat.com" <vschneid@redhat.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"bp@alien8.de" <bp@alien8.de>,
	"bsegall@google.com" <bsegall@google.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	"jannh@google.com" <jannh@google.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"kees@kernel.org" <kees@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH RFT v8 4/9] fork: Add shadow stack support to clone3()
Message-ID: <Zr8RfoHZYRWem1K9@arm.com>
References: <20240808-clone3-shadow-stack-v8-0-0acf37caf14c@kernel.org>
 <20240808-clone3-shadow-stack-v8-4-0acf37caf14c@kernel.org>
 <f3a2a564094d05beac2dc5ab657cbc009c465667.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f3a2a564094d05beac2dc5ab657cbc009c465667.camel@intel.com>

On Thu, Aug 15, 2024 at 12:18:23AM +0000, Edgecombe, Rick P wrote:
> On Thu, 2024-08-08 at 09:15 +0100, Mark Brown wrote:
> > +int arch_shstk_post_fork(struct task_struct *t, struct kernel_clone_args
> > *args)
[...]
> > +       /* This should really be an atomic cmpxchg.  It is not. */
> > +       if (access_remote_vm(mm, addr, &val, sizeof(val),
> > +                            FOLL_FORCE) != sizeof(val))
> > +               goto out;
> > +
> > +       if (val != expected)
> > +               goto out;
> > +       val = 0;
> 
> After a token is consumed normally, it doesn't set it to zero. Instead it sets
> it to a "previous-ssp token". I don't think we actually want to do that here
> though because it involves the old SSP, which doesn't really apply in this case.
> I don't see any problem with zero, but was there any special thinking behind it?

BTW, since it's the parent setting up the shadow stack in its own
address space before forking, I think at least the read can avoid
access_remote_vm() and we could do it earlier, even before the new
process is created.

> > +       if (access_remote_vm(mm, addr, &val, sizeof(val),
> > +                            FOLL_FORCE | FOLL_WRITE) != sizeof(val))
> > +               goto out;
> 
> The GUPs still seem a bit unfortunate for a couple reasons:
>  - We could do a CMPXCHG version and are just not (I see ARM has identical code
> in gcs_consume_token()). It's not the only race like this though FWIW.
>  - I *think* this is the only unprivileged FOLL_FORCE that can write to the
> current process in the kernel. As is, it could be used on normal RO mappings, at
> least in a limited way. Maybe another point for the VMA check. We'd want to
> check that it is normal shadow stack?
>  - Lingering doubts about the wisdom of doing GUPs during task creation.

I don't like the access_remote_vm() either. In the common (practically
only) case with CLONE_VM, the mm is actually current->mm, so no need for
a GUP.

We could, in theory, consume this token in the parent before the child
mm is created. The downside is that if a parent forks multiple
processes using the same shadow stack, it will have to set the token
each time. I'd be fine with this, that's really only for the mostly
theoretical case where one doesn't use CLONE_VM and still want a
separate stack and shadow stack.

> I don't think they are show stoppers, but the VMA check would be nice to have in
> the first upstream support.

Good point.

-- 
Catalin

