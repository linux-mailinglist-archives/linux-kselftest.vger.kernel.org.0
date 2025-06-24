Return-Path: <linux-kselftest+bounces-35670-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1363AE5DA7
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 09:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5E3A4008D8
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 07:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CF425524C;
	Tue, 24 Jun 2025 07:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DqFTQJCz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9191724EA85
	for <linux-kselftest@vger.kernel.org>; Tue, 24 Jun 2025 07:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750750112; cv=none; b=ZMyPmf8CkQA0mWkTIvREOMKBLJPwPGNcxmWB+lFpXsco40yBY9Uuw5goEJrhsJ2h82tcmJ4KPsjjYDaM/eD3ibI2Zxvdx5WvbbMjapdwvhq2TOWipZtHJynkqRMW1dp+wMWNYiZ38weY5uQn3YbEz9VUsL3BpKjrQ3peHZtWeq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750750112; c=relaxed/simple;
	bh=E0MHYIBtJb1pjGFFLLtjW6ldijZKZX8x+CorPvQl3vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+9xKtdludvSb5PH76kyq0rfSZP3wmIXJ6/34Qtwv0Xkkyb4i5yfaf8ftkuCBpOuq0Ub+0nSo7qBRb4KMc/xVkx21hjcf7ST6wESQFFkK2wEtCXYqINEEUzn2Nvus2Kwjcmmz1hS/NwQB9UhgexctE1bvMwcUHWyM9wUN9SMp10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DqFTQJCz; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 24 Jun 2025 00:28:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750750096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lc032N2dP+96gZo5C4cwrU+RJ37ABZ5fu4zPpJwktik=;
	b=DqFTQJCzyv7ZW1hvEieX7Tv1cH2uTdFq+CU5nxIqcXQzUMK7fJNSfc1ljHoatbsDfahyJy
	A/drSdnfKA4r++oWZYI67rUXxdDdMTS78irjNs8L0Ja5xCl/c9X+xBvTINGbvVjcqLLx4a
	JKirWyEfgoAsJNKWk2g5AXAJMBIikM8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Colton Lewis <coltonlewis@google.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, corbet@lwn.net,
	linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
	maz@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, mark.rutland@arm.com, shuah@kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 01/23] arm64: cpufeature: Add cpucap for HPMN0
Message-ID: <aFpThZIE2PxjVAVw@linux.dev>
References: <aFYAXjzICzgmSyLI@linux.dev>
 <gsntqzza9uxp.fsf@coltonlewis-kvm.c.googlers.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gsntqzza9uxp.fsf@coltonlewis-kvm.c.googlers.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 23, 2025 at 06:25:38PM +0000, Colton Lewis wrote:
> Oliver Upton <oliver.upton@linux.dev> writes:
> 
> > On Fri, Jun 20, 2025 at 10:13:01PM +0000, Colton Lewis wrote:
> > > Add a capability for FEAT_HPMN0, whether MDCR_EL2.HPMN can specify 0
> > > counters reserved for the guest.
> 
> > > This required changing HPMN0 to an UnsignedEnum in tools/sysreg
> > > because otherwise not all the appropriate macros are generated to add
> > > it to arm64_cpu_capabilities_arm64_features.
> 
> > > Signed-off-by: Colton Lewis <coltonlewis@google.com>
> > > ---
> > >   arch/arm64/kernel/cpufeature.c | 8 ++++++++
> > >   arch/arm64/tools/cpucaps       | 1 +
> > >   arch/arm64/tools/sysreg        | 6 +++---
> > >   3 files changed, 12 insertions(+), 3 deletions(-)
> 
> > > diff --git a/arch/arm64/kernel/cpufeature.c
> > > b/arch/arm64/kernel/cpufeature.c
> > > index b34044e20128..278294fdc97d 100644
> > > --- a/arch/arm64/kernel/cpufeature.c
> > > +++ b/arch/arm64/kernel/cpufeature.c
> > > @@ -548,6 +548,7 @@ static const struct arm64_ftr_bits ftr_id_mmfr0[] = {
> > >   };
> 
> > >   static const struct arm64_ftr_bits ftr_id_aa64dfr0[] = {
> > > +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE,
> > > ID_AA64DFR0_EL1_HPMN0_SHIFT, 4, 0),
> > >   	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE,
> > > ID_AA64DFR0_EL1_DoubleLock_SHIFT, 4, 0),
> > >   	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE,
> > > ID_AA64DFR0_EL1_PMSVer_SHIFT, 4, 0),
> > >   	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE,
> > > ID_AA64DFR0_EL1_CTX_CMPs_SHIFT, 4, 0),
> > > @@ -2896,6 +2897,13 @@ static const struct arm64_cpu_capabilities
> > > arm64_features[] = {
> > >   		.matches = has_cpuid_feature,
> > >   		ARM64_CPUID_FIELDS(ID_AA64MMFR0_EL1, FGT, FGT2)
> > >   	},
> > > +	{
> > > +		.desc = "Allow MDCR_EL2.HPMN = 0",
> 
> > This feedback still stands...
> 
> > 		.desc = "HPMN0",
> 
> > [*] https://lore.kernel.org/kvm/aD4ijUaSGm9b2g5H@linux.dev/
> 
> Sorry for ignoring your previous feedback. I looked at the other .desc
> fields and they had more descriptive English, so I think this one should
> be more than "FEAT_HPMN0" for consistency.
> 
> If you insist I'll change it.

I'm not exactly sold on the merits of using descriptive names for the
capabilities, as the architecture extension names are exact terms that
can be related back to documentation.

Thanks,
Oliver

