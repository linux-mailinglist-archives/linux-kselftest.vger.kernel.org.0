Return-Path: <linux-kselftest+bounces-21965-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC6C9C7B48
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 19:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2970B36378
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 18:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8564A205E25;
	Wed, 13 Nov 2024 18:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dWr5Tj6B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91425205E15
	for <linux-kselftest@vger.kernel.org>; Wed, 13 Nov 2024 17:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731520801; cv=none; b=t6+JbFgvlZyW4BYUdD6t1Mibl5FkFsZzC5kgvN92vwcAdt9z3chAcP+X0PN7qtKpTFHJ0r7CUgkzA7rKzov4TwGzYIWpVbzjoIJV97HbLYhO3wAV7eahO5/kBPK51Fi8Ap9WPW4K0bs90+Zc1p1TbgLi+sot96AjMycLJ8LKP5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731520801; c=relaxed/simple;
	bh=pKjj2+Cv5RVya63su3M8gauw10wpOz6WwG+RdfrjUP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DZJW+1WQ57QbgaGZV9KiCGq61DBBSL5fXIgQMNIR3rPpHGUOstDfPQwJOXKzRCqcFqyM2erEJd7EWhi2nRHq86sC4i3IMCdItRuUPs6AVw5bty2B/9vh80hcYOQtb+v3scn0+NY1CMFbHOKBnQlI5B0ONkdUE8ZJIibKkYyjK1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dWr5Tj6B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731520798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dblJkbxFu+E1XmXn1xUYxXtUULG/yL/Mmf7WkR1K4ew=;
	b=dWr5Tj6BkmbO7SPqOnwkMQV/Tiw0EbCDOUmv5Tjc8wMWIpfnY7vfIFeirqRtZp+oozsLG9
	cWfZjJmRjXyvpMXhSWxOGDPZWmbBq45cNeCjfesvABMjUAH7nv437fLNg794YwTsBtWHSp
	gDKlrnBvEm4cAQxSbUJPsr4Dkc253nc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-PWActc6bOoSV1Bzyya9J4g-1; Wed, 13 Nov 2024 12:59:57 -0500
X-MC-Unique: PWActc6bOoSV1Bzyya9J4g-1
X-Mimecast-MFC-AGG-ID: PWActc6bOoSV1Bzyya9J4g
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4316300bb15so49506775e9.2
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Nov 2024 09:59:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731520796; x=1732125596;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dblJkbxFu+E1XmXn1xUYxXtUULG/yL/Mmf7WkR1K4ew=;
        b=mih63sphUZzjXWEyaxX6PaVaQY/jwzgwrvLt05k6UufNTAfabFGvRsoOodvnwkbUDh
         WnZdJCoRvvQWdhg7PhBbRr55wglEe7ZUgbLAcNzAEtwnc4SG/TDkiEwHRHS6XnrNU5OD
         5F4rLDD9GnU90+ZKSCYdiJGncZ8dnWakN0K8CkQrxcsEbXKRaeMwv8j8CrVzfzbjyiCS
         T3x1e8xAJ+ha2N1j4BvHLLDLDA9jL3Ai+GP3CTW/T7PNTQ95cloO04Vr2SK8j6VHYa3y
         a36GOBsakjcfv6dJ2aRljm47SjC3jF2vjess3cW53fUPgyUgmhIDa8ZbdHqJcGOtJ6kY
         yqPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSuxuyLn8REzbx3rlnN1w6hj0g10Qlkv9E3KQ4B+qitLfK73gi+U0Kz76P3csMT41oQz5Fp6Hf7REmNAe43z0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH6l4xNmcFIYnHxkDfaCIJOeSA7BJkHDSF/qkaNE1PvhEJ5icH
	wutkZ50GZsO9x2DjIJHSi/w7+4+nb6GeVYIQHVJJjHMcSid7Mxe98bsJkF21JDkdsiFHu/Mk8Zj
	OsRjYO+rZ2jRC/p9xY/QxPGrjrd3qWCC0vx+ZlYGzaTVgk63PW5CPLycQw/l2nEiE2g==
X-Received: by 2002:a05:600c:1e89:b0:426:60b8:d8ba with SMTP id 5b1f17b1804b1-432b751dc3cmr162297345e9.28.1731520796105;
        Wed, 13 Nov 2024 09:59:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmAdVNv4lE+G0uFJYG3tpSf03OwGRFjpW25aIwlVpY7CYnWL5GPLCuFsbc38AS7YrClVheUA==
X-Received: by 2002:a05:600c:1e89:b0:426:60b8:d8ba with SMTP id 5b1f17b1804b1-432b751dc3cmr162297245e9.28.1731520795740;
        Wed, 13 Nov 2024 09:59:55 -0800 (PST)
Received: from [192.168.10.47] ([151.49.84.243])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-432d550412csm31975525e9.19.2024.11.13.09.59.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 09:59:54 -0800 (PST)
Message-ID: <b1ddb439-9e28-4a58-ba86-0395bfc081e0@redhat.com>
Date: Wed, 13 Nov 2024 18:59:53 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] KVM: x86: Add support for VMware guest specific
 hypercalls
