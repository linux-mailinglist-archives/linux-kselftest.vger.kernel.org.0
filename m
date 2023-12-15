Return-Path: <linux-kselftest+bounces-2083-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EA4814D34
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 17:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 531BB1C2354A
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 16:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB943DBBB;
	Fri, 15 Dec 2023 16:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="FMziPy5F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FC73DBAE
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Dec 2023 16:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-28abb389323so406373a91.2
        for <linux-kselftest@vger.kernel.org>; Fri, 15 Dec 2023 08:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1702658207; x=1703263007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJvYVagYHhoUh6izHlhrfd4VlIqIxeyLW6YH9/IOyR8=;
        b=FMziPy5F0KuuWbuqia792leGIkEYU7QDEsuclB9QFip9dubN5SF+2PDn8809rmnxjK
         wMl4/DjHttWumZ8JNKgouE6nNNdjGPJbkUWzvuTrg7izvDguTeO22lhyWP4d5F6NUjjv
         WEnEVqSnaCtRLYN8UOKJcTytt4fPr0Fz1+SfOKCSELF8j7CNdjAy+ttS3Iu9ENbaJSTR
         c/WyjxpScQosXyDYH82FyxqAlfLw3qFVra0/rKsTvt07kgX3Oh+qYC1v2wLwcPlTrten
         Dfzn9qqzinuyvyPsX24hjsF3Meu6uw+htdB5Zs/puf76TwPgA4A0cs+j1hWs8w44Ejcq
         liBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702658207; x=1703263007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aJvYVagYHhoUh6izHlhrfd4VlIqIxeyLW6YH9/IOyR8=;
        b=f0C1mINO9T/04PIoOahrmMsm7CyIpE81QzDLdj+nHOPFroIvAINnXVtspHttggnVE7
         8uGXUgBQ/gmakp6NUduGvnkkrn5H98c4ApMJWVQbopYS+Soco1CtmxG7kud5Z4L3Q+4a
         pnCxbmnpcPL51UMmcV+RaMM9sPC7tURIwZ2eB3gjfSmMFp7eOsT2OKlUedjac97xUvTb
         vrKfZcTsf8Matlprnu4trqcvSkJRxVex/j3hILJ6F0g2z20UFcGa1aI5Zacx0UigWoot
         aDAfluNKDYPYCOZ1HPWYkCA+v4Zbw6Ybj0hfuwuX6heCZOd74prog0Ji2nJarCQdoXZs
         ghgA==
X-Gm-Message-State: AOJu0YycIlE52a47eYIET1ckWRNobumt76WGVkI69sHNwz5NJcjBOvup
	2Ma28dRhMgcFZRXOOT0JMC5HGg==
X-Google-Smtp-Source: AGHT+IFeZMff91cUpMEe/cVJxJ+9czTxTnqQpAPTa8UZm78P42ynaIIY0rSElsDc43O0h3A+3heBEQ==
X-Received: by 2002:a17:90a:4687:b0:28a:efa3:682f with SMTP id z7-20020a17090a468700b0028aefa3682fmr2312037pjf.74.1702658207601;
        Fri, 15 Dec 2023 08:36:47 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id h5-20020a17090a9c0500b0028ad273525dsm6353303pjp.25.2023.12.15.08.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 08:36:47 -0800 (PST)
Date: Fri, 15 Dec 2023 08:36:44 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Jason Wang <jasowang@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, John
 Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan
 <shuah@kernel.org>, Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew
 Melnychenko <andrew@daynix.com>, Benjamin Tissoires <bentiss@kernel.org>,
 bpf <bpf@vger.kernel.org>, "open list:DOCUMENTATION"
 <linux-doc@vger.kernel.org>, kvm@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>
Subject: Re: Should I add BPF kfuncs for userspace apps? And how?
Message-ID: <20231215083644.4dd9a323@hermes.local>
In-Reply-To: <72b8e198-7058-469a-a1e0-17f48330deca@daynix.com>
References: <2f33be45-fe11-4b69-8e89-4d2824a0bf01@daynix.com>
	<CAO-hwJJhzHtKrUEw0zrjgub3+eapgJG-zsG0HRB=PaPi6BxG+w@mail.gmail.com>
	<e256c6df-0a66-4f86-ae96-bff17920c2fb@daynix.com>
	<CAO-hwJKMrWYRNpuprDj9=k87V0yHtLPEJuQ94bpOF3O81=v0kA@mail.gmail.com>
	<0d68722c-9e29-407b-9ef0-331683c995d2@daynix.com>
	<20231214094042.75f704f6@hermes.local>
	<72b8e198-7058-469a-a1e0-17f48330deca@daynix.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Dec 2023 14:49:56 +0900
Akihiko Odaki <akihiko.odaki@daynix.com> wrote:

> >> It is exactly what BPF_PROG_TYPE_SOCKET_FILTER does, but it lacks a
> >> mechanism to report hash values so I need to extend it or invent a new
> >> method. Extending BPF_PROG_TYPE_SOCKET_FILTER is not a way forward since
> >> CO-RE is superior to the context rewrite it relies on. But apparently
> >> adopting kfuncs and CO-RE also means to lose the "we don't break user
> >> space" contract although I have no intention to expose kernel internals
> >> to the eBPF program.  
> > 
> > An example is how one part of DPDK recomputes RSS over TAP.
> > 
> > https://git.dpdk.org/dpdk/tree/drivers/net/tap/bpf/tap_bpf_program.c
> > 
> > This feature is likely to be removed, because it is not actively used
> > and the changes in BPF program loading broke it on current kernel
> > releases.  Which brings up the point that since the kernel does
> > not have stable API/ABI for BPF program infrastructure, I would
> > avoid it for projects that don't want to deal with that.  
> 
> It's unfortunate to hear that, but thanks for the information.
> I'll consider more about the option not using BPF (plain ioctl and 
> in-kernel implementation).

With libbpf, things are much better. It is just that projects like
DPDK have to support wide range of kernels including older versions of RHEL.

