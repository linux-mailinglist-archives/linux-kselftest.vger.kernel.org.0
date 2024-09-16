Return-Path: <linux-kselftest+bounces-18040-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B9D97A5D9
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 18:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C7901C20B45
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 16:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A6C156F55;
	Mon, 16 Sep 2024 16:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EPl7aPcM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16694158553
	for <linux-kselftest@vger.kernel.org>; Mon, 16 Sep 2024 16:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726503590; cv=none; b=m3ivhyk0+Ev9GO48E0SZqvEaeMMA0HOCD3wwBpQJOaX/dd/8DCXhRSLNBcf8ZteFv+fCB3obovYjaPahbv2e9GV0UGWDupC3ncfrh/+vLPIQRDdAmrw3T8S6jQSWAjDz5SqLAJLEJf16OyI8DaNAferm4m3Tuf77ciD7agtbIm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726503590; c=relaxed/simple;
	bh=YvyNTLs4uMCK8KC6w9yv9ZBgOsXtl/+tB8wPhJZ/3n4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F7EIfoi/p/GzxVhOdaObxwnvtyqFB5bkAFYo8xaB1qET7S2dy7y02NlfU80pjyFTXP/MqkjbvsVrMeUZ5uxYoB63sZCvDM89Yx1rVYGW585lYd12BBbiYlhv+pa+TrrkpB0ZQjiDLX+3cgSoCDyeQFeLpcFMvwkUfTgsLWvK59k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EPl7aPcM; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5356aa9a0afso4628906e87.2
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Sep 2024 09:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726503586; x=1727108386; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TeHUY0PZItimrlsbwgBi3IPxzckdC8el2yYzdkC9Wig=;
        b=EPl7aPcMGmnl2kmTmaiGbd3SBpjftoIoZ91oK4zMjV7uvG1hblQSd0D6znV21h5QhC
         sQKB2/t9froL4yZTCd/eA9mnneeJtt5WOrhXi2Ev0tqGMBuX7+mZBdjVQN9r/uCP/MVQ
         dlpypcMQIxzUjGjMnfzEwkaZ1OdX7DHkNwrDIh/kYQqd2Gfy//x9reYCQYRMihe/t2r+
         tXVlVP9YQ3lvAUvw2QT/sW634GMh/bpXqKz3n07zR3ESbrDSc6zaH75FwvsI1pfjPKke
         j7u8CrrOYMaUnDS8w1eiMjVJTk2i4BTnE4lxqf6XikDIQKdKfiE9llKf2vwuJ4ap+FZ2
         cVRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726503586; x=1727108386;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TeHUY0PZItimrlsbwgBi3IPxzckdC8el2yYzdkC9Wig=;
        b=g3curxdKjxsx4Yb+LVPNRmuItWwLsAdIA1BnOyy4BfaT18AHqwIQh94BCoZwLLDUkr
         h/0xZfeEkKFtnElBnA0dZ0qFqLiSADqMIbxWEGGCXJSLO/60Dg1AZLL7eQTdnni0TISO
         tqK62JLvPiq0tTrCv5clSaCjeAiOJuEdZvWHjIHJ8BTJZl1QddZURRxs/SfeS7tMzCH5
         kwzvH3aeGKf8/Pz5HMHeuLjJ1A7pDcoByHtWVt7C4OKkf6/fVQy9leh7xZ+CbtirG9hB
         73W7Bp7FxsjSQMuC5RnrAPG5lcHYH9JAlVwLyEg5JY5E/SHPC0t2+F44XS9Aq6Yke4dD
         +7ug==
X-Forwarded-Encrypted: i=1; AJvYcCVvNZq/6YMNaMpqevF6KviLGTLNMWtL5iPJ+r570nH7TPzXyBVizZNKKXOuswH+BP9jbOnBeehoXFlcM282koE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk5vciytUEokBq6g1Qkb4oRP5eE7ulRhNJPvAj2T4b8I4NMF3c
	q1ZM3zQ+KMmIX5Z3iDxzM3Uiiy+UsgNJ4TFCr/g/e2Qv8BZcSBPaUBveprDruJg=
X-Google-Smtp-Source: AGHT+IH3a/tPPLSwoh0fht/6T3CHsO4QwSNvSbAcBQ9lu1ytAwT4uikLUdhzqRchn4HhnE3qeSuZiw==
X-Received: by 2002:a05:6512:3e06:b0:533:45c9:67fe with SMTP id 2adb3069b0e04-5367ff24c0bmr6614808e87.48.1726503585921;
        Mon, 16 Sep 2024 09:19:45 -0700 (PDT)
