Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64EFF724D3A
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 21:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjFFTjq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 15:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234006AbjFFTje (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 15:39:34 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1E110EA
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Jun 2023 12:39:32 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-77a1a5c98e1so4268539f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Jun 2023 12:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1686080372; x=1688672372;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bchEnBbzFEQ715Mm1+e6mTqO4zV/mMGdnFuk7zRzgTk=;
        b=NQLjeQ7GvFieMLE4xVj7sBdkTcKdCB9tsgBg4N9XYBrFgf0Z7qrNuGyvtZkA+BjXrZ
         5uq5Jy2+oVpzn9eoiWu5D5FyPVYPTh3ipZ/jf2EDIiFB6faO1IK2B0UDOhoO5wGouoYv
         aAcYifCJnQoaK8bjsa/X7IFm8BZFNMLI5vUHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686080372; x=1688672372;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bchEnBbzFEQ715Mm1+e6mTqO4zV/mMGdnFuk7zRzgTk=;
        b=CDgVgCVgM55+qkBQx4qs8I6Mvx1z3vm6cqDoW41lQ03u6lFKlswcjPhPK2xvrnwx7p
         K73KByD9NP1qzbNfdeGqdOZpdRtmdD9Nd1L7tiJBTRVmL/SnTGH3uNq4s+iWZS+UZKvg
         mOEiB4MkebrB6Q2AN7FUdAoMqkiiorRiPdQi5gNy8jhI19McNY/fwQMVSNnqxL50Q/r/
         7iMBJvbDhuvSVuWsW2bnIFgQFSKdtcXM2a2IihbgQsGn8bIFsOi1hnWj+EGN4WmbZdiK
         q/iFH+1Kt7cKyoP//yzzmeqz9GhroJ04UgnqfVo6pV10bSEGzZGSUw20nprN9WxaKjKL
         DCoQ==
X-Gm-Message-State: AC+VfDyYrIBbkSREyFzVb3z7JntF6Ta1Hx0nBMLxkBr5V6+ev35xPRcs
        2ajQ+TXKBjacheRUt2F6aR5j7g==
X-Google-Smtp-Source: ACHHUZ4fm1hlUrAtwDI6ZLu+qeUfIJuXfPPOCsRO0UOH0yDoBzq37HoVLoSrYvi3SpOIiRRZPHMYYQ==
X-Received: by 2002:a05:6602:2d96:b0:777:b51c:6058 with SMTP id k22-20020a0566022d9600b00777b51c6058mr2582851iow.2.1686080372192;
        Tue, 06 Jun 2023 12:39:32 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id h15-20020a02c4cf000000b0040fae3b49e5sm3083987jaj.124.2023.06.06.12.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 12:39:31 -0700 (PDT)
Message-ID: <1514ff05-9049-25d7-77cb-04db04e441b0@linuxfoundation.org>
Date:   Tue, 6 Jun 2023 13:39:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] selftests: prctl: Add new prctl test for PR_SET_NAME
Content-Language: en-US
To:     Osama Muhammad <osmtendev@gmail.com>, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        ivan.orlov0322@gmail.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20230606175515.12855-1-osmtendev@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230606175515.12855-1-osmtendev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/6/23 11:55, Osama Muhammad wrote:
> This patch will add the new test, which covers the prctl call
> PR_SET_NAME command. The test tries to give a name using the PR_SET_NAME
> call and then confirm it that it changed correctly by using  PR_GET_NAME.
> It also tries to rename it with empty name.In the test PR_GET_NAME is
> tested by passing null pointer to it and check its behaviour.
> 
> Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
> ---
>   tools/testing/selftests/prctl/Makefile        |  2 +-
>   .../selftests/prctl/set-process-name.c        | 61 +++++++++++++++++++
>   2 files changed, 62 insertions(+), 1 deletion(-)
>   create mode 100644 tools/testing/selftests/prctl/set-process-name.c
> 
> diff --git a/tools/testing/selftests/prctl/Makefile b/tools/testing/selftests/prctl/Makefile
> index c058b81ee..cfc35d29f 100644
> --- a/tools/testing/selftests/prctl/Makefile
> +++ b/tools/testing/selftests/prctl/Makefile
> @@ -5,7 +5,7 @@ ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
>   
>   ifeq ($(ARCH),x86)
>   TEST_PROGS := disable-tsc-ctxt-sw-stress-test disable-tsc-on-off-stress-test \
> -		disable-tsc-test set-anon-vma-name-test
> +		disable-tsc-test set-anon-vma-name-test set-process-name
>   all: $(TEST_PROGS)
>   
>   include ../lib.mk
> diff --git a/tools/testing/selftests/prctl/set-process-name.c b/tools/testing/selftests/prctl/set-process-name.c
> new file mode 100644
> index 000000000..12c5ed9a5
> --- /dev/null
> +++ b/tools/testing/selftests/prctl/set-process-name.c
> @@ -0,0 +1,61 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * This test covers the PR_SET_NAME functionality of prctl calls
> + */
> +
> +#include <errno.h>
> +#include <sys/prctl.h>
> +#include <string.h>
> +
> +#include "../kselftest_harness.h"
> +
> +#define CHANGE_NAME "changename"
> +#define EMPTY_NAME ""
> +
> +int set_name(char *name)
> +{
> +	int res;
> +
> +	res = prctl(PR_SET_NAME, name, NULL, NULL, NULL);
> +
> +	if (res < 0)
> +		return -errno;
> +	return res;
> +}
> +
> +int check_is_name_correct(char *check_name)
> +{
> +	char name[16];

Use TASK_COMM_LEN here instead of 16.

> +	int res;
> +
> +	res = prctl(PR_GET_NAME, name, NULL, NULL, NULL);
> +
> +	if (res < 0)
> +		return -errno;
> +
> +	return !strcmp(name, check_name);
> +}
> +
> +int check_null_pointer(char *check_name)
> +{
> +	char *name = NULL;
> +	int res;
> +
> +	res = prctl(PR_GET_NAME, name, NULL, NULL, NULL);
> +
> +	return res;
> +}
> +
> +TEST(rename_process) {
> +
> +	EXPECT_GE(set_name(CHANGE_NAME), 0);
> +	EXPECT_TRUE(check_is_name_correct(CHANGE_NAME));
> +
> +	EXPECT_GE(set_name(EMPTY_NAME), 0);
> +	EXPECT_TRUE(check_is_name_correct(EMPTY_NAME));
> +
> +	EXPECT_GE(set_name(CHANGE_NAME), 0);
> +	EXPECT_LT(check_null_pointer(CHANGE_NAME), 0);
> +}
> +
> +TEST_HARNESS_MAIN

Otherwise looks good.

thanks,
-- Shuah
