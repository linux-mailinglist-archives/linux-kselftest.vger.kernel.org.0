Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7ED1157CA
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2019 20:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbfLFTbu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Dec 2019 14:31:50 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33095 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfLFTbu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Dec 2019 14:31:50 -0500
Received: by mail-lj1-f194.google.com with SMTP id 21so8899535ljr.0;
        Fri, 06 Dec 2019 11:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c0i7PQFXimXWpGVLkYYKBm4f7YSggydB6SsE85wLPz0=;
        b=CGqxsXJ1NAkcws9QIo/5PmdAISTzNi1qBfMkvLLDNP52aJNNld2YyCheGY8hVccaCQ
         nHq2UHGPRcxS+fdB2mY10PfOzpVhdmcsCg7uNxWsrN5LHjp3hXEwnTEX6EjMFq2GzpRE
         FGSlObTNDSZEZLRKW2OZQGBUsN4r0gkqUvD5gLzNvR3Px1OMY314OaQmJGLmO+l8q3d8
         jCk4VfSIp9iPF2db8IM/NeSGdDaVt3KcC3oOUtBjYwSfgIG5POjUsKR/HTy3c7bx/S6S
         31WTMmPP5EgDt5svdCeZLTOkGDsjQJDPIYCnVM6sNMSnpancUVPQp+bnScpolg45mSym
         kDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c0i7PQFXimXWpGVLkYYKBm4f7YSggydB6SsE85wLPz0=;
        b=e6Rv20xrsAbNmVzblr2VEK4hHPtPyn/Ry6qfrd7KZUeQhmxjWgWi3F5FCiFBnd021B
         Oh0N+sKnbZJ5if6VmWYMQrZenMD2XM/SHTo/59a0DisHvhM9WRXKeOt+uivJulPDoknD
         lkIa6aujw9tZHFXlRT2MI/ZKiD2MOr3p3UWqH4NfEwlBM+CqcFU7fegZV6dtGSMFqrw8
         XdH1bmpxuaggA3Fm5niYEpaRm+qOVqG0qfoO+NYS0DuYqEVQbWDmJzzaErFHRl0BsNpP
         6YYJ5ld/z04oHAMkxfAhxitWggqNv8HeyMybEpDNMvVK3DAh7SsjJRR4sUs+gfFg9t2T
         K5uQ==
X-Gm-Message-State: APjAAAVhjOQBwkLa0aaA0GTZ0Q+2lbwe33fIXWnOVVNnVY72R8Nx3VAc
        H6DCxOMYBOJlRW8NsW0enilt8fZ1+9RROg5Uyhs=
X-Google-Smtp-Source: APXvYqy64ysU6bQkPmBJYnQVN8J6Dx04EnlY29IwsfHNNDiNvdNu37U8eOIv5chOGy87VHdjwHl/keyJWALg1TEjMhk=
X-Received: by 2002:a05:651c:102c:: with SMTP id w12mr9448372ljm.53.1575660707792;
 Fri, 06 Dec 2019 11:31:47 -0800 (PST)
MIME-Version: 1.0
References: <20191202114221.827-1-sjpark@amazon.com>
In-Reply-To: <20191202114221.827-1-sjpark@amazon.com>
From:   SeongJae Park <sj38.park@gmail.com>
Date:   Fri, 6 Dec 2019 20:31:21 +0100
Message-ID: <CAEjAshq_nfY2MRuXwvN7hoX9jOxkO1C+g5AH1KJbDS=wxVSC5Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] kselftest/runner: Print new line in print of timeout log
To:     SeongJae Park <sjpark@amazon.com>
Cc:     Shuah Khan <shuah@kernel.org>, Kees Cook <keescook@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello Shuah,


May I ask your comments?


Thanks,
SeongJae Park

On Mon, Dec 2, 2019 at 12:42 PM SeongJae Park <sjpark@amazon.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> If a timeout failure occurs, kselftest kills the test process and prints
> the timeout log.  If the test process has killed while printing a log
> that ends with new line, the timeout log can be printed in middle of the
> test process output so that it can be seems like a comment, as below:
>
>     # test_process_log  not ok 3 selftests: timers: nsleep-lat # TIMEOUT
>
> This commit avoids such problem by printing one more line before the
> TIMEOUT failure log.
>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>  tools/testing/selftests/kselftest/runner.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
> index 84de7bc74f2c..a8d20cbb711c 100644
> --- a/tools/testing/selftests/kselftest/runner.sh
> +++ b/tools/testing/selftests/kselftest/runner.sh
> @@ -79,6 +79,7 @@ run_one()
>                 if [ $rc -eq $skip_rc ]; then   \
>                         echo "not ok $test_num $TEST_HDR_MSG # SKIP"
>                 elif [ $rc -eq $timeout_rc ]; then \
> +                       echo "#"
>                         echo "not ok $test_num $TEST_HDR_MSG # TIMEOUT"
>                 else
>                         echo "not ok $test_num $TEST_HDR_MSG # exit=$rc"
> --
> 2.17.1
>
