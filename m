Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3C725F829
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Sep 2020 12:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbgIGK1r (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Sep 2020 06:27:47 -0400
Received: from foss.arm.com ([217.140.110.172]:60084 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728186AbgIGK10 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Sep 2020 06:27:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFFFF106F;
        Mon,  7 Sep 2020 03:27:20 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7EAE33F66E;
        Mon,  7 Sep 2020 03:27:19 -0700 (PDT)
Date:   Mon, 7 Sep 2020 11:27:17 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Boyan Karatotev <boyan.karatotev@arm.com>
Cc:     Shuah Khan <shuah@kernel.org>, boian4o1@gmail.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        amit.kachhap@arm.com, vincenzo.frascino@arm.com,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/4] kselftests/arm64: add PAuth test for whether exec()
 changes keys
Message-ID: <20200907102717.GM6642@arm.com>
References: <20200828131606.7946-1-boyan.karatotev@arm.com>
 <20200828131606.7946-4-boyan.karatotev@arm.com>
 <20200902170052.GJ6642@arm.com>
 <70e207ea-f7c2-2c9d-e868-3ba3b6451c6f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70e207ea-f7c2-2c9d-e868-3ba3b6451c6f@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 03, 2020 at 11:20:25AM +0100, Boyan Karatotev wrote:
> On 02/09/2020 18:00, Dave Martin wrote:
> > On Fri, Aug 28, 2020 at 02:16:05PM +0100, Boyan Karatotev wrote:
> >> Kernel documentation states that it will change PAuth keys on exec() calls.
> >>
> >> Verify that all keys are correctly switched to new ones.
> >>
> >> Cc: Shuah Khan <shuah@kernel.org>
> >> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >> Cc: Will Deacon <will@kernel.org>
> >> Signed-off-by: Boyan Karatotev <boyan.karatotev@arm.com>
> >> ---

[...]

> >> diff --git a/tools/testing/selftests/arm64/pauth/pac.c b/tools/testing/selftests/arm64/pauth/pac.c
> >> index cdbffa8bf61e..16dea47b11c7 100644
> >> --- a/tools/testing/selftests/arm64/pauth/pac.c
> >> +++ b/tools/testing/selftests/arm64/pauth/pac.c

[...]

> >> +int exec_sign_all(struct signatures *signed_vals, size_t val)
> >> +{
> > 
> > Could popen(3) be used here?
> > 
> > Fork-and-exec is notoriously fiddly, so it's preferable to use a library
> > function to do it where applicable.I would love to, but the worker needs a bidirectional channel and popen
> only gives a unidirectional stream.

Ah, fair point.

Would it help if you created an additional pipe before calling popen()?

May not be worth it, though.  For one thing, wiring that extra pipe to
stdin or stdout in the child process would require some extra work...

Cheers
---Dave
