Return-Path: <linux-kselftest+bounces-8447-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D068AB254
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 17:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0206A283E52
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 15:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB3B1304AF;
	Fri, 19 Apr 2024 15:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmYMhp6L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B131304A5;
	Fri, 19 Apr 2024 15:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713541791; cv=none; b=gZs1g8EC/zaLNAgpYCBluhOhdZ9l6N0TbkSCx1Nb+XIFq/o5TV6RdD+NE/WZhggekbyVwuZvQxGL9++F8N87Z+erLccpOA7TdCH8oVMRzIK2l6eZ4rhNJ91GBQuR3+FOQH7zpuBq/mb1BR/ccApl/4Hj13cqefNRMpEPQ7vNrDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713541791; c=relaxed/simple;
	bh=WWJM97CcvSF3993rmBMTv0D7IMRw9Z8Se5HS1FM9dCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=juM07VQTd6gHNjixM6Iu4vpBI7CoQFXGMwneKN/2bSRrEzHhtW3eAu7e6QN/Jn/hCd0xftRjnbI/cbeqdmLM3yrSS69q4fN6gg081sl1c027LTjm2vfgsmQjVm0g03B5FL9GiLioE0/EfyCQLCEWJd0U14U6tiaDgP5ecsBWaEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmYMhp6L; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2da01cb187cso38815321fa.0;
        Fri, 19 Apr 2024 08:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713541788; x=1714146588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWJM97CcvSF3993rmBMTv0D7IMRw9Z8Se5HS1FM9dCc=;
        b=kmYMhp6LRdt/pghJaBvQj6WbF6GqXMtpUAEhZK0d2NdAFc6DCgAZqfSnb4plb5Zd+l
         58cn/Z9mUPVU8LZpZgBVMGRo1doOHE8s3odLMyWdKZrqcmh3oVMPDaz6ACTLr6DqrG/N
         7/Ejhfq+3pJ9aRsZBAMeTHWbkkCGBeNnLqFUUAJ/D2lTd+Z1WsfHIFQ6ka1UHTLCEwGW
         5efgVwRq6vhcMF6m+ped9WKAlH84SHWYU9b2pAW9GxEiGoSxo9jxizM+Tov729mEBZOt
         HKE20TKgnhFYwgZYebOaLUGC3CKwmGmYKEuE/1+CYTaljYQwMD6Vc5yReg3TZ7l3skl/
         +2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713541788; x=1714146588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WWJM97CcvSF3993rmBMTv0D7IMRw9Z8Se5HS1FM9dCc=;
        b=G+z/Fu7vFcNFFrquMB4/fDHgbGXC+49mTakdt0GHgTYH22yXDNdo28IxJFsNRX1Opk
         R0866oqyI9igAQS8Yeb4xEBDqnZP8c1ki3sb27qtbyDjS88XLDstxqw00OUXJGT/4Lli
         CPUnBl1SNRlh3uPjDrKaDAGLpYgGMH4EfD9HNz2MaCF39w6IA4GRdWBd5lmcckN9gITJ
         qOFIS75wTxGCDXaw2N5O4w+3URZaybNiScNaL+pZQmFIoe7ro3g6kwlQm/f2n3PjHgVn
         t4incPZds7I7VkIL//G+0j17UDt+nSimXyraB5rSo6Mh4ZP6NgYbtNR/xQLpn/sliV0T
         flRA==
X-Forwarded-Encrypted: i=1; AJvYcCUzG3Ww9PtQwC+9qqzZ0+RqyzRwynmM8cpl3umth9xsVfHg/uzOBD4O/7hHpLZ6QF+cE2J/yMfKNplWmNO/aeWl8/swEym5FojOex7RG11Ydj8e5mbeVZrqg0t0ySYfD0/2tLCmgs2ciGr21tHcsI4Q+0KuMXB9Dv6O8xrFLTmASwd0
X-Gm-Message-State: AOJu0YzuvAL0JSGR2Qby7NKpfwCiH3MWWmA7Ggf6R8PPwc8JCxgH/WTQ
	IiqiIrdeM1LluReDIcdVb5jmU7XecjthSpsZVwdAb4RdAp0fVpzasM7/YBjEKrmXDci5J8dMCaY
	NewhrAC8zJ1gZxvdW8/1clIQPTrk3G2/y
X-Google-Smtp-Source: AGHT+IH04YykqEPooeOpjDIaG5sd/QHb2gYVKjVVnbzLd0iOOjJo3/w0oYTDMe3y+t0h1QyYwoWJkv8kcRg4hn+1y0U=
X-Received: by 2002:a2e:bea7:0:b0:2d6:fa7a:a670 with SMTP id
 a39-20020a2ebea7000000b002d6fa7aa670mr2311881ljr.33.1713541787684; Fri, 19
 Apr 2024 08:49:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416-bpf_wq-v1-0-c9e66092f842@kernel.org> <20240416-bpf_wq-v1-17-c9e66092f842@kernel.org>
 <khz5omyjsd2iklm66bi3na4gdxw2cpwhb3c2xwu4fjxkaefi77@puck4pfltjgm> <b7akvvt67m7w6hdfq5vboojnzyjbntxrjioh6nuqziz4pzia3d@6x2le6iz6cor>
In-Reply-To: <b7akvvt67m7w6hdfq5vboojnzyjbntxrjioh6nuqziz4pzia3d@6x2le6iz6cor>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 19 Apr 2024 08:49:36 -0700
Message-ID: <CAADnVQ+hPNQ3-fVj-5qt+UrT8yPavE9L7AaphsLLEKwve21P-g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 17/18] bpf: add bpf_wq_start
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 8:14=E2=80=AFAM Benjamin Tissoires <bentiss@kernel.=
org> wrote:
>
>
> Honestly I just felt the patch series was big enough for a PoC and
> comparison with sleepable bpf_timer. But if we think this needs not to
> be added, I guess that works too :)

It certainly did its job to compare the two and imo bpf_wq with kfunc appro=
ach
looks cleaner overall and will be easier to extend in the long term.

I mean that we'll be adding 3 kfuncs initially:
bpf_wq_init, bpf_wq_start, bpf_wq_set_callback.

imo that's good enough to land it and get some exposure.
I'll be using it right away to refactor bpf_arena_alloc.h into
actual arena allocator for bpf progs that is not just a selftest.

I'm currently working on locks for bpf_arena.
Kumar has a patch set that adds bpf_preempt_disble kfunc and
coupled with bpf_wq we'll have all mechanisms to build
arbitrary data structures/algorithms as bpf programs.

