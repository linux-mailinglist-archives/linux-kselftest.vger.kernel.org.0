Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1C976C4C9
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Aug 2023 07:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjHBFWK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 01:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjHBFWI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 01:22:08 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EBF2137;
        Tue,  1 Aug 2023 22:22:04 -0700 (PDT)
X-QQ-mid: bizesmtp64t1690953711tpgrmgb5
Received: from linux-lab-host.localdomain ( [116.30.131.233])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 02 Aug 2023 13:21:50 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: zT6n3Y95oi3BNQ283kmFfmeO4lwPDSt0J5JDNOhNs39E3Gc3Lbi6ZIvwiSn5I
        fzAs2cHLPio8pBluisDzG3gHd1+ftovD1yT0mV82eJNB4Iwg3l+QIng73RKwy/Pw2fXFifU
        PrzMCzJVQw0GNa1HO80YXeJmIQjrI3QSTr8edXa4kcU1Svo+7BoaxHJv/1PmDR9FTn3Nrjo
        cJXfRJnDtZt4f131giJsuLzYIWpxG0GYoDktYifwT7GTroLSdGB8lv0TqnNLBd2ezXlK22o
        pEBJp7avut+tsLuS3RajxofZS5xF0hNn/mpZBYhY6lVTzu19r6jPZk7+XEEX7auneb3rFce
        J9OjfkR6NZKL5iA00viRaKRYoV/UnN4scg7BBaLWXmOLXOq3JfTTQH/2jF/M7qT/xxTE9RM
        kd1J+VbjHdc=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17801687012396113882
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux@weissschuh.net
Subject: [PATCH v4 08/12] selftests/nolibc: add test support for ppc
Date:   Wed,  2 Aug 2023 13:21:50 +0800
Message-Id: <20230802052150.138283-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <0833846b9fc9e2260f9aa2c732a12d9dfa329286.1690916314.git.falcon@tinylab.org>
References: <0833846b9fc9e2260f9aa2c732a12d9dfa329286.1690916314.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Willy, Thomas

Yuan is helping me to test this series and the tinyconfig series with
the latest compilers.

His first test found this ppc support failed with stackprotector when
using a newer compiler (I used an older compiler without stackprotector
for ppc), I'm debugging it, so, please ignore this revision too, of
course, if time allows, welcome to take a look at the other patches.

His other tests are trying to find out the exact poweroff support
options for every architecture one by one, let's fill this gap ...

Thanks,
Zhangjin

> Kernel uses ARCH=powerpc for both 32-bit and 64-bit PowerPC, here adds a
> ppc variant for 32-bit PowerPC and uses it as the default variant of
> powerpc architecture.
> 
> Users can pass ARCH=powerpc or XARCH=ppc to test 32-bit PowerPC.
> 
> The default qemu-system-ppc g3beige machine [1] is used to run 32-bit
> powerpc kernel.
> 
> The pmac32_defconfig is used with extra PMACZILOG console options to
> enable normal print.
> 
> Note, zImage doesn't boot due to "qemu-system-ppc: Some ROM regions are
> overlapping" error, so, vmlinux is used instead.
> 
> [1]: https://qemu.readthedocs.io/en/latest/system/ppc/powermac.html
> 
> Suggested-by: Willy Tarreau <w@1wt.eu>
> Link: https://lore.kernel.org/lkml/ZL9leVOI25S2+0+g@1wt.eu/
> Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> ---
>  tools/testing/selftests/nolibc/Makefile                     | 6 ++++++
>  .../testing/selftests/nolibc/configs/nolibc-test-ppc.config | 3 +++
>  2 files changed, 9 insertions(+)
>  create mode 100644 tools/testing/selftests/nolibc/configs/nolibc-test-ppc.config
> 
> diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> index 3c9e3963fbad..29e02b49903a 100644
> --- a/tools/testing/selftests/nolibc/Makefile
> +++ b/tools/testing/selftests/nolibc/Makefile
> @@ -33,9 +33,11 @@ endif
>  # architectures where both are equal.
>  
>  # configure default variants for target kernel supported architectures
> +XARCH_powerpc    = ppc
>  XARCH            = $(or $(XARCH_$(ARCH)),$(ARCH))
>  
>  # map from user input variants to their kernel supported architectures
> +ARCH_ppc         = powerpc
>  ARCH            := $(or $(ARCH_$(XARCH)),$(XARCH))
>  
>  # kernel image names by architecture
> @@ -45,6 +47,7 @@ IMAGE_x86        = arch/x86/boot/bzImage
>  IMAGE_arm64      = arch/arm64/boot/Image
>  IMAGE_arm        = arch/arm/boot/zImage
>  IMAGE_mips       = vmlinuz
> +IMAGE_ppc        = vmlinux
>  IMAGE_riscv      = arch/riscv/boot/Image
>  IMAGE_s390       = arch/s390/boot/bzImage
>  IMAGE_loongarch  = arch/loongarch/boot/vmlinuz.efi
> @@ -58,6 +61,7 @@ DEFCONFIG_x86        = defconfig
>  DEFCONFIG_arm64      = defconfig
>  DEFCONFIG_arm        = multi_v7_defconfig
>  DEFCONFIG_mips       = malta_defconfig
> +DEFCONFIG_ppc        = pmac32_defconfig
>  DEFCONFIG_riscv      = defconfig
>  DEFCONFIG_s390       = defconfig
>  DEFCONFIG_loongarch  = defconfig
> @@ -77,6 +81,7 @@ QEMU_ARCH_x86        = x86_64
>  QEMU_ARCH_arm64      = aarch64
>  QEMU_ARCH_arm        = arm
>  QEMU_ARCH_mips       = mipsel  # works with malta_defconfig
> +QEMU_ARCH_ppc        = ppc
>  QEMU_ARCH_riscv      = riscv64
>  QEMU_ARCH_s390       = s390x
>  QEMU_ARCH_loongarch  = loongarch64
> @@ -89,6 +94,7 @@ QEMU_ARGS_x86        = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(
>  QEMU_ARGS_arm64      = -M virt -cpu cortex-a53 -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
>  QEMU_ARGS_arm        = -M virt -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
>  QEMU_ARGS_mips       = -M malta -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
> +QEMU_ARGS_ppc        = -M g3beige -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
>  QEMU_ARGS_riscv      = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
>  QEMU_ARGS_s390       = -M s390-ccw-virtio -m 1G -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
>  QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
> diff --git a/tools/testing/selftests/nolibc/configs/nolibc-test-ppc.config b/tools/testing/selftests/nolibc/configs/nolibc-test-ppc.config
> new file mode 100644
> index 000000000000..b1975f8253f7
> --- /dev/null
> +++ b/tools/testing/selftests/nolibc/configs/nolibc-test-ppc.config
> @@ -0,0 +1,3 @@
> +CONFIG_SERIAL_PMACZILOG=y
> +CONFIG_SERIAL_PMACZILOG_TTYS=y
> +CONFIG_SERIAL_PMACZILOG_CONSOLE=y
> -- 
> 2.25.1
