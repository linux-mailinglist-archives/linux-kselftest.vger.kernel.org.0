Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4EEE1FF829
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jun 2020 17:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgFRPw6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Jun 2020 11:52:58 -0400
Received: from mga14.intel.com ([192.55.52.115]:58067 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727911AbgFRPw6 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Jun 2020 11:52:58 -0400
IronPort-SDR: zz43w2BAAasn4uYs6kw3LtkM3X323TZTDNMMY35jUR2bO0DDhj5n4j/NuluZmxsdce64e6hqCN
 ReScRyT47BAg==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="141701484"
X-IronPort-AV: E=Sophos;i="5.75,251,1589266800"; 
   d="scan'208";a="141701484"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 08:52:56 -0700
IronPort-SDR: Rz7wj+h3c6y5PnE7mt0HLs+WCimZP8shyO9jjYR92TH5XPP+l4Rs1D7su9MB1R/gF705XCWoaj
 /weqIcFrTVQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,251,1589266800"; 
   d="scan'208";a="277665815"
Received: from otcsectest.jf.intel.com (HELO 258ff54ff3c0) ([10.54.30.81])
  by orsmga006.jf.intel.com with ESMTP; 18 Jun 2020 08:52:56 -0700
Date:   Thu, 18 Jun 2020 15:49:32 +0000
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
Subject: Re: [PATCH 4/4] X86: Use KVM CR pin MSRs
Message-ID: <20200618154931.GD23@258ff54ff3c0>
References: <20200617190757.27081-1-john.s.andersen@intel.com>
 <20200617190757.27081-5-john.s.andersen@intel.com>
 <b5d791f9-1708-9715-e03d-4618d1b27d05@intel.com>
 <20200618152649.GC23@258ff54ff3c0>
 <5706af0c-e426-91bc-4c38-d1203cf1b3b7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5706af0c-e426-91bc-4c38-d1203cf1b3b7@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 18, 2020 at 08:38:06AM -0700, Dave Hansen wrote:
> On 6/18/20 8:26 AM, Andersen, John wrote:
> > On Thu, Jun 18, 2020 at 07:41:04AM -0700, Dave Hansen wrote:
> >>> +config PARAVIRT_CR_PIN
> >>> +       bool "Paravirtual bit pinning for CR0 and CR4"
> >>> +       depends on KVM_GUEST
> >>> +       help
> >>> +         Select this option to have the virtualised guest request that the
> >>> +         hypervisor disallow it from disabling protections set in control
> >>> +         registers. The hypervisor will prevent exploits from disabling
> >>> +         features such as SMEP, SMAP, UMIP, and WP.
> >>
> >> I'm confused.  Does this add support for ""Paravirtual bit pinning", or
> >> actually tell the guest to request pinning by default?
> >>
> >> It says "Select this option to have the virtualised guest request...",
> >> which makes it sound like it affects the default rather than the
> >> availability of the option.
> > 
> > How about this
> > 
> > Select this option to request protection of SMEP, SMAP, UMIP, and WP
> > control register bits when running paravirtualized under KVM. Protection will
> > be active provided the feature is available host side and kexec is disabled via
> > kconfig or the command line for the guest requesting protection.
> 
> It still isn't very clear to me.
> 
> Let's pull the config option out of this patch.  Enable the feature by
> default and do the command-line processing in this patch.
> 
> If you still think a Kconfig option is helpful, add it in a separate
> patch calling out the deficiencies with the boot-time options.

That's right we're going to pull it out anyway and just disable if the
disable_pv_cr_pin command line option is set. Oops. That solves that.

Thank you very much for your review Dave
