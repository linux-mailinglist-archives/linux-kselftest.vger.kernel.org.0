Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3D2193013
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Mar 2020 19:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbgCYSKM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Mar 2020 14:10:12 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38185 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbgCYSKM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Mar 2020 14:10:12 -0400
Received: by mail-pg1-f196.google.com with SMTP id x7so1529084pgh.5
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Mar 2020 11:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mCMDLx96gBb9PVNfbGpeGhFfN+gcscZ0Sw/AuceDcYw=;
        b=OzisoSYR8xG9adN42Vh791qneDavZ0HSxIrazB7q71rTrmkTkPDDUaFbHPKHaVT/MB
         DVu/4JBu5srpWwblRKe1H6yVro66d6AhkEhz9Vzf+V8U62+HvjfY/utTHz7gppPPcGix
         vKJzi3T7S4F/ywZtlm+nGKX2vWdyZYUCw4mfJb3slEdIWsi2+mEFRUHXiCxQb5JVlimV
         2zvEq8CgJq4Gerl/e2Jik+3rJrR3qlegSlwyJtYCCm/Tt0heQ3XLV2n9mTiTkEtPxmiG
         0WvmtbB5KPFd6zAAQL9hReZXTjQW3rdNFvH9QGs37ABxpVwFfJyY+sw83UPUFwC84J6F
         /2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mCMDLx96gBb9PVNfbGpeGhFfN+gcscZ0Sw/AuceDcYw=;
        b=AOiiy7gOQzFFyqN+fCU0hajrRzRaQQpF45iHfugxZ8B70KeSvt9NdNzo6oO0MkLtIy
         8RH0JTqx13H+iZbWsia6vchJP1DiwsjD8EhfzeSilCypA5eUdjsBdnItGtkUDUFHBn7Z
         UOfpgAYZff/AQDJL5J5q/olryOmEgJTeRGxLD+P7HmkBA/O5FWbTDnt12XmVbKIqNrRq
         qi6fDe+8UCQ7SXA9AxlWjyTd3b6GjhrcWrCOvLGmFE6gdY2vjVcTrHPj/QgnteblIGcy
         C5ugOcisLVrbjgScF70YFgkLAChT5hyN0M5raKGEZ7rQsHKlJ9bZQMx5j1Vvl8VB/K6u
         aqkw==
X-Gm-Message-State: ANhLgQ0W0eJVXaf8ym8q1cPEE+/WLlPx+NYDXKl3FYv5aF8RqrqTV8eI
        ZG2wiZp/HE0vyb0mxBUam2BxVcNHYh4Jm3n+H7eYXw==
X-Google-Smtp-Source: ADFU+vvnK7P42RfRULi0wmeJinug/pd//+uMrm5Bceh4lyd/Shur0xusPHmdpsgfif4+bs63GDIbu+gd1enYXKvXueE=
X-Received: by 2002:a62:8343:: with SMTP id h64mr4948056pfe.166.1585159810046;
 Wed, 25 Mar 2020 11:10:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200311222157.259707-1-davidgow@google.com>
In-Reply-To: <20200311222157.259707-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 25 Mar 2020 11:09:57 -0700
Message-ID: <CAFd5g47c+g_ufcOKEkKtCtj71nQtFwp40JuWajh_jPhQt50B_w@mail.gmail.com>
Subject: Re: [RFC PATCH kunit-next] kunit: kunit_tool: Separate out config/build/exec/parse
To:     David Gow <davidgow@google.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 11, 2020 at 3:23 PM David Gow <davidgow@google.com> wrote:
>
> Add new subcommands to kunit.py to allow stages of the existing 'run'
> subcommand to be run independently:
> - 'config': Verifies that .config is a subset of .kunitconfig
> - 'build': Compiles a UML kernel for KUnit
> - 'exec': Runs the kernel, and outputs the test results.
> - 'parse': Parses test results from a file or stdin

I think all the names are fine. I like the verb-noun pattern.

>
> Most of these are not hugely useful by themselves yet, and there's room
> for plenty of bikeshedding on the names, but this hopefully can form a
> foundation for future improvements.
>
> Signed-off-by: David Gow <davidgow@google.com>

This looks really good! I really only have one minor comment right
now, see below.

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

> ---
> [Whoops: typo-ed Brendan's email. Sorry about that!]
>
> As was briefly disccussed in [1], this change is part of a "separation
> of concerns" in kunit_tool. This should make it easier to integrate
> kunit_tool into other setups.
>
> Of particular intrest is probably 'kunit.py parse', which should allow
> KUnit results to be parsed from other sources, such as after loading a
> module, or from a non-UML kernel, or from debugfs when that's
> supported[2].
>
> [1]: https://lkml.org/lkml/2020/2/5/552
> [2]: https://patchwork.kernel.org/patch/11419901/
>
>  tools/testing/kunit/kunit.py           | 236 ++++++++++++++++++++-----
>  tools/testing/kunit/kunit_tool_test.py |  55 ++++++
>  2 files changed, 242 insertions(+), 49 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index 180ad1e1b04f..92a634594cf6 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py

[...]

> @@ -147,6 +244,47 @@ def main(argv, linux=None):
>                 result = run_tests(linux, request)
>                 if result.status != KunitStatus.SUCCESS:
>                         sys.exit(1)
> +       elif cli_args.subcommand == 'config':
> +               request = KunitConfigRequest(cli_args.build_dir,
> +                                            cli_args.defconfig)
> +               result = config_tests(linux, request)
> +               kunit_parser.print_with_timestamp((
> +                       'Elapsed time: %.3fs\n') % (
> +                               result.elapsed_time))
> +               if result.status != KunitStatus.SUCCESS:
> +                       sys.exit(1)
> +       elif cli_args.subcommand == 'build':
> +               request = KunitBuildRequest(cli_args.jobs,
> +                                           cli_args.build_dir)
> +               result = build_tests(linux, request)
> +               kunit_parser.print_with_timestamp((
> +                       'Elapsed time: %.3fs\n') % (
> +                               result.elapsed_time))
> +               if result.status != KunitStatus.SUCCESS:
> +                       sys.exit(1)
> +       elif cli_args.subcommand == 'exec':
> +               exec_request = KunitExecRequest(cli_args.timeout,
> +                                               cli_args.build_dir)
> +               exec_result = exec_tests(linux, exec_request)
> +               parse_request = KunitParseRequest(cli_args.raw_output,
> +                                                 exec_result.result)
> +               result = parse_tests(parse_request)
> +               kunit_parser.print_with_timestamp((
> +                       'Elapsed time: %.3fs\n') % (
> +                               exec_result.elapsed_time))
> +               if result.status != KunitStatus.SUCCESS:
> +                       sys.exit(1)
> +       elif cli_args.subcommand == 'parse':
> +               if cli_args.file == '-':
> +                       kunit_output = sys.stdin

Could you make it so parse accepts the dmesg log from stdin if no file
is specified instead of a '-'?

> +               else:
> +                       with open(cli_args.file, 'r') as f:
> +                               kunit_output = f.read().splitlines()
> +               request = KunitParseRequest(cli_args.raw_output,
> +                                           kunit_output)
> +               result = parse_tests(request)
> +               if result.status != KunitStatus.SUCCESS:
> +                       sys.exit(1)
>         else:
>                 parser.print_help()
>

[...]
