Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916BF29A546
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Oct 2020 08:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507353AbgJ0HLQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Oct 2020 03:11:16 -0400
Received: from mga11.intel.com ([192.55.52.93]:1077 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390835AbgJ0HLQ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Oct 2020 03:11:16 -0400
IronPort-SDR: bHTFB4LiCz3fGH6e3b2LSe6mKCDgTCOvaCqFDV+G6jZoAuE8E8MUWl570i+9W+9q6V7eDYw1Mf
 xSZgrD4FjcWw==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="164537400"
X-IronPort-AV: E=Sophos;i="5.77,422,1596524400"; 
   d="scan'208";a="164537400"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 00:11:15 -0700
IronPort-SDR: yxpbvNXqR2ZH8VELzLKdveHPiLfaOg4FP6eotaVuipb+Li1gAU22E4WQmw0d7T2iCHSawR5QAw
 LXDe2LDQzbVA==
X-IronPort-AV: E=Sophos;i="5.77,422,1596524400"; 
   d="scan'208";a="535680174"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 00:11:15 -0700
Date:   Tue, 27 Oct 2020 00:11:14 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 07/10] x86/entry: Pass irqentry_state_t by reference
Message-ID: <20201027071114.GN534324@iweiny-DESK2.sc.intel.com>
References: <20201022222701.887660-1-ira.weiny@intel.com>
 <20201022222701.887660-8-ira.weiny@intel.com>
 <87y2jw4ne6.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2jw4ne6.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 23, 2020 at 11:56:33PM +0200, Thomas Gleixner wrote:
> On Thu, Oct 22 2020 at 15:26, ira weiny wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> >
> > In preparation for adding PKS information to struct irqentry_state_t
> > change all call sites and usages to pass the struct by reference
> > instead of by value.
> 
> This still does not explain WHY you need to do that. 'Preparation' is a
> pretty useless information.
> 
> What is the actual reason for this? Just because PKS information feels
> better that way?
> 
> Also what is PKS information? Changelogs have to make sense on their own
> and not only in the context of a larger series of changes.

I've reworded this to explain the addition of new members which would make
passing by value less efficient with additional structure changes being added
later in the series.

> 
> > While we are editing the call sites it is a good time to standardize on
> > the name 'irq_state'.
> 
>   While at it change all usage sites to consistently use the variable
>   name 'irq_state'.
> 
> Or something like that. See Documentation/process/...

Sorry, bad habit.

Fixed.

Thanks,
Ira

> 
> Thanks,
> 
>         tglx
> 
