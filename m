Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E93A9318CAF
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Feb 2021 14:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbhBKNvd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Feb 2021 08:51:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:50982 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231126AbhBKNtQ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Feb 2021 08:49:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613051306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Nk5HHbWEiSFsYXHMak3oMydNJDyPAGGwCf/NXmBNISo=;
        b=SYYf8p4GyosaPMQ8UTRM5Az4E96abJP5HOTGod2aXqeG70+lvCQTGqWn0CPEXrL24zYVjC
        h+ruhPzMg+nYlXgKlrd2U17ppZPEZvKXtbOmkBsBXX+BsYfNCiJiM+Tti4QyPBJ9hv+Iau
        wclYWnEyqLoifucp/wMnhGHqukMXdOg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 393A9AC69;
        Thu, 11 Feb 2021 13:48:26 +0000 (UTC)
Date:   Thu, 11 Feb 2021 14:48:25 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH v6 2/4] lib: vsprintf: Fix handling of number field
 widths in vsscanf
Message-ID: <YCU1qRtI2zXy7xFr@alley>
References: <20210209155604.6998-1-rf@opensource.cirrus.com>
 <20210209155604.6998-2-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209155604.6998-2-rf@opensource.cirrus.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue 2021-02-09 15:56:02, Richard Fitzgerald wrote:
> The existing code attempted to handle numbers by doing a strto[u]l(),
> ignoring the field width, and then repeatedly dividing to extract the
> field out of the full converted value. If the string contains a run of
> valid digits longer than will fit in a long or long long, this would
> overflow and no amount of dividing can recover the correct value.
> 
> This patch fixes vsscanf() to obey number field widths when parsing
> the number.
> 
> A new _parse_integer_limit() is added that takes a limit for the number
> of characters to parse. The number field conversion in vsscanf is changed
> to use this new function.
> 
> If a number starts with a radix prefix, the field width  must be long
> enough for at last one digit after the prefix. If not, it will be handled
> like this:
> 
>  sscanf("0x4", "%1i", &i): i=0, scanning continues with the 'x'
>  sscanf("0x4", "%2i", &i): i=0, scanning continues with the '4'
> 
> This is consistent with the observed behaviour of userland sscanf.
> 
> Note that this patch does NOT fix the problem of a single field value
> overflowing the target type. So for example:
> 
>   sscanf("123456789abcdef", "%x", &i);
> 
> Will not produce the correct result because the value obviously overflows
> INT_MAX. But sscanf will report a successful conversion.
> 
> Note that where a very large number is used to mean "unlimited", the value
> INT_MAX is used for consistency with the behaviour of vsnprintf().
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

The patchset looks ready for upstream from my POV.

Best Regards,
Petr
