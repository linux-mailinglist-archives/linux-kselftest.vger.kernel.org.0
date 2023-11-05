Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B397E130D
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Nov 2023 11:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjKEKf4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 5 Nov 2023 05:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKEKf4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 5 Nov 2023 05:35:56 -0500
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA507F2;
        Sun,  5 Nov 2023 02:35:52 -0800 (PST)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 3A5AZe6w002725;
        Sun, 5 Nov 2023 11:35:40 +0100
Date:   Sun, 5 Nov 2023 11:35:40 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, Zhangjin Wu <falcon@tinylab.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 5/6] selftests/nolibc: extraconfig support
Message-ID: <ZUdv/AniaMBC2KFW@1wt.eu>
References: <20231105-nolibc-mips-be-v1-0-6c2ad3e50a1f@weissschuh.net>
 <20231105-nolibc-mips-be-v1-5-6c2ad3e50a1f@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231105-nolibc-mips-be-v1-5-6c2ad3e50a1f@weissschuh.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Nov 05, 2023 at 11:09:59AM +0100, Thomas Weiﬂschuh wrote:
> Allow some postprocessing of defconfig files.
> 
> Suggested-by: Zhangjin Wu <falcon@tinylab.org>
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  tools/testing/selftests/nolibc/Makefile | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> index f8fea9fa0263..02c074e73a28 100644
> --- a/tools/testing/selftests/nolibc/Makefile
> +++ b/tools/testing/selftests/nolibc/Makefile
> @@ -81,6 +81,8 @@ DEFCONFIG_s390       = defconfig
>  DEFCONFIG_loongarch  = defconfig
>  DEFCONFIG            = $(DEFCONFIG_$(XARCH))
>  
> +EXTRACONFIG           = $(EXTRACONFIG_$(XARCH))
> +
>  # optional tests to run (default = all)
>  TEST =
>  
> @@ -227,6 +229,10 @@ initramfs: nolibc-test
>  
>  defconfig:
>  	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare
> +	$(Q)if [ -n "$(EXTRACONFIG)" ]; then \
> +		$(srctree)/scripts/config --file $(objtree)/.config $(EXTRACONFIG); \
> +		$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) oldconfig < /dev/null; \

You should instead use "olddefconfig" for this. It reuses defconfig but
uses defaults for new questions. I've already experienced issues from
time to time using /dev/null with oldconfig as you did above, with a
process looping forever (probably on a non acceptable choice I guess),
and never met such issues anymore since I switched to olddefconfig
instead.

Willy
