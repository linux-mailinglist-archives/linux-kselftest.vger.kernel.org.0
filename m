Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210A663CA91
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Nov 2022 22:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236361AbiK2Vp2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Nov 2022 16:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233312AbiK2Vp1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Nov 2022 16:45:27 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E022B26E
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Nov 2022 13:45:25 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id p193so939176iod.6
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Nov 2022 13:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tL0jBoZ68wOuymTPlZ1IsGpQ4OkLFUq6glJ5F26fyto=;
        b=P+BsYYU9L8jc2+iZ7bsg+CRAOVP+YxlZgbfG+ckOTS5BLkB3/FMtqdoymusRqHtJyV
         4PCikHlD96Cem4VVBlIDaxwzAaTzeW0Zly/NVYWxB+cr8mPGf82O7K1tiWreTdKufP05
         Dhn+7Y/1WSOMB5zZCYtdvBt4dw+RRcB/yCyAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tL0jBoZ68wOuymTPlZ1IsGpQ4OkLFUq6glJ5F26fyto=;
        b=iU0XVhZw4fw8aKStnoSccZT6TiCDEdxLSsQIsRKMVx+VxaZ3y+q3KtP2fdE0aS9a68
         58j/C6t2VYsArjw0jTA4vXnctCwgJxGjw7hzb7yJevxRqYwVGDEhLmNmnyzqa9M74EOm
         5iuaVdHBcG3RjcSLoEq5F6MBx9rXpQjJgdLVG3BSQDg2NoSg5RUA/zjVRHUaAjjzuUwZ
         vTk5xYGxXc2Ay9mKhv3dw84uozSusi29ENGZC9nYQkER7Y4sGnoedDiWVe35vZZxrTsm
         ybniakMODmgu2o9DyTtomTbjhsdqeB1S939vXkS1vDHR6efm3rHeQfvAokBtmTCzwxYC
         cL4g==
X-Gm-Message-State: ANoB5plk9wrhdafKsC7BpHPuPbEbjK/V302oHhkKJOFK0vcBEtqI8x/d
        MhOnnQdLS0BDD/vGDqOEK1bLQql7O0rpgQ==
X-Google-Smtp-Source: AA0mqf6m73622bv1+JBh0FmfsWTMka4QhacodmL8HPMTHwXyGZN4mmZxQj3L1HQFsRQQPgjWHVR/Iw==
X-Received: by 2002:a5e:c809:0:b0:6cf:8cf0:91ac with SMTP id y9-20020a5ec809000000b006cf8cf091acmr17911334iol.186.1669758325063;
        Tue, 29 Nov 2022 13:45:25 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id t8-20020a025408000000b0038a01eba60fsm44504jaa.69.2022.11.29.13.45.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 13:45:24 -0800 (PST)
Message-ID: <af72853d-d326-832e-247a-2397e83fa08e@linuxfoundation.org>
Date:   Tue, 29 Nov 2022 14:45:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] selftests/tpm2: Split async tests call to separate shell
 script runner
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Shuah Khan <shuah@kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221128220340.536558-1-nfraprado@collabora.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221128220340.536558-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/28/22 15:03, Nícolas F. R. A. Prado wrote:
> When the async test case was introduced, despite being a completely
> independent test case, the command to run it was added to the same shell
> script as the smoke test case. Since a shell script implicitly returns
> the error code from the last run command, this effectively caused the
> script to only return as error code the result from the async test case,
> hiding the smoke test result (which could then only be seen from the
> python unittest logs).
> 
> Move the async test case call to its own shell script runner to avoid
> the aforementioned issue. This also makes the output clearer to read,
> since each kselftest KTAP result now matches with one python unittest
> report.
> 
> While at it, also make it so the async test case is skipped if
> /dev/tpmrm0 doesn't exist, since commit 8335adb8f9d3 ("selftests: tpm:
> add async space test with noneexisting handle") added a test that relies
> on it.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> ---
> 
>   tools/testing/selftests/tpm2/Makefile      |  2 +-
>   tools/testing/selftests/tpm2/test_async.sh | 10 ++++++++++
>   tools/testing/selftests/tpm2/test_smoke.sh |  1 -
>   3 files changed, 11 insertions(+), 2 deletions(-)
>   create mode 100755 tools/testing/selftests/tpm2/test_async.sh
> 
> diff --git a/tools/testing/selftests/tpm2/Makefile b/tools/testing/selftests/tpm2/Makefile
> index 1a5db1eb8ed5..a9bf9459fb25 100644
> --- a/tools/testing/selftests/tpm2/Makefile
> +++ b/tools/testing/selftests/tpm2/Makefile
> @@ -1,5 +1,5 @@
>   # SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
>   include ../lib.mk
>   
> -TEST_PROGS := test_smoke.sh test_space.sh
> +TEST_PROGS := test_smoke.sh test_space.sh test_async.sh
>   TEST_PROGS_EXTENDED := tpm2.py tpm2_tests.py
> diff --git a/tools/testing/selftests/tpm2/test_async.sh b/tools/testing/selftests/tpm2/test_async.sh
> new file mode 100755
> index 000000000000..43bf5bd772fd
> --- /dev/null
> +++ b/tools/testing/selftests/tpm2/test_async.sh
> @@ -0,0 +1,10 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> +
> +# Kselftest framework requirement - SKIP code is 4.
> +ksft_skip=4
> +
> +[ -e /dev/tpm0 ] || exit $ksft_skip
> +[ -e /dev/tpmrm0 ] || exit $ksft_skip
> +
> +python3 -m unittest -v tpm2_tests.AsyncTest
> diff --git a/tools/testing/selftests/tpm2/test_smoke.sh b/tools/testing/selftests/tpm2/test_smoke.sh
> index 3e5ff29ee1dd..58af963e5b55 100755
> --- a/tools/testing/selftests/tpm2/test_smoke.sh
> +++ b/tools/testing/selftests/tpm2/test_smoke.sh
> @@ -7,4 +7,3 @@ ksft_skip=4
>   [ -e /dev/tpm0 ] || exit $ksft_skip
>   
>   python3 -m unittest -v tpm2_tests.SmokeTest
> -python3 -m unittest -v tpm2_tests.AsyncTest

Thank you for fixing the problem. Applied to linux-kselftest next
for Linux 6.2-rc1

thanks,
-- Shuah
