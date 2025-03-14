Return-Path: <linux-kselftest+bounces-29112-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89861A62200
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 00:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C077E421727
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 23:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091CD1DF242;
	Fri, 14 Mar 2025 23:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4hN7Brp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4A6A32;
	Fri, 14 Mar 2025 23:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741995615; cv=none; b=EY/b6uuyXrMWSuUTRW1NLWmzQp+Qo+TtxXnTEYPVx9odfUB1g8etbSNJFZZzSWQxvuszvilk2lIo2A944ZLWKxkO9h72gMYn482U3rB68f7I7mdbdLEFhomz+P19ucmFzFIxrj82GgYFM6VGObKAH/xdxsHmYwiQc35NMseHw0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741995615; c=relaxed/simple;
	bh=y5AGtjFGSZOOof2oYdliemsaBNUX4dD7/hPkc4FxLE0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iPlvqilFE+73jt4pBD8dEikmGGW0BuzDgrB48bGvz2JqMu4TFmZ/bcmGQPlHjhhp05zbifa7U2U9XhqwyLCgBLdzNS5rV81j+DS6gyog2PjWjvsm+AAgze9ziHaAMJBbNzS19yIfAc4jeI7LAouat3CVHEoVNk03IWl8pRf0CBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4hN7Brp; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-224191d92e4so53603615ad.3;
        Fri, 14 Mar 2025 16:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741995614; x=1742600414; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nVsn+tfKHHydjyMGFQzYaSfWZr4r8NiOObk/ROots50=;
        b=e4hN7Brpiy8BQzGM8910lYV6mYTxgBVhXxFKV19wSW7eCrJ3BiR6PmYwN6uyAlo09/
         P8nQInWab2MkzqB9RMLEooezFKxQAR9dXFkjafHWcnhpP0l0Kf6oomcl2eMFW5H1Ajtb
         q3qw2jRD11lAgBCYX9yvKHVkfsdvVXr/mcSu3bt5BD7OznQ7i+kOPj8LURKFVxLf0kEh
         wvB/mRJR2u+iTgW3pIXCAgzvCE2m7zHGLSTKoFT/Xwgp3yqU8a58yVmfm7Ae6xb2w9a8
         AQVpAypdlI9Vu4F9MtdsN2dafavtoDTYiDgiyEdaQhO37vSxf+q6htPO2k+Jw2oI7Lxq
         jizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741995614; x=1742600414;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nVsn+tfKHHydjyMGFQzYaSfWZr4r8NiOObk/ROots50=;
        b=JeSF2iR8OaXYlTB0WMXyD8t7u5L6etW1HT7S2hA5LszpxyEw2Cyrbja0Q59EQHxTAt
         gZNfm4OBax7BazHBDOhnVG/xH+iAKATXWX6JA2qvhoBvs2XmhFy+A8wQWcNRdIjg9ccx
         b6WTwG4qHjoNFxAG8DIO/SbSv/l5gr7a7kXDggQXEOqCxFj1xtlY/+yzZbWGMJwwJTK6
         t/6nqPcDUXplgvGFfbHVrWj4B8+xdB0TuQqXcy2vQCMp4gDy8AtgqFlyvF/KUtaNberV
         Nu289hMlD9Vzasj69CERBaGT9uhrdROXfgjXe4V4+q+b7ShtaUDd/29BxFXk1tFaKXdr
         kMOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJPi6grJtgluUrvB0EBLjGmbycpJbAIPUbINJnDgQc9FZPdFZApxhcIPnPsiQT5zAvBhkF2WbaZjc9rBPOSupw@vger.kernel.org, AJvYcCUWHdyttzEY5PgSvKzQZ14xiF1LGJmUY0gEzAGnBP3Wt22Yh+rwvpf7FErw3cvIt9ynAV5JsRbngJ5MdguM@vger.kernel.org, AJvYcCXNhztxgHXdZjFvCy8UGO5CJgLX3iBWL6Apw8QhPQS+GG2rsti7ORrHHtQTt6wl+7KGthA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6c0qC/LjhUUlNxsM+aoT9bgI/ImbD/3Tir7OwXcCBYEMFIT3D
	MEZUVR/WII/aSFGvtQuGzB11c8fYFfmUMqgevRPnAW3yuB2JegFi
X-Gm-Gg: ASbGncsXm+ZJJsvTxXLRSPyP0DYhInmI221GkvgYFpohLP3IH9+GBdoJl+M/uw5Ncz3
	H65grvqnwRLatsv8eYcW+cdw8naDaXxat2L2fBotp6mAO6qEKRkmxoGigWz7qHHBj8r0vijMYUd
	ZQJbaJfZRuCd/YyIpmsz804AZhARnWtZR9C0J8Lq3ZIpG8uVTdnoEXEF9WPRZHXL67xv8ipDZQg
	sP9vT+tVEA93tpm6cnQcJ1CnRVBGK1cjYMF6TrkA5GPuKw1MqocmOWxzddWADoQEW+8SYuj8QOY
	0dhrFrl8YGR0e7XQI8B4qy8Q3VKM9rGvEhXw0Frm
