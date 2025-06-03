Return-Path: <linux-kselftest+bounces-34265-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C3CACCFF8
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 00:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCFF41894A84
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 22:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43596253954;
	Tue,  3 Jun 2025 22:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lzCIQEGZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653B3253347;
	Tue,  3 Jun 2025 22:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748990669; cv=none; b=aVh6co6uFlXhuVj5OOAnV2oJDFjLJlj7PCJcnSMrRL1+d7VAJuvzpCjhngF6hecaTu8l/vi5ojSur/v1KWtekoT/VB5xvwdYcvHTnj56EVGisN2YL6wCBNc89ly5K29U1drPW39Gc+DQZ+/nHj85xjerH/hatUmuccp/sIVELBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748990669; c=relaxed/simple;
	bh=LLoqeM/UCB0mh20l/3/Xv9BmLg+WjY+M+SHRDQyeuwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pi7WqimRRSOyYt2OfDt2wmOBJdrbTR9l3bUFPcC2NBbKLfOSmb02tzDRqzm0n+9TLDl+kLAwYkIiLCx1wsIrscSagRyUAAyf835FuL9ZukRdVCO05mbiB7BQJwsDZm2hcXJwBVMXvCwHwiVWg8j//9Ahf7iq2FpNlppcMzdsml0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lzCIQEGZ; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 3 Jun 2025 15:43:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748990654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GoKlMc1lHrduXpDbBbVFy4M8aj5m5zbNDdssxMr5tdc=;
	b=lzCIQEGZ9FI8wt89dqHEjgAakygFlEyD4l9ip53qVy9LfjTGPS95wVhPcy/2qmUyOYVAjE
	JRaFapvUKpqg/O3lcUMMPEcYcp7ibaVQc7D6mRAMyy7cTKnSFcjae5MS7anwW9DSr5vcUV
	rFDNBe0JSQRHTY/ygvKnzMkxuvVGfU8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Colton Lewis <coltonlewis@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Mark Rutland <mark.rutland@arm.com>, Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 00/17] ARM64 PMU Partitioning
Message-ID: <aD96rn78BSUDbEu1@linux.dev>
References: <20250602192702.2125115-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602192702.2125115-1-coltonlewis@google.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 02, 2025 at 07:26:45PM +0000, Colton Lewis wrote:
> Caveats:
> 
> Because the most consistent and performant thing to do was untrap
> PMCR_EL0, the number of counters visible to the guest via PMCR_EL0.N
> is always equal to the value KVM sets for MDCR_EL2.HPMN. Previously
> allowed writes to PMCR_EL0.N via {GET,SET}_ONE_REG no longer affect
> the guest.
> 
> These improvements come at a cost to 7-35 new registers that must be
> swapped at every vcpu_load and vcpu_put if the feature is enabled. I
> have been informed KVM would like to avoid paying this cost when
> possible.
> 
> One solution is to make the trapping changes and context swapping lazy
> such that the trapping changes and context swapping only take place
> after the guest has actually accessed the PMU so guests that never
> access the PMU never pay the cost.

You should try and model this similar to how we manage the debug
breakpoints/watchpoints. In that case the debug register context is
loaded if either:

 (1) Self-hosted debug is actively in use by the guest, or

 (2) The guest has accessed a debug register since the last vcpu_load()

> This is not done here because it is not crucial to the primary
> functionality and I thought review would be more productive as soon as
> I had something complete enough for reviewers to easily play with.
> 
> However, this or any better ideas are on the table for inclusion in
> future re-rolls.

One of the other things that I'd like to see is if we can pare down the
amount of CPU feature dependencies for a partitioned PMU. Annoyingly,
there aren't a lot of machines out there with FEAT_FGT yet, and you
should be able to make all of this work in VHE + FEAT_PMUv3p1.

That "just" comes at the cost of extra traps (leaving TPM and
potentially TPMCR set). You can mitigate the cost of this by emulating
accesses in the fast path that don't need to go out to a kernel context
to be serviced. Same goes for requiring FEAT_HPMN0 to expose 0 event
counters, we can fall back to TPM traps if needed.

Taking perf out of the picture should still give you a significant
reduction vPMU overheads.

Last thing, let's table guest support for FEAT_PMUv3_ICNTR for the time
being. Yes, it falls in the KVM-owned range, but we can just handle it
with a fine-grained undef for now. Once the core infrastructure has
landed upstream we can start layering new features into the partitioned
implementation.

Thanks,
Oliver

