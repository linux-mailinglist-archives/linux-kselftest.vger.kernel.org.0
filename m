Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8178B676547
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jan 2023 09:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjAUIyC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 21 Jan 2023 03:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjAUIyB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 21 Jan 2023 03:54:01 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D65765F00;
        Sat, 21 Jan 2023 00:53:59 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 30L8rhbr011764;
        Sat, 21 Jan 2023 09:53:43 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 0/2] selftests/nolibc: small simplification of test development phase
Date:   Sat, 21 Jan 2023 09:53:18 +0100
Message-Id: <20230121085320.11712-1-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello Paul,

while developing and testing the recent changes for errno/environ/auxv, I
found that I wasn't relying on the kernel that much and that I was mostly
using qemu in userland only with my local kernel.

I figured that it was more convenient for this purpose than rebuilding an
initramfs and kernel for a quick test, and decided to make this approach
easier to use for everyone by adding a "run-user" target to the Makefile
to do exactly this. E.g:

Native build:
  $ time make -C tools/testing/selftests/nolibc run-user
  ...
  make: Entering directory '/g/public/linux/master/tools/testing/selftests/nolibc'
    MKDIR   sysroot/x86/include
  make[1]: Entering directory '/g/public/linux/master/tools/include/nolibc'
  make[2]: Entering directory '/g/public/linux/master'
  make[2]: Leaving directory '/g/public/linux/master'
  make[2]: Entering directory '/g/public/linux/master'
    INSTALL /g/public/linux/master/tools/testing/selftests/nolibc/sysroot/sysroot/include
  make[2]: Leaving directory '/g/public/linux/master'
  make[1]: Leaving directory '/g/public/linux/master/tools/include/nolibc'
    CC      nolibc-test
  18 chroot_root = -1 EPERM               [FAIL]
  43 link_dir = -1 EACCES  != (-1 EPERM)  [FAIL]
  See all results in /g/public/linux/master/tools/testing/selftests/nolibc/run.out
  make: Leaving directory '/g/public/linux/master/tools/testing/selftests/nolibc'

  real    0m0.966s
  user    0m0.731s
  sys     0m0.164s

Cross build:
  $ time make -C tools/testing/selftests/nolibc run-user ARCH=s390 CROSS_COMPILE=/f/tc/nolibc/gcc-11.3.0-nolibc/s390-linux/bin/s390-linux-
  make: Entering directory '/g/public/linux/master/tools/testing/selftests/nolibc'
    MKDIR   sysroot/s390/include
  make[1]: Entering directory '/g/public/linux/master/tools/include/nolibc'
  make[2]: Entering directory '/g/public/linux/master'
  make[2]: Leaving directory '/g/public/linux/master'
  make[2]: Entering directory '/g/public/linux/master'
    INSTALL /g/public/linux/master/tools/testing/selftests/nolibc/sysroot/sysroot/include
  make[2]: Leaving directory '/g/public/linux/master'
  make[1]: Leaving directory '/g/public/linux/master/tools/include/nolibc'
    CC      nolibc-test
  18 chroot_root = -1 EPERM               [FAIL]
  43 link_dir = -1 EACCES  != (-1 EPERM)  [FAIL]
  See all results in /g/public/linux/master/tools/testing/selftests/nolibc/run.out
  make: Leaving directory '/g/public/linux/master/tools/testing/selftests/nolibc'

  real    0m1.014s
  user    0m0.732s
  sys     0m0.183s

In addition, the "x86_64" value for ARCH= is now supported as I got caught
too many times with it not working in this subdir while it's used for the
rest of the kernel ("x86" is used instead as coming from subarch.include).
Generally you don't type it as x86_64 probably is the native build for most
users, but when you start to test toolchains it's a different thing.

There's no matter of urgency for these patches, they're just a bit of
user-friendly stuff. As such, if you're fine with stacking them on top of
what you already have for 6.3, that will be great, otherwise they can
easily wait.

Thank you!
Willy

[CCing Ammar who could benefit from this]

---
Willy Tarreau (2):
  selftests/nolibc: support "x86_64" for arch name
  selftests/nolibc: add a "run-user" target to test the program in user
    land

 tools/testing/selftests/nolibc/Makefile | 10 ++++++++++
 1 file changed, 10 insertions(+)

-- 
2.17.5

