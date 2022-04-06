Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6E74F57B6
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Apr 2022 10:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbiDFHRF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Apr 2022 03:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1454453AbiDFGoO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Apr 2022 02:44:14 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39FC1C16E8
        for <linux-kselftest@vger.kernel.org>; Tue,  5 Apr 2022 21:44:22 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id l7-20020a05600c1d0700b0038c99618859so2860240wms.2
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Apr 2022 21:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e1+rSoTUFj3WU/eLBjLIgKZMH01AWeNOKksTlBoI6QI=;
        b=DZ356kbwx5IGdFHW0oHIMS7b7EvtD/qoADxDb3OCAQsNy1e/3rk+O6v1Hin+9fHM+w
         8YqIdfgn96Z+8lR/e9ASQ3ksjl+FNnPdAdUm2+RQdYwNoXTgTXoMmEGa76DCWF7gfBUL
         oKQ9OsGLPk05HGzDi42x5w+msAtGdWaYaIqrEJiF5vYr3hbgkZSJu2/xuBheXSzuSkdD
         WOxPvzQ8Q5YPN+/86k1RZ4stBMQRuQfdD8rd6KFDKmkv3h4E0v/yX7tZksqWzQGW4eaL
         4TRxoR7LGSY9TJroykH/kpFBz83Ju2+XPgxlkW7QvV2C0PW4k18tlPzNGrBG1qnKcloJ
         Rl8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e1+rSoTUFj3WU/eLBjLIgKZMH01AWeNOKksTlBoI6QI=;
        b=mJj+aZ7be/m+vKKBocio647x/+lJBF1RRLzTZPm+7BNJJb2SCkNQs69b5AgFnD+SpT
         VNzQ2UPSVQq2BqhZkHcxyTGrggsNhresg2DUosb6w9usVxm/+4Qm1RAov1XrodxMd0Wu
         oGqnqGyjDWjvukQztn05jRYpoAYX5Ab6FmLMnQ5DZ7G8TZRz86WfD2gm3UJBftqxTcqR
         SLotXSIomPUBg4sKmrshrCbFlqZ2bKnEiuEfguNmubVSVtT+7XDiNfgQ+DgHZ1QZmp0s
         ig/umb2klhhRmb9srWcveSdki2RfmBGP72FF5Tt8d849cLItxxt2iw4ZFULUK1HESwP+
         AM5Q==
X-Gm-Message-State: AOAM5323gjohBzkrrf6TCY11aU0nE8wvH5SdExvJHVaMa60rC2jxhAHX
        a9/KlkriZJVunRGTG3knPePZtqvNiVLFmhUnTKX6fw==
X-Google-Smtp-Source: ABdhPJzUeoLh2rgohUoRmso6+QuCiyytCmkErXglSSd5mbHd/aI3A9xMIPS+cvm8RRGxxq/lcUpM6xrBahrJyk5gvpg=
X-Received: by 2002:a05:600c:6004:b0:38c:6c00:4316 with SMTP id
 az4-20020a05600c600400b0038c6c004316mr5854562wmb.6.1649220261185; Tue, 05 Apr
 2022 21:44:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220405190619.540177-1-dlatypov@google.com>
In-Reply-To: <20220405190619.540177-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 6 Apr 2022 12:44:10 +0800
Message-ID: <CABVgOSmJ+oOLqK-yVtr-AhtOSQ8RxMo9hB0uLR6-p_mBrME3Hg@mail.gmail.com>
Subject: Re: [PATCH] lib/Kconfig.debug: change KUnit tests to default to KUNIT_ALL_TESTS
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
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Apr 6, 2022 at 3:06 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> This is in line with Documentation/dev-tools/kunit/style.rst.
> Some of these tests predate that so they don't follow this convention.
>
> With this and commit b0841b51cac9 ("kunit: arch/um/configs: Enable
> KUNIT_ALL_TESTS by default"), kunit.py will now run these tests by
> default. This hopefully makes it easier to run and maintain the tests.
> If any of these were to start failing, people would notice much quicker.
>
> Note: this commit doesn't update LINEAR_RANGES_TEST since that would
> select its dependency (LINEAR_RANGES). We don't want KUNIT_ALL_TESTS
> to enable anything other than test kconfigs.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

I'd forgotten these were missing KUNIT_ALL_TESTS support, thanks!

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David
