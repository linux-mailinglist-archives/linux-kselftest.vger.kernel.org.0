Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CA67B26E7
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 22:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjI1Uym (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Sep 2023 16:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbjI1Uyl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Sep 2023 16:54:41 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02211B2
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Sep 2023 13:54:37 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-534694a9f26so1321a12.1
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Sep 2023 13:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695934476; x=1696539276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTaV4VyiNGopMAo3snspiaAuae6NCzQuBXwYXK+cknU=;
        b=06x8sj5l7t7tQvr8JBmYhG8MK9Bs/ev26z/xXu04tdezLktQOc5J1oej+fbW+O4UHY
         BO7Ou3xHNqretZSCqdDRcHtTmqQnif4BGNLtoZSXcUx9Wd/lAmZwS/g07cCrg60OYn5Z
         At/V9GENiFKQTRQMK7OopyAme1H8HG5I79EGsAt2TlO3PhRuTGcyN+Qc/ORX1BB/GoNq
         hCx8KM/KdZrk/WkNdFAsNJyAS/HHE8CzqyMSDiY0krAehnWHbhC/3LhvlL5o0uFhrB2m
         yoH8iLJE8b7T1Z4JErOw4dP94nfgewVA9n5k1bxqUaF+YSY38pfbT8q9TBEEbQMzOUjo
         6/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695934476; x=1696539276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hTaV4VyiNGopMAo3snspiaAuae6NCzQuBXwYXK+cknU=;
        b=ITW83mtYpoZDx0Wuh3jnS1HbZXEIRbSKsTuZ2lGzWe4In3ZB42krPDL5/kbHOeYFjc
         2K1RpwY4xSnoBjQ1udBuDomGiQFNLBsTbdeSI8Kd+zbhjm0/Pgn1aJbn32n/v3Y6pQO5
         N+iU0LCPK70jvAvb4Hh7E601mMANrW+hEE+2UOeORdAoz0yruz4P/OqrUbFUGBvQFUx8
         2NG9bMDBPrctOPlFcZjdnJ+LXgnLFTiXa8eQcfqFRjAcmkEVQms2fST6N4hr8JTx2GDO
         yQJ4gFwWSf5yBXxiq1RU8/DLv6wwPKhBQXUZoyWdMPpzDMNXgxO5rRhTBOcBq+UE98WC
         G2bA==
X-Gm-Message-State: AOJu0YyL57yaDXAJGp/FTP8vwfKUxVIQdGq7EPmf2QqbA6YM+canZQvX
        A1vrHxDniz/qietZ3JcnUFHFXkQXrt434/SiPQwTv5076delUQTQYmzifg==
X-Google-Smtp-Source: AGHT+IHV71UOuafsdH0ZsqC1khFfs11EG/J09TfPWpLYl31rGQC8XYfveWPrc7BQas3vfivxUePEJ+c/bcBVeJ//QOs=
X-Received: by 2002:a50:d0d9:0:b0:530:4f4b:d9ee with SMTP id
 g25-20020a50d0d9000000b005304f4bd9eemr485129edf.5.1695934475925; Thu, 28 Sep
 2023 13:54:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230925175733.1379-1-michal.wajdeczko@intel.com> <20230925175733.1379-5-michal.wajdeczko@intel.com>
In-Reply-To: <20230925175733.1379-5-michal.wajdeczko@intel.com>
From:   Rae Moar <rmoar@google.com>
Date:   Thu, 28 Sep 2023 16:54:23 -0400
Message-ID: <CA+GJov4o9ixrbSma-9SABH4n88AXFD=nDG6+C=wfVVMgzLoprA@mail.gmail.com>
Subject: Re: [PATCH 4/4] kunit: Prepare test plan for parameterized subtests
To:     Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Sep 25, 2023 at 1:58=E2=80=AFPM Michal Wajdeczko
<michal.wajdeczko@intel.com> wrote:
>
> In case of parameterized tests we are not providing a test plan
> so we can't detect if any result is missing.
>
> Count available params using the same generator as during a test
> execution
>
> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> ---
>  lib/kunit/test.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 43c3efc286e4..55eabb324f39 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -540,6 +540,20 @@ static void kunit_accumulate_stats(struct kunit_resu=
lt_stats *total,
>         total->total +=3D add.total;
>  }
>
> +static size_t count_test_case_params(struct kunit_case *test_case)
> +{
> +       char param_desc[KUNIT_PARAM_DESC_SIZE];
> +       const void *param_value =3D NULL;
> +       size_t num =3D 0;
> +
> +       if (test_case->generate_params)
> +               while ((param_value =3D test_case->generate_params(param_=
value,
> +                                                                param_de=
sc)))
> +                       num++;
> +
> +       return num;
> +}
> +

Hello!

This change largely looks good to me. However, I am not 100 percent
confident that the function to generate parameters always produces the
same output (or same number of test cases). I would be interested in
David's opinion on this.

Otherwise it seems to work well!

Thanks!
-Rae

>  int kunit_run_tests(struct kunit_suite *suite)
>  {
>         char param_desc[KUNIT_PARAM_DESC_SIZE];
> @@ -585,6 +599,8 @@ int kunit_run_tests(struct kunit_suite *suite)
>                         test_case->status =3D KUNIT_SKIPPED;
>                         kunit_log_indent(KERN_INFO, &test, "KTAP version =
1\n");
>                         kunit_log_indent(KERN_INFO, &test, "# Subtest: %s=
", test_case->name);
> +                       kunit_log_indent(KERN_INFO, &test, "1..%zd\n",
> +                                        count_test_case_params(test_case=
));
>
>                         while (test.param_value) {
>                                 kunit_run_case_catch_errors(suite, test_c=
ase, &test);
> --
> 2.25.1
>
