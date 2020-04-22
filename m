Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1331B42C4
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Apr 2020 13:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgDVLFx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Apr 2020 07:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgDVLFw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Apr 2020 07:05:52 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBD2C03C1A8
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Apr 2020 04:05:52 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id e20so1618213otk.12
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Apr 2020 04:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5ua829JJkYBZUaS7OvERcUI6nSagxxxKkmMkhojcO/w=;
        b=dECYwC87TGzR0PPYXGM4EoY/ahwVrWMHIcNp4S24KkPjixaFvhz85M3MQzFjQ4/zsJ
         rCKJEJKdVPld8GIqAJu5Hk023HPbBYugaOcvd5NHFIvMwVIi4lLGDn1prBJusUXfeh/k
         96K8Lyfup1w7v7OOHoACpRPNQaZs+w9ZxrWIGQTce6MR0qvLCvcrlByWIp5Xo9r4AiZB
         R/FsqoDqjQB9NntpPixHFVdBc+IxLz4Ad8Iu2bGL++oh0Ck27PlFAKoP2wX3k5A34Pvk
         hcxSYF8fAqT8mCQJiodnCaQzfn8T4gilCVJ/xmTSrWsxwu5JzLI8SSQBYCgnxRvkwI05
         OUdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5ua829JJkYBZUaS7OvERcUI6nSagxxxKkmMkhojcO/w=;
        b=VCSnpcOD+AQcBnC9ZMeMcnywJ6eIe7hiuRGSUMUKXZrHD9UvP823rSchC5AJB/fMwF
         L58lAuJkJDTekDkIfgxWCk0T4siYCGnae4/1EmqRz2p/fUKTl9QdF63DCIXZTYRFeM8+
         H04SSGlQ6u1u7/D6ppljc4UPfOro3kyplkoqBtplQ/e40bqnXfuiE8DgbJoxCfLBq45X
         KZNnpSkTNOLI1PNN8gVTyJc2yEqdzKycqSDcstyhMrdaIQiH3/nbmn4Ks6Cus1T2wj5/
         uuE4YmzIYXDJScm5Y6UNgkywJ8pQsQyT+sguUBVMU1Is5PpPvCdyRCSfWwjCBIDRAKuV
         2mZA==
X-Gm-Message-State: AGi0PubjIHkGBnfbKYTlyy1cmePTlv7VNbxt0/zhS51CDuPq2ETqagWR
        8TKvHE/Hfl5GsYxt4x0vH4uT6H5VpLcNoPiHTlXbfRir
X-Google-Smtp-Source: APiQypKqDQFlwlVMNU/xBAKxK9coMX73yES94AnayN5DUQJdaeHSzK+8UbzFgxFMv1bYxzq/04dqTJkLMaFLEOdKrAA=
X-Received: by 2002:a9d:412:: with SMTP id 18mr17906271otc.233.1587553551366;
 Wed, 22 Apr 2020 04:05:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200416114256.226329-1-elver@google.com> <alpine.LRH.2.21.2004171103160.32364@localhost>
In-Reply-To: <alpine.LRH.2.21.2004171103160.32364@localhost>
From:   Marco Elver <elver@google.com>
Date:   Wed, 22 Apr 2020 13:05:39 +0200
Message-ID: <CANpmjNNsSX+C1oXezj+WuW-DQpGJ2ETvqH6n6XryVwmKB0phxw@mail.gmail.com>
Subject: Re: [PATCH] kunit: Add missing newline in summary message
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        frank.rowand@sony.com, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 17 Apr 2020 at 12:03, Alan Maguire <alan.maguire@oracle.com> wrote:
>
> On Thu, 16 Apr 2020, Marco Elver wrote:
>
> > Add missing newline, as otherwise flushing of the final summary message
> > to the console log can be delayed.
> >
> > Fixes: e2219db280e3 ("kunit: add debugfs /sys/kernel/debug/kunit/<suite>/results display")
> > Signed-off-by: Marco Elver <elver@google.com>
>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
>
> Thanks for finding/fixing this!
>
> Alan
>
> > ---
> >  lib/kunit/test.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)

Which tree will pick this up? I cannot yet see this in -next.

Thanks,
-- Marco


> > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > index 7a6430a7fca0..ccb2ffad8dcf 100644
> > --- a/lib/kunit/test.c
> > +++ b/lib/kunit/test.c
> > @@ -93,7 +93,7 @@ static void kunit_print_ok_not_ok(void *test_or_suite,
> >        * representation.
> >        */
> >       if (suite)
> > -             pr_info("%s %zd - %s",
> > +             pr_info("%s %zd - %s\n",
> >                       kunit_status_to_string(is_ok),
> >                       test_number, description);
> >       else
> > --
> > 2.26.1.301.g55bc3eb7cb9-goog
> >
> >
