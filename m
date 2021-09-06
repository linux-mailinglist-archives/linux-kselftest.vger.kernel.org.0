Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18BF0401A7B
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Sep 2021 13:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbhIFLV2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Sep 2021 07:21:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33713 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230284AbhIFLV1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Sep 2021 07:21:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630927222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j7VH8fL3glvum3Nt0WVFPZDDHGKO9yZkd04H/l3akBA=;
        b=Qj05cyGYy6ALDy97812fK3Snt+vbujbdmxBGJd7XaaaCA8G6fIOF1SxIIO12/u2OKbLHXt
        PZLY0pGw+chH+qDO1cyDuIPnNIUouDotKfyRClvQk/8CaWWS1zuSFryL9/9OibLth44nxZ
        w4u1vMESFELlQ1Lqg2V20AzLOK9LcMs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-xJQHHUvpNryUFm_Go1QFGQ-1; Mon, 06 Sep 2021 07:20:21 -0400
X-MC-Unique: xJQHHUvpNryUFm_Go1QFGQ-1
Received: by mail-wm1-f71.google.com with SMTP id w25-20020a1cf6190000b0290252505ddd56so2214648wmc.3
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Sep 2021 04:20:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j7VH8fL3glvum3Nt0WVFPZDDHGKO9yZkd04H/l3akBA=;
        b=OXNJUkoJpveYlYDhCi0olgn3KBDCgh2g845ctLFRviVOQHMKCqq2eIOdJgy03kvgfR
         fgStl1AUiEh9/rUTkTsNvuCnFjNGbDqcpZNDBuYV+V3btFkQZecbkb0iwvKUINDz2Pit
         WvhnOl9ZlTIBxbxvsYmft4OsiuCVrkDSJA5L3ziUuy/bqOj9ja8QSEtnDgYYlQWJddLo
         PDzyeBlNLH9Dj3lzMjM/CCdEqHjIF3EXkrUTwK5JHG2WDBXuWqdtB0VTDifWNbwB+gC3
         cIhRLjxBpA1bfDyZaAPNVuWDlCaIeYNeHvocvzAl/JvWJpu0ohPldqBWUfec/NgLohqc
         sbzQ==
X-Gm-Message-State: AOAM530JcH1As4llK2ICdBiSTUIXG/VcfTMzKp2tiFNIwOEmyv6Qpk8o
        TCzV8QiQZXz+szvLPzgpSp23WuZ+CR+uIzb71nadjahQHogQ4FOnD9awaTVDJppwLxZIfWJrbT2
        QbrZFWKb6D8hHBYoHBnpGf0EVk9Qe
X-Received: by 2002:a1c:9a0e:: with SMTP id c14mr11072631wme.119.1630927220084;
        Mon, 06 Sep 2021 04:20:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxnnpEuWDhXm/HsiMYhbswprAY/0U3Qm9lUNt38ZqMW4d4O9iigvGYH5X6vA70t10AlgvDOaw==
X-Received: by 2002:a1c:9a0e:: with SMTP id c14mr11072600wme.119.1630927219810;
        Mon, 06 Sep 2021 04:20:19 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id m11sm7585194wrz.28.2021.09.06.04.20.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 04:20:19 -0700 (PDT)
Subject: Re: [PATCH v3 6/6] KVM: selftests: test KVM_GUESTDBG_BLOCKIRQ
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Kieran Bingham <kbingham@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Andrew Jones <drjones@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jessica Yu <jeyu@kernel.org>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Yang Weijiang <weijiang.yang@intel.com>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210811122927.900604-1-mlevitsk@redhat.com>
 <20210811122927.900604-7-mlevitsk@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <137f2dcc-75d2-9d71-e259-dd66d43ad377@redhat.com>
Date:   Mon, 6 Sep 2021 13:20:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210811122927.900604-7-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/08/21 14:29, Maxim Levitsky wrote:
> Modify debug_regs test to create a pending interrupt
> and see that it is blocked when single stepping is done
> with KVM_GUESTDBG_BLOCKIRQ
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>   .../testing/selftests/kvm/x86_64/debug_regs.c | 24 ++++++++++++++++---
>   1 file changed, 21 insertions(+), 3 deletions(-)

I haven't looked very much at this, but the test fails.

Paolo

> diff --git a/tools/testing/selftests/kvm/x86_64/debug_regs.c b/tools/testing/selftests/kvm/x86_64/debug_regs.c
> index 6097a8283377..5f078db1bcba 100644
> --- a/tools/testing/selftests/kvm/x86_64/debug_regs.c
> +++ b/tools/testing/selftests/kvm/x86_64/debug_regs.c
> @@ -8,12 +8,15 @@
>   #include <string.h>
>   #include "kvm_util.h"
>   #include "processor.h"
> +#include "apic.h"
>   
>   #define VCPU_ID 0
>   
>   #define DR6_BD		(1 << 13)
>   #define DR7_GD		(1 << 13)
>   
> +#define IRQ_VECTOR 0xAA
> +
>   /* For testing data access debug BP */
>   uint32_t guest_value;
>   
> @@ -21,6 +24,11 @@ extern unsigned char sw_bp, hw_bp, write_data, ss_start, bd_start;
>   
>   static void guest_code(void)
>   {
> +	/* Create a pending interrupt on current vCPU */
> +	x2apic_enable();
> +	x2apic_write_reg(APIC_ICR, APIC_DEST_SELF | APIC_INT_ASSERT |
> +			 APIC_DM_FIXED | IRQ_VECTOR);
> +
>   	/*
>   	 * Software BP tests.
>   	 *
> @@ -38,12 +46,19 @@ static void guest_code(void)
>   		     "mov %%rax,%0;\n\t write_data:"
>   		     : "=m" (guest_value) : : "rax");
>   
> -	/* Single step test, covers 2 basic instructions and 2 emulated */
> +	/*
> +	 * Single step test, covers 2 basic instructions and 2 emulated
> +	 *
> +	 * Enable interrupts during the single stepping to see that
> +	 * pending interrupt we raised is not handled due to KVM_GUESTDBG_BLOCKIRQ
> +	 */
>   	asm volatile("ss_start: "
> +		     "sti\n\t"
>   		     "xor %%eax,%%eax\n\t"
>   		     "cpuid\n\t"
>   		     "movl $0x1a0,%%ecx\n\t"
>   		     "rdmsr\n\t"
> +		     "cli\n\t"
>   		     : : : "eax", "ebx", "ecx", "edx");
>   
>   	/* DR6.BD test */
> @@ -72,11 +87,13 @@ int main(void)
>   	uint64_t cmd;
>   	int i;
>   	/* Instruction lengths starting at ss_start */
> -	int ss_size[4] = {
> +	int ss_size[6] = {
> +		1,		/* sti*/
>   		2,		/* xor */
>   		2,		/* cpuid */
>   		5,		/* mov */
>   		2,		/* rdmsr */
> +		1,		/* cli */
>   	};
>   
>   	if (!kvm_check_cap(KVM_CAP_SET_GUEST_DEBUG)) {
> @@ -154,7 +171,8 @@ int main(void)
>   	for (i = 0; i < (sizeof(ss_size) / sizeof(ss_size[0])); i++) {
>   		target_rip += ss_size[i];
>   		CLEAR_DEBUG();
> -		debug.control = KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_SINGLESTEP;
> +		debug.control = KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_SINGLESTEP |
> +				KVM_GUESTDBG_BLOCKIRQ;
>   		debug.arch.debugreg[7] = 0x00000400;
>   		APPLY_DEBUG();
>   		vcpu_run(vm, VCPU_ID);
> 

