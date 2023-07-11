Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7CAB74E5A9
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jul 2023 06:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjGKEDH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jul 2023 00:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbjGKEDG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jul 2023 00:03:06 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3EA12A;
        Mon, 10 Jul 2023 21:03:03 -0700 (PDT)
X-QQ-mid: bizesmtp87t1689047765t5k8nm7u
Received: from localhost.localdomain ( [116.30.126.249])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 11 Jul 2023 11:56:03 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: 2KxaQ4e4DJSXxVMIxm62BmR5CWYTSe93SBnDRQVYkAlWUBSaFPutv7mx8ZzZ2
        Hzk/NredcNyAJ7A09rVV3lTjtSlmMTRLhsF+VgtcLtkwB+DMW6K3iTD+nOybmDsw98GXOXv
        BR90S3FYEK9pkqFrsMhTnw1oYBq49WqwQYWdfOgO5dQjn1b9+yqBWFXl1BCqmjmuNxmpnG/
        tVq3d28llynZ+UUp7AkDdi2/l9bFtAlVd9M7Vd0NRqSBAyQtHglOZbvFTGcPqiYo1BLlN2F
        /IqclF+jq2rrhbIR3cFUwyJy2bkYoTgKedueY/o3+NWt0bvVNMMaYKxaSfUITqmAJOIAM+h
        AYkO+5biuJbSBn8uW9kWEN6+62Amnz0gqm9CTZ1ietLviGOF762qiyxzvl91Q==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8635562446704093046
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v1 00/22] selftests/nolibc: add minimal kernel config support
Date:   Tue, 11 Jul 2023 11:55:08 +0800
Message-Id: <20230711035508.7273-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687706332.git.falcon@tinylab.org>
References: <cover.1687706332.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy and Thomas

I'm planning to renew this patchset, so, require more discuss.

The main goal of this minimal kernel config support here is faster build
and therefore faster test for the run target, but this old patchset is
not enough, especially for the 'mrproper' operation during every config:

    defconfig:
     	$(Q)$(MAKE) -C $(srctree) ARCH=$(KARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare
     
    +tinyconfig:
    +	$(Q)$(MAKE) -C $(srctree) ARCH=$(KARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper tinyconfig prepare
    +

In order to avoid this 'mrproper', one solution is create an arch
specicifc output directory for all of the kernel targets to avoid they
share the same build output (by default, it is the same as the source
code directory and therefore pollute the source code tree), it is
required for both tools/nolibc and selftests/nolibc:

    // tools/nolibc

    headers_standalone: headers
    	$(Q)$(MAKE) -C $(srctree) headers
    	$(Q)$(MAKE) -C $(srctree) headers_install INSTALL_HDR_PATH=$(OUTPUT)sysroot
    

    // selftests/nolibc

    defconfig:
    	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare
    
    kernel: initramfs
    	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME) CONFIG_INITRAMFS_SOURCE=$(CURDIR)/initramfs
    
    # run the tests after building the kernel
    run: kernel
    	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
    	$(Q)$(REPORT) $(CURDIR)/run.out


The "O" variable could be used to pass an arch specific output for every
arch:

    # OUTPUT is only set when run from the main makefile, otherwise
    # it defaults to this nolibc directory.
    OUTPUT ?= $(CURDIR)/

    # Architecture specific directory
    ARCH_OUTPUT ?= $(CURDIR)/build/$(ARCH)/


With "O":

    // tools/nolibc

    KERNEL_BUILD   ?= $(ARCH_OUTPUT)linux/
    MAKE_KERNEL     = $(MAKE) -C "$(srctree)" O="$(KERNEL_BUILD)" ARCH=$(ARCH)

    headers_standalone: headers
    	$(Q)$(MAKE_KERNEL) headers
    	$(Q)$(MAKE_KERNEL) headers_install INSTALL_HDR_PATH=$(ARCH_OUTPUT)sysroot
    

    // selftests/nolibc
    RUN_OUT         = $(ARCH_OUTPUT)run.out
    ...
    NOLIBC_INITRAMFS  = $(ARCH_OUTPUT)initramfs/
    ...
    KERNEL_BUILD   ?= $(ARCH_OUTPUT)linux/
    MAKE_KERNEL     = $(MAKE) -C "$(srctree)" O="$(KERNEL_BUILD)" ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE)
    KERNEL_IMAGE    = $(KERNEL_BUILD)$(IMAGE)
    KERNEL_CONFIG   = $(KERNEL_BUILD).config

    defconfig:
    	$(Q)$(MAKE_KERNEL) $(DEFCONFIG) prepare
    
    kernel: initramfs
    	$(Q)$(MAKE_KERNEL) $(IMAGE_NAME) CONFIG_INITRAMFS_SOURCE=$(NOLIBC_INITRAMFS)
    
    # run the tests after building the kernel
    run: kernel
    	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(KERNEL_IMAGE)" -serial stdio $(QEMU_ARGS) > "$(RUN_OUT)"
    	$(Q)$(REPORT) $(RUN_OUT)

