Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A1C2D2D1F
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Dec 2020 15:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbgLHOZN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Dec 2020 09:25:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59924 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729475AbgLHOZN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Dec 2020 09:25:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607437426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bfs7R36tArLHPO/+HIzcgL+lyVc7901iiK5/fepesp8=;
        b=CnIth2N4YjhmDuSTHAHEnf7P0rGsrexygqGd4pSpi3UvIrXl1xSwDwbT1vwm5rBX7g1fVA
        dxLvUI4cin34fm8hIHcF2Mcdeg0yQEHlaUvwSnvx8BnzUMFrgU71k+WPxUMIECI9LuXg6e
        0cwZzRNa7A08ilKZdd7MCgzCCC4XSIE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-aHFPSlkaM7y4stEEN7OEgw-1; Tue, 08 Dec 2020 09:23:45 -0500
X-MC-Unique: aHFPSlkaM7y4stEEN7OEgw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB78A107ACE3;
        Tue,  8 Dec 2020 14:23:42 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-8.gru2.redhat.com [10.97.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7DE3960BD8;
        Tue,  8 Dec 2020 14:23:42 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 8ACC04172ED9; Mon,  7 Dec 2020 20:34:23 -0300 (-03)
Date:   Mon, 7 Dec 2020 20:34:23 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Oliver Upton <oupton@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] KVM: x86: implement KVM_{GET|SET}_TSC_STATE
Message-ID: <20201207233423.GE27492@fuller.cnet>
References: <20201203171118.372391-1-mlevitsk@redhat.com>
 <20201203171118.372391-2-mlevitsk@redhat.com>
 <87a6uq9abf.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6uq9abf.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Dec 06, 2020 at 05:19:16PM +0100, Thomas Gleixner wrote:
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
> >From a timekeeping POV and the guests expectation of TSC this is
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

It already does it: The unified TSC offset is kept at kvm->arch.cur_tsc_offset.


