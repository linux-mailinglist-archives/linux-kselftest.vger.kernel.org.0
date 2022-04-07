Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68884F89F9
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Apr 2022 00:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbiDGUkA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Apr 2022 16:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiDGUjq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Apr 2022 16:39:46 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E254E383991
        for <linux-kselftest@vger.kernel.org>; Thu,  7 Apr 2022 13:31:27 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id t2so9036893qtw.9
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Apr 2022 13:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EW4jKj0Aht/BtYVNZ+iEkVJaVKtkBsTq1J5snmk+nuY=;
        b=flcQDSKpQ1QojYalveVlM2QHe4EtNYUqKNuiUf73lypG7bstIhL9ocdBgbQBh5Sqja
         xwvhtj2rN4/FqHuP1JsNlWwRpWCWnAc6tTUbe+0v1JUFdXEEmb2SI6rUMigoHiIPhEky
         9RNA6V8JjVxaC7YbWgKp/Hd558UCx0VCb0DxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EW4jKj0Aht/BtYVNZ+iEkVJaVKtkBsTq1J5snmk+nuY=;
        b=lEk4dJo21C+AcHeJXZH5/7NGWD4hjVW9VRcUNEDmqEA5dBzOThi5WlZ5wrg/ddONQ7
         hqly4HdNAu6DHeEfnTJPKLugf0+6dsUZeBrJyT0KAH+AUqi0xBqtGV/1YcG8PbTtGEWq
         kDGsCubh962JrPmxKS54E0FxFNfc13wP0s2tca8Q6NIVKw1JuaY6hDv5P0OaoIT+nt54
         ha/FD5S4nOGQXpMRLO8+68HdmuEbskFN1UBcR6iXdzeCOSb4lnHu7nh96zjrv04EFZix
         jarnYvtbgvnR38xPxY/M8nU6f36niF6ybwI5IdwRZBYL+EWXTfeJkbKcAkdYs2YcIR4E
         Eaog==
X-Gm-Message-State: AOAM532qzchG6uRuaknm2gNU87SG4rHl0uJG2K5fMXd5+esJXVl8An5r
        nNntkkvCFsQS1JivlIlkL64lu/TUaIYDTA==
X-Google-Smtp-Source: ABdhPJwNaq968o79j7Sy32TZQ5p516IMnSRGKRGZljWrjagyqsAVFjo4QD4QFxfDdSlgbH/rE3i/zQ==
X-Received: by 2002:a02:a98f:0:b0:315:19db:27a3 with SMTP id q15-20020a02a98f000000b0031519db27a3mr7313724jam.184.1649361633505;
        Thu, 07 Apr 2022 13:00:33 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id u15-20020a056e021a4f00b002c665afb993sm12217063ilv.11.2022.04.07.13.00.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 13:00:33 -0700 (PDT)
Subject: Re: [PATCH 3/4] selftests/memfd: add tests for F_SEAL_EXEC
To:     Daniel Verkamp <dverkamp@chromium.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Mattias Nissler <mnissler@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220401220834.307660-1-dverkamp@chromium.org>
 <20220401220834.307660-4-dverkamp@chromium.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <6f71a4f3-8f8e-926b-883c-1df630cfc1a0@linuxfoundation.org>
