Return-Path: <linux-kselftest+bounces-26186-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85533A2F255
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 16:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21152160987
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 15:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8F9243969;
	Mon, 10 Feb 2025 15:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXWPIGhA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579C4241CA6;
	Mon, 10 Feb 2025 15:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739203140; cv=none; b=jih8xV6BWGSPviGTLJNMAtW0fuXuewiACfU4ke2XGNaZn+yhHQny8Shjn+vg4XVNBQq+CUpKJCT5h1pNGexAnYuJJbGWNwQ1BWvNnZQAnC29TF3jjQyauvxMX05AgySOUXthxf6bl8Tc4rvnt6+2ITbVGv41UxT5wWH5t+Bj2Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739203140; c=relaxed/simple;
	bh=7EBG2tbET6wKJo1NNIhON2+Zer6a0bhl92q4Vm0qXA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D51iVQAGBFvgwRbScVtGgL1pBHO43Y2zMRShwfv+GmqHc/x8coZzdwI/dL0XuPxsmfyAOfjH7qWnJSWs53CpFvoN/RVvzZDwAwsRRCZ0/GNcR0qDUDGV7w7M9s0hZ3NORUcg6GX4B85VK/JxjBF4bmyFaY4L+RO8kwcek1npCis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IXWPIGhA; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-308e3bd8286so18908671fa.1;
        Mon, 10 Feb 2025 07:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739203136; x=1739807936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zrWLyzw/v9toMpV/2WaUI0bKtb0fFU80Ird81ZrYzdM=;
        b=IXWPIGhAJ82Ozp6AAlz6rPnWLR32UWEpqQwsF5nlYoQnSBdVLH/rkZZzREyqftTzz1
         9659ptAEkg6vdRzo3nS9loRUYh6uK206frrUB9KYTHSDA2Im4+JIy40iwIt2IRPmPWCk
         /kNiJFGirK6czrCfqZUtsmdzlf8WUBqSMvKPK9aiUE5u3IYmCzY6aGv/iI1ebX20AOkj
         kZb0i+ZURZBo2ul0TV4MThGbbMkYcIfTvmnpD+17E/y3BDoljMqKggLVX2fX/aDDH8aQ
         wDckAQarsyWpRORHWOkfDuTZh/MuuCu/Y0dHft8vHZRI4M5cLYD0qxC/nZveDOxjL2R2
         t8Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739203136; x=1739807936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zrWLyzw/v9toMpV/2WaUI0bKtb0fFU80Ird81ZrYzdM=;
        b=jmIM7eqHEdEyUlSCVZb/A/W+H4STXaE3tKQAKIOT2TS14coIe2p3g2Ww71//VNqJPk
         stG9LdYHMG66erExGlKLDoDfLk4V2lE6/N7ZthkyJ+S5/hqUMBgRhX80pqQwOI7lVY5Y
         QXNnVh6Dc+I+REXn4VKr102f5ZipT3rdYDWQwaG1vy0LTLe1H2lecNUD+ja+Zxu5074E
         PD+JgztblI4uk/DGWIm+Uyp0E5spaGcjpZGEw9QHhAicM84EWnzdwCk30sEH8rH2vcRB
         FfpPGvp0is1Aii5686+QiMRXDWDwPyf0gTyL06Ru14A/aSpi24wYgKBo4rvcDi4Uoag7
         5MAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOk5X6F1pzYXSFgA+Fh3CbEDuIA38WUWB/xuc4VQ8uDhGQh7FXkwAFSmm9XzCbjbR7MJp5zO2J@vger.kernel.org, AJvYcCUmT5/4BL+kWxbea581QLY9wNkaMefkzC9X38kurUr04q3vWdQxao2N4g4q6+iohqH7zKGvvDW8YLG3ElmXkBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzSUEwhsjKTtW8CaXL2c+ZtGHv5SirQAVHcwqAB7wEcqWO0KHp
	CAVZXZQXTp4TL+0XEuiK6xdaUsyFiIxba3d9fvlY/0cfKCHioc5lVFqP4JUXt5egxM9yTbR97Mb
	vpusM4Al6REjYmOpXlHviby5NvVXTaGe1
