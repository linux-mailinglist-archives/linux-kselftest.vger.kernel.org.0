Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B7C1FBC15
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jun 2020 18:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730372AbgFPQsU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Jun 2020 12:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728861AbgFPQsQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Jun 2020 12:48:16 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C87C061573
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Jun 2020 09:48:15 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id d4so2063851otk.2
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Jun 2020 09:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8rUF2LfAoNKaTd4vWHI3MdLVKx6YmjE2fH2WB8RQ4cM=;
        b=Qnh9zamxRTz9tICXi94zKmLrRe6pOvx4YLq+3bTEUhbgMqMofGpjsQqCdAGWQXyYUb
         hNLm6hJDZdEiLiN0yh093FhlPeGpkdZFLrH2oOiBgSyL/kJVazmmL1KVFsb6ncYeThfg
         ZJpDoiwuvkW5604CWku7XL/I679fBoHG9VIa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8rUF2LfAoNKaTd4vWHI3MdLVKx6YmjE2fH2WB8RQ4cM=;
        b=HPND9Brih39/GNJpwnaUtolq9uc10TjebwqfEyPrdUMlU6dERY69HAoH+GltGGFt/Y
         LrHwshaOIU/D+TJD7o4rhKNTQ918ShRsQP9/UGtt455T7/cWcBrPLDGtsTSonfQMfASo
         Kqjz5UzXKH9IBe77BhXiYQRJUroi6pTtTmjnJp1yJniLSz+ecaCd6aRxebo1vLr0k/+u
         VxA6VP9MYl7ITFmy8JjsZX8NEQ1qA7S5XUm2+NPlaB7++pRB0FxDrnYtsgm2yoS6FsEw
         5v740YsULGxFq7PPCVQ5RY/KaasL7bzdaJ8L1lEIe7NUwpD6PFzH94OM4741v62n+34d
         qdDA==
X-Gm-Message-State: AOAM530lUazbSwSKgw1KSUxbzQ2h1x6WVGMU91i0Ks6czogalg/1hJoW
        BSwFvG8HFe4eneHKcNfJKXLV7Q==
X-Google-Smtp-Source: ABdhPJxsRUguwXES0v09lV50WYgYiQaZP7HUqFVEuuzjIDuUKNsegdaX7ZDaQWw1JcDtGU4Ink7YHA==
X-Received: by 2002:a05:6830:1657:: with SMTP id h23mr3371442otr.339.1592326094539;
        Tue, 16 Jun 2020 09:48:14 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id z7sm4156278oto.2.2020.06.16.09.48.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 09:48:13 -0700 (PDT)
Subject: Re: [PATCH v3 4/7] selftests/ftrace: Convert required interface
 checks into requires list
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        skhan@linuxfoundation.org
References: <159115200085.70027.6141550347953439240.stgit@devnote2>
 <159115203782.70027.2241223276591824366.stgit@devnote2>
 <1cf646af-ef25-a7df-9df3-1e6aa8e6a9c8@linuxfoundation.org>
 <20200610145535.747d2765d60e6e3923441768@kernel.org>
 <5a658ffa-348a-436d-fb74-e01f56541d6b@linuxfoundation.org>
 <20200610093206.5b9fb1b7@oasis.local.home>
 <f8cc0d67-3f35-134a-a6c4-ad4a98a215a3@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <41b50b37-c9cb-9e7c-3ea7-d0824a41c03c@linuxfoundation.org>
Date:   Tue, 16 Jun 2020 10:48:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <f8cc0d67-3f35-134a-a6c4-ad4a98a215a3@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/11/20 6:03 AM, Shuah Khan wrote:
> On 6/10/20 7:32 AM, Steven Rostedt wrote:
>> On Wed, 10 Jun 2020 06:04:33 -0600
>> Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>>>> Steve, what would you think?
>>>
>>> No worries. As far as kselftest tree is concrned, I can apply these
>>> after rc1 comes out with Tom's patch.
>>>
>>> Or I can give Ack and Steve can take these through tracing tree.
>>
>> All my patches have already made it to Linus's tree. Perhaps
>> cherry-pick the commit needed from Linus's tree (it shouldn't break
>> anything when Linus pulls it). Just let Linus know what you did, and
>> everything should be fine.
>>
> 
> Good to know. I will get these in.
> 

I applied all 7 patches to linux-kselftest next for my second update.
I saw a couple of merge problems with 4/7 patch even when I applied
it on top of with Tom's patch.

I resolved them and amended the commit message to indicate the merge.
It is straight forward. Please check for sanity.

thanks,
-- Shuah
