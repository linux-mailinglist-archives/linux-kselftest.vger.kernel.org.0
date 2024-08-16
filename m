Return-Path: <linux-kselftest+bounces-15531-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5079954DEF
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 17:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6136F283BB5
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 15:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380181BD50E;
	Fri, 16 Aug 2024 15:38:55 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EB81DDF5;
	Fri, 16 Aug 2024 15:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723822735; cv=none; b=SSN2aMSOJN3Mx8wH07wFOf4Q8GnwX7KKYNxIX/M0XlFxjxYixbLy2QHnYnSJZP+N3BM/9ZYA7l2Csmqpb640XvbJndK48zKQfh9Sbj4k/Hk0IG7wn89/sQQskhackRyg3gjlA+H+eIk64FQo1fC5Q3oW+/jS//dm/LimzQOwGUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723822735; c=relaxed/simple;
	bh=jhH9HJuzS6uir4HieayuUjEk9MIauiiZ5eQdD5kG3XQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gf5RQlT18SmG/72UIAjSQ7bDPSpXV+sEjdoFjSOjOvV/6SU0RZxMFcI0U0P/SfOSamRlFunkZN0Ji1Ol8OYATxYBd4T9zJ1Bqm53p+u1cRuNTxPkAqFPSpq4BP7kpi3kBmNwut/OEd0k+CyHvXNmL7aA9w/c/aoOeXVo0h5jaJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16609C32782;
	Fri, 16 Aug 2024 15:38:49 +0000 (UTC)
Date: Fri, 16 Aug 2024 16:38:48 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>,
	"mgorman@suse.de" <mgorman@suse.de>,
	"Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
	"fweimer@redhat.com" <fweimer@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"vschneid@redhat.com" <vschneid@redhat.com>,
	"kees@kernel.org" <kees@kernel.org>,
	"will@kernel.org" <will@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"jannh@google.com" <jannh@google.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"bsegall@google.com" <bsegall@google.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"broonie@kernel.org" <broonie@kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH RFT v8 4/9] fork: Add shadow stack support to clone3()
Message-ID: <Zr9yiH6DP0IPac-H@arm.com>
References: <20240808-clone3-shadow-stack-v8-0-0acf37caf14c@kernel.org>
 <20240808-clone3-shadow-stack-v8-4-0acf37caf14c@kernel.org>
 <f3a2a564094d05beac2dc5ab657cbc009c465667.camel@intel.com>
 <Zr8RfoHZYRWem1K9@arm.com>
 <23a8838adda28b03b3db77e135934e2da0599d0f.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23a8838adda28b03b3db77e135934e2da0599d0f.camel@intel.com>

On Fri, Aug 16, 2024 at 02:52:28PM +0000, Edgecombe, Rick P wrote:
> On Fri, 2024-08-16 at 09:44 +0100, Catalin Marinas wrote:
> > > After a token is consumed normally, it doesn't set it to zero. Instead it
> > > sets it to a "previous-ssp token". I don't think we actually want to do that here
> > > though because it involves the old SSP, which doesn't really apply in this
> > > case. I don't see any problem with zero, but was there any special thinking behind
> > > it?
> > 
> > BTW, since it's the parent setting up the shadow stack in its own
> > address space before forking, I think at least the read can avoid
> > access_remote_vm() and we could do it earlier, even before the new
> > process is created.
> 
> Hmm. Makes sense. It's a bit racy since the parent could consume that token from
> another thread, but it would be a race in any case.

More on the race below. If we handle it properly, we don't need the
separate checks.

> > > > +       if (access_remote_vm(mm, addr, &val, sizeof(val),
> > > > +                            FOLL_FORCE | FOLL_WRITE) != sizeof(val))
> > > > +               goto out;
> > > 
> > > The GUPs still seem a bit unfortunate for a couple reasons:
> > >   - We could do a CMPXCHG version and are just not (I see ARM has identical
> > > code in gcs_consume_token()). It's not the only race like this though FWIW.
> > >   - I *think* this is the only unprivileged FOLL_FORCE that can write to the
> > > current process in the kernel. As is, it could be used on normal RO
> > > mappings, at
> > > least in a limited way. Maybe another point for the VMA check. We'd want to
> > > check that it is normal shadow stack?
> > >   - Lingering doubts about the wisdom of doing GUPs during task creation.
> > 
> > I don't like the access_remote_vm() either. In the common (practically
> > only) case with CLONE_VM, the mm is actually current->mm, so no need for
> > a GUP.
> 
> On the x86 side, we don't have a shadow stack access CMPXCHG. We will have to
> GUP and do a normal CMPXCHG off of the direct map to handle it fully properly in
> any case (CLONE_VM or not).

I guess we could do the same here and for the arm64 gcs_consume_token().
Basically get_user_page_vma_remote() gives us the page together with the
vma that you mentioned needs checking. We can then do a cmpxchg directly
on the page_address(). It's probably faster anyway than doing GUP twice.

-- 
Catalin

