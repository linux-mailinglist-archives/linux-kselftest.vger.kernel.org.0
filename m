Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F25774BCC
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 22:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbjHHUzr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 16:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234996AbjHHUze (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 16:55:34 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04314271E
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Aug 2023 13:44:07 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-780c89d1998so38454339f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Aug 2023 13:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1691527446; x=1692132246;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rjv8XIJqffOkKpyD7dykI7sGXhmoGCSRZKfdAmqWIW8=;
        b=XMLm8Vt+Alntw+x3XwstRjO4/8p7+j5rftUaBVS44dgGBGtV2/ERFPJBSnLIi+yOWQ
         DDRqu//Q3ZaKBf7UTGPcnN9mTRD+RCpmeTREphyqI6yANvi4bsSeffcVG+6MoTZgV9Ur
         uEJ8pSxVKym1aYP3YzUiQU+j8XA1yF0iryqGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691527446; x=1692132246;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rjv8XIJqffOkKpyD7dykI7sGXhmoGCSRZKfdAmqWIW8=;
        b=hgBu4GxYW0ym19r/zGRYdUTbVmbcrIjbKI8UOcNP92J/Up6YY3cVa1ubSf5+/TnucE
         eZOvbLqcYwhMihRYa18akShOeCU45xdG9baqPt7vrbnjcoExwzLUsa5NC1KH9btTwok0
         VMqwxmaJpGJqUNnQe/6QsGfmfvSjehm5WMgPWMpOIawMP5QH6yrn11Vl3VCObmq/bb4c
         RYIwg120PO+QnU7cmi1rC2cBlgqHjfzZPfrW564e9qhyHZp2tM5B0+lHRqWuDiOMI3DW
         kdIjisMs35nHnKRljtGTrEIH5fQ7HyXrV7E9KGkPGpqhgiRP3QMDRQwuKPVdCffz0HDA
         /iCw==
X-Gm-Message-State: AOJu0YwXkEe94bhtir2gYgen+K4ORZcshZh/Ih9QhTcpz4XdybAb1Qwu
        Qih1OiKPvoXV34S+kU+fqoLZog==
X-Google-Smtp-Source: AGHT+IFJfvWoVvPgmusc54DOL0NDBOmrgtKVAa7yCf/zmoS8y2tSADL1GPkwyJ8VfLnyse3zjqERkw==
X-Received: by 2002:a05:6602:29c7:b0:780:d6ef:160 with SMTP id z7-20020a05660229c700b00780d6ef0160mr1133187ioq.1.1691527445894;
        Tue, 08 Aug 2023 13:44:05 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id x19-20020a5d9913000000b007836a9ca101sm3890696iol.22.2023.08.08.13.44.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 13:44:05 -0700 (PDT)
Message-ID: <c1971f70-6c1d-4cd5-e130-ff948942f5b3@linuxfoundation.org>
Date:   Tue, 8 Aug 2023 14:44:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/4] RSEQ selftests updates
Content-Language: en-US
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230515135801.15220-1-mathieu.desnoyers@efficios.com>
 <fd64bf35-8e18-8da7-d83c-882fdc60a87d@efficios.com>
 <f0fdf470-f25d-b51f-8a2d-f891ea7b94b1@linuxfoundation.org>
 <4fb64f73-12eb-d6a6-6f84-97e6195d7a5b@efficios.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <4fb64f73-12eb-d6a6-6f84-97e6195d7a5b@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/7/23 13:38, Mathieu Desnoyers wrote:
> On 8/7/23 14:53, Shuah Khan wrote:
>> On 6/6/23 07:36, Mathieu Desnoyers wrote:
>>> Hi Peter,
>>>
>>> Can you queue those fixes through your tree ?
>>>
>>
>>
>> Peter, Mathieu,
>>
>> Doesn't look like this series has been pickedup?
> 
> Not AFAIK. Peter, if you have this somewhere in your tip queue, please let us know.
> 
>>
>> I can take these in for 6.6-rc1 if there are no dependencies
>> on other trees.
> 
> It should not have dependencies with other trees.
> 

Applied to linux-kselftest next for Linux 6.6-rc1.

thanks,
-- Shuah

