Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB412A70DC
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Nov 2020 23:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730366AbgKDWyl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Nov 2020 17:54:41 -0500
Received: from mga01.intel.com ([192.55.52.88]:34988 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728301AbgKDWyk (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Nov 2020 17:54:40 -0500
IronPort-SDR: 4WoQSYiZ0697gYl35K7fAfTopxokDJQITXuHLJKqkMjr1WI3tyKKzSSom7Zdib6EXK9ej5t5Sq
 Pdtv2AsL411g==
X-IronPort-AV: E=McAfee;i="6000,8403,9795"; a="187165986"
X-IronPort-AV: E=Sophos;i="5.77,451,1596524400"; 
   d="scan'208";a="187165986"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 14:54:40 -0800
IronPort-SDR: laAzFrVJ4b18lJiO5pTuJbaqaj+thHKns+evfRlz6qK4Gx1buM1+VrrUaKOiyle0oLYkYbAqaN
 w1JYgldLrPPQ==
X-IronPort-AV: E=Sophos;i="5.77,451,1596524400"; 
   d="scan'208";a="320972878"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 14:54:39 -0800
Date:   Wed, 4 Nov 2020 14:54:39 -0800
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
Message-ID: <20201104225438.GF1531489@iweiny-DESK2.sc.intel.com>
References: <20201102205320.1458656-1-ira.weiny@intel.com>
 <871rhb8h73.fsf@nanos.tec.linutronix.de>
 <20201104174643.GC1531489@iweiny-DESK2.sc.intel.com>
 <87k0v0lr4r.fsf@nanos.tec.linutronix.de>
 <20201104224554.GE1531489@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104224554.GE1531489@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 04, 2020 at 02:45:54PM -0800, 'Ira Weiny' wrote:
> On Wed, Nov 04, 2020 at 11:00:04PM +0100, Thomas Gleixner wrote:
> > On Wed, Nov 04 2020 at 09:46, Ira Weiny wrote:
> > > On Tue, Nov 03, 2020 at 12:36:16AM +0100, Thomas Gleixner wrote:
> > >> This is the wrong ordering, really.
> > >> 
> > >>      x86/entry: Move nmi entry/exit into common code
> > >> 
> > >> is a general cleanup and has absolutely nothing to do with PKRS.So this
> > >> wants to go first.
> > >
> > > Sorry, yes this should be a pre-patch.
> > 
> > I picked it out of the series and applied it to tip core/entry as I have
> > other stuff coming up in that area. 
> 
> Thanks!  I'll rebase to that tree.
> 
> I assume you fixed the spelling error?  Sorry about that.

I'll fix it and send with the other spelling errors I found.

Ira
