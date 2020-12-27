Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE4C2E32A6
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Dec 2020 21:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgL0UBM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 27 Dec 2020 15:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbgL0UBL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 27 Dec 2020 15:01:11 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847DAC061796
        for <linux-kselftest@vger.kernel.org>; Sun, 27 Dec 2020 12:00:31 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id iq13so4893109pjb.3
        for <linux-kselftest@vger.kernel.org>; Sun, 27 Dec 2020 12:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CCyTtxeQ/2wD8VxKgYKuPRRB6ZhCqK8ijOpnQMPS1DI=;
        b=cvqQ5l2UZ7Nt2IS50m3j7Q0YL/BSipq714qbez8/6cZoo9FZa/R2sL3+j5LA5md+8q
         HCX6enAqtGIq3uD4Jhjq5Vsp5gkPRBwKJVpwQgHLPbxp4PZrf0zcYChSNfXqEfmTK7Ho
         LG6GmKmzMDo7BMZvQfawWf1yLCbk5PTIeNJLfvQIMyc58W2PYsRz70iOG21Fv0iryyAV
         ZUxpYGE0ydnwyc55l5hyGKKWibqR8psUdELb0feIJGKtR0+dc5Sdhsgofs3nmsLUEwrR
         p1aBri+jaR/r/IeJmM0Q0D1rdUVgl19E4+DLPF/6E6oaKBhcEqrCyXBDpbRHu7t4Fs6U
         s4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CCyTtxeQ/2wD8VxKgYKuPRRB6ZhCqK8ijOpnQMPS1DI=;
        b=CkxaZIQp5v/zuYtj9W3nbx+S/Cs+0jSPNqVDXbpcCVYiKgq1r/Ec51FG34q4I3I8xF
         uQxAAT5vhZ2tcDPcvzKMISYhMKWy/BPZ14JknfbSBMmjhy/NWyrKeud5aolt+O2OvOdz
         VqmByrV82e81b5qy8y4zmNqzokKm/VasHfKMosbzDv0xqYXto7zQUE8ctWHFfAZ8j+vm
         E/nsCIvHk/PliDbYo7rrB38V8bJlamcICI/hc8+h2U0UtyMseq0vlxE7umkknmF/zNly
         HHZCfHP+ZiY2eqpgzApbiGofKacm1O4VGPg4Hyu1Bq0lx744cUfv1rs/9U9YFdE+QpAG
         n1ig==
X-Gm-Message-State: AOAM532d7xXoso+WFRZWPtT9hBQyOxC6HdqI1c+bk7fiDuGAnZcwwcAk
        DtX+1nOzb6HwgGNLZGoH1k1cRFuqJbGqsetMe65LMA==
X-Google-Smtp-Source: ABdhPJyYBl0iV8pdPVZtEVH/YOfuteMorhbLBFfcQ5BRBSId/DsaO6b6KEQynz8zit1oDdXra/faGuZIlGRAm1aq1LY=
X-Received: by 2002:a17:902:fe87:b029:da:5d3b:4a84 with SMTP id
 x7-20020a170902fe87b02900da5d3b4a84mr42465536plm.51.1609099230919; Sun, 27
 Dec 2020 12:00:30 -0800 (PST)
MIME-Version: 1.0
References: <20201222073900.3490607-1-davidgow@google.com>
In-Reply-To: <20201222073900.3490607-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Sun, 27 Dec 2020 12:00:19 -0800
Message-ID: <CAFd5g45i-x5itqnLQe1tikSVsycF8HZcJiiKiJ-SRo4D7b9dxQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Force the use of the 'tty' console for UML
To:     David Gow <davidgow@google.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 21, 2020 at 11:39 PM David Gow <davidgow@google.com> wrote:
>
> kunit_tool relies on the UML console outputting printk() output to the
> tty in order to get results. Since the default console driver could
> change, pass 'console=tty' to the kernel.
>
> This is triggered by a change[1] to use ttynull as a fallback console
> driver which -- by chance or by design -- seems to have changed the
> default console output on UML, breaking kunit_tool. While this may be
> fixed, we should be less fragile to such changes in the default.
>
> [1]:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=757055ae8dedf5333af17b3b5b4b70ba9bc9da4e
>
> Signed-off-by: David Gow <davidgow@google.com>
> Fixes: 757055ae8ded ("init/console: Use ttynull as a fallback when there is no console")

Acked-by: Brendan Higgins <brendanhiggins@google.com>

Thanks for taking care of this!
