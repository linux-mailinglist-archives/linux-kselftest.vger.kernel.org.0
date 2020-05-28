Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A99C1E67A9
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 May 2020 18:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405158AbgE1Qp7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 May 2020 12:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405081AbgE1Qp6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 May 2020 12:45:58 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D146C08C5C6
        for <linux-kselftest@vger.kernel.org>; Thu, 28 May 2020 09:45:58 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id o13so2871883otl.5
        for <linux-kselftest@vger.kernel.org>; Thu, 28 May 2020 09:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tqJPlIw10s9Ij/zrETOCDphuCrsusdSvfBPan3DJSeI=;
        b=ba0UjTXhf1uH8fl/cUodMv7++faO5D0gtXNXssPhpJqkjn2JLzJTRBq7AE79JvIzhT
         qpHKNdxWaYvgFKswEhjsbL5KHh5JpO8dC7r8tGO4iiV6Xr4KuzdQgkSmzkDKNTUX8Vhu
         YE/kneNase+CEm39JNI37HEDNo5NqK/Pei0rE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tqJPlIw10s9Ij/zrETOCDphuCrsusdSvfBPan3DJSeI=;
        b=VX1+kfuBaYPOB+HviufTJ6aQQSdbdmdeg2PBEgUKHH1J2oIEqohcpOmouZ+MjMmW3a
         g0hJLbUmu0HaL33fSW4xCoiyHxUdTzL3BFRXBOizBUJ6wLNjn9V69Rv1EBAtvCl1ovFh
         y6k6rIV48mxMxjqP8F9g4IcZCeiDijR4br400Q4aGj8F0Xl8o7TBBapHgp+S8wuG1UVJ
         L6QZvGCqciwxMpQjmXwTs2tbVKQs5M8/5O4iqrkgC69SMJzU2WhAUlB+W6TLt4vRMXKY
         X+xG0B82Iavrj8ZqkLunwlf5rJ7RpLzuK/pEf8SMhQVYMNDqWDHbdoG/1esAKFT1Ft+3
         xAig==
X-Gm-Message-State: AOAM530bOrFd3PMZvJ4o3YjnplII9fgCZY9BFwHskBBGrjAB9AfqLbl/
        SQfLFEFzAyaMp2gbHNuzxwG0vw==
X-Google-Smtp-Source: ABdhPJx2phhHCCTSMcd8x9B0836mZiGJ+WjKKrBJbJbydW5C7TtGeSceoh3cnrWSDcF7DjPlCyWvCQ==
X-Received: by 2002:a05:6830:1601:: with SMTP id g1mr2753646otr.228.1590684357287;
        Thu, 28 May 2020 09:45:57 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id t6sm1748396otb.27.2020.05.28.09.45.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 09:45:56 -0700 (PDT)
Subject: Re: [PATCH] selftests/ftrace: Return unsupported if no error_log file
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <159040205682.10129.10826221002090446642.stgit@devnote2>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <bfaf034d-4bbb-1ca2-1cd7-309d4df79403@linuxfoundation.org>
Date:   Thu, 28 May 2020 10:45:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <159040205682.10129.10826221002090446642.stgit@devnote2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/25/20 4:20 AM, Masami Hiramatsu wrote:
> Check whether error_log file exists in tracing/error_log testcase
> and return UNSUPPORTED if no error_log file.
> 
> This can happen if we run the ftracetest on the older stable
> kernel.
> 
> Fixes: 4eab1cc461a6 ("selftests/ftrace: Add tracing/error_log testcase")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>   .../ftrace/test.d/ftrace/tracing-error-log.tc      |    2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/tracing-error-log.tc b/tools/testing/selftests/ftrace/test.d/ftrace/tracing-error-log.tc
> index 021c03fd885d..23465823532b 100644
> --- a/tools/testing/selftests/ftrace/test.d/ftrace/tracing-error-log.tc
> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/tracing-error-log.tc
> @@ -14,6 +14,8 @@ if [ ! -f set_event ]; then
>       exit_unsupported
>   fi
>   
> +[ -f error_log ] || exit_unsupported
> +
>   ftrace_errlog_check 'event filter parse error' '((sig >= 10 && sig < 15) || dsig ^== 17) && comm != bash' 'events/signal/signal_generate/filter'
>   
>   exit 0
> 

Applied to

git.kernel.org/pub/scm/linux/kernel/git/shuah/linux kselftest.git/ next
branch for Linux 5.8-rc1

thanks,
-- Shuah
