Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E70052225C
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 May 2022 19:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348006AbiEJR1t (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 May 2022 13:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244581AbiEJR1q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 May 2022 13:27:46 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC51E14E2F9
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 10:23:48 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id f4so19245610iov.2
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 10:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6Mxaa9zldI5g5gROrpqfa7o89lmkZmvApfkpzCQDPTU=;
        b=AqPeMT0SfdkcixR4qTLiKvPqwwAuytjFV8n2Yvx3BSgwqKAJvP5LvLj3rtkIl2es/e
         64yTs9oQhh5YjDeVal2RN6YJuj6SEtQ9z0SYX9hjU86wc2qrEXbZHC9ItVt1hPNFsZBg
         gGFspwf3Y85ZxHvo2TWE98JmpBCkvdm568XP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6Mxaa9zldI5g5gROrpqfa7o89lmkZmvApfkpzCQDPTU=;
        b=J1P2mRJ6VaMy4ayIT3oF0QY068O7+bdhdZk4FLIHcJBSeFNWjnDJh8YmGxc3e1Gise
         5s7zajv+Wulz54YcyYAW/2zWOP1dfe6KCYJeqf5K7/QMkCVNzbGx1Fa15EZeuBzhLfnZ
         zzR/pNqmR5WureuaK3eXW2+TLfzL0ox0N4UL0GCoaYpRdFTC4Z945VQ5alidjwXzdCpl
         AjftDi/CKlihJXiFNvT60v0ffhdHwectwRFILRi2hOnPAQc5AkSSYLgwZZi5Oz0A016/
         xGhSo39zLcuzA6OWzKgtHl6QqzUQYWzqcAo4IhtHpBBjCQWfLzzTVal82PjcI3DghzbG
         Rflg==
X-Gm-Message-State: AOAM530wXsL3eZ9UMeBK6VILb/z8vGVX/q+HPQ0bQmtxIMRajue6RC11
        BrwjFpBZ5+y5Luy8rCji9nHSiA==
X-Google-Smtp-Source: ABdhPJzHhtMQmgp8/vmBWxqTfP452Z9e4+tpfHIHJpQACUXUa7/7eBesCYXoQa3kpPxoYc7bPtJx5Q==
X-Received: by 2002:a05:6638:2182:b0:32b:8ed4:4e26 with SMTP id s2-20020a056638218200b0032b8ed44e26mr10782682jaj.225.1652203427897;
        Tue, 10 May 2022 10:23:47 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id a23-20020a056638059700b0032b3a781769sm4508648jar.45.2022.05.10.10.23.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 10:23:47 -0700 (PDT)
Subject: Re: [PATCH v1 4/5] selftests/arm64: Remove casts to/from void in
 check_tags_inclusion
To:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Joey Gouly <joey.gouly@arm.com>, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220510164520.768783-1-broonie@kernel.org>
 <20220510164520.768783-5-broonie@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <5c990941-d3a9-0add-29bc-f59ec7789d37@linuxfoundation.org>
Date:   Tue, 10 May 2022 11:23:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220510164520.768783-5-broonie@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/10/22 10:45 AM, Mark Brown wrote:
> Void pointers may be freely used with other pointer types in C, any casts
> between void * and other pointer types serve no purpose other than to
> mask potential warnings. Drop such casts from check_tags_inclusion to
> help with future review of the code.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   .../arm64/mte/check_tags_inclusion.c          | 24 +++++++++----------
>   1 file changed, 12 insertions(+), 12 deletions(-)
> 

Looks good to me.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
