Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56165B624C
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Sep 2019 13:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbfIRLd7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Sep 2019 07:33:59 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:49960 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbfIRLd7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Sep 2019 07:33:59 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id BFA523C04C0;
        Wed, 18 Sep 2019 13:33:57 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XO4uxawDwBGG; Wed, 18 Sep 2019 13:33:52 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 03DB53C00C4;
        Wed, 18 Sep 2019 13:33:52 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.468.0; Wed, 18 Sep
 2019 13:33:51 +0200
Date:   Wed, 18 Sep 2019 13:33:48 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Shuah Khan <shuah@kernel.org>
CC:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        "George G. Davis" <george_davis@mentor.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Colin Ian King <colin.king@canonical.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] selftests: watchdog: Validate optional file
 argument
Message-ID: <20190918113348.GA23977@vmlxhi-102.adit-jv.com>
References: <20190917184023.16701-1-erosca@de.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190917184023.16701-1-erosca@de.adit-jv.com>
User-Agent: Mutt/1.12.1+40 (7f8642d4ee82) (2019-06-28)
X-Originating-IP: [10.72.93.184]
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,

On Tue, Sep 17, 2019 at 08:40:22PM +0200, Eugeniu Rosca wrote:
> From: "George G. Davis" <george_davis@mentor.com>
> 
> The newly added optional file argument does not validate if the
> file is indeed a watchdog, e.g.:
> 
> ./watchdog-test  -f /dev/zero
> Watchdog Ticking Away!
> 
> Fix it by confirming that the WDIOC_GETSUPPORT ioctl succeeds.
> 
> Fixes: c3f2490d6e9257 ("selftests: watchdog: Add optional file argument")
> Reported-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> Signed-off-by: George G. Davis <george_davis@mentor.com>
> Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> ---
> v3:
>  - Used v1 as starting point and simplified commit description
>  - Added Fixes tag (WARNING: commit id is from linux-next!)
>  - No change in the contents
>  - Applied cleanly to the same base as used in [v1]

Can we have your confirmation the patches look fine now?

-- 
Best Regards,
Eugeniu
