Return-Path: <linux-kselftest+bounces-725-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7637D7FBF07
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 17:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 322ED2827C1
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 16:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D58B37D28;
	Tue, 28 Nov 2023 16:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="MWLMiBqD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LJYiXb1f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A96DD5D;
	Tue, 28 Nov 2023 08:13:55 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailnew.nyi.internal (Postfix) with ESMTP id 789E8580840;
	Tue, 28 Nov 2023 11:13:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 28 Nov 2023 11:13:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm3; t=
	1701188034; x=1701195234; bh=5drytYPek90lBybE7wNiNIhC63+OA3VvQrl
	HiKy5Ycc=; b=MWLMiBqDQM0jldo13NemcTHBNlvAw8LJNZ2MXz2NFpGCypApIYk
	vSx7FYxadVUDFBgw7etbYWgU1etNQ8neLssg6im2iB6cZr8sbnz7ry3XZ/jXXqxJ
	+gAx+aGGA1tTOO4f50fIP/x7lNjaHSFqY9jYsBbBmVi43IC8/pSKdHuKTtaUX5m/
	6fRg6AnN1Xh/RR7BsRBZ8fKbrgog8e1I91vzuVffQNwXix50s3JGHUZ+vIF7f9jY
	6gEB40ehEsHJfF1/YbeHRvcuFA+GGfglB/5q6SqHfqmwm8KxeD8eAAJ/q4Fg7I5S
	NWdxgMnWABeI8F06/oz16d19xtgSSE3+eCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1701188034; x=1701195234; bh=5drytYPek90lBybE7wNiNIhC63+OA3VvQrl
	HiKy5Ycc=; b=LJYiXb1faT8Z5T6zh3cCWzKeiLAh2qi6GIh6hxy6f9xgrhNXb/y
	JfSuYQ6z8gRm0nTqXOJReTI90ZlRd/TMxeU3ct31Kr5O/QvPUJfllnO4JEu6I0zZ
	ugbbpDkhnCPdq65l2DiDAAEuGaX1lLXZxpYecncXApmRNgCy+niYjDmeCBSlSbZc
	vKJwWJTq8AylZpCGNanVL1YVnDRy2Dq26YPwpeN0Xj8GotPYGC7r4fe0eHMr3DTr
	gblOgh/Z4GmEwGQfg3+KBy8LpAGfQU5824+K2RK8VBsOCgkRqvXSXqk4JYo0WxKq
	Py4FAKBRS7UG4NmmuS4MPytYiu2hcNM3vNQ==
X-ME-Sender: <xms:wRFmZSVBUl3H4hVXqbYvRHcBUzC5Q7Q90dXxExCnF0dfisQ2PgxHRQ>
    <xme:wRFmZekWnw5m_WNQo8YeF4JM8pO_kGCkpKOPkG-wHgRx3gB_gjdIOLEpMp0WPbVyV
    EG311-Fhb89M4Al5g>
X-ME-Received: <xmr:wRFmZWZvfkx-8bXezS0cI2jrKM-Xd9AiDOUJT2b25_ZdIgjJzzF-q6Ef2abj9aNi6TY1ITayqLO2Tm51jIIc7Aqr36KQZU0iyJTaqao3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeifedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpeffhffvvefukfhfgggtugfgjgestheksfdt
    tddtudenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpeehgffgkeekleeluddvgedtgeejfeejtdffheeggeeutdeu
    geduvefgleegteehleenucffohhmrghinhepugiguhhuuhdrgiihiidpghhithhhuhgsrd
    gtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    ugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:whFmZZV-1pT1kDnvbwn0sSqU8OO9C9DvD32DOKidagZM26_YrlL0Fw>
    <xmx:whFmZcmHrTi3kRWmQcoio-kxuktyTmP5kPgoWZxvXdRTIo2BIFImJw>
    <xmx:whFmZecCFAbovJnVE75moP9rvrnhihBc7mDGvTPRqC-1xcR18YMGHQ>
    <xmx:whFmZUHWqli85EIgW1WDAXRK4_i1lRlQkydqelzSllazLDTCCG7crQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Nov 2023 11:13:52 -0500 (EST)
Date: Tue, 28 Nov 2023 10:13:50 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	antony.antony@secunet.com, Mykola Lysenko <mykolal@fb.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, devel@linux-ipsec.org, 
	Network Development <netdev@vger.kernel.org>
Subject: Re: [PATCH ipsec-next v1 6/7] bpf: selftests: test_tunnel: Disable
 CO-RE relocations
