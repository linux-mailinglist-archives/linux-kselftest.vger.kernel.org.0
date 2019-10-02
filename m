Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E40BC4DCE
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2019 12:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbfJBKl2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Oct 2019 06:41:28 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:42936 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfJBKl1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Oct 2019 06:41:27 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 88F1C3C057F;
        Wed,  2 Oct 2019 12:41:25 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VmjJXeBz8g7t; Wed,  2 Oct 2019 12:41:20 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id E90553C0585;
        Wed,  2 Oct 2019 12:41:03 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.468.0; Wed, 2 Oct 2019
 12:41:03 +0200
Date:   Wed, 2 Oct 2019 12:41:01 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     shuah <shuah@kernel.org>
CC:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        "George G. Davis" <george_davis@mentor.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH v3 1/2] selftests: watchdog: Validate optional file
 argument
Message-ID: <20191002104101.GA6855@vmlxhi-102.adit-jv.com>
References: <20190917184023.16701-1-erosca@de.adit-jv.com>
 <156996250317.31379.1299334144215961607.git-patchwork-notify@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <156996250317.31379.1299334144215961607.git-patchwork-notify@kernel.org>
User-Agent: Mutt/1.12.1+40 (7f8642d4ee82) (2019-06-28)
X-Originating-IP: [10.72.93.184]
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,

On Tue, Oct 01, 2019 at 08:41:43PM +0000, patchwork-bot+linux-kselftest@kernel.org wrote:
> Hello:
> 
> This series was applied to shuah/linux-kselftest.git (refs/heads/fixes).
> 
> On Tue, 17 Sep 2019 20:40:22 +0200 you wrote:
> > From: "George G. Davis" <george_davis@mentor.com>
> > 
> > The newly added optional file argument does not validate if the
> > file is indeed a watchdog, e.g.:
> > 
> > ./watchdog-test  -f /dev/zero
> > Watchdog Ticking Away!
> > 
> > [...]
> 
> Here is a summary with links:
>   - [v3,1/2] selftests: watchdog: Validate optional file argument
>     https://git.kernel.org/shuah/linux-kselftest/c/93c384f5d553bc4fdfb252b89ff378363ee05cee

Could you please update the 'Fixes:' tag in the above commit to:
Fixes: a4864a33f56caa ("selftests: watchdog: Add optional file argument")

The warning in https://patchwork.kernel.org/patch/11149287/ clearly says
that the fixed commit is from linux-next and it seems to have been
updated before landing in mainline. TIA.

-- 
Best Regards,
Eugeniu
