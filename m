Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0677076850C
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Jul 2023 13:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjG3LWa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 30 Jul 2023 07:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjG3LWE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 30 Jul 2023 07:22:04 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59A5198E;
        Sun, 30 Jul 2023 04:22:01 -0700 (PDT)
X-QQ-mid: bizesmtp77t1690716110tv8bivfu
Received: from linux-lab-host.localdomain ( [61.141.77.223])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 30 Jul 2023 19:21:49 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: eeGIu46hDGgGrNOUk9kqFEgsnoRGVRs0YH7r5TFTD0m9ie1JZ6KZoIHj2r/fp
        eQWVrfAE3N6rJx8MYKVspuOzM31OFsjtMsJtMwTfJd39KhZEqwkcGFV2alHjT1jzWBvkqIu
        BN9mpoUn+YS2Gcg/t5JzuKU+DVxZpQOxO9UK183z+pBoTRxOExfZbGGvz4wQYRBkvvSdt4Q
        TZtcS8MCwILTEJ7duybxPS2ojY5ZcEcOgdLtip9jdfV5L1JyEKOgCXARldrSFv+YePRzBu1
        U9Nvw31sa1wLYYBwIgH7CafAC0oTZrhjUKkF5HOZ+kvdbsRgP1eT8i2deGiJ4qDi5mX3prx
        i5EqUCZZf7gZt3vy63LGRa8hQkQBvr6ro7epVMC9vHZqDbmVJf4SzQ38kgleQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7311399538816519313
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v3 3/7] selftests/nolibc: add extra configs customize support
Date:   Sun, 30 Jul 2023 19:21:49 +0800
Message-Id: <20230730112149.37896-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230730061801.GA7690@1wt.eu>
References: <20230730061801.GA7690@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> On Sun, Jul 30, 2023 at 02:01:31PM +0800, Zhangjin Wu wrote:
> > > > > Seems 'nolibc-test-config' is really more meaningful than 'defconfig', especially
> > > > > when we want to use tinyconfig through it?
> > > > > 
> > > > >     $ make nolibc-test-config DEFCONFIG=tinyconfig
[...]
> > 
> > And this:
> > 
> >     # extra configs/ files appended to .config during the nolibc-test-config target
> >     # include common + architecture specific
> >     EXTRA_CONFIG         = common.config $(XARCH).config
> > 
> > And the update of the help target too.
> > 
> > If both of you are happy with this? let's do it ;-)
> 
> Well, I understand "nolibc-test-config" as "the config suitable to
> correctly run nolibc-test". In that case I agree. We can indeed start
> from the defconfig, and if we manage to refine it we can later map it
> to anything else that's known to work. And if we eventually split
> nolibc-test into multiple tests (libc, syscalls, ipc, network, whatever)
> then we might as well adopt different configs in the future. I'd also

Agree, with this info, I do like nolibc-test-config, let's align all
related with nolibc-test- prefix and NOLIBC_TEST_CONFIG too ;-)

I have thought about a simpler 'config' target for both tinyconfig and
defconfig before, but I'm worried about the same issue mentioned by
Willy, it may conflict with the one from top-level Makefile.

With exact nolibc-test prefix, it is better.

> want to keep defconfig on its own because it relies on each arch's
> defconfig and is a simple way to verify they work (as they should).
> As I said, till now I haven't met issues with defconfig so probably
> we don't need to patch it, but we could revisit that option later if
> needed.
>

No Willy, this patch here is not originally for tinyconfig, is for
pmac32_defconfig used by the default ppc32 qemu machine has no builtin
console, it is configured as a module:

    CONFIG_SERIAL_8250=m
    CONFIG_SERIAL_PMACZILOG=m
    CONFIG_SERIAL_PMACZILOG_TTYS=y

This is why we also need to add such extra logic also for defconfig
target. Another solution is ask the kernel maintainer to switch the =m
to =y, but as we discussed before, it is better to depends on the kernel
part, so, an extra logic is used here for better flexibility and less
dependency.

If we still to reserve the 'defconfig' target, is this ok for you?

    defconfig: nolibc-test-config

    Or

    nolibc-test-defconfig: nolibc-test-config

Which one do you like? If 'defconfig', the one for tinyconfig may also
better to use 'tinyconfig':

    tinyconfig defconfig: nolibc-test-config
    tinyconfig: CONFIG=tinyconfig

Otherwise,

    nolibc-test-tinyconfig nolibc-test-defconfig: nolibc-test-config
    nolibc-test-tinyconfig: CONFIG=tinyconfig

I'm ok with anyone of them (note, the tinyconfig related parts will not
be really added here), what about you?

> I'm still having that question about your "make allnoconfig" at the
> end, which for me simply replaces the config you've just created, thus
> which makes no sense. There might be a trick that I'm missing but if so
> it should be explained there because the only situation where anybody
> should start a question with "why" when reading code is when they
> discovered a bug.
>

Yeah, the name of allnoconfig doesn't confuse a little, to simplify it a
lot, let's simply use 'olddefconfig' (as 'oldconfig' you suggested in
another replay, but without prompt and silently set new options as
default) instead?

> Also please split the mrproper and defconfig on two distinc lines, as
> there's no point anymore in keeping them as a single one.
>

Yeah, it is better.

> Since you're using the extra options for nolibc-test-config, I think
> they should be called "nolibc-test-common.config" and
> "nolibc-test-$XARCH.config" so that we don't restart with tons of
> "if" and macros when adding a new target.

Done.

Btw, since this one does have some relationship with another three
patches (two are from tinyconfig part1, like the XARCH you mentioned two
times), in order to make them more fast forward, I have reorder them to
make things clear.

* selftests/nolibc: fix up O= option support

    Fix up the wrong srctree previously used, then, we can use objtree
    directly in this patch.

* selftests/nolibc: add macros to reduce duplicated changes

    Some of the macros are heavily used in our new nolibc-test-config
    target, for we require to split mrproper and prepare into more
    lines, shorter macros prepared earlier does help this.

* selftests/nolibc: add XARCH and ARCH mapping support

    Add this one earlier, then, our patch can use the XARCH directly.

As you suggested, If no other opposite, another two about CROSS_COMPILE
will be moved to this powerpc series too:

* selftests/nolibc: allow customize CROSS_COMPILE by architecture
* selftests/nolibc: customize CROSS_COMPILE for 32/64-bit powerpc

At last, here is it?

    # extra configs/ files appended to .config during the nolibc-test-config target
    # include common + architecture specific
    NOLIBC_TEST_CONFIG   = nolibc-test-common.config nolibc-test-$(XARCH).config

    nolibc-test-config:
	$(Q)$(MAKE_KERNEL) mrproper
	$(Q)$(MAKE_KERNEL) $(or $(CONFIG),$(DEFCONFIG)) prepare
	$(Q)$(srctree)/scripts/kconfig/merge_config.sh -Q -O "$(objtree)" -m "$(KERNEL_CONFIG)" $(foreach c,$(NOLIBC_TEST_CONFIG),$(wildcard $(CURDIR)/configs/$c))
	$(Q)$(MAKE_KERNEL) olddefconfig
	$(Q)$(MAKE_KERNEL) prepare

    defconfig: nolibc-test-config

The last line still depends on your confirm.

Without more issues, I will renew this patchset as v4, thanks very much!

(will update the XARCH patch to get your confirm in another reply too)

Best regards,
Zhangjin

> Thomas, are you also OK with this ?
> 
> Thanks,
> Willy
