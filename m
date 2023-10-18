Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898B67CE761
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Oct 2023 21:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjJRTJt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Oct 2023 15:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjJRTJt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Oct 2023 15:09:49 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6071F118
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Oct 2023 12:09:47 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-79fab2caf70so59138539f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Oct 2023 12:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1697656186; x=1698260986; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c0ky1wnd5GsHa1/Gq5XBn5olLOi5clFpai88Fqne3Ic=;
        b=MBM6mbGGwY0OOVlChj4bZmAPFnZJfBHGpxKbxSZrMZ6u1f2ULNWs65d0BFSPvmnmPP
         Kkjy9xK8eNwMcP1LD4W17ZJmXx3sJ/zx2xv2BgZC5Xtqhj6ws5jWG2X18u1b7SXpX3OE
         fRJu/bAoeelGdOOAwAb8itLRY+tZFwwFidf6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697656186; x=1698260986;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c0ky1wnd5GsHa1/Gq5XBn5olLOi5clFpai88Fqne3Ic=;
        b=O2grQja1bc/BxrGbJtsF+0jSlLmIQFi5n2X3Jydt0VwjxAuoFBhe6C95P/Dix7iAU5
         qdg6Ftmi1uMq4C44kuElUri9wDdkQNRXS9clB22dO/SjI/3J72b6zbM238oty0NAiU8R
         7K2E5iugV0e/8wiUB1t64JhbW0oR+b2kvtE9Dis7L8ewB+cVb9aHpMlvhhQqYAuR9iyU
         4uDrXj1BB+crwpOALuvoqallGA7e6c9ejLR3GO1FDLailSkIDj7oe91Qv1iSge72Rf8a
         z765cMFJrjvdzM/bPnHC4+b4B52gWYr+3yn1KpBGDAYjmzc+JDc3FfDzBTiG1benLDCJ
         ZqiQ==
X-Gm-Message-State: AOJu0YzuPpvwNpP+vObOdK3AC1viCQ8YwJhYCH/H7X8vuKRmGGuWctPq
        7p/SRJahiKizvgCycvG43E+kjg==
X-Google-Smtp-Source: AGHT+IGoIPCy85/s3YvO+smp2suqtSbF1zjsbHan9WxAd0UULvUIkJocwTzaMM/ukwNQlfidwpLKoQ==
X-Received: by 2002:a92:da12:0:b0:357:4682:d128 with SMTP id z18-20020a92da12000000b003574682d128mr328511ilm.1.1697656186753;
        Wed, 18 Oct 2023 12:09:46 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id y4-20020a927d04000000b0035134215863sm1283159ilc.55.2023.10.18.12.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 12:09:46 -0700 (PDT)
Message-ID: <d686781f-9594-4a57-ba59-9ad26532fd3e@linuxfoundation.org>
Date:   Wed, 18 Oct 2023 13:09:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests:modify the incorrect print format
Content-Language: en-US
To:     zhujun2 <zhujun2@cmss.chinamobile.com>, shuah@kernel.org
Cc:     nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>
References: <20231017020856.7003-1-zhujun2@cmss.chinamobile.com>
 <f1857ee6-1569-4a85-ba51-94c3d841cb61@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <f1857ee6-1569-4a85-ba51-94c3d841cb61@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/17/23 09:54, Shuah Khan wrote:
> On 10/16/23 20:08, zhujun2 wrote:
>> when the argument type is 'unsigned int',printf '%u'
>> in format string
>>
> 
> Please add how you found the problem to the commit log.
> 
>> Signed-off-by: zhujun2 <zhujun2@cmss.chinamobile.com>
> 
> thanks,
> -- Shuah
> 

Applied to linux-kselftest next for Linux 6.7-rc1.

Updated the commit log with details on how the problem was found.

thanks,
-- Shuah

