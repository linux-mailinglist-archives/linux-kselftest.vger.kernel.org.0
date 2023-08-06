Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4143D7713F1
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Aug 2023 10:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjHFIRs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 6 Aug 2023 04:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjHFIRr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 6 Aug 2023 04:17:47 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 237EA1BEC;
        Sun,  6 Aug 2023 01:17:43 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3768HVuR011736;
        Sun, 6 Aug 2023 10:17:31 +0200
Date:   Sun, 6 Aug 2023 10:17:31 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, tanyuan@tinylab.org,
        thomas@t-8ch.de
Subject: Re: [PATCH v6 7/8] selftests/nolibc: allow customize CROSS_COMPILE
 by architecture
Message-ID: <20230806081731.GA10627@1wt.eu>
References: <cover.1691259983.git.falcon@tinylab.org>
 <8f21df212f07a43d7534dedfd2beb4c8a2e05308.1691259983.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f21df212f07a43d7534dedfd2beb4c8a2e05308.1691259983.git.falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Aug 06, 2023 at 02:46:03AM +0800, Zhangjin Wu wrote:
> Some cross compilers may not just be prefixed with ARCH, customize them
> by architecture may simplify the test a lot, especially, when iterate
> with ARCH.
> 
> After customizing this for every architecture, the minimal test argument
> will be architecture itself, no CROSS_COMPILE required to be passed.
> 
> If the prefix of installed cross compiler is not the same as the one
> customized, we can also pass CROSS_COMPILE as before or even pass
> CROSS_COMPILE_<ARCH>.
> 
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> ---
>  tools/testing/selftests/nolibc/Makefile | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> index 452d8e424d28..45d231b9c5c2 100644
> --- a/tools/testing/selftests/nolibc/Makefile
> +++ b/tools/testing/selftests/nolibc/Makefile
> @@ -55,6 +55,12 @@ IMAGE_loongarch  = arch/loongarch/boot/vmlinuz.efi
>  IMAGE            = $(IMAGE_$(XARCH))
>  IMAGE_NAME       = $(notdir $(IMAGE))
>  
> +# CROSS_COMPILE: cross toolchain prefix by architecture
> +CROSS_COMPILE           ?= $(CROSS_COMPILE_$(XARCH))
> +
> +# make sure CC is prefixed with CROSS_COMPILE
> +$(call allow-override,CC,$(CROSS_COMPILE)gcc)
> +

Note that I feared that it would break my "CC=gcc-5.5.0" and so on but
fortunately it did not. However I don't understand what it tries to do
nor the problem it tries to solve (even the commit message is quite
unclear to me). I'm leaving it aside anyway but I wanted to let you
know.

Willy
