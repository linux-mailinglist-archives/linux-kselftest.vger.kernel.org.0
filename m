Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63FC6D5523
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Apr 2023 01:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbjDCXRm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Apr 2023 19:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233591AbjDCXRl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Apr 2023 19:17:41 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F257BFF
        for <linux-kselftest@vger.kernel.org>; Mon,  3 Apr 2023 16:17:40 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id h31so18550522pgl.6
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Apr 2023 16:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680563860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fL5aL7ueJMbZFfg2C1YEce55qF2blBEt+U5Y2R4F0x8=;
        b=heQGaq5JSUiONOze0+sgMt3BY4yh1MXR60iNGsJnSnCwUPz3PGzvkoSTCovdOnIanZ
         Qv5+kttSgXzH/C+6iNGQyhvFen9aa8LT2KHMP7p8elo5gq4sDqoV5wGjjC6X72L385d4
         KCGXmhKMTjpK75uOwiAmI0M6yd8H4qpM9tapP70G1dQ6avtihVJNYxggCYLGTtIhhdBO
         yUIaEPWOxdV+43VRFix1Mgb/qMZs/5LvtCunIK5hCLor2bwMMQgXfL1k1N3T3T1h3a5Z
         4/ZANM55rgv7h1LkUFTu0n0j0iO5fL4ULCQLzTBuJGVXO1im1LTC1mYHpMSaEwPnuxnr
         d/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680563860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fL5aL7ueJMbZFfg2C1YEce55qF2blBEt+U5Y2R4F0x8=;
        b=eg7vxKKO1h4sR/tZ8lChr/yb5St9Au6Z9qOha3o1dse8pTQbr71vm+NJ19mBmcP/Oi
         70ugMBxQmLPJZPTdmaCYsb3I3WPnmKakVCy7WSVKQEpcgTMAXM4Jt9g7h2n3UlIn5Vbb
         EsCp2MthDb3v4GTqZAH+V1/yUsCayx6Qtx4NhcB9NeMvcfSlSfbeCyl11cdArJFy9fvB
         07qMnE2cGzvJnKFnovrgB9I/xX9jVw1gqMix5oO4lhS4XCPeqj1YvfnsrRfOQ4ENYk6v
         kiDaWd2/tZ/DHqG3i9646rIIJXSmr6BjUKSSw3teJ+levRUldUtANPWAimUktxYQGpuR
         mLMg==
X-Gm-Message-State: AAQBX9dxJc3sd4NXPCZwukZCMISIZ8tC+fbpPtEcN1ABF1M2mfmJCufZ
        Tvf/WU/2cCg3zxD1kuKiRv/LGdce5829obgT3ofm9w==
X-Google-Smtp-Source: AKy350YYGanRvcClBEn93vto0mI4p4oBfDFO0zFPG7UTZ/7lVw8xoM9Ae6DqSongpPNh8kvMWVUapf0C7yNdA35C3cU=
X-Received: by 2002:a63:eb50:0:b0:509:4ac5:7f44 with SMTP id
 b16-20020a63eb50000000b005094ac57f44mr88131pgk.2.1680563860189; Mon, 03 Apr
 2023 16:17:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230403201930.2019419-1-rmoar@google.com>
In-Reply-To: <20230403201930.2019419-1-rmoar@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 3 Apr 2023 16:17:29 -0700
Message-ID: <CAGS_qxp5NAox7eGqfa48zi5=QEgB48ior-tXwtDFEqCJ=vFCEA@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: add tests for using current KUnit test field
To:     Rae Moar <rmoar@google.com>
Cc:     brendanhiggins@google.com, davidgow@google.com,
        skhan@linuxfoundation.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Apr 3, 2023 at 1:19=E2=80=AFPM Rae Moar <rmoar@google.com> wrote:
>
> Create test suite called "kunit_current" to add test coverage for the use
> of current->kunit_test, which returns the current KUnit test.
>
> Add two test cases:
> - kunit_current_test to test current->kunit_test and the method
>   kunit_get_current_test(), which utilizes current->kunit_test.
>
> - kunit_current_fail_test to test the method
>   kunit_fail_current_test(), which utilizes current->kunit_test.
>
> Signed-off-by: Rae Moar <rmoar@google.com>

Reviewed-by: Daniel Latypov <dlatypov@google.com>

Looks good and runs well here.
It's nice to have a test for this given kunit_fail_current_test() went
from a simple function call to now using `kunit_hooks` to do an
indirect call and relying on the `kunit_running` static key.


> ---
>
> Changes from v1->v2:
> - Combine two test cases to test both ways of getting current test in
>   kunit_current_test.
> - Changes to comments.
> - Add kunit_cleanup to kunit_current_fail_test.
>
>  lib/kunit/kunit-test.c | 42 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)
>
> diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
> index b63595d3e241..42e44caa1bdd 100644
> --- a/lib/kunit/kunit-test.c
> +++ b/lib/kunit/kunit-test.c
> @@ -6,6 +6,7 @@
>   * Author: Brendan Higgins <brendanhiggins@google.com>
>   */
>  #include <kunit/test.h>
> +#include <kunit/test-bug.h>
>
>  #include "try-catch-impl.h"
>
> @@ -532,7 +533,46 @@ static struct kunit_suite kunit_status_test_suite =
=3D {
>         .test_cases =3D kunit_status_test_cases,
>  };
>
> +static void kunit_current_test(struct kunit *test)
> +{
> +       /* Check results of both current->kunit_test and
> +        * kunit_get_current_test() are equivalent to current test.
> +        */
> +       KUNIT_EXPECT_PTR_EQ(test, test, current->kunit_test);
> +       KUNIT_EXPECT_PTR_EQ(test, test, kunit_get_current_test());
> +}
> +
> +static void kunit_current_fail_test(struct kunit *test)
> +{
> +       struct kunit fake;
> +
> +       kunit_init_test(&fake, "fake test", NULL);
> +       KUNIT_EXPECT_EQ(test, fake.status, KUNIT_SUCCESS);
> +
> +       /* Set current->kunit_test to fake test. */
> +       current->kunit_test =3D &fake;
> +
> +       kunit_fail_current_test("This should make `fake` test fail.");
> +       KUNIT_EXPECT_EQ(test, fake.status, (enum kunit_status)KUNIT_FAILU=
RE);
> +       kunit_cleanup(&fake);
> +
> +       /* Reset current->kunit_test to current test. */
> +       current->kunit_test =3D test;
> +}
> +
> +static struct kunit_case kunit_current_test_cases[] =3D {
> +       KUNIT_CASE(kunit_current_test),
> +       KUNIT_CASE(kunit_current_fail_test),
> +       {}
> +};
> +
> +static struct kunit_suite kunit_current_test_suite =3D {
> +       .name =3D "kunit_current",
> +       .test_cases =3D kunit_current_test_cases,
> +};
> +
>  kunit_test_suites(&kunit_try_catch_test_suite, &kunit_resource_test_suit=
e,
> -                 &kunit_log_test_suite, &kunit_status_test_suite);
> +                 &kunit_log_test_suite, &kunit_status_test_suite,
> +                 &kunit_current_test_suite);
>
>  MODULE_LICENSE("GPL v2");
>
> base-commit: 7232282dd47cce6a780c9414bd9baccf232c7686
> --
> 2.40.0.348.gf938b09366-goog
>
