Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFFCB5850B8
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Jul 2022 15:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236644AbiG2NTl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Jul 2022 09:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236564AbiG2NTj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Jul 2022 09:19:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3A26170B;
        Fri, 29 Jul 2022 06:19:34 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 79FB620F96;
        Fri, 29 Jul 2022 13:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659100772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0NOHoO5pDnDM2VrGEVv3dHZSyGwX/afdE0gaL3Yb6WQ=;
        b=V9y8qH/RiFKTyzdqVyEddKjvrmZ90LYQDkM4SxcLkxz4EQcyZsevCt1D5PaSiUh0T8u6V8
        0X8W5SA54RhWf/XoNoyM8rAaKbWfmpo61o3GHHMoj4lOZ2wawq4af7OC024XXFFbqy99pf
        aegMhqQl4sT0wxZAniprTt43g6La4fs=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 504B02C141;
        Fri, 29 Jul 2022 13:19:32 +0000 (UTC)
Date:   Fri, 29 Jul 2022 15:19:31 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, jpoimboe@redhat.com, mbenes@suse.cz
Subject: Re: [PATCH v2 2/2] selftests: livepatch: Test livepatching a heavily
 called syscall
Message-ID: <YuPeY6hZCPI+Kh/t@alley>
References: <20220630141226.2802-1-mpdesouza@suse.com>
 <20220630141226.2802-3-mpdesouza@suse.com>
 <Ys2Li9ilYtpmJhN3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys2Li9ilYtpmJhN3@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue 2022-07-12 10:56:11, Joe Lawrence wrote:
> On Thu, Jun 30, 2022 at 11:12:26AM -0300, Marcos Paulo de Souza wrote:
> > Syscalls are called a tricky way. Some architectures add a prefix to the
> > syscall name (SYSCALL_WRAPPER).
> > 
> > This new test creates one userspace process per online cpu calling getpid
> > continuously and tries to livepatch the getpid function. Add the correct
> > function prefix for all archs that select HAS_SYSCALL_WRAPPER.
> > 
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> 
> Hi Marcos,
> 
> Thanks for working on this and sorry for the delayed reply.  I gave it a
> spin yesterday and have a few comments below...
> 
> > diff --git a/tools/testing/selftests/livepatch/Makefile b/tools/testing/selftests/livepatch/Makefile
> > index 5ef492b87bb1..35014197184e 100644
> > --- a/tools/testing/selftests/livepatch/Makefile
> > +++ b/tools/testing/selftests/livepatch/Makefile
> > @@ -1,10 +1,14 @@
> >  # SPDX-License-Identifier: GPL-2.0
> > +include ../../../build/Build.include
> > +include ../../../scripts/Makefile.arch
> > +include ../../../scripts/Makefile.include

This looks bad. It is outside of tools/tests/selftests/. It would
mean that the tests are not self-contained any longer.

The tests should support all scenarios described in
Documentation/dev-tools/kselftest.rst.

Note that it allows to install them and run them from
the installed copy. I guess that this is useful if you
want to package the selftests.


> Final note, kbuild is probably my weakest area, so I'm of limited help
> review-wise there.  In trying out the code, I wasn't sure exactly how to
> run things.  I did:
> 
>   $ make -C tools/testing/selftests/livepatch/ run_tests
> 
> and that built everything and ran the tests (good).  I changed a few .c
> files and tried again, but they didn't rebuild.  Then from
> tools/testing/selftests/livepatch/test_modules/ I ran `make` and it only
> ran the clean target (not good, I think).
>
> What is the typical workflow supposed to be in this combined setup?

I personally test the mainline kernels the following way:

workstation> make binrpm-pkg

test-system-qemu# sshfs workstation:/path/to/packages /mnt
test-system-qemu# rpm -ivh /mnt/RPMS/x86_64/kernel-xxxx.rpm
test-system-qemu# reboot

test-system-qemu# sshfs workstation:/path/to/sources /mnt
test-system-qemu# cd /mnt/linux/tools/tests/selftests/livepatch
test-system-qemu# make run_tests

With this patchset I get:

test-system-qemu:/mnt/kernel/linux/tools/testing/selftests/livepatch # make run_tests 
make -C test_modules test_klp_atomic_replace.ko
make[1]: Entering directory '/mnt/kernel/linux/tools/testing/selftests/livepatch/test_modules'
make -C /lib/modules/5.19.0-rc8-default+/build M=/mnt/kernel/linux/tools/testing/selftests/livepatch/test_modules test_klp_atomic_replace.ko
make[2]: Entering directory '/mnt/kernel/linux/tools/testing/selftests/livepatch/test_modules'
make[2]: *** /lib/modules/5.19.0-rc8-default+/build: No such file or directory.  Stop.
make[2]: Leaving directory '/mnt/kernel/linux/tools/testing/selftests/livepatch/test_modules'
make[1]: *** [Makefile:17: test_klp_atomic_replace.ko] Error 2
make[1]: Leaving directory '/mnt/kernel/linux/tools/testing/selftests/livepatch/test_modules'
make: *** [Makefile:44: /mnt/kernel/linux/tools/testing/selftests/livepatch/test_modules/test_klp_atomic_replace.ko] Error 2


I get the same when I try it from the top level directory:

test-system-qemu:/mnt/kernel/linux # make -C tools/testing/selftests TARGETS=livepatch run_tests
make: Entering directory '/mnt/kernel/linux/tools/testing/selftests'
make --no-builtin-rules ARCH=x86 -C ../../.. headers_install
make[1]: Entering directory '/mnt/kernel/linux'
  INSTALL ./usr/include
make[1]: Leaving directory '/mnt/kernel/linux'
make[1]: Entering directory '/mnt/kernel/linux/tools/testing/selftests/livepatch'
make -C test_modules test_klp_atomic_replace.ko
make[2]: Entering directory '/mnt/kernel/linux/tools/testing/selftests/livepatch/test_modules'
make -C /lib/modules/5.19.0-rc8-default+/build M=/mnt/kernel/linux/tools/testing/selftests/livepatch/test_modules test_klp_atomic_replace.ko
make[3]: Entering directory '/mnt/kernel/linux/tools/testing/selftests/livepatch/test_modules'
make[3]: *** /lib/modules/5.19.0-rc8-default+/build: No such file or directory.  Stop.
make[3]: Leaving directory '/mnt/kernel/linux/tools/testing/selftests/livepatch/test_modules'
make[2]: *** [Makefile:17: test_klp_atomic_replace.ko] Error 2
make[2]: Leaving directory '/mnt/kernel/linux/tools/testing/selftests/livepatch/test_modules'
make[1]: *** [Makefile:44: /mnt/kernel/linux/tools/testing/selftests/livepatch/test_modules/test_klp_atomic_replace.ko] Error 2
make[1]: Leaving directory '/mnt/kernel/linux/tools/testing/selftests/livepatch'
make: *** [Makefile:178: all] Error 2
make: Leaving directory '/mnt/kernel/linux/tools/testing/selftests'


I am not sure if this is exactly the process described in
Documentation/dev-tools/kselftest.rst. But it looks to me that
it is the way how to test "any" kernel with selftests
from an up-to-date kernel sources.

Best Regards,
Petr
