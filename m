Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAC026C6B5
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Sep 2020 20:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbgIPSAs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Sep 2020 14:00:48 -0400
Received: from foss.arm.com ([217.140.110.172]:34856 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727291AbgIPSAk (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Sep 2020 14:00:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E251214BF;
        Wed, 16 Sep 2020 08:38:15 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91CA13F718;
        Wed, 16 Sep 2020 08:38:14 -0700 (PDT)
Date:   Wed, 16 Sep 2020 16:38:12 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Boyan Karatotev <boian4o1@gmail.com>
Cc:     Boyan Karatotev <boyan.karatotev@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        amit.kachhap@arm.com, vincenzo.frascino@arm.com,
        Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/4] kselftests/arm64: add PAuth test for whether exec()
 changes keys
Message-ID: <20200916153809.GZ6642@arm.com>
References: <20200828131606.7946-1-boyan.karatotev@arm.com>
 <20200828131606.7946-4-boyan.karatotev@arm.com>
 <20200902170052.GJ6642@arm.com>
 <70e207ea-f7c2-2c9d-e868-3ba3b6451c6f@arm.com>
 <20200907102717.GM6642@arm.com>
 <4f38a974-d5a0-87e6-3db3-647e3cc32c0e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f38a974-d5a0-87e6-3db3-647e3cc32c0e@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 15, 2020 at 04:18:28PM +0100, Boyan Karatotev wrote:
> On 07/09/2020 11:27 am, Dave Martin wrote:
> > On Thu, Sep 03, 2020 at 11:20:25AM +0100, Boyan Karatotev wrote:
> >> On 02/09/2020 18:00, Dave Martin wrote:
> >>> On Fri, Aug 28, 2020 at 02:16:05PM +0100, Boyan Karatotev wrote:
> >>>> +int exec_sign_all(struct signatures *signed_vals, size_t val)
> >>>> +{
> >>>
> >>> Could popen(3) be used here?
> >>>
> >>> Fork-and-exec is notoriously fiddly, so it's preferable to use a library
> >>> function to do it where applicable.I would love to, but the worker needs a bidirectional channel and popen
> >> only gives a unidirectional stream.
> > 
> > Ah, fair point.
> > 
> > Would it help if you created an additional pipe before calling popen()?
> > 
> > May not be worth it, though.  For one thing, wiring that extra pipe to
> > stdin or stdout in the child process would require some extra work...
> Well, I probably could, but I doubt the result would be any better. I
> agree that I'm not sure the effort is worth it and would rather keep it
> the same.

Sure, fair enough.

Ideally kselftest would provide some common code for this sort of thing,
but I guess that's a separate discussion.

Cheers
---Dave
