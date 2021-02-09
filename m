Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBD83144D8
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Feb 2021 01:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhBIAZR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Feb 2021 19:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbhBIAZQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Feb 2021 19:25:16 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C1CC061786
        for <linux-kselftest@vger.kernel.org>; Mon,  8 Feb 2021 16:24:35 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id q4so6316697otm.9
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Feb 2021 16:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7kDiAEc8hVWsP8AT+4zrE196f9WKY5uk7YuIQwZzsY8=;
        b=GT6yf9L8n9BFgjyjmJcuHtb5TFfyA2v6JOq7OUfEowzeXh++HxYYtWilXaczafmSYD
         wICb7yrKCJRqzitSWEWGSi4ltVQ4e+/qLtP7iFrZT+2hwH+ZQSXGjKl6/m99PnEa9utP
         AV/7bwbclQY15Q17x2GvEG0JL8vrsR2Vv8nYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7kDiAEc8hVWsP8AT+4zrE196f9WKY5uk7YuIQwZzsY8=;
        b=N8glVF2FQWOl0DA2Pts95Qag07pBQBt9SZgSYARTU14+jN4F+FUszL4228yF9PcrHA
         EtSRbBLUFXuFGvsNaqvCsbVTAt96CAQt2eHPhXjhPcisbyS9ZyK0WGBztZxzbhD4s1RU
         suiJfyo1XDdMVNIYe1tCpugWqKn1/IOaUR5A1YWmoWgHeX3hAIa3FDkCzdhGGXWB+B42
         U1l6Qd1PNCQuLErd6vnKSYjuuNHM9hDkbmWvBKHQSkDhOLw5YEjXv9QnNq4j6LF9ziWk
         mTvDUjBwRgd5HZhR4Tz3ifbJRxpJaWBKUnbmsuxrZ86sx34tVqTviCkd80VzU3PyyKom
         GtHw==
X-Gm-Message-State: AOAM531SqPRAh3gsty0tyMIjD6eaLlPVcAfhUPcMu4w/3GMCs1RvGIWo
        ShyEY8wy7waDtI+jR3oCzmw/Zsx4aY832Q==
X-Google-Smtp-Source: ABdhPJwSqNVILwdqvhuucfnk6VdFDFxH25yzE+cXGeyRuHRTNXDomPv0/rvWiWCd62PN1yMkVzUgZA==
X-Received: by 2002:a05:6830:19e7:: with SMTP id t7mr4551934ott.211.1612830275065;
        Mon, 08 Feb 2021 16:24:35 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k15sm4054954otp.10.2021.02.08.16.24.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 16:24:34 -0800 (PST)
Subject: Re: [PATCH] selftests/core: fix close_range_test build after XFAIL
 removal
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Tobias Klauser <tklauser@distanz.ch>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20201218112428.13662-1-tklauser@distanz.ch>
 <20201218122555.rlazqtui5pn5wm3u@wittgenstein>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <1ae15d95-51e5-cbd5-537f-833d4dc9bf97@linuxfoundation.org>
Date:   Mon, 8 Feb 2021 17:24:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20201218122555.rlazqtui5pn5wm3u@wittgenstein>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/18/20 5:25 AM, Christian Brauner wrote:
> On Fri, Dec 18, 2020 at 12:24:28PM +0100, Tobias Klauser wrote:
>> XFAIL was removed in commit 9847d24af95c ("selftests/harness: Refactor
>> XFAIL into SKIP") and its use in close_range_test was already replaced
>> by commit 1d44d0dd61b6 ("selftests: core: use SKIP instead of XFAIL in
>> close_range_test.c"). However, commit 23afeaeff3d9 ("selftests: core:
>> add tests for CLOSE_RANGE_CLOEXEC") introduced usage of XFAIL in
>> TEST(close_range_cloexec). Use SKIP there as well.
>>
>> Cc: Giuseppe Scrivano <gscrivan@redhat.com>
>> Fixes: 23afeaeff3d9 ("selftests: core: add tests for CLOSE_RANGE_CLOEXEC")
>> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
>> ---
> 
> Thanks for this! I already have a fix for this in my tree but I'm
> dropping it and taking yours instead.
> 
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Shuah, I'll be taking this through my tree since I'm adding selftests
> for a vfs regression fix that I'll be sending before Sunday.
> 
> Christian
> 

Thank you Christian

thanks,
-- Shuah
