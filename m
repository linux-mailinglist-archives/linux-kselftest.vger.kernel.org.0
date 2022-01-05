Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFAC485955
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jan 2022 20:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243643AbiAETlE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Jan 2022 14:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243639AbiAETlC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Jan 2022 14:41:02 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7195DC061212
        for <linux-kselftest@vger.kernel.org>; Wed,  5 Jan 2022 11:41:02 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id q3so276964pfs.7
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Jan 2022 11:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pZ7Du5aXJypbN5z9JdXaN/bv6j/5WCgbjcAZoOJVTUo=;
        b=fZrlfDN2fNtW20qRO8Z9+o9nA5CFDsiKwl72mrfDZ538L6+n+8tdbpiIIOCAAtuJ/U
         kR3kRLZLgvWRszCANN33MnEha5UmcBTrH9HOq653dfDwYe1JNqJKRrbdk9mmWBs3h86k
         qjo99ocaP1PvNTkh+DsMkxm0dEAh9KCtGCIglmzsyd6gTDNp8Hsp0fZi022Tu+XIZ8IC
         o79KS8q79BBdJpu2S8Rk7bRM4T+a2Csi/Ew7MqGaW/3MpIp+WIiFc0dwtT0Mw0762+jB
         J0aW7melAxcapbZXU1N44tXkKhjlm7jCSBWqDErSFgRrhQfQxFBXYId40kXyaBklusJQ
         xlCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pZ7Du5aXJypbN5z9JdXaN/bv6j/5WCgbjcAZoOJVTUo=;
        b=uUufXWxujWSBelCTYewNhsZtAv00tH5WEI54kVVMM5lLwO9TPX3Z+Pp7NWYXqHyVFI
         B0qBAB4TV3o6qUh3DFsm9e7ZcHwAOkFp6edAGfnBgA48vgH+WVYq3JrkwVTjPEM1kjZH
         spYH8dafUodhYcqm4hV8UhlHlee6bgnBC3/xod8O6Ca3aN8Ah/Fk3InpjXIstbi+8/91
         Xy1NmsWbibvg5xUqh8vgImDFI2grfIBXLAMLLgJhGyfdgdfWLfngmJ/dq9N7FVWMr0kR
         D1lWM9cTW9o9q2h7jBRsVgUK+9/rfsqnK9wP/qjE6oqpo9jvCUMpJ8yYz3dyyDzZLTik
         W6CA==
X-Gm-Message-State: AOAM530xIHPH9rLhEUk3ik/pPbmq3di8BQqZ2MsHeiZEpSg8/a+xo46p
        3RdgvOfgbVOnf56YqXIlKHn2Rg==
X-Google-Smtp-Source: ABdhPJxd23qEySJcCwtTGFUUCnhs0ACGzCCMlTQh0PUWwigVeZbm2WT+JjUT3hpQbEtMvfjsVpFKNw==
X-Received: by 2002:aa7:8e88:0:b0:4ba:8792:b with SMTP id a8-20020aa78e88000000b004ba8792000bmr56091893pfr.23.1641411661585;
        Wed, 05 Jan 2022 11:41:01 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id n34sm43708606pfv.129.2022.01.05.11.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 11:41:01 -0800 (PST)
Date:   Wed, 5 Jan 2022 19:40:57 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Michael Roth <michael.roth@amd.com>
Cc:     linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Nathan Tempelman <natet@google.com>,
        Marc Orr <marcorr@google.com>,
        Steve Rutherford <srutherford@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Shuah Khan <shuah@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Ricardo Koller <ricarkol@google.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu
Subject: Re: [RFC PATCH 00/10] KVM: selftests: Add support for
 test-selectable ucall implementations
Message-ID: <YdX0SRoBXReggrVA@google.com>
References: <20211210164620.11636-1-michael.roth@amd.com>
 <Yc4gcJdhxthBKUUd@google.com>
 <20220104233517.kxjbdw4t7taymab5@amd.com>
 <YdTjnRZQID5IabK0@google.com>
 <20220105170244.jwr6i2erecbhx3fz@amd.com>
 <YdXYuaoXJux6lHrF@google.com>
 <20220105191107.qx67wf2coc3q6giu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105191107.qx67wf2coc3q6giu@amd.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jan 05, 2022, Michael Roth wrote:
> On Wed, Jan 05, 2022 at 05:43:21PM +0000, Sean Christopherson wrote:
> > Because it uses multiple VMs, and my rough sketch only allows for a single VM to
> > use ucall.  Though I suppose we could simply keep appending to the ucall list for
> > every VM.  The requirement would then be that all VMs are of the same type, i.e.
> > utilize the same ucall_ops.
> 
> Hmm, maybe I misread your patch. Not supporting multiple VMs was the
> reason I gave up on having the ucall structs allocated on-demand and
> went with requiring them to be passed as arguments to ucall().
> 
> I thought with your patch you had solved that by having each vm have it's
> own pool, via vm->ucall_list, and then mapping each pool into each guest
> separately via:
> 
>   ucall_init(vm):
>     ucall_list = vm->ucall_list
>     sync_global_to_guest(ucall_list).
> 
> then as long as that ucall_init() is done *after* the guest calls
> kvm_vm_elf_load(), it will end up with a 'ucall_list' global that points
> to it's own specific vm->ucall_list. Then on the test side it doesn't
> matter what the 'ucall_list' global is currently set to since you have
> the GPA and know what vm exited.
> 
> Or am I missing something there?

Ha, that was not at all intented.  But yes, it should work.  I'd rather be lucky
than good?

> Although even if that is the case, now that we're proposing doing the
> ucall_init() inside vm_create(), then we run the risk of a test calling
> kvm_vm_elf_load() after, which might clobber the guest's copy of
> ucall_list global if ucall_init() had since been called for another VM.
> But that could maybe be worked around by having whatever vm_create()
> variant we use also do the kvm_vm_elf_load() unconditionally as part of
> creation.

Will sync_global_to_guest() even work as intended if kvm_vm_elf_load() hasn't
been called?  If not, then sync_global_{to,from}_guest() should really assert if
the test hasn't been loaded.

As for ucall_init(), I think the best approach would be to make kvm_vm_elf_load()
a static and replace all calls with:

	kvm_vm_load_guest(vm);

where its implementation is:

  void kvm_vm_load_guest(struct kvm_vm *vm)
  {
  	kvm_vm_elf_load(vm, program_invocation_name);

	ucall_init(vm);
  }

The logic being that if a test creates a VM but never loads any code into the guest,
e.g. kvm_create_max_vcpus, then it _can't_ make ucalls.
