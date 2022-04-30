Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF4D515B09
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Apr 2022 09:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382304AbiD3HlB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 30 Apr 2022 03:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382301AbiD3HlA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 30 Apr 2022 03:41:00 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B86965B4
        for <linux-kselftest@vger.kernel.org>; Sat, 30 Apr 2022 00:37:39 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id kq17so19199033ejb.4
        for <linux-kselftest@vger.kernel.org>; Sat, 30 Apr 2022 00:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wCobWo69+jIm4fH75WU4L/jzWPNIEpuFjehqElCC5hI=;
        b=Dt+JwlV6xwioPpmPFMYxhvzDAUkL4hvfM3WzEELy87oI73/HySdA/AkT7r1I/CCkZC
         BFBEoipQ+FSsjhGITTcarutg7aCHIucAbRqzS1/4rM4CVKWCpll34gflzQ9OtMp3Ef2v
         Ap7qBmbqRj9IkP9hb45B1ce+R82pF2F0Wcbs3CLZvbTD6LCwrxeM2N4118ogucr45tCz
         AiLAXjEiTkWh9n6meceQqywlnYai6ogPGEh0S3kam6jKNretYw8TXDzYgKsqF9uEqL5x
         hY4zyvhiV85C9DylSrZc18DM4+vZ8H7Sx7oCdlBkCdgEeVtGRKLDRI7h8XqjhTDn6bFu
         29/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wCobWo69+jIm4fH75WU4L/jzWPNIEpuFjehqElCC5hI=;
        b=OkHBNUiFlJ55HyM6aSSdL5GpkepCRwp91vpx2Auyqdj4mPgpYTLqzaed+Zs8PRKmcp
         xEIC+M6zqyrko8nfSu7cjMfDchFJmj3MazzWhml04JKOqxHHF5s4Px8xARSm6KH14QzV
         skpeOttcHcFIGfVIC8hSIGXew3nPxAsLeYfTAfRuzfvGvHtEgOhxzb0XV7ucBXThkFio
         covkHvX4WPBdEwgXgOMFgHRyORoVdP8xapcWW0wGbdwz04wIBjOU7rN3LGEvBfLCw3ND
         H6oXal/Laya/8VtZpbY9XNUQ1sAOR9QksxqH8obTU7KY6vkiZgL5RsfSyhP7ybC7z2ik
         oYqg==
X-Gm-Message-State: AOAM533j88/26HRSpIxqIH0yaNNA6bYkcUzQFkS8xMUdxkyt1dDA+5Aw
        LbvtEYoSUGV3hrjkXuDoXy6gEGUCbs83dVr2bVX0lQ==
X-Google-Smtp-Source: ABdhPJwm29VJPmR9TrgD15lFfCp6e/1B/nAXV/3OQUy9LzxA7phk0dqo3thETOqtZ+EkvNHlwBKiEbC3aZ3gYUTpYYI=
X-Received: by 2002:a17:907:33c2:b0:6f3:9aff:d532 with SMTP id
 zk2-20020a17090733c200b006f39affd532mr2897407ejb.394.1651304257717; Sat, 30
 Apr 2022 00:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220429181259.622060-1-dlatypov@google.com> <20220429181259.622060-2-dlatypov@google.com>
In-Reply-To: <20220429181259.622060-2-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Sat, 30 Apr 2022 03:37:26 -0400
Message-ID: <CAFd5g45aOYErmW2sGgRxpSCPftrzbWnc9Ug8-bTRdgW1-hAvpA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] kunit: add ability to specify suite-level init and
 exit functions
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 29, 2022 at 2:13 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> KUnit has support for setup/cleanup logic for each test case in a suite.
> But it lacks the ability to specify setup/cleanup for the entire suite
> itself.
>
> This can be used to do setup that is too expensive or cumbersome to do
> for each test.
> Or it can be used to do simpler things like log debug information after
> the suite completes.
> It's a fairly common feature, so the lack of it is noticeable.
>
> Some examples in other frameworks and languages:
> * https://docs.python.org/3/library/unittest.html#setupclass-and-teardownclass
> * https://google.github.io/googletest/reference/testing.html#Test::SetUpTestSuite
>
> Meta:
> This is very similar to this patch here: https://lore.kernel.org/linux-kselftest/20210805043503.20252-3-bvanassche@acm.org/
> The changes from that patch:
> * pass in `struct kunit *` so users can do stuff like
>   `kunit_info(suite, "debug message")`
> * makes sure the init failure is bubbled up as a failure
> * updates kunit-example-test.c to use a suite init
> * Updates kunit/usage.rst to mention the new support
> * some minor cosmetic things
>   * use `suite_{init,exit}` instead of `{init/exit}_suite`
>   * make suite init error message more consistent w/ test init
>   * etc.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
