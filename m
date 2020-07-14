Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4EE21E7A7
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jul 2020 07:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgGNFnK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Jul 2020 01:43:10 -0400
Received: from mga05.intel.com ([192.55.52.43]:56275 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgGNFnJ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Jul 2020 01:43:09 -0400
IronPort-SDR: uhQTP7KOU/pcJ6TYeJU6keO8b1WHUW8JP6FxH9RNRDrmUhssOiiNxi8J6Lr4lYKOSBtJYu7+sh
 f3EuN3bqwPlQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="233665963"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="233665963"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2020 22:43:08 -0700
IronPort-SDR: MizPN2CBTzimOsR+xSUT+e+4WVuCCDUceoaUG09wR/Om3zkkAzUomzdwbif514QuCYev3LbEyA
 G70hNQxP+5QQ==
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="316281009"
Received: from otcsectest.jf.intel.com (HELO 760745902f30) ([10.54.30.81])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2020 22:43:08 -0700
Date:   Tue, 14 Jul 2020 05:39:30 +0000
From:   "Andersen, John" <john.s.andersen@intel.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Shuah Khan <shuah@kernel.org>,
        Liran Alon <liran.alon@oracle.com>,
        Andrew Jones <drjones@redhat.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Oliver Neukum <oneukum@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Fenghua Yu <fenghua.yu@intel.com>, reinette.chatre@intel.com,
        vineela.tummalapalli@intel.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        caoj.fnst@cn.fujitsu.com, Baoquan He <bhe@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>, eric.auger@redhat.com,
        aaronlewis@google.com, Peter Xu <peterx@redhat.com>,
        makarandsonare@google.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: [PATCH 2/4] KVM: x86: Introduce paravirt feature CR0/CR4 pinning
Message-ID: <20200714053930.GC25@760745902f30>
References: <20200618144314.GB23@258ff54ff3c0>
 <124a59a3-a603-701b-e3bb-61e83d70b20d@intel.com>
 <20200707211244.GN20096@linux.intel.com>
 <19b97891-bbb0-1061-5971-549a386f7cfb@intel.com>
 <31eb5b00-9e2a-aa10-0f20-4abc3cd35112@redhat.com>
 <20200709154412.GA25@64c96d3be97b>
 <af6ac772-318d-aab0-ce5f-55cf92f6e96d@intel.com>
 <CALCETrWxt0CHUoonWX1fgbM46ydJPQZhj8Q=G+45EG4wW3wZqQ@mail.gmail.com>
 <6040c3b3-cac9-cc0e-f0de-baaa274920a2@intel.com>
 <CALCETrUHcpqjDfAM9SbrZUM7xcS2wkVm=r1Nb1JmxV7A-KAeUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrUHcpqjDfAM9SbrZUM7xcS2wkVm=r1Nb1JmxV7A-KAeUQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 09, 2020 at 09:27:43AM -0700, Andy Lutomirski wrote:
> On Thu, Jul 9, 2020 at 9:22 AM Dave Hansen <dave.hansen@intel.com> wrote:
> >
> > On 7/9/20 9:07 AM, Andy Lutomirski wrote:
> > > On Thu, Jul 9, 2020 at 8:56 AM Dave Hansen <dave.hansen@intel.com> wrote:
> > >> On 7/9/20 8:44 AM, Andersen, John wrote:
> > >>>         Bits which are allowed to be pinned default to WP for CR0 and SMEP,
> > >>>         SMAP, and UMIP for CR4.
> > >> I think it also makes sense to have FSGSBASE in this set.
> > >>
> > >> I know it hasn't been tested, but I think we should do the legwork to
> > >> test it.  If not in this set, can we agree that it's a logical next step?
> > > I have no objection to pinning FSGSBASE, but is there a clear
> > > description of the threat model that this whole series is meant to
> > > address?  The idea is to provide a degree of protection against an
> > > attacker who is able to convince a guest kernel to write something
> > > inappropriate to CR4, right?  How realistic is this?
> >
> > If a quick search can find this:
> >
> > > https://googleprojectzero.blogspot.com/2017/05/exploiting-linux-kernel-via-packet.html
> >
> > I'd pretty confident that the guys doing actual bad things have it in
> > their toolbox too.
> >
> 
> True, but we have the existing software CR4 pinning.  I suppose the
> virtualization version is stronger.
> 

Yes, as Kees said this will be stronger because it stops ROP and other gadget
based techniques which avoid the use of native_write_cr0/4().

With regards to what should be done in this patchset and what in other
patchsets. I have a fix for kexec thanks to Arvind's note about
TRAMPOLINE_32BIT_CODE_SIZE. The physical host boots fine now and the virtual
one can kexec fine.

What remains to be done on that front is to add some identifying information to
the kernel image to declare that it supports paravirtualized control register
pinning or not.

Liran suggested adding a section to the built image acting as a flag to signify
support for being kexec'd by a kernel with pinning enabled. If anyone has any
opinions on how they'd like to see this implemented please let me know.
Otherwise I'll just take a stab at it and you'll all see it hopefully in the
next version.

With regards to FSGSBASE, are we open to validating and adding that to the
DEFAULT set as a part of a separate patchset? This patchset is focused on
replicating the functionality we already have natively.


(If anyone got this email twice, sorry I messed up the From: field the first
time around)
