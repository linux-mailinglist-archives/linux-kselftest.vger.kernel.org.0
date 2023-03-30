Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8C96D120D
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Mar 2023 00:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjC3WVK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Mar 2023 18:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjC3WVJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Mar 2023 18:21:09 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FFDB74B
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Mar 2023 15:21:04 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id f6-20020a17090ac28600b0023b9bf9eb63so21336032pjt.5
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Mar 2023 15:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680214864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ugtukTfVbDV/8BLzVhb0qFtwrdmFXjkERveHQp9G65k=;
        b=QZW1GJVAmZz3qfIMiei04YZkmBfPBmo9pjKDJ0qIuljXSgJnrQfiMXpSTDlZ3uIfCK
         cjDiVcujfjVO0lTG8UoYtP3BX8zbOy24sgjzQhp4lxBlv/vjHz2NGjgLsiu3amflo2Wi
         iU39U0/7TViaKVt3ek+fdn1/FrYJLAGPyPBStfAtvbZuwl6j9tq7rYpkhxbGKvSGuJio
         DxX2qWP+h93Bw2S7dLJi4JPrX5xg+AitcnTeK6DuJ9B+uDWpBPfDtsOrhEj+vqav3nAQ
         AD34aKGZzXypuB5br7F2mU7PW1XxsQl0l2wfI84qTJfb18gZO2Auel2N2sEsfv6SeZM/
         IPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680214864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ugtukTfVbDV/8BLzVhb0qFtwrdmFXjkERveHQp9G65k=;
        b=xB5wQ4VnTfS/Rk6WACE49f5Ck1p2RRq5+0KYH+VwbL0nfa55B4RDi6Aglysyofm/1A
         nKCBFAra9Gp5Rlw6dxLBCXf1ZHKDunl4c5Cg7VI2gv/CxCaQvB6TzCHv5FFwFP/NovoF
         Wp7KYZx3Pwf0JjdGwiZzMF63XORbALrDCaG4aKFN1aJ/g9rDvOmLXlO+tCWcPMD/hCPl
         zgzF/dl2jbOfdUJ+owCmkJrwOUqQdgXfuO1EWD9ERkjAmBf8FTt4/tzX6ei6FO5+JiT/
         ShuZhQy6AqZRSmW6sMb0Lfr4UotQKB0HMLujfJcL5TAgS6o2RHDvUIzYsvjPvPjDuGPr
         VkMg==
X-Gm-Message-State: AAQBX9de+RmzTyJzJbi5n2419KI4j2eDSp4RGEvf5mA5m+I7rixsI1AI
        ohoP9lREMBS0frXN6Nkj5fBCtfV+B/OajRzzMvkVLJ7B5RR7G+zp8MUHVqHV
X-Google-Smtp-Source: AKy350a64NmP0+Q1R1KoNiSqZ1E4LGky7ImztC0tAFffBWnHiJgqrB9cVB40cwkL6Jij9puwY4+MFQmWIsrgYuQbaS0=
X-Received: by 2002:a17:902:ea0c:b0:1a0:527b:9189 with SMTP id
 s12-20020a170902ea0c00b001a0527b9189mr9224011plg.11.1680214863803; Thu, 30
 Mar 2023 15:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230330220506.1399796-1-rmoar@google.com>
In-Reply-To: <20230330220506.1399796-1-rmoar@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 30 Mar 2023 15:20:52 -0700
Message-ID: <CAGS_qxqNwVcymkG6-8Kv72oZc9aDqjFjBBmjr+f+mOVKT1bGvA@mail.gmail.com>
Subject: Re: [PATCH v1] kunit: add tests for using current KUnit test field
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

I've got a few minor comments below, but this otherwise looks good.
I like the idea of testing knuit_fail_current_test().


On Thu, Mar 30, 2023 at 3:05=E2=80=AFPM Rae Moar <rmoar@google.com> wrote:
>
> +static void kunit_current_kunit_test_field(struct kunit *test)
> +{
> +       struct kunit *current_test;
> +
> +       /* Check to ensure the result of current->kunit_test
> +        * is equivalent to current test.
> +        */
> +       current_test =3D current->kunit_test;
> +       KUNIT_EXPECT_PTR_EQ(test, test, current_test);

Perhaps we can combine this and the next test case down to
static void kunit_current_test(struct kunit *test) {
  /* There are two different ways of getting the current test */
  KUNIT_EXPECT_PTR_EQ(test, test, current->kunit_test);
  KUNIT_EXPECT_PTR_EQ(test, test, kunit_get_current_test());
}
?

> +}
> +
> +static void kunit_current_get_current_test(struct kunit *test)
> +{
> +       struct kunit *current_test1, *current_test2;
> +
> +       /* Check to ensure the result of kunit_get_current_test()
> +        * is equivalent to current test.
> +        */
> +       current_test1 =3D kunit_get_current_test();
> +       KUNIT_EXPECT_PTR_EQ(test, test, current_test1);
> +
> +       /* Check to ensure the result of kunit_get_current_test()
> +        * is equivalent to current->kunit_test.
> +        */
> +       current_test2 =3D current->kunit_test;
> +       KUNIT_EXPECT_PTR_EQ(test, current_test1, current_test2);

> +}
> +
> +static void kunit_current_fail_current_test(struct kunit *test)
> +{
> +       struct kunit fake;
> +
> +       /* Initialize fake test and set as current->kunit_test. */

Nit: I think the code is self-explanatory enough that we can drop this comm=
ent.

> +       kunit_init_test(&fake, "fake test", NULL);
> +       KUNIT_EXPECT_EQ(test, fake.status, KUNIT_SUCCESS);
> +       current->kunit_test =3D &fake;
> +
> +       /* Fail current test and expect status of fake test to be failed.=
 */

Nit: I think this comment could also be dropped or maybe shortened to
  kunit_fail_current_test("This should make `fake` fail");

or
  /* Now kunit_fail_current_test() should modify `fake`, not `test` */
  kunit_fail_current_test("This should make `fake` fail");

> +       kunit_fail_current_test("This test is supposed to fail.");
> +       KUNIT_EXPECT_EQ(test, fake.status, (enum kunit_status)KUNIT_FAILU=
RE);
> +

Hmm, should we try calling
  kunit_cleanup(&fake);
?

Right now this does resource cleanups, but we might have other state
to cleanup for our `fake` test object in the future.

Daniel
