Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3366B1FF581
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jun 2020 16:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731319AbgFROrP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Jun 2020 10:47:15 -0400
Received: from mga18.intel.com ([134.134.136.126]:37512 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730972AbgFROqq (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Jun 2020 10:46:46 -0400
IronPort-SDR: YTPfJnLBCgiQD2m3BnlYGtIwhquabKGHkC8cHFoqX6IRZFjZd13FiL7KkPnYqKznpUThCKc0rg
 sQyzN7bFQhcQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9655"; a="129934642"
X-IronPort-AV: E=Sophos;i="5.75,526,1589266800"; 
   d="scan'208";a="129934642"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 07:46:42 -0700
IronPort-SDR: WGKHqT4NW9u/bPt4hQJ2PRe+VhtNaO04N5bA77bBJhGDBMYgmIJugixFWDKjUdJZV7JIGT1nS8
 X5yhIIUDsMHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,526,1589266800"; 
   d="scan'208";a="477218525"
Received: from otcsectest.jf.intel.com (HELO 258ff54ff3c0) ([10.54.30.81])
  by fmsmga006.fm.intel.com with ESMTP; 18 Jun 2020 07:46:39 -0700
Date:   Thu, 18 Jun 2020 14:43:14 +0000
From:   "Andersen, John" <john.s.andersen@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     corbet@lwn.net, pbonzini@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        shuah@kernel.org, sean.j.christopherson@intel.com,
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
Message-ID: <20200618144314.GB23@258ff54ff3c0>
References: <20200617190757.27081-1-john.s.andersen@intel.com>
 <20200617190757.27081-3-john.s.andersen@intel.com>
 <0fa9682e-59d4-75f7-366f-103d6b8e71b8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fa9682e-59d4-75f7-366f-103d6b8e71b8@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 18, 2020 at 07:18:09AM -0700, Dave Hansen wrote:
> On 6/17/20 12:07 PM, John Andersen wrote:
> > +#define KVM_CR0_PIN_ALLOWED	(X86_CR0_WP)
> > +#define KVM_CR4_PIN_ALLOWED	(X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_UMIP)
> 
> Why *is* there an allowed set?  Why don't we just allow everything?
> 
> Shouldn't we also pin any unknown bits?  The CR4.FSGSBASE bit is an
> example of something that showed up CPUs without Linux knowing about it.
>  If set, it causes problems.  This set couldn't have helped FSGSBASE
> because it is not in the allowed set.
> 
> Let's say Intel loses its marbles and adds a CR4 bit that lets userspace
> write to kernel memory.  Linux won't set it, but an attacker would go
> after it, first thing.

The allowed set came about because there were comments from internal review
where it was said that allowing the guest to pin TS and MP adds unnecessary
complexity.

Also because KVM always intercepts these bits via the CR0/4_GUEST_HOST_MASK. If
we allow setting of any bits, then we have to add some infrastructure for
modifying the mask when pinned bits are updated. I have a patch for that if we
want to go that route, but it doesn't account for the added complexity
mentioned above.
