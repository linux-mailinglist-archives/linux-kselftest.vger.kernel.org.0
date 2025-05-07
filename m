Return-Path: <linux-kselftest+bounces-32561-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1346CAADAB3
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 11:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A1B81BC1CD2
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 09:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BBE230BC2;
	Wed,  7 May 2025 09:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="XySpEsOl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B67230981
	for <linux-kselftest@vger.kernel.org>; Wed,  7 May 2025 09:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608832; cv=none; b=UlhIL8mmxDvxyhyVMe37rPtpWhjxz6gUNn3jkrwU+ACLBV7TSuLmOTcWrd++oVtQD00MaBMu/lw5lS9XKZmVLEyKuJzPbZY+60TSavoSsaKgElioaP2Ir4Sxr8KfeQCnWdVl1eExDgU+EZMkg4Up4UXQoZIIluREtFPwIwft7GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608832; c=relaxed/simple;
	bh=hZC5f+b9USatNoguTDEhrP+OZA4hqYVfUftEwfqtpBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QoktVUEerkC3SI/g7kpsNqlcvEd218zTQs6pu/DF3+gAPUnLABHUVaIFxqiMFepPhNdXqGaWET3s9EJSLKRK2btdTvBdWNpKQ9Irhh2Xap7Tj02rydEGrLyWogwgHFjkks9eC6RYKeUk1asTjzfRPZUxgjrvhc0n3qfhpv1IS8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=XySpEsOl; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39ee57c0b8cso5966639f8f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 07 May 2025 02:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1746608828; x=1747213628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HzWczKOtRNdv6oYCcCWTL1fK96+7hkuKcZ+yQdI7Ga8=;
        b=XySpEsOlzlx9BD3K2I9sACRU4+r0ads2Re2zrMJ7l6xo3twTSfpUI+XMqOAro488Sp
         HJyIveFJ5K/xgN2mWon3CGl2I4Q8f4AUE1QM03KjTqtnubf2CKFhen3Hw79q84Mq2uBD
         8L2CHY9NC/0+O24r0S9Mdz7RvY1PVXkRO5JIm+E50bPNkJgyw7C6gBt5HYUEy7yA0p3s
         q+vmBnKqYAqhe5RLLJTjjQPEK+QhL9IYE/2LI+WyJFQsRbcZmopd0Pqj0QqzxZI0iy6H
         wmOeddQlzxyEvInfUdTvZGUJoEBJtszTvfhhnKlgCR5qzAjcGfYmrqZSSUzqUdHEgMmU
         N6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746608828; x=1747213628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HzWczKOtRNdv6oYCcCWTL1fK96+7hkuKcZ+yQdI7Ga8=;
        b=ilv4VPbwmDm4CHXns+hSGikd8c+QUJOi96SCRL0zY0zfdT437PvCInp170yNox0gXC
         9zG2512rTi+YcdZwisUTaAFU0Cqc3kkV9sZF2zM24ydQeIC2s9Bn2U9M7yAmQuWJT7by
         7o8qrUiPZCI/GLFvYBcLULZfmZaYK136tpPUlt8XWj6qeG4ng67CR3du0NtTeu0gIVmK
         8sP1YhsorS0Z9EoZ0h5jt0yWSHWN9bRmNiI+airc0NpdqbcVaqPolD9bWtJW4Nfv+53V
         XKbljmKZlUg6EVk/qgHMI4jsgE/dpMLb4OYyK3TwNxAsImYu6IRLfJc/iVIDk4oBo0gw
         hpLQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2TIj0sV7rB16gRxQ2ER4b7+rFQAa53DoxoU54hy7bLJdBcvULO1yRublx8c6AoB6n1kuIO5tKJLXCWk9Jxys=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsNusDKVK+8orH/6mVkpTacGyEa5ZBsdKz9tIVFIf+pZdUuFiy
	tRfiPXANIdCYhREpZPtyLDYmFq4iWxCakiWnLc9eOx5s+m+NkOOzduFkvWkH0gfGwMJTEdw6bsp
	rMxAlEjN6gds7GAMqLILiuBzoMLYA0KPVTfWgHQ==
X-Gm-Gg: ASbGncsdQCfqCXNzPt7R8fAzR0BC2y7m9aMl4VNqCctWb6WmLCHgcQhw5RlRKroqBrU
	hIQtox7E+1W7mNRwXzEaOLs0hz+gzyvU/ZxXDp+B9z52+SxDZ2fi7Ikm6tg2P6GGKgl3eYRNxSl
	+JRoKMPkpW6EEnmLbWZK1ZNkNpIgXFRgPZrZBbbwo5NSvirA==
X-Google-Smtp-Source: AGHT+IHjbkLnacbos9jg8MSNrNqfZgtfYSx+9ggUbfHgSlwtKGIOIJuAXx/CFfKUFlefpe1UhB48Y5x5Uo8a3HvYMaw=
X-Received: by 2002:a05:6000:2210:b0:3a0:830a:3d63 with SMTP id
 ffacd0b85a97d-3a0b4997fc5mr1984898f8f.9.1746608828586; Wed, 07 May 2025
 02:07:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505-vmlinux-mmap-v3-0-5d53afa060e8@isovalent.com>
 <20250505-vmlinux-mmap-v3-1-5d53afa060e8@isovalent.com> <CAEf4BzbsLJgbnuLj6sYFgH7sUZPfn3SqRf_5edTSGuo2oYXN4A@mail.gmail.com>
In-Reply-To: <CAEf4BzbsLJgbnuLj6sYFgH7sUZPfn3SqRf_5edTSGuo2oYXN4A@mail.gmail.com>
From: Lorenz Bauer <lmb@isovalent.com>
Date: Wed, 7 May 2025 10:06:57 +0100
X-Gm-Features: ATxdqUF-AtJKaQ86AR2mJxx8_Qq77605VMH3v3VHVteQJKjxM9Yh70Gg0ik9GJQ
Message-ID: <CAN+4W8j-s3YSj-Ct7pNiXkhVnsVkv_bWx22WCnkGYf3mjRf_Fw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/3] btf: allow mmap of vmlinux btf
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 10:39=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> > +       if (vma->vm_pgoff)
> > +               return -EINVAL;
>
> any particular reason to not allow vm_pgoff?

Doesn't seem particularly useful because the header is at offset 0,
and I don't trust myself to get the overflow checks done right.

> it's certainly subjective, but I find this error handling with !err in
> for loop condition hard to follow. What's wrong with arguably more
> straightforward (and as you can see I'm not a big fan of mutated addr
> but calculated vma->vm_start + i * PAGE_SIZE: pick one style one
> follow it for both entities?):

Yeah that's nicer, I was just going off of what Alexei proposed.

