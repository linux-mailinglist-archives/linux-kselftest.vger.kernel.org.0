Return-Path: <linux-kselftest+bounces-15519-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5371F954DA4
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 17:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5C01B215E5
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 15:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891771BCA1F;
	Fri, 16 Aug 2024 15:29:21 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6767A127E3A;
	Fri, 16 Aug 2024 15:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723822161; cv=none; b=mBSEEfF2xiyUTjq8mnzfCgPPcsBTwj+asIwp+HKSsT9gRUOLWYzSYZT95asyIQoa0o+H2AsivHwqyK7DihRI/bp6hUttD6CGDGwOgkNyCWL0csevfAVC6WkYKYyWLj72GiqaxqRstgNfhgkQL/EbTNfjA+e3/ju9frToUE/HRvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723822161; c=relaxed/simple;
	bh=WI2ju2roiuRPYcgtvyYBVO+X9EVBNXOTsTEF+JEQqXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QB20JM8C1EBDisnGxZhUNzqnktOxf0CIhStn9NybVx1uTdpiOKBmYlt7qPA5meBtegpsd+i5oH/5UL5y+I8mr/Op6TCzPgreb6PsjxVPuv6XMnsVN1hAMhFq0jn3SHrfMgwGhA+ZnGCfyRIPZQl5TmjhOHlRpYhcakvfC4O+CPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2B2C32782;
	Fri, 16 Aug 2024 15:29:16 +0000 (UTC)
Date: Fri, 16 Aug 2024 16:29:13 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
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
Message-ID: <Zr9wSa2Yyq-MCWVq@arm.com>
References: <20240808-clone3-shadow-stack-v8-0-0acf37caf14c@kernel.org>
 <20240808-clone3-shadow-stack-v8-4-0acf37caf14c@kernel.org>
 <f3a2a564094d05beac2dc5ab657cbc009c465667.camel@intel.com>
 <Zr8RfoHZYRWem1K9@arm.com>
 <c644d64b-f7d0-47de-b5ba-ae2ac1b46e1b@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c644d64b-f7d0-47de-b5ba-ae2ac1b46e1b@sirena.org.uk>

On Fri, Aug 16, 2024 at 11:51:57AM +0100, Mark Brown wrote:
> On Fri, Aug 16, 2024 at 09:44:46AM +0100, Catalin Marinas wrote:
> > We could, in theory, consume this token in the parent before the child
> > mm is created. The downside is that if a parent forks multiple
> > processes using the same shadow stack, it will have to set the token
> > each time. I'd be fine with this, that's really only for the mostly
> > theoretical case where one doesn't use CLONE_VM and still want a
> > separate stack and shadow stack.
> 
> I originally implemented things that way but people did complain about
> the !CLONE_VM case, which does TBH seem reasonable.  Note that the
> parent won't as standard be able to set the token again - since the
> shadow stack is not writable to userspace by default it'd instead need
> to allocate a whole new shadow stack for each child.

Ah, good point.

> I change back to parsing the token in the parent but I don't want to end
> up in a cycle of bouncing between the two implementations depending on
> who's reviewed the most recent version.

You and others spent a lot more time looking at shadow stacks than me.
I'm not necessarily asking to change stuff but rather understand the
choices made.

-- 
Catalin

