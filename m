Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559917AF7F4
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 04:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjI0CCp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 22:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234819AbjI0CAo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 22:00:44 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEAD35AE
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Sep 2023 18:18:30 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-351265d0d67so5547315ab.0
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Sep 2023 18:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1695777510; x=1696382310; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pSK45h5LTS9VqkVC57gaj2Wd82aeyGKZrEYe4dJCVic=;
        b=bxVM6N7U4F+Ynjj38INwi6ASqm3IBKUZ2yJDT7Ckbee+wq9E3UZNBRzyGfQcYS34Zm
         390zUF6zyX1jXsJs0qezpAIk0Fh/LHYP2jTC2k9Oekg0LvZ2uiw1Xok3H/KHren2K1Kj
         zuzTpI7pO+/1KMER6qwgrgRDhYD6SZbd/b9wM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695777510; x=1696382310;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pSK45h5LTS9VqkVC57gaj2Wd82aeyGKZrEYe4dJCVic=;
        b=NV3OvxfSdqqnm8d/YL5eQvmQN0ZJvlESgxIULLahKDviPY8u9/z5x4VIpa0WaIKXY6
         Y28ljsGzpt/iS2VvGciGnMWTrDsBnG0xS8ZWbX2aY4lUSKSLOw4Eg3sWw31PIs+CKnqt
         OwCE1W/6KEhiEoU4XtQ74OFtKh5cV9fxnLcpJHlHsTEWYWWsDa3XtLMzkv9ppgoSifen
         KDHi9Qqk+rQjyGlaW/km4MmOxySLfv2w2fNwlCJGm/XwVqfYDwUbmAo/EyhqAbfWHPui
         nIuVcTWTpRwjm8KuZ5WGc8fnK/1ZuYgIRobNpuiioBhsDWMypfA5GqfotGRJzydPxdt8
         Ba6g==
X-Gm-Message-State: AOJu0YxPCJ9WG1rWWjAzR3TIchtnr5w5YGQHZb9nIVGAF1tVdTv+ECiW
        uOeAE/cxp9nV+++J767P19luHg==
X-Google-Smtp-Source: AGHT+IE2jaCutfBvakslg8GPNafee+TlzK+8frCnXrODTVfbk9z1YRbburEMP7cvS9iSP7ZFw0fvlQ==
X-Received: by 2002:a92:cc46:0:b0:350:f353:4017 with SMTP id t6-20020a92cc46000000b00350f3534017mr614948ilq.0.1695777510062;
        Tue, 26 Sep 2023 18:18:30 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id y3-20020a92d203000000b0034f3220c086sm2389624ily.12.2023.09.26.18.18.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 18:18:29 -0700 (PDT)
Message-ID: <fc915b30-5842-5851-bd76-71c2133685b9@linuxfoundation.org>
Date:   Tue, 26 Sep 2023 19:18:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] selftests: Fix wrong TARGET in kselftest top level
 Makefile
Content-Language: en-US
To:     Juntong Deng <juntong.deng@outlook.com>, shuah@kernel.org,
        mic@digikod.net, brauner@kernel.org, keescook@chromium.org,
        tony.luck@intel.com, gpiccoli@igalia.com, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-riscv@lists.infradead.org,
        bpf@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <VI1P193MB0752596147F224B9F921C85199C3A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <VI1P193MB0752596147F224B9F921C85199C3A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
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

On 9/26/23 12:03, Juntong Deng wrote:
> The 'uevents' subdirectory does not exist in tools/testing/selftests/
> and adding 'uevents' to the TARGETS list results in the following error:
> 
> make[1]: Entering directory 'xx/tools/testing/selftests/uevents'
> make[1]: *** No targets specified and no makefile found. Stop.
> make[1]: Leaving directory 'xx/tools/testing/selftests/uevents'
> 
> What actually exists in tools/testing/selftests/ is the 'uevent'
> subdirectory.
> 
> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> ---

Thank you. Applied now to linux-kselftest fixes for the next rc

thanks,
-- Shuah