Received: from [192.168.3.3] (77.39.160.45.gramnet.com.br. [45.160.39.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612e67f3sm334742166b.185.2024.09.16.09.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 09:19:45 -0700 (PDT)
Message-ID: <9b1074fb1c9512e804d4484e12bc0d229865d02b.camel@suse.com>
Subject: Re: [PATCH] selftests: livepatch: test livepatching a kprobed
 function
From: mpdesouza@suse.com
To: Michael Vetter <mvetter@suse.com>, linux-kselftest@vger.kernel.org, 
	live-patching@vger.kernel.org
Date: Mon, 16 Sep 2024 13:19:40 -0300
In-Reply-To: <20240913125811.116410-1-mvetter@suse.com>
References: <20240913125811.116410-1-mvetter@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-09-13 at 14:58 +0200, Michael Vetter wrote:
> The test proves that a function that is being kprobed and uses a
> post_handler cannot be livepatched.
>=20
> Only one ftrace_ops with FTRACE_OPS_FL_IPMODIFY set may be registered
> to any given function at a time.

First of all, thanks a lot for sending the patch!

>=20
> Signed-off-by: Michael Vetter <mvetter@suse.com>
> ---
> =C2=A0tools/testing/selftests/livepatch/Makefile=C2=A0=C2=A0=C2=A0 |=C2=
=A0 3 +-
> =C2=A0.../selftests/livepatch/test-kprobe.sh=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 62
> +++++++++++++++++++
> =C2=A0.../selftests/livepatch/test_modules/Makefile |=C2=A0 3 +-
> =C2=A0.../livepatch/test_modules/test_klp_kprobe.c=C2=A0 | 38 +++++++++++=
+
> =C2=A04 files changed, 104 insertions(+), 2 deletions(-)
> =C2=A0create mode 100755 tools/testing/selftests/livepatch/test-kprobe.sh
> =C2=A0create mode 100644
> tools/testing/selftests/livepatch/test_modules/test_klp_kprobe.c
>=20
> diff --git a/tools/testing/selftests/livepatch/Makefile
> b/tools/testing/selftests/livepatch/Makefile
> index 35418a4790be..a080eb54a215 100644
> --- a/tools/testing/selftests/livepatch/Makefile
> +++ b/tools/testing/selftests/livepatch/Makefile
> @@ -10,7 +10,8 @@ TEST_PROGS :=3D \
> =C2=A0	test-state.sh \
> =C2=A0	test-ftrace.sh \
> =C2=A0	test-sysfs.sh \
> -	test-syscall.sh
> +	test-syscall.sh \
> +	test-kprobe.sh
> =C2=A0
> =C2=A0TEST_FILES :=3D settings
> =C2=A0
> diff --git a/tools/testing/selftests/livepatch/test-kprobe.sh
> b/tools/testing/selftests/livepatch/test-kprobe.sh
> new file mode 100755
> index 000000000000..0c62c6b81e18
> --- /dev/null
> +++ b/tools/testing/selftests/livepatch/test-kprobe.sh
> @@ -0,0 +1,62 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2024 SUSE
> +# Author: Michael Vetter <mvetter@suse.com>
> +
> +. $(dirname $0)/functions.sh
> +
> +MOD_LIVEPATCH=3Dtest_klp_livepatch
> +MOD_KPROBE=3Dtest_klp_kprobe
> +
> +setup_config
> +
> +# Kprobe a function and verify that we can't livepatch that same
> function
> +# when it uses a post_handler since only one IPMODIFY maybe be
> registered
> +# to any given function at a time.
> +
> +start_test "livepatch interaction with kprobed function with
> post_handler"
> +
> +echo 1 > /sys/kernel/debug/kprobes/enabled

I believe that in order to keep the system in the same as it was before
running the tests we might want to save the current kprobe enabled
state, enable it (what you are doing) and then restoring to the initial
state.

Everything else is fine, thank you so much!

With this fixed,

Reviewed-by: Marcos Paulo de Souza <mpdesouza@suse.com>

> +
> +load_mod $MOD_KPROBE has_post_handler=3Dtrue
> +load_failing_mod $MOD_LIVEPATCH
> +unload_mod $MOD_KPROBE
> +
> +check_result "% insmod test_modules/test_klp_kprobe.ko
> has_post_handler=3Dtrue
> +% insmod test_modules/$MOD_LIVEPATCH.ko
> +livepatch: enabling patch '$MOD_LIVEPATCH'
> +livepatch: '$MOD_LIVEPATCH': initializing patching transition
> +livepatch: failed to register ftrace handler for function
> 'cmdline_proc_show' (-16)
> +livepatch: failed to patch object 'vmlinux'
> +livepatch: failed to enable patch '$MOD_LIVEPATCH'
> +livepatch: '$MOD_LIVEPATCH': canceling patching transition, going to
> unpatch
> +livepatch: '$MOD_LIVEPATCH': completing unpatching transition
> +livepatch: '$MOD_LIVEPATCH': unpatching complete
> +insmod: ERROR: could not insert module
> test_modules/$MOD_LIVEPATCH.ko: Device or resource busy
> +% rmmod test_klp_kprobe"
> +
> +start_test "livepatch interaction with kprobed function without
> post_handler"
> +
> +load_mod $MOD_KPROBE has_post_handler=3Dfalse
> +load_lp $MOD_LIVEPATCH
> +
> +unload_mod $MOD_KPROBE
> +disable_lp $MOD_LIVEPATCH
> +unload_lp $MOD_LIVEPATCH
> +
> +check_result "% insmod test_modules/test_klp_kprobe.ko
> has_post_handler=3Dfalse
> +% insmod test_modules/$MOD_LIVEPATCH.ko
> +livepatch: enabling patch '$MOD_LIVEPATCH'
> +livepatch: '$MOD_LIVEPATCH': initializing patching transition
> +livepatch: '$MOD_LIVEPATCH': starting patching transition
> +livepatch: '$MOD_LIVEPATCH': completing patching transition
> +livepatch: '$MOD_LIVEPATCH': patching complete
> +% rmmod test_klp_kprobe
> +% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
> +livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
> +livepatch: '$MOD_LIVEPATCH': starting unpatching transition
> +livepatch: '$MOD_LIVEPATCH': completing unpatching transition
> +livepatch: '$MOD_LIVEPATCH': unpatching complete
> +% rmmod $MOD_LIVEPATCH"
> +
> +exit 0
> diff --git a/tools/testing/selftests/livepatch/test_modules/Makefile
> b/tools/testing/selftests/livepatch/test_modules/Makefile
> index e6e638c4bcba..4981d270f128 100644
> --- a/tools/testing/selftests/livepatch/test_modules/Makefile
> +++ b/tools/testing/selftests/livepatch/test_modules/Makefile
> @@ -11,7 +11,8 @@ obj-m +=3D test_klp_atomic_replace.o \
> =C2=A0	test_klp_state2.o \
> =C2=A0	test_klp_state3.o \
> =C2=A0	test_klp_shadow_vars.o \
> -	test_klp_syscall.o
> +	test_klp_syscall.o \
> +	test_klp_kprobe.o
> =C2=A0
> =C2=A0# Ensure that KDIR exists, otherwise skip the compilation
> =C2=A0modules:
> diff --git
> a/tools/testing/selftests/livepatch/test_modules/test_klp_kprobe.c
> b/tools/testing/selftests/livepatch/test_modules/test_klp_kprobe.c
> new file mode 100644
> index 000000000000..49b579ea1054
> --- /dev/null
> +++
> b/tools/testing/selftests/livepatch/test_modules/test_klp_kprobe.c
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2024 Marcos Paulo de Souza <mpdesouza@suse.com>
> +// Copyright (C) 2024 Michael Vetter <mvetter@suse.com>
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/kprobes.h>
> +
> +static bool has_post_handler =3D true;
> +module_param(has_post_handler, bool, 0444);
> +
> +static void __kprobes post_handler(struct kprobe *p, struct pt_regs
> *regs,
> +				unsigned long flags)
> +{
> +}
> +
> +static struct kprobe kp =3D {
> +	.symbol_name =3D "cmdline_proc_show",
> +};
> +
> +static int __init kprobe_init(void)
> +{
> +	if (has_post_handler)
> +		kp.post_handler =3D post_handler;
> +
> +	return register_kprobe(&kp);
> +}
> +
> +static void __exit kprobe_exit(void)
> +{
> +	unregister_kprobe(&kp);
> +}
> +
> +module_init(kprobe_init)
> +module_exit(kprobe_exit)
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Michael Vetter <mvetter@suse.com>");
> +MODULE_DESCRIPTION("Livepatch test: livepatch kprobed function");