Date:   Thu, 7 Apr 2022 14:00:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220401220834.307660-4-dverkamp@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/1/22 4:08 PM, Daniel Verkamp wrote:
> Basic tests to ensure that user/group/other execute bits cannot be
> changed after applying F_SEAL_EXEC to a memfd.
> 
> Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>
> ---
>   tools/testing/selftests/memfd/memfd_test.c | 80 ++++++++++++++++++++++
>   1 file changed, 80 insertions(+)
> 
> diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
> index 94df2692e6e4..fdb0e46e9df9 100644
> --- a/tools/testing/selftests/memfd/memfd_test.c
> +++ b/tools/testing/selftests/memfd/memfd_test.c
> @@ -28,6 +28,10 @@
>   #define MFD_DEF_SIZE 8192
>   #define STACK_SIZE 65536
>   
> +#ifndef F_SEAL_EXEC
> +#define F_SEAL_EXEC	0x0020
> +#endif
> +
>   /*
>    * Default is not to test hugetlbfs
>    */
> @@ -594,6 +598,48 @@ static void mfd_fail_grow_write(int fd)
>   	}
>   }
>   
> +static void mfd_assert_mode(int fd, int mode)
> +{
> +	struct stat st;
> +
> +	if (fstat(fd, &st) < 0) {
> +		printf("fstat(%d) failed: %m\n", fd);

Let's print the filename here - just printing fd isn't useful.

> +		abort();
> +	} else if ((st.st_mode & 07777) != mode) {
> +		printf("wrong file mode 0%04o, but expected 0%04o\n",
> +		       (int)st.st_mode & 07777, mode);

This one doesn't even print fd - same comment here about filename.

> +		abort();
> +	}
> +}
> +
> +static void mfd_assert_chmod(int fd, int mode)
> +{
> +	if (fchmod(fd, mode) < 0) {
> +		printf("fchmod(0%04o) failed: %m\n", mode);

Same here.

> +		abort();
> +	}
> +
> +	mfd_assert_mode(fd, mode);
> +}
> +
> +static void mfd_fail_chmod(int fd, int mode)
> +{
> +	struct stat st;
> +
> +	if (fstat(fd, &st) < 0) {
> +		printf("fstat(%d) failed: %m\n", fd);

Same comment about filename

> +		abort();
> +	}
> +
> +	if (fchmod(fd, mode) == 0) {
> +		printf("fchmod(0%04o) didn't fail as expected\n");

Same comment about filename

> +		abort();
> +	}
> +
> +	/* verify that file mode bits did not change */
> +	mfd_assert_mode(fd, st.st_mode & 07777);
> +}
> +
>   static int idle_thread_fn(void *arg)
>   {
>   	sigset_t set;
> @@ -880,6 +926,39 @@ static void test_seal_resize(void)
>   	close(fd);
>   }
>   
> +/*
> + * Test SEAL_EXEC
> + * Test that chmod() cannot change x bits after sealing
> + */
> +static void test_seal_exec(void)
> +{
> +	int fd;
> +
> +	printf("%s SEAL-EXEC\n", memfd_str);
> +
> +	fd = mfd_assert_new("kern_memfd_seal_exec",
> +			    mfd_def_size,
> +			    MFD_CLOEXEC | MFD_ALLOW_SEALING);
> +
> +	mfd_assert_mode(fd, 0777);
> +
> +	mfd_assert_chmod(fd, 0644);
> +
> +	mfd_assert_has_seals(fd, 0);
> +	mfd_assert_add_seals(fd, F_SEAL_EXEC);
> +	mfd_assert_has_seals(fd, F_SEAL_EXEC);
> +
> +	mfd_assert_chmod(fd, 0600);
> +	mfd_fail_chmod(fd, 0777);
> +	mfd_fail_chmod(fd, 0670);
> +	mfd_fail_chmod(fd, 0605);
> +	mfd_fail_chmod(fd, 0700);
> +	mfd_fail_chmod(fd, 0100);
> +	mfd_assert_chmod(fd, 0666);
> +
> +	close(fd);
> +}
> +
>   /*
>    * Test sharing via dup()
>    * Test that seals are shared between dupped FDs and they're all equal.
> @@ -1059,6 +1138,7 @@ int main(int argc, char **argv)
>   	test_seal_shrink();
>   	test_seal_grow();
>   	test_seal_resize();
> +	test_seal_exec();
>   
>   	test_share_dup("SHARE-DUP", "");
>   	test_share_mmap("SHARE-MMAP", "");
> 

The rest looks good.

thanks,
-- Shuah
