Return-Path: <linux-kselftest+bounces-6447-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3882F880AEF
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Mar 2024 07:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A60C51F22714
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Mar 2024 06:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C50B1755C;
	Wed, 20 Mar 2024 06:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PH6vwttF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C621A5A2;
	Wed, 20 Mar 2024 06:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710914609; cv=none; b=mJbIPYwAviDf4QPhygR9QCiG53FM1nZuJwQpJNGPXQsTk2qdSoBsechRCxak6TGQJsGpWfo8MO+N0mp3O3XBfo50Tifj3/RKTJI1ffuP/DoXNZ5U9as0zUhlAZ9ygls2Cy4dSHqXHd+uv0vxdNwcgira0/oLMbqPVNypiCmVNhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710914609; c=relaxed/simple;
	bh=Xj+0EJwM7uAPM9IYGHMym6tea0yeShSg9UcqikTwriI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SzTVOuNIK0HdtfiaSnU8H+3ZXj5NJ8/g8eIvz6Y2zsMFvgVIhP6rRdS3FS1bI21DwJtJR/tQN4De9Um0GqGXObQ1rbc+8XPcaLBZpzlRfq2cTsRuE0kciOJLs3nksrAmIPfh6Ywd/hQo+BX9oeOETxhmfhQwl6GZACCm2m7ZcQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PH6vwttF; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-341730bfc46so1779863f8f.3;
        Tue, 19 Mar 2024 23:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710914606; x=1711519406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ao8qG1eSPb4R5Tf5aIIiQnLt3AJxqdYQvtHZM6vC9CY=;
        b=PH6vwttFtq+Qjy+GnG+JelPOdmjZenrcU8KkxGoZkM7ERCqFC9KVMwto9bNPRIqPyF
         Akv/ftL3ItZwrM3UTI6OtUSGGANuD+V/qvObV+pLXffW+Bq2USEYOF8cn2HG8/H6jaiO
         QSiqX5eBWKWxyOUaZxPeu3COzFF23PFk94/K7Mb0nQVRYu97oY87HAI95/Z+qSLV7x32
         nO/FL+eBdS0RMS5KwAJRJGfZBBbfaSXteeAWUWn/hDeD0xkmsdpU0hD4lpmb1MHDlZaV
         RS/VejVnd5CwHqgxGdkhiactK2ly7AqaPBj5dt4biG8d5nanq+ikTrjbzY9gdpJzKErB
         ZxhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710914606; x=1711519406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ao8qG1eSPb4R5Tf5aIIiQnLt3AJxqdYQvtHZM6vC9CY=;
        b=ISpBvJab7WrBrKNpJsCdw43Z1tWmTuy+xgQgR/FyT5p/Yy8MjJAvFRZvYoIg3xu44I
         LUYGBW3dBl5XcNIYABV2GfSZnILAO2TejjFk19s1hYfoSkWXW0i13K75oWnQIQm4ivjB
         rcicbYLcnj1I8t/Wg8y3J2u13OlKXVOgKUy+tMKO7DTxGe5Uel61NQmyZHY2UO2mpuO7
         3M7gEMmFW7nRrgowWLsJiEUMx27s07/McOjko/SysW31LpfZQmcrpCiOcUVJk7YA90tP
         GqB7UO9nlEmnipECOTt6MmbtXoQxnaZG68Xc857BGQqWkWutgKvkMxj2OLkYkcitfAbw
         8JVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJY47Du8+YxZkxyPWZnQpI65ZyI5oHih4zyQbgUtiXWTsZuj2jLsW2Vx4RDg/xTocEH0XwVKJlK+02AYF52GdW9vwtm7vc5piiLrrU2B+HdP+wpdLuLUf/3KBNYWMpvd5CS1L+Bi7jlXU9ZY9PhH9UcpFOcnEEhto4Or3IQnIQzhY4
