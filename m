Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF68DB3A01
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2019 14:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732293AbfIPMI1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Sep 2019 08:08:27 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:36461 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731744AbfIPMI1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Sep 2019 08:08:27 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 514CD3C04C0;
        Mon, 16 Sep 2019 14:08:25 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AU5kSxoqQ_WN; Mon, 16 Sep 2019 14:08:19 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id A6AC93C00C4;
        Mon, 16 Sep 2019 14:08:19 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.468.0; Mon, 16 Sep
 2019 14:08:19 +0200
Date:   Mon, 16 Sep 2019 14:08:16 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Shuah Khan <shuah@kernel.org>
CC:     "George G. Davis" <george_davis@mentor.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Colin Ian King <colin.king@canonical.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH 1/2] selftests: watchdog: Validate optional file argument
Message-ID: <20190916120816.GA30453@vmlxhi-102.adit-jv.com>
References: <20190907085833.21167-1-erosca@de.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190907085833.21167-1-erosca@de.adit-jv.com>
User-Agent: Mutt/1.12.1+40 (7f8642d4ee82) (2019-06-28)
X-Originating-IP: [10.72.93.184]
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,

On Sat, Sep 07, 2019 at 10:58:32AM +0200, Eugeniu Rosca wrote:
> From: "George G. Davis" <george_davis@mentor.com>
> 
> As reported by Eugeniu Rosca, the newly added optional file
> argument does not validate if the file is indeed a watchdog, e.g.:
> 
> ./watchdog-test  -f /dev/zero
> Watchdog Ticking Away!
> 
> Fix it by confirming that the WDIOC_GETSUPPORT ioctl succeeds.
> 
> Reported-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> Signed-off-by: George G. Davis <george_davis@mentor.com>
> Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> ---
> v1: Applied/tested on commit ce54eab71e210f ("kunit: fix failure to build without printk") of
>     https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=next

Any concerns about the two patches?
Can you please confirm they are in your queue?

-- 
Best Regards,
Eugeniu.
