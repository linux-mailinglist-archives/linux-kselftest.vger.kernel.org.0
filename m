Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A8767863D
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jan 2023 20:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbjAWTZq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Jan 2023 14:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbjAWTZp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Jan 2023 14:25:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262A6559F;
        Mon, 23 Jan 2023 11:25:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A47866101C;
        Mon, 23 Jan 2023 19:25:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049FCC433EF;
        Mon, 23 Jan 2023 19:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674501941;
        bh=CQO8sAt05z7HNpCiygP6X5/bkrbsFXfz4htbMDsLKr4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=JCpubCMxBXCgZgZrqd16Lo5/KeyXxxf4JEYejAE0MrSkmNjjGw3onmRw3d5tfh44Y
         nEZntg9SqGEdUmNztK3xrw4ibZhZRK0HBzOBo4tfiKSvSc3hKzlVJMdusZUGc4EKiA
         gbH1Nj6H3eLOzweNFcYYMzwcrlPMz/PEXi4Y3YeZk5VSvEoAxc+qcpATjapDl07cb4
         affT7597qVXEgwvPNtmNJPi2LOYLx0u0jc4/vj0HuGDMDRz5iRbsG9/Bh4AJ2tIlHr
         r9Y5cSfpq+v5PkfESaZAH4NUTGp/ASSgn0hmpuTDp8V+57shikW5TNhV4q+SJdIDKw
         IxgVKztKk1Ojw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8A4DC5C043A; Mon, 23 Jan 2023 11:25:40 -0800 (PST)
Date:   Mon, 23 Jan 2023 11:25:40 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/2] selftests/nolibc: small simplification of test
 development phase
Message-ID: <20230123192540.GZ2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230121085320.11712-1-w@1wt.eu>
 <20230121200038.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230121213455.GA16121@1wt.eu>
 <Y868lIin0bLM9HfM@biznet-home.integral.gnuweeb.org>
 <20230123172016.GB13172@1wt.eu>
 <Y87EVVt431Wx2zXk@biznet-home.integral.gnuweeb.org>
 <20230123174003.GU2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230123191250.GD13172@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123191250.GD13172@1wt.eu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 23, 2023 at 08:12:50PM +0100, Willy Tarreau wrote:
> On Mon, Jan 23, 2023 at 09:40:03AM -0800, Paul E. McKenney wrote:
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
> Interesting. Maybe something differs in the way it passes expectedly
> invalid pointers to some syscalls. Keep in mind that it's using your
> local kernel also, that could make a difference. I'm not that much keen
> on trying to investigate that one to be honest, given that this user
> mode is really meant to ease the life of test developers like Ammar
> and myself who just want to focus on the correctness of the test they're
> adding and not that much on the validity of the test itself in this
> context. I suggest we keep this one in mind without putting too much
> effort on it for now.

Indeed, it is easy for me to remove qemu-user and re-install my
hand-built version.  In fact, I just now did this and verified that
everything now passes.  ;-)

							Thanx, Paul
