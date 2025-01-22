Return-Path: <linux-kselftest+bounces-24928-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C179A19104
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 12:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8165C1887C93
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 11:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30901211A3C;
	Wed, 22 Jan 2025 11:56:49 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B708F20FA85;
	Wed, 22 Jan 2025 11:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737547009; cv=none; b=kr9arxezeFeF//Jg0f0m6LvwhjLuzTNIaG3PkBDfxz+FBTrFa3GCuDhlYRwjonF7pgu2gNKdNNbYfZ9cm3V5cLc60d1avSHbD67TGU3iGrlz9cZxqdGDedeNJ58WiCS4EviZvQVB2yX3gtQ2X86Ac0Ju7AnkSX6IKNrfgxVAY2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737547009; c=relaxed/simple;
	bh=+EIjOXYtV7UHuH1Wh/VPj04+iLEP4wQGaJPu3yGhD58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bEQWQNo2k2eoz6GUM6SCGjxEP3u+5Vx3HgyMRRohXlaBglPU7vvWjzaAVwP1CAZySdsyaveH8IQCdgs/+VAejffHAt3R74La8/BRI/r5TPWlREnAqX0FF+t9eC6L4XEkaNgAgfRuzo4qKClpcNgaeTbZfxUW8RK20+Mb0RbyQPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 847CF1007;
	Wed, 22 Jan 2025 03:57:15 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 127373F738;
	Wed, 22 Jan 2025 03:56:43 -0800 (PST)
Date: Wed, 22 Jan 2025 11:56:41 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Will Deacon <will@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC v3 09/27] KVM: arm64: Factor SVE guest exit handling
 out into a function
Message-ID: <Z5Dc-WMu2azhTuMn@J2N7QTR9R3>
References: <20241220-kvm-arm64-sme-v3-0-05b018c1ffeb@kernel.org>
 <20241220-kvm-arm64-sme-v3-9-05b018c1ffeb@kernel.org>
 <Z4pAMaEYvdLpmbg2@J2N7QTR9R3>
 <86o6zzukwr.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86o6zzukwr.wl-maz@kernel.org>

On Wed, Jan 22, 2025 at 11:51:00AM +0000, Marc Zyngier wrote:
> On Fri, 17 Jan 2025 11:34:09 +0000, Mark Rutland <mark.rutland@arm.com> wrote:
> > The TL;DR summary is that it's not sufficient for kvm_arch_vcpu_put_fp()
> > to fix up ZCR_ELx. Either:
> > 
> > * That needs to be fixed up while IRQs are masked, e.g. by
> >   saving/restoring the host and guest ZCR_EL1 and/or ZCR_ELx values in
> >   kvm_arch_vcpu_ctxflush_fp() and kvm_arch_vcpu_ctxsync_fp()
> > 
> > * The lazy save logic in fpsimd_save_user_state() needs to handle KVM
> >   explicitly, saving the guest's ZCR_EL1 and restoring the host's
> >   ZCR_ELx.
> > 
> > I think we need to fix that before we extend this logic for SME.
> 
> So save/restore ZCR_ELx eagerly? If that's what it takes, let's do
> that now.

I believe that's sufficient; I'll go double-check and spin that now.

Mark.

