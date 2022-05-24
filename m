Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADE5532D26
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 May 2022 17:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238766AbiEXPQ6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 May 2022 11:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233605AbiEXPQ4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 May 2022 11:16:56 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FF019284
        for <linux-kselftest@vger.kernel.org>; Tue, 24 May 2022 08:16:54 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id v9so17085658oie.5
        for <linux-kselftest@vger.kernel.org>; Tue, 24 May 2022 08:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oPCAh/MbNJ7vTzTZ4OICpOYd9k58HhsAFhhZYJpObms=;
        b=T5qQDbRM+U5IieOuT0qtFSvOh21ZF62wGaKxGUwtlgHrCMThlJ4Gw8B91aRK5nhj6z
         tf3F4MNHUJRdtwCO5KyQVrSuhoSvGAW9/0FpJ9aFpULcf/cxjwQr4/cq8KVWICgAFT0O
         gjrxNVlAu2FnAoO3mV25cFGeGCr3EMHsxwtXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oPCAh/MbNJ7vTzTZ4OICpOYd9k58HhsAFhhZYJpObms=;
        b=wCud1rNMQQUw5GpiL/jRQlBOEo/ZV+5YGnBEv6pPCp5uxNtHEJzZ5UkOLo8xkVu9xG
         qtKy8GP3Wpf/qrhB8FGesJVFnhKxknUoZkU7SBscUuAWjSgsbh1AcFiMMwQdfZdbvoF9
         3K/ZIn/f92V9ZMrGiIOlihMhCxEEL0pjL0rlitP8wGb6ZURrlqu+R4k/XbLYUFc6xjaj
         2sv29dipuygBju9LqFTLIJ5JyzZ8ZffZNqy/ljBrN1mmber2Tv989HyGODdh3GdvrOIN
         yIHUJgXKk+Nc3I2W+517mtSJ5awh+Jeyj7fd/9h2fyTafP1kwLV72JjPpgtd9CaeLMAy
         DQag==
X-Gm-Message-State: AOAM5312B4q4JvQq3NVdBSDemrIiAZMk+qHMD+w0OeSHz0ekvgzax3Ec
        LzZkW8p5+VjinuJmLq5MPKBm8A==
X-Google-Smtp-Source: ABdhPJy6HF1goWkqu/fQqtmL0KamjoLObtK9Bu/HN/WxBuE04sk+qxQqHp02nRL9NMAISKf3ZyQt9g==
X-Received: by 2002:a05:6808:248:b0:32b:6aa:6cbd with SMTP id m8-20020a056808024800b0032b06aa6cbdmr2437182oie.34.1653405413669;
        Tue, 24 May 2022 08:16:53 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id x26-20020a056830245a00b0060afe803e5bsm3972666otr.35.2022.05.24.08.16.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 08:16:53 -0700 (PDT)
Subject: Re: [GIT PULL] KUnit update for Linux 5.19-rc1
To:     linux-kselftest@vger.kernel.org
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        shuah <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <76e8af6c-9757-4367-1407-84fbad96cc8d@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <cee5ce2e-faa0-4acf-35b9-1c16c890c040@linuxfoundation.org>
Date:   Tue, 24 May 2022 09:16:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <76e8af6c-9757-4367-1407-84fbad96cc8d@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/23/22 12:21 PM, Shuah Khan wrote:
> Hi Linus,
> 
> Please pull the following KUnit update for Linux 5.19-rc1.
> 
> This KUnit update for Linux 5.19-rc1 consists of several fixes, cleanups,
> and enhancements to tests and framework:
> 
> - introduces _NULL and _NOT_NULL macros to pointer error checks
> 
> - reworks kunit_resource allocation policy to fix memory leaks when
>    caller doesn't specify free() function to be used when allocating
>    memory using kunit_add_resource() and kunit_alloc_resource() funcs.
> 
> - adds ability to specify suite-level init and exit functions
> 
> diff is attached.
> 
> thanks,
> -- Shuah
> 

This bounced from linux-kselftest list  as the diff exceeded the message
size. Sorry for the noise for others that are seeing this twice (minus
the diff).

FYI that the following KUnit pull request has been sent for Linux 5.19-rc1

thanks,
-- Shuah

