Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D30F21A3FC
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jul 2020 17:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgGIPrt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Jul 2020 11:47:49 -0400
Received: from mga07.intel.com ([134.134.136.100]:65354 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726519AbgGIPrt (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Jul 2020 11:47:49 -0400
IronPort-SDR: zWcAl1CBz8ho4wdzuI0K6pR9lYnbxKDPvdNE0k6B8RqIeHIsgDdrlRdwRftVfw8gnYRXjShmqN
 Gun1BpHFSIIw==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="212931531"
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="212931531"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 08:47:48 -0700
IronPort-SDR: cE9JhtxvrZXc4jXdrrCsehjy1soh2GYV/VEffc4pqCe90cpz7eO/WgThxiLkUkSOt1RsCnX3pA
 iA1cbdX19Rog==
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="324261360"
Received: from otcsectest.jf.intel.com (HELO 64c96d3be97b) ([10.54.30.81])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 08:47:48 -0700
Date:   Thu, 9 Jul 2020 15:44:12 +0000
From:   "Andersen, John" <john.s.andersen@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        x86@kernel.org, hpa@zytor.com, shuah@kernel.org,
        liran.alon@oracle.com, drjones@redhat.com,
        rick.p.edgecombe@intel.com, kristen@linux.intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, mchehab+huawei@kernel.org,
        gregkh@linuxfoundation.org, paulmck@kernel.org,
        pawan.kumar.gupta@linux.intel.com, jgross@suse.com,
        mike.kravetz@oracle.com, oneukum@suse.com, luto@kernel.org,
        peterz@infradead.org, fenghua.yu@intel.com,
        reinette.chatre@intel.com, vineela.tummalapalli@intel.com,
        dave.hansen@linux.intel.com, arjan@linux.intel.com,
        caoj.fnst@cn.fujitsu.com, bhe@redhat.com, nivedita@alum.mit.edu,
        keescook@chromium.org, dan.j.williams@intel.com,
        eric.auger@redhat.com, aaronlewis@google.com, peterx@redhat.com,
        makarandsonare@google.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH 2/4] KVM: x86: Introduce paravirt feature CR0/CR4 pinning
Message-ID: <20200709154412.GA25@64c96d3be97b>
References: <20200617190757.27081-1-john.s.andersen@intel.com>
 <20200617190757.27081-3-john.s.andersen@intel.com>
 <0fa9682e-59d4-75f7-366f-103d6b8e71b8@intel.com>
 <20200618144314.GB23@258ff54ff3c0>
 <124a59a3-a603-701b-e3bb-61e83d70b20d@intel.com>
 <20200707211244.GN20096@linux.intel.com>
 <19b97891-bbb0-1061-5971-549a386f7cfb@intel.com>
 <31eb5b00-9e2a-aa10-0f20-4abc3cd35112@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31eb5b00-9e2a-aa10-0f20-4abc3cd35112@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 07, 2020 at 11:51:54PM +0200, Paolo Bonzini wrote:
> On 07/07/20 23:48, Dave Hansen wrote:
> > On 7/7/20 2:12 PM, Sean Christopherson wrote:
> >>>>> Let's say Intel loses its marbles and adds a CR4 bit that lets userspace
> >>>>> write to kernel memory.  Linux won't set it, but an attacker would go
> >>>>> after it, first thing.
> >> That's an orthogonal to pinning.  KVM never lets the guest set CR4 bits that
> >> are unknown to KVM.  Supporting CR4.NO_MARBLES would require an explicit KVM
> >> change to allow it to be set by the guest, and would also require a userspace
> >> VMM to expose NO_MARBLES to the guest.
> >>
> >> That being said, this series should supporting pinning as much as possible,
> >> i.e. if the bit can be exposed to the guest and doesn't require special
> >> handling in KVM, allow it to be pinned.  E.g. TS is a special case because
> >> pinning would require additional emulator support and IMO isn't interesting
> >> enough to justify the extra complexity.  At a glance, I don't see anything
> >> that would prevent pinning FSGSBASE.
> > 
> > Thanks for filling in the KVM picture.
> > 
> > If we're supporting as much pinning as possible, can we also add
> > something to make it inconvenient for someone to both make a CR4 bit
> > known to KVM *and* ignore the pinning aspects?
> > 
> > We should really make folks think about it.  Something like:
> > 
> > #define KVM_CR4_KNOWN 0xff
> > #define KVM_CR4_PIN_ALLOWED 0xf0
> > #define KVM_CR4_PIN_NOT_ALLOWED 0x0f
> > 
> > BUILD_BUG_ON(KVM_CR4_KNOWN !=
> >              (KVM_CR4_PIN_ALLOWED|KVM_CR4_PIN_NOT_ALLOWED));
> > 
> > So someone *MUST* make an active declaration about new bits being pinned
> > or not?
> 
> I would just make all unknown bits pinnable (or perhaps all CR4 bits in
> general).
> 

Sounds good. I'll make it this way in the next revision. I'll do the same for
CR0 (unless I hear otherwise). I've added the last paragraph here under the
ALLOWED MSRs data section.

data:
        Bits which may be pinned.

        Attempting to pin bits other than these will result in a failure when
        writing to the respective CR pinned MSR.

        Bits which are allowed to be pinned default to WP for CR0 and SMEP,
        SMAP, and UMIP for CR4.

        The host VMM may modify the set of allowed bits. However, only the above
        have been tested to work. Allowing the guest to pin other bits may or
        may not be compatible with KVM.
