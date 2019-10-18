Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A058DDD28F
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Oct 2019 00:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391555AbfJRWMW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Oct 2019 18:12:22 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:34745 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390014AbfJRWMV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Oct 2019 18:12:21 -0400
Received: by mail-pg1-f176.google.com with SMTP id k20so4099681pgi.1
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Oct 2019 15:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FetT0tM90HzfRfVTAG8wVUH3dQZzL8bvcOngJje+KGw=;
        b=WnrDxsWzJJwxHbiiIfa09p4bEU4DQfRBT7AWtxciDnIv9oJcigQ3pARQuskaaOpR8p
         8bOvewqd2WzUtfvVO8iBfvXm+71jI9Zc+JTCKBo9UHaLMUYnZKUg3eYtIuMvjla3KYUC
         xYYbaKJGthpm/CeQR3lMgszKBYU/wABo7HdjlLiv2EGV6Wwb3HfiDTKl7DfhtGCD/WGp
         zLqTbQ1lSwPawuCL48IrPVSkg5YeaPwzuI5aSv9cfObKK8kMiKgasWgparTM8mpgBJxb
         Nb4PrUyTHGN+gE3N12FTw2kN22/GqCjRhDYTfJEiCzzzraB3ch3SDBbd6CwJC9jb2PqM
         MHcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FetT0tM90HzfRfVTAG8wVUH3dQZzL8bvcOngJje+KGw=;
        b=V3g/W1/bCRVds1A22OmayrQNcmVm3fzEvAanvkZVvKYG/AaECVngf0H7OEGMtUnBfP
         qTarJhLIwW5kUK0+kLrQMMOvVBYgP3nurHLdBbnjVrNVf48LecnvRg9QmmiSEe6fS/ZQ
         xqEKfZJTMj8aXwgH2it1zPXT3wOFnTkmQZaoSNQkJFFAsi25ih0rsullHV+FaYJ3v/wD
         6dYaTLD2SygJMwtyuL9JDmbWfTqdr3KsiLvwOzKYx8j1HFpbAOZmk6ITeCONq5rkVFGX
         sHkcsU5NMywc/TSSmEgQjVF/vyIuAWA42i89EiVoQlWFtoLPfE4W2IJl7DaQ+61ZoN2Q
         v9mg==
X-Gm-Message-State: APjAAAXp5al4g5t7vl5h3Zh4KWPLtxHMZXUQEiAsyUbBmmv/mczIt/yM
        L3v73GBod2tlOUXpjp/a/l54z8yfk07jxJDFyWIa0OT8fKM5kA==
X-Google-Smtp-Source: APXvYqxsStNw5zwJcR42wzIqJ1DfFlpzcZjKfVaJEpI7uDytoBDXZfBpO1vAWTeTWT77tn01nd9lxJ5T/NCD0zuH1/k=
X-Received: by 2002:a63:3044:: with SMTP id w65mr12080314pgw.384.1571436740160;
 Fri, 18 Oct 2019 15:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <c99604e5-2ea4-4075-9a39-470104298368@googlegroups.com>
 <CAFd5g46+OMmP8mYsH8vcpMpdOeYryp=1Lsab4Hy6pAhWjX5-4Q@mail.gmail.com>
 <291f012c-0ffd-599e-0dac-a6b4e05ebb97@infradead.org> <CAFd5g455KciviPA50cVDxK8XMB8ufcLrRq9DPA0d=f-1qXezWg@mail.gmail.com>
 <20191017125154.GD25548@mit.edu>
In-Reply-To: <20191017125154.GD25548@mit.edu>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 18 Oct 2019 15:12:08 -0700
Message-ID: <CAFd5g45S57PsghpOiL2+6qcEjUdMG1XSzU97fUqCvEV7XvOGQA@mail.gmail.com>
Subject: Re: kunit.py should default to --build_dir=.kunit
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Theodore Ts'o" <theodore.tso@gmail.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 17, 2019 at 5:51 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Wed, Oct 16, 2019 at 02:04:35PM -0700, Brendan Higgins wrote:
> > > > Should we maybe drop `--build_dir` in favor of `O`?
> > >
> > > Yes, preferably be consistent with the rest of the kernel makefiles.
> >
> > Alright, probably a good idea to make this change fairly soon then
> > before we have to worry about backwards compatibility and such.
>
> I'm not sure how this would work; so something like:
>
>     .../kunit.py run O=/build_dir

Seems reasonable to me.

> Should other flags we can pass in via the makefile processing, such as
> V=1, etc., also work?  What other things can we pass in via after the
> "run" command?

Hmmm...that's a good point. I don't know about V; probably need to
improve how kunit_tool displays build information for that to be
useful. I don't think that W is likely to be useful since I think that
is semantically a different operation than just running KUnit tests.

Probably don't want to forward ARCH, or CROSS_COMPILE or any of those.

Supporting some of these[1] seems useful.

> And if we're going to go this far, maybe we should make "make kunit"
> run tools/testing/kunit/kunit.py?

That seems reasonable. I was holding off on that initially because I
thought it might be a bridge too far in terms of putting KUnit in a
highly visible place. However, in hindsight, I think we crossed that
bridge a long time ago with putting tests is very visible places. So
yeah, now is probably a good time to do that.

> Some minor other nits if you're going to be making changes to
> kunit.py's CLI parsing:
>
> 1) It would be nice if there was a help command so that "kunit.py
>    help" does what kunit.py -h does.

Seems reasonable.

> 2) The top-level help message should indicate that "kunit.py run"
>    takes various optional arguments and the way to find them is
>    "kunit.py run -h".  This was *not* obvious, and the way I figured
>    out there was even --build_dir option was via purusing the source
>    code.  (It wasn't in the documentation that I could find.)

Also reasonable.

> 3) And maybe then "kunit.py help run" should display the help message
>    for "kunit.py urn".  This would make it consistent with other tools
>    that some of us might be familiar with (e.g., gcloud, gsutil, etc.)

That's reasonable, but also a little harder. At that point, I think we
might need to write our own flag library to support all this. So, I
will put this as a TODO, but we probably won't get to it for a while.

> Of course, if the front entry for kunit starts being "make kunit" as
> opposed to ./tools/testing/kunit/kunit.py, then we really need to
> figure out how to pass in the equivalent of --timeout.  (Maybe

Yeah, that's true. We should probably also by default set --timeout to
a reasonable default instead of infinite.

> --raw_output is enabled if we run make kunit V=1?).  And of course,

Hmmm...that seems like a good idea.

> all of this would need to be documented.

Yeah, we very much need to improve our documentation, especially for
the kunit_tool. That is very high on our TODO list.

[1] https://www.gnu.org/software/make/manual/html_node/Options-Summary.html
