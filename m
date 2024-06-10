Return-Path: <linux-kselftest+bounces-11602-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 106A4902A91
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 23:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 812591F20F1C
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 21:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B873057CA7;
	Mon, 10 Jun 2024 21:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tmLBnM8c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D43E1B7FD
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Jun 2024 21:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718054867; cv=none; b=WJJVME/mNe3LcA9pltM2t94te+RqUrJApwGdFWFbpstBZtxXzcsikBhe8qIac43sdN3YemBRHzvjy3tiH+3doJpkCI1t6KOiEWNVN7lHgfrfpHUDw44g3aFJQ5LDP+HVSUCc8nZd6kY5ARg243IiPXjcThzFDoilfYixMaulNd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718054867; c=relaxed/simple;
	bh=0o+jjQiifOTCMVQUM04UVchcL5waYA0JeJLLyZdNrKI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RpSiA/bvyUPw/UjQ/fSfC6VzOqi7NYFt1HZrrKi4AusaPoym5rv5BpMbK8/JPVTpeULYPfTar0pyIXrDDB6V12pFwGdz3Pcx3t7FtgkmTNrJKTA1+pYjyuhk2GzjrnkEr+D8iwpKjlmehtb8RlbTqh2LNK6fSxS0lNMdNu/1LBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tmLBnM8c; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-6c761c61892so4690590a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jun 2024 14:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718054865; x=1718659665; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kpTwvXr7PTLHgh7A1q9yVuIlNtMg/utPoyrhC0r4kPE=;
        b=tmLBnM8cet/fDogTY/73WgRXzagZWlOjKrTM/PIaMzm1u9xY7gZIG6+4oKCoYuIB7H
         wuSUR/nlX8tG28eVB1jGE8vKBuOAxeF/4iOXbYcGPWLzup0k5+dn/oinIx6xjTsszZBz
         VW2iPG9IT78tNIO3M1/xRKivYEm82WowZXKxPVV78rtew0xhYatBWX3Xd6Yqpm9sZ/h7
         7y+WgNnxn11hy5wkuH7i4lJFbDUrHs1QOyBWqnTsIdAhLVZvFTy7TkWKyD5DdiYTKGPM
         5hSPl9C80+eP/f9/RoZjprobwaz3TOrEsHuARgP/OhQ5JVvDZbYjXSGuvP2lW6xEB8YJ
         BdcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718054865; x=1718659665;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kpTwvXr7PTLHgh7A1q9yVuIlNtMg/utPoyrhC0r4kPE=;
        b=W6+xcbvlyJqV/k3oyUgta/7vPioxkO12kjRSgCB3RHOB7RsPaHOugqVeVGEWyNWV+E
         r5HLWThndTUm4Zg1CY6UGYzBn/Y7k9+gcGbHcP8wx5HsHdjFBfxTdOJXvv/RTVDSy02G
         gIQjWOOqIRkgJuojqKxbLGIIgfxtowBbh2406Rtitowe9e6deq0xcmL4rcgnVR+EdaTu
         ULs0zFFDmov91nlWaApIaneW3eQ0qDsq8kuCvFFPd+cCOpfB5fdQeknvpBxogmNR5ccs
         uc8PAV5/Q1PbqeaBV5Zb/pFlHpdaAG56usGWqTmesUHNcz75V/Cy2hscSV1hrqv8RvLp
         iCxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQb36xge++Z8OLsjZfnZHw3YjEi1eb2tRiYIkjaYJndXjsirDGXuN66lUkWuXki5jEjkLLpJfHFPuHxF+HvTgzImPF9UbABTkmPdOnaXIg
X-Gm-Message-State: AOJu0Yz//WRXJjYVJAOzQej2kFYNgjeJ1lLEI5vcgFwoPUJH3LDCIiGf
	REnJhFuaxMo3/V7u1X/M2sCvdQwfVD+mKJO1FdavlpczOUW3SPJl7IeF8uQrDnzlrkgl0nJGE7u
	H4A==
