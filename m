Return-Path: <linux-kselftest+bounces-6367-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F53687D416
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Mar 2024 19:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9031C1C22256
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Mar 2024 18:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F4038DD1;
	Fri, 15 Mar 2024 18:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Me6YpGFg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0865655C29
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Mar 2024 18:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710528655; cv=none; b=WGAnEeyJB71hyVe0zKZDeboH2d4HPHNM63RS0Uidhor48ag+CD/zTzAfxEt6dcGpqu9eda2L9mda/DExgTvMx+iF6hm/Ng8ioK9JxPtNPc8pq7HinyokzUFFUO87r7ABaKU8hx4Ke2VXM4qkHm+iz3OuE1CP+9+OkiFNBfXJRvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710528655; c=relaxed/simple;
	bh=lmLbRKyghwboNWtEfGotXrpbpxUAQ3nWSRJz7Qjgis4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Rz1QHLHwdQie+vZp/9M4p3ypZ8ZGBD9CbGBnNmGARbqSppPY2pfa5tqs1349qy2FgG+oNwhg+37kAUM5TOCKWQd5UwzRho04nTAVc1lwWRP0p3ZgLpganfPx+80YFBDys/vueluxv4GgbaW6yYn+mVySlR/6BYHdGEGA4bOMNr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Me6YpGFg; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5cfd6ba1c11so1801609a12.0
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Mar 2024 11:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710528651; x=1711133451; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DtYC38JTkqYWVAKyPrGYPSxbyTCY8qOTTr3Tw0hY0wc=;
        b=Me6YpGFgLPzRDHruPgCnsdhJ68KCQZHfI2goX8dddUqMBoEla5jRvOdvp0wwKedQ4c
         jCHjgxtcdXX580dtlrqnIEUQIe/E0axvVD5uR8iDREoLJ25c19SMgyeQHM/XmnNqgWMB
         tWOGGL+IpxpdRvACN4b5G1h41TaBWMvP5ckTuhOZ7hfS8mpqdUk2HAeVeyw8aFWVFOwc
         gt85LrJKG0527y1qwG5ifEsPyP4mA/HCFYHBGvHUi2NdLVQppvhYhBlg1QFEDxkG06g4
         bGzJYZ5dPYmEdCXOfgd00WYcduQpU+adLCz4pzLyF+UgxvlHpdR8olqJbaE+/rYvHi4q
         6ogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710528651; x=1711133451;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DtYC38JTkqYWVAKyPrGYPSxbyTCY8qOTTr3Tw0hY0wc=;
        b=acc03Z4Y7saVYWepG2ER5LftjyKUwlWKUKAa1NPTDKEcPOR/p5Kyfj7A9XM6M5D7Xw
         rlHRMDyUq52dKSoPuviuCRm0Uhy8JwxjVSsLiZMGhV4J6eB8Quc+UK2z+bwOKFEF3CUQ
         Mhuho5YMEFuXyNNzhiWrB6oUzS2xMzqq1h0CrakzWt67GDV0p+/4hKNiLYTMCk9MoNAw
         TiVTcJyh/KpwLUuxrHuAmuREPX6tSgA+Jr7WShFte3ou1FvgI4dX8rCVreeIfLgejpRL
         zPZtU6zoI8Li4QxLqSi94VdV4FE5wKOHIROo/g6zBbw8GmvL3OSkHrDJRS6jwTx+/LZC
         cnqg==
X-Forwarded-Encrypted: i=1; AJvYcCULMzbeJu6ikN+uFa0gcPd6xCPTHGu6jcOUV9OdusMcnWSqH+icN259MfdXbduT4A+MaCCGL+I+FsGdhSGV0a5Fi6XG6UjOPiwi0zlT6kmM
X-Gm-Message-State: AOJu0Yw0O4MhRhwL/nI0u4ba5szh5C96RACWTBSwCEp7DWXZ5JN2Z3/2
	9UJgpLcs3gFAS/Wln/l3mN/kfNmyKpUD/33KRhIRUJK/KUhBl+m7RlqXKrjYZyCGXQ==
X-Google-Smtp-Source: AGHT+IEKRxCSilQm25fucau7ePyZf3G/pVMezpgUmF3LnBUAc1qSPoAA3mqkZJs+iIba2I9iYXMZ02Y=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:534f:0:b0:5dc:832e:d805 with SMTP id
 t15-20020a63534f000000b005dc832ed805mr13318pgl.11.1710528651355; Fri, 15 Mar
 2024 11:50:51 -0700 (PDT)
Date: Fri, 15 Mar 2024 11:50:49 -0700
In-Reply-To: <20240315182804.216081-1-josef@netflix.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240315182804.216081-1-josef@netflix.com>
Message-ID: <ZfSYiWcE0_au_ZPt@google.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add btf_task_get_cgroup_id kfunc
From: Stanislav Fomichev <sdf@google.com>
To: Jose Fernandez <josef@netflix.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Tycho Andersen <tycho@tycho.pizza>
Content-Type: text/plain; charset="utf-8"

On 03/15, Jose Fernandez wrote:
> This patch enhances the BPF helpers by adding a kfunc to retrieve the
> cgroup v2 ID of a specific task, addressing a previous limitation where
> only bpf_task_get_cgroup1 was available for cgroup v1. The new kfunc is
> particularly useful for scenarios where obtaining the cgroup ID of a
> task other than the "current" one is necessary, which the existing
> bpf_get_current_cgroup_id helper cannot accommodate. A specific use case
> at Netflix involved the sched_switch tracepoint, where we had to get
> the cgroup IDs of both the previous and next tasks.
> 
> The bpf_task_get_cgroup_id kfunc returns a task's cgroup ID, correctly
> implementing RCU read locking and unlocking for safe data access, and
> leverages existing cgroup.h helpers to fetch the cgroup and its ID.
> 
> Signed-off-by: Jose Fernandez <josef@netflix.com>
> Reviewed-by: Tycho Andersen <tycho@tycho.pizza>
> ---
>  kernel/bpf/helpers.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index a89587859571..8038b2bd3488 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2266,6 +2266,27 @@ bpf_task_get_cgroup1(struct task_struct *task, int hierarchy_id)
>  		return NULL;
>  	return cgrp;
>  }
> +
> +/**
> + * bpf_task_get_cgroup_id - Get the cgroup ID of a task.
> + * @task: The target task
> + *
> + * This function returns the ID of the task's default cgroup, primarily
> + * designed for use with cgroup v2. In cgroup v1, the concept of default
> + * cgroup varies by subsystem, and while this function will work with
> + * cgroup v1, it's recommended to use bpf_task_get_cgroup1 instead.
> + */
> +__bpf_kfunc u64 bpf_task_get_cgroup_id(struct task_struct *task)
> +{
> +	struct cgroup *cgrp;
> +	u64 cgrp_id;
> +
> +	rcu_read_lock();
> +	cgrp = task_dfl_cgroup(task);
> +	cgrp_id = cgroup_id(cgrp);
> +	rcu_read_unlock();
> +	return cgrp_id;
> +}
>  #endif /* CONFIG_CGROUPS */
>  
>  /**
> @@ -2573,6 +2594,7 @@ BTF_ID_FLAGS(func, bpf_cgroup_ancestor, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_cgroup_from_id, KF_ACQUIRE | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_task_under_cgroup, KF_RCU)
>  BTF_ID_FLAGS(func, bpf_task_get_cgroup1, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_task_get_cgroup_id, KF_RCU)

Any reason we are not returning 'struct cgroup' pointer? That should
allow using other kfuncs that are all 'struct cgrop' based as well.

