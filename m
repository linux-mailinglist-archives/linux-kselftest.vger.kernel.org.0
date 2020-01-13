Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BED5A139AA3
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2020 21:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbgAMUQL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jan 2020 15:16:11 -0500
Received: from mga01.intel.com ([192.55.52.88]:25413 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbgAMUQL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jan 2020 15:16:11 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jan 2020 12:16:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,430,1571727600"; 
   d="scan'208";a="273121191"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Jan 2020 12:16:10 -0800
Date:   Mon, 13 Jan 2020 12:16:10 -0800
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
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: Re: [PATCH] KVM: VMX: Rename define to CPU_BASED_USE_TSC_OFFSETTING
Message-ID: <20200113201610.GE2322@linux.intel.com>
References: <20191221044513.21680-1-sean.j.christopherson@intel.com>
 <20191221044513.21680-18-sean.j.christopherson@intel.com>
 <20200113183228.GO13310@zn.tnic>
 <20200113183705.GL1175@linux.intel.com>
 <20200113183823.GP13310@zn.tnic>
 <20200113184217.GA2216@linux.intel.com>
 <20200113185216.GQ13310@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113185216.GQ13310@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 13, 2020 at 07:52:16PM +0100, Borislav Petkov wrote:
> On Mon, Jan 13, 2020 at 10:42:17AM -0800, Sean Christopherson wrote:
> > > Doesn't bother me, I could do it in a patch ontop. But your call.
> > 
> > No objection here.
> 
> Something like this:
> 
> ---
> From: Borislav Petkov <bp@suse.de>
> 
> ... so that "offsetting" is spelled the same as the respective VMX feature
> bit VMX_FEATURE_TSC_OFFSETTING.
> 
> No functional changes.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---

Reviewed-and-tested-by: Sean Christopherson <sean.j.christopherson@intel.com>
