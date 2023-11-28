Return-Path: <linux-kselftest+bounces-684-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4CF7FAECF
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 01:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E53EDB21117
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 00:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B4836B;
	Tue, 28 Nov 2023 00:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="h0vUhgD6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="awkJk73X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1824101;
	Mon, 27 Nov 2023 16:01:10 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailnew.nyi.internal (Postfix) with ESMTP id 6ACEB580979;
	Mon, 27 Nov 2023 19:01:07 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 27 Nov 2023 19:01:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm3; t=
	1701129667; x=1701136867; bh=OSQtcO0pegrxarZcG5C5VOBtpHVJhZcct9m
	oQPXmvT4=; b=h0vUhgD60RYO7nCWRGpot3ijJG19C3YfA4IIwFyt5kXWyvb9puA
	AWklEiuo9lkbPYgqPBm+2ytpwqLWv92V3IFFRnw6+Rix78s95QWtzD2eNtSNh9MU
	KAx7SQ36fYiuB2pu6ZIn6I5UzbWhCYN0C+vkTtYL4/oR9sB5wZETNiHhRqQLNPIb
	NPIGXPvNNH6fAgi1IztrtsLv7z/FkVWLs49gojsQCNR8ouH2JHr+RY0kd5rtvxZL
	tJ6nE1jzcThqBubP7Llz+8WPQ0SNyce3wca8453C24xAH2Jh6tzGjvihH/Ab+VU/
	sPti/9X12x1it+XA/cy54WoIimh/YQVFKUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1701129667; x=1701136867; bh=OSQtcO0pegrxarZcG5C5VOBtpHVJhZcct9m
	oQPXmvT4=; b=awkJk73X+I1uiAWNEQNYVfVRIMq1ZItqrORBmTZep8lSK1xxZkY
	DtfTBYj+ETVL2WGPowa6TQNRc0pr+lBFrUNDwhYtfWy68hW5yvbWFDUDpLg6GHDt
	QyYDf0s0B6Yh5NzguaHrASuO91Eek9LcP1FfwggGl9oE7l6l8KxQKyGMQ2c+ViWD
	aNRW9/AokxHlC4Y8eahUqlQMmwwyfkkjjpEQTD8bAAPIl20seqA5fkxm1VAewsJK
	0ims1oXiSYZjbRadYrgAKD3+t2JUpSZtzOV3eyy0+11wNgve47OuUJKVQqOuphDU
	hR6w3hI5ilKBqyo4usayhnAerJpaKSJIkgw==
X-ME-Sender: <xms:wS1lZVNjk5J9DyJX2P6YmrMiP6c0IX9o4-SWgScUp8iL4Wod9Ms5PA>
    <xme:wS1lZX_4d6aXQX2n04miga8vf0Cixzw6Zm5zfP5cvJ2KztEFddxIUCLcVgqCKKYKF
    yr3XNjhfO9a-Yk3rw>
X-ME-Received: <xmr:wS1lZURAy9jMPGoMfF26znWE7bQ1hyeHMnwrfM5nEPhiEcXISryDbBmOxL7zx9ZgzmXeJmcZtcSRuahiwgwndR0kWnWLZGjW3AzJSeDE4qD6kEXSiTtju2xs21I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeivddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdljedtmdenucfjughrpeffhffvvefukfhfgggtugfgjgestheksfdt
    tddtudenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpeehteelgfffiedtledulefgteejhedufeehuefhvefhhfff
    hfekhfefkefhkeegudenucffohhmrghinhepugiguhhuuhdrgiihiienucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdig
    hiii
X-ME-Proxy: <xmx:wi1lZRvh2mX76SoCmDnz2VUJdkbcWfB2EPb-TbIcqCuiC3W1k_xsbQ>
    <xmx:wi1lZdfely_9ITCr7XGzR6-e6lXE5Hn1tzwI2rfWH5UWxkhmPMyvhA>
    <xmx:wi1lZd2n-RYWze-qa67kob1sGvPedOBU5Ci5c8tkWoC1sLB2EHbSdw>
    <xmx:wy1lZT_Mhk3mz2Zi4Uj1Nt66u5V5I4EIZ-k2l2d-vaNb0HVRA7-06w>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Nov 2023 19:01:04 -0500 (EST)
