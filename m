Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40080B50C8
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2019 16:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbfIQOyN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Sep 2019 10:54:13 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:44531 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbfIQOyN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Sep 2019 10:54:13 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id C92BF3C0579;
        Tue, 17 Sep 2019 16:54:09 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id C98Q-R7PqAfm; Tue, 17 Sep 2019 16:54:04 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 0D0F33C00C4;
        Tue, 17 Sep 2019 16:54:04 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.468.0; Tue, 17 Sep
 2019 16:54:03 +0200
Date:   Tue, 17 Sep 2019 16:54:00 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     shuah <shuah@kernel.org>
CC:     "George G. Davis" <george_davis@mentor.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Colin Ian King <colin.king@canonical.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] selftests: watchdog: Validate optional file argument
Message-ID: <20190917145400.GA14341@vmlxhi-102.adit-jv.com>
References: <1568659751-1845-1-git-send-email-george_davis@mentor.com>
 <fa008fd8-f867-b80e-84ed-148e1630c09e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fa008fd8-f867-b80e-84ed-148e1630c09e@kernel.org>
User-Agent: Mutt/1.12.1+40 (7f8642d4ee82) (2019-06-28)
X-Originating-IP: [10.72.93.184]
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Shuah,

On Mon, Sep 16, 2019 at 07:19:35PM -0600, shuah wrote:
> On 9/16/19 12:49 PM, George G. Davis wrote:
> > As reported by Eugeniu Rosca, a side of affect of commit c3f2490d6e92
> > ("selftests: watchdog: Add optional file argument") is that arbitrary files
> > may be opened for watchdog testing, e.g.
> > 
> 
> You don't need to say this here since you are already have a
> Reported-by tag. 

This looks like asking people to stick to your personal taste which
BTW doesn't really match the patterns established in Linux community.

With a bit of scripting, I am able to find around 4600 vanilla commits
which happen to mention the name of the reporter in addition to
Reported-by: https://paste.ubuntu.com/p/wNXfdGCJbX/ .

I really don't care if my name is mentioned once or twice, but I do
believe that requesting a new patch revision just based on this criteria
is nonsense. Can you please revise your review criteria?

> You are missing the Fixes tag.

The _fixed_ commit didn't land in vanilla as of v5.3-2061-gad062195731.
It is still undergoing the linux-next testing, where it can be found as
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=c3f2490d6e92
("selftests: watchdog: Add optional file argument").

Since the _fixed_ commit is not yet in mainline, there is no Fixes tag
included in this patch.

> > ./watchdog-test  -f /dev/zero
> > Watchdog Ticking Away!
> > 
> > To prevent watchdog-test from operating on non-watchdog device files,
> > validate that a file is indeed a watchdog device via an
> > ioctl(WDIOC_GETSUPPORT) call.
> > 
> > While we're at it, since the watchdog_info is available as a result of the
> > ioctl(WDIOC_GETSUPPORT) call, add a command line option to optionally show
> > the watchdog_info.
> > 
> 
> Let's try this again. I want two patches. The first one with Fixes tag.
> The first patch might be candidate for going into stables.

This makes me wonder if you figured out the relationship and timeline
of this and the fixed patches. Since both are going to be part of the
same kernel release (v5.4), why do you worry about the stable updates?

> 
> The -i (info) should be a separate patch. This won't go into stables.

Please, see the above. I don't think this patch, or any of its parts,
are candidate for linux-stable.

> 
> Please write a clear commit log. The following will help:
> 
> https://chris.beams.io/posts/git-commit/

With all my appreciation for https://chris.beams.io/, I see no
contributions from him in Linux whatsoever. Given that Linux commit
descriptions and summary lines obey specific/unique rules, I doubt this
is the best guide to provide to your contributors :)

With the above inputs, can you please outline your expectations
precisely which changes are expected in the next patch revision, if at
all needed?

-- 
Best Regards,
Eugeniu
