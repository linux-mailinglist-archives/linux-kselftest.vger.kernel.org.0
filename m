Return-Path: <linux-kselftest+bounces-27003-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE538A3C57D
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 17:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1D9018862C3
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 16:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7575C21420B;
	Wed, 19 Feb 2025 16:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FDvEz8Qd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AF9213E94
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Feb 2025 16:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739984126; cv=none; b=kp1Yo/FgeTOqnMlRpw4ajcsTRskVVqHHaDGBc2mUcjioQscxVEZSYPfgNjF7HN3TCuIfoUvCxR8x58FO9nK00iWhM7ERqAcznO9rMGJHoc71wKrSxfYrhDVOmGUdqiItrOOHBzVRGYcYMMto82PP7gpRHETsNx8ZVzRHnXuGBcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739984126; c=relaxed/simple;
	bh=zXZMhxfgPGoGg9+pszO2DAIc2abTR6Bhzlavg2C7vT4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MdXJDnjv1imERmVAXEnVCD/4HsAXgqyXPyv51snIFnjpMHkWEhvJV1NI9F6S/G3q6NFvGa717R2mIOnuQ12Ro2jGdLKVKfLFZ8ad6KXGookPVD5tgPM0akbWs4yAeeESV+i644A/7Qw4UWJilZFu2k/RZx3jHWk4Pa7gnfiL6vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FDvEz8Qd; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc2b258e82so27909a91.0
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Feb 2025 08:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739984124; x=1740588924; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GZJR0+PtUXDIHTCVf0zYccbuwTW86FFOWj32RIzZzvw=;
        b=FDvEz8Qd1l0kkbZ5PgNj4wigvrLb0m4x40/xLZyZM3coiAdNR6KejN5EigU8Ncweqm
         8JmFVD+ix3zi4EUfP9yoZHVvjKeSMzmcrAcjUr8F3gXl/xrdUuLJwEKNPDZMuxFPucbP
         cE0pd+XdPN3bdZ3S4nGDsp3M4HzxT44gDW5RIpZ1+o3KdZaHPcho0YwhChzGINeE0z37
         sSP7u/9T39LQ/Zrbl2vjuJlRr3lfULF7CQIpnBt5Eeper6T+F/MERfW8PHayRL2M+Z41
         GC2f+PfCqfgEPwre01wrPFJulrnYf1WS3Pjjswz9Z1TmIG4YVkjxVg8ywEPqYk1v9QGm
         sUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739984124; x=1740588924;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GZJR0+PtUXDIHTCVf0zYccbuwTW86FFOWj32RIzZzvw=;
        b=rwQLRQ+Sxud/t4eZEt4E3X5ntgElgg3ZhtLnBEzSMpHfeI30gl3dzYpQ1kkhKhX28P
         lki2DIsXuRXIcvn8F0PEzB/ICUTnL58I3/O+1SqzPFtaudaAvQx1Mix6Y3T4pvdB+KaK
         3Yd2tGBkgKrcZh8iTKJAnkcmdQga6hC9xL9GXs8odr8eUkIhIQRlQfZ9o7nn5hzyYSff
         LQTbso2QI6JlPz2HwMv3vWdfcKMlg6xDww0SRvRwzlRxvBScXDkcpQdv/uNUwBT2RuxJ
         3a9x+h2sFClHn707DfpaH66M9tzIYzI3RxDMDfJiafcSMOlYuKvISBSWGZPHlt2xzLKQ
         adRQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3kP6cOHx8KlRo5gCtSVuHKbDLgSloOmYSt4n/EwQJpAJ47NVoSoHmxdnkpXNVS7UWj+R0sdtX1++coyVjJPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvAfjVEH6FTmazEvDO6QQwhxss7ZCA4afjqJQpPnRm5eVNjuio
	e85cOyGjgt5SSqMsg8lyE2TcWnQpr04D+ebCiH6L8MvXWlkO5RyijEsGq6KeZ1JdqHw/sjrzsFj
	bow==
