Return-Path: <linux-kselftest+bounces-39729-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6967FB32420
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 23:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91FA7AA44DB
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 21:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93E2335BC3;
	Fri, 22 Aug 2025 21:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRAS1keY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B48A32276E;
	Fri, 22 Aug 2025 21:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755897802; cv=none; b=Zl0z7xH11mDMj+cYZNBVth9zqJuFndf6JvwRUKL5tHLW0UTRCqjcURMrEbXeD/El020pK/4srjedHbr088EQD9lXBpHQI3xoEK7+I4ivvcNzxGwAUHi0p/X1g4Tod8d1I3mV6Q7tjo99kCQcen+C+wEfN+43dQYXZ5Nnm/yWCzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755897802; c=relaxed/simple;
	bh=oH8hEd3Xh95OS4Zj7F4TJPkJBMw5KkDWhnVrMfbT3kY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ExagrvHilePMTcXlZ0chkPMx+1nGs2n1Y+ZEGNy/4SHVAplpQWCZXrf/uJ7S2Gpv5m3b3lLxdGy/EQ6C6b1AdyfLF6j+Y26d6CPLQDkFZyMx+ckXWPgRnWGuUWUHNYVrwCNS+vANxo0/vyUoxyQSngpjQw+Hil286WmtMFwju1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRAS1keY; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b4717330f9eso1800617a12.1;
        Fri, 22 Aug 2025 14:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755897799; x=1756502599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cigHzkD9VKrMPHnR2u8edDTCZGXj+bAVSWOdyrroCYU=;
        b=dRAS1keYsbC2BtRbTC+k1qHgf62rNESoxz/aeMbIBpB45ZNTxmIIo6MyNG5wqS84ji
         TPWXbSAO7OzKu2OdJz66M/62K3NQcaPdgq9Ag5cUmy7g7zaClLR9k59QVQnV5mnFkMZX
         U2yI0qFfH5AXtkDX2iTxjDPKErWFnnDFD1zKIuDD20ZwM/uVKd3aTIn6G6xqg+4m3nhd
         rm/cb3LM99g1SAkHyqlcrH54yE2X0e5RCs72v+zi8hFAAMx/GTR1Oo3R+P4pXqzSYUFJ
         dZ1yv7uhRFpm01ZURaORT0lL1caMokn41uDSuvczNUY/kUs37qhVVcA935SblhjKyfAp
         vWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755897799; x=1756502599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cigHzkD9VKrMPHnR2u8edDTCZGXj+bAVSWOdyrroCYU=;
        b=DIi317IsgIRHCoONl/9cDuAE/iOlCbWjNEI5NgNlze2yx1o4E7WRwa60pssH6vUddq
         pTXfH2jd3lTvqaFBPL6i9msG6UH/L4KsRUKATVz82kn2dkFQrQoVV9VjX2SFkGoiyvlU
         IeyE+7RBhIbFaULW2LDP4nJGB1kUE6SM8sDztVu5mkijYKiNs6i8IZT09delPkK5M8Z9
         uRZ3DsWvngvMwpTj34oIMe0yVCdicos0bQGUAeXs5JbZj5jo6vPaO4MTjKOyeuWTrsyk
         qKutluBFF5YZENV6oXhdMI6WdaJc2UK0QnQWW9eQ3BpIwLd3/kZydABSpV/H/1Epz0i/
         7BLw==
X-Forwarded-Encrypted: i=1; AJvYcCUBo8iJygo0eReFJK11evgeh9ACrzq0VBwlTkfT4ALKF02pqL4tuAtYc+S+wefAbehaYUiZVPuagl+VGCE=@vger.kernel.org, AJvYcCVWTf/qosQsEWQNQnkdGz3Vtg0cMHbgK9D29DzHE/iGEoki1zbKQjZCoFk7g8hH+WPjTkT7dUK0KacHxM44LwXT@vger.kernel.org
X-Gm-Message-State: AOJu0YxHe4WeOb+qjEKrJ2VHQv6+L/IMf8qxmfQLMo4MmKlPy1t3ZFwp
	aywrSEUi60Dv/j/oFNUuQuwneHRx+XtzRmbgXGIILOpjdPtzPR6n4u6AcgTsEP7PfS3/UnmrjUu
	Dmx95vBlT1SliBqO1D2BZzdl2vkL0Phk=
