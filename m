Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A377403C8
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jun 2023 21:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjF0TJA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jun 2023 15:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF0TI7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jun 2023 15:08:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFEBFD;
        Tue, 27 Jun 2023 12:08:57 -0700 (PDT)
Received: from [192.168.10.54] (unknown [182.179.162.32])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AA24F6607165;
        Tue, 27 Jun 2023 20:08:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687892936;
        bh=NQDlzaX3MiB53zJheAaS4x+ijWekgq2JrH0gJe+g+tc=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=MGkS/O5MaDzDXDi24ojsh+0nLwUS1FFIP0HARhsRWv40RYMsAhdqkSu0BCKbbttyS
         U2aMqaxhXPj6Hny+J4aOnpFr+Po3mFJ0o9ndgF8VqJrJTN1B9En2hFzrABgndyAJAu
         CX25FxiC8yYP7uhgry/1hWHzkB/lS3cmrsEW4JGE5VxkGXxe1+Nlq7RQUPy745EYjW
         fswes+9Lvo2GCTA27O86sFCGPUbErILPWIArgLE09a1G3WeqynZ8pIX77s0XXQcXe4
         tHwalPURKzgrd4s66FqDcSEKU5x5VD1mHWf3UuxGsGs+iqBZtahxRW3iGqErsd+9DW
         T/O9S9unz+EtQ==
Message-ID: <732c535d-97cd-429f-3c1d-eda7a57df001@collabora.com>
Date:   Wed, 28 Jun 2023 00:08:50 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2] selftests: prctl: Add new prctl test for PR_SET_NAME
Content-Language: en-US
To:     Osama Muhammad <osmtendev@gmail.com>, shuah@kernel.org
References: <20230607153600.15816-1-osmtendev@gmail.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20230607153600.15816-1-osmtendev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Unrelated to this patch:
You can build the user header files by running `make headers` in a kernel
repository to process the kernel header files. They are generated in
<kernel_source>/include/uapi Then run `make -C
tools/testing/selftests/prctl` to build the test etc.

On 6/7/23 8:36 PM, Osama Muhammad wrote:
> This patch will add the new test, which covers the prctl call
> PR_SET_NAME command. The test tries to give a name using the PR_SET_NAME
> call and then confirm it that it changed correctly by using  PR_GET_NAME.
> It also tries to rename it with empty name.In the test PR_GET_NAME is
> tested by passing null pointer to it and check its behaviour.
> 
> Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> 
> ---
> changes since v1:
> 	-Used TASK_COMM_LEN instead of using numerical value 16.
> 	 
> ---
>  tools/testing/selftests/prctl/Makefile        |  2 +-
>  .../selftests/prctl/set-process-name.c        | 62 +++++++++++++++++++
>  2 files changed, 63 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/prctl/set-process-name.c
> 
> diff --git a/tools/testing/selftests/prctl/Makefile b/tools/testing/selftests/prctl/Makefile
> index c058b81ee..cfc35d29f 100644
> --- a/tools/testing/selftests/prctl/Makefile
> +++ b/tools/testing/selftests/prctl/Makefile
> @@ -5,7 +5,7 @@ ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
>  
>  ifeq ($(ARCH),x86)
>  TEST_PROGS := disable-tsc-ctxt-sw-stress-test disable-tsc-on-off-stress-test \
> -		disable-tsc-test set-anon-vma-name-test
> +		disable-tsc-test set-anon-vma-name-test set-process-name
>  all: $(TEST_PROGS)
>  
>  include ../lib.mk
> diff --git a/tools/testing/selftests/prctl/set-process-name.c b/tools/testing/selftests/prctl/set-process-name.c
> new file mode 100644
> index 000000000..3bc5e0e09
> --- /dev/null
> +++ b/tools/testing/selftests/prctl/set-process-name.c
> @@ -0,0 +1,62 @@
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
> +#define TASK_COMM_LEN 16
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
> +	char name[TASK_COMM_LEN];
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

-- 
BR,
Muhammad Usama Anjum
