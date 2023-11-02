Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40697DEE54
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Nov 2023 09:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjKBIuF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Nov 2023 04:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjKBIuF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Nov 2023 04:50:05 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 96004128;
        Thu,  2 Nov 2023 01:50:01 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 3A28nUV0005974;
        Thu, 2 Nov 2023 09:49:30 +0100
Date:   Thu, 2 Nov 2023 09:49:30 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, Zhangjin Wu <falcon@tinylab.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] selftests/nolibc: use EFI -bios for LoongArch qemu
Message-ID: <ZUNimsmXWjky6Z37@1wt.eu>
References: <20231031-nolibc-out-of-tree-v1-0-47c92f73590a@weissschuh.net>
 <20231031-nolibc-out-of-tree-v1-1-47c92f73590a@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231031-nolibc-out-of-tree-v1-1-47c92f73590a@weissschuh.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 31, 2023 at 09:36:58PM +0100, Thomas Weiﬂschuh wrote:
> qemu for LoongArch does not work properly with direct kernel boot.
> The kernel will panic during initialization and hang without any output.
> 
> When booting in EFI mode everything work correctly.
> 
> While users most likely don't have the LoongArch EFI binary installed at
> least an explicit error about 'file not found' is better than a hanging
> test without output that can never succeed.
> 
> Link: https://lore.kernel.org/loongarch/1738d60a-df3a-4102-b1da-d16a29b6e06a@t-8ch.de/
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  tools/testing/selftests/nolibc/Makefile | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> index a0fc07253baf..eb258ae1d948 100644
> --- a/tools/testing/selftests/nolibc/Makefile
> +++ b/tools/testing/selftests/nolibc/Makefile
> @@ -88,6 +88,13 @@ QEMU_ARCH_s390       = s390x
>  QEMU_ARCH_loongarch  = loongarch64
>  QEMU_ARCH            = $(QEMU_ARCH_$(XARCH))
>  
> +QEMU_BIOS_DIR = /usr/share/edk2/
> +QEMU_BIOS_loongarch = $(QEMU_BIOS_DIR)/loongarch64/OVMF_CODE.fd
> +
> +ifneq ($(QEMU_BIOS_$(XARCH)),)
> +QEMU_ARGS_BIOS = -bios $(QEMU_BIOS_$(XARCH))
> +endif
> +
>  # QEMU_ARGS : some arch-specific args to pass to qemu
>  QEMU_ARGS_i386       = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(TEST:%=NOLIBC_TEST=%)"
>  QEMU_ARGS_x86_64     = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(TEST:%=NOLIBC_TEST=%)"
> @@ -101,7 +108,7 @@ QEMU_ARGS_ppc64le    = -M powernv -append "console=hvc0 panic=-1 $(TEST:%=NOLIBC
>  QEMU_ARGS_riscv      = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
>  QEMU_ARGS_s390       = -M s390-ccw-virtio -m 1G -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
>  QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
> -QEMU_ARGS            = $(QEMU_ARGS_$(XARCH)) $(QEMU_ARGS_EXTRA)
> +QEMU_ARGS            = $(QEMU_ARGS_$(XARCH)) $(QEMU_ARGS_BIOS) $(QEMU_ARGS_EXTRA)
>  
>  # OUTPUT is only set when run from the main makefile, otherwise
>  # it defaults to this nolibc directory.

Looks much nicer this way, thanks ;-)

Acked-by: Willy Tarreau <w@1wt.eu>

Willy
