Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1487708C9
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 21:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjHDTRn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 15:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjHDTRm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 15:17:42 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891A8B9;
        Fri,  4 Aug 2023 12:17:33 -0700 (PDT)
X-QQ-mid: bizesmtp85t1691176641tm8sx53q
Received: from linux-lab-host.localdomain ( [116.30.131.233])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 05 Aug 2023 03:17:20 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: CR3LFp2JE4lYbqaaZM+OIeBxhpPfHwNf6FKIYa/5hIfNhQALqcHrQX6AQHnj9
        XD7O5WO7YseMp4dKhzKzkWvz0X2v4zXDwYFcdKN/LYO36c+81Ae6CFjM7e2qwrZqxlST7Hf
        hTGSfwM5MkGVnPQENxXNPtaoczWvPt4+/azy1enEF2NAEeGckk5C5x3sC9amyVHtkfUZqFu
        7bEnqYoOUfoK9gUWBym28UUtqaFuw4VbqAaN4swt3ienM6MZAlVKAYMoIH+zhwROK4Nc25f
        BOxVJwJj49L8HuYNowFtueyaPHe9tyDWpeAZbTeeH8q39COL/NhC2xtNSRg0lyIcrm3BFbM
        nEH8KoYoWa/2qskOZqleIzkApgC3JLYz0+i09/jxWkUzF8BMKG18Vi+tpKfCg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 426980743630132163
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, tanyuan@tinylab.org,
        thomas@t-8ch.de
