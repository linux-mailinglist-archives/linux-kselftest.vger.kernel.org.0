Return-Path: <linux-kselftest+bounces-45975-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E62C6E834
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 13:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A8C04FA481
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 12:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1AF13590BB;
	Wed, 19 Nov 2025 12:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNYCScuh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D9D3596FF
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 12:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763555296; cv=none; b=M0lXvEGAR4PW+M93QPwMNFGBYEgBGo4TAHahABHCHiIwaoBoqenPojJ36P+pT/Qmm+fxV0H1Fuy4ouW7CZfrXqpDoO0bUqXSUVDNCkCRgqaGzsb8zGnXjKaZZX1rdYOViz9Jfvmq6/mjOuEFysjvYNptNqqpQR4oocCPYz4yvho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763555296; c=relaxed/simple;
	bh=FwNfJ1FkJj/jUj+TxbqbW6X3s7ImIQRrELHQjc029ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WIulzUfwqTadw4Qm5PzbAHLAV++qA8/FV2/1DbJ6hfmAtzK+7AyE8BcA/Vpm3m0PqLAaHA7Ph8jMGfbTEhMIOZibZmfoTAc8SOYWnbAYoGVAlwMcI7lAs+cP91b2HPB5dJWz+nK9QYFWlAMl+sUR/NTKIs5C/xM7CclcB2qsRs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNYCScuh; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7b89c1ce9easo6792645b3a.2
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 04:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763555293; x=1764160093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CKhj841T0e6qZvubDhvAJxg1sC8gp96pehxxFiAmCs=;
        b=XNYCScuhJS2JjLhjxjpU18f/RptwLCzoG0Mzng14GEZ9124zrVQkxmjJwx5BS1HCzO
         TWHY5lRaQpP8ft1nNJ1HZIPdo7mwaynJ5VC7NYWQPiH/8d73bKhE2jNBUwLDQyZlfRj6
         bH4ziETXbIXRX7nDVpeWT6jGjYYuGJzNLm5PobFvzOQRXJ1PTj/Ick26Lcd7wlTE7LMW
         a1xPcKqBL4mTt5peXC9EXMKX70ysLoBkS40DivvjxTg/QUQcVvN+mHxIq7KZrPUztdVs
         fEwSCk1Z4GJ10srWZRDEW7CMd2l9Rpisr7WLEw11+Upwgub8+fl5axyAFABUInQYqwsv
         s1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763555293; x=1764160093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+CKhj841T0e6qZvubDhvAJxg1sC8gp96pehxxFiAmCs=;
        b=VuH3kIuy3hdoAhfK01uVY0DBGlw4Ev5B5yr4UPimMgEGHHoKw/Sgx71WwPAcxpBMo+
         xWTZL6+6GkWShb13cy5Lzt9WVzcXuqjOhdusmBeFlhR9iA78EfoFW3IgKBs/pmuaTPRv
         KdJ8729fJdoAO9+SVJZdOh79Ig9EGSWjAWNh4bZ5KpGKvok2Ow2J1Msoxq4hzqC9PmpH
         DGPleVVx+f/nz5k+4dNQuTmI0pR2zYyjakaWwP7PT/W9301DFZ+3yu+EfD51Q0dILBXU
         Jp8ja6OzOWOzro4oT7VI9heyHWD5SwIPc39TAIaMiNIqM5gnWeKrLt8axmR8i9t/K13/
         mURg==
X-Forwarded-Encrypted: i=1; AJvYcCUTSvDjAucqMzoEN84VAqTb6/rPo+LwWP/OKS8Jw4fnrZZrzIjC4uTUX1WCyDR/l8YIG8RKEjrZVMKn8sgtLpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjsXbIDPpBtg4MlW/UHEACf5tjwLYu1aL20/4HVPgTnuXLVKcv
	zVJ4524RmEZqYQg8IRZTWnoGvs+ahDLS8K7BpILAi1VuPtjjPJ+lbRXn
X-Gm-Gg: ASbGncsUKnoM8BV5bQHzCoagjlfaVQJWZUqIc02OKa2Z+UfxwLRGb68GD0OeHyc8jbi
	GdbckQJB4cdpExLo0+tuhhf9qmVDe4QkELsHQkkryGOgEhH4TBYEQMRsXoDDYQ4loou5lmG1nUJ
	cjKSvwTps0D6DV50ceuC8MkveZyAn4Dv9RPXBOQ+OJJVTM3HpU/a0BVbvs7SgQkHr+mibWHL7g7
	PBGQFfyNxypzKAIl5woUso5xXJ0Wz/dQOLPc6JE7OTUnMi/VC79PXoHrx34MgKg1KPpmyFpSX1/
	G5mGozkltbXly7LapdR7xf+dAv+4FuzfoyBukkJiuiqlvDw2BuTInCvOV5bekpZHJ8DxOpO9Lxl
	FfVy/zcweCOIfjOfM/MWpEAliNfCrOtA240h3tWqKNqXf88VHwENOTTpEZ7BB+XjVDnETJF8zxi
	NvJqHbnRJs5wZdxNm3Jxc=
