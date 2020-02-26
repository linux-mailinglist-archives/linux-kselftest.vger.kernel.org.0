Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDBB1170A63
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2020 22:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbgBZVZj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Feb 2020 16:25:39 -0500
Received: from mga02.intel.com ([134.134.136.20]:51811 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727503AbgBZVZj (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Feb 2020 16:25:39 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 13:25:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,489,1574150400"; 
   d="scan'208";a="256472357"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by orsmga002.jf.intel.com with ESMTP; 26 Feb 2020 13:25:37 -0800
Date:   Wed, 26 Feb 2020 13:25:37 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     TonyWWang-oc@zhaoxin.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, bp@alien8.de, bp@suse.de,
        hpa@zytor.com, jacob.jun.pan@linux.intel.com,
        jarkko.sakkinen@linux.intel.com, jmattson@google.com,
        jolsa@redhat.com, joro@8bytes.org, kvm@vger.kernel.org,
        lenb@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-pm@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com,
        namhyung@kernel.org, pbonzini@redhat.com, peterz@infradead.org,
        rkrcmar@redhat.com, shuah@kernel.org, tglx@linutronix.de,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org
Subject: Re: [PATCH v5 13/19] x86/cpufeatures: Add flag to track whether MSR
 IA32_FEAT_CTL is configured
Message-ID: <20200226212537.GR9940@linux.intel.com>
References: <e741196d-52aa-0f5e-8f1e-a37ddf2e5025@intel.com>
 <20200225221234.GL9245@linux.intel.com>
 <1eaf6fbe-0adb-5074-3bc4-1e8327e0cdb3@intel.com>
 <20200225232900.GO9245@linux.intel.com>
 <5434303a-0742-3811-fd14-6445d296c0f0@intel.com>
 <20200226004258.GP9245@linux.intel.com>
 <a9c4b363-1569-f03e-6155-a869dd186ced@intel.com>
 <df215c4c-82f0-5b15-57c3-d304fd94ff3b@intel.com>
 <20200226205745.GQ9940@linux.intel.com>
 <9a0a7373-f469-f2ae-c218-5821f805f0d8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a0a7373-f469-f2ae-c218-5821f805f0d8@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 26, 2020 at 01:03:01PM -0800, Jacob Keller wrote:
> On 2/26/2020 12:57 PM, Sean Christopherson wrote:
> > Bummer.  Using clear_cpu_cap() instead of setup_clear_cpu_cap() was me
> > being fancy and trying to allow KVM to identify the case where VMX is
> > available and configured on some CPUs but not all.  I'll work on a fix.
> > 
> Hmm. Right. For that to work, you'd need to make this disabling happen
> significantly later, and/or fix setup_pku to somehow honor this properly.

Arguably, setup_pku() should be a little less heavy handed in updating
cpufeatures for X86_FEATURE_OSPKE, but init_ia32_feat_ctl() should also be
more robust.

I've reproduced the bug, should have a fix ready by EOD.

> But it looks like rdmsr is global and not tied to a given CPU anyways?

For better or worse, the MSR is thread scoped.
