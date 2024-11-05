Return-Path: <linux-kselftest+bounces-21434-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 503A09BC323
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 03:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D47B81F22C2F
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 02:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E4B47A5C;
	Tue,  5 Nov 2024 02:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iAKmoQB7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8400C1CD0C
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Nov 2024 02:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730773363; cv=none; b=DdIgmSH4m+SwIF2DeV3tHMRv3348XxtLHN6zXmIgSlrRJCP9Qqk6Bzbd6IwdP15DhZcnf/keOCmvSe5HBYOsv9gSYDkUXDX3/nKc3HEvZm9prJS4bqrX9pDtHut2tVkh6lO50GKXM7cpBQ+K6ZXZPOHlKb/IxeSSiscAcX6Nur8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730773363; c=relaxed/simple;
	bh=fASZrlOrGSWP18gmYt8bKLkLXj2wDQ1MzYPz3q9daX0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UHIMOWXGdh2MIrZVyaY/B/O5yENix14QI0KADIKObdDCOtcXJCo2BC6elcptr5PtZ9qe7IwzXvY6TqhbS3XoXgPO6O18nrRFkorYF/c67r0UYqat/esU8ECG/USaquosA9lA5QbSNqWuD+q7fIJi0ryVPtz5cMMu70ok9fuGST8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iAKmoQB7; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7edb8c3e743so3357459a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Nov 2024 18:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730773360; x=1731378160; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rTrj4Vb+gjmZyvOereONM4xaExQ9e1t81Zeg65PUba4=;
        b=iAKmoQB71pLTav7c9f1jte4hXpXhoLYra/46jA8BKdnxGvHglOC5M81NOxHFyIAovM
         c6J65z/iZHJO5ta4k+EoRB5e6JsDvkRAZox+K/b7JeaiGcXNT/LeT9yV+MjYEeTuqPd9
         +Hk1rUmsuBH+ogF9a5u/EAyUIUkd/FedM/oxeuj53T84f6RZ4rRD06vkfMm3S7T4h2ff
         L22bJoHwqM3viX3/34rIz35z5wqOPR5dfRSkZBlt3w11TdGImoVk7Inp9B+6KnzuGKc3
         eqb/AZ2jG/KGOWftp40HLfBdO1icyzxMubQrKX1U4qCdH6YMuSagxgA71KqgSGB9ct7q
         8SwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730773360; x=1731378160;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rTrj4Vb+gjmZyvOereONM4xaExQ9e1t81Zeg65PUba4=;
        b=BjX0ezQwiICjkiJVZki+X5g51zdwwzIMQfdRS6dmR7Tn97dWCdzfv9T8dLad/vEs70
         wHdiujzTdsLgSc7rZkNLMQHddM+u5vaXNGvONvw9yIjBx5mcZJpwY571senlrc4aGksE
         oTT9o8Gn5owodksioWHbuB5rgISkGnhz2a5k5qs04I42goXYFNzTJLCHHJEQACG2Mob3
         qBJZQUtQDDio2fegn8Ca7BDI0Hao6YzrPcKol55R9Al6nvCu22yo560HvErAA7zGf9WE
         zXkAOLP8+K3ip2DhYpkkJBl6Hr9c0WosdO6IGzTeCzSq4l4mydMlzh8GrasL96RB+wNO
         H9mg==
X-Forwarded-Encrypted: i=1; AJvYcCWKVnBf/Nay+5NZk8W0akis+uSI9HWZR691UBC0ZgPAV0bBEBtxMTCFQ9IRqXtYZxS89cnf7J/TUunU+42AxAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YymwDjAAtpnEOZeSEwQPFJ18DKqFMKWQtypR7Aij/tiSTpks0Cn
	9SUb6hKGE5Vr6qO8jN6/7vlCnshjwsfnlmtAFPihL0J/Mac7P3lsQjwgk6xQN3aN1NcqXFt4zoN
	xlg==
X-Google-Smtp-Source: AGHT+IH0unGMBQfLgioqGmr0yzEMUoopms0yCwfTp21z4CVHah4e9K57FkA7ZEnCFrqk1qMnNAGjr3IC698=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:6a02:4d07:b0:7ea:97c3:7a8f with SMTP id
 41be03b00d2f7-7ee3a90d751mr34651a12.10.1730773359794; Mon, 04 Nov 2024
 18:22:39 -0800 (PST)
Date: Mon, 4 Nov 2024 18:22:38 -0800
In-Reply-To: <74089281-3208-435d-93b3-22f1d794dfae@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241004053341.5726-1-manali.shukla@amd.com> <20241004053341.5726-3-manali.shukla@amd.com>
 <Zw6rJ3y_F-10xBcH@google.com> <74089281-3208-435d-93b3-22f1d794dfae@amd.com>
