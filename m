Return-Path: <linux-kselftest+bounces-17172-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F84E96C7F8
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 21:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 451541F23D60
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 19:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052CF1E6DD8;
	Wed,  4 Sep 2024 19:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBjEgIL3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906F740C03;
	Wed,  4 Sep 2024 19:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725479518; cv=none; b=eWImYYu+b58fndy1ipYw59fo0BzEl8c/twrQj9G0CdoWz195LKMltzvoSquE/XIlTKEMkI/MCUd2jV7P4b1l4PQHTXOFoYF8SmHIDv9jw0lBHWzz52aU81v/Vy/8Ul/0E4X5/Ba8UVpmkFOiyXy15KALeOOWtiVSQU2PQERzJlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725479518; c=relaxed/simple;
	bh=jMjV+mACabVtS1s/b+EerKLoP4dfqsPQZBap4a0CyLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=siYR+ePXgzKNvZrbZFz1Clebs/RlgSx9bEIbXDCx4sHDH5WGthvRSF8Uvf/bWfeuBxi9pdUEXWNSOst05l5klCNg+gosITuh8cZRWgBzY4szFM71qLK/0E2gOS3BvedNfeparkfCMhB5gsYWkF0VghgF6YR941pzBQvHDPhIyAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBjEgIL3; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-6bce380eb96so28986a12.0;
        Wed, 04 Sep 2024 12:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725479517; x=1726084317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+NBxbNBFdHSHvip0jtI2fspf01m3KW2hgp7dEW0ZGY=;
        b=eBjEgIL3UP4v6qY+sFjYkxSqPlq8Tzxv71RtTYWKifg3mWcDrQlMiHlryvIHznJfO9
         MY8XHDpf9+O/+7Qnd/hG2x7XZfk33/qJqaTDP+OlfF9vCojeY8DPTWMyz/xUWE/GK6vC
         /Ze+PxuX7gE/EtqAXfzkLYoX2l4MEZirx13x4Baqfmbh2b351DOglI/b1iDsYthD4YXT
         JYXRoGnzphWSsRIpI3wkPJIvIgIFyXUCQSMyUXqTi3qvIBrXlWrDp4ztrdzjk2qE0+rD
         eyR/vO59Fjbpps/VvpXlfmfMXQgXnRce/yM9ZAU5JLRLvzXYJP4dgv7C8KS96sYfrKVk
         o+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725479517; x=1726084317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o+NBxbNBFdHSHvip0jtI2fspf01m3KW2hgp7dEW0ZGY=;
        b=iPVysMCZ0Ybfr/P4QwX/w6NENxfrdMFrtroIAQ2KWGDBIOJ0qUUOoBnSwzunOWKpkv
         q7Y772oCVerDrxBQCmKj6RSAG3zQ//+iJVQzPzn1pbZMO9pKkRM+3pawxqxvM5iupusp
         7V3dGT+SiknRBQWRZmW6M+szwlyEHOQBfMMp21Hz6/xKg71HpKYvmzmbhlQe/BbVF41a
         u/xg1jH10HOzHilJIV2Z3t1t41gKtUn7LjsmGvgkKu3lMOhhSU5rufJSP3RPl8EW1s4/
         xNPgUMpGfAlmDIQhC9FI/Ycjhh1IIUKo0JMLcIvB8C/1PMXp8WpEQUJKdkBx4cmrrL3U
         rvkg==
X-Forwarded-Encrypted: i=1; AJvYcCXyDyK1rcqIjkmnLB+umTLZ7Mrv93+tcYtb/iFredCnKM/HHyhGaL3Ti7LuZGHzcAVaWMp5bIg0KcxPmKfP4kU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXGcCSnVS6ZOGIOnqmhcjdNaHAfM53RJM6ZwRqkxDBjiNBhyZp
	eGgOb4yArtGNndMcXb0wterJItwh/ELqBeh9h6kkojVUZqrPP4l1i5Ia2UhNJCJAGL1Ap4e5zLy
	GJbRwXIMMDDXTTQEur6t2VCtMGVc=
X-Google-Smtp-Source: AGHT+IH+Yuqzm9oCB9w3ar1Td/gA2h89tyfOcj5kaT/RrUbIgTWAX7xaMx4mFUksnx1RL9hNw1onz3Ax35hD3uLxWM4=
X-Received: by 2002:a17:90b:1888:b0:2d1:ca16:5555 with SMTP id
 98e67ed59e1d1-2d890620d8fmr14486713a91.37.1725479516934; Wed, 04 Sep 2024
 12:51:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1725347944.git.tony.ambardar@gmail.com> <d9c2565c75d7a41a6cd7e4b1657da6cdc2428df0.1725347944.git.tony.ambardar@gmail.com>
In-Reply-To: <d9c2565c75d7a41a6cd7e4b1657da6cdc2428df0.1725347944.git.tony.ambardar@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 4 Sep 2024 12:51:44 -0700
Message-ID: <CAEf4BzYRL_gXfBVr-rBSDxy9fwHyqM2p+2PO-7=rCD9iGF34jw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 6/8] libbpf: Support linking bpf objects of
 either endianness
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Quentin Monnet <qmo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 12:34=E2=80=AFAM Tony Ambardar <tony.ambardar@gmail.=
com> wrote:
>
> Allow static linking object files of either endianness, checking that inp=
ut
> files have consistent byte-order, and setting output endianness from inpu=
t.
>
> Linking requires in-memory processing of programs, relocations, sections,
> etc. in native endianness, and output conversion to target byte-order. Th=
is
> is enabled by built-in ELF translation and recent BTF/BTF.ext endianness
> functions. Further add local functions for swapping byte-order of section=
s
> containing BPF insns.
>
> Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> ---
>  tools/lib/bpf/linker.c | 78 +++++++++++++++++++++++++++++++++---------
>  1 file changed, 62 insertions(+), 16 deletions(-)
>

This one looks nice, simple and straightforward, thanks.

> diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
> index 7489306cd6f7..85562e26c3de 100644
> --- a/tools/lib/bpf/linker.c
> +++ b/tools/lib/bpf/linker.c
> @@ -135,6 +135,7 @@ struct bpf_linker {
>         int fd;
>         Elf *elf;
>         Elf64_Ehdr *elf_hdr;
> +       bool swapped_endian;
>

[...]