X-Google-Smtp-Source: AGHT+IFnJL5tvWfrf1NceCqfcI+KtB1oseQNaQWAubEKby8gMw+NuLS2vd/et1sOJdqW4BqJmAa1QhpNTqk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:f68c:b0:1f7:167d:e2a9 with SMTP id
 d9443c01a7336-1f7167dec29mr4296865ad.13.1718054865348; Mon, 10 Jun 2024
 14:27:45 -0700 (PDT)
Date: Mon, 10 Jun 2024 14:27:43 -0700
In-Reply-To: <20240605050835.30491-1-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240605050835.30491-1-manali.shukla@amd.com>
Message-ID: <Zmdvz-3exedRbCmy@google.com>
Subject: Re: [PATCH v2] KVM: selftest: Add a common check to identify AMD cpu
 in perf event filter test
From: Sean Christopherson <seanjc@google.com>
To: Manali Shukla <manali.shukla@amd.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, pbonzini@redhat.com, 
	shuah@kernel.org, nikunj@amd.com, thomas.lendacky@amd.com, 
	sandipan.das@amd.com, ravi.bangoria@amd.com, ananth.narayan@amd.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Jun 05, 2024, Manali Shukla wrote:
> PMU event filter test fails on zen4 architecture because of the
> unavailability of family and model check for zen4 in use_amd_pmu().
> use_amd_pmu() is added to detect architectures that supports event

No, use_amd_pmu() already exists.

