Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3909B28C32D
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Oct 2020 22:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbgJLUqs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Oct 2020 16:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731468AbgJLUqs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Oct 2020 16:46:48 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCB9C0613E4
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Oct 2020 13:46:32 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id o9so9316959plx.10
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Oct 2020 13:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=GP/tSxU+2ueJJAD5XvrlcBqjjbcVqs1GAlfX4xS/x5o=;
        b=Zmyj6b1xn7fgYQ4LeerdVC70u737/gGJRwdCYnv5k4lAJ4ZAWiq77J6HTWNtPLy5Fb
         +xId2w1AJdlP4b4Gk+cO+qmKRbcZL0o4WUamdOMbP0HnLbSjH7bnxsZclfoKc6+wueKq
         Y4WFwLXKO7dsLcGwu3W0ytOyLYRM/b67FrN7deWaZaARnBxEiuSQkhaYtEFWV3FNh1DJ
         mYsz/GpTkpDNVka9ngAw3/WAJVbib0KRuj33mR5fuEcT+qGLmQdkwuO6TrpxS1rNI4ix
         t8Vacy6eZIRybQE0PFe7c5weaxWzTGWykb5XWW2C6WIttIokJ30keX8fgYRcZYI7D11N
         1gcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GP/tSxU+2ueJJAD5XvrlcBqjjbcVqs1GAlfX4xS/x5o=;
        b=nEXpXlmm6ydfYnZOlzQ80hfT7JUxkLzyvqcJWdwqYRpLKXrM7bhCfaYiXFWnxtFJhJ
         QtrFTkGnadVFDQ0ApsxVfZXguTGIsrnw0I/h3/Dj823Z/EPtBXFP+4RzJ984IaqOgCD4
         4C/H4r1p3QBRfkQTNjomPLKfN3O86dGaDvQHomI1Jf9aSMyRrBbjycPKVBkFYoUqDzAg
         8XwSrxKQpP+oR6ta05/PluzS9W3IJ3gLavfB71ejC+stD8vZwcjYVYpRGqWQK5hA4+pS
         RNq56PS5zZxthjiKXlwlbGSVhAeNzEsjFbKrrvc6mPb+eLVzHmE6m5QRKt8o8HTtBmmO
         k0dQ==
X-Gm-Message-State: AOAM530VgVwyf8kvENZsPyPj/NciNxYRX/jCmSE2axoJY2SdIY+YBnKU
        62g5ZvEZjV/hlIZrvw8uMTyhHA==
X-Google-Smtp-Source: ABdhPJxvYuECJqceRU/Ms78R61xviB7QnwDg4XOxMDIU5Uul1Qb3W8B+eZKuWlzzWx/nqi1F2hbH0w==
X-Received: by 2002:a17:902:70c8:b029:d4:d4d5:f140 with SMTP id l8-20020a17090270c8b02900d4d4d5f140mr9444301plt.33.1602535591364;
        Mon, 12 Oct 2020 13:46:31 -0700 (PDT)
Received: from google.com ([2620:15c:2cb:201:c634:6bff:fe71:d8d1])
        by smtp.gmail.com with ESMTPSA id q5sm9065695pjg.0.2020.10.12.13.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 13:46:30 -0700 (PDT)
Date:   Mon, 12 Oct 2020 13:46:25 -0700
From:   Brendan Higgins <brendanhiggins@google.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arpitha Raghunandan <98.arpi@gmail.com>,
        skhan@linuxfoundation.org, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] lib: Convert test_printf.c to KUnit
Message-ID: <20201012204625.GA56597@google.com>
References: <20200817043028.76502-1-98.arpi@gmail.com>
 <f408efbd-10f7-f1dd-9baa-0f1233cafffc@rasmusvillemoes.dk>
 <20200821113710.GA26290@alley>
 <20200821122849.GS1891694@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200821122849.GS1891694@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 21, 2020 at 03:28:49PM +0300, Andy Shevchenko wrote:
> On Fri, Aug 21, 2020 at 01:37:10PM +0200, Petr Mladek wrote:
> > On Mon 2020-08-17 09:06:32, Rasmus Villemoes wrote:
> > > On 17/08/2020 06.30, Arpitha Raghunandan wrote:
> > > > Converts test lib/test_printf.c to KUnit.
> > > > More information about KUnit can be found at
> > > > https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html.
> > > > KUnit provides a common framework for unit tests in the kernel.
> > > 
> > > So I can continue to build a kernel with some appropriate CONFIG set to
> > > y, boot it under virt-me, run dmesg and see if I broke printf? That's
> > > what I do now, and I don't want to have to start using some enterprisy
> > > framework.
> > 
> > I had the same concern. I have tried it.

Sorry you feel that way. Do you have any suggestions on how we can make
it seem less enterprisy? Seems like there are people here who are not a
fan of the output format, so of which we can fix here, some of which is
part of KTAP[1].

> Which raises an obvious question: did the people who convert this test this
> themselves? Looks like a janitor work in the area without understanding the
> area good enough.

Looks to me like Arpitha ran it, but you are right, we don't have a lot
of familiarity with this area; we were treating it as "janitor work" as
you say.

Our intention was just to take some existing tests and as non-invasively
as possible, get them to report using a common format, and maybe even
get some of the tests to follow a common pattern.

> Probably I will NAK all those patches from now on, until it will be good commit
> messages and cover of risen aspects, including reference to before and after
> outcome for passed and failed test cases.

Fair enough, hopefully we can address these issues in the next revision.

One issue though, with the "before and after outcome" you are
referencing; are you referring to the issue that Petr pointed out in how
they are inconsistent:

   + original code: vsnprintf(buf, 6, "%pi4|%pI4", ...) wrote '127.0', expected '127-0'
   + kunit code: vsnprintf(buf, 20, "%pi4|%pI4", ...) wrote '127.000.000.001|127', expected '127-000.000.001|127'  

(I think Rasmus addressed this.) Or are your referring to something
else?

> Brendan, I guess the ball now on your side to prove this is good activity.

And I see that we are off to a great start! :-)

In all seriousness, I am really sorry about this. I kind of bungled this
up trying to go after too many of these conversions at once.

Arpitha, can you get this follow up patch out?

[1] https://lore.kernel.org/linux-kselftest/CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com/
