Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF302727A1D
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jun 2023 10:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234602AbjFHIjX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jun 2023 04:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbjFHIjW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jun 2023 04:39:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23F926B8;
        Thu,  8 Jun 2023 01:39:20 -0700 (PDT)
Received: from [192.168.10.48] (unknown [119.152.150.198])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1F54F6605733;
        Thu,  8 Jun 2023 09:39:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686213559;
        bh=PRBO+SGpGVNVyEZwkfuIfWdn28x8QrprhmLGoj83lEI=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=knWIgt8GxFoafW6fQ7Gl2m9yA19hEzmpTCohAkDxUxO3y4WLgFJok0+mq5Vj5hpkT
         Zz2M5hRNHViLxADau0oS5yIiFUtDREYVj+w6KTHJMWyPw6sB2KG4c0gWpi+551QzWU
         /fh5Zlgpkak976cefjfBisBG84cXboeSJtp32WppNWYfBBRMy7irzJsZfb521evnl4
         5655kYkjZBu2Mh9X2GhtxItA8AsB6QLA9uoMqjkaxT44XKsLvXqZd8U2qUflTw7nQo
         vbh7hEzc1vjwnccGviigLcrl0aczTRwpKqBTYGckmZqzf3hREvD7SrjWr9KejJpitc
         g7mZOGyHDvM4w==
Message-ID: <11b94ce7-d7e3-1935-307b-5a0a0f32739f@collabora.com>
Date:   Thu, 8 Jun 2023 13:39:11 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: selftests: -e error: missing kernel header files. Please run this
 and try again
Content-Language: en-US
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org
References: <CA+G9fYueMV2gFF0sYR4Lf3btcEoxMpOy0_YvpjvS26WFZ2pcBA@mail.gmail.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CA+G9fYueMV2gFF0sYR4Lf3btcEoxMpOy0_YvpjvS26WFZ2pcBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/8/23 1:21 PM, Naresh Kamboju wrote:
> The make kselftest-install failed on Linux next 20230608.
> 
> make --silent --keep-going --jobs=8
> O=/home/tuxbuild/.cache/tuxmake/builds/1/build
> INSTALL_PATH=/home/tuxbuild/.cache/tuxmake/builds/1/build/kselftest_install
> ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- 'HOSTCC=sccache clang'
> 'CC=sccache clang' LLVM=1 LLVM_IAS=1 kselftest-install
Around 6-8 months ago, selftests used to build kernel headers from the
source tree automatically and were using those to build all applications.
But this behavior got changed where user need to build header manually
first before building kselftest because auto header build was in-consistent
in some cases.

So from several months people, who were unaware of this are building
kselftests with installed kernel headers in their distro. This was creating
failure for some newer tests for people. They didn't know that selftests
are supposed to build with kernel headers from source instead from locally
installed headers in distro. So a patch has been introduced which spits
error if kernel headers aren't built already:
https://lore.kernel.org/all/20230606071637.267103-12-jhubbard@nvidia.com

To fix things for your case, please build kernel headers by `make headers
...` and then build kselftests. The error is trying to say the same thing.

> 
> make[3]: Entering directory '/builds/linux/tools/testing/selftests/alsa'
> 
> -e error: missing kernel header files.
> Please run this and try again:
> 
>     cd /builds/linux/tools/testing/selftests/../../..
>     make headers
> 
> make[3]: Leaving directory '/builds/linux/tools/testing/selftests/alsa'
> make[3]: *** [../lib.mk:77: kernel_header_files] Error 1
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Links,
> ===
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2QsWmEgSFF9iwodTUrWsdopV4Qp/
> 
> --
> Linaro LKFT
> https://lkft.linaro.org

-- 
BR,
Muhammad Usama Anjum
