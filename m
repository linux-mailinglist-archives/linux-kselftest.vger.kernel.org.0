Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1902A70C4
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Nov 2020 23:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730774AbgKDWp4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Nov 2020 17:45:56 -0500
Received: from mga01.intel.com ([192.55.52.88]:34372 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728065AbgKDWpz (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Nov 2020 17:45:55 -0500
IronPort-SDR: KMCZvvaIwhvmGRrlFVZjUgxPPRBL0DkjgjLSeuQrYFjXgzH2p3I3QEfvgLi2grV6tcGl+We3Q2
 nRP7lSGIyR8g==
X-IronPort-AV: E=McAfee;i="6000,8403,9795"; a="187165107"
X-IronPort-AV: E=Sophos;i="5.77,451,1596524400"; 
   d="scan'208";a="187165107"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 14:45:55 -0800
IronPort-SDR: Yu6Av8YfU+hmZkASLaufD19grQq9zs+wMzuJdOarI6DsD7ekyU5JCuR4WDdbdtEa4Ih697xK7O
 BUokPLMnwCjg==
X-IronPort-AV: E=Sophos;i="5.77,451,1596524400"; 
   d="scan'208";a="539110386"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 14:45:54 -0800
Date:   Wed, 4 Nov 2020 14:45:54 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH V2 00/10] PKS: Add Protection Keys Supervisor (PKS)
 support
Message-ID: <20201104224554.GE1531489@iweiny-DESK2.sc.intel.com>
References: <20201102205320.1458656-1-ira.weiny@intel.com>
 <871rhb8h73.fsf@nanos.tec.linutronix.de>
 <20201104174643.GC1531489@iweiny-DESK2.sc.intel.com>
 <87k0v0lr4r.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0v0lr4r.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 04, 2020 at 11:00:04PM +0100, Thomas Gleixner wrote:
> On Wed, Nov 04 2020 at 09:46, Ira Weiny wrote:
> > On Tue, Nov 03, 2020 at 12:36:16AM +0100, Thomas Gleixner wrote:
> >> This is the wrong ordering, really.
> >> 
> >>      x86/entry: Move nmi entry/exit into common code
> >> 
> >> is a general cleanup and has absolutely nothing to do with PKRS.So this
> >> wants to go first.
> >
> > Sorry, yes this should be a pre-patch.
> 
> I picked it out of the series and applied it to tip core/entry as I have
> other stuff coming up in that area. 

Thanks!  I'll rebase to that tree.

I assume you fixed the spelling error?  Sorry about that.

Ira
