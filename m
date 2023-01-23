Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802DE678262
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jan 2023 17:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbjAWQ6K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Jan 2023 11:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbjAWQ6E (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Jan 2023 11:58:04 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BAC2D60;
        Mon, 23 Jan 2023 08:58:03 -0800 (PST)
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.88.152])
        by gnuweeb.org (Postfix) with ESMTPSA id B7B0E82EE8;
        Mon, 23 Jan 2023 16:58:00 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1674493083;
        bh=RL84kMCvYWv/pTDDDFyHQaSrNTODlwVbtU2vRg+2Pg8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N5g3kO15ss6WuApxMtAGjHEnLrjaLwX5uXjmzlv1kaGifsk9F9DI0k9uO8E/ikgUk
         kcszc/4vucqZ7DagY6FdzZtKdSl/P2h1yGZ0Wt35TJc0IgdSSWr3Lc1axJX5jdQQ6t
         sydAvDNBVon9Qqbbu+JY9yy4MucVgCori95cLflE/METJ5eQCdEkMfV3+LkM643/ww
         tMYZ5YS0yhYTmwYIBeTNm85SUF8AEKt1Pc9onshSNclSQTDcC+t5ucbh//uxIiklhx
         A7Z9UHs0ISAlTPF/EJSmbRvdNAuPk3HYLreYvLyMlr4J4hTaBtwx55z3bua8Tp5/qS
         656SPJ3dVPflg==
Date:   Mon, 23 Jan 2023 23:57:56 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/2] selftests/nolibc: small simplification of test
 development phase
Message-ID: <Y868lIin0bLM9HfM@biznet-home.integral.gnuweeb.org>
References: <20230121085320.11712-1-w@1wt.eu>
 <20230121200038.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230121213455.GA16121@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230121213455.GA16121@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jan 21, 2023 at 10:34:55PM +0100, Willy Tarreau wrote:
> On Sat, Jan 21, 2023 at 12:00:38PM -0800, Paul E. McKenney wrote:
> > One dependency is of course qemu-x86_64, so in the meantime I will figure
> > out where I get that from.  ;-)
> 
> I build it from time to time from the sources, it's not that long and
> normally doesn't reserve me any surprises. But if you have it for other
> platforms it's likely that you have it for most platforms as well,
> including this one.

Willy,

Is there a way to make it work for the default qemu installation?
Or maybe it's a mandatory requirement to build qemu from the source?

I use the qemu that comes from Ubuntu apt. I have "qemu-system-x86_64",
but no "qemu-x86_64". So, something like this...

  $ which qemu-x86_64
  $ echo $?
  1

  $ which qemu-system-x86_64
  /usr/bin/qemu-system-x86_64

  $ time make run-user
    MKDIR   sysroot/x86/include
  make[1]: Entering directory '/home/ammarfaizi2/work/linux.work.cc/tools/include/nolibc'
  make[2]: Entering directory '/home/ammarfaizi2/work/linux.work.cc'
  make[2]: Leaving directory '/home/ammarfaizi2/work/linux.work.cc'
  make[2]: Entering directory '/home/ammarfaizi2/work/linux.work.cc'
    INSTALL /home/ammarfaizi2/work/linux.work.cc/tools/testing/selftests/nolibc/sysroot/sysroot/include
  make[2]: Leaving directory '/home/ammarfaizi2/work/linux.work.cc'
  make[1]: Leaving directory '/home/ammarfaizi2/work/linux.work.cc/tools/include/nolibc'
    CC      nolibc-test
  /bin/sh: 1: qemu-x86_64: not found
  0 test(s) passed.

  real    0m0.506s
  user    0m0.393s
  sys     0m0.086s

It would be great if we can avoid building qemu from the source. But if
not, let's go with that.

Thanks!

-- 
Ammar Faizi