To: Doug Covelli <doug.covelli@broadcom.com>
Cc: Zack Rusin <zack.rusin@broadcom.com>,
 Sean Christopherson <seanjc@google.com>, kvm <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 the arch/x86 maintainers <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Shuah Khan <shuah@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>, Joel Stanley <joel@jms.id.au>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 "Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>,
 linux-kselftest <linux-kselftest@vger.kernel.org>
References: <20241030033514.1728937-1-zack.rusin@broadcom.com>
 <20241030033514.1728937-3-zack.rusin@broadcom.com>
 <CABgObfaRP6zKNhrO8_atGDLcHs=uvE0aT8cPKnt_vNHHM+8Nxg@mail.gmail.com>
 <CABQX2QMR=Nsn23zojFdhemR7tvGUz6_UM8Rgf6WLsxwDqoFtxg@mail.gmail.com>
 <Zy0__5YB9F5d0eZn@google.com>
 <CABQX2QNxFDhH1frsGpSQjSs3AWSdTibkxPrjq1QC7FGZC8Go-Q@mail.gmail.com>
 <e3f943a7-a40a-45cb-b0d9-e3ed58344d8b@redhat.com>
 <CADH9ctD1uf_yBA3NXNQu7TJa_TPhLRN=0YZ3j2gGhgmaFRdCFg@mail.gmail.com>
 <c3026876-8061-4ab2-9321-97cc05bad510@redhat.com>
 <CADH9ctBivnvP1tNcatLKzd8EDz8Oo6X65660j8ccxYzk3aFzCA@mail.gmail.com>
 <CABgObfZEyCQMiq6CKBOE7pAVzUDkWjqT2cgfbwjW-RseH8VkLw@mail.gmail.com>
 <CADH9ctA_C1dAOus1K+wOH_SOKTb=-X1sVawt5R=dkH1iGt8QUg@mail.gmail.com>
 <CABgObfZrTyft-3vqMz5w0ZiAhp-v6c32brgftynZGJO8OafrdA@mail.gmail.com>
 <CADH9ctBYp-LMbW4hm3+QwNoXvAc5ryVeB0L1jLY0uDWSe3vbag@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CADH9ctBYp-LMbW4hm3+QwNoXvAc5ryVeB0L1jLY0uDWSe3vbag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/24 17:24, Doug Covelli wrote:
>> No worries, you're not hijacking :) The only reason is that it would
>> be more code for a seldom used feature and anyway with worse performance.
>> (To be clear, CR8 based accesses are allowed, but stores cause an exit
>> in order to check the new TPR against IRR. That's because KVM's API
>> does not have an equivalent of the TPR threshold as you point out below).
> 
> I have not really looked at the code but it seems like it could also
> simplify things as CR8 would be handled more uniformly regardless of
> who is virtualizing the local APIC.

Not much because CR8 basically does not exist at all (it's just a byte
in memory) with userspace APIC.  So it's not easy to make it simpler, even
though it's less uniform.

That said, there is an optimization: you only get KVM_EXIT_SET_TPR if
CR8 decreases.

>>> Also I could not find these documented anywhere but with MSFT's APIC our monitor
>>> relies on extensions for trapping certain events such as INIT/SIPI plus LINT0
>>> and SVR writes:
>>>
>>> UINT64 X64ApicInitSipiExitTrap    : 1; // WHvRunVpExitReasonX64ApicInitSipiTrap
>>> UINT64 X64ApicWriteLint0ExitTrap  : 1; // WHvRunVpExitReasonX64ApicWriteTrap
>>> UINT64 X64ApicWriteLint1ExitTrap  : 1; // WHvRunVpExitReasonX64ApicWriteTrap
>>> UINT64 X64ApicWriteSvrExitTrap    : 1; // WHvRunVpExitReasonX64ApicWriteTrap
>>
>> There's no need for this in KVM's in-kernel APIC model. INIT and
>> SIPI are handled in the hypervisor and you can get the current
>> state of APs via KVM_GET_MPSTATE. LINT0 and LINT1 are injected
>> with KVM_INTERRUPT and KVM_NMI respectively, and they obey IF/PPR
>> and NMI blocking respectively, plus the interrupt shadow; so
>> there's no need for userspace to know when LINT0/LINT1 themselves
>> change. The spurious interrupt vector register is also handled
>> completely in kernel.
> 
> I realize that KVM can handle LINT0/SVR updates themselves but our
> interrupt subsystem relies on knowing the current values of these
> registers even when not virtualizing the local APIC.  I suppose we
> could use KVM_GET_LAPIC to sync things up on demand but that seems
> like it might nor be great from a performance point of view.

Ah no, you're right---you want to track the CPU that has ExtINT enabled
and send KVM_INTERRUPT to that one, I guess?  And you need the spurious
vector registers because writes can set the mask bit in LINTx, but
essentially you want to trap LINT0 changes.

