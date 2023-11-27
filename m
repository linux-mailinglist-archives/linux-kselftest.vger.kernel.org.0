Return-Path: <linux-kselftest+bounces-666-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 509D17FABD4
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 21:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73B041C20D9B
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 20:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02F32F87F;
	Mon, 27 Nov 2023 20:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="pgevG6dm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rfq6nyQn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C22A1AA;
	Mon, 27 Nov 2023 12:45:19 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailnew.west.internal (Postfix) with ESMTP id 4BBC32B0013D;
	Mon, 27 Nov 2023 15:45:15 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 27 Nov 2023 15:45:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm3; t=
	1701117914; x=1701125114; bh=c6RIxCPZspuBtK8K2FUFUy9oe3rOA3IlnLJ
	SMn0aJrY=; b=pgevG6dm8hI24w8peAUEuqrhrBxxBUDDFCa0Hm1UIUnb/T7rTjM
	qCpKbObWmxmmRGvLKpbJUQDavUV2Er1g3ipGG7DCnXPezvkHY65i21yrNKxtdzuk
	DR+PN7+i5JLdCXSmBY5xbAjfCJsdBFzf9wWI6ADakx3kMBu+wilTOKOiWs9TFpAc
	vBd8zruS+Gtr97UiqdlR9OG6hY+NSi7KYPE0l2P1R7JcUpqDCGmTsPyRcLXcZ/ox
	5wmtS+5X4JdCWnCY881cxlgGzWkae7Afzbufdr+Mmn2ha5+/jqf6+89NQ99FeLlC
	x7/gYhb6UeZGD4zsq2Bdhb5KpuOW87GY+bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1701117914; x=1701125114; bh=c6RIxCPZspuBtK8K2FUFUy9oe3rOA3IlnLJ
	SMn0aJrY=; b=Rfq6nyQnKnCi3gDOoi66hH0ZpfPk+E924Vdx/1BipZdSjeaqekH
	tdWqN63IevDJNwH9oSolNGavAKGHMUxjSTcHTUMACgQJO4au11SbcZHQZ5v3Rvgw
	ENZ9XeCF6VyNxNSLdT82qFEni/due1wxdKM7Ddj3ksHDPHpN/d5KpxpcJE+xvu3P
	f7F44b6mBTFFaSuslNTiM7bnBOgbwt2tB3/G3UvDjIOzB/X2+jggM80wPzmuD9AI
	N1ZVbM2WU53AQ3igGLR1fhVnUGtmtZzq6tXgYZzxQXUdc4f4SPPk4vVE4/vxyHpQ
	2erVRMU6Ho3grJA25M9wZRMBMz6B/pXbGnw==
X-ME-Sender: <xms:2f9kZTi25_zkJrmXET_KDyWAMVKkbzoFgBrHv8ANkfUdiguLApTjcg>
    <xme:2f9kZQAC9a8vBBDBZ2y9HZL2MllFJxZVGfAbQgFoR6BxFPquFOFcr6syCkFh_RQpY
    owHmYIW79EpgiY-OQ>
X-ME-Received: <xmr:2f9kZTEyftqvefDvMcRt0CG2BhcjG29W99bYFbe8OvIbu-W0Vd-maMnkDnx22jQz4GeAswwJluDws32c3gx4WqIAg1bDbmlhDqPBxvaFYICO7-xT-cajyhSSifk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiuddgudegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdejtddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkefs
    tddttddunecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihii
    eqnecuggftrfgrthhtvghrnhepudefiedtieehffeuffelffegheegjeekteekgfdtkeef
    jeehffejtdfgkeeiteelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:2f9kZQTR4nBr7Y-dxUjnLjjdQwBsfjoT2Wxh1e_j4OlC7I4qIFJNFA>
    <xmx:2f9kZQxbUDx61KaAdVg2gkVDDml2RCQ9JvKRBNEw2KRu64np0V1pUw>
    <xmx:2f9kZW4o-rcgLZw2yXCCC5SxWGNAFYksp9XUJv3CeDlP8uEP6cV1pg>
    <xmx:2v9kZdz7R6dEonqpP1w4QvJ7vI63sdvRV-JRlc_kM7IMCMr7dm2sfn1H2-8>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Nov 2023 15:45:12 -0500 (EST)
Date: Mon, 27 Nov 2023 14:45:11 -0600
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
Message-ID: <xehp2qvy5cyaairbnfhem4hvbsl26blo4zzu7z6ywbp26jcwyn@hgp3v2q4ud7o>
References: <cover.1700676682.git.dxu@dxuuu.xyz>
 <391d524c496acc97a8801d8bea80976f58485810.1700676682.git.dxu@dxuuu.xyz>
 <0f210cef-c6e9-41c1-9ba8-225f046435e5@linux.dev>
 <CAADnVQ+sEsUyNYPeZyOf2PcCnxOvOqw4bUuAuMofCU14szTGvg@mail.gmail.com>
 <3ec6c068-7f95-419a-a0ae-a901f95e4838@linux.dev>
 <18e43cdf65e7ba0d8f6912364fbc5b08a6928b35.camel@gmail.com>
 <uc5fv3keghefszuvono7aclgtjtgjnnia3i54ynejmyrs42ser@bwdpq5gmuvub>
 <0535eb913f1a0c2d3c291478fde07e0aa2b333f1.camel@gmail.com>
 <42f9bf0d-695a-412d-bea5-cb7036fa7418@linux.dev>
 <a5a84482-13ef-47d8-bf07-8017060a5d64@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a5a84482-13ef-47d8-bf07-8017060a5d64@linux.dev>

On Sun, Nov 26, 2023 at 09:53:04PM -0800, Yonghong Song wrote:
> 
> On 11/27/23 12:44 AM, Yonghong Song wrote:
> > 
> > On 11/26/23 8:52 PM, Eduard Zingerman wrote:
> > > On Sun, 2023-11-26 at 18:04 -0600, Daniel Xu wrote:
> > > [...]
> > > > > Tbh I'm not sure. This test passes with preserve_static_offset
> > > > > because it suppresses preserve_access_index. In general clang
> > > > > translates bitfield access to a set of IR statements like:
> > > > > 
> > > > >    C:
> > > > >      struct foo {
> > > > >        unsigned _;
> > > > >        unsigned a:1;
> > > > >        ...
> > > > >      };
> > > > >      ... foo->a ...
> > > > > 
> > > > >    IR:
> > > > >      %a = getelementptr inbounds %struct.foo, ptr %0, i32 0, i32 1
> > > > >      %bf.load = load i8, ptr %a, align 4
> > > > >      %bf.clear = and i8 %bf.load, 1
> > > > >      %bf.cast = zext i8 %bf.clear to i32
> > > > > 
> > > > > With preserve_static_offset the getelementptr+load are replaced by a
> > > > > single statement which is preserved as-is till code generation,
> > > > > thus load with align 4 is preserved.
> > > > > 
> > > > > On the other hand, I'm not sure that clang guarantees that load or
> > > > > stores used for bitfield access would be always aligned according to
> > > > > verifier expectations.
> > > > > 
> > > > > I think we should check if there are some clang knobs that prevent
> > > > > generation of unaligned memory access. I'll take a look.
> > > > Is there a reason to prefer fixing in compiler? I'm not opposed to it,
> > > > but the downside to compiler fix is it takes years to propagate and
> > > > sprinkles ifdefs into the code.
> > > > 
> > > > Would it be possible to have an analogue of BPF_CORE_READ_BITFIELD()?
> > > Well, the contraption below passes verification, tunnel selftest
> > > appears to work. I might have messed up some shifts in the macro,
> > > though.
> > 
> > I didn't test it. But from high level it should work.
> > 
> > > 
> > > Still, if clang would peek unlucky BYTE_{OFFSET,SIZE} for a particular
> > > field access might be unaligned.
> > 
> > clang should pick a sensible BYTE_SIZE/BYTE_OFFSET to meet
> > alignment requirement. This is also required for BPF_CORE_READ_BITFIELD.
> > 
> > > 
> > > ---
> > > 
> > > diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > > b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > > index 3065a716544d..41cd913ac7ff 100644
> > > --- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > > +++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > > @@ -9,6 +9,7 @@
> > >   #include "vmlinux.h"
> > >   #include <bpf/bpf_helpers.h>
> > >   #include <bpf/bpf_endian.h>
> > > +#include <bpf/bpf_core_read.h>
> > >   #include "bpf_kfuncs.h"
> > >   #include "bpf_tracing_net.h"
> > >   @@ -144,6 +145,38 @@ int ip6gretap_get_tunnel(struct __sk_buff *skb)
> > >       return TC_ACT_OK;
> > >   }
> > >   +#define BPF_CORE_WRITE_BITFIELD(s, field, new_val) ({            \
> > > +    void *p = (void *)s + __CORE_RELO(s, field, BYTE_OFFSET);    \
> > > +    unsigned byte_size = __CORE_RELO(s, field, BYTE_SIZE);        \
> > > +    unsigned lshift = __CORE_RELO(s, field, LSHIFT_U64); \
> > > +    unsigned rshift = __CORE_RELO(s, field, RSHIFT_U64); \
> > > +    unsigned bit_size = (rshift - lshift);                \
> > > +    unsigned long long nval, val, hi, lo;                \
> > > +                                    \
> > > +    asm volatile("" : "=r"(p) : "0"(p));                \
> > 
> > Use asm volatile("" : "+r"(p)) ?
> > 
> > > +                                    \
> > > +    switch (byte_size) {                        \
> > > +    case 1: val = *(unsigned char *)p; break;            \
> > > +    case 2: val = *(unsigned short *)p; break;            \
> > > +    case 4: val = *(unsigned int *)p; break;            \
> > > +    case 8: val = *(unsigned long long *)p; break;            \
> > > +    }                                \
> > > +    hi = val >> (bit_size + rshift);                \
> > > +    hi <<= bit_size + rshift;                    \
> > > +    lo = val << (bit_size + lshift);                \
> > > +    lo >>= bit_size + lshift;                    \
> > > +    nval = new_val;                            \
> > > +    nval <<= lshift;                        \
> > > +    nval >>= rshift;                        \
> > > +    val = hi | nval | lo;                        \
> > > +    switch (byte_size) {                        \
> > > +    case 1: *(unsigned char *)p      = val; break;            \
> > > +    case 2: *(unsigned short *)p     = val; break;            \
> > > +    case 4: *(unsigned int *)p       = val; break;            \
> > > +    case 8: *(unsigned long long *)p = val; break;            \
> > > +    }                                \
> > > +})
> > 
> > I think this should be put in libbpf public header files but not sure
> > where to put it. bpf_core_read.h although it is core write?
> > 
> > But on the other hand, this is a uapi struct bitfield write,
> > strictly speaking, CORE write is really unnecessary here. It
> > would be great if we can relieve users from dealing with
> > such unnecessary CORE writes. In that sense, for this particular
> > case, I would prefer rewriting the code by using byte-level
> > stores...
> or preserve_static_offset to clearly mean to undo bitfield CORE ...

Ok, I will do byte-level rewrite for next revision.

Just wondering, though: will bpftool be able to generate the appropriate
annotations for uapi structs? IIUC uapi structs look the same in BTF as
any other struct.

> 
> [...]
> 

Thanks,
Daniel

