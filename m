Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2694D2F17
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Mar 2022 13:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbiCIMc2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Mar 2022 07:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbiCIMcX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Mar 2022 07:32:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A62AD1768D9
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Mar 2022 04:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646829083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3TnDEK0JCXTbpdB9IZGtQZaJ3T3tAhTYIIWvW6puKns=;
        b=hWC6DcIek8gcjI772hr4GJD+VYb0hWg1hvVR/JBZ31R/Pr3sO1kIVbCXJP/8MKQcxKdxXD
        lJO/4pbCB31soQr12SboVaD2mkXkSLhJmItCJOaAnZFtlTI2Dl1PE4nrQ3lpVO4RVNDNEe
        hgdhO5Go1OvMTallbghMkOWHFkaes94=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-215-zU3EStL0Mrux_sh9LmqqsQ-1; Wed, 09 Mar 2022 07:31:20 -0500
X-MC-Unique: zU3EStL0Mrux_sh9LmqqsQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1E0A8145F6;
        Wed,  9 Mar 2022 12:31:16 +0000 (UTC)
Received: from starship (unknown [10.40.192.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D6EC37C0E0;
        Wed,  9 Mar 2022 12:31:03 +0000 (UTC)
Message-ID: <3221c2385e1148fe0ee77d4717b52726e1db9d8d.camel@redhat.com>
Subject: Re: [PATCH v3 2/6] KVM: x86: add force_intercept_exceptions_mask
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Kieran Bingham <kbingham@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Andrew Jones <drjones@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jessica Yu <jeyu@kernel.org>,
        Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Yang Weijiang <weijiang.yang@intel.com>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>
Date:   Wed, 09 Mar 2022 14:31:02 +0200
In-Reply-To: <YifoysEvfnQgq59A@google.com>
References: <20210811122927.900604-1-mlevitsk@redhat.com>
         <20210811122927.900604-3-mlevitsk@redhat.com> <YTECUaPa9kySQxRX@google.com>
         <0cdac80177eea408b7e316bd1fc4c0c5839ba1d4.camel@redhat.com>
         <YifoysEvfnQgq59A@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 2022-03-08 at 23:37 +0000, Sean Christopherson wrote:
> On Tue, Feb 08, 2022, Maxim Levitsky wrote:
> > On Thu, 2021-09-02 at 16:56 +0000, Sean Christopherson wrote:
> > > Assuming this hasn't been abandoned...
> > > 
> > > On Wed, Aug 11, 2021, Maxim Levitsky wrote:
> > > > This parameter will be used by VMX and SVM code to force
> > > > interception of a set of exceptions, given by a bitmask
> > > > for guest debug and/or kvm debug.
> > > > 
> > > > This is based on an idea first shown here:
> > > > https://patchwork.kernel.org/project/kvm/patch/20160301192822.GD22677@pd.tnic/
> > > > 
> > > > CC: Borislav Petkov <bp@suse.de>
> > > > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > > > ---
> > > >  arch/x86/kvm/x86.c | 3 +++
> > > >  arch/x86/kvm/x86.h | 2 ++
> > > >  2 files changed, 5 insertions(+)
> > > > 
> > > > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > > index fdc0c18339fb..092e2fad3c0d 100644
> > > > --- a/arch/x86/kvm/x86.c
> > > > +++ b/arch/x86/kvm/x86.c
> > > > @@ -184,6 +184,9 @@ module_param(force_emulation_prefix, bool, S_IRUGO);
> > > >  int __read_mostly pi_inject_timer = -1;
> > > >  module_param(pi_inject_timer, bint, S_IRUGO | S_IWUSR);
> > > >  
> > > > +uint force_intercept_exceptions_mask;
> > > > +module_param(force_intercept_exceptions_mask, uint, S_IRUGO | S_IWUSR);
> > > 
> > > Use octal permissions.  This also can't be a simple writable param, at least not
> > > without a well-documented disclaimer, as there's no guarantee a vCPU will update
> > > its exception bitmap in a timely fashion.  An alternative to a module param would
> > > be to extend/add a per-VM ioctl(), e.g. maybe KVM_SET_GUEST_DEBUG?  The downside
> > > of an ioctl() is that it would require userspace enabling :-/
> > > 
> > 
> > All other module params in this file use macros for permissions, that is why
> > I used them too.
> > 
> > I'll add a comment with a disclaimer here - this is only for debug.
> > I strongly don't want to have this as ioctl as that will indeed need qemu patches,
> > not to mention things like unit tests and which don't even always use qemu.
> > 
> > Or I can make this parameter read-only. I don't mind reloading kvm module when
> > I change this parameter.
> 
> Oh!  We can force an update, a la nx_huge_pages, where the setter loops through
> all VMs and does a kvm_make_all_cpus_request() to instruct vCPUs to update their
> bitmaps.  Requires a new request, but that doesn't seem like a huge deal, and it
> might help pave the way for adding more debug hooks for developers.

Question: is it worth it? Since I am very busy with various things, this feature,
beeing just small debug help which I used once in a while doesn't get much time from me.

I can implement this in the future no doubt.

Best regards,
	Maxim Levitsky

> 
> The param should also be "unsafe".

I didn't knew about unsafe parameters until recently. I can mark it as such,
no objections.

Best regards,
	Maxim Levitsky

> 
> E.g. something like
> 
> static const struct kernel_param_ops force_ex_intercepts_ops = {
> 	.set = set_force_exception_intercepts,
> 	.get = get_force_exception_intercepts,
> };
> module_param_cb_unsafe(force_exception_intercepts, &force_ex_intercepts_ops,
> 		       &force_exception_intercepts, 0644);
> 


