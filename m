Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E60943D719
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Oct 2021 01:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhJ0XFY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Oct 2021 19:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbhJ0XFX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Oct 2021 19:05:23 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AA0C061745
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Oct 2021 16:02:57 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k7so6687474wrd.13
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Oct 2021 16:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DkNDhiEnUBFd5g6Q7nEnrcdTNYozC6sABi5j39jJUF8=;
        b=O57Zy/hgeucXgevrTxtL8Wv4sU2LKVUiZQ68zd/yTuraAcKI9j4ZpvMgxRU2jfJF6L
         1rh56ESO/dUOk7Wi2e+OpC3mrxyxrzVQ3TxRjLTzx0BGas/reMb9hVgpmFh0/khc2P7M
         ZVa1qUPybjco2VRP7TiTOagAaCUc7QG7Z6dS648ZstOlb3HqJ/1O/gf/dVVyyNFdxNjv
         DMi2hHGtTJb7hWtn3/Gpd3SaCtrTVdPE1jyicUQtktSj25G2XHfxb3claF160a41FPap
         zLX4XtOTPFVRpDJ+NpZXkhKIdHPWjJXxFoVC/PywSnVjM55edlzrxbZ6U8OB7bhMkcGy
         n/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DkNDhiEnUBFd5g6Q7nEnrcdTNYozC6sABi5j39jJUF8=;
        b=tou4F1UtkGopv8GnTXZ2b0/BeqsOJ2TzcXN9RGXX37wMfNOkyNNMmhXm1YOs/BfazO
         ewnekAB0XGX0R7YO2ABYYZNDaZA530H256OZr6h72nFOnWWR1DlxjeodccNm1xZrG2YZ
         16yrHx6ss+0tJwAxtBxy1veMBZQN/v++EtnRayZMe4mqXYWGZzTm6tjZ5QajobDKRRTC
         GRxQx/vTu/LIsRb0cxkZNckvC8fA8ICZGAeGh283tlL1Ejm08w5EexSSIx2fFccF49Mz
         QrQTpUzXYGxdNTH8RhIv/L1tL/geWHUevun5P5fl7G6UAxhfOZd0zPpKzcq5m2WoosgS
         IWzQ==
X-Gm-Message-State: AOAM531lNQcJEAbak/EomGIi1FO4/LRRp7JFyIIp6QvQC8hd9ZRo4JN7
        QK4KjEUsuQFICgZ3D1RRHh3ajt5tzfXHS0GAU08+xA==
X-Google-Smtp-Source: ABdhPJyO1vwvDrD3z/hjTZUkPwoCJGxlHZGp1P4reZ7iy0UtXE2yq8mDVVpaGENP60V2gmhuJF8PbiES4vM1e/WK3qE=
X-Received: by 2002:adf:d0c3:: with SMTP id z3mr789158wrh.44.1635375776246;
 Wed, 27 Oct 2021 16:02:56 -0700 (PDT)
MIME-Version: 1.0
References: <20211027013702.2039566-1-davidgow@google.com> <CAGS_qxo2=NmXEnEnkg4E_1k-DXwniGK8xFZi08nKZZkb8otXzQ@mail.gmail.com>
In-Reply-To: <CAGS_qxo2=NmXEnEnkg4E_1k-DXwniGK8xFZi08nKZZkb8otXzQ@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 28 Oct 2021 07:02:45 +0800
Message-ID: <CABVgOSnQ73ZqnF=Y7Wg-rO_wp-ttSbK8=p2EXUbh7ogGpDPUfA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] kunit: tool: Do not error on tests without test plans
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Rae Moar <rmr167@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 28, 2021 at 6:13 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Tue, Oct 26, 2021 at 6:37 PM David Gow <davidgow@google.com> wrote:
> >
> > The (K)TAP spec encourages test output to begin with a 'test plan': a
> > count of the number of tests being run of the form:
> > 1..n
> >
> > However, some test suites might not know the number of subtests in
> > advance (for example, KUnit's parameterised tests use a generator
> > function). In this case, it's not possible to print the test plan in
> > advance.
> >
> > kunit_tool already parses test output which doesn't contain a plan, but
> > reports an error. Since we want to use nested subtests with KUnit
> > paramterised tests, remove this error.
> >
> > Signed-off-by: David Gow <davidgow@google.com>
>
> Reviewed-by: Daniel Latypov <dlatypov@google.com>
>
> This looks to be unchanged from v1.

Yeah, the changes in v2 were all in the new patches.

-- David
