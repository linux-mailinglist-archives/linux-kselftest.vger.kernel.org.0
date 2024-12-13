Return-Path: <linux-kselftest+bounces-23334-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B79E9F13DD
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 18:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB675281194
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 17:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDE41E47D4;
	Fri, 13 Dec 2024 17:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="EOB/VNal"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D904517B505;
	Fri, 13 Dec 2024 17:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734111503; cv=none; b=EBJ/qSgGy0ZYCpaainMt8DANWI027DVaZsKDyaJGffNU3QuYJOT3zrHlRIpKZKv527aQU/SWL1s3movyfRv7FJ2IvcvtZytpP7JbB6XWvk2JbAUF9BZ6lvYOiyIjBq0nelwBFwJFa04R628FERyTD5CNS1XYROzkJxAWlYLeNUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734111503; c=relaxed/simple;
	bh=mPbgWOcMGYlFCPvbpDL+TlJdKHPaIYsXuCeD6gLUKgw=;
	h=Subject:Date:From:To:CC:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bj93e6qwknfHQ43sEZdyqq92JNB00p5vEXovkhVecGIKZwxtYVsLvVNNgGCTX0xj8ZKHZsxvlc2j8FJ6r0XGzAH73fjRSz+7/ub6azpuhOotlabBlaecOtClJr+OwrJKH24NeiO+mQBuG1Fh1ZfSadQBt4fxk8Q0tVlYkhVuPt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=EOB/VNal; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1734111503; x=1765647503;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=9REjgkF9b+T7p8wApCqWiWDX78cu++CuxonPuil9yEk=;
  b=EOB/VNal83o+FkZBCxzJdDMS7iwcxTllNG784hLD2iXdmuxJeUamZaQO
   MTj6S8A+AOxqGbQhQHtLLLDkt8Pe//3QQgWNLtuGXPv3jTEZsTyYO/8b8
   ZCycFnePzSG1aKTVVKNLJAttaEwYJd4bp3mCvlCepFGcK4PuHSqAyRg9M
   I=;
X-IronPort-AV: E=Sophos;i="6.12,231,1728950400"; 
   d="scan'208";a="455875939"
Subject: Re: [PATCH v2 3/6] KVM: VMX: Handle vectoring error in
 check_emulate_instruction
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 17:38:20 +0000
Received: from EX19MTAUEC001.ant.amazon.com [10.0.44.209:63734]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.24.38:2525] with esmtp (Farcaster)
 id efb3ffaa-b66f-42a9-8f38-cda355b95b6d; Fri, 13 Dec 2024 17:38:18 +0000 (UTC)
