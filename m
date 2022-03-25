Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92EC4E7D19
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Mar 2022 01:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbiCYUAz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Mar 2022 16:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbiCYUAn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Mar 2022 16:00:43 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4FFF9F89
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Mar 2022 12:50:55 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id z8so9291632oix.3
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Mar 2022 12:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yhjO44+D0aYcdcE6np5+AvBqPKTyqdOVFrzIZ1noXSA=;
        b=D1Z0ZOmohogqX9cY1Fn5MmdsU63Ql5MjmB2/cwbcNP79oqgulB9P5vq4095xzwX70F
         mE8qYfHlBI1vzgfkPA+4TMRn67kB4oLbrgGT44kywmHKUL+nq2hWJCfeiRohpnj7PDhH
         pAfuMXJuxOWD22YmZir2dZgsEwUI8KdXF3u78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yhjO44+D0aYcdcE6np5+AvBqPKTyqdOVFrzIZ1noXSA=;
        b=IbxlCOicxIGjXvQ053xspt3iT8fEnMc+o6bT3JQe8hSi5qeA22VBASxI3ICfVD3SdU
         LFq79Tcqe7ajxknzCVh0aHRYyiSmKzqZ8NGYwzof6Tyld3/5sYV9kjU7j+XUraLFBnFp
         /Gi2ar33xLjNnWE/t6OQdaKBLD3bvlx3qtUbpY1RGZ8eOnHop6ELYhwk/N2PqT1fPNXG
         NbK7pe+BCpTKYkUmwE1fmavbJ1f8j8L/nx9Zq8udRhi36tbJIsqqT2WO2RvWG6JyJKor
         /itLmdfgSfm8fAI7Rq6Se4tO56e2RNF9QOLpN01w1LB2tdeUsL0YwucB9ffLAiFBKkuq
         dHLg==
X-Gm-Message-State: AOAM531em5ebRYBaETWDD5sw+Xd6rxTegVEnxW+gF569FLnx6vuPSVMd
        LJfu/hYGTIeDfdBmMU+i4GtUBA==
X-Google-Smtp-Source: ABdhPJzl0o/k3dhCX11aBLeVLMykkE17NaTFp2/mx4UDZ4KUorNcH1gIJsPkfFCAaagVqRtdWqBJRQ==
X-Received: by 2002:a05:6808:d51:b0:2ec:b129:1197 with SMTP id w17-20020a0568080d5100b002ecb1291197mr834192oik.12.1648237848423;
        Fri, 25 Mar 2022 12:50:48 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id g6-20020a056870a24600b000da0df8b3cesm2950982oai.20.2022.03.25.12.50.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 12:50:48 -0700 (PDT)
Subject: Re: [PATCH 2/2] selftests: fix an unused variable warning in pidfd
 selftest
To:     Christian Brauner <brauner@kernel.org>,
        Axel Rasmussen <axelrasmussen@google.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        llvm@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>
References: <20220324223929.1893741-1-axelrasmussen@google.com>
 <20220324223929.1893741-2-axelrasmussen@google.com>
 <20220325152117.mxp35mdfxcgsow6a@wittgenstein>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <5733cfff-d20e-7792-f809-14cc594a1afe@linuxfoundation.org>
Date:   Fri, 25 Mar 2022 13:50:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220325152117.mxp35mdfxcgsow6a@wittgenstein>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/25/22 9:21 AM, Christian Brauner wrote:
> On Thu, Mar 24, 2022 at 03:39:29PM -0700, Axel Rasmussen wrote:
>> I fixed a few warnings like this in commit e2aa5e650b07
>> ("selftests: fixup build warnings in pidfd / clone3 tests"), but I
>> missed this one by mistake. Since this variable is unused, remove it.
>>
>> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
>> ---
> 
> Looks good,
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> 

Thank you both. Will apply it for Linux 5.18-rc2.

thanks,
-- Shuah
