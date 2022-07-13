Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1F6573A0F
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Jul 2022 17:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236525AbiGMPYr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Jul 2022 11:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234650AbiGMPYp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Jul 2022 11:24:45 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BC145050
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Jul 2022 08:24:44 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id 190so11176520iou.6
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Jul 2022 08:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cIzmuCZhcyQbk8eSHv2sqFPZ0r/TfvGha/933Vn+Tqg=;
        b=FMAPG3lpSqY+4/JOG6woLiJpYlD3Akz7uW2GlrJp4lfUtiQ4uHcP+78MDlN11xnhb3
         MZdJMDgdEZ6p63mRU7a5Egb0HttFCxlm1GlHz/HqmrT/IkJEbrf1RndiGXBcDJ7pmZTQ
         tGBeyWcn9eUzSG+diIO5qwz5FH2o1Rji2IUNzSKdpyEwqDEOmamWLpNw6E3IT/rWTfDC
         s6+utrSezcOmGHTgICZRCXffgedlAUJdXA1+ez2cwS59lJiRC5yAyxhiCBNQedE/c+da
         KKB1/Q4UskXOepImCPuBs5dm9Q3TW17hdFH8VgxQ1I2Eqp+k31vTBZX1FkOeVWWvtmCG
         nXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cIzmuCZhcyQbk8eSHv2sqFPZ0r/TfvGha/933Vn+Tqg=;
        b=D6JGAPEMr7CZv1M2TbfCio8k/Qdi9j/2oapRXgwefRoccbbxP6XeME/kaJSd69fPGK
         uUpGrH55i3IywtynI0h8FO8jKX/IczR+z484JoocRicBR2dWY7zzIdBQtPVj4dlgyS1x
         0EIWNuRQEAkHIBDk51v73pyOqG0I+m5KddX0+IlUrwVAuDNiubhcYh/6OSU56mCo2Wyu
         4jb2WU2LAJnDkCokWPi58mbskPvrEeIlFNK/RuqD5xjYvyMPcUV+cxr8nv12NYV4Uwx9
         GHNbXxuQR0bWPg9itM2JWX5sasFYoXwQYbgzrkLw1gg1W0CF9BkVwR3UVahWnahWm8qa
         4cdA==
X-Gm-Message-State: AJIora+gVQXQ6rkqydfFYJJkS8s8R8uTXm3x2XH4sNtYLOMbcEmI5PBp
        1x+nLoe1S83/QNvdiwF/aBEsbPENTOvhA5I2ic7mlA==
X-Google-Smtp-Source: AGRyM1tGpK1Jb0GzgDSuTPT0r4ZCKW4BCOjdF0Cbi6ycvY5CUshQoiFJjaXVaZHvy4/7CYsR64P2FpdhqSwWviTA0YM=
X-Received: by 2002:a05:6638:190c:b0:33f:8585:6ef3 with SMTP id
 p12-20020a056638190c00b0033f85856ef3mr1609961jal.153.1657725883559; Wed, 13
 Jul 2022 08:24:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220713005221.1926290-1-davidgow@google.com>
In-Reply-To: <20220713005221.1926290-1-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 13 Jul 2022 08:24:32 -0700
Message-ID: <CAGS_qxrNKnrWXhOfptz9iL5c_sixhKjpAfR2RLQi1XqL6m2Tpg@mail.gmail.com>
Subject: Re: [PATCH] module: kunit: Load .kunit_test_suites section when CONFIG_KUNIT=m
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        linux-modules@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Tue, Jul 12, 2022 at 5:52 PM David Gow <davidgow@google.com> wrote:
>
> The new KUnit module handling has KUnit test suites listed in a
> .kunit_test_suites section of each module. This should be loaded when
> the module is, but at the moment this only happens if KUnit is built-in.
>
> Also load this when KUnit is enabled as a module: it'll not be usable
> unless KUnit is loaded, but such modules are likely to depend on KUnit
> anyway, so it's unlikely to ever be loaded needlessly.

This seems reasonable to me.

Question: what happens in this case?
1. insmod <test-module>
2. insmod kunit
3. rmmod <test-module>

I think on 3, we'll call the cleanup code, __kunit_test_suites_exit(),
for <test-module>, I think?
But we never called __kunit_test_suites_init().
My fear is what breaks as a result of this precondition break.

E.g. In the case that CONFIG_KUNIT_DEBUGFS is enabled, this includes a
call to kunit_debugfs_destroy_suite() with no previous call to
kunit_debugfs_create_suite().
That will include a call to debugfs_remove_recursive(suite->debugfs),
where suite->debugfs is an uninitialized pointer.

Maybe we can treat it as "undefined behavior" for now and proceed with
this patch.

In terms of long-term fixes, perhaps insmod kunit could trigger it to
1. run all built-in tests (IIUC, it doesn't right now)
2. run all the tests of currently loaded modules
3. track which modules already ran so if you rmmod + insmod kunit
again, it won't rerun tests?

Daniel