Subject: Re: [PATCH v1 2/3] selftests/nolibc: fix up O= option support
Date:   Sat,  5 Aug 2023 03:17:15 +0800
Message-Id: <20230804191715.379716-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230804184348.GA31470@1wt.eu>
References: <20230804184348.GA31470@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> On Sat, Aug 05, 2023 at 02:40:23AM +0800, Zhangjin Wu wrote:
> > > On Fri, Aug 04, 2023 at 07:51:50PM +0200, Thomas Wei?schuh wrote:
> > > > On 2023-08-05 00:29:10+0800, Zhangjin Wu wrote:
> > [...]
> > > > > Do you mean here?
> > > > > 
> > > > >     # kernel image names by architecture
> > > > >     IMAGE_i386    = arch/x86/boot/bzImage
> > > > >     IMAGE_x86     = arch/x86/boot/bzImage
> > > > >     IMAGE_arm64   = arch/arm64/boot/Image
> > > > >     IMAGE_arm     = arch/arm/boot/zImage
> > > > >     IMAGE_mips    = vmlinuz
> > > > >     IMAGE_riscv   = arch/riscv/boot/Image
> > > > >     IMAGE         = $(IMAGE_$(ARCH))
> > > > >     IMAGE_NAME    = $(notdir $(IMAGE))
> > > > > 
> > > > > It does save another KERNEL_IMAGE macro in my future patch ;-)
> > > > > 
> > > > > But without O=, OUTPUT is also empty like objtree and when empty, it is
> > > > > assigned as $(CURDIR), not $(srctree) as we expected for IMAGE and .config. To
> > > > > be cleaner, objtree should also be used:
> > > > > 
> > > > >     - IMAGE         = $(IMAGE_$(ARCH))
> > > > >     + IMAGE         = $(objtree)/$(IMAGE_$(ARCH))
> > > > > 
> > > > > Is this what you want?
> > > > 
> > > > More like:
> > > > 
> > > > -	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
> > > > +	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(OUTPUT)$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
> > > > 
> > > > My assumption was that it's weird that we need to define such variables
> > > > ourselves.
> > > > 
> > > > Using an empty $(OUTPUT) would have been fine if make is run from the
> > > > root of the kernel tree. But that is not the case.
> > > > 
> > > > It still feels weird but I can't think of a nicer way, and it's not
> > > > a big issue. So let's keep that part the same.
> > > > 
> > > > Or maybe Willy has a better idea.
> > > 
> > > I've just glanced over the discussion, but I'm wondering, why not
> > > "$(objtree)/$(IMAGE)" instead ?
> > >
> > 
> > We used "$(objtree)/$(IMAGE)" originally, I thought of Thomas asked me to
> > further add "$(objtree)" in the first place of IMAGE,
> > 
> >      - IMAGE         = $(IMAGE_$(ARCH))
> >      + IMAGE         = $(objtree)/$(IMAGE_$(ARCH))
> > 
> > And then, we can use "IMAGE" directly in the qemu run & rerun targets:
> > 
> >     # run the tests after building the kernel
> >     run: kernel
> >     -	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(objtree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(RUN_OUT)"
> >     +	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(RUN_OUT)"
> >     	$(Q)$(REPORT) "$(RUN_OUT)"
> >     
> >     # re-run the tests from an existing kernel
> >     rerun:
> >     -	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(objtree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(RUN_OUT)"
> >     +	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(RUN_OUT)"
> >     	$(Q)$(REPORT) "$(RUN_OUT)"
> > 
> > Which one do you prefer? will renew this series soon.
> 
> It's not a matter of preference but which solution really works. In short
> it should work fine and consistently when launched from topdir and from
> the nolibc-test dir. I personally don't know the effect of O= when run
> from a subdir (is it relative to the current dir or topdir?).
>

As suggested by Thomas, $(COMMAND_O) will be used to pass the absolute
$(O) for every sub $(MAKE), O= will work like this:

    // subdir
    $ pwd
    /labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc
    $ mkdir -p out
    $ make run-user O=out -C /labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc/ -j4 | grep status
    Makefile:122: srctree=/labs/linux-lab/src/linux-stable
    Makefile:123: objtree: out
    Makefile:124: COMMAND_O: O=/labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc/out
    Makefile:125: OUTPUT=/labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc/out/
    166 test(s): 158 passed,   8 skipped,   0 failed => status: warning

    // topdir
    $ pwd
    /labs/linux-lab/src/linux-stable
    $ mkdir -p out
    $ make run-user O=out -C /labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc/ -j4 | grep status
    Makefile:122: srctree=/labs/linux-lab/src/linux-stable
    Makefile:123: objtree: out
    Makefile:124: COMMAND_O: O=/labs/linux-lab/src/linux-stable/out
    Makefile:125: OUTPUT=/labs/linux-lab/src/linux-stable/out/
    166 test(s): 158 passed,   8 skipped,   0 failed => status: warning

    // outside
    $ pwd
    /labs/linux-lab/build
    $ mkdir -p out
    $ make run-user O=out -C /labs/linux-lab/src/linux-stable/tools/testing/selftests/nolibc/ -j4 | grep status
    Makefile:122: srctree=/labs/linux-lab/src/linux-stable
    Makefile:123: objtree: out
    Makefile:124: COMMAND_O: O=/labs/linux-lab/build/out
    Makefile:125: OUTPUT=/labs/linux-lab/build/out/
    166 test(s): 158 passed,   8 skipped,   0 failed => status: warning

The change:

    $ grep COMMAND_O -ur tools/testing/selftests/nolibc/Makefile 
    	$(Q)$(MAKE) -C ../../../include/nolibc $(COMMAND_O) ARCH=$(ARCH) OUTPUT=$(OUTPUT)sysroot/ headers_standalone
    	$(Q)$(MAKE) -C $(srctree) $(COMMAND_O) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare
    	$(Q)$(MAKE) -C $(srctree) $(COMMAND_O) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME) CONFIG_INITRAMFS_SOURCE=$(CURDIR)/initramfs

> > And even further, I thought of puting everything to $(OUTPUT), but the
> > change is very ugly and not good for v6.6, If you like, I will send that
> > patch only as a discuss stuff.
> 
> Yeah I'd rather avoid ugly things for 6.6 now.
>

Ok, since you also suggested let's develop in outside directory, it is better
to reserve the left parts as-is ;-)

> Thanks,
> Willy
