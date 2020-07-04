Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC322146D1
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Jul 2020 17:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgGDPL0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 4 Jul 2020 11:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgGDPLZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 4 Jul 2020 11:11:25 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1D4C061794;
        Sat,  4 Jul 2020 08:11:25 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id b25so4469804qto.2;
        Sat, 04 Jul 2020 08:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OOkooQcgZT8G2WjNcK+Cq5ASRRPbRLgNwU0mUCZTWZI=;
        b=SSCGTrxShtNJIdkHMwubUtEAPLob65gZ9Nz5GIsi4JTIzZCXrLS/99iaMWNLeILZZh
         dUCTc3VZFmhBFFLd6jSGUcZoz4xga8nOBy81G/6qLO+eDQFVHxsn45Hc+A2nfJbxQLQ3
         F/yWQeimUTBDQsKwVTH3jhKYtwL7xOf7lN40MjPuRNoNjMdHcoy12/g+hDD3lKHj4+yW
         4w2ihNFDM1x8cwKAZcSDup2S5B+BdcBesMzzm3szOfZD3uGB51X/o6qFL+ZwB749hzBe
         DWEjqvR/fDIzJeaw5zs0M8WY8K+4iXiLIzARk5Sn76TMP5jOkhrKt6AE/QYT8GXmRlM/
         0w3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=OOkooQcgZT8G2WjNcK+Cq5ASRRPbRLgNwU0mUCZTWZI=;
        b=DU1IyXEHq0szioK2dOKcmbWf9AF5ZtFC3bhzKAX86tsYbgYYV1t8/cHEwWR7k7bKM/
         izEMEhIL8cz8ZtYJ587zrB60/4GP8381hCNeaH/5Z9/RicPH5yLCt4qhZGhHn/q+SAPQ
         vviKlsF89ahLwPNfnsh87KItPl2ETyOHQhKZ/BF0h9Ephw+UwvTUcPQxV6+hrO7gNqg3
         DgkDjqb0hhzsI04nhzdMN5NhhcY92aXkGhMT3Xe64pYUeOm+jhjKXqf2kk5OGyz00uxi
         t7F+PT04KkAbZ5QOPl8KYuMLm13JXFDBYfST7s5YC0A3/0DB5/ufJPoRpJOW9EZmASNU
         EPfg==
X-Gm-Message-State: AOAM531DqdCNzkRkpwUCOaM5WVElITjacx9x7ADqNKgj6gh4bRdCQKjW
        xaNoe20oHlDywdqQmuZGAqc=
X-Google-Smtp-Source: ABdhPJyYWEY9xvrLxysif9VMRbbPNXdpPaaf7cVFq/ebirldMeLAaEYpHqI6t21b12ayi2VmWj4t2Q==
X-Received: by 2002:aed:2492:: with SMTP id t18mr42182035qtc.353.1593875484322;
        Sat, 04 Jul 2020 08:11:24 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id z68sm13598056qke.113.2020.07.04.08.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 08:11:23 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sat, 4 Jul 2020 11:11:21 -0400
To:     "Andersen, John" <john.s.andersen@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Shuah Khan <shuah@kernel.org>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Liran Alon <liran.alon@oracle.com>,
        Andrew Jones <drjones@redhat.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, mchehab+huawei@kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        pawan.kumar.gupta@linux.intel.com, Juergen Gross <jgross@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Oliver Neukum <oneukum@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Fenghua Yu <fenghua.yu@intel.com>, reinette.chatre@intel.com,
        vineela.tummalapalli@intel.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        caoj.fnst@cn.fujitsu.com, Baoquan He <bhe@redhat.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Kees Cook <keescook@chromium.org>,
        Geremy Condra <geremy.condra@intel.com>,
        Dan Williams <dan.j.williams@intel.com>, eric.auger@redhat.com,
        aaronlewis@google.com, Peter Xu <peterx@redhat.com>,
        makarandsonare@google.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: [PATCH 4/4] X86: Use KVM CR pin MSRs
Message-ID: <20200704151121.GA1611291@rani.riverdale.lan>
References: <20200617190757.27081-1-john.s.andersen@intel.com>
 <20200617190757.27081-5-john.s.andersen@intel.com>
 <CALCETrXwzQDDd1rfBW+ptmijEjc2cMqfWGvJu-qqrqia5Ls=Uw@mail.gmail.com>
 <20200623200334.GA23@6540770db1d7>
 <20200703214814.GA25@0e1a9e0069b7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200703214814.GA25@0e1a9e0069b7>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 03, 2020 at 09:48:14PM +0000, Andersen, John wrote:
> > > Is there a plan for fixing this for real?  I'm wondering if there is a
> > > sane weakening of this feature that still allows things like kexec.
> > > 
> > 
> > I'm pretty sure kexec can be fixed. I had it working at one point, I'm
> > currently in the process of revalidating this. The issue was though that
> > kexec only worked within the guest, not on the physical host, which I suspect
> > is related to the need for supervisor pages to be mapped, which seems to be
> > required before enabling SMAP (based on what I'd seen with the selftests and
> > unittests). I was also just blindly turning on the bits without checking for
> > support when I'd tried this, so that could have been the issue too.
> > 
> > I think most of the changes for just blindly enabling the bits were in
> > relocate_kernel, secondary_startup_64, and startup_32.
> > 
> 
> So I have a naive fix for kexec which has only been tested to work under KVM.
> When tested on a physical host, it did not boot when SMAP or UMIP were set.
> Undoubtedly it's not the correct way to do this, as it skips CPU feature
> identification, opting instead for blindly setting the bits. The physical host
> I tested this on does not have UMIP so that's likely why it failed to boot when
> UMIP gets set blindly. Within kvm-unit-tests, the test for SMAP maps memory as
> supervisor pages before enabling SMAP. I suspect this is why setting SMAP
> blindly causes the physical host not to boot.
> 
> Within trampoline_32bit_src() if I add more instructions I get an error
> about "attempt to move .org backwards", which as I understand it means
> there are only so many instructions allowed in each of those functions.
> 
> My suspicion is that someone with more knowledge of this area has a good
> idea on how best to handle this. Feedback would be much appreciated.

You can simply increase the value of TRAMPOLINE_32BIT_CODE_SIZE in
pgtable.h, assuming you don't need a very large increase. There's one
page available for code + stack at present.
