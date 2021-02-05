Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F10311859
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Feb 2021 03:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhBFCfL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Feb 2021 21:35:11 -0500
Received: from mga17.intel.com ([192.55.52.151]:63121 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230179AbhBFCco (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Feb 2021 21:32:44 -0500
IronPort-SDR: e82Z/HV77K0RwfvWAG1RxHw8KWJc44XrZkABKWI/8Qi2A6VwXqcaydkpdflxmRzZ2eAdLmreIL
 u/0TNtR5WM+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="161249243"
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="161249243"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 14:16:23 -0800
IronPort-SDR: NRaIsHFlw3uFgHarMm4gK9o7SP+5teoIs0kpMxEdiegNa2O3M7s2Wf+xkk6NnQ8XS9giwlZgWq
 Vu92meHKWIDA==
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="394033953"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 14:16:23 -0800
Date:   Fri, 5 Feb 2021 14:16:21 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, corbet@lwn.net,
        peterz@infradead.org, keescook@chromium.org, rafael@kernel.org,
        lenb@kernel.org, james.morse@arm.com, bp@alien8.de,
        devel@driverdev.osuosl.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 1/7] seqnum_ops: Introduce Sequence Number Ops
Message-ID: <20210205221621.GA74059@agluck-desk2.amr.corp.intel.com>
References: <cover.1612314468.git.skhan@linuxfoundation.org>
 <23f6347a7bb9f902babe7351f71b23644035673d.1612314468.git.skhan@linuxfoundation.org>
 <YB0WzBnLd+OcpxEE@kroah.com>
 <2fe15f90-2e33-d018-0d5d-cabe3846ed98@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fe15f90-2e33-d018-0d5d-cabe3846ed98@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 05, 2021 at 01:03:18PM -0700, Shuah Khan wrote:
> On 2/5/21 2:58 AM, Greg KH wrote:
> > On Wed, Feb 03, 2021 at 11:11:57AM -0700, Shuah Khan wrote:
> > > +static inline u32 seqnum32_inc(struct seqnum32 *seq)
> > > +{
> > > +	atomic_t val = ATOMIC_INIT(seq->seqnum);
> > > +
> > > +	seq->seqnum = (u32) atomic_inc_return(&val);
> > > +	if (seq->seqnum >= UINT_MAX)
> > > +		pr_info("Sequence Number overflow %u detected\n",
> > > +			seq->seqnum);
> > > +	return seq->seqnum;
> > 
> > As Peter points out, this is doing doing what you think it is doing :(
> > 
> > Why do you not just have seq->seqnum be a real atomic variable?  Trying
> > to switch to/from one like this does not work as there is no
> > "atomic-ness" happening here at all.
> > 
> 
> Yes. This is sloppy on my part. As Peter and Rafael also pointed. I have
> to start paying more attention to my inner voice.

What's the end goal with this sequence number type?

Apart from the functional issues with this code already pointed
out, it doesn't seem overly useful to just print the *value* of
the sequence number when it hits the max value.  It might be
more helpful if each instance had a seq->name field that is
used here to tell the user *which* user of sequence numbers
had seen the wrap arounnd.

But that just begs the question of what should users of sequence
numbers do when wrap around occurs? Any user that can run through
sequence numbers at greater than 10 Hz is going to cause a problem
for systems that stay running for years.

Maybe you should force users to code for wraparound by initializing
to something like 0xffffff00 so that they all get a wraparound event
quickly, rather than slowly, (same as was done with jiffies)?
