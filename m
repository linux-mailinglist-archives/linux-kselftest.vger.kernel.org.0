Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2312F46C7C4
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Dec 2021 23:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238149AbhLGW4t (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Dec 2021 17:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238080AbhLGW4t (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Dec 2021 17:56:49 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CDBC061746
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Dec 2021 14:53:18 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso670911pjb.0
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Dec 2021 14:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FwDgJnKJalwt8LVW8wK99qzWzGdP063/zKEOOgpHy2A=;
        b=hV61umr33rMnbgSKPPAnOLIJhq5MdWqYSrZKKoi1d17nv4RwxuCwFACovwlCy2fUHh
         8Og2GwmGMM/LCqDoamJ5/Nw8NjXnllzWCM34Uz/hb+smr9hXxHUhv2V49FYbIVNVwbH4
         zjRnQlyqfT4yLn3+XUgM2QNj4p3WWKpa3Vm08zRuP//rR0PQgXlVBYPbqYGt8VFJpYf1
         lZ5U8s5G3DDHZujVoe2Tjl737TpG/bRNPDzJzL7cBCFBK4VIWxBlvaMnEIzXx089QuQA
         39v+/IoyQ2odQ883DhehFURFHM/s0fIVwydsbiHBM04Xnko2+K+nfddnyHGEaNTeqv1c
         Fw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FwDgJnKJalwt8LVW8wK99qzWzGdP063/zKEOOgpHy2A=;
        b=QMqev/NB+pWz6FpbeDU71gL8I7zYjeJ4QQTOc+mGQvcv2A81hFrIgRzOGJcfB5KAW9
         Snnh42PX5bfWWKduuYYfKAidqx5Ofw+VTHLzs6w0RkARAFCWeT5haUbpUkMplDWalQtD
         DBEIGsJE60LV6CezsVRlIp+gDKnBjqe9KXF2q6CYK6n0Wx1QI11aJ2vJxQJmiup08jh1
         VDWCPWWRNIWBFgmoy8yVNiL8hTdsLOOb+QcYX76B81nFVdah322x9pL9jrOgcZ503SX+
         01Z1V9uMYa3iZG99pY6hDXauer9K7xDT1VT8O1d+CIeyz2qbUEAEYoj4QlqtJW5NncGs
         s/sg==
X-Gm-Message-State: AOAM532i2g+XSOAGaIjtFExPv+ka9Wd5bPQlpimbABiq6ZiIywHTKujB
        54lqBz4Nt2Dva6jT6mpfp2fKiuMiYsoSKoc6MzuJPg==
X-Google-Smtp-Source: ABdhPJw4GHO9GUATVuIUdeL+x4R9vXgelcanfQA1sHCfXcQJIdcgXLxQe6j0lJOd7ZVXvbiC5eDUWK44kGAawhin/BY=
X-Received: by 2002:a17:902:cb8a:b0:141:f601:d5f1 with SMTP id
 d10-20020a170902cb8a00b00141f601d5f1mr55452553ply.77.1638917597643; Tue, 07
 Dec 2021 14:53:17 -0800 (PST)
MIME-Version: 1.0
References: <20211111183356.4073001-1-dlatypov@google.com>
In-Reply-To: <20211111183356.4073001-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 7 Dec 2021 17:53:06 -0500
Message-ID: <CAFd5g45RxVE-BAoM00KY-5VFNvu=StYQg0p5+GFRD-JOHFezUw@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: revamp message for invalid kunitconfig
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 11, 2021 at 1:34 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> The current error message is precise, but not very clear if you don't
> already know what it's talking about, e.g.
>
> > $ make ARCH=um olddefconfig O=.kunit
> > ERROR:root:Provided Kconfig is not contained in validated .config. Following fields found in kunitconfig, but not in .config: CONFIG_DRM=y
>
> Try to reword the error message so that it's
> * your missing options usually have unsatisified dependencies
> * if you're on UML, that might be the cause (it is, in this example)
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
