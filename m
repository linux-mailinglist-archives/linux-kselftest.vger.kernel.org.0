Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73B98102FDA
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2019 00:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfKSXSX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Nov 2019 18:18:23 -0500
Received: from mga12.intel.com ([192.55.52.136]:62268 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbfKSXSX (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Nov 2019 18:18:23 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2019 15:18:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,219,1571727600"; 
   d="scan'208";a="357256816"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by orsmga004.jf.intel.com with ESMTP; 19 Nov 2019 15:18:22 -0800
Date:   Tue, 19 Nov 2019 15:18:22 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Tony Luck <tony.luck@intel.com>,
        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: Re: [PATCH v3 01/19] x86/msr-index: Clean up bit defines for
 IA32_FEATURE_CONTROL MSR
Message-ID: <20191119231822.GA6855@linux.intel.com>
References: <20191119031240.7779-1-sean.j.christopherson@intel.com>
 <20191119031240.7779-2-sean.j.christopherson@intel.com>
 <20191119111445.GB27787@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119111445.GB27787@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 19, 2019 at 12:15:08PM +0100, Borislav Petkov wrote:
> On Mon, Nov 18, 2019 at 07:12:22PM -0800, Sean Christopherson wrote:
> > As pointed out by Boris, the defines for bits in IA32_FEATURE_CONTROL
> > are quite a mouthful, especially the VMX bits which must differentiate
> > between enabling VMX inside and outside SMX (TXT) operation.  Rename the
> > bit defines to abbreviate FEATURE_CONTROL as FEAT_CTL so that they're a
> > little friendlier on the eyes.  Keep the full name for the MSR itself to
> > help even the most obtuse reader decipher the abbreviation, and to match
> > the name used by the Intel SDM.
> > 
> > Opportunistically fix a few other annoyances with the defines:
> > 
> >   - Relocate the bit defines so that they immediately follow the MSR
> >     define, e.g. aren't mistaken as belonging to MISC_FEATURE_CONTROL.
> >   - Add whitespace around the block of feature control defines to make
> >     it clear that FEAT_CTL is indeed short for FEATURE_CONTROL.
> >   - Use BIT() instead of manually encoding the bit shift.
> >   - Use "VMX" instead of "VMXON" to match the SDM.
> >   - Append "_ENABLED" to the LMCE bit to be consistent with the verbiage
> >     used for all other feature control bits.  (LCME is an acronym for
> >     Local Machine Check Exception, i.e. LMCE_ENABLED is not redundant).
> 
> Sure but SDM calls it LMCE_ON. What is our current decision on sticking
> to SDM bit names? I guess we don't...
> 
> But above you say "to match the SDM"...

Ugh.  Match the SDM unless it's obviously "wrong"?  :-)  It might literally
be the only instance of the SDM using "on" instead of "enable(d)" for an
MSR or CR bit.  The SDM even refers to it as an enable bit, e.g. "platform
software has not enabled LMCE by setting IA32_FEATURE_CONTROL.LMCE_ON (bit 20)".

Whining aside, I'm ok going with LMCE_ON, I have a feeling "on" was
deliberately chosen differentiate it from IA32_MCG_EXT_CTL.LMCE_EN.
