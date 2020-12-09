Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7D02D4417
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Dec 2020 15:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgLIOXO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Dec 2020 09:23:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:60754 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbgLIOXO (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Dec 2020 09:23:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607523747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uiDomGRkuTSzGKant3Aykyu4NfcmJKpExuBm+U0wY6U=;
        b=llU3BLB5UKPeWSLJXbXRWqQFNC9+04cq552hR+C0t0hncDH4zPxBV9Z7zAqopdJuNxisGD
        vNt66K/Mr749w/ZCGLfwNzuZPbPgI7TT1T9wGl5mDu1HepWLhOnUkuuAMysZuNWEgMjW+f
        rashFuxkMx2iToRRQG4GQEB8raa7qAA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4FA27ACF4;
        Wed,  9 Dec 2020 14:22:27 +0000 (UTC)
Date:   Wed, 9 Dec 2020 15:22:26 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        shuah@kernel.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 4/4] MAINTAINERS: Add lib/test_scanf.c to VSPRINTF
Message-ID: <X9DdovpUOTLmvn9y@alley>
References: <20201130145800.19960-1-rf@opensource.cirrus.com>
 <20201130145800.19960-4-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130145800.19960-4-rf@opensource.cirrus.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon 2020-11-30 14:58:00, Richard Fitzgerald wrote:
> Adds the new scanf test to the VSPRINTF group.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>

I would prefer to squash this into the 2nd patch that adds the
file. But anyway:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
