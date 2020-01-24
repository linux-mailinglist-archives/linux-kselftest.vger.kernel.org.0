Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A814F149172
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2020 23:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbgAXW5G (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Jan 2020 17:57:06 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46137 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729535AbgAXW5E (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Jan 2020 17:57:04 -0500
Received: by mail-wr1-f66.google.com with SMTP id z7so3914012wrl.13
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jan 2020 14:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fNqODm3MPzAsBSCY9n8l1wXAgR4AKgIMTb5pUp7NU0U=;
        b=srTj1j2mPK8t2sakwkD7rQEbDNeFFM9BwDp93dCsDs1Q20oZf59EZmlmAzOPPdf+4y
         YxcM9llvhHsbhRScaQhg5pfhZuQ5EK2Wiabt848H4kBft/yOeKD0KfLCT/l9W4a5Y1L4
         Ws4qptwOggL7bhfng7gBhzPp9HhaA+aTg36WNq74YBut1qhS4L/ZTMqXR3HYzj9r7FGA
         g3OhV0aJtCq6S5MwW9QcBqn3UQ760IxL5+/lie2pPtU7H3eL61wmjRFYGCWegua4o7px
         G9xsghTqHOYLmfB+t0+5wgQJi9Xa2XH6e7g4cwoQw8CdIX7jxs00HjMp1GrSPYPF2HYQ
         4/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fNqODm3MPzAsBSCY9n8l1wXAgR4AKgIMTb5pUp7NU0U=;
        b=SGRqRoFscbqHUNh3De0SJZBrML3G3GnjSXhkRQLhP4RmS/7hq8Bgf0SaE5cvu7bMQd
         jriFWg1fue5qtMxXn7vCji7XkHZ+fuWNkBgf61LE2VrpZNXL43KfiDR3X91hPYuF10Bb
         sk9ESmhYr07QEa032FPqTGqyLMlo7yraDas7rZin+zLxVXKmoG8tFRc4d62BKP/DjbsO
         25+SY1r1aR4rrqmUGLfmwOnHS1bwPyZON3uWu00fxT0RWc90oOBXLZvrd6rHvEAc1GJx
         s+IB3k0NE53tlLagKXJ70mWJflDpF4EFqs0TRNKx8INUHtEkAr9t2iwQ2+Quhil2+YwU
         cJpQ==
X-Gm-Message-State: APjAAAXKn7K+m2nVkE4dyXtEXu8Z4XefcjDo3NFECmhMT1qpoLWJHe1z
        8h1S/SLDfxN+7MOKfSVv1cOuwFVKLjHuf7cwtVyQUg==
X-Google-Smtp-Source: APXvYqzP4FnUZ8kt/z6sTrHwXtHilzjV/goyThoHUZqMef+SOku7Q5F6lD4mv864jnI2/qV48MsRq4J931iUvo8aLpk=
X-Received: by 2002:adf:e887:: with SMTP id d7mr6634585wrm.162.1579906622211;
 Fri, 24 Jan 2020 14:57:02 -0800 (PST)
MIME-Version: 1.0
References: <20200120145635.GA30904@blackbody.suse.cz> <20200124114017.8363-1-mkoutny@suse.com>
 <20200124114017.8363-2-mkoutny@suse.com>
In-Reply-To: <20200124114017.8363-2-mkoutny@suse.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 24 Jan 2020 14:56:51 -0800
Message-ID: <CAJuCfpGjC=YwY=oNnYFNDp2nCuR9YhSU95=xbbeoDEheemte+Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] cgroup: Iterate tasks that did not finish do_exit()
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     cgroups mailinglist <cgroups@vger.kernel.org>,
        alex.shi@linux.alibaba.com, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        kernel-team <kernel-team@android.com>,
        JeiFeng Lee <linger.lee@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        linux-mediatek@lists.infradead.org, Li Zefan <lizefan@huawei.com>,
        matthias.bgg@gmail.com, shuah@kernel.org,
        Tejun Heo <tj@kernel.org>, Tom Cherry <tomcherry@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jan 24, 2020 at 3:40 AM Michal Koutn=C3=BD <mkoutny@suse.com> wrote=
:
>
> PF_EXITING is set earlier than actual removal from css_set when a task
> is exitting. This can confuse cgroup.procs readers who see no PF_EXITING
> tasks, however, rmdir is checking against css_set membership so it can
> transitionally fail with EBUSY.
>
> Fix this by listing tasks that weren't unlinked from css_set active
> lists.
> It may happen that other users of the task iterator (without
> CSS_TASK_ITER_PROCS) spot a PF_EXITING task before cgroup_exit(). This
> is equal to the state before commit c03cd7738a83 ("cgroup: Include dying
> leaders with live threads in PROCS iterations") but it may be reviewed
> later.
>
> Reported-by: Suren Baghdasaryan <surenb@google.com>
> Fixes: c03cd7738a83 ("cgroup: Include dying leaders with live threads in =
PROCS iterations")
> Signed-off-by: Michal Koutn=C3=BD <mkoutny@suse.com>
> ---
>  include/linux/cgroup.h |  1 +
>  kernel/cgroup/cgroup.c | 23 ++++++++++++++++-------
>  2 files changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index d7ddebd0cdec..e75d2191226b 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -62,6 +62,7 @@ struct css_task_iter {
>         struct list_head                *mg_tasks_head;
>         struct list_head                *dying_tasks_head;
>
> +       struct list_head                *cur_tasks_head;
>         struct css_set                  *cur_cset;
>         struct css_set                  *cur_dcset;
>         struct task_struct              *cur_task;
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 735af8f15f95..a6e3619e013b 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -4404,12 +4404,16 @@ static void css_task_iter_advance_css_set(struct =
css_task_iter *it)
>                 }
>         } while (!css_set_populated(cset) && list_empty(&cset->dying_task=
s));
>
> -       if (!list_empty(&cset->tasks))
> +       if (!list_empty(&cset->tasks)) {
>                 it->task_pos =3D cset->tasks.next;
> -       else if (!list_empty(&cset->mg_tasks))
> +               it->cur_tasks_head =3D &cset->tasks;
> +       } else if (!list_empty(&cset->mg_tasks)) {
>                 it->task_pos =3D cset->mg_tasks.next;
> -       else
> +               it->cur_tasks_head =3D &cset->mg_tasks;
> +       } else {
>                 it->task_pos =3D cset->dying_tasks.next;
> +               it->cur_tasks_head =3D &cset->dying_tasks;
> +       }
>
>         it->tasks_head =3D &cset->tasks;
>         it->mg_tasks_head =3D &cset->mg_tasks;
> @@ -4467,10 +4471,14 @@ static void css_task_iter_advance(struct css_task=
_iter *it)
>                 else
>                         it->task_pos =3D it->task_pos->next;
>
> -               if (it->task_pos =3D=3D it->tasks_head)
> +               if (it->task_pos =3D=3D it->tasks_head) {
>                         it->task_pos =3D it->mg_tasks_head->next;
> -               if (it->task_pos =3D=3D it->mg_tasks_head)
> +                       it->cur_tasks_head =3D it->mg_tasks_head;
> +               }
> +               if (it->task_pos =3D=3D it->mg_tasks_head) {
>                         it->task_pos =3D it->dying_tasks_head->next;
> +                       it->cur_tasks_head =3D it->dying_tasks_head;
> +               }
>                 if (it->task_pos =3D=3D it->dying_tasks_head)
>                         css_task_iter_advance_css_set(it);
>         } else {
> @@ -4489,11 +4497,12 @@ static void css_task_iter_advance(struct css_task=
_iter *it)
>                         goto repeat;
>
>                 /* and dying leaders w/o live member threads */
> -               if (!atomic_read(&task->signal->live))
> +               if (it->cur_tasks_head =3D=3D it->dying_tasks_head &&
> +                   !atomic_read(&task->signal->live))
>                         goto repeat;
>         } else {
>                 /* skip all dying ones */
> -               if (task->flags & PF_EXITING)
> +               if (it->cur_tasks_head =3D=3D it->dying_tasks_head)
>                         goto repeat;
>         }
>  }
> --
> 2.24.1
>

Tested-by: Suren Baghdasaryan <surenb@google.com>

Thanks!
