Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B54077081C
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 20:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjHDSkl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 14:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjHDSkk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 14:40:40 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40084A2;
        Fri,  4 Aug 2023 11:40:36 -0700 (PDT)
X-QQ-mid: bizesmtp70t1691174425tacm0wfn
Received: from linux-lab-host.localdomain ( [116.30.131.233])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 05 Aug 2023 02:40:24 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000B00A0000000
X-QQ-FEAT: BYUemv+qiN0VLbZmRldZ/F0a42eYYqNsVrI455YT1Xa6PjgIcrjcLGXTK11Tj
        tXYfp++yvnLAniSgob2c6y5L9R6PZn8vwbkkFo4GZoXpx3cqwaLbuAAblKF8zz29Gd9Knrf
        MzR0TWWtLxsfiC4zzILr7t1GONzKbsppMivRPLY5u8LOb/3EadsI+yyakI6K2xINhflemWV
        cXRCITRX/RQFr3aUjCWO04lwBId6780BvzKzp0reJt7HXhihC6sEIG+/1EZA1G+BBliclRq
        asGjT0572mPIlptgDYelfBjct/7vbn5LG1MvmhsJEL3auGEm4BEvTe0wzKpbVxolYoyVgmx
        Oql8UkWXcqgwrVF8wtIW5wzFF9qZ0gwTe/vKtRq/xhVXuDaTGkD5BUa2C9L5w==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5968938389250024209
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, tanyuan@tinylab.org,
        thomas@t-8ch.de
Subject: Re: [PATCH v1 2/3] selftests/nolibc: fix up O= option support
Date:   Sat,  5 Aug 2023 02:40:23 +0800
Message-Id: <20230804184023.354950-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230804175429.GC31163@1wt.eu>
References: <20230804175429.GC31163@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> On Fri, Aug 04, 2023 at 07:51:50PM +0200, Thomas Weißschuh wrote:
> > On 2023-08-05 00:29:10+0800, Zhangjin Wu wrote:
[...]
> > > Do you mean here?
> > > 
> > >     # kernel image names by architecture
> > >     IMAGE_i386    = arch/x86/boot/bzImage
> > >     IMAGE_x86     = arch/x86/boot/bzImage
> > >     IMAGE_arm64   = arch/arm64/boot/Image
> > >     IMAGE_arm     = arch/arm/boot/zImage
> > >     IMAGE_mips    = vmlinuz
> > >     IMAGE_riscv   = arch/riscv/boot/Image
> > >     IMAGE         = $(IMAGE_$(ARCH))
> > >     IMAGE_NAME    = $(notdir $(IMAGE))
> > > 
> > > It does save another KERNEL_IMAGE macro in my future patch ;-)
> > > 
> > > But without O=, OUTPUT is also empty like objtree and when empty, it is
> > > assigned as $(CURDIR), not $(srctree) as we expected for IMAGE and .config. To
> > > be cleaner, objtree should also be used:
> > > 
> > >     - IMAGE         = $(IMAGE_$(ARCH))
> > >     + IMAGE         = $(objtree)/$(IMAGE_$(ARCH))
> > > 
> > > Is this what you want?
> > 
> > More like:
> > 
> > -	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
> > +	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(OUTPUT)$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
> > 
> > My assumption was that it's weird that we need to define such variables
> > ourselves.
> > 
> > Using an empty $(OUTPUT) would have been fine if make is run from the
> > root of the kernel tree. But that is not the case.
> > 
> > It still feels weird but I can't think of a nicer way, and it's not
> > a big issue. So let's keep that part the same.
> > 
> > Or maybe Willy has a better idea.
> 
> I've just glanced over the discussion, but I'm wondering, why not
> "$(objtree)/$(IMAGE)" instead ?
>

We used "$(objtree)/$(IMAGE)" originally, I thought of Thomas asked me to
further add "$(objtree)" in the first place of IMAGE,

     - IMAGE         = $(IMAGE_$(ARCH))
     + IMAGE         = $(objtree)/$(IMAGE_$(ARCH))

And then, we can use "IMAGE" directly in the qemu run & rerun targets:

    # run the tests after building the kernel
    run: kernel
    -	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(objtree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(RUN_OUT)"
    +	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(RUN_OUT)"
    	$(Q)$(REPORT) "$(RUN_OUT)"
    
    # re-run the tests from an existing kernel
    rerun:
    -	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(objtree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(RUN_OUT)"
    +	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(RUN_OUT)"
    	$(Q)$(REPORT) "$(RUN_OUT)"

Which one do you prefer? will renew this series soon.

And even further, I thought of puting everything to $(OUTPUT), but the
change is very ugly and not good for v6.6, If you like, I will send that
patch only as a discuss stuff.

Thanks,
Zhangjin

> Willy
