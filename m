Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2252A3FCEBA
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Aug 2021 22:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241104AbhHaUnn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Aug 2021 16:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241069AbhHaUnm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Aug 2021 16:43:42 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1740CC061575
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Aug 2021 13:42:47 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id u1so176635plq.5
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Aug 2021 13:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mopPPWDUZRS/w1wlTyFoXTy78YTkhMUpVlxA4c+KbU4=;
        b=QSAnXt/l+YXwS35Zb7EeTO80O4bG84fSptNL6F97mRyXbnnXvSIBvTrt8uFiDWH24J
         si4rtmnaiMjSKP2gJo/ZBMHXNhmipGJK0+2jLIcfkYu8O7ExE3zPnNHMSaG0Dhhn/ccA
         6e7QHppOo4trMtzqO8B6Io4cqR35gh2fsm1g0014k1UdK3uhwXmPKQkeGQFUNmkPF4eP
         xvbldCtC/+uSUv8M+1DhE0TwJUjPr37EWBbMSWpqG5chh5zok9DW19n2om4pk3Mn2bt1
         DmTPE9Zbtt4xGi8I/e2JpNAVUbKGc1mOg3HhjrxJsHHM3f9t6GpNh6smhFVHozS3R7AB
         6zJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mopPPWDUZRS/w1wlTyFoXTy78YTkhMUpVlxA4c+KbU4=;
        b=aRrja8vGJ85UNz/gyjm4wusWsoS6tw4kdgonCTYG4PSFUmAZ7fM4wH6/4WJOwK3Clj
         JWZVHuY4UxsMTSIuzrmolGX/pVgkbRCSZvnZhtZqGM+rznsIDmEGsdL126Whs91G8faR
         boKXjWz+jYOT0PHVsxqYMmk6Tk9Vs/fVpnzfL5J6hC76xOKh29GgK/FLuul0OD2NdGt4
         tKn7xCrUJ0xnmTun7bSKCKS7yAU+MDeaUTBJUOg91EPSDeE48hQoXPLcAOyEiJxlchc3
         jTooDrQjNb0BxnRNHv9oa3HsYox9tO/OoZpeRArOAmGiyQbztCSsHd+peUBy/Qp3i/Sq
         p9Gw==
X-Gm-Message-State: AOAM531GMm1TtEBKXJcjo5XAdGjsbgwz2pmc7UMp+kcdvQjuqB2C2gY7
        9mBg6QvCphlZ8eg5q3zt3p+gqYNSKifthXIHjU9ZAy2xoftJQg==
X-Google-Smtp-Source: ABdhPJx/NHWP8ax0f3aUn4vVb5tWgiQwsgvRL2xaUV+mtAgEFQ2Fp01KfH+y6V2bUBgjTh2sT0H5EA0nTOWN6p3BAII=
X-Received: by 2002:a17:90a:1904:: with SMTP id 4mr7522137pjg.217.1630442566184;
 Tue, 31 Aug 2021 13:42:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210831171926.3832806-1-dlatypov@google.com>
In-Reply-To: <20210831171926.3832806-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 31 Aug 2021 13:42:35 -0700
Message-ID: <CAFd5g460dsFZrxio5P6VX5LVpFMC6Runwos7PQtTuNpoOdPZCw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] kunit: drop assumption in kunit-log-test about
 current suite
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 31, 2021 at 10:19 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> This test assumes that the declared kunit_suite object is the exact one
> which is being executed, which KUnit will not guarantee [1].
>
> Specifically, `suite->log` is not initialized until a suite object is
> executed. So if KUnit makes a copy of the suite and runs that instead,
> this test dereferences an invalid pointer and (hopefully) segfaults.
>
> N.B. since we no longer assume this, we can no longer verify that
> `suite->log` is *not* allocated during normal execution.
>
> An alternative to this patch that would allow us to test that would
> require exposing an API for the current test to get its current suite.
> Exposing that for one internal kunit test seems like overkill, and
> grants users more footguns (e.g. reusing a test case in multiple suites
> and changing behavior based on the suite name, dynamically modifying the
> setup/cleanup funcs, storing/reading stuff out of the suite->log, etc.).
>
> [1] In a subsequent patch, KUnit will allow running subsets of test
> cases within a suite by making a copy of the suite w/ the filtered test
> list. But there are other reasons KUnit might execute a copy, e.g. if it
> ever wants to support parallel execution of different suites, recovering
> from errors and restarting suites
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
