Return-Path: <linux-kselftest+bounces-15896-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 647D095A45C
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 20:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 964AA1C22472
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 18:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F6C1B2EEE;
	Wed, 21 Aug 2024 18:05:16 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45481B2ED6;
	Wed, 21 Aug 2024 18:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724263516; cv=none; b=JoaKLqgo8i1uY7zpY0qp43HOVPVFCLUE8Pcuvz1cEIcUE9CK0BygziLaDMypOzZr2qis88A+xPM8p6CYxAPtZGnLf4QUTW/GPv8DeiSbUO5SUlYc1x7WyN1zFtiS/bUWWX7TYPYyYdAd2KyjSVeOGG7usi/E8K+9rp6zgrTHAPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724263516; c=relaxed/simple;
	bh=BL3FxBjXqdUlgS2BCFaDe/fd09UFnxS+0qX9Ww02TCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPNVZht/WditcPuVNAUfaG6r5IjAL7LL4rUzfWtgnInvI0A1enDefbobF3BlZAf07jDvj5wZL6DCiM1SrN7b8U9WFbb5eYwc52w1nDh4IsKF1aFPxc8EXfX8zKJ5MxMx5NaiO4ZG/gftldTt1DgG9Ah9ZHQa/vIj0eE3AYF7tRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335FAC32781;
	Wed, 21 Aug 2024 18:05:11 +0000 (UTC)
Date: Wed, 21 Aug 2024 19:05:08 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>,
	"mgorman@suse.de" <mgorman@suse.de>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"fweimer@redhat.com" <fweimer@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"vschneid@redhat.com" <vschneid@redhat.com>,
	"kees@kernel.org" <kees@kernel.org>,
	"will@kernel.org" <will@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"jannh@google.com" <jannh@google.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"yury.khrustalev@arm.com" <yury.khrustalev@arm.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"wilco.dijkstra@arm.com" <wilco.dijkstra@arm.com>,
	"bsegall@google.com" <bsegall@google.com>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH RFT v9 4/8] fork: Add shadow stack support to clone3()
Message-ID: <ZsYsVJZ2iFVyqA3M@arm.com>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <158190d9-a4a6-4647-84e8-f4ae036d984b@sirena.org.uk>

On Wed, Aug 21, 2024 at 06:23:18PM +0100, Mark Brown wrote:
> On Wed, Aug 21, 2024 at 03:54:49PM +0000, Edgecombe, Rick P wrote:
> > On Wed, 2024-08-21 at 13:45 +0100, Mark Brown wrote:
> > > > Sorry for that. I looked through all the old threads expecting to find
> > > > discussion, but couldn't find an answer. Is clone3 support a dependency for
> > > > arm shadow stacks?
> 
> > > Catalin didn't want to merge the arm64 support without clone3(), and
> > > there's code dependencies as a result.  I could unpick it and reverse
> > > the ordering so long as the arm64 maintainers are OK with that since the
> > > overlap is in the implementation of copy_thread() and some of the
> > > dependency patches.
> 
> Actually in an off-list discussion today Catalin indicated that he's
> fine with relaxing that a little so I'm in the process of picking the
> dependency apart.

Just to confirm, I'd rather get the clone3() ABI choices properly
debated than rushing it. It seems that our libc support does not rely on
clone3() yet, so let's continue with the arm64 series independently of
this one (only clone() with default shadow stack allocation). We'll
follow up with the clone3() support that covers both architectures.

Thanks and sorry for the confusion. I did not realise the complications
of adding clone3() support.

-- 
Catalin

