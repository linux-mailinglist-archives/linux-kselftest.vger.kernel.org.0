Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9746D37611A
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 May 2021 09:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhEGH0q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 May 2021 03:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235276AbhEGH0p (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 May 2021 03:26:45 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32FEC061761
        for <linux-kselftest@vger.kernel.org>; Fri,  7 May 2021 00:25:44 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id n2so12077934ejy.7
        for <linux-kselftest@vger.kernel.org>; Fri, 07 May 2021 00:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eTcOiJuUBe4mwErRjR9sk/Dc+yGEFwaWB4ssf73sgvI=;
        b=SrVWIbP2AUGIHpQoE5kpkyBzA8SAVtCVKnIgW34Ds8KCO5uqfbMI7yjAm5hWES23b2
         Yz1iZPCrCSrugSkoibyQ2++4q5cBe52pVGr/qRa7SKeE/hIrseHXUj7APD0aW4+E/npV
         bJepwV8ztZhu/TRjbd9SYhDHChguZiINkL1G1WxtAqX4BFdkLpvi5t4zSbaP9kPOlU9w
         jVwHqmo2YziO3XdxAezNS62/ft1yM5AtRt123yE+4IxulhQt4DLYVuWLqbT2neL4p3Uo
         Gn70glTXdFKL5P038nLTPFZYIj0qZ5EFQBwIdqsopfIddNEbudpWJSX2KmIws5akSewY
         y00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eTcOiJuUBe4mwErRjR9sk/Dc+yGEFwaWB4ssf73sgvI=;
        b=lAoppJHzKRg36ZYaWPVMdKHmSzp/gDTMCarXMpywcnqUCNtnUQizODsDrNam6rvh2M
         OqDtw5VPkFuDAhQepVOVfwihjqrAICoNa2gVLmvdMcAV3wtokxap50yUlSnt/Sel8NWM
         6ZEejCFoD2jHZAutNKpCzApm2s7OPy+SozxkL3bj7+sbs4bW3a7w2/hpF4og9Epj78pL
         Xtn8ai67QSQ6F4m8iE6Jb3MhNfd1tBrWfhgkidQPPoQCWgCrgop91wvoHtMAAzjRo8Ug
         C176RQDYzDBX0GpOPBPlq4uZ3m2P7TpS+gXpDkkYoSDqPWZ5AdJ7b7fj3G7Tbp0IjvR9
         CEfA==
X-Gm-Message-State: AOAM531jg9d1hXJxTkxsYcjAKnOpxsxoek7v3cWAXIuDKYZOSNth9NS4
        j43/HW0ycCE6WXlZkwTBnnrQV3gIBGzYfsGvdW9jCw==
X-Google-Smtp-Source: ABdhPJyu8GA+H4PSMjHEiEswlBTm9mTDBQOIbjb/Cdl4U1P8ljwsaYvPMqaWo60UhqJEfuu3YqDlY6D194iK/XP86Qg=
X-Received: by 2002:a17:906:d0c8:: with SMTP id bq8mr8247577ejb.423.1620372343322;
 Fri, 07 May 2021 00:25:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210507050908.1008686-1-davidgow@google.com>
In-Reply-To: <20210507050908.1008686-1-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 7 May 2021 00:25:32 -0700
Message-ID: <CAGS_qxoqt3ui13HKNv4iQkOB2Bo1m189sRngR3EzOOHM2jnY-A@mail.gmail.com>
Subject: Re: [PATCH 1/2] kunit: Do not typecheck binary assertions
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 6, 2021 at 10:09 PM David Gow <davidgow@google.com> wrote:
>
> The use of typecheck() in KUNIT_EXPECT_EQ() and friends is causing more
> problems than I think it's worth. Things like enums need to have their
> values explicitly cast, and literals all need to be very precisely typed
> for the code to compile.
>
> While typechecking does have its uses, the additional overhead of having
> lots of needless casts -- combined with the awkward error messages which
> don't mention which types are involved -- makes tests less readable and
> more difficult to write.
>
> By removing the typecheck() call, the two arguments still need to be of
> compatible types, but don't need to be of exactly the same time, which
> seems a less confusing and more useful compromise.
>
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>
> I appreciate that this is probably a bit controversial (and, indeed, I
> was a bit hesitant about sending it out myself), but after sitting on it
> for a few days, I still think this is probably an improvement overall.

I'm in favor.
The absolute worst part of the status quo is that the types involved
might not get shown at all in the GCC error output!
It's an incredible pain and probably has wasted a good deal of other
people's time as well.
(Maybe clang is better in this regard).

Here's a few examples where things get a bit weird:
    KUNIT_EXPECT_EQ(test, 1 + 1, 2.5);
     Expected 1 + 1 == 2.5, but
         1 + 1 == 2
         2.5 == 2

Along similar lines:
  KUNIT_EXPECT_EQ(test, 0xffffffff, ~0);
  KUNIT_EXPECT_EQ(test, 0xffffffffffffffff, ~0);
  KUNIT_EXPECT_EQ(test, 0xfffffffffffffffe, ~1);
  KUNIT_EXPECT_EQ(test, 0xfffffffe, ~0); //fails
The failure message on the last might make one wonder how the first ones worked.
    Expected 0xfffffffe == ~0, but
         0xfffffffe == 4294967294
         ~0 == -1

Explanation: when evaluating the assertion, we compare __left/__right
directly which maintain their types.
But struct kunit_binary_assert stores them as `long long`, hence the
truncation of 2.5 to 2.

I was nervous about ~0, as it should be an int, i.e. this passes:
  KUNIT_EXPECT_EQ(test, sizeof(~0), sizeof(int))
But it all works as expected, e.g. we don't have implicit narrowing
going on and causing us to say that 0xfffffffffffffffe = 0.


Stuff like
  KUNIT_EXPECT_EQ(test, 0, NULL);
will compile, but with warnings
../include/kunit/test.h:805:15: warning: comparison between pointer and integer
  805 |         left, ==, right,          \
      |               ^~

So I generally think that we can rely on compiler warnings to protect
us from some misuse.

Reviewed-by: Daniel Latypov <dlatypov@google.com>


>
> The second patch does fix what I think is an actual bug, though, so even
> if this isn't determined to be a good idea, it (or some equivalent)
> should probably go through.
>
> Cheers,
> -- David
>
>  include/kunit/test.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 49601c4b98b8..4c56ffcb7403 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -775,7 +775,6 @@ void kunit_do_assertion(struct kunit *test,
>  do {                                                                          \
>         typeof(left) __left = (left);                                          \
>         typeof(right) __right = (right);                                       \
> -       ((void)__typecheck(__left, __right));                                  \
>                                                                                \
>         KUNIT_ASSERTION(test,                                                  \
>                         __left op __right,                                     \
> --
> 2.31.1.607.g51e8a6a459-goog
>
