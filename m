Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E508018EA73
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Mar 2020 17:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgCVQbT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 22 Mar 2020 12:31:19 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33310 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgCVQbR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 22 Mar 2020 12:31:17 -0400
Received: by mail-oi1-f194.google.com with SMTP id r7so12281682oij.0
        for <linux-kselftest@vger.kernel.org>; Sun, 22 Mar 2020 09:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4iL/vxcmuCGdmEbGF65JPTkLwm3vbSnxis9k9yz7zYU=;
        b=CFIDTDuboOmS5h57Eudf0IOM+t8BzaWRSenk2qqS+UCiQSEQDcK68Ay6EsBL7FiqJe
         cRl715GSB3yvnyV3i7HqgOBcSIwatwYdyiCTcrSl2C+rsODPDabazvC5JL3l1e671qS8
         6MfpFENsIXCidvU9Vg9++kwJWzgjmArPMkjPE0KBnaYGCDbCFBfh1RNcv63cG7m/c5gg
         lBoDc75R1GAE8xmT4mBSdXZ8FN0ZWlEGz2iPuwsBZ8V6Nuo+ocqDsCSAlIONXFZFFtPy
         jm09NEk2e+679EIXBmgrgAHwxPLuFyMUkEOgeWPnDRdeGB8Cgf/mXV69Tq2JltuO/L/7
         8pDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4iL/vxcmuCGdmEbGF65JPTkLwm3vbSnxis9k9yz7zYU=;
        b=EOU4k2GIvkUuHfvvUjAR89fv44tcdMtwAFsjFdlTof6BeqbbrJ6Pc0QSVPmoyx3/tx
         RoBpuyIJQL/lmOnDlO0H8QDcT39FGAY6AY82WAynaHkXcZhzDt5xarkAqlmslf9oUmSm
         nK6FWtF73vkWvq/uL6GFnXjNg3FQyphqEQXqzaDpCk1uO0p4NenCNh0eZkeCiuOneZAe
         0zqJUWfF4iLjLzTXLN+45bu62bNyUktmBqRpgsCEBDaK+4yTnkz3t1CJ+MoY4p/f2GcQ
         ef5rS6ue985e9o6B1moM+CmZ9tyojCE/pjMWoc0kDYFhR3QBZB9Q68SL6Mp3GW5NUaHm
         LmrQ==
X-Gm-Message-State: ANhLgQ1zrvyGWrcXPZOjH3TRmwaZhm0VZDyHO0SEATvPfNfkxCZoyNdi
        hd9LxU53DwuwpHLGrh3yebKAzEOA2zJJJR1h2VgFpb69
X-Google-Smtp-Source: ADFU+vvf96FZtlsIS//BVK2SjBJ0SPGxMqpePrWO3JlyPSAiQzURgqIuQEuzA9/RPMvltp9B0Rl8UZJfYgX3OvsxOoA=
X-Received: by 2002:aca:ed54:: with SMTP id l81mr14515219oih.69.1584894675252;
 Sun, 22 Mar 2020 09:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200322013525.1095493-1-aquini@redhat.com>
In-Reply-To: <20200322013525.1095493-1-aquini@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sun, 22 Mar 2020 09:31:04 -0700
Message-ID: <CALvZod4GjRFLRX=S_YFYnJk-kL6tjveYEDOBFS76NqrURERHHQ@mail.gmail.com>
Subject: Re: [PATCH] tools/testing/selftests/vm/mlock2-tests: fix mlock2
 false-negative errors
To:     Rafael Aquini <aquini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Mar 21, 2020 at 6:35 PM Rafael Aquini <aquini@redhat.com> wrote:
>
> Changes for commit 9c4e6b1a7027f ("mm, mlock, vmscan: no more skipping pagevecs")
> break this test expectations on the behavior of mlock syscall family immediately
> inserting the recently faulted pages into the UNEVICTABLE_LRU, when MCL_ONFAULT is
> passed to the syscall as part of its flag-set.

mlock* syscalls do not provide any guarantee that the pages will be in
unevictable LRU, only that the pages will not be paged-out. The test
is checking something very internal to the kernel and this is expected
to break.

>
> There is no functional error introduced by the aforementioned commit,
> but it opens up a time window where the recently faulted and locked pages
> might yet not be put back into the UNEVICTABLE_LRU, thus causing a
> subsequent and immediate PFN flag check for the UNEVICTABLE bit
> to trip on false-negative errors, as it happens with this test.
>
> This patch fix the false negative by forcefully resorting to a code path that
> will call a CPU pagevec drain right after the fault but before the PFN flag
> check takes place, sorting out the race that way.
>
> Fixes: 9c4e6b1a7027f ("mm, mlock, vmscan: no more skipping pagevecs")

This is fixing the actual test and not about fixing the mentioned
patch. So, this Fixes line is not needed.
