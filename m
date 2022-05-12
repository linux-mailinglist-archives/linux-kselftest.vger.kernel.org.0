Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1AA525529
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 May 2022 20:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357791AbiELSwg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 May 2022 14:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345813AbiELSwf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 May 2022 14:52:35 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8B45EBC6
        for <linux-kselftest@vger.kernel.org>; Thu, 12 May 2022 11:52:33 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id a21so7372578edb.1
        for <linux-kselftest@vger.kernel.org>; Thu, 12 May 2022 11:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qdnyh7+uu18FzVA20njWSdWEwxEC9EB3ZfenS4EmCh8=;
        b=NtPPWDW+K9Q3GoCCru2mvoD3zjpF1DWuglu+M2WF8crMt/Y+9dsYZ3dkt+buBrYye/
         pITGDScQHlaTUGQguC/n+YyPsk1I9N/0rmmoewXxEq9jBEl/vogABi1kQ943x7A4XX0h
         zZvX/DdbVdY5aH9lGHQAaa/zZx0waDN1vdegmtxWJf5xWxAObQjX4mIE7SscUUA+yw8G
         2LQJaOO5dgiaXpOJiQEqzfjvLJ1zOsAnpd/PcfMnlsRoVLc2NPI8i0Q70cByqUu1tXSu
         afSw0z2XiJSK42puSJjpK1CoNkV3ZNfBhNQcI3071baoxDnfyL+CcCNvUIgJMVfEUdai
         GIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qdnyh7+uu18FzVA20njWSdWEwxEC9EB3ZfenS4EmCh8=;
        b=mIb8y8FHhx7L59n0dU8XQ9264masG0bbS8mwI68LoHf+Lpw7RBZqfUHw5G+lUlpb3d
         gtBSTEWOmVO2kMNAqV2SS95hpwkGJBAWLtdhGwAz4a1OH4bbM3D0BYgNjYWbPjUw1ALH
         lf+eknfdlvRSl/SytUVAyIDyX3pI40JzbON+WefoCaYdbF5XCo8XMKhCUp9xa2lnDVe7
         WDhVv0YxB5Xj9KzLMXyum911Xh9S9n4B2vyyVYaj1thGA8t3DiaE+0aAsnrhfJNTkq6M
         m6ThWBDysA3hbJPzh9vvnEU/DBgYoWg4Yp6ZmagjEixZFdFRFCczHKYlafgvNsb9DyPf
         7zuA==
X-Gm-Message-State: AOAM532Wkg95PdobpyIHhDwh3CYKUm/w0Gg26O3u2UGBO4jSb4B3DqY5
        KkKW7zW7vW+9SQqZ9vMKUqpUF7ZKrP+SbllwQ3R2mQ==
X-Google-Smtp-Source: ABdhPJyOVKvjn7GnmLfbaRzvyQLgsSYg1Hg8lBeaOUmFzCrYOPeSR7JAngVtkD4cazI9ApC+FwLv5q1HqE3E3EFmJ2A=
X-Received: by 2002:a05:6402:40c5:b0:427:af77:c10c with SMTP id
 z5-20020a05640240c500b00427af77c10cmr36851119edb.387.1652381552037; Thu, 12
 May 2022 11:52:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220502192327.81153-1-dlatypov@google.com>
In-Reply-To: <20220502192327.81153-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 12 May 2022 14:52:20 -0400
Message-ID: <CAFd5g47FYJPXK6Ab-qdWsGGmPmnUF1tmpK6m2ZpgkC6W4nhaog@mail.gmail.com>
Subject: Re: [PATCH] lib/atomic64_test.c: convert to use KUnit
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, mpe@ellerman.id.au
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

On Mon, May 2, 2022 at 3:23 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> The test currently is a bunch of checks (implemented using BUG_ON())
> that can be built into the kernel or as a module.
>
> Convert it to a KUnit test, which can also run in both modes.
> From a user's perspective, this change adds a CONFIG_KUNIT=y dep and
> changes the output format of the test [1]. The test itself is the same.
>
> This hopefully makes the test easier to run and more consistent with
> similar tests in lib/.
> Since it has no dependencies, it can be run without explicitly setting
> up a .kunitconfig via
> $ ./tools/testing/kunit/kunit.py run atomic
> ...
> [13:53:44] Starting KUnit Kernel (1/1)...
> [13:53:44] ============================================================
> [13:53:47] =================== atomic (2 subtests) ====================
> [13:53:47] [PASSED] test_atomic
> [13:53:47] [PASSED] test_atomic64
> [13:53:47] ===================== [PASSED] atomic ======================
> [13:53:47] ============================================================
> [13:53:47] Testing complete. Passed: 2, Failed: 0, Crashed: 0, Skipped: 0, Errors: 0
> [13:53:47] Elapsed time: 13.902s total, 1.629s configuring, 9.331s building, 2.852s running
>
> It can be run on ARCH=x86_64 (and others) via:
> $ ./tools/testing/kunit/kunit.py run --arch=x86_64 atomic
>
> The message about which platform the test ran on won't show up in
> kunit.py, but still gets printed out in dmesg, e.g.
> > TAP version 14
> > 1..1
> >     # Subtest: atomic
> >     1..2
> >     ok 1 - test_atomic
> >     ok 2 - test_atomic64
> >     # atomic: ran on x86-64 platform with CX8 and with SSE
> > # atomic: pass:2 fail:0 skip:0 total:2
> > # Totals: pass:2 fail:0 skip:0 total:2
> > ok 1 - atomic
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

I am also not an expert, but it looks good to me.

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
