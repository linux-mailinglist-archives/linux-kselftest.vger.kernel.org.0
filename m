Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09081722FEB
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 21:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbjFETkY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 15:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234525AbjFETkX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 15:40:23 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E7B9C
        for <linux-kselftest@vger.kernel.org>; Mon,  5 Jun 2023 12:40:22 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-33d0c740498so2434515ab.0
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jun 2023 12:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1685994021; x=1688586021;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pSCTHh0/+bNATByAsUgmwiP+hFeMNJkT6J92qlZVpFs=;
        b=dtAHvThcg4aNGSQ913U3mJcT51DfHlnPIomJIPoaOYJC7ydC/a08Yi/nkRlzyL/fDX
         1qitrjr/BugM2dN/4FJe8AejRktG+yrcV8u6jm8GiynuSiVxsv5fwMyYqFG+QZFdm8f+
         TxW8rnJKe6895GHa/gt96mubg1XpaqQ5nTF3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685994021; x=1688586021;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pSCTHh0/+bNATByAsUgmwiP+hFeMNJkT6J92qlZVpFs=;
        b=Mz1jQLea7Z2fyHQ494eAT5J+6EFj7Dl/cDT4bN6wb/en4zC7/8qIt6cOIYLmK9rDGY
         xvlTBiYTvki4hdYRNQOXjon6kMmtrtsVhiCV/6H6uUxB1mAKkBcQXzYWa1FA2umZbb0r
         a+Km/9CHIrC4CQoItXmzP1xWs/o2ZJW5rIAv35jdJCsMIvVYNe2zoQ0Q70Gd7Lu8cz1B
         DctAp6iHky1E0mfcSGYUBF/lV/RVn6UgUwPy35NeBX9xqp8i15W1cJC1jAeOTC1O2qMJ
         o+RLcN57V9fz5EmhyiHvO98iMpmBlE9DPKj4Vn6sPU0FSHYczTNvfvK7RVG+2rj7FDI5
         CB/A==
X-Gm-Message-State: AC+VfDx9VR+wBx9GJrtUdhs3m53QNmEXdSme654a5xPeqLNIhGdA8l1c
        cruVg2XnDEJ6/T1eIaQfrtz2JOWHZ/5p7wHGmx4=
X-Google-Smtp-Source: ACHHUZ4ALFEeOShyYs4ZR1D96r9L04QZMWgT8pY9pitWcfD/3Roa1gTw3zGYN6dsxwB4LDSQ1eT5Dg==
X-Received: by 2002:a6b:8d8e:0:b0:777:a5a4:c6cb with SMTP id p136-20020a6b8d8e000000b00777a5a4c6cbmr117369iod.1.1685994021528;
        Mon, 05 Jun 2023 12:40:21 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id a5-20020a6b6c05000000b0075c37601b5csm2713016ioh.4.2023.06.05.12.40.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 12:40:21 -0700 (PDT)
Message-ID: <93651468-daa2-1530-f94e-b66a4fd4bdf8@linuxfoundation.org>
Date:   Mon, 5 Jun 2023 13:40:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] kselftests: Sort the collections list to avoid duplicate
 tests
Content-Language: en-US
To:     Rishabh Bhatnagar <risbhat@amazon.com>, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230601211112.12724-1-risbhat@amazon.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230601211112.12724-1-risbhat@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/1/23 15:11, Rishabh Bhatnagar wrote:
> If the collections list is not sorted uniq doesn't weed out duplicate
> tests correctly. Make sure to sort it before running uniq.
> 
> Signed-off-by: Rishabh Bhatnagar <risbhat@amazon.com>
> ---
>   tools/testing/selftests/run_kselftest.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/run_kselftest.sh b/tools/testing/selftests/run_kselftest.sh
> index 97165a83df63..e0cb10c85169 100755
> --- a/tools/testing/selftests/run_kselftest.sh
> +++ b/tools/testing/selftests/run_kselftest.sh
> @@ -85,7 +85,7 @@ if [ -n "$TESTS" ]; then
>   	available="$(echo "$valid" | sed -e 's/ /\n/g')"
>   fi
>   
> -collections=$(echo "$available" | cut -d: -f1 | uniq)
> +collections=$(echo "$available" | cut -d: -f1 | sort | uniq)
>   for collection in $collections ; do
>   	[ -w /dev/kmsg ] && echo "kselftest: Running tests in $collection" >> /dev/kmsg
>   	tests=$(echo "$available" | grep "^$collection:" | cut -d: -f2)

Applied to linux-kselftest next for Linux 6.5-rc1.

thanks,
-- Shuah
