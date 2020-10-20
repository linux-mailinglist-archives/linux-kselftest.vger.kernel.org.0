Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A830429448A
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Oct 2020 23:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409931AbgJTV37 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Oct 2020 17:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409891AbgJTV37 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Oct 2020 17:29:59 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A73C0613CE
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Oct 2020 14:29:59 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 19so112703pge.12
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Oct 2020 14:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PQN53A18HEXIMSVQwDL2aUEOOt7VTSrd4q0az2vgKqk=;
        b=PHmwyly0+5d4FWC0bA3HjtsaVHVqSTb8xeTts8Y2cH76mtjKsKSJfSlaXgakyPf2Ki
         0F0zQ4lE+/bYMMHZcTEGvc7Wdgse53dDN/N8e7+2QwriVMes6Ppa4LLqjTEfiuuls4Al
         3emCfFvBV6mPCjRTbFuvO/YBjpvwjJFnh93GYgbCJJ8XmhqkXHAHzKuKr3A5htoVnQSZ
         j5khcndwlhqjHVIPnp0ZuS2g2gg9jVmXt+677pSnApHpWHQ+W24GujZO2w+/vxaYu9VK
         3hRsA2m4IZjsVEXcMmjYuqCdYqqN1LSpr/sLcAQexBjDwCwHcntXB8fucQl4FRXOdwc8
         PPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PQN53A18HEXIMSVQwDL2aUEOOt7VTSrd4q0az2vgKqk=;
        b=lDd8/Pk0IyE1Zq21tx1gvmcfmW5ZDErXmibLFcNyf1XLIWyh33BpUcE6D0w5L7OojS
         3j3ki6eOoIIxr65jjZGLneXzdmndyGiL2/9t7jVkaa/JfP4WOs4lUotJDLm+fO1ZOTta
         YPGSWYBTisFcbEI6XEAn8deyGyeVbV9hFWbkPYV98QuDzTJ4N2UmFCV2qHYauMtvkjkM
         UtBApNIzHNyI/eeP6HhjvEJInCVRRsogIZlrClzIwgSXsWIboWVAPmMJPGCBiVOWU+pc
         CETeVCJGglB91amSF6Sm57N85Qby5DPclAn4R8DDb5NayvjXV3oiA0Ud5b43GGZyfDXI
         42fA==
X-Gm-Message-State: AOAM531YppgJQvbgu6BGyyMmC3wRtL8nV9/d+Nog3/Eh1icWnkaNi9Te
        0FS5eu0pbgt0WcoQuDnp+g1puipEtP/dJKSlkuMI8vYtpPOYCA==
X-Google-Smtp-Source: ABdhPJzl89C7MyRECCBI4cc0euzO33kttVMcLKzPM1buXxlPXtZ5PmhrbjNgKFMDBR1UZbGacKCBWehwSTUK+WLBEhA=
X-Received: by 2002:a62:3782:0:b029:15d:2c3e:ca14 with SMTP id
 e124-20020a6237820000b029015d2c3eca14mr77436pfa.38.1603229398388; Tue, 20 Oct
 2020 14:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <20201015162817.86901-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20201015162817.86901-1-andriy.shevchenko@linux.intel.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 20 Oct 2020 14:29:47 -0700
Message-ID: <CAFd5g45zpu8+Pb82-ZcYRs5CTouaZaom4w0wKUYiDSCm2qGgWg@mail.gmail.com>
Subject: Re: [PATCH v1] kunit: Don't fail test suites if one of them is empty
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 15, 2020 at 9:28 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Empty test suite is okay test suite.
>
> Don't fail the rest of the test suites if one of them is empty.
>
> Fixes: 6ebf5866f2e8 ("kunit: tool: add Python wrappers for running KUnit tests")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Nice catch! Thanks!

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>