Message-ID: <ZymBbk829lGCY8dp@google.com>
Subject: Re: [PATCH v3 2/4] KVM: SVM: Enable Bus lock threshold exit
From: Sean Christopherson <seanjc@google.com>
To: Manali Shukla <manali.shukla@amd.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, pbonzini@redhat.com, 
	shuah@kernel.org, nikunj@amd.com, thomas.lendacky@amd.com, 
	vkuznets@redhat.com, bp@alien8.de, babu.moger@amd.com, 
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Sun, Nov 03, 2024, Manali Shukla wrote:
> On 10/15/2024 11:19 PM, Sean Christopherson wrote:
> > On Fri, Oct 04, 2024, Manali Shukla wrote:
> ...
> >>  
> >> +static int bus_lock_exit(struct kvm_vcpu *vcpu)
> >> +{
> >> +	struct vcpu_svm *svm = to_svm(vcpu);
> >> +
> >> +	vcpu->run->exit_reason = KVM_EXIT_X86_BUS_LOCK;
> >> +	vcpu->run->flags |= KVM_RUN_X86_BUS_LOCK;
> >> +
> >> +	/*
> >> +	 * Reload the counter with value greater than '0'.
> > 
> > The value quite obviously must be exactly '1', not simply greater than '0.  I also
> > think this is the wrong place to set the counter.  Rather than set the counter at
> > the time of exit, KVM should implement a vcpu->arch.complete_userspace_io callback
> > and set the counter to '1' if and only if RIP (or LIP, but I have no objection to
> > keeping things simple) is unchanged.  It's a bit of extra complexity, but it will
> > make it super obvious why KVM is setting the counter to '1'.  And, if userspace
> > wants to stuff state and move past the instruction, e.g. by emulating the guilty
> > instruction, then KVM won't unnecessarily allow a bus lock in the guest.
> > 
> > And then the comment can be:
> > 
> > 	/*
> > 	 * If userspace has NOT change RIP, then KVM's ABI is to let the guest
> > 	 * execute the bus-locking instruction.  Set the bus lock counter to '1'
> > 	 * to effectively step past the bus lock.
> > 	 */
> > 
> 
> The bus lock threshold intercept feature is available for SEV-ES and SEV-SNP
> guests too. The rip where the bus lock exit occurred, is not available in
> bus_lock_exit handler for SEV-ES and SEV-SNP guests, so the above-mentioned
> solution won't work with SEV-ES and SEV-SNP guests.
> 
> I would propose to add the above-mentioned solution only for normal and SEV guests
> and unconditionally reloading of bus_lock_counter to 1 in complete_userspace_io
> for SEV-ES and SEV-SNP guests.

Yeah, that works.  Though I would condition the check on guest_state_protected.
Actually, and this is going to seem really stupid, but everything will Just Work
if you use kvm_get_linear_rip() and kvm_is_linear_rip(), because kvm_get_linear_rip()
returns '0' for vCPUs with protected state.  I.e. KVM will do a rather superfluous
cui() callback, but otherwise it's fine.  Silly, but in many ways preferable to
special casing ES and SNP guests.

On a related topic, can you add a refacotring prep patch to move linear_rip out
of kvm_pio_request and place it next to complete_userspace_io?  There's nothing
port I/O specific about that field, it just so happens to that port I/O is the
only case where KVM's ABI is to let userspace stuff state (to emulate RESET)
without first completing the I/O instruction.

I.e.

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 8e8ca6dab2b2..8617b15096a6 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -406,7 +406,6 @@ struct kvm_rmap_head {
 };
 
 struct kvm_pio_request {
-       unsigned long linear_rip;
        unsigned long count;
        int in;
        int port;
@@ -884,6 +883,7 @@ struct kvm_vcpu_arch {
        bool emulate_regs_need_sync_to_vcpu;
        bool emulate_regs_need_sync_from_vcpu;
        int (*complete_userspace_io)(struct kvm_vcpu *vcpu);
+       unsigned long cui_linear_rip;
 
        gpa_t time;
        struct pvclock_vcpu_time_info hv_clock;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 425a301911a6..7704d3901481 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9308,7 +9308,7 @@ static int complete_fast_pio_out(struct kvm_vcpu *vcpu)
 {
        vcpu->arch.pio.count = 0;
 
-       if (unlikely(!kvm_is_linear_rip(vcpu, vcpu->arch.pio.linear_rip)))
+       if (unlikely(!kvm_is_linear_rip(vcpu, vcpu->arch.cui_linear_rip)))
                return 1;
 
        return kvm_skip_emulated_instruction(vcpu);
@@ -9333,7 +9333,7 @@ static int kvm_fast_pio_out(struct kvm_vcpu *vcpu, int size,
                        complete_fast_pio_out_port_0x7e;
                kvm_skip_emulated_instruction(vcpu);
        } else {
-               vcpu->arch.pio.linear_rip = kvm_get_linear_rip(vcpu);
+               vcpu->arch.cui_linear_rip = kvm_get_linear_rip(vcpu);
                vcpu->arch.complete_userspace_io = complete_fast_pio_out;
        }
        return 0;
@@ -9346,7 +9346,7 @@ static int complete_fast_pio_in(struct kvm_vcpu *vcpu)
        /* We should only ever be called with arch.pio.count equal to 1 */
        BUG_ON(vcpu->arch.pio.count != 1);
 
-       if (unlikely(!kvm_is_linear_rip(vcpu, vcpu->arch.pio.linear_rip))) {
+       if (unlikely(!kvm_is_linear_rip(vcpu, vcpu->arch.cui_linear_rip))) {
                vcpu->arch.pio.count = 0;
                return 1;
        }
@@ -9375,7 +9375,7 @@ static int kvm_fast_pio_in(struct kvm_vcpu *vcpu, int size,
                return ret;
        }
 
-       vcpu->arch.pio.linear_rip = kvm_get_linear_rip(vcpu);
+       vcpu->arch.cui_linear_rip = kvm_get_linear_rip(vcpu);
        vcpu->arch.complete_userspace_io = complete_fast_pio_in;
 
        return 0;

