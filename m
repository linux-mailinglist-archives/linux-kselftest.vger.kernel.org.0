Return-Path: <linux-kselftest+bounces-622-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F06847F98DA
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 06:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E6D5280E5F
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 05:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B52753A0;
	Mon, 27 Nov 2023 05:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pVEFZ9Qq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ba])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856A5124;
	Sun, 26 Nov 2023 21:45:02 -0800 (PST)
Message-ID: <42f9bf0d-695a-412d-bea5-cb7036fa7418@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701063899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jfng7m5CVVUjMjDZCHK2DOYs3dS/poCbHNGMSgQaFl8=;
	b=pVEFZ9QqEWYcXasAIBDiDF5YwRLy6ERVkY4BiC9RFXTTbMs3XRft0JzgWZasUBK7ec+6Pm
	Ypdq3RByDDY0EQDJN1OE5N5+v5KQkQjvrVDERSMkKpsyDHYwxabApB7aiNLv8Dk42WWlVn
	UXreyPsOVnzk7PeSIN7MVXfCCyI0R7E=
Date: Sun, 26 Nov 2023 21:44:48 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH ipsec-next v1 6/7] bpf: selftests: test_tunnel: Disable
 CO-RE relocations
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, Daniel Xu <dxu@dxuuu.xyz>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Steffen Klassert <steffen.klassert@secunet.com>, antony.antony@secunet.com,
 Mykola Lysenko <mykolal@fb.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 bpf <bpf@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, devel@linux-ipsec.org,
 Network Development <netdev@vger.kernel.org>
References: <cover.1700676682.git.dxu@dxuuu.xyz>
 <391d524c496acc97a8801d8bea80976f58485810.1700676682.git.dxu@dxuuu.xyz>
 <0f210cef-c6e9-41c1-9ba8-225f046435e5@linux.dev>
 <CAADnVQ+sEsUyNYPeZyOf2PcCnxOvOqw4bUuAuMofCU14szTGvg@mail.gmail.com>
 <3ec6c068-7f95-419a-a0ae-a901f95e4838@linux.dev>
 <18e43cdf65e7ba0d8f6912364fbc5b08a6928b35.camel@gmail.com>
 <uc5fv3keghefszuvono7aclgtjtgjnnia3i54ynejmyrs42ser@bwdpq5gmuvub>
 <0535eb913f1a0c2d3c291478fde07e0aa2b333f1.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <0535eb913f1a0c2d3c291478fde07e0aa2b333f1.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 11/26/23 8:52 PM, Eduard Zingerman wrote:
> On Sun, 2023-11-26 at 18:04 -0600, Daniel Xu wrote:
> [...]
>>> Tbh I'm not sure. This test passes with preserve_static_offset
>>> because it suppresses preserve_access_index. In general clang
>>> translates bitfield access to a set of IR statements like:
>>>
>>>    C:
>>>      struct foo {
>>>        unsigned _;
>>>        unsigned a:1;
>>>        ...
>>>      };
>>>      ... foo->a ...
>>>
>>>    IR:
>>>      %a = getelementptr inbounds %struct.foo, ptr %0, i32 0, i32 1
>>>      %bf.load = load i8, ptr %a, align 4
>>>      %bf.clear = and i8 %bf.load, 1
>>>      %bf.cast = zext i8 %bf.clear to i32
>>>
>>> With preserve_static_offset the getelementptr+load are replaced by a
>>> single statement which is preserved as-is till code generation,
>>> thus load with align 4 is preserved.
>>>
>>> On the other hand, I'm not sure that clang guarantees that load or
>>> stores used for bitfield access would be always aligned according to
>>> verifier expectations.
>>>
>>> I think we should check if there are some clang knobs that prevent
>>> generation of unaligned memory access. I'll take a look.
>> Is there a reason to prefer fixing in compiler? I'm not opposed to it,
>> but the downside to compiler fix is it takes years to propagate and
>> sprinkles ifdefs into the code.
>>
>> Would it be possible to have an analogue of BPF_CORE_READ_BITFIELD()?
> Well, the contraption below passes verification, tunnel selftest
> appears to work. I might have messed up some shifts in the macro, though.

I didn't test it. But from high level it should work.

>
> Still, if clang would peek unlucky BYTE_{OFFSET,SIZE} for a particular
> field access might be unaligned.

clang should pick a sensible BYTE_SIZE/BYTE_OFFSET to meet
alignment requirement. This is also required for BPF_CORE_READ_BITFIELD.

>
> ---
>
> diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> index 3065a716544d..41cd913ac7ff 100644
> --- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> +++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> @@ -9,6 +9,7 @@
>   #include "vmlinux.h"
>   #include <bpf/bpf_helpers.h>
>   #include <bpf/bpf_endian.h>
> +#include <bpf/bpf_core_read.h>
>   #include "bpf_kfuncs.h"
>   #include "bpf_tracing_net.h"
>   
> @@ -144,6 +145,38 @@ int ip6gretap_get_tunnel(struct __sk_buff *skb)
>   	return TC_ACT_OK;
>   }
>   
> +#define BPF_CORE_WRITE_BITFIELD(s, field, new_val) ({			\
> +	void *p = (void *)s + __CORE_RELO(s, field, BYTE_OFFSET);	\
> +	unsigned byte_size = __CORE_RELO(s, field, BYTE_SIZE);		\
> +	unsigned lshift = __CORE_RELO(s, field, LSHIFT_U64);		\
> +	unsigned rshift = __CORE_RELO(s, field, RSHIFT_U64);		\
> +	unsigned bit_size = (rshift - lshift);				\
> +	unsigned long long nval, val, hi, lo;				\
> +									\
> +	asm volatile("" : "=r"(p) : "0"(p));				\

