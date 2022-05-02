Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AFE517A0C
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 May 2022 00:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbiEBWk5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 May 2022 18:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbiEBWk4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 May 2022 18:40:56 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63260112D
        for <linux-kselftest@vger.kernel.org>; Mon,  2 May 2022 15:37:26 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id be20so18108397edb.12
        for <linux-kselftest@vger.kernel.org>; Mon, 02 May 2022 15:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E0CI0L8FLznl+zpxus1ooWUihJs/c/FZ66YeO2QuIbM=;
        b=bilfqug9/u+JZhH84+svlZRP72aMOiEVNWug2iPMUFX96FsRUAJqwwFHtQi/xn+Mql
         PrnLmb8tyQp1BlslX5JvlzwFYryoeGmDCteqh/g76tAhbhR4MzjPvPmf3LeoHanEWe6C
         egzctu32JbbU74GvBRYKIkhSk9fblUY3UP5osBlr0J7AOusfiE5xuHMkdJoZgsfmzt9H
         x/x/9SZfVfxedF8x14IH7uys1w93PdWdNff6ezCa2l5Bf/dTca4uYsTeTDj8kbhN5UYj
         xu7qgrGgBSiLkXnqpOii1dV26oNtWPTLtqqFMS9JTyPzHsO5CjHG4ZU4wmp2TfJPwtFp
         CCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E0CI0L8FLznl+zpxus1ooWUihJs/c/FZ66YeO2QuIbM=;
        b=F8a3W10tUKFldWHhp8l11/Mc1nN2w+p8LA3bukeUqP/K9sGqPfsbuTKA6MkEIuj41r
         5/wc6Br4fWvMnI8zr14NW49dmffMCI9QGs3RWmkzI0tFHeiS5DbJqO0539H1AQDl86pQ
         1HM9xJr48iXfHpShaTmH+uHXmhFODIDU2zulqn2jgTjjOH5ffabFCIryB5IOongrGsjD
         wESbPS+UirxGRZv+1OI7aqdvz7ocCe3TZiAJaZwhwBWpjvqZALmfuOWNb2EZ3Pppv2kl
         OOR3BjdL5jh1UiL81KS6SoOrXDcsNIbySWc/NPKYMylZgpqsW+c2WJ2gbOjGrlMNhuNy
         OQUg==
X-Gm-Message-State: AOAM530fRQ6HQAIdWykbc7+6/prA6XIyq1LdQOsnyz67AaaNERRQhFM+
        otOy3U4iXtz2mUcx0n0fUJYJErnXdKHR9Uq5qCL+dg==
X-Google-Smtp-Source: ABdhPJy7kCW4kIlfBmICFCPRDAJzjcxlbeLzjYkaXGT0caseN13/5/Obe1GLCoeeWBnaCpp+Ag4p9GXLq/e58bwAyMY=
X-Received: by 2002:a05:6402:28b6:b0:425:e137:e31a with SMTP id
 eg54-20020a05640228b600b00425e137e31amr15491035edb.215.1651531044738; Mon, 02
 May 2022 15:37:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220430045639.839186-1-davidgow@google.com>
In-Reply-To: <20220430045639.839186-1-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 2 May 2022 17:37:13 -0500
Message-ID: <CAGS_qxrVnDnUD=0f8vX5C2SWG2mxxXdAWU9A+P7h-K2Y1nm88A@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Add list of all valid test configs on UML
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 29, 2022 at 11:56 PM David Gow <davidgow@google.com> wrote:
>
> It's often desirable (particularly in test automation) to run as many
> tests as possible. This config enables all the tests which work as
> builtins under UML at present, increasing the total tests run from 156
> to 342 (not counting 36 'skipped' tests).

Just to clear up potential confusion for others, I'll note that these
aren't counting test cases.
This is from kunit.py's output, so it counts each parameter from
parameterized tests as "subtests."

Copying my command from
https://kunit-review.googlesource.com/c/linux/+/5249, one can use this
to count the # of test cases.
$ ./tools/testing/kunit/kunit.py run --kunitconfig=...
--raw_output=kunit --kernel_args=kunit.action=list | egrep
'^[a-z0-9_-]+\.[a-z0-9_-]+'

I see this enabling a total of 260 test _cases_ (including skipped).

The default (basically just CONFIG_KUNIT_ALL_TESTS=y) gives 192
(including skipped).

>
> They can be run with:
> ./tools/testing/kunit/kunit.py run
> --kunitconfig=./tools/testing/kunit/configs/all_tests_uml.config
>
> This acts as an in-between point between the KUNIT_ALL_TESTS config
> (which enables only tests whose dependencies are already enabled), and
> the kunit_tool --alltests option, which tries to use allyesconfig,
> taking a very long time to build and breaking very often.
>
> Signed-off-by: David Gow <davidgow@google.com>

Tested-by: Daniel Latypov <dlatypov@google.com>

Looks good to me, some small comments below.

> ---
>  .../kunit/configs/all_tests_uml.config        | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 tools/testing/kunit/configs/all_tests_uml.config
>
> diff --git a/tools/testing/kunit/configs/all_tests_uml.config b/tools/testing/kunit/configs/all_tests_uml.config
> new file mode 100644
> index 000000000000..bdee36bef4a3
> --- /dev/null
> +++ b/tools/testing/kunit/configs/all_tests_uml.config
> @@ -0,0 +1,37 @@
> +# This config enables as many tests as possible under UML.
> +# It is intended for use in continuous integration systems and similar for
> +# automated testing of as much as possible.
> +# The config is manually maintained, though it uses KUNIT_ALL_TESTS=y to enable
> +# any tests whose dependencies are already satisfied. Please feel free to add
> +# more options if they any new tests.

missing: "enable"?
"if they enable any new tests"

Hmm, should we state a preference for how heavy (time or
resource-wise) tests should be?
Because the comment says it's meant for automation, but I can imagine
humans wanting to run it.
(I'm completely fine with us not stating one, just throwing the idea
out there for discussion)

Currently, I get this with an incremental rebuild:
Elapsed time: 141.627s total, 1.384s configuring, 136.175s building,
3.970s running

But we do have tests on other arches that take ~30s to run (kfence),
for example.
Would such tests be candidates for inclusion in this file?
Or is it only problematic when they start taking a couple minutes each?
