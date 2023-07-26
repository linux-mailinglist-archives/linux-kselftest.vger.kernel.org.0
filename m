Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D337E763B0D
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 17:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbjGZP35 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jul 2023 11:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbjGZP35 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jul 2023 11:29:57 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853FB2136;
        Wed, 26 Jul 2023 08:29:53 -0700 (PDT)
X-QQ-mid: bizesmtp63t1690385383t5iif69s
Received: from linux-lab-host.localdomain ( [61.141.78.189])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 26 Jul 2023 23:29:42 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: J5JfekO1WsiL3ug9fgDy4ITrNZ0Fco01rrnYx6BE0VpZMg43YoQewkRlQLBJn
        hmjsVReJmsufwSNs1hcQEemS4Gi3UmrZjM2f332VOw0ctbp2I3bQ+11jvuvtO4kgHhB1Bb4
        dgGHIEGSE1tH1ti5KfpuC1PJsLVA/YVixLnj6aMYZ6bf0vgvAsv1gLDot4aVJxN2aa9fLYE
        D6+rvyZuIvWtkwPdlPTQepiwz9uEs22TuKaaByxV6pg93K+XJ9rbwzWtaI9m8I1BFDibKhC
        7AWSr78gfaqfy5Y9MO3W7CAKq/11Z9jdzhX8g/dEApdrCur/O2zk/h5CKHGRV66cIvNu5CJ
        gA75ep7cyJr+vfuVIyd/on06QRLMAMKwr89tP9wp2mTul2iE2UJZCTmuVdM5dw35aNaqmQg
        ei5hA+tkEb8=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4160635926283433686
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux@weissschuh.net,
        thomas@t-8ch.de
Subject: [PATCH v2 5/7] selftests/nolibc: add test support for ppc
Date:   Wed, 26 Jul 2023 23:29:38 +0800
Message-Id: <20230726152938.251649-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <55603bb4aecb20561e63f9ab10563c0c470300b1.1690373704.git.falcon@tinylab.org>
References: <55603bb4aecb20561e63f9ab10563c0c470300b1.1690373704.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy

I'm very sorry, the extra configs/powerpc.config file is missing in this
patch, perhaps a failed rebase introduced this issue.

Please don't merge it, to avoid manually merge another addtional patch, if no
other issues in this v2 series, I will send v3 immediately, just wait for your
feedbacks, no hurry.

Best regards,
Zhangjin

> The default qemu-system-ppc g3beige machine [1] is used to run 32-bit
> powerpc kernel.
> 
> The pmac32_defconfig is used with extra PMACZILOG console options to
> enable normal print.
> 
> Note, zImage doesn't boot due to "qemu-system-ppc: Some ROM regions are
> overlapping" error, so, vmlinux is used instead.
> 
> Kernel uses ARCH=powerpc for both 32-bit and 64-bit PowerPC, here adds a
> ppc variant for 32-bit PowerPC and use it as the default variant of
> powerpc architecture.
> 
> Users can pass ARCH=powerpc or ARCH=ppc to test 32-bit PowerPC.
> 
> [1]: https://qemu.readthedocs.io/en/latest/system/ppc/powermac.html
> 
> Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> ---
>  tools/testing/selftests/nolibc/Makefile | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> index f04ec1cc132b..0e9abb7f3d4f 100644
> --- a/tools/testing/selftests/nolibc/Makefile
> +++ b/tools/testing/selftests/nolibc/Makefile
> @@ -16,10 +16,12 @@ endif
>  
>  # XARCH is used to save user-input ARCH variant
>  # allow configure default variant for target ARCH
> +XARCH_powerpc    = ppc
>  XARCH           := $(or $(XARCH_$(ARCH)),$(ARCH))
>  
>  # ARCH is supported by kernel
>  # map from user-input variant to kernel-supported
> +ARCH_ppc         = powerpc
>  override ARCH   := $(or $(ARCH_$(XARCH)),$(XARCH))
>  
>  # kernel image names by architecture
> @@ -29,6 +31,7 @@ IMAGE_x86        = arch/x86/boot/bzImage
>  IMAGE_arm64      = arch/arm64/boot/Image
>  IMAGE_arm        = arch/arm/boot/zImage
>  IMAGE_mips       = vmlinuz
> +IMAGE_ppc        = vmlinux
>  IMAGE_riscv      = arch/riscv/boot/Image
>  IMAGE_s390       = arch/s390/boot/bzImage
>  IMAGE_loongarch  = arch/loongarch/boot/vmlinuz.efi
> @@ -42,6 +45,7 @@ DEFCONFIG_x86        = defconfig
>  DEFCONFIG_arm64      = defconfig
>  DEFCONFIG_arm        = multi_v7_defconfig
>  DEFCONFIG_mips       = malta_defconfig
> +DEFCONFIG_ppc        = pmac32_defconfig
>  DEFCONFIG_riscv      = defconfig
>  DEFCONFIG_s390       = defconfig
>  DEFCONFIG_loongarch  = defconfig
> @@ -60,6 +64,7 @@ QEMU_ARCH_x86        = x86_64
>  QEMU_ARCH_arm64      = aarch64
>  QEMU_ARCH_arm        = arm
>  QEMU_ARCH_mips       = mipsel  # works with malta_defconfig
> +QEMU_ARCH_ppc        = ppc
>  QEMU_ARCH_riscv      = riscv64
>  QEMU_ARCH_s390       = s390x
>  QEMU_ARCH_loongarch  = loongarch64
> @@ -72,6 +77,7 @@ QEMU_ARGS_x86        = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(
>  QEMU_ARGS_arm64      = -M virt -cpu cortex-a53 -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
>  QEMU_ARGS_arm        = -M virt -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
>  QEMU_ARGS_mips       = -M malta -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
> +QEMU_ARGS_ppc        = -M g3beige -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
>  QEMU_ARGS_riscv      = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
>  QEMU_ARGS_s390       = -M s390-ccw-virtio -m 1G -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
>  QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
> -- 
> 2.25.1
