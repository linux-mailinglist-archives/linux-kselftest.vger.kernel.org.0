Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15E2F1410F3
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2020 19:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbgAQSln (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Jan 2020 13:41:43 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32981 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbgAQSln (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Jan 2020 13:41:43 -0500
Received: by mail-wr1-f65.google.com with SMTP id b6so23734288wrq.0
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Jan 2020 10:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Hl2KZMvca+Q8kuDbq/WhLs/Rb2uaYU/dE+p/JdLh8Ok=;
        b=pya+t3ljvih0NEjKSrRArdnH313MxZONXt8kTq2RCSmOCsZP7KR3baPZAFPehTPQxx
         VuKQfkLNIc4O7hDdNydFUo+Rit+LleyvNPqIqy5948KMTJxnyj2MVgDSFofqnZqQS5Nx
         Or3Zo594/EnJk39EWoCRDMjG4V8NF2BmHRXws3l/1nFpofa/+Bvxs6YNhCcdsqG7x3wk
         vR24AbaUtYr8X6KA5iQGuwz6Z7LgbIrcG2vC/4HLMaSGjk6nSLQU3vF89b7ikkhwAMpc
         A800IqSQpGRJuHLz6yxrYHsfaVbVemOGjrYeY0sTZTYGZtjBtpiMZzaKyNvlSn/ysOZH
         U/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Hl2KZMvca+Q8kuDbq/WhLs/Rb2uaYU/dE+p/JdLh8Ok=;
        b=PUZ6nw8LPDs8QaC+6O73vqoMwKWfXk4K32mSzM6iKamJjrl3JNp0d++AZG8UX7vD75
         IRXr0hBUJtb8pgDeSU7JRVBqRRHipi/FhRUJwB62rleTvuDkmy7DI0fq84sfHXKj63iW
         X0BCr2wIv/SR+deyzjroiHd5WMbZX6FSaVqnwWjk3cPJZS1HsV4d274tCCSeqRgeU5ac
         xFsjOYwOFpGgJYpDHPsruBmOHWFxaJRUQvCSybNvWECP6JCD3a0htBvbi0jhgx7Nmghv
         Uvd3LThBn7pvrYg+RIcljh+bC9KwVtPRvtZ9CHe6vlvPlB2wwaZ9vi6IWLXc/IB0dSLr
         8wVw==
X-Gm-Message-State: APjAAAXbs8KMc89NKpTge6Xh+gAYN3BubCemqtxpgKlCi0M3inWkZf3D
        dgNCEo2UB5+upJFsrTqQfWa1e2ThxwvPiUEDqNPG7g==
X-Google-Smtp-Source: APXvYqy7GEdReDU3nlMa6hYZ9OrqeU0qE5bnCgOzJN8pNOYKrSXVI8Xbd+U1s/kjHmCr0FVwMIzZK3FVc56LwsF0buY=
X-Received: by 2002:adf:e887:: with SMTP id d7mr4490076wrm.162.1579286500370;
 Fri, 17 Jan 2020 10:41:40 -0800 (PST)
MIME-Version: 1.0
References: <20200116043612.52782-1-surenb@google.com> <20200117151533.12381-1-mkoutny@suse.com>
 <20200117151533.12381-3-mkoutny@suse.com> <20200117172806.GK2677547@devbig004.ftw2.facebook.com>
In-Reply-To: <20200117172806.GK2677547@devbig004.ftw2.facebook.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 17 Jan 2020 10:41:29 -0800
Message-ID: <CAJuCfpFqEUVFXsjD8XcCKsGXKTf72r0Ek5_1yqu_k5UZAssKTw@mail.gmail.com>
Subject: Re: [PATCH 2/3] cgroup: Iterate tasks that did not finish do_exit()
To:     Tejun Heo <tj@kernel.org>
Cc:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>, alex.shi@linux.alibaba.com,
        Roman Gushchin <guro@fb.com>,
        kernel-team <kernel-team@android.com>,
        JeiFeng Lee <linger.lee@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        shuah@kernel.org, Tom Cherry <tomcherry@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jan 17, 2020 at 9:28 AM Tejun Heo <tj@kernel.org> wrote:
>
> On Fri, Jan 17, 2020 at 04:15:32PM +0100, Michal Koutn=C3=BD wrote:
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

Tested-by: Suren Baghdasaryan <surenb@google.com>

>
> Yeah, this looks fine to me.  Any chance you can order this before the
> clean up so that we can mark it for -stable.
>

+1 for reordering. Makes it easier to backport.
Thanks,
Suren.

> Thanks.
>
> --
> tejun
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
