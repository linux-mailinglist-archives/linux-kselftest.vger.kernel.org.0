Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDD06CC8A3
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Mar 2023 18:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjC1Q5C (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Mar 2023 12:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjC1Q5C (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Mar 2023 12:57:02 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A8FB747
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Mar 2023 09:57:01 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-752fe6c6d5fso7705339f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Mar 2023 09:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1680022620;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WuhR7C9sPLSc4hNe7UZJGxZfKsFXbBmUVGuYhZev+w8=;
        b=GXLVDiAN+JKnqKU8AGfiMNcTerA/REWmOyg0ptlVwyXP2BCPxG2brolg5skQolJ668
         ou6K0h4IvmSZNHxKwDYNK4CRJ0GdBhzBQiK5oJBz5mADLNm7f9/0s1+F94k5g0p1poUq
         XsAVmsS8dwmkBndJ4lCtL6J0oFDWiuIH4b338=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680022620;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WuhR7C9sPLSc4hNe7UZJGxZfKsFXbBmUVGuYhZev+w8=;
        b=GPdW9GN62CJVpWpYmvDH0t5C2QoZFhB4g2GCbc4i7C7yV0G9UFS12PWUO5wrH3vrGc
         X6U+fltEnGPYwCrROF4j6HHkfiQoL/U5jNqTlKd2xnCic31aRZML6pxEwwke3lBcSuOW
         ta1NFOrPE3k/6AUXZFhU4rJa6b4NZvjEv4A9xm8VDxUpMjrss40RDay3WC1IdhLIfpFK
         cbuHqAgGBAeZIyKVvn/6JQKijOt3D7AYGGHIFtYtUKTGUza2eTwQoJGFPU6PNXgO874b
         EaVx6h3jVr8ugJ+A3irXPdJPp7RuReDZnqNK2H/iUuBiodfjYMxbCLojsMihiW3Q1f3o
         9FUQ==
X-Gm-Message-State: AO0yUKUyLUSaP5NAXGDndzUG2UXPVexx0FZggJpxFoxE7WrHELK/HbAW
        FM2NCKlGLvb8i102dCqAfdrczA==
X-Google-Smtp-Source: AK7set8LuWrdxjSDNgZjgg6G/M5qRfcCIc7t6efNSu7YQSnIS8BVCNbNfaKrsPxOYeIcDfmKWmEgQw==
X-Received: by 2002:a05:6602:2c82:b0:740:7d21:d96f with SMTP id i2-20020a0566022c8200b007407d21d96fmr10235137iow.1.1680022620552;
        Tue, 28 Mar 2023 09:57:00 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id d37-20020a023f25000000b004062b6d7ab3sm9696677jaa.149.2023.03.28.09.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 09:57:00 -0700 (PDT)
Message-ID: <65ec8d6c-319e-8079-7445-ae514e328a4e@linuxfoundation.org>
Date:   Tue, 28 Mar 2023 10:56:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] Refactor 'peeksiginfo' ptrace test part
Content-Language: en-US
To:     Ivan Orlov <ivan.orlov0322@gmail.com>, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230220160302.4679-1-ivan.orlov0322@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230220160302.4679-1-ivan.orlov0322@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/20/23 09:03, Ivan Orlov wrote:
> peeksiginfo creates an array of 10 instances of 'siginfo_t',
> but actually uses only one. This patch will reduce amount
> of memory on the stack used by the peeksiginfo test.
> 
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> ---

Thank you. Applied to linux-kselftest next for Linux 6.4-rc1

thanks,
-- Shuah

