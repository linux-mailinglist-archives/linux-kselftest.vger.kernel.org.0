Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4F2A10DABE
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Nov 2019 22:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfK2VGa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Nov 2019 16:06:30 -0500
Received: from mga03.intel.com ([134.134.136.65]:18073 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727110AbfK2VGa (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Nov 2019 16:06:30 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2019 13:06:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,258,1571727600"; 
   d="scan'208";a="199904363"
Received: from kryanx-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.22.23])
  by orsmga007.jf.intel.com with ESMTP; 29 Nov 2019 13:06:17 -0800
Date:   Fri, 29 Nov 2019 23:06:12 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
        linux-kselftest@vger.kernel.org, Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v3 01/19] x86/msr-index: Clean up bit defines for
 IA32_FEATURE_CONTROL MSR
Message-ID: <20191129210551.GC12055@linux.intel.com>
References: <20191119031240.7779-1-sean.j.christopherson@intel.com>
 <20191119031240.7779-2-sean.j.christopherson@intel.com>
 <20191121094614.GA20907@linux.intel.com>
 <20191121221408.GF16617@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121221408.GF16617@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 21, 2019 at 02:14:08PM -0800, Sean Christopherson wrote:
> On Thu, Nov 21, 2019 at 11:46:14AM +0200, Jarkko Sakkinen wrote:
> > On Mon, Nov 18, 2019 at 07:12:22PM -0800, Sean Christopherson wrote:
> > > As pointed out by Boris, the defines for bits in IA32_FEATURE_CONTROL
> > > are quite a mouthful, especially the VMX bits which must differentiate
> > > between enabling VMX inside and outside SMX (TXT) operation.  Rename the
> > > bit defines to abbreviate FEATURE_CONTROL as FEAT_CTL so that they're a
> > > little friendlier on the eyes.  Keep the full name for the MSR itself to
> > > help even the most obtuse reader decipher the abbreviation, and to match
> > > the name used by the Intel SDM.
> > 
> > If you anyway shorten the prefix, why not then go directly to FT_CTL?
> > It is as obvious as FEAT_CTL is. Given the exhausting long variable
> > names like FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX this would be worth of
> > considering.
> 
> If we're going to rename the function and file, I think we should stick
> with the slightly longer FEAT_CTL.  FT_CTL for the bits is ok since there
> is more context to work with, but init_ft_ctl_msr() looks weird to me.

OK.

/Jarkko
