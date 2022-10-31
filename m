Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5636F613CA6
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Oct 2022 18:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbiJaRyy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Oct 2022 13:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbiJaRyw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Oct 2022 13:54:52 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B566356
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Oct 2022 10:54:50 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id k2so31428488ejr.2
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Oct 2022 10:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QNSHj1Pi7KpdN4CZz38s5hNP1TxvrZQ+3qa5AOl5Yyw=;
        b=rO/cwHoAAQ0VRP9qqaykr6SUN6yhLh7TWSVazD3hc+N0MKGvihbbxOQ3jr6VP9y5aB
         iKKWrZvwgMTYiQXsEbB8GL7Y9FD+tIO8vci4symHzUXYu1RN/7D4aY1Bv5X81VVadrvx
         ZqHjrkodukcZz6oFd0K97nh8xwwQa8xKVhw2e2ltCqs4f5/RFA5SeLQ8ur8296iYkOjr
         0l6BFx3M9uE5PRpHWjkUsThODrpomLAPAeCtv3a5IOTET1aV1AaMOStRThMnGbpDT+Lf
         oORsSywGLiVp2HbNTFU/0AMGMNmXtKPc1uAYwxwN7TZBSFHBG6qLj/OM/04u749sOXBo
         GvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QNSHj1Pi7KpdN4CZz38s5hNP1TxvrZQ+3qa5AOl5Yyw=;
        b=t32K9+WnX1ceHPjfl11hQqfWQrlyslMzax7GSdxthc/J+sa6g2i1hfg7k38MXx9MU6
         7e5UJcBb8JRUY6xmbCPA6iFeuFnxasmdy3jVMdM1VzJNhEudOFoswhU8TyEhrEprcByF
         BqhziHdsZdMkNtm0M+aeshDeLKTvHBExtQBLjkx1W/MDC6xAdz9NiaeqTU2Z7HEE8+Aq
         kY/bu/ZIgiylXNbLKO04VdrnWvem+Nqg9dxBJ58fkoM9Ara7y0wxjTOGZN5lAF03jS6w
         BGfrGkjiFuvhGXO5DAtqY/QgS47A8lRNpF70/mo9aKlIgvGpYLQ/0nhSjg4h/p8GcP1z
         N/Cw==
X-Gm-Message-State: ACrzQf1PScaGMhFTPhkdQF4F/PJ5WrqkpqI9N/NBIvCSvr5aSsmRZmXG
        yjvlF6vnAGOSskZf2c+7zsRXp5ZjsHlepXv1VsHIEgC2gdA=
X-Google-Smtp-Source: AMsMyM5BBkRhLKN5ftz0Vjb8eiUNngBuoKLwvPjf945dsngAJi0SZHjwI7pEyyLKwbhp93Yg17H7tk8xTumuo8lGFUo=
X-Received: by 2002:a17:907:2705:b0:7ad:8460:7d30 with SMTP id
 w5-20020a170907270500b007ad84607d30mr13783488ejk.693.1667238889166; Mon, 31
 Oct 2022 10:54:49 -0700 (PDT)
MIME-Version: 1.0
References: <20221028210256.3776835-1-dlatypov@google.com> <20221028210256.3776835-2-dlatypov@google.com>
 <CABVgOSkXE-nYnWyJmCdEZ0b1xCBj-p_cpE5YzBCZvW4cdk8LOw@mail.gmail.com>
In-Reply-To: <CABVgOSkXE-nYnWyJmCdEZ0b1xCBj-p_cpE5YzBCZvW4cdk8LOw@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 31 Oct 2022 10:54:37 -0700
Message-ID: <CAGS_qxo97DeZJuv7CXuQyhBgbT-k5ah_51N-L7+pzoi6BT1NzQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] kunit: tool: print summary of failed tests if a few
 failed out of a lot
To:     David Gow <davidgow@google.com>
Cc:     brendanhiggins@google.com, rmoar@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
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

On Sun, Oct 30, 2022 at 7:05 AM David Gow <davidgow@google.com> wrote:
>
> On Sat, Oct 29, 2022 at 5:03 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > E.g. all the hw_breakpoint tests are failing right now.
> > So if I run `kunit.py run --altests --arch=x86_64`, then I see
> > > Testing complete. Ran 408 tests: passed: 392, failed: 9, skipped: 7
> >
> > Seeing which 9 tests failed out of the hundreds is annoying.
> > If my terminal doesn't have scrollback support, I have to resort to
> > looking at `.kunit/test.log` for the `not ok` lines.
> >
> > Teach kunit.py to print a summarized list of failures if the # of tests
> > reachs an arbitrary threshold (>=100 tests).
> >
> > To try and keep the output from being too long/noisy, this new logic
> > a) just reports "parent_test failed" if every child test failed
> > b) won't print anything if there are >10 failures (also arbitrary).
> >
> > With this patch, we get an extra line of output showing:
> > > Testing complete. Ran 408 tests: passed: 392, failed: 9, skipped: 7
> > > Failures: hw_breakpoint
> >
> > This also works with parameterized tests, e.g. if I add a fake failure
> > > Failures: kcsan.test_atomic_builtins_missing_barrier.threads=6
> >
> > Note: we didn't have enough tests for this to be a problem before.
> > But with commit 980ac3ad0512 ("kunit: tool: rename all_test_uml.config,
> > use it for --alltests"), --alltests works and thus running >100 tests
> > will probably become more common.
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
>
> I like it! I do think we'll ultimately want some more options for the
> main results display as well (e.g., only display failed tests, limit
> the depth of nested results, etc), but this would be useful even then,
> as the number of tests displayed could still be large. (And you might
> not know what failures you'd be looking for in advance.)
>
> Reviewed-by: David Gow <davidgow@google.com>

Agreed, there's a lot of room to play around with the main output.
The hope here is this is enough to tide us over (usability-wise) until
we get around to that.

E.g. in the future, it might make sense to only print suite names by default.
If subtests (test cases and individual parameters) fail, we could
print those in expanded detail.
But there's obviously tradeoffs:
* the real time output is nice, esp. since some test cases are slower
than others
* I think most people are only running 1-2 suites at a time right now

Another thing we could do is optionally use \r to use only the last
few lines for in-progress output?
E.g.

t=1
Running suite: example
[PASSED] example_simple_test

t=2, use \r to update the test case line
Running suite: example
[SKIPPED] example_skip_test

Then we could print out the results of interest in more detail at the end.
