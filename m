Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00833234C87
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jul 2020 22:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgGaUxr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 31 Jul 2020 16:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbgGaUxq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 31 Jul 2020 16:53:46 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7025C06174A
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Jul 2020 13:53:46 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id r11so7141805pfl.11
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Jul 2020 13:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ASoX6rfz5bQ5FIRAlZmP6CuXAEI7tVxg2VHGvZXSf5k=;
        b=UZSCRrsNvb7U/6sNOg0nmvM1lhYADZr3xElqLrwf1FAjVXCKUcYXAIB3qluyiUZIIg
         s7Oq8+0gDmPXofchwzcv+GI6UllQAsKwyidQTh4v8czpYX2AUJdfxfRiODZQc/e25ejQ
         4xkCeSRR30UicbY7lFNufWjGwYcHhIMy9yOwjC08T0y9wWFOQaWiAPEVeC1DBxSGRrTm
         w4GiRFgXHOZATK+L7tbeqedgQNwoVvhpwp9oWpewbKI4GPB/NS3sCurlzLHWLrMQ+72B
         3IJyUAei30wFb/kjH1F2VtiY/FNEusyd293eHctGgBsM5yuvoG66Ry1nP3iXobG/XcmW
         Fr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ASoX6rfz5bQ5FIRAlZmP6CuXAEI7tVxg2VHGvZXSf5k=;
        b=YKi/7rgVs7tBgUY3rtNw0T7Uq+0mNiRBg7Pv1RHVO1L/TuEbnAy/yRYBhxkUdSDCwE
         QDpsei5t7cXFcMqwnRNE59R2VoNDm1bW5aUtlc2dEHJx54iIsRzPX1N4/X+WX6248njb
         FEezCWBTvkSqRp5FOgf5NtkERX9mZ46pshBEpPZ7F3IucZLEG2YPcWkjWsBbsdd1/mQM
         IGIeRVXkmplJjBImkhYXDno2lH2dLFG+DzHnhYB19CfrUHzrTwI45LZBqebCDgsJJrHH
         zpkL7m0lbq51S5kb7sH4nJGZ9cxv//PnDVVZQ6rXeT0s0NYdWVfoPXeLZrNYDzI2Py5R
         4l7g==
X-Gm-Message-State: AOAM532JaZKwbi3UDPPjA5cSiSghYq2CUEZmCcyLWft/WEDTVcfkKLIa
        GDPUnVNc8Ds7NkXEYwigsgbVD+zRO/Mv/mY10UzQuQ==
X-Google-Smtp-Source: ABdhPJyGqtQD45YZn7SMj9UvX8QA2GrLrcjRcPgtKJyDQA1M9yb7pFOzWaaAvNB0t6w5NBwOk1uD61A2Sph/u4r9BdI=
X-Received: by 2002:a62:6484:: with SMTP id y126mr5561234pfb.166.1596228825718;
 Fri, 31 Jul 2020 13:53:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200730121656.45302-1-98.arpi@gmail.com> <CAFd5g46wpYxF1=bs3LvXeVg6mPHrT6Ggp=QxScaf87O=yqcpBA@mail.gmail.com>
 <3aae0ade-1a61-5d28-94ee-6b0eee7c7be6@gmail.com>
In-Reply-To: <3aae0ade-1a61-5d28-94ee-6b0eee7c7be6@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 31 Jul 2020 13:53:34 -0700
Message-ID: <CAFd5g46OBRKFbTAPgq63A5pTaL88D83NjuTP9vK_qwPFxBNBSg@mail.gmail.com>
Subject: Re: [PATCH] lib: Convert test_uuid.c to KUnit
To:     Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 31, 2020 at 3:02 AM Arpitha Raghunandan <98.arpi@gmail.com> wrote:
>
> On 31/07/20 11:20 am, Brendan Higgins wrote:
> > On Thu, Jul 30, 2020 at 5:18 AM Arpitha Raghunandan <98.arpi@gmail.com> wrote:
> >>
> >> Converts test lib/test_uuid.c to KUnit
> >
> > Can you add some more detail to the commit message? Maybe link to
> > KUnit and say something about why this change is beneficial.
> >
> Sure, I will make this change.
> >> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
> >
> > Change mostly looks good to me.
> > Thank you for the review.
>
> On failure, the original test calls another function which prints a detailed error. I removed it when converting to KUnit. Is this required?

I think that's probably Andy's call. Do you mind calling out the
segment of code in question?
