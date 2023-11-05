Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9183B7E130A
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Nov 2023 11:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjKEKcw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 5 Nov 2023 05:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKEKcv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 5 Nov 2023 05:32:51 -0500
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61FEFE9;
        Sun,  5 Nov 2023 02:32:47 -0800 (PST)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 3A5AWRwg002706;
        Sun, 5 Nov 2023 11:32:27 +0100
Date:   Sun, 5 Nov 2023 11:32:27 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, Zhangjin Wu <falcon@tinylab.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/6] selftests/nolibc: use XARCH for MIPS
Message-ID: <ZUdvO9moDc7X5E54@1wt.eu>
References: <20231105-nolibc-mips-be-v1-0-6c2ad3e50a1f@weissschuh.net>
 <20231105-nolibc-mips-be-v1-3-6c2ad3e50a1f@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231105-nolibc-mips-be-v1-3-6c2ad3e50a1f@weissschuh.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Thomas,

On Sun, Nov 05, 2023 at 11:09:57AM +0100, Thomas Weiﬂschuh wrote:
> MIPS has many different configurations prepare the support of additional
> ones by moving the build of MIPS to the generic XARCH infrastructure.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  tools/testing/selftests/nolibc/Makefile     | 12 +++++++-----
>  tools/testing/selftests/nolibc/run-tests.sh |  2 +-
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> index c5df1617cbc3..15c12f3c27ba 100644
> --- a/tools/testing/selftests/nolibc/Makefile
> +++ b/tools/testing/selftests/nolibc/Makefile
> @@ -40,12 +40,14 @@ objtree ?= $(srctree)
>  
>  # configure default variants for target kernel supported architectures
>  XARCH_powerpc    = ppc
> +XARCH_mips       = mipso32le
>  XARCH            = $(or $(XARCH_$(ARCH)),$(ARCH))
>  
>  # map from user input variants to their kernel supported architectures
>  ARCH_ppc         = powerpc
>  ARCH_ppc64       = powerpc
>  ARCH_ppc64le     = powerpc
> +ARCH_mipso32le   = mips

I *think* that what you called "mipso32le" above corresponds exactly to
what is commonly called "mips32le" in toolchains or distros, because,
unless I'm mistaken, "mips32" currently uses the O32 ABI. So that would
sound more intuitive and natural I think.

Willy
