Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071D42FBA46
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jan 2021 15:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391094AbhASOud (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jan 2021 09:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391183AbhASLAU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jan 2021 06:00:20 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEFFC061757;
        Tue, 19 Jan 2021 02:59:40 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id b8so10308980plx.0;
        Tue, 19 Jan 2021 02:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2FDiZ6od0fvQh7WzUZnbGxxoxVajqn8rZ5Nyw7ukQhM=;
        b=CfevHelY0M0Q8sniU03dWoxCXyGea12k+yHYrnOAuetxEesrkfgIlWtfy7H3izws9O
         q3ST3hp6q7UNbAWoRM7yXJGRdkkEPBFX7noEfzwwwf7zDI6rhiLUQaniHgome26PbBsk
         7Fe2silUEW6jc2ToHyqfXeu5UwbiIa7JSkeZKpJA7CRZy4YFjsM3HQbD6OxTYRjGqxdG
         INOkAGLEgEN9+PU1eSvfuIk+qbUP5bcxFbsto2UVSwD7RkEU3XpyWXgid2ROUhExBWv9
         Q6SGOiA60iHvQCycthECli2DbzAPzLZB49sD5c+BUfEqTBVjGEvKW987/a5BzQe2TlpX
         OXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2FDiZ6od0fvQh7WzUZnbGxxoxVajqn8rZ5Nyw7ukQhM=;
        b=bOqz/2RNYVvBWzec1Xb3IJUm3+bseLbaUccblaGQlbUrUsewarObTBzlTEVjIezSBX
         rGcCrwG2uUDjikMV/VSbR+4f5NWUCJNZyvdD5B+O+LrW30R6A29ZBWi64roHlmRCZHzl
         9bE7FHBHLS0GJ3idZGjTFqSBQGseYaMr7S1Nc88SZGMT66NiAQlbjccynRe9+8ZUymQA
         flUWGBWoTdsu71/8r/59WPbGLIm4Zb5/gkfQDJm/Aej8svJmd+xn/KhE1xJyx9lMNSII
         U9P0AIMaOcad6z2/705D0JcNKu3G0fUF0T0h7rF5EjAoaPK88lmdrvCkCPAbA+xAlPuQ
         ASrA==
X-Gm-Message-State: AOAM533qvese8PdXQSa+qGQP7bRLqE8dA1HvfFS1VejvavLmCUqH7SGJ
        ZRBW5FpzOn7zWE6HP0KMudg=
X-Google-Smtp-Source: ABdhPJxyLJIgULTnX2m2lZkZhNNmupD+5+0pVQKyeFBaTgJYI5RBZ4sN/jOzV58/mIL3judNWX9wKg==
X-Received: by 2002:a17:902:8492:b029:de:17d0:16cf with SMTP id c18-20020a1709028492b02900de17d016cfmr4055536plo.74.1611053979877;
        Tue, 19 Jan 2021 02:59:39 -0800 (PST)
Received: from sol (106-69-181-154.dyn.iinet.net.au. [106.69.181.154])
        by smtp.gmail.com with ESMTPSA id v9sm18204495pff.102.2021.01.19.02.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 02:59:39 -0800 (PST)
Date:   Tue, 19 Jan 2021 18:59:33 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Bamvor Jian Zhang <bamv2005@gmail.com>
Subject: Re: [PATCH v2 0/7] selftests: gpio: rework and port to GPIO uAPI v2
Message-ID: <20210119105933.GA21741@sol>
References: <20210107025731.226017-1-warthog618@gmail.com>
 <CACRpkdZf2GhScg=sUG35nA5P6jXH93uuK0Fq_uhz29wBQLHOKQ@mail.gmail.com>
 <20210119003455.GB5169@sol>
 <CAMpxmJUkFL+w7afS2NKF-xiMR==HVR1Mk8uQm3782DBoG0qneA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMpxmJUkFL+w7afS2NKF-xiMR==HVR1Mk8uQm3782DBoG0qneA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 19, 2021 at 11:37:46AM +0100, Bartosz Golaszewski wrote:
> On Tue, Jan 19, 2021 at 1:35 AM Kent Gibson <warthog618@gmail.com> wrote:
> >
> > On Mon, Jan 18, 2021 at 04:04:51PM +0100, Linus Walleij wrote:
> > > On Thu, Jan 7, 2021 at 3:58 AM Kent Gibson <warthog618@gmail.com> wrote:
> > >
> > > >   selftests: gpio: rework and simplify test implementation
> > > >   selftests: gpio: remove obsolete gpio-mockup-chardev.c
> > > >   selftests: remove obsolete build restriction for gpio
> > > >   selftests: remove obsolete gpio references from kselftest_deps.sh
> > > >   tools: gpio: remove uAPI v1 code no longer used by selftests
> > > >   selftests: gpio: port to GPIO uAPI v2
> > > >   selftests: gpio: add CONFIG_GPIO_CDEV to config
> > >
> > > Bartosz I think you can just merge these patches into the GPIO tree, at least
> > > I think that is what I have done in the past.
> > >
> >
> > Could you touch up that Fixes tag in patch 1 if you merge v2?
> >
> > Thanks,
> > Kent.
> 
> Kent,
> 
> This doesn't apply to my for-next branch - there's a conflict in
> tools/testing/selftests/gpio/Makefile, could you take a look?
> 

Which is your for-next branch?

The patch set is based on and applies cleanly to gpio/for-next 7ac554888233,
so I'm not sure which branch you are targetting.

Cheers,
Kent.
