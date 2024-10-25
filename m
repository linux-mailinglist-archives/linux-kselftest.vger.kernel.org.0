Return-Path: <linux-kselftest+bounces-20705-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5333E9B0FF9
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 22:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09B0B1F22291
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 20:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E32821621F;
	Fri, 25 Oct 2024 20:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wiBV5pfA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAA52161F8;
	Fri, 25 Oct 2024 20:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729888837; cv=none; b=XWibrtZhjkpvSfBnwpVW2WUW6OXpE1SU/h/6gicj+1VN1qyGelms6FkHxN5aXaRZ0SD3OS3xAi8acWe2Dt6UKOEkZDAgZ+cOS9qaP02o7q+z03ymrejflN3C1AVmRCAJCMjGTWeEox9JlsNh5ozuCXaIYLFVTq8WCzBZucBmwY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729888837; c=relaxed/simple;
	bh=1VR9nQjGldSxwX5w5pEmypJuoDm8azOUI2JHhYVwkjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPWOZqh9tgGl7VutoMuPg1dvddpl/novXuX+QokO79AzVcghyawWZt2ckhBrSvl3wsOgkz+sVt3WmOEjItCJBBs3DJRBI1U3auyrhCtegTuEVFZpcBFPbY4aJhz0PQVlRBEfMawmubnNAa4m0qisPEo8yyXq1Nm1ePnh3wLa5As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wiBV5pfA; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 25 Oct 2024 13:40:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729888833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YMAXXsBpu7Ehcn655+wzQ1uMVEuNQVBFhx8QRZMZ0rg=;
	b=wiBV5pfAS60vsXVuI1GT02TDemB6eoQa7vMvOYPdvau9og9kfHNCrIwzOsxNAEvNzLpZH5
	nEbImKrpEPXD3n9ZjlOveq+RV/QdwpoLnPdZkIzeOVTkeyM+wnWeOnrb2/cM7PjeccRfV0
	hCmdOXTju1vks2ugKnuwkE14UmBoEuk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Miguel Luis <miguel.luis@oracle.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
	Shuah Khan <shuah@kernel.org>, David Woodhouse <dwmw@amazon.co.uk>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	Francesco Lavra <francescolavra.fl@gmail.com>
Subject: Re: [PATCH v6 6/6] arm64: Use SYSTEM_OFF2 PSCI call to power off for
 hibernate
Message-ID: <ZxwCOHd-DbUT8dsT@linux.dev>
References: <20241019172459.2241939-1-dwmw2@infradead.org>
 <20241019172459.2241939-7-dwmw2@infradead.org>
 <23C91005-7304-4312-A5E0-F5E6C05B3209@oracle.com>
 <ECD0CA58-2C3B-48F3-AF12-95E37CB0FC48@infradead.org>
 <ZxprcWDe2AXuLhD_@linux.dev>
 <691447A1-8F3F-4890-B00F-8068A14CA126@infradead.org>
 <ZxqmsiXV6ZYTANKY@linux.dev>
 <627769A8-AF84-47A1-B4F9-5F44C75A8058@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <627769A8-AF84-47A1-B4F9-5F44C75A8058@infradead.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Oct 25, 2024 at 08:13:03AM +0200, David Woodhouse wrote:
> On 24 October 2024 21:57:38 CEST, Oliver Upton <oliver.upton@linux.dev> wrote:
> >On Thu, Oct 24, 2024 at 05:56:09PM +0200, David Woodhouse wrote:
> >> On 24 October 2024 17:44:49 CEST, Oliver Upton <oliver.upton@linux.dev> wrote:
> >> >IIUC, you're really wanting to 0x0 because there are hypervisors out
> >> >there that violate the final spec and *only* accept this value.
> >> >
> >> >That's perfectly fine, but it'd help avoid confusion if the supporting
> >> >comment was a bit more direct:
> >> >
> >> >	/*
> >> >	 * If no hibernate type is specified SYSTEM_OFF2 defaults to
> >> >	 * selecting HIBERNATE_OFF.
> >> >	 *
> >> >	 * There are hypervisors in the wild that violate the spec and
> >> >	 * reject calls that explicitly provide a hibernate type. For
> >> >	 * compatibility with these nonstandard implementations, pass 0
> >> >	 * as the type.
> >> >	 */
> >> >	 if (system_entering_hibernation())
> >> >		invoke_psci_fn(PSCI_FN_NATIVE(1_3, SYSTEM_OFF2), 0 , 0, 0);
> >> 
> >> By the time this makes it into released versions of the guest Linux kernel, that comment won't be true any more.
> >
> >Then does it even matter? What is the problem you're trying to solve
> >with using a particular value for the hibernate type?
> >
> >Either the goal of this is to make the PSCI client code compatible with
> >your hypervisor today (and any other implementation based on 'F ALP1') or
> >we don't care and go with whatever value we want.
> >
> >Even if the comment eventually becomes stale, there is a ton of value in
> >documenting the exact implementation decision being made.
> >
> 
> Eventually it won't matter and we can go with whatever value we want. But yes, the goal is to be compatible with the hypervisor *today* until it catches up the changes to the final versions of the spec. I didn't spend much time overthinking the comment. What was it....
> 
> 	/*
> 	 * Zero is an acceptable alternative to PSCI_1_3_OFF_TYPE_HIBERNATE_OFF
> 	 * and is supported by hypervisors implementing an earlier version
> 	 * of the pSCI v1.3 spec.
> 	 */
> 
> That seems to cover it just fine, I think.

No. You're leaving the work for the reader to:

 (1) Figure out what you're talking about
 (2) Go dig up an "earlier version" of the spec
 (3) Realise that it means certain hypervisors only take 0x0 as an
     argument

If you speak *directly* about the problem you're trying to address then
reviewers are less likely to get hung up on what you're trying to do.

I'm genuinely at a loss for why you would want to present this as an
"acceptable alterantive" rather than a functional requirement for this
driver to run on your hypervisor.

-- 
Thanks,
Oliver

