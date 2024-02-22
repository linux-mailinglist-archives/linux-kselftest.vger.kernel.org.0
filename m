Return-Path: <linux-kselftest+bounces-5281-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C6F85F775
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 12:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C17411F2653E
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 11:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FCF47A7A;
	Thu, 22 Feb 2024 11:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LNHlvWpD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7601747A48
	for <linux-kselftest@vger.kernel.org>; Thu, 22 Feb 2024 11:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708602621; cv=none; b=GTgT23L/JJ0WuZUid59YsnjJA5XjnCqVBIAGG/ehI7WXXcF9pZhl/315rus9BudMGV6jZ+3y9xbzbletjz134gTJcnEyMTYyBAonPkKIWIhjae76CqdiXcy538c1i9JEcvb4U1Rl9p7ESr9cTCL0mEjFiW5E8kDzhzAPPiEYvls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708602621; c=relaxed/simple;
	bh=ma9DfQIGiAa5vr3ks75PfINXo2TPrC0w7A/88yi8pA8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pZy9eE3hwXdSJ9dnHmudMlEr1d1EGrBNH4zToJ3evoVFBoitXWB/U93Iz1EzHXAEQTX++3YksmFo6LOHDJMeq4P/ekKK3xIwKlT7ThGrSgWUXcrgn7aMe35UWKPZiqpHFdOh3Qt75ka0aaFOTIsJS9qm3d8JLajrbAY8hmB0mPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LNHlvWpD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708602617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ldC5iLR/TjfHxpr5I8kE+2L9PTCMZ2jj1k9txMQpdfM=;
	b=LNHlvWpDPvqy6mIpfwQBe7iBjXqd28ML5ZmGBOpEMRu1nPlpHyWxgNMk6N4czt4mPdsSNw
	EkNAUkQeAsQWv+W58bVedLlLGDy8CWVecJCD/r19DIyPYLNKVp7pOJHqgDh2NCRfiiGFCg
	XRwa7yM8XhJhwk95PwaQFQbgc+ynhvA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-1HAB9ppbOV-yHgPN4NIK2w-1; Thu, 22 Feb 2024 06:50:16 -0500
X-MC-Unique: 1HAB9ppbOV-yHgPN4NIK2w-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a3bdd99a243so79434366b.0
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Feb 2024 03:50:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708602614; x=1709207414;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ldC5iLR/TjfHxpr5I8kE+2L9PTCMZ2jj1k9txMQpdfM=;
        b=N4gMkyhTmkKMQOsxVltKp0pz2o5J9LC9VgvhGIasCzZA96PF5cuEmiLzG7pNzrz1wp
         dq/hXejyRCc3YDuW1bVSh2iOcht81hFQpNWGbven8dI/xTYU740dvza5n1i8AJKAyP7a
         vKu5Xj1bylJi/JYgrHKPhqSwOjm7xFA8MhqXgyJ0Q9EHehs7EYBXh3RB4id4sQz5iblv
         BzT47BbJYQWhkGtbf/hL2xTcnWXH0VRSv6Ni2LpXfMfen794V0J7tPuZ70yDaIkIsWiK
         /L1gjvSyrcccyLwwB4hIH8SnXXeaAXAksLLFXgOs2FZ2MXaY5WBWmsCgPL0p/Rh3Eqc1
         m4NA==
X-Forwarded-Encrypted: i=1; AJvYcCUevH4WVZM/AxPl/fqJJ6MBbLeJVZKyimiCTnutM0dttB+YqG7YQOJJBDogfFrOzGi1J2nER5Gsagr966KBTCqDWE0zGWCbk4mNhvSdtlRI
X-Gm-Message-State: AOJu0Yz6WlA60iNwyLpTwURhmCulk9CNNj7d1aE/WpAR2Y1olTmBan9a
	XUTrK7/Nkohk14M/qKc4tkM5J/I2EpmmOZg4No2Gvy9e3V8YhmVmIUTkQn5MHFMcvGDTrOJh481
	Veo1j/W7u6lNtN8+oojrnZPQJ2PRozSkvu/7KQUzxGNJ9KEjBfgmBmzP5WszbarA12Q==
