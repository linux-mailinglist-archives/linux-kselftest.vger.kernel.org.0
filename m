Return-Path: <linux-kselftest+bounces-42749-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9E0BB86BE
	for <lists+linux-kselftest@lfdr.de>; Sat, 04 Oct 2025 01:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2CD03BCB97
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Oct 2025 23:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA5F2737FC;
	Fri,  3 Oct 2025 23:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CP+IkT7y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A9F265296
	for <linux-kselftest@vger.kernel.org>; Fri,  3 Oct 2025 23:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759534657; cv=none; b=mEm6CoQARzyuL9LsSqLDCvNXUtZ3n7dymN7xtsuCdqvrX2lgOrU9SnnTcFLME4oJflfzXsZmhrq/aC71YCmqH0b/rG8aV4tD7oJYAZkeRCuaEZkE0v/BircWs4icD/L78TEd4HzlTtDbZE+Y5RYsZni6BtX7jL6kvjWZspA6WVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759534657; c=relaxed/simple;
	bh=GNFmT2VxEaPkh32hnm7rrBTVz4auBq5soR9sb5kDJTs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RCWX8XXDP1FejQQhJ+CoBPJD4tPzPWsiX0capt9Cp+YKLw7Fb61EClcCnSjw2fcoRyE+gsB8kI933wdBWDhcJCIHAaUmeC5EELeP9htq7NgYE5u+rireZhYiryy/141TSuP2otiX++IxSyHnWVP6NPW2WtnNFKWvvL3H726SeVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CP+IkT7y; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-77f68fae1a8so3800331b3a.1
        for <linux-kselftest@vger.kernel.org>; Fri, 03 Oct 2025 16:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759534655; x=1760139455; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8opnbw/m2Z8T5yDXIhCeyupu0RmNSEU/h2Gk1+QmiW8=;
        b=CP+IkT7yqUoHZoT7zCW/Gm9XneFhutzrzUrIVZiWwcnMJcBSJ3p1hDaj3yK2mQUl02
         KPW+98yOockhCm2MqcqDsFfSpOmX0Pb6HuI+xgECZSurqSCcQKNqgDn4YF07vAZhgiRj
         f/WephWzE1sBwEM25yu9BuGHOQAJqv1AVT7B3Q44rXFF8QFFCZOtFegmhBCehfn5EC0Z
         j3exu3bw4/ogRD/ICwExcXeJRsr9HnWI4C2cI7MfCEpN60IYwCm7xaEDan1ArbgOdo6p
         cT2xWKnJfsDbvmyDJDOEZbIZrlAEoMhVV/PWA7LrgHy+L3IKpxd4CJkvwJ9TbeQNlVvz
         E4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759534655; x=1760139455;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8opnbw/m2Z8T5yDXIhCeyupu0RmNSEU/h2Gk1+QmiW8=;
        b=qlIZZITXxfrbqUsu8nUSUOwj4TWfdDkJldGHE7E4o9EdO1ylISRiTqWYoBEODxCsMA
         Jml19Kf+0cEb2JWaTYSBVD7sBQPq5ESeqwfeWmCj87QkKJypK/GfG11wEGzCzvaE3W6o
         NeYa5l1Urz5MG0MP4SuzQ/tFl6HzBmgUd8bMnAOwCav19Wz1BUAtb4SxBWr8AMk0AFon
         8Y3awzuSKpqOa2tcNPRfrRBwQWa2qubkLwA+BvvWbvMUVgfjcznQ444jLX7YF1PAHJsf
         8JksLZkCHEC8ucjwxh73TwQgoj3A8dDm3KpBVs48TIyHQPK4RaOzcB9rhm1gb5fXi9sC
         1vxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUutWVUkllxo+PQ5x74IM/ulapN/AWXGPdByliT6AOQOFhjWvRjdnXEO60crejtPKIvBFNNjwLGvBOU2En1Tlg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7ygfl4IfEuQXWnNBTU2i6CH1jeuUx1hII9Pm3K8U2Ir5CEcrv
	znDORnb+4a/ZW8gLuhUVp5EjN/cCTvPvrptVJqzco7nvU9Lm6TRFxAQx
X-Gm-Gg: ASbGncvRBBaPttowS4Fe4HBOvx+B39RbBdeAY2Mr0Q2cBFr6gartJdRztt8ZMyRxkU8
	ktMU0WM5kgyUNSTQOjbmzcA2L0ZUaJ2SzOnqT7Tf0RgvU1UDqDzNhCgvh5CYV1B2+kjRKZABJcV
	uof2gXto1Zl6/NTTv5gMDDkIP2cSzRUG3obV35CG+HTLkl4nqT5vIHWeJzOAjCHSHRuDUsIrv1s
	2CgR+aJ8r3WFnqUiKbvOHzfki0SslL6J3CaMFwnRPAHl5LL6fxjV4n12LvqgeLZqstsXnbUeh5L
	v+Gi0obMKvSUkeD5WjAc6F/r3/RlnRyRqZLi5FbcasUm9zLPGu3roCVDNnGc+hOJhPXBhZEbA4K
	ZVcanGFQKOEtjj2untXtZY/E0wh/irVhj2d5771xRKeqWEgI0i5tZ6bAE+0iuEO7JmNk+7kgW
