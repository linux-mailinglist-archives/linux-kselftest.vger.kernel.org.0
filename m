Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4B87686F7
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Jul 2023 20:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjG3SC5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 30 Jul 2023 14:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjG3SC4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 30 Jul 2023 14:02:56 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A37E6;
        Sun, 30 Jul 2023 11:02:53 -0700 (PDT)
X-QQ-mid: bizesmtp84t1690740163tacgzyir
Received: from linux-lab-host.localdomain ( [61.141.77.223])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 31 Jul 2023 02:02:42 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000B00A0000000
X-QQ-FEAT: eLy0Un1haEtPNoBCMrR+0QNTGgaUHCp3JzruG7T8YQiEqqLJBEN6PtSjw2QPM
        6lp4hvFV2qGAXjHgAr1s0SwClCkBQkcMxNtTZGLtoWKHHkHXRGpFjBe5fNQDlXYp8hzWzy1
        reSOXTJnc42aBPgxYXHSzr8r13uruShQZEHsq4SEuqo8GA5pnKM2J5/K0S0O+qYFHlpZyC0
        NPBmt9IcgcNq5TW5jLIRiClcMs9iX8dt+rA5xF5DK7PeHUXdwbmzei/gannkBq1z9FUDrEB
        gO7NIwEb9ZlmOHbHIvbGbZbj1deIH04ENqe4D1vZ7YVFKgJc+VIZ+QYEO5gHn8rlPtvMHOz
        nAmA8qu+SLZLqq7zewUmggH5Z4QBQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10960849253273204474
From:   Zhangjin Wu <falcon@tinylab.org>
To:     falcon@tinylab.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de, w@1wt.eu
Subject: Re: [PATCH v3 3/7] selftests/nolibc: add extra configs customize support
Date:   Mon, 31 Jul 2023 02:02:42 +0800
Message-Id: <20230730180242.387931-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230730112149.37896-1-falcon@tinylab.org>
References: <20230730112149.37896-1-falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

> At last, here is it?
> 
>     # extra configs/ files appended to .config during the nolibc-test-config target
>     # include common + architecture specific
>     NOLIBC_TEST_CONFIG   = nolibc-test-common.config nolibc-test-$(XARCH).config
> 
>     nolibc-test-config:
> 	$(Q)$(MAKE_KERNEL) mrproper
> 	$(Q)$(MAKE_KERNEL) $(or $(CONFIG),$(DEFCONFIG)) prepare

The 'prepare' should be removed, we have one in the end.

> 	$(Q)$(srctree)/scripts/kconfig/merge_config.sh -Q -O "$(objtree)" -m "$(KERNEL_CONFIG)" $(foreach c,$(NOLIBC_TEST_CONFIG),$(wildcard $(CURDIR)/configs/$c))
> 	$(Q)$(MAKE_KERNEL) olddefconfig

Oh, sorry, test shows, 'allnoconfig' worth a comment ;-)

'allnoconfig' is ~2x faster than 'olddefconfig', it is more
deterministic for it set all new symbols (the ones not specified in
.config) with no.

    // scripts/kconfig/Makefile

        @echo  '  oldconfig       - Update current config utilising a provided .config as base'
        @echo  '  defconfig       - New config with default from ARCH supplied defconfig'
        @echo  '  allnoconfig     - New config where all options are answered with no'
        @echo  '  allyesconfig    - New config where all options are accepted with yes'
        @echo  '  olddefconfig    - Same as oldconfig but sets new symbols to their'
        @echo  '                    default value without prompting'


here is the result:

    // with 'allnoconfig'
    $ sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches'; arch=ppc; time make tinyconfig kernel -C tools/testing/selftests/nolibc CONFIG=tinyconfig XARCH=$arch O=$PWD/kernel-$arch
    real	3m37.337s
    user	3m11.576s
    sys         0m16.899s

    // with 'olddefconfig'
    $ sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches'; arch=ppc; time make tinyconfig kernel -C tools/testing/selftests/nolibc CONFIG=tinyconfig XARCH=$arch O=$PWD/kernel-$arch 
    real	5m28.759s
    user	4m47.873s
    sys         0m30.115s

    // with 'defconfig'
    

Both merge_tools.sh and tinyconfig target use 'allnoconfig', the usage
is clear enough, no risk:

    scripts/kconfig/merge_config.sh:

    # Use the merged file as the starting point for:
    # alldefconfig: Fills in any missing symbols with Kconfig default
    # allnoconfig: Fills in any missing symbols with # CONFIG_* is not set
    make KCONFIG_ALLCONFIG=$TMP_FILE $OUTPUT_ARG $ALLTARGET


    scripts/kconfig/Makefile:

    tinyconfig:
        $(Q)KCONFIG_ALLCONFIG=kernel/configs/tiny-base.config $(MAKE) -f $(srctree)/Makefile allnoconfig
        $(Q)$(MAKE) -f $(srctree)/Makefile tiny.config


And also since I have carefully test 'allnoconfig' for all of the nolibc
supported architectures, it is not good to waste time to test
'olddefconfig'. 'allnoconfig' is also more deterministic than
'olddefconfig' since it only enable the options specified by us
explicitly, so, no new symbols will be randomly enabled.

I plan to add more comments before 'nolibc-test-config':

    # kernel config for nolibc-test
    #
    # - delete the current configuration and all generated files via 'mrproper' target
    # - generate .config via '$(CONFIG)' or '$(DEFCONFIG_$(XARCH))' target
    # - merge extra config options from $(NOLIBC_TEST_CONFIG) files to .config
    # - use merged .config as base and fills in any missing symbols with '# CONFIG_* is not set' via 'allnoconfig' target
    # - prepare things we need to do before we recursively start building the kernel via 'prepare' target
    #

    nolibc-test-config:
    	$(Q)$(MAKE_KERNEL) mrproper
    	$(Q)$(MAKE_KERNEL) $(or $(CONFIG),$(DEFCONFIG))
    	$(Q)$(srctree)/scripts/kconfig/merge_config.sh -Q -O "$(objtree)" -m "$(KERNEL_CONFIG)" $(foreach c,$(NOLIBC_TEST_CONFIG),$(wildcard $(CURDIR)/configs/$c))
    	$(Q)$(MAKE_KERNEL) KCONFIG_ALLCONFIG=$(KERNEL_CONFIG) allnoconfig
    	$(Q)$(MAKE_KERNEL) prepare

> 	$(Q)$(MAKE_KERNEL) prepare
> 
>     defconfig: nolibc-test-config
> 
> The last line still depends on your confirm.
> 
> Without more issues, I will renew this patchset as v4, thanks very much!
> 
> (will update the XARCH patch to get your confirm in another reply too)
> 
> Best regards,
> Zhangjin