X-Received: by 2002:a17:906:393:b0:a3f:4ca8:f93e with SMTP id b19-20020a170906039300b00a3f4ca8f93emr2003795eja.24.1708602614231;
        Thu, 22 Feb 2024 03:50:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFqkM/gRLrevRcPSWpe7we5hg0Pbu6lFDxiRpmiSyGCXmYKdK+uwM9zZOtenBwAxZkzrXVHw==
X-Received: by 2002:a17:906:393:b0:a3f:4ca8:f93e with SMTP id b19-20020a170906039300b00a3f4ca8f93emr2003757eja.24.1708602613833;
        Thu, 22 Feb 2024 03:50:13 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id h10-20020a170906398a00b00a3f99497456sm259912eje.90.2024.02.22.03.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 03:50:13 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 63345112DEFE; Thu, 22 Feb 2024 12:50:12 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Jiri Kosina
 <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
Subject: Re: [PATCH RFC bpf-next v3 04/16] bpf/helpers: introduce sleepable
 bpf_timers
In-Reply-To: <20240221-hid-bpf-sleepable-v3-4-1fb378ca6301@kernel.org>
References: <20240221-hid-bpf-sleepable-v3-0-1fb378ca6301@kernel.org>
 <20240221-hid-bpf-sleepable-v3-4-1fb378ca6301@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 22 Feb 2024 12:50:12 +0100
Message-ID: <87le7chg5n.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Benjamin Tissoires <bentiss@kernel.org> writes:

> @@ -1245,6 +1294,7 @@ BPF_CALL_3(bpf_timer_set_callback, struct bpf_timer_kern *, timer, void *, callb
>  		ret = -EPERM;
>  		goto out;
>  	}
> +	down(&t->sleepable_lock);
>  	prev = t->prog;
>  	if (prev != prog) {
>  		/* Bump prog refcnt once. Every bpf_timer_set_callback()
> @@ -1261,6 +1311,7 @@ BPF_CALL_3(bpf_timer_set_callback, struct bpf_timer_kern *, timer, void *, callb
>  		t->prog = prog;
>  	}
>  	rcu_assign_pointer(t->callback_fn, callback_fn);
> +	up(&t->sleepable_lock);
>  out:
>  	__bpf_spin_unlock_irqrestore(&timer->lock);
>  	return ret;
> @@ -1282,7 +1333,7 @@ BPF_CALL_3(bpf_timer_start, struct bpf_timer_kern *, timer, u64, nsecs, u64, fla
>  
>  	if (in_nmi())
>  		return -EOPNOTSUPP;
> -	if (flags & ~(BPF_F_TIMER_ABS | BPF_F_TIMER_CPU_PIN))
> +	if (flags & ~(BPF_F_TIMER_ABS | BPF_F_TIMER_CPU_PIN | BPF_F_TIMER_SLEEPABLE))
>  		return -EINVAL;
>  	__bpf_spin_lock_irqsave(&timer->lock);
>  	t = timer->timer;
> @@ -1299,7 +1350,10 @@ BPF_CALL_3(bpf_timer_start, struct bpf_timer_kern *, timer, u64, nsecs, u64, fla
>  	if (flags & BPF_F_TIMER_CPU_PIN)
>  		mode |= HRTIMER_MODE_PINNED;
>  
> -	hrtimer_start(&t->timer, ns_to_ktime(nsecs), mode);
> +	if (flags & BPF_F_TIMER_SLEEPABLE)
> +		schedule_work(&t->work);
> +	else
> +		hrtimer_start(&t->timer, ns_to_ktime(nsecs), mode);
>  out:
>  	__bpf_spin_unlock_irqrestore(&timer->lock);
>  	return ret;

I think it's a little weird to just ignore the timeout parameter when
called with the sleepable flag. But I guess it can work at least as a
first pass; however, in that case we should enforce that the caller
passes in a timeout of 0, so that if we do add support for a timeout for
sleepable timers in the future, callers will be able to detect this.

-Toke


