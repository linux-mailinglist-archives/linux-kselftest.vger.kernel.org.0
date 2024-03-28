Return-Path: <linux-kselftest+bounces-6777-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC89890BD5
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Mar 2024 21:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE6B71C310E6
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Mar 2024 20:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE2E13BAEF;
	Thu, 28 Mar 2024 20:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4tuN2qn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7BB13A3E7;
	Thu, 28 Mar 2024 20:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711658772; cv=none; b=iA/3QnWjN30PkgFgcAZc9RpgljPGMThRoc6JLVSM/V/Yu6JjdxQfhekFPchjRW2Mzeqd94E0EGsdDCdxxih2x59JSZO7RgBKq+TwCuDzMv8rzXaQ/TyUlbknfUuGN4CqP/gEtV4KcATWi27Xh1mgrtwmEpMn0lStELtgNgdkt4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711658772; c=relaxed/simple;
	bh=g3FUs8oSA+rki3KtzU+fASuzzmwuKLMhOPJ3dRUzwlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZkgSIl28DJUCjbU8/0GJwKVtAKcKLQUckzNezg4tX+JiqREPPXEpVDjQyfl4EpraBTqdP0qUZc07MFx9CyK2GMZ4PG0wbJkyHajkiMVQrFTocqY3w+/xWgpkwIkEZx3mFIaSMrTEPWL+bAAZhT2ZQMTl5NE20VKE4AMmJBFVkRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4tuN2qn; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41490d05bafso13294255e9.1;
        Thu, 28 Mar 2024 13:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711658768; x=1712263568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ROvuikQjjjOim6lRPo+vqju8xmCENbq2GpP5H9zg3o=;
        b=W4tuN2qnTVuTlk1gl0o+5Sm9HUTDaAiyXbfV3E9yDoC60Sjc5feRAZCYFNz20KV+F4
         5S82L+jlDesZkqE2GfZHTW7/ZrtMjcwXF1s513j5Pt2HXGPjanulJ0PrJaougvETHAAp
         S7Cb4f/li0Rm/DRJFgp3KtGa6lNgjgFxikZqMvd3Jp5/lhRYW8qs9mFYh29g0912jIex
         23CFBcwSQxJ2QzhuXxGyAFDejd3CC9m9sHlbyaaIE8H65c7KRoN0i8UcSF4/pKwBK9v5
         vGSBNtX3+zLXjTTLXxFZUFGgA3znCTAroeIZh8zxvGJOGqBRw7mQ+kfx0LV1dXrhYU+v
         fQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711658768; x=1712263568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ROvuikQjjjOim6lRPo+vqju8xmCENbq2GpP5H9zg3o=;
        b=C5VQuflX/7GPLEyc21P9EIjHUZVIxqHV+LH2J5euEyz29bEmOw1X2z1l7FwnJnqAJK
         GW2RC4RJwdDd4fgqfY5fGhDIEkjcsR9wZnkfKjbjCA7f6hHTu3u4MQLRVJNbYhdOmNW0
         QGEW9Dh3FPyFayjhlmfFZNvHGRm3wsmmxxps61lr0wuLo9krgG8N3cD1TODVdHrRpzTO
         kPeUVlfSuEg7LYUZk6V5c0zWwNonN8EvnlPajGwMSu0jmqkzgLdV5NNoX21KmWlBTz7I
         yROQoNT/hLTv1LD/Xat29PpZEalahJoBTO+UJ6j/R1rRo7AxaP0egoXKYXUQ8Tki/pu4
         8AxQ==
X-Forwarded-Encrypted: i=1; AJvYcCV78ueAH2EI/SgQGE5xd83EvYD+tpAj5Zr4Qe8vUuCAtbRi3Al4RSxw6lTTFzrr9immA+pSlQLKs/6tCrRdndcLIfwSKJ337dz2iu447hOOSwzVdQyLOwv3+8F+VgIiUy3GLh4d5SNRQEvovkHVNT5c1drx1cxrcvfe2WzgMP7fr0ggPedOeLtuF6M636Mh8e3npWBVhVxMqSOYVg==
X-Gm-Message-State: AOJu0Yzpz59GCCAcB1SiaCK1FYYwemXHHzc3yLzDHud5vd4WThSWWiGg
	r9CwqF4gvzQY2joDLtwMUO2CMnTqltlCnt3gfdmr5/x0jO7sfNI/5ysujiDDFV04C6uXf3Fb4WN
	7aZobszuuQh2xUMJVhQ4Um80uEm8=
X-Google-Smtp-Source: AGHT+IEdrmrdYZ0neuzmeyllgckzAWnObYdTmf8L+advoRdhvLgbXuXjAoPzNFvj61inxZuOuaxGq2GMEL3TifRYDag=
X-Received: by 2002:a05:600c:19c6:b0:414:9455:85e with SMTP id
 u6-20020a05600c19c600b004149455085emr410145wmq.25.1711658768259; Thu, 28 Mar
 2024 13:46:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327-ccb56fc7a6e80136db80876c@djalal> <20240327225334.58474-1-tixxdz@gmail.com>
 <ZgWnPZtwBYfHEFzf@slm.duckdns.org> <CAADnVQK6BUGZFCATD8Ejcfob5sKK-b8HUD_4o8Q6s9FM72L4iQ@mail.gmail.com>
 <ZgWv19ySvoACAll4@slm.duckdns.org> <CAADnVQLhWDcX-7XCdo-W=jthU=9iPqODwrE6c9fvU8sfAJ5ARg@mail.gmail.com>
 <ZgXMww9kJiKi4Vmd@slm.duckdns.org>
In-Reply-To: <ZgXMww9kJiKi4Vmd@slm.duckdns.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 28 Mar 2024 13:45:56 -0700
Message-ID: <CAADnVQK970_Nx3918V41ue031RkGs+WsteOAm6EJOY7oSwzS1A@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/3] bpf: freeze a task cgroup from bpf
To: Tejun Heo <tj@kernel.org>
Cc: Djalal Harouni <tixxdz@gmail.com>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 1:02=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> There's also cgroup.kill which would be useful for similar use cases. We =
can
> add interface for both but idk. Let's say we have something like the
> following (pardon the bad naming):
>
>   bpf_cgroup_knob_write(struct cgroup *cgrp, char *filename, char *buf)
>
> Would that work? I'm not necessarily in love with the idea or against add=
ing
> separate helpers but the duplication still bothers me a bit.

I liked it.
So filename will be one of cgroup_base_files[].name ?
We probably don't want psi or cgroup1_base_files in there.

From the verifier pov 2nd arg can be "char *knob__str" and
the verifier will make sure it's a constant NULL terminated string,
so at runtime it will be easier to search cgroup_base_files array.
And 'buf' can be: void *mem, int mem__sz with kfunc doing
run-time validation that there a null there.

