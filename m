Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D13749D7F6
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jan 2022 03:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbiA0CUq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 21:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234994AbiA0CUq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 21:20:46 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7619C06173B
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 18:20:45 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id n8so898999wmk.3
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 18:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=irIwWJy603Qxo+dhI+0ZurEBEeIfLdRgAJSY+8tlXwY=;
        b=ONgoXgiUT2wCVoWow8Kr8Bj290mv2hublYsDDNUZW3mgaXwY4u7/H0MBfLXD40mM0j
         HJordW5x+vb5g81d6q0QlQhN3/hSqC+lTQwYeCXmV8UUeAY5IjZLTCUaY4Krqwjlslg+
         j9j8Mo0EofrmhDZh3rIKhRyYjzBKQIYAwPSLlVsGQyKZFWp9KBVANU+14Xu2IS8Kn3Qd
         lFiCwqogNEYW3ISK2aI7+8k6tXoV0hqxGTpfUoNPtpJFEWeofyCdrFKT47H+1wPy2j+r
         L7rPjF7cp6DRMcd6+EOPHDpGQqpp1nqb+g3oCLAsTFibdAYtLVbPALIBoUuG/nu7rfsr
         e+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=irIwWJy603Qxo+dhI+0ZurEBEeIfLdRgAJSY+8tlXwY=;
        b=EketbSRiW/DLIFGD2WWLn7fdALgK4khdFLGX+KSo5SvtH1KHnoN6bMY+7+nRqtwNN2
         N5pR9tJgF/wafRVNqoDZhFOFe/xtP5KEQ+9d2GLyGP4Df1DPlXNZIIDTgITUusZ+6rBP
         4iFMsJ/32WocXOYew+ps8fYlH1RIb6uzAC63tSDMJA0P9KSBP3c06sPC3wzj3l2atEKC
         q3MD27Di2Sx/FFi7R3b9qSq9yORkGIr8jTr3ITO/kBm2NWLftppOTwd6obrjczMwhroc
         8UayDSgMWjo+2zVfUikpKKFn7if78SiZdSBTF1rOKqeWv4KbFa1E2CIhns0gvtJB/8Ss
         1BfQ==
X-Gm-Message-State: AOAM532bhjGWChlLeNmSZ6yZb5ujKdhujMZkbRNQ5Tno7AxOrDtDpD+I
        mWlyS9nQ6HYOurRZgaim/+i9m8uF5SkORdjghYSNoWDphBk=
X-Google-Smtp-Source: ABdhPJyEh7M6xKyAwygYkLTsrsFF1tjSwVXPUsRWCi11iR2Y0inbuF6mQ6Pq4T7QsPZlC393PfLAx2/Jlg5rGCF9yvQ=
X-Received: by 2002:a05:600c:1e2a:: with SMTP id ay42mr9718512wmb.131.1643250044209;
 Wed, 26 Jan 2022 18:20:44 -0800 (PST)
MIME-Version: 1.0
References: <20220118190922.1557074-1-dlatypov@google.com> <CABVgOSnY8Ctc9vuVX+Fjmmd3L5kpXnzMXJQ0LPXAgmjCKsrYYw@mail.gmail.com>
 <CAGS_qxqx+wcruc7DAD9TQjk27OF+VDo1n9S6atRx+dDG5cr=6g@mail.gmail.com> <CAGS_qxpRqOAoBbkkFttZgB_Zm+KM=pwprgZ0wzDROh21mO0r8Q@mail.gmail.com>
In-Reply-To: <CAGS_qxpRqOAoBbkkFttZgB_Zm+KM=pwprgZ0wzDROh21mO0r8Q@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 27 Jan 2022 10:20:32 +0800
Message-ID: <CABVgOSnmfhPcMCy5yQEymyBnTWSqEFbmTnSbHYL7D1D=eJOk5A@mail.gmail.com>
Subject: Re: [PATCH 1/5] kunit: tool: drop mostly unused KunitResult.result field
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jan 27, 2022 at 3:55 AM 'Daniel Latypov' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> On Thu, Jan 20, 2022 at 9:19 AM Daniel Latypov <dlatypov@google.com> wrote:
> > > That being said, I can live with the current solution, but'd ideally
> > > like a comment or something to make the return value Tuple a bit more
> > > obvious.
> >
> > A comment to explain that Tuple == multiple return values from a func?
> > Or something else?
>
> Friendly ping.
> Do we want a comment like this?
>
> # Note: Python uses tuples internally for multiple return values
> def foo() -> Tuple[int, int]
>    return 0, 1
>

Whoops -- forgot to send my response to this.

I was less worried about explaining the concept of multiple return
values, and more about naming what the return values were: that the
first one is the result information, and the second is the parsed
test.

That being said, it's reasonably obvious from the types in this case,
so I'm okay leaving this as-is, though in general I'm wary of tuples
when the order doesn't matter, and a struct-style thing (with named
members) fits that better.

I'm no Python expert though, so don't let my whinging get too much in the way.

-- David
