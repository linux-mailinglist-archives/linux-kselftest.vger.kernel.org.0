Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F384AFD65
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Feb 2022 20:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbiBIT3F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Feb 2022 14:29:05 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236200AbiBIT2G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Feb 2022 14:28:06 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434F3E016D86
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Feb 2022 11:26:42 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id n17so4561679iod.4
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Feb 2022 11:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=uJdZ7oqw+QQlIzr17qqdwzwfregbqFYC9sj7YzP1HYY=;
        b=fYz8PGQMd29UOajQhZT2X83HUOpYoErPoGjRcNCM4yVnITAfRZgeDe7UMSvRLFe4oS
         1k0WRleLPHEuUfcf6Ia64xTw2nV6RRaWj+2NboS6Cc4j+5N0sOvshg1GvERuJ5jICtiI
         eslZtJUanhs7SqaFUnbPEbDHd79D+9p9fHxms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uJdZ7oqw+QQlIzr17qqdwzwfregbqFYC9sj7YzP1HYY=;
        b=6rY+AA1m6gpaTDaoVVtTy3p4dLUNu/seFex5UFBn7BUriGTBxerHtkCkpG1N1bKzLh
         qJmWu1j9SQyLmFYlgMm/fWiJVQBhs8OsRymxCnoV15UVWRCQuVROF0lkKkvm8hdoLOEg
         8ic+voT1BUw3bpmNaqOpZkjNa1Vc581xumf87FzOUO4RsnT8tk8H9T5Hf6i/RP3Fv1OI
         sozKenf1Ui5YpZH2llTBP/gWUy45+08IxYOos8GGEpM11gBgsG5Ln4LHQ8KaMGFLQ8TY
         bZkkrai+wWxJ/jg5ijNwiJPYcrShw+2PY+r9+8tboq6rB3baQJE/EpAsXNjawGTul5r2
         +Whg==
X-Gm-Message-State: AOAM531inLE1cl9drL86z2J7/mqdHvScyTAK62azgLrYHJIvvnUnmcDF
        4NiwzInxpyuyQk4SAYsTqvi/9g==
X-Google-Smtp-Source: ABdhPJw5MU53uJwqzrLtiF140G+vIQQ1qVQ9YiU1UrUUC9dzqLmlqHS4jlfDiPOVYXjgDYKvgAj0iA==
X-Received: by 2002:a6b:6f09:: with SMTP id k9mr1864423ioc.61.1644434801604;
        Wed, 09 Feb 2022 11:26:41 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id o22sm9992022iow.37.2022.02.09.11.26.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 11:26:41 -0800 (PST)
Subject: Re: [PATCH] selftests/ftrace: Do not trace do_softirq because of
 PREEMPT_RT
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, joseph.salisbury@canonical.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220209162430.286578-1-krzysztof.kozlowski@canonical.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <aa0833ac-154e-9a66-c3f5-7c3b98f15f19@linuxfoundation.org>
Date:   Wed, 9 Feb 2022 12:26:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220209162430.286578-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/9/22 9:24 AM, Krzysztof Kozlowski wrote:
> The PREEMPT_RT patchset does not use soft IRQs thus trying to filter for
> do_softirq fails for such kernel:
> 
>    echo do_softirq
>    ftracetest: 81: echo: echo: I/O error
> 
> Choose some other externally visible function for the test.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> ---
> 
> I understand that the failure does not exist on mainline kernel (only
> with PREEMPT_RT patchset) but the change does not harm it.
> 
> If it is not suitable alone, please consider it for RT patchset.
> ---
>   .../selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc      | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
> index e96e279e0533..1d0c7601865f 100644
> --- a/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
> @@ -19,7 +19,7 @@ fail() { # mesg
>   
>   FILTER=set_ftrace_filter
>   FUNC1="schedule"
> -FUNC2="do_softirq"
> +FUNC2="_printk"
>   
>   ALL_FUNCS="#### all functions enabled ####"
>   
> 

Change looks good to me.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

