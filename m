Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C85D217A07
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jul 2020 23:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbgGGVMt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Jul 2020 17:12:49 -0400
Received: from mga12.intel.com ([192.55.52.136]:52288 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728001AbgGGVMs (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Jul 2020 17:12:48 -0400
IronPort-SDR: 9bLxoIDZriLgmu3OdmsHa06/6JHQiDrg/vNAWXZDyfFw5CD5wN4zP15/9kRkRDSWg25q03qE8Q
 ziH+3l3whr8w==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="127292903"
X-IronPort-AV: E=Sophos;i="5.75,325,1589266800"; 
   d="scan'208";a="127292903"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 14:12:44 -0700
IronPort-SDR: JTcQq4O8pgB/WDWxc4jQef5Ro2nDaeHPpTG34Y0JkkFdPUSm/D+lUIgdm39EQVE4KKKPmr10aY
 4I46+pIegejw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,325,1589266800"; 
   d="scan'208";a="279735787"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.152])
  by orsmga003.jf.intel.com with ESMTP; 07 Jul 2020 14:12:44 -0700
Date:   Tue, 7 Jul 2020 14:12:44 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Andersen, John" <john.s.andersen@intel.com>, corbet@lwn.net,
        pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, shuah@kernel.org,
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
Message-ID: <20200707211244.GN20096@linux.intel.com>
References: <20200617190757.27081-1-john.s.andersen@intel.com>
 <20200617190757.27081-3-john.s.andersen@intel.com>
 <0fa9682e-59d4-75f7-366f-103d6b8e71b8@intel.com>
 <20200618144314.GB23@258ff54ff3c0>
 <124a59a3-a603-701b-e3bb-61e83d70b20d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <124a59a3-a603-701b-e3bb-61e83d70b20d@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 18, 2020 at 07:51:10AM -0700, Dave Hansen wrote:
> On 6/18/20 7:43 AM, Andersen, John wrote:
> > On Thu, Jun 18, 2020 at 07:18:09AM -0700, Dave Hansen wrote:
> >> On 6/17/20 12:07 PM, John Andersen wrote:
> >>> +#define KVM_CR0_PIN_ALLOWED	(X86_CR0_WP)
> >>> +#define KVM_CR4_PIN_ALLOWED	(X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_UMIP)
> >>
> >> Why *is* there an allowed set?  Why don't we just allow everything?
> >>
> >> Shouldn't we also pin any unknown bits?  The CR4.FSGSBASE bit is an
> >> example of something that showed up CPUs without Linux knowing about it.
> >>  If set, it causes problems.  This set couldn't have helped FSGSBASE
> >> because it is not in the allowed set.
> >>
> >> Let's say Intel loses its marbles and adds a CR4 bit that lets userspace
> >> write to kernel memory.  Linux won't set it, but an attacker would go
> >> after it, first thing.

That's an orthogonal to pinning.  KVM never lets the guest set CR4 bits that
are unknown to KVM.  Supporting CR4.NO_MARBLES would require an explicit KVM
change to allow it to be set by the guest, and would also require a userspace
VMM to expose NO_MARBLES to the guest.

That being said, this series should supporting pinning as much as possible,
i.e. if the bit can be exposed to the guest and doesn't require special
handling in KVM, allow it to be pinned.  E.g. TS is a special case because
pinning would require additional emulator support and IMO isn't interesting
enough to justify the extra complexity.  At a glance, I don't see anything
that would prevent pinning FSGSBASE.
