Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043D34C4D24
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Feb 2022 19:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiBYSCT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Feb 2022 13:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbiBYSCR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Feb 2022 13:02:17 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1B52510EF
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Feb 2022 10:01:43 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id i1so4899205ila.7
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Feb 2022 10:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jmPNe5w2igTeTdG9i+t0C+LJ8u5o2P/TYchcIcjneOM=;
        b=UAtesJgznmZkD5fCGtm7cVlSmUmJT0RNZpejtSXRc54OGmXFBgYOWb/Wup7KhHpZKC
         6KWhHF8W1G1Ar4MY86dZ37zqxQGpS7toDNK1lTeVdbPXk6nEldKmki8uV/GjOhMvxQXK
         Iv7jJ7uL0UjIyqHbsp9eAtA8Hy4HY5ToJCNJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jmPNe5w2igTeTdG9i+t0C+LJ8u5o2P/TYchcIcjneOM=;
        b=TzBnne99pq57qMJaFaU0RBJRiEtK5OJV1MDus809ndxHguaORI47ImHkVubxV9dFlB
         Ksp6ViaNFYh3cUnQuD4Sy0Jg4iyvSKw8kUQr0OszMjpT+BhjEB5SHUnLh+WeKg2JUviG
         54PjER1T/EnDGjlAO4FmzRe5mVCewoZdp7eKBeDnejdZGl36yrN68F3D9RUakXdM0YHr
         y8rE+m1+Y3vu5NA6RaVsVBeiZ9w+pTTdJhCyjmHGVcMMVDjGzjlIpHEYGBvaZ+JFN/f6
         BQsIaEDJnbKlaCSSEaVUuNlJerBJfAGFPqeFoOz9jPpyNQAPiChGeDbnZUsX6Ctj6q6E
         C3yw==
X-Gm-Message-State: AOAM533hZehysGYu53UcJP1sN3b/93APDw8m3wE7DI161oItDVqGBHTz
        c8anpLMLu0MATwtAIVc99oKoig==
X-Google-Smtp-Source: ABdhPJyeoCYCoIZbD+oRa0e576ynpqdPVl3oq4IN0xpZ37BARybE4JvNHHYpQXh+IBx1zozXaExyNA==
X-Received: by 2002:a05:6e02:178b:b0:2c2:81f5:3cbb with SMTP id y11-20020a056e02178b00b002c281f53cbbmr7469031ilu.296.1645812102498;
        Fri, 25 Feb 2022 10:01:42 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id a2-20020a056e02120200b002c21a18437csm1932389ilq.40.2022.02.25.10.01.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 10:01:42 -0800 (PST)
Subject: Re: [PATCH V2] selftests: Fix build when $(O) points to a relative
 path
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>
Cc:     kernel@collabora.com, kernelci@groups.io,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220216223817.1386745-1-usama.anjum@collabora.com>
 <46489cd9-fb7a-5a4b-7f36-1c9f6566bd93@collabora.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <63870982-62ba-97f2-5ee2-d4457a7a5cdb@linuxfoundation.org>
Date:   Fri, 25 Feb 2022 11:01:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <46489cd9-fb7a-5a4b-7f36-1c9f6566bd93@collabora.com>
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

On 2/25/22 10:22 AM, Muhammad Usama Anjum wrote:
> Any thoughts about it?
> 

No to post please.

> On 2/17/22 3:38 AM, Muhammad Usama Anjum wrote:
>> Build of bpf and tc-testing selftests fails when the relative path of
>> the build directory is specified.
>>
>> make -C tools/testing/selftests O=build0
>> make[1]: Entering directory '/linux_mainline/tools/testing/selftests/bpf'
>> ../../../scripts/Makefile.include:4: *** O=build0 does not exist.  Stop.
>> make[1]: Entering directory '/linux_mainline/tools/testing/selftests/tc-testing'
>> ../../../scripts/Makefile.include:4: *** O=build0 does not exist.  Stop.
>>
>> Makefiles of bpf and tc-testing include scripts/Makefile.include file.
>> This file has sanity checking inside it which checks the output path.
>> The output path is not relative to the bpf or tc-testing. The sanity
>> check fails. Expand the output path to get rid of this error. The fix is
>> the same as mentioned in commit 150a27328b68 ("bpf, preload: Fix build
>> when $(O) points to a relative path").
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>> Changes in V2:
>> Add more explaination to the commit message.
>> Support make install as well.

Looks god to me. I can pull this in for Linux 5.18-rc1

thanks,
-- Shuah
