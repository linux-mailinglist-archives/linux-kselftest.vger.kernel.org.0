Return-Path: <linux-kselftest+bounces-8403-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8FF8AA854
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 08:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45A241F21EEF
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 06:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA8BC144;
	Fri, 19 Apr 2024 06:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gb+cY2GX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E074B667;
	Fri, 19 Apr 2024 06:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713507534; cv=none; b=nVhwY09XbqokCYcv38eRRaqwkmX29WQPjWTP9o+upcuhFPzDsg/kQ5KrVRv2psw1kdqkR6g7L2lqceGzsvayKj5fScs9XY9PHOeM4l4YIPNEBtS0R+fYDCv1hUnbq8htEbAURFd42VTcrsQICZoM19RNZjFIrj9bN+pz537O+d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713507534; c=relaxed/simple;
	bh=kEsvu7vcp/eaJtdZNoGBObrUsef0VK0b5+uiY0D3hEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKiLjQoU3n8tgXLRLe8qJe/sTsxhyrqujsVUJMJ3owVd3/Pr+fEaoR8ZNbnmWJ1QQgm6ixkfAzxrv5lx1Tp4M5g/uY47E+I7mvjOqMzk5wVfZAwwDQqoeyawQPMcDkB9e/Nkc5sWM6eWRC7xOwF1oynVK2bQb/XKNbHSlt5pyiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gb+cY2GX; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e3f6f03594so13903775ad.0;
        Thu, 18 Apr 2024 23:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713507532; x=1714112332; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=poWGN5JQViLc0iD9MOEsvcT5w8/SJjK3ZixJJE0DRNU=;
        b=Gb+cY2GXM7qDryuZDXiMwhcKZ5WgonDJ6M7x5ZIPCw47CfjMItHjjUAVVehmaC8Uvv
         Bm345C2kRSJFZR1vea8ds8Dn4rRjPfpGTFoqNWwkkNJ6Ih23opjd87YXQiIH4WMDadJm
         3cAa2HlhMLhrZYlZaoemx3yAvhHWElZkFhWJcqs5NbeUh2f83zS+NRArefLP/sV6H3de
         UDupBsk6mlrUYQeC9eDDQXjHF0VtZ6v/gewsxb49EDBngVTU1trDfLw4mD87PLhYipdK
         vH2IXdzAoohAZraCHyPdhb8VcIgyoctJBFvvF3Qtt4MreDhxGqZb8apN9OzHeTDPMEol
         k7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713507532; x=1714112332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=poWGN5JQViLc0iD9MOEsvcT5w8/SJjK3ZixJJE0DRNU=;
        b=A40sxiKfg4CIoVC0LYW/ysQUvzz6lQHtd0dRQraeRDoF4Q3i5ecm/uIWqinfFKGg7d
         HlzqmpSAHxIGv9yG2VjpDvVFyLKL4XxOsY0cmE7PddNPRVHJRqJU7LcQT4iPamsl4OXe
         cPy7ESGUz9/BhZzL7F7RAKKpVS0pUC63fUOEFKjBZekHE/i+0R80UfFuB+4GKJkGhgBo
         xOt++0CQnCdwdnTO9PcQPMbB+lRLm1kfI0e307cHKaooGOER8xjA48/9uIt2TJt8w965
         zz2eTw2bqFdfW+eqvtixGNwMrtMCXXojqrIhMIzgNwikXeT9o2sHP0tk6++qfc317ybb
         5wQA==
X-Forwarded-Encrypted: i=1; AJvYcCXfMqd99U48Y4GDpJ2I5L1Gx014UF/2mzxPiaukBcjRUjdNlfh7YO+k2OcDLp5yGUJQazo0sik8XtARYBogw3u3JHhf3seXvao+kAE5YhMZtCpU4QrqVkNADSNrHSIMO2/W2aQliHIr+w6urKWGtQl5Bs5NW6LFvtZW4F3TWKAEHda5
X-Gm-Message-State: AOJu0Yw8Q/GsVuDlIGiYo4e9ZGTfoIm4lD2myRleFJ0ngWQkboQw2zKB
	uGPl8vYovx2rdU28KM4wxP/vFTAcwdP3NQyoECK2rwxtozQRx+pM
X-Google-Smtp-Source: AGHT+IGZBO4S0Urrc41F7lSiTQp/yby76+VaES64OQoWUNWzAhzgGywbYNfVeRhAKLQylOaVLE/GiA==
X-Received: by 2002:a17:902:b083:b0:1e4:3f6d:20f6 with SMTP id p3-20020a170902b08300b001e43f6d20f6mr1160365plr.30.1713507532384;
        Thu, 18 Apr 2024 23:18:52 -0700 (PDT)
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:400::5:fbcc])
        by smtp.gmail.com with ESMTPSA id d1-20020a170902654100b001e2a7ed52d0sm2602586pln.239.2024.04.18.23.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 23:18:52 -0700 (PDT)
Date: Thu, 18 Apr 2024 23:18:48 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next 17/18] bpf: add bpf_wq_start
Message-ID: <khz5omyjsd2iklm66bi3na4gdxw2cpwhb3c2xwu4fjxkaefi77@puck4pfltjgm>
References: <20240416-bpf_wq-v1-0-c9e66092f842@kernel.org>
 <20240416-bpf_wq-v1-17-c9e66092f842@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416-bpf_wq-v1-17-c9e66092f842@kernel.org>

On Tue, Apr 16, 2024 at 04:08:30PM +0200, Benjamin Tissoires wrote:
> again, copy/paste from bpf_timer_start().
> 
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> ---
>  kernel/bpf/helpers.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index e5c8adc44619..ed5309a37eda 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2728,6 +2728,29 @@ __bpf_kfunc int bpf_wq_init(struct bpf_wq *wq, void *map, unsigned int flags)
>  	return __bpf_async_init(async, map, flags, BPF_ASYNC_TYPE_WQ);
>  }
>  
> +__bpf_kfunc int bpf_wq_start(struct bpf_wq *wq, unsigned int flags)
> +{
> +	struct bpf_async_kern *async = (struct bpf_async_kern *)wq;
> +	struct bpf_work *w;
> +	int ret = 0;
> +
> +	if (in_nmi())
> +		return -EOPNOTSUPP;
> +	if (flags)
> +		return -EINVAL;
> +	__bpf_spin_lock_irqsave(&async->lock);
> +	w = async->work;
> +	if (!w || !w->cb.prog) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	schedule_work(&w->work);
> +out:
> +	__bpf_spin_unlock_irqrestore(&async->lock);

Looks like you're not adding wq_cancel kfunc in this patch set and
it's probably a good thing not to expose async cancel to bpf users,
since it's a foot gun.
Even when we eventually add wq_cancel_sync kfunc it will not be
removing a callback.
So we can drop spinlock here.
READ_ONCE of w and cb would be enough.
Since they cannot get back to NULL once init-ed and cb is set.

