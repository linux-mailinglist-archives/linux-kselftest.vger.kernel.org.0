Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 229EDD4DCC
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2019 08:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbfJLGxs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 12 Oct 2019 02:53:48 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35414 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728821AbfJLGxs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 12 Oct 2019 02:53:48 -0400
Received: by mail-ed1-f67.google.com with SMTP id v8so10565719eds.2;
        Fri, 11 Oct 2019 23:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=BHDcnsQSrbWE+Pwo7S+n8GHA2q4eny0JAFUJGKe7xZ8=;
        b=PbU0a8kowD3t6HBy71saesdP3fKlVa1vMs/phqLjOSTHNJKbukN3u4Tyw9JBYTjfGK
         KmjzoK9sb6/xvZtwS8NTny6aibTAjo9w830m/FVcOSEmeFlewHjgCWFjLA+mAYpESwL2
         dCI6N/Gk/gs51Hlh21r0vZZsjgEB0Xj3xfhVTiAE7Z3rTQzx0kpRLu4Ux+XjL/NMf940
         VUgjoXAcZq/oplrXxk6tTvgQiYQpyrsxkI8Td0rRZh/q3On+yiAM62rjCwjOMjTAfn7y
         4Xh6Dw1JvVN8hkEQh/TnEtedqvIlQc7gU9wdiJtJkm05Mjs+2zdTWXCclY3CwXFrxap+
         xM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=BHDcnsQSrbWE+Pwo7S+n8GHA2q4eny0JAFUJGKe7xZ8=;
        b=P86Q/i/6HQ0AhQAEuqsV1U12x+nQA6XvmfWvWsgIUWaxY0HqYwYTgql8x+mcqsMVGn
         oZ48u9C/20AKMiJU3eUhFdjG5kva2IBa1OjAR3dN+jkux1HrNjoaRWh4w1AP3pfloaWP
         um20eo6OieRHVp304VSQ/xzm9k54IDaDXWqplLQbqiWkujU8U/vSNDo0FFMXDZZyBBcC
         VamOG6sYku0Aj9/X80AtDOJTLVozVAsAiSTYGU4ug7b/gPmyS+2HzB/2UVe3jmszwqAv
         yFqVY1JXCUSegqvR4FZwnUGMMtJ0qwaH+gKf4nNlW9vhAsdmB2kUX8Y4Xr+e24ptrHQc
         obEw==
X-Gm-Message-State: APjAAAUtWAm3bCK2E8fP+doT6mrakWLDMNJlzxA5paeKI8B4l9JzF93O
        +6WO74RvSk/LlVvT3fTJkqU8xKAyhr1rPb1kk5s=
X-Google-Smtp-Source: APXvYqzh1JhXn6wt25rBXxwiyzDYbOv7kAXqapBl3dI3xpJuHLNnt136lJlkwVriE3147d0sP1DVJNPzWbR1pVBgw1k=
X-Received: by 2002:a17:906:792:: with SMTP id l18mr17349024ejc.170.1570863226323;
 Fri, 11 Oct 2019 23:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <20191010133518.5420-1-christian.brauner@ubuntu.com>
 <CAHO5Pa3V7fDb_+U-v+LB+TeAU0vfJyUMs9mD4ZqUtbLpZcD4nA@mail.gmail.com> <20191011221208.5eglbazksfigliob@yavin.dot.cyphar.com>
In-Reply-To: <20191011221208.5eglbazksfigliob@yavin.dot.cyphar.com>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Sat, 12 Oct 2019 08:53:34 +0200
Message-ID: <CAKgNAkhgGhGi-hMJt3UxYYDuyOZLx7c-eucpD5V7js+hsyv2CQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] clone3: add CLONE3_CLEAR_SIGHAND
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello Aleksa,

On Sat, 12 Oct 2019 at 00:12, Aleksa Sarai <cyphar@cyphar.com> wrote:
>
> On 2019-10-11, Michael Kerrisk <mtk.manpages@gmail.com> wrote:
> > Why CLONE3_CLEAR_SIGHAND rather than just CLONE_CLEAR_SIGHAND?
>
> There are no more flag bits left for the classic clone()/clone2() (the
> last one was used up by CLONE_PIDFD) -- thus this flag is clone3()-only.

Yes, I understand that. But, I'm not sure that the "3" in the prefix
is necessary. "CLONE_" still seems better to me.

Consider this: sometime in the near future we will probably have time
namespaces. The new flag for those namespaces will only be usable with
clone3(). It should NOT be called CLONE3_NEWTIME, but rather
CLONE_NEWTIME (or similar), because that same flag will presumably
also be used in other APIs such as unshare() and setns(). (Hmm -- I
wonder if we are going to need a new unshare2() or some such...)

Thanks,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
