Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 882034A4D63
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jan 2022 18:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381025AbiAaRh6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jan 2022 12:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381040AbiAaRh5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jan 2022 12:37:57 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF762C06173D
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Jan 2022 09:37:57 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id s1so12050043ilj.7
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Jan 2022 09:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8XiEhEIc6GPrOy61yWxlOIFlYNHT1dKB1NGb7FtAFv8=;
        b=eitccCFFfue7+J/VoBFC3XgyotyS9xyGKLRYGs9u4JIUeo3e//pzWH29TGLwyiIGaJ
         Sc/xy9hvdCtOSNr/C5zarL0GDTP95d5T2WgrPuwsBdHh8d7ytjkp3FqbJQQ1B+KniG2g
         u9FweIeFiyHtgS01zJCVMG2eorfA6gIqWNi3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8XiEhEIc6GPrOy61yWxlOIFlYNHT1dKB1NGb7FtAFv8=;
        b=Z/xUXIeN1wo7OtmE4TmOlJtlmIwFd92S0K+J1mQgEiN3XXz4FE/cdKYW33/M428Kw2
         sWEZhmPYMUM3bZhxlntf4EumR5dedjCaOdoe3zMlrvdFx/P09X7tHE96om/lCOq4VZLG
         cGsM7mp+omHe0E5mWHb+Ze7+2yASPYGL+a52PTu4H209vKRMpEF0zAiPMHoCutFpCX/6
         gKCFkWWX7mbL98vFopd24MznXH5UjuVqPuRHYG7hN7JjQf5MERQGKT8c8avLvJfQAkFD
         /vk0DDyAFDrNUAaO+ZpNwytOhRBxHqJLxTYJREh82bGMF4YHuNvLFhljCYsu66GFwUq6
         6YKw==
X-Gm-Message-State: AOAM532JVI+6TLpjPzCM/B2IUd/aN4pRlaiPh2rwPClDihEx9wSgitxv
        lfjSXNuhSzm22Yt5UtFptWVWlQ==
X-Google-Smtp-Source: ABdhPJy82tBGgtocPF6fYHvtMkpmZ07MAXznuTPlai5ZQ11Xm+VEykni4kt+G/4+lrWjvPjWaohedQ==
X-Received: by 2002:a05:6e02:152c:: with SMTP id i12mr12746996ilu.215.1643650677138;
        Mon, 31 Jan 2022 09:37:57 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id z5sm19459022ioq.47.2022.01.31.09.37.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 09:37:56 -0800 (PST)
Subject: Re: [PATCH v4] kselftest: Fix vdso_test_abi return status
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220131113405.25977-1-vincenzo.frascino@arm.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <299a9d32-ec50-029b-b8c7-b89aff6331a4@linuxfoundation.org>
Date:   Mon, 31 Jan 2022 10:37:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220131113405.25977-1-vincenzo.frascino@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/31/22 4:34 AM, Vincenzo Frascino wrote:
> vdso_test_abi contains a batch of tests that verify the validity of the
> vDSO ABI.
> 
> When a vDSO symbol is not found the relevant test is skipped reporting
> KSFT_SKIP. All the tests return values are then added in a single
> variable which is checked to verify failures. This approach can have
> side effects which result in reporting the wrong kselftest exit status.
> 
> Fix vdso_test_abi verifying the return code of each test separately.
> 
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Reported-by: Cristian Marussi <cristian.marussi@arm.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>   tools/testing/selftests/vDSO/vdso_test_abi.c | 135 +++++++++----------
>   1 file changed, 62 insertions(+), 73 deletions(-)
> 

Thank you. Applied to linux-kselftest fixes for rc3

thanks,
-- Shuah
