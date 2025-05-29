Return-Path: <linux-kselftest+bounces-33978-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB65AC7874
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 07:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F157DA472F8
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 05:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B6F17BA9;
	Thu, 29 May 2025 05:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRF+sfvL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EACB25CC72;
	Thu, 29 May 2025 05:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748497503; cv=none; b=GZ5Kgl5dWqY/IIix66anZMRhYRMVT5iTnlvCbEFGzgD/b3R2kPAG9NCA9tzmOjVVvk/zn2aLXBxE3rbccZtsVEfICmySCyCmvVPJ3mulQUGcDVD0kvoFBohDvBRj4bM+29uT74QhGDuwJ9nw5OJNdjTTxKoC+ExNqEPYjU2Y8cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748497503; c=relaxed/simple;
	bh=sn8RqX6Rt8HNg3sQJQLMQjRLeGPHU0yvRzHxn3HXMXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oDSqjTHGBixQibGiK9ykuG+RPNBElFvcMGJI0KgWdOWwmOd/jtc0wjllm4DJeP/DgZR8j2mYJYj1NbAuRutAuArROV1VhTI2rDSThgkII18pVuzwidkwcP3PNoOzQHiQCvwdZLIFridU/4UTKhNi6W/TfvkpGMgh/7nzW1BWV0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRF+sfvL; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a4dba2c767so1116928f8f.1;
        Wed, 28 May 2025 22:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748497499; x=1749102299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sn8RqX6Rt8HNg3sQJQLMQjRLeGPHU0yvRzHxn3HXMXc=;
        b=lRF+sfvLXVuIeV60tyDhbm96H9sONhOGe1JwHnvVVwHwOqZlU29yjsKOnkiV/WBQ6C
         sTLuwBJmQnP2FBJ6TfUPXL8M7zcwN6AnMJ5dH7IK6aZGKgDJ7uM8ZjjXozGdlXN/tgS1
         qbUZZgM7Em88ItcdHgL6R9xeLtsfFZa4kEb+vKLTE7aRVHgySFwB6sjLbQqR3X5E92Xm
         U7ofXmVCzc8o3FcQ8JWwHzmP+wYalkP1tD7l/A5ONitiCFpIVNgU/WdSha5qXnnCefqD
         j196uZTkmOo28n85+UBo7Fqai5CRdSIZgdIO8yv9FXVKI/nqSC57S5w1g/c9iMbWGZBa
         j2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748497499; x=1749102299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sn8RqX6Rt8HNg3sQJQLMQjRLeGPHU0yvRzHxn3HXMXc=;
        b=KR34pSfOl0uODDogXeqMGjR0nGCJb77onj17g569kcbFUPFkAf5GIfUS34d2bWd3Rc
         EOcsYftUsZKW7mO/IK9ux3D5F3ULuMsskb5LdhCj52ovhRcQSMr7WRnPCh/WvUBEJ5jS
         /BOaqVL4+8Awp8GMbWm1jHhEtnoXjg6rLO7sexbHty5H0oRBMbgxcU4TlIr3Fbo9pI7P
         MnyI6W3AqviGwhtsk7l4QKmGvusyX6m07nuD7Oeyt5SB9HSUEvVOxYOgqzQumbJ1q2z1
         ltg673paqmOzzJsiGcIPun/c8N8NfcJShYy+zSrYi0N2PKRJLRoxwnEEGvo1aAj0sswQ
         5Jvg==
X-Forwarded-Encrypted: i=1; AJvYcCVz310zKGgjJL8Bk+RKpvi9oZrtWANBmwXaX+jrqCHdKKq+1pmG8jcFkwnL4lj3dA7OHN+zvewgu9ZH0YPNJkcX@vger.kernel.org, AJvYcCWhDwti8719UxrO9bPMB9vOB1l2RJww+8upZFIijgniVjdoelT+HBiGSwcG83aJGyw9VI4=@vger.kernel.org, AJvYcCXQVWTTbHTKsOxIoDxYbDyIjyMQZh+oKeZWFmTfXe+Twajz3eFpPJRse882JfuNrl8ujigeRKBICy/3rCnL@vger.kernel.org
X-Gm-Message-State: AOJu0YyYsfbOIxVskAgjPS0Ftf8i/i1/+WOBAOXJSEb+/WiUDTjD3X2v
	hCEPB3leEZB6htPjiXHAG9BzEwiqC7kTddtL1usfFnz7fThQb9/mzJLOedmwh/w2JRwR/D5jrx6
	45Qn1ss9aIl6xs/6gI1pXVBLmJ4UGzXA=
X-Gm-Gg: ASbGnctgygrtKqO3cS5PKdoilqUH4ZA5C6qE8sFrXlWocr0dUqqpqqmP8z1Dua2DqCs
	dqDxH3J7lQW510/B3stQG9KbjI29ZPQaBuYrdhGmWXRnltl8wWzyrXVH9a8qisES/ZyWOThu1eS
	Hl8/9ZCOnaqYUXpRh/8HFpha1XMPmX5Sh0
X-Google-Smtp-Source: AGHT+IHHkOgDRBoQ3p5rRRxYiAy+7qojGE+ZaX7/Dqnol4ahyLPM+Q2s8zZ0AMWmWijNtZjPCyiBHgmpolWsb2S+gro=
X-Received: by 2002:adf:b356:0:b0:3a4:e238:6496 with SMTP id
 ffacd0b85a97d-3a4eedb8aabmr1291575f8f.18.1748497499279; Wed, 28 May 2025
 22:44:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1748488784.git.rtoax@foxmail.com> <tencent_97F8B56B340F51DB604B482FEBF012460505@qq.com>
In-Reply-To: <tencent_97F8B56B340F51DB604B482FEBF012460505@qq.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 28 May 2025 22:44:48 -0700
X-Gm-Features: AX0GCFvdAazJcnjeIdtcKgCy4Hnh2NXiGCB1n6kru5atVUhx8JT-WyGFXdd_3ZM
Message-ID: <CAADnVQ+hUk2wV3M+9mgv_i5sNt_FuHpAnDpkQJ22D37bxAJHsQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add bpf_task_cwd_from_pid() kfunc
To: Rong Tao <rtoax@foxmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, rongtao@cestc.cn, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Juntong Deng <juntong.deng@outlook.com>, Amery Hung <amery.hung@bytedance.com>, 
	Dave Marchevsky <davemarchevsky@fb.com>, Hou Tao <houtao1@huawei.com>, 
	"open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 8:37=E2=80=AFPM Rong Tao <rtoax@foxmail.com> wrote:
>
> From: Rong Tao <rongtao@cestc.cn>
>
> It is a bit troublesome to get cwd based on pid in bpf program, such as
> bpftrace example [1].
>
> This patch therefore adds a new bpf_task_cwd_from_pid() kfunc which
> allows BPF programs to get cwd from a pid.
>
> [1] https://github.com/bpftrace/bpftrace/issues/3314

Yes. This is cumbersome, but adding a very specific kfunc
to the kernel is not a solution.
This is tracing, no need for precise cwd. probe_read_kernel
can do the job. bpftrace needs to have better C interop.
Once that happens any kind of tracing extraction will be
easy to write in C. Like this bpf_task_cwd_from_pid()
can already be written as C bpf program.

