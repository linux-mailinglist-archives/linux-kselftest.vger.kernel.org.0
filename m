Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC3E4E47B7
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Mar 2022 21:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiCVUrr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Mar 2022 16:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiCVUrq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Mar 2022 16:47:46 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE8C7560F
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Mar 2022 13:46:18 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id d62so21607996iog.13
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Mar 2022 13:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SW396NDYNeeWQ6iN/XMDLHjaQ5Q2d2vMibTLYG2275Q=;
        b=ErdkwnEI2p17J+VqER/oe3EuGzT3slBGsL4oh5hl5itSWOeP4pbjvJqOKKcjT4jmpH
         FnTWR+nKNFnw24GTVGH5mMe/C1WPgXltm79xHKMEPwC7svGKk+pnkrVr+LNGKmfqgyln
         xjVQ94S4NxY55XEvQ31mOv38y4XqRrqBF1/rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SW396NDYNeeWQ6iN/XMDLHjaQ5Q2d2vMibTLYG2275Q=;
        b=N3gqdE3airydeWOwdeum8ThlWncMSpnYWEJLCvYfWMQDsvdbq7mvwm43JbAF42Eg/N
         UcKTismDu14d8QDtjJGVQh5Uz5YL1zlCI3wJFiuc1rcxiTg/+W2uTYMffRIE1CSJ1isH
         porXyJV+hF9Enc/7Ya35SmAMMuwCURhhaIr68UHNdefwv/iNU5By3xMHnVztLcbpeiLk
         /9ICd2uYt4zJcvZ982f1RguK+3yZLmDhRBE+Ee8cyn5aY+XgW+oktQK+h0yjkMLVpRL+
         FCXghLHZypZWx+5StFU0ljm5/CowaADjqy6qz/lENI33xtm/uNBmG+jj5eSPjKYVPQoN
         3cuA==
X-Gm-Message-State: AOAM531PwBbzxxcyb/m7afSN3805tbFHbc8YGlZVeewwVk+h25+1Rgoj
        +N0DX78vs4fXkeSF9YPXCprxp9Afpync9g==
X-Google-Smtp-Source: ABdhPJwuZuKWj9ImSMdbuNlZEU7NxoTx22NbfWyYRJX8CTkqjha/DNwgxeDvLHDq+PPi1ObfRitBBA==
X-Received: by 2002:a05:6638:24d6:b0:317:cf47:aaf7 with SMTP id y22-20020a05663824d600b00317cf47aaf7mr14467959jat.107.1647981977563;
        Tue, 22 Mar 2022 13:46:17 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id h1-20020a92c261000000b002c81ef3b36fsm4964380ild.35.2022.03.22.13.46.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 13:46:16 -0700 (PDT)
Subject: Re: [bug report] selftests: futex: warning during build with multiple
 jobs
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        KERNEL SELFTEST FRAMEWORK <linux-kselftest@vger.kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        "kernelci@groups.io >> \"kernelci@groups.io\"" <kernelci@groups.io>,
        Collabora Kernel ML <kernel@collabora.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <8907d4a9-2a3f-3442-2c5e-6c34f196d2a8@collabora.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <73470cb9-bb3c-eb4a-a1af-d15f6e15a60b@linuxfoundation.org>
Date:   Tue, 22 Mar 2022 14:46:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <8907d4a9-2a3f-3442-2c5e-6c34f196d2a8@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/13/22 10:09 AM, Muhammad Usama Anjum wrote:
> Hi,
> 
> On linux-next
> cd tools/testing/selftests/futex && make clean -j 32
> gives warning
> make[1]: warning: jobserver unavailable: using -j1.  Add '+' to parent
> make rule.
> The full logs with with different reproduction steps can be found here:
> https://storage.staging.kernelci.org/next/master/next-20220310/x86_64/x86_64_defconfig+kselftest/gcc-10/logs/kselftest.log.
> Usually this type of warning shouldn't come when $MAKE is being used
> instead of make in Makefile.
> 
> Maybe `define CLEAN` inside override construct defined in parent
> makefile is not getting jobsever information when child make process
> executes. I've enabled verbose mode and tried with other makefile flags
> (-p, -d etc) as well. Documentation mentions that if make is unable to
> identify the child process correctly, this warning will appear.
> 
> Please share if you have any thoughts on it.
> 

futex test defines its own clean to catch all the sub-directories
overriding common clean. Changing it not override won't do the
clean properly.

Propose a fix that works for -j build as well keeping override in
place.

thanks,
-- Shuah

