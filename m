Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C10C9B5497
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2019 19:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfIQRvI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Sep 2019 13:51:08 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:45370 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfIQRvI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Sep 2019 13:51:08 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 7D7323C04C0;
        Tue, 17 Sep 2019 19:51:05 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lwSvD75jPiX3; Tue, 17 Sep 2019 19:50:59 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id E323D3C00C4;
        Tue, 17 Sep 2019 19:50:59 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.468.0; Tue, 17 Sep
 2019 19:50:59 +0200
Date:   Tue, 17 Sep 2019 19:50:56 +0200
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
Message-ID: <20190917175056.GA24224@vmlxhi-102.adit-jv.com>
References: <1568659751-1845-1-git-send-email-george_davis@mentor.com>
 <fa008fd8-f867-b80e-84ed-148e1630c09e@kernel.org>
 <20190917145400.GA14341@vmlxhi-102.adit-jv.com>
 <73bab70b-e22c-42b4-cfca-b4e33431b423@kernel.org>
 <20190917165418.GA21010@vmlxhi-102.adit-jv.com>
 <374127ff-d06f-fcc3-d317-5614dfdc5a71@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <374127ff-d06f-fcc3-d317-5614dfdc5a71@kernel.org>
User-Agent: Mutt/1.12.1+40 (7f8642d4ee82) (2019-06-28)
X-Originating-IP: [10.72.93.184]
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 17, 2019 at 11:44:45AM -0600, shuah wrote:
> On 9/17/19 10:54 AM, Eugeniu Rosca wrote:
> > Shuah,
> > 
> > On Tue, Sep 17, 2019 at 09:25:31AM -0600, shuah wrote:
> > 
> > [..]
> > 
> > > I want two patches and the first one with
> > > Fixes tag.
> > 
> 
> These two patches need to be separate. The first one is a fix and
> the second is an enhancement.

That was exactly the idea of v1.

> 
> Please send two patches - the first one with Fixes tag.

Can you please pick [v1] series from below:
 - https://patchwork.kernel.org/patch/11136283/
 - https://patchwork.kernel.org/patch/11136285/

with adding a one-liner Fixes tag to the first patch?

-- 
Best Regards,
Eugeniu.
