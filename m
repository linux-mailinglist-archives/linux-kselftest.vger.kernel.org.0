Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEDE49497D
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jan 2022 09:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359230AbiATIa4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jan 2022 03:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359265AbiATIaM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jan 2022 03:30:12 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBE7C061755
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jan 2022 00:30:12 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id o1-20020a1c4d01000000b0034d95625e1fso5553516wmh.4
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jan 2022 00:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f598GxBX3eYMMeExQx/Xgejk6SKcvZUYFtg4erPpbmA=;
        b=AYhSOilisYtm5Kva53WYknZU/cP0nBLrKX+D5I5wa60go1JcqjfG8boGZx7MEqCG4n
         H1AIzJNsNFhkvcg0e+v0rIbxV0bskcFjv6KOCcbshPSdC7Ihq1JnTnsEIL+Bgmw1UcpQ
         uiM3A6/GFcOMq0lUwFIhluvY64B1n1khk8pw2h5P/jXNjCiqhfwjARf+zF5ibOQgLK/j
         SLM6S4eCuBTOCdBRRM63jLCRXDyBX5dN0XASh7COboD4KOCpJgZ3oqxjO+63IdrWzILZ
         YluFiNt7Fo453BO2lkxMdzKejEe7sfE01xg8/t7tuj/gGhhBJzPtkLKOR2qV93/YRRA+
         D3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f598GxBX3eYMMeExQx/Xgejk6SKcvZUYFtg4erPpbmA=;
        b=LO6bApaKSx3O8UBVUzuiRAQ/wR98VaW8XmOADKSQZKG/4OOpBvfYNBn4/0ROJkugTw
         HDmjtKqZSplTh5KszXOCpa9hgmQi3qlSNM+MU/kFFuFWUi6PlEl5LIBVeTKkPp+jg2eh
         RW2Wuq651sqxhfoChb+FJGr6G3GplzFZpGypveRZVBVAJqq3pIWIrK6wisyDCo2DDSUe
         iUXOT/bi533Gh6xMSi+g8bxBlF8Sp3KZ1TT7Nl/mbpwlYmQRQFKt0QsKcp00htYx7pnJ
         tTPe7u9XUeauj9aHSncKB7fsiwUcBeMuWWXtli9BXMBdmmypdhUjEr/V7AHTJ45pSaYc
         s+Hw==
X-Gm-Message-State: AOAM533a31kvgA3zWY3oDD1RXAIXbjzSA+fhoxxR8z5Ha8N19rzoVgHh
        z0HgDftRzaPLOD8Myi0AmTmnj+Q8YOgIiXxmdOywKw==
X-Google-Smtp-Source: ABdhPJyBLRZv0QzjJfHJWKm1oD8j2btPknNw9AvpKSc6Oq5Bi32otoRK6KPR4Ba+Fi5gaAJQVUtXkySKvELZI5lP5ZM=
X-Received: by 2002:a05:600c:28cc:: with SMTP id h12mr7749968wmd.18.1642667410465;
 Thu, 20 Jan 2022 00:30:10 -0800 (PST)
MIME-Version: 1.0
References: <20220118190922.1557074-1-dlatypov@google.com> <20220118190922.1557074-4-dlatypov@google.com>
In-Reply-To: <20220118190922.1557074-4-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 20 Jan 2022 16:29:59 +0800
Message-ID: <CABVgOSnSrsTn0_9FuFzvFXd=H8uQEaLWMnP=3Y=xeGGS=J2JtA@mail.gmail.com>
Subject: Re: [PATCH 4/5] kunit: tool: drop last uses of collections.namedtuple
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jan 19, 2022 at 3:09 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Since we formally require python3.7+ since commit df4b0807ca1a
> ("kunit: tool: Assert the version requirement"), we can just use
> @dataclasses.dataclass instead.
>
> In kunit_config.py, we used namedtuple to create a hashable type that
> had `name` and `value` fields and had to subclass it to define a custom
> `__str__()`.
> @datalcass lets us just define one type instead.
>
> In qemu_config.py, we use namedtuple to allow modules to define various
> parameters. Using @dataclass, we can add type-annotations for all these
> fields, making our code more typesafe and making it easier for users to
> figure out how to define new configs.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

This seems sensible, and the type-annotations are definitely a good thing.

I guess I'm going to have to learn how to use @dataclass, though...

Reviewed-by: David Gow <davidgow@google.com>

-- David

>  tools/testing/kunit/kunit_config.py |  9 +++++----
>  tools/testing/kunit/qemu_config.py  | 17 ++++++++++-------
>  2 files changed, 15 insertions(+), 11 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit_config.py b/tools/testing/kunit/kunit_config.py
> index 677354546156..ca33e4b7bcc5 100644
> --- a/tools/testing/kunit/kunit_config.py
> +++ b/tools/testing/kunit/kunit_config.py
> @@ -6,16 +6,17 @@
>  # Author: Felix Guo <felixguoxiuping@gmail.com>
>  # Author: Brendan Higgins <brendanhiggins@google.com>
>
> -import collections
> +from dataclasses import dataclass
>  import re
>  from typing import List, Set
>
>  CONFIG_IS_NOT_SET_PATTERN = r'^# CONFIG_(\w+) is not set$'
>  CONFIG_PATTERN = r'^CONFIG_(\w+)=(\S+|".*")$'
>
> -KconfigEntryBase = collections.namedtuple('KconfigEntryBase', ['name', 'value'])
> -
> -class KconfigEntry(KconfigEntryBase):
> +@dataclass(frozen=True)
> +class KconfigEntry:
> +       name: str
> +       value: str
>
>         def __str__(self) -> str:
>                 if self.value == 'n':
> diff --git a/tools/testing/kunit/qemu_config.py b/tools/testing/kunit/qemu_config.py
> index 1672f6184e95..0b6a80398ccc 100644
> --- a/tools/testing/kunit/qemu_config.py
> +++ b/tools/testing/kunit/qemu_config.py
> @@ -5,12 +5,15 @@
>  # Copyright (C) 2021, Google LLC.
>  # Author: Brendan Higgins <brendanhiggins@google.com>
>
> -from collections import namedtuple
> +from dataclasses import dataclass
> +from typing import List
>
>
> -QemuArchParams = namedtuple('QemuArchParams', ['linux_arch',
> -                                              'kconfig',
> -                                              'qemu_arch',
> -                                              'kernel_path',
> -                                              'kernel_command_line',
> -                                              'extra_qemu_params'])
> +@dataclass(frozen=True)
> +class QemuArchParams:
> +  linux_arch: str
> +  kconfig: str
> +  qemu_arch: str
> +  kernel_path: str
> +  kernel_command_line: str
> +  extra_qemu_params: List[str]
> --
> 2.34.1.703.g22d0c6ccf7-goog
>
