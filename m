Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C097CE758
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Oct 2023 21:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjJRTIF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Oct 2023 15:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjJRTIE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Oct 2023 15:08:04 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E0F11D
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Oct 2023 12:08:02 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-79fab2caf70so59109839f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Oct 2023 12:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1697656082; x=1698260882; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cEDDXOwUBOTP0ob0yPcID6lS1qUx48BjXcmqRUbCC3Q=;
        b=WGbJ8L3Rl+jtKoPsUhVoxw9U2g8NQtg8V9iaudGEQ3gnDn6j9PW+TpKRQIhGBFYma9
         r6S1iiHcKRyNu1Zd+0IHesiyXRMaiCsFdHoisgCBrwyxXMaTqJ5cMdhRY4+dA2H9JC03
         fv8U1e0y9HTgRCgy8WWC9ZHUXNVDsGGPJKNEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697656082; x=1698260882;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cEDDXOwUBOTP0ob0yPcID6lS1qUx48BjXcmqRUbCC3Q=;
        b=lZVQ32QAviSQ+k8HZulLfAtIFWDQ7RM8DucAKedfIMSltkB2KsPN/HBmGnAQ/yryka
         GKEAQLFNyDqTUUlu0BNM+jEWSPoq8tpm1Y85zd26t8kB8vWMP1NhLAyD47RpvtNIeaMl
         F9fHGxGGPRlbYR8bT8g0VwkTcwYA9uhWOv+yBGXbtg3OdM4pRvNw2331/BOAEzPfeeMX
         +W+mTrvMqz6NRFJIrPXwke937k1Mvao6fIwDsib9zHR4Jt6XXMMCfvr65TWjltoHHdBf
         lpsisgAActOUwDfFsiVDazKS9OjpcQcQigIdu9zLraOtyxlIzROmwxPijEF/itmNmzWO
         1KvA==
X-Gm-Message-State: AOJu0Ywh2FXAytKyNCNXnR6JhoM4Q49kltNfYhs0LIZgq55eDYM3IChH
        nlBJsw8sPQ9dUdqFaUa3qQ2Ieg==
X-Google-Smtp-Source: AGHT+IEb8K9JivIiDdJvTYkRWVcFRkSMFzysZi9fbNS8GC7PoRIcGsS4IE+VR539cbz5D00A4ZwqQQ==
X-Received: by 2002:a6b:671b:0:b0:7a5:cd6b:7581 with SMTP id b27-20020a6b671b000000b007a5cd6b7581mr203528ioc.2.1697656082045;
        Wed, 18 Oct 2023 12:08:02 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id 9-20020a5d9c09000000b0079199e52035sm269584ioe.52.2023.10.18.12.08.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 12:08:00 -0700 (PDT)
Message-ID: <662a7ca4-beee-4ea3-b77e-4d5af1462f13@linuxfoundation.org>
Date:   Wed, 18 Oct 2023 13:08:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/efivarfs: create-read: fix a resource leak
Content-Language: en-US
To:     zhujun2 <zhujun2@cmss.chinamobile.com>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <2a96e3a8-48a5-46ae-9a0c-b5f2def0a257@linuxfoundation.org>
 <20231018015921.16890-1-zhujun2@cmss.chinamobile.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231018015921.16890-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/17/23 19:59, zhujun2 wrote:
> The opened file should be closed in main(), otherwise resource
> leak will occur that this problem was discovered by code reading
> 
> Signed-off-by: zhujun2 <zhujun2@cmss.chinamobile.com>
> ---
>   tools/testing/selftests/efivarfs/create-read.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/efivarfs/create-read.c b/tools/testing/selftests/efivarfs/create-read.c
> index 9674a1939..7bc7af4eb 100644
> --- a/tools/testing/selftests/efivarfs/create-read.c
> +++ b/tools/testing/selftests/efivarfs/create-read.c
> @@ -32,8 +32,10 @@ int main(int argc, char **argv)
>   	rc = read(fd, buf, sizeof(buf));
>   	if (rc != 0) {
>   		fprintf(stderr, "Reading a new var should return EOF\n");
> +		close(fd);
>   		return EXIT_FAILURE;
>   	}
>   
> +	close(fd);
>   	return EXIT_SUCCESS;
>   }

Thank you. Applied to linux-kselftest next for Linux 6.7-c1.

thanks,
-- Shuah
