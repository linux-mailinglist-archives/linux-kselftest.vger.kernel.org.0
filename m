Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7853363FD96
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Dec 2022 02:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbiLBBTr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Dec 2022 20:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiLBBTq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Dec 2022 20:19:46 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA87CEFA6
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Dec 2022 17:19:45 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id d128so4298952ybf.10
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Dec 2022 17:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b7S/Lk010656nN0nZxqgfS6l85QGHGwdF8mVU2ojAvw=;
        b=AT27u0tgCh7uOLyY8Ql580WvVeAiLYjcI4f7NZQk46/CLU3/+7buoJ9V9c45rcuscx
         vO3aJrqhgyS83lteGHszZNkkP6VWo3MZjH2Qjet5VpEKr0WGC7ohz8eweYOlk/r4/M3N
         2re1dOKiEt2z8CUlhFFmVe1BO2uIxZ+/7iLECz027ISRWR5OSHZtMIrQ3EJwwv+7BrA8
         HuFq/TFGiHrpGVs5rpDfrSJezKlFjz8vkxbLERmHxYGvM66JGx9bqyz+9LTQMpygTbAX
         obXKGb1YCfLqFUB3LT2WKVMxMV0uKAc214ok+1DRf56odpooPaRsD/tiliqpYyz/Ar2b
         LRvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b7S/Lk010656nN0nZxqgfS6l85QGHGwdF8mVU2ojAvw=;
        b=vN9loZDWbiHWEAW1B9w9k3jgVzW2We3BERUkjrLn+57wsjDX7I+JkBK0gi/PAfF1mH
         sOCscGPIwd3uk71/G5jJIkRqNE/UcxyvRSUNEL45l0mGgz4pHAxQZwFT+v86l1LRg6Fp
         WMnJe+INgch6YjSNeJ6UrFOJpfzzwi9UxKe1shWV5jWJREuaH0o1F9nQ1wkOS8GbBaTE
         ESaE+XrnshWDA4fFj5K+o1JePHc/k4RRiB4CxPrKuZbTATnal8GtbbgMhZmm0Sbggsru
         E7nRSamrdhe66Azw/Z4diLnAb7VZqWqfg5n3yqSeXQIUxVq//J0gX6Nvg35heIKgll61
         ggNg==
X-Gm-Message-State: ANoB5pnVW7GjiKDNcn1DHmwh+9cNyzIDiiRHNeH7d94v2fE/31JXOrT9
        3i5tomXh9pMP0snYXrVjxvzhNBR9DMx7pdgP4yZpRg==
X-Google-Smtp-Source: AA0mqf5T9Ra5V6yzXWV8vxb2tO65VZIyhze90LfjaKJK9kFL4fvKtrfCro9CM2DGiAIYQHU0Nn4aBh3Rm5cSdQPsKak=
X-Received: by 2002:a25:ef09:0:b0:6fc:63f6:eb89 with SMTP id
 g9-20020a25ef09000000b006fc63f6eb89mr3768398ybd.587.1669943984310; Thu, 01
 Dec 2022 17:19:44 -0800 (PST)
MIME-Version: 1.0
References: <20221125084306.1063074-1-davidgow@google.com> <202212011652.4E8CB40@keescook>
In-Reply-To: <202212011652.4E8CB40@keescook>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 1 Dec 2022 17:19:33 -0800
Message-ID: <CAGS_qxotC7jCXewCoa3CwP0pxs=FRqZPF0oY67La0dUN1ay7LQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] kunit: Provide a static key to check if KUnit is
 actively running tests
To:     Kees Cook <keescook@chromium.org>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org
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

On Thu, Dec 1, 2022 at 4:53 PM Kees Cook <keescook@chromium.org> wrote:
> > +     static_branch_inc(&kunit_running);
>
> Is it expected there will be multiple tests running? (I was expecting
> "static_branch_enable").

It shouldn't normally happen, no.

One possible use case:
KUnit's unit tests for itself create fake test objects and operate on them.
They don't currently exercise this particular code though, afaict
(maybe they should).

>
> > +
> >       for (i = 0; i < num_suites; i++) {
> >               kunit_init_suite(suites[i]);
> >               kunit_run_tests(suites[i]);
> >       }
> > +
> > +     static_branch_dec(&kunit_running);
> >       return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(__kunit_test_suites_init);
> > --
> > 2.38.1.584.g0f3c55d4c2-goog
> >
>
> Regardless:
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> --
> Kees Cook

Daniel
