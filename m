Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5C0754D02
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Jul 2023 03:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjGPBSH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 Jul 2023 21:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjGPBSG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 Jul 2023 21:18:06 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303D2271E;
        Sat, 15 Jul 2023 18:18:01 -0700 (PDT)
X-QQ-mid: bizesmtp83t1689470269tl6qvxpu
Received: from linux-lab-host.localdomain ( [119.123.131.162])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 16 Jul 2023 09:17:48 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: /rrU+puPB7R3dUIHlO09/AeIT/VkiUr5cQOQzyFr2/vxxa2PE0PG2BOpgp/mr
        +hSKy28g2oDqzqG+0la4SaV0sz4yYYw/l3wam333PAU2cl5cOoXataat8Asw1sJVTYh2CS2
        q2sJxmdp6Fx+PDXznUTV+aFsWct1yOOQEs2w4R1rjYCZWYpwZW++yD+h6EBhmraRRd7OgBo
        14OiYcyh2QpLK/vLvcJh0oTZt6NTkVzGHz6K/X3c95YythlyGSw/z0cVTvFrRcgv0F3p5/P
        3WAe3tBxnsRQk7AWo5a4evzItD7KYotUcIlt3IfuGbj2ZF+2OYUNlGTFRHK52iu9dwzaFrd
        7Dl5LYyzv3z6MAkKpvqvvz1GMSLZ0fwrdhXmbZkSpdGCtB7J42nShh3v7w2Rjm7HqZA7Nrk
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2171079884746672651
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v4 00/18] tools/nolibc: shrink arch support
Date:   Sun, 16 Jul 2023 09:17:44 +0800
Message-Id: <20230716011744.499597-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230715222658.GA27708@1wt.eu>
References: <20230715222658.GA27708@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

> Hi Zhangjin,
> 
> On Sun, Jul 16, 2023 at 02:16:36AM +0800, Zhangjin Wu wrote:
> > Hi, Willy, Thomas
> > 
> > Thanks very much for your careful review and great suggestions, now, we
> > get v4 revision of the arch shrink series [1], it mainly include a new
> > fixup for -O0 under gcc < 11.1.0, the stackprotector support for
> > _start_c(), new testcases for startup code and two new test targets.
> > 
> > All of the tests passed or skipped (tinyconfig + few options +
> > qemu-system) for both -Os and -O0:
> (...)
> 
> First, good news, it looks OK from the nolibc-test perspective and
> by looking at the code, so I merged all this into branch
> 
>   20230715-nolibc-next-1
>

Thanks very much.

> Second, bad news, my preinit code doesn't build anymore due to missing
> definitions for statx. It's built using the default method which involves
> just including nolibc.h (and getting linux includes from the default path).
> I could simplify it to this one-liner:
> 
>   $ printf "int test_stat(const char *p, struct stat *b) { return stat(p,b); }\n" |
>     gcc -c -o test.o -xc - -nostdlib -include ./sysroot/x86/include/nolibc.h
> 
>   In file included from ././sysroot/x86/include/nolibc.h:98:0,
>                    from <command-line>:32:
>   ././sysroot/x86/include/sys.h:952:78: warning: 'struct statx' declared inside parameter list will not be visible outside of this definition or declaration
>    int sys_statx(int fd, const char *path, int flags, unsigned int mask, struct statx *buf)
>                                                                                 ^~~~~
>   ././sysroot/x86/include/sys.h:962:74: warning: 'struct statx' declared inside parameter list will not be visible outside of this definition or declaration
>    int statx(int fd, const char *path, int flags, unsigned int mask, struct statx *buf)
>                                                                             ^~~~~
>   ././sysroot/x86/include/sys.h: In function 'statx':
>   ././sysroot/x86/include/sys.h:964:51: warning: passing argument 5 of 'sys_statx' from incompatible pointer type [-Wincompatible-pointer-types]
>     return __sysret(sys_statx(fd, path, flags, mask, buf));
>                                                      ^~~
>   ././sysroot/x86/include/sys.h:952:5: note: expected 'struct statx *' but argument is of type 'struct statx *'
>    int sys_statx(int fd, const char *path, int flags, unsigned int mask, struct statx *buf)
>        ^~~~~~~~~
>   ././sysroot/x86/include/sys.h: In function 'stat':
>   ././sysroot/x86/include/sys.h:971:15: error: storage size of 'statx' isn't known
>     struct statx statx;
>                  ^~~~~
>   ././sysroot/x86/include/sys.h:974:60: error: 'STATX_BASIC_STATS' undeclared (first use in this function)
>     ret = __sysret(sys_statx(AT_FDCWD, path, AT_NO_AUTOMOUNT, STATX_BASIC_STATS, &statx));
>                                                               ^~~~~~~~~~~~~~~~~
>   ././sysroot/x86/include/sys.h:974:60: note: each undeclared identifier is reported only once for each function it appears in
> 
> I finally found that it's due to the lack of -Isysroot/x86/include, so
> it used to get linux includes from those provided by glibc and these ones
> were missing statx since packaged for an older kernel.
>

