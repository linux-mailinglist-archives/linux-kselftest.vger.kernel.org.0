Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31FEE2DC29E
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Dec 2020 16:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgLPPA6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Dec 2020 10:00:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:35502 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbgLPPA5 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Dec 2020 10:00:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1608130810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rUr1yE3SiJ3liS7JwmJQkTdMbmwmxrWkUAvup8jy/Sk=;
        b=P5pg2YRW4QQxMBF29dvNTPxj9jddjXPXVA/D4Vg9GcPaCuuLVH1H4VXSR3D3jgv770c43v
        vR6CKevp8umeXyAAfrDI0lKFtE8UaY6phaXxgL0c7KYxZfnaMD6Z7JvmrvoQ8PzqF+YPbb
        cvh2zULr2SeAjo9oCC/V9foX994yjko=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9EAF2ACC6;
        Wed, 16 Dec 2020 15:00:10 +0000 (UTC)
Date:   Wed, 16 Dec 2020 16:00:10 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        shuah@kernel.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 2/4] lib: test_scanf: Add tests for sscanf number
 conversion
Message-ID: <X9og+nKP18bUsi6x@alley>
References: <20201130145800.19960-1-rf@opensource.cirrus.com>
 <20201130145800.19960-2-rf@opensource.cirrus.com>
 <X9DcEL54k0qRayr+@alley>
 <f3e97a68-71fe-c077-5add-a6c0fb397032@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3e97a68-71fe-c077-5add-a6c0fb397032@opensource.cirrus.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue 2020-12-15 14:26:53, Richard Fitzgerald wrote:
> 
> 
> On 09/12/2020 14:15, Petr Mladek wrote:
> > On Mon 2020-11-30 14:57:58, Richard Fitzgerald wrote:
> > > Adds test_sscanf to test various number conversion cases, as
> > > number conversion was previously broken.
> > > 
> > > This also tests the simple_strtoxxx() functions exported from
> > > vsprintf.c.
> > 
> > It is impressive.
> > 
> > Honestly, I do not feel to be expert on testing and mathematics.
> > I am not sure how comprehensive the test is. Also I am not
> > sure what experts would say about the tricks with random
> > numbers.
> > 
> > Anyway, this is much more than what I have expected. And it checks
> > great number of variants and corner cases.
> > 
> > I suggest only one small change, see below.
> > 
> > > --- /dev/null
> > > +++ b/lib/test_scanf.c
> > > +#define test_one_number(T, gen_fmt, scan_fmt, val, fn)			\
> > > +do {									\
> > > +	const T expect_val = (T)(val);					\
> > > +	T result = ~expect_val; /* should be overwritten */		\
> > 
> > If I get it correctly, this is supposed to initialize the temporary
> > variable with a value that is different from the expected value.
> > It will cause test failure when it is not updated by vsscanf().
> > 
> > It does not work for zero value. A better solution might be to add
> 
> That's a ~, not a -
> ~0 = 0xFFFFFFFF
> ~-1 = 0

I see. This works well.

I am sorry for the noise. Sigh, I think that I need stronger glasses
or use a monitor. I am not able to distinguish the two characeters
without staring closely on the laptop screen. I wish I was able to
work from the office again.

Best Regards,
Petr