X-Google-Smtp-Source: AGHT+IFxL1r3PI/Br5RBGy9nlJ2Yu+epzR55PEoYubTnTOQFjm0trVfsQ3SG73ehJJ8KFg41YfQTt7ILMT8=
X-Received: from pjf4.prod.google.com ([2002:a17:90b:3f04:b0:2fc:13d6:b4cb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:134e:b0:2ee:acb4:fecd
 with SMTP id 98e67ed59e1d1-2fcb5a10379mr6963863a91.9.1739984124036; Wed, 19
 Feb 2025 08:55:24 -0800 (PST)
Date: Wed, 19 Feb 2025 08:55:22 -0800
In-Reply-To: <ecaee27e-c121-4831-9764-043d2e6230cf@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250203223205.36121-1-prsampat@amd.com> <20250203223205.36121-7-prsampat@amd.com>
 <Z6wDiOGjSElatLBd@google.com> <ecaee27e-c121-4831-9764-043d2e6230cf@amd.com>
Message-ID: <Z7YM-hu-xfVGbAad@google.com>
Subject: Re: [PATCH v6 6/9] KVM: selftests: Add library support for
 interacting with SNP
From: Sean Christopherson <seanjc@google.com>
To: Pratik Rajesh Sampat <prsampat@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	pbonzini@redhat.com, thomas.lendacky@amd.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, shuah@kernel.org, 
	pgonda@google.com, ashish.kalra@amd.com, nikunj@amd.com, pankaj.gupta@amd.com, 
	michael.roth@amd.com, sraithal@amd.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Feb 14, 2025, Pratik Rajesh Sampat wrote:
> On 2/11/25 8:12 PM, Sean Christopherson wrote:
> > On Mon, Feb 03, 2025, Pratik R. Sampat wrote:
> >> Extend the SEV library to include support for SNP ioctl() wrappers,
> >> which aid in launching and interacting with a SEV-SNP guest.
> >>
> >> Tested-by: Srikanth Aithal <sraithal@amd.com>
> >> Signed-off-by: Pratik R. Sampat <prsampat@amd.com>
> 
> [..snip..]
> 
> >> +/*
> >> + * A SEV-SNP VM requires the policy reserved bit to always be set.
> >> + * The SMT policy bit is also required to be set based on SMT being
> >> + * available and active on the system.
> >> + */
> >> +static inline u64 snp_default_policy(void)
> >> +{
> >> +	bool smt_active = false;
> >> +	FILE *f;
> >> +
> >> +	f = fopen("/sys/devices/system/cpu/smt/active", "r");
> > 
> > Please add a helper to query if SMT is enabled.  I doubt there will ever be many
> > users of this, but it doesn't seem like something that should buried in SNP code.
> > 
> > Ha!  smt_possible() in tools/testing/selftests/kvm/x86/hyperv_cpuid.c is already
> > guilty of burying a related helper, and it looks like it's a more robust version.
> > 
> 
> You're right, a more general helper is in order here.
> 
> Since the hyperv_cpuid selftest only seems to care about whether SMT is
> possible (i.e., it may or may not be enabled) and we care about it being
> enabled as well, for the flag to be set. I should make a more generic
> variant(s) that can be accessible to both. Maybe I can implement it
> within testing/selftests/kvm/include/x86_processor.h?

It should go in kvm_util.h, /sys/devices/system/cpu/smt/active is a generic interface
provided by kernel/cpu.c.

> >> @@ -93,7 +124,7 @@ void sev_vm_launch(struct kvm_vm *vm, uint32_t policy)
> >>  	TEST_ASSERT_EQ(status.state, SEV_GUEST_STATE_LAUNCH_UPDATE);
> >>  
> >>  	hash_for_each(vm->regions.slot_hash, ctr, region, slot_node)
> >> -		encrypt_region(vm, region);
> >> +		encrypt_region(vm, region, 0);
> > 
> > Please add an enum/macro instead of open coding a literal '0'.  I gotta assume
> > there's an appropriate name for page type '0'.
> > 
> 
> For SNP, we supply this parameter to determine the page type for SNP
> launch update defined as KVM_SEV_SNP_PAGE_TYPE_*. For SEV/SEV-ES,
> however, the page type doesn't really get factored in and falls through
> unaccounted in that case, so I had passed a zero to it.
> 
> Having said that, having a literal here is quite unclean. Maybe I can
> pass one of the existing page types to it or, better yet, define a new
> KVM_SEV_PAGE_TYPE_[RESERVED|UNUSED] type instead for our selftest
> header?

Ya, define something new and arbitrary.  I vote for either KVM_SEV_PAGE_TYPE_NONE
or KVM_SEV_PAGE_TYPE_INVALID.  RESERVED suggests the page is "valid" but reserved
for some entity.  Ditto for UNUSED; valid, but not yet claimed.