> ----------------------------------------------------------------
> The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:
> 
>    Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-5.19-rc1
> 
> for you to fetch changes up to e7eaffce47b7db72b077630dbe836f0c4132496d:
> 
>    kunit: tool: Use qemu-system-i386 for i386 runs (2022-05-18 17:03:54 -0600)
> 
> ----------------------------------------------------------------
> linux-kselftest-kunit-5.19-rc1
> 
> This KUnit update for Linux 5.19-rc1 consists of several fixes, cleanups,
> and enhancements to tests and framework:
> 
> - introduces _NULL and _NOT_NULL macros to pointer error checks
> 
> - reworks kunit_resource allocation policy to fix memory leaks when
>    caller doesn't specify free() function to be used when allocating
>    memory using kunit_add_resource() and kunit_alloc_resource() funcs.
> 
> - adds ability to specify suite-level init and exit functions
> 
> ----------------------------------------------------------------
> Brendan Higgins (2):
>        kunit: add support for kunit_suites that reference init code
>        kunit: tool: update riscv QEMU config with new serial dependency
> 
> Daniel Latypov (25):
>        kunit: tool: make --json handling a bit clearer
>        kunit: tool: drop unused KernelDirectoryPath var
>        kunit: tool: drop last uses of collections.namedtuple
>        kunit: tool: simplify code since build_dir can't be None
>        kunit: tool: readability tweaks in KernelCI json generation logic
>        kunit: tool: refactor how we plumb metadata into JSON
>        kunit: tool: properly report the used arch for --json, or '' if not known
>        kunit: tool: more descriptive metavars/--help output
>        kunit: split resource API from test.h into new resource.h
>        kunit: split resource API impl from test.c into new resource.c
>        Documentation: kunit: update kconfig options needed for UML coverage
>        kunit: rename print_subtest_{start,end} for clarity (s/subtest/suite)
>        kunit: add ability to specify suite-level init and exit functions
>        kfence: test: use new suite_{init/exit} support, add .kunitconfig
>        kunit: fix debugfs code to use enum kunit_status, not bool
>        lib/Kconfig.debug: change KUnit tests to default to KUNIT_ALL_TESTS
>        kunit: bail out of test filtering logic quicker if OOM
>        kunit: tool: update test counts summary line format
>        kunit: tool: stop using a shell to run kernel under QEMU
>        kunit: tool: print clearer error message when there's no TAP output
>        kunit: tool: remove dead parse_crash_in_log() logic
>        kunit: tool: make parser stop overwriting status of suites w/ no_tests
>        kunit: tool: minor cosmetic cleanups in kunit_parser.py
>        kunit: tool: misc cleanups
>        kunit: fix executor OOM error handling logic on non-UML
> 
> David Gow (5):
>        list: test: Test the hlist structure
>        kunit: Make kunit_remove_resource() idempotent
>        kunit: Rework kunit_resource allocation policy
>        kunit: tool: Add list of all valid test configs on UML
>        kunit: tool: Use qemu-system-i386 for i386 runs
> 
> Kees Cook (1):
>        kunit: tool: Do not colorize output when redirected
> 
> Marco Elver (1):
>        kcsan: test: use new suite_{init,exit} support
> 
> Miguel Ojeda (1):
>        kunit: take `kunit_assert` as `const`
> 
> Ricardo Ribalda (6):
>        kunit: Introduce _NULL and _NOT_NULL macros
>        kunit: use NULL macros
>        thunderbolt: test: use NULL macros
>        kasan: test: Use NULL macros
>        mctp: test: Use NULL macros
>        apparmor: test: Use NULL macros
> 
> 
>   Documentation/dev-tools/kunit/api/index.rst        |   5 +
>   Documentation/dev-tools/kunit/api/resource.rst     |  13 +
>   Documentation/dev-tools/kunit/running_tips.rst     |   3 +-
>   Documentation/dev-tools/kunit/usage.rst            |  19 +-
>   drivers/thunderbolt/test.c                         | 134 +++----
>   include/kunit/resource.h                           | 406 ++++++++++++++++++++
>   include/kunit/test.h                               | 418 ++++++---------------
>   kernel/kcsan/kcsan_test.c                          |  31 +-
>   lib/Kconfig.debug                                  |  15 +-
>   lib/kunit/Makefile                                 |   1 +
>   lib/kunit/debugfs.c                                |   2 +-
>   lib/kunit/executor.c                               |  32 +-
>   lib/kunit/executor_test.c                          |   4 +-
>   lib/kunit/kunit-example-test.c                     |  16 +
>   lib/kunit/kunit-test.c                             |  37 +-
>   lib/kunit/resource.c                               |  79 ++++
>   lib/kunit/test.c                                   | 145 ++-----
>   lib/list-test.c                                    | 397 ++++++++++++++++++-
>   lib/test_kasan.c                                   |   2 +-
>   mm/kfence/.kunitconfig                             |   6 +
>   mm/kfence/kfence_test.c                            |  31 +-
>   net/mctp/test/route-test.c                         |   4 +-
>   security/apparmor/policy_unpack_test.c             |   6 +-
>   tools/testing/kunit/configs/all_tests_uml.config   |  37 ++
>   tools/testing/kunit/kunit.py                       |  63 ++--
>   tools/testing/kunit/kunit_config.py                |  21 +-
>   tools/testing/kunit/kunit_json.py                  |  66 ++--
>   tools/testing/kunit/kunit_kernel.py                |  81 ++--
>   tools/testing/kunit/kunit_parser.py                | 154 +++-----
>   tools/testing/kunit/kunit_tool_test.py             |  44 +--
>   tools/testing/kunit/qemu_config.py                 |  17 +-
>   tools/testing/kunit/qemu_configs/alpha.py          |   2 +-
>   tools/testing/kunit/qemu_configs/arm.py            |   2 +-
>   tools/testing/kunit/qemu_configs/arm64.py          |   2 +-
>   tools/testing/kunit/qemu_configs/i386.py           |   4 +-
>   tools/testing/kunit/qemu_configs/powerpc.py        |   2 +-
>   tools/testing/kunit/qemu_configs/riscv.py          |   7 +-
>   tools/testing/kunit/qemu_configs/s390.py           |   4 +-
>   tools/testing/kunit/qemu_configs/sparc.py          |   2 +-
>   tools/testing/kunit/qemu_configs/x86_64.py         |   2 +-
>   tools/testing/kunit/run_checks.py                  |   2 +-
>   .../kunit/test_data/test_is_test_passed-crash.log  |  70 ----
>   .../test_is_test_passed-no_tests_no_plan.log       |   2 +-
>   43 files changed, 1499 insertions(+), 891 deletions(-)
>   create mode 100644 Documentation/dev-tools/kunit/api/resource.rst
>   create mode 100644 include/kunit/resource.h
>   create mode 100644 lib/kunit/resource.c
>   create mode 100644 mm/kfence/.kunitconfig
>   create mode 100644 tools/testing/kunit/configs/all_tests_uml.config
>   delete mode 100644 tools/testing/kunit/test_data/test_is_test_passed-crash.log
> ----------------------------------------------------------------

