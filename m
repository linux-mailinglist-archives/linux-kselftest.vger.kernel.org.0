Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3426367D8DB
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jan 2023 23:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbjAZWyn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Jan 2023 17:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbjAZWye (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Jan 2023 17:54:34 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F422E0D9
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Jan 2023 14:54:29 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id f8so1438837ilj.5
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Jan 2023 14:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4YOljWyGQiSDuWcg4PQG6vSllKDFhB9jVbes21tjtGs=;
        b=YK8qP085Bvta3Nfw6rwSlDN3b2YCnwzGBK+SlpHBmCm8Cca5p1UcVmiO+CgBRuaGru
         mtfMKh8eO+ltKfPoOwqCC75A8aJdkaTZuhM62ADET+LG21AOPi513wU1nIdR1YqTtU1t
         SNKUbHOdlwb8sHPb32SqisRbzaLS7k8Y2LK1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4YOljWyGQiSDuWcg4PQG6vSllKDFhB9jVbes21tjtGs=;
        b=rGmA2C3o4idTwx84HceYmMKgW39agfShM2rwUiKDiWI/PLP4BSf6wU8g3SfPQPHwyv
         zDk7tWrPJELecjtsdUDkVg/4N08dhlS77s3fdO9+PRUmGqpoMnfCfVT6WCggbXyfgcau
         FhoeR66e4W4Qzqk2b1jl4DSP1PNx0nOzZN2kw+LKI0BLC9BvqBjrnVegxp7lu36UiY0T
         N9G44dDDrosKz7IuVdTc3s8HgCETSYz9HkSMR+GdPF/48SeQL6Uq/UUQvS9rSmbWw19G
         imuX8CTcHtL1ElX1nxrhMlKIFs8DIy46iZ1auQ9QADTR+HSg7Z5RS+8lR+lGPm0CFVou
         wdAw==
X-Gm-Message-State: AO0yUKWugrLeokERry8TAJKTsVYAyw2zQLCn4wBmlNRZq6MdP6C8VIIn
        JNZV7jplsF/e5w5VtOAXW9hRxphK2T8o25op
X-Google-Smtp-Source: AK7set9imA/gYnoLNO9UwE1NbKQQNZm5PPCorp0iwwdfhgwKqUaGGLBLOCuzHOqwTIU1hvJsLx611Q==
X-Received: by 2002:a92:6810:0:b0:310:9adc:e1bb with SMTP id d16-20020a926810000000b003109adce1bbmr1453260ilc.0.1674773669138;
        Thu, 26 Jan 2023 14:54:29 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id h31-20020a022b1f000000b00363f8e0ab41sm836828jaa.152.2023.01.26.14.54.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 14:54:28 -0800 (PST)
Message-ID: <604dc49a-fd03-4407-0e13-d16022ba81c4@linuxfoundation.org>
Date:   Thu, 26 Jan 2023 15:54:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC PATCH] selftests: Fix: search kernel headers in
 $(KHDR_INCLUDES)
Content-Language: en-US
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230117201724.11869-1-mathieu.desnoyers@efficios.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230117201724.11869-1-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/17/23 13:17, Mathieu Desnoyers wrote:
> Use $(KHDR_INCLUDES) as lookup path for kernel headers. This prevents
> building against kernel headers from the build environment in scenarios
> where kernel headers are installed into a specific output directory
> (O=...).
> 

The change looks good to me.
> [ Hopefully I did not break too many things with this selftests-wide
>    change. Additional testing would be welcome before merging, especially
>    given that whenever we get this wrong, it appears to fall-back on the
>    build environment system headers, which hides issues. This applies on
>    top of v6.2-rc3. ]
> 

One concern with treewide change is the merge conflicts. Selftests
go through several trees as you may already know.

Would it be possible for you send patch series instead? Patch series
will help us avoid merge conflict issues.

I will run tests on this patch and let you know in the meatime.

thanks,
-- Shuah
