Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F59DB536F
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2019 18:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfIQQya (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Sep 2019 12:54:30 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:45116 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfIQQya (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Sep 2019 12:54:30 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id AF3913C04C0;
        Tue, 17 Sep 2019 18:54:27 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lW4yUnaoSD6L; Tue, 17 Sep 2019 18:54:21 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 7AB2A3C00C4;
        Tue, 17 Sep 2019 18:54:21 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.468.0; Tue, 17 Sep
 2019 18:54:21 +0200
Date:   Tue, 17 Sep 2019 18:54:18 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     shuah <shuah@kernel.org>
CC:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        "George G. Davis" <george_davis@mentor.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Colin Ian King <colin.king@canonical.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] selftests: watchdog: Validate optional file argument
Message-ID: <20190917165418.GA21010@vmlxhi-102.adit-jv.com>
References: <1568659751-1845-1-git-send-email-george_davis@mentor.com>
 <fa008fd8-f867-b80e-84ed-148e1630c09e@kernel.org>
 <20190917145400.GA14341@vmlxhi-102.adit-jv.com>
 <73bab70b-e22c-42b4-cfca-b4e33431b423@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <73bab70b-e22c-42b4-cfca-b4e33431b423@kernel.org>
User-Agent: Mutt/1.12.1+40 (7f8642d4ee82) (2019-06-28)
X-Originating-IP: [10.72.93.184]
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Shuah,

On Tue, Sep 17, 2019 at 09:25:31AM -0600, shuah wrote:

[..]

> I want two patches and the first one with
> Fixes tag. 

I am not sure we are on the same page and you don't seem to be receptive
to what I say.

> The reason for that is that the first patch fixes a problem
> in patch that is already in my tree which is fixes a problem.

Here is my understanding of your request:

 +--------------+    +--------------+
 |1/2 this patch|    |1/2 this patch|
 |    (fix)     +----+  (feature)   |
 +------+-------+    +--------------+
        | Fixes
 +------v-------+
 |     [A]      |
 +------+-------+
        | Fixes
 +------v-------+
 |     [B]      |
 +--------------+

So, you ask to decompose this v2 patch into two parts (fix and feature),
__exactly like it was in v1__, with the reasoning that the bugfix
related part of this patch fixes [A] (which is true), while [A] fixes
another commit [B]. But given that [A] is a feature commit, adding brand
new functionality, there can't be any [B] commit being fixed by [A].

> I am going to mark the patch for stables and the first patch in this
> series.

I do not understand your request. Both current patch and [A] are
scheduled for v5.4. I do not see any relevant patches for linux-stable.
I hope either a clarification or a third opinion will shed more light
onto this totally unproductive dialogue.

[A] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=c3f2490d6e92
    ("selftests: watchdog: Add optional file argument")
    https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=next&id=c3f2490d6e92
    ("selftests: watchdog: Add optional file argument")
[B] ???

-- 
Best Regards,
Eugeniu.
