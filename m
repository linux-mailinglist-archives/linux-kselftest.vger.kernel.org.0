Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB0D57DB5E
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Jul 2022 09:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbiGVHf3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Jul 2022 03:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbiGVHf2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Jul 2022 03:35:28 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D8B52884
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Jul 2022 00:35:26 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id q26so3598206vsp.11
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Jul 2022 00:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cIXvAaSW5DBMQmZr/o71wlkcHcjE5t5Cw7BSqv0X5TU=;
        b=Nhacxl3MXayW7aaoYCXJWsTgzG7gbf4KkzQY+ICMD4yHn8UYPUZJNCsJ6GAYKBYKKO
         7b1NO321W5m6fG4eTUxm5B4GdORnPGMEa4oOlLf1MrW2c6e9HvwGnMNX9+EvJt5vu/TJ
         rcwm+Oqvg5k3Vt5J3rCGWtCikThPXVWBrb3Lm83QuB3zUWLtXWNjCEIP/3VZnchywQ5H
         735jptWUTIrfz69Fq00KQ1wPJCDbX5EPDhyqD3WQnYxxK9xWOL3Sp1JthMHELGqv3utv
         0R12Wupu7ZvKvKfj29EoNbm4Lt/UbrQAGV1Ic7HPfGSjoAHBu7PrwN3TDCBIyb68vZ7p
         gKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cIXvAaSW5DBMQmZr/o71wlkcHcjE5t5Cw7BSqv0X5TU=;
        b=f9WWUWYKYG8QoTp4xCHw6jBRAnlTLcBJQI8/f9BBSTu+SNxklbTxcnQNwZDmXwQVLT
         iDdeJTWOVQTvB27tO6r+57vpLAZ19Dv0j6DXphiFVqrI1EOMInKEVNqZNlAtWiT2jFbp
         t8kzr0WH6cnqyymQWSteF91Ko19XOTHdeoUliFEqpZHkUqZsYt0w5sBkyglP3Nf/j8fP
         ehe0FeRpI8n42j95N+K3na9MCZXYqaP97EM+KM1WZzZuqgPsAmhkJhmbjHRnRMdm1Fcm
         Xu1e4HcFrMvdeN+TZxrwCdpGDOPClPf/B7a2JLVvaLSnOK8Q5C2urxWQSLz1mCgUNh7c
         Ju4A==
X-Gm-Message-State: AJIora9iS1cCba0RZw8RWVvMBceucDJFNt1TL60Dh7rujkFe7Nh+n78p
        wlvxtCwVoJ/T/x8zQXo8tIFjz2b94+XOXnEqPME+Bw==
X-Google-Smtp-Source: AGRyM1vChcaBz2dWLY/qMzpEDulfg11hmEElJ6QknyFZPyhzwQrGsq47B0QWAHXWymoKsaYgUZY56itiw7gyYLEW1MY=
X-Received: by 2002:a05:6102:381:b0:357:a112:adc7 with SMTP id
 m1-20020a056102038100b00357a112adc7mr624492vsq.38.1658475325123; Fri, 22 Jul
 2022 00:35:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220721180214.3223778-1-dlatypov@google.com> <20220721180214.3223778-4-dlatypov@google.com>
In-Reply-To: <20220721180214.3223778-4-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 22 Jul 2022 15:35:14 +0800
Message-ID: <CABVgOSkHCDt4DPRTCpSgWUSa5_5adEoqwW1fNnXyev9fK1eiuQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] kunit: make knuit_kfree() not segfault on invalid inputs
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
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

(Nit: typo in the subject line "knuit_free" --> "kunit_free"
On Fri, Jul 22, 2022 at 2:02 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> kunit_kfree() can only work on data ("resources") allocated by KUnit.
>
> Currently for code like this,
> > void *ptr = kmalloc(4, GFP_KERNEL);
> > kunit_kfree(test, ptr);
> kunit_kfree() will segfault.
>
> It'll try and look up the kunit_resource associated with `ptr` and get a
> NULL back, but it won't check for this. This means we also segfault if
> you double-free.

Personally, I don't think the case of people calling kunit_kfree() on
pointers allocated with kmalloc() is too worrying, but I do think we
should error more gracefully in cases like double-frees (and maybe
handle kfree(NULL) situations).
>
> Change kunit_kfree() so it'll notice these invalid pointers and respond
> by failing the test.
>
> Implementation: kunit_destroy_resource() does what kunit_kfree() does,
> but is more generic and returns -ENOENT when it can't find the resource.
> Sadly, unlike just letting it crash, this means we don't get a stack
> trace. But kunit_kfree() is so infrequently used it shouldn't be hard to
> track down the bad callsite anyways.

One day we should look into printing stacktraces on failed
expectations... It could be spammy in some cases, but it'd be nice to
have the option for things like this.
>
> After this change, the above code gives:
> > # example_simple_test: EXPECTATION FAILED at lib/kunit/test.c:702
> > kunit_kfree: 00000000626ec200 already freed or not allocated by kunit
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Looks good to me: this is both more correct and so much simpler as a
function. I can live without the nitpicks fixed.

Reviewed-by: David Gow <davidgow@google.com>

Thanks!
-- David

>  lib/kunit/test.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 82019a78462e..c7ca87484968 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -698,18 +698,8 @@ static inline bool kunit_kfree_match(struct kunit *test,
>
>  void kunit_kfree(struct kunit *test, const void *ptr)
>  {
> -       struct kunit_resource *res;
> -
> -       res = kunit_find_resource(test, kunit_kfree_match, (void *)ptr);
> -
> -       /*
> -        * Removing the resource from the list of resources drops the
> -        * reference count to 1; the final put will trigger the free.
> -        */
> -       kunit_remove_resource(test, res);
> -
> -       kunit_put_resource(res);
> -
> +       if (kunit_destroy_resource(test, kunit_kfree_match, (void *)ptr))
> +               KUNIT_FAIL(test, "kunit_kfree: %px already freed or not allocated by kunit", ptr);

_Maybe_ we should no-op if ptr is NULL. I think it's legal for
free()/kfree(), and while I don't see much use of it for kunit tests,
maybe it'll save someone confusion down the road.

But I could live with it either way...

>  }
>  EXPORT_SYMBOL_GPL(kunit_kfree);
>
> --
> 2.37.1.359.gd136c6c3e2-goog
>
