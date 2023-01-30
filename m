Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2296816EF
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jan 2023 17:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235980AbjA3QwF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Jan 2023 11:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234744AbjA3QwD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Jan 2023 11:52:03 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BB53D924
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 08:52:03 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id u8so5344583ilq.13
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 08:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H5RCrcNjRn0IHRfMfm1ZofUiFxm+I7DHJWe0ZUOClTY=;
        b=Gss3kq48HUmg1lFEIIGPE+n74X2HZ8Qn6l4VCT1b1vA/Xq70VoFL5kb1aa+8bYPp5e
         8bo1zqDYhO+KO9u2V+8CXQoQWPagVQHzWr/owccHj5SX4UoFehliDsPVk2aNETFcCLzE
         YqkztDfGbWS2AweNQuuidJNKeHuf3fyPExL2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H5RCrcNjRn0IHRfMfm1ZofUiFxm+I7DHJWe0ZUOClTY=;
        b=z1C1feehHthaG2IVvGraXwnxx6aCPfPchtTSED4pNfjL8mUm80Qm5w8XfZaKZGZKs9
         zGCunMbSnqhEMGdoxxqSuc1mg0PIYAYuDVZ2d3wLDSuqTEuKpCrZsoalON3lr0jFbZ4A
         YcYLrxADp5njFGeXSXm25dVEzBhtOcR3q+1W7gFQGzF5NGfe8Ery3xeiHyvwnN+g/CuW
         ICPpt5PbTuN2cse6COHCOmRsufZCR6VhmBpOHg7YHHash1YccIWUQjI/xAore0q1u3eu
         5lJLwwMJ90ymXDCSM80wKdaS6zMuAO6qLlmYbuVchAxj6JlMMCzHNp6mcU3GTyzV4d8j
         83Gg==
X-Gm-Message-State: AFqh2krktx7XZDEeBcVvFtxgwOZUmU7eNhbhcrAUjdX0EcPQqwD9H7le
        YpKhGi6ZbivHgGlWDBycVjXeUw==
X-Google-Smtp-Source: AMrXdXtIme1NJywHulBEJer3W+W3TG6mt5R9QJ9SD81kV6tJ0FkgbffaOPaqyVBHA80kVHjwcrlY6Q==
X-Received: by 2002:a92:6e11:0:b0:304:c683:3c8a with SMTP id j17-20020a926e11000000b00304c6833c8amr7062908ilc.3.1675097522508;
        Mon, 30 Jan 2023 08:52:02 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id p3-20020a92d283000000b0030efa122291sm4185286ilp.56.2023.01.30.08.52.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 08:52:01 -0800 (PST)
Message-ID: <e65bb0dd-fb9b-68e0-3a4f-4cc71ce3f886@linuxfoundation.org>
Date:   Mon, 30 Jan 2023 09:52:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 25/34] selftests: seccomp: Fix incorrect kernel headers
 search path
Content-Language: en-US
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230127135755.79929-1-mathieu.desnoyers@efficios.com>
 <20230127135755.79929-26-mathieu.desnoyers@efficios.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230127135755.79929-26-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/27/23 06:57, Mathieu Desnoyers wrote:
> Use $(KHDR_INCLUDES) as lookup path for kernel headers. This prevents
> building against kernel headers from the build environment in scenarios
> where kernel headers are installed into a specific output directory
> (O=...).
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: linux-kselftest@vger.kernel.org
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: <stable@vger.kernel.org>    [5.18+]
> ---
>   tools/testing/selftests/seccomp/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/seccomp/Makefile b/tools/testing/selftests/seccomp/Makefile
> index f017c382c036..584fba487037 100644
> --- a/tools/testing/selftests/seccomp/Makefile
> +++ b/tools/testing/selftests/seccomp/Makefile
> @@ -1,5 +1,5 @@
>   # SPDX-License-Identifier: GPL-2.0
> -CFLAGS += -Wl,-no-as-needed -Wall -isystem ../../../../usr/include/
> +CFLAGS += -Wl,-no-as-needed -Wall $(KHDR_INCLUDES)
>   LDFLAGS += -lpthread
>   LDLIBS += -lcap
>   

Now the right one.

Kees,

I plan to take this through kselftest unless there are conflicts.
In case there are conflicts and you want to take this through yours

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
