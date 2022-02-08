Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5750C4ADE99
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 17:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240522AbiBHQro (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Feb 2022 11:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238447AbiBHQrn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Feb 2022 11:47:43 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644D5C061578
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Feb 2022 08:47:43 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id z18so14455638ilp.3
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Feb 2022 08:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4ekLUS/+NuWskbgINo6td92M1u4mJlXxAyOideI3Gr0=;
        b=DpHVKDHjmDa073qxMyCoLuFOt8hnFEiMkuUq1DYSSeTD/G5ILe9U6/XG9X+6r+gC8o
         H/xw2xCWTiPCnfUiLEhOtmQeQNDYBmUtLvcel4aNu8VyDV0Tjbf1R6XbEbeShckIt4YY
         pND6cM5UpzTOj2JcFSKwwUsnvZIWwFDEeu0m4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4ekLUS/+NuWskbgINo6td92M1u4mJlXxAyOideI3Gr0=;
        b=Z5gF8Q5+vhRaiS56WGRcbvlFM0Bvvvv2Q3VFW570Q9hmoNCOkrhYHvqJMDK/2hsJw1
         UsiTtVPDKz1WGvZQYd1+Ic04XFk+gZivGDQKXq8GGcY0NVdlCvUYqq8O7vDP7/uIMS1L
         nL4EocXaBxms/5xnd859UHSn52hu3Jg9frebRysBi3z7FRTh8/Af7HeJt4rYZZIxN4D5
         6utBWCsjsgLWtEgRndw7fuT5O68HMfugf1QSp31Hs0Zp+99EX1E1F5glCHx8UUikz+Ni
         NWo6dcbLmdGOfZNPbaYbCbKbMX/imFMJ3sB8dvaK9EkegqXxXkjhUxpdLUtiLp3O7onv
         Y1Rw==
X-Gm-Message-State: AOAM531AMs5+Vq3uSy0tYUiqnU6l6mKWIpYSAB/u6bPpz1jdytAlDY79
        tCxNnsUHwvH/ShHjbc82JPKV5g==
X-Google-Smtp-Source: ABdhPJwUKQH9abD7ya2mFlJ3HnHxdfbTvEysc9E0ncM7IM9nL1Cx9aXZgfZBJ0X+p52/vNAST1wrEg==
X-Received: by 2002:a05:6e02:1449:: with SMTP id p9mr2607103ilo.289.1644338862785;
        Tue, 08 Feb 2022 08:47:42 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id u26sm8155570ior.52.2022.02.08.08.47.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 08:47:42 -0800 (PST)
Subject: Re: kselftest/fixes build: 8 builds: 0 failed, 8 passed, 1 warning
 (linux-kselftest-fixes-5.17-rc3-3-g183f80fd72db)
To:     "kernelci.org bot" <bot@kernelci.org>, kernelci-results@groups.io,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
References: <62028689.1c69fb81.901d.5e69@mx.google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <dae5693e-68bf-1d42-e21e-94ab5429efb5@linuxfoundation.org>
Date:   Tue, 8 Feb 2022 09:47:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <62028689.1c69fb81.901d.5e69@mx.google.com>
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

On 2/8/22 8:04 AM, kernelci.org bot wrote:
> kselftest/fixes build: 8 builds: 0 failed, 8 passed, 1 warning (linux-kselftest-fixes-5.17-rc3-3-g183f80fd72db)
> 
> Full Build Summary: https://kernelci.org/build/kselftest/branch/fixes/kernel/linux-kselftest-fixes-5.17-rc3-3-g183f80fd72db/
> 
> Tree: kselftest
> Branch: fixes
> Git Describe: linux-kselftest-fixes-5.17-rc3-3-g183f80fd72db
> Git Commit: 183f80fd72db42c9cc483aa7a5e8e881355d0b03
> Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
> Built: 4 unique architectures
> 
> Warnings Detected:
> 
> arm64:
> 
> arm:
> 
> i386:
> 
> x86_64:
>      x86_64_defconfig+kselftest (clang-14): 1 warning
> 
> 
> Warnings summary:
> 
>      1    net/core/skbuff.o: warning: objtool: skb_copy()+0x132: unreachable instruction
> 

This is not ksefltest test build failure. Could this be because CONFIG_SKB_EXTENSIONS
isn't enabled in x86_64_defconfig

thanks,
-- Shuah
