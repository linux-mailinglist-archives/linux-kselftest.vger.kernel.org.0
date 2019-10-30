Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82003EA3B5
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2019 20:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfJ3TCc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Oct 2019 15:02:32 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40624 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfJ3TCb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Oct 2019 15:02:31 -0400
Received: by mail-pf1-f193.google.com with SMTP id r4so2218779pfl.7
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Oct 2019 12:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oGDBahFoMPSIZ29sHXhe1mehZlhHuZjEGPvioRijuyg=;
        b=ITHLhKwYHLawxDKJoXVFazyKfWfmJx5VWQYSzCXI3uwCtcs0q7fLyaj9SL04wb9vsM
         RlSKIzlfu4E7whMcthOGZ0RckEeTvwu4OzrBanTEIRe9aOYcmYXOA8e4hm7V0kDaVqJU
         d50WeQX+Habf5zhjgR6kw/cCCYQZ5jn9IttQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oGDBahFoMPSIZ29sHXhe1mehZlhHuZjEGPvioRijuyg=;
        b=W7A0IJXO5cRcPkDsn1g0GYzLSKOk6036j7aY+v8M2lhgzH5Q6zPaspNvwlHcC0gqlx
         taQXJ7cWKz7WxbFz6CrRjXoV5i4NdvglMHUB5vFd2AqGrD/PKmBfV5OxIjOmaU8JhEFw
         3JmgmQroy8NOWik8ciTsUQq91B/hpk/+O0K7UnPcjtYUhsO55HH+9YlSjfTVgNcKmyYm
         PnEDgCCn0B0sT47rDLgd5jsQ1hRnV7gx8xHZ5PK1YrMEuyUb6RhArSAKLE0hKQU27fQ/
         Y3aGuLcKFbsNcPZvEn7R64dAVfZ8kniyJBuQZjoxUECFL07OhZnC5kUonU8K9gKIGdX7
         hzNA==
X-Gm-Message-State: APjAAAWVUiLaQWunnMIQIeCE+z1TVjHRgSjPg9dtq8jV7xyvh+9QN98M
        YWj2+OrsBLc8vw/mm+lAX+1ISQ==
X-Google-Smtp-Source: APXvYqzota95kx11bi1wNxwIZc9AQEa/YsaYDEtNJUaPGRly4YWFB/enVi4ZfTsIfFi/BRYxa1QUGQ==
X-Received: by 2002:a62:83c6:: with SMTP id h189mr892782pfe.213.1572462149354;
        Wed, 30 Oct 2019 12:02:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j26sm508386pgi.92.2019.10.30.12.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 12:02:28 -0700 (PDT)
Date:   Wed, 30 Oct 2019 12:02:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Brendan Higgins <brendanhiggins@google.com>
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
Subject: Re: [PATCH linux-kselftest/test v1] apparmor: add AppArmor KUnit
 tests for policy unpack
Message-ID: <201910301201.404F0E3BB@keescook>
References: <20191018001816.94460-1-brendanhiggins@google.com>
 <20191018004307.GA95597@google.com>
 <20191018162519.GH21137@mit.edu>
 <CAFd5g45LmnbD7L4LqdbfBV5YR377e81m61+z==RKCGjWBFqDGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g45LmnbD7L4LqdbfBV5YR377e81m61+z==RKCGjWBFqDGQ@mail.gmail.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 18, 2019 at 02:41:38PM -0700, Brendan Higgins wrote:
> On Fri, Oct 18, 2019 at 9:25 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> >
> > On Thu, Oct 17, 2019 at 05:43:07PM -0700, Brendan Higgins wrote:
> > > > +config SECURITY_APPARMOR_TEST
> > > > +   bool "Build KUnit tests for policy_unpack.c"
> > > > +   default n
> > > > +   depends on KUNIT && SECURITY_APPARMOR
> > >
> > > Ted, here is an example where doing select on direct dependencies is
> > > tricky because SECURITY_APPARMOR has a number of indirect dependencies.
> >
> > Well, that could be solved by adding a select on all of the indirect
> > dependencies.  I did get your point about the fact that we could have
> 
> In this particular case that would work.
> 
> > cases where the indirect dependencies might conflict with one another.
> > That's going to be a tough situation regardless of whether we have a
> > sat-solver or a human who has to struggle with that situation.
> 
> But yeah, that's the real problem.

I think at this stage we want to make it _possible_ to write tests
sanely without causing all kinds of headaches. I think "build all the
tests" can just be a function of "allmodconfig" and leave it at that
until we have cases we really need to deal with.

-- 
Kees Cook
