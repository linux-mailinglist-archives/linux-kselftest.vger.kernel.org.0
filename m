Return-Path: <linux-kselftest+bounces-621-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE6E7F989D
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 06:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E00A1C20918
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 05:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18DC53BA;
	Mon, 27 Nov 2023 05:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vT6C7U8X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [IPv6:2001:41d0:203:375::ac])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C0ED0
	for <linux-kselftest@vger.kernel.org>; Sun, 26 Nov 2023 21:20:42 -0800 (PST)
Message-ID: <2b66d64c-3398-44e0-897e-39dce82a6935@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701062440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UUrbG3HjhihcDSzvkRm1feo5g3W6/H0iCiMp+spttWg=;
	b=vT6C7U8XfSqEqxK251ALqSEbpw2NDD0mseTiFA2A2SckDHBRTu0xVHHOlB3NwjOuxoTwBZ
	g7/8q7wltd1g8fGXkVu+yD19S5DzHtbR/Nbypxj3P8ziOyACIM6Lyeu12hjPyseqAweaLy
	PCUkvLoivcUD2xH9R/tawCRCkVFXO7k=
Date: Sun, 26 Nov 2023 21:20:30 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH ipsec-next v1 6/7] bpf: selftests: test_tunnel: Disable
 CO-RE relocations
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>, Shuah Khan <shuah@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>,
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <18e43cdf65e7ba0d8f6912364fbc5b08a6928b35.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 11/26/23 3:14 PM, Eduard Zingerman wrote:
> On Sat, 2023-11-25 at 20:22 -0800, Yonghong Song wrote:
> [...]
>> --- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
>> +++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
>> @@ -6,7 +6,10 @@
>>     * modify it under the terms of version 2 of the GNU General Public
>>     * License as published by the Free Software Foundation.
>>     */
>> -#define BPF_NO_PRESERVE_ACCESS_INDEX
>> +#if __has_attribute(preserve_static_offset)
>> +struct __attribute__((preserve_static_offset)) erspan_md2;
>> +struct __attribute__((preserve_static_offset)) erspan_metadata;
>> +#endif
>>    #include "vmlinux.h"
> [...]
>>    int bpf_skb_get_fou_encap(struct __sk_buff *skb_ctx,
>> @@ -174,9 +177,13 @@ int erspan_set_tunnel(struct __sk_buff *skb)
>>           __u8 hwid = 7;
>>    
>>           md.version = 2;
>> +#if __has_attribute(preserve_static_offset)
>>           md.u.md2.dir = direction;
>>           md.u.md2.hwid = hwid & 0xf;
>>           md.u.md2.hwid_upper = (hwid >> 4) & 0x3;
>> +#else
>> +       /* Change bit-field store to byte(s)-level stores. */
>> +#endif
>>    #endif
>>    
>>           ret = bpf_skb_set_tunnel_opt(skb, &md, sizeof(md));
>>
>> ====
>>
>> Eduard, could you double check whether this is a valid use case
>> to solve this kind of issue with preserve_static_offset attribute?
> Tbh I'm not sure. This test passes with preserve_static_offset
> because it suppresses preserve_access_index. In general clang
> translates bitfield access to a set of IR statements like:
>
>    C:
>      struct foo {
>        unsigned _;
>        unsigned a:1;
>        ...
>      };
>      ... foo->a ...
>
>    IR:
>      %a = getelementptr inbounds %struct.foo, ptr %0, i32 0, i32 1
>      %bf.load = load i8, ptr %a, align 4
>      %bf.clear = and i8 %bf.load, 1
>      %bf.cast = zext i8 %bf.clear to i32
>
> With preserve_static_offset the getelementptr+load are replaced by a
> single statement which is preserved as-is till code generation,
> thus load with align 4 is preserved.
>
> On the other hand, I'm not sure that clang guarantees that load or
> stores used for bitfield access would be always aligned according to
> verifier expectations.

I think it should be true. The frontend does alignment analysis based on
types and (packed vs. unpacked) and assign each load/store with proper
alignment (like 'align 4' in the above). 'align 4' truely means
the load itself is 4-byte aligned. Otherwise, it will be very confusing
for arch's which do not support unaligned memory access (e.g. BPF).

>
> I think we should check if there are some clang knobs that prevent
> generation of unaligned memory access. I'll take a look.



