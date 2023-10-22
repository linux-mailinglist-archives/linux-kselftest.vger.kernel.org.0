Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193CF7D2215
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Oct 2023 11:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjJVJWx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 22 Oct 2023 05:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjJVJWw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 22 Oct 2023 05:22:52 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A998E124;
        Sun, 22 Oct 2023 02:22:49 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 39M9Md4Z003529;
        Sun, 22 Oct 2023 11:22:39 +0200
Date:   Sun, 22 Oct 2023 11:22:39 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, Zhangjin Wu <falcon@tinylab.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] selftests/nolibc: anchor paths in $(srcdir) if
 possible
Message-ID: <20231022092239.GD2669@1wt.eu>
References: <20231010-nolibc-out-of-tree-v1-0-b6a263859596@weissschuh.net>
 <20231010-nolibc-out-of-tree-v1-3-b6a263859596@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231010-nolibc-out-of-tree-v1-3-b6a263859596@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 10, 2023 at 02:33:58PM +0200, Thomas Weiﬂschuh wrote:
> It is easier to recognize paths from their well-known location in the
> source tree than having to resolve the relative path in ones head.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  tools/testing/selftests/nolibc/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> index 258293639572..598d53c5cb7b 100644
> --- a/tools/testing/selftests/nolibc/Makefile
> +++ b/tools/testing/selftests/nolibc/Makefile
> @@ -167,7 +167,7 @@ sysroot: sysroot/$(ARCH)/include
>  sysroot/$(ARCH)/include:
>  	$(Q)rm -rf sysroot/$(ARCH) sysroot/sysroot
>  	$(QUIET_MKDIR)mkdir -p sysroot
> -	$(Q)$(MAKE) -C ../../../include/nolibc ARCH=$(ARCH) OUTPUT=$(CURDIR)/sysroot/ headers_standalone
> +	$(Q)$(MAKE) -C $(srctree)/tools/include/nolibc ARCH=$(ARCH) OUTPUT=$(CURDIR)/sysroot/ headers_standalone
>  	$(Q)mv sysroot/sysroot sysroot/$(ARCH)
>  
>  ifneq ($(NOLIBC_SYSROOT),0)
> @@ -177,7 +177,7 @@ nolibc-test: nolibc-test.c sysroot/$(ARCH)/include
>  else
>  nolibc-test: nolibc-test.c
>  	$(QUIET_CC)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ \
> -	  -nostdlib -static -include ../../../include/nolibc/nolibc.h $< -lgcc
> +	  -nostdlib -static -include $(srctree)/tools/include/nolibc/nolibc.h $< -lgcc
>  endif

Agreed, this comes from the early days where we didn't have srctree,
that's better this way.

Acked-by: Willy Tarreau <w@1wt.eu>

Willy
