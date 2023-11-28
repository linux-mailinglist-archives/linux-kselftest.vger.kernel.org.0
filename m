Return-Path: <linux-kselftest+bounces-727-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 525697FBF16
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 17:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 119382827B0
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 16:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC8F37D36;
	Tue, 28 Nov 2023 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uu4ot+Y+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D4B182;
	Tue, 28 Nov 2023 08:19:18 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-5079f6efd64so7633953e87.2;
        Tue, 28 Nov 2023 08:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701188356; x=1701793156; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AeC86zbCGJVSk79IhGKH9GShZbi811qqEA24Z7ghM0M=;
        b=Uu4ot+Y+/yr6anfulEW9FJBZ/sZefqjz76MNgQ7GsoYMn6wK3Lzb7+gP4b/4RopvHv
         +bTQLNod+CC2soIujByj+Q54uSjmZXqU59jubqO8XxeDkq3/iKXDTsjUDrHRepgmfafp
         m6czn/C0LdooY3a93n0yMIB+HEzddn3bPn5jZcM46EnyGg4F1MRI9wddH46Z+F2CpaZ1
         O0gLL9O9LQOQq6vMDSeTNHuojKk+F0Pd9VZn9CFXudT0fTa+MZh+vsbXZU4V06kIQuIx
         GZMvoBrNolhhsLzzGbCQhyfn36BViO5bRtD19ydnD8H1aNLaJDSl2taJ9gngN3zcVx7r
         p6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701188356; x=1701793156;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AeC86zbCGJVSk79IhGKH9GShZbi811qqEA24Z7ghM0M=;
        b=kRLnyB2vxbeW/RHNzNmruPnnD4oFXgHBigfM6egHn3+Io07nn0SixvEhHZ53E3LsdJ
         LRXgKJEKpLdY8ZYvzQA+OMA2vjLBEVi5MhFQlQ0DiQsqrocNb2NJ7pFe1L9n/WuIpK6b
         9DApDp125KMbyrrJsl5tzhcFmWBWEA3aJBvbSSTIlWoo/28Qv/yYT6uc75S7ikP0vsVI
         YBFkQ/cu8v5jDFEJRSsUoyLh5AFQ55/pZTMNIyCBccVBOBHc8gfy2Pd46Br2G54xoVSe
         R+EF/7MnNzhAML+L91qCaVCLF9dN3G/7CYTce9kZn3AXu5qqOU7a9Nv/c64AM5o6PrX5
         Lrkw==
X-Gm-Message-State: AOJu0Yz2aDtlqozyIoQpfhkaicNPF0/bXqeyaKn2hGrXq6EIE17fD1bQ
	Nv+euAhf/Rq/w9flCqhpYsU=
X-Google-Smtp-Source: AGHT+IGMma2vgs85Y0T7461/0MipHE1/19RTn/0fiyXlqiyumPPE/1qzpnDwgkRnEwkYX001zMdDPQ==
X-Received: by 2002:a05:6512:2245:b0:50a:40b6:2d37 with SMTP id i5-20020a056512224500b0050a40b62d37mr13159186lfu.40.1701188356322;
        Tue, 28 Nov 2023 08:19:16 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id i14-20020a05640200ce00b0054866f0c1b8sm6386704edu.69.2023.11.28.08.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 08:19:15 -0800 (PST)
Message-ID: <b9f63218d934b8048ccdafa8e2c27f9929e344a6.camel@gmail.com>
Subject: Re: [PATCH ipsec-next v1 6/7] bpf: selftests: test_tunnel: Disable
 CO-RE relocations
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Xu <dxu@dxuuu.xyz>, Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Shuah Khan
 <shuah@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Steffen Klassert
 <steffen.klassert@secunet.com>, antony.antony@secunet.com, Mykola Lysenko
 <mykolal@fb.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, bpf
 <bpf@vger.kernel.org>,  "open list:KERNEL SELFTEST FRAMEWORK"
 <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
 devel@linux-ipsec.org, Network Development <netdev@vger.kernel.org>
Date: Tue, 28 Nov 2023 18:19:08 +0200
In-Reply-To: <p6qdiwnuglz7ry6hsssruf3w6n3tnavglya3iampors7eb4ac6@nonyetjx2zvc>
References: 
	<CAADnVQ+sEsUyNYPeZyOf2PcCnxOvOqw4bUuAuMofCU14szTGvg@mail.gmail.com>
	 <3ec6c068-7f95-419a-a0ae-a901f95e4838@linux.dev>
	 <18e43cdf65e7ba0d8f6912364fbc5b08a6928b35.camel@gmail.com>
	 <uc5fv3keghefszuvono7aclgtjtgjnnia3i54ynejmyrs42ser@bwdpq5gmuvub>
	 <0535eb913f1a0c2d3c291478fde07e0aa2b333f1.camel@gmail.com>
	 <42f9bf0d-695a-412d-bea5-cb7036fa7418@linux.dev>
	 <a5a84482-13ef-47d8-bf07-8017060a5d64@linux.dev>
	 <xehp2qvy5cyaairbnfhem4hvbsl26blo4zzu7z6ywbp26jcwyn@hgp3v2q4ud7o>
	 <53jaqi72ef4gynyafxidl5veb54kfs7dttxezkarwg75t7szd4@cvfg5pc7pyum>
	 <f68c01d6-bf6b-4b76-8b20-53e9f4a61fcd@linux.dev>
	 <p6qdiwnuglz7ry6hsssruf3w6n3tnavglya3iampors7eb4ac6@nonyetjx2zvc>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-11-28 at 10:13 -0600, Daniel Xu wrote:
[...]
> > One thing for sure is memory layout of bitfields should be the same
> > for both clang and gcc as it is determined by C standard. Register
> > representation and how to manipulate could be different for different
> > compilers.
>=20
> I was reading this thread:
> https://github.com/Lora-net/LoRaMac-node/issues/697. It's obviously not
> authoritative, but they sure sound confident!
>=20
> I think I've also heard it before a long time ago when I was working on
> adding bitfield support to bpftrace.
>=20
>=20
> [...]

Here is a citation from ISO/IEC 9899:201x (C11 standard) =C2=A76.7.2.1
(Structure and union specifiers), paragraph 11 (page 114 in my pdf):

> An implementation may allocate any addressable storage unit large
> enough to hold a bit- field. If enough space remains, a bit-field
> that immediately follows another bit-field in a structure shall be
> packed into adjacent bits of the same unit. If insufficient space
> remains, whether a bit-field that does not fit is put into the next
> unit or overlaps adjacent units is implementation-defined. The order
> of allocation of bit-fields within a unit (high-order to low-order
> or low-order to high-order) is implementation-defined. The alignment
> of the addressable storage unit is unspecified.