X-Google-Smtp-Source: AGHT+IEJJjWz+MJzpUl7ns76a+Og9nUY/w0T8Ert+O7huCBITXi39FiE1X0vmFKSLM4XAxMf1Yzn/A==
X-Received: by 2002:a05:6a00:22c5:b0:7ab:8d8a:1024 with SMTP id d2e1a72fcca58-7ba39bbdfcdmr21856893b3a.7.1763555292868;
        Wed, 19 Nov 2025 04:28:12 -0800 (PST)
Received: from EBJ9932692.tcent.cn ([45.8.220.113])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b92782d39bsm19596383b3a.63.2025.11.19.04.28.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 19 Nov 2025 04:28:12 -0800 (PST)
From: Lance Yang <ioworker0@gmail.com>
To: zhangguopeng@kylinos.cn
Cc: hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	mhocko@kernel.org,
	mkoutny@suse.com,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	shuah@kernel.org,
	tj@kernel.org,
	leon.huangfu@shopee.com,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH] selftests: cgroup: make test_memcg_sock robust against delayed sock stats
Date: Wed, 19 Nov 2025 20:27:58 +0800
Message-ID: <20251119122758.85610-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251119105216.1675608-1-zhangguopeng@kylinos.cn>
References: <20251119105216.1675608-1-zhangguopeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>


On Wed, 19 Nov 2025 18:52:16 +0800, Guopeng Zhang wrote:
> test_memcg_sock() currently requires that memory.stat's "sock " counter
> is exactly zero immediately after the TCP server exits. On a busy system
> this assumption is too strict:
> 
>   - Socket memory may be freed with a small delay (e.g. RCU callbacks).
>   - memcg statistics are updated asynchronously via the rstat flushing
>     worker, so the "sock " value in memory.stat can stay non-zero for a
>     short period of time even after all socket memory has been uncharged.
> 
> As a result, test_memcg_sock() can intermittently fail even though socket
> memory accounting is working correctly.
> 
> Make the test more robust by polling memory.stat for the "sock " counter
> and allowing it some time to drop to zero instead of checking it only
> once. If the counter does not become zero within the timeout, the test
> still fails as before.
> 
> On my test system, running test_memcontrol 50 times produced:
> 
>   - Before this patch:  6/50 runs passed.
>   - After this patch:  50/50 runs passed.

Good catch! Thanks!

With more CPU cores, updates may be distributed across cores, making it
slower to reach the per-CPU flush threshold, IIUC :)

> 
> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
> ---
>  .../selftests/cgroup/test_memcontrol.c        | 24 ++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
> index 4e1647568c5b..86d9981cddd8 100644
> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> @@ -1384,6 +1384,8 @@ static int test_memcg_sock(const char *root)
>  	int bind_retries = 5, ret = KSFT_FAIL, pid, err;
>  	unsigned short port;
>  	char *memcg;
> +	long sock_post = -1;
> +	int i, retries = 30;
>  
>  	memcg = cg_name(root, "memcg_test");
>  	if (!memcg)
> @@ -1432,7 +1434,27 @@ static int test_memcg_sock(const char *root)
>  	if (cg_read_long(memcg, "memory.current") < 0)
>  		goto cleanup;
>  
> -	if (cg_read_key_long(memcg, "memory.stat", "sock "))
> +	/*
> +	 * memory.stat is updated asynchronously via the memcg rstat
> +	 * flushing worker, so the "sock " counter may stay non-zero
> +	 * for a short period of time after the TCP connection is
> +	 * closed and all socket memory has been uncharged.
> +	 *
> +	 * Poll memory.stat for up to 3 seconds and require that the
> +	 * "sock " counter eventually drops to zero.

It might be worth mentioning that the current periodic rstat flush happens
every 2 seconds (#define FLUSH_TIME (2UL*HZ)). Adding this context to the
comment would explain why the 3-second timeout was chosen ;)

> +	 */
> +	for (i = 0; i < retries; i++) {
> +		sock_post = cg_read_key_long(memcg, "memory.stat", "sock ");
> +		if (sock_post < 0)
> +			goto cleanup;
> +
> +		if (!sock_post)
> +			break;
> +
> +		usleep(100 * 1000); /* 100ms */

Nit: It would be better to define the retry count and interval as macros
(e.g., MAX_RETRIES, WAIT_INTERVAL) to avoid magic numbers and make the 3s
timeout calculation explicit.

> +	}
> +
> +	if (sock_post)
>  		goto cleanup;
>  
>  	ret = KSFT_PASS;

Thanks,
Lance

