Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5A41FFC7F
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jun 2020 22:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbgFRU36 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Jun 2020 16:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgFRU35 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Jun 2020 16:29:57 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A118AC06174E
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Jun 2020 13:29:57 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id h22so3236387pjf.1
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Jun 2020 13:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5/hCpa4EUzmgzyQWCDiDnoXra6cXP6DdcXvsMo077Gs=;
        b=RDbK89/DJFlPYBLi55AUzHik7hIPiAtrhNB3Qa2pdC8sq3oAKuRj+VhPo1gjJBe1GN
         pIusZmQqosz28RAPNaShZUmvRSvTZ4EzkJRinInfNnyR2OhGWhAIW7UagQLSbf8lTAKN
         KmPwknx0k7749KSqeRDXxoQZoh9ar4v/7B03lx02PuZFdeTdROniKhr+wLSEjik/enwI
         ihdjQVuWtYdfF+yQTXSerlGuocHTzvCp4gXjS8YmZne6mTxZIOWtwUp4HhH76bM5g8pQ
         /zR0EgeK5AgsprFpSFT4Wne7/sUVbgYXMvlO//r2X8YcgZr2pMj/0qoxF7dgOlNjLPZm
         b+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5/hCpa4EUzmgzyQWCDiDnoXra6cXP6DdcXvsMo077Gs=;
        b=nIORjlotmwuiv2+eED1BYJlPGBwYviWOz4Q8Fm9w3K6x0FxJq0Gc60fC5iUwDRAmWg
         yw/9GntFnKEsrTOUhivhEcy3XNuTjRGsu9XhdS1LTwcCH1OetM1dTZ6fJIIxC0s3HRJv
         U//G/FwZwgBXR8WeILCax3OVYhEFbwp+kGSxt91vHu6nmiiAQQ2lPAsUu6xilCfBTV7d
         yIC6Z0DQpUMCNcIcOGO6J/vphMkpzR37LT7pUaI7AYKMAqqsPDwJgIub6049qmgE8xTm
         R1Qmm33XNgcP63EAT7fjRnWzMGJyg1rJOdntkX1Kg7VIPsiH1ThZ9s2zMW/4KwGQaqG9
         as5g==
X-Gm-Message-State: AOAM5322sSzJJMsfALmbobjD9iaeMn/V2rciBMxOIAox+phh82XVJchl
        mug8k89WsI4mWk7IpxYkVL+Fdhyt/O6nV5wDQXtj0g==
X-Google-Smtp-Source: ABdhPJzxU3pY06CWSm4LO7FME2n4fLBB6pVcJXHzNqN2LnUXllGbawGj0C6+Ydhb05A/tvBLq04fczMZ38da+qd63co=
X-Received: by 2002:a17:90a:df82:: with SMTP id p2mr74335pjv.217.1592512197024;
 Thu, 18 Jun 2020 13:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200618035736.245566-1-vitor@massaru.org>
In-Reply-To: <20200618035736.245566-1-vitor@massaru.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 18 Jun 2020 13:29:46 -0700
Message-ID: <CAFd5g45AB8K-p78GRmauRPbkXLU572D2tuMTc0pumL+EgDA52Q@mail.gmail.com>
Subject: Re: [PATCH] kunit: fix KconfigParseError by ignoring CC_VERSION_TEXT
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 17, 2020 at 8:57 PM Vitor Massaru Iha <vitor@massaru.org> wrote:
>
> Commit 8b59cd81dc5 ("kbuild: ensure full rebuild when the compiler
> is updated") added the environment variable CC_VERSION_TEXT,
> parse_from_string() doesn't expect a string and this causes the
> failure below:
>
> [iha@bbking linux]$ tools/testing/kunit/kunit.py run --timeout=60
> [00:20:12] Configuring KUnit Kernel ...
> Generating .config ...
> Traceback (most recent call last):
>   File "tools/testing/kunit/kunit.py", line 347, in <module>
>     main(sys.argv[1:])
>   File "tools/testing/kunit/kunit.py", line 257, in main
>     result = run_tests(linux, request)
>   File "tools/testing/kunit/kunit.py", line 134, in run_tests
>     config_result = config_tests(linux, config_request)
>   File "tools/testing/kunit/kunit.py", line 64, in config_tests
>     success = linux.build_reconfig(request.build_dir, request.make_options)
>   File "/home/iha/lkmp/linux/tools/testing/kunit/kunit_kernel.py", line 161, in build_reconfig
>     return self.build_config(build_dir, make_options)
>   File "/home/iha/lkmp/linux/tools/testing/kunit/kunit_kernel.py", line 145, in build_config
>     return self.validate_config(build_dir)
>   File "/home/iha/lkmp/linux/tools/testing/kunit/kunit_kernel.py", line 124, in validate_config
>     validated_kconfig.read_from_file(kconfig_path)
>   File "/home/iha/lkmp/linux/tools/testing/kunit/kunit_config.py", line 89, in read_from_file
>     self.parse_from_string(f.read())
>   File "/home/iha/lkmp/linux/tools/testing/kunit/kunit_config.py", line 85, in parse_from_string
>     raise KconfigParseError('Failed to parse: ' + line)
> kunit_config.KconfigParseError: Failed to parse: CONFIG_CC_VERSION_TEXT="gcc (GCC) 10.1.1 20200507 (Red Hat 10.1.1-1)"

I am pretty there is already a fix out for this issue:

https://patchwork.kernel.org/patch/11592313/

Can you confirm?
