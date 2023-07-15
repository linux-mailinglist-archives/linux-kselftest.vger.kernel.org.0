Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F52754CC7
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Jul 2023 00:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjGOW1O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 Jul 2023 18:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGOW1N (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 Jul 2023 18:27:13 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9FA191993;
        Sat, 15 Jul 2023 15:27:11 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 36FMQw5g028157;
        Sun, 16 Jul 2023 00:26:58 +0200
Date:   Sun, 16 Jul 2023 00:26:58 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v4 00/18] tools/nolibc: shrink arch support
Message-ID: <20230715222658.GA27708@1wt.eu>
References: <cover.1689444638.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689444638.git.falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Zhangjin,

On Sun, Jul 16, 2023 at 02:16:36AM +0800, Zhangjin Wu wrote:
> Hi, Willy, Thomas
> 
> Thanks very much for your careful review and great suggestions, now, we
> get v4 revision of the arch shrink series [1], it mainly include a new
> fixup for -O0 under gcc < 11.1.0, the stackprotector support for
> _start_c(), new testcases for startup code and two new test targets.
> 
> All of the tests passed or skipped (tinyconfig + few options +
> qemu-system) for both -Os and -O0:
(...)

First, good news, it looks OK from the nolibc-test perspective and
by looking at the code, so I merged all this into branch

  20230715-nolibc-next-1

Second, bad news, my preinit code doesn't build anymore due to missing
definitions for statx. It's built using the default method which involves
just including nolibc.h (and getting linux includes from the default path).
I could simplify it to this one-liner:

  $ printf "int test_stat(const char *p, struct stat *b) { return stat(p,b); }\n" |
    gcc -c -o test.o -xc - -nostdlib -include ./sysroot/x86/include/nolibc.h

  In file included from ././sysroot/x86/include/nolibc.h:98:0,
                   from <command-line>:32:
  ././sysroot/x86/include/sys.h:952:78: warning: 'struct statx' declared inside parameter list will not be visible outside of this definition or declaration
   int sys_statx(int fd, const char *path, int flags, unsigned int mask, struct statx *buf)
                                                                                ^~~~~
  ././sysroot/x86/include/sys.h:962:74: warning: 'struct statx' declared inside parameter list will not be visible outside of this definition or declaration
   int statx(int fd, const char *path, int flags, unsigned int mask, struct statx *buf)
                                                                            ^~~~~
  ././sysroot/x86/include/sys.h: In function 'statx':
  ././sysroot/x86/include/sys.h:964:51: warning: passing argument 5 of 'sys_statx' from incompatible pointer type [-Wincompatible-pointer-types]
    return __sysret(sys_statx(fd, path, flags, mask, buf));
                                                     ^~~
  ././sysroot/x86/include/sys.h:952:5: note: expected 'struct statx *' but argument is of type 'struct statx *'
   int sys_statx(int fd, const char *path, int flags, unsigned int mask, struct statx *buf)
       ^~~~~~~~~
  ././sysroot/x86/include/sys.h: In function 'stat':
  ././sysroot/x86/include/sys.h:971:15: error: storage size of 'statx' isn't known
    struct statx statx;
                 ^~~~~
  ././sysroot/x86/include/sys.h:974:60: error: 'STATX_BASIC_STATS' undeclared (first use in this function)
    ret = __sysret(sys_statx(AT_FDCWD, path, AT_NO_AUTOMOUNT, STATX_BASIC_STATS, &statx));
                                                              ^~~~~~~~~~~~~~~~~
  ././sysroot/x86/include/sys.h:974:60: note: each undeclared identifier is reported only once for each function it appears in

I finally found that it's due to the lack of -Isysroot/x86/include, so
it used to get linux includes from those provided by glibc and these ones
were missing statx since packaged for an older kernel.

I knew that sooner or later I'd have to reinstall this machine but I
can't get out of my head that to date I have yet not been convinced by
the absolute necessity of this modification which is progressively adding
more burden :-/  Time will tell...

Cheers,
Willy
