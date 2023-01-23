Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09C5678332
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jan 2023 18:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbjAWRcW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Jan 2023 12:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbjAWRcM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Jan 2023 12:32:12 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CE22FCC5;
        Mon, 23 Jan 2023 09:31:08 -0800 (PST)
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.88.152])
        by gnuweeb.org (Postfix) with ESMTPSA id 53D9B82EE8;
        Mon, 23 Jan 2023 17:31:05 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1674495067;
        bh=KjR3HeGWgHB57q9Q8tURy2vc2DEolO1MPrSDJwO5k5Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=trbvHZWSsdEi+rgPTTAoUKPKMsBwA0WayiiyAZ+WXIOc5lKjGD/85XpTZweJerLXh
         AjFcXsNiptQk8HKhw0C12cS2cujveL+3QtfpfZklFJIUPKruzKJ0EFycX0FsHri1ba
         zHcfKcyM2rL62I/suzia0jxr4YAsPMWcMc8mYK2DmD2tmPb5J6QZj4O0DuMvY5YaVi
         Qj94zomJdywKBm4Eli+KCj199WYJe/9yKHCWZdR0Ms8EYemZCj+DU6ipfpv/NoGEh3
         inhUU1hyW16hceXmBJn9b0fvFJtf0K5qjgJPoyERHMJrR0latfG5jRyGNQQY28wihU
         WdR68XxxJUdbw==
Date:   Tue, 24 Jan 2023 00:31:01 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/2] selftests/nolibc: small simplification of test
 development phase
Message-ID: <Y87EVVt431Wx2zXk@biznet-home.integral.gnuweeb.org>
References: <20230121085320.11712-1-w@1wt.eu>
 <20230121200038.GG2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230121213455.GA16121@1wt.eu>
 <Y868lIin0bLM9HfM@biznet-home.integral.gnuweeb.org>
 <20230123172016.GB13172@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123172016.GB13172@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 23, 2023 at 06:20:16PM +0100, Willy Tarreau wrote:
> Ah now I think I understand Paul's question. I didn't know that the
> userland version was not always provided. I've always had both side
> by side.
> 
> > It would be great if we can avoid building qemu from the source. But if
> > not, let's go with that.
> 
> As Paul indicated, it's really trouble-free and I think I've only done
> that since the very first day I started to use QEMU, reason why I probably
> never noticed that not everything was packaged.
> 
> Then at least to respond to Paul, it could make sense to add a note that
> on some distros the userland version might not always be provided and
> might require a pretty simple rebuild of QEMU.

Ah well...

I figured it out. It turned qemu-user is a different package.
So I have "qemu-system" installed, but not "qemu-user".

Without building from source, just do this on Ubuntu:

  $ sudo apt-get install qemu-user -y
  ...
  Preparing to unpack .../qemu-user_1%3a6.2+dfsg-2ubuntu6.6_amd64.deb ...
  Unpacking qemu-user (1:6.2+dfsg-2ubuntu6.6) ...
  Selecting previously unselected package qemu-user-binfmt.
  Preparing to unpack .../qemu-user-binfmt_1%3a6.2+dfsg-2ubuntu6.6_amd64.deb ...
  Unpacking qemu-user-binfmt (1:6.2+dfsg-2ubuntu6.6) ...
  Setting up qemu-user (1:6.2+dfsg-2ubuntu6.6) ...
  Setting up qemu-user-binfmt (1:6.2+dfsg-2ubuntu6.6) ...
  Processing triggers for man-db (2.10.2-1) ...

  $ which qemu-x86_64
  /usr/bin/qemu-x86_64

  $ sudo make run-user
  MKDIR   sysroot/x86/include
  make[1]: Entering directory '/home/ammarfaizi2/work/linux.work.cc/tools/include/nolibc'
  make[2]: Entering directory '/home/ammarfaizi2/work/linux.work.cc'
  make[2]: Leaving directory '/home/ammarfaizi2/work/linux.work.cc'
  make[2]: Entering directory '/home/ammarfaizi2/work/linux.work.cc'
    INSTALL /home/ammarfaizi2/work/linux.work.cc/tools/testing/selftests/nolibc/sysroot/sysroot/include
  make[2]: Leaving directory '/home/ammarfaizi2/work/linux.work.cc'
  make[1]: Leaving directory '/home/ammarfaizi2/work/linux.work.cc/tools/include/nolibc'
    CC      nolibc-test
  83 test(s) passed.

Sorry for that. I didn't know that they come from different packages.
It works fine for me now.

-- 
Ammar Faizi

