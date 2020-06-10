Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D681F5429
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jun 2020 14:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbgFJMEj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Jun 2020 08:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbgFJMEi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Jun 2020 08:04:38 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789FDC03E96F
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Jun 2020 05:04:36 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id e5so1465509ote.11
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Jun 2020 05:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hDQ1f7GxgIenpnrfjjsSwEQqXFg9qmR/mq8VF3wwVUw=;
        b=U0TFHza/mFwgCdbNAv5y57CHubhJ88QTZKe9L3Vs3W+l/4+m27dDr7hIOoieGo37tf
         TtsHk5+lewifx8kIHPNKwzjN+HCJLMhzwWH3zBeW8zmYCJ53/zWq8MNsMMf8FvqSXPXw
         3vLmGQYass+cSLWRudAMX9WLj8fJChZoc3FgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hDQ1f7GxgIenpnrfjjsSwEQqXFg9qmR/mq8VF3wwVUw=;
        b=H5aKANRKvLG/bW1TMCyK2ShO/eN+KLarTNS9uaZypDhWPO8NGRugQW1qgkARxLNAI8
         hAjtE5JPDgOpWAc7YfVcY+EsPT70kuLhZt7bxfaFPLnbjGZV0XkG8jpZcng4XGCuGIJK
         edhbwXgDuB/Hjr2y7dVLdCW0ay5QOK0/OpTbN6D2wt9RmHxsqnSd7rKhNEdx9F35pqmF
         yxa/6P7P8Th1j7VI2lNkzTFKZQwEYQ+L6Ic1Rf0yf2+Lw0JBSBP6HAb3UUCqz4zo6VZ8
         VzCLGTOsQaiUZSXH7MGuCsVGaP997r3MGapPRraC8g+he4Hnignv9h9o1X3bg26JUmWy
         7mOw==
X-Gm-Message-State: AOAM5313/ALSHcbiAjfawsAkPDIIZiQDf9ALsGetNhc9uIbzwj9+L5J7
        KAFTeRSazvd09Wcr4ju/O3jn9g==
X-Google-Smtp-Source: ABdhPJwyIl3tV0H71EcAz7e72pJ1J+W64/fKEusa03TZIBDnAl5bReM9AsiTKcLQgDj8CoAwE2SQfA==
X-Received: by 2002:a9d:d86:: with SMTP id 6mr2460944ots.83.1591790675575;
        Wed, 10 Jun 2020 05:04:35 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id q2sm2841277oti.36.2020.06.10.05.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 05:04:34 -0700 (PDT)
Subject: Re: [PATCH v3 4/7] selftests/ftrace: Convert required interface
 checks into requires list
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <159115200085.70027.6141550347953439240.stgit@devnote2>
 <159115203782.70027.2241223276591824366.stgit@devnote2>
 <1cf646af-ef25-a7df-9df3-1e6aa8e6a9c8@linuxfoundation.org>
 <20200610145535.747d2765d60e6e3923441768@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <5a658ffa-348a-436d-fb74-e01f56541d6b@linuxfoundation.org>
Date:   Wed, 10 Jun 2020 06:04:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200610145535.747d2765d60e6e3923441768@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/9/20 11:55 PM, Masami Hiramatsu wrote:
> Hi Shuah,
> 
> On Tue, 9 Jun 2020 14:41:27 -0600
> Shuah Khan <skhan@linuxfoundation.org> wrote:
> 
>> On 6/2/20 8:40 PM, Masami Hiramatsu wrote:
>>> Convert the required tracefs interface checking code with
>>> requires: list.
>>>
>>> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
>>> Reviewed-by: Tom Zanussi <zanussi@kernel.org>
>>> ---
>>>     Changes in v2: Fix trigger-onchange-action-hist.tc requires list.
>>
>> Masami,
>>
>> This patch doesn't apply to linux-kselftest next
>>
>> Patches 1-3 applied fine and this one failed. For now I will
>> hold off on applying this series.
> 
> Yes, there is another patch posted by Tom with his ftrace enhancement
> in tracing-next. Thus I commented on 0/7 as below.
> 

Sorry I made a note of it when I first looked at the series and
missed that when I was applying patches.

> ----
> Since this series depends on following 2 commits,
> 
> commit 619ee76f5c9f ("selftests/ftrace: Return unsupported if no
>   error_log file") on Shuah's Kselftest tree
> commit bea24f766efc ("selftests/ftrace: Distinguish between hist
>   and synthetic event checks") on Steven's Tracing tree
> 
> This can be applied on the tree which merged both of them.
> ----
> 
> I'm not sure how do I handle it. It is OK just modifying this
> for linux-kselftest, but in that case we will need another
> patch after merged both.
> 
> IMHO, since the kselftest must run correctly on older kernel,
> (and ftracetest does) Tom's kselftest patch should be merged
> into linux-kselftest instead of tracing tree.
> 
> Steve, what would you think?
> 

No worries. As far as kselftest tree is concrned, I can apply these
after rc1 comes out with Tom's patch.

Or I can give Ack and Steve can take these through tracing tree.


thanks,
-- Shuah

