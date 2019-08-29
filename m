Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00113A1F22
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2019 17:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfH2P3E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Aug 2019 11:29:04 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:34945 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbfH2P3D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Aug 2019 11:29:03 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id A84943C0579;
        Thu, 29 Aug 2019 17:29:01 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OgIdBam3RgzE; Thu, 29 Aug 2019 17:28:55 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 93CF43C04C0;
        Thu, 29 Aug 2019 17:28:55 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.468.0; Thu, 29 Aug
 2019 17:28:55 +0200
Date:   Thu, 29 Aug 2019 17:28:52 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     "George G. Davis" <george_davis@mentor.com>
CC:     Shuah Khan <shuah@kernel.org>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Colin Ian King <colin.king@canonical.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH] selftests: watchdog: Add optional file argument
Message-ID: <20190829152852.GA15203@vmlxhi-102.adit-jv.com>
References: <1567053566-18971-1-git-send-email-george_davis@mentor.com>
 <20190829143814.GA3424@vmlxhi-102.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190829143814.GA3424@vmlxhi-102.adit-jv.com>
User-Agent: Mutt/1.12.1+40 (7f8642d4ee82) (2019-06-28)
X-Originating-IP: [10.72.93.184]
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 29, 2019 at 04:38:14PM +0200, Eugeniu Rosca wrote:
> Hi George,
> 
> On Thu, Aug 29, 2019 at 12:39:25AM -0400, George G. Davis wrote:
> > Some systems have multiple watchdog devices where the first device
> > registered is assigned to the /dev/watchdog device file.
> 
> Confirmed on R-Car H3-Salvator-X:
> 
> root@rcar-gen3:~# ls -al /dev/watchdog*
> crw-------    1 root     root       10, 130 Aug 21 09:38 /dev/watchdog
> crw-------    1 root     root      247,   0 Aug 21 09:38 /dev/watchdog0

Based on [1], I think this patch is actually helpful when there
is at least a /dev/watchdog1 in the system. Particularly on R-Car3,
this happens when enabling softdog in addition to the standard RWDT:

root@rcar-gen3:~# ls -al /dev/watchdog*
crw-------    1 root     root       10, 130 Aug 21 09:38 /dev/watchdog
crw-------    1 root     root      247,   0 Aug 21 09:38 /dev/watchdog0
crw-------    1 root     root      247,   1 Aug 21 09:38 /dev/watchdog1

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/watchdog/watchdog-kernel-api.rst?h=v5.3-rc6#n71
  ----8<----
id 0 is special. It has both a
/dev/watchdog0 cdev (dynamic major, minor 0) as well as the old
/dev/watchdog miscdev.
  ----8<----

-- 
Best Regards,
Eugeniu.