X-Google-Smtp-Source: AGHT+IGjOrXc4ow/tKqJ4tqaPFLLb7WlMrAJtuGww00AJ+3W8ap1jSuRZuNSWgniLxNwNri94jxBaw==
X-Received: by 2002:a17:902:f70b:b0:224:d72:920d with SMTP id d9443c01a7336-225e0afa009mr57678505ad.37.1741995613632;
        Fri, 14 Mar 2025 16:40:13 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd5c03sm33890155ad.249.2025.03.14.16.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 16:40:13 -0700 (PDT)
Message-ID: <f6f08d64c777a6022771ab0adf96cefb6b631d75.camel@gmail.com>
Subject: Re: [PATCH bpf-next 00/11] bpf: Mitigate Spectre v1 using barriers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Luis Gerhorst <luis.gerhorst@fau.de>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend	
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev	 <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai
 <xukuohai@huaweicloud.com>, Catalin Marinas	 <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Hari Bathini	 <hbathini@linux.ibm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,  Naveen N Rao
 <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman	 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Mykola
 Lysenko	 <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, Henriette Herzog	
 <henriette.herzog@rub.de>, Cupertino Miranda
 <cupertino.miranda@oracle.com>,  Matan Shachnai <m.shachnai@gmail.com>,
 Dimitar Kanaliev <dimitar.kanaliev@siteground.com>, Shung-Hsi Yu	
 <shung-hsi.yu@suse.com>, Daniel Xu <dxu@dxuuu.xyz>, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org, George Guo	
 <guodongtai@kylinos.cn>, WANG Xuerui <git@xen0n.name>, Tiezhu Yang	
 <yangtiezhu@loongson.cn>
Date: Fri, 14 Mar 2025 16:40:08 -0700
In-Reply-To: <20250313172127.1098195-1-luis.gerhorst@fau.de>
References: <20250313172127.1098195-1-luis.gerhorst@fau.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-03-13 at 18:21 +0100, Luis Gerhorst wrote:
> This improves the expressiveness of unprivileged BPF by inserting
> speculation barriers instead of rejecting the programs.
>=20
> The approach was previously presented at LPC'24 [1] and RAID'24 [2].
>=20
> To mitigate the Spectre v1 (PHT) vulnerability, the kernel rejects
> potentially-dangerous unprivileged BPF programs as of
> commit=C2=A09183671af6db ("bpf: Fix leakage under speculation on mispredi=
cted
> branches"). In [2], we have analyzed 364 object files from open source
> projects (Linux Samples and Selftests, BCC, Loxilb, Cilium, libbpf
> Examples, Parca, and Prevail) and found that this affects 31% to 54% of
> programs.
>=20
> To resolve this in the majority of cases this patchset adds a fall-back
> for mitigating Spectre v1 using speculation barriers. The kernel still
> optimistically attempts to verify all speculative paths but uses
> speculation barriers against v1 when unsafe behavior is detected. This
> allows for more programs to be accepted without disabling the BPF
> Spectre mitigations (e.g., by setting cpu_mitigations_off()).
>=20
> In [1] we have measured the overhead of this approach relative to having
> mitigations off and including the upstream Spectre v4 mitigations. For
> event tracing and stack-sampling profilers, we found that mitigations
> increase BPF program execution time by 0% to 62%. For the Loxilb network
> load balancer, we have measured a 14% slowdown in SCTP performance but
> no significant slowdown for TCP. This overhead only applies to programs
> that were previously rejected.
>=20
> I reran the expressiveness-evaluation with v6.14 and made sure the main
> results still match those from [1] and [2] (which used v6.5).
>=20
> Main design decisions are:
>=20
> * Do not use separate bytecode insns for v1 and v4 barriers. This
>   simplifies the verifier significantly and has the only downside that
>   performance on PowerPC is not as high as it could be.
>=20
> * Allow archs to still disable v1/v4 mitigations separately by setting
>   bpf_jit_bypass_spec_v1/v4(). This has the benefit that archs can
>   benefit from improved BPF expressiveness / performance if they are not
>   vulnerable (e.g., ARM64 for v4 in the kernel).
>=20
> * Do not remove the empty BPF_NOSPEC implementation for backends for
>   which it is unknown whether they are vulnerable to Spectre v1.

[...]

I think it would be good to have some tests checking that nospec
instructions are inserted in expected locations.
Could you please take look at use of __xlated tag in e.g.
tools/testing/selftests/bpf/progs/verifier_sdiv.c ?

[...]


