Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36A0015366D
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2020 18:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgBER2A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Feb 2020 12:28:00 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34131 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbgBER2A (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Feb 2020 12:28:00 -0500
Received: by mail-wm1-f65.google.com with SMTP id s144so4968363wme.1
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Feb 2020 09:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/J7K6eoBY50PYm0N/u4X3+dlKUZnt64LaOlAE9qk+tY=;
        b=lJaz2HSL0GodXUnBdAWn5vXGicOnSOjlEzL6WRhsXUYvoCwf2EksV/H80DsSr0HvVU
         jf5gZF9txDXrM3yAMqWtQrJa6rF6ZxYg2ABlbXin3ylMvhed2NeSefp4yc29oR7AO7Kq
         SForPuVGtkLxc0SWSZpIfaM7l+JRe3quj6YnZtk6CLCdH6Ya1+FowX4QH8PE8atAmrxL
         2mwslJZqu1/pZH8QJ9X3mo5JZXE2zX0ovIXlKc9ZS9JoWrcs0qZi3ZNp1BsgCSehUGC7
         pVPo2EESWoXfB1s0YdZHI7GfTR2svAMgYjRNn51zpIpuaTZN19/bg1o9tYC2NLTZCylr
         L8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/J7K6eoBY50PYm0N/u4X3+dlKUZnt64LaOlAE9qk+tY=;
        b=Xmch7J/qmODOt4mW+KITxpOKXzbGlyL0pjV9HcyKPRg0+a0Pz0Ah/czDIM/iNhtgbF
         1pkYrMKlvcHW4YECeGEQ16Mt0nF79w/6+NYy3cVhNrzirRp2wK4Fo609Nz+vVh42jyZL
         f2IlD/gD1nFEBiTvhkeMiuWjfeikajXxr442BnpM1jn8IJatvIX00ihzfba8y6QvMr1s
         Cx5zOubP1uRJIB+ymHtbfKo2P3rm4z9X8jfP5DClsUMT67q8nBG/MzxabK3YZy0NmLFz
         NSXz5zrn4gxZPeMNAcF1Va/tnu9FNSzuVgPhbnOk6NARcqwJxJYzOo2DeqoWRrM9dh+Y
         iWpA==
X-Gm-Message-State: APjAAAV59WhidrTG4t2Cpr7jXyUwr7m9L78KGkj5sJW+thfnjergWT0I
        qLFqBV4tEm9uAZDx4AheDS3jXykwIv8jZQgJcJSPBg==
X-Google-Smtp-Source: APXvYqynJh5j49aSDjFF+KSFSB3CwQRk6jra7/lReDNXiogMGUoOKebQhesHur67DC3ixje/LTjLJnSEbVX+e6ufw68=
X-Received: by 2002:a1c:6a15:: with SMTP id f21mr6625580wmc.126.1580923677710;
 Wed, 05 Feb 2020 09:27:57 -0800 (PST)
MIME-Version: 1.0
References: <20200120145635.GA30904@blackbody.suse.cz> <20200124114017.8363-1-mkoutny@suse.com>
 <20200124114017.8363-2-mkoutny@suse.com> <CAJuCfpGjC=YwY=oNnYFNDp2nCuR9YhSU95=xbbeoDEheemte+Q@mail.gmail.com>
In-Reply-To: <CAJuCfpGjC=YwY=oNnYFNDp2nCuR9YhSU95=xbbeoDEheemte+Q@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 5 Feb 2020 09:27:45 -0800
Message-ID: <CAJuCfpEq9c6cdEdqZOq6KDmxSHLNzby=46psRYpGxYhDT31yew@mail.gmail.com>
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

On Fri, Jan 24, 2020 at 2:56 PM Suren Baghdasaryan <surenb@google.com> wrot=
e:
>
> On Fri, Jan 24, 2020 at 3:40 AM Michal Koutn=C3=BD <mkoutny@suse.com> wro=
te:
> >
> > PF_EXITING is set earlier than actual removal from css_set when a task
> > is exitting. This can confuse cgroup.procs readers who see no PF_EXITIN=
G
> > tasks, however, rmdir is checking against css_set membership so it can
> > transitionally fail with EBUSY.
> >
> > Fix this by listing tasks that weren't unlinked from css_set active
> > lists.
> > It may happen that other users of the task iterator (without
> > CSS_TASK_ITER_PROCS) spot a PF_EXITING task before cgroup_exit(). This
> > is equal to the state before commit c03cd7738a83 ("cgroup: Include dyin=
g
> > leaders with live threads in PROCS iterations") but it may be reviewed
> > later.
> >
> > Reported-by: Suren Baghdasaryan <surenb@google.com>
> > Fixes: c03cd7738a83 ("cgroup: Include dying leaders with live threads i=
n PROCS iterations")
> > Signed-off-by: Michal Koutn=C3=BD <mkoutny@suse.com>
> > ---
> >  include/linux/cgroup.h |  1 +
> >  kernel/cgroup/cgroup.c | 23 ++++++++++++++++-------
> >  2 files changed, 17 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> > index d7ddebd0cdec..e75d2191226b 100644
> > --- a/include/linux/cgroup.h
> > +++ b/include/linux/cgroup.h
> > @@ -62,6 +62,7 @@ struct css_task_iter {
> >         struct list_head                *mg_tasks_head;
> >         struct list_head                *dying_tasks_head;
> >
> > +       struct list_head                *cur_tasks_head;
> >         struct css_set                  *cur_cset;
> >         struct css_set                  *cur_dcset;
> >         struct task_struct              *cur_task;
> > diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> > index 735af8f15f95..a6e3619e013b 100644
> > --- a/kernel/cgroup/cgroup.c
> > +++ b/kernel/cgroup/cgroup.c
> > @@ -4404,12 +4404,16 @@ static void css_task_iter_advance_css_set(struc=
t css_task_iter *it)
> >                 }
> >         } while (!css_set_populated(cset) && list_empty(&cset->dying_ta=
sks));
> >
> > -       if (!list_empty(&cset->tasks))
> > +       if (!list_empty(&cset->tasks)) {
> >                 it->task_pos =3D cset->tasks.next;
> > -       else if (!list_empty(&cset->mg_tasks))
> > +               it->cur_tasks_head =3D &cset->tasks;
> > +       } else if (!list_empty(&cset->mg_tasks)) {
> >                 it->task_pos =3D cset->mg_tasks.next;
> > -       else
> > +               it->cur_tasks_head =3D &cset->mg_tasks;
> > +       } else {
> >                 it->task_pos =3D cset->dying_tasks.next;
> > +               it->cur_tasks_head =3D &cset->dying_tasks;
> > +       }
> >
> >         it->tasks_head =3D &cset->tasks;
> >         it->mg_tasks_head =3D &cset->mg_tasks;
> > @@ -4467,10 +4471,14 @@ static void css_task_iter_advance(struct css_ta=
sk_iter *it)
> >                 else
> >                         it->task_pos =3D it->task_pos->next;
> >
> > -               if (it->task_pos =3D=3D it->tasks_head)
> > +               if (it->task_pos =3D=3D it->tasks_head) {
> >                         it->task_pos =3D it->mg_tasks_head->next;
> > -               if (it->task_pos =3D=3D it->mg_tasks_head)
> > +                       it->cur_tasks_head =3D it->mg_tasks_head;
> > +               }
> > +               if (it->task_pos =3D=3D it->mg_tasks_head) {
> >                         it->task_pos =3D it->dying_tasks_head->next;
> > +                       it->cur_tasks_head =3D it->dying_tasks_head;
> > +               }
> >                 if (it->task_pos =3D=3D it->dying_tasks_head)
> >                         css_task_iter_advance_css_set(it);
> >         } else {
> > @@ -4489,11 +4497,12 @@ static void css_task_iter_advance(struct css_ta=
sk_iter *it)
> >                         goto repeat;
> >
> >                 /* and dying leaders w/o live member threads */
> > -               if (!atomic_read(&task->signal->live))
> > +               if (it->cur_tasks_head =3D=3D it->dying_tasks_head &&
> > +                   !atomic_read(&task->signal->live))
> >                         goto repeat;
> >         } else {
> >                 /* skip all dying ones */
> > -               if (task->flags & PF_EXITING)
> > +               if (it->cur_tasks_head =3D=3D it->dying_tasks_head)
> >                         goto repeat;
> >         }
> >  }
> > --
> > 2.24.1
> >
>
> Tested-by: Suren Baghdasaryan <surenb@google.com>
>
> Thanks!

Hi Folks,
If this new version looks good could we get an Ack please? I need to
start backporting this fix to Android and would like a confirmation
before doing so.
Thanks!
