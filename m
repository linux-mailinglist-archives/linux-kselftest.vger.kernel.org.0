Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F765EE859
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Sep 2022 23:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbiI1VfW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Sep 2022 17:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbiI1VfT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Sep 2022 17:35:19 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F66E7CAA9
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Sep 2022 14:35:15 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id gb14so176166qtb.3
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Sep 2022 14:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ecE1Wx59U8t3VWPKgBMV6HjrUaa0NrKvwxKOMa7cu78=;
        b=WGRBNqUvFZg2MFhAZmLvc6rOlYFQ4xW1vV7wew3evrEEtE3AhA/VGXXhd4k1+RHdxY
         kRPD8IQ2xjMsIUOjOULvRBGZ2zqWcU92VB5AleE/zbzWYGq8eguh+ywyNIcYapxbX6ea
         GVIQ1D+U0/ao68iv4JOcruPE3HBfS/9UdnZA0mIxKB8fB2Yj7kQyIjg2SSVYvTxH2V/T
         p48OOj+01GsDG/RXSXh2msfIHNdX8eAohIzOMRkfUqM1PCqObtFueQBKm2UiuzHUEBKV
         kLte9ta4qVBhRGWsxRU7wQSHDSgE/Bk1IF294evur0uPQMns/qxPfEd1By8c2vlJHq68
         IHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ecE1Wx59U8t3VWPKgBMV6HjrUaa0NrKvwxKOMa7cu78=;
        b=MaMf74pI4GJ5uwXHzM57cB3oSzIgdQDLgWuXlgkKupZC7tagXqzJgE4HHlHTnnb3C0
         xKMIv5Xgm3XWLsbKWlYWji06AUpKJKB3HWzKoNXjBOdkoSroBLnoBKxsJTehG7HYlHPJ
         rBv8Qfe6zt1eJ5hM/14yaMmmQNNwVNRslcoXse6ziTAyRDdWjK1aXqUibL6IfQh+9vCn
         MJyKjJ91shOxVuWzhH30qvkx30YbL6TYwQcuH91mzEXm/G3s89vZRq1G97U/xLPbcnn+
         Cd+cT9Y7AGGLCy9bH491ROeeIKAkgvT7ZY49HyLZDwKeJLiuzpXL1WDC9VAAcNYnBoVy
         T1gQ==
X-Gm-Message-State: ACrzQf2ZzzZi1uS/p4XI43wGgSfjFYzYxS6WQW6niJOwBZJ/eqJ9t28v
        AFJHkXAago5+iwzCWojWt2BY1piteMu2AmDKbKEy
X-Google-Smtp-Source: AMsMyM6OLvuKw2TK/y8ZPoMH1L7oucP6uw70jeNI8iPFQWMKO204VYaXNDz2brHt+XkEviSSpKmQXKj0ZkhjlJJyaEM=
X-Received: by 2002:ac8:5e51:0:b0:35c:e40f:d898 with SMTP id
 i17-20020ac85e51000000b0035ce40fd898mr29035261qtx.685.1664400914106; Wed, 28
 Sep 2022 14:35:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220823142456.3977086-1-joefradley@google.com>
 <10f97a94-ab35-fbc7-4dd7-98586a027c8b@gmail.com> <CAF-60z2huZ0scPzrV8mrZGzH0Ha6-c+iszOdcpVV7y020m4arw@mail.gmail.com>
 <9024bdb2-4460-0424-42f4-b280983f3146@gmail.com>
