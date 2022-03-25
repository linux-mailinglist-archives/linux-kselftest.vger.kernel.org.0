Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133304E7BB9
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Mar 2022 01:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiCYXoZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Mar 2022 19:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiCYXoW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Mar 2022 19:44:22 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173AE171EDD
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Mar 2022 16:42:48 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-deb9295679so2310802fac.6
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Mar 2022 16:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FUQdFtH9YlwwBGqgehIdhTZB7NcQKOtLcacGBJDjt4k=;
        b=UZxKWr4IAkS8kPXqfIyReCOSUs3hKS8T9U43E5J75p52qMYbDZycIgrQDGJdNncT2a
         Ob8lpNIc9/fqFWWjuPigNfT7DCeA/oyzQ6YWZ9jYbULHbG3uq9RFLD/4gX0X4MrEbosX
         25iDHR6+D+UzXw7ziI6RO+/DM8bJdAGkf5Jas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FUQdFtH9YlwwBGqgehIdhTZB7NcQKOtLcacGBJDjt4k=;
        b=6LByuMwPlFI72IC7Tvwl93/l6gGd8SMUnPaiQVXtcli3SLYE5R9ZTyF0TvNsaWz9yM
         IA7s7rX4Tmp2ijMbqbl+t43SyXRxoNXx09JTX00LlBam45LKaVVwzbbKvNFwv7Nnuz9g
         ZqXcHnrsbdwooTY9Vmkg5n5fbjY9Zs7v2TFPsU+WK/FKP+yn97pZpz54+CZ9TQTZkJNO
         2IvfggGwcZsnwcOuzvlQICOp+UTWlU0oVEzyopGqtsU5x/iq/6vg1Jnw/oHIt9dKybd9
         lUrLBXvWYfFHHg7INfmWbGrG8QH7/Prk6k47Jix3EoZznJtLmdjMnJjD7omVYyg5FtDR
         ODIw==
X-Gm-Message-State: AOAM532+3hmCFRiuWe/Mu6kpgXGOsrsyzPwdmx/69+sokKEKC+mpAGO3
        wJE6ziUnOBXR76mmqBGlNb/9ZA==
X-Google-Smtp-Source: ABdhPJx7Ui0xBXqZcCJr5lcafT8zzi6aQ/2UZCJT/m0lgtUh9E7RSA75QBRG/3cho6hyYR4c8GLewA==
X-Received: by 2002:a05:6870:d28d:b0:da:b3f:3234 with SMTP id d13-20020a056870d28d00b000da0b3f3234mr5964913oae.228.1648251767361;
        Fri, 25 Mar 2022 16:42:47 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id bm51-20020a0568081ab300b002da5c44e0bdsm3416422oib.28.2022.03.25.16.42.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 16:42:47 -0700 (PDT)
Subject: Re: [PATCH net] selftests: tls: skip cmsg_to_pipe tests with TLS=n
To:     Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc:     pabeni@redhat.com, netdev@vger.kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220325232709.2358965-1-kuba@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <00f158e4-0e49-6ab1-825a-e53df4b744b3@linuxfoundation.org>
Date:   Fri, 25 Mar 2022 17:42:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220325232709.2358965-1-kuba@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/25/22 5:27 PM, Jakub Kicinski wrote:
> These are negative tests, testing TLS code rejects certain
> operations. They won't pass without TLS enabled, pure TCP
> accepts those operations.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Fixes: d87d67fd61ef ("selftests: tls: test splicing cmsgs")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>   tools/testing/selftests/net/tls.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
> index 6e468e0f42f7..5d70b04c482c 100644
> --- a/tools/testing/selftests/net/tls.c
> +++ b/tools/testing/selftests/net/tls.c
> @@ -683,6 +683,9 @@ TEST_F(tls, splice_cmsg_to_pipe)
>   	char buf[10];
>   	int p[2];
>   
> +	if (self->notls)
> +		SKIP(return, "no TLS support");
> +
>   	ASSERT_GE(pipe(p), 0);
>   	EXPECT_EQ(tls_send_cmsg(self->fd, 100, test_str, send_len, 0), 10);
>   	EXPECT_EQ(splice(self->cfd, NULL, p[1], NULL, send_len, 0), -1);
> @@ -703,6 +706,9 @@ TEST_F(tls, splice_dec_cmsg_to_pipe)
>   	char buf[10];
>   	int p[2];
>   
> +	if (self->notls)
> +		SKIP(return, "no TLS support");
> +
>   	ASSERT_GE(pipe(p), 0);
>   	EXPECT_EQ(tls_send_cmsg(self->fd, 100, test_str, send_len, 0), 10);
>   	EXPECT_EQ(recv(self->cfd, buf, send_len, 0), -1);
> 

Looks good to me. Thanks for the fix.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