So, your local glibc may be older than 2.28 (The one we mentioned in the
commit message who supports statx)? mine 2.31 glibc is ok:

    $ ldd --version
    ldd (Ubuntu GLIBC 2.31-0ubuntu9.2) 2.31
    Copyright (C) 2020 Free Software Foundation, Inc.
    This is free software; see the source for copying conditions.  There is NO
    warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
    Written by Roland McGrath and Ulrich Drepper.
    
    // anyone of the following commands work
    $ echo -e "int test_stat(const char *p, struct stat *b) { return stat(p,b); }\n" | gcc -c -o test.o -xc - -nostdlib -include sysroot/x86/include/nolibc.h 
    $ echo -e "int test_stat(const char *p, struct stat *b) { return stat(p,b); }\n" | gcc -c -o test.o -xc - -nostdlib -Isysroot/x86/include -include ../../../include/nolibc/nolibc.h 
    $ echo -e "int test_stat(const char *p, struct stat *b) { return stat(p,b); }\n" | gcc -c -o test.o -xc - -nostdlib -include ../../../include/nolibc/nolibc.h

For older Linux systems without a newer libc may really require the
installation of the linux sysroot (linux/uapi).

In Ubuntu 20.04, the "struct statx" is provided by the linux-libc-dev
package:

    $ dpkg -S /usr/include/linux/
    linux-libc-dev:amd64: /usr/include/linux
    $ dpkg -l | grep linux-libc-dev
    ii  linux-libc-dev:amd64                     5.4.0-88.99                                                    amd64        Linux Kernel Headers for development
    ii  linux-libc-dev-arm64-cross               5.4.0-59.65cross1                                              all          Linux Kernel Headers for development (for cross-compiling)
    ii  linux-libc-dev-armel-cross               5.4.0-59.65cross1                                              all          Linux Kernel Headers for development (for cross-compiling)
    ii  linux-libc-dev-i386-cross                5.4.0-59.65cross1                                              all          Linux Kernel Headers for development (for cross-compiling)
    ii  linux-libc-dev-riscv64-cross             5.4.0-21.25cross1                                              all          Linux Kernel Headers for development (for cross-compiling)
    $ grep "struct statx" -ur /usr/include/linux/
    /usr/include/linux/stat.h: * Timestamp structure for the timestamps in struct statx.
    /usr/include/linux/stat.h:struct statx_timestamp {
    /usr/include/linux/stat.h:struct statx {
    /usr/include/linux/stat.h:	struct statx_timestamp	stx_atime;	/* Last access time */
    /usr/include/linux/stat.h:	struct statx_timestamp	stx_btime;	/* File creation time */
    /usr/include/linux/stat.h:	struct statx_timestamp	stx_ctime;	/* Last attribute change time */
    /usr/include/linux/stat.h:	struct statx_timestamp	stx_mtime;	/* Last data modification time */
    /usr/include/linux/stat.h: * Query request/result mask for statx() and struct statx::stx_mask.
    /usr/include/linux/stat.h:#define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */

This may be relative to glibc version, it is a dep of libc package:

    Package: libc6-dev
    Source: glibc
    Version: 2.36-9
    Architecture: amd64
    Maintainer: GNU Libc Maintainers <debian-glibc@lists.debian.org>
    Installed-Size: 11954
    Depends: libc6 (= 2.36-9), libc-dev-bin (= 2.36-9), linux-libc-dev, libcrypt-dev, libnsl-dev, rpcsvc-proto

> I knew that sooner or later I'd have to reinstall this machine but I
> can't get out of my head that to date I have yet not been convinced by
> the absolute necessity of this modification which is progressively adding
> more burden :-/  Time will tell...
>

This may also let us think about the removing of <linux/xxx.h> from our
nolibc headers? just like musl does ;-)

    $ grep "include <linux" -ur ../../../include/nolibc/
    ../../../include/nolibc/stdlib.h:#include <linux/auxvec.h>
    ../../../include/nolibc/sys.h:#include <linux/fs.h>
    ../../../include/nolibc/sys.h:#include <linux/loop.h>
    ../../../include/nolibc/sys.h:#include <linux/time.h>
    ../../../include/nolibc/sys.h:#include <linux/auxvec.h>
    ../../../include/nolibc/sys.h:#include <linux/fcntl.h> /* for O_* and AT_* */
    ../../../include/nolibc/sys.h:#include <linux/stat.h>  /* for statx() */
    ../../../include/nolibc/sys.h:#include <linux/prctl.h>
    ../../../include/nolibc/types.h:#include <linux/mman.h>
    ../../../include/nolibc/types.h:#include <linux/reboot.h> /* for LINUX_REBOOT_* */
    ../../../include/nolibc/types.h:#include <linux/stat.h>
    ../../../include/nolibc/types.h:#include <linux/time.h>

If simply put all of them to types.h, it may be too much, a new "sys/"
directory with almost the same Linux type files may be required, but as
an in-kernel libc, this duplication may be a "big" issue too, so, adding
minimal required macros and structs in types.h may be another choice.

After removing the duplicated ones, it is not that much:

    ../../../include/nolibc/stdlib.h:#include <linux/auxvec.h>
    ../../../include/nolibc/sys.h:#include <linux/fs.h>
    ../../../include/nolibc/sys.h:#include <linux/loop.h>
    ../../../include/nolibc/sys.h:#include <linux/time.h>
    ../../../include/nolibc/sys.h:#include <linux/fcntl.h> /* for O_* and AT_* */
    ../../../include/nolibc/sys.h:#include <linux/stat.h>  /* for statx() */
    ../../../include/nolibc/sys.h:#include <linux/prctl.h>
    ../../../include/nolibc/types.h:#include <linux/mman.h>
    ../../../include/nolibc/types.h:#include <linux/reboot.h> /* for LINUX_REBOOT_* */

The required new macros and structs may be around 100-300 lines? but it may
help to avoid the installation of sysroot completely and also avoid the cross
including the linux-libc-dev package used by glibc?

Best regards,
Zhangjin

> Cheers,
> Willy
