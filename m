Return-Path: <linux-kselftest+bounces-1002-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E47BE8018DA
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Dec 2023 01:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDF12B20D53
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Dec 2023 00:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C77C64A;
	Sat,  2 Dec 2023 00:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jn43UGKF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B6CCF;
	Fri,  1 Dec 2023 16:20:19 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c9b5c12898so34226401fa.2;
        Fri, 01 Dec 2023 16:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701476417; x=1702081217; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V7H5mtM4rdlF96TurskSVKsv77wngFKN9XzMokfXX3o=;
        b=Jn43UGKFRFJ0+BEoGYvujtwfUqqKtIr6LDAE+RABaR+aVGqcnIx9X9jdWX7QQ8vIhF
         E+loP/zR25iuxh77C4btFqjufM4WD3BO2iyr9QdKMy3yGDdswhGhTm5BhnKpzH++fMND
         zGK4JuVbf316yQGLyUbTcV9WKT/UktTEHsfqJbJUTSbSRn9q/6/p8gjzreGNi/SmfCr3
         pnE4OHHQKOcPdAIY3UXT0u+zXq3fVybVi4WWzvlKWrVN1lRZ1poPiJ5Lc1qAlyBMy1hf
         19xNACl2sU2y+boBKntWDxToJ9O9xgm4rJmEJRv0/UPG0I5o8AHMU2uoTIaX3dJFq48F
         +qdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701476417; x=1702081217;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V7H5mtM4rdlF96TurskSVKsv77wngFKN9XzMokfXX3o=;
        b=gIOVEQWQwbhgyaaxtu5zJHX9YrxLDozKa65p7yZFZ3XnQDZ+2UTERbXnoS+q31ndcw
         P22HAiS1z0JdsQ8D4grM9jZizJEaNRxooKqL7IgBXFMx1sr0dA4/6Q2Tozfhq+lwyvuM
         MCeABfqJiw3+o83O8Bpd4c3bEV8ToxHoq/Qd1S5qVgdIo1GTzO/4GvOzSPLB/58WkiYr
         7IvClF9NCAwyr1DyBAOuVG2RtOsb1Tc827OScTX5uFC8519CddvS0SUz0lUrUfD2hbLD
         ldOnyohNNbT9K72H0U+K+MuHZDRY/8+PpJTjPzGRnHyFT/1ApaN1CsY0akVNxbeWYX/U
         TUcQ==
X-Gm-Message-State: AOJu0YyIQYXyB5sJRa0qtUuuTaLChD+qCrslkclMvnKDilrM+kMxyquo
	4lJR/sdi+eq0zwrodjLs/sM=
X-Google-Smtp-Source: AGHT+IHIx/W2tOPuzPFRMcUv6dY0UL4yjmePC/SUMhNp+oiMbw0mgLKn5Mr6poXdbiv24WSxMFodQA==
X-Received: by 2002:a2e:8895:0:b0:2c9:d874:6efc with SMTP id k21-20020a2e8895000000b002c9d8746efcmr1441290lji.89.1701476417363;
        Fri, 01 Dec 2023 16:20:17 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id l13-20020a170906a40d00b00a18a9931dc1sm2365617ejz.105.2023.12.01.16.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 16:20:16 -0800 (PST)
Message-ID: <d2fe8b0593a1009305e90d98a8bff984c1314748.camel@gmail.com>
Subject: Re: [PATCH ipsec-next v3 5/9] libbpf: selftests: Add verifier tests
 for CO-RE bitfield writes
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Xu <dxu@dxuuu.xyz>, Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
 andrii@kernel.org,  steffen.klassert@secunet.com,
 antony.antony@secunet.com,  alexei.starovoitov@gmail.com,
 yonghong.song@linux.dev, mykolal@fb.com,  martin.lau@linux.dev,
 song@kernel.org, john.fastabend@gmail.com,  kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, devel@linux-ipsec.org,
 netdev@vger.kernel.org
Date: Sat, 02 Dec 2023 02:20:15 +0200
In-Reply-To: <ka2irjz53qjkax545o67mvouyytzqw3dvorqixe2q72crgzjpi@he2uiobuelvd>
References: <cover.1701462010.git.dxu@dxuuu.xyz>
	 <e4d14fb5f07145ff4a367cc01d8dcf6c82581c88.1701462010.git.dxu@dxuuu.xyz>
	 <CAEf4Bzaz+_y=kxBpPmwYsvzaHypmL=ZBfOK12vLom04DRDWyPg@mail.gmail.com>
	 <ka2irjz53qjkax545o67mvouyytzqw3dvorqixe2q72crgzjpi@he2uiobuelvd>
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

On Fri, 2023-12-01 at 17:10 -0700, Daniel Xu wrote:
[...]
> > > +SEC("tc")
> > > +__description("single CO-RE bitfield roundtrip")
> > > +__btf_path("btf__core_reloc_bitfields.bpf.o")
> > > +__success __failure_unpriv
> >=20
> > do we want __failure_unpriv at all? Is this failure related to
> > *bitfield* logic at all?
>=20
> Oh, I pre-emptively added it. From the docs, I thought __failure_unpriv
> meant "don't try to load this as an unprivileged used cuz it'll fail".
> And since I used the tc hook, I figured it'd fail.

Actually it means:
"try to load as unprivileged user and expect failure,
 report error on successful load".

In general, the meaning of "___xxx" and "___xxx_unpriv" annotations
is identical, except first instructs to run the test in privileged mode,
while second instructs to run test in unprivileged mode:
- if only annotations w/o "*_unpriv" suffix are present the test would
  be executed as privileged;
- if only annotations with "*_unpriv" suffix are present the test would
  be executed as unprivileged;
- if both kinds of annotations are present the test would be executed
  in both modes.

[...]

