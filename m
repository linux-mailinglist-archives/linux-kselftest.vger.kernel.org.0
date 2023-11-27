Return-Path: <linux-kselftest+bounces-619-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1061B7F974D
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 02:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41DF81C20371
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 01:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A021ED2;
	Mon, 27 Nov 2023 01:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1bXFA6W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA83CB;
	Sun, 26 Nov 2023 17:53:01 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3316a4bc37dso2385638f8f.2;
        Sun, 26 Nov 2023 17:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701049979; x=1701654779; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pDa4h87tLl9seJwBOHZP7XV4Q6UZXGRUr4YEgiSl+xQ=;
        b=f1bXFA6W7vf3x7O6rQPra0ervbbnuXaktdujXFci5mINJ6kKrdq4i7f0d7BweYqVWP
         u71rrUw2kUrgZug9JHR6DEXr8QwCdyr4aar4qVlRRH+0bMOpm5bYJaL6zuGXm5EmpCFB
         TXkwpQoDTNqZky7b05OBgy4QyQGeCiiQ/feQk6sos0cMOgeSj17H2tXFIWUJk9bW394y
         S0rKp2yCtwEF2HxikAtXY+Cp3IpwDIPUwffrvZc+mosLP3IOx0w30uxk1TBQqUAdMO+1
         aX6HZ/3GaDM3vzjCV7agGZ4uyMtoIS6v41zpwWAsBn4u2BV9GZwWpYnTnlBQYP0pxu3s
         tHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701049979; x=1701654779;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pDa4h87tLl9seJwBOHZP7XV4Q6UZXGRUr4YEgiSl+xQ=;
        b=n+Woeoxhsu5HsntmQeJKply06PS74SzZNMYWKr5YNqasOddY8/9o+d3Sle+e+bWkQK
         vC2e8nsKvjNPiY1Es9hKxA87NjVZCdVH1aFlAw55MSgSFauNmBaX06zPtbhO13aXnttq
         0bUQNClm6iKu3mXD8iKHMSC/qLalfBEdIZILQdOCaMVmKD/pCqB/g6XlOVWe7cXul5Af
         wIqOqpBKMPf1YrNoJok15CGtejoR6OTaLfYAaS7fJzr4OeDJ8KB21ELCrD+1TY/UMMV/
         EHLo6s/0uWQ3JckSY/CZdF3dP/mjw/00LPV+ulq4wDhdDevNnAsj6W04dn7t/C5lRfw9
         fDOg==
X-Gm-Message-State: AOJu0Yzusb6j1i5zp97sqvjB9F3deQzh2A+2/Yzwvd2F8E1uM313lMmV
	m4ZEOsR+IsHDbLV5LlDznZ8=
X-Google-Smtp-Source: AGHT+IFOMrHE/OFhR5o8+ckGwEKULp9iDRst9RDrnPEG3X1J/+3QoGf5xsumWfxTUvBmkngDc+8vzA==
X-Received: by 2002:a05:6000:239:b0:332:e62e:f0ba with SMTP id l25-20020a056000023900b00332e62ef0bamr5949115wrz.18.1701049979323;
        Sun, 26 Nov 2023 17:52:59 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id w3-20020a5d5443000000b003140f47224csm10496423wrv.15.2023.11.26.17.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 17:52:58 -0800 (PST)
Message-ID: <0535eb913f1a0c2d3c291478fde07e0aa2b333f1.camel@gmail.com>
Subject: Re: [PATCH ipsec-next v1 6/7] bpf: selftests: test_tunnel: Disable
 CO-RE relocations
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Shuah Khan <shuah@kernel.org>, Daniel
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
Date: Mon, 27 Nov 2023 03:52:56 +0200
In-Reply-To: <uc5fv3keghefszuvono7aclgtjtgjnnia3i54ynejmyrs42ser@bwdpq5gmuvub>
References: <cover.1700676682.git.dxu@dxuuu.xyz>
	 <391d524c496acc97a8801d8bea80976f58485810.1700676682.git.dxu@dxuuu.xyz>
	 <0f210cef-c6e9-41c1-9ba8-225f046435e5@linux.dev>
	 <CAADnVQ+sEsUyNYPeZyOf2PcCnxOvOqw4bUuAuMofCU14szTGvg@mail.gmail.com>
	 <3ec6c068-7f95-419a-a0ae-a901f95e4838@linux.dev>
	 <18e43cdf65e7ba0d8f6912364fbc5b08a6928b35.camel@gmail.com>
	 <uc5fv3keghefszuvono7aclgtjtgjnnia3i54ynejmyrs42ser@bwdpq5gmuvub>
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

On Sun, 2023-11-26 at 18:04 -0600, Daniel Xu wrote:
[...]
> > Tbh I'm not sure. This test passes with preserve_static_offset
> > because it suppresses preserve_access_index. In general clang
> > translates bitfield access to a set of IR statements like:
> >=20
> >   C:
> >     struct foo {
> >       unsigned _;
> >       unsigned a:1;
> >       ...
> >     };
> >     ... foo->a ...
> >=20
> >   IR:
> >     %a =3D getelementptr inbounds %struct.foo, ptr %0, i32 0, i32 1
> >     %bf.load =3D load i8, ptr %a, align 4
> >     %bf.clear =3D and i8 %bf.load, 1
> >     %bf.cast =3D zext i8 %bf.clear to i32
> >=20
> > With preserve_static_offset the getelementptr+load are replaced by a
> > single statement which is preserved as-is till code generation,
> > thus load with align 4 is preserved.
> >=20
> > On the other hand, I'm not sure that clang guarantees that load or
> > stores used for bitfield access would be always aligned according to
> > verifier expectations.
> >=20
> > I think we should check if there are some clang knobs that prevent
> > generation of unaligned memory access. I'll take a look.
>=20
> Is there a reason to prefer fixing in compiler? I'm not opposed to it,
> but the downside to compiler fix is it takes years to propagate and
> sprinkles ifdefs into the code.
>
> Would it be possible to have an analogue of BPF_CORE_READ_BITFIELD()?

Well, the contraption below passes verification, tunnel selftest
appears to work. I might have messed up some shifts in the macro, though.

Still, if clang would peek unlucky BYTE_{OFFSET,SIZE} for a particular
field access might be unaligned.

---

diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/t=
esting/selftests/bpf/progs/test_tunnel_kern.c
index 3065a716544d..41cd913ac7ff 100644
--- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
@@ -9,6 +9,7 @@
 #include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
+#include <bpf/bpf_core_read.h>
 #include "bpf_kfuncs.h"
 #include "bpf_tracing_net.h"
=20
@@ -144,6 +145,38 @@ int ip6gretap_get_tunnel(struct __sk_buff *skb)
 	return TC_ACT_OK;
 }
=20
+#define BPF_CORE_WRITE_BITFIELD(s, field, new_val) ({			\
+	void *p =3D (void *)s + __CORE_RELO(s, field, BYTE_OFFSET);	\
+	unsigned byte_size =3D __CORE_RELO(s, field, BYTE_SIZE);		\
+	unsigned lshift =3D __CORE_RELO(s, field, LSHIFT_U64);		\
+	unsigned rshift =3D __CORE_RELO(s, field, RSHIFT_U64);		\
+	unsigned bit_size =3D (rshift - lshift);				\
+	unsigned long long nval, val, hi, lo;				\
+									\
+	asm volatile("" : "=3Dr"(p) : "0"(p));				\
+									\
+	switch (byte_size) {						\
+	case 1: val =3D *(unsigned char *)p; break;			\
+	case 2: val =3D *(unsigned short *)p; break;			\
+	case 4: val =3D *(unsigned int *)p; break;			\
+	case 8: val =3D *(unsigned long long *)p; break;			\
+	}								\
+	hi =3D val >> (bit_size + rshift);				\
+	hi <<=3D bit_size + rshift;					\
+	lo =3D val << (bit_size + lshift);				\
+	lo >>=3D bit_size + lshift;					\
+	nval =3D new_val;							\
+	nval <<=3D lshift;						\
+	nval >>=3D rshift;						\
+	val =3D hi | nval | lo;						\
+	switch (byte_size) {						\
+	case 1: *(unsigned char *)p      =3D val; break;			\
+	case 2: *(unsigned short *)p     =3D val; break;			\
+	case 4: *(unsigned int *)p       =3D val; break;			\
+	case 8: *(unsigned long long *)p =3D val; break;			\
+	}								\
+})
+
 SEC("tc")
 int erspan_set_tunnel(struct __sk_buff *skb)
 {
@@ -173,9 +206,9 @@ int erspan_set_tunnel(struct __sk_buff *skb)
 	__u8 hwid =3D 7;
=20
 	md.version =3D 2;
-	md.u.md2.dir =3D direction;
-	md.u.md2.hwid =3D hwid & 0xf;
-	md.u.md2.hwid_upper =3D (hwid >> 4) & 0x3;
+	BPF_CORE_WRITE_BITFIELD(&md.u.md2, dir, direction);
+	BPF_CORE_WRITE_BITFIELD(&md.u.md2, hwid, (hwid & 0xf));
+	BPF_CORE_WRITE_BITFIELD(&md.u.md2, hwid_upper, (hwid >> 4) & 0x3);
 #endif
=20
 	ret =3D bpf_skb_set_tunnel_opt(skb, &md, sizeof(md));
@@ -214,8 +247,9 @@ int erspan_get_tunnel(struct __sk_buff *skb)
 	bpf_printk("\tindex %x\n", index);
 #else
 	bpf_printk("\tdirection %d hwid %x timestamp %u\n",
-		   md.u.md2.dir,
-		   (md.u.md2.hwid_upper << 4) + md.u.md2.hwid,
+		   BPF_CORE_READ_BITFIELD(&md.u.md2, dir),
+		   (BPF_CORE_READ_BITFIELD(&md.u.md2, hwid_upper) << 4) +
+		   BPF_CORE_READ_BITFIELD(&md.u.md2, hwid),
 		   bpf_ntohl(md.u.md2.timestamp));
 #endif
=20
@@ -252,9 +286,9 @@ int ip4ip6erspan_set_tunnel(struct __sk_buff *skb)
 	__u8 hwid =3D 17;
=20
 	md.version =3D 2;
-	md.u.md2.dir =3D direction;
-	md.u.md2.hwid =3D hwid & 0xf;
-	md.u.md2.hwid_upper =3D (hwid >> 4) & 0x3;
+	BPF_CORE_WRITE_BITFIELD(&md.u.md2, dir, direction);
+	BPF_CORE_WRITE_BITFIELD(&md.u.md2, hwid, (hwid & 0xf));
+	BPF_CORE_WRITE_BITFIELD(&md.u.md2, hwid_upper, (hwid >> 4) & 0x3);
 #endif
=20
 	ret =3D bpf_skb_set_tunnel_opt(skb, &md, sizeof(md));
@@ -294,8 +328,9 @@ int ip4ip6erspan_get_tunnel(struct __sk_buff *skb)
 	bpf_printk("\tindex %x\n", index);
 #else
 	bpf_printk("\tdirection %d hwid %x timestamp %u\n",
-		   md.u.md2.dir,
-		   (md.u.md2.hwid_upper << 4) + md.u.md2.hwid,
+		   BPF_CORE_READ_BITFIELD(&md.u.md2, dir),
+		   (BPF_CORE_READ_BITFIELD(&md.u.md2, hwid_upper) << 4) +
+		   BPF_CORE_READ_BITFIELD(&md.u.md2, hwid),
 		   bpf_ntohl(md.u.md2.timestamp));
 #endif
=20

