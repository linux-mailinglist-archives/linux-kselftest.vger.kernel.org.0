Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB102D106F
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Dec 2020 13:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgLGMSK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Dec 2020 07:18:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28743 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727795AbgLGMSJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Dec 2020 07:18:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607343402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N6oDFfyq47RyWju2nHjeojjMvm9K1GLJgiOLjWvGMww=;
        b=FUOT34VDv70gB5Rd5orKEst2WG0n28GDvAUereSqQDPB0d9v3kYpmRlGPFW2Yg8Ojo2SPL
        Mu/vh00ZkJCNiNPS7/ZE8SOU6cwhfnFXXmZMIj8w5FhkuqsYRJhvwIUMWvZn6mAvTKPEcW
        v2365eRw2IfjseNGIOBAdJZ33V3xPWc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-_HOXYd9OOjWvW5CDT30MqA-1; Mon, 07 Dec 2020 07:16:39 -0500
X-MC-Unique: _HOXYd9OOjWvW5CDT30MqA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2F0F800D62;
        Mon,  7 Dec 2020 12:16:36 +0000 (UTC)
Received: from starship (unknown [10.35.206.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D1B74620DE;
        Mon,  7 Dec 2020 12:16:27 +0000 (UTC)
Message-ID: <1dbbeefc7c76c259b55582468ccd3aab35a6de60.camel@redhat.com>
Subject: Re: [PATCH v2 1/3] KVM: x86: implement KVM_{GET|SET}_TSC_STATE
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Oliver Upton <oupton@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Date:   Mon, 07 Dec 2020 14:16:26 +0200
In-Reply-To: <87a6uq9abf.fsf@nanos.tec.linutronix.de>
References: <20201203171118.372391-1-mlevitsk@redhat.com>
         <20201203171118.372391-2-mlevitsk@redhat.com>
         <87a6uq9abf.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, 2020-12-06 at 17:19 +0100, Thomas Gleixner wrote:
> On Thu, Dec 03 2020 at 19:11, Maxim Levitsky wrote:
> > +	case KVM_SET_TSC_STATE: {
> > +		struct kvm_tsc_state __user *user_tsc_state = argp;
> > +		struct kvm_tsc_state tsc_state;
> > +		u64 host_tsc, wall_nsec;
> > +
> > +		u64 new_guest_tsc, new_guest_tsc_offset;
> > +
> > +		r = -EFAULT;
> > +		if (copy_from_user(&tsc_state, user_tsc_state, sizeof(tsc_state)))
> > +			goto out;
> > +
> > +		kvm_get_walltime(&wall_nsec, &host_tsc);
> > +		new_guest_tsc = tsc_state.tsc;
> > +
> > +		if (tsc_state.flags & KVM_TSC_STATE_TIMESTAMP_VALID) {
> > +			s64 diff = wall_nsec - tsc_state.nsec;
> > +			if (diff >= 0)
> > +				new_guest_tsc += nsec_to_cycles(vcpu, diff);
> > +			else
> > +				new_guest_tsc -= nsec_to_cycles(vcpu, -diff);
> > +		}
> > +
> > +		new_guest_tsc_offset = new_guest_tsc - kvm_scale_tsc(vcpu, host_tsc);
> > +		kvm_vcpu_write_tsc_offset(vcpu, new_guest_tsc_offset);
> 
> From a timekeeping POV and the guests expectation of TSC this is
> fundamentally wrong:
> 
>       tscguest = scaled(hosttsc) + offset
> 
> The TSC has to be viewed systemwide and not per CPU. It's systemwide
> used for timekeeping and for that to work it has to be synchronized. 
> 
> Why would this be different on virt? Just because it's virt or what? 
> 
> Migration is a guest wide thing and you're not migrating single vCPUs.
> 
> This hackery just papers over he underlying design fail that KVM looks
> at the TSC per vCPU which is the root cause and that needs to be fixed.

I don't disagree with you.
As far as I know the main reasons that kvm tracks TSC per guest are

1. cases when host tsc is not stable 
(hopefully rare now, and I don't mind making
the new API just refuse to work when this is detected, and revert to old way
of doing things).

2. (theoretical) ability of the guest to introduce per core tsc offfset
by either using TSC_ADJUST (for which I got recently an idea to stop
advertising this feature to the guest), or writing TSC directly which
is allowed by Intel's PRM:

"The RDMSR and WRMSR instructions read and write the time-stamp counter, treating the time-stamp counter as an
ordinary MSR (address 10H). In the Pentium 4, Intel Xeon, and P6 family processors, all 64-bits of the time-stamp
counter are read using RDMSR (just as with RDTSC). When WRMSR is used to write the time-stamp counter on
processors before family [0FH], models [03H, 04H]: only the low-order 32-bits of the time-stamp counter can be
written (the high-order 32 bits are cleared to 0). For family [0FH], models [03H, 04H, 06H]; for family [06H]],
model [0EH, 0FH]; for family [06H]], DisplayModel [17H, 1AH, 1CH, 1DH]: all 64 bits are writable."


But other than that I don't mind making TSC offset global per VM thing.
Paulo, what do you think about this?

Best regards,
	Maxim Levitsky


> 
> Thanks,
> 
>         tglx
> 


