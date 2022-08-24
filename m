Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF58D5A0286
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Aug 2022 22:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240161AbiHXUMq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Aug 2022 16:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiHXUMp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Aug 2022 16:12:45 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE7B1835C
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Aug 2022 13:12:43 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id 62so14312889iov.5
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Aug 2022 13:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:from:to:cc;
        bh=AUsCic3JN9zpVEn1D9LBfAVAahfOpJCAJY/k/xDwQ9k=;
        b=ZLeTmPXG/YiGfSOKhcKrcCuC1KD4Xl2qzFZFnKSXLLXS5+nYjGnYMFazuS4gpO9Oh3
         pxfXXxtYHo8npFBpOyR0vMfI2xIUPsCqvQhI72/jkSByrF504yA7RxoLbiRnnmkb6cfM
         YjYpZnTwlU4Bkdvh799XjuJKrj4s1UqwUoil0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc;
        bh=AUsCic3JN9zpVEn1D9LBfAVAahfOpJCAJY/k/xDwQ9k=;
        b=JK7Kpn7U9fVWQc85epptitXyzVhpdLvP1pyjqnZSqf/ZvccQKMhmFAl59+M1hPYU5y
         3HnhfgqhgQq7lQhhCVCgviUZV6Xnrw6k8aHphXdIkP4PjNHMZJSP+LhwiTA6AwYpo3Ql
         cZDWd6mV5e50K8FwzZ7rLz0FQ0qkIJAIrrRCAVfX1Gbn78bvMNysTVbNtpPpYL2F7UAG
         FPquSTsZl4B1N+UN1occZgkxKmRLtcno2e8+iy80ew0t8H6SOCSrXYD77/pVOoU6tQLa
         K0Fnjwno9C1tKiebkd8/EPsb4v31DNDWJ7RIYdmFP8dFTyScTAuV7eRs1ChO5KoLZn3F
         NwUw==
X-Gm-Message-State: ACgBeo0Z589WJK77NpsX/g93lMpOaIKDY/a0bcfiCnf8b8C6kk4pLoY8
        UUsXp32t7gs8ZSlRm7IgtD9JKQ==
X-Google-Smtp-Source: AA6agR6Vlt8aZBycuctok098xfzKSgjUx8repUjgNyGlxpIw7jPbnOYUpPj8dqwOhXRABG2WcDSHDg==
X-Received: by 2002:a05:6638:2615:b0:349:fc66:cab with SMTP id m21-20020a056638261500b00349fc660cabmr281450jat.170.1661371962995;
        Wed, 24 Aug 2022 13:12:42 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id x2-20020a0566022c4200b006887640a5edsm164735iov.23.2022.08.24.13.12.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 13:12:42 -0700 (PDT)
Subject: Re: [net-next] Fix reinitialization of TEST_PROGS in net self tests.
To:     Adel Abouchaev <adel.abushaev@gmail.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        shuah@kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <Adel Abouchaev <adel.abushaev@gmail.com>
 <20220824184351.3759862-1-adel.abushaev@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3e3edde6-eb35-6197-4ffd-ed7c545b4f85@linuxfoundation.org>
Date:   Wed, 24 Aug 2022 14:12:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220824184351.3759862-1-adel.abushaev@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/24/22 12:43 PM, Adel Abouchaev wrote:
> Fix reinitialization of TEST_PROGS in net self tests.
> 
> Signed-off-by: Adel Abouchaev <adel.abushaev@gmail.com>
> ---
>   tools/testing/selftests/net/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index 11a288b67e2f..4a5978eab848 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -42,7 +42,7 @@ TEST_PROGS += arp_ndisc_evict_nocarrier.sh
>   TEST_PROGS += ndisc_unsolicited_na_test.sh
>   TEST_PROGS += arp_ndisc_untracked_subnets.sh
>   TEST_PROGS += stress_reuseport_listen.sh
> -TEST_PROGS := l2_tos_ttl_inherit.sh
> +TEST_PROGS += l2_tos_ttl_inherit.sh
>   TEST_PROGS_EXTENDED := in_netns.sh setup_loopback.sh setup_veth.sh
>   TEST_PROGS_EXTENDED += toeplitz_client.sh toeplitz.sh
>   TEST_GEN_FILES =  socket nettest
> 

Thank you for fixing this. I am seeing these types of bugs recently
Have to careful with := vs +=

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
