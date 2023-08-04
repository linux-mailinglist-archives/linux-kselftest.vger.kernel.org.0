Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42B5770820
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 20:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjHDSoG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 14:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjHDSoB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 14:44:01 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C17A54C05;
        Fri,  4 Aug 2023 11:43:58 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 374Ihmtm031478;
        Fri, 4 Aug 2023 20:43:48 +0200
Date:   Fri, 4 Aug 2023 20:43:48 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, tanyuan@tinylab.org,
        thomas@t-8ch.de
Subject: Re: [PATCH v1 2/3] selftests/nolibc: fix up O= option support
Message-ID: <20230804184348.GA31470@1wt.eu>
References: <20230804175429.GC31163@1wt.eu>
 <20230804184023.354950-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804184023.354950-1-falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Aug 05, 2023 at 02:40:23AM +0800, Zhangjin Wu wrote:
> > On Fri, Aug 04, 2023 at 07:51:50PM +0200, Thomas Wei?schuh wrote:
> > > On 2023-08-05 00:29:10+0800, Zhangjin Wu wrote:
> [...]
> > > > Do you mean here?
> > > > 
> > > >     # kernel image names by architecture
> > > >     IMAGE_i386    = arch/x86/boot/bzImage
> > > >     IMAGE_x86     = arch/x86/boot/bzImage
> > > >     IMAGE_arm64   = arch/arm64/boot/Image
> > > >     IMAGE_arm     = arch/arm/boot/zImage
> > > >     IMAGE_mips    = vmlinuz
> > > >     IMAGE_riscv   = arch/riscv/boot/Image
> > > >     IMAGE         = $(IMAGE_$(ARCH))
> > > >     IMAGE_NAME    = $(notdir $(IMAGE))
> > > > 
> > > > It does save another KERNEL_IMAGE macro in my future patch ;-)
> > > > 
> > > > But without O=, OUTPUT is also empty like objtree and when empty, it is
> > > > assigned as $(CURDIR), not $(srctree) as we expected for IMAGE and .config. To
> > > > be cleaner, objtree should also be used:
> > > > 
> > > >     - IMAGE         = $(IMAGE_$(ARCH))
> > > >     + IMAGE         = $(objtree)/$(IMAGE_$(ARCH))
> > > > 
> > > > Is this what you want?
> > > 
> > > More like:
> > > 
> > > -	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
> > > +	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(OUTPUT)$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
> > > 
> > > My assumption was that it's weird that we need to define such variables
> > > ourselves.
> > > 
> > > Using an empty $(OUTPUT) would have been fine if make is run from the
> > > root of the kernel tree. But that is not the case.
> > > 
> > > It still feels weird but I can't think of a nicer way, and it's not
> > > a big issue. So let's keep that part the same.
> > > 
> > > Or maybe Willy has a better idea.
> > 
> > I've just glanced over the discussion, but I'm wondering, why not
> > "$(objtree)/$(IMAGE)" instead ?
> >
> 
> We used "$(objtree)/$(IMAGE)" originally, I thought of Thomas asked me to
> further add "$(objtree)" in the first place of IMAGE,
> 
>      - IMAGE         = $(IMAGE_$(ARCH))
>      + IMAGE         = $(objtree)/$(IMAGE_$(ARCH))
> 
> And then, we can use "IMAGE" directly in the qemu run & rerun targets:
> 
>     # run the tests after building the kernel
>     run: kernel
>     -	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(objtree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(RUN_OUT)"
>     +	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(RUN_OUT)"
>     	$(Q)$(REPORT) "$(RUN_OUT)"
>     
>     # re-run the tests from an existing kernel
>     rerun:
>     -	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(objtree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(RUN_OUT)"
>     +	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(RUN_OUT)"
>     	$(Q)$(REPORT) "$(RUN_OUT)"
> 
> Which one do you prefer? will renew this series soon.

It's not a matter of preference but which solution really works. In short
it should work fine and consistently when launched from topdir and from
the nolibc-test dir. I personally don't know the effect of O= when run
from a subdir (is it relative to the current dir or topdir?).

> And even further, I thought of puting everything to $(OUTPUT), but the
> change is very ugly and not good for v6.6, If you like, I will send that
> patch only as a discuss stuff.

Yeah I'd rather avoid ugly things for 6.6 now.

Thanks,
Willy
