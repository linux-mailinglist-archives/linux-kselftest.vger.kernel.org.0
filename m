Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9934DD400
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Mar 2022 05:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbiCREwA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Mar 2022 00:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbiCREwA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Mar 2022 00:52:00 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05E831934;
        Thu, 17 Mar 2022 21:50:40 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id q19so4272396pgm.6;
        Thu, 17 Mar 2022 21:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aPJHHquyjBnSufkdQ/CHMVfaCdWkcaHC/wocvUvtM2g=;
        b=L5+IUfXTkDjiK+ANw+KnlygW7x1M6zI1nZKYKG8jW93yJ0tEAcGlUx48T0NZ2sFz6L
         jDxT0gbkygNOOKK8Tc1gVyd6ymspz90eonQ6TBa9V4zx3wN+Dthk53JLZ74y06zljXlz
         VQaly16G1x2Hl2uxOXsUJUU7hVD2hrCLJkQ5fODbmlMU/PInY7mTYAZ8MO0ETg1B9dDH
         WSiG2J1HZzIXHJdqmFhD32TclV02lEfivp3bBcbXzPgM/zhTItKhadan3OnKhc2aVkzv
         lLkvJkBnbik5ttZL0XPEhbpaEruniAVu5asVUQ9WaWcY0DS/6zFjiyJDajkoueovd9i6
         hM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aPJHHquyjBnSufkdQ/CHMVfaCdWkcaHC/wocvUvtM2g=;
        b=4/fuLvu89KkL6d0wmYMQguq5HiFDNP3GlyDH54qP4WiQWFPiH7yP88pLRRKDDkbsZT
         gAJJW6rAiVP1tPvVf5YWGJtV0ynMBQ1g7V/3PNAO6wshj7xfSgKTy7kfT1J2s/rmmjo7
         5bYqkRUkvshOnqNVpxSsTXrotI/qBnwpWMyiI7g5/MGqlBpdTKxNZpE0gcwi+rmSseAx
         0GSrsMOyPPujCXbudWdFG4qVeom67aqGX+9jFfZLaUL2yuV5S0gjHOOPlxRNhAUjfWic
         VsCnV8RyDirKxmyyuFMcrgXTx+trp7nkqfRS/26hl2bTSH6yn0ezwBxBqZZaO94o6HXl
         cTEw==
X-Gm-Message-State: AOAM531bss81YfZ18v7m6Mu0eU4TaxKcYUZ6HhnKcjEgtyNjBTiQrXdM
        HMQShiuEx24hMvU8sWr6sMufA+zkWZAMGQ==
X-Google-Smtp-Source: ABdhPJzhxM+hugE7owmzEeU+bzQPYLXLvCW/ZmgFw14Vv0YIH0K1U6rFcf3IiYlZhsK58SGQHcP1rw==
X-Received: by 2002:a65:538f:0:b0:382:b4d:bdd8 with SMTP id x15-20020a65538f000000b003820b4dbdd8mr4457255pgq.262.1647579040371;
        Thu, 17 Mar 2022 21:50:40 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-92.three.co.id. [180.214.233.92])
        by smtp.gmail.com with ESMTPSA id u4-20020a056a00158400b004fa0263cf5dsm8788368pfk.130.2022.03.17.21.50.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 21:50:39 -0700 (PDT)
Message-ID: <07033c8a-fe1a-f97e-49b3-48d1da1e0413@gmail.com>
Date:   Fri, 18 Mar 2022 11:50:34 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] docs/kselftest: add more guidelines for adding new tests
Content-Language: en-US
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     kernel@collabora.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220317172758.582690-1-usama.anjum@collabora.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220317172758.582690-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 18/03/22 00.27, Muhammad Usama Anjum wrote:
> Add the following new guidelines:
> - Add instruction to use lib.mk
> - Add instruction about how to use headers from kernel source
> - Add instruction to add .gitignore file
> - Add instruction about how to add new test in selftests/Makefile
> - Add instruction about different build commands to test
> 

Too verbose, because people can figure out what were added in the diff
without explicitly mention them.
  
> + * Use lib.mk instead of writing Makefile from sratch. Specify flags and
> +   binaries generation flags on need basis before including lib.mk. ::
> +
> +    CFLAGS = $(KHDR_INCLUDES)
> +    TEST_GEN_PROGS := close_range_test
> +    include ../lib.mk
> +

I think what you mean is "In your Makefile, use facilities from lib.mk by
including it instead of reinventing the wheel.", right?

> + * Add new test name in TARGETS in selftests/Makefile::
> +
> +    TARGETS += android
> +
> + * All of the following build commands should be successful
> +
> +   - Same directory build of kselftests::
> +
> +      make kselftest-all
> +      make kselftest-install
> +      make kselftest-clean
> +      make kselftest-gen_tar
> +
> +   - Build with absolute output directory path::
> +
> +      make kselftest-all O=/abs_build_path
> +      make kselftest-install O=/abs_build_path
> +      make kselftest-clean O=/abs_build_path
> +      make kselftest-gen_tar O=/abs_build_path
> +
> +   - Build with relative output directory path::
> +
> +      make kselftest-all O=relative_path
> +      make kselftest-install O=relative_path
> +      make kselftest-clean O=relative_path
> +      make kselftest-gen_tar O=relative_path
> +
> +   - Build from Makefile of selftests directly::
> +
> +      make -C tools/testing/selftests
> +      make -C tools/testing/selftests O=/abs_build_path
> +      make -C tools/testing/selftests O=relative_path
> +

For simplicity, we can say "All changes should pass
kselftest-{all,install,clean,gen_tar} builds."

You don't need to spell out full command-line in the guideline unless
absolutely necessary, in general.

-- 
An old man doll... just what I always wanted! - Clara
