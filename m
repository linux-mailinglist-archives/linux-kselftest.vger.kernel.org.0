Return-Path: <linux-kselftest+bounces-6452-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6D588137F
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Mar 2024 15:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEBBE1F23432
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Mar 2024 14:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FB047F72;
	Wed, 20 Mar 2024 14:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Odv2kcKM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BD41A291;
	Wed, 20 Mar 2024 14:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710945682; cv=none; b=rdw9CQbq4lYoai0VtJD45xJCOy/kuurFAhBIqVadJQbgUon3bhOuLnPBeKST+CPVhg4/RUHa8V6e2xa7I2vwDfYBcw8CGYIIq0J635QqnNupvrwIpY49xpbefjPSATMJjaSBtxAZnbtDD9e8AG2Pyjwr2ElM0+/Z2lIS/atzLwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710945682; c=relaxed/simple;
	bh=fgOCc2Xhdclblgsu6udDHoN+Tmr1BWbG4hJb0qImDyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6RpN4k1dYf4djI4RZqf5nzZSr2SyeceDUhMn/wOjx5i8QxM2LjMyGsOHK9nDDa72f7sfPaHNLMjBUKZ9PAh6I5CUMdMRCKFBbOQ6LL7oawqOf3ibSgc2spKzpEtnGkiDdo43cShzrPOyZOnugUm1qptLnnxhQNGfH8iEk2C6Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Odv2kcKM; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-609f1f97864so74037977b3.0;
        Wed, 20 Mar 2024 07:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710945679; x=1711550479; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0J7VKp53yijpgZI901ch7zhYg0qj6RwRSqJUmVcaUBY=;
        b=Odv2kcKMLdpyMCQ/htHyH5Db8kb/9FHQ/CSu9Uy9iH01vRiFlXASKlwj2pSzbvon40
         q8/6htmf4rDX3mDrsH1z463V3W1PKF/en/urt5GklCSaWgfl7ZlFaupcL2kbAlfL6nlY
         mYNT2oKjbUumqe3P66SyJa8eFZAFe70fg8jNDPXi4nzfE/Uhn43nEKG8xyTNp6dychx9
         wYlW9aBw7UUYXN9tVYaKQaAEdFzaTiUplIooAzaua0Q7tSbG4DxJ+NxBUHrdXFn1YjIK
         Z8vMUGEK7x2aJ7sd9Jy7H2TFe6elMM26QR7S/SzjfMqu8mtb1YKB1r/RVH1E6C2cF5MM
         AH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710945679; x=1711550479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0J7VKp53yijpgZI901ch7zhYg0qj6RwRSqJUmVcaUBY=;
        b=AEH6nEgviz/I7M1ciPs26mU9NuNWc3sQJG/4Lcqmcfey+gCcae8o9QlfCLNWOqFhKP
         e4cYYYcclpBHYK2JMJSFajZr807XnhmXQ8+l2e3Fb/TCkF6t2aSI5+P24r2FTqr7hfUq
         5bUnbj/KPIcqCPkKZ+1ifRQH1w+0AkcTTsqGBVw+alXC6WO4KQ5LlhjbrrPlLyJAhNhB
         +zUvaksiD0g7xZKAHCT7yLhnde1Fet/DLyIIRob5MWUtX3YLvPmkMau6D2mrKTHB4VL7
         i/57ROathn8+Ezi4an7riESbgDSJFcwsGcC1iZU30rqQXFTO/SLfqSQrEY1dVnNNpLlD
         GV+w==
X-Forwarded-Encrypted: i=1; AJvYcCVhBJpEQiAbVTNECARYznP7kfKfLfMB1eEyjyvwmbMEExrNRWGjxdwMlK/4XSCltuFmx99g0rzcRQRPUOaira+zooZYcRQX0flkBFrVRPf/Nr7huSSEQJA97cknSjWDF9mpOKwhSewrrcD+tGAKGXbEpKtxs5cJOJ3gBGftcyRtjdNP
X-Gm-Message-State: AOJu0YwU/nufNerVNjnbf9CiTeIndwmHCpAqbSi/zPO5/sz5FyHzK3ed
	vCjBc2WA9jDRCgw3rmj9+V+MwqYlF4dMQWWujFxCkDB3V1cZeiLVQf93MQ7y
X-Google-Smtp-Source: AGHT+IEknFVM/pV9erRySbDktQRCKez9PunzGmtN0+wjAn+6XPp749HSD1dx4X4Y2QVu6RNWqWxGZw==
X-Received: by 2002:a81:6284:0:b0:610:b930:816a with SMTP id w126-20020a816284000000b00610b930816amr6662455ywb.49.1710945679527;
        Wed, 20 Mar 2024 07:41:19 -0700 (PDT)
Received: from localhost ([2600:1700:2ec0:58c0::44])
        by smtp.gmail.com with ESMTPSA id et13-20020a05690c2e0d00b00609f45c6b89sm2778205ywb.88.2024.03.20.07.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 07:41:19 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 20 Mar 2024 07:41:17 -0700
From: Tejun Heo <tj@kernel.org>
To: Jose Fernandez <josef@netflix.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [PATCH V3 bpf-next 1/2] bpf: add bpf_task_get_cgroup kfunc
Message-ID: <Zfr1jQ6W6yaLsHID@mtj.duckdns.org>
References: <20240319050302.1085006-1-josef@netflix.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319050302.1085006-1-josef@netflix.com>

On Mon, Mar 18, 2024 at 11:03:01PM -0600, Jose Fernandez wrote:
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

Acked-by: Tejun Heo <tj@kernel.org>

but some questions below

> +__bpf_kfunc struct cgroup *bpf_task_get_cgroup(struct task_struct *task)
> +{
> +	struct cgroup *cgrp;
> +
> +	rcu_read_lock();
> +	cgrp = task_dfl_cgroup(task);
> +	if (!cgroup_tryget(cgrp))
> +		cgrp = NULL;
> +	rcu_read_unlock();
> +	return cgrp;
> +}

So, as this is a lot easier in cgroup2, the above can probably be written
directly in BPF (untested and not sure the necessary annotations are in
place, so please take it with a big grain of salt):

	bpf_rcu_read_lock();
	cgrp = task->cgroups->dfl_cgrp;
	cgrp = bpf_cgroup_from_id(cgrp->kn.id);
	bpf_rcu_read_unlock();

If all you need is ID, it's even simpler:

	bpf_rcu_read_lock();
	cgrp_id = task->cgroups->dfl_cgrp->kn.id;
	bpf_rcu_read_unlock();

In the first example, it's not great that we go from task pointer to cgroup
pointer to ID and then back to acquired cgroup pointer. I wonder whether
what we really want is to support something like the following:

	bpf_rcu_read_lock();
	cgrp = bpf_cgroup_tryget(task->cgroups->dfl_cgrp);
	bpf_rcu_read_unlock();

What do you think?

Thanks.

-- 
tejun

