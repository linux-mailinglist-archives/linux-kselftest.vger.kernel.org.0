Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27BB30FD2D
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Feb 2021 20:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238172AbhBDToa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 4 Feb 2021 14:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236813AbhBDTo1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 4 Feb 2021 14:44:27 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E4EC06178A
        for <linux-kselftest@vger.kernel.org>; Thu,  4 Feb 2021 11:43:47 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id j2so2874831pgl.0
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Feb 2021 11:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+kgb/YSMbLJoQSXAwYx5oByXM+QqtdTuysP9uC+LOVY=;
        b=Jo6inYMe+oAf/ZNWs+rdh0hwRaP31M8CMmpKBThsY5WdazEC1grF551bbNI2uj10BI
         9ZKob5V12cBrfYe+gq92asoo3x5EhO3kbxsoex6lmH+GfAT1ufZ3/JAhYuDGoOziwINt
         g9azF5imCgzkCIFhEifVOOsNbzt8ugUjJf850TdfwenzYrrtwxl1DvintomA9REJx84k
         VpWlC4hhZmVMBqtYPyiwzExcSVFDljIrzTkoKG6pG+sAvhBLGXZE8jpaibHtLWkUv3HV
         hvzSXEIapqSXthvQLkWZ5GHrUrKbcp0p5Al6ya0yVoaVwtRGCLeC+H7CNpGCSY3YjzwF
         GMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+kgb/YSMbLJoQSXAwYx5oByXM+QqtdTuysP9uC+LOVY=;
        b=Eb+v+AnVPS0CNAmjCDZ0KQIyRNnoLu7inN0X7KwyeK3IUZb8XFyWIgiPMc8zpdjH/D
         CTXIqRtipVJG+ZpVfCfzkt6RV2YVubMDNHefqaZib58jtreEuso8FQVC2zHQ9e9dfGVQ
         EFRws70gk5qpCHhYpy9N7qCySWC02Kknv89+Hz5i1t1ydCOSeoARK/pkfLrSM9Het2ct
         LigDbaOgk9Nwyd/LIFvFcIwX+mEId8W62pdJLIgUu453hrMHPdHblsFP598H96ebVVMP
         +pfjYOgpKczyJM2tI7wQcWTTlWIxXLPkHqlZGJSlti6MpZLBHM1yrOpwT7HnxCehi0jG
         nIkA==
X-Gm-Message-State: AOAM532xRp1CCMED5Yaiq5Khs0IGn4vjw6qMuNVxfwDBySUT+0IcN8hg
        Gz39/85D5CUPXbKXJEM+/sv3Yop8Wks7S6JS/BI3aA==
X-Google-Smtp-Source: ABdhPJxQJ8tBTeSJ8nCb7YyZX9ImArmYqpV0jOz1Wj7zW9BC+iSj35fvPxdyuo4MVKdGgu1OF9GqMxSNk34iSmXWVis=
X-Received: by 2002:a62:fc84:0:b029:1ba:9b85:2e92 with SMTP id
 e126-20020a62fc840000b02901ba9b852e92mr860888pfh.38.1612467826595; Thu, 04
 Feb 2021 11:43:46 -0800 (PST)
MIME-Version: 1.0
References: <20210204173045.1138504-1-dlatypov@google.com> <20210204173045.1138504-2-dlatypov@google.com>
In-Reply-To: <20210204173045.1138504-2-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 4 Feb 2021 11:43:35 -0800
Message-ID: <CAFd5g47N2ec7KTG9Lk-DgxqEnOEdqYjoQ1+V=aE6NTXbY0-MMg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] kunit: add kunit.filter_glob cmdline option to
 filter suites
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 4, 2021 at 9:31 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> E.g. specifying this would run suites with "list" in their name.
>   kunit.filter_glob=list*
>
> Note: the executor prints out a TAP header that includes the number of
> suites we intend to run.
> So unless we want to report empty results for filtered-out suites, we
> need to do the filtering here in the executor.
> It's also probably better in the executor since we most likely don't
> want any filtering to apply to tests built as modules.
>
> This code does add a CONFIG_GLOB=y dependency for CONFIG_KUNIT=y.
> But the code seems light enough that it shouldn't be an issue.
>
> For now, we only filter on suite names so we don't have to create copies
> of the suites themselves, just the array (of arrays) holding them.
>
> The name is rather generic since in the future, we could consider
> extending it to a syntax like:
>   kunit.filter_glob=<suite_glob>.<test_glob>
> E.g. to run all the del list tests
>   kunit.filter_glob=list-kunit-test.*del*
>
> But at the moment, it's far easier to manually comment out test cases in
> test files as opposed to messing with sets of Kconfig entries to select
> specific suites.
> So even just doing this makes using kunit far less annoying.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

One minor issue below, otherwise:

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

> ---
>  lib/kunit/Kconfig    |  1 +
>  lib/kunit/executor.c | 91 +++++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 83 insertions(+), 9 deletions(-)
>
> diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
> index 00909e6a2443..0b5dfb001bac 100644
> --- a/lib/kunit/Kconfig
> +++ b/lib/kunit/Kconfig
> @@ -4,6 +4,7 @@
>
>  menuconfig KUNIT
>         tristate "KUnit - Enable support for unit tests"
> +       select GLOB if KUNIT=y
>         help
>           Enables support for kernel unit tests (KUnit), a lightweight unit
>           testing and mocking framework for the Linux kernel. These tests are
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index a95742a4ece7..996efb80dba6 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -1,6 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0
>
>  #include <kunit/test.h>
> +#include <linux/glob.h>
> +#include <linux/moduleparam.h>
>
>  /*
>   * These symbols point to the .kunit_test_suites section and are defined in
> @@ -11,14 +13,79 @@ extern struct kunit_suite * const * const __kunit_suites_end[];
>
>  #if IS_BUILTIN(CONFIG_KUNIT)
>
> -static void kunit_print_tap_header(void)
> +static char *filter_glob;
> +module_param(filter_glob, charp, 0);

You should probably also use MODULE_PARM_DESC().