Date: Mon, 27 Nov 2023 18:01:03 -0600
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
Message-ID: <53jaqi72ef4gynyafxidl5veb54kfs7dttxezkarwg75t7szd4@cvfg5pc7pyum>
References: <391d524c496acc97a8801d8bea80976f58485810.1700676682.git.dxu@dxuuu.xyz>
 <0f210cef-c6e9-41c1-9ba8-225f046435e5@linux.dev>
 <CAADnVQ+sEsUyNYPeZyOf2PcCnxOvOqw4bUuAuMofCU14szTGvg@mail.gmail.com>
 <3ec6c068-7f95-419a-a0ae-a901f95e4838@linux.dev>
 <18e43cdf65e7ba0d8f6912364fbc5b08a6928b35.camel@gmail.com>
 <uc5fv3keghefszuvono7aclgtjtgjnnia3i54ynejmyrs42ser@bwdpq5gmuvub>
 <0535eb913f1a0c2d3c291478fde07e0aa2b333f1.camel@gmail.com>
 <42f9bf0d-695a-412d-bea5-cb7036fa7418@linux.dev>
 <a5a84482-13ef-47d8-bf07-8017060a5d64@linux.dev>
 <xehp2qvy5cyaairbnfhem4hvbsl26blo4zzu7z6ywbp26jcwyn@hgp3v2q4ud7o>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xehp2qvy5cyaairbnfhem4hvbsl26blo4zzu7z6ywbp26jcwyn@hgp3v2q4ud7o>

