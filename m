Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC86C53FF95
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jun 2022 14:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244352AbiFGM7h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Jun 2022 08:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244341AbiFGM7g (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Jun 2022 08:59:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC958A07D;
        Tue,  7 Jun 2022 05:59:35 -0700 (PDT)
Received: from [192.168.10.2] (unknown [39.45.211.232])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EAECB6601A93;
        Tue,  7 Jun 2022 13:59:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654606774;
        bh=QEuHwxJN6odW1g5krFZeQvoskzQhnvkfJZhXm3QQ7hk=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=Wnreb7Vt0UfkowMpVzJX44PRp7et4qVMYEC774vdMH2+S5q9cIb+SL+S+wTm3FdCn
         Dplll3g9VRylAoiNYTCe+1cOA+TbaDM2V72XBpxx9qRWe38p+y+vaaNzNQPT1PlXUn
         GhIw7LJ7ib9IkVZNYDsilKwMjx2qSgNU9R4n8uV466lFS8l7tu0mxo4ROtiJWcHWne
         f+mZwDYOXWlGh8ACAIh3LIvt7oYi97y5rLsDbr5fBaoQ4gz6kfihuEKsngUiZEcIy4
         nuU8ZeEln3co52oGHiuorhM4+EQWXkmiFME/wh5hQ8qxVZ+ULcxw3nAcCK9jZIYHJ4
         4RaHbM9QUl1MA==
Message-ID: <e01f90a0-a3c7-c5fd-ae1f-197c6fec525e@collabora.com>
Date:   Tue, 7 Jun 2022 17:59:28 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Cc:     usama.anjum@collabora.com, kernel@collabora.com,
        bagasdotme@gmail.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs/kselftest: add more guidelines for adding new
 tests
Content-Language: en-US
To:     Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
References: <20220521073651.4191910-1-usama.anjum@collabora.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20220521073651.4191910-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Reminder!

On 5/21/22 12:36 PM, Muhammad Usama Anjum wrote:
> Improve and add instructions to add new tests. Add build commands to
> test before sending the new test patch.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes in v2:
> - Updated commit message
> - Removed dependence of this patch from other patch
> - Updated instructions
> ---
>  Documentation/dev-tools/kselftest.rst | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
> index a833ecf12fbc1..ee6467ca8293f 100644
> --- a/Documentation/dev-tools/kselftest.rst
> +++ b/Documentation/dev-tools/kselftest.rst
> @@ -208,6 +208,14 @@ In general, the rules for selftests are
>  Contributing new tests (details)
>  ================================
>  
> + * In your Makefile, use facilities from lib.mk by including it instead of
> +   reinventing the wheel. Specify flags and binaries generation flags on
> +   need basis before including lib.mk. ::
> +
> +    CFLAGS = $(KHDR_INCLUDES)
> +    TEST_GEN_PROGS := close_range_test
> +    include ../lib.mk
> +
>   * Use TEST_GEN_XXX if such binaries or files are generated during
>     compiling.
>  
> @@ -230,13 +238,30 @@ Contributing new tests (details)
>   * First use the headers inside the kernel source and/or git repo, and then the
>     system headers.  Headers for the kernel release as opposed to headers
>     installed by the distro on the system should be the primary focus to be able
> -   to find regressions.
> +   to find regressions. Use KHDR_INCLUDES in Makefile to include headers from
> +   the kernel source.
>  
>   * If a test needs specific kernel config options enabled, add a config file in
>     the test directory to enable them.
>  
>     e.g: tools/testing/selftests/android/config
>  
> + * Create a .gitignore file inside test directory and add all generated objects
> +   in it.
> +
> + * Add new test name in TARGETS in selftests/Makefile::
> +
> +    TARGETS += android
> +
> + * All changes should pass::
> +
> +    kselftest-{all,install,clean,gen_tar}
> +    kselftest-{all,install,clean,gen_tar} O=abo_path
> +    kselftest-{all,install,clean,gen_tar} O=rel_path
> +    make -C tools/testing/selftests {all,install,clean,gen_tar}
> +    make -C tools/testing/selftests {all,install,clean,gen_tar} O=abs_path
> +    make -C tools/testing/selftests {all,install,clean,gen_tar} O=rel_path
> +
>  Test Module
>  ===========
>  

-- 
Muhammad Usama Anjum
