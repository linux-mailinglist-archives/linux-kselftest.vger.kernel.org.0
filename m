Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8124ADE97
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 17:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiBHQrP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Feb 2022 11:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240522AbiBHQrP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Feb 2022 11:47:15 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CB1C06157A
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Feb 2022 08:47:13 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id d188so21906569iof.7
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Feb 2022 08:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IEhpb/5gTsoo5ZYwkUwsZcKZY4W8dLpouGRd8+DZ0cE=;
        b=SwHlhemNAmAHQgDmHS2+ugJ85slb/2ImYaAabaQR4q2jCV656kpFKk3g3zHld5WgL9
         YSm57fuIStVZqVx4jl1b4AF/8DQFVKJd8f9FbMguIvwFVXCriDqkJs3ZAALOAVxTabwP
         jTHeNUTH4pesLacJEGdZSxVUsCrGr0fC8SLFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IEhpb/5gTsoo5ZYwkUwsZcKZY4W8dLpouGRd8+DZ0cE=;
        b=O+yMhEJkMpMIrJZSI40OguJLkjld8df3jzWhLb9gRZAxvhVNjYHvv9aLjyrLxgro5E
         nD1nNUuA6Dgerw6/zxttXa5QnoBZQzFi6c4eozcgDDpGgMI2jCQk0Ygvh4tEUCh08cdw
         0HbsKTD5zaFyN4xGvyHN2dWl/OtRbUaI6zwHiXx1nm9xoWbbYSZrpTJePGdRWA3oj4o2
         TqLs1H/5hLOYouC6MkxHThQnbfIcipYkYlCr6KIoWbiATvdNL9X3A0JsLWkuz0dSxJwK
         pv1Fig6VO6wc1LkOJPKT5KoDvBLwv6mZjppPfIj94fo9q1jTvV7h8Kn9ikAW4zkdT/Dm
         Nh7w==
X-Gm-Message-State: AOAM531Z4BbJyVdCAtM+T98XZUO4l/eJE+uqTYVszkJ/ipnJdPte9eat
        Ai5AXzJB+/6Snrf/vM2E7sKYcA==
X-Google-Smtp-Source: ABdhPJyz78UYFszSYYf30LgMsEHnYn0C08Z7BzKs/td4B+sMvk23d6Ua3anJ+x4y/p1lR2PtF3QcQg==
X-Received: by 2002:a05:6602:2a4b:: with SMTP id k11mr2455068iov.136.1644338832997;
        Tue, 08 Feb 2022 08:47:12 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id a4sm7309166ili.80.2022.02.08.08.47.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 08:47:12 -0800 (PST)
Subject: Re: kselftest/next build: 7 builds: 0 failed, 7 passed, 1 warning
 (v5.17-rc1-2-g6d468898d774)
To:     "kernelci.org bot" <bot@kernelci.org>, kernelci-results@groups.io,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
References: <620289a2.1c69fb81.35dec.875a@mx.google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <db5f313a-7c88-4f6a-e4d5-2f0fec15beca@linuxfoundation.org>
Date:   Tue, 8 Feb 2022 09:47:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <620289a2.1c69fb81.35dec.875a@mx.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/8/22 8:17 AM, kernelci.org bot wrote:
> kselftest/next build: 7 builds: 0 failed, 7 passed, 1 warning (v5.17-rc1-2-g6d468898d774)
> 
> Full Build Summary: https://kernelci.org/build/kselftest/branch/next/kernel/v5.17-rc1-2-g6d468898d774/
> 
> Tree: kselftest
> Branch: next
> Git Describe: v5.17-rc1-2-g6d468898d774
> Git Commit: 6d468898d7744564ea9cb59d8de8f74660421599
> Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
> Built: 3 unique architectures
> 
> Warnings Detected:
> 
> arm64:
> 
> arm:
> 
> x86_64:
>      x86_64_defconfig+kselftest (clang-14): 1 warning?> 
> 
> Warnings summary:
> 
>      1    net/core/skbuff.o: warning: objtool: skb_copy()+0x132: unreachable instruction
> 

This is not ksefltest test build failure. Could this be because CONFIG_SKB_EXTENSIONS
isn't enabled in x86_64_defconfig

thanks,
-- Shuah
