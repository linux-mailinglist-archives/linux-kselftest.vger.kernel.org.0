Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87CCF201C0F
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jun 2020 22:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390113AbgFSUM2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Jun 2020 16:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390044AbgFSUM1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Jun 2020 16:12:27 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57765C0613EE
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Jun 2020 13:12:27 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ne5so4491817pjb.5
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Jun 2020 13:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CtL6MXEKzIeEStdpWr+Z+AY2ozIEH/pJKXnlCHuuM48=;
        b=JhzmdnUXuMgHKNez3rF4CNCqDonN/tgdYvlkkcY/gmPsUHMicehnsmLblPolT0WwCP
         jBS2JJcHqQG1V0nwykQ0NmhmhWrSfYF01b7DLyrDEHJFDrPzR1QitEqoxZXQYFz3FqJR
         YrKNN9+B5Pb8rAcdwHREZXyWpmcRScK+4i+0ol8nC/KODfzFmCrOrpZ7LA7DzlOFCBLP
         qjT6ZfI4bFvx0peh229/xx3Bx3hEpB2yDOZURUzmy3toPz6A2Jfkelvpiw7pkmY7K0q8
         CAPWGRC9EplTK1ob060zhSYPcTqcJQ9rC4nHw4wzmtkOnA/QUBrGlbR3sMJxiI8zzqvp
         6/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CtL6MXEKzIeEStdpWr+Z+AY2ozIEH/pJKXnlCHuuM48=;
        b=nMO9/bD58ZNCg9NLkJ5zePzSzVOIg5v/WyjFi0KmOh2GEr8QJmmalcNFIULYnbzlMV
         POAHpnP1lGUWEgxlaZVOS/cxHN743OuheHKWPedShj2SsfZ82vW7Q2SU2w4WuAIf7fcE
         PsbNkVVbqpLXnSPsIV8377v1CZ9csA8s7qfSVREP+3LnxESRYE6lhUsyKLTM6LyeV3PZ
         BWaLjoekZA3/pKb1Fiin7mRoYYewzWYe9Pr78bqRJo+psAYcc8VZeh+LZyHY2VJEQYL/
         nW1VryPeHLbO3UFVtOKO/tdFWRLGOhHyyhLYvXXmgyAhoWqgkfUX3hgdkv8I55ctu5KV
         LIRw==
X-Gm-Message-State: AOAM530RBVVwirl04JAmCd9nKeI3G5gA8AZYEFmljkLFN3PMlQiK4INl
        H/EXZnC0xAXVjGubK1ipY0M/ysY7h/E3LPRcv3Wztg==
X-Google-Smtp-Source: ABdhPJypxSlZuKQ8KcK9qjRv+cbeQn6Qu6jLWRyO3vg5JSCH4ChHL8jP7spzL1WH9TUNcBt0eMgqMcv9S+u+44HLvxE=
X-Received: by 2002:a17:90a:df82:: with SMTP id p2mr5255928pjv.217.1592597546456;
 Fri, 19 Jun 2020 13:12:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200611215501.213058-1-vitor@massaru.org> <202006121403.CF8D57C@keescook>
 <CABVgOSnofuJQ_fiCL-8KdKezg3Hnqk3A+X509c4YP_toKeBVBg@mail.gmail.com>
 <202006141005.BA19A9D3@keescook> <CABVgOSkPYBL8Qy9Fsr0owNhh2=tXZmdwCsWhnq+PshJLr06YKA@mail.gmail.com>
 <alpine.LRH.2.21.2006160956170.16027@localhost> <CABVgOS=-AHNABkAVV7p=pq67hwoVcXXJSEPvxNbp90Eh_RaxBg@mail.gmail.com>
 <CAFd5g44kZe7h+qKHmx029Qj15FdqxsFRFD3TEx_iEhPEt0jJmA@mail.gmail.com> <CABVgOSnjrzfFOMF0VE1-5Ks-e40fc0XZsNZ92jE60ZOhYmZWog@mail.gmail.com>
In-Reply-To: <CABVgOSnjrzfFOMF0VE1-5Ks-e40fc0XZsNZ92jE60ZOhYmZWog@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 19 Jun 2020 13:12:15 -0700
Message-ID: <CAFd5g45jHMZV3yHnxO-U3uCvhpPeOesHbuAgnzXOqtP-z7+Gmw@mail.gmail.com>
Subject: Re: common KUnit Kconfig and file naming (was: Re: [PATCH] lib:
 kunit_test_overflow: add KUnit test of check_*_overflow functions)
To:     David Gow <davidgow@google.com>
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Vitor Massaru Iha <vitor@massaru.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 18, 2020 at 11:39 PM David Gow <davidgow@google.com> wrote:
[...]
> On Fri, Jun 19, 2020 at 4:28 AM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > On Tue, Jun 16, 2020 at 9:21 PM David Gow <davidgow@google.com> wrote:
> > >
> > > On Tue, Jun 16, 2020 at 5:40 PM Alan Maguire <alan.maguire@oracle.com> wrote:
> > > >
> > > > On Tue, 16 Jun 2020, David Gow wrote:
[...]
> > > > > <keescook@chromium.org> wrote:
> > > > > >
> > > > > > On Sat, Jun 13, 2020 at 02:51:17PM +0800, David Gow wrote:

[...]

> > > - Test names: Personally, I'd kind-of like to not prefix these at all,
> > > as they're already part of the suite. If we do want to, though, prefix
> > > them with <subsystem> and <suite>.
> >
> > Eh, I did that to remain consistent with the kernel naming
> > conventions, but I think those have diverged too. If maintainers are
> > cool with it, I agree that the prefixes are redundant on tests and
> > generally way too long.
> >
>
> Do you have a link to the conventions you're talking about?

A link no. This is only of those undocumented rules that most people follow.

The rule is something like this:

Global identifiers should be named:
<subsystem_name_n>_<subsystem_name_n-1>_..._<subsystem_name_1>_<subsystem_name_0>_foo.

For example, let's say I am working on Synopsis' DesignWare I2C master
driver. The outermost namespace is i2c, and because DesignWare is
long, we might prefix each function with i2c_dw_*.

It is a practice that is not universally maintained around the kernel,
but it seems to be the most common method of namespacing aside from
just randomly throwing characters together in a prefix that hasn't
been used before.

Anyway, standardized or not, that is the convention I was trying to follow.
