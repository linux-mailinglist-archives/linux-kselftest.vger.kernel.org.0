Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626451FFC8A
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jun 2020 22:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729866AbgFRUbh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Jun 2020 16:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbgFRUbf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Jun 2020 16:31:35 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D66EC0613EE
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Jun 2020 13:31:35 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 10so3328008pfx.8
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Jun 2020 13:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2vYguTxknGE8Dx16795P40n1hyMI+4rqo7SoKdZ0n4M=;
        b=jUQk5nqzrPWoyZry6OFj3XXe2iWiykd0oEPPhNsYguTw0jHnq0ttSeXC05Jbcj+aKH
         i2w49bRIQ5UXe4x22BDcgWgjawQPc1s94rGXML4EP3kzY94O7KzGbJmSf8A849v/UXa2
         oRf+0BFrbHWIBtEoBJdAikbWPgiYzu90FKcXuNY+ZRcgFcx+Wm8Nv9EGxMtm1b0LKXn3
         G5kB8nhaWvIOWj9+7918MeRleRN0sfuG6FyMC3ZIONGqNxWyBXVUr67HqJ+qoafWkLB7
         hCFfMmFjlUt/CmROnI8YhwVwYsILkkIJmZo5/IDHjO4Rsp9jrOOJozHQ13XkS+gRKeeM
         4BAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2vYguTxknGE8Dx16795P40n1hyMI+4rqo7SoKdZ0n4M=;
        b=ACnyowP+d7inuBDbxssuWvRHtzuIovPTdouoTIX6eh6WdssTKnsUbRM77PIaohGFCk
         98EP0/8RNfLLWzrdWOykYWuUs2uAoi97tOo+5aY3ajO3IHaqQAvyz260fyRLvBZfQWsG
         n4zUtrr3+8z2OTVOCRCB6iHFLQJe2cXpKQlWzDrx6W1Y968A/GLzjsy21Z1tRss7FkLA
         O1Nu//Q+G4D0K0ONF+bCdC+szv3iggoOD6ayciNoi3/eUy1TapmMF+B5yd5SvWaMLKi8
         HTLJtDOkAvEraGL1eyzKl+Z4xhQzAkcRl/xA7QscSsVcsmgiGtkOT2YOhV7F2G0u8vnh
         lK4w==
X-Gm-Message-State: AOAM533SRAJh0m3ITZCxC0fswvneIE3QqWmJATOzQG0Sbhq+XM2DgvWB
        o99xMOK/Jktz8sRAGYFIwXCvY7OxzT5dyjY9Re4t+g==
X-Google-Smtp-Source: ABdhPJyg7+/EsMv/uILhnCx33cvfvyj/A5rdmlcYEhM69bT4X7pfCnqfldKiOJpntTlq+2IKO59hml9kLz5hSl5KpGY=
X-Received: by 2002:aa7:868f:: with SMTP id d15mr5402182pfo.166.1592512294729;
 Thu, 18 Jun 2020 13:31:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200618123912.64762-1-vitor@massaru.org>
In-Reply-To: <20200618123912.64762-1-vitor@massaru.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 18 Jun 2020 13:31:23 -0700
Message-ID: <CAFd5g47tWA=yqa2zN8f6d=dKDhutU_Dr3JLjAdu8+wRFq9iOyg@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: fix KconfigParseError handling CC_VERSION_TEXT
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

On Thu, Jun 18, 2020 at 5:39 AM Vitor Massaru Iha <vitor@massaru.org> wrote:
>
> Commit 8b59cd81dc5 ("kbuild: ensure full rebuild when the compiler
> is updated") added the environment variable CC_VERSION_TEXT,
> parse_from_string() doesn't expect a string in value field and this
> causes the failure below:
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
