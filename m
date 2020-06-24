Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB668207DAC
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jun 2020 22:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391514AbgFXUsR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Jun 2020 16:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389960AbgFXUsQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Jun 2020 16:48:16 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF4FC061795
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jun 2020 13:48:15 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id j1so1765141pfe.4
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jun 2020 13:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mEB3lYAl4SsCrlV3BTMPre2pXq7ZML14cKlVh3L5q6Y=;
        b=lhCo7Ce8+px/1qsZVVvWEvl8b17OyY0VZ6phH6kNRqcIOvtIYFe0Bosc/F3kgxiZAE
         hIt8Ui2UgLPzKPs5Pu8zXZBkVSaIoZREtMw1R5nWAh47Ns+jsFMToC89jWQxGRUdKYXP
         CSG99NaJzj43AQOQGF2aC1BQwpgpJnQXPq1No=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mEB3lYAl4SsCrlV3BTMPre2pXq7ZML14cKlVh3L5q6Y=;
        b=ifrJMbFh1eaNpn12oATygndw5PF3O9pxIYTZS/o0U1KePIO5NNrsaiWzUBtt8D/8nM
         FGMj/TSWYtYqD7kLzUEoJbCeYCALA6PXPNffTEfkB6Y1SIqiQWkKmB2QnShnyDFcdLN2
         BWYp73e04Ga6LDMF4wX4XrLueH5cNoCdNX4+fRgXHc80oBS5RRrCexfHfb9QgNnNy491
         KgyNcrDrA8cGy2xPXh2K7BfXifbxGRKtKkZY5d5qggtLvTK99VA6AlPufp/iLG9vtL33
         VJwJwneIR9VQuO7ZK7RqsgfW+R1hMBiLV9KdI0YWmn7fsscGQZ0OFKmakY/o+fjytA2Y
         Zh2w==
X-Gm-Message-State: AOAM531+KCyQhY19/JZKJgHwaE2lf/XA5nXW68w2ewhllbDU+Y3X/a7z
        RgvQLvjvPNdjjZrK979kh13nWw==
X-Google-Smtp-Source: ABdhPJxeJ8eBpJFffDOuMwexylg22gOTAro/oN0xNaO5l0HSv9qlqevOVqP5fuMF0UPCCX1u+a0H8Q==
X-Received: by 2002:a63:be01:: with SMTP id l1mr23945501pgf.32.1593031695265;
        Wed, 24 Jun 2020 13:48:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n11sm17739270pgm.1.2020.06.24.13.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 13:48:14 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:48:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Iurii Zaikin <yzaikin@google.com>,
        David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, rppt@linux.ibm.com,
        Greg KH <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-arch@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v3 4/7] init: main: add KUnit to kernel init
Message-ID: <202006241345.43D22CB261@keescook>
References: <20200228012036.15682-5-brendanhiggins@google.com>
 <202003021439.A6B6FD8@keescook>
 <CAFd5g45Jz-5wtO-YNuqPN2Zc_rJtoA1qbPLVs2wrJFQyZpd5QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g45Jz-5wtO-YNuqPN2Zc_rJtoA1qbPLVs2wrJFQyZpd5QQ@mail.gmail.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 24, 2020 at 01:20:35PM -0700, Brendan Higgins wrote:
> On Mon, Mar 2, 2020 at 2:45 PM Kees Cook <keescook@chromium.org> wrote:
> > Now, I realize kunit tests _should_ be self-contained, but this seems
> > like a possible robustness problem. Is there any reason this can't be
> > moved after rcu_end_inkernel_boot() in kernel_init() instead?
> 
> I tried that, but it doesn't work without an initramfs. We could add

I'm curious to know what happened. To me it looks like it would be
possible to do it in here:

        system_state = SYSTEM_RUNNING;
        numa_default_policy();

        rcu_end_inkernel_boot();

        do_sysctl_args();

	put it here?

        if (ramdisk_execute_command) {
                ret = run_init_process(ramdisk_execute_command);

That should be before anything happens with an initramfs. (i.e. boot the
kernel without an initrd and it won't be required...)

> an initramfs for KUnit at some point if highly desired, but I think
> that is outside the scope of this patchset. Additionally, this patch
> actually moves running tests to later in the init process, which is
> still an improvement over the way KUnit works today.

Later is better! :)

> There are some other reasons I wouldn't want to make that change right
> now, which will become apparent in a patch that I will send out in
> short order.

Cool; I'll look for it.

-- 
Kees Cook
