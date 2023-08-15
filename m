Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BC177CE06
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 16:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbjHOOZ5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 10:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237635AbjHOOZy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 10:25:54 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D862BB8
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Aug 2023 07:25:52 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-77dcff76e35so59459539f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Aug 2023 07:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1692109552; x=1692714352;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n++fu5lgK8bUrOQTFhHxiUW13bKpyZhkEp2AxLuZIps=;
        b=PPkwoLdeBQwvyBdlONtZeVF4UZQ5s/LzgIClqs9grEot6Izdv9Ke/ikyhLX8pPIjd/
         sZTfr1PeTrhVoKX9UoF8VYWBEjJBkbQt5lSoDhylx66e6929F3MSO/W2d0E2FIfmC6Mo
         tWEcISBSOtjqdnJz3A1ArCnKxozU3gH+jTLTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692109552; x=1692714352;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n++fu5lgK8bUrOQTFhHxiUW13bKpyZhkEp2AxLuZIps=;
        b=ZWNnftcGyqAYXp4UWJ7o2KuzBY9QmUV03IahgO3C6w4YHHy58MTa5UZXLfA4jQBs4y
         7yXQxh2+wNEhz/lnVv17oFuCb2Hn7LzyO/ZX1bUGj4GYEtt/WBYz5Gk5VKQC8jypj0Hm
         d6XZG3oHcG6zJlMAZdsJj0kWZSmLpazR5IRbRAIB0jOdeFldKygnWDW3AIUUVCW4exBT
         /KFNOyVFl54ujG0ZaQXwN8WDTZBshESM8FCTSUd8faXgHMy/hc42DS45pevD4ytJMSKQ
         jQSsWVI1C5rPq1Y3QM3XOqPXo2Dkmuhx3X9Um8iCxH/fLBiv+k9G1c21Hsdqj9W4MwXw
         yzbQ==
X-Gm-Message-State: AOJu0YwF3VzWhbaAL3wRRl+ip1yMj2kJwo4fYCvi8/didMt5C11J9K/w
        Ug3CwwnNdlwpadNJiaKyWycEUMIyj/kr2uPKMxw=
X-Google-Smtp-Source: AGHT+IGwqEa3upbwsHqNdEkwQ7urSGaTr4VyveV6m36h3gTUy2GHNdUExTNgQZUhjJQBn5mYuliEJA==
X-Received: by 2002:a92:c749:0:b0:349:5c87:e712 with SMTP id y9-20020a92c749000000b003495c87e712mr14072947ilp.1.1692109552265;
        Tue, 15 Aug 2023 07:25:52 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id t1-20020a056e02060100b0034a9a9a2016sm1760463ils.23.2023.08.15.07.25.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 07:25:51 -0700 (PDT)
Message-ID: <3efa3710-4e8b-d187-a24d-ff85858e37fe@linuxfoundation.org>
Date:   Tue, 15 Aug 2023 08:25:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [GIT PULL] nolibc changes for 6.6-rc1
To:     Willy Tarreau <w@1wt.eu>, "Paul E. McKenney" <paulmck@kernel.org>
Cc:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        shuah <shuah@kernel.org>
References: <20230806172245.GA26239@1wt.eu>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230806172245.GA26239@1wt.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/6/23 11:22, Willy Tarreau wrote:
> Hi Shuah, hi Paul,
> 
> I'm sending you the list of planned nolibc changes for 6.6. A doc update
> may possibly follow a bit later to try to document the contribution
> process. We also noticed a slight increase in binary sizes that might
> be fixed soon but I wouldn't bet on this since it will require lot of
> testing again and I'd rather postpone this by default. In any case I
> have no intent to push any significant updates/fixes for 6.6 at this
> point.
> 
> I'm also pasting a summary of the changes in this pull request, feel
> free to use it for the merge commit message if you need.
> 
> For any question or if anything is not clear, do not hesitate to ask!
> 
> Thanks,
> Willy
> 
> ----- changes ------
> Nolibc:
>    - improved portability by removing build errors with -ENOSYS
>    - added syscall6() on MIPS to support pselect6() and mmap()
>    - added setvbuf(), rmdir(), pipe(), pipe2()
>    - add support for ppc/ppc64
>    - environ is no longer optional
>    - fixed frame pointer issues at -O0
>    - dropped sys_stat() in favor of sys_statx()
>    - centralized _start_c() to remove lots of asm code
>    - switched size_t to __SIZE_TYPE__
> 
> Selftests:
>    - improved status reporting (success/warning/failure counts, path to log file)
>    - various code cleanups (indent, unused variables, ...)
>    - more consistent test numbering
>    - enabled compiler warnings
>    - dropped unreliable chmod_net test
>    - improved reliability (create /dev/zero & /tmp, rely less on /proc)
>    - new tests (brk/sbrk/mmap/munmap)
>    - improved compatibility with musl
>    - new run-nolibc-test target to build and run natively
>    - new run-libc-test target to build and run against native libc
>    - made the cmdline parser more reliable against boolean arguments
>    - dropped dependency on memfd for vfprintf() test
>    - nolibc-test is no longer stripped
>    - added support for extending ARCH via XARCH
> 
> Other:
>    - add Thomas as co-maintainer
> -----------
> 
> The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:
> 
>    Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)
> 
> are available in the Git repository at:
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git/ 20230806-for-6.6-1
> 
> for you to fetch changes up to d98c1e27e46e47a3ae67e1d048f153598ba82611:
> 
>    tools/nolibc: stackprotector.h: make __stack_chk_init static (2023-08-06 18:44:47 +0200)
> 

Hi Willy,

I am sorry for the delay on this. I was traveling last week
and getting back to digging myself out of emails.

I am having trouble pulling this request though:

git request-pull https://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git/ 20230806-for-6.6-1

gives me the following error

fatal: Not a valid revision: git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git/

I don't see a tag at https://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git

thanks,
-- Shuah
