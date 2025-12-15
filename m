Return-Path: <linux-kselftest+bounces-47587-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1AACBF4AF
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Dec 2025 18:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E783300FA29
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Dec 2025 17:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07834322B6E;
	Mon, 15 Dec 2025 17:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEVe02Iu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9B5322547;
	Mon, 15 Dec 2025 17:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765821025; cv=none; b=aIx9gD7pt0EN7uJKC6PbbMHg/RwZ2QhgzihQyDbVtowbf4dnOAtHg6Ojqtsw4m2Vnds10LdJN6jgXRXSwl/Jzp67AdzvUzadddim1yR83DAK/2CkzVsikQnIX45YrHwEn3C8zxhhqED2MdAsv+lpbCgSznyrpCsANMXSMKxTkXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765821025; c=relaxed/simple;
	bh=YrTHPSx4341UHi+jq+akqh9qZcSw7dvO2ic7YUiWbg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPxMdgL6eyKVGKDYS1C52GQCuY33tp/ZJ2QkAy/5VKQ9nmZa+raQS1PHQJoPrTRcqwQXe2jxrRW22gG9+peOW9kIyAayfXwYyaDDl7Gx1xFvSL5XPDfexmcZekVDjfovhysdF88VqKtj+5J+3tQ0cOpSMQ3dD0okuXGxfaLV6Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEVe02Iu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132FCC4CEF5;
	Mon, 15 Dec 2025 17:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765821025;
	bh=YrTHPSx4341UHi+jq+akqh9qZcSw7dvO2ic7YUiWbg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CEVe02IunMd7oRHFksHEuNX1ZGXmcKIUYs9D3rfyToXy2S9a/vJIReRvxn0hSyuHq
	 ZYiHE+ofGwyMAJmluKhkQYrdZH/sUMKtertR6dDwxTG+iRRnl/gjKIqHFfSgnoV8Fk
	 /L9lVyXu1WUxeBFv8WZU9ewBj0Uk7MrThe65m2SeSzSV5CJ1IHPADfw7Bhajy5exxg
	 f29m8+hYKOCCh9kjItC7brKVPTJ8NfuY+VapVLoxSo3SCPlFZTTXHGejcN362IY5CC
	 x0KbRMlW7m0lhBWnhBDb71H/F/MBsH1wSUTLQinohrsqHRnKc3HV6K4mEP6ckdb691
	 4ezHrJtnERipQ==
Date: Mon, 15 Dec 2025 09:50:23 -0800
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
Subject: Re: [PATCH v5 21/24] KVM: arm64: Inject recorded guest interrupts
Message-ID: <aUBKX8iqsptyTb4S@kernel.org>
References: <aTioEWHu0ZbFCjR6@kernel.org>
 <gsnt8qf72tv9.fsf@coltonlewis-kvm.c.googlers.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gsnt8qf72tv9.fsf@coltonlewis-kvm.c.googlers.com>

On Fri, Dec 12, 2025 at 10:55:06PM +0000, Colton Lewis wrote:
> Oliver Upton <oupton@kernel.org> writes:
> 
> > In no situation should KVM be injecting a "recorded" IRQ. The overflow
> > condition of the PMU is well defined in the architecture and we should
> > implement *exactly* that.
> 
> When I say "record" I just meant "updating the virtual overflow register
> to reflect an overflow".

Right, consider changing the shortlog to read more along the lines of
"detect overflows for partitioned PMU" or similar.

> > On Tue, Dec 09, 2025 at 08:51:18PM +0000, Colton Lewis wrote:
> > > +/**
> > > + * kvm_pmu_part_overflow_status() - Determine if any guest counters
> > > have overflowed
> > > + * @vcpu: Ponter to struct kvm_vcpu
> > > + *
> > > + * Determine if any guest counters have overflowed and therefore an
> > > + * IRQ needs to be injected into the guest.
> > > + *
> > > + * Return: True if there was an overflow, false otherwise
> > > + */
> > > +bool kvm_pmu_part_overflow_status(struct kvm_vcpu *vcpu)
> > > +{
> > > +	struct arm_pmu *pmu = vcpu->kvm->arch.arm_pmu;
> > > +	u64 mask = kvm_pmu_guest_counter_mask(pmu);
> > > +	u64 pmovs = __vcpu_sys_reg(vcpu, PMOVSSET_EL0);
> > > +	u64 pmint = read_pmintenset();
> > > +	u64 pmcr = read_pmcr();
> 
> > How do we know that the vPMU has been loaded on the CPU at this point?
> 
> Because this is only called by kvm_pmu_update_state which is only called
> by kvm_pmu_update_state <- kvm_pmu_{flush,sync}_hwstate <-
> kvm_arch_vcpu_ioctl_run after a vcpu_load.

That's assuming the PMU is loaded eagerly which I thought we agreed it
would not be.

Thanks,
Oliver