And further, the output of the other targets should be put in the
$(ARCH_OUTPUT) directory too, include the sysroot, nolibc-test, initramfs,
run.out and even libc-test, the whole Makefile of selftests/nolibc will be
touched.

I have prepared and verified such a solution locally, before send the patches,
welcome your suggestions.

My local patchset now provides such features:

  - Allow build everything for a target arch in the arch specific directory
  
  - Allow clean everything of a target arch
  
  - Allow trigger a config target automatically for the run target, use the new
    tinyconfig by default, be able to choose defconfig as before
  
  - Allow configure additional config options for both defconfig and tinyconfig
  
  - Allow configure the default CROSS_COMPILE by default, only the ARCH variable is required
  
  - Allow download the missing cross toolchains automatically (from mirrrors.edge.kernel.org)
  
  - Allow download the missing bios automatically
  
  - Allow download and build musl automatically
  
  - Allow run tests for all of the supported architectures automatically with one command
    with minimal preparation, may be only the installation of qemu-user and qemu-system

With the new patchset, it is able to rebuild and rerun everything in several
minutes, it may make people very happy to develop nolibc itself and also make
people to work on linux with nolibc, especially for developing and testing a
new kernel feature ;-)

Without this reorg of the output directory, it is very hard to verify this
tinyconfig support patchset itself, it always require 'mrproper' to clean the
whole build while config and test another ARCH (because the source code tree is
polluted). for one ARCH, it is not that time-costed, but for all, it waste too
much time. That means, without the arch specific output support, our minimal
config support is really not that helpful, it also breaks the possibility to
share the already built binaries for rebuild after a reconfig.

If it is hard to make decision on this description, I'm ok to send the whole
new patchset for more discussion.

The change is 'huge' and the review work may be 'huge' too ;-)

Thanks,
Zhangjin

