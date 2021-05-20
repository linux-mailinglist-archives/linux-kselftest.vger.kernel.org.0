Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC47389FEB
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 May 2021 10:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhETIhG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 May 2021 04:37:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:34458 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230102AbhETIhG (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 May 2021 04:37:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621499744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iFqDqDGNusFcTWoYhOsnJAlpgmr8zyG2LCD23iwtO7w=;
        b=MUwQtOhhpue1M5O6jjNLv9xobUdzxKOA5+3Vt7pjtf53XjdD6+KiToornxONG690fK+Thk
        t6GTmZgDif0JqrJJevJ/7y2rOxS76+cR2GQtjhJzIMRG4H/PtRX/Evyuc6dapB4g7jxOuh
        MmHilKdPyKM4O6WkmW3LHQte4B/zUCk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 590F7AAFD;
        Thu, 20 May 2021 08:35:44 +0000 (UTC)
Date:   Thu, 20 May 2021 10:35:43 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH v8 RESEND 1/4] lib: vsprintf: scanf: Negative number must
 have field width > 1
Message-ID: <YKYfX5Vp+4onbIFj@alley>
References: <20210514161206.30821-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514161206.30821-1-rf@opensource.cirrus.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri 2021-05-14 17:12:03, Richard Fitzgerald wrote:
> If a signed number field starts with a '-' the field width must be > 1,
> or unlimited, to allow at least one digit after the '-'.
> 
> This patch adds a check for this. If a signed field starts with '-'
> and field_width == 1 the scanf will quit.
> 
> It is ok for a signed number field to have a field width of 1 if it
> starts with a digit. In that case the single digit can be converted.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The entrire patchset has been committed into print/linux.git,
branch for-5.14-vsprintf-scanf.

Thanks for reminder. I am sorry. It somehow fallen from my radar.

Best Regards,
Petr
