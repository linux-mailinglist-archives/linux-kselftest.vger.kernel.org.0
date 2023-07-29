Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF1F767D29
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 10:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjG2Ifo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 29 Jul 2023 04:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjG2Ifm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 29 Jul 2023 04:35:42 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F120144A9;
        Sat, 29 Jul 2023 01:35:37 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 36T8ZUFU004434;
        Sat, 29 Jul 2023 10:35:30 +0200
Date:   Sat, 29 Jul 2023 10:35:30 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Zhangjin Wu <falcon@tinylab.org>
Cc:     thomas@t-8ch.de, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 06/12] selftests/nolibc: customize CROSS_COMPILE for
 32/64-bit powerpc
Message-ID: <20230729083530.GN956@1wt.eu>
References: <cover.1690489039.git.falcon@tinylab.org>
 <41e2aa9e4299dd35cfeef9fecc2a6a02a7b49d90.1690489039.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41e2aa9e4299dd35cfeef9fecc2a6a02a7b49d90.1690489039.git.falcon@tinylab.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 28, 2023 at 04:28:17AM +0800, Zhangjin Wu wrote:
> The little-endian powerpc64le compilers provided by Ubuntu and Fedora
> are able to compile big endian kernel and big endian nolibc-test [1].
> 
> These default CROSS_COMPILE settings allow to test target architectures
> with:
> 
>     $ cd /path/to/tools/testing/selftests/nolibc/
> 
>     $ for arch in ppc ppc64 ppc64le; do \
>         make run-user ARCH=$arch | grep "status: "; \
>       done
> 
> If want to use another cross compiler, please simply pass CROSS_COMPILE
> or CC as before.
> 
> For example, it is able to build 64-bit nolibc-test with the big endian
> powerpc64-linux-gcc crosstool from [2]:
> 
>     $ wget -c https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.1.0/x86_64-gcc-13.1.0-nolibc-powerpc64-linux.tar.xz
>     $ tar xvf x86_64-gcc-13.1.0-nolibc-powerpc64-linux.tar.xz
>     $ export PATH=$PWD/gcc-13.1.0-nolibc/powerpc64-linux/bin/:$PATH
> 
>     $ export CROSS_COMPILE_ppc64=powerpc64-linux-
>     $ export CROSS_COMPILE_ppc64le=powerpc64-linux-
>     $ for arch in ppc64 ppc64le; do \
>         make run-user ARCH=$arch | grep "status: "; \
>       done
> 
> Or specify CC directly with full path:
> 
>     $ export CC=$PWD/gcc-13.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux-gcc
>     $ for arch in ppc64 ppc64le; do \
>         make run-user ARCH=$arch | grep "status: "; \
>       done
> 
> [1]: https://github.com/open-power/skiboot
> [2]: https://mirrors.edge.kernel.org/pub/tools/crosstool/
> 
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> ---
>  tools/testing/selftests/nolibc/Makefile | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> index 3f15c7f7ef76..6385915d16c9 100644
> --- a/tools/testing/selftests/nolibc/Makefile
> +++ b/tools/testing/selftests/nolibc/Makefile
> @@ -46,6 +46,9 @@ IMAGE            = $(IMAGE_$(XARCH))
>  IMAGE_NAME       = $(notdir $(IMAGE))
>  
>  # CROSS_COMPILE: cross toolchain prefix by architecture
> +CROSS_COMPILE_ppc       ?= powerpc-linux-gnu-
> +CROSS_COMPILE_ppc64     ?= powerpc64le-linux-gnu-
> +CROSS_COMPILE_ppc64le   ?= powerpc64le-linux-gnu-
>  CROSS_COMPILE           ?= $(CROSS_COMPILE_$(XARCH))

It seems to me that this patch and the previous one were rather
for the PPC series as I'm not seeing the relation with the tiny
config here.

Willy
