Return-Path: <linux-kselftest+bounces-23268-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C47429EF2A6
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 17:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81C65291D31
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 16:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C602322541E;
	Thu, 12 Dec 2024 16:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="JL7oDRZ/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66472F44;
	Thu, 12 Dec 2024 16:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734021703; cv=none; b=qb2ceavmwiN+bHR15WCQT8WMNJU3vB8pvCWpGSlfi8PDoyfgSgxl7kbcoJfKpFfRC7a44SkEUt2Al5f/sJHLfMeNE4y5Ic7iUm0eb3rmofEA+bmYEl56MIa/mA5kgsaTMFom3jckYVRf+9YB5Sy5tt5kSHUhlDKhQYeIRO3zMqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734021703; c=relaxed/simple;
	bh=qxTujLFmvDRRf9nMjsxWVIb0FdvxT3pr/t7WazM7ag4=;
	h=Subject:Date:From:To:CC:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AID5hJpNl6fcWX03aPdWEPNnWKINHxyOzmCkOYBqO1m6DSxFz3Nue+GHuqg268rPNAzzyeC/JWCJEgY7FvpWOuqiqvtm72XthlvkJQs/ZgnEIBM0BYPT1p8TidAZc6elYP4cQ+MziMQ8SzOxEn0VzSQhAQl0qCbDlDgTii5di7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=JL7oDRZ/; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1734021702; x=1765557702;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject;
  bh=9s34Z4x2hQgQrTZeexBeEc6mgPAK+N+ETguazXEwacg=;
  b=JL7oDRZ/r4HWtWpKGHX80PAePf92/v8ROm36qkrKTp8vvAKQAaNVI2/j
   zYukngBM7Bk8CtzU8CFVBDgCu5ZUapEJ0Iom16DQpLnmIKb0rx0kUEgNQ
   z0OsXCWEkCi5IwTI08Jo0BjAL5tPcv5XkB4YfwDaiU1e/FtuASJJzrYKF
   U=;
X-IronPort-AV: E=Sophos;i="6.12,229,1728950400"; 
   d="scan'208";a="155366538"
Subject: Re: [PATCH v2 3/6] KVM: VMX: Handle vectoring error in
 check_emulate_instruction
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 16:41:39 +0000
Received: from EX19MTAUEA001.ant.amazon.com [10.0.44.209:54057]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.51.155:2525] with esmtp (Farcaster)
 id 66d2dafb-b30a-4fa1-86bb-4bdc329912f2; Thu, 12 Dec 2024 16:41:39 +0000 (UTC)
X-Farcaster-Flow-ID: 66d2dafb-b30a-4fa1-86bb-4bdc329912f2
Received: from EX19D008UEC003.ant.amazon.com (10.252.135.194) by
 EX19MTAUEA001.ant.amazon.com (10.252.134.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 12 Dec 2024 16:41:38 +0000
Received: from EX19MTAUWB001.ant.amazon.com (10.250.64.248) by
 EX19D008UEC003.ant.amazon.com (10.252.135.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 12 Dec 2024 16:41:38 +0000
Received: from email-imr-corp-prod-pdx-all-2c-d1311ce8.us-west-2.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.254) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Thu, 12 Dec 2024 16:41:38 +0000
Received: from dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com (dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com [10.253.74.38])
	by email-imr-corp-prod-pdx-all-2c-d1311ce8.us-west-2.amazon.com (Postfix) with ESMTP id 422264029E;
	Thu, 12 Dec 2024 16:41:38 +0000 (UTC)
Received: by dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com (Postfix, from userid 29210185)
	id C94286224; Thu, 12 Dec 2024 16:41:37 +0000 (UTC)
Date: Thu, 12 Dec 2024 16:41:37 +0000
From: Ivan Orlov <iorlov@amazon.com>
To: Sean Christopherson <seanjc@google.com>
CC: Ivan Orlov <ivan.orlov0322@gmail.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <mingo@redhat.com>, <pbonzini@redhat.com>,
	<shuah@kernel.org>, <tglx@linutronix.de>, <hpa@zytor.com>,
	<kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <x86@kernel.org>, <pdurrant@amazon.co.uk>,
	<dwmw@amazon.co.uk>
Message-ID: <20241212164137.GA71156@dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com>
References: <20241111102749.82761-1-iorlov@amazon.com>
 <20241111102749.82761-4-iorlov@amazon.com>
 <Z1nWykQ3e4D5e2C-@google.com>
 <2b75550c-0dc7-4bcc-ac60-9ad4402c17f8@gmail.com>
 <Z1o1013dUex8w9hK@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z1o1013dUex8w9hK@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Dec 11, 2024 at 05:01:07PM -0800, Sean Christopherson wrote:
> > Hm, by the way, what is the desired behaviour if EMULTYPE_ALLOW_RETRY_PF is
> > set? Is it correct that we return an internal error if it is set during
> > vectoring? Or KVM may try to unprotect the page and re-execute?
> 
> Heh, it's sneaky, but EMULTYPE_ALLOW_RETRY_PF can be set if and only if
> RET_PF_WRITE_PROTECTED is set.  Hmm, that makes me think we should do the below
> (EMULTYPE_WRITE_PF_TO_SP was a recent addition).
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 2e713480933a..de5f6985d123 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9077,7 +9077,7 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
> 
>         if ((emulation_type & EMULTYPE_ALLOW_RETRY_PF) &&
>             (WARN_ON_ONCE(is_guest_mode(vcpu)) ||
> -            WARN_ON_ONCE(!(emulation_type & EMULTYPE_PF))))
> +            WARN_ON_ONCE(!(emulation_type & EMULTYPE_WRITE_PF_TO_SP))))
>                 emulation_type &= ~EMULTYPE_ALLOW_RETRY_PF;
> 

What if we are handling a write to write-protected page, but not a write to
the page table? We still can retry after unprotecting the page, so
EMULTYPE_ALLOW_RETRY_PF should be enabled, right?

>         r = kvm_check_emulate_insn(vcpu, emulation_type, insn, insn_len);
> 
> That said, let me get back to you on this when my brain is less tired.  I'm not
> sure emulating when an exit occurred during event delivery is _ever_ correct.
> 

I believe we can re-execute the instruction if exit happened during vectoring
due to exception (and if the address is not MMIO, e.g. when it's a write to
write-protected page, for instance when stack points to it).

KVM unprotects the page, executes the instruction one more time and
(probably) gets this exception once again (but the page is already
unprotected, so vectoring succeeds without vmexit). If not
(e.g. exception conditions are not met anymore), guest shouldn't really
care and it can continue execution.

However, I'm not sure what happens if vectoring is caused by external
interrupt: if we unprotect the page and re-execute the instruction,
will IRQ be delivered nonetheless, or it will be lost as irq is
already in ISR? Do we need to re-inject it in such a case?

--
Kind regards,
Ivan Orlov