X-Gm-Message-State: AOJu0YyUvGtmxDUEwwCV/Kkbc3qSDVFrWCioqypnemE0VKsEBtW7/+xi
	9kCzeuRAWb37/p2tRVYZOJ6QtH/U/6Ana77UYpzSSYcnhvVvJqkAB+VR30qVVpcyxOImsS0Gt3m
	q1Lxq/G4AW5NznCeMHAIcq/WlTRA=
X-Google-Smtp-Source: AGHT+IH1rdMb3LEWwbjbirEDhmFBs9QAAhpWIj+p8X1QiKJltlr/RabGEulNmHtplvCFddTMVgDaubwKn8kaCsU1i4k=
X-Received: by 2002:adf:f38c:0:b0:33e:7a1f:5824 with SMTP id
 m12-20020adff38c000000b0033e7a1f5824mr12414766wro.0.1710914605898; Tue, 19
 Mar 2024 23:03:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319050302.1085006-1-josef@netflix.com>
In-Reply-To: <20240319050302.1085006-1-josef@netflix.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 19 Mar 2024 23:03:14 -0700
Message-ID: <CAADnVQJ=HGFBn-8aKb2efUh2NxUe-wJc_FqPKROGZxz6d4L_vQ@mail.gmail.com>
Subject: Re: [PATCH V3 bpf-next 1/2] bpf: add bpf_task_get_cgroup kfunc
To: Jose Fernandez <josef@netflix.com>, Tejun Heo <tj@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Tycho Andersen <tycho@tycho.pizza>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 10:04=E2=80=AFPM Jose Fernandez <josef@netflix.com>=
 wrote:
>
> This patch enhances the BPF helpers by adding a kfunc to retrieve the
> cgroup v2 of a task, addressing a previous limitation where only
> bpf_task_get_cgroup1 was available for cgroup v1. The new kfunc is
> particularly useful for scenarios where obtaining the cgroup ID of a
> task other than the "current" one is necessary, which the existing
> bpf_get_current_cgroup_id helper cannot accommodate. A specific use
> case at Netflix involved the sched_switch tracepoint, where we had to
> get the cgroup IDs of both the prev and next tasks.
>
> The bpf_task_get_cgroup kfunc acquires and returns a reference to a
> task's default cgroup, ensuring thread-safe access by correctly
> implementing RCU read locking and unlocking. It leverages the existing
> cgroup.h helper, and cgroup_tryget to safely acquire a reference to it.
>
> Signed-off-by: Jose Fernandez <josef@netflix.com>
> Reviewed-by: Tycho Andersen <tycho@tycho.pizza>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Acked-by: Stanislav Fomichev <sdf@google.com>
> ---
> V2 -> V3: No changes
> V1 -> V2: Return a pointer to the cgroup instead of the cgroup ID
>
>  kernel/bpf/helpers.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index a89587859571..bbd19d5eedb6 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2266,6 +2266,31 @@ bpf_task_get_cgroup1(struct task_struct *task, int=
 hierarchy_id)
>                 return NULL;
>         return cgrp;
>  }
> +
> +/**
> + * bpf_task_get_cgroup - Acquire a reference to the default cgroup of a =
task.
> + * @task: The target task
> + *
> + * This function returns the task's default cgroup, primarily
> + * designed for use with cgroup v2. In cgroup v1, the concept of default
> + * cgroup varies by subsystem, and while this function will work with
> + * cgroup v1, it's recommended to use bpf_task_get_cgroup1 instead.
> + * A cgroup returned by this kfunc which is not subsequently stored in a
> + * map, must be released by calling bpf_cgroup_release().
> + *
> + * Return: On success, the cgroup is returned. On failure, NULL is retur=
ned.
> + */
> +__bpf_kfunc struct cgroup *bpf_task_get_cgroup(struct task_struct *task)
> +{
> +       struct cgroup *cgrp;
> +
> +       rcu_read_lock();
> +       cgrp =3D task_dfl_cgroup(task);
> +       if (!cgroup_tryget(cgrp))
> +               cgrp =3D NULL;
> +       rcu_read_unlock();
> +       return cgrp;
> +}

Tejun,

Does this patch look good to you?

