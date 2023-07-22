Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E682F75DC55
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jul 2023 14:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjGVMAy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 22 Jul 2023 08:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjGVMAv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 22 Jul 2023 08:00:51 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2269730C4;
        Sat, 22 Jul 2023 05:00:47 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 36MC0bDQ017318;
        Sat, 22 Jul 2023 14:00:37 +0200
Date:   Sat, 22 Jul 2023 14:00:37 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     thomas@t-8ch.de, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH v1 4/8] selftests/nolibc: add extra config file customize
 support
Message-ID: <20230722120037.GA17311@1wt.eu>
References: <cover.1689713175.git.falcon@tinylab.org>
 <ecd5cd252bc728df1becfebff772713e8edce1ec.1689713175.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ecd5cd252bc728df1becfebff772713e8edce1ec.1689713175.git.falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 19, 2023 at 05:14:07AM +0800, Zhangjin Wu wrote:
> The default DEFCONFIG_<ARCH> may not always work for all architectures,
> some architectures require to add extra kernel config options, this adds
> a new 'extconfig' target for this requirement.
> 
> It allows to customize extra kernel config options via the common
> common.config and the architecture specific <ARCH>.config, at last
> trigger 'allnoconfig' to let them take effect with missing config
> options as disabled.
> 
> The scripts/kconfig/merge_config.sh tool is used to merge the extra
> config files.
> 
> Suggested-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> Link: https://lore.kernel.org/lkml/67eb70d4-c9ff-4afc-bac7-7f36cc2c81bc@t-8ch.de/
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> ---
>  tools/testing/selftests/nolibc/Makefile | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> index f42adef87e12..08a5ca5f418b 100644
> --- a/tools/testing/selftests/nolibc/Makefile
> +++ b/tools/testing/selftests/nolibc/Makefile
> @@ -39,6 +39,9 @@ DEFCONFIG_s390       = defconfig
>  DEFCONFIG_loongarch  = defconfig
>  DEFCONFIG            = $(DEFCONFIG_$(ARCH))
>  
> +# extra kernel config files under configs/, include common + architecture specific
> +EXTCONFIG            = common.config $(ARCH).config
> +
>  # optional tests to run (default = all)
>  TEST =
>  
> @@ -162,6 +165,10 @@ initramfs: nolibc-test
>  defconfig:
>  	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare
>  
> +extconfig:
> +	$(Q)$(srctree)/scripts/kconfig/merge_config.sh -O "$(srctree)" -m "$(srctree)/.config" $(foreach c,$(EXTCONFIG),$(wildcard $(CURDIR)/configs/$c))
> +	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) KCONFIG_ALLCONFIG="$(srctree)/.config" allnoconfig
> +

Please also mention this entry in the "help" message.
Other than that, OK.

Willy
