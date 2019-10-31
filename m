Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83134EAC09
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2019 10:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfJaJB4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Oct 2019 05:01:56 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44619 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfJaJBz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Oct 2019 05:01:55 -0400
Received: by mail-pl1-f194.google.com with SMTP id q16so2418492pll.11
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Oct 2019 02:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y+lN6OouBuoSQt3ETowJ/+pYDKU3ueEIqgC5n3IlEcQ=;
        b=XfIzIH3h2eLFU9EjoJKF0OPU/HRYonBmX8s1z/SEss99D8tpfL9bbiZhKhXCSGRdd+
         CJRGhu6b9KeI1ZxcXGkZTYWKzeBDhkfrDGoL4YslFSntF7tmY1Su8GarxX4FJsvC09iv
         VpPbF3zI3XKkXC5esWyLJFqiPR82fBe24X8G2td9u40dvG8Zreq0vassekWSSvmpQwZX
         ybf3+w6TiFeUopfVf0lxGNI/1NINenwJ7IDhhug0DNRzJCH3jJeDlOIjYGXwfUiaC2Gk
         htgg0gwd6stxCQe/dklWynj2OlRwk6ctcZC2eTNzt82qGIYPKX62v5UIigUpDCjltx2N
         yj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y+lN6OouBuoSQt3ETowJ/+pYDKU3ueEIqgC5n3IlEcQ=;
        b=tjORp8T5tpkbbyPsgVSQ+UmjsqCeUU09Pb6VAfeZavN0Hvkm3rMrZxLQR2j2Xjipp4
         DATzGoSoqG3YtScR2JrB/v80qgorYGXRBBgTMi0ATOxQma1JENdVER7iMfR6bJCL/8Or
         1/3YrxBQ9G4L1sEdVS4P1QPz/+SD9558cVMRFNOJi7MrVXDCgaEn9qldpiQgSLP/fYik
         PZnfAA3d9s+5hVwQQ3F+MWCW1OuqQDw507GgRMbOmeY46sUeDQLbfPM8XvQ40t5dYRVq
         kpXqvDRiGX6c6grZL8ucl/WirNT6oeyCdmWPb1Icf8gKuHvR8ztctCAi0GVAAms1Ewh8
         yfvQ==
X-Gm-Message-State: APjAAAWjQjNZOJ4Vw/7ScGJgJXNXTuTti75kVMDJYw5kAzzLq//EXXPx
        9R7w22B3A3WGRNtBxzfJJ/aAYMjYsyGt83t4eC97Vg==
X-Google-Smtp-Source: APXvYqz9plcKuS+v8/NxTpBOgu2B8ITr8Y7Zp3UldgNEcoB9VWmT4ZIzBtm17H78/y8tZZlxr7vL1O/Fbmrx0TUcOCI=
X-Received: by 2002:a17:902:7b87:: with SMTP id w7mr5316993pll.325.1572512514689;
 Thu, 31 Oct 2019 02:01:54 -0700 (PDT)
MIME-Version: 1.0
References: <20191018001816.94460-1-brendanhiggins@google.com>
 <20191018004307.GA95597@google.com> <20191018162519.GH21137@mit.edu>
 <CAFd5g45LmnbD7L4LqdbfBV5YR377e81m61+z==RKCGjWBFqDGQ@mail.gmail.com> <201910301201.404F0E3BB@keescook>
In-Reply-To: <201910301201.404F0E3BB@keescook>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 31 Oct 2019 02:01:43 -0700
Message-ID: <CAFd5g45mEO5iFgACvKSzBOCtyGfOonL4g-9FvDyS=5g+irwQYw@mail.gmail.com>
Subject: Re: [PATCH linux-kselftest/test v1] apparmor: add AppArmor KUnit
 tests for policy unpack
To:     Kees Cook <keescook@chromium.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, shuah <shuah@kernel.org>,
        John Johansen <john.johansen@canonical.com>, jmorris@namei.org,
        serge@hallyn.com, Alan Maguire <alan.maguire@oracle.com>,
        Iurii Zaikin <yzaikin@google.com>,
        David Gow <davidgow@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Mike Salvatore <mike.salvatore@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 30, 2019 at 12:02 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Oct 18, 2019 at 02:41:38PM -0700, Brendan Higgins wrote:
> > On Fri, Oct 18, 2019 at 9:25 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> > >
> > > On Thu, Oct 17, 2019 at 05:43:07PM -0700, Brendan Higgins wrote:
> > > > > +config SECURITY_APPARMOR_TEST
> > > > > +   bool "Build KUnit tests for policy_unpack.c"
> > > > > +   default n
> > > > > +   depends on KUNIT && SECURITY_APPARMOR
> > > >
> > > > Ted, here is an example where doing select on direct dependencies is
> > > > tricky because SECURITY_APPARMOR has a number of indirect dependencies.
> > >
> > > Well, that could be solved by adding a select on all of the indirect
> > > dependencies.  I did get your point about the fact that we could have
> >
> > In this particular case that would work.
> >
> > > cases where the indirect dependencies might conflict with one another.
> > > That's going to be a tough situation regardless of whether we have a
> > > sat-solver or a human who has to struggle with that situation.
> >
> > But yeah, that's the real problem.
>
> I think at this stage we want to make it _possible_ to write tests
> sanely without causing all kinds of headaches. I think "build all the
> tests" can just be a function of "allmodconfig" and leave it at that
> until we have cases we really need to deal with.

That...appears to work. I really can't see any reason why that isn't
good enough for now.

I am surprised that this hasn't been suggested yet.

Thanks!
