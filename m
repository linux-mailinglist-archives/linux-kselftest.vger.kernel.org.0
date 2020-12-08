Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 511852D3097
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Dec 2020 18:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgLHRJl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Dec 2020 12:09:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48901 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730351AbgLHRJk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Dec 2020 12:09:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607447293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yF+3r9yZr3OimJtNxI93YdLbEufXdUnZo4bnKb1/obs=;
        b=hRdLYvbCnGIF1W3I7Yp+s5zPCNKToY9jyPo6qHO4kYQ8SFmRn5lFcIoTJUPauVumXc1HpB
        QJsqI4Q5mFgsK0iCvx6zvz5Qsy7ErU/PhkF47jJWsUJcqY8V/jNH0YFN1ijNqWVNYOgzD6
        7OKQzB4TdQqpLwF2WQJVgHMdVjV8soE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-rUUp2KzZMZ--p7BszPHx1w-1; Tue, 08 Dec 2020 12:08:11 -0500
X-MC-Unique: rUUp2KzZMZ--p7BszPHx1w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF5E58042BD;
        Tue,  8 Dec 2020 17:08:07 +0000 (UTC)
Received: from starship (unknown [10.35.206.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0010699A5;
        Tue,  8 Dec 2020 17:08:01 +0000 (UTC)
Message-ID: <047afdde655350a6701803aa8ae739a8bd1c1c14.camel@redhat.com>
Subject: Re: [PATCH v2 1/3] KVM: x86: implement KVM_{GET|SET}_TSC_STATE
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Oliver Upton <oupton@google.com>
Cc:     kvm list <kvm@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
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
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Date:   Tue, 08 Dec 2020 19:08:00 +0200
In-Reply-To: <87lfe82quh.fsf@nanos.tec.linutronix.de>
References: <20201203171118.372391-1-mlevitsk@redhat.com>
         <20201203171118.372391-2-mlevitsk@redhat.com>
         <CAOQ_Qsj6THRPj2ta3PdOxUJeCj8KxPnLkWV8EGpvN_J=qUv74A@mail.gmail.com>
         <d3dd82950301517e47630cc86fa0e6dc84f63f90.camel@redhat.com>
         <87lfe82quh.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 2020-12-08 at 17:40 +0100, Thomas Gleixner wrote:
> On Tue, Dec 08 2020 at 13:13, Maxim Levitsky wrote:
> > On Mon, 2020-12-07 at 11:29 -0600, Oliver Upton wrote:
> > > How would a VMM maintain the phase relationship between guest TSCs
> > > using these ioctls?
> > 
> > By using the nanosecond timestamp. 
> >  
> > While I did made it optional in the V2 it was done for the sole sake of being 
> > able to set TSC on (re)boot to 0 from qemu, and for cases when qemu migrates 
> > from a VM where the feature is not enabled.
> > In this case the tsc is set to the given value exactly, just like you
> > can do today with KVM_SET_MSRS.
> > In all other cases the nanosecond timestamp will be given.
> >  
> > When the userspace uses the nanosecond timestamp, the phase relationship
> > would not only be maintained but be exact, even if TSC reads were not
> > synchronized and even if their restore on the target wasn't synchronized as well.
> >  
> > Here is an example:
> >  
> > Let's assume that TSC on source/target is synchronized, and that the guest TSC
> > is synchronized as well.
> > 
> > Let's call the guest TSC frequency F (guest TSC increments by F each second)
> >  
> > We do KVM_GET_TSC_STATE on vcpu0 and receive (t0,tsc0).
> > We do KVM_GET_TSC_STATE on vcpu1 after 1 second passed (exaggerated) 
> > and receive (t0 + 1s, tsc0 + F)
> 
> Why?
> 
> You freeeze the VM and store the realtime timestamp of doing that. At
> that point assuming a full sync host system the only interesting thing
> to store is the guest offset which is the same on all vCPUs and it is
> known already.
> 
> So on restore the only thing which needs to be adjusted is the guest
> wide offset.
> 
>      newoffset = oldoffset + (now - tfreeze)
> 
> Then set newoffset for all vCPUs. Anything else is complexity for no
> value and bound to fall apart in hard to debug ways.
> 
> The offset is still the same for all vCPUs whether you can restore them
> in the same nanosecond or whether you need 3 minutes for each one. It
> does not matter because when you restore vCPU1 3 minutes after vCPU0
> then TSC has advanced 3 minutes as well. It's still correct from the
> guest POV.
> 
> Even if you support TSCADJUST and let the guest write to it does not
> change the per guest offset at all. TSCADJUST is per [v]CPU and adds on
> top:
> 
>     tscvcpu = tsc_host + guest_offset + TSC_ADJUST
> 
> Scaling is just orthogonal and does not change any of this.

I agree with this, and I think that this is what we will end up doing.
Paulo, what do you think about this?

Best regards,
	Maxim Levitsky

> 
> Thanks,
> 
>         tglx
> 


