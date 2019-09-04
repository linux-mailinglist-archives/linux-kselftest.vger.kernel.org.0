Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8FB2A9559
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2019 23:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbfIDVml (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Sep 2019 17:42:41 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35491 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbfIDVml (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Sep 2019 17:42:41 -0400
Received: by mail-lf1-f68.google.com with SMTP id w6so232398lfl.2
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Sep 2019 14:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=afyKDAGEEGBbAV94gj2UOZt2XiwokGAAZY9fEg48q/g=;
        b=NaaXzsE03/A0aggT0JGsMPgqMPOgw689sbkH2wUyL6Wp3qKaZ1pKjDt9q3nSCqMPah
         2e4dX/SHASPLfri+fuLDS7WlObVzMB0uCQ613gb+lr0h/VEtc5FGRP26lR62YK8De+Ct
         /QjcaW9K7a4FCLT2Siyb/L/tVCZoNkYi2RP38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=afyKDAGEEGBbAV94gj2UOZt2XiwokGAAZY9fEg48q/g=;
        b=RMTH0OQ5Vw1ASDcOInk8TiboEAUi6OeZnPs6BMXNbTWEOA4FyrrUeLjOd4Q7Lm5U33
         2I/IFWsrk9Uor+fOdfLo80ukidUP5OXPvd2tOvd2voJ/FlZzHQNOx+ECCIWNDanCgvaS
         3HHWb8OZFV/inudj6Do7PS1EZQVGzBmn2+h1nnMP0cGew28dgxuQbLgr2iokkU4Q8spD
         XIYbx2l/cf27U5Fwtkhsd4RzfQ9eZpmZWLa6iT0ENYsTQtBRoysLzl47sD6EOBFg3nXI
         pxJNxkULwU7W4kV5dd1phD3ew+MchmROBMRk0YsMWtE3WYkgij6IUwyam1ZTP5kLmO7/
         JPNw==
X-Gm-Message-State: APjAAAXk7abGhWySzRQrfezXcLr8vj/1A5mv9EA+y1ZOI9MAuzGwLF5P
        Wi0htEy/F+Dg7EBru0z9KhgiTfKjeOs=
X-Google-Smtp-Source: APXvYqxs31cTn05sDaOJghwkt8zyvdlfJsHru6Cawhhv5QKKcChk3/3jyXJ4HCqpIjtN1eDIcarU3w==
X-Received: by 2002:ac2:495e:: with SMTP id o30mr178861lfi.82.1567633358949;
        Wed, 04 Sep 2019 14:42:38 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id k28sm16089lfj.33.2019.09.04.14.42.38
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2019 14:42:38 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id c12so217826lfh.5
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Sep 2019 14:42:38 -0700 (PDT)
X-Received: by 2002:a05:6512:512:: with SMTP id o18mr154625lfb.170.1567633024273;
 Wed, 04 Sep 2019 14:37:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190904201933.10736-1-cyphar@cyphar.com> <20190904201933.10736-11-cyphar@cyphar.com>
 <CAHk-=wiod1rQMU+6Zew=cLE8uX4tUdf42bM5eKngMnNVS2My7g@mail.gmail.com> <CAHk-=wiHRW3Z9xPRiExi9jLjB0cdGhM=3vaW+b80mjuRcbORyw@mail.gmail.com>
In-Reply-To: <CAHk-=wiHRW3Z9xPRiExi9jLjB0cdGhM=3vaW+b80mjuRcbORyw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 4 Sep 2019 14:36:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiExfaVhUTvKj7hR6DG4C2+oy6usz0Sa6QbPr5EgDH28w@mail.gmail.com>
Message-ID: <CAHk-=wiExfaVhUTvKj7hR6DG4C2+oy6usz0Sa6QbPr5EgDH28w@mail.gmail.com>
Subject: Re: [PATCH v12 10/12] namei: aggressively check for nd->root escape
 on ".." resolution
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Aleksa Sarai <asarai@suse.de>,
        Linux Containers <containers@lists.linux-foundation.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 4, 2019 at 2:35 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Sep 4, 2019 at 2:09 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > So you'd have three stages:
> >
> >  1) ".." always returns -EXDEV
> >
> >  2) ".." returns -EXDEV if there was a concurrent rename/mount
> >
> >  3) ".." returns -EXDEV if there was a concurrent rename/mount and we
> > reset the sequence numbers and check if you escaped.
>
> In fact, I wonder if this should return -EAGAIN instead - to say that
> "retrying may work".

And here "this" was meant to be "case 2" - I was moving the quoted
text around and didn't fix my wording, so now it is ambiguous or
implies #3, which would be crazy.

Sorry for the confusion,

            Linus