X-Farcaster-Flow-ID: efb3ffaa-b66f-42a9-8f38-cda355b95b6d
Received: from EX19D008UEA004.ant.amazon.com (10.252.134.191) by
 EX19MTAUEC001.ant.amazon.com (10.252.135.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 17:38:17 +0000
Received: from EX19MTAUEB002.ant.amazon.com (10.252.135.47) by
 EX19D008UEA004.ant.amazon.com (10.252.134.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 17:38:17 +0000
Received: from email-imr-corp-prod-pdx-all-2c-c4413280.us-west-2.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.135.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Fri, 13 Dec 2024 17:38:17 +0000
Received: from dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com (dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com [10.253.74.38])
	by email-imr-corp-prod-pdx-all-2c-c4413280.us-west-2.amazon.com (Postfix) with ESMTP id C22B8A0005;
	Fri, 13 Dec 2024 17:38:16 +0000 (UTC)
Received: by dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com (Postfix, from userid 29210185)
	id 570D64E3D; Fri, 13 Dec 2024 17:38:16 +0000 (UTC)
Date: Fri, 13 Dec 2024 17:38:16 +0000
From: Ivan Orlov <iorlov@amazon.com>
To: Sean Christopherson <seanjc@google.com>
CC: Ivan Orlov <ivan.orlov0322@gmail.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <mingo@redhat.com>, <pbonzini@redhat.com>,
	<shuah@kernel.org>, <tglx@linutronix.de>, <hpa@zytor.com>,
	<kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <x86@kernel.org>, <pdurrant@amazon.co.uk>,
	<dwmw@amazon.co.uk>
Message-ID: <20241213173816.GA7768@dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com>
References: <20241111102749.82761-1-iorlov@amazon.com>
 <20241111102749.82761-4-iorlov@amazon.com>
 <Z1nWykQ3e4D5e2C-@google.com>
 <2b75550c-0dc7-4bcc-ac60-9ad4402c17f8@gmail.com>
 <Z1o1013dUex8w9hK@google.com>
 <20241212164137.GA71156@dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com>
 <Z1s8rWBrDhQaUHuw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z1s8rWBrDhQaUHuw@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Dec 12, 2024 at 11:42:37AM -0800, Sean Christopherson wrote:
> Gah, I got my enums mixed up.  I conflated RET_PF_WRITE_PROTECTED with
> EMULTYPE_WRITE_PF_TO_SP.  Ignore the above.
> 
> FWIW, KVM _can't_ unprotect and retry in the EMULTYPE_WRITE_PF_TO_SP case.  From
> kvm_unprotect_and_retry_on_failure():
> 

Ah alright, I guess I get it now :) So, EMULTYPE_ALLOW_RETRY_PF is set
whenever there is a PF when accessing write-protected page, and
EMULTYPE_WRITE_PF_TO_SP is set when this access touches SPTE used to
translate the write itself. If both are set, we can't unprotect and
retry, and the latter can be set only if the former is set.

> Unprotect and re-execute is fine, what I'm worried about is *successfully*
> emulating the instruction.  E.g.
> 
>   1. CPU executes instruction X and hits a #GP.
>   2. While vectoring the #GP, a shadow #PF is taken.
>   3. On VM-Exit, KVM re-injects the #GP (see __vmx_complete_interrupts()).
>   4. KVM emulates because of the write-protected page.
>   5. KVM "successfully" emulates and also detects the #GP
>   6. KVM synthesizes a #GP, and because the vCPU already has injected #GP,
>      incorrectly escalates to a #DF.
> 
> The above is a bit contrived, but I think it could happen if the guest reused a
> page that _was_ a page table, for a vCPU's kernel stack.
> 

Does it work like that only for contributory exceptions / page faults?
In case if it's not #GP but (for instance) #UD, (as far as I understand)
KVM will queue only one of them without causing #DF so it's gonna be
valid?

> > However, I'm not sure what happens if vectoring is caused by external
> > interrupt: if we unprotect the page and re-execute the instruction,
> > will IRQ be delivered nonetheless, or it will be lost as irq is
> > already in ISR? Do we need to re-inject it in such a case?
> 
> In all cases, the event that was being vectored is re-injected.  Restarting from
> scratch would be a bug.  E.g. if the cause of initial exception was "fixed", say
> because the initial exception was #BP, and the guest finished patching out the INT3,
> then restarting would execute the _new_ instruction, and the INT3 would be lost.
> 

Cool, that is what I was concerned about, glad that it is already
implemented :)

> 
> As far as unprotect+retry being viable, I think we're on the same page.  What I'm
> getting at is that I think KVM should never allow emulating on #PF when the #PF
> occurred while vectoring.  E.g. this:
> 
>   static inline bool kvm_can_emulate_event_vectoring(int emul_type)
>   {
>         return !(emul_type & EMULTYPE_PF);
>   }
> 

Yeah, I agree. I'll post a V3 with suggested fixes (after running all of the
selftests to be sure that it doesn't break anything).

> and then I believe this?  Where this diff can be a separate prep patch (though I'm
> pretty sure it's technically pointless without the vectoring angle, because shadow
> #PF can't coincide with any of the failure paths for kvm_check_emulate_insn()).
> 

Looks good. If you don't mind, I could add this patch to the series with `Suggested-by`
tag since it's neccessary to allow unprotect+retry in case of shadow #PF during
vectoring.

--
Kind regards,
Ivan Orlov

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 07c6f1d5323d..63361b2da450 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9107,6 +9107,10 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
>                 if (r == X86EMUL_RETRY_INSTR || r == X86EMUL_PROPAGATE_FAULT)
>                         return 1;
> 
> +               if (kvm_unprotect_and_retry_on_failure(vcpu, cr2_or_gpa,
> +                                                      emulation_type))
> +                       return 1;
> +
>                 if (r == X86EMUL_UNHANDLEABLE_VECTORING_IO) {
>                         kvm_prepare_event_vectoring_exit(vcpu, cr2_or_gpa);
>                         return 0;
> 

