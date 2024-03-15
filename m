Return-Path: <linux-kselftest+bounces-6368-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7DB87D6C3
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Mar 2024 23:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08A421F213D9
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Mar 2024 22:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28585823D;
	Fri, 15 Mar 2024 22:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b="NuG1v4kN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC9259B66
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Mar 2024 22:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710542537; cv=none; b=H76aC6N65D9EdMcFVcpdZZRXUPAObRk8dz5ryAk3qKHEY8qSXnv+Sr4SyMz8s6JzRpR87kYdS2sSNSHHpUYYstYB/pGUINHZuAyuP7S9JvN5k65hoKVvMYDeMnT0Tr99VG/lLxwU9jEYH74mp0u7iNjraOg0KcG1TmMRbUqSEXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710542537; c=relaxed/simple;
	bh=9aTC8xKicnal5qtnDL3cjqNci//gvsNOASreQ2FWddk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCnh2Lx78p2wP6AOcxFThEfjM+i1+otZF8NMbXmUBI5SszWVYa/UmoTn9vtMvB9o8QuE6v4Ze0orkhoXeOhXpw25geqbAwFl1Vr5q3CjAw4sTrZQstvONwghCgpDZfjjoEN0dX9blN3h1CwV9DQd25M4kQMqj1LKySNB4Dt+yTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com; spf=pass smtp.mailfrom=netflix.com; dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b=NuG1v4kN; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netflix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netflix.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7c8aed81a3bso69442439f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Mar 2024 15:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netflix.com; s=google; t=1710542534; x=1711147334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LsRqTXgMaYQKprnwZS46sKtunWtNyYt/xYWjCFRYquc=;
        b=NuG1v4kN0tBNM8FYruKU8M5f/mqN01+dXs/ZiwkD3SyRgzyIcBPzyUKEiCnzcT5Zhn
         Gnnbzhlio4SeWTNsxFlj8zgWvLreRGORREl4v+nrDWiUbAljBMiyD2WekGJWqleN6bHo
         42CwjqS6jRNLV9etWkx8479k0SF79AMR/q6fc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710542534; x=1711147334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LsRqTXgMaYQKprnwZS46sKtunWtNyYt/xYWjCFRYquc=;
        b=ZZKcQs35+/ET1Ii6dXiU+hg2/xcozN7l38iJXtMLLtSF9D3mLkI6nA2XfYkZI418aH
         vw9gCNtVlvOXHVIyLlKSmIyK+pTFlzFy8zud76V3+g+TrIa+HB6jR3RvsnreM7JFcBUU
         XAd/xEyfWAPWJcxFXOEmdFItlkNYy9qg9urDvPxgUVkQLRO7iCgrfXWUz+fCExrhqc7R
         DFALjD4uh9c+0PIS3/fOdVtRBVzb5If7i7T0sk5GREuYpGKdDVERA66aQEBtbOeYUM48
         XhrkzKtbIGQWFwGIFZ/vXIXGcVZIcxyHJIER+79Ad9uCD2kgE6XDf1qPTCZR1Jk8I4v8
         N77Q==
X-Forwarded-Encrypted: i=1; AJvYcCXq5wtjwoNNoNGgui7Z/2r68JJ6cXtgraa6axZTSVajEEA3eYlMmD97e+ZVP9KJtdtZGkStVgJI2BKo+2kVKP9JtdbOWxVYA3e0F10tju4z
X-Gm-Message-State: AOJu0YxamSb/NkiOMucTUd1VfEZNgVVm1Ov0MnL9+Z6qMDWL4scwhdIe
	2rfdZ9+XgZFoh0dxi0ZvsXodkoxlrzu+0pFUfG7Z5ext4N7bC709llrJ3Pf9yfs=
X-Google-Smtp-Source: AGHT+IGfhVeqIsZOso6gswm+yxDMnUr35mGAJUjS8wARQgdmrfpH74HsobqMOyD3K0gWlSYbttz7rw==
X-Received: by 2002:a6b:4f17:0:b0:7cb:f1d0:a1cc with SMTP id d23-20020a6b4f17000000b007cbf1d0a1ccmr3704914iob.4.1710542533892;
        Fri, 15 Mar 2024 15:42:13 -0700 (PDT)
