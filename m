Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E52678366
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jan 2023 18:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbjAWRhc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Jan 2023 12:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjAWRha (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Jan 2023 12:37:30 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C0A1A5F1;
        Mon, 23 Jan 2023 09:37:16 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 30NHb7x1014494;
        Mon, 23 Jan 2023 18:37:07 +0100
Date:   Mon, 23 Jan 2023 18:37:07 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/2] selftests/nolibc: small simplification of test
 development phase
Message-ID: <20230123173707.GC13172@1wt.eu>
References: <20230121085320.11712-1-w@1wt.eu>
 <20230121200038.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230121213455.GA16121@1wt.eu>
 <Y868lIin0bLM9HfM@biznet-home.integral.gnuweeb.org>
 <20230123172016.GB13172@1wt.eu>
 <Y87EVVt431Wx2zXk@biznet-home.integral.gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y87EVVt431Wx2zXk@biznet-home.integral.gnuweeb.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 24, 2023 at 12:31:01AM +0700, Ammar Faizi wrote:
> I figured it out. It turned qemu-user is a different package.
> So I have "qemu-system" installed, but not "qemu-user".
> 
> Without building from source, just do this on Ubuntu:
> 
>   $ sudo apt-get install qemu-user -y
>   ...
>   Preparing to unpack .../qemu-user_1%3a6.2+dfsg-2ubuntu6.6_amd64.deb ...
>   Unpacking qemu-user (1:6.2+dfsg-2ubuntu6.6) ...
>   Selecting previously unselected package qemu-user-binfmt.
>   Preparing to unpack .../qemu-user-binfmt_1%3a6.2+dfsg-2ubuntu6.6_amd64.deb ...
>   Unpacking qemu-user-binfmt (1:6.2+dfsg-2ubuntu6.6) ...
>   Setting up qemu-user (1:6.2+dfsg-2ubuntu6.6) ...
>   Setting up qemu-user-binfmt (1:6.2+dfsg-2ubuntu6.6) ...
>   Processing triggers for man-db (2.10.2-1) ...
> 
>   $ which qemu-x86_64
>   /usr/bin/qemu-x86_64

Ah cool! I looked for something like this on a remote ubuntu system but
failed to figure it out by myself. Do you also have the other archs with
it ?

>   $ sudo make run-user
>   MKDIR   sysroot/x86/include
>   make[1]: Entering directory '/home/ammarfaizi2/work/linux.work.cc/tools/include/nolibc'
>   make[2]: Entering directory '/home/ammarfaizi2/work/linux.work.cc'
>   make[2]: Leaving directory '/home/ammarfaizi2/work/linux.work.cc'
>   make[2]: Entering directory '/home/ammarfaizi2/work/linux.work.cc'
>     INSTALL /home/ammarfaizi2/work/linux.work.cc/tools/testing/selftests/nolibc/sysroot/sysroot/include
>   make[2]: Leaving directory '/home/ammarfaizi2/work/linux.work.cc'
>   make[1]: Leaving directory '/home/ammarfaizi2/work/linux.work.cc/tools/include/nolibc'
>     CC      nolibc-test
>   83 test(s) passed.

Great. And without sudo you should see two of them fail. I intend to
implement geteuid() and condition their result to it, that will be
sufficient for most cases. I'd rather avoid seeing users run test
programs under sudo actually, since they're run on the local system :-/

> Sorry for that. I didn't know that they come from different packages.
> It works fine for me now.

No, don't be sorry, quite the opposite, you taught us something useful!

Thank you!
Willy