Message-ID: <p6qdiwnuglz7ry6hsssruf3w6n3tnavglya3iampors7eb4ac6@nonyetjx2zvc>
References: <CAADnVQ+sEsUyNYPeZyOf2PcCnxOvOqw4bUuAuMofCU14szTGvg@mail.gmail.com>
 <3ec6c068-7f95-419a-a0ae-a901f95e4838@linux.dev>
 <18e43cdf65e7ba0d8f6912364fbc5b08a6928b35.camel@gmail.com>
 <uc5fv3keghefszuvono7aclgtjtgjnnia3i54ynejmyrs42ser@bwdpq5gmuvub>
 <0535eb913f1a0c2d3c291478fde07e0aa2b333f1.camel@gmail.com>
 <42f9bf0d-695a-412d-bea5-cb7036fa7418@linux.dev>
 <a5a84482-13ef-47d8-bf07-8017060a5d64@linux.dev>
 <xehp2qvy5cyaairbnfhem4hvbsl26blo4zzu7z6ywbp26jcwyn@hgp3v2q4ud7o>
 <53jaqi72ef4gynyafxidl5veb54kfs7dttxezkarwg75t7szd4@cvfg5pc7pyum>
 <f68c01d6-bf6b-4b76-8b20-53e9f4a61fcd@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f68c01d6-bf6b-4b76-8b20-53e9f4a61fcd@linux.dev>

