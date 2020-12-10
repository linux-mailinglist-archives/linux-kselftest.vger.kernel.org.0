Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC062D5EB6
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Dec 2020 15:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389812AbgLJOzW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Dec 2020 09:55:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24504 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731316AbgLJOyC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Dec 2020 09:54:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607611956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/hi8a0jEzGqN1iBD0C9+/eRWGMqXO+jd3SvUGWEwjC4=;
        b=SqlteXh4IHgm44UDbdvV93uCp2fgU9lMiqTrsMS9oRU9YCXIfaXkKrL1PK2A97+ow6dPoG
        Zg6wvoAVspmgbty3P6KeeY7R4EBUqDuiy9LVuZCmQyg/DQIAlLCNbP/D7jT1stuaptuMYk
        yLo3kYyWtl8l1gWG8F00XqSys9hh3SQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-qv4wd_1gML2sR-lxBto1jw-1; Thu, 10 Dec 2020 09:52:34 -0500
X-MC-Unique: qv4wd_1gML2sR-lxBto1jw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2AAB1858182;
        Thu, 10 Dec 2020 14:52:32 +0000 (UTC)
Received: from starship (unknown [10.35.206.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E3DB19C78;
        Thu, 10 Dec 2020 14:52:26 +0000 (UTC)
Message-ID: <9389c1198da174bcc9483d6ebf535405aa8bdb45.camel@redhat.com>
Subject: Re: [PATCH v2 1/3] KVM: x86: implement KVM_{GET|SET}_TSC_STATE
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>
Cc:     kvm@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
Date:   Thu, 10 Dec 2020 16:52:25 +0200
In-Reply-To: <70f9a5b3-d912-2a46-3718-a9c7591cd1f4@redhat.com>
References: <20201203171118.372391-1-mlevitsk@redhat.com>
         <20201203171118.372391-2-mlevitsk@redhat.com>
         <20201207232920.GD27492@fuller.cnet>
         <05aaabedd4aac7d3bce81d338988108885a19d29.camel@redhat.com>
         <87sg8g2sn4.fsf@nanos.tec.linutronix.de>
         <6f64558a029574444da417754786f711c2fec407.camel@redhat.com>
         <87blf42dvv.fsf@nanos.tec.linutronix.de>
         <70f9a5b3-d912-2a46-3718-a9c7591cd1f4@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 2020-12-10 at 12:48 +0100, Paolo Bonzini wrote:
> On 08/12/20 22:20, Thomas Gleixner wrote:
> > So now life migration comes a long time after timekeeping had set the
> > limits and just because it's virt it expects that everything works and it
> > just can ignore these limits.
> > 
> > TBH. That's not any different than SMM or hard/firmware taking the
> > machine out for lunch. It's exactly the same: It's broken.
> 
> I agree.  If *live* migration stops the VM for 200 seconds, it's broken.
> 
> Sure, there's the case of snapshotting the VM over the weekend.  My 
> favorite solution would be to just put it in S3 before doing that.  *Do 
> what bare metal does* and you can't go that wrong.

Note though that qemu has a couple of issues with s3, and it is disabled 
by default in libvirt. 
I would be very happy to work on improving this if there is a need for that.


> 
> In general it's userspace policy whether to keep the TSC value the same 
> across live migration.  There's pros and cons to both approaches, so KVM 
> should provide the functionality to keep the TSC running (which the 
> guest will see as a very long, but not extreme SMI), and this is what 
> this series does.  Maxim will change it to operate per-VM.  Thanks 
> Thomas, Oliver and everyone else for the input.

I agree with that.
 
I still think though that we should have a discussion on feasibility
of making the kernel time code deal with large *forward* tsc jumps 
without crashing.

If that is indeed hard to do, or will cause performance issues,
then I agree that we might indeed inform the guest of time jumps instead.
 
In fact kvmclock already have such a mechanism (KVM_KVMCLOCK_CTRL ioctl, which sets 
the PVCLOCK_GUEST_STOPPED bit in the PV clock struct).
That informs the guest that it was stopped (guest clears this bit), 
and currently that makes the guest touch various watchdogs.
 
I think that the guest uses it only when kvmclock is used but
we can think about extending this to make guest use it 
even when bare tsc is used, and also implement whatever logic is
needed to jump the guest clock forward when this bit is set.

What do you think?

Best regards,
	Maxim Levitsky

> 
> Paolo
> 