X-Google-Smtp-Source: AGHT+IHwNn3pqjoWotecuXY2Bk382T7KlekPldLWjd7xtyWnaXq++HkfhSeL9JeF/XIh23fgTqEc8A==
X-Received: by 2002:a05:6a00:22c4:b0:781:1b4c:75fb with SMTP id d2e1a72fcca58-78c98dd945emr5793503b3a.18.1759534654703;
        Fri, 03 Oct 2025 16:37:34 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:2a3b:74c8:31da:d808? ([2620:10d:c090:500::4:e149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01f9ac7esm6083494b3a.7.2025.10.03.16.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 16:37:34 -0700 (PDT)
Message-ID: <d108d59be611a63c73303347d07fe0ba5f2b74b7.camel@gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: fix implicit-function-declaration
 errors
From: Eduard Zingerman <eddyz87@gmail.com>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, ihor.solodrai@linux.dev, 
	alan.maguire@oracle.com
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, Andrii Nakryiko	
 <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann	
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu	
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend	
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev	 <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Shuah Khan <shuah@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers	 <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Date: Fri, 03 Oct 2025 16:37:32 -0700
In-Reply-To: <20251003-bpf-sft-fix-build-err-6-18-v1-1-2a71170861ef@kernel.org>
References: 
	<20251003-bpf-sft-fix-build-err-6-18-v1-1-2a71170861ef@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-03 at 17:24 +0200, Matthieu Baerts (NGI0) wrote:
> When trying to build the latest BPF selftests, with a debug kernel
> config, Pahole 1.30 and CLang 20.1.8 (and GCC 15.2), I got these errors:
>=20
>   progs/dynptr_success.c:579:9: error: call to undeclared function 'bpf_d=
ynptr_slice'; ISO C99 and later do not support implicit function declaratio=
ns [-Wimplicit-function-declaration]
>     579 |         data =3D bpf_dynptr_slice(&ptr, 0, NULL, 1);
>         |                ^
>   progs/dynptr_success.c:579:9: note: did you mean 'bpf_dynptr_size'?
>   .virtme/build-debug-btf//tools/include/vmlinux.h:120280:14: note: 'bpf_=
dynptr_size' declared here
>    120280 | extern __u32 bpf_dynptr_size(const struct bpf_dynptr *p) __we=
ak __ksym;
>           |              ^
>   progs/dynptr_success.c:579:7: error: incompatible integer to pointer co=
nversion assigning to '__u64 *' (aka 'unsigned long long *') from 'int' [-W=
int-conversion]
>     579 |         data =3D bpf_dynptr_slice(&ptr, 0, NULL, 1);
>         |              ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   progs/dynptr_success.c:596:9: error: call to undeclared function 'bpf_d=
ynptr_slice'; ISO C99 and later do not support implicit function declaratio=
ns [-Wimplicit-function-declaration]
>     596 |         data =3D bpf_dynptr_slice(&ptr, 0, NULL, 10);
>         |                ^
>   progs/dynptr_success.c:596:7: error: incompatible integer to pointer co=
nversion assigning to 'char *' from 'int' [-Wint-conversion]
>     596 |         data =3D bpf_dynptr_slice(&ptr, 0, NULL, 10);
>         |              ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> I don't have these errors without the debug kernel config from
> kernel/configs/debug.config. With the debug kernel, bpf_dynptr_slice()
> is not declared in vmlinux.h. It is declared there without debug.config.
>=20
> The fix is similar to what is done in dynptr_fail.c which is also using
> bpf_dynptr_slice(): bpf_kfuncs.h is now included.
>=20
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---

I can reproduce similar issue when including
kernel/configs/debug.config with my regular dev config, but for
different functions: bpf_rcu_read_{un,}lock().

However, this is not a way to fix this.
Kfuncs are not supposed to just disappear from DWARF.

Running pahole in verbose mode I see the following output:

  $ pahole -V \
      --btf_features=3Dencode_force,var,float,enum64,decl_tag,type_tag,opti=
mized_func,consistent_func,decl_tag_kfuncs \
      --btf_features=3Dattributes \
      --lang_exclude=3Drust \
      --btf_encode_detached=3D/dev/null vmlinux
  ...
  matched function 'bpf_rcu_read_lock' with 'bpf_rcu_read_lock.cold'
  ...

Alan, Ihor, does this sound familiar?

