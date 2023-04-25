Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884E86EE80B
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Apr 2023 21:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbjDYTLU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Apr 2023 15:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjDYTLU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Apr 2023 15:11:20 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D759F72A9
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Apr 2023 12:11:17 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-3ef31924c64so195311cf.1
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Apr 2023 12:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682449877; x=1685041877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+el9HnAEkjAwcIZXHJipWv7CnhoGdX3eWtO34Q1+csc=;
        b=wl+vbZqUf4Yzyu94qIYHS4scGC2UaPSsAE+Cqii5fIizO2OMMc1SWJ43+ZAxE2swGJ
         EZ1gZf6yYAvLPReAH8Pb5Y3ySeOatOMV5reJCTVgW5KnV/5SbZObLyc0DqR0MHiFg5+W
         5jr9+hcp7BzWyw/wQOOhfKI6k8ni81GLy7HYKR8XOI49+39Ss0WhyFdXGVVAVCIP46/l
         QC5kXL46bjn2Ngu8ulJ7t5D7G5L0Kh2ThOx7N2z0pEP1++SLjPiycvmjSOofZZ9dSx05
         /Qp6bK4njzmgztK9/o1nJrLlroHVAspinRKFceiinQJSpWOdWJhMYYpcK4rgZjsTqSe1
         /1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682449877; x=1685041877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+el9HnAEkjAwcIZXHJipWv7CnhoGdX3eWtO34Q1+csc=;
        b=S0R4Ld0IrXfP3DMQmnJdXh/LdRZq60hbTp6MdKnd++3nvV7KIM7Fha0HHyxzT70kJY
         //rV8WAqIIIMpR+c/t3lDHFJbLRbsw2qOTMY6xRZQykvXRS2DDsNqv3OwBYShbNa+Q5o
         4chHzB2JKtX/lbiVne9u9qMB3ZFMQDgEAn9VMBwDjFLsqiyAm2wrIjjEI6WzmktvKpqx
         WcsfZ4vF+4B8Pu4QTsILMAbuoBrWBuZnwoGHPDHkiDeIF5vbajZG8fssN3mns81sAQSM
         Rn3UZkh18kvcPCsPT2gVO6B3vC1Ds8anEaPn1x5Cq0acU6J5R6Yi80jgD2vty1y5Yc3X
         J6BA==
X-Gm-Message-State: AC+VfDwEUtdwROrrq5ASZ6Ocueuu3Et4Ajs1L36MVLjnc2ZEAJqSH35i
        9eIcRIQMziz71wre4KGTbu8/e6hCYgAfi5bkg/ThFA==
X-Google-Smtp-Source: ACHHUZ5gyvxZ6/VVecCj50kIZMLvP7Q2BZmfrPDjXDGiWXdqIWJieT6NtYd2TO+kGzqAXo/D43kOvGkphSCa9OAEXJ8=
X-Received: by 2002:ac8:4e89:0:b0:3de:b0b0:557c with SMTP id
 9-20020ac84e89000000b003deb0b0557cmr44534qtp.18.1682449876862; Tue, 25 Apr
 2023 12:11:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230421040218.2156548-1-davidgow@google.com> <20230421040218.2156548-4-davidgow@google.com>
In-Reply-To: <20230421040218.2156548-4-davidgow@google.com>
From:   Rae Moar <rmoar@google.com>
Date:   Tue, 25 Apr 2023 15:11:04 -0400
Message-ID: <CA+GJov4+-u3fnqDWCgsp8EjGkm2efbqtaqMFq+_0pWpTnfkurw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] kunit: example: Provide example exit functions
To:     David Gow <davidgow@google.com>
Cc:     Benjamin Berg <benjamin@sipsolutions.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>, maxime@cerno.tech,
        Stephen Boyd <sboyd@kernel.org>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sadiya Kazi <sadiyakazi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Apr 21, 2023 at 12:02=E2=80=AFAM David Gow <davidgow@google.com> wr=
ote:
>
> Add an example .exit and .suite_exit function to the KUnit example
> suite. Given exit functions are a bit more subtle than init functions
> (due to running in a different kthread, and running even after tests or
> test init functions fail), providing an easy place to experiment with
> them is useful.
>
> Signed-off-by: David Gow <davidgow@google.com>

Hi David!

I have reviewed this patch and the overall changes to the cleanup
structure. It looks good to me (other than that kernel test robot
error). Nice to see an example of how to use exit functions in our
example test.

Thanks!
-Rae

Reviewed-by: Rae Moar <rmoar@google.com>

> ---
>
> This patch was introduced in v3.
>
> ---
>  lib/kunit/kunit-example-test.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-tes=
t.c
> index cd8b7e51d02b..24315c882b31 100644
> --- a/lib/kunit/kunit-example-test.c
> +++ b/lib/kunit/kunit-example-test.c
> @@ -41,6 +41,16 @@ static int example_test_init(struct kunit *test)
>         return 0;
>  }
>
> +/*
> + * This is run once after each test case, see the comment on
> + * example_test_suite for more information.
> + */
> +static void example_test_exit(struct kunit *test)
> +{
> +       kunit_info(test, "cleaning up\n");
> +}
> +
> +
>  /*
>   * This is run once before all test cases in the suite.
>   * See the comment on example_test_suite for more information.
> @@ -52,6 +62,16 @@ static int example_test_init_suite(struct kunit_suite =
*suite)
>         return 0;
>  }
>
> +/*
> + * This is run once after all test cases in the suite.
> + * See the comment on example_test_suite for more information.
> + */
> +static void example_test_exit_suite(struct kunit_suite *suite)
> +{
> +       kunit_info(suite, "exiting suite\n");
> +}
> +
> +
>  /*
>   * This test should always be skipped.
>   */
> @@ -211,7 +231,9 @@ static struct kunit_case example_test_cases[] =3D {
>  static struct kunit_suite example_test_suite =3D {
>         .name =3D "example",
>         .init =3D example_test_init,
> +       .exit =3D example_test_exit,
>         .suite_init =3D example_test_init_suite,
> +       .suite_exit =3D example_test_exit_suite,
>         .test_cases =3D example_test_cases,
>  };
>
> --
> 2.40.0.634.g4ca3ef3211-goog
>
