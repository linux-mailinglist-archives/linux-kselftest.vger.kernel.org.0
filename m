Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E9E74E7AF
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jul 2023 09:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjGKHJO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jul 2023 03:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjGKHJO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jul 2023 03:09:14 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B60B4A9;
        Tue, 11 Jul 2023 00:09:11 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 36B78tJ4030639;
        Tue, 11 Jul 2023 09:08:55 +0200
Date:   Tue, 11 Jul 2023 09:08:55 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     thomas@t-8ch.de, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 00/22] selftests/nolibc: add minimal kernel config
 support
Message-ID: <ZK0AB1OXH1s2xYsh@1wt.eu>
References: <cover.1687706332.git.falcon@tinylab.org>
 <20230711035508.7273-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711035508.7273-1-falcon@tinylab.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Zhangjin,

On Tue, Jul 11, 2023 at 11:55:08AM +0800, Zhangjin Wu wrote:
> Hi, Willy and Thomas
> 
> I'm planning to renew this patchset, so, require more discuss.
> 
> The main goal of this minimal kernel config support here is faster build
> and therefore faster test for the run target, but this old patchset is
> not enough, especially for the 'mrproper' operation during every config:
> 
>     defconfig:
>      	$(Q)$(MAKE) -C $(srctree) ARCH=$(KARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare
>      
>     +tinyconfig:
>     +	$(Q)$(MAKE) -C $(srctree) ARCH=$(KARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper tinyconfig prepare
>     +

It will depend on the number of runs, because the mrproper will
only be run before recreating a config. Logically once you have
your kernel you're not going to reconfigure it.

> In order to avoid this 'mrproper', one solution is create an arch
> specicifc output directory for all of the kernel targets to avoid they
> share the same build output (by default, it is the same as the source
> code directory and therefore pollute the source code tree), it is
> required for both tools/nolibc and selftests/nolibc:

This could provide an improvement when building for multiple archs
in a row, indeed. But keep in mind that an important aspect is also
to be able to test the kernel you're currently working on, and not
to have to rebuild it again for nolibc into a subdir.

And given that the makefile doesn't know how to iterate over multiple
archs, it would make sense to permit to pass the build output as an
argument to the makefile so that the external script calling make for
each arch would just pass the build directory (as is sometimes done
for the normal kernel).

> The "O" variable could be used to pass an arch specific output for every
> arch:
> 
>     # OUTPUT is only set when run from the main makefile, otherwise
>     # it defaults to this nolibc directory.
>     OUTPUT ?= $(CURDIR)/
> 
>     # Architecture specific directory
>     ARCH_OUTPUT ?= $(CURDIR)/build/$(ARCH)/
> 
> 
> With "O":
> 
>     // tools/nolibc
> 
>     KERNEL_BUILD   ?= $(ARCH_OUTPUT)linux/
>     MAKE_KERNEL     = $(MAKE) -C "$(srctree)" O="$(KERNEL_BUILD)" ARCH=$(ARCH)
> 
>     headers_standalone: headers
>     	$(Q)$(MAKE_KERNEL) headers
>     	$(Q)$(MAKE_KERNEL) headers_install INSTALL_HDR_PATH=$(ARCH_OUTPUT)sysroot
>     
> 
>     // selftests/nolibc
>     RUN_OUT         = $(ARCH_OUTPUT)run.out
>     ...
>     NOLIBC_INITRAMFS  = $(ARCH_OUTPUT)initramfs/
>     ...
>     KERNEL_BUILD   ?= $(ARCH_OUTPUT)linux/
>     MAKE_KERNEL     = $(MAKE) -C "$(srctree)" O="$(KERNEL_BUILD)" ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE)

Yes but this one will break reuse of the already built kernel. Also
for those trying all archs for a single test it will eat a lot of
disk space (when enabling certain debugging symbols you can end up
with extremely large build dirs, I already ran out of space a few
times).

I think that instead we should just let the user pass this "O=" to the
make command and let the lower ones inherit it. That makes it closer
to what it usually done. I'm also fine with using another variable if
there's a good reason for this, but given that it's already called "O"
it's not something unexpected to the user. Thus we could imagine just
running:

    for arch in "${ARCHS[@]}"; do
        make -j$(nproc) O=$PWD/kernel-$arch ARCH=$arch \
             CROSS_COMPILE=/path/to/cc/$arch/bin/$arch- \
             run
    done
             
Which is simple enough without requiring a user to have to figure what
build option to hack on for just a regular build.

> And further, the output of the other targets should be put in the
> $(ARCH_OUTPUT) directory too, include the sysroot, nolibc-test, initramfs,
> run.out and even libc-test, the whole Makefile of selftests/nolibc will be
> touched.

It's a matter of taste but there are pros and cons. I personally spend
my time using grep -r on the sysroots, having gigabytes of .o there would
quickly made me regret that approach. I would also argue that when you
pass "O=" to the kernel build, it serves as a prefix and the directory
hierarchy is preserved, so if you would want to put the sysroots etc
under $O then it would be more logical that it appears in
$O/tools/testing/selftests/nolibc/sysroot/$arch, which would then remain
compatible with today when O corresponds to the kernel's CURDIR. Then
maybe that would be the solution to making O per-arch for those who want
to re-run over many kernels, while keeping it easy for those who want to
test their own kernel or want to grep in sysroot.

> I have prepared and verified such a solution locally, before send the patches,
> welcome your suggestions.
> 
> My local patchset now provides such features:
> 
>   - Allow build everything for a target arch in the arch specific directory
>   
>   - Allow clean everything of a target arch
>   
>   - Allow trigger a config target automatically for the run target, use the new
>     tinyconfig by default, be able to choose defconfig as before
>   
>   - Allow configure additional config options for both defconfig and tinyconfig
>   
>   - Allow configure the default CROSS_COMPILE by default, only the ARCH variable is required
>   
>   - Allow download the missing cross toolchains automatically (from mirrrors.edge.kernel.org)
>   
>   - Allow download the missing bios automatically
>   
>   - Allow download and build musl automatically
>   
>   - Allow run tests for all of the supported architectures automatically with one command
>     with minimal preparation, may be only the installation of qemu-user and qemu-system

There can be good things there, but I'm seeing a lot of "by default" and
"automatically" which worry me, because when you're debugging something,
there's nothing more annoying than all the stuff happening in your back
and fooling your analysis. On the opposite I do value the ability to
proceed through steps that I don't need to revalidate, and these ones
can be done automatically just by chaining a few commands from a script.

And no download should ever be done automatically. Any download must
always be deliberately and consciously initiated by the user. How many
times we've seen some scripts stall with no information, just to discover
a SYN_SENT socket in netstat! You can have a "download-toolchain",
"download-bios", "download-musl" etc if you want, but quite frankly, I'm
seriously doubting it will be *that* useful to anyone working on the
kernel since by definition they already have these toolchains, and
sometimes different ones (e.g. linaro, bootlin etc) and in different
versions. In fact if some expresses the need for having a simplified
command to download a toolchain, then it wouldn't be specific to
nolibc-test but would be used as a general tool for the kernel since
it would be shared with all the rest of the code. You could also imagine
downloading and building qemu, but it also takes a while and we're very
far from the simple build script whose purpose was to validate that a
few syscalls appeared to work fine.

> With the new patchset, it is able to rebuild and rerun everything in several
> minutes, it may make people very happy to develop nolibc itself and also make
> people to work on linux with nolibc, especially for developing and testing a
> new kernel feature ;-)

