Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5C64ACB6D
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Feb 2022 22:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240104AbiBGVjo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 16:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbiBGVjo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 16:39:44 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EFBC061355
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 13:39:43 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id b13so33074738edn.0
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Feb 2022 13:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JkUXjUfONMEakOKrSs8qeEQ8fO3Su2ebpIj8MlZJxVE=;
        b=Oq62eM9QvIuCDhAdIj1f86cKklVgCa4pi3jRg64xUBzlO9ICsyvBa/d87BJhtZikAm
         V8GHeqf7OYkxA3wLr5xT0tMouiyrPVPUOJ/Fl1gyE40k8mhfpJWUH5P9R2+TGmXtaMwH
         LDEmkyf4eWjrR1gFVR5yf34CJny0KeOz6GrEK61ueilERIDvaf9zXu5zgCedaOzTIItv
         8WJMpEHCipEvOXSQpUCuI53fwJQ81s98wpoJM0ohoz74TdAeGG1tGsdb4xRjdRcdtMbC
         E/amJkuBKnug434U2ITh14EBFvPIQVwSWSOOpxG5jNZAYT+FYrD8XFKbzEMSAm7qt/2V
         gm7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JkUXjUfONMEakOKrSs8qeEQ8fO3Su2ebpIj8MlZJxVE=;
        b=3qoQpdcjhfGT47GkJ+8Z4Rj7mnrKTQlQHn6cn3Oq4NBE30anrvT3MM3MOd3my3i122
         sutIMs8HpoLx2NV547GtEubhnDA63naQN8Xo+RQuWw5b79Zoui96dVfXvj2Q/6o59TF2
         Yj7GiFuR5IcSg+U8ax+0HUindW+bqvJC8F/AfnjwNdHC03zi4iWhaZ76qPXIcLVP0EOm
         7yzREIFYsGyK0wt6ls9C6oY2ODC0WURUHHD6/0Ivksy4XJPG8yOZDpsjZrVRu0tFG2i8
         K4VBbHHmXuQf/k/zORaKajWT57+R5MgowkuP5Tr+f5D2tochk31R/D3opZYXpY+7OVOQ
         LL8w==
X-Gm-Message-State: AOAM531Ahiml7o2/nlmwDs9BpMYzJSRfSPn/h3YalSvougwLgC9g6Ica
        fXYPnAHjmfmE9qedbInNPVvQHzaiYEqr3re5Wx+M3g==
X-Google-Smtp-Source: ABdhPJyUDCZjErGGp4mC5UrUHbCD59oq5XN+jzmjTXkyVxCwdEhoCDUSc+IKtLPlLIXVjeO3aGer3OK3Gr03k8b/5gM=
X-Received: by 2002:a05:6402:34d3:: with SMTP id w19mr1422514edc.377.1644269982031;
 Mon, 07 Feb 2022 13:39:42 -0800 (PST)
MIME-Version: 1.0
References: <20220207211144.1948690-1-ribalda@chromium.org> <20220207211144.1948690-2-ribalda@chromium.org>
In-Reply-To: <20220207211144.1948690-2-ribalda@chromium.org>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 7 Feb 2022 13:39:30 -0800
Message-ID: <CAGS_qxo5d5uTcHfG6qxtQjzCkkHfEOKMjgO75bk_WNb6JyYutA@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] kunit: use NULL macros
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
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

On Mon, Feb 7, 2022 at 1:11 PM Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Replace the NULL checks with the more specific and idiomatic NULL macros.
>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: Daniel Latypov <dlatypov@google.com>

LGTM, thanks!
(This will still need Brendan's RB to go in)

> ---
>  lib/kunit/kunit-example-test.c | 2 ++
>  lib/kunit/kunit-test.c         | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
> index 4bbf37c04eba..91b1df7f59ed 100644
> --- a/lib/kunit/kunit-example-test.c
> +++ b/lib/kunit/kunit-example-test.c
> @@ -91,6 +91,8 @@ static void example_all_expect_macros_test(struct kunit *test)
>         KUNIT_EXPECT_NOT_ERR_OR_NULL(test, test);
>         KUNIT_EXPECT_PTR_EQ(test, NULL, NULL);
>         KUNIT_EXPECT_PTR_NE(test, test, NULL);
> +       KUNIT_EXPECT_NULL(test, NULL);
> +       KUNIT_EXPECT_NOT_NULL(test, test);
>
>         /* String assertions */
>         KUNIT_EXPECT_STREQ(test, "hi", "hi");
> diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
> index 555601d17f79..8e2fe083a549 100644
> --- a/lib/kunit/kunit-test.c
> +++ b/lib/kunit/kunit-test.c
> @@ -435,7 +435,7 @@ static void kunit_log_test(struct kunit *test)
>         KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
>                                      strstr(suite.log, "along with this."));
>  #else
> -       KUNIT_EXPECT_PTR_EQ(test, test->log, (char *)NULL);
> +       KUNIT_EXPECT_NULL(test, test->log);
>  #endif
>  }
>
> --
> 2.35.0.263.gb82422642f-goog
>
