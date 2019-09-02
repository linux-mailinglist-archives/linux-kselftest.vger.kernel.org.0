Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12666A5475
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2019 12:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730785AbfIBKx1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Sep 2019 06:53:27 -0400
Received: from foss.arm.com ([217.140.110.172]:52128 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729881AbfIBKx1 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Sep 2019 06:53:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5ACD528;
        Mon,  2 Sep 2019 03:53:26 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C6DB3F246;
        Mon,  2 Sep 2019 03:53:25 -0700 (PDT)
Date:   Mon, 2 Sep 2019 11:53:23 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     andreyknvl@google.com, shuah@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 00/11] Add arm64/signal initial kselftest support
Message-ID: <20190902105322.GL27757@arm.com>
References: <20190802170300.20662-1-cristian.marussi@arm.com>
 <20190813162254.GX10425@arm.com>
 <b4c9cb22-6e08-8096-addb-4ac267fc0a84@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4c9cb22-6e08-8096-addb-4ac267fc0a84@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 30, 2019 at 05:40:42PM +0100, Cristian Marussi wrote:
> Hi
> 
> On 13/08/2019 17:22, Dave Martin wrote:
> > On Fri, Aug 02, 2019 at 06:02:49PM +0100, Cristian Marussi wrote:
> >> Hi
> >>
> >> this patchset aims to add the initial arch-specific arm64 support to
> >> kselftest starting with signals-related test-cases.
> >> A common internal test-case layout is proposed which then it is anyway
> >> wired-up to the toplevel kselftest Makefile, so that it should be possible
> >> at the end to run it on an arm64 target in the usual way with KSFT.
> > 
> > The tests look like a reasonable base overall and something that we can
> > extend later as needed.
> > 
> > There are various minor things that need attention -- see my comments on
> > the individual patches.  Apart for some things that can be factored out,
> > I don't think any of it involves redesign.
> > 
> > 
> > A few general comments:
> > 
> >  * Please wrap all commit messages to <= 75 chars, and follow the other
> >    guidelines about commit messages in
> >    Documentation/process/submitting-patches.rst).
> > 
> >  * Remember to run scripts/checkpatch.pl on your patches.  Currently
> >    various issues are reported: they should mostly be trivial to fix.
> >    checkpatch does report some false positives, but most of the warnings
> >    I see look relevant.
> > 
> 
> Thanks for the review. I addressed latest issues in V4, published now.
> 
> I kept tests verbose (outputting to stderr) as of now.
> Removed as a whole standalone build/run.

The responses look reasonable, thanks for repost.

I'll take a look.

[...]

Cheers
---Dave
