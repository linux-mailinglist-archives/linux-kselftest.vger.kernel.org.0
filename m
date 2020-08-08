Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2077B23F69B
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Aug 2020 07:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgHHFpT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 8 Aug 2020 01:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgHHFpS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 8 Aug 2020 01:45:18 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEE2C061A27
        for <linux-kselftest@vger.kernel.org>; Fri,  7 Aug 2020 22:45:18 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id x5so3368590wmi.2
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Aug 2020 22:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=441erG+nQmp/Gw1mKUcyWCbdvIu4tY4AskgERTUrfjg=;
        b=gFgiaaUI3R97K8gVNTA0DZeC1udE44Xe94EfLuFG1QpmUFFLrLEysS/L41zYbhywlR
         mPQkkd+eeFz/LTsg34gxiKRGptrqJhCYX9JpHb2zPZDfvKDf4EC824Em7a6WPF+Qx6ZG
         IyHyoO7cF3GP1ylR3urde/Y1x+HM1HMXDCaEEVM4N9t9AX+Nvr8VlhnUnpo9OMzUsDnt
         mYOmnT2IEGD86AG63um15D87y76SR2uMql/cULk2BXS9r+afuQlHDsuuw+vpjp0vdeya
         4kBLhd/DC2NyDWZh4c7JaDvRiK6eGx6TtAeR/UQVZ1NFR/F6HprG8LVCJH1H0RttbBcE
         0eTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=441erG+nQmp/Gw1mKUcyWCbdvIu4tY4AskgERTUrfjg=;
        b=Xkf7N8ko9efs3u0WpMSKvcCyOVTBi7BSb8EjrpBh7/1Jt8gaGx25REoLMID3/U7t4r
         jsu5S7a011X1jUvw5hryr1QQ62XOSk+qjkQ6Vavjdg27otMyaxDbgkI6mU9z6Oc1Sav+
         SWZuo8PKffKLXPifb/fyK3u2zSIdZBcJ3oIe6bOhWPg3gyVWON+JYPQbsmBHyWcBp4/R
         G8qnJ83oGcTe7b7iJKlrvFrS9aS4aA4BRGduK/4D012whKkYQ5CSdAOE2In6aZSXFtGj
         1Al5CKNZky6TKb5E0p2UxYuKQ2U/Nm8+w2K0PGItcNWgPbgarVaO4S329kq0M5g0YO0Q
         x0Gw==
X-Gm-Message-State: AOAM533UoxUUAuoQjNBee6/QCP1PyictPsfRJCM8Go39WKEpu3K2Ph4o
        z+PQhGLdZkY0DP1bcXe7hFpFgkZHui0Q+g1ab3CNWg==
X-Google-Smtp-Source: ABdhPJx0rFe0zGAHdrBJuE8AHpoJMag7cGGMlYcCrkYzgb+JqKHHTSUqvpypkcKFaRZqkqXKMiukGIhlzijpTrDC9gs=
X-Received: by 2002:a7b:c2aa:: with SMTP id c10mr15492330wmk.86.1596865516755;
 Fri, 07 Aug 2020 22:45:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200808011651.2113930-1-brendanhiggins@google.com>
In-Reply-To: <20200808011651.2113930-1-brendanhiggins@google.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 8 Aug 2020 13:45:05 +0800
Message-ID: <CABVgOSkEiQkcOy+gF9irJo-R6xCeiCvDRZXa_ubzCfz+9Yx2ZA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] kunit: tool: fix running kunit_tool from outside
 kernel tree
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Aug 8, 2020 at 9:17 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> Currently kunit_tool does not work correctly when executed from a path
> outside of the kernel tree, so make sure that the current working
> directory is correct and the kunit_dir is properly initialized before
> running.
>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  tools/testing/kunit/kunit.py | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index 425ef40067e7..96344a11ff1f 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -237,9 +237,14 @@ def main(argv, linux=None):
>
>         cli_args = parser.parse_args(argv)
>
> +       if get_kernel_root_path():
> +               print('cd ' + get_kernel_root_path())
Do we want to print this, or is it a leftover debug statement?


> +               os.chdir(get_kernel_root_path())
> +
>         if cli_args.subcommand == 'run':
>                 if not os.path.exists(cli_args.build_dir):
>                         os.mkdir(cli_args.build_dir)
> +                       create_default_kunitconfig()
Why are we adding this everywhere when it's already in config_tests,
which should already be called in all of the places where a
kunitconfig is required?
Is the goal to always copy the default kunitconfig when creating a new
build_dir? While I can sort-of see why we might want to do that, if
the build dir doesn't exist, most of the subcommands will fail anyway
(maybe we should only create the build-dir for 'config' and 'run'?)


>
>                 if not linux:
>                         linux = kunit_kernel.LinuxSourceTree()
> @@ -257,6 +262,7 @@ def main(argv, linux=None):
>                 if cli_args.build_dir:
>                         if not os.path.exists(cli_args.build_dir):
>                                 os.mkdir(cli_args.build_dir)
> +                               create_default_kunitconfig()
>
>                 if not linux:
>                         linux = kunit_kernel.LinuxSourceTree()
> @@ -273,6 +279,7 @@ def main(argv, linux=None):
>                 if cli_args.build_dir:
>                         if not os.path.exists(cli_args.build_dir):
>                                 os.mkdir(cli_args.build_dir)
> +                               create_default_kunitconfig()
>
>                 if not linux:
>                         linux = kunit_kernel.LinuxSourceTree()
> @@ -291,6 +298,7 @@ def main(argv, linux=None):
>                 if cli_args.build_dir:
>                         if not os.path.exists(cli_args.build_dir):
>                                 os.mkdir(cli_args.build_dir)
> +                               create_default_kunitconfig()
>
>                 if not linux:
>                         linux = kunit_kernel.LinuxSourceTree()
>
> base-commit: 30185b69a2d533c4ba6ca926b8390ce7de495e29
> --
> 2.28.0.236.gb10cc79966-goog
>
