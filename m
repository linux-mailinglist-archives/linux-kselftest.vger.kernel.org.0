Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E5E1C223B
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 May 2020 04:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgEBCL3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 May 2020 22:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgEBCL2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 May 2020 22:11:28 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E240C08E859
        for <linux-kselftest@vger.kernel.org>; Fri,  1 May 2020 19:11:28 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u127so2153399wmg.1
        for <linux-kselftest@vger.kernel.org>; Fri, 01 May 2020 19:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DxgeZ4dWQbsgxzC3vr4Uf0z6ga9GPtUvmnQ6rfH9mnw=;
        b=GoAOXqYvnqNaHnqw0sl6wxaUTEEROMaaJ5wtFkTK5JBEL5n2G2yvGvhs3s05djne9u
         Z0Nm572hdR8ZAqHgELOeTbhCxmoiHUC726/03InwwU0piYRV48UG/j+BM16uSqBf7VFT
         3/4Bks7Dn7b3YYiGicAkJq043PppsvbGx0CWk1jV7TbiQ2eZ698CTHttNGU9GMA+gSlD
         yy5AuwsFaLV1/DF+ulL0gMVwg0fBWYh58QliUQqii9fRHedY1IHl5AtDR8kM7dLRpvvV
         Geu2ui5FWXP3BSoTCYRcP8EFX/JKjNL7AXTEBtblQXJ+7oX2W9r8tZjBd+6ylNmZDSNY
         yEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DxgeZ4dWQbsgxzC3vr4Uf0z6ga9GPtUvmnQ6rfH9mnw=;
        b=Zx/wcxJ3iM+XMmKZLcPYTzxuNHtMzvAAom0Fg5fACaw7cstq1KlvubfW/06pafF2Uw
         ypJTefxvkNiTmP8n5uy0u/r1fSFJpJL1B5JxbtYi/+cp271RcZjYvWXIAC2m+6KWAidE
         Pf7qceafNQvQMYj1Hida3JQg2I8RbOL6OUqnMYOJxvgX5IAHNfsp+MAlhz+P72V46ykg
         MU6FJUmern4ahQRYNkbHN3XoMQ3nlISmYMCL7I1M+Cjf4/P3z36eLlek1ZAIlWu8VMCG
         vWEkSGPP/LPC3MdUjmLJjoVWNRXldY52dhBStM6RVlTXitsV0PT/ZNG03bv5I+fvtkqm
         wjDQ==
X-Gm-Message-State: AGi0PuYjkzJCuGj85ENMgADeg1KwJrpMHh1nH+b9STBYncLsb/JTFJH1
        qWzdk4wF7BHuZKmrp6iL/ACxjsvQlvlTXaVEvkexAg==
X-Google-Smtp-Source: APiQypLDIvRbUKevZsGcEO30n6w7WQseNzEj38FrNcXYHjaeCNVPqKzvEB/q8lL2AFg/XGQTwq2/IwPCqTdYBakWPhw=
X-Received: by 2002:a1c:dd8a:: with SMTP id u132mr2195716wmg.87.1588385486740;
 Fri, 01 May 2020 19:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200501083510.1413-1-anders.roxell@linaro.org> <CAFd5g45C98_70Utp=QBWg_tKxaUMJ-ArQvjWbG9q6=dixfHBxw@mail.gmail.com>
In-Reply-To: <CAFd5g45C98_70Utp=QBWg_tKxaUMJ-ArQvjWbG9q6=dixfHBxw@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 2 May 2020 10:11:15 +0800
Message-ID: <CABVgOSkAAb7tyjhdqFZmyKyknaxz_sM_o3=bK6cL6Ld4wFxkRQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: Kconfig: enable a KUNIT_RUN_ALL fragment
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        Marco Elver <elver@google.com>,
        John Johansen <john.johansen@canonical.com>, jmorris@namei.org,
        serge@hallyn.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org, kasan-dev <kasan-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, May 2, 2020 at 4:31 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Fri, May 1, 2020 at 1:35 AM Anders Roxell <anders.roxell@linaro.org> wrote:
> >
> > Make it easier to enable all KUnit fragments.  This is needed for kernel
> > test-systems, so its easy to get all KUnit tests enabled and if new gets
> > added they will be enabled as well.  Fragments that has to be builtin
> > will be missed if CONFIG_KUNIT_RUN_ALL is set as a module.
> >
> > Adding 'if !KUNIT_RUN_ALL' so individual test can be turned of if
> > someone wants that even though KUNIT_RUN_ALL is enabled.
>
> I would LOVE IT, if you could make this work! I have been trying to
> figure out the best way to run all KUnit tests for a long time now.
>
> That being said, I am a bit skeptical that this approach will be much
> more successful than just using allyesconfig. Either way, there are
> tests coming down the pipeline that are incompatible with each other
> (the KASAN test and the KCSAN test will be incompatible). Even so,
> tests like the apparmor test require a lot of non-default
> configuration to compile. In the end, I am not sure how many tests we
> will really be able to turn on this way.
>
> Thoughts?

I think there's still some value in this which the allyesconfig option
doesn't provide. As you point out, it's not possible to have a generic
"run all tests" option due to potential conflicting dependencies, but
this does provide a way to run all tests for things enabled in the
current config. This could be really useful for downstream developers
who want a way of running all tests relevant to their config without
the overhead of running irrelevant tests (e.g., for drivers they don't
build). Using allyesconfig doesn't make that distinction.

Ultimately, we'll probably still want something which enables a
broader set of tests for upstream development: whether that's based on
this, allyesconfig, or something else entirely remains to be seen, I
think. I suspect we're going to end up with something
subsystem-specific (having a kunitconfig per subsystem, or a testing
line in MAINTAINERS or similar are ideas which have been brought up in
the past).

This is a great looking tool to have in the toolbox, though.

-- David
