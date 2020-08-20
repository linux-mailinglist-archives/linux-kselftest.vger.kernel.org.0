Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444B224C681
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Aug 2020 22:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgHTUDA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Aug 2020 16:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgHTUC5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Aug 2020 16:02:57 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D948C061385
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Aug 2020 13:02:57 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id u6so1803310ybf.1
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Aug 2020 13:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pKzOsx3lB8pzuOnpghHkzifipDVHUez5Ep3w+VChvf0=;
        b=iV5dB/t3SeBM+FwAbkWuzlVj7dB/3sx6clIP6cToxRAKGcIsGtW43y7PIOaTMuPXOb
         xRI8hv+9CZJ1X5Z2rRl94DLH3a/Ls8H6OX1cjHiy3lOIrqI4LThU43BR8aDebN82Z/Ol
         eTEded8ta1Rq53oy8ny+wdVIS6YIqmJWFXFjfy7mmIdyy7vagX7XpsAEAgUz46sQThTv
         D3gjB1/GosxtfNunimcT9BPagecNLl004x0DAUeY5dBeYfW6zCieS0S0GslqBSY/Us1m
         FoFnE4IQIX9qcWbekRlyAkngQnj8V6qaV+AfXL4JCxY0ywsiQWEPqXLSMQTIG3v55ezo
         nTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pKzOsx3lB8pzuOnpghHkzifipDVHUez5Ep3w+VChvf0=;
        b=W3KIQvdX3JZmCWMV/nz7qQyQUYawDornPKLkwviCNDkmRrcNmX9Hotf7iSeU/qNtYc
         6gx36rLCS7xs/jFXM+c6GQiu+almS/wKCpsPob79nRQ8RfoBrcMzJdNII/9SeIjUfj3k
         Gs9i8eJlyKgdr22TbPuozBM7x/Heme/kknfIF85/RjMKBD8qfajrlZgyoxkr+NKQJFU9
         lyvu01WfXHrLDztdVYZdtupkFOqAHnGxGxXFC6seTrAGHwHH/QVEjaDBwml/sbh4BcBH
         DrMHkh9eRUt5ltkKva7uXNX1h3Sk+q5ySC4Rh6dde04usaO8OfHoXzklo1x4u1OTDxfy
         MiZw==
X-Gm-Message-State: AOAM530V1Q0nMgjV+yHH1XxeNnztlFx9Hk4TJrRM64QCvb2TN2Za+c0J
        t3pfYMhXn6AKd7hw3krm2Zqu6K9kR0eFtllXynxwNQ==
X-Google-Smtp-Source: ABdhPJxiVxLbcB0tn2f/pg5YuwsWHw31MGw6sjXeQSIBYBTKIYOVjOLw2jEetHYAwMcfXDPX8GrHs38hjbuuVhldjD4=
X-Received: by 2002:a5b:c44:: with SMTP id d4mr6648410ybr.488.1597953775217;
 Thu, 20 Aug 2020 13:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200819193917.67409-1-vitor@massaru.org> <CAFd5g45_6mA7c4Bu9jSigEzeGqQgLz=o5v6VrSM7Qx39c_WDFQ@mail.gmail.com>
In-Reply-To: <CAFd5g45_6mA7c4Bu9jSigEzeGqQgLz=o5v6VrSM7Qx39c_WDFQ@mail.gmail.com>
From:   Vitor Massaru Iha <vitor@massaru.org>
Date:   Thu, 20 Aug 2020 17:02:19 -0300
Message-ID: <CADQ6JjVDvfUaT-rZ2PVYgKpyBZfOm7UmyfaY=btZAmfHXLBjBA@mail.gmail.com>
Subject: Re: [PATCH] kunit: Customize KUNIT_EXCEPT/KUNIT_ASSERT Expected messages
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 19, 2020 at 7:24 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Wed, Aug 19, 2020 at 12:39 PM Vitor Massaru Iha <vitor@massaru.org> wrote:
> >
> > In some cases, to maintain the consistency of the Expected messages
> > with the original runtime test, it is necessary to customize the
> > Expected messages on KUnit.
> >
> > As an example test_overflow conversion to KUnit (I added 1,
> > p->s_of+1, just to fail the test).
> >
> > Using KUNIT_EXPECT_EQ:
> >
> > Expected _of == p->s_of+1, but
> >   _of == 0
> >   p->s_of+1 == 1
> > not ok 1 - overflow_calculation_test
> > ok 2 - overflow_shift_test
> >
> > Using KUNIT_EXPECT_EQ_CUSTOM_MSG:
> >
> > Expected 0 + 0 to not overflow (type u8)
> > not ok 1 - overflow_calculation_test
> >
> > Which is more similar to the error message of the original test.
> >
> > Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
>
> All in all this looks pretty reasonable to me; however, is there any
> chance you could provide an example of its usage?

Sure I'll do that.

I am reviewing the errors reported by 0day in the overflow_kunit patch v3,
and I noticed when compiling overflow_kunit with the parameters of
0day and this patch, there were some errors related to this patch that I sent.

I'll fix it too.
