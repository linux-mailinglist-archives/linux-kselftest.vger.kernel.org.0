Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCFB4EB41B
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Mar 2022 21:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240964AbiC2TbJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Mar 2022 15:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240960AbiC2TbJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Mar 2022 15:31:09 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DBF517D4
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Mar 2022 12:29:25 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id p15so37148450ejc.7
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Mar 2022 12:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B5UYIP8SGQjxl6HHM2puamfh3AUwmyljeoli+qwWwAY=;
        b=D7GisGTzI8xLen8EAeQSTteYE6hALAZt9nrQMQJpPWjRkXDFmI32APn0NszipPzuMz
         i8ekYTV8xc3iD/Qz/qvrRynW7B0WGm9RGQIn/vLk93ZqRkR7pckkhiZUL6M/axKxHaiy
         fQUhTAre9qC57KkbxvGc2mzFY9ibz2WNgaGOw+1mW3NCPkS2lFprfeQoX9X0pn+4OHe7
         C4HBZtUnhLbZGJdHvtKMzGQxyT8qtwStFp28hU64HH5r25Bh2ewsP/p1elUQo6Q+29Gh
         5F6WJl17WhoSFhkJzIfUAUUAfMyJfgjtPq1yNS+ij+1Wx54ERBVEIg+DJSSeYztob8eF
         +LEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B5UYIP8SGQjxl6HHM2puamfh3AUwmyljeoli+qwWwAY=;
        b=mNi1twNHLkmrer9i9a+ZimjW9LCRP5nyoPE9e0pOr350AP3ZeE8oKgkvFXuQ5vq0Bd
         wFiQWgrSdvZzMaW0xBSiMx11sOkn9shUpDyeG8rC3VFppGNjuDNGY6D9iXjYcA0/yFIO
         jAnKxk0xAnjq4oACxBbyTl09MfIe0/PIHuMBn4JTAVcOa/E4fukS1jok5OPXZUG2THhn
         b1I/8bYhsHBKG6j7qMOt5WEKJcP0LCrgNRnn6KbQ9OKmzNM8BpxF6UE74IVohWpwiHXF
         KKRPw6puiHGAg14u3Br4UqwJLEvxLhHZOJt/FqWkLQJ/wK4UPIPuju/FUfBPqEkCkZOC
         IYdg==
X-Gm-Message-State: AOAM530bCOX6tgauoMqa+FU6loJsGuPSz/h/n/vNpBBV4G2ouuShXQm3
        b0RijfXuaLURx8x+w7HQq0hPvhpFRCfgRZSCbKoQOA==
X-Google-Smtp-Source: ABdhPJxME9rqCqtD+YyjhoLF8AMHjGE8/rDwNWZoTr9qqHV5Nd6s4I/10V3Ga1QgKWeZq0HW7cy8w6FfTFeMjT1Bkok=
X-Received: by 2002:a17:907:a0c9:b0:6df:eaef:d93d with SMTP id
 hw9-20020a170907a0c900b006dfeaefd93dmr35558344ejc.369.1648582163761; Tue, 29
 Mar 2022 12:29:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220329103919.2376818-1-lv.ruyi@zte.com.cn>
In-Reply-To: <20220329103919.2376818-1-lv.ruyi@zte.com.cn>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 29 Mar 2022 14:29:12 -0500
Message-ID: <CAGS_qxpCHgp7ToQV9UALPy-4nyHDcdpWOCCd3duz-L6EgYPpOg@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: add null pointer check
To:     cgel.zte@gmail.com
Cc:     brendanhiggins@google.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 29, 2022 at 5:39 AM <cgel.zte@gmail.com> wrote:
>
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
>
> kmalloc and kcalloc is a memory allocation function which can return NULL
> when some internal memory errors happen. Add null pointer check to avoid
> dereferencing null pointer.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
> ---
>  lib/kunit/executor.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index 22640c9ee819..be21d0451367 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -71,9 +71,13 @@ kunit_filter_tests(struct kunit_suite *const suite, const char *test_glob)
>
>         /* Use memcpy to workaround copy->name being const. */
>         copy = kmalloc(sizeof(*copy), GFP_KERNEL);
> +       if (!copy)
> +               return NULL;

While this is technically correct to check, in this context it's less clear.
If we can't allocate this memory, we likely can't run any subsequent
tests, either because the test cases will want to allocate some memory
and/or KUnit will need to allocate some for internal bookkeeping.

The existing code (and by extension this patch) "handles" OOM
situations by silently dropping test suites/cases.
So I sort of intentionally figured we should let it crash early in
this case since that's probably more debuggable.

This code does check for NULL returns earlier on in the call chain, i.e.

first in kunit_filter_suites()
   158          copy = kmalloc_array(max, sizeof(*filtered.start), GFP_KERNEL);
   159          filtered.start = copy;
   160          if (!copy) { /* won't be able to run anything, return
an empty set */
   161                  filtered.end = copy;
   162                  return filtered;
   163          }

and second in kunit_filter_subsuite()
   107          filtered = kmalloc_array(n + 1, sizeof(*filtered), GFP_KERNEL);
   108          if (!filtered)
   109                  return NULL;

The first kmalloc_array() is our first allocation in this file.
If we can't handle that, then things are really going wrong, and I
assumed there'd be plenty of debug messages in dmesg, so silently
returning is probably fine.
The second one also felt similar.

So I think that
* it's highly unlikely that we pass those checks and fail on these new
ones (we're not allocating much)
* if we do fail, this is now harder to debug since it's partially
running tests, partially not

Should we instead rework the code to more clearly signal allocation
errors instead of overloading NULL to mean "no matches or error?"
Or maybe just adding some pr_err() calls is sufficient.

>         memcpy(copy, suite, sizeof(*copy));
>
>         filtered = kcalloc(n + 1, sizeof(*filtered), GFP_KERNEL);
> +       if (!filtered)
> +               return NULL;
>
>         n = 0;
>         kunit_suite_for_each_test_case(suite, test_case) {
> --
> 2.25.1
>
