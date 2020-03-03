Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A912017717B
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Mar 2020 09:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbgCCIpv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Mar 2020 03:45:51 -0500
Received: from mail-qk1-f171.google.com ([209.85.222.171]:46192 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgCCIpv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Mar 2020 03:45:51 -0500
Received: by mail-qk1-f171.google.com with SMTP id u124so2543656qkh.13
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Mar 2020 00:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OH4rbnHjGbdeSp/ARdwMPE6vcoSpZAJa8ZMuVz+DiW0=;
        b=e330jM1WfYTvxlSRgPZq2bJYPXRpQn0/ChL8vrkJ6qFrl3dNZoY2So8rXWCKFf+AFb
         A8HpSIkMmIgDlZaC2xvGq1dwX+233K6PKbucHs4qWBsAdaKqVF9XviZcascbpHQfgvRy
         AvKhsrGEMXGlsCyC2ZYdoOldd8A/+YDBJsd+tMJf4MhdaBu9nCasSxqUNkKQUY4oa7mp
         snbxjnUmK9m7fsihScQpSGjqFqXS6e4J3R0c2/tzc3rmbqXKrbLtyRcOQ2QU6L3goE8C
         93UMXkaz0wCvH17sdSbmwg8m2CeqS8SOyuVLqJavrlb4ul96DBj0CRNY9iZUvwKExBT+
         0Y/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OH4rbnHjGbdeSp/ARdwMPE6vcoSpZAJa8ZMuVz+DiW0=;
        b=eWtZ5JbmFE7fqVa3U3rF/coosr8pd9Fwk72MsBidUlaIBORVmaDgjTmh/UZr6ioKC1
         JgQCy3p0nQki2/U+xbjmixepwbBcwSGJI8Zst/MuCBiInOMvIUcloWJrnIzhn76UAxzj
         HHu850KbmDZYA7oIzOol9TaV1K4elDCx+0cwcjXc/6vvcwWjTOXWGgku6MVvd8lJrI2j
         gQAheAO/NJ7h11qTuWWedUTgcg9kkG117zPUP63cGP0FE89HINL69MtJxIqC9ostSiWB
         yqKiLf9uRZgeqOjVnh1yALKYJys4UJkIRDD0VFBLLnJVd21cgwkKRWxm8nkdpQri9lia
         YcXg==
X-Gm-Message-State: ANhLgQ1CVw0vjGrMcSuQeitMT0MSZSZP+lJ6BZh3fISt5kL1kRi1fAqB
        MdS3jXrtMsRWevly3wnlcCUGM3+qdU4LNFQTvLGUqg==
X-Google-Smtp-Source: ADFU+vuB14gKDmC4hNvE8A4dYbuZm3IniRZjTAmwxtRpSxrbDY1pC0/3TwsqoNBzGv2bnqhudf3Ld52vC+BVm0igawo=
X-Received: by 2002:a05:620a:79a:: with SMTP id 26mr3042058qka.43.1583225150278;
 Tue, 03 Mar 2020 00:45:50 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+YjOxmOzzPt_xaYE44QNZfq9haNfbnVBrTnPXe7zuSEfA@mail.gmail.com>
 <CACT4Y+ZaN900gwx=PHS10hrKofZib7HA7JFxE_DkwChyttYW+A@mail.gmail.com>
 <876a2abe-41ab-5819-4ae8-ad26186d0d1c@kernel.org> <226099bc-9763-3a73-e26a-b292f601494c@kernel.org>
 <20191011180248.GA24089@rei.lan> <b715f3d7-547f-9a43-dc41-2e46ec3bfd51@kernel.org>
 <20191014085414.GB31760@rei.lan> <CACT4Y+aKbgT=i8C5aZvp8ZV52PamGm=GdnR6kQecczLQOQSGqA@mail.gmail.com>
 <62903a33-8ffc-56b6-de1a-539f10b5de2a@oracle.com> <86bde120-e5fe-4bb1-9b93-769a444500f9@oracle.com>
 <e8b11b09-37ac-6ae2-0908-b803b4160f7c@oracle.com> <CACT4Y+bShy-3vO3ifNKVcGGNf3X9XA7zL-Ja9-T+gZv5=QNe4w@mail.gmail.com>
 <8a4dbbb1-f8ba-00ba-41d2-d82a35fc0f81@oracle.com>
In-Reply-To: <8a4dbbb1-f8ba-00ba-41d2-d82a35fc0f81@oracle.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 3 Mar 2020 09:45:38 +0100
Message-ID: <CACT4Y+aZ=rBZXdnrU0D-21QqSK0G3vqHU+iD=k0PhGgo3TL6rA@mail.gmail.com>
Subject: Re: [Automated-testing] syzkaller reproducers
To:     George Kennedy <george.kennedy@oracle.com>,
        shuah <shuah@kernel.org>
Cc:     Cyril Hrubis <chrubis@suse.cz>,
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

Shauh,

We've added more reproducers to:
https://github.com/dvyukov/syzkaller-repros/tree/master/linux

It makes sense to pull in them to the kernel-arts repo. Not sure
what's the most convenient way for you since it's not exactly a
traditional "patch"? Perhaps you just copy linux/*.c files and commit?

George, another throw in of 446 repros ;)



On Mon, Jan 27, 2020 at 6:08 PM George Kennedy
<george.kennedy@oracle.com> wrote:
> > Hi George,
> >
> > This was still starred in my inbox, but I never got to actually do
> > anything with it. Thanks for pinging me. I thought that the script to
> > extract the repros won't work for some reason and that I will need to
> > fix it first. But turns out it's still working as-is (I wanted to
> > submit some changes that would break it, but I never go to that as
> > well. Good! :)).
> >
> > So here is a new drop in with 692 repros:
> > https://github.com/dvyukov/syzkaller-repros/commit/6a06992209c328a3115c89c020f45b844b103573
> > Enjoy!
> >
> > Yes, we have separate managers for each version, the entries in the
> > Instances table correspond to syz-manager one-to-one:
> > https://syzkaller.appspot.com/upstream
> > https://syzkaller.appspot.com/linux-4.19
> > https://syzkaller.appspot.com/android-54
>
> Thank you Dmitry!
> George
> >
> >
> >
> > On Mon, Jan 27, 2020 at 3:20 PM George Kennedy
> > <george.kennedy@oracle.com> wrote:
> >> Hi Dmitry,
> >>
> >> Re-sending this request.
> >>
> >> Also, how do you track the Upstream branches with Syzkaller? Do you have
> >> a version of Syzkaller for each (i.e. 4.14, 4.19, etc)?
> >>
> >> Thank you,
> >> George
> >>
> >> On 12/6/2019 3:06 PM, George Kennedy wrote:
> >>> Hello Dmitry,
> >>>
> >>> Could we get another drop of the Syzkaller C reproducers?
> >>>
> >>> Wonder if we could get the drop periodically (i.e. a drop/quarter or a
> >>> drop to match a major linux release)?
> >>>
> >>> Thank you,
> >>> George
>
