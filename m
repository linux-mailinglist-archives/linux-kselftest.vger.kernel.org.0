Return-Path: <linux-kselftest+bounces-5490-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7251869CCC
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 17:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DF861F247B4
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 16:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A402576D;
	Tue, 27 Feb 2024 16:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="APOVu2Si"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAB622091
	for <linux-kselftest@vger.kernel.org>; Tue, 27 Feb 2024 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709052719; cv=none; b=VwvUY8JrfsbareRWzZkTQ0fqfKlo/DrUjbZ4lnR5bi6qR/7oRo075yokd1OHI1wdmXVlGKHHmo9o5WDIhl/fIPJXxlYysVWOKwCE2R47uvlZl/SGoklDmK3MbOeFlgWW7lG8/bnW0QuZxwIsaCZnzcy+tQ7EG/l8WC/zK9b2hm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709052719; c=relaxed/simple;
	bh=zaOkgxIiB8GNse2AVQG29Q0YOlZCBjN6gtzoplU25RI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VBYIiUJLRzBwsO7Rld2kfiI6CkoNdklqVY0aslfFqDs9reKXT9gOvCAIbro7h405HetQ7GyUh7ImiFaRZdzpMOvrVjnG3a/4QBuwH/QHDRIqIylIoSDMW2WjQhA2X94JNOJefugbUUA94aUH+AwSLHyC5zTDBWsvX7LMJ2ZVM8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=APOVu2Si; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709052716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fa7hNUw2MnGUSkkyaysmsOHXW2bn0B5N2bcUJWgOZXI=;
	b=APOVu2SiDYy8HXCXeWjtvdxwHfiVad7qU8YtTLZHfyVYxcnMnXpcGZZCYuRcdzR86kzoFx
	fJzhI5JM/w7m7XVARHTrUvFREa9Xwfxwmi+Efw9T2vRoKtHKH2Vi7fAeS5dSzU5Q670aYZ
	MdQ9rWQPE1J8qavJbluL4y9H7irvdPI=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-HZOqnUNgOV-ACStIsNFGqA-1; Tue, 27 Feb 2024 11:51:53 -0500
X-MC-Unique: HZOqnUNgOV-ACStIsNFGqA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-512fb30e992so2337452e87.0
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Feb 2024 08:51:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709052712; x=1709657512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fa7hNUw2MnGUSkkyaysmsOHXW2bn0B5N2bcUJWgOZXI=;
        b=RSnuIYvobm5A+9TIgtRl8wmb4dMkO4PO8I7kK1k3CFvmLsb6i3Z+wPcnGNbW2cj/5X
         IwtOJ2fQrgDApOLW0Awg/k5d7/4Kr8zBrFKeUr86tt3Fv5TxJUNJfB5EG+wuTzOZ8X1r
         1Bqks5bCnX8Jq1UuV7UI4CnRwElgzfIhiVAY4jIvlCAWRX12FoSZuXXmCJdVSCZPrp+t
         N6I/9zq8usp3Ew9rUPzaosQkhggG8479b/ac7i7T/4Jm3GmaI8+8EpyoLqOawnh41He/
         xa/AZ2RIOln0MItVki4oHu3eJ9p/igfqMmepnWyG6PW0o/dobASsJbsSfqWj+8VTV8xg
         F0Wg==
X-Forwarded-Encrypted: i=1; AJvYcCXyb3GQHIRWmlMvu9Gz6AwySaGEStg6aCuoMUItlAXfwFShvZWjDTdRtCzoLltE8EMTOQeE9TNTG3wV3DCcOUtElf1SkJDI+QsrThbFhA1T
X-Gm-Message-State: AOJu0YzfNoanDCWH3YXlDecxc8e3Na46XhQKAZiVhc29cegami+TaVUD
	rnDmwSwmPjq1tQbRneLigvX6jngXVc1B2aE3xMBJ6JfMEUqh0bobjX71svdnMlciMW5CrZIKIAc
	nHAvRVKiNeuNbrlP9KZSyFgHq4Vtx8GZkxc3GGdeqz0tKvMVRFpu76pRSY2xuComy50DwtsURDo
	YV+JkR5s+M1rSMKJTb1fDRs6SvFhCd4ziHg0YfHj1v
