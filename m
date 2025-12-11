Return-Path: <linux-kselftest+bounces-47413-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEACCB600E
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 14:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0295F3014DA5
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 13:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1D43128BF;
	Thu, 11 Dec 2025 13:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="ScsMBP9W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out198-11.us.a.mail.aliyun.com (out198-11.us.a.mail.aliyun.com [47.90.198.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F01A3093C7;
	Thu, 11 Dec 2025 13:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765459297; cv=none; b=aOUb1jbahpAQ7ukpdVvUQutfdWmo1Ovl9bLGHcQrxkP+o1brdRPDFLTN16qpqpuifiDJOHBZVdXlHHNdkDBBmDYLJs+7JbeiaGWf4W3TA7FeUGrViEXCFjMCgU42OP7uNuBl0F0pODlGOSkmpyrKGpdiJX295AK0xM+rK6KLzG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765459297; c=relaxed/simple;
	bh=lRedtGdX4oCKhlRiAdGUm00EDRog+3H1AUISYTZhVzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZzTIQcMK4TbyueewyUNLGkijYMjeXAECvMeGGU6aZQNBY+yKKFX4Ul+qabzeEzvFXeiYqIgm2pZlYRVrzA7Obz6hrIuFo3Jc1lcFq4f7/50BULoApQPiBiQk5aMrvDLDIAhaK8hCRjNIgQi7GCS+P5cevub+55H/sGQ/PlelVXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=ScsMBP9W; arc=none smtp.client-ip=47.90.198.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1765459274; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=gG6kBFbKarBbNXFT04fWyvoXcVfKMmK5lJ3VuYLbu5o=;
	b=ScsMBP9Wg9KiOl9qoHhHc8AUauYKFwXKtglW6dEHo/Hpzctk+v6nVvF94xDwGjAoV5DK8PAaUKdU+uGJ672lDVpzhtA/y/ExHfTQ/ZWOrTqWoeiRcr6oMSnNCvxJ54TWg3ctb7PbUS5izxrAdlmvVBh3Jiq1rTl1husy+xTaz4k=
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.fi26fM-_1765459273 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 11 Dec 2025 21:21:13 +0800
Date: Thu, 11 Dec 2025 21:21:13 +0800
From: Hou Wenlong <houwenlong.hwl@antgroup.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] KVM: selftests: Verify 'BS' bit checking in pending
 debug exception during VM entry
Message-ID: <20251211132113.GA42509@k08j02272.eu95sqa>
References: <cover.1757416809.git.houwenlong.hwl@antgroup.com>
 <3c0686934fc33ebb484aa5cc71443a22504df7ca.1757416809.git.houwenlong.hwl@antgroup.com>
 <aTMjLkW2h_FWjfxe@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTMjLkW2h_FWjfxe@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, Dec 05, 2025 at 10:23:42AM -0800, Sean Christopherson wrote:
> On Wed, Sep 10, 2025, Hou Wenlong wrote:
> >  #define IRQ_VECTOR 0xAA
> >  
> > +#define  CAST_TO_RIP(v)  ((unsigned long long)&(v))
> > +
> >  /* For testing data access debug BP */
> >  uint32_t guest_value;
> >  
> >  extern unsigned char sw_bp, hw_bp, write_data, ss_start, bd_start;
> > -extern unsigned char fep_bd_start;
> > +extern unsigned char fep_bd_start, fep_sti_start, fep_sti_end;
> > +
> > +static void guest_db_handler(struct ex_regs *regs)
> > +{
> > +	static int count;
> > +	unsigned long target_rips[2] = {
> > +		CAST_TO_RIP(fep_sti_start),
> > +		CAST_TO_RIP(fep_sti_end),
> > +	};
> > +
> > +	__GUEST_ASSERT(regs->rip == target_rips[count], "STI: unexpected rip 0x%lx (should be 0x%lx)",
> > +		       regs->rip, target_rips[count]);
> > +	regs->rflags &= ~X86_EFLAGS_TF;
> > +	count++;
> > +}
> > +
> > +static void guest_irq_handler(struct ex_regs *regs)
> > +{
> > +}
> >  
> >  static void guest_code(void)
> >  {
> > @@ -69,13 +89,25 @@ static void guest_code(void)
> >  	if (is_forced_emulation_enabled) {
> >  		/* DR6.BD test for emulation */
> >  		asm volatile(KVM_FEP "fep_bd_start: mov %%dr0, %%rax" : : : "rax");
> > +
> > +		/* pending debug exceptions for emulation */
> > +		asm volatile("pushf\n\t"
> > +			     "orq $" __stringify(X86_EFLAGS_TF) ", (%rsp)\n\t"
> > +			     "popf\n\t"
> > +			     "sti\n\t"
> > +			     "fep_sti_start:"
> > +			     "cli\n\t"
> > +			     "pushf\n\t"
> > +			     "orq $" __stringify(X86_EFLAGS_TF) ", (%rsp)\n\t"
> > +			     "popf\n\t"
> > +			     KVM_FEP "sti\n\t"
> > +			     "fep_sti_end:"
> > +			     "cli\n\t");
> >  	}
> >  
> >  	GUEST_DONE();
> >  }
> >  
> > -#define  CAST_TO_RIP(v)  ((unsigned long long)&(v))
> > -
> >  static void vcpu_skip_insn(struct kvm_vcpu *vcpu, int insn_len)
> >  {
> >  	struct kvm_regs regs;
> > @@ -110,6 +142,9 @@ int main(void)
> >  	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
> >  	run = vcpu->run;
> >  
> > +	vm_install_exception_handler(vm, DB_VECTOR, guest_db_handler);
> > +	vm_install_exception_handler(vm, IRQ_VECTOR, guest_irq_handler);
> 
> But the IRQ should never be taken thanks to the CLI in the STI shadow.  I.e.
> installing a dummy handler could mask failures, no?
>
Yes, this also breaks the testcase regarding KVM_GUESTDBG_BLOCKIRQ.
Sorry, I forgot why I added this, as you said there should be no IRQ
delivered due to the STI shadow. :(
I'll remove it in the next version.
 
Thanks!

> > +
> >  	/* Test software BPs - int3 */
> >  	memset(&debug, 0, sizeof(debug));
> >  	debug.control = KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_USE_SW_BP;
> > -- 
> > 2.31.1
> > 

