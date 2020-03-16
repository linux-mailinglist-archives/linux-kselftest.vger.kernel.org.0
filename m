Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5050A187408
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Mar 2020 21:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732535AbgCPU1c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Mar 2020 16:27:32 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33246 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732532AbgCPU1c (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Mar 2020 16:27:32 -0400
Received: by mail-qk1-f195.google.com with SMTP id q17so3994687qki.0
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Mar 2020 13:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S2gv1QhjogxptslpnkdxgZhw8u/nAyfilbVaSMlvcmU=;
        b=PMiOVc3vQbipGLvlB6qHP0Ixsz0PjMhpv8/8WD86hkkaD7DCDUtRTaLv/Veghz8yaY
         bvFeSUzKfRpitgsIMyOeBQAuV41Om8Rc9UX5jsVnzyLjCi2sKG2KpkOdOE766UR8i3hs
         PgFjzwqYOdh8+BQBzqxGXIn0Q5ZUxAI/GrGwdpyRsQDguhXbbODhq4N1b50sVPPsZgUS
         CJnTQZNio8h84hnqW5iF21LNrggfj1AYOUbxqfrVKa596fPHNv0gl22xM7u0Jtm3i2aa
         8iKSnsdnqs1zTlQYqLDoUchqW432txsk+lO735Fm+yRfyhH901W50Yk78OmLgnf0QJVb
         f0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S2gv1QhjogxptslpnkdxgZhw8u/nAyfilbVaSMlvcmU=;
        b=abLROF6Sp2OTdOmUwrdpN2d2QCgDLIKPm2Anlov8Qe4MHcIHZetl0ytvv2YNKZY9My
         Xwp7/BbdHzvMbCJY4djKurOILv7AE2qPZ8gPPqNXhJabMD0u9HpjbjT1h9+Ezqfm8UAj
         7dNWSBlnsJpcz7sZ023+tmh3SbmsxyKd+9OKUQPCU0fvlQJwf/B4F9y/uPI9hgf0GnpE
         haMe0GDR561hlxzaPPC4+9nqFdYbIxCEdpBsmStmWp2YLONcdtSqHMxJ+WjZFsf9YUsE
         8O2ndV7a2xDBz6KwbECupoaeebWo0hevXIgtdlwWkESm3Z9dnePzAlSq48vkcGC5HLuN
         +uOA==
X-Gm-Message-State: ANhLgQ1lokVO9sebrdWOAULvm00lz3fnDQBzb6fv+SjjrW5X5IpAGABb
        GLexdfiSFA5q/RAbYU614sycydoOcx0qczc7uIis3w==
X-Google-Smtp-Source: ADFU+vshaoIHEoVCoTdfRwECb4uhEWSchW+KhN7IDeSP8twzFAjIO6PFEI4jhrTTmXzwanIWsN9cc6E6UGLZPGWyvOc=
X-Received: by 2002:a37:f511:: with SMTP id l17mr1520749qkk.479.1584390450866;
 Mon, 16 Mar 2020 13:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200305200409.239406-1-heidifahim@google.com>
 <CAFd5g45HSuxcP8_-yaJY4M=Acy14L=FTwY3GT_m-eTVtP6NJhQ@mail.gmail.com> <b8777872-189b-b361-6ff4-c7cd51772dfd@kernel.org>
In-Reply-To: <b8777872-189b-b361-6ff4-c7cd51772dfd@kernel.org>
From:   Heidi Fahim <heidifahim@google.com>
Date:   Mon, 16 Mar 2020 13:27:19 -0700
Message-ID: <CAMVcs3uBetxWdLw=R86D1by3+SJO3ruo5Z7UUA_YHF9Hu3BKFw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kunit: kunit_parser: make parser more robust
To:     shuah <shuah@kernel.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 13, 2020 at 1:22 PM shuah <shuah@kernel.org> wrote:
>
> On 3/5/20 2:25 PM, Brendan Higgins wrote:
> > On Thu, Mar 5, 2020 at 12:04 PM Heidi Fahim <heidifahim@google.com> wrote:
> >>
> >> Previously, kunit_parser did not properly handle kunit TAP output that
> >> - had any prefixes (generated from different configs e.g.
> >> CONFIG_PRINTK_TIME)
> >> - had unrelated kernel output mixed in the middle of
> >> it, which has shown up when testing with allyesconfig
> >> To remove prefixes, the parser looks for the first line that includes
> >> TAP output, "TAP version 14".  It then determines the length of the
> >> string before this sequence, and strips that number of characters off
> >> the beginning of the following lines until the last KUnit output line is
> >> reached.
> >> These fixes have been tested with additional tests in the
> >> KUnitParseTest and their associated logs have also been added.
> >>
> >> Signed-off-by: Heidi Fahim <heidifahim@google.com>
> >
> > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> >
>
> Heidi and Brendan,
>
> git apply is throwing away formatting in
>
> tools/testing/kunit/test_data/test_config_printk_time.log
>
>
> Applying: kunit: kunit_parser: make parser more robust
> .git/rebase-apply/patch:396: space before tab in indent.
>         # Subtest: kunit-resource-test
> .git/rebase-apply/patch:397: space before tab in indent.
>         1..5
> .git/rebase-apply/patch:398: space before tab in indent.
>         ok 1 - kunit_resource_test_init_resources
> .git/rebase-apply/patch:399: space before tab in indent.
>         ok 2 - kunit_resource_test_alloc_resource
> .git/rebase-apply/patch:400: space before tab in indent.
>         ok 3 - kunit_resource_test_destroy_resource
> warning: squelched 11 whitespace errors
> warning: 16 lines add whitespace errors.
>
> Can you fix this and resend patches. If apply this as is,
> all the formatting you have in there goes away.
>
> This is what gets applied.
>
> [    0.060000] TAP version 14
> [    0.060000]  # Subtest: kunit-resource-test
> [    0.060000]  1..5
> [    0.060000]  ok 1 - kunit_resource_test_init_resources
> [    0.060000]  ok 2 - kunit_resource_test_alloc_resource
> [    0.060000]  ok 3 - kunit_resource_test_destroy_resource
> [    0.060000]  ok 4 - kunit_resource_test_cleanup_resources
> [    0.060000]  ok 5 - kunit_resource_test_proper_free_ordering
> [    0.060000] ok 1 - kunit-resource-test
> [    0.060000]  # Subtest: kunit-try-catch-test
> [    0.060000]  1..2
> [    0.060000]  ok 1 - kunit_test_try_catch_successful_try_no_catch
> [    0.060000]  ok 2 - kunit_test_try_catch_unsuccessful_try_does_catch
> [    0.060000] ok 2 - kunit-try-catch-test
> [    0.060000]  # Subtest: string-stream-test
> [    0.060000]  1..3
> [    0.060000]  ok 1 - string_stream_test_empty_on_creation
> [    0.060000]  ok 2 - string_stream_test_not_empty_after_add
> [    0.060000]  ok 3 - string_stream_test_get_string
> [    0.060000] ok 3 - string-stream-test
> [    0.060000] List of all partitions:
> [    0.060000] No filesystem could mount root, tried:
>
> thanks,
> -- Shuah

Thanks Shuah. I made the fix by marking the .log files as binaries
which should make the git apply work well now. See my v3 patch for
specifics.

Best,
Heidi