In-Reply-To: <9024bdb2-4460-0424-42f4-b280983f3146@gmail.com>
From:   Joe Fradley <joefradley@google.com>
Date:   Wed, 28 Sep 2022 14:35:03 -0700
Message-ID: <CAF-60z1OOR7DebmF9ua7oXX3Tj8XpGpbsd9pve3efy4NrnsfBQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] kunit: add boot time parameter to enable KUnit
To:     Tales Aparecida <tales.aparecida@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, David Gow <davidgow@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        kernel-team@android.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 28, 2022 at 10:26 AM Tales Aparecida
<tales.aparecida@gmail.com> wrote:
>
> On 28/09/2022 10:58, Joe Fradley wrote:
> > On Sat, Sep 24, 2022 at 5:42 PM Tales Aparecida
> > <tales.aparecida@gmail.com> wrote:
> >>
> >> Hi,
> >>
> >>
> >> This series is
> >> Tested-by: Tales Aparecida <tales.aparecida@gmail.com>
> >>
> >> 1. Tested using kunit_tool: running tests and showing output as expected.
> >>
> >> 2. Tested further by running QEMU through virtme-run with:
> >>    $ ../virtme/virtme-run --show-command --kdir ../linux/.for-amd/ --mods=auto --kopt kunit.enable=1
> >>
> >> 2.a. "KUNIT_DEFAULT_ENABLED" works as expected when "kunit.enable" is omitted
> >> 2.b. kunit.enable=0 results in printing "kunit: disabled" on boot and on loading test modules, as expected
> >> 3.c. kunit.enable=1 runs tests on boot and allows them to run when loading test modules
> >>
> >> 3. Regarding taint
> >> 3.a. /proc/sys/kernel/tainted is 0 when kunit.enable=0 and does not change when trying to load test modules.
> >> 3.b. /proc/sys/kernel/tainted is 0 when kunit.enable=1 until the first test runs, then it becomes 262144 (2^18) as expected.
> >
> > Tales, thank you for doing this testing.
> >
> >>
> >>
> >> On other note, there's something I would like to delve into below.
> >>
> >>
> >> On 23/08/2022 11:24, Joe Fradley wrote:
> >>> v2:
> >>>  - Added enable check in executor.c to prevent wrong error output from
> >>>    kunit_tool.py when run against a KUnit disabled kernel
> >>>  - kunit_tool.py now passes kunit.enable=1
> >>>  - Flipped around logic of new config to KUNIT_DEFAULT_ENABLED
> >>>  - Now load modules containing tests but not executing them
> >>>  - Various message/description text clean up
> >>>
> >>> There are some use cases where the kernel binary is desired to be the same
> >>> for both production and testing. This poses a problem for users of KUnit
> >>> as built-in tests will automatically run at startup and test modules
> >>> can still be loaded leaving the kernel in an unsafe state. There is a
> >>> "test" taint flag that gets set if a test runs but nothing to prevent
> >>> the execution.
> >>
> >> Do you have any info on whether these use cases would have something against writing tests for static functions using the documented approach of including the tests into the actual runtime code?
> >> https://docs.kernel.org/dev-tools/kunit/usage.html#testing-static-functions
> >>
> >> Otherwise, would them agree to export the symbols that need to be tested?
> >>
> >> I would really like to understand better what are these use cases :)
> >
> > I feel using the static functions as described in your link is a good
> > alternative to
> > modules with embedded KUnit tests. However, this is a different use case then
> > I refer to, which is the ability to have the framework embedded in the
> > kernel for
> > both production and test with the control of test execution gated on a kernel
> > command line parameter.
> >
>
> I have another question regarding the compilation in this use case.
>
> Does it have a strict requirement to minimize the kernel size?

Even though kunit.enable will work as expected for built-in tests,
it's geared more towards the loading test modules scenario. It doesn't
have any requirements for kernel size.  But if built-in tests are
included the cost of the extra space will need to be weighed against
the value of having the option to activate the tests via kunit.enable.

> That is, is there any requirement around built-in test modules
> and/or a plan to load test modules on demand when booting with
> kunit.enable=1?

There's no current plan to load test modules on demand that wouldn't
otherwise be loaded when kunit.enable=1.

>
>
> I would also like to know whether the use case includes running
> unit tests for AMDGPU or DRM, just so we can be aware of it when
> writing more tests for static functions using the approach shown
> in that link.

I can't speak specifically about AMDGPU or DRM at the moment
because it depends on the targets we're testing. But it's a good
question in general about tests that are embedded in modules. It's
effectively the same tradeoff I mentioned earlier in regards to built-in
tests. The pros in having the tests activated by kunit.enable would
need to outweigh the cons of the size addition. It would be
preferable for the tests to be in a separate module.



>
> >>
> >>>
> >>> This patch adds the kunit.enable module parameter that will need to be
> >>> set to true in addition to KUNIT being enabled for KUnit tests to run.
> >>> The default value is true giving backwards compatibility. However, for
> >>> the production+testing use case the new config option KUNIT_DEFAULT_ENABLED
> >>> can be set to N requiring the tester to opt-in by passing kunit.enable=1 to
> >>> the kernel.
> >>>
> >>> Joe Fradley (2):
> >>>   kunit: add kunit.enable to enable/disable KUnit test
> >>>   kunit: no longer call module_info(test, "Y") for kunit modules
> >>>
> >>>  .../admin-guide/kernel-parameters.txt         |  6 +++++
> >>>  include/kunit/test.h                          |  3 ++-
> >>>  lib/kunit/Kconfig                             | 11 +++++++++
> >>>  lib/kunit/executor.c                          |  4 ++++
> >>>  lib/kunit/test.c                              | 24 +++++++++++++++++++
> >>>  tools/testing/kunit/kunit_kernel.py           |  1 +
> >>>  6 files changed, 48 insertions(+), 1 deletion(-)
> >>>
> >>
> >> Great work!
> >>
> >> Kind regards,
> >> Tales
