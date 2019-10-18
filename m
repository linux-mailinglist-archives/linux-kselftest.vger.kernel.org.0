Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD1F0DD437
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Oct 2019 00:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbfJRWXP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Oct 2019 18:23:15 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43411 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405141AbfJRWXM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Oct 2019 18:23:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id i32so4082682pgl.10
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Oct 2019 15:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZzFjkJfCdQsvvmn45ej4PRYX2Ksv6KlFlj/T0OsJ77A=;
        b=DPS5OmboH+PIYPvZyGOMW4WJhPyyVwcaEaBk8/R4rLtVZxmgChmNmKIb1HEI8oPUqt
         CIGwqsk8TCJMmzsKmIhkmX7woXewN5gVb9A6sQr3mmsjKB98eCe9o4K/xf2Wi9zoB2Wf
         gYlCc0655Bvh8aRaMknPb/ujYQmw3cYru6pKSueyr9eotSSB4axmk7fqKc7BRQfqVCrL
         +G+RmvtgwaHUAsJ8IBgWko31DBrqFBgQG9Er27RmzjAqvEKjDLnwfMKNiJFlsWH6oqWs
         ED6ThJeVV7UW0BNzVkPM4siRhvuT9fCkJUTNvixR2/OdaVQl1SjE8F8H+iNOqmontUGx
         gSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZzFjkJfCdQsvvmn45ej4PRYX2Ksv6KlFlj/T0OsJ77A=;
        b=bvyyfPjpVF44UZmb2+nf29TB0EUy824hffty5yBo9pAjl2AQj5jl4YKwBiuv0Mpj2K
         Dnu8Xrcsiqdn9d0Kk3lk3BZ46scYssHI3SZ2oO41PkVNXDEn1zgyO05h/3RBnf8cB2Fo
         qUHd4pKZKNUwOLiUrYOUNvPraQgar6lcoevY6Bu+yN4GqeeUoqAwcJdIBOuj6+wyHUhk
         PxfSWiNcGf64Tk50HbPbUJFCcSCNB4RD8Gr0B9oBd4s7Aw0sAhpe5tsklHQCT+z9SVMw
         lrkyzMs/PVrdr2iroNk972Tf69CfBuISmx1od0IJA7/p1msMyXEMxuK9K9cbwpPABf4y
         //ag==
X-Gm-Message-State: APjAAAVJniwTwApOMueZdJHLuQcy3r8Y2Dq4pnwjzdamZDwhrxbjMlpk
        KCqiRotk8J5ZWjK0Yc+Gk7oncCWHwD6XY2c6P+MPAQ==
X-Google-Smtp-Source: APXvYqyzFqJJU+jMrmX1uODKhYjq6xcohFfDpDnVmwORCsbOF2gUtUeX/haJkfYX0w0qFiN7iCBERYot8KqrDxfVbBY=
X-Received: by 2002:a17:90a:2451:: with SMTP id h75mr13928203pje.131.1571437390713;
 Fri, 18 Oct 2019 15:23:10 -0700 (PDT)
MIME-Version: 1.0
References: <c99604e5-2ea4-4075-9a39-470104298368@googlegroups.com>
 <CAFd5g46+OMmP8mYsH8vcpMpdOeYryp=1Lsab4Hy6pAhWjX5-4Q@mail.gmail.com>
 <551223d0-7712-41df-90f2-3ca3da301435@googlegroups.com> <CAFd5g44EE3A3kXOFQD5vMOXZoJ_PzD=h9dac+KJmgxeXUycJGQ@mail.gmail.com>
 <20191018124346.GE11244@42.do-not-panic.com>
In-Reply-To: <20191018124346.GE11244@42.do-not-panic.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 18 Oct 2019 15:22:59 -0700
Message-ID: <CAFd5g44kumsD1W0uj_pgq7GVfuQWV2tiJ-PRBrOKOJ=oaEuung@mail.gmail.com>
Subject: Re: kunit.py should default to --build_dir=.kunit
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     "Theodore Ts'o" <theodore.tso@gmail.com>, shuah <shuah@kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 18, 2019 at 5:43 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Wed, Oct 16, 2019 at 02:02:52PM -0700, Brendan Higgins wrote:
> > Shuah's solution was just to use CONFIG fragments in the meantime
> > similar to what kselftest already does. I was leaning in that
> > direction since kselftest already does that and we know that it works.
> >
> > Shuah, Luis, does this still match what you have been thinking?
>
> I personally never use the selftest full config thing myself, however I
> do use subcomponent selftests configs as hints to edit my .config to add
> what I need and then run 'make menuconfig', in hopes that that leaves a
> .config with all that is needed.
>
> So indeed, I believe ethis works well for now, and it works for me.

Okay, good to know. So that is probably the right thing to do until we
can come up with a good solution to the dynamically generating an
allconfig problem.

> I've hinted elsewhere that there is a difference between what kernel
> features you have enabled Vs what components are needed / should we
> built to test the current target kernel .config. And even then, what we
> test in userspace is in my view different than what should be configured
> in the kernel. To scale this I think a respective .config for userspace

Sure.

> and respective symbols for testing may be in order, this way the
> userspace tests can only be visible say if you enabled certain features
> in your kernel.  How this gets exposed, etc, is a separate question,

I think that is a reasonable idea, but I don't think that really
applies here. I don't think it really makes sense to have the `make
kunit` that Ted is describing here do anything involving userspace.
That should just run the KUnit tests in the kernel. In anycase, I
expressed my ideas on the matter in more detail on the hybrid testing
thread[1].

> however I think this can be addressed later, and I believe Knut will
> likely be dealing with it during the KTF merge to kunit work as
> currently it addresses this via generic netlink, and we want something
> simple to start off with.

Cheers!

[1] https://lore.kernel.org/linux-kselftest/CAFd5g459xmO+=QPhnnXVO8+dB_t1PViXxK-Fz6Zp+sp5suJZ2w@mail.gmail.com/
