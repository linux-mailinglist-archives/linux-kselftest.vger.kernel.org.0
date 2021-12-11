Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7366747162A
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Dec 2021 21:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbhLKUhe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 11 Dec 2021 15:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbhLKUhe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 11 Dec 2021 15:37:34 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245F1C061751
        for <linux-kselftest@vger.kernel.org>; Sat, 11 Dec 2021 12:37:34 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id e128so14275116iof.1
        for <linux-kselftest@vger.kernel.org>; Sat, 11 Dec 2021 12:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vimKUBu4jl1yDMrzMKNMXbtLDYzaP8Rhsu237Y7354I=;
        b=dh0SHigCv4/fO/fM257DhD4dXavhZ9244NcnFJ4NjMA4iEaOEs2DOV1RMCM5k7xhzi
         qWkyXD5n2WlAucY7ltc//CmHIk329EcYDhGB0/DTVqd5yHBI/bkNtd4HzHyfKsh+h7i/
         pcG6d3zAL/dq+QMfKtv+xeBXfx3UTUU69lcsetHlLX6rlLJ2hjrOsHa/dYz5rCkeDC3r
         FBBSqNRx+N6RrZKzofXZdqxlKBurs0MYTybwMflFE5+DNI7U0VnRQdrN10XHH93+XU7W
         dGfXaG/pYd7FTNs2pid5gXxCNqVKJOj9/Z3bmy/sLa8D1o13y5+nsurbqM5WY/7GWiOj
         c4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vimKUBu4jl1yDMrzMKNMXbtLDYzaP8Rhsu237Y7354I=;
        b=Juaz8OEJ6vYp4XfaWnv8ylkXPZ3nW67UEUNYnfU/8LohpZP2NXGBaXsmEiDQ4w2dKE
         KUARvQ+vFAgVScbKZj6VqCDz1aMNFovMlDUT7lNqk8YcknxekmaJlW/xy819+llBOvco
         2313TDiHPck3wqrAUkZb0xIxlFRR7pQi/TU1iIaG7cEHn7zxsa5OjtzEdmsxs/B9QN9q
         XYG+2R51G0BXhynabFyp/fnIT0OPAjZcpaaVESpXLgyX5Cs8tStgF2snP+Sn75n7TnWf
         cv0pXOLYYk9tYVPzXEoI25j43clibqz/SaYelJkRDpC+WkSaZp8qbryn2as3y6q70IXC
         sSrA==
X-Gm-Message-State: AOAM531/oR70e/uWNE/54e1IPyGmJFt418YLI66BvjFrb7gVVPEXM79+
        nD318rnwLhYJCTwNbeNGH4Vm0ylFCgsE6e/8+7LA0g==
X-Google-Smtp-Source: ABdhPJwWiv46khWjoDfNffz//oMDNQtsoju0bZe08RkhtTRCY+X8rh8SN3c1haaBR+WLssUWIVio8ctXjtveB1X4dAc=
X-Received: by 2002:a5e:8a41:: with SMTP id o1mr26618187iom.131.1639255053377;
 Sat, 11 Dec 2021 12:37:33 -0800 (PST)
MIME-Version: 1.0
References: <20211211084928.410669-1-davidgow@google.com>
In-Reply-To: <20211211084928.410669-1-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Sat, 11 Dec 2021 12:37:22 -0800
Message-ID: <CAGS_qxqAqnEo5iojk85uhuD9dcRNxTw030nfCMCsMADm9RsmbA@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Default --jobs to number of CPUs
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Dec 11, 2021 at 12:49 AM David Gow <davidgow@google.com> wrote:
>
> The --jobs parameter for kunit_tool currently defaults to 8 CPUs,
> regardless of the number available. For systems with significantly more
> (or less), this is not as efficient. Instead, default --jobs to the
> number of CPUs present in the system: while there are as many
> superstitions as to exactly what the ideal jobs:CPU ratio is, this seems
> sufficiently sensible to me.
>
> Signed-off-by: David Gow <davidgow@google.com>

Reminder: the unit tests depend on this hard-coded value.
$ ag '\b8\b' tools/testing/kunit/kunit_tool_test.py
422:
self.linux_source_mock.build_kernel.assert_called_once_with(False, 8,
'.kunit', None)
529:
self.linux_source_mock.build_kernel.assert_called_once_with(False, 8,
build_dir, None)

> ---
>  tools/testing/kunit/kunit.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index 68e6f461c758..2cb6c7db5683 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -310,7 +310,7 @@ def add_build_opts(parser) -> None:
>         parser.add_argument('--jobs',
>                             help='As in the make command, "Specifies  the number of '
>                             'jobs (commands) to run simultaneously."',
> -                           type=int, default=8, metavar='jobs')
> +                           type=int, default=os.cpu_count(), metavar='jobs')

Just looking for edge cases:
https://docs.python.org/3/library/os.html#os.cpu_count says
> Returns None if undetermined
and
> This number is not equivalent to the number of CPUs the current process can use. The number of usable CPUs can be obtained with len(os.sched_getaffinity(0))

I assume the None caveat is mainly for other operating systems and
doubt it'll impact any users.
The second point is a bit more interesting, but still niche.
Up to you if you want to use that instead.

Super unscientific comparison (n=1) running all on CPU #0

$ taskset 0x1 ./tools/testing/kunit/kunit.py run --jobs=1
Elapsed time: ... 155.978s building ...

--jobs=2 (some people swear by the 2x ratio)
Elapsed time: ... 158.891s building ...

--jobs=8 (Old behavior)
...
Elapsed time: ... 171.448s building

--jobs=32
Elapsed time: ...  170.765s building ...

So the overhead of j being "too high" isn't that bad and it doesn't
seem to matter much either way.


>
>  def add_exec_opts(parser) -> None:
>         parser.add_argument('--timeout',
> --
> 2.34.1.173.g76aa8bc2d0-goog
>
