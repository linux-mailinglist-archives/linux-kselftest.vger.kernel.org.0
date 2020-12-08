Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3662D30E5
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Dec 2020 18:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgLHRXd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Dec 2020 12:23:33 -0500
Received: from mga09.intel.com ([134.134.136.24]:46494 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728510AbgLHRXc (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Dec 2020 12:23:32 -0500
IronPort-SDR: k2OaVScCk5FhknST8x3ZNPTDFlBJ/0jwRkrAoYOxpIIPTOIXwx3UcFAK20CAEGexujISkS7QRX
 ZoRnGoEMSw1Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="174079650"
X-IronPort-AV: E=Sophos;i="5.78,403,1599548400"; 
   d="scan'208";a="174079650"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 09:22:51 -0800
IronPort-SDR: 4tMCT8vGceU6karZIafhKmMgXOvVyLb2LYUpW4elgkPoxwOmo0p3IPPIPJd/KFUP4xOgwuEKcz
 tsRuwAPBPm3Q==
X-IronPort-AV: E=Sophos;i="5.78,403,1599548400"; 
   d="scan'208";a="363733327"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 09:22:51 -0800
Date:   Tue, 8 Dec 2020 09:22:51 -0800
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
Subject: Re: [PATCH V3 00/10] PKS: Add Protection Keys Supervisor (PKS)
 support V3
Message-ID: <20201208172250.GA2032506@iweiny-DESK2.sc.intel.com>
References: <20201106232908.364581-1-ira.weiny@intel.com>
 <20201207221431.GL1563847@iweiny-DESK2.sc.intel.com>
 <87v9dc2sxh.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9dc2sxh.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 08, 2020 at 04:55:54PM +0100, Thomas Gleixner wrote:
> Ira,
> 
> On Mon, Dec 07 2020 at 14:14, Ira Weiny wrote:
> > Is there any chance of this landing before the kmap stuff gets sorted out?
> 
> I have marked this as needs an update because the change log of 5/10
> sucks. https://lore.kernel.org/r/87lff1xcmv.fsf@nanos.tec.linutronix.de
> 
> > It would be nice to have this in 5.11 to build off of.
> 
> It would be nice if people follow up on review request :)

I did, but just as an update to that patch.[1]  Sorry if this caused you to
miss the response.  It would have been better for me to ping you on that patch.
:-/

I was trying to avoid a whole new series just for that single commit message.
Is that generally ok?

Is that commit message still lacking?

Ira

[1] https://lore.kernel.org/linux-doc/20201124060956.1405768-1-ira.weiny@intel.com/
