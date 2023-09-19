Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E367A61AD
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Sep 2023 13:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjISLsz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Sep 2023 07:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjISLsy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Sep 2023 07:48:54 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FF2E3;
        Tue, 19 Sep 2023 04:48:42 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.99.103]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MpD39-1rU32D0eCt-00qh95; Tue, 19 Sep 2023 13:47:54 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id B7DBF3E9B4; Tue, 19 Sep 2023 13:47:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1695124068; bh=nmeuXLZk5BWSMOsNpfSkXKF7Qd+tLy4N88pMrtO1oXU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qCmBEC4q10JGX3wyfYWBNDaMKIUnF8accmx4H16x9sZAC04P4H6r5Ka3GMfe8WRaV
         40NxV5h3JWUlxIaDruehebrYkIRj/rNhS/0tWybDTGy1/UG3PfUvBPGYR/vjHSN8bB
         mY9Q1iJmkvNSZYd/8PrZC54Zb87jDE1Hhin6Wt0s=
Date:   Tue, 19 Sep 2023 13:47:47 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC v2] selftests/nolibc: don't embed initramfs into
 kernel image
Message-ID: <ZQmKYz6WRkznqdWV@fjasle.eu>
References: <20230917-nolibc-initramfs-v2-1-f0f293a8b198@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230917-nolibc-initramfs-v2-1-f0f293a8b198@weissschuh.net>
Organisation: AVM GmbH
X-Provags-ID: V03:K1:AI4RW+U+z5OjltmaIRmDpMq9Q94TiDilXlDL2Na8kATQIRVHK2U
 rvgZ+e6sn5Qrq/blRej4g7jml4Ufb2swextL9aaZl3mrs4oxYlNgHx+X5ccpNQLh5sLC8bm
 yMuiFQuewMJuwj2Xx1b0zOPI1FWO6vIyjfurdZlYab/x0naFSyIXG3Mq/GYtdn5DJHGqxL2
 a88o60KQgKHRSYrBKgqeQ==
UI-OutboundReport: notjunk:1;M01:P0:C8fldALX24o=;hb7CL7PypnMZNCdVxrYDUL6lXHq
 1Pu0+2F+BzCGlUAO1XSxCiy4otYNzeVcXrhMbSV21T5lRYEVQkxkFW5RE13qARi//mRf7LUt4
 oynsMb7z7ok91YhFUE17Hk+7qufvGAzuNObSFXc/j3tUZIJfRCBc946cWLGHtBupzjgh15Yg+
 J7jw0migdb4ylgFsfdPM+RLnVO0BcG0p2xxSilCLmEypOFyhIXKN/LaODbu9vnplGGqu/5M0c
 aIwctndOEyouFqvQb1uJoEqKhiitlumtknro7KqHUlox4kUGWD/+PVfGLlPeYYdyQ5QrqUWis
 zrkfOnJwp9/F3yRmU9bOp/TpGzTVdMXQgaazKxtqcaZEnON2LB75MhpU3XE6I+VSz1wARMMD2
 l48JeFGPnt8mApTxGqIfHaWGamobEw7zrZLJl6zSdoNKZMe91VeiIBzeIOFPGkdbMTbUhGN3y
 FeAxV/GesH34B6scnzdmamseurScz1Tjb9Sdw1w671XLhIRJeWYLy8ek0NyZ/bhC0QWvuXLDR
 TSx8ozJg28CRXcUukIvcZLA92SRAL/w9nCNVIqR7PXzPoyhdUKCsyvqOAG2JnbZe4H+p5uLKO
 tGtYKuUs4z0lxhUvrn9FxseGVl5u/GPaARRioDo74fSt/1mNGosFA3DDk1kzSgTd4tSe0cVbW
 FmyHc8yIvSVLI28kP3utjpZZnh6/ZV9unHGQAYez6qFdlATfOBlZzF9r+sOh2HIjqn17+xN3q
 CveBOWco372asafdXoD2dvw2gCe6mfI34sz9wHuP9jMqLgZVsh5rXukXtSBw7YAp/ugrmgGnJ
 uW69NP/Ky8K3oyK261sV9SPmjUeLWmvbfIbjfpFrfH0JyVQ+kXqMClDtyS3WlkumQgAloX8B8
 Zhy2GyAzCOYBH9g==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Sep 17, 2023 at 05:21:38PM +0200 Thomas Weißschuh wrote:
> When the initramfs is embedded into the kernel each rebuild of it will
> trigger a full kernel relink and all the expensive postprocessing steps.
> 
> Currently nolibc-test and therefore the initramfs are always rebuild,
> even without source changes, leading to lots of slow kernel relinks.
> 
> Instead of linking the initramfs into the kernel assemble it manually
> and pass it explicitly to qemu.
> This avoids all of the kernel relinks.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> Currently the nolibc testsuite embeds the test executable into a kernel
> image with CONFIG_INITRAMFS_SOURCE.
> This forces a full kernel relink everytime the test executable is
> updated.
> 
> This relinking step dominates the test cycle.
> It is slower than building and running the test in qemu together.
> 
> With a bit of Makefile-shuffling the relinking can be avoided.
> ---
> Changes in v2:
> - avoid need to modify top-level Makefile
> - drop patch removing "rerun" target
> - add kernel-standalone target
> - Link to v1: https://lore.kernel.org/r/20230916-nolibc-initramfs-v1-0-4416ecedca6d@weissschuh.net
> ---

