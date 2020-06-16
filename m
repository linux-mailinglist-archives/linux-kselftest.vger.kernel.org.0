Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94AC71FC280
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jun 2020 01:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgFPX6u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Jun 2020 19:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFPX6t (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Jun 2020 19:58:49 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03964C061573
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Jun 2020 16:58:48 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id b7so1652538pju.0
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Jun 2020 16:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1amKsauscRtUYJxwB6r4wYVg83Pm/9N/gPGEAJklEmE=;
        b=XKpaUV4k35DbwbzOQuJTW+T/q9ZaidqF3eHIGTJL1bfH9SWqYawWt4k1SDxDdVl0Er
         uJKpGRwXhgJ2kpafC1Cxs+opRyw0SSNeYiiRAs6NgGPj80aLrrIHJgsbZDboP5SLvum8
         ExowX4oSlC1mDJPZvvSTKTQXnvl0JakZ2dtzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1amKsauscRtUYJxwB6r4wYVg83Pm/9N/gPGEAJklEmE=;
        b=dhaRurUjh2yp8f9XGsdagcO1oDJX2dYbNnHL0Em/MijNTBku1HyDVxlL/r0NCIfsk5
         x8FIeMsgfY4nfwzJt1Ddl6lqTNAx6NjY2vaxKN6VvD/2kQo0AV+J4q2oHa2ukfv8NnTB
         1DTUKKcDsAkTfsQ2RFBGPvrVyx2hIPKfvKxcvuROG9FjYsYsrfSY7Fgy0a/bKfdwxPy9
         Nx1CNpBoY//Izfw5yGnzrZUZKvLmbbxJ8yJPweCAEzxssA/pKaNcIfoNIm3a76tEvUOt
         z5iRSjLqKm0AabKDexrGixxHBKRpOGZkiEDruaCWeuLPFBw7DyOl/4J7vSpN6B9krrVW
         fAww==
X-Gm-Message-State: AOAM532Zrz9hfPCocrt4Kp+kG3t3B8TL4bgl/OfJe3NHnLfTJaq0cfT4
        WjNpg2brQ2MiWcf1qJKXv143gw==
X-Google-Smtp-Source: ABdhPJxw5yiyCJ+o734BQt9lxF/pwbijsWxt1/EuncjKqx6IjLfKfPKWQBHx++cMFpFqHMhs426j1A==
X-Received: by 2002:a17:90a:ce14:: with SMTP id f20mr4947277pju.115.1592351928416;
        Tue, 16 Jun 2020 16:58:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w18sm18318483pfq.121.2020.06.16.16.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 16:58:47 -0700 (PDT)
Date:   Tue, 16 Jun 2020 16:58:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     "Bird, Tim" <Tim.Bird@sony.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Gow <davidgow@google.com>
Subject: Re: RFC - kernel selftest result documentation (KTAP)
Message-ID: <202006161653.15C278A5@keescook>
References: <CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com>
 <202006141120.96FF8C5@keescook>
 <CY4PR13MB11757D57CD441C5CAEC3F257FD9C0@CY4PR13MB1175.namprd13.prod.outlook.com>
 <7161fadb-45ba-c4c0-8bbb-cb47d2dd0265@redhat.com>
 <CY4PR13MB11755F5A6879CA3FFD005426FD9D0@CY4PR13MB1175.namprd13.prod.outlook.com>
 <CAFd5g454n4ZPgCdWaAxezFueG47TztqBx4L7x4oYwgPAR3BZNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g454n4ZPgCdWaAxezFueG47TztqBx4L7x4oYwgPAR3BZNA@mail.gmail.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 16, 2020 at 12:44:28PM -0700, Brendan Higgins wrote:
> On Tue, Jun 16, 2020 at 9:42 AM Bird, Tim <Tim.Bird@sony.com> wrote:
> > > From: Paolo Bonzini <pbonzini@redhat.com>
> > >
> > > On 15/06/20 21:07, Bird, Tim wrote:
> > > >> Note: making the plan line required differs from TAP13 and TAP14. I
> > > >> think it's the right choice, but we should be clear.
> > >
> > > As an aside, where is TAP14?
> > By TAP14, I was referring to the current, undocumented, KUnit
> > conventions.
> 
> Not so. TAP14 is the proposed next version of TAP13:
> 
> https://github.com/TestAnything/testanything.github.io/pull/36
> https://github.com/isaacs/testanything.github.io/blob/tap14/tap-version-14-specification.md

I was reading this (I haven't compared to the blob above):

https://github.com/TestAnything/Specification/blob/tap-14-specification/specification.md

> Based on the discussion, it seems like most of the things we wanted
> from TAP14 would probably make it in if TAP ever accepts another pull
> request.

Were our leading diagnostic lines part of their latest spec? I thought
we were pretty far off in left field for that particular bit.

> > My personal preference is to have the dash.  I think it's more human readable.
> > I note that the TAP spec has examples of result lines both with and without
> > the dash, so even the spec is ambiguous on this.   I think not mandating it
> > either way is probably best.  For regex parsers, it's easy to ignore with '[-]?'
> > outside the pattern groups that grab the number and description.
> 
> I don't think we care, because we don't use it.

Yeah, I'm in the same place. I don't care -- I would just like a
determination. (The "implied" nature of it in TAP14 bothers me.)

> > > XFAIL/XPASS are different from SKIP.  I personally don't have a need for
> > > them, but kselftests includes XFAIL/XPASS exit codes and they aren't
> > > reflected into selftests/kselftest/runner.sh.
> > >
> > > Likewise, kselftest.h has ksft_inc_xfail_cnt but not
> > > ksft_test_result_xfail/ksft_test_result_xpass.

I proposed fixing that recently[1]. seccomp uses XFAIL for "I have
detected you lack the config to test this, so I can't say it's working
or not, because it only looks like a failure without the config."

[1] https://lore.kernel.org/lkml/20200611224028.3275174-7-keescook@chromium.org/

-- 
Kees Cook
