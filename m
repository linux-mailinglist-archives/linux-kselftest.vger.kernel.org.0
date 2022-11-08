Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21886620EFF
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 12:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbiKHLZo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Nov 2022 06:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234109AbiKHLZG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Nov 2022 06:25:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509174FF9A;
        Tue,  8 Nov 2022 03:25:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C87B9614F6;
        Tue,  8 Nov 2022 11:25:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A9EC433D6;
        Tue,  8 Nov 2022 11:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667906705;
        bh=Jlcv4F7K6dxP/Icf73x6ONzyur9GFR/J4bBQqn3lSGI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KYyqVfSmSq6CRBF0I0oBl/HeUwJx6zE4DpRuJqRHkqKccNQm+lZU3ecqXXJgkTqNw
         IH2zkk0Ie+5wN+u/uRwnaCobHyZiRw7jkIhs+/nZgnk8PR53LOvUxxFGFR5OhP8Gx2
         ukRnUPeDCCtwyTmLB5IkzLO0XpwqS/mGwWi/Wy174JfwTzGpFj9+yh9XKa88S9HMdx
         CLxkV9/WMdyEEY33VMO7vNYSnqvXXvtt15ZD7Td4FBHLEtUGVi/jaxjCKA84W+ZGot
         0BzNlyccOdBUEVUIZxXG04P7rgY7IWg4gyk1qMRCNrB4G36EUKTmhLLR0zh/3cm62o
         l/L7vrd8imLkA==
Date:   Tue, 8 Nov 2022 12:25:00 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Florian Weimer <fweimer@redhat.com>,
        libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: selftests: clone3: clone3_clear_sighand failed - Bail out!
 Failed to clear signal handler for child process
Message-ID: <20221108112500.rffm2hmt2kvdc3io@wittgenstein>
References: <CA+G9fYs+fOTBO=aTfO57xby=QQDaqUt4umwgo6bwLB_iGoSEPw@mail.gmail.com>
 <20221108100420.6zhmrio226vbii4e@wittgenstein>
 <CA+G9fYtoqQq9xgpEzPL=q7ds5WbudRYikBHEAZAh_25SkPj4ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+G9fYtoqQq9xgpEzPL=q7ds5WbudRYikBHEAZAh_25SkPj4ww@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 08, 2022 at 03:51:24PM +0530, Naresh Kamboju wrote:
> On Tue, 8 Nov 2022 at 15:34, Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Tue, Nov 08, 2022 at 03:28:55PM +0530, Naresh Kamboju wrote:
> > > selftests: clone3: clone3_clear_sighand failed on arm32 and i386
> > > but passed on arm64 and x86_64.
> > >
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > >
> > > # selftests: clone3: clone3_clear_sighand
> > > # TAP version 13
> > > # 1..1
> > > # # clone3() syscall supported
> > > # Bail out! Failed to clear signal handler for child process
> > > # # Planned tests != run tests (1 != 0)
> > > # # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
> > > not ok 2 selftests: clone3: clone3_clear_sighand # exit=1
> > >
> > > Test details links,
> > > https://lkft.validation.linaro.org/scheduler/job/5820146#L1795
> > >
> > > Test results comparison link,
> > > https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20221107/testrun/12848543/suite/kselftest-clone3/test/clone3.clone3_clear_sighand/history/
> >
> > Seems before 27 September 2022 this test wasn't run on 32bit instances
> > and noone ever noticed?
> 
> This email is about sharing the results log and reporting failures.
> If you think it is not supported on 32bit the test should SKIP instead of fail.

No, I was just asking whether this has been detected just now for the
first time. If this has been a problem for such a long time I was just
puzzled why this was never reported.
