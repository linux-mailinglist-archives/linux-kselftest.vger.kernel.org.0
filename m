Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF1B15AF8B
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2020 19:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbgBLSPu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Feb 2020 13:15:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:49274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727264AbgBLSPu (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Feb 2020 13:15:50 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 546BE2073C;
        Wed, 12 Feb 2020 18:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581531349;
        bh=kOqJbVCC1I1+rcE3QheAKMQBYpL4dBwVq3+rzFsB9tU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FcMbBJTt7N6Bx+hLXCgOyEiN56/H0SNvmHg8/MkdLDbkI9gXt8cCu4PZcJMcUxvKm
         LY56E+Ep3Y90MAoTwDNHtDSh4pSM29XsRjbWjfdqMgm9Df3qivGI+hie7vqgnijR2j
         4GKzQ4SiPmpJzt3Ooi3l1bmxhMW+C7+rOc7KxdT8=
Subject: Re: [PATCH] selftests: use LDLIBS for libraries instead of LDFLAGS
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kselftest@vger.kernel.org, avagin@gmail.com,
        linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>, shuah <shuah@kernel.org>
References: <20200212140040.126747-1-dima@arista.com>
From:   shuah <shuah@kernel.org>
Message-ID: <db01c4e9-c236-3847-f812-943e4442f048@kernel.org>
Date:   Wed, 12 Feb 2020 11:15:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200212140040.126747-1-dima@arista.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/12/20 7:00 AM, Dmitry Safonov wrote:
> While building selftests, the following errors were observed:
>> tools/testing/selftests/timens'
>> gcc -Wall -Werror -pthread  -lrt -ldl  timens.c  -o tools/testing/selftests/timens/timens
>> /usr/bin/ld: /tmp/ccGy5CST.o: in function `check_config_posix_timers':
>> timens.c:(.text+0x65a): undefined reference to `timer_create'
>> collect2: error: ld returned 1 exit status
> 
> Quoting commit 870f193d48c2 ("selftests: net: use LDLIBS instead of
> LDFLAGS"):
> 
> The default Makefile rule looks like:
> 
> $(CC) $(CFLAGS) $(LDFLAGS) $@ $^ $(LDLIBS)
> 
> When linking is done by gcc itself, no issue, but when it needs to be passed
> to proper ld, only LDLIBS follows and then ld cannot know what libs to link
> with.
> 
> More detail:
> https://www.gnu.org/software/make/manual/html_node/Implicit-Variables.html
> 
> LDFLAGS
> Extra flags to give to compilers when they are supposed to invoke the linker,
> ‘ld’, such as -L. Libraries (-lfoo) should be added to the LDLIBS variable
> instead.
> 
> LDLIBS
> Library flags or names given to compilers when they are supposed to invoke the
> linker, ‘ld’. LOADLIBES is a deprecated (but still supported) alternative to
> LDLIBS. Non-library linker flags, such as -L, should go in the LDFLAGS
> variable.
> 
> While at here, correct other selftests, not only timens ones.
> 
> Reported-by: Shuah Khan <skhan@kernel.org>
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>   tools/testing/selftests/futex/functional/Makefile | 2 +-
>   tools/testing/selftests/net/Makefile              | 4 ++--
>   tools/testing/selftests/rtc/Makefile              | 2 +-
>   tools/testing/selftests/timens/Makefile           | 2 +-
>   4 files changed, 5 insertions(+), 5 deletions(-)
> 


Looks good. Thanks for fixing it quickly.

Please split these into 4 patches and send one for each test.

For timens:

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