Thanks, seems to work as described (and I am surprised how fast the 'run'
target is) and patch looks good to me.

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>


>  tools/testing/selftests/nolibc/Makefile | 42 ++++++++++++++++++++-------------
>  1 file changed, 26 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> index 689658f81a19..ee6a9ad28cfd 100644
> --- a/tools/testing/selftests/nolibc/Makefile
> +++ b/tools/testing/selftests/nolibc/Makefile
> @@ -131,18 +131,20 @@ REPORT  ?= awk '/\[OK\][\r]*$$/{p++} /\[FAIL\][\r]*$$/{if (!f) printf("\n"); f++
>  
>  help:
>  	@echo "Supported targets under selftests/nolibc:"
> -	@echo "  all          call the \"run\" target below"
> -	@echo "  help         this help"
> -	@echo "  sysroot      create the nolibc sysroot here (uses \$$ARCH)"
> -	@echo "  nolibc-test  build the executable (uses \$$CC and \$$CROSS_COMPILE)"
> -	@echo "  libc-test    build an executable using the compiler's default libc instead"
> -	@echo "  run-user     runs the executable under QEMU (uses \$$XARCH, \$$TEST)"
> -	@echo "  initramfs    prepare the initramfs with nolibc-test"
> -	@echo "  defconfig    create a fresh new default config (uses \$$XARCH)"
> -	@echo "  kernel       (re)build the kernel with the initramfs (uses \$$XARCH)"
> -	@echo "  run          runs the kernel in QEMU after building it (uses \$$XARCH, \$$TEST)"
> -	@echo "  rerun        runs a previously prebuilt kernel in QEMU (uses \$$XARCH, \$$TEST)"
> -	@echo "  clean        clean the sysroot, initramfs, build and output files"
> +	@echo "  all               call the \"run\" target below"
> +	@echo "  help              this help"
> +	@echo "  sysroot           create the nolibc sysroot here (uses \$$ARCH)"
> +	@echo "  nolibc-test       build the executable (uses \$$CC and \$$CROSS_COMPILE)"
> +	@echo "  libc-test         build an executable using the compiler's default libc instead"
> +	@echo "  run-user          runs the executable under QEMU (uses \$$XARCH, \$$TEST)"
> +	@echo "  initramfs.cpio    prepare the initramfs archive with nolibc-test"
> +	@echo "  initramfs         prepare the initramfs tree with nolibc-test"
> +	@echo "  defconfig         create a fresh new default config (uses \$$XARCH)"
> +	@echo "  kernel            (re)build the kernel (uses \$$XARCH)"
> +	@echo "  kernel-standalone (re)build the kernel with the initramfs (uses \$$XARCH)"
> +	@echo "  run               runs the kernel in QEMU after building it (uses \$$XARCH, \$$TEST)"
> +	@echo "  rerun             runs a previously prebuilt kernel in QEMU (uses \$$XARCH, \$$TEST)"
> +	@echo "  clean             clean the sysroot, initramfs, build and output files"
>  	@echo ""
>  	@echo "The output file is \"run.out\". Test ranges may be passed using \$$TEST."
>  	@echo ""
> @@ -195,6 +197,9 @@ run-user: nolibc-test
>  	$(Q)qemu-$(QEMU_ARCH) ./nolibc-test > "$(CURDIR)/run.out" || :
>  	$(Q)$(REPORT) $(CURDIR)/run.out
>  
> +initramfs.cpio: kernel nolibc-test
> +	$(QUIET_GEN)echo 'file /init nolibc-test 755 0 0' | $(srctree)/usr/gen_init_cpio - > initramfs.cpio
> +
>  initramfs: nolibc-test
>  	$(QUIET_MKDIR)mkdir -p initramfs
>  	$(call QUIET_INSTALL, initramfs/init)
> @@ -203,17 +208,20 @@ initramfs: nolibc-test
>  defconfig:
>  	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare
>  
> -kernel: initramfs
> +kernel:
> +	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME)
> +
> +kernel-standalone: initramfs
>  	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME) CONFIG_INITRAMFS_SOURCE=$(CURDIR)/initramfs
>  
>  # run the tests after building the kernel
> -run: kernel
> -	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
> +run: kernel initramfs.cpio
> +	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -initrd initramfs.cpio -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
>  	$(Q)$(REPORT) $(CURDIR)/run.out
>  
>  # re-run the tests from an existing kernel
>  rerun:
> -	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
> +	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -initrd initramfs.cpio -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
>  	$(Q)$(REPORT) $(CURDIR)/run.out
>  
>  # report with existing test log
> @@ -227,6 +235,8 @@ clean:
>  	$(Q)rm -f nolibc-test
>  	$(call QUIET_CLEAN, libc-test)
>  	$(Q)rm -f libc-test
> +	$(call QUIET_CLEAN, initramfs.cpio)
> +	$(Q)rm -rf initramfs.cpio
>  	$(call QUIET_CLEAN, initramfs)
>  	$(Q)rm -rf initramfs
>  	$(call QUIET_CLEAN, run.out)
> 
> ---
> base-commit: 3f79a57865b33f49fdae6655510bd27c8e6610e0
> change-id: 20230916-nolibc-initramfs-4fd00eac3256
> 
> Best regards,
> -- 
> Thomas Weißschuh <linux@weissschuh.net>

-- 
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
↳ gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --
