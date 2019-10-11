Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75034D4A20
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2019 23:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbfJKVzV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Oct 2019 17:55:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:32882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728719AbfJKVzU (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Oct 2019 17:55:20 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B39B62084C;
        Fri, 11 Oct 2019 21:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570830920;
        bh=gd8GAu0tkKp0TCBgtng5DI6iLgkG7+iNpGuxcQi/knA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xbODnkmKqLvt+vMAiqzr5JnHjM/KSN2k/ERgprBZVFV8y2sT8beQvYqrkep4D3bMI
         jE2bE005KDpC/x40l1Qb3PnuSkYYy+0tKTSypdeepNKTxF4DVe4/RdL9/3W6PWtuqa
         IyXs7JFv76ptET5PXKIr9ePK2vbJ+CtMW4AFfqf8=
Date:   Fri, 11 Oct 2019 14:55:19 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Gow <davidgow@google.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Kees Cook <keescook@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-kselftest/test v2] lib/list-test: add a test for
 the 'list' doubly linked list
Message-Id: <20191011145519.7b7a1d16ecdead9bec212c01@linux-foundation.org>
In-Reply-To: <CABVgOS=UwWxwD97c6y-XzbLWVhznPjBO3qvQEzX=8jTJ-gBi3A@mail.gmail.com>
References: <20191010185631.26541-1-davidgow@google.com>
        <20191011140727.49160042fafa20d5867f8df7@linux-foundation.org>
        <CABVgOS=UwWxwD97c6y-XzbLWVhznPjBO3qvQEzX=8jTJ-gBi3A@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 11 Oct 2019 14:37:25 -0700 David Gow <davidgow@google.com> wrote:

> On Fri, Oct 11, 2019 at 2:05 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > <looks at kunit>
> >
> > Given that everything runs at late_initcall time, shouldn't everything
> > be __init, __initdata etc so all the code and data doesn't hang around
> > for ever?
> >
> 
> That's an interesting point. We haven't done this for KUnit tests to
> date, and there is certainly a possibility down the line that we may
> want to be able to run these tests in other circumstances. (There's
> some work being done to allow KUnit and KUnit tests to be built as
> modules here: https://lkml.org/lkml/2019/10/8/628 for example.) Maybe
> it'd be worth having macros which wrap __init/__initdata etc as a way
> of futureproofing tests against such a change?
> 
> Either way, I suspect this is something that should probably be
> considered for KUnit as a whole, rather than on a test-by-test basis.

Sure, a new set of macros for this makes sense.  Can be retrofitted any
time.

There might be a way of loading all of list_test.o into a discardable
section at link time instead of sprinkling annotation all over the .c
code.
