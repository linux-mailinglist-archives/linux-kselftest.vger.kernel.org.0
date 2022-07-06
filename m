Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CABC356927D
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Jul 2022 21:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiGFTRB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Jul 2022 15:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234080AbiGFTRA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Jul 2022 15:17:00 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7E019C19
        for <linux-kselftest@vger.kernel.org>; Wed,  6 Jul 2022 12:16:57 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id d2so28789470ejy.1
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Jul 2022 12:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=reR7P1Rqp9a3ZRIWONmbR6Gu3xvrQ/WGL3CcB+nbnkM=;
        b=fqWhLqc2EGatGpbH3yd/h+TgP4hbqtyviQObkzDgxbGsNOWyAz3gwwPz25bzbHrMft
         LtkGAYh/478DEa0fjHhj0j95jZXj+kADrSHDf4P1y+4Y/cNZZjTs9aCbp3L/33ShpNmO
         umoPVImXwRYpN/r/Dhc3QGZ4lSk/rJD8KkTLmMdfCN9Vm5AEQjmsvsubrHE5oMueGm83
         P1sTqslvmATew8I73x/zgFHWrQadBZ83MwgnfITNCv40k7E/9sPa4FdZ5ltT9qz3DUwJ
         JUxVtKP4/vZfGF3+D3UMk9ulRGyYgzLmNjKp8xa8CdBt67CXvM30jVc01+HbFuqdZAle
         Qxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=reR7P1Rqp9a3ZRIWONmbR6Gu3xvrQ/WGL3CcB+nbnkM=;
        b=TsOwSF3UrHp+0C0IWtQHkHAVEg9jcmbUyHnfxCJvhLpdKZEFv3x2+WBizgHaiXHLAd
         KvKZBMm2KN2hl73ihOWOpsSjesSRpNB/tTuo6HlozBUZGcZWtwqPAvJBH3iQuIQ/Scel
         pPkq2SUhEOONb6Wxy7ai6oXcD9YJh97S/XTVdwMwD63AQ3PW2dgLFFGtTxsJhFxFDv7J
         svxjEHOoePCX1s1slE6X7THnSfXP89uOBThkDCxQiZkJQ1I2heZI50DqCGcKl21aggvg
         9dLD88jtjWYsFHJLRtZvGyPxtbuBZgpHjpDCtg4rQod5PTLtJi5tSesDSrMW7IY6ip+M
         V2fQ==
X-Gm-Message-State: AJIora8TQ9bzJ/W3WNeAyw2OEIv86GhtAfRngbdTteHIcUd/zWUc80C5
        OlgpbGyImEjxsVVlNMXZj77NH7WAJ8pITbAMBERSpQ==
X-Google-Smtp-Source: AGRyM1tzlbqhCEX19MN4cOQjHXWl0PI+r+wxRpjM/F5GB2jrE0tv8rohCwuA//k7gFDG/+c67aYo3qLGzaDBsjvPoWA=
X-Received: by 2002:a17:907:e8e:b0:72a:ad07:8357 with SMTP id
 ho14-20020a1709070e8e00b0072aad078357mr23318147ejc.338.1657135016015; Wed, 06
 Jul 2022 12:16:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220516194730.1546328-1-dlatypov@google.com> <20220516194730.1546328-3-dlatypov@google.com>
In-Reply-To: <20220516194730.1546328-3-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 6 Jul 2022 15:16:44 -0400
Message-ID: <CAFd5g45r5gt=_CLQC0ZsK=G8zKF1suFEOp9179dAJtoMMhJaKQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] kunit: tool: refactoring printing logic into kunit_printer.py
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
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

On Mon, May 16, 2022 at 3:48 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Context:
> * kunit_kernel.py is importing kunit_parser.py just to use the
>   print_with_timestamp() function
> * the parser is directly printing to stdout, which will become an issue
>   if we ever try to run multiple kernels in parallel
>
> This patch introduces a kunit_printer.py file and migrates callers of
> kunit_parser.print_with_timestamp() to call
> kunit_printer.stdout.print_with_timestamp() instead.
>
> Future changes:
> If we want to support showing results for parallel runs, we could then
> create new Printer's that don't directly write to stdout and refactor
> the code to pass around these Printer objects.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
