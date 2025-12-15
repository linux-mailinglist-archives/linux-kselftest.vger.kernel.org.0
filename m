Return-Path: <linux-kselftest+bounces-47588-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DE2CBF593
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Dec 2025 19:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C16C03001BDD
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Dec 2025 18:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7334A33891A;
	Mon, 15 Dec 2025 18:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4dXhe81"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CF8338582;
	Mon, 15 Dec 2025 18:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765821984; cv=none; b=hbVgF++851Uwwd83vfYD0Oig+i95ATTkLHc5XmhUWvU1QpHvZJoAJlTpS3y6FS6fhPwpUfr3ICrNDqjtY9L9+3Fp96vd8sSmyyE/KxcM0+tJUZepmK92UvNPN2SuNew1R3AjkpenCALMWuM1b/+aY5+w8IY5kvxk1FmmdXnelek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765821984; c=relaxed/simple;
	bh=rJKmpgwGt+PHS/ree1WrcDO5XiHWvRcZqNyAmcIy9es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LD2BRIfKwFYBHPHirmE7CYP+vR59cGqi58ZfCOTq0gD/ml+Rqr0VBLZnXIXKwxJytVKbidHyop8vDEyeJP2joxrT6O9qAEedAhmbyy6zCz19qEHr+RHviNv2xWlnxVMEy8ExbV8Sl346SyMafMD97lpfGiKuO26zaw+pn/jY/9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4dXhe81; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815FCC4CEF5;
	Mon, 15 Dec 2025 18:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765821983;
	bh=rJKmpgwGt+PHS/ree1WrcDO5XiHWvRcZqNyAmcIy9es=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X4dXhe815EGINN9+D1XDn9JYU912TK9FP4PyD9foSopSle3q6dYCpVr7jyRI+DWhV
	 i6Kl7yfrDQ4oeU9p4NFbKlHcZcHLCJnJKJW94SSYYy2027yh6oiX0HK+vlP/mFkgUK
	 mdZ1j/FEb2u77rv4Czi+cnB6TX/3tPXeEf921FoIY1kP8zucob8vquXGqRRwH5blGu
	 xe7Yqqh6OPmRYcD0CODaZO0GScRbWURp5ofAw6wIEfevB9DzZdxup/JiUjV7dz0lu4
	 al90hyz2mGYTARGtQoXeQzQHL243qPui+pkwqiXgqGkCb0e324FpssFbB2tPlaUd/9
	 po/4NT+SEhi5Q==
Date: Mon, 15 Dec 2025 10:06:22 -0800
From: Oliver Upton <oupton@kernel.org>
To: Colton Lewis <coltonlewis@google.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, corbet@lwn.net,
	linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
	maz@kernel.org, oliver.upton@linux.dev, mizhang@google.com,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	mark.rutland@arm.com, shuah@kernel.org,
	gankulkarni@os.amperecomputing.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 19/24] KVM: arm64: Implement lazy PMU context swaps
Message-ID: <aUBOHnT1whwR3vbo@kernel.org>
References: <aTidfRwYLYwTfmK_@kernel.org>
 <gsntecoz2v87.fsf@coltonlewis-kvm.c.googlers.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gsntecoz2v87.fsf@coltonlewis-kvm.c.googlers.com>

On Fri, Dec 12, 2025 at 10:25:44PM +0000, Colton Lewis wrote:
> Oliver Upton <oupton@kernel.org> writes:
> 
> > On Tue, Dec 09, 2025 at 08:51:16PM +0000, Colton Lewis wrote:
> > > +enum vcpu_pmu_register_access {
> > > +	VCPU_PMU_ACCESS_UNSET,
> > > +	VCPU_PMU_ACCESS_VIRTUAL,
> > > +	VCPU_PMU_ACCESS_PHYSICAL,
> > > +};
> 
> > This is confusing. Even when the guest is accessing registers directly
> > on the CPU I'd still call that "hardware assisted virtualization" and
> > not "physical".
> 
> It was what I thought described the access pattern. Do you have another
> naming suggestion?

	PMU_STATE_FREE,
	PMU_STATE_GUEST_OWNED,

> > > +	kvm_pmu_set_physical_access(vcpu);
> > > +
> > >   	return true;
> > >   }
> 
> > Aren't there a ton of other registers the guest may access before
> > these two? Having generic PMU register accessors would allow you to
> > manage residence of PMU registers from a single spot.
> 
> Yes but these are the only two that use the old trap handlers. I also
> call set_physical_access from my fast path handler that handles all the
> other registers when partitioned.

The fast path accessors should only be accessing state already loaded
on the CPU. If the guest's PMU context isn't loaded on the CPU then it
should return to a kernel context and do a full put/load on the vCPU.

I'm not seeing how this all fits together but for lazy loading to work
correctly you need to evaluate the state of the vPMU at vcpu_load(). If
there exists an enabled PMC, set PMU_STATE_GUEST_OWNED and load it
upfront.

Otherwise, default to PMU_STATE_FREE until the next register access and
this whole thing resets when the vCPU is scheduled out. I had suggested
to you a while back that you should follow a similar model to the debug
registers, this is how they behave.

Thanks,
Oliver

