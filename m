Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C273D41D089
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Sep 2021 02:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346667AbhI3AZU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Sep 2021 20:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346608AbhI3AZT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Sep 2021 20:25:19 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93DAC06161C
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Sep 2021 17:23:35 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id u18so7061835wrg.5
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Sep 2021 17:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JSQkVSiN1+zP+Jeqk9BsuAYII2lwHRa7BSBYUWDZKe0=;
        b=eJ/CBXGRPaT/0t3P0rvayDkW3i5f7uHQlPxkcRC4+AuoWanUPnHeVSYIdmbqnFCnHe
         n5ZwkX8cZCRwtEv75FZ48p4mtQu9cnUZd+aOx8EdmGoslP/JJs+ubY2Pq78mNaerPcsd
         tSEaFCAdxggIHWByzJOWnzgtgCpFn6WnUG6Eripd0k3gnPq1QlVU5c8XPJ6wYpUmNYoJ
         ia2Ycou8Ow1Bsv4XhJDoI19xf8g1A5x+Ooyiqdqs2XdD05hDPKdWVQWJBtEAARAwAn0Y
         LHsCSN7ZvLfmMdyxWdcj/ZtqlNQPNlvE0a4lIzbuVfCpcq2jYAn49En3k0jdv0DprcgF
         N6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JSQkVSiN1+zP+Jeqk9BsuAYII2lwHRa7BSBYUWDZKe0=;
        b=BrJhOSEwnogPRcUfLuAyE4lW2HaHHXT23DzVU0iuaTpoXLhEcthb1PRhnPI7m5/e2Q
         RwijpWA2NtHxq9f89/30WrUwPAprNYepSlbtwYm0uei/YO8wjLkbAqPcjv8hFDGAlJs+
         km1k7JqJVfcSRGKCrLa253d7FZysC03C6al5JsRrbUdBqAEVa/5HkHTTm6TtLJizc7OV
         Wpb0wQEGKCDTylqjIsuAQeGMQpT78jxfIvpwpmsjjRawZ6p8Fvc75v+U/ef/TWKMyPhz
         scw/bedJ5/zVgLbt8K04lnV8KbUjwYFS3Y+dTSUVeCU5JQ8fXEjEPeisXaFcwdVUV1DB
         Y2dw==
X-Gm-Message-State: AOAM533o8hrevCI984JYeMomv9+dnQ3C8OLZ/MH7bD3tlpQ0flH9QEzP
        +laC7LnONJACsEmBjr0OjTAyfowPCegmBkXZdOz7Gw==
X-Google-Smtp-Source: ABdhPJwerOaugHpID+JPAzBswNv/cKLg+ct97HozKh8FvKra/kiTPxE2YOJtfgyjgGpRIzND3Oj8CGrWHQhBX6G+ars=
X-Received: by 2002:adf:f6c7:: with SMTP id y7mr2999746wrp.44.1632961414281;
 Wed, 29 Sep 2021 17:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210929232534.1433720-1-dlatypov@google.com>
In-Reply-To: <20210929232534.1433720-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 30 Sep 2021 08:23:23 +0800
Message-ID: <CABVgOSn7KpVj_+3YYrO1DkNxHkO3VJcUYjXuD+RSNHV_aZC6_Q@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: show list of valid --arch options when invalid
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

On Thu, Sep 30, 2021 at 7:26 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Consider this attempt to run KUnit in QEMU:
> $ ./tools/testing/kunit/kunit.py run --arch=x86
>
> Before you'd get this error message:
> kunit_kernel.ConfigError: x86 is not a valid arch
>
> After:
> kunit_kernel.ConfigError: x86 is not a valid arch, options are ['alpha', 'arm', 'arm64', 'i386', 'powerpc', 'riscv', 's390', 'sparc', 'x86_64']
>
> This should make it a bit easier for people to notice when they make
> typos, etc. Currently, one would have to dive into the python code to
> figure out what the valid set is.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

This is really nice, particularly given that we've had to reproduce
that list in lots of talks, documentation, etc. and it could get
out-of-date.

Reviewed-by: David Gow <davidgow@google.com>

[FYI: this didn't seem to apply cleanly to kselftest/kunit head, but
it was a pretty minor issue with kunit_tool_test.py.]

Thanks,
-- David

>  tools/testing/kunit/kunit_kernel.py    | 5 +++--
>  tools/testing/kunit/kunit_tool_test.py | 4 ++++
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> index 1870e75ff153..a6b3cee3f0d0 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -198,8 +198,9 @@ def get_source_tree_ops(arch: str, cross_compile: Optional[str]) -> LinuxSourceT
>                 return LinuxSourceTreeOperationsUml(cross_compile=cross_compile)
>         elif os.path.isfile(config_path):
>                 return get_source_tree_ops_from_qemu_config(config_path, cross_compile)[1]
> -       else:
> -               raise ConfigError(arch + ' is not a valid arch')
> +
> +       options = [f[:-3] for f in os.listdir(QEMU_CONFIGS_DIR) if f.endswith('.py')]
> +       raise ConfigError(arch + ' is not a valid arch, options are ' + str(sorted(options)))
>
>  def get_source_tree_ops_from_qemu_config(config_path: str,
>                                          cross_compile: Optional[str]) -> Tuple[
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index cad37a98e599..2ae72f04cbe0 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -289,6 +289,10 @@ class LinuxSourceTreeTest(unittest.TestCase):
>                                 pass
>                         kunit_kernel.LinuxSourceTree('', kunitconfig_path=dir)
>
> +       def test_invalid_arch(self):
> +               with self.assertRaisesRegex(kunit_kernel.ConfigError, 'not a valid arch, options are.*x86_64'):
> +                       kunit_kernel.LinuxSourceTree('', arch='invalid')
> +
>         # TODO: add more test cases.
>
>
>
> base-commit: 865a0a8025ee0b54d1cc74834c57197d184a441e
> --
> 2.33.0.685.g46640cef36-goog
>
