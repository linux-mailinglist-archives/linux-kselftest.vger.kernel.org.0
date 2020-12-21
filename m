Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD352DFD69
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Dec 2020 16:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgLUPUW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Dec 2020 10:20:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:52730 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbgLUPUW (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Dec 2020 10:20:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1608563975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ioR0BT7ZJcK29n+g9zo8NAIlU+EWWPZiYMtI3Se05Xo=;
        b=VEXKKNy1ayzuIHzzLpPRhKlKYNzayXPoTdLxkGB+NjUS/BQ3unHv+QeuU2ixBDa4ent5X3
        jjDbLJ+NizDanU7ddzRieKu8yYsTeyzsQp7CLEgTCfSi5MFmYNq+8F4xtp40+MRo1eGgW+
        MQsJfvlGeCkO+61hf0DqtPh5/iC4rj4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8C509AD4D;
        Mon, 21 Dec 2020 15:19:35 +0000 (UTC)
Date:   Mon, 21 Dec 2020 16:19:35 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        shuah@kernel.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 2/4] lib: vsprintf: Fix handling of number field
 widths in vsscanf
Message-ID: <X+C9Bw9KtOdRuuBJ@alley>
References: <20201217180057.23786-1-rf@opensource.cirrus.com>
 <20201217180057.23786-2-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217180057.23786-2-rf@opensource.cirrus.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu 2020-12-17 18:00:55, Richard Fitzgerald wrote:
> The existing code attempted to handle numbers by doing a strto[u]l(),
> ignoring the field width, and then repeatedly dividing to extract the
> field out of the full converted value. If the string contains a run of
> valid digits longer than will fit in a long or long long, this would
> overflow and no amount of dividing can recover the correct value.
> 
> This patch fixes vsscanf to obey number field widths when parsing
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
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