> select 0xc2 umask 0 as "retired branch instructions".
> 
> Model ranges in is_zen1(), is_zen2() and is_zen3() are used only for
> sever SOCs, so they might not cover all the model ranges which supports
> retired branch instructions.
> 
> X86_FEATURE_ZEN is a synthetic feature flag specifically added to
> recognize all Zen generations by commit 232afb557835d ("x86/CPU/AMD: Add
> X86_FEATURE_ZEN1"). init_amd_zen_common() uses family >= 0x17 check to
> enable X86_FEATURE_ZEN.

This is a lot of unnecessary noise.  It's mildly interesting that the kernel also
treats 17h+ as Zen, but the existence of a synthetic flag in the kernel doesn't
make this any more or less correct.

> Family 17h+ is where Zen and its successors start and that event 0xc2,0
> is supported on all currently released F17h+ processors as branch
> instruction retired and it is true going forward to maintain the
> backward compatibility for the branch instruction retired.
> 
> Since X86_FEATURE_ZEN is not recognized in selftest framework, instead
> of checking family and model value for all zen architecture, "family >=
> 0x17" check is added in use_amd_pmu().
> 
> Fixes: bef9a701f3eb ("selftests: kvm/x86: Add test for KVM_SET_PMU_EVENT_FILTER")

I don't think a Fixes tag is justified.  There was nothing wrong with the commit
when it went in, e.g. Zen4 wasn't even officialy released yet.

If we want to get test coverage on older kernels, then an explicit Cc: to stable
would be the way to go, but it's not clear to me that even that is warranted.

> Suggested-by: Sandipan Das <sandipan.das@amd.com>
> Signed-off-by: Manali Shukla <manali.shukla@amd.com>
> ---

...

>  /*
> - * Determining AMD support for a PMU event requires consulting the AMD
> - * PPR for the CPU or reference material derived therefrom. The AMD
> - * test code herein has been verified to work on Zen1, Zen2, and Zen3.
> - *
> - * Feel free to add more AMD CPUs that are documented to support event
> - * select 0xc2 umask 0 as "retired branch instructions."
> + * Family 17h+ is where Zen and its successors start and that event
> + * 0xc2,0 is supported on all currently released F17h+ processors as
> + * branch instruction retired and it is true going forward to maintain
> + * the backward compatibility for the branch instruction retired.

For the comment, just state what the "rule" is, and leave it to the changelog to
explain why the rule is correct (i.e. that AMD pinky swears not to change it).

>   */
>  static bool use_amd_pmu(void)
>  {
>  	uint32_t family = kvm_cpu_family();
> -	uint32_t model = kvm_cpu_model();
> -
> -	return host_cpu_is_amd &&
> -		(is_zen1(family, model) ||
> -		 is_zen2(family, model) ||
> -		 is_zen3(family, model));
> +	return family >= 0x17;

This still needs to check host_cpu_is_amd.  There's also a comment elsewhere in
the file that needs to be updated.

All in all, this is what I'm applying (not yet tested).  Please holler if you
disagree with anything.

--
From: Manali Shukla <manali.shukla@amd.com>
Date: Wed, 5 Jun 2024 05:08:35 +0000
Subject: [PATCH] KVM: selftests: Treat AMD Family 17h+ as supporting branch
 insns retired

When detecting AMD PMU support for encoding "branch instructions retired"
as event 0xc2,0, simply check for Family 17h+ as all Zen CPUs support said
encoding, and AMD will maintain the encoding for backwards compatibility
on future CPUs.

Note, the kernel proper also interprets Family 17h+ as Zen (see the sole
caller of init_amd_zen_common()).

Suggested-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Manali Shukla <manali.shukla@amd.com>
Link: https://lore.kernel.org/r/20240605050835.30491-1-manali.shukla@amd.com
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../kvm/x86_64/pmu_event_filter_test.c        | 35 +++----------------
 1 file changed, 5 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
index 26b3e7efe5dd..c15513cd74d1 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
@@ -32,8 +32,8 @@ struct __kvm_pmu_event_filter {
 
 /*
  * This event list comprises Intel's known architectural events, plus AMD's
- * "retired branch instructions" for Zen1-Zen3 (and* possibly other AMD CPUs).
- * Note, AMD and Intel use the same encoding for instructions retired.
+ * Branch Instructions Retired for Zen CPUs.  Note, AMD and Intel use the
+ * same encoding for Instructions Retired.
  */
 kvm_static_assert(INTEL_ARCH_INSTRUCTIONS_RETIRED == AMD_ZEN_INSTRUCTIONS_RETIRED);
 
@@ -353,38 +353,13 @@ static bool use_intel_pmu(void)
 	       kvm_pmu_has(X86_PMU_FEATURE_BRANCH_INSNS_RETIRED);
 }
 
-static bool is_zen1(uint32_t family, uint32_t model)
-{
-	return family == 0x17 && model <= 0x0f;
-}
-
-static bool is_zen2(uint32_t family, uint32_t model)
-{
-	return family == 0x17 && model >= 0x30 && model <= 0x3f;
-}
-
-static bool is_zen3(uint32_t family, uint32_t model)
-{
-	return family == 0x19 && model <= 0x0f;
-}
-
 /*
- * Determining AMD support for a PMU event requires consulting the AMD
- * PPR for the CPU or reference material derived therefrom. The AMD
- * test code herein has been verified to work on Zen1, Zen2, and Zen3.
- *
- * Feel free to add more AMD CPUs that are documented to support event
- * select 0xc2 umask 0 as "retired branch instructions."
+ * On AMD, all Family 17h+ CPUs (Zen and its successors) use event encoding
+ * 0xc2,0 for Branch Instructions Retired.
  */
 static bool use_amd_pmu(void)
 {
-	uint32_t family = kvm_cpu_family();
-	uint32_t model = kvm_cpu_model();
-
-	return host_cpu_is_amd &&
-		(is_zen1(family, model) ||
-		 is_zen2(family, model) ||
-		 is_zen3(family, model));
+	return host_cpu_is_amd && kvm_cpu_family() >= 0x17;
 }
 
 /*

base-commit: f626279dea33ba551839f2321511ad127e5a58e8
-- 