X-Received: by 2002:a05:6512:21c3:b0:512:eb68:d314 with SMTP id d3-20020a05651221c300b00512eb68d314mr5801939lft.37.1709052712053;
        Tue, 27 Feb 2024 08:51:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFn+5DokthX5JEB0laGa6PU+Ets4rObRsTUnAYyutXhmYDPA3cLG84WeT3/0s2gZENZv7xZvDHyIB5bfThwtvA=
X-Received: by 2002:a05:6512:21c3:b0:512:eb68:d314 with SMTP id
 d3-20020a05651221c300b00512eb68d314mr5801912lft.37.1709052711724; Tue, 27 Feb
 2024 08:51:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221-hid-bpf-sleepable-v3-0-1fb378ca6301@kernel.org>
 <20240221-hid-bpf-sleepable-v3-8-1fb378ca6301@kernel.org> <55177311ccdc24a74811d4a291ee1880044a5227.camel@gmail.com>
 <pocfd5n6lxriqg7r6usyhrlprgslclxs44jqoq63lw734fjl2g@5kv4hjaux2fp> <9a35a53a1887fb664fd540ec7e272cb3ea63f799.camel@gmail.com>
In-Reply-To: <9a35a53a1887fb664fd540ec7e272cb3ea63f799.camel@gmail.com>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Tue, 27 Feb 2024 17:51:39 +0100
Message-ID: <CAO-hwJ+TGiLrc4De7htvKaSsMfQnZahK-zONAMNgUMYHEQb-7g@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v3 08/16] bpf/verifier: do_misc_fixups for is_bpf_timer_set_sleepable_cb_kfunc
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 5:36=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2024-02-27 at 17:18 +0100, Benjamin Tissoires wrote:
> [...]
>
> > Hmm, I must still be missing a piece of the puzzle:
> > if I declare bpf_timer_set_sleepable_cb() to take a third "aux"
> > argument, given that it is declared as kfunc, I also must declare it in
> > my bpf program, or I get the following:
> >
> > # libbpf: extern (func ksym) 'bpf_timer_set_sleepable_cb': func_proto [=
264] incompatible with vmlinux [18151]
> >
> > And if I declare it, then I don't know what to pass, given that this is
> > purely added by the verifier:
> >
> > 43: (85) call bpf_timer_set_sleepable_cb#18152
> > arg#2 pointer type STRUCT bpf_prog_aux must point to scalar, or struct =
with scalar
>
> Right, something has to be done about number of arguments and we don't
> have a convenient mechanism for this afaik.
>
> The simplest way would be to have two kfuncs:
> - one with 2 arguments, used form bpf program;
> - another with 3 arguments, used at runtime;
> - replace former by latter during rewrite.

It's hacky but seems interesting enough to be tested :)

>
> > Maybe I should teach the verifier that this kfunc only takes 2
> > arguments, and the third one is virtual, but that also means that when
> > the kfunc definitions are to be included in vmlinux.h, they would also
> > have this special case.
>
> It might be a somewhat generic mechanism, e.g. btf_decl_tag("hidden")
> for kfunc parameter.

We also could use the suffix (like __uninit, __k, etc...), but it
might introduce more headaches than the 2 kfuncs you are proposing.

>
> imho, having two kfuncs is less hacky.
>
> > (I just tried with a blank u64 instead of the struct bpf_prog_aux*, but
> >  it crashes with KASAN complaining).
>
> For my understanding:
> - you added a 3rd param (void *) to kfunc;

it was struct bpf_prog_aux *, but yes

> - passed it as zero in BPF program;
> - applied the above rewrite, so that r3 equals to prog->aux;
> - and now KASAN complains, right?

yep, but see below

>
> Could you please provide more details on what exactly it complains about?
>

Well, there is a simple reason: that code is never reached because, in
that function, there is a `if (insn->src_reg =3D=3D
BPF_PSEUDO_KFUNC_CALL)` above that unconditionally terminates with a
`continue`. So basically this part of the code is never hit.

I'll include that new third argument and the dual kfunc call in
fixup_kfunc_call() and report if it works from here.

Cheers,
Benjamin