Something like this (missing the KVM_ENABLE_CAP and KVM_CHECK_EXTENSION
code) is good, feel free to include it in your v2 (Co-developed-by
and Signed-off-by me):

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 5fb29ca3263b..b7dd89c99613 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -122,6 +122,7 @@
  #define KVM_REQ_HV_TLB_FLUSH \
  	KVM_ARCH_REQ_FLAGS(32, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
  #define KVM_REQ_UPDATE_PROTECTED_GUEST_STATE	KVM_ARCH_REQ(34)
+#define KVM_REQ_REPORT_LINT0_ACCESS	KVM_ARCH_REQ(35)
  
  #define CR0_RESERVED_BITS                                               \
  	(~(unsigned long)(X86_CR0_PE | X86_CR0_MP | X86_CR0_EM | X86_CR0_TS \
@@ -775,6 +776,7 @@ struct kvm_vcpu_arch {
  	u64 smi_count;
  	bool at_instruction_boundary;
  	bool tpr_access_reporting;
+	bool lint0_access_reporting;
  	bool xfd_no_write_intercept;
  	u64 ia32_xss;
  	u64 microcode_version;
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 88dc43660d23..0e070f447aa2 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1561,6 +1561,21 @@ static u32 apic_get_tmcct(struct kvm_lapic *apic)
  			      apic->divide_count));
  }
  
+static void __report_lint0_access(struct kvm_lapic *apic, u32 value)
+{
+	struct kvm_vcpu *vcpu = apic->vcpu;
+	struct kvm_run *run = vcpu->run;
+
+	kvm_make_request(KVM_REQ_REPORT_LINT0_ACCESS, vcpu);
+	run->lint0_access.value = value;
+}
+
+static inline void report_lint0_access(struct kvm_lapic *apic, u32 value)
+{
+	if (apic->vcpu->arch.lint0_access_reporting)
+		__report_lint0_access(apic, value);
+}
+
  static void __report_tpr_access(struct kvm_lapic *apic, bool write)
  {
  	struct kvm_vcpu *vcpu = apic->vcpu;
@@ -2312,8 +2327,10 @@ static int kvm_lapic_reg_write(struct kvm_lapic *apic, u32 reg, u32 val)
  			int i;
  
  			for (i = 0; i < apic->nr_lvt_entries; i++) {
-				kvm_lapic_set_reg(apic, APIC_LVTx(i),
-					kvm_lapic_get_reg(apic, APIC_LVTx(i)) | APIC_LVT_MASKED);
+				u32 old = kvm_lapic_get_reg(apic, APIC_LVTx(i));
+				kvm_lapic_set_reg(apic, APIC_LVTx(i), old | APIC_LVT_MASKED);
+				if (i == 0 && !(old & APIC_LVT_MASKED))
+					report_lint0_access(apic, old | APIC_LVT_MASKED);
  			}
  			apic_update_lvtt(apic);
  			atomic_set(&apic->lapic_timer.pending, 0);
@@ -2352,6 +2369,8 @@ static int kvm_lapic_reg_write(struct kvm_lapic *apic, u32 reg, u32 val)
  		if (!kvm_apic_sw_enabled(apic))
  			val |= APIC_LVT_MASKED;
  		val &= apic_lvt_mask[index];
+		if (index == 0 && val != kvm_lapic_get_reg(apic, reg))
+			report_lint0_access(apic, val);
  		kvm_lapic_set_reg(apic, reg, val);
  		break;
  	}
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d0d3dc3b7ef6..2b039b372c3f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10879,6 +10879,11 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
  			kvm_vcpu_flush_tlb_guest(vcpu);
  #endif
  
+		if (kvm_check_request(KVM_REQ_REPORT_LINT0_ACCESS, vcpu)) {
+			vcpu->run->exit_reason = KVM_EXIT_LINT0_ACCESS;
+			r = 0;
+			goto out;
+		}
  		if (kvm_check_request(KVM_REQ_REPORT_TPR_ACCESS, vcpu)) {
  			vcpu->run->exit_reason = KVM_EXIT_TPR_ACCESS;
  			r = 0;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 637efc055145..ec97727f9de4 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -178,6 +178,7 @@ struct kvm_xen_exit {
  #define KVM_EXIT_NOTIFY           37
  #define KVM_EXIT_LOONGARCH_IOCSR  38
  #define KVM_EXIT_MEMORY_FAULT     39
+#define KVM_EXIT_LINT0_ACCESS     40
  
  /* For KVM_EXIT_INTERNAL_ERROR */
  /* Emulate instruction failed. */
@@ -283,6 +284,10 @@ struct kvm_run {
  				__u64 flags;
  			};
  		} hypercall;
+		/* KVM_EXIT_LINT0_ACCESS */
+		struct {
+			__u32 value;
+		} lint0_access;
  		/* KVM_EXIT_TPR_ACCESS */
  		struct {
  			__u64 rip;


For LINT1, it should be less performance critical; if it's possible
to just go through all vCPUs, and do KVM_GET_LAPIC to check who you
should send a KVM_NMI to, then I'd do that.  I'd also accept a patch
that adds a VM-wide KVM_NMI ioctl that does the same in the hypervisor
if it's useful for you.

And since I've been proven wrong already, what do you need INIT/SIPI for?

Paolo


