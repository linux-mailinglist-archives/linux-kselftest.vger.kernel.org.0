Return-Path: <linux-kselftest+bounces-19749-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FFF99F243
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 18:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9C041F233DC
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 16:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FF81DD0D8;
	Tue, 15 Oct 2024 16:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T7Ng6TJC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747901CB9FC;
	Tue, 15 Oct 2024 16:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729008331; cv=none; b=EaubadgHlLwaY9efPsbPM/USQ2ZJzIPgcrODjNJbwU1dyWbiEUkJ1g4owzbDCbmCUF/UQ94Xe2fAOKQIQWqYSIdc3U2a3wQbSMPzqhaana8V3jqTCSGp5mjxJToGOLO3pR8lHhhRBTzxlRIgTuAcN/tzDaeyv+g4HpptHIimUtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729008331; c=relaxed/simple;
	bh=YQ53XndspLGpbhTGCSSul0R4z2fIICDQYPz9a8rUG2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMu2pNAulRMcW/pcZBHX15RnoV236oRLJzJf5oMYiZpwzuPbBa1vh1JodNh1kgStBXZXHQcDLQnayLtoJR8iahvkfaYIEZ2ZHWq7mlrDGfsk+TneXWGgHCO+vYgCxIsTHe5Msxbya5S4PniwtheQdv/kigurM3/GEhh5QwaghOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T7Ng6TJC; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 15 Oct 2024 09:05:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729008327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l6VKTTEot+K7niCJS6lBnaCocYaIc0vO9Sx2qrc2It0=;
	b=T7Ng6TJCI19EPEOMr+JCbwLaGP6CGCut2IkXEyXDqtYZ0tGbxnoY7SetkIYlsQ7wEly95u
	RO/WKJKryq5K1tEDqPmR6031gcDsDG5R8DbAXNQUCtI/JIcDqKxdfTBah9MtBhoYxyNFGy
	2fOs8s6cC3zmRL0Vc8+HrHvHMGJGaR4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
	Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
	Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Francesco Lavra <francescolavra.fl@gmail.com>,
	Miguel Luis <miguel.luis@oracle.com>
Subject: Re: [PATCH v5 4/5] KVM: selftests: Add test for PSCI SYSTEM_OFF2
Message-ID: <Zw6Svts5hqpIoKwN@linux.dev>
References: <20240926184546.833516-1-dwmw2@infradead.org>
 <20240926184546.833516-5-dwmw2@infradead.org>
 <ZvwWM7rQd075o6nb@linux.dev>
 <408b137dbf60ff4d189cbd98b7cf8cd833579f61.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <408b137dbf60ff4d189cbd98b7cf8cd833579f61.camel@infradead.org>
X-Migadu-Flow: FLOW_OUT

On Sat, Oct 12, 2024 at 10:28:10AM +0100, David Woodhouse wrote:
> On Tue, 2024-10-01 at 08:33 -0700, Oliver Upton wrote:
> > On Thu, Sep 26, 2024 at 07:37:59PM +0100, David Woodhouse wrote:
> > > +       vm = setup_vm(guest_test_system_off2, &source, &target);
> > > +       vcpu_get_reg(target, KVM_REG_ARM_PSCI_VERSION, &psci_version);
> > > +       TEST_ASSERT(psci_version >= PSCI_VERSION(0, 2),
> > > +                   "Unexpected PSCI version %lu.%lu",
> > > +                   PSCI_VERSION_MAJOR(psci_version),
> > > +                   PSCI_VERSION_MINOR(psci_version));
> > > +
> > > +       if (psci_version < PSCI_VERSION(1,3))
> > > +               goto skip;
> > 
> > I'm not following this. Is there a particular reason why we'd want to
> > skip for v1.2 and fail the test for anything less than that?
> 
> These tests unconditionally set KVM_ARM_VCPU_PSCI_0_2 in setup_vm().
> Which is probably OK assuming support for that that predates
> KVM_CAP_ARM_SYSTEM_SUSPEND (which is already a TEST_REQUIRE() right at
> the start).
> 
> So the world is very broken if KVM actually starts a VM but the version
> isn't at least 0.2, and it seemed like it warranted an actual failure.

If we're looking at this from a testing lens then KVM coming up with any
PSCI version other than KVM_ARM_PSCI_LATEST (i.e. v1.3) is a bug. So
maybe we can tighten that assertion because...

> > Just do TEST_REQUIRE(psci_version >= PSCI_VERSION(1, 3)), it makes the
> > requirements obvious in the case someone runs new selftests on an old
> > kernel.
> 
> I don't think we want to put that in main() and skip the other checks
> that would run on earlier kernels.

Running KVM selftests on older kernels in a meaningful way isn't
something we support. At all. An example of this is commit
8a53e1302133 ("KVM: selftests: Require KVM_CAP_USER_MEMORY2 for
tests that create memslots"), which skips ~everything for kernels older
than 6.8.

> (Even if we had easy access to
> psci_version without actually running a test and starting a VM).
> 
> I could put it into host_test_system_off2() which runs last (and
> comment the invocations in main() to say that they're in increasing
> order of PSCI version) to accommodate such). But then it seems that I'd
> be the target of this comment in ksft_exit_skip()...
> 
>         /*
>          * FIXME: several tests misuse ksft_exit_skip so produce
>          * something sensible if some tests have already been run
>          * or a plan has been printed.  Those tests should use
>          * ksft_test_result_skip or ksft_exit_fail_msg instead.
>          */
> 
> I suspect the real answer here is that the individual tests here be
> calling ksft_test_result_pass(), and the system_off2 one should call
> ksft_test_result_skip() if it skips?

modulo a few one-offs, KVM selftests doesn't use the kselftest harness
so it isn't subject to this comment. Since there's no test plan, we can
skip at any time.

> I'll add an explicit comment about the 0.2 check though, saying that it
> should never happen so we might as well have the ASSERT for it.

After looking at this again, I think we should do one of the following:

 - TEST_REQUIRE() that the PSCI version is at least v1.3, making the
   dependency clear on older kernels.

 - TEST_REQUIRE() for v1.3, which would provide better test coverage on
   upstream.

-- 
Thanks,
Oliver

