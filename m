Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D45675998
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jan 2023 17:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjATQMI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Jan 2023 11:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjATQMH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Jan 2023 11:12:07 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B95427488;
        Fri, 20 Jan 2023 08:12:06 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id h24so4559991lfv.6;
        Fri, 20 Jan 2023 08:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a4yAGJjXOFsRxl3MVuwwc2t7yCQNogOABolprG59Klo=;
        b=jeGinbmjOqvqtrzCow4cr5uNVhQNjd/Ru07Uoyv/O9Vv85QGVQvabmzNXEL5HBIjhq
         h5szoBQLDROSncN8DalmO/GpRqXpABQ8h34hg0YZ9bWAtaFZz6aahsP4d11Cgc6dyRah
         pHXMVXhQHI3eRNWxaVcR/4T0IURs+uXES1UK3Xh3VjhMorDglYUAq0RhDigN2S4wBdw3
         WUg0VIeV5Jf10ORrXHZQi7ZkTrwNhWrDaBnbyNmsE0Zoar58ioRvn0m3sDdf1MNNYCXd
         uH6YxZpAHjKXe9X3ZLNxhBCv7sDVp7uUhRJIm3Kb9pAx/9dg9CXpyFqEZ3WecCxPzR13
         kNjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a4yAGJjXOFsRxl3MVuwwc2t7yCQNogOABolprG59Klo=;
        b=FfxyiId8swoBFGvPLF8cPzYZu3FWoMvJMDKq9VQEFVoT93HeyUIF5aRbPWY1Ct31Wj
         oYk60vuWRB0T4ue+SGvEppJI7/yXdm/QIOqsQYqinN9o69g0JCppUJ1Zj5KFUO8MGl5Q
         Pyy44v1vKerq17FdAQKXk9dbjPX+W/n7gsFlLD83JspyYA3gIaqLAXIu6lW88qL/J+Vh
         ghN3IMOiZKF36pbNYu6P/4vKmNbWDRnTp1hxfvsH/aXiBp7HCV7AFd49veEOVZ7I9pml
         0XBwlgKFgLI/zJ1X7ybYjOKFC3k/Gd/iQcFS+TkLFcIX3toj1ogrfEIrlA2dNwagRcmV
         4rog==
X-Gm-Message-State: AFqh2kqjHewCk+OcsMsw3Ev3v2fzYGgKp7CcsMbnThwc1s2EOL3wN13O
        6D4AAerv4+ELB5fYQHMgVpMOxxM6OZc8HIojLPg=
X-Google-Smtp-Source: AMrXdXtmo9mDdZkynbkzZR4K2Vx9T4BBVUjbaZlq6jE5LFYNyOe+fo7OiPoTnzJd/qlDiYLt8aCWpnfQ01kB6uWvp3k=
X-Received: by 2002:a05:6512:159:b0:4b5:2958:bd06 with SMTP id
 m25-20020a056512015900b004b52958bd06mr907263lfo.26.1674231124504; Fri, 20 Jan
 2023 08:12:04 -0800 (PST)
MIME-Version: 1.0
References: <001201d92c93$98c8a040$ca59e0c0$@telus.net> <Y8pcIjGsikDeGqoU@amd.com>
In-Reply-To: <Y8pcIjGsikDeGqoU@amd.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 20 Jan 2023 17:11:27 +0100
Message-ID: <CA+icZUWP_uYr5B6d_xms5gpCRmNCx46KwukmZyuuTdEPawKUyA@mail.gmail.com>
Subject: Re: [PATCH] selftests: amd-pstate: Don't delete source files via Makefile
To:     Huang Rui <ray.huang@amd.com>
Cc:     Doug Smythies <dsmythies@telus.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jan 20, 2023 at 10:17 AM Huang Rui <ray.huang@amd.com> wrote:
>
> On Fri, Jan 20, 2023 at 01:54:01PM +0800, Doug Smythies wrote:
> > Revert the portion of a recent Makefile change that incorrectly
> > deletes source files when doing "make clean".
> >
> > Fixes: ba2d788aa873 ("selftests: amd-pstate: Trigger tbench benchmark and test cpus")
> > Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> > Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> > Signed-off-by: Doug Smythies <dsmythies@telus.net>
>
> (+ Shuah and linux-kselftest mailing list)
>
> Thanks for fix!
>
> Acked-by: Huang Rui <ray.huang@amd.com>
>

[ I already replied - but with these important CCs ]

Hi Doug,

Thanks for the patch!

Small nit, I saw this with:

$ make -C tools/ clean

Otherwise:

Reviewed-by: Sedat Dilek <sedat.dilek@gmail.com>

BR,
-Sedat-

> > ---
> >  tools/testing/selftests/amd-pstate/Makefile | 5 -----
> >  1 file changed, 5 deletions(-)
> >
> > diff --git a/tools/testing/selftests/amd-pstate/Makefile b/tools/testing/selftests/amd-pstate/Makefile
> > index 5f195ee756d6..5fd1424db37d 100644
> > --- a/tools/testing/selftests/amd-pstate/Makefile
> > +++ b/tools/testing/selftests/amd-pstate/Makefile
> > @@ -7,11 +7,6 @@ all:
> >  uname_M := $(shell uname -m 2>/dev/null || echo not)
> >  ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
> >
> > -ifeq (x86,$(ARCH))
> > -TEST_GEN_FILES += ../../../power/x86/amd_pstate_tracer/amd_pstate_trace.py
> > -TEST_GEN_FILES += ../../../power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> > -endif
> > -
> >  TEST_PROGS := run.sh
> >  TEST_FILES := basic.sh tbench.sh gitsource.sh
> >
> > --
> > 2.25.1
> >
> >
