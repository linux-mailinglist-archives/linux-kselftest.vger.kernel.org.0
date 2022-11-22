Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A4963322A
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Nov 2022 02:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbiKVBbY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Nov 2022 20:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbiKVBbU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Nov 2022 20:31:20 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD53FD2991
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Nov 2022 17:31:15 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 205so15649986ybe.7
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Nov 2022 17:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IYRjBqU3ZoHV4i/knmVPjtRYVyj2wBtBdprE9kY1bXY=;
        b=g5eszoEulUfrD1WqxBnLIM3gUgku3IJD6GBT91ItK1iQ3CxkGoNjn4a2GWvTpmdSFi
         lVPxF9/dWFtr1nFuFXhSuZJw4FsGD+qKgco89uA/o5CL0rOWhS6iLjHimnSuvw+Zbr3M
         hd9XngwctwS8u8UKW5cxJm3NuK1i1QaV6Ff5SoqsmPl2knL0bPLiF4P3bruDRLe+ZoBX
         L/9ygwEcgsHydEymZYpk6EmBs2aPgOYUl33sXvPNl77s93ZF6cTkx57vBtmi9Z2wHKdN
         2iT20/pBA0ALqF1gCn54EBl5r80A+JsvDMLC+Y4DhkhDE/AKhjh2aazXYzDejfWdkeCy
         JNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IYRjBqU3ZoHV4i/knmVPjtRYVyj2wBtBdprE9kY1bXY=;
        b=W37FQGPC3ksxZelo7YnMhsbF6SvO3JvGtE9mLw5Aae6iVVLKURaJvdFFze5tVAg5QM
         QKUrkdvS3EPaX8Onm56sjSGvQadURJC9jcq35HEx/4eRPYa9tSfOdR7jgnvWshc5DwVk
         sPbn9UqTf5M/fT+qwwGBY6bgNSSqyp/x3XJUyPQhj12qYPglIwQwyD4dYbNv55j+Ss7I
         Dl7qqB5/K2uQeCwnww8zwZzYC8YFUoE5jAb6lcmfDzTxkRTL9/wD6iy/IfIViPjzyECo
         OFnwfb6nddFhwaDM5mJqEHuZ3BIqudoy1ON8MHD53XpDRndJhEOGKAy8J4xtHH1qhuhI
         CQ2Q==
X-Gm-Message-State: ANoB5pnk/J80c12fUOJfNSMNE2Yncw4JugFUyieb7SvD6RwIgmt7KLzu
        I5TyvDgw3OIG+idUKrattFYcyi8Tsg6RcdvUbKpJapMXUW8=
X-Google-Smtp-Source: AA0mqf4BKdfRzMVGdYVC78GLj287VlFFPylImBY9mMzZlCVRzwhU/woID2KDtu9GDCYShjObFVE7+ndAAu8aVAdZGaQ=
X-Received: by 2002:a25:d2cf:0:b0:6cf:e761:43e1 with SMTP id
 j198-20020a25d2cf000000b006cfe76143e1mr20115372ybg.650.1669080674817; Mon, 21
 Nov 2022 17:31:14 -0800 (PST)
MIME-Version: 1.0
References: <20221119081252.3864249-1-davidgow@google.com>
In-Reply-To: <20221119081252.3864249-1-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 21 Nov 2022 17:31:03 -0800
Message-ID: <CAGS_qxqyyH-v4wMJyD1phPP2YA5_6L98C-t4cJtt_SYsSvR3Ag@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] kunit: Provide a static key to check if KUnit is
 actively running tests
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-doc@vger.kernel.org, linux-mm@kvack.org
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

On Sat, Nov 19, 2022 at 12:13 AM David Gow <davidgow@google.com> wrote:
>
> KUnit does a few expensive things when enabled. This hasn't been a
> problem because KUnit was only enabled on test kernels, but with a few
> people enabling (but not _using_) KUnit on production systems, we need a
> runtime way of handling this.
>
> Provide a 'kunit_running' static key (defaulting to false), which allows
> us to hide any KUnit code behind a static branch. This should reduce the
> performance impact (on other code) of having KUnit enabled to a single
> NOP when no tests are running.
>
> Note that, while it looks unintuitive, tests always run entirely within
> __kunit_test_suites_init(), so it's safe to decrement the static key at
> the end of this function, rather than in __kunit_test_suites_exit(),
> which is only there to clean up results in debugfs.
>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Daniel Latypov <dlatypov@google.com>

I didn't know anything about the static key support in the kernel
before this patch.
But from what I read and saw of other uses, this looks good to me.

One small question/nit about how we declare the key below.

<snip>

> +/* Static key: true if any KUnit tests are currently running */
> +extern struct static_key_false kunit_running;

Is there any documented preference between this and
  DECLARE_STATIC_KEY_FALSE(kunit_running);
?

I see 89 instances of this macro and 45 of `extern struct static_key_false`.
So I'd vote for the macro since it seems like the newer approach and
more common.

Daniel
