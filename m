Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A03B79D505
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 17:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236313AbjILPgE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Sep 2023 11:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233996AbjILPgD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Sep 2023 11:36:03 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD46410DE
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Sep 2023 08:35:59 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-34e1757fe8fso6880695ab.0
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Sep 2023 08:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1694532959; x=1695137759; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JVk5eGuDfgVHDM0pGgUJbtkfG29nSNa44eDk7qo/ifQ=;
        b=HKuXR3toS/pSfem9j6rXiya1e1FBp1FCZA0U3zpVBSFohCjZfIvO2ZfeNbuvCd7/QY
         mskbPJjZ3P49mlprgLQzPk28YHOfyJMvEPPBpBCJPAGhk4kG/FEOImCF5e4QhUqu8xXy
         He9BG+x2wZd1tQi5KlksrmaHrhs6cWp5us4u8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694532959; x=1695137759;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JVk5eGuDfgVHDM0pGgUJbtkfG29nSNa44eDk7qo/ifQ=;
        b=JNrnTb0eNGM60+TTIJoCR86FS8PsnhDDNwL4m2pzwSwDyEfRzWg+GMk4lWhELeSmFj
         IvFouEWFGsKAkP6CBp2f5zMw2/l9yDhgixwg8BFh6Mes778pKLf/tkBXH9lU3XBvrrRR
         YMsa+804OIqz5IPgVT1CMIau6hAnn64syca6Dm7P+IKkrS8s97M0e2QDdUSX7gSdSL/n
         keSFQfr2oBEfangxEa7GoEkF/xLewO5X7lH3Hx+vYFRGBKAlf1nF3M4hPZLbu7tXM/Hn
         jm/ZVBCk+8D1vw329+F1bxyuYjE0EAWHCg54eWqOADy/DLp+JLubGFcR26sc5TH4/OYW
         OHNw==
X-Gm-Message-State: AOJu0YyGQPSmsUSOifPjFUsujYpO2D2iPGN6lp0vf8895oWXXZrDWYFu
        2hbqO0GJxc6eodgK8fMG2/pmKx7yONr2580BcDU=
X-Google-Smtp-Source: AGHT+IFyQYIec+ZkZkMp0oBWAkBhA57O5seJjNF+C8TUcV03cpbY6X3sP3fNhezi8tYZnUouG5KKYw==
X-Received: by 2002:a92:cc4f:0:b0:34f:2e07:685b with SMTP id t15-20020a92cc4f000000b0034f2e07685bmr13596154ilq.0.1694532959145;
        Tue, 12 Sep 2023 08:35:59 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id o16-20020a92dad0000000b0034f33615fc6sm3178884ilq.11.2023.09.12.08.35.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 08:35:58 -0700 (PDT)
Message-ID: <49f6d44b-b6e8-bfca-1df7-3ab94684902e@linuxfoundation.org>
Date:   Tue, 12 Sep 2023 09:35:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [FIX PATCH v2] selftests: tracing: Fix to unmount tracefs for
 recovering environment
To:     Steven Rostedt <rostedt@goodmis.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <169448103881.242465.4589561134225171701.stgit@devnote2>
 <20230911212453.58b9082a@gandalf.local.home>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230911212453.58b9082a@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/11/23 19:24, Steven Rostedt wrote:
> On Tue, 12 Sep 2023 10:10:39 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
>> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>
>> Fix to unmount the tracefs if the ftracetest mounted it for recovering
>> system environment. If the tracefs is already mounted, this does nothing.
>>
>> Suggested-by: Mark Brown <broonie@kernel.org>
>> Link: https://lore.kernel.org/all/29fce076-746c-4650-8358-b4e0fa215cf7@sirena.org.uk/
>> Fixes: cbd965bde74c ("ftrace/selftests: Return the skip code when tracing directory not configured in kernel")
>> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>> ---
>>   Changes in v2:
>>     - use -n option explictly for testing the string is non-zero.
>> ---
>>   tool
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> -- Steve

Thank you all. Applied to linux-kselftest fixes branch for next rc

thanks,
-- Shuah
