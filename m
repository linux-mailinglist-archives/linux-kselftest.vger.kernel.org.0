Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF4428F7E2
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Oct 2020 19:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731471AbgJORzD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Oct 2020 13:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgJORzC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Oct 2020 13:55:02 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24808C061755
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Oct 2020 10:55:01 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id d15so2945523ybl.10
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Oct 2020 10:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RNMeTvOaz0/h5HrgVdhcL0I723yFp6eeFhAhKe832tM=;
        b=zQJqUMJbqE10ZDoKYvabI/IVuow1p9ef3k/Xbjk1edMb/E4/ELSAWeJbhMhnNTtZr8
         rGWQSQIkzaphHykRwMilrYtSrJt+ab04A3b7kvsRVLsAi149Y7t0L+ug+dQFIbcTOufy
         WO9pvVnf/mO2fRfSuF86nj2/n2G9CAV0WCn9qXfqlZb8ZA9WgSNn4YXIjU3heXAFphIt
         baSCChawLtd6EJx5PZ600yPVOYgMet9x3eW5qqt6JQt0sCx2eGKfu9lpjUA5cPZFiFTI
         Lfo87vlafID5WJmXytXlMnHOPCdJ1k8l6wPDZVtRZ8AFtCFwenhb6mTN1QqQ9YdDncZz
         a18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RNMeTvOaz0/h5HrgVdhcL0I723yFp6eeFhAhKe832tM=;
        b=lcZlwuRe90+nPoQ1VidlFXJbGf54zMprUgKy0l4BL9KO1Jq2gUO8sVRXYyI63mo80A
         UX4Jpg1mqVC3g0IlczIHwd2S6oPLmIHl9pS6uhFB71Q9U5zSbrWji9oay/kyQ64G1+l0
         UApwsWW74il6dr64oBXnKbiAsa0FME5JzBy87VZl0lAU3QTFmvGUHX0XnHI2l2tT7mUj
         E4720LqaOrJqerNp1UDfXB7x0K0bIxDfz3nK50ul9le6CTOoIv9BK9sV/T6bCRLvDfwV
         M4rItXHPLFN/fn2YWb3+AglUXdPK5em26AVrZiQDGPkMAPIMojs/2ORV/sFufwIpwxkj
         Y2OQ==
X-Gm-Message-State: AOAM533kfhJMB93ukzKj4PiEzuEC6atsEy/aMCWxgfw6Jit50cnB1D6A
        a8xMMNSshKDTGsz9S94e4bH4+EgXgNg+xMhOB74IaA==
X-Google-Smtp-Source: ABdhPJxwp0LTMI67BFC1GnQldzIHFWKrt37t3xVhpxf9+u2vv32ZtNDxZ9ocgvw95gQ/gCNeE8r7pZNvgJvyvREPDlE=
X-Received: by 2002:a25:2311:: with SMTP id j17mr7280173ybj.362.1602784500232;
 Thu, 15 Oct 2020 10:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <20201015014616.309000-1-vitor@massaru.org> <20201015105105.GS4077@smile.fi.intel.com>
In-Reply-To: <20201015105105.GS4077@smile.fi.intel.com>
From:   Vitor Massaru Iha <vitor@massaru.org>
Date:   Thu, 15 Oct 2020 14:54:24 -0300
Message-ID: <CADQ6JjVxRGLr3-fY-Ovmq+oZHdsNbWg43RVa8-tsT-=3tKb1pA@mail.gmail.com>
Subject: Re: [PATCH v2] lib: kunit: add list_sort test conversion to KUnit
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Marco Elver <elver@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        tglx@linutronix.de, geert@linux-m68k.org,
        paul.gortmaker@windriver.com, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, arnd@arndb.de,
        elfring@users.sourceforge.net, mhocko@suse.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 15, 2020 at 7:50 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Oct 14, 2020 at 10:46:16PM -0300, Vitor Massaru Iha wrote:
> > This adds the conversion of the runtime tests of test_list_sort,
> > from `lib/test_list_sort.c` to KUnit tests.
>
> Please, provide better commit message. For example, add the output of _succeeded_
> *and* _failed_ test cases (yes, you have to break code manually to reproduce failed
> test cases) _before_ *and* _after_ the change.

Sure, I'll do it. Thanks!

> W/o above information I'm going to NAK this as I promised before.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
