Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEAE5F9DA1
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2019 00:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfKLXBb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Nov 2019 18:01:31 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40067 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbfKLXBa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Nov 2019 18:01:30 -0500
Received: by mail-pl1-f196.google.com with SMTP id e3so164747plt.7
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Nov 2019 15:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nExhpa8NtyhyvUyh20F6httON+9jpHubOC8X4R1/1QI=;
        b=c4HijsXEjZGJqE7HF/OLTdBXGVnY9qLmNBULMzMpbSwMDUdlWMyYkBAj7Jv9KvJQq9
         uQ/fhhX6CbwBVqkc6vhI0J9bVR6S+eypweTAwvYsABomRnDDk1wGcU2hJ/fV4/K6uu+1
         c9+G8zkVxO8gfkNV8xNJ/wUCIdP5veO1BJPEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nExhpa8NtyhyvUyh20F6httON+9jpHubOC8X4R1/1QI=;
        b=U/qvW9C3YRJe8yj8lgYfm804Fy78W9l8zkIXSD/WLDR5ACa64Ib2NqmLQsY8UxUpIg
         jmkVVHML5eY0RJYD/zgto+0LBCi9wKgdvFIAF7dUahNUgSEBDRjq+er3qM+l2jN0LDzE
         Lj0kmooEGAdewtsvkhmvOdzkXsqf7vgaJOnAtONyUY97hUizApjBJFDl2zQQd3kGLb+p
         fUeRAg2eJbjhPdg+2YhYKsMi35q5kKfnBv44a7nJR5oyjLqzNH27mdaNibIqFPiI8O5O
         5xdpzIQCAwNyQsv8Q2BS1NCym6Ne/amRvnusjwx+/CVB0Z0FeyveYfCCV5eggOjxbz0Z
         mQpg==
X-Gm-Message-State: APjAAAWqRPhXG5BG0loVrWKs25hIV6P24bddnRG48DP6B6anm7dfksls
        bDztWYEEBOsSqkLJUcD1u7RoJQ==
X-Google-Smtp-Source: APXvYqy/dNw+1S0sgv4o54+xgQ9m/sDAbXJguDm6De1m1sF3Ucjez84Z50LDqlIQCV97XGMiY2eUjw==
X-Received: by 2002:a17:902:b282:: with SMTP id u2mr266015plr.301.1573599688858;
        Tue, 12 Nov 2019 15:01:28 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id em16sm159840pjb.21.2019.11.12.15.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 15:01:27 -0800 (PST)
Date:   Tue, 12 Nov 2019 15:01:26 -0800
From:   Kees Cook <keescook@chromium.org>
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
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, libc-alpha@sourceware.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v15 0/9] open: introduce openat2(2) syscall
Message-ID: <201911121457.7D02692@keescook>
References: <20191105090553.6350-1-cyphar@cyphar.com>
 <20191111132404.y523iqicbn6fivx5@yavin.dot.cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111132404.y523iqicbn6fivx5@yavin.dot.cyphar.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 12, 2019 at 12:24:04AM +1100, Aleksa Sarai wrote:
> On 2019-11-05, Aleksa Sarai <cyphar@cyphar.com> wrote:
> > This patchset is being developed here:
> >   <https://github.com/cyphar/linux/tree/openat2/master>
> > 
> > Patch changelog:
> >  v15:
> >   * Fix code style for LOOKUP_IN_ROOT handling in path_init(). [Linus Torvalds]
> >   * Split out patches for each individual LOOKUP flag.
> >   * Reword commit messages to give more background information about the
> >     series, as well as mention the semantics of each flag in more detail.
> > [...]
> 
> Ping -- this patch hasn't been touched for a week. Thanks.

If I've been following correctly, everyone is happy with this series.
(i.e. Linus's comment appear to have been addressed.)

Perhaps the next question is should this go via a pull request by you to
Linus directly during the v5.5 merge window, via akpm, via akpm, via
Christian, or some other path? Besides Linus, it's not been clear who
should "claim" this series. :)

-- 
Kees Cook
