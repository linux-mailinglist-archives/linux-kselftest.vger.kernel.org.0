Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0F5523F32
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 May 2022 23:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347965AbiEKVF7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 May 2022 17:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiEKVF6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 May 2022 17:05:58 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F0B36149
        for <linux-kselftest@vger.kernel.org>; Wed, 11 May 2022 14:05:56 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id gh6so6543513ejb.0
        for <linux-kselftest@vger.kernel.org>; Wed, 11 May 2022 14:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ynACITrtZzlKKqGyhSsamC0GjuNyAFQkpCuDbRLZ5eA=;
        b=L+AOis4yZWcZ1IL0iiPSTBcAUZGQn0SnVYsycwPfW58FE93ROmbF7Bq0hPrNiFRa8g
         JlrGFDByBnBWX5XKOuqEvyXXxMhG6UQkvV+XCCXX0AasnWtJ7lzwavwMGctz+7PCjPfw
         P8l9wg9vsu3om2MiVDp2PgbXcXZKSfn3Vc0pLg4NLih5m3Upk9BdZ1VzrwAGvFhmjLjO
         4M16DpVcSQ27cz+SJMwC/TKKZ3fNClJsGiy7u1rWz/ePh/1VRMnAZNrqe5POmmMFNCtq
         tGQ79/PFZYBRAUe0jo4rCXfD1S4WxZimlrsSErCx2ZbPncFLyz77tISUtsD8lw3bkz5y
         O7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ynACITrtZzlKKqGyhSsamC0GjuNyAFQkpCuDbRLZ5eA=;
        b=Sjj/J2hBGdrBouRqjmC0oblPE68Yf7HDsHoRB4rex9dJtsZq1DLoVgpIf7AqqNR8C3
         GJwovW+brH3rpU/Q+/eHRZgkKKYpz+bwGg7RqmPxskye3MSkGbB5Gj81IYJ1zj9w7wlg
         ZQR1nITV4WuWecM7SLhY4uUldDJP721rjUCzOhscuy6o8420pm169sRGu9MAx1g9ZkAl
         CzY04pIaNM4TlzII32lyxPnWk6LjmIzSbE2CoxXiMysji3pxGJZcqIVMtIl9PMsrq+xT
         cAUxLvGmYQ5jrTlH+XtviM9KbV+jOnfEs/WoPMKAiPNXNLTXCo5f1M8lTz3EkbACdJY6
         9L2Q==
X-Gm-Message-State: AOAM530FStVRYPyVKcTYWCfpNYNlspGZqyhwUSD9R1etVB0EiMZ4grCH
        XDXjWGs1kxB0Bjdb+l36iTS3Cfi6r8bwEFP6YFdTPQ==
X-Google-Smtp-Source: ABdhPJw4G75TGPYUDLK0sLGgvp0IXvKBjVwkHssJ3WNT+0ieIBKIsLsCtXbiQIiHz5aaWSrxJ7SnEdCMer/vL8uYcxE=
X-Received: by 2002:a17:907:968d:b0:6f4:9f9e:3e5f with SMTP id
 hd13-20020a170907968d00b006f49f9e3e5fmr27155651ejc.540.1652303155279; Wed, 11
 May 2022 14:05:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220405190619.540177-1-dlatypov@google.com>
In-Reply-To: <20220405190619.540177-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 11 May 2022 17:05:42 -0400
Message-ID: <CAFd5g44HjAHkwY9rAe3VCSTpRUNcoR0WU-e1z0BA+MKu_BYXyA@mail.gmail.com>
Subject: Re: [PATCH] lib/Kconfig.debug: change KUnit tests to default to KUNIT_ALL_TESTS
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
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

On Tue, Apr 5, 2022 at 3:06 PM Daniel Latypov <dlatypov@google.com> wrote:
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

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
