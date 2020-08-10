Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8351241240
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Aug 2020 23:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgHJVZQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Aug 2020 17:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgHJVZQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Aug 2020 17:25:16 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C3CC061756;
        Mon, 10 Aug 2020 14:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xX0l+o3WOXrFYkfAFbEcFNmccJy5nLnWF03ye/oymn4=; b=AABfE5rB1ADqgBAiUjRtfhh7CH
        9oSnxCesZTQcjy1wuye8zf3x1lBCnu/W3hbKNCGFhDtn/jXpL8okZ2rO66WlYAz+2U/DtmUssoo5c
        mOwSYEtLkzDqJlTF6TgYjAnLks0wf1/cry6vuFoVMaTR1arZmDzeaWYz1/LJPprlrkJ0Amm52NZKz
        vp0zri8hZXlCrJz7JsaG07k86BJm4fhGqPWkk5Qk7SIM602h4hbWeqPAJ7ez1foEDuWe30ezyHqlC
        J6JCYupUtyysZRkYAs92N7ogiYFnMLzUobTWpJPb55LkAe+PSLyHoiAKRDKj8Bx4uxkeIarzk7yX6
        5wCdKt2A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5FI4-0004FC-6c; Mon, 10 Aug 2020 21:25:08 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 20238980D39; Mon, 10 Aug 2020 23:25:06 +0200 (CEST)
Date:   Mon, 10 Aug 2020 23:25:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Uriel Guajardo <urielguajardo@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>, mingo@redhat.com,
        will@kernel.org, Uriel Guajardo <urielguajardojr@gmail.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kunit: added lockdep support
Message-ID: <20200810212506.GH3982@worktop.programming.kicks-ass.net>
References: <20200806203737.3636830-1-urielguajardojr@gmail.com>
 <CAG30EedgwNJMCXX6Eo3b8heMa228N4=RLd=BgAQhS8AZ51bU0A@mail.gmail.com>
 <CAFd5g46=zgY_+jawXMS+yTx6MhRGa_4-WVmer-BwoL_c2QPcrg@mail.gmail.com>
 <CAG30EefjgzOMePHA2tQ-UmAw5_mnLDoS2hJH6z3nidNC8n8+Lg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG30EefjgzOMePHA2tQ-UmAw5_mnLDoS2hJH6z3nidNC8n8+Lg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 10, 2020 at 04:17:42PM -0500, Uriel Guajardo wrote:
> On Mon, Aug 10, 2020 at 3:35 PM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > On Thu, Aug 6, 2020 at 1:43 PM Uriel Guajardo <urielguajardo@google.com> wrote:
> > >
> > > On Thu, Aug 6, 2020 at 3:37 PM Uriel Guajardo <urielguajardojr@gmail.com> wrote:
> > > >
> > > > From: Uriel Guajardo <urielguajardo@google.com>
> > > >
> > > > KUnit tests will now fail if lockdep detects an error during a test
> > > > case.
> > > >
> > > > The idea comes from how lib/locking-selftest [1] checks for lock errors: we
> > > > first if lock debugging is turned on. If not, an error must have
> > > > occurred, so we fail the test and restart lockdep for the next test case.
> > > >
> > > > Like the locking selftests, we also fix possible preemption count
> > > > corruption from lock bugs.
> >
> > Sorry, just noticed: You probably want to send this to some of the
> > lockdep maintainers or the maintainers of the kselftest for lockdep.
> >
> 
> Thanks for the reminder. CC'ed lockdep maintainers.

Please resend as a whole, this is an unreadable mess.
