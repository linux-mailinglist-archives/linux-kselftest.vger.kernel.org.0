Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41096785E0
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jan 2023 20:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbjAWTMq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Jan 2023 14:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjAWTMo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Jan 2023 14:12:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981A832E40;
        Mon, 23 Jan 2023 11:12:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 321BC60FE5;
        Mon, 23 Jan 2023 19:12:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E41C433EF;
        Mon, 23 Jan 2023 19:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674501158;
        bh=islRvDNrVD3ntDfkLsFbpt6J8Sa/zaz/j4KZu8k2Zh4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=S7tkux1Xh9FworSgFd1H5Q0Sp9ixUGaLD4cIlVszsDurONBwWOr9IbdUy3zTG+QAJ
         Gws17/yk3qg8Uv27DAdoes2sy4nC6Kv9VMpQtyCNCI2hJmHpTB27mJSaOoCzqgc8yv
         FG8gHGc8ABY2/kmn2kwO2n3DvP+7l8pUSHlLFQS17NdBpCmYljKRjqdv4U4mLcElqJ
         zLpm806hG7KHPbx1BeCaw77M1O8luDdxp2rbnHa73fXEK/2CrP2dWXDzmGzd9MmgCF
         57wcXHH8LQ20nf6LyzOP9whyNUhW+FYTH6TpO4iu66qv/LkSH2F/RkgUba94IXgwqR
         HD97KNTzb0+oA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 237FF5C0543; Mon, 23 Jan 2023 11:12:38 -0800 (PST)
Date:   Mon, 23 Jan 2023 11:12:38 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Willy Tarreau <w@1wt.eu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 0/2] selftests/nolibc: small simplification of test
 development phase
Message-ID: <20230123191238.GX2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230121085320.11712-1-w@1wt.eu>
 <20230121200038.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230121213455.GA16121@1wt.eu>
 <Y868lIin0bLM9HfM@biznet-home.integral.gnuweeb.org>
 <20230123172016.GB13172@1wt.eu>
 <Y87EVVt431Wx2zXk@biznet-home.integral.gnuweeb.org>
 <20230123174003.GU2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y87ZnsULqjYzo6Y2@biznet-home.integral.gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y87ZnsULqjYzo6Y2@biznet-home.integral.gnuweeb.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 24, 2023 at 02:01:50AM +0700, Ammar Faizi wrote:
> On Mon, Jan 23, 2023 at 09:40:03AM -0800, Paul E. McKenney wrote: 
> > I looked for that, but didn't find it, so thank you!
> > 
> > (Yes, I should have used dpkg, but I was lazy.)
> > 
> > Except that when I install Ubuntu 20.04's version, I get this:
> > 
> > ------------------------------------------------------------------------
> > 
> > $ sudo make run-user
> >   MKDIR   sysroot/x86/include
> > make[1]: Entering directory '/home/git/linux-rcu/tools/include/nolibc'
> > make[2]: Entering directory '/home/git/linux-rcu'
> > make[2]: Leaving directory '/home/git/linux-rcu'
> > make[2]: Entering directory '/home/git/linux-rcu'
> >   INSTALL /home/git/linux-rcu/tools/testing/selftests/nolibc/sysroot/sysroot/include
> > make[2]: Leaving directory '/home/git/linux-rcu'
> > make[1]: Leaving directory '/home/git/linux-rcu/tools/include/nolibc'
> >   CC      nolibc-test
> > 32 gettimeofday_null = -1 EFAULT        [FAIL]
> > See all results in /home/git/linux-rcu/tools/testing/selftests/nolibc/run.out
> > 
> > ------------------------------------------------------------------------
> > 
> > I have attached run.out.
> > 
> > In contrast, with my hand-built qemu-x86_64, all tests passed.
> > 
> > This might be just a version-related bug, but figured I should let you
> > guys know.
> 
> This is an interesting bug.
> 
> I'm a bit reluctant to say that this is a qemu bug. But I can't
> reproduce it on my machine. I use qemu that comes from Ubuntu 22.04.
> 
> FWIW, my qemu version is:
> 
>    $ qemu-x86_64 -version
>    qemu-x86_64 version 6.2.0 (Debian 1:6.2+dfsg-2ubuntu6.6)
>    Copyright (c) 2003-2021 Fabrice Bellard and the QEMU Project developers
> 
> I'll take a look at that gettimeofday() code and see if we have a bug in
> it. In meantime, could you send your qemu version info?

Thank you for looking into this, and here you go:

    $ qemu-x86_64 -version
    qemu-x86_64 version 4.2.1 (Debian 1:4.2-3ubuntu6.24)
    Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers

The version that I built by hand (which passed all tests) is as follows:

    $ /home/git/qemu/build/qemu-x86_64 -version
    qemu-x86_64 version 7.2.0 (v7.2.0)
    Copyright (c) 2003-2022 Fabrice Bellard and the QEMU Project developers

							Thanx, Paul
