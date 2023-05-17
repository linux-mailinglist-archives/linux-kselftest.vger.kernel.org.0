Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64C670650B
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 12:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjEQKX4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 06:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjEQKX4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 06:23:56 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54955468B
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 03:23:54 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2ac8cc8829fso5113231fa.3
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 03:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684319032; x=1686911032;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yIQ6fYa21+cYzYn2iIYkZmNTKAXcbkhKtUB0hi/hAdM=;
        b=z8tNnVb0tGU2l0Jtnuu5+zhhobHx8ULzKRa/7Qf25jLfsRLzy8n2wpzbkuWx5A6yjI
         fbz9B5n+xBgnKj06d6EFZ0iaQMHwd+/73hW46dEPxKFMsH5x2djnDaHIn3R7ROVASwv0
         YTSrN+jT5mjJuQZ1LnbbxXwCZOFIeruwbAgQPwkK/v6Ya5naJLHMAKmYIaFqW0vYLVX9
         rdXiN73oVuXFLGFS4tjUmmbIXsS99pdf86r4M3B0XEuqOjSPjKaE6tzQuwMT+xsXdY8a
         z6YeTQjEubUcTxCsYvIHP8fJLhw/a+scsMUEH0aApI6sM3+dR1rs5y2Ua8XFFKJztGJU
         2WJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684319032; x=1686911032;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yIQ6fYa21+cYzYn2iIYkZmNTKAXcbkhKtUB0hi/hAdM=;
        b=bxwW4nUvFXVa5HNZyXYQW9x2YIfbQ841RI9GyIHvFXIqn3DBvURjmTlx7m66LNlSzW
         s6fqrlIH2e+uSa5F+G6BUML4QvkNAqm1P3hezC+KiFb68w2gYsnVMyoE020RZ5Gs85JS
         pc8qny39dBn6S7XR3p43kUv27m2Wv60ly3/emfmbzUWbbnmDZNh3TuBBlIqrLgtOLXyl
         bg9Tq3aEgNDCPQ0KTWx/3PAC/B3Q16I3XuEJTDNVV2TxohE8qgRzMz8kTbSB2J6KLka8
         cDIHR8TULp1I6eFXjvFZICQjrAu81GhpOV6I8s6PwLUzUucQTm0pi1Gb6P52IdRETq3L
         1JvA==
X-Gm-Message-State: AC+VfDwkh93bkWZGLBc7ZTw3kpdrkY8Wkf6IhWanrpjmUPfuGoLXb7sq
        Sxr/Vsppv6zKJFX7ORJG1gozRw==
X-Google-Smtp-Source: ACHHUZ6cJ84AMP6d+bFEcZ3qOrqmYqxL2qtawFhKOIjNP4FnK6kWS8lYYAtNvC4/lqH03lT7tLb/Yg==
X-Received: by 2002:a05:6512:48f:b0:4f3:9a2c:589e with SMTP id v15-20020a056512048f00b004f39a2c589emr93715lfq.24.1684319032486;
        Wed, 17 May 2023 03:23:52 -0700 (PDT)
Received: from mutt (c-9b0ee555.07-21-73746f28.bbcust.telenor.se. [85.229.14.155])
        by smtp.gmail.com with ESMTPSA id t13-20020a2e780d000000b002a8ae16ac8csm3768052ljc.18.2023.05.17.03.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 03:23:51 -0700 (PDT)
Date:   Wed, 17 May 2023 12:23:50 +0200
From:   Anders Roxell <anders.roxell@linaro.org>
To:     Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        kernel@collabora.com, naresh.kamboju@linaro.org,
        dan.carpenter@linaro.org
Subject: Re: [PATCH] selftests/mincore: fix skip condition for
 check_huge_pages test
Message-ID: <20230517102350.GB411@mutt>
References: <20230515132643.119809-1-ricardo.canuelo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230515132643.119809-1-ricardo.canuelo@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-05-15 15:26, Ricardo Cañuelo wrote:
> The check_huge_pages test was failing instead of skipping on qemu-armv7
> because the skip condition wasn't handled properly. Add an additional
> check to fix it.
> 
> Signed-off-by: Ricardo Cañuelo <ricardo.canuelo@collabora.com>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/all/CA+G9fYuoB8Ug8PcTU-YGmemL7_eeEksXFihvxWF6OikD7sK7pA@mail.gmail.com

Tested-by: Anders Roxell <anders.roxell@linaro.org>

This is how I tested it on Linux next tag: next-20230516. Installed
tuxmake [1], and tuxrun [2].

$ tuxmake --runtime podman --target-arch arm --toolchain gcc-12 \
 --kconfig defconfig \
 --kconfig-add https://raw.githubusercontent.com/Linaro/meta-lkft/kirkstone/meta/recipes-kernel/linux/files/lkft.config \
 --kconfig-add https://raw.githubusercontent.com/Linaro/meta-lkft/kirkstone/meta/recipes-kernel/linux/files/systemd.config \
 --kconfig-add CONFIG_ARM_TI_CPUFREQ=y --kconfig-add CONFIG_SERIAL_8250_OMAP=y --kconfig-add CONFIG_POSIX_MQUEUE=y \
 --kconfig-add CONFIG_OF=y --kconfig-add CONFIG_SYN_COOKIES=y--kconfig-add CONFIG_SCHEDSTATS=y --kconfig-add CONFIG_AHCI_DWC=y \
 dtbs dtbs-legacy headers kernel kselftest modules \
 --results-hook "tuxrun --runtime podman --device qemu-armv7 --boot-args rw --tuxmake ./ --rootfs https://storage.tuxboot.com/debian/bookworm/armhf/rootfs.ext4.xz --parameters SKIPFILE=skipfile-lkft.yaml --parameters KSELFTEST='\$BUILD'/kselftest.tar.xz --tests kselftest-mincore --timeouts boot=30"

Cheers,
Anders
[1] https://tuxmake.org/
[2] https://tuxrun.org/

> ---
>  tools/testing/selftests/mincore/mincore_selftest.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/mincore/mincore_selftest.c b/tools/testing/selftests/mincore/mincore_selftest.c
> index 4c88238fc8f0..6fb3eea5b6ee 100644
> --- a/tools/testing/selftests/mincore/mincore_selftest.c
> +++ b/tools/testing/selftests/mincore/mincore_selftest.c
> @@ -150,8 +149,8 @@ TEST(check_huge_pages)
>  		MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB,
>  		-1, 0);
>  	if (addr == MAP_FAILED) {
> -		if (errno == ENOMEM)
> -			SKIP(return, "No huge pages available.");
> +		if (errno == ENOMEM || errno == EINVAL)
> +			SKIP(return, "No huge pages available or CONFIG_HUGETLB_PAGE disabled.");
>  		else
>  			TH_LOG("mmap error: %s", strerror(errno));
>  	}
> -- 
> 2.25.1
> 

-- 
Anders Roxell
anders.roxell@linaro.org
M: +46 708 22 71 05 | IRC: roxell
