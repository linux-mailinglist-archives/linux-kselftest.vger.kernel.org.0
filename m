Return-Path: <linux-kselftest+bounces-6456-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB6D881A14
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Mar 2024 00:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EDFE1C2134F
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Mar 2024 23:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B475986130;
	Wed, 20 Mar 2024 23:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHTaeHuw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BEB85C7F;
	Wed, 20 Mar 2024 23:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710975953; cv=none; b=E9ioDgWIR5CqB4pc2wbMkcbplkW77M1JqeaJZGsS5TKLbQN8xKHAWRykBHLimVLW8dNzh2bbR040H0lj1XbHhtnHS9WoZMc143aoMQNpw7Q5oIhvD4g/IBmcG+VVGXtLuGNme+Zuf+3EoUkSNh75WFqownKRFxc9zx4n4vs2dKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710975953; c=relaxed/simple;
	bh=ELyhYMDZed5LfXvPYq9GtdT7SjQr8w1n1G6fOIXkz9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KgG3CmcbROjQ9P+0q6r4yvs1qXDUIk/icrljYaQWTV1wbErdLkqOM2Bm85T9Um87+wOv/qtFQX8BUEt68SG6x3fRv/YGvBTAqR2xYYdKSx2Fy1/imVU22mXE7g61s8+7n0OxG3oSvGE9iRYzUBy4xMdvVo3alC6Fz/ibKLQm+m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHTaeHuw; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3412f49bac7so239744f8f.0;
        Wed, 20 Mar 2024 16:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710975950; x=1711580750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yG+x+jaCoD6sMzDeeYBU8wB6RIeoBL6DiU2NzqQrX6g=;
        b=XHTaeHuwsJJimootsiKCyw4pHycHMCWWEKXQ47rBaewttwFEi4Jpzb311wzMBkAPQb
         iNIV/vdyC8jYLL2zn8YJPxL/7piVmJ/Viq0JchTIgir+nSVLc9i+QNYNNg13iDc//V8K
         RCvBJ5sNqZ2/SCq60sV7E08vS5TMzagqUUoltSc+hvEdIKbkKwgkG/3bb8V9+rG0YR5V
         pOD7MWwfoCaQMTxxZ3btVFpdqA/Ygrc7+CNtqr8ELIOb2Wi1L8zOeE6LUCUMwB/f/kIU
         OzKD7TnYiSE0FSh6+AVjDEh90PAEiIIH9MOB3mFrmiZ2CiwJmpmUlIRSlLo7g7IGzhb/
         u05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710975950; x=1711580750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yG+x+jaCoD6sMzDeeYBU8wB6RIeoBL6DiU2NzqQrX6g=;
        b=Xr2X3Y/BaVvkVY8hkMCF481NoSGC8zkX2pjPlgXJZcjQ3jFzsdYaB08Zmez+jT+c0X
         gvPRe5Js74GFzKw1whb7sWHrJnzdz2tN9VMW48jIUp/IUiMt8uE9vA4MKI7uGygzSypW
         1ZQtvirqmMcRaXepQFIZdYOx7MwI84hf0PCcgQFgpRxkrsLmwrY3FRH+RHsXyCta1aXB
         U24YTNJ7M89c6LIJ0MukZDqs0Sd9mTNRjGDO3fAjK4Bap+uvz/a1WAQT4dzaGXANc33W
         Eck+ltG2sLrrW5uDvXzTPIE6wHldOzBYCrIUZIkOWbAbxXewcr9TB5JBgznPnIsaONRf
         zOUg==
X-Forwarded-Encrypted: i=1; AJvYcCWQPRr4E5fXRn4ExlbtxknUIfu8DSqxN8IpmQG24syCzcBO54kUDS0+mfiJvzM2mepY1YKBenkK6u+jW1aOOYw5TrIOrVnp/gPp9rnKlUtb0WEOWCqtzDnt9oqY37METbGkHcqNxf/o7hBXUMOHzVz34tUXmZUvjmhFIetb7khhy3MB
X-Gm-Message-State: AOJu0YwtkDdnykpiKCItvNNqiGBc3ijkQsbgHRcPUJrVrZqjpCVGQ76w
	Zmri6DWwI7i8H99Ux2vWsjNH4mlqs+rABbiaZ7qEbRypI3Opan9ANz4xlq2t3XLI/BNIrawMVvs
	27gQOZNlMhnkQi+8oXnWB5IKnFBo=