On Mon, Nov 27, 2023 at 08:06:01PM -0800, Yonghong Song wrote:
> 
> On 11/27/23 7:01 PM, Daniel Xu wrote:
> > On Mon, Nov 27, 2023 at 02:45:11PM -0600, Daniel Xu wrote:
> > > On Sun, Nov 26, 2023 at 09:53:04PM -0800, Yonghong Song wrote:
> > > > On 11/27/23 12:44 AM, Yonghong Song wrote:
> > > > > On 11/26/23 8:52 PM, Eduard Zingerman wrote:
> > > > > > On Sun, 2023-11-26 at 18:04 -0600, Daniel Xu wrote:
> > > > > > [...]
> > > > > > > > Tbh I'm not sure. This test passes with preserve_static_offset
> > > > > > > > because it suppresses preserve_access_index. In general clang
> > > > > > > > translates bitfield access to a set of IR statements like:
> > > > > > > > 
> > > > > > > >     C:
> > > > > > > >       struct foo {
> > > > > > > >         unsigned _;
> > > > > > > >         unsigned a:1;
> > > > > > > >         ...
> > > > > > > >       };
> > > > > > > >       ... foo->a ...
> > > > > > > > 
> > > > > > > >     IR:
> > > > > > > >       %a = getelementptr inbounds %struct.foo, ptr %0, i32 0, i32 1
> > > > > > > >       %bf.load = load i8, ptr %a, align 4
> > > > > > > >       %bf.clear = and i8 %bf.load, 1
> > > > > > > >       %bf.cast = zext i8 %bf.clear to i32
> > > > > > > > 
> > > > > > > > With preserve_static_offset the getelementptr+load are replaced by a
> > > > > > > > single statement which is preserved as-is till code generation,
> > > > > > > > thus load with align 4 is preserved.
> > > > > > > > 
> > > > > > > > On the other hand, I'm not sure that clang guarantees that load or
> > > > > > > > stores used for bitfield access would be always aligned according to
> > > > > > > > verifier expectations.
> > > > > > > > 
> > > > > > > > I think we should check if there are some clang knobs that prevent
> > > > > > > > generation of unaligned memory access. I'll take a look.
> > > > > > > Is there a reason to prefer fixing in compiler? I'm not opposed to it,
> > > > > > > but the downside to compiler fix is it takes years to propagate and
> > > > > > > sprinkles ifdefs into the code.
> > > > > > > 
> > > > > > > Would it be possible to have an analogue of BPF_CORE_READ_BITFIELD()?
> > > > > > Well, the contraption below passes verification, tunnel selftest
> > > > > > appears to work. I might have messed up some shifts in the macro,
> > > > > > though.
> > > > > I didn't test it. But from high level it should work.
> > > > > 
> > > > > > Still, if clang would peek unlucky BYTE_{OFFSET,SIZE} for a particular
> > > > > > field access might be unaligned.
> > > > > clang should pick a sensible BYTE_SIZE/BYTE_OFFSET to meet
> > > > > alignment requirement. This is also required for BPF_CORE_READ_BITFIELD.
> > > > > 
> > > > > > ---
> > > > > > 
> > > > > > diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > > > > > b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > > > > > index 3065a716544d..41cd913ac7ff 100644
> > > > > > --- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > > > > > +++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > > > > > @@ -9,6 +9,7 @@
> > > > > >    #include "vmlinux.h"
> > > > > >    #include <bpf/bpf_helpers.h>
> > > > > >    #include <bpf/bpf_endian.h>
> > > > > > +#include <bpf/bpf_core_read.h>
> > > > > >    #include "bpf_kfuncs.h"
> > > > > >    #include "bpf_tracing_net.h"
> > > > > >    @@ -144,6 +145,38 @@ int ip6gretap_get_tunnel(struct __sk_buff *skb)
> > > > > >        return TC_ACT_OK;
> > > > > >    }
> > > > > >    +#define BPF_CORE_WRITE_BITFIELD(s, field, new_val) ({            \
> > > > > > +    void *p = (void *)s + __CORE_RELO(s, field, BYTE_OFFSET);    \
> > > > > > +    unsigned byte_size = __CORE_RELO(s, field, BYTE_SIZE);        \
> > > > > > +    unsigned lshift = __CORE_RELO(s, field, LSHIFT_U64); \
> > > > > > +    unsigned rshift = __CORE_RELO(s, field, RSHIFT_U64); \
> > > > > > +    unsigned bit_size = (rshift - lshift);                \
> > > > > > +    unsigned long long nval, val, hi, lo;                \
> > > > > > +                                    \
> > > > > > +    asm volatile("" : "=r"(p) : "0"(p));                \
> > > > > Use asm volatile("" : "+r"(p)) ?
> > > > > 
> > > > > > +                                    \
> > > > > > +    switch (byte_size) {                        \
> > > > > > +    case 1: val = *(unsigned char *)p; break;            \
> > > > > > +    case 2: val = *(unsigned short *)p; break;            \
> > > > > > +    case 4: val = *(unsigned int *)p; break;            \
> > > > > > +    case 8: val = *(unsigned long long *)p; break;            \
> > > > > > +    }                                \
> > > > > > +    hi = val >> (bit_size + rshift);                \
> > > > > > +    hi <<= bit_size + rshift;                    \
> > > > > > +    lo = val << (bit_size + lshift);                \
> > > > > > +    lo >>= bit_size + lshift;                    \
> > > > > > +    nval = new_val;                            \
> > > > > > +    nval <<= lshift;                        \
> > > > > > +    nval >>= rshift;                        \
> > > > > > +    val = hi | nval | lo;                        \
> > > > > > +    switch (byte_size) {                        \
> > > > > > +    case 1: *(unsigned char *)p      = val; break;            \
> > > > > > +    case 2: *(unsigned short *)p     = val; break;            \
> > > > > > +    case 4: *(unsigned int *)p       = val; break;            \
> > > > > > +    case 8: *(unsigned long long *)p = val; break;            \
> > > > > > +    }                                \
> > > > > > +})
> > > > > I think this should be put in libbpf public header files but not sure
> > > > > where to put it. bpf_core_read.h although it is core write?
> > > > > 
> > > > > But on the other hand, this is a uapi struct bitfield write,
> > > > > strictly speaking, CORE write is really unnecessary here. It
> > > > > would be great if we can relieve users from dealing with
> > > > > such unnecessary CORE writes. In that sense, for this particular
> > > > > case, I would prefer rewriting the code by using byte-level
> > > > > stores...
> > > > or preserve_static_offset to clearly mean to undo bitfield CORE ...
> > > Ok, I will do byte-level rewrite for next revision.
> > [...]
> > 
> > This patch seems to work: https://pastes.dxuuu.xyz/0glrf9 .
> > 
> > But I don't think it's very pretty. Also I'm seeing on the internet that
> > people are saying the exact layout of bitfields is compiler dependent.
> 
> Any reference for this (exact layout of bitfields is compiler dependent)?
> 
> > So I am wondering if these byte sized writes are correct. For that
> > matter, I am wondering how the GCC generated bitfield accesses line up
> > with clang generated BPF bytecode. Or why uapi contains a bitfield.
> 
> One thing for sure is memory layout of bitfields should be the same
> for both clang and gcc as it is determined by C standard. Register
> representation and how to manipulate could be different for different
> compilers.

I was reading this thread:
https://github.com/Lora-net/LoRaMac-node/issues/697. It's obviously not
authoritative, but they sure sound confident!

I think I've also heard it before a long time ago when I was working on
adding bitfield support to bpftrace.


[...]

