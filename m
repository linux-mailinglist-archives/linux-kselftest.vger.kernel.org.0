Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1A73B4803
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jun 2021 19:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhFYRKv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Jun 2021 13:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbhFYRKv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Jun 2021 13:10:51 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F19C061766
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Jun 2021 10:08:30 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id v3so13263569ioq.9
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Jun 2021 10:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BAeKdqZ59vL1Zbwsx1VHL+yJw2gaJxpfVIkCy9lIIDI=;
        b=v2hF/rN8oc5jKd1ALzPWk2TqOGe7FSqh+ichwcaElu6TvqiyWhiT4zV2KMjbDQkBAy
         uwz0094OrW3Y8TenuJLLSsVxlFswLB1DFhqBR8qk8UtVOuU7RAprdwhEwrW5XaWn6Zfx
         6KfusyDZXfJtjP2BDG61Cw8yEjdl6xTUahNe4L+v9Cuttm418J5E1hdBysgqgLuTi9zL
         q9GSO3W7MK8nR3yupHB1FGQFP6H+kKn5cpYFOdxkwuJELj3kkeVFvvWEZeQheb1h8ujp
         UAxcvjRgF72WF40kJzjCE0+Z1Uxt+qKrmYvgrVYDRFfwM23Ngws4ne+gHVBuHk95LuuF
         5uXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BAeKdqZ59vL1Zbwsx1VHL+yJw2gaJxpfVIkCy9lIIDI=;
        b=Evebqg072xGPQQhC7QV7q/aW6Vjp2jOqyjKuCwTl1ncVgrTTpWNSQ52CoMGIo1md5K
         RuYZM44wbYwbLt1/NrGRjttKhNNM41vaAcdd4cN1YcBwA4jpAt9duMjZLKMoYFt60+dn
         DlZGspCq2PL7CASa6sgyfcHyyRNCpjPWQwMPkDOdIn+r8qNWMvZczkaSSJHpvnWeVhyy
         3IvkHyaf0baNXuTCQvinoXAH6F18uNs9kpIVjQkjYybSoiQFb9wtlMyAxweK66csqblu
         7CnDVBd8oVjZyrwFmqrEuTKXdSXfjAUHN0TRKRyM331yZ+GESVxDrBJ5SMoYdUFjQCHX
         XdrA==
X-Gm-Message-State: AOAM5327nw9m5G32Ag4IZYV2pwN8xjGkfhRsju7agEZ21Fh+cbSOQeXp
        NGKIt8GSPAswIn7bMeyw419SnIzMfOi7d/F/4KzzmA==
X-Google-Smtp-Source: ABdhPJz8mi1eUDrZtCpfq6twQvh+DMXZW+fiAz3Rb1m6GEIwRkHIn+RG6CZH6YT8nl+vaVFkIkUDuJ94CAPpbFadYos=
X-Received: by 2002:a05:6638:110e:: with SMTP id n14mr10388327jal.4.1624640909410;
 Fri, 25 Jun 2021 10:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210625111603.358518-1-davidgow@google.com> <99c2564c-4175-7e3e-84c3-3bcb6d4f9d58@linuxfoundation.org>
In-Reply-To: <99c2564c-4175-7e3e-84c3-3bcb6d4f9d58@linuxfoundation.org>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 25 Jun 2021 10:08:17 -0700
Message-ID: <CAGS_qxqCBZy+b1-pFc4Eh9AExc7XRkB2LZ2b776bX=oY2C4qfw@mail.gmail.com>
Subject: Re: [PATCH] kunit: Fix merge issue in suite filtering test
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 25, 2021 at 9:11 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 6/25/21 5:16 AM, David Gow wrote:
> > There were a couple of errors introuced when
> > "kunit: add unit test for filtering suites by names"[1] was merged in
> > c9d80ffc5a.
> >
> > An erroneous '+' was introduced in executor.c, and the executor_test.c
> > file went missing. This causes the kernel to fail to compile if
> > CONFIG_KUNIT is enabled, as reported in [2,3].
> >
> > As with the original, I've tested by running just the new tests using
> > itself:
> > $ ./tools/testing/kunit/kunit.py run '*exec*'
> >
> > [1]: https://lore.kernel.org/linux-kselftest/20210421020427.2384721-1-dlatypov@google.com/
> > [2]: https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org/thread/6IKQX5JXZF7I3NFH4IAWUMHXEQSCPNDP/
> > [3]: https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org/thread/EKY7ZH5YDCCTSJF2G7XFPMGIXQSUVD3Y/
> >
> > Fixes: c9d80ffc5a ("kunit: add unit test for filtering suites by names")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: David Gow <davidgow@google.com>
> > ---
> >
> > This is another fix for the kunit-fixes branch, where there seems to
> > have been an issue merging the "kunit: add unit test for filtering
> > suites by names" patch here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit-fixes&id=c9d80ffc5a0a30955de0b8c5c46a05906d417800
> >
> > Again, feel free to squash this into the original patch if that works
> > better.
> >
>
> Thank you. My bad. Applied to kunit-fixes now.

Hmm, it looks like executor_test.c might not have made it into kunit-fixes.
I believe this is the applied version of this patch:

$ git show d833ce7480864d4d7eb2dbb04320858be3578b2a --stat
commit d833ce7480864d4d7eb2dbb04320858be3578b2a
Author: David Gow <davidgow@google.com>
Date:   Fri Jun 25 04:16:03 2021 -0700

    kunit: Fix merge issue in suite filtering test
...
 lib/kunit/executor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

The result looks like this:
$ ./tools/testing/kunit/kunit.py run
...
$ make ARCH=um --jobs=8 O=.kunit
ERROR:root:../lib/kunit/executor.c:140:10: fatal error:
executor_test.c: No such file or directory
  140 | #include "executor_test.c"
      |          ^~~~~~~~~~~~~~~~~


I just `git am` or something just really doesn't like executor_test.c :)




>
>
>
> thanks,
>
> -- Shuah
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/99c2564c-4175-7e3e-84c3-3bcb6d4f9d58%40linuxfoundation.org.
