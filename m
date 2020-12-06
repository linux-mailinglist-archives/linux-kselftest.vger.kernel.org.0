Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2AD2D05E4
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Dec 2020 17:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgLFQT7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 6 Dec 2020 11:19:59 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58806 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgLFQT6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 6 Dec 2020 11:19:58 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607271556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6FbgwqR8cwx7EiM6FSCm/Hsw2IrEwAZDzoC3Of2D+NM=;
        b=AMz9My6hb4QDemn9K++Vs98nvP7FMGhxiDgoliw4OGCYQsN4AelRWDtTpvHLHfycGZLdkq
        lN2D+Rik2oiLYeRdq7oQbj6FeQt5C6GgN/ctLS7OurkWyvZZM9TQDysqxgpACcJCwiNKj9
        pDoCHie/GHDWiyeGgkAKCjCc4YTlncKuOXCzJXpFNMbcleEhwL+8PA6MREdrMERpT4a2d6
        OPzyx5pOnVWYX6Xj6X6GKwr48KMbXrQOv+xzh822r86kkdjpNbCHR+shy6UnnUuHtLJjLv
        d6E0LRcfDyi0J41Y3LZl+2qLY/LOYzMR3a8oNbvB8thi0Zgk8U8OfGBhoqrbGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607271556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6FbgwqR8cwx7EiM6FSCm/Hsw2IrEwAZDzoC3Of2D+NM=;
        b=Q1r5sG2dmTxR8OVLAifO4qaayPqOe82xtw00JIX+Twp9heSkYjiWB0fmhDdZsNTxJb3AA+
        fhG1ko9MCJ+5w2BQ==
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "open list\:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer\:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Shuah Khan <shuah@kernel.org>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Oliver Upton <oupton@google.com>,
        "open list\:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] KVM: x86: implement KVM_{GET|SET}_TSC_STATE
In-Reply-To: <20201203171118.372391-2-mlevitsk@redhat.com>
References: <20201203171118.372391-1-mlevitsk@redhat.com> <20201203171118.372391-2-mlevitsk@redhat.com>
Date:   Sun, 06 Dec 2020 17:19:16 +0100
Message-ID: <87a6uq9abf.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 03 2020 at 19:11, Maxim Levitsky wrote:
> +	case KVM_SET_TSC_STATE: {
> +		struct kvm_tsc_state __user *user_tsc_state = argp;
> +		struct kvm_tsc_state tsc_state;
> +		u64 host_tsc, wall_nsec;
> +
> +		u64 new_guest_tsc, new_guest_tsc_offset;
> +
> +		r = -EFAULT;
> +		if (copy_from_user(&tsc_state, user_tsc_state, sizeof(tsc_state)))
> +			goto out;
> +
> +		kvm_get_walltime(&wall_nsec, &host_tsc);
> +		new_guest_tsc = tsc_state.tsc;
> +
> +		if (tsc_state.flags & KVM_TSC_STATE_TIMESTAMP_VALID) {
> +			s64 diff = wall_nsec - tsc_state.nsec;
> +			if (diff >= 0)
> +				new_guest_tsc += nsec_to_cycles(vcpu, diff);
> +			else
> +				new_guest_tsc -= nsec_to_cycles(vcpu, -diff);
> +		}
> +
> +		new_guest_tsc_offset = new_guest_tsc - kvm_scale_tsc(vcpu, host_tsc);
> +		kvm_vcpu_write_tsc_offset(vcpu, new_guest_tsc_offset);

From a timekeeping POV and the guests expectation of TSC this is
fundamentally wrong:

      tscguest = scaled(hosttsc) + offset

The TSC has to be viewed systemwide and not per CPU. It's systemwide
used for timekeeping and for that to work it has to be synchronized. 

Why would this be different on virt? Just because it's virt or what? 

Migration is a guest wide thing and you're not migrating single vCPUs.

This hackery just papers over he underlying design fail that KVM looks
at the TSC per vCPU which is the root cause and that needs to be fixed.

Thanks,

        tglx
