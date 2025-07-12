Return-Path: <linux-kselftest+bounces-37193-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56168B02CB3
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Jul 2025 21:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80717189F1AD
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Jul 2025 19:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE0B288C09;
	Sat, 12 Jul 2025 19:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ri65r+c5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794FD1FBEBD
	for <linux-kselftest@vger.kernel.org>; Sat, 12 Jul 2025 19:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752349663; cv=none; b=roL0BmfDwEwhOpBUTdS5qudEZ/iBxdTXr+cEhnsMGRtgyWwoNGXPXEmY+O5ZzA5/E+JPQI/mMmgN/3bALHcZZmXePYOp+CqhsUGmohyZo0LboGl9yrS/WTOd5wy4VYWkEPH5pDWcj1BruhgtNTr9X0DkxeQtq6YXKUP+xGd57rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752349663; c=relaxed/simple;
	bh=f7jirJngtZPmjp6nUuToVUR1+33dys87/8xXFSMeddQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OL/cEoRh6aYITZ8yjkDgaIpGhNDxSvwyWM9IxxVVLraSWd3AeknKMDYIWHWEdp2uDtZ+xLYJGizQYRgEfdq0UJ5zFxoKq+XL/HhFk9zIA0ktIoFfPNedGASPVWysWGLoIPuZYRPxQQecUKCTqD0Ke5fHyAj2dJUanicnTvwz5oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ri65r+c5; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 12 Jul 2025 12:47:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752349649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t/KO7cxY55TZXEuxm/aJMlnOT2I2d5MUZFj4P6QELUY=;
	b=Ri65r+c54bI2Dx0vVIuVeDzldrENr3nFiK2CbHP8HII66ewc/paI3WssyPiPfNrGcdB//4
	Z14A96Kb4SwBP+zq6/FtDPWBPhETyDJXYfATv3PnpWMTj34Qn4ihFcM7hWAG6/gm0+ONYp
	AgolM6pN6cUvnHKnZ+EXg6jN/91qaTg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Jiaqi Yan <jiaqiyan@google.com>
Cc: maz@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org,
	pbonzini@redhat.com, corbet@lwn.net, shuah@kernel.org,
	kvm@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	duenwen@google.com, rananta@google.com, jthoughton@google.com
Subject: Re: [PATCH v2 3/6] KVM: arm64: Allow userspace to inject external
 instruction aborts
Message-ID: <aHK7w4TTEm7a1mco@linux.dev>
References: <20250604050902.3944054-1-jiaqiyan@google.com>
 <20250604050902.3944054-4-jiaqiyan@google.com>
 <aHFpIpIfqVCQZVgG@linux.dev>
 <CACw3F51xRWr5LXz4-JhK+mjizY7D7Oa+GrJ-OZHktfPzFGKeiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACw3F51xRWr5LXz4-JhK+mjizY7D7Oa+GrJ-OZHktfPzFGKeiw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Jul 11, 2025 at 04:58:57PM -0700, Jiaqi Yan wrote:
> On Fri, Jul 11, 2025 at 12:42 PM Oliver Upton <oliver.upton@linux.dev> wrote:
> >
> > On Wed, Jun 04, 2025 at 05:08:58AM +0000, Jiaqi Yan wrote:
> > > From: Raghavendra Rao Ananta <rananta@google.com>
> > >
> > > When KVM returns to userspace for KVM_EXIT_ARM_SEA, the userspace is
> > > encouraged to inject the abort into the guest via KVM_SET_VCPU_EVENTS.
> > >
> > > KVM_SET_VCPU_EVENTS currently only allows injecting external data aborts.
> > > However, the synchronous external abort that caused KVM_EXIT_ARM_SEA
> > > is possible to be an instruction abort. Userspace is already able to
> > > tell if an abort is due to data or instruction via kvm_run.arm_sea.esr,
> > > by checking its Exception Class value.
> > >
> > > Extend the KVM_SET_VCPU_EVENTS ioctl to allow injecting instruction
> > > abort into the guest.
> > >
> > > Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> > > Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> >
> > Hmm. Since we expose an ESR value to userspace I get the feeling that we
> > should allow the user to supply an ISS for the external abort, similar
> > to what we already do for SErrors.
> 
> Oh, I will create something in v3, by extending kvm_vcpu_events to
> something like:
> 
> struct {
>   __u8 serror_pending;
>   __u8 serror_has_esr;
>   __u8 ext_dabt_pending;
>   __u8 ext_iabt_pending;
>   __u8 ext_abt_has_esr;  // <= new
>   /* Align it to 8 bytes */
>   __u8 pad[3];
>   union {
>     __u64 serror_esr;
>     __u64 ext_abt_esr;  // <= new

This doesn't work. The ABI allows userspace to pend both an SError and
SEA, so we can't use the same storage for the ESR.

>   };
> } exception;
> 
> One question about the naming since we cannot change it once
> committed. Taking the existing SError injection as example, although
> the name in kvm_vcpu_events is serror_has_esr, it is essentially just
> the ISS fields of the ESR (which is also written in virt/kvm/api.rst).
> Why named after "esr" instead of "iss"? The only reason I can think of
> is, KVM wants to leave the room to accept more fields than ISS from
> userspace. Does this reason apply to external aborts? Asking in case
> if "iss" is a better name in kvm_vcpu_events, maybe for external
> aborts, we should use ext_abt_has_iss?

We will probably need to include more ESR fields in the future, like
ESR_ELx.ISS2. So let's just keep the existing naming if that's OK with
you.

Thanks,
Oliver

