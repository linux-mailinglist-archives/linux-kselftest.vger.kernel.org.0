Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9C52A0B0C
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Oct 2020 17:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbgJ3Q02 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Oct 2020 12:26:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:40498 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbgJ3Q02 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Oct 2020 12:26:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604075186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+a0eewLbc0DaaRq9NLSkTv7hmXsXsmk9e+rtyuIjTik=;
        b=BYY6aVS5b0RlbLlk18+GJWhuAxIVAMOJTA0Jqv8FFXa7GY3g6PT9fsNz5PTsyoowCARt57
        6ZbXDmw2OfJQuzr4E62ys1OE9EXYklEiIT0BARKx8ywsgRaeG6k4ENUDhiPB9xKf96GOCZ
        AVBGKHc2Rzlhq+QU5EMFqcHHeF/Jf3A=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 257C7AC1F;
        Fri, 30 Oct 2020 16:26:26 +0000 (UTC)
Date:   Fri, 30 Oct 2020 17:26:25 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Shuah Khan <shuah@kernel.org>, Kees Cook <keescook@chromium.org>,
        Willy Tarreau <w@1wt.eu>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Arpitha Raghunandan <98.arpi@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH 4/4] lib/test_printf.c: use deterministic sequence of
 random numbers
Message-ID: <20201030162625.GE20201@alley>
References: <20201025214842.5924-1-linux@rasmusvillemoes.dk>
 <20201025214842.5924-5-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201025214842.5924-5-linux@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun 2020-10-25 22:48:42, Rasmus Villemoes wrote:
> The printf test suite does each test with a few different buffer sizes
> to ensure vsnprintf() behaves correctly with respect to truncation and
> size reporting. It calls vsnprintf() with a buffer size that is
> guaranteed to be big enough, a buffer size of 0 to ensure that nothing
> gets written to the buffer, but it also calls vsnprintf() with a
> buffer size chosen to guarantee the output gets truncated somewhere in
> the middle.
> 
> That buffer size is chosen randomly to increase the chance of finding
> some corner case bug (for example, there used to be some %p<foo>
> extension that would fail to produce any output if there wasn't room
> enough for it all, despite the requirement of producing as much as
> there's room for). I'm not aware of that having found anything yet,
> but should it happen, it's annoying not to be able to repeat the
> test with the same sequence of truncated lengths.
> 
> For demonstration purposes, if we break one of the test cases
> deliberately, we still get different buffer sizes if we don't pass the
> seed parameter:
> 
> root@(none):/# modprobe test_printf
> [   15.317783] test_printf: vsnprintf(buf, 18, "%piS|%pIS", ...) wrote '127.000.000.001|1', expected '127-000.000.001|1'
> [   15.323182] test_printf: failed 3 out of 388 tests
> [   15.324034] test_printf: random seed used was 0x278bb9311979cc91
> modprobe: ERROR: could not insert 'test_printf': Invalid argument
> 
> root@(none):/# modprobe test_printf
> [   13.940909] test_printf: vsnprintf(buf, 22, "%piS|%pIS", ...) wrote '127.000.000.001|127.0', expected '127-000.000.001|127.0'
> [   13.944744] test_printf: failed 3 out of 388 tests
> [   13.945607] test_printf: random seed used was 0x9f72eee1c9dc02e5
> modprobe: ERROR: could not insert 'test_printf': Invalid argument
> 
> but to repeat a specific sequence of tests, we can do
> 
> root@(none):/# modprobe test_printf seed=0x9f72eee1c9dc02e5
> [  448.328685] test_printf: vsnprintf(buf, 22, "%piS|%pIS", ...) wrote '127.000.000.001|127.0', expected '127-000.000.001|127.0'
> [  448.331650] test_printf: failed 3 out of 388 tests
> [  448.332295] test_printf: random seed used was 0x9f72eee1c9dc02e5
> modprobe: ERROR: could not insert 'test_printf': Invalid argument
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Great feature!

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
