Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBCBC2AD439
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Nov 2020 11:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbgKJK6o (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Nov 2020 05:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgKJK6n (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Nov 2020 05:58:43 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C31C0613D1
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Nov 2020 02:58:43 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id w145so13825508oie.9
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Nov 2020 02:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=94tiZd4Xfo6idGbxmiXDVBxg8Gu69WxG80x6rMgUhQQ=;
        b=Wln8ylEoEHqFMf/a2BD4fDClafPZLlRCqtI8EEk95v6Uk78e1f/riTCVHWK31P16F7
         5t6Klxhxot3Cs6C1X2oMq2efacvNRcKpFgg3PRXj3kYQD2IUnm9SnAf2sNvCj+vbXvFF
         +A36dSgA1HYYcTumf5A/5mkM3skgc8kH6AkC23EtUMfLbd15h/3+NhbC1Lej3jiJ6+qy
         i93CJnmu54HKAE44JYDF5R4ZuruIvX8dTGklV2Sb1ovJd5eTnTsZ8hkl5TKLA4RzXj3M
         ckwRm8jh5HzzDtIP8D+FDYrzxL2Um+novRjUPQRK/16QFGRPWoGxqAQjxX03NfexO67B
         PSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=94tiZd4Xfo6idGbxmiXDVBxg8Gu69WxG80x6rMgUhQQ=;
        b=VAUHWiMvFLlzTlrvdXY9pHyw8fa092+adO8jgAZtHyqtIza5Gt+kx6wlx/as8hdwNT
         RdHO0b1gdE7tB96UnMoLFcgXrx892n6/tzU8HQGiudI2sqsvVXdydxyUEFrqZMYs7Fx7
         aMXpuN8LP30wr7hFmVVJvmPCcSkIOR6t8wgqXTvJoDKK8I02fVxqRZSa3ZXW5kLkejCD
         WIjOWHkFKxvXnQAaqGBo4vLClMLeDPHkxEJtFD3oeRfSHwgPSIh6q5vr2Z5GKvWty08Q
         Vhq++0etNlCtd267YM3nYetfyOx5667LYL+Ovx1qS+CRR/talUKh/YBWB+VaVOOvNPjB
         s1XA==
X-Gm-Message-State: AOAM533EG8pHgLrQk7KxU8/KyTUEgVjJB16b3NJeE8Cyv+iWlWBZel8h
        BsK89JGiAGRzrGvBeobIiEaUzLJivXOEvTq+SgW4Hg==
X-Google-Smtp-Source: ABdhPJwxeroz4djU/HfOYnlpWJSxXVwoptInlidQ6W6O3cU1eGTEiAgfeIUJ5t9PI8CAY9/biuXDB33G6ERM6TPfPPw=
X-Received: by 2002:aca:a988:: with SMTP id s130mr2454674oie.172.1605005922432;
 Tue, 10 Nov 2020 02:58:42 -0800 (PST)
MIME-Version: 1.0
References: <20201110072936.1380718-1-davidgow@google.com>
In-Reply-To: <20201110072936.1380718-1-davidgow@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 10 Nov 2020 11:58:31 +0100
Message-ID: <CANpmjNPnB1ODuDqpMMO1horTV=3+NQv0gxEpnDwGDOV540cDhA@mail.gmail.com>
Subject: Re: [PATCH] kunit: kunit_tool: Correctly parse diagnostic messages
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arpitha Raghunandan <98.arpi@gmail.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 10 Nov 2020 at 08:29, David Gow <davidgow@google.com> wrote:
>
> Currently, kunit_tool expects all diagnostic lines in test results to
> contain ": " somewhere, as both the subtest header and the crash report
> do. Fix this to accept any line starting with (minus indent) "# " as
> being a valid diagnostic line.
>
> This matches what the TAP spec[1] and the draft KTAP spec[2] are
> expecting.
>
> [1]: http://testanything.org/tap-specification.html
> [2]: https://lore.kernel.org/linux-kselftest/CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com/T/
>
> Signed-off-by: David Gow <davidgow@google.com>

Acked-by: Marco Elver <elver@google.com>

Thanks!

> ---
>  tools/testing/kunit/kunit_parser.py | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> index 84a1af2581f5..dab4cfa05b74 100644
> --- a/tools/testing/kunit/kunit_parser.py
> +++ b/tools/testing/kunit/kunit_parser.py
> @@ -134,8 +134,8 @@ def parse_ok_not_ok_test_case(lines: List[str], test_case: TestCase) -> bool:
>         else:
>                 return False
>
> -SUBTEST_DIAGNOSTIC = re.compile(r'^[\s]+# .*?: (.*)$')
> -DIAGNOSTIC_CRASH_MESSAGE = 'kunit test case crashed!'
> +SUBTEST_DIAGNOSTIC = re.compile(r'^[\s]+# (.*)$')
> +DIAGNOSTIC_CRASH_MESSAGE = re.compile(r'^[\s]+# .*?: kunit test case crashed!$')
>
>  def parse_diagnostic(lines: List[str], test_case: TestCase) -> bool:
>         save_non_diagnositic(lines, test_case)
> @@ -145,7 +145,8 @@ def parse_diagnostic(lines: List[str], test_case: TestCase) -> bool:
>         match = SUBTEST_DIAGNOSTIC.match(line)
>         if match:
>                 test_case.log.append(lines.pop(0))
> -               if match.group(1) == DIAGNOSTIC_CRASH_MESSAGE:
> +               crash_match = DIAGNOSTIC_CRASH_MESSAGE.match(line)
> +               if crash_match:
>                         test_case.status = TestStatus.TEST_CRASHED
>                 return True
>         else:
> --
> 2.29.2.222.g5d2a92d10f8-goog
>