X-Google-Smtp-Source: AGHT+IHjpYfe2cpITcZt0Bmhy3zO3JabTkcQRk31hDBaFg0+bErKPWOGxypSYPor1TZYoSpm5/ECmKeYDVahQzcCwQU=
X-Received: by 2002:adf:f9d0:0:b0:33e:c528:c900 with SMTP id
 w16-20020adff9d0000000b0033ec528c900mr293487wrr.55.1710975950002; Wed, 20 Mar
 2024 16:05:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319050302.1085006-1-josef@netflix.com> <Zfr1jQ6W6yaLsHID@mtj.duckdns.org>
In-Reply-To: <Zfr1jQ6W6yaLsHID@mtj.duckdns.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 20 Mar 2024 16:05:38 -0700
Message-ID: <CAADnVQJV83CB+ENhRzwNyFbA8rdq3ZGtx6A8Jm7d+Wx9p2rgow@mail.gmail.com>
Subject: Re: [PATCH V3 bpf-next 1/2] bpf: add bpf_task_get_cgroup kfunc
To: Tejun Heo <tj@kernel.org>
Cc: Jose Fernandez <josef@netflix.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Tycho Andersen <tycho@tycho.pizza>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 7:41=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> On Mon, Mar 18, 2024 at 11:03:01PM -0600, Jose Fernandez wrote:
> > This patch enhances the BPF helpers by adding a kfunc to retrieve the
> > cgroup v2 of a task, addressing a previous limitation where only
> > bpf_task_get_cgroup1 was available for cgroup v1. The new kfunc is
> > particularly useful for scenarios where obtaining the cgroup ID of a
> > task other than the "current" one is necessary, which the existing
> > bpf_get_current_cgroup_id helper cannot accommodate. A specific use
> > case at Netflix involved the sched_switch tracepoint, where we had to
> > get the cgroup IDs of both the prev and next tasks.
> >
> > The bpf_task_get_cgroup kfunc acquires and returns a reference to a
> > task's default cgroup, ensuring thread-safe access by correctly
> > implementing RCU read locking and unlocking. It leverages the existing
> > cgroup.h helper, and cgroup_tryget to safely acquire a reference to it.
> >
> > Signed-off-by: Jose Fernandez <josef@netflix.com>
> > Reviewed-by: Tycho Andersen <tycho@tycho.pizza>
> > Acked-by: Yonghong Song <yonghong.song@linux.dev>
> > Acked-by: Stanislav Fomichev <sdf@google.com>
>
> Acked-by: Tejun Heo <tj@kernel.org>
>
> but some questions below
>
> > +__bpf_kfunc struct cgroup *bpf_task_get_cgroup(struct task_struct *tas=
k)
> > +{
> > +     struct cgroup *cgrp;
> > +
> > +     rcu_read_lock();
> > +     cgrp =3D task_dfl_cgroup(task);
> > +     if (!cgroup_tryget(cgrp))
> > +             cgrp =3D NULL;
> > +     rcu_read_unlock();
> > +     return cgrp;
> > +}
>
> So, as this is a lot easier in cgroup2, the above can probably be written
> directly in BPF (untested and not sure the necessary annotations are in
> place, so please take it with a big grain of salt):
>
>         bpf_rcu_read_lock();
>         cgrp =3D task->cgroups->dfl_cgrp;
>         cgrp =3D bpf_cgroup_from_id(cgrp->kn.id);
>         bpf_rcu_read_unlock();
>
> If all you need is ID, it's even simpler:
>
>         bpf_rcu_read_lock();
>         cgrp_id =3D task->cgroups->dfl_cgrp->kn.id;
>         bpf_rcu_read_unlock();

Good point.
Looks like this kfunc isn't really needed.

We even have the following in one of the selftests:
        /* simulate bpf_get_current_cgroup_id() helper */
        bpf_rcu_read_lock();
        cgroups =3D task->cgroups;
        if (!cgroups)
                goto unlock;
        cgroup_id =3D cgroups->dfl_cgrp->kn->id;
unlock:
        bpf_rcu_read_unlock();


> In the first example, it's not great that we go from task pointer to cgro=
up
> pointer to ID and then back to acquired cgroup pointer. I wonder whether
> what we really want is to support something like the following:
>
>         bpf_rcu_read_lock();
>         cgrp =3D bpf_cgroup_tryget(task->cgroups->dfl_cgrp);
>         bpf_rcu_read_unlock();

this one should work already.
that's existing bpf_cgroup_acquire().

pw-bot: cr

