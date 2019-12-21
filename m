Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABCE1286CD
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Dec 2019 04:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfLUDo6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Dec 2019 22:44:58 -0500
Received: from mga06.intel.com ([134.134.136.31]:51368 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726613AbfLUDo5 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Dec 2019 22:44:57 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Dec 2019 19:44:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,338,1571727600"; 
   d="scan'208";a="228789519"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by orsmga002.jf.intel.com with ESMTP; 20 Dec 2019 19:44:54 -0800
Date:   Fri, 20 Dec 2019 19:44:54 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Tony Luck <tony.luck@intel.com>,
        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>,
        Len Brown <lenb@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: Re: [PATCH v4 00/19] x86/cpu: Clean up handling of VMX features
Message-ID: <20191221034454.GB22351@linux.intel.com>
References: <20191128014016.4389-1-sean.j.christopherson@intel.com>
 <20191212140755.GF4991@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212140755.GF4991@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Dec 12, 2019 at 03:07:55PM +0100, Borislav Petkov wrote:
> On Wed, Nov 27, 2019 at 05:39:57PM -0800, Sean Christopherson wrote:
> > Clean up a handful of interrelated warts in the kernel's handling of VMX:
> > 
> >   - Enable VMX in IA32_FEATURE_CONTROL during boot instead of on-demand
> >     during KVM load to avoid future contention over IA32_FEATURE_CONTROL.
> > 
> >   - Rework VMX feature reporting so that it is accurate and up-to-date,
> >     now and in the future.
> > 
> >   - Consolidate code across CPUs that support VMX.
> 
> Ok, this is shaping up slowly to be upstream-ready, AFAICT.
> 
> How are we merging the next revision, after the minor things have been
> taken care of? Through tip?
> 
> Paolo?

Tip would be my preference, we'll need to rebase the SGX series on this
and tip would probably be slightly more convenient for that. 
