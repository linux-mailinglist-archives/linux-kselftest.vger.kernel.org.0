Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 152DB3D074E
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jul 2021 05:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbhGUCjB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Jul 2021 22:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbhGUCi6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Jul 2021 22:38:58 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8D5C061574
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Jul 2021 20:19:36 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id v14so275011plg.9
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Jul 2021 20:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e9+wIJMSoz3bWq2JYWBjZyZXlwOkY3lYjFKTKlDMrfM=;
        b=W4z9powBmBd9ZAlHfbGJ2zXJGXn+mPsE2G8UiL/ADun/Ic4d6jmEY+lQFI3RLx7LgE
         cWoS7//JkQGN7zGcrbiqigQIPOcSnMWXLYF7HcNYPvNfTgwviJDKnFiEPfBA8CX3jk5F
         xgMvBwu3UW4iyQJo6MqQd4nf0BAsCzHJPY/cmBPEPEBwSXbSq3Nmg9F4zUe6z9EfvLgB
         1s7e3HGkfe1mXDyBcACpwpuoKowdppS6dK5HpGpkx1ynobEsCv/ogIt9qx+0CD3G48gF
         OeQiHqDdaZx3GT+SwkynAEOirp7gEB2IgBPlks2qeCKxAgoZh4RSCZ9Mnb6hLDwkvW+f
         DxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e9+wIJMSoz3bWq2JYWBjZyZXlwOkY3lYjFKTKlDMrfM=;
        b=CPWlVZwDI1TvS56OdYfgdmColCemPoZDyiR/eBbNVMPraWa6z8YsT077X6AmDdz+YW
         +GABEXDKa/Svfsp1Vmx2BffBBti/lC3ecI9NtrY2Rki5l4ID46z2xnKVTGxhUyqGYZAF
         Wz2+drYHd3Z114aBTIC/ZAz7lkgdmSlAvB2ookCZyuvyx/ogdSpWRCluuMgLC4hS+sGJ
         ZMp+F17tYYyEhkgvIfb+Yl7aQtcgv6ocGv065OzP2PwLcgdUL5JBdXN8GVqSkz9FLO0z
         j3aQHGdMqXui/xJ4VpnMXGgltBstXXKvjycuRwxxoJdQr+IpqmKPGu025Z0Bi0GIS4H0
         h1fg==
X-Gm-Message-State: AOAM533lW7FdwzpZHXfNYVTOKWbPNUd4DohqROakRewAVhTYXrE2HaEI
        NgWX4ua3LjxAekCKaUDFFOixmvmlKCPRyiEAZcQbTA==
X-Google-Smtp-Source: ABdhPJzesoHmQb19adjMNNR2Oi/k9zrmsZ6Ll3l4VZcnQgG1m0XVJC0ii26fEs8PPG08dNMebdso+Rii165naxphtQM=
X-Received: by 2002:a17:90b:1d84:: with SMTP id pf4mr32768550pjb.166.1626837575462;
 Tue, 20 Jul 2021 20:19:35 -0700 (PDT)
MIME-Version: 1.0
References: <1583733592-22873-1-git-send-email-vincent.chen@sifive.com>
 <1583733592-22873-3-git-send-email-vincent.chen@sifive.com> <1257037909.25426.1626705790861.JavaMail.zimbra@efficios.com>
In-Reply-To: <1257037909.25426.1626705790861.JavaMail.zimbra@efficios.com>
From:   Vincent Chen <vincent.chen@sifive.com>
Date:   Wed, 21 Jul 2021 11:19:24 +0800
Message-ID: <CABvJ_xgLgk0woE-X2mjtSUzO5ykzmu+qKkToDiskOrCQ1u=Pog@mail.gmail.com>
Subject: Re: [PATCH V2 2/3] riscv: Add support for restartable sequence
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Guo Ren <guoren@linux.alibaba.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 19, 2021 at 10:43 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> ----- On Mar 9, 2020, at 1:59 AM, Vincent Chen vincent.chen@sifive.com wrote:
> [...]
> > --- a/arch/riscv/kernel/signal.c
> > +++ b/arch/riscv/kernel/signal.c
> > @@ -234,6 +234,7 @@ static void handle_signal(struct ksignal *ksig, struct
> > pt_regs *regs)
> >       sigset_t *oldset = sigmask_to_save();
> >       int ret;
> >
> > +     rseq_signal_deliver(ksig, regs);
> >       /* Are we from a system call? */
> >       if (regs->cause == EXC_SYSCALL) {
>
> [...]
>
> As Al Viro pointed out on IRC, the rseq_signal_deliver() should go after syscall
> restart handling, similarly to what is done on every other supported architecture.

Thanks for the notification. I will adjust the porting and try to send
the patch again for review.


>
> Note that there is already an upstream commit derived on this non-upstream patch:
>
> commit 9866d141a097 ("csky: Add support for restartable sequence")
>
> which is broken in the same way.
>
> I'm not sure why I was never CC'd on the csky patch. Considering that nobody
> bothered to implement the rseq selftests for csky, I don't see how any of
> this is tested. I would favor a revert of that commit until the testing glue
> is contributed. Unfortunately, the csky commit has been upstream since v5.7.
>
> Thanks,
>
> Mathieu
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
