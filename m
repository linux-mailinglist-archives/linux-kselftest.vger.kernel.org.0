Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB6AF17207C
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2020 15:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731348AbgB0OnX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Feb 2020 09:43:23 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:36510 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731060AbgB0OnW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Feb 2020 09:43:22 -0500
Received: by mail-vs1-f66.google.com with SMTP id a2so1984431vso.3
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2020 06:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z+isuoKHbYPGILyMICbGR0T5QiMYRy4J1XMZ/c0MyCE=;
        b=dsz/dd+K0I4XD1YrhrhPrHHrR191LtRyLN7aW8hmkbZPgrrvlzPCU2Smg1NEu36eT6
         KHLffuYRjxM41BUOtcI6irVNls7ebDoaPsitXlh9zLNYML4FI9hSwEqIRBSYmpQPdrk6
         +5Jc5auj6M+JJe2bJ1uLklew3o9sgGElGwB3XYKUXjOLArCJ0cpQkL84PKxdozFzjvc+
         KIlGHGfjb2TATOqqIOqDSze6qeAqyF/kaKk98t/jbfQT0r2qx6PrOxDMGQ4f7S6IIwmt
         dbHDeywyho5NjaxRwEKTM+v75sCIpKtLn9ske4II8+0vX697sx2/ui4at3opVGGi2eJP
         BmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z+isuoKHbYPGILyMICbGR0T5QiMYRy4J1XMZ/c0MyCE=;
        b=Z3/90eeSXyqPCMcu2thOljWS8SlQBNN2uKERg+j/izC/v55gAW7aJNe7P1HM+iZTzH
         uWZr0kNY4q+AMTX7HF13J153aanoc8bkXC9fmWDl/AT6dcfhcP7NYcRE5P7GSaHS+U0w
         rojfYTfb5AJ9XVkgraKs2XnDM2TE9+zRh7xVAMqG/MiVgzocxVLypo+Za3S+T3rYojOj
         jqSSY5jNhSQuO+xzJZxe7aYr8M03yRjjVZLsyVeVjpcFsxBhXD5RcRnfn2JAzKoq1txY
         gZRTkccQ4rTpCCMfpRTre9CP7UGCacNlZErWfDy346QuOXpSAOYVVFjW9Bg6U4vJ3KNm
         s9ow==
X-Gm-Message-State: APjAAAXJSAcrcKaIRPeWRJ4MmMtwM/RDszF9k/fUmSRDpKH2sVBISCjf
        oVYbQLwpFIyiTaglmOF9ZEWXrOt+AkAfZD6SMHI1hA==
X-Google-Smtp-Source: APXvYqwcq58o1fQ/mxg6LapwJjViDpXeZMxMof5dGvU3nXZs+HFFCPF/LbTlE/gRBPnnUHHPHu5q3xLtm8y/xdFNsQ0=
X-Received: by 2002:a67:f318:: with SMTP id p24mr2787324vsf.240.1582814601592;
 Thu, 27 Feb 2020 06:43:21 -0800 (PST)
MIME-Version: 1.0
References: <20200227024301.217042-1-trishalfonso@google.com> <20200227024301.217042-2-trishalfonso@google.com>
In-Reply-To: <20200227024301.217042-2-trishalfonso@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 27 Feb 2020 15:43:10 +0100
Message-ID: <CACT4Y+YFewcbRnY62wLHueVNwyXCSZwO8K7SUR2cg=pxZv8uZA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] KUnit: KASAN Integration
To:     Patricia Alfonso <trishalfonso@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>, vincent.guittot@linaro.org,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 27, 2020 at 3:44 AM 'Patricia Alfonso' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> Integrate KASAN into KUnit testing framework.
>  - Fail tests when KASAN reports an error that is not expected
>  - Use KUNIT_EXPECT_KASAN_FAIL to expect a KASAN error in KASAN tests
>  - KUnit struct added to current task to keep track of the current test
> from KASAN code
>  - Booleans representing if a KASAN report is expected and if a KASAN
>  report is found added to kunit struct
>  - This prints "line# has passed" or "line# has failed"
>
> Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
> ---
> If anyone has any suggestions on how best to print the failure
> messages, please share!
>
> One issue I have found while testing this is the allocation fails in
> kmalloc_pagealloc_oob_right() sometimes, but not consistently. This
> does cause the test to fail on the KUnit side, as expected, but it
> seems to skip all the tests before this one because the output starts
> with this failure instead of with the first test, kmalloc_oob_right().

I don't follow this... we don't check output in any way, so how does
output affect execution?...


> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -141,7 +141,7 @@ class LinuxSourceTree(object):
>                 return True
>
>         def run_kernel(self, args=[], timeout=None, build_dir=''):
> -               args.extend(['mem=256M'])
> +               args.extend(['mem=256M', 'kasan_multi_shot'])

This is better done somewhere else (different default value if
KASAN_TEST is enabled or something). Or overridden in the KASAN tests.
Not everybody uses tools/testing/kunit/kunit_kernel.py and this seems
to be a mandatory part now. This means people will always hit this, be
confused, figure out they need to flip the value, and only then be
able to run kunit+kasan.


>                 process = self._ops.linux_bin(args, timeout, build_dir)
>                 with open(os.path.join(build_dir, 'test.log'), 'w') as f:
>                         for line in process.stdout:
