Return-Path: <linux-kselftest+bounces-617-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 325F47F9534
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Nov 2023 21:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAF0D280E08
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Nov 2023 20:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A15312E69;
	Sun, 26 Nov 2023 20:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6fZkzUN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EB3E4;
	Sun, 26 Nov 2023 12:14:25 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40b4746ae51so117485e9.2;
        Sun, 26 Nov 2023 12:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701029664; x=1701634464; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Yp72lr6ldBtEgxHJc2cyITFerBaMZB0y6t1H7uYo/wE=;
        b=N6fZkzUNCHBgaL2WqAH/H8+bY2Z3t7DuPx7ayZ0Ju5p0K/2CpRhTsl4UPcB2qR7ULN
         iWTsJpyFluJRDuf7I4GwYEfcPzATDuYY/qt1p7FORbNayY17deOAAij2GSPetxjk5Uay
         uZhfdwUtHzV3WDHR+t3OLPqKqSmTNV2DBtKSGWFRQnZbZZQN4n1UD+BM2QfWacHLLbZ9
         l02azx2una8LJdA5jVtqMjCPQy+WkDYZZ6ePA9M1ikF0MLyjfKJK5zCcpu+CBxGyanCo
         ETWw9xIjeqbzDV677vRXYfBlJRysXJgPSAW8i2uSO2NK/bWQIaf8eqfxhNAgKa2JCKjX
         SDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701029664; x=1701634464;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yp72lr6ldBtEgxHJc2cyITFerBaMZB0y6t1H7uYo/wE=;
        b=UV/kgFJ+6eDWLiQpNm5LQ2ruzmKwK9qy+jJTN/LlFXW4bcLNk28sVGRn4mxJUY50an
         EvR4ehGI6nVfcgARskgs3mNSgn+U4Z/GVuEBQRFtO9m/BIGuI5kO7Pz5P5oPQ1s1Wgjf
         K/qaMRkDGVkjoFJBAmauMbP0q/XKpHlUaixqu6po9vAI4O+vPA1iLRJVe4pF34uKNhhY
         EZS8B8hWgWSBSXstzmfUkiLbwF2B5pMTpTN1c3KbcbugnIrsnc4j6tfgOahHJ/uEQXp2
         J2dt6C4K+zSTlMwn6tWob94Xy48nKnAH+eV+Fd/yx56zdgQm7TBRm8Lzswel3Q/Lbf0z
         l4mA==
X-Gm-Message-State: AOJu0YzGhMVEoBGfN4DWv2pcn7nwp5uEL43noN7obREPhlL8asPji5vs
	SON1Faeh4m89YN55qFA6+jA=
X-Google-Smtp-Source: AGHT+IEXnfDuJsDjgnbQlSmje39O1/E0Rx1OURxqJsPw3DCqHQh4XLMDSWdKw0b6oNENL8GA2lMg9w==
X-Received: by 2002:a05:600c:21c7:b0:40a:4c7e:6f37 with SMTP id x7-20020a05600c21c700b0040a4c7e6f37mr6639703wmj.20.1701029663842;
        Sun, 26 Nov 2023 12:14:23 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id jg28-20020a05600ca01c00b004063cd8105csm12025666wmb.22.2023.11.26.12.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 12:14:22 -0800 (PST)
Message-ID: <18e43cdf65e7ba0d8f6912364fbc5b08a6928b35.camel@gmail.com>
Subject: Re: [PATCH ipsec-next v1 6/7] bpf: selftests: test_tunnel: Disable
 CO-RE relocations
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>, Shuah Khan <shuah@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Steffen Klassert
 <steffen.klassert@secunet.com>,  antony.antony@secunet.com, Mykola Lysenko
 <mykolal@fb.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, bpf
 <bpf@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK"
 <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
 devel@linux-ipsec.org, Network Development <netdev@vger.kernel.org>
Date: Sun, 26 Nov 2023 22:14:21 +0200
In-Reply-To: <3ec6c068-7f95-419a-a0ae-a901f95e4838@linux.dev>
References: <cover.1700676682.git.dxu@dxuuu.xyz>
	 <391d524c496acc97a8801d8bea80976f58485810.1700676682.git.dxu@dxuuu.xyz>
	 <0f210cef-c6e9-41c1-9ba8-225f046435e5@linux.dev>
	 <CAADnVQ+sEsUyNYPeZyOf2PcCnxOvOqw4bUuAuMofCU14szTGvg@mail.gmail.com>
	 <3ec6c068-7f95-419a-a0ae-a901f95e4838@linux.dev>
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

On Sat, 2023-11-25 at 20:22 -0800, Yonghong Song wrote:
[...]
> --- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> +++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> @@ -6,7 +6,10 @@
>    * modify it under the terms of version 2 of the GNU General Public
>    * License as published by the Free Software Foundation.
>    */
> -#define BPF_NO_PRESERVE_ACCESS_INDEX
> +#if __has_attribute(preserve_static_offset)
> +struct __attribute__((preserve_static_offset)) erspan_md2;
> +struct __attribute__((preserve_static_offset)) erspan_metadata;
> +#endif
>   #include "vmlinux.h"
[...]
>   int bpf_skb_get_fou_encap(struct __sk_buff *skb_ctx,
> @@ -174,9 +177,13 @@ int erspan_set_tunnel(struct __sk_buff *skb)
>          __u8 hwid =3D 7;
>  =20
>          md.version =3D 2;
> +#if __has_attribute(preserve_static_offset)
>          md.u.md2.dir =3D direction;
>          md.u.md2.hwid =3D hwid & 0xf;
>          md.u.md2.hwid_upper =3D (hwid >> 4) & 0x3;
> +#else
> +       /* Change bit-field store to byte(s)-level stores. */
> +#endif
>   #endif
>  =20
>          ret =3D bpf_skb_set_tunnel_opt(skb, &md, sizeof(md));
>=20
> =3D=3D=3D=3D
>=20
> Eduard, could you double check whether this is a valid use case
> to solve this kind of issue with preserve_static_offset attribute?

Tbh I'm not sure. This test passes with preserve_static_offset
because it suppresses preserve_access_index. In general clang
translates bitfield access to a set of IR statements like:

  C:
    struct foo {
      unsigned _;
      unsigned a:1;
      ...
    };
    ... foo->a ...

  IR:
    %a =3D getelementptr inbounds %struct.foo, ptr %0, i32 0, i32 1
    %bf.load =3D load i8, ptr %a, align 4
    %bf.clear =3D and i8 %bf.load, 1
    %bf.cast =3D zext i8 %bf.clear to i32

With preserve_static_offset the getelementptr+load are replaced by a
single statement which is preserved as-is till code generation,
thus load with align 4 is preserved.

On the other hand, I'm not sure that clang guarantees that load or
stores used for bitfield access would be always aligned according to
verifier expectations.

I think we should check if there are some clang knobs that prevent
generation of unaligned memory access. I'll take a look.

