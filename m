Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5966785AD
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jan 2023 20:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjAWTCA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Jan 2023 14:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjAWTB6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Jan 2023 14:01:58 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B05B1716;
        Mon, 23 Jan 2023 11:01:57 -0800 (PST)
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.88.152])
        by gnuweeb.org (Postfix) with ESMTPSA id 652B782EE9;
        Mon, 23 Jan 2023 19:01:54 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1674500516;
        bh=xwVdlDhpzVag/5ZRVw6w7cj0KSXltPYoj8fR3ps3qBU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SKq7yIICoWMZuGaSIQGkI0+I69MZUda8n4EUBvuG9BEHBH4yJiTEP+73F3s4/99/h
         a+2OjwWo2qfY6ycO9+rc0aFdhQw1q2RZG/GtKVOSmeuhAzSs7/AtBiG/sfN9aKF1k6
         cH7ez4zyRru0nPigte7lWigi30DCZk+Iysq32qcD09/qomLGfrr3Qp+eWbUcfFHLFz
         BoEvXzTYGGpqAZLQ1J6Bbdm5ZmreKCPRy9J2CpKroFa+AA0GXYXmsVoXOCmp7O3Li5
         E1cF97sI5Ggwr6zWnDTF2wfotrO++cTT3bLvsqZaG076dw55DYbFyaUE0CfTsMbfmA
         et6/AWx+dZXlQ==
Date:   Tue, 24 Jan 2023 02:01:50 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Willy Tarreau <w@1wt.eu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 0/2] selftests/nolibc: small simplification of test
 development phase
Message-ID: <Y87ZnsULqjYzo6Y2@biznet-home.integral.gnuweeb.org>
References: <20230121085320.11712-1-w@1wt.eu>
 <20230121200038.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230121213455.GA16121@1wt.eu>
 <Y868lIin0bLM9HfM@biznet-home.integral.gnuweeb.org>
 <20230123172016.GB13172@1wt.eu>
 <Y87EVVt431Wx2zXk@biznet-home.integral.gnuweeb.org>
 <20230123174003.GU2948950@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123174003.GU2948950@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 23, 2023 at 09:40:03AM -0800, Paul E. McKenney wrote: 
> I looked for that, but didn't find it, so thank you!
> 
> (Yes, I should have used dpkg, but I was lazy.)
> 
> Except that when I install Ubuntu 20.04's version, I get this:
> 
> ------------------------------------------------------------------------
> 
> $ sudo make run-user
>   MKDIR   sysroot/x86/include
> make[1]: Entering directory '/home/git/linux-rcu/tools/include/nolibc'
> make[2]: Entering directory '/home/git/linux-rcu'
> make[2]: Leaving directory '/home/git/linux-rcu'
> make[2]: Entering directory '/home/git/linux-rcu'
>   INSTALL /home/git/linux-rcu/tools/testing/selftests/nolibc/sysroot/sysroot/include
> make[2]: Leaving directory '/home/git/linux-rcu'
> make[1]: Leaving directory '/home/git/linux-rcu/tools/include/nolibc'
>   CC      nolibc-test
> 32 gettimeofday_null = -1 EFAULT        [FAIL]
> See all results in /home/git/linux-rcu/tools/testing/selftests/nolibc/run.out
> 
> ------------------------------------------------------------------------
> 
> I have attached run.out.
> 
> In contrast, with my hand-built qemu-x86_64, all tests passed.
> 
> This might be just a version-related bug, but figured I should let you
> guys know.

This is an interesting bug.

I'm a bit reluctant to say that this is a qemu bug. But I can't
reproduce it on my machine. I use qemu that comes from Ubuntu 22.04.

FWIW, my qemu version is:

   $ qemu-x86_64 -version
   qemu-x86_64 version 6.2.0 (Debian 1:6.2+dfsg-2ubuntu6.6)
   Copyright (c) 2003-2021 Fabrice Bellard and the QEMU Project developers

I'll take a look at that gettimeofday() code and see if we have a bug in
it. In meantime, could you send your qemu version info?

-- 
Ammar Faizi