> Willy, Thomas
> 
> We just sent the 'selftests/nolibc: allow run with minimal kernel
> config' series [1], Here is the 'minimal' kernel config support, with
> both of them, it is possible to run nolibc-test for all architectures
> with oneline command and in less than ~30 minutes - 1 hour (not fullly
> measured yet):
> 
>     // run with tiny config + qemu-system
>     // Note: rv32 and loongarch require to download the bios at first
>     $ time make run-tiny-all QUIET_RUN=1
> 
>     // run with default config + qemu-system
>     $ time make run-default-all QUIET_RUN=1
> 
>     // run with qemu-user
>     $ time make run-user-all QUIET_RUN=1
> 
> Besides the 'tinyconfig' suggestion from Thomas, this patch also merge
> the generic part of my local powerpc porting (the extconfig to add
> additional console support).
> 
> This is applied after the test report patchset [2] and the rv32 compile
> patchset [3], because all of them touched the same Makefile.
> 
> Even without the 'selftests/nolibc: allow run with minimal kernel
> config' series [1], all of the tests can pass except the /proc/self/net
> related ones (We haven't enable CONFIG_NET in this patchset), the
> chmod_net one will be removed by Thomas from this patchset [4] for the
> wrong chmodable attribute issue of /proc/self/net, the link_cross one
> can be simply fixed up by using another /proc/self interface (like
> /proc/self/cmdline), which will be covered in our revision of the [1]
> series.
> 
> Beside the core 'minimal' config support, some generic patch are added
> together to avoid patch conflicts.
> 
> * selftests/nolibc: add test for -include /path/to/nolibc.h
> 
>   Add a test switch to allow run nolibc-test with nolibc.h
> 
> * selftests/nolibc: print result to the screen too
> 
>   Let the run targets print results by default, allow disable by
>   QUIET_RUN=1
> 
> * selftests/nolibc: allow use x86_64 toolchain for i386
> 
>   Allow use x86_64 toolchains for i386
> 
> * selftests/nolibc: add menuconfig target for manual config
> 
>   a new 'menuconfig' target added for development and debugging
> 
> * selftests/nolibc: add tinyconfig target
> 
>   a new 'tinyconfig' compare to 'defconfig', smaller and faster, but not
>   enough for boot and print, require following 'extconfig' target
> 
> * selftests/nolibc: allow customize extra kernel config options
> 
>   a new 'extconfig' allows to add extra config options for 'defconfig'
>   and 'tinyconfig'
> 
> * selftests/nolibc: add common extra config options
>   selftests/nolibc: add power reset control support
>   selftests/nolibc: add procfs, shmem and tmpfs
> 
>   Add common extra configs, the 3rd one (procfs, shmem and tmpfs) can be
>   completely reverted after [1] series, but as discuss with Thomas,
>   procfs may be still a hard requirement.
> 
> * selftests/nolibc: add extra configs for i386
>   selftests/nolibc: add extra configs for x86_64
>   selftests/nolibc: add extra configs for arm64
>   selftests/nolibc: add extra configs for arm
>   selftests/nolibc: add extra configs for mips
>   selftests/nolibc: add extra configs for riscv32
>   selftests/nolibc: add extra configs for riscv64
>   selftests/nolibc: add extra configs for s390x
>   selftests/nolibc: add extra configs for loongarch
> 
>   Add architecture specific extra configs to let kernel boot and
>   nolibc-test print. The rv32 added here is only for test, it should not
>   be merged before the missing 64bit syscalls are added (still wait for
>   the merging of the __sysret and -ENOSYS patches).
> 
> * selftests/nolibc: config default CROSS_COMPILE
>   selftests/nolibc: add run-tiny and run-default
> 
>   both run-tiny and run-default are added to do config and run together,
>   this easier test a log.
> 
> * selftests/nolibc: allow run tests on all targets
>   selftests/nolibc: detect bios existing to avoid hang
> 
>   Further allow do run-user, run-tiny and run-default for all
>   architectures at once, the -all suffix is added to do so.
> 
> Since some generic patches are still in review, before sending the left
> rv32 patches, I'm will send more generic patches later, the coming one
> is arch-xxx.h cleanup, and then, the 32bit powerpc porting support.
> 
> For the compile speedup, the next step may be add architecture specific
> 'O' support, which may allow us rerun across architectures without
> mrproper, for a single architecture development, this 'minimal' config
> should be enough ;-)
> 
> Thanks.
> 
> Best regards,
> Zhangjin
> ---
> [1]: https://lore.kernel.org/lkml/cover.1687344643.git.falcon@tinylab.org/
> [2]: https://lore.kernel.org/lkml/cover.1687156559.git.falcon@tinylab.org/
> [3]: https://lore.kernel.org/linux-riscv/cover.1687176996.git.falcon@tinylab.org/
> [4]: https://lore.kernel.org/lkml/20230624-proc-net-setattr-v1-0-73176812adee@weissschuh.net/
> 
> Zhangjin Wu (22):
>   selftests/nolibc: add test for -include /path/to/nolibc.h
>   selftests/nolibc: print result to the screen too
>   selftests/nolibc: allow use x86_64 toolchain for i386
>   selftests/nolibc: add menuconfig target for manual config
>   selftests/nolibc: add tinyconfig target
>   selftests/nolibc: allow customize extra kernel config options
>   selftests/nolibc: add common extra config options
>   selftests/nolibc: add power reset control support
>   selftests/nolibc: add procfs, shmem and tmpfs
>   selftests/nolibc: add extra configs for i386
>   selftests/nolibc: add extra configs for x86_64
>   selftests/nolibc: add extra configs for arm64
>   selftests/nolibc: add extra configs for arm
>   selftests/nolibc: add extra configs for mips
>   selftests/nolibc: add extra configs for riscv32
>   selftests/nolibc: add extra configs for riscv64
>   selftests/nolibc: add extra configs for s390x
>   selftests/nolibc: add extra configs for loongarch
>   selftests/nolibc: config default CROSS_COMPILE
>   selftests/nolibc: add run-tiny and run-default
>   selftests/nolibc: allow run tests on all targets
>   selftests/nolibc: detect bios existing to avoid hang
> 
>  tools/testing/selftests/nolibc/Makefile | 125 ++++++++++++++++++++++--
>  1 file changed, 119 insertions(+), 6 deletions(-)
> 
> -- 
> 2.25.1