X-Gm-Gg: ASbGncv3ddWeXQrP9q09sn3jn/fEWtgNtJ0c7YPvt4z4NhTlwbEwvQXXSm3me/IfvvI
	qZPWzvgfxp2fth7o80gQSKPUsv2VevvnLniZogA3zPOAIZc2gDWxBPkEGDJbJEjB+JmHWTNf78W
	Wu9649mxQpAnTKroWSXAHTApNJc7mdtdRho+koXbNra8NUqTe0mmUoOyd5jwi41ef1BnBaM8wty
	WNPrdxAWdfMvoPKjrEBwmA=
X-Google-Smtp-Source: AGHT+IGAb1ykLBNf+7vCFUXiySU8Nxu82yayp/F9ft0zlMg1j7Ay3f7ENvehleDJa8y+ZLlAzgq9UieLZ8bAU9N3ca4=
X-Received: by 2002:a17:903:1c8:b0:242:3105:1787 with SMTP id
 d9443c01a7336-2462ef8e152mr58423365ad.50.1755897799298; Fri, 22 Aug 2025
 14:23:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804022101.2171981-1-xukuohai@huaweicloud.com> <20250804022101.2171981-3-xukuohai@huaweicloud.com>
In-Reply-To: <20250804022101.2171981-3-xukuohai@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 22 Aug 2025 14:23:03 -0700
X-Gm-Features: Ac12FXwHNeczuDhGuV2foSF9m_Z4qnE30i2s2DCCieGa_DciRFyxDqFAIRCA2vA
Message-ID: <CAEf4Bzaq5drHWChXoRBnrmkb6reAsSVj8r=uByFSup31FMA7hw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] libbpf: ringbuf: Add overwrite ring buffer process
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yhs@fb.com>, 
	Song Liu <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Willem de Bruijn <willemb@google.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, Paul Chaignon <paul.chaignon@gmail.com>, 
	Tao Chen <chen.dylane@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin Kelly <martin.kelly@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 3, 2025 at 7:27=E2=80=AFPM Xu Kuohai <xukuohai@huaweicloud.com>=
 wrote:
>
> From: Xu Kuohai <xukuohai@huawei.com>
>
> In overwrite mode, the producer does not wait for the consumer, so the
> consumer is responsible for handling conflicts. An optimistic method
> is used to resolve the conflicts: the consumer first reads consumer_pos,
> producer_pos and overwrite_pos, then calculates a read window and copies
> data in the window from the ring buffer. After copying, it checks the
> positions to decide if the data in the copy window have been overwritten
> by be the producer. If so, it discards the copy and tries again. Once
> success, the consumer processes the events in the copy.
>

I don't mind adding BPF_F_OVERWRITE mode to BPF ringbuf (it seems like
this will work fine) itself, but I don't think retrofitting it to this
callback-based libbpf-side API is a good fit.

For one, I don't like that extra memory copy and potentially a huge
allocation that you do. I think for some use cases user logic might be
totally fine with using ringbuf memory directly, even if it can be
overwritten at any point. So it would be unfair to penalize
sophisticated users for such cases. Even if not, I'd say allocating
just enough to hold the record would be a better approach.

Another downside is that the user doesn't really have much visibility
right now into whether any samples were overwritten.

I've been mulling over the idea of adding an iterator-like API for BPF
ringbuf on the libbpf side for a while now. I'm still debating some
API nuances with Eduard, but I think we'll end up adding something
pretty soon. Iterator-based API seems like a much better fit for
overwritable mode here.

But all that is not really overwrite-specific and is broader, so I
think we can proceed with finalizing kernel-side details of overwrite
and not block on libbpf side of things for now, though.

> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>  tools/lib/bpf/ringbuf.c | 103 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 102 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> index 9702b70da444..9c072af675ff 100644
> --- a/tools/lib/bpf/ringbuf.c
> +++ b/tools/lib/bpf/ringbuf.c
> @@ -27,10 +27,13 @@ struct ring {
>         ring_buffer_sample_fn sample_cb;
>         void *ctx;
>         void *data;
> +       void *read_buffer;
>         unsigned long *consumer_pos;
>         unsigned long *producer_pos;
> +       unsigned long *overwrite_pos;
>         unsigned long mask;
>         int map_fd;
> +       bool overwrite_mode;
>  };

[...]

