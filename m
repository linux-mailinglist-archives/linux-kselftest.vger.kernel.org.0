Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876CA75DC8E
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jul 2023 14:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjGVMfj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 22 Jul 2023 08:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGVMfj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 22 Jul 2023 08:35:39 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D476E71;
        Sat, 22 Jul 2023 05:35:37 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 36MCZR0R017420;
        Sat, 22 Jul 2023 14:35:27 +0200
Date:   Sat, 22 Jul 2023 14:35:27 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     thomas@t-8ch.de, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 05/14] selftests/nolibc: add menuconfig for development
Message-ID: <20230722123527.GG17311@1wt.eu>
References: <cover.1689759351.git.falcon@tinylab.org>
 <a7fcca12e0f567efd29314172ccf1ad4cd279bf7.1689759351.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7fcca12e0f567efd29314172ccf1ad4cd279bf7.1689759351.git.falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 19, 2023 at 09:22:37PM +0800, Zhangjin Wu wrote:
> The default DEFCONFIG_<ARCH> may not always work for all architectures,
> let's allow users to tune some kernel config options with 'menuconfig'.
> 
> This is important when porting nolibc to a new architecture, it also
> allows to speed up nolibc 'run' target testing via manually disabling
> tons of unnecessary kernel config options.
> 
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> ---
>  tools/testing/selftests/nolibc/Makefile | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> index 058e7be070ea..06954b4b3885 100644
> --- a/tools/testing/selftests/nolibc/Makefile
> +++ b/tools/testing/selftests/nolibc/Makefile
> @@ -202,6 +202,9 @@ KERNEL_IMAGE  = $(objtree)/$(IMAGE)
>  defconfig:
>  	$(Q)$(MAKE_KERNEL) mrproper $(DEFCONFIG) prepare
>  
> +menuconfig:
> +	$(Q)$(MAKE_KERNEL) menuconfig

What is the real benefit of this compared to just running the
standard "make menuconfig" ? We should avoid adding makefile targets
that do not bring value on top of that the top-level makefile does,
because it will make the useful ones much harder to spot, and will
tend to encourage users to use only that makefile during the tests,
which is a bad practice since many targets will always be missing
or work differently. It's important in my opinion that we strictly
stick to what is useful to operate the tests themselves and this
one doesn't make me feel like it qualifies as such.

Willy
