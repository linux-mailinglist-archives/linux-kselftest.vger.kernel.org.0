Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15ED8776AE1
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Aug 2023 23:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjHIVWm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Aug 2023 17:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjHIVWm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Aug 2023 17:22:42 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741421BCF
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Aug 2023 14:22:41 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe32ec7201so9275e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Aug 2023 14:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691616160; x=1692220960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OzDUu1hDm/ATiZnfZV5ckNUxU989e7rnsufB9B73ynU=;
        b=45JFkSEfRo/3zF5ZBKajbQu58vncVRAXgsXnR20SR1i7M37MN7xPRj3J9CFsBOmVkW
         1v0+QL7pGJjiQjREGXvrw2oQYlXFdFbH4frzGia+82I3fiKtd7BcKEQDpejcMeuOPKBh
         7A7YFETwRa9MdVSxsK79ZFmKJe/d11S+P4dY40XlJWc4XGxos5+xfHTF4fJ3HUOc5yzC
         PI4cWFoQ7oXI7ZwGpEFFyZaOTTEflW6q6t7nyU/GxvCl7ZBJxWH8k0Ej5VOnwDEJY5KE
         IKofP1UXUHv43uL7NBCso9lgoKqa7LbDrKFJ5SG/0+gwCeQc3wj0v9UziVZglupNRbnU
         53YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691616160; x=1692220960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OzDUu1hDm/ATiZnfZV5ckNUxU989e7rnsufB9B73ynU=;
        b=XuX/dTfvv4+H9ZAa6SUOothuD6SaikBFo/5FLmUVEXjFozagZB7spKHdriSYVSEOGt
         +sIC2qJ0KBeeykBA7h4pu8ZpEwmjoP+KlvppYRF5T+l8Ov9mswNumq6LOaA9GDVIfcpB
         JzQU4bBapJkcSJvniVvdrsWM6DW3Jl0opKrBVFdcFpaGr83+MRHay87JCUPWdL6kCzCp
         cUz0lEWSuVuYIrcXgAbIbfjx/QGZuoVmRt3j4e2lbphsVW8YYbdIZg2uq2ua+s3SN2Im
         GghFtnqoWHuwKTT0w0QZmxxVRj7p6jkzMqOnYSxh2Tq1sVSVtRrZUkCBmX+Ii54RVnc+
         nYiQ==
X-Gm-Message-State: AOJu0Yw3NHFZyROoWCWYcAPocE+Usm0X9nBfX9VTaTuev8Bspzs7jyZZ
        omqh42xePenu9BF++7wjifuUHViCLhPYOnl/jaf5Cg==
X-Google-Smtp-Source: AGHT+IEK6i69InzMFREQBEsiskrQ2aeVsQRHKZX4y+J+bXQTGTKiO4c48LF8jE3FeufO9pukJwNIfu9pX0MxmOW7bO0=
X-Received: by 2002:a05:600c:500c:b0:3f6:f4b:d4a6 with SMTP id
 n12-20020a05600c500c00b003f60f4bd4a6mr154162wmr.7.1691616159907; Wed, 09 Aug
 2023 14:22:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230809155438.22470-1-rf@opensource.cirrus.com> <20230809155438.22470-5-rf@opensource.cirrus.com>
In-Reply-To: <20230809155438.22470-5-rf@opensource.cirrus.com>
From:   Rae Moar <rmoar@google.com>
Date:   Wed, 9 Aug 2023 17:22:28 -0400
Message-ID: <CA+GJov5tw2kCmy=Qrnw4EK9Dr91MXAsOmai0XFz-2tfgZ724vg@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] kunit: kunit-test: Test logging a line that
 exactly fills a fragment
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     brendan.higgins@linux.dev, davidgow@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 9, 2023 at 11:54=E2=80=AFAM Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> If a log string is the exact length of a log fragment buffer
> kunit_log_append() should now exactly fill that fragment without
> extending the log.
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>

Hello!

This test looks good to me. I have tested it and it seems to be working wel=
l.

I appreciate all of the assert and expect statements. I do have one
comment below.

Although, I would be happy to set this as reviewed by me after that
comment is responded to.

Thanks!
-Rae

> ---
>  lib/kunit/kunit-test.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
> index c0ee33a8031e..9ac81828d018 100644
> --- a/lib/kunit/kunit-test.c
> +++ b/lib/kunit/kunit-test.c
> @@ -763,12 +763,49 @@ static void kunit_log_extend_test_2(struct kunit *t=
est)
>  #endif
>  }
>
> +static void kunit_log_frag_sized_line_test(struct kunit *test)
> +{
> +#ifdef CONFIG_KUNIT_DEBUGFS
> +       struct kunit_suite suite;
> +       struct kunit_log_frag *frag, *src;
> +
> +       suite.log =3D kunit_kzalloc(test, sizeof(*suite.log), GFP_KERNEL)=
;
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, suite.log);
> +       INIT_LIST_HEAD(suite.log);
> +       frag =3D kunit_kzalloc(test, sizeof(*frag), GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, frag);
> +       kunit_init_log_frag(frag);
> +       list_add_tail(&frag->list, suite.log);
> +
> +       src =3D kunit_kzalloc(test, sizeof(*src), GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, src);
> +       memset(src->buf, 'x', sizeof(src->buf) - 2);
> +       KUNIT_ASSERT_EQ(test, strlen(src->buf), sizeof(src->buf) - 2);

Should this be an EXPECT instead? It doesn't seem like the test needs
to fail immediately if this fails. Let me know what you think.

> +
> +       /* Log a string that exactly fills the fragment */
> +       kunit_log_append(suite.log, "%s\n", src->buf);
> +       KUNIT_EXPECT_TRUE(test, list_is_singular(suite.log));
> +       KUNIT_EXPECT_EQ(test, strlen(frag->buf), sizeof(frag->buf) - 1);
> +       strlcat(src->buf, "\n", sizeof(src->buf));
> +       KUNIT_EXPECT_STREQ(test, frag->buf, src->buf);
> +
> +       /* Logging another string should extend the log */
> +       kunit_log_append(suite.log, "Next\n");
> +       KUNIT_EXPECT_EQ(test, list_count_nodes(suite.log), 2);
> +       frag =3D list_last_entry(suite.log, struct kunit_log_frag, list);
> +       KUNIT_EXPECT_STREQ(test, frag->buf, "Next\n");
> +#else
> +       kunit_skip(test, "only useful when debugfs is enabled");
> +#endif
> +}
> +
>  static struct kunit_case kunit_log_test_cases[] =3D {
>         KUNIT_CASE(kunit_log_init_frag_test),
>         KUNIT_CASE(kunit_log_test),
>         KUNIT_CASE(kunit_log_newline_test),
>         KUNIT_CASE(kunit_log_extend_test_1),
>         KUNIT_CASE(kunit_log_extend_test_2),
> +       KUNIT_CASE(kunit_log_frag_sized_line_test),
>         {}
>  };
>
> --
> 2.30.2
>
