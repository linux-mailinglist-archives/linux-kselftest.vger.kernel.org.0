Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651CC767C9A
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 08:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbjG2Goh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Jul 2023 02:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjG2Gog (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Jul 2023 02:44:36 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA1E46BE;
        Fri, 28 Jul 2023 23:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1690613073; bh=vT7T7S6ZTBPa7EPWoFTGiyvB7Db4bQi2VXEcK4hdMAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mwOGyO5u/wDRg5VTnXjrNNV8BfM1Z1xmwfqy73F85CS0IyaDbrAlOxPJKkGGl1FRi
         0du+Tj+gw41YMv6PUfFhN2yRAqCIxTbNaFROVEg8QZCtijwYFMrP4mJMyZb2bBST3r
         +kUIrMcBl6ZSmfQYOJY0qw299CzWwDX/8NOFKWIo=
Date:   Sat, 29 Jul 2023 08:44:32 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     w@1wt.eu, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 12/12] selftests/nolibc: speed up some targets with
 multiple jobs
Message-ID: <ce2f10ad-bbdf-4948-b784-b497e8973e6e@t-8ch.de>
References: <cover.1690489039.git.falcon@tinylab.org>
 <ca03989b38085a74bde33b7dc5040b33a76f3c4b.1690489039.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca03989b38085a74bde33b7dc5040b33a76f3c4b.1690489039.git.falcon@tinylab.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-07-28 04:35:01+0800, Zhangjin Wu wrote:
> The sysroot install and kernel build targets are time cost, let's use
> -j<N> to parallelize them with multiple jobs.
> 
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> ---
>  tools/testing/selftests/nolibc/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> index ad2538ec5eb0..1b45c22f9a94 100644
> --- a/tools/testing/selftests/nolibc/Makefile
> +++ b/tools/testing/selftests/nolibc/Makefile
> @@ -171,7 +171,7 @@ PHONY = sysroot/$(ARCH)/include
>  sysroot/$(ARCH)/include:
>  	$(Q)rm -rf sysroot/$(ARCH) sysroot/sysroot
>  	$(QUIET_MKDIR)mkdir -p sysroot
> -	$(Q)$(MAKE) -C ../../../include/nolibc ARCH=$(ARCH) OUTPUT=$(CURDIR)/sysroot/ headers_standalone
> +	$(Q)$(MAKE) -j$$(nproc) -C ../../../include/nolibc ARCH=$(ARCH) OUTPUT=$(CURDIR)/sysroot/ headers_standalone

This should already work when the users specify -j on the make command
line themselves.
I'm not a fan of force-enabling it here.

>  	$(Q)mv sysroot/sysroot sysroot/$(ARCH)
>  
>  ifneq ($(NOLIBC_SYSROOT),0)
> @@ -211,7 +211,7 @@ initramfs: nolibc-test
>  	$(Q)cp nolibc-test initramfs/init
>  
>  # common macros for kernel targets
> -MAKE_KERNEL   = $(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE)
> +MAKE_KERNEL   = $(MAKE) -j$$(nproc) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE)
>  KERNEL_CONFIG = $(objtree)/.config
>  KERNEL_IMAGE  = $(objtree)/$(IMAGE)
>  
> -- 
> 2.25.1
> 