X-Gm-Gg: ASbGncvEAbWsGV9MNjjUHwnNY/iJsUmY+mDDKzq7eLBtGaCNNOAhZ3gPrGT4QwOkJG/
	F8CQkLXABFw3U/R+WV/0RdjGjXiRjpgNwNNzuyUu8eOxbN2zUjyjJRelQN+YVP++H36nMcEGiqG
	jGWV/06bAfuEVa
X-Google-Smtp-Source: AGHT+IGkqQH/E+Pgi9Ncy1DZY26oSYyDtgavDMNfwuH1XfljRJcaQYH2iTSlbf1cM2cPI7piPE6eDaDQ/T6kMAyVk/Y=
X-Received: by 2002:a2e:be1e:0:b0:300:42ad:f284 with SMTP id
 38308e7fff4ca-307e57bed2dmr45655851fa.7.1739203136163; Mon, 10 Feb 2025
 07:58:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250208-blackholedev-kunit-convert-v2-1-182db9bd56ec@gmail.com>
In-Reply-To: <20250208-blackholedev-kunit-convert-v2-1-182db9bd56ec@gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 10 Feb 2025 10:58:19 -0500
X-Gm-Features: AWEUYZlql4JL5QMxP8vmE8jTowIauEkfV0cUWeYdpuMMeJ7DErdRhKXRycQGMg4
Message-ID: <CAJ-ks9nRmR-w6xAyWkVt-NH9pO+Ec_ehE9rJU+6LQBCYsgWd0w@mail.gmail.com>
Subject: Re: [PATCH v2] blackhole_dev: convert self-test to KUnit
To: Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	David Gow <davidgow@google.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 8, 2025 at 2:26=E2=80=AFPM Tamir Duberstein <tamird@gmail.com> =
wrote:
>
> Convert this very simple smoke test to a KUnit test.
>
> Add a missing `htons` call that was spotted[0] by kernel test robot
> <lkp@intel.com> after initial conversion to KUnit.
>
> Link: https://lore.kernel.org/oe-kbuild-all/202502090223.qCYMBjWT-lkp@int=
el.com/ [0]
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
> I tested this using:
>
> $ tools/testing/kunit/kunit.py run --arch arm64 --make_options LLVM=3D1 -=
-kconfig_add CONFIG_NET=3Dy blackholedev
> ---
> Changes in v2:
> - Add missing `htons` call. (kernel test robot <lkp@intel.com>)
> - Link to v1: https://lore.kernel.org/r/20250207-blackholedev-kunit-conve=
rt-v1-1-8ef0dc1ff881@gmail.com
> ---
>  lib/Kconfig.debug                                  | 20 ++++-----
>  lib/Makefile                                       |  2 +-
>  ...{test_blackhole_dev.c =3D> blackhole_dev_kunit.c} | 47 ++++++++------=
--------
>  tools/testing/selftests/net/Makefile               |  2 +-
>  tools/testing/selftests/net/test_blackhole_dev.sh  | 11 -----
>  5 files changed, 29 insertions(+), 53 deletions(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 1af972a92d06..238321830993 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2557,15 +2557,6 @@ config TEST_BPF
>
>           If unsure, say N.
>
> -config TEST_BLACKHOLE_DEV
> -       tristate "Test blackhole netdev functionality"
> -       depends on m && NET
> -       help
> -         This builds the "test_blackhole_dev" module that validates the
> -         data path through this blackhole netdev.
> -
> -         If unsure, say N.
> -
>  config FIND_BIT_BENCHMARK
>         tristate "Test find_bit functions"
>         help
> @@ -2888,6 +2879,17 @@ config USERCOPY_KUNIT_TEST
>           on the copy_to/from_user infrastructure, making sure basic
>           user/kernel boundary testing is working.
>
> +config BLACKHOLE_DEV_KUNIT_TEST
> +       tristate "Test blackhole netdev functionality" if !KUNIT_ALL_TEST=
S
> +       depends on NET
> +       depends on KUNIT
> +       default KUNIT_ALL_TESTS
> +       help
> +         This builds the "blackhole_dev_kunit" module that validates the
> +         data path through this blackhole netdev.
> +
> +         If unsure, say N.
> +
>  config TEST_UDELAY
>         tristate "udelay test driver"
>         help
> diff --git a/lib/Makefile b/lib/Makefile
> index d5cfc7afbbb8..19ff6993c2bc 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -102,7 +102,6 @@ obj-$(CONFIG_TEST_RUNTIME) +=3D tests/
>  obj-$(CONFIG_TEST_DEBUG_VIRTUAL) +=3D test_debug_virtual.o
>  obj-$(CONFIG_TEST_MEMCAT_P) +=3D test_memcat_p.o
>  obj-$(CONFIG_TEST_OBJAGG) +=3D test_objagg.o
> -obj-$(CONFIG_TEST_BLACKHOLE_DEV) +=3D test_blackhole_dev.o
>  obj-$(CONFIG_TEST_MEMINIT) +=3D test_meminit.o
>  obj-$(CONFIG_TEST_LOCKUP) +=3D test_lockup.o
>  obj-$(CONFIG_TEST_HMM) +=3D test_hmm.o
> @@ -393,6 +392,7 @@ obj-$(CONFIG_FORTIFY_KUNIT_TEST) +=3D fortify_kunit.o
>  obj-$(CONFIG_CRC_KUNIT_TEST) +=3D crc_kunit.o
>  obj-$(CONFIG_SIPHASH_KUNIT_TEST) +=3D siphash_kunit.o
>  obj-$(CONFIG_USERCOPY_KUNIT_TEST) +=3D usercopy_kunit.o
> +obj-$(CONFIG_BLACKHOLE_DEV_KUNIT_TEST) +=3D blackhole_dev_kunit.o
>
>  obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) +=3D devmem_is_allowed.o
>
> diff --git a/lib/test_blackhole_dev.c b/lib/blackhole_dev_kunit.c
> similarity index 68%
> rename from lib/test_blackhole_dev.c
> rename to lib/blackhole_dev_kunit.c
> index ec290ac2a0d9..06834ab35f43 100644
> --- a/lib/test_blackhole_dev.c
> +++ b/lib/blackhole_dev_kunit.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * This module tests the blackhole_dev that is created during the
> + * This tests the blackhole_dev that is created during the
>   * net subsystem initialization. The test this module performs is
>   * by injecting an skb into the stack with skb->dev as the
>   * blackhole_dev and expects kernel to behave in a sane manner
> @@ -9,9 +9,8 @@
>   * Copyright (c) 2018, Mahesh Bandewar <maheshb@google.com>
>   */
>
> -#include <linux/init.h>
> +#include <kunit/test.h>
>  #include <linux/module.h>
> -#include <linux/printk.h>
>  #include <linux/skbuff.h>
>  #include <linux/netdevice.h>
>  #include <linux/udp.h>
> @@ -25,17 +24,15 @@
>
>  #define UDP_PORT 1234
>
> -static int __init test_blackholedev_init(void)
> +static void test_blackholedev(struct kunit *test)
>  {
>         struct ipv6hdr *ip6h;
>         struct sk_buff *skb;
>         struct udphdr *uh;
>         int data_len;
> -       int ret;
>
>         skb =3D alloc_skb(SKB_SIZE, GFP_KERNEL);
> -       if (!skb)
> -               return -ENOMEM;
> +       KUNIT_ASSERT_NOT_NULL(test, skb);
>
>         /* Reserve head-room for the headers */
>         skb_reserve(skb, HEAD_SIZE);
> @@ -55,7 +52,7 @@ static int __init test_blackholedev_init(void)
>         ip6h =3D (struct ipv6hdr *)skb_push(skb, sizeof(struct ipv6hdr));
>         skb_set_network_header(skb, 0);
>         ip6h->hop_limit =3D 32;
> -       ip6h->payload_len =3D data_len + sizeof(struct udphdr);
> +       ip6h->payload_len =3D htons(data_len + sizeof(struct udphdr));
>         ip6h->nexthdr =3D IPPROTO_UDP;
>         ip6h->saddr =3D in6addr_loopback;
>         ip6h->daddr =3D in6addr_loopback;
> @@ -68,32 +65,20 @@ static int __init test_blackholedev_init(void)
>         skb->dev =3D blackhole_netdev;
>
>         /* Now attempt to send the packet */
> -       ret =3D dev_queue_xmit(skb);
> -
> -       switch (ret) {
> -       case NET_XMIT_SUCCESS:
> -               pr_warn("dev_queue_xmit() returned NET_XMIT_SUCCESS\n");
> -               break;
> -       case NET_XMIT_DROP:
> -               pr_warn("dev_queue_xmit() returned NET_XMIT_DROP\n");
> -               break;
> -       case NET_XMIT_CN:
> -               pr_warn("dev_queue_xmit() returned NET_XMIT_CN\n");
> -               break;
> -       default:
> -               pr_err("dev_queue_xmit() returned UNKNOWN(%d)\n", ret);
> -       }
> -
> -       return 0;
> +       KUNIT_EXPECT_EQ(test, dev_queue_xmit(skb), NET_XMIT_SUCCESS);
>  }
>
> -static void __exit test_blackholedev_exit(void)
> -{
> -       pr_warn("test_blackholedev module terminating.\n");
> -}
> +static struct kunit_case blackholedev_cases[] =3D {
> +       KUNIT_CASE(test_blackholedev),
> +       {},
> +};
> +
> +static struct kunit_suite blackholedev_suite =3D {
> +       .name =3D "blackholedev",
> +       .test_cases =3D blackholedev_cases,
> +};
>
> -module_init(test_blackholedev_init);
> -module_exit(test_blackholedev_exit);
> +kunit_test_suite(blackholedev_suite);
>
>  MODULE_AUTHOR("Mahesh Bandewar <maheshb@google.com>");
>  MODULE_DESCRIPTION("module test of the blackhole_dev");
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftes=
ts/net/Makefile
> index 73ee88d6b043..afa4bcdc5833 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -7,7 +7,7 @@ CFLAGS +=3D -I../../../../usr/include/ $(KHDR_INCLUDES)
>  CFLAGS +=3D -I../
>
>  TEST_PROGS :=3D run_netsocktests run_afpackettests test_bpf.sh netdevice=
.sh \
> -             rtnetlink.sh xfrm_policy.sh test_blackhole_dev.sh
> +             rtnetlink.sh xfrm_policy.sh
>  TEST_PROGS +=3D fib_tests.sh fib-onlink-tests.sh pmtu.sh udpgso.sh ip_de=
frag.sh
>  TEST_PROGS +=3D udpgso_bench.sh fib_rule_tests.sh msg_zerocopy.sh psock_=
snd.sh
>  TEST_PROGS +=3D udpgro_bench.sh udpgro.sh test_vxlan_under_vrf.sh reusep=
ort_addr_any.sh
> diff --git a/tools/testing/selftests/net/test_blackhole_dev.sh b/tools/te=
sting/selftests/net/test_blackhole_dev.sh
> deleted file mode 100755
> index 3119b80e711f..000000000000
> --- a/tools/testing/selftests/net/test_blackhole_dev.sh
> +++ /dev/null
> @@ -1,11 +0,0 @@
> -#!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0
> -# Runs blackhole-dev test using blackhole-dev kernel module
> -
> -if /sbin/modprobe -q test_blackhole_dev ; then
> -       /sbin/modprobe -q -r test_blackhole_dev;
> -       echo "test_blackhole_dev: ok";
> -else
> -       echo "test_blackhole_dev: [FAIL]";
> -       exit 1;
> -fi
>
> ---
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> change-id: 20250207-blackholedev-kunit-convert-9a52a1a1a032
>
> Best regards,
> --
> Tamir Duberstein <tamird@gmail.com>

Adding David.