Received: from localhost ([2601:285:8700:8f20:80e2:186e:c8ca:d2a2])
        by smtp.gmail.com with UTF8SMTPSA id w25-20020a029699000000b00474350caf1asm958836jai.175.2024.03.15.15.42.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 15:42:13 -0700 (PDT)
Date: Fri, 15 Mar 2024 16:42:12 -0600
From: Jose Fernandez <josef@netflix.com>
To: Stanislav Fomichev <sdf@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [PATCH bpf-next 1/2] bpf: add btf_task_get_cgroup_id kfunc
Message-ID: <20240315224212.sinyco7bxbnlgw2e@SlimPro9i>
References: <20240315182804.216081-1-josef@netflix.com>
 <ZfSYiWcE0_au_ZPt@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfSYiWcE0_au_ZPt@google.com>

On 24/03/15 11:50AM, Stanislav Fomichev wrote:
> On 03/15, Jose Fernandez wrote:
> > This patch enhances the BPF helpers by adding a kfunc to retrieve the
> > cgroup v2 ID of a specific task, addressing a previous limitation where
> > only bpf_task_get_cgroup1 was available for cgroup v1. The new kfunc is
> > particularly useful for scenarios where obtaining the cgroup ID of a
> > task other than the "current" one is necessary, which the existing
> > bpf_get_current_cgroup_id helper cannot accommodate. A specific use case
> > at Netflix involved the sched_switch tracepoint, where we had to get
> > the cgroup IDs of both the previous and next tasks.
> > 
> > The bpf_task_get_cgroup_id kfunc returns a task's cgroup ID, correctly
> > implementing RCU read locking and unlocking for safe data access, and
> > leverages existing cgroup.h helpers to fetch the cgroup and its ID.
> > 
> > Signed-off-by: Jose Fernandez <josef@netflix.com>
> > Reviewed-by: Tycho Andersen <tycho@tycho.pizza>
> > ---
> >  kernel/bpf/helpers.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> > 
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index a89587859571..8038b2bd3488 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -2266,6 +2266,27 @@ bpf_task_get_cgroup1(struct task_struct *task, int hierarchy_id)
> >  		return NULL;
> >  	return cgrp;
> >  }
> > +
> > +/**
> > + * bpf_task_get_cgroup_id - Get the cgroup ID of a task.
> > + * @task: The target task
> > + *
> > + * This function returns the ID of the task's default cgroup, primarily
> > + * designed for use with cgroup v2. In cgroup v1, the concept of default
> > + * cgroup varies by subsystem, and while this function will work with
> > + * cgroup v1, it's recommended to use bpf_task_get_cgroup1 instead.
> > + */
> > +__bpf_kfunc u64 bpf_task_get_cgroup_id(struct task_struct *task)
> > +{
> > +	struct cgroup *cgrp;
> > +	u64 cgrp_id;
> > +
> > +	rcu_read_lock();
> > +	cgrp = task_dfl_cgroup(task);
> > +	cgrp_id = cgroup_id(cgrp);
> > +	rcu_read_unlock();
> > +	return cgrp_id;
> > +}
> >  #endif /* CONFIG_CGROUPS */
> >  
> >  /**
> > @@ -2573,6 +2594,7 @@ BTF_ID_FLAGS(func, bpf_cgroup_ancestor, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
> >  BTF_ID_FLAGS(func, bpf_cgroup_from_id, KF_ACQUIRE | KF_RET_NULL)
> >  BTF_ID_FLAGS(func, bpf_task_under_cgroup, KF_RCU)
> >  BTF_ID_FLAGS(func, bpf_task_get_cgroup1, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
> > +BTF_ID_FLAGS(func, bpf_task_get_cgroup_id, KF_RCU)
> 
> Any reason we are not returning 'struct cgroup' pointer? That should
> allow using other kfuncs that are all 'struct cgrop' based as well.

Returning the cgroup pointer would make this kfunc more flexible, agreed. 
My intention was to make the kfunc more user friendly by returning the cgroup ID, 
but I can see how it would be beneficial to have the cgroup pointer as well. 
I'll update the patch to return the cgroup pointer.