On Mon, Nov 27, 2023 at 02:45:11PM -0600, Daniel Xu wrote:
> On Sun, Nov 26, 2023 at 09:53:04PM -0800, Yonghong Song wrote:
> > 
> > On 11/27/23 12:44 AM, Yonghong Song wrote:
> > > 
> > > On 11/26/23 8:52 PM, Eduard Zingerman wrote:
> > > > On Sun, 2023-11-26 at 18:04 -0600, Daniel Xu wrote:
> > > > [...]
> > > > > > Tbh I'm not sure. This test passes with preserve_static_offset
> > > > > > because it suppresses preserve_access_index. In general clang
> > > > > > translates bitfield access to a set of IR statements like:
> > > > > > 
> > > > > >    C:
> > > > > >      struct foo {
> > > > > >        unsigned _;
> > > > > >        unsigned a:1;
> > > > > >        ...
> > > > > >      };
> > > > > >      ... foo->a ...
> > > > > > 
> > > > > >    IR:
> > > > > >      %a = getelementptr inbounds %struct.foo, ptr %0, i32 0, i32 1
> > > > > >      %bf.load = load i8, ptr %a, align 4
> > > > > >      %bf.clear = and i8 %bf.load, 1
> > > > > >      %bf.cast = zext i8 %bf.clear to i32
> > > > > > 
> > > > > > With preserve_static_offset the getelementptr+load are replaced by a
> > > > > > single statement which is preserved as-is till code generation,
> > > > > > thus load with align 4 is preserved.
> > > > > > 
> > > > > > On the other hand, I'm not sure that clang guarantees that load or
> > > > > > stores used for bitfield access would be always aligned according to
> > > > > > verifier expectations.
> > > > > > 
> > > > > > I think we should check if there are some clang knobs that prevent
> > > > > > generation of unaligned memory access. I'll take a look.
> > > > > Is there a reason to prefer fixing in compiler? I'm not opposed to it,
> > > > > but the downside to compiler fix is it takes years to propagate and
> > > > > sprinkles ifdefs into the code.
> > > > > 
> > > > > Would it be possible to have an analogue of BPF_CORE_READ_BITFIELD()?
> > > > Well, the contraption below passes verification, tunnel selftest
> > > > appears to work. I might have messed up some shifts in the macro,
> > > > though.
> > > 
> > > I didn't test it. But from high level it should work.
> > > 
> > > > 
> > > > Still, if clang would peek unlucky BYTE_{OFFSET,SIZE} for a particular
> > > > field access might be unaligned.
> > > 
> > > clang should pick a sensible BYTE_SIZE/BYTE_OFFSET to meet
> > > alignment requirement. This is also required for BPF_CORE_READ_BITFIELD.
> > > 
> > > > 
> > > > ---
> > > > 
> > > > diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > > > b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > > > index 3065a716544d..41cd913ac7ff 100644
> > > > --- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > > > +++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > > > @@ -9,6 +9,7 @@
> > > >   #include "vmlinux.h"
> > > >   #include <bpf/bpf_helpers.h>
> > > >   #include <bpf/bpf_endian.h>
> > > > +#include <bpf/bpf_core_read.h>
> > > >   #include "bpf_kfuncs.h"
> > > >   #include "bpf_tracing_net.h"
> > > >   @@ -144,6 +145,38 @@ int ip6gretap_get_tunnel(struct __sk_buff *skb)
> > > >       return TC_ACT_OK;
> > > >   }
> > > >   +#define BPF_CORE_WRITE_BITFIELD(s, field, new_val) ({            \
> > > > +    void *p = (void *)s + __CORE_RELO(s, field, BYTE_OFFSET);    \
> > > > +    unsigned byte_size = __CORE_RELO(s, field, BYTE_SIZE);        \
> > > > +    unsigned lshift = __CORE_RELO(s, field, LSHIFT_U64); \
> > > > +    unsigned rshift = __CORE_RELO(s, field, RSHIFT_U64); \
> > > > +    unsigned bit_size = (rshift - lshift);                \
> > > > +    unsigned long long nval, val, hi, lo;                \
> > > > +                                    \
> > > > +    asm volatile("" : "=r"(p) : "0"(p));                \
> > > 
> > > Use asm volatile("" : "+r"(p)) ?
> > > 
> > > > +                                    \
> > > > +    switch (byte_size) {                        \
> > > > +    case 1: val = *(unsigned char *)p; break;            \
> > > > +    case 2: val = *(unsigned short *)p; break;            \
> > > > +    case 4: val = *(unsigned int *)p; break;            \
> > > > +    case 8: val = *(unsigned long long *)p; break;            \
> > > > +    }                                \
> > > > +    hi = val >> (bit_size + rshift);                \
> > > > +    hi <<= bit_size + rshift;                    \
> > > > +    lo = val << (bit_size + lshift);                \
> > > > +    lo >>= bit_size + lshift;                    \
> > > > +    nval = new_val;                            \
> > > > +    nval <<= lshift;                        \
> > > > +    nval >>= rshift;                        \
> > > > +    val = hi | nval | lo;                        \
> > > > +    switch (byte_size) {                        \
> > > > +    case 1: *(unsigned char *)p      = val; break;            \
> > > > +    case 2: *(unsigned short *)p     = val; break;            \
> > > > +    case 4: *(unsigned int *)p       = val; break;            \
> > > > +    case 8: *(unsigned long long *)p = val; break;            \
> > > > +    }                                \
> > > > +})
> > > 
> > > I think this should be put in libbpf public header files but not sure
> > > where to put it. bpf_core_read.h although it is core write?
> > > 
> > > But on the other hand, this is a uapi struct bitfield write,
> > > strictly speaking, CORE write is really unnecessary here. It
> > > would be great if we can relieve users from dealing with
> > > such unnecessary CORE writes. In that sense, for this particular
> > > case, I would prefer rewriting the code by using byte-level
> > > stores...
> > or preserve_static_offset to clearly mean to undo bitfield CORE ...
> 
> Ok, I will do byte-level rewrite for next revision.

[...]

This patch seems to work: https://pastes.dxuuu.xyz/0glrf9 .

But I don't think it's very pretty. Also I'm seeing on the internet that
people are saying the exact layout of bitfields is compiler dependent.
So I am wondering if these byte sized writes are correct. For that
matter, I am wondering how the GCC generated bitfield accesses line up
with clang generated BPF bytecode. Or why uapi contains a bitfield.

WDYT, should I send up v2 with this or should I do one of the other
approaches in this thread?

I am ok with any of the approaches.

Thanks,
Daniel

