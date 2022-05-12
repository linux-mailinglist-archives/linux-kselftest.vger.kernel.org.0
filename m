Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FD1525431
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 May 2022 19:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350502AbiELRxn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 May 2022 13:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347947AbiELRxm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 May 2022 13:53:42 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A922C2457B9
        for <linux-kselftest@vger.kernel.org>; Thu, 12 May 2022 10:53:41 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id i19so11683104eja.11
        for <linux-kselftest@vger.kernel.org>; Thu, 12 May 2022 10:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rF5TwgxqcKOTnH6e3JjjcZnpXw1SrE4T3AtfEU9WAmA=;
        b=P4dnIDAHRA//qYjQW/VtuRT1f+AWqvasomN7glq/CP85sbLSclvxORqzKSRJM1nU2n
         YuEZ0fA5uFsuc8M0MyjCWNI16kSGNp1Bn0JaPlMXkXq9uJhFaAqfW9+1XVsuBt9B1FZD
         FkscgFHN5nMwNd8rQfi8GxrRbWQTg0pReDu0V+PLnpBTT9hNN1edF876C646DmZv+KkA
         zC4D3lga+dg51lx5QdUOr2seNJYbzMVa4dGQTr3qy1zY6MmkzUn6meRL0VV3P7P4m1EG
         0adXneAez5QIHnDMyZORoVOqznwj4GMwROiJnTlAdfC3EVjNrHAL/GQAWinypgQeeSPU
         Q8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rF5TwgxqcKOTnH6e3JjjcZnpXw1SrE4T3AtfEU9WAmA=;
        b=V0DY6ZcekBPGXs1oUHmhI4D7E71QbQEX5pEYVcNhoWSScrbMbyUjmfKgmaMYj9xIVR
         YI/yByocnfn0BTe3FfxTXV37w2fWolY5PjX8P1IBpLEmttvafs1oEBP1C22wb+lREtTK
         Ov0pQG4Ko8rnWlOlpRPkUcXuksAFPJyp4R4CnHn+E528TMr1vHDzugMdyry6BT7ydEuj
         6JMujhoAwnpOD9genFMDkBnL+GcWExySBzVazS3h+Yzi8PCQkpERfXgQsNq2VtryhyB5
         5qPOpOwLK7hHHgFVI6aOu+nqXkrLnSmR0FY6Ubm0z6xLEfRzsafyVPsvQbeKhpGm2Sx6
         2g7A==
X-Gm-Message-State: AOAM531mABHaWwxelD8rRQeZI2r7k9HR/0SGEXQX5A8w5nLCYgnojGnu
        LLvEi2YTSXyUjvxKvVt8BYhLa+NlX0K/zioky/PHuw==
X-Google-Smtp-Source: ABdhPJwzEeDAwH5SCYP3hdfs32D2Sa5DcGVldegaz4uvByNdImHvnt0LUPxtSRUmmoIiyMmSLPVsFX+pLbmjUjvooTo=
X-Received: by 2002:a17:907:8a24:b0:6f4:82c9:9adc with SMTP id
 sc36-20020a1709078a2400b006f482c99adcmr978237ejc.223.1652378020059; Thu, 12
 May 2022 10:53:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220426173334.3871399-1-dlatypov@google.com> <20220426173334.3871399-2-dlatypov@google.com>
In-Reply-To: <20220426173334.3871399-2-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 12 May 2022 13:53:28 -0400
Message-ID: <CAFd5g44V99m1Rgy_FEPZYPWzSLr9T07ShnX-1H1PcwYrKBmXyw@mail.gmail.com>
Subject: Re: [PATCH 2/3] kunit: tool: make parser stop overwriting status of
 suites w/ no_tests
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
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

On Tue, Apr 26, 2022 at 1:33 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Consider this invocation
> $ ./tools/testing/kunit/kunit.py parse <<EOF
>   TAP version 14
>   1..2
>   ok 1 - suite
>     # Subtest: no_tests_suite
>     # catastrophic error!
>   not ok 1 - no_tests_suite
> EOF
>
> It will have a 0 exit code even though there's a "not ok".
>
> Consider this one:
> $ ./tools/testing/kunit/kunit.py parse <<EOF
>   TAP version 14
>   1..2
>   ok 1 - suite
>   not ok 1 - no_tests_suite
> EOF
>
> It will a non-zero exit code.
>
> Why?
> We have this line in the kunit_parser.py
> > parent_test = parse_test_header(lines, test)
> where we have special handling when we see "# Subtest" and we ignore the
> explicit reported "not ok 1" status!
>
> Also, NO_TESTS at a suite-level only results in a non-zero status code
> where then there's only one suite atm.
>
> This change is the minimal one to make sure we don't overwrite it.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
