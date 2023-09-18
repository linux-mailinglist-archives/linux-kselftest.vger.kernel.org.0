Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF03A7A50BD
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Sep 2023 19:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjIRROU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Sep 2023 13:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjIRROS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Sep 2023 13:14:18 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673C090
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Sep 2023 10:14:13 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-7950d0c85bbso52515139f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Sep 2023 10:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1695057253; x=1695662053; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ie4OPVJg6VkbmJGC/wWGQH6IojD/zRo6+BSb7Fsy9JI=;
        b=DNl+DzVkGgl4TJkwuJ9c4+5wGWNvbM2InDF1SNefKskc8l6AD0liH3lWzupbRCaOJn
         v5jd4+DMSz/nq/X9WKS8SWRlqgGn0yvZzMygyL3s8IFhILMwXoi8nK17pknxBD7E85+a
         jKViiTDI4nsUYP843NuTF3b6mNpkiv7p738A8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695057253; x=1695662053;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ie4OPVJg6VkbmJGC/wWGQH6IojD/zRo6+BSb7Fsy9JI=;
        b=IjI/7psMTo+WL78cPGOCn57sHhpyCW2B01MXJvtNjg4abv+YZKY5NfNd8V5kx1a+Uw
         pIWQXpVpMVXjfKfBX362pvQNOunu6A4lv5ClUaeqZyI4Jq/vO9+tFNBlDOVYNhS4kinG
         tLlxCMEAsn39ecoYaA8/vakFnjciEA6ii2OsP3TVSndyODfO7G7vhMlaAp8O3ZrbEmJK
         d8VnSAUhNgBqTqI7grbYq3OgzHnTk+Qw9dXgCkXWP16RJASaLQLCrW/iXeGR9vxah9/h
         0Pe+QcSUIdRwhME3aQtixo9xG7Phd9EWy2HqWsJbpgqzEVIgj8Fi5sNfiigNO0nmDwwy
         3eeA==
X-Gm-Message-State: AOJu0YyrteElryRzbK7HtDkoUTlRP0jlv4DO53IJ7i+F1TsrK/gHJrZw
        PMXNRPcncMQr/TtGklb8fJ9l0w==
X-Google-Smtp-Source: AGHT+IG2V3CJARBNRxPKJKeXyTh9r0NpUgCO8mWIrC0bsn2cdb/nmfGR+IUEAWSd4X2yjN18/40B7g==
X-Received: by 2002:a05:6602:2cd1:b0:794:cbb8:725e with SMTP id j17-20020a0566022cd100b00794cbb8725emr13416129iow.2.1695057252743;
        Mon, 18 Sep 2023 10:14:12 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id x13-20020a5e830d000000b0077e3566a801sm2872515iom.29.2023.09.18.10.14.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 10:14:12 -0700 (PDT)
Message-ID: <3a279a31-7a3b-fed9-e50f-b0d86f4de4f6@linuxfoundation.org>
Date:   Mon, 18 Sep 2023 11:14:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] selftests: uevent filtering: fix return on error in
 uevent_listener
Content-Language: en-US
To:     Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230916-topic-self_uevent_filtering-v1-1-26ede507d454@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230916-topic-self_uevent_filtering-v1-1-26ede507d454@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/16/23 10:11, Javier Carrasco wrote:
> Assign the error value to the real returned variable fret. The ret
> variable is used to check function return values and assigning values to
> it on error has no effect as it is an unused value.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>   tools/testing/selftests/uevent/uevent_filtering.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/uevent/uevent_filtering.c b/tools/testing/selftests/uevent/uevent_filtering.c
> index 5cebfb356345..e191b6d69f8c 100644
> --- a/tools/testing/selftests/uevent/uevent_filtering.c
> +++ b/tools/testing/selftests/uevent/uevent_filtering.c
> @@ -158,7 +158,7 @@ static int uevent_listener(unsigned long post_flags, bool expect_uevent,
>   		r = recvmsg(sk_fd, &hdr, 0);
>   		if (r <= 0) {
>   			fprintf(stderr, "%s - Failed to receive uevent\n", strerror(errno));
> -			ret = -1;
> +			fret = -1;
>   			break;
>   		}
>   
> @@ -172,7 +172,7 @@ static int uevent_listener(unsigned long post_flags, bool expect_uevent,
>   
>   		if (!expect_uevent) {
>   			fprintf(stderr, "Received unexpected uevent:\n");
> -			ret = -1;
> +			fret = -1;
>   		}
>   
>   		if (TH_LOG_ENABLED) {
> 

Thank you for the find. Please simplify these leg and use just one
variable for failures, ret or fret and not both to avoid future
coding errors like this one you are fixing.

thanks,
-- Shuah

