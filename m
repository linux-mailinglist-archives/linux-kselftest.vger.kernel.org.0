Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFF2569217
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Jul 2022 20:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbiGFSqP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Jul 2022 14:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbiGFSqO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Jul 2022 14:46:14 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379862251F
        for <linux-kselftest@vger.kernel.org>; Wed,  6 Jul 2022 11:46:13 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y8so14636738eda.3
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Jul 2022 11:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ArQRj5zQtcHaydnmWOW5hB+rAM/OvX+j6DP4yVvvY38=;
        b=SfC0Ow+BAevij9wNFnjUlGAUPxxIuQEyx9vRw9qqiXZppQrwgiDm9b55bo37nbGfv1
         etksABI3SWnauwd6TAc1VJM0LxeH9kM6/P+tAnFUjebkUyHDlS1+ccblLwWqAHJisuFa
         Zv3+Jrqqc2yU9F+WJYGQcmwTNkUVNkf/QoHI0I2DNiJqLbmuPc/9Kvd8+Z2MyzpXBK1Y
         YULaJbBAHG2B1oiNNz/QJmBT9dFi7h07Zkv/+hqUh4XdkDXVar0mre/nbW1IpLvYiNN4
         ccTlhrEiPWDRQZ0DC/oAW6RVEPPJV+x3RZcQ8jBndwRH8burEyoKqhVuQbFLA52TWA3G
         uP6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ArQRj5zQtcHaydnmWOW5hB+rAM/OvX+j6DP4yVvvY38=;
        b=S9dXFC+4zqeyGeAnqvbpvx8aAD94lvOVV7eoqEoJM5tnjyopkp4Gwaq1NTgDbNF6Xn
         gGd4k0XGO1DmEEFzpl3tUZVteUP4fUcQOf+mxacaAwtSl9SfPPBwkOycNEPWbbBafnh7
         mLqDWMaDdPbhfIGhmHhe3Q3ergBn/OQvLceHPpTL0PFAdt5Opb+XTCREYwK/L0uUyV2G
         pEUKnD3GsBrpzJNZr24Xk2cqjLBB8HOWArUdcW/n0aLDl4HT1XQ8JCmBXQfoDaEucOCb
         JTi4vtCKHj9XRnjNtm7MnBlPi718v8BhFT6aAXwEazYBOQDE4TMorWR2kCTGftBydt6d
         MZbA==
X-Gm-Message-State: AJIora9g7KFxdVWMqvsEEYmzJIU5KdHkbsoeHafhwVB+9Eq9CUYGxNh3
        tKaGgDbIFoA9ENg+4EmTcmp+hTYhQURDMXxtpHDU3Q==
X-Google-Smtp-Source: AGRyM1vmlS6JeMg7FkIAaxA4ps9qsKFG6dUJPPUMkJnxDLKjk7ynSMQRPEC1KauAfgG9ktfePccDwQOt9xt4Klwfq/0=
X-Received: by 2002:a05:6402:90a:b0:439:c144:24cd with SMTP id
 g10-20020a056402090a00b00439c14424cdmr33061862edz.209.1657133171655; Wed, 06
 Jul 2022 11:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220702051205.3292468-1-davidgow@google.com>
In-Reply-To: <20220702051205.3292468-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 6 Jul 2022 14:46:00 -0400
Message-ID: <CAFd5g47AVBUV8qdWF0B_oY8EMwTE85apv3b+nSsQu=bOZV=o4g@mail.gmail.com>
Subject: Re: [PATCH] kunit: Documentation: Fix a kernel-doc reference
To:     David Gow <davidgow@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Latypov <dlatypov@google.com>,
        Martin Fernandez <martin.fernandez@eclypsium.com>,
        Kees Cook <keescook@chromium.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jul 2, 2022 at 1:12 AM David Gow <davidgow@google.com> wrote:
>
> When building the KUnit documentation, the reference to
> kunit_test_suites in the kunit_test_init_section_suites kernel-doc
> comment gives an error:
> Documentation/dev-tools/kunit/api/test:9: ./include/kunit/test.h:323: WARNING: Inline interpreted text or phrase reference start-string without end-string.
>
> This is because the reference is mixing two function reference styles:
> adding an '&' to the front, and "()" to the end. The latter is neater,
> so get rid of the '&'.
>
> Fixes: 9bf2eed995f9 ("kunit: add support for kunit_suites that reference init code")
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
