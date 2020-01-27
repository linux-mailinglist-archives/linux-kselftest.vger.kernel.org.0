Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2437B14A72D
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2020 16:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbgA0P04 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Jan 2020 10:26:56 -0500
Received: from mail-qt1-f170.google.com ([209.85.160.170]:39117 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729146AbgA0P04 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Jan 2020 10:26:56 -0500
Received: by mail-qt1-f170.google.com with SMTP id e5so7640488qtm.6
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Jan 2020 07:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z9p1qi1i0v8biakrNGHXKDGzx+YbJBDVxIKmZtnkXoM=;
        b=WCVC7MCmIhSEep6ULkRMqsMa1GtRWthKfO8i09zB2j6eiMqdYEJQ6JDhvqVbz8MvHs
         euUVXGzrYhzqK2mtSB+3TrrnoG77ZemAtoqR+JJIziUzLgKOBYyzbfNoN6NSRF38Eh5E
         NbbySwARzRwzHgoIbCtCp46zJpbP1wlpPtALJduajM4X6+5AyNiJNRqPfsE09MvvOPMR
         4wM7gXebzVbznwogrFAdOpU/2wyQdzYzDobfdzdpvlzLjlaLhZ2Jasr7Zq/V7W6J2lNX
         P5hf35aDGHSDBANpU3YzwK2e9W3Q4sH5MgRSQ44aAFbCNM73SMgT8DBYNl3/G1nTG5db
         m2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z9p1qi1i0v8biakrNGHXKDGzx+YbJBDVxIKmZtnkXoM=;
        b=KaA6DWpJh84GrT98ggue2Kgs+FEnLmMlJ6d5AOexBbez1cEYQmlBYnitFnkCC3J0NE
         tQ+ivMlLlwnsFBLP3Ogd39S5JYOI1O4fiY8zi4qh+7ED4WDCvIniRzhZEzRr1TJWnj7P
         TaCMNR9YNHYF0sSY9bZb27zhDR4Y9dKvQlYMH4ehPTgEqGWdbBKiKbBUzJhb1ZCUg6DF
         PAHktezBWvQW/FEo4Dmxtc6OhqsqPFbAFOWVfxTGrtwCH4Y0Kdayw6XoWTphN95sJg6K
         4Pai+CNNED/ziaOUvwGfPnPvik0X1zSACRKMioxJAzJeMfKp9YHjcXJs0kKTYKWD23M5
         JoZg==
X-Gm-Message-State: APjAAAUsMV8Me862pCQTnNCh7TaWQfG5tOqeqyVCZ2K+qs9wzfVkMUmN
        HRo82d0B1Fdm9tfgkuPdzeRp2wjfAdsoBRPlxlRWDw==
X-Google-Smtp-Source: APXvYqxa2HxvNQurhDo3aHHjycZl/xwN3Vsfq99Rc2Zmv7N+jn9VoxAzfMNiUg+l7uuzU1iBJ2C6kuwjHNbJZc4b7jU=
X-Received: by 2002:ac8:71d7:: with SMTP id i23mr16488532qtp.50.1580138814604;
 Mon, 27 Jan 2020 07:26:54 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+YjOxmOzzPt_xaYE44QNZfq9haNfbnVBrTnPXe7zuSEfA@mail.gmail.com>
 <CACT4Y+ZaN900gwx=PHS10hrKofZib7HA7JFxE_DkwChyttYW+A@mail.gmail.com>
 <876a2abe-41ab-5819-4ae8-ad26186d0d1c@kernel.org> <226099bc-9763-3a73-e26a-b292f601494c@kernel.org>
 <20191011180248.GA24089@rei.lan> <b715f3d7-547f-9a43-dc41-2e46ec3bfd51@kernel.org>
 <20191014085414.GB31760@rei.lan> <CACT4Y+aKbgT=i8C5aZvp8ZV52PamGm=GdnR6kQecczLQOQSGqA@mail.gmail.com>
 <62903a33-8ffc-56b6-de1a-539f10b5de2a@oracle.com> <86bde120-e5fe-4bb1-9b93-769a444500f9@oracle.com>
 <e8b11b09-37ac-6ae2-0908-b803b4160f7c@oracle.com>
In-Reply-To: <e8b11b09-37ac-6ae2-0908-b803b4160f7c@oracle.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 27 Jan 2020 16:26:42 +0100
Message-ID: <CACT4Y+bShy-3vO3ifNKVcGGNf3X9XA7zL-Ja9-T+gZv5=QNe4w@mail.gmail.com>
Subject: Re: [Automated-testing] syzkaller reproducers
To:     George Kennedy <george.kennedy@oracle.com>
Cc:     Cyril Hrubis <chrubis@suse.cz>, shuah <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        automated-testing@yoctoproject.org, kernelci@groups.io,
        Dhaval Giani <dhaval.giani@gmail.com>,
        Jan Setje-Eilers <jan.setjeeilers@oracle.com>,
        syzkaller <syzkaller@googlegroups.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi George,

This was still starred in my inbox, but I never got to actually do
anything with it. Thanks for pinging me. I thought that the script to
extract the repros won't work for some reason and that I will need to
fix it first. But turns out it's still working as-is (I wanted to
submit some changes that would break it, but I never go to that as
well. Good! :)).

So here is a new drop in with 692 repros:
https://github.com/dvyukov/syzkaller-repros/commit/6a06992209c328a3115c89c020f45b844b103573
Enjoy!

Yes, we have separate managers for each version, the entries in the
Instances table correspond to syz-manager one-to-one:
https://syzkaller.appspot.com/upstream
https://syzkaller.appspot.com/linux-4.19
https://syzkaller.appspot.com/android-54



On Mon, Jan 27, 2020 at 3:20 PM George Kennedy
<george.kennedy@oracle.com> wrote:
>
> Hi Dmitry,
>
> Re-sending this request.
>
> Also, how do you track the Upstream branches with Syzkaller? Do you have
> a version of Syzkaller for each (i.e. 4.14, 4.19, etc)?
>
> Thank you,
> George
>
> On 12/6/2019 3:06 PM, George Kennedy wrote:
> > Hello Dmitry,
> >
> > Could we get another drop of the Syzkaller C reproducers?
> >
> > Wonder if we could get the drop periodically (i.e. a drop/quarter or a
> > drop to match a major linux release)?
> >
> > Thank you,
> > George
>
