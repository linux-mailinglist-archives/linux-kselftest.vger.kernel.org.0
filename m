Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2316B2D6888
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Dec 2020 21:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389939AbgLJUS5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Dec 2020 15:18:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53342 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389999AbgLJO1t (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Dec 2020 09:27:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607610382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XemBX6GDiS8sIGiD/ca2Z1h8LOYV6Xo8hkAbb535R90=;
        b=Fo5NgH0K0pumbaYNdlpWaUydgSzoS+PMR1Qp12Xf7zybqbWAJ0y1YQZLFG1DxhD6rq3N3L
        bj1FFMYPLi+xVbb3+OWi5jcuhG8lR0BpgkDG0uUcWSQepf0T52nPmvBnuiCkiUMOfRSuwy
        DaqlgjcMTbcnzpb7P5GkrA4XNgn2tpI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-0sU_Km6bOiuY1Rfj4BqIcA-1; Thu, 10 Dec 2020 09:26:18 -0500
X-MC-Unique: 0sU_Km6bOiuY1Rfj4BqIcA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D6FD1842146;
        Thu, 10 Dec 2020 14:26:15 +0000 (UTC)
Received: from starship (unknown [10.35.206.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3083636FA;
        Thu, 10 Dec 2020 14:25:58 +0000 (UTC)
Message-ID: <7846c5452644a3c029d27361759cb82c2b8d4f2e.camel@redhat.com>
Subject: Re: [PATCH v2 1/3] KVM: x86: implement KVM_{GET|SET}_TSC_STATE
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oliver Upton <oupton@google.com>
Cc:     kvm list <kvm@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
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
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Date:   Thu, 10 Dec 2020 16:25:57 +0200
In-Reply-To: <7c25e8c0-a7d4-8906-ae47-20714e6699fe@redhat.com>
References: <20201203171118.372391-1-mlevitsk@redhat.com>
         <20201203171118.372391-2-mlevitsk@redhat.com>
         <CAOQ_Qsj6THRPj2ta3PdOxUJeCj8KxPnLkWV8EGpvN_J=qUv74A@mail.gmail.com>
         <d3dd82950301517e47630cc86fa0e6dc84f63f90.camel@redhat.com>
         <87lfe82quh.fsf@nanos.tec.linutronix.de>
         <047afdde655350a6701803aa8ae739a8bd1c1c14.camel@redhat.com>
         <7c25e8c0-a7d4-8906-ae47-20714e6699fe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 2020-12-10 at 12:48 +0100, Paolo Bonzini wrote:
> On 08/12/20 18:08, Maxim Levitsky wrote:
> > > Even if you support TSCADJUST and let the guest write to it does not
> > > change the per guest offset at all. TSCADJUST is per [v]CPU and adds on
> > > top:
> > > 
> > >      tscvcpu = tsc_host + guest_offset + TSC_ADJUST
> > > 
> > > Scaling is just orthogonal and does not change any of this.
> > 
> > I agree with this, and I think that this is what we will end up doing.
> > Paulo, what do you think about this?
> 
> Yes, you can have a VM ioctl that saves/restores cur_tsc_nsec and 
> cur_tsc_write.  The restore side would loop on all vcpus.

Why would the restore need to run on all VCPUs though?

The picture that I have in mind is that we we will restore the 
cur_tsc_nsec/cur_tsc_write pair once per VM, and then restore the 
TSC_ADJUST value on all vCPUs as if the guest wrote it (with the quirk disabled), 
which will restore all the horrible things that the guest did to its TSC.

Since TSC adjust is enabled by default, if the user disables it in the CPUID, 
we might as well just disable the whole thing, 
make TSC readonly or something similar.

This way we don't need to worry about TSC writes as 
those will be reflected in the TSC_ADJUST.

> 
> However, it is not so easy: 1) it would have to be usable only if 
> KVM_X86_QUIRK_TSC_HOST_ACCESS is false, 2) it would fail if 
> kvm->arch.nr_vcpus_matched_tsc == kvm->online_vcpus (which basically 
> means that userspace didn't mess up the TSC configuration).  If not, it 
> would return -EINVAL.

Note though that we don't track the guest tsc/tsc_adjust writes anymore
via the tsc sync code, and with the quirk disabled we don't track them
even for the host writes, thus the (2) condition will always be true
(the only call left to kvm_synchronize_tsc is in the kvm_arch_vcpu_postcreate)

However I indeed see no reason to allow new per VM API when the masterclock is
disabled, and therefore using cur_tsc_nsec/cur_tsc_write is reasonable.

The cur_tsc_nsec should IMHO be converted to absolute time (CLOCK_REALTIME
or similiar) or should the conversion be done in the userspace? 
I don't know yet if I can convert between different POSIX clocks
in race/error free manner. (e.g get the offset between them).


> 
> Also, while at it let's burn and pour salt on the support for 
> KVM_SET_TSC_KHZ unless TSC scaling is supported, together with 
> vcpu->tsc_catchup and all the "tolerance" crap that is in 
> kvm_set_tsc_khz.  And initialize vcpu->arch.virtual_tsc_khz to 
> kvm->arch.last_tsc_khz before calling kvm_synchronize_tsc.

The tsc_catchup is enabled when host TSC is unstable, so that guest
TSC at least roughtly follows real time (which host kernel gets
by other means).

We push the guest tsc forward roughtly each time VM entry from userspace
happens:

(On each kvm_arch_vcpu_load, we raise KVM_REQ_GLOBAL_CLOCK_UPDATE
request which (with small delay) makes all vcpus go through 
kvm_guest_time_update which pushes the guest tsc forward)

However we also have the 'tsc_always_catchup' mode which is indeed 
something I would like to remove.

It is a poor man simulation of the TSC scaling which is enabled 
when the host doesn't support TSC scaling, but we were asked 
to run at frequency faster than host TSC frequency is.

This way guest tsc runs slower than it should, but on each VM exit,
we punt the guest tsc offset forward so on average the guest tsc
doesn't lag behind.

Unless backward compatibility is an issue, I have no objections
to remove that code.

The tolerance thing might be needed. On many systems 
(including mine new 3970X), the hardware doesn't have means to report 
the unscaled host TSC frequency, thus the kernel has to 
measure it, and since the measurement is not 100% accurate, a slightly
different value is used every time the host boots.

Thus without a small tolerance, we will always have to use TSC scaling,
while migrating even between two identical systems.
I don't know if this is an issue.


Best regards,
	Maxim Levitsky


> 
> Paolo
> 


