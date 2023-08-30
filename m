Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B11678E225
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Aug 2023 00:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbjH3WMF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Aug 2023 18:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236964AbjH3WME (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Aug 2023 18:12:04 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEA210D5
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Aug 2023 15:11:36 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so5499a12.0
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Aug 2023 15:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693433434; x=1694038234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwull7ixEoBTkBDcqYgr2EkUJ4YqIF3S8jAnKkIS0/8=;
        b=jrRwsHg34yHS6SXiiwKjXIqyVIY/YhT7IjUkO3evCp67ne1eV0Cil3r9jYFzGVRddk
         +QXtxApduBHsuDj6lgjot+/YaMA31VNWclyw+wONOsek70qWq9JQl1hY0Efuny8kpAo9
         9GBBtvNG//7EbSDu9mqOiTZVocqNC8ZtlMBoy1HZ+T/3M19xnM3BWRbLeZiKAdq5XUGk
         ePA9MgdUjy6F7YHXJwj7MK9EdGQmc8l2FO57y8oBFdRESZLARvUDspVcLIH/YEkTW/58
         LrmEZ4BPM24fStNH83NZFXN6fDym+FQneDDdtdpvf+RdAnR1fozVQRGLqFqmEiBZoCCJ
         eNoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693433434; x=1694038234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jwull7ixEoBTkBDcqYgr2EkUJ4YqIF3S8jAnKkIS0/8=;
        b=Ee0iSR6d0lLI+dyTjwkUXM8dxa0QS6v62+TCm7k0/VD3xvfUc7uZZ98IvBa8bJ06iX
         Wt9G7xUJHFeaiXgqjGa5GExllpBL4Z+UHGc4KCbCfg+VyeDrOwaKLYsDq8UtxyrSlcM1
         2iclPydt/OZDgb2vTEn9+yMNiL3dE1ypqciOE+xSBgMHQFr6E2eZYIozhnevJygawdzQ
         eKFWbKY0hV0xYoigB7GXIxbTBv20aYVhNKAFZ7UOLrnj5cod5mqWlfgSfRf7nZg7KOMG
         fKyZE2oBrDJTqvPKkCtxW1Rhsm0aQlhGyaCNIGF0+yYS63NApjv37XLBce6+MEQfAEpB
         38nw==
X-Gm-Message-State: AOJu0YzHIpVToyhfKTHWFvcxk7xXAc2f4JKVOYV0pBfq3XY6X+Aw8t30
        IBcbfRj4VmiytwzGa6GZtbdmAMmckQgd49FQmz56Ow==
X-Google-Smtp-Source: AGHT+IFaXP3W1g9cDwqVNTqIISpWJ1ar0Mu3iqJ4c1hCyU6KeMzZ/peTAT0HgRd8Vd2Wb2CBEz131MPnNuSxiJQVVC4=
X-Received: by 2002:a05:600c:33a1:b0:3fe:cd3a:ef92 with SMTP id
 o33-20020a05600c33a100b003fecd3aef92mr46852wmp.6.1693431280127; Wed, 30 Aug
 2023 14:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230830002116.3768675-1-davidgow@google.com>
In-Reply-To: <20230830002116.3768675-1-davidgow@google.com>
From:   Rae Moar <rmoar@google.com>
Date:   Wed, 30 Aug 2023 17:34:28 -0400
Message-ID: <CA+GJov67zAHkJJfoaC27LT7KXNvPyiEubZ7y7jQxQsNmdD7MRA@mail.gmail.com>
Subject: Re: [PATCH] kunit: test: Make filter strings in executor_test writable
To:     David Gow <davidgow@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Aug 29, 2023 at 8:21=E2=80=AFPM David Gow <davidgow@google.com> wro=
te:
>
> KUnit's attribute filtering feature needs the filter strings passed in
> to be writable, as it modifies them in-place during parsing. This works
> for the filters passed on the kernel command line, but the string
> literals used in the executor tests are at least theoretically read-only
> (though they work on x86_64 for some reason). s390 wasn't fooled, and
> crashed when these tests were run.
>
> Use a 'char[]' instead, (and make an explicit variable for the current
> filter in parse_filter_attr_test), which will store the string in a
> writable segment.
>
> Fixes: 76066f93f1df ("kunit: add tests for filtering attributes")
> Closes: https://lore.kernel.org/linux-kselftest/55950256-c00a-4d21-a2c0-c=
f9f0e5b8a9a@roeck-us.net/
> Signed-off-by: David Gow <davidgow@google.com>

Hello!

This looks good to me. Thanks for doing this!

Reviewed-by: Rae Moar <rmoar@google.com>

-Rae

> ---
>  lib/kunit/executor_test.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
> index 4084071d0eb5..b4f6f96b2844 100644
> --- a/lib/kunit/executor_test.c
> +++ b/lib/kunit/executor_test.c
> @@ -119,7 +119,7 @@ static void parse_filter_attr_test(struct kunit *test=
)
>  {
>         int j, filter_count;
>         struct kunit_attr_filter *parsed_filters;
> -       char *filters =3D "speed>slow, module!=3Dexample";
> +       char filters[] =3D "speed>slow, module!=3Dexample", *filter =3D f=
ilters;
>         int err =3D 0;
>
>         filter_count =3D kunit_get_filter_count(filters);
> @@ -128,7 +128,7 @@ static void parse_filter_attr_test(struct kunit *test=
)
>         parsed_filters =3D kunit_kcalloc(test, filter_count, sizeof(*pars=
ed_filters),
>                         GFP_KERNEL);
>         for (j =3D 0; j < filter_count; j++) {
> -               parsed_filters[j] =3D kunit_next_attr_filter(&filters, &e=
rr);
> +               parsed_filters[j] =3D kunit_next_attr_filter(&filter, &er=
r);
>                 KUNIT_ASSERT_EQ_MSG(test, err, 0, "failed to parse filter=
 '%s'", filters[j]);
>         }
>
> @@ -154,6 +154,7 @@ static void filter_attr_test(struct kunit *test)
>                 .start =3D subsuite, .end =3D &subsuite[2],
>         };
>         struct kunit_suite_set got;
> +       char filter[] =3D "speed>slow";
>         int err =3D 0;
>
>         subsuite[0] =3D alloc_fake_suite(test, "normal_suite", dummy_attr=
_test_cases);
> @@ -168,7 +169,7 @@ static void filter_attr_test(struct kunit *test)
>          * attribute is unset and thus, the filtering is based on the par=
ent attribute
>          * of slow.
>          */
> -       got =3D kunit_filter_suites(&suite_set, NULL, "speed>slow", NULL,=
 &err);
> +       got =3D kunit_filter_suites(&suite_set, NULL, filter, NULL, &err)=
;
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
>         KUNIT_ASSERT_EQ(test, err, 0);
>         kfree_at_end(test, got.start);
> @@ -191,12 +192,13 @@ static void filter_attr_empty_test(struct kunit *te=
st)
>                 .start =3D subsuite, .end =3D &subsuite[2],
>         };
>         struct kunit_suite_set got;
> +       char filter[] =3D "module!=3Ddummy";
>         int err =3D 0;
>
>         subsuite[0] =3D alloc_fake_suite(test, "suite1", dummy_attr_test_=
cases);
>         subsuite[1] =3D alloc_fake_suite(test, "suite2", dummy_attr_test_=
cases);
>
> -       got =3D kunit_filter_suites(&suite_set, NULL, "module!=3Ddummy", =
NULL, &err);
> +       got =3D kunit_filter_suites(&suite_set, NULL, filter, NULL, &err)=
;
>         KUNIT_ASSERT_EQ(test, err, 0);
>         kfree_at_end(test, got.start); /* just in case */
>
> @@ -211,12 +213,13 @@ static void filter_attr_skip_test(struct kunit *tes=
t)
>                 .start =3D subsuite, .end =3D &subsuite[1],
>         };
>         struct kunit_suite_set got;
> +       char filter[] =3D "speed>slow";
>         int err =3D 0;
>
>         subsuite[0] =3D alloc_fake_suite(test, "suite", dummy_attr_test_c=
ases);
>
>         /* Want: suite(slow, normal), NULL -> suite(slow with SKIP, norma=
l), NULL */
> -       got =3D kunit_filter_suites(&suite_set, NULL, "speed>slow", "skip=
", &err);
> +       got =3D kunit_filter_suites(&suite_set, NULL, filter, "skip", &er=
r);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
>         KUNIT_ASSERT_EQ(test, err, 0);
>         kfree_at_end(test, got.start);
> --
> 2.42.0.283.g2d96d420d3-goog
>
