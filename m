Return-Path: <linux-kselftest+bounces-25251-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D83E2A20037
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 23:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBDF318869DC
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 22:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C301D7E4A;
	Mon, 27 Jan 2025 22:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBogqoiN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F43B64A;
	Mon, 27 Jan 2025 22:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738015559; cv=none; b=CjyVdYdqvop+4vErg5E4rxrWQIh0MhVocKqRm7Q/4d/meN9KcepAjSulCw4QTD+H+cFTz3bFkf0KKH0tEDbO+q1PKkcEVTI+nZZrRnukBUsNBz7fKSFyaO35sTzXJ2vT2bAYcFwym7VbV3bLFReaqzUuoMICvrssj6iIh6sfhZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738015559; c=relaxed/simple;
	bh=9N+XSmBoarkOQfkGPuL9tRrQksXm4Gv2lX/v/1vjZqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j9+bIZMpjE6PIneSPe6gfhmWUkK13qbG2E1CQ3ivURpsHPkBf0gcOviLvWD1NHWKvgk5xDQDilbemNtN3A0bQe2RJeOz/NnrjWvOyedBtOh1fGiExWOYx2ts5U22afHXmVbl4T1by5hZgjRcd80XdrYgLmfj5ehz3fzJMGGLvCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBogqoiN; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21675fd60feso110587675ad.2;
        Mon, 27 Jan 2025 14:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738015557; x=1738620357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+QrLyHJ4Vggvq5+RcXppD/MHlX2L2OBpoLDY+MGP7Uo=;
        b=FBogqoiNWdEcU8jKcqrOcmv4xvtIMDhlpddKN4n3K2V/ukPA5kasFrP5SgeErfzDoA
         OPDAqWJpNjg+f9ARbQsg+R0dnFwKfXm7f9M5a2p0XsQAkqk7GJOPNdGhPm0gCGDu6SeT
         VKKc2IaamqYU+ZdoUnK7l8Kgmbzh+jQhTIGHsbQocN7Ti+3fVMgk+nvS4/aHOg1msop1
         KVOeacKQFPPkXn92UN60oSofZewtBn4tDBJCJwdE1a7Y6GIGP9j8We4CbsV1JlFX9j+U
         Ommuzs+o7GjVBRGDlebq4RivqT3efXlHgKaY1Mx+F4or/rTioI5kl9Z4JfawDIFqeUKz
         oYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738015557; x=1738620357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+QrLyHJ4Vggvq5+RcXppD/MHlX2L2OBpoLDY+MGP7Uo=;
        b=MfVhbtzuDWF9uI28pwLeZBe67wrcjhxpoBqIvjolyiFAyXfKrij+ixi4aiCFMW3s+2
         Ve0N2ecu9gqg2LDa2MocIYy4FVrvxNF531L05FQYhCjsLBI1QbbMiZCUXcp/i6sdN/WH
         C+zFEw17H0EdrqDpfhHiCC1zBCmEiEKN55nIAMqDjS3QbiJuO923Vcg2y4gv+dZbQgzo
         QSQl5s658yuwZu7fukVjiF2a2Kbrsn/6ABhhKrOSaNN0zTbSFncz2+ULOunknb++HJ6B
         tMki16XevRz/so5IGSSgWY8xCXtHk5bW8Znxd0jdyzJ3+4wjo5qk1E/3/k1nbpF8OhaK
         xQeA==
X-Forwarded-Encrypted: i=1; AJvYcCUWLfE7ya/WjWruUNCYWJ29rOmZKx2IUdbBxYk8dfZBgWsi0IQTwUdclBK6kXCkZGz+6vU=@vger.kernel.org, AJvYcCUzhSQKQ6k2Y5Sr3hl7OpXJ9ICWH+8ut3pFfmvrOx4tj9n/sU6WZ1cxdiquNoqFOdV0hW9oUU1COJelTcrjULto@vger.kernel.org, AJvYcCVElxKnTL8EIpRufuBcFODylU0xaw3JCZobi5YLOQnWkt9i5z7fu7S+mZgRuu25DZj40M/sQSrtLguu1Den@vger.kernel.org, AJvYcCXOvVehZd1xfnxDrB3buBKOHAi4oh3qO+E0s5c7VHW6Nk9dPsMUQrVEYjBMLNhv3Wyz53w3fOFFzuJjLVz6vU8ik8Zt@vger.kernel.org
X-Gm-Message-State: AOJu0YxlVpb0DdHF7Vujb7OKEqHVLB2GSX/pRt7KqaTPGmt6B+PR55FI
	jNuPvz431tK85Yd1OM9XpfhaZmmJ5WgKFtGgsDx5rKntgbO1GyuNMB9r7fDWog3HH2nvmcKYMk0
	+Uf1954Ef61JFifo/o7mByhuzXBnsVo9d
X-Gm-Gg: ASbGnctPHkOTV6rhQzt9ocfVL4lyL+hkF+3acYKa6oji9O0yZGauLo+2uhTTDVsX27y
	3sjIQzqPR7nlcg7hi3VBlhi5A2bQyJfqFtffg160zbKnkA3Ia3ygc3H5UmooKbV0EIrzFk/9H4y
	z0JA==
