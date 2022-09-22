Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA5C5E6030
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Sep 2022 12:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiIVKvN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Sep 2022 06:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiIVKvM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Sep 2022 06:51:12 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66501D0796
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Sep 2022 03:51:11 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id d187so165030vsd.6
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Sep 2022 03:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=+8RVBpvMoPFWmhGcL4H8dYuUDziDEsgkdhPy3XBz2I4=;
        b=ALXZwDuV3TsTjfRdY2r0nlIayYwKQkpAssa3cAxmHzh9FzEHyxGQJoM8/rFAa0rjWq
         pjnAg5AUJb2jZRCc0XBK5lc/K3e4n58QS7EfbIApkoV2lHESNKqvd9TaFEzQrfc48vbd
         wlSVh2GkkPC2rmyZsR3UPcfCIYTgN5JVeLlv2RX6V5tIqo6hugIJAd3e1erxwLljHY7j
         5yRf4vMzMttEiQAFCpG1mZeB2WQf8tSaPlgUeLsFIlcm8ALSevfBh+oDCj3FH3/u5xcO
         M/uwg+9E2b8LN1MeN6YJma7VTwCVcZo7L8PggzNdqcKu4py2kew8N3TnAgkeS/8W6ujF
         p//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=+8RVBpvMoPFWmhGcL4H8dYuUDziDEsgkdhPy3XBz2I4=;
        b=AmOSlQcAe8e9EkRLB4v7zF9dLaaeZhQlHlbZkXfiSzwOj1P3wgkIo692B8xmsX9UqX
         trQWmEBEhpoPqiMD4FmbCuwQQV5sjPtkIxN4aZp+3nKx4H7XT62LHPNCi260bxpLNo8E
         V1hwVgqxyV+93movV120fepEoKCFUwq/oCp+NmWiJm2KzOLKjl4nk6XCwYKVxudZ6Ikg
         QsQrL+wOl3NqXfgQr/UJVKasal7479hGZJyX8S2n0Kdl2VC/W9Z8we0rS/qu9AMKeBNO
         i/OPr2VjlsQHz+SPBvc4yK9OEhx8tN76tig5u7zw0Ss0Z5/Vs5JEz4c/xOVc/ZaqaZSu
         BE7A==
X-Gm-Message-State: ACrzQf08yZyYIXBAsyd3J2YZ9K3/mB+zjOvuiCbrGxk7fC4tVKDzXCY1
        reNaTcqlVnveHU7yHsEbsPlFjW+HU0xDBAEZBzM5oA==
X-Google-Smtp-Source: AMsMyM5ux/GTkwPJINb2jtUbdLbNx0AxJBCoraABepK6fxresVoILEuZIdOMa7gE8zQETeOy6f8ctYKKFt9G9jS7mFw=
X-Received: by 2002:a67:d211:0:b0:398:3cfd:5a34 with SMTP id
 y17-20020a67d211000000b003983cfd5a34mr899669vsi.35.1663843870401; Thu, 22 Sep
 2022 03:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220922083610.235936-1-xu.panda@zte.com.cn> <CABVgOSkjmuWDVwOW5PQRAtDYJGjHjcc_8Gg4JjhiT41Kez1rcw@mail.gmail.com>
 <Yyw24J7YFVtxsnJ7@kroah.com>
In-Reply-To: <Yyw24J7YFVtxsnJ7@kroah.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 22 Sep 2022 18:50:59 +0800
Message-ID: <CABVgOSmDn8aVz=LEE6HnLTH8FJ0Civ7gsqejVfhnizFiAWF6jw@mail.gmail.com>
Subject: Re: [PATCH linux-next] kunit: tool: use absolute path for wget
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     cgel.zte@gmail.com, Brendan Higgins <brendan.higgins@linux.dev>,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xu Panda <xu.panda@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 22, 2022 at 6:20 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Sep 22, 2022 at 06:09:28PM +0800, David Gow wrote:
> > On Thu, Sep 22, 2022 at 4:36 PM <cgel.zte@gmail.com> wrote:
> > >
> > > From: Xu Panda <xu.panda@zte.com.cn>
> > >
> > > Not using absolute path when invoking wget can lead to serious
> > > security issues.
> > >
> > > Reported-by: Zeal Robot <zealci@zte.com.cn>
> > > Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> > > ---
> >
> > This seems mostly okay to me -- we'd be abandoning people who have
> > wget in an unusual location, but I don't think there are many people
> > who want to run KUnit under RISC-V, have wget in a non-standard
> > location, and can't acquire the bios file themselves.
> >
> > So this is:
> > Reviewed-by: David Gow <davidgow@google.com>
>
> Please no, at this point in time, submissions from this gmail "alias"
> are going to have to be rejected from the kernel.
>

Good to know, thanks.

This isn't queued anyway, as I think that getting rid of the code to
download the BIOS (and instead relying on the user's distro to provide
it) is probably a better solution.

Cheers,
-- David
