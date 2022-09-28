Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2B95EDE53
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Sep 2022 15:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbiI1N7G (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Sep 2022 09:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbiI1N7F (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Sep 2022 09:59:05 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A8254C9E
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Sep 2022 06:59:02 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id c19so7879425qkm.7
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Sep 2022 06:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Xl3s6np3thQqV7b5PLy2sMzW5jKteWMBx5DZFvaLryE=;
        b=JGOorsiYUNjvI8/WD7E2CgaiXHZQgB0JDGDdZb+8DhWqv7w5VxaqdmkMVPU3vKlnA4
         hGfpg+dHdXAbwVeRNVK5yuL4XBBMjhpS9U6LcEIoXkhsRjeTo9XwC9RvddgpBIpcLM7E
         oX/OcunbT/1d8V348Ux6/ZEPF+DnP1RUNhqMdE2pXckOJlyNmWEfwJmz9yz7ipVMyu3e
         rfHcdl10jK5xZBtHvAfVTZS5FFEwY5A1u7/X82VuJ4xaNY1kHjDsV1BBsXLBsGezoCnl
         8XuU1qyer25lMYkjlYc6Ty3UKKNY37O0cr+quxDXsiwIk2si9Mo0kkFvKE2WWqyl+3YR
         QR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Xl3s6np3thQqV7b5PLy2sMzW5jKteWMBx5DZFvaLryE=;
        b=ChGZDYnZ5AIMRyGEwF/ZNiD8rQKIH7uJV8kKygYniykLSVLX9qgO1BlcM6/JznyDqT
         mRMIwK2Uz5lxUwrWgvS7caeSJqvFxK/hpZKBIlvofNsb32FqvsRZ4wagEAejKBS2OyMS
         yuDSsxdPydnNkHsR94sp7haZih+JcZAVMZcYVwESoi9+ije3CAd22gSRzfkbEqSzvhV2
         Ynu8uzBxyRuhlmxo/y5QligKNgpO2zWYXpV2Mr+uPIqxC/w8+8WV25YbYNXY7ivbBn6y
         vHm1N24wo8fhvKamuFOzLyMlVeN3bzno/b6XC367droiPXPl5CsKyW4Ppf2D6OqgcJfR
         tYlg==
X-Gm-Message-State: ACrzQf1UE3ZiJTczlSh5/B4uSW7E8d4teaAzfBZIbpydUiuMD4wiwlHc
        u7jo0ICWSZpt0/3ky0qi7aI5Y65ed5WlY9NDLdBx
X-Google-Smtp-Source: AMsMyM4H+l18N+zAUfM6ee44zSsHUNaMWwjy7Dmkp444wZ/HV+lUoGmG6UBMyR5k3fA9S/QTZz1TipveiUtv2DF1SWw=
X-Received: by 2002:a05:620a:29c9:b0:6ce:7681:19e9 with SMTP id
 s9-20020a05620a29c900b006ce768119e9mr21006494qkp.297.1664373541846; Wed, 28
 Sep 2022 06:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220823142456.3977086-1-joefradley@google.com> <10f97a94-ab35-fbc7-4dd7-98586a027c8b@gmail.com>
In-Reply-To: <10f97a94-ab35-fbc7-4dd7-98586a027c8b@gmail.com>
From:   Joe Fradley <joefradley@google.com>
Date:   Wed, 28 Sep 2022 06:58:50 -0700
Message-ID: <CAF-60z2huZ0scPzrV8mrZGzH0Ha6-c+iszOdcpVV7y020m4arw@mail.gmail.com>
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Sep 24, 2022 at 5:42 PM Tales Aparecida
<tales.aparecida@gmail.com> wrote:
>
> Hi,
>
>
> This series is
> Tested-by: Tales Aparecida <tales.aparecida@gmail.com>
>
> 1. Tested using kunit_tool: running tests and showing output as expected.
>
> 2. Tested further by running QEMU through virtme-run with:
>    $ ../virtme/virtme-run --show-command --kdir ../linux/.for-amd/ --mods=auto --kopt kunit.enable=1
>
> 2.a. "KUNIT_DEFAULT_ENABLED" works as expected when "kunit.enable" is omitted
> 2.b. kunit.enable=0 results in printing "kunit: disabled" on boot and on loading test modules, as expected
> 3.c. kunit.enable=1 runs tests on boot and allows them to run when loading test modules
>
> 3. Regarding taint
> 3.a. /proc/sys/kernel/tainted is 0 when kunit.enable=0 and does not change when trying to load test modules.
> 3.b. /proc/sys/kernel/tainted is 0 when kunit.enable=1 until the first test runs, then it becomes 262144 (2^18) as expected.

Tales, thank you for doing this testing.

>
>
> On other note, there's something I would like to delve into below.
>
>
> On 23/08/2022 11:24, Joe Fradley wrote:
> > v2:
> >  - Added enable check in executor.c to prevent wrong error output from
> >    kunit_tool.py when run against a KUnit disabled kernel
> >  - kunit_tool.py now passes kunit.enable=1
> >  - Flipped around logic of new config to KUNIT_DEFAULT_ENABLED
> >  - Now load modules containing tests but not executing them
> >  - Various message/description text clean up
> >
> > There are some use cases where the kernel binary is desired to be the same
> > for both production and testing. This poses a problem for users of KUnit
> > as built-in tests will automatically run at startup and test modules
> > can still be loaded leaving the kernel in an unsafe state. There is a
> > "test" taint flag that gets set if a test runs but nothing to prevent
> > the execution.
>
> Do you have any info on whether these use cases would have something against writing tests for static functions using the documented approach of including the tests into the actual runtime code?
> https://docs.kernel.org/dev-tools/kunit/usage.html#testing-static-functions
>
> Otherwise, would them agree to export the symbols that need to be tested?
>
> I would really like to understand better what are these use cases :)

I feel using the static functions as described in your link is a good
alternative to
modules with embedded KUnit tests. However, this is a different use case then
I refer to, which is the ability to have the framework embedded in the
kernel for
both production and test with the control of test execution gated on a kernel
command line parameter.

>
> >
> > This patch adds the kunit.enable module parameter that will need to be
> > set to true in addition to KUNIT being enabled for KUnit tests to run.
> > The default value is true giving backwards compatibility. However, for
> > the production+testing use case the new config option KUNIT_DEFAULT_ENABLED
> > can be set to N requiring the tester to opt-in by passing kunit.enable=1 to
> > the kernel.
> >
> > Joe Fradley (2):
> >   kunit: add kunit.enable to enable/disable KUnit test
> >   kunit: no longer call module_info(test, "Y") for kunit modules
> >
> >  .../admin-guide/kernel-parameters.txt         |  6 +++++
> >  include/kunit/test.h                          |  3 ++-
> >  lib/kunit/Kconfig                             | 11 +++++++++
> >  lib/kunit/executor.c                          |  4 ++++
> >  lib/kunit/test.c                              | 24 +++++++++++++++++++
> >  tools/testing/kunit/kunit_kernel.py           |  1 +
> >  6 files changed, 48 insertions(+), 1 deletion(-)
> >
>
> Great work!
>
> Kind regards,
> Tales
