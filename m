Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 027191A2AA1
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Apr 2020 22:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgDHUt6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Apr 2020 16:49:58 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38924 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728968AbgDHUt6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Apr 2020 16:49:58 -0400
Received: by mail-pf1-f196.google.com with SMTP id k15so2991581pfh.6
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Apr 2020 13:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sNpfUBGg3CA1K2vxNEj9F7bn3A/l8oh4NRcT4/IV2xg=;
        b=hVXNPZbYUMsXTc/0qBikT/XKLxdaFJrj+zwZ62r0KB8IYXfMPaKYCE1XhLGZE0UEv5
         bhB8WxLM4vFTMneHhmWPD5RhRW7gpZd/zrpO5OoDwjBi2g3fpBPCTS06rwJqO4KOaKJb
         hXAur34+mePzU+GDvgB799eHlBiC5TvFjWfxPSWGkEWGlCnDCneDnC4L8jOuMxUHIEdx
         WezgBa6EDF6pABHVPA+o/1HaPybAWHHE2QEV3pMIp1L6IhW/IlyUnLr/TuJwvKA2rKwd
         B57F9dTHDWqGMCyRNbUMw37riqbux5ZHmUklKky2Qi1l529LfRdvFjylvVNS6yDsW5rf
         v/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sNpfUBGg3CA1K2vxNEj9F7bn3A/l8oh4NRcT4/IV2xg=;
        b=lx8Ce2ipdZ5v+zq7ygYI25Jrzhm6KcNLPf5tgQVz8NxJTVljmEaUMba86cbYyp/T0E
         VempiCieBvxCRYsjpWPUgF/31ztCEB7eXDim0SwCvWpOHP/ZXh8XJMwr2HDbidfAXoGT
         pLotLCTe+22G0oYnuf0E2JL4/WmfY8vzzX+Iqsmc5d9iUNatYrCWi8A40ciIwQUsg4ma
         E8iWiqn+oUyy8aR+7TvJrfDOf+gqKbXGl2rqN7NFAKLPzFS1nrYdd6dxQpwYRzIwNjww
         GeV87Dir9ZamokH/Mq4PmOs4SGqctZV6RGabKZeTa67vFx3chMwIkwjBI09ZxDWw3f5r
         dWcg==
X-Gm-Message-State: AGi0Pub9xSlYKZS8l4KCrL+tPBKa7HRqnX5d4likQykqeaO2tMMU7mPK
        108i2rfOJwrWBkQmwLU8o2E8DNA2DvbDtYH8tYbdHQ==
X-Google-Smtp-Source: APiQypKxLzdSpSrJ7kYtCrVRBGLXn1N8B0A9lka+Em4qhOW2hYd/cRagdFrv4Q6TVtsdULmaIPx7Up9zvGgVUcj2Y6k=
X-Received: by 2002:aa7:9a5d:: with SMTP id x29mr9087916pfj.284.1586378996829;
 Wed, 08 Apr 2020 13:49:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200406214130.21224-1-l.rubusch@gmail.com> <CAFd5g448Qz0bGkNCPR+zS-gH-T9A64L1tExgKb_-jQO3bysGOA@mail.gmail.com>
 <CAFXKEHYvE5N4go9KvBbMOaCWTT3vsb8M-G1JXTeKNsYBP0R1bg@mail.gmail.com>
 <CAFd5g44L7Ho1zc8cunfC_T-OGgdkTMngX8LW_Jt83WRKL2M5QA@mail.gmail.com> <CAFXKEHYXvL2kw3YnsBrpcVmGvobbHpo+vGMFDwsmbvDVr4exAA@mail.gmail.com>
In-Reply-To: <CAFXKEHYXvL2kw3YnsBrpcVmGvobbHpo+vGMFDwsmbvDVr4exAA@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 8 Apr 2020 13:49:45 -0700
Message-ID: <CAFd5g47i2wGY=63z=pPZUbG70Xt+=gcAn-OBKumfrn-gqCd5YA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: test.h - fix warnings
To:     Lothar Rubusch <l.rubusch@gmail.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Apr 8, 2020 at 1:39 PM Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> Hello,
>
> (...)
> > > > > @@ -232,7 +232,7 @@ void __kunit_test_suites_exit(struct kunit_suite **suites);
> > > > >   * kunit_test_suites() - used to register one or more &struct kunit_suite
> > > > >   *                      with KUnit.
> > > > >   *
> > > > > - * @suites: a statically allocated list of &struct kunit_suite.
> > > > > + * suites - a statically allocated list of &struct kunit_suite.
> > > >
> > > > So, I am pretty sure you can name the variadic arguments and then that
> > > > gives you a valid parameter to use with kernel doc. Can you try that
> > > > out?
> > > >
> > > You mean the warning "Excess function parameter 'suites' description
> > > in 'kunit_test_suites'"?
> >
> > Yep, I just tried it out locally and it should work.
>
> Something like '@...:' should be possible, to list the variadic under
> "Parameters", and display the corresponding description.

That'll probably work, or you can change the `...` to something like
`suites_param...` and change the corresponding `__VA_ARGS__` to
`suites_param`. Either way works for me.

> For curiosity I went through the kunit docs and fixed some formatting
> issues. Great piece of work, thanks for realizing kunit!

Thanks!

> Last but not least, going through the document, there is a chapter
> "API" consisting of a single page with one link to "API".
> Is this on purpose? I would suggest to take out this level of
> indirection and remove the .rst file, linking API directly.

Yeah, it's because we have some other features that we are planning on
adding soonish which will have their own pages.

> I'll send my proposals in a PATCH v2. Let me know then what you think
> after that.

Looking forward to them!

Cheers
