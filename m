Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 941232D31E9
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Dec 2020 19:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730798AbgLHSQN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Dec 2020 13:16:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50428 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730975AbgLHSQM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Dec 2020 13:16:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607451286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M9T5kVr+CAbU/Pqq1HubTPf8M564HNxJMPku0hKIlCY=;
        b=VT75sXUE4sYF08py/ua35cLvFjMlEUc9IDj8Svlvi9hgaa6OtyZqxPgn1YZPo13IhFMVej
        +49p6cG6R15CQ9aUr4XhoCe3u0FCvkwlyh2GMauAHnxrX77IYE0XvDsDtcc7pyKaz9H5JS
        YSZCLnB6D4D859HR7BcNLMpV9a9rnNY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-pdftyMXzODOmvHNI7kaGyA-1; Tue, 08 Dec 2020 13:14:42 -0500
X-MC-Unique: pdftyMXzODOmvHNI7kaGyA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D8B8804002;
        Tue,  8 Dec 2020 18:14:40 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-8.gru2.redhat.com [10.97.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D5D160877;
        Tue,  8 Dec 2020 18:14:39 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 51416405CBC7; Tue,  8 Dec 2020 15:11:07 -0300 (-03)
Date:   Tue, 8 Dec 2020 15:11:07 -0300
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
Message-ID: <20201208181107.GA31442@fuller.cnet>
References: <20201203171118.372391-1-mlevitsk@redhat.com>
 <20201203171118.372391-2-mlevitsk@redhat.com>
 <20201207232920.GD27492@fuller.cnet>
 <05aaabedd4aac7d3bce81d338988108885a19d29.camel@redhat.com>
 <87sg8g2sn4.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sg8g2sn4.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 08, 2020 at 05:02:07PM +0100, Thomas Gleixner wrote:
> On Tue, Dec 08 2020 at 16:50, Maxim Levitsky wrote:
> > On Mon, 2020-12-07 at 20:29 -0300, Marcelo Tosatti wrote:
> >> > +This ioctl allows to reconstruct the guest's IA32_TSC and TSC_ADJUST value
> >> > +from the state obtained in the past by KVM_GET_TSC_STATE on the same vCPU.
> >> > +
> >> > +If 'KVM_TSC_STATE_TIMESTAMP_VALID' is set in flags,
> >> > +KVM will adjust the guest TSC value by the time that passed since the moment
> >> > +CLOCK_REALTIME timestamp was saved in the struct and current value of
> >> > +CLOCK_REALTIME, and set the guest's TSC to the new value.
> >> 
> >> This introduces the wraparound bug in Linux timekeeping, doesnt it?
> 
> Which bug?

max_cycles overflow. Sent a message to Maxim describing it.

> 
> > It does.
> > Could you prepare a reproducer for this bug so I get a better idea about
> > what are you talking about?
> >
> > I assume you need very long (like days worth) jump to trigger this bug
> > and for such case we can either work around it in qemu / kernel 
> > or fix it in the guest kernel and I strongly prefer the latter.
> >
> > Thomas, what do you think about it?
> 
> For one I have no idea which bug you are talking about and if the bug is
> caused by the VMM then why would you "fix" it in the guest kernel.

1) Stop guest, save TSC value of cpu-0 = V.
2) Wait for some amount of time = W.
3) Start guest, load TSC value with V+W.

Can cause an overflow on Linux timekeeping.

> Aside of that I think I made it pretty clear what the right thing to do
> is.

Sure: the notion of a "unique TSC offset" already exists (it is detected
by write TSC logic, and not explicit in the interface, though).

But AFAIK it works pretty well.

Exposing a single TSC value on the interface level seems alright to
me...

