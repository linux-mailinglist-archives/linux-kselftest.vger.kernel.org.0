Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F592021FB
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jun 2020 08:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbgFTGpL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 20 Jun 2020 02:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgFTGpL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 20 Jun 2020 02:45:11 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C89EC06174E
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Jun 2020 23:45:09 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id f185so10945686wmf.3
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Jun 2020 23:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nuqIBJcEfQ5YejHXKkH59txUGkRqecLMXyxE/1IPdkk=;
        b=t+nkAWVDInMtkOcuQjp92ZOQUc1IuMFxgyEboiybhrYvZWoh7q8LUr77tTUAeuXJMe
         Z0c2rRVzRqxJsr27Q1uuzAbLvXBm89jXnexCcqb3+uui3x2XZgl9s/suCXtMX8kIMORP
         /HaDwMnLpd3LIvu//Ci+o1/LKX+QbutwsQnO8okTCN5S+UEkUoWtApZ44xBeVawrCr0U
         jBjoYlEaJuw8beWnZgo605MuWPFluoHXQ7r7qjlo1v1J2d7RZGAkZ1AsJBwOuqx02p3k
         7gddTIo0Kvi5en3QzTINvAc5Mf8CD0ezYQUl9tdYA0RztGMaxLB+elN4/3MeQT+neeCd
         V2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nuqIBJcEfQ5YejHXKkH59txUGkRqecLMXyxE/1IPdkk=;
        b=fG1neCCjlVKQRPAYJxoqXFsQWT5rTdRWRIH13wT85XuSzh2oGtJieiMp4upOTt7A+5
         CE3fVYhc76bJKaSkOXyqZD5iRKJAMT25XuwKoz5phiurZ7d2rfGnSFoz8L+DnvsGx3tm
         CGZarmZ7UzgY8ctWQUcsgeoXEjAChSUt0Fohpj348gYJsQokT5io1TXE/e9RDQ3WIrVi
         jamuZgyuuXNNfyiF+Y7/pzL2mnxSSRWP7UGUXAGJbCUXzPZxHWNcNzZhWYbFezSfbugw
         T6YLzpVNIZx5oRj3K1e5sq4N+ZEVfeJDwYFwmpqmTeQLwbOKk7upMMsQ94TqYRjwCqDZ
         NUXQ==
X-Gm-Message-State: AOAM53303UGlig7Wspey5CvjEsa+w62XbOJj45mrgikcb6OdWXyeKZAJ
        tLigarFC26IeiyQTUTDzo9/XcHpJw54bvvVLSRyLoA==
X-Google-Smtp-Source: ABdhPJx7mIrBxGEmOgQAPKNX/fbXVDZ9o5UkxJWjrhZtIbfVJfeiUzymJy9QxNd1F8rgmFm/6coNOM/Cqq9zfVvRrUo=
X-Received: by 2002:a1c:a444:: with SMTP id n65mr6939881wme.99.1592635507940;
 Fri, 19 Jun 2020 23:45:07 -0700 (PDT)
MIME-Version: 1.0
References: <CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com>
 <202006141120.96FF8C5@keescook> <CY4PR13MB11757D57CD441C5CAEC3F257FD9C0@CY4PR13MB1175.namprd13.prod.outlook.com>
 <7161fadb-45ba-c4c0-8bbb-cb47d2dd0265@redhat.com> <dc853d83-649e-b652-819f-4766ea294d78@gmail.com>
In-Reply-To: <dc853d83-649e-b652-819f-4766ea294d78@gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 20 Jun 2020 14:44:56 +0800
Message-ID: <CABVgOS=qSMY9xP7db4-hkSt71YKyPpJuQv=fqcfzV-kCC1k9qQ@mail.gmail.com>
Subject: Re: RFC - kernel selftest result documentation (KTAP)
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        "Bird, Tim" <Tim.Bird@sony.com>, Kees Cook <keescook@chromium.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jun 20, 2020 at 1:58 AM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 2020-06-16 07:08, Paolo Bonzini wrote:
> > On 15/06/20 21:07, Bird, Tim wrote:

> >>>> Finally,
> >>>>   - Should a SKIP result be 'ok' (TAP13 spec) or 'not ok' (current kselftest practice)?
> >>>> See https://testanything.org/tap-version-13-specification.html
> >>>
> >>> Oh! I totally missed this. Uhm. I think "not ok" makes sense to me "it
> >>> did not run successfully". ... but ... Uhhh ... how do XFAIL and SKIP
> >>> relate? Neither SKIP nor XFAIL count toward failure, though, so both
> >>> should be "ok"? I guess we should change it to "ok".
> >
> > See above for XFAIL.
> >
> > I initially raised the issue with "SKIP" because I have a lot of tests
> > that depend on hardware availability---for example, a test that does not
> > run on some processor kinds (e.g. on AMD, or old Intel)---and for those
> > SKIP should be considered a success.
>
> No, SKIP should not be considered a success.  It should also not be considered
> a failure.  Please do not blur the lines between success, failure, and
> skipped.

I agree that skipped tests should be their own thing, separate from
success and failure, but the way they tend to behave tends to be
closer to a success than a failure.

I guess the important note here is that a suite of tests, some of
which are SKIPped, can be listed as having passed, so long as none of
them failed. So, the rule for "bubbling up" test results is that any
failures cause the parent to fail, the parent is marked as skipped if
_all_ subtests are skipped, and otherwise is marked as having
succeeded. (Reversing the last part: having a suite be marked as
skipped if _any_ of the subtests are skipped also makes sense, and has
its advantages, but anecdotally seems less common in other systems.)

The other really brave thing one could do to break from the TAP
specification would be to add a "skipped" value alongside "ok" and
"not ok", and get rid of the whole "SKIP" directive/comment stuff.
Possibly not worth the departure from the spec, but it would sidestep
part of the problem.


Cheers,
-- David
