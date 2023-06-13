Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CA472DC20
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jun 2023 10:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238447AbjFMIQX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Jun 2023 04:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237456AbjFMIQW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Jun 2023 04:16:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D60E4E;
        Tue, 13 Jun 2023 01:16:20 -0700 (PDT)
Received: from [192.168.10.54] (unknown [119.155.33.163])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1ABF86606ED2;
        Tue, 13 Jun 2023 09:16:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686644179;
        bh=23nB+nTv3KCcOlVRmQT97LpYYVvrc8jbpP9qb6C81us=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=hO7vn83iGsoPMQ+DTS+RAHvOkpTsmthC2Fn31D1IGPll3ujIv2OV3ql9BpdJ9se3J
         c2JoYUPtlplbg6zGgNkSckcSca3gJcYH4nkTBOYB24ztZW2fm9/sisbUaZ4UXXM3Ow
         DIr4yW7vRnLJyYPZbKNnb7Kj8cYFEaAqj5KjluL3t6oOv/LOi36zcaqp4fwY5bTMK0
         EfPxd54u8W0lVHPsoGSXJsuRqU1pUhRQQcb7svcuU3Bf2GAFdRzLWZD3TbSRxCVekB
         jF3u4UxoHawFeKq3O+J9K8Jnk7gSJXUXTgVBskfxnJLIj44g0Mr7luT0BkaFUMJiqN
         /5fb555dPbQEg==
Message-ID: <cf6eb3f1-276a-bdcc-7d63-7f4ab3f9cdce@collabora.com>
Date:   Tue, 13 Jun 2023 13:16:12 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhubbard@nvidia.com
Subject: Re: [PATCH] selftests: lib.mk: fix out-of-tree builds
Content-Language: en-US
To:     Anders Roxell <anders.roxell@linaro.org>, shuah@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list : MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>
References: <20230613074931.666966-1-anders.roxell@linaro.org>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20230613074931.666966-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch needs to go through mm tree as the commit which it fixes is in mm.

On 6/13/23 12:49 PM, Anders Roxell wrote:
> Since commit ("selftests: error out if kernel header files are not yet
> built") got merged, the kselftest build correctly because the
> KBUILD_OUTPUT isn't set when building out-of-tree and specifying 'O='
> This is the error message that pops up.
> 
> make --silent --keep-going --jobs=32 O=/home/anders/.cache/tuxmake/builds/1482/build INSTALL_PATH=/home/anders/.cache/tuxmake/builds/1482/build/kselftest_install ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- V=1 CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- kselftest-install
> make[3]: Entering directory '/home/anders/src/kernel/next/tools/testing/selftests/alsa'
> 
> -e [1;31merror[0m: missing kernel header files.
> Please run this and try again:
> 
>     cd /home/anders/src/kernel/next/tools/testing/selftests/../../..
>     make headers
> 
> make[3]: Leaving directory '/home/anders/src/kernel/next/tools/testing/selftests/alsa'
> make[3]: *** [../lib.mk:77: kernel_header_files] Error 1
> 
> Fixing the issue by assigning KBUILD_OUTPUT the same way how its done in
> kselftest's Makefile. By adding 'KBUILD_OUTPUT := $(O)' 'if $(origin O)'
> is set to 'command line'. This will set the the BUILD dir to
> KBUILD_OUTPUT/kselftest when doing out-of-tree builds which makes them
> in its own separete output directory.
> 
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Please add fixes tag. ("selftests: error out if kernel header files are not
yet built")

Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/lib.mk | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index b8ea03b9a015..d17854285f2b 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -44,6 +44,10 @@ endif
>  selfdir = $(realpath $(dir $(filter %/lib.mk,$(MAKEFILE_LIST))))
>  top_srcdir = $(selfdir)/../../..
>  
> +ifeq ("$(origin O)", "command line")
> +  KBUILD_OUTPUT := $(O)
> +endif
> +
>  ifneq ($(KBUILD_OUTPUT),)
>    # Make's built-in functions such as $(abspath ...), $(realpath ...) cannot
>    # expand a shell special character '~'. We use a somewhat tedious way here.

-- 
BR,
Muhammad Usama Anjum
