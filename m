Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 782402B502A
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Nov 2020 19:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgKPStV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Nov 2020 13:49:21 -0500
Received: from mga02.intel.com ([134.134.136.20]:50413 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727701AbgKPStV (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Nov 2020 13:49:21 -0500
IronPort-SDR: isxPLhZX6e4/B74nh8z4uG3vOKzpEKkpbZyptzktclqw6xWlfNfccQ56UOcem5Mvd4UkjTQlnY
 R31xfgo1knuw==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="157821919"
X-IronPort-AV: E=Sophos;i="5.77,483,1596524400"; 
   d="scan'208";a="157821919"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 10:49:18 -0800
IronPort-SDR: QM3K1Df9J/Wg+oJAcVfa83qY/TNr4BOrYcj8zI8YrrZ97jsEsonZ8J/uK1N6DUXothgxIsiUVW
 Pzs792lhR6LA==
X-IronPort-AV: E=Sophos;i="5.77,483,1596524400"; 
   d="scan'208";a="533514829"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 10:49:17 -0800
Date:   Mon, 16 Nov 2020 10:49:16 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V3 05/10] x86/entry: Pass irqentry_state_t by reference
Message-ID: <20201116184916.GA722447@iweiny-DESK2.sc.intel.com>
References: <20201106232908.364581-1-ira.weiny@intel.com>
 <20201106232908.364581-6-ira.weiny@intel.com>
 <87mtzi8n0z.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mtzi8n0z.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Nov 15, 2020 at 07:58:52PM +0100, Thomas Gleixner wrote:
> Ira,
> 
> On Fri, Nov 06 2020 at 15:29, ira weiny wrote:
> 
> Subject prefix wants to 'entry:'. This changes generic code and the x86
> part is just required to fix the generic code change.

Sorry, yes that was carried incorrectly from earlier versions.

> 
> > Currently struct irqentry_state_t only contains a single bool value
> > which makes passing it by value is reasonable.  However, future patches
> > propose to add information to this struct, for example the PKRS
> > register/thread state.
> >
> > Adding information to irqentry_state_t makes passing by value less
> > efficient.  Therefore, change the entry/exit calls to pass irq_state by
> > reference.
> 
> The PKRS muck needs to add an u32 to that struct. So how is that a
> problem?

There are more fields to be added for the kmap/pmem support.  So this will be
needed eventually.  Even though it is not strictly necessary in the next patch.

> 
> The resulting struct still fits into 64bit which is by far more
> efficiently passed by value than by reference. So which problem are you
> solving here?

I'm getting ahead of myself a bit.  I will be adding more fields for the
kmap/pmem tracking.

Would you accept just a clean up for the variable names in this patch?  I could
then add the pass by reference when I add the new fields later.  Or would an
update to the commit message be ok to land this now?

Ira

> 
> Thanks
> 
>         tglx
> 