I doubt it. Rebuilding everything is not what most developers need. What
they need is to just fix a missing parenthesis that broke the build and
rebuild the strict minimum, restarting from where they left. And they
need to be able to figure what caused that "FAILED" output, disassemble
the output, re-run it manually under qemu-user, rebuild the .c manually
after copy-pasting the whole command line via "V=1", etc.

Keep in mind that the purpose of a selftest is not to optimize the case
where it works fine, but to optimize the developer's work when it fails.
This is something that a lot of people tend to get wrong. They're proud
of a "make world" that does everything including delivering them pizzas
to wait for the builds to complete, and they say "hey, impressed?". But
when someone else reports "I'm getting this strange error I don't
understand", they can hardly suggest more than "hmmm run make clean, try
again, or use the same distro as me because it works for me".

What I've tried to focus on from the beginning with this tiny test suite
precisely is debugging. That's why I wanted to support alternate libcs,
to help compare, making it easy to use a different toolchain and other
cflags, running in userland, building just the binary so that I can scp
it to a remote native machine etc. All of these are important, and your
approach above makes me feel like I would lose most of it, or still be
able to do that but in a very complicated way (i.e. constantly have to
reverse-engineer a complicated makefile to figure where I can inject an
option).

However one thing I mentioned in the past is the usefulness of some
batching scripts (I even shared one). And I think that helping the user
prepare certain steps or iterate over architectures *is* useful. When
you do it in two layers (the script replacing the user, the makefile
doing the build job), it remains easy and convenient to use, and you
can pick only what you need (e.g. "please build musl for me"). And if
something goes wrong, it's simple for the user to takeover and complete
that failed task by changing an arch name, a directory or anything, and
have their tools ready. Let's just never make that automatic for the
sake of everyone's health!

Thanks,
Willy
