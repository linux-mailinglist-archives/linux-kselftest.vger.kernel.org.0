Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260A66EEC41
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Apr 2023 04:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239221AbjDZCMo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Apr 2023 22:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239175AbjDZCMn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Apr 2023 22:12:43 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580FA14479
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Apr 2023 19:12:41 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1a6e5be6224so152745ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Apr 2023 19:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682475161; x=1685067161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQAl7WIDX3nG1b8WyYVDaxQxUXgVIGV2IaFgXNIX3BQ=;
        b=cDF46ZOLvvKRFEBOEk2p8ZsjyWIwx+A+Khp62kbiCO79drnTEk7FaJM5QzGHnPUCHY
         pQaGO4GB1RZ0UlzkDQNFA0pJFN7blaF+DPYsxecCFMRVWbZzmrX/mDxVRwtF8c2Z90gP
         ZTGqSixXO1xYspZpStywkwE568OAH9aLNDjCgqHka8N2j8KWbri3vnYo+6xIYyPPT310
         8Og80162GDA9fzT44SLcXIR7K5re5fHv83lVoguZSiKdirr2lMHowrUxsY1ji0/HNbtS
         Rg/Lj7amlTC1wa+Bit14r7RJcEsD78t7RENWC1vDVAfPvsq7TSA+BGZsAkRU0dDbzvEw
         RDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682475161; x=1685067161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQAl7WIDX3nG1b8WyYVDaxQxUXgVIGV2IaFgXNIX3BQ=;
        b=dNAFvPVZWS8O6OKUbNi7pNHkwurzQFRLm1IVADH9jGAYpzLwbKntxASJZE1WsGayaz
         uEMmaWFs5JFZA8o6FW+TN+WZ+rwD0fgUDTOTTz3rYkEmbTaaBDrecYB9SrBiSXr1CAhz
         bo5UYrdo8eWkNXnZOyqdUB/V0Bck3IoavB3d9wEedpQ+5L0Yof6TXLwhzvB1oGCnww9y
         VJ6xp6ZylstOEQVI228loJkkYNdEHg6+TFm/hA6tCzOEqbthdnCc8YS9Rgxif14PucZr
         zTBm1hpYIfaQMjamDjpFqOU7nhvb+I1VmsKafFQBTOP8Ovr/atvk05oZvYrNsHmrx7lo
         qRMQ==
X-Gm-Message-State: AC+VfDz+K+YKqkWCFz5c7hVctlekyPqP48hdrwgrVUwec3sOSESfte1p
        nrRHSgiajqubZW7twYiuxaker1k3kjym5HLcF4rJeA==
X-Google-Smtp-Source: ACHHUZ5TrEeOXF1Ku1oe7rI+MSUtgXxc1PFXG1WC0SxAVGSGPuAvwT5hk5Eks697mlBICtmiJyGox6uCSwhojLPo9G4=
X-Received: by 2002:a17:902:f1d3:b0:1a8:df:f3c6 with SMTP id
 e19-20020a170902f1d300b001a800dff3c6mr148837plc.2.1682475160683; Tue, 25 Apr
 2023 19:12:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230421084226.2278282-1-davidgow@google.com> <20230421084226.2278282-2-davidgow@google.com>
In-Reply-To: <20230421084226.2278282-2-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 25 Apr 2023 19:12:29 -0700
Message-ID: <CAGS_qxp72dSbE9ZD7EyQ-JvXWucMs=LcX7uM1MAYL5oF_mtzgA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] kunit: Add kunit_add_action() to defer a call
 until test exit
To:     David Gow <davidgow@google.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Stephen Boyd <sboyd@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Rae Moar <rmoar@google.com>,
        Benjamin Berg <benjamin@sipsolutions.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Apr 21, 2023 at 1:42=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> Many uses of the KUnit resource system are intended to simply defer
> calling a function until the test exits (be it due to success or
> failure). The existing kunit_alloc_resource() function is often used for
> this, but was awkward to use (requiring passing NULL init functions, etc)=
,
> and returned a resource without incrementing its reference count, which
> -- while okay for this use-case -- could cause problems in others.
>
> Instead, introduce a simple kunit_add_action() API: a simple function
> (returning nothing, accepting a single void* argument) can be scheduled
> to be called when the test exits. Deferred actions are called in the
> opposite order to that which they were registered.
>
> This mimics the devres API, devm_add_action(), and also provides
> kunit_remove_action(), to cancel a deferred action, and
> kunit_release_action() to trigger one early.

Apologies for the delayed bikeshedding.

I think mimicking the devres API is a better idea than kunit_defer()
and friends.
But I can't help but think this still isn't the best name.
I personally would have no idea what `kunit_release_action()` does
without looking it up.

I feel like `kunit_add_cleanup()` probably works better for a unit
test framework.
I think `kunit_remove_cleanup()` is fine and `kunit_release_cleanup()`
is questionably ok.
Instead of `release`, maybe it should be `kunit_trigger_cleanup()` or
more verbosely, something like `kunit_early_trigger_cleanup()`.

I tried to look for equivalents in other languages/frameworks:
* Rust and C++ rely on RAII, don't think they have equivalents in testing l=
ibs
* Python has `self.addCleanup()`,
https://docs.python.org/3/library/unittest.html#unittest.TestCase.addCleanu=
p
* Go has `t.Cleanup()`, https://pkg.go.dev/testing#T.Cleanup
* Looking at Zig since it also has a `defer`, I guess they just use
that, I don't see anything in
https://ziglang.org/documentation/master/std/#A;std:testing
* I know nothing about JUnit, but a quick search seems like they rely
on @After and @AfterClass annotations,
https://junit.org/junit4/javadoc/4.12/org/junit/After.html
* I know even less about HUnit, but it looks like it relies on
wrapping things via the IO monad,
https://hackage.haskell.org/package/HUnit-1.6.2.0/docs/Test-HUnit-Base.html=
#t:AssertionPredicate
* Since we were inspired by TAP, I tried to look at Perl, but didn't
immediately see anything that looked equivalent,
https://metacpan.org/pod/Test::Most

>
> This is implemented as a resource under the hood, so the ordering
> between resource cleanup and deferred functions is maintained.
>
> Signed-off-by: David Gow <davidgow@google.com>
> ---

<snip>

> diff --git a/include/kunit/resource.h b/include/kunit/resource.h
> index c0d88b318e90..6db28cd43e9b 100644
> --- a/include/kunit/resource.h
> +++ b/include/kunit/resource.h
> @@ -387,4 +387,80 @@ static inline int kunit_destroy_named_resource(struc=
t kunit *test,
>   */
>  void kunit_remove_resource(struct kunit *test, struct kunit_resource *re=
s);
>
> +
> +/**
> + * kunit_add_action() - Defer an 'action' (function call) until the test=
 ends.
> + * @test: Test case to associate the action with.
> + * @func: The function to run on test exit
> + * @ctx: Data passed into @func
> + *
> + * Defer the execution of a function until the test exits, either normal=
ly or
> + * due to a failure.  @ctx is passed as additional context. All function=
s
> + * registered with kunit_add_action() will execute in the opposite order=
 to that
> + * they were registered in.
> + *
> + * This is useful for cleaning up allocated memory and resources.

Re renaming to kunit_add_cleanup(), I think this makes writing the
comment easier.

E.g.
- kunit_add_action() - Defer an 'action' (function call) until the test end=
s.
+ kunit_add_cleanup() - Call a function when the test ends.
+ ...
+ This is useful for cleaning up allocated memory and resources.

Daniel
