Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F89767F2F
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 14:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjG2MhB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Jul 2023 08:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjG2MhA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Jul 2023 08:37:00 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454523AB9;
        Sat, 29 Jul 2023 05:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1690634216; bh=cPI6LIWuZjuB2o2aZA/SkL/WLC8y7hZUU6IJgq71yy8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EGqoxsi4EhhnSJ3FMbJc8JNptu8bfGKxTW2Cl8+C5+YVb4dKmoW68pKpEW5pWdWva
         21UCiKgesCS1+G2p7uefSjsP2OulgVBZreMLDiyCbuCMJvha1AyhEB+YTa/Ud/RQ7h
         qKFZ0iUQV94AF3u/2FHTmmkIw8gYSANoqcUGeUq4=
Date:   Sat, 29 Jul 2023 14:36:55 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     w@1wt.eu, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 3/7] selftests/nolibc: add extra configs customize
 support
Message-ID: <74f6a3b5-666c-41e9-a3d5-0ed5457f20f5@t-8ch.de>
References: <cover.1690468707.git.falcon@tinylab.org>
 <8e9e5ac6283c6ec2ecf10a70ce55b219028497c1.1690468707.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e9e5ac6283c6ec2ecf10a70ce55b219028497c1.1690468707.git.falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-07-27 23:02:02+0800, Zhangjin Wu wrote:
> The default DEFCONFIG_<ARCH> may not always work for all architectures,
> some architectures require to add extra kernel config options, this
> allows to add extra options in the defconfig target.
> 
> Based on the .config generated from DEFCONFIG_<ARCH>, It allows to
> customize extra kernel config options via both the common common.config
> and the architecture specific <ARCH>.config, at last trigger
> 'allnoconfig' to let them take effect with missing config options as
> disabled.
> 
> The scripts/kconfig/merge_config.sh tool is used to merge the extra
> config files.
> 
> Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
> Link: https://lore.kernel.org/lkml/67eb70d4-c9ff-4afc-bac7-7f36cc2c81bc@t-8ch.de/
> Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> ---
>  tools/testing/selftests/nolibc/Makefile | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> index f42adef87e12..9576f1a0a98d 100644
> --- a/tools/testing/selftests/nolibc/Makefile
> +++ b/tools/testing/selftests/nolibc/Makefile
> @@ -39,6 +39,9 @@ DEFCONFIG_s390       = defconfig
>  DEFCONFIG_loongarch  = defconfig
>  DEFCONFIG            = $(DEFCONFIG_$(ARCH))
>  
> +# extra kernel config files under configs/, include common + architecture specific
> +EXTCONFIG            = common.config $(ARCH).config

As this series seems to need a respin anyways:

extconfig means "extended config", correct?
That is fairly nondescript.

I would prefer something like "NOLIBC_TEST_CONFIG" and something like
"make nolibctestconfig" to make an existing config ready for
nolibc-test.

> +
>  # optional tests to run (default = all)
>  TEST =
>  
> @@ -161,6 +164,8 @@ initramfs: nolibc-test
>  
>  defconfig:
>  	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare
> +	$(Q)$(srctree)/scripts/kconfig/merge_config.sh -O "$(srctree)" -m "$(srctree)/.config" $(foreach c,$(EXTCONFIG),$(wildcard $(CURDIR)/configs/$c))
> +	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) KCONFIG_ALLCONFIG="$(srctree)/.config" allnoconfig
>  
>  kernel: initramfs
>  	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME) CONFIG_INITRAMFS_SOURCE=$(CURDIR)/initramfs
> -- 
> 2.25.1
> 
