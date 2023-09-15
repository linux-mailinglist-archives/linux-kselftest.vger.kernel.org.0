Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D307A26E5
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Sep 2023 21:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236829AbjIOTGl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Sep 2023 15:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237059AbjIOTGe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Sep 2023 15:06:34 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F011E98
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Sep 2023 12:06:28 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-6564515ec4eso830266d6.2
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Sep 2023 12:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694804788; x=1695409588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/NNdNMoPNLRC5J4Us7rjn5YK+Bn2P8ki5j52BrAmQfc=;
        b=IcUP3ZThw4r0yzR1wPf2MKuL86qqJTY3lGmO5wVIwizbo32mHmJNZZSk/HLCKHmzhW
         Gla9MXisJOcGl205VuT46VlfVlhP6xgjKUvgEbqifKysED3psNQ5hqW3CZOjgckLmjeX
         43LkHAbC+H1FUTt/bAuUJd+MV8LWoq2/Z74adGTaSMb3PVcM6bURd5o8B0Dd8ZnDhmch
         F88soN5Lthi1YPNktkbKNwEd2wMiZaMQllXBNNsrJx1dLyIgTkvZTwdgw5Ap7ERCiBEj
         aEE4u5wKUgjHR8vyQY0ZFUpZ7YEJ7LxF7BwF+AgWpkAv65snr4p5kovPzR4wE932OWEy
         6kNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694804788; x=1695409588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/NNdNMoPNLRC5J4Us7rjn5YK+Bn2P8ki5j52BrAmQfc=;
        b=RgGVLif9otx/N2I5NYdOfex0J66iSByobDrq5pXz6fZG/mCBSnV6BHqqMSdjhRqPcu
         +pdoZEvuxC2v89fzFIApFhQmKGhYhepTp219KtJlzLQlpTWXqckjw4fzTjg6NvqhGiXf
         D+wr7qKLADoIIjfkHfktfXYmGdpHybFbkznK0yCesUhUSTm+SoFHlPEva0Q1B///xe9T
         f5+OeIxRajGC7SkHXOXJJWhn8lFRj6baYuLMlF5NjNPOu6FAcX1qOnmdNTPKToTHeqdK
         xc+pUcE0OXEXJyP0CX48jPOHHzBQ8fKQf224EkJyldZHJzWpF9IJs/qD/R2R4LbMUQmW
         U6gQ==
X-Gm-Message-State: AOJu0YwXJQ5FgrO7kIaEA8hv7Qo+2X4C4/ia2lptEwPbpgOAsvH9nHp2
        8W98naQi3V3TojaxqwmJGtuWPBbFb2w2RxWB/FBcFg==
X-Google-Smtp-Source: AGHT+IHnUmEPsIeFlP8ufy20De8OLVwpSSqcrp7lDWmTe6PTj/7WjDAOWdhgq5G3z26K+KHrakYbT0n8GVD/uGs4Htc=
X-Received: by 2002:a0c:e301:0:b0:651:65ca:141d with SMTP id
 s1-20020a0ce301000000b0065165ca141dmr2504505qvl.37.1694804787931; Fri, 15 Sep
 2023 12:06:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230915050125.3609689-1-davidgow@google.com>
In-Reply-To: <20230915050125.3609689-1-davidgow@google.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 15 Sep 2023 12:05:50 -0700
Message-ID: <CABCJKueOu+MwgvTcEUY51tJ1YjNjS-3zHhAHP=1TQUC1wd_1VA@mail.gmail.com>
Subject: Re: [RFC PATCH] kunit: Add a macro to wrap a deferred action function
To:     David Gow <davidgow@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Rae Moar <rmoar@google.com>, dlatypov@google.com,
        Benjamin Berg <benjamin.berg@intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
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

Hi David,

On Thu, Sep 14, 2023 at 10:01=E2=80=AFPM David Gow <davidgow@google.com> wr=
ote:
>
> KUnit's deferred action API accepts a void(*)(void *) function pointer
> which is called when the test is exited. However, we very frequently
> want to use existing functions which accept a single pointer, but which
> may not be of type void*. While this is probably dodgy enough to be on
> the wrong side of the C standard, it's been often used for similar
> callbacks, and gcc's -Wcast-function-type seems to ignore cases where
> the only difference is the type of the argument, assuming it's
> compatible (i.e., they're both pointers to data).
>
> However, clang 16 has introduced -Wcast-function-type-strict, which no
> longer permits any deviation in function pointer type. This seems to be
> because it'd break CFI, which validates the type of function calls.
>
> This rather ruins our attempts to cast functions to defer them, and
> leaves us with a few options:
> 1. Stick our fingers in our ears an ignore the warning. (It's worked so
>    far, but probably isn't the right thing to do.)
> 2. Find some horrible way of casting which fools the compiler into
>    letting us do the cast. (It'd still break CFI, though.)
> 3. Disable the warning, and CFI for this function. This isn't optimal,
>    but may make sense for test-only code. However, I think we'd have to
>    do this for every function called, not just the caller, so maybe it's
>    not practical.
> 4. Manually write wrappers around any such functions. This is ugly (do
>    we really want two copies of each function, one of which has no type
>    info and just forwards to the other). It could get repetitive.
> 5. Generate these wrappers with a macro. That's what this patch does.
>
> I'm broadly okay with any of the options above, though whatever we go
> with will no doubt require some bikeshedding of details (should these
> wrappers be public, do we dedupe them, etc).
>
> Thoughts?

Using a macro to generate a wrapper is a reasonable approach IMO, and
we've used it before in the kernel to fix type mismatches in
indirectly called functions (v4l2-ioctl and cfg80211 come to mind at
least).

Sami