X-Google-Smtp-Source: AGHT+IHva/OP+DoTh2/zhL+78DJJwCmZNeRm2fJ+vXdhtTPPlAt115197G2ZeZ462STlSYJ/EFxcVsiFbi64wvOoqeE=
X-Received: by 2002:a05:6a20:a105:b0:1e1:b153:4dc9 with SMTP id
 adf61e73a8af0-1eb214983b7mr64699594637.19.1738015557326; Mon, 27 Jan 2025
 14:05:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250125-bpf_dynptr_probe-v2-0-c42c87f97afe@outlook.com>
 <20250125-bpf_dynptr_probe-v2-1-c42c87f97afe@outlook.com> <CAADnVQ+bRvL-4n4ZB5QS2oUxvo3vhJHf=8=2No3WWqYHqSyBEg@mail.gmail.com>
 <MEYP282MB2312A90273FF290ED5FC6F6AC6ED2@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
In-Reply-To: <MEYP282MB2312A90273FF290ED5FC6F6AC6ED2@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 27 Jan 2025 14:05:45 -0800
X-Gm-Features: AWEUYZllQivFCryOHNWkib_tGKPFG0AXB80XDq4gGunucSp_1aM0Xhch7dWS2Hw
Message-ID: <CAEf4BzYkuPK4_W2DFiyKbwmOrdTJ7GuMLnWSgC8i=tV-FJ8mZg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/7] bpf: Implement bpf_probe_read_kernel_dynptr
 helper
To: Levi Zim <rsworktech@outlook.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mykola Lysenko <mykolal@fb.com>, 
	Shuah Khan <shuah@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 25, 2025 at 5:05=E2=80=AFPM Levi Zim <rsworktech@outlook.com> w=
rote:
>
> On 2025/1/26 00:58, Alexei Starovoitov wrote:
>  > On Sat, Jan 25, 2025 at 12:30=E2=80=AFAM Levi Zim via B4 Relay
>  > <devnull+rsworktech.outlook.com@kernel.org> wrote:
>  >> From: Levi Zim <rsworktech@outlook.com>
>  >>
>  >> This patch add a helper function bpf_probe_read_kernel_dynptr:
>  >>
>  >> long bpf_probe_read_kernel_dynptr(const struct bpf_dynptr *dst,
>  >>          u32 offset, u32 size, const void *unsafe_ptr, u64 flags);
>  > We stopped adding helpers years ago.
>  > Only new kfuncs are allowed.
>
> Sorry, I didn't know that. Just asking, is there any
> documentation/discussion
> about stopping adding helpers?
>
> I will switch the implementation to kfuncs in v3.

you might want to look at Documentation/bpf/kfuncs.rst as well

>
>  > This particular one doesn't look useful as-is.
>  > The same logic can be expressed with
>  > - create dynptr
>  > - dynptr_slice
>  > - copy_from_kernel
>
> By copy_from_kernel I assume you mean bpf_probe_read_kernel. The problem
> with dynptr_slice_rdwr and probe_read_kernel is that they only support a
> compile-time constant size [1].
>
> But in order to best utilize the space on a BPF ringbuf, it is possible
> to reserve a
> variable length of space as dynptr on a ringbuf with
> bpf_ringbuf_reserve_dynptr.
>
> Then currently we have no way to read a variable length of kernel memory
> into this dynptr, except doing it chunk by chunk[2], which is kinda awkwa=
rd.
> That's the problem the new helpers trying to solve.
> And I am not the only one needing this kind of feature [3].
>
> Andrii said it would be a straightforward addition as it is a super thin
> wrapper
> around existing functionality (we are just avoiding fixed buffer size
> restrictions of
> existing probe/copy_from APIs)

Yep, exactly. All the probe/copy APIs we have require statically known
dst buffer and, worst still, statically known read size, which makes
it very hard and cumbersome to request data which size is known at
runtime (e.g., process argv/environ data).

So, in short, I think these new dynptr-based APIs are a good addition,
but yeah, they'll have to be added as kfuncs.

One thing that we need to figure out is how to deal with SKB/XDP
dynptrs, we can't just reject them as destination buffers for all
possible APIs. I think we'll need to develop a set of internal helpers
that would handle skb/xdp dynptr cases almost transparently:

  - if skb/xdp memory is linear, we just memcpy/probe_read into it directly=
;
  - if it's not linear, we use on-the-stack small buffer (128 or 256
bytes, something like that), to do desired operation (memcpy or probe)
into that buffer, and then using generic dynptr write functionality
from that buffer into skb/xdp.

We probably can start simple with excluding xdp/skb, but this should
be the second step.

>
> [1]:
> https://elixir.bootlin.com/linux/v6.12.6/source/kernel/bpf/helpers.c#L260=
0-L2601
> [2]:
> https://github.com/libbpf/libbpf-bootstrap/commit/046fad60df3e39540937b5e=
c6ee86054f33d3f28
> [3]: https://github.com/libbpf/libbpf-rs/issues/1041
> [4]:
> https://lore.kernel.org/bpf/CAEf4BzZctXJsR+TwMhmXNWnR0_BV802-3KJw226ZZt8S=
t4xNkw@mail.gmail.com/
>
>  > pw-bot: cr

