Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A424D2588
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Mar 2022 02:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiCIBIL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Mar 2022 20:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiCIBHw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Mar 2022 20:07:52 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504FAD5F62
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Mar 2022 16:48:27 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id u124so617110vsb.10
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Mar 2022 16:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2kU1A0mZ+Yf718gi2yxK3phVn7nYLq00SbSALiBBt2c=;
        b=a3wxXsXXiZ50ZckVfXFMr8KdVU78K5T3RLsMnlj3KUTmsXr2mTTchwj6lfSmoIW6Jw
         Xxcj7nT6ioNm+beNeT7w/gpTTEoesAjFfDTQkbfIWQwfq91ifPoOm3HZ8d5QpMlRFFmu
         /SvS/C3P+W10CB6HG+SZCcWMlW7qlD0MjWDZHoph8a3b1v7eqS2BfyKguOEWwdkttbdX
         RqHb2uCJ+bspxUluBYFhwxvdHNOj0fFpnkuHxLzLPAlkPVyOzDfrRkJ8/tz488d1UDi3
         MOfKNkuD4sJ9Xv7tvkhmywY4CjEK6CRMke81P29RSspDH8NnokaenIYa9TIs71rPiZ4j
         hzYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2kU1A0mZ+Yf718gi2yxK3phVn7nYLq00SbSALiBBt2c=;
        b=bk6SMr7wk+3TOneHGKxc9aSPgGpFnPxGvmRGKIFk4DvafwkQFZjiSPMSUEfHgNzy6b
         BHCO7QbSY0VnnsKr31nCVyzqk5k1Y+C7ngl5r70gwQlbFkvyGIDLWNIPQEfKnXOIIK52
         cp1KAb9/LeSB6s43CNRz6arEmTGNA3pfLNGtw2JOb17Is7wB3ZWXoJ/QU1L613CivoNo
         +YL+508xTf+6xekQlxkyZD6u6TR92whKa8cemzKKhFiCKJmjXGEjCti8znhabgDg5gI6
         5qCziN6A2bBBsPet7W3okTCjOibZLDGgh6QHlEYita12O2IwjgzPuAeUBRIqX+AHUcls
         u6kA==
X-Gm-Message-State: AOAM532EmB8nuU7BpWtV36eJGdgdfAF4XbOWO3BQfy9BuoCcAPA0WNpC
        yT68MF10gNnThQZ4VDJLOjx4hmfwIgqSxg==
X-Google-Smtp-Source: ABdhPJxu5BNOL66aUTFVR0ibkfjQAJZxN1/5Jln5I65fELTDrubmqTQaTFywu9mFnXzUzDH+EMVzEQ==
X-Received: by 2002:a17:902:b602:b0:14f:e42b:d547 with SMTP id b2-20020a170902b60200b0014fe42bd547mr19779057pls.91.1646782670904;
        Tue, 08 Mar 2022 15:37:50 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id e13-20020a056a001a8d00b004f0f28910cdsm185636pfv.42.2022.03.08.15.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 15:37:50 -0800 (PST)
Date:   Tue, 8 Mar 2022 23:37:46 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
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
Subject: Re: [PATCH v3 2/6] KVM: x86: add force_intercept_exceptions_mask
Message-ID: <YifoysEvfnQgq59A@google.com>
References: <20210811122927.900604-1-mlevitsk@redhat.com>
 <20210811122927.900604-3-mlevitsk@redhat.com>
 <YTECUaPa9kySQxRX@google.com>
 <0cdac80177eea408b7e316bd1fc4c0c5839ba1d4.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cdac80177eea408b7e316bd1fc4c0c5839ba1d4.camel@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Feb 08, 2022, Maxim Levitsky wrote:
> On Thu, 2021-09-02 at 16:56 +0000, Sean Christopherson wrote:
> > Assuming this hasn't been abandoned...
> > 
> > On Wed, Aug 11, 2021, Maxim Levitsky wrote:
> > > This parameter will be used by VMX and SVM code to force
> > > interception of a set of exceptions, given by a bitmask
> > > for guest debug and/or kvm debug.
> > > 
> > > This is based on an idea first shown here:
> > > https://patchwork.kernel.org/project/kvm/patch/20160301192822.GD22677@pd.tnic/
> > > 
> > > CC: Borislav Petkov <bp@suse.de>
> > > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > > ---
> > >  arch/x86/kvm/x86.c | 3 +++
> > >  arch/x86/kvm/x86.h | 2 ++
> > >  2 files changed, 5 insertions(+)
> > > 
> > > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > index fdc0c18339fb..092e2fad3c0d 100644
> > > --- a/arch/x86/kvm/x86.c
> > > +++ b/arch/x86/kvm/x86.c
> > > @@ -184,6 +184,9 @@ module_param(force_emulation_prefix, bool, S_IRUGO);
> > >  int __read_mostly pi_inject_timer = -1;
> > >  module_param(pi_inject_timer, bint, S_IRUGO | S_IWUSR);
> > >  
> > > +uint force_intercept_exceptions_mask;
> > > +module_param(force_intercept_exceptions_mask, uint, S_IRUGO | S_IWUSR);
> > 
> > Use octal permissions.  This also can't be a simple writable param, at least not
> > without a well-documented disclaimer, as there's no guarantee a vCPU will update
> > its exception bitmap in a timely fashion.  An alternative to a module param would
> > be to extend/add a per-VM ioctl(), e.g. maybe KVM_SET_GUEST_DEBUG?  The downside
> > of an ioctl() is that it would require userspace enabling :-/
> > 
> 
> All other module params in this file use macros for permissions, that is why
> I used them too.
> 
> I'll add a comment with a disclaimer here - this is only for debug.
> I strongly don't want to have this as ioctl as that will indeed need qemu patches,
> not to mention things like unit tests and which don't even always use qemu.
> 
> Or I can make this parameter read-only. I don't mind reloading kvm module when
> I change this parameter.

Oh!  We can force an update, a la nx_huge_pages, where the setter loops through
all VMs and does a kvm_make_all_cpus_request() to instruct vCPUs to update their
bitmaps.  Requires a new request, but that doesn't seem like a huge deal, and it
might help pave the way for adding more debug hooks for developers.

The param should also be "unsafe".

E.g. something like

static const struct kernel_param_ops force_ex_intercepts_ops = {
	.set = set_force_exception_intercepts,
	.get = get_force_exception_intercepts,
};
module_param_cb_unsafe(force_exception_intercepts, &force_ex_intercepts_ops,
		       &force_exception_intercepts, 0644);