Use asm volatile("" : "+r"(p)) ?

> +									\
> +	switch (byte_size) {						\
> +	case 1: val = *(unsigned char *)p; break;			\
> +	case 2: val = *(unsigned short *)p; break;			\
> +	case 4: val = *(unsigned int *)p; break;			\
> +	case 8: val = *(unsigned long long *)p; break;			\
> +	}								\
> +	hi = val >> (bit_size + rshift);				\
> +	hi <<= bit_size + rshift;					\
> +	lo = val << (bit_size + lshift);				\
> +	lo >>= bit_size + lshift;					\
> +	nval = new_val;							\
> +	nval <<= lshift;						\
> +	nval >>= rshift;						\
> +	val = hi | nval | lo;						\
> +	switch (byte_size) {						\
> +	case 1: *(unsigned char *)p      = val; break;			\
> +	case 2: *(unsigned short *)p     = val; break;			\
> +	case 4: *(unsigned int *)p       = val; break;			\
> +	case 8: *(unsigned long long *)p = val; break;			\
> +	}								\
> +})

I think this should be put in libbpf public header files but not sure
where to put it. bpf_core_read.h although it is core write?

But on the other hand, this is a uapi struct bitfield write,
strictly speaking, CORE write is really unnecessary here. It
would be great if we can relieve users from dealing with
such unnecessary CORE writes. In that sense, for this particular
case, I would prefer rewriting the code by using byte-level
stores...

> +
>   SEC("tc")
>   int erspan_set_tunnel(struct __sk_buff *skb)
>   {
> @@ -173,9 +206,9 @@ int erspan_set_tunnel(struct __sk_buff *skb)
>   	__u8 hwid = 7;
>   
>   	md.version = 2;
> -	md.u.md2.dir = direction;
> -	md.u.md2.hwid = hwid & 0xf;
> -	md.u.md2.hwid_upper = (hwid >> 4) & 0x3;
> +	BPF_CORE_WRITE_BITFIELD(&md.u.md2, dir, direction);
> +	BPF_CORE_WRITE_BITFIELD(&md.u.md2, hwid, (hwid & 0xf));
> +	BPF_CORE_WRITE_BITFIELD(&md.u.md2, hwid_upper, (hwid >> 4) & 0x3);
>   #endif
>   
>   	ret = bpf_skb_set_tunnel_opt(skb, &md, sizeof(md));
> @@ -214,8 +247,9 @@ int erspan_get_tunnel(struct __sk_buff *skb)
>   	bpf_printk("\tindex %x\n", index);
>   #else
>   	bpf_printk("\tdirection %d hwid %x timestamp %u\n",
> -		   md.u.md2.dir,
> -		   (md.u.md2.hwid_upper << 4) + md.u.md2.hwid,
> +		   BPF_CORE_READ_BITFIELD(&md.u.md2, dir),
> +		   (BPF_CORE_READ_BITFIELD(&md.u.md2, hwid_upper) << 4) +
> +		   BPF_CORE_READ_BITFIELD(&md.u.md2, hwid),
>   		   bpf_ntohl(md.u.md2.timestamp));
>   #endif
>   
> @@ -252,9 +286,9 @@ int ip4ip6erspan_set_tunnel(struct __sk_buff *skb)
>   	__u8 hwid = 17;
>   
>   	md.version = 2;
> -	md.u.md2.dir = direction;
> -	md.u.md2.hwid = hwid & 0xf;
> -	md.u.md2.hwid_upper = (hwid >> 4) & 0x3;
> +	BPF_CORE_WRITE_BITFIELD(&md.u.md2, dir, direction);
> +	BPF_CORE_WRITE_BITFIELD(&md.u.md2, hwid, (hwid & 0xf));
> +	BPF_CORE_WRITE_BITFIELD(&md.u.md2, hwid_upper, (hwid >> 4) & 0x3);
>   #endif
>   
>   	ret = bpf_skb_set_tunnel_opt(skb, &md, sizeof(md));
> @@ -294,8 +328,9 @@ int ip4ip6erspan_get_tunnel(struct __sk_buff *skb)
>   	bpf_printk("\tindex %x\n", index);
>   #else
>   	bpf_printk("\tdirection %d hwid %x timestamp %u\n",
> -		   md.u.md2.dir,
> -		   (md.u.md2.hwid_upper << 4) + md.u.md2.hwid,
> +		   BPF_CORE_READ_BITFIELD(&md.u.md2, dir),
> +		   (BPF_CORE_READ_BITFIELD(&md.u.md2, hwid_upper) << 4) +
> +		   BPF_CORE_READ_BITFIELD(&md.u.md2, hwid),
>   		   bpf_ntohl(md.u.md2.timestamp));
>   #endif
>   

