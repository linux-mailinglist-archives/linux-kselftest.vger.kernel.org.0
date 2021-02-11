Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87CF8318CAB
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Feb 2021 14:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbhBKNv2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Feb 2021 08:51:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:49034 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231802AbhBKNrd (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Feb 2021 08:47:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613051204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V9WUW7Zqf3EJxDCBBQWFJdMXIY0+XYoBbFG5pbCKyc8=;
        b=oJqW1dgv3OIa7aJRI2BTnSF32yrBRJ2KUi6SRjDsda1upaXWbFeUdvs1CC8VZTEbRVXLAs
        waFEL97r1ddfdActvcjrUHt/jGwWWYT0ey9SIOKeEF837a/6OmLsfdlLj6pQ5aBwwW23jy
        1LvTtljT2YQtkvHk35J/NnUk09mncG4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2705FAD29;
        Thu, 11 Feb 2021 13:46:44 +0000 (UTC)
Date:   Thu, 11 Feb 2021 14:46:43 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH v6 3/4] lib: test_scanf: Add tests for sscanf number
 conversion
Message-ID: <YCU1QyJzVgfRp0rZ@alley>
References: <20210209155604.6998-1-rf@opensource.cirrus.com>
 <20210209155604.6998-3-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209155604.6998-3-rf@opensource.cirrus.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue 2021-02-09 15:56:03, Richard Fitzgerald wrote:
> Adds test_sscanf to test various number conversion cases, as
> number conversion was previously broken.
> 
> This also tests the simple_strtoxxx() functions exported from
> vsprintf.c.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
