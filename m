Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7F52DEE09
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Dec 2020 10:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgLSJmk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 19 Dec 2020 04:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbgLSJmk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 19 Dec 2020 04:42:40 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0F0C061282
        for <linux-kselftest@vger.kernel.org>; Sat, 19 Dec 2020 01:41:59 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id z3so3195845qtw.9
        for <linux-kselftest@vger.kernel.org>; Sat, 19 Dec 2020 01:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jKNJRmx0eYAUpZpwCq5ZV9sDDOhriznJbXCWXkD9bEo=;
        b=P5yYUtVR6rdJTBAzxze64I+pP1/TkTJKW9DPb0BLE+FKPx/D2v58xhqnyxjp9wf+nX
         YOsuojepOAhUHQorncAuc7x+GEFTOqHsQkRoggcETESTLj8nCBbrZB78HwRi/Lb9oo3Z
         Nkf2KPRmsvnJv5VC4rloVWAAX4Gd87FSiX7j7TISJ2tMgtLzGvEDsvIX/O+G5hKf8DpG
         rlBDS9rzg8YxTl8UX4d7KdFDQHa7NaPUqSPUhLBLIpSRAmZyXdcYkZUyRz/Flqvdqnz+
         q9XeWXxgZIf+d6blm0egJnQeH8bDQwBwpAlbLZZzm38v0H/81ujYtNclWps8Mwqq0U6W
         etNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jKNJRmx0eYAUpZpwCq5ZV9sDDOhriznJbXCWXkD9bEo=;
        b=Z9bYwPH5IRRVz9yeUp6DJ16og5/lldNsVozrsP8hDYmwJN4qWqKDp6hEgI8KT3jAHl
         8M7w9mGHEFXlRpg5FPkH/oThjb1PJY13G5JYoqgj0kAGFTNY5oL/6nkbAWDDt4wiQylg
         Ixm6+enzrzHtadHZuD9QwnPxOUVkaubYIjeTHqUsM0/rlHOD41m1ydsU+KSYLzrm635S
         JrotYUEomM44iDn/f5dVc9D+3VuohML9axX7lygTlEq/JvzkwOshA4it5sI4vhLSAFAf
         +DCm2N+++DIZ/ZT5fXwp2qBai1eV+3FtPocGHBbjfgzl7BXLmDChyw7x9vdse22gTPXY
         0fqg==
X-Gm-Message-State: AOAM5319EpCC8HvwGUUW4nrUsdGDZobOGVSKP5jKxX/P3tSsRyhShVpX
        5ausD3NBp2qh9ecFjM7fLAIWr/HczH8FoqfzVZXIrw==
X-Google-Smtp-Source: ABdhPJyeTNXDinqht80iLQ/jsytyx9IA/MtM78gFuYdt2jUWCeXu1VsZqbeDy9OJTs6GESOiOdQzvK7OWzUI2E+Y/OA=
X-Received: by 2002:aed:208f:: with SMTP id 15mr7786546qtb.290.1608370918325;
 Sat, 19 Dec 2020 01:41:58 -0800 (PST)
MIME-Version: 1.0
References: <000000000000f415bd05a047548f@google.com> <0000000000001e7f4605b6c84833@google.com>
In-Reply-To: <0000000000001e7f4605b6c84833@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 19 Dec 2020 10:41:46 +0100
Message-ID: <CACT4Y+bqBib4Sb=5keBayTybKXpi3kXgF7+uAsnZjBGfpHr04g@mail.gmail.com>
Subject: Re: kernel BUG at drivers/dma-buf/dma-buf.c:LINE!
To:     syzbot <syzbot+d6734079f30f7fc39021@syzkaller.appspotmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        christian.koenig@amd.com, Christian Brauner <christian@brauner.io>,
        Colin King <colin.king@canonical.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hridya Valsaraju <hridya@google.com>, jbwyatt4@gmail.com,
        Joel Fernandes <joel@joelfernandes.org>,
        linaro-mm-sig-owner@lists.linaro.org,
        linaro-mm-sig@lists.linaro.org,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-media@vger.kernel.org,
        m.szyprowski@samsung.com, Martijn Coenen <maco@android.com>,
        masahiroy@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Suren Baghdasaryan <surenb@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Todd Kjos <tkjos@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Dec 19, 2020 at 3:50 AM syzbot
<syzbot+d6734079f30f7fc39021@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit e722a295cf493388dae474745d30e91e1a2ec549
> Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Date:   Thu Aug 27 12:36:27 2020 +0000
>
>     staging: ion: remove from the tree
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17d4f137500000
> start commit:   abb3438d Merge tag 'm68knommu-for-v5.9-rc3' of git://git.k..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=978db74cb30aa994
> dashboard link: https://syzkaller.appspot.com/bug?extid=d6734079f30f7fc39021
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17428596900000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: staging: ion: remove from the tree
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

The reproducer opens /dev/ion

#syz fix: staging: ion: remove from the tree
