Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA12B6A3A
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Sep 2019 20:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730139AbfIRSHR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Sep 2019 14:07:17 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44929 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729708AbfIRSHR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Sep 2019 14:07:17 -0400
Received: by mail-pf1-f196.google.com with SMTP id q21so482779pfn.11
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Sep 2019 11:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NDosSDmfQjatkG4wkOQpAvxMT8eQlYv0n1egSYiYo8Y=;
        b=EN5mzTyEKz0R+OYR61O7os0/JLlPH83xppejWSOkUPIn46QgYTUPmqZIMXkF2cHNzg
         iR6ospTXDHB8OcZCQYxzRQRG6RlaQ0V4PyCF4/sdrVnPy8T6J0bhnsx/JHjVAM+XnwuK
         cM5JD4COPmLVJpo33P+fFQ9rDSj8bJVAYyfZtr3YNW6/GJpEFj8tC/Kg7wgOhZKMzLoR
         mDUIcAi/oVSJJDbdU98Qlji0rz6+bnWIrPO8sYCFcR2yZP7/J1KAkJdSvvOglHrCHULs
         FDAG/UI75sYwfJNKANtZfNac4SYid/yiDqBj65b8lqRAmbewotNQLmxkgYsWvY+AXfsm
         Fqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NDosSDmfQjatkG4wkOQpAvxMT8eQlYv0n1egSYiYo8Y=;
        b=IUwAPbC/9lac3GuMPSxV82+3ztxxe+R9FDxiS4vrSKsPg+jA6wZoImnEiJGiEi3682
         0LARrVpx5P9bLcZNn9RK4pNowgTUM4g7ySx5ST1q6ySqMS8jlugx/0704Ltp5Q1ltwJ5
         +oxOsxEyKX3y0sjuygbdVpVryUUETX5BbXBj/G8L3/qse9Xud+HPgnn1CeKo0B5OjvQg
         M6m3cbJfQRPK1WSCuPPShC9pZ27SPs1B4GGgWhj5XPAdhdqkazpGjLCkxqwKk+/J6EE3
         bM1t51C3AxRzK8q6elj+bmoktdZMguAWFbVhG/lROQxu4mnhgotO9Z6wshfjtVqtsuJm
         ZAhw==
X-Gm-Message-State: APjAAAWZqfiBlMHcQxuf4hIcuUdLA4+Y7zAkpsnM2e7ens/oLaYy3kUz
        ARdRXiID6MoT+p5mF7sunBmxIw==
X-Google-Smtp-Source: APXvYqw1h+7+kJ3we2X7NX1MFJSWR3g+cC7SHypeuSUCcWEQ1a6wmTUaYa5Obud1oCLZjDB+QdBtUw==
X-Received: by 2002:a62:1a4d:: with SMTP id a74mr5583249pfa.179.1568830036523;
        Wed, 18 Sep 2019 11:07:16 -0700 (PDT)
Received: from cisco ([2601:282:901:dd7b:8ca:f826:700:a6])
        by smtp.gmail.com with ESMTPSA id d10sm9540877pfn.50.2019.09.18.11.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 11:07:15 -0700 (PDT)
Date:   Wed, 18 Sep 2019 12:07:12 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        luto@amacapital.net, jannh@google.com, wad@chromium.org,
        shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH 1/4] seccomp: add SECCOMP_RET_USER_NOTIF_ALLOW
Message-ID: <20190918180712.GG3835@cisco>
References: <20190918084833.9369-1-christian.brauner@ubuntu.com>
 <20190918084833.9369-2-christian.brauner@ubuntu.com>
 <201909181018.E3CEC9A81@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201909181018.E3CEC9A81@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 18, 2019 at 10:30:00AM -0700, Kees Cook wrote:
> On Wed, Sep 18, 2019 at 10:48:30AM +0200, Christian Brauner wrote:
> > This allows the seccomp notifier to continue a syscall. A positive
> > discussion about this feature was triggered by a post to the
> > ksummit-discuss mailing list (cf. [3]) and took place during KSummit
> > (cf. [1]) and again at the containers/checkpoint-restore
> > micro-conference at Linux Plumbers.
> > 
> > Recently we landed seccomp support for SECCOMP_RET_USER_NOTIF (cf. [4])
> > which enables a process (watchee) to retrieve an fd for its seccomp
> > filter. This fd can then be handed to another (usually more privileged)
> > process (watcher). The watcher will then be able to receive seccomp
> > messages about the syscalls having been performed by the watchee.
> > 
> > This feature is heavily used in some userspace workloads. For example,
> > it is currently used to intercept mknod() syscalls in user namespaces
> > aka in containers.
> > The mknod() syscall can be easily filtered based on dev_t. This allows
> > us to only intercept a very specific subset of mknod() syscalls.
> > Furthermore, mknod() is not possible in user namespaces toto coelo and
> > so intercepting and denying syscalls that are not in the whitelist on
> > accident is not a big deal. The watchee won't notice a difference.
> > 
> > In contrast to mknod(), a lot of other syscall we intercept (e.g.
> > setxattr()) cannot be easily filtered like mknod() because they have
> > pointer arguments. Additionally, some of them might actually succeed in
> > user namespaces (e.g. setxattr() for all "user.*" xattrs). Since we
> > currently cannot tell seccomp to continue from a user notifier we are
> > stuck with performing all of the syscalls in lieu of the container. This
> > is a huge security liability since it is extremely difficult to
> > correctly assume all of the necessary privileges of the calling task
> > such that the syscall can be successfully emulated without escaping
> > other additional security restrictions (think missing CAP_MKNOD for
> > mknod(), or MS_NODEV on a filesystem etc.). This can be solved by
> > telling seccomp to resume the syscall.
> > 
> > One thing that came up in the discussion was the problem that another
> > thread could change the memory after userspace has decided to let the
> > syscall continue which is a well known TOCTOU with seccomp which is
> > present in other ways already.
> > The discussion showed that this feature is already very useful for any
> > syscall without pointer arguments. For any accidentally intercepted
> > non-pointer syscall it is safe to continue.
> > For syscalls with pointer arguments there is a race but for any cautious
> > userspace and the main usec cases the race doesn't matter. The notifier
> > is intended to be used in a scenario where a more privileged watcher
> > supervises the syscalls of lesser privileged watchee to allow it to get
> > around kernel-enforced limitations by performing the syscall for it
> > whenever deemed save by the watcher. Hence, if a user tricks the watcher
> > into allowing a syscall they will either get a deny based on
> > kernel-enforced restrictions later or they will have changed the
> > arguments in such a way that they manage to perform a syscall with
> > arguments that they would've been allowed to do anyway.
> > In general, it is good to point out again, that the notifier fd was not
> > intended to allow userspace to implement a security policy but rather to
> > work around kernel security mechanisms in cases where the watcher knows
> > that a given action is safe to perform.
> > 
> > /* References */
> > [1]: https://linuxplumbersconf.org/event/4/contributions/560
> > [2]: https://linuxplumbersconf.org/event/4/contributions/477
> > [3]: https://lore.kernel.org/r/20190719093538.dhyopljyr5ns33qx@brauner.io
> > [4]: commit 6a21cc50f0c7 ("seccomp: add a return code to trap to userspace")
> > 
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Andy Lutomirski <luto@amacapital.net>
> > Cc: Will Drewry <wad@chromium.org>
> > Cc: Tycho Andersen <tycho@tycho.ws>
> > CC: Tyler Hicks <tyhicks@canonical.com>
> > Cc: Jann Horn <jannh@google.com>
> > ---
> >  include/uapi/linux/seccomp.h |  2 ++
> >  kernel/seccomp.c             | 24 ++++++++++++++++++++----
> >  2 files changed, 22 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
> > index 90734aa5aa36..2c23b9aa6383 100644
> > --- a/include/uapi/linux/seccomp.h
> > +++ b/include/uapi/linux/seccomp.h
> > @@ -76,6 +76,8 @@ struct seccomp_notif {
> >  	struct seccomp_data data;
> >  };
> >  
> > +#define SECCOMP_RET_USER_NOTIF_ALLOW 0x00000001
> 
> nit: I'd like to avoid confusion here about what "family" these flags
> belong to. "SECCOMP_RET_..." is used for the cBPF filter return action
> value, so let's instead call this:
> 
> #define SECCOMP_USER_NOTIF_CONTINUE	BIT(0)

+1, I was thinking maybe even SECCOMP_USER_NOTIF_FLAG_CONTINUE.

But the whole series (minus the patch that already exists) looks good
to me if we make this change:

Reviewed-by: Tycho Andersen <tycho@tycho.ws>
