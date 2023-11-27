Return-Path: <linux-kselftest+bounces-618-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2017F96B6
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 01:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 148CBB20A3B
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 00:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5403E361;
	Mon, 27 Nov 2023 00:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="NaulhuTw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IddQoC+7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99351FB;
	Sun, 26 Nov 2023 16:04:57 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailnew.nyi.internal (Postfix) with ESMTP id 8E18F5807BE;
	Sun, 26 Nov 2023 19:04:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 26 Nov 2023 19:04:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1701043493; x=1701050693; bh=UG
	Nk44U4jmXOJ/AcIH3TlGvpqXW3QFjzprbde8gLJZU=; b=NaulhuTwyiNqIMbSl8
	cyVa+7RWp/OPWxg3O6P76LZYVLpu1kn9SSue+Gawi6CCJnxzv/34X+Dje+wkdcH1
	f8LbXnkQwglIhjYZ5xLYDHHiXJejykMtIaKkvynrpBp806WZFNj1LAlKuObSyZhx
	yBXlqxjT6mkV+9AlVfDMXlXc+3pvahR790j3p7HWy4LXsLquJbbGhI0IBPPtvwkk
	m06RNfkcOqs46d46Op1KamrJp9AFX8G2XRjcSUZ6whvllI9SdGkV45OEdy7KStJb
	l7/BlGCzViVsjjzLmFhXKj5mc6sx1w8CCxCV1VAFj8d64QeWkPOwH/TUNcUN+cj4
	Z4Fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701043493; x=1701050693; bh=UGNk44U4jmXOJ
	/AcIH3TlGvpqXW3QFjzprbde8gLJZU=; b=IddQoC+7h+piTRX4O77oxs63wgeJ/
	qQnXeFocUrafGEluooWeaacpsCbDVfmdZuE4tsjVFdeVqbb5pBhzuOIjeP8npVRu
	rIveoi2kbsn9DsEuo98IuOaOda6yDqAHriusUOrL/l0e72i6Nn9UkmlHN6DPGKZZ
	lpopZKJC7so4PuhVBw0ANM3hoH3xpte6LkxKztaZTx+dPA496kw//3jrzxW8F6ZF
	mna5ObqhhpOf88uguLewL6PNO15mHOs8bpMYXVB6LfWRmRbKxnXzrRwau+yIvQ3W
	SAHtD0C6guqpxbuH+2NfaKPBFSUxLropKwdtGyEDIDPvaOgNbjzwy8XHA==
X-ME-Sender: <xms:JN1jZYB8lkRG4HvbGfVVyl63D6gCGn9Vy6pqBUHi1bZaXcEVSOdFGA>
    <xme:JN1jZage5HU5HK2QOTcsYn1zmUjds4J1h2TBFXRg0qHFZvInr-sJ3n0iUzhka-3rx
    QbjlCDDn-m1u86J_Q>
X-ME-Received: <xmr:JN1jZblV7A9gPrV_VYyDnqvA5U1eL2YjD67We8yizuvZfUeJJKItobc6vEA0YDfmfB-48OZoRIU96Vb5x8T6iNb-KD-kbfdmqv717jjKQfjxsHmEj1YDFtJIiTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeitddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdljedtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddt
    tddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepvdefkeetuddufeeigedtheefffekuedukeehudffudfffffg
    geeitdetgfdvhfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:JN1jZewhFNYrH3CWZo3e6cDOkL-r3TE0Y62hP4FPt5KiaEMaV6VPhg>
    <xmx:JN1jZdQ94GZwV7HD3rNVtmbhQWKh6EvZgaR4qqWYMnrJSZSSakv0Aw>
    <xmx:JN1jZZZnXZ1yJmMlvYfD_FqJhTP2Fpd4oOmFJLWNmdMHC0IjITNloA>
    <xmx:Jd1jZeSaCF8iY51kKfXZA8wE1Q39ayvlE32l--qTjttdD6eITauZIA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Nov 2023 19:04:50 -0500 (EST)
Date: Sun, 26 Nov 2023 18:04:49 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, 
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
Message-ID: <uc5fv3keghefszuvono7aclgtjtgjnnia3i54ynejmyrs42ser@bwdpq5gmuvub>
References: <cover.1700676682.git.dxu@dxuuu.xyz>
 <391d524c496acc97a8801d8bea80976f58485810.1700676682.git.dxu@dxuuu.xyz>
 <0f210cef-c6e9-41c1-9ba8-225f046435e5@linux.dev>
 <CAADnVQ+sEsUyNYPeZyOf2PcCnxOvOqw4bUuAuMofCU14szTGvg@mail.gmail.com>
 <3ec6c068-7f95-419a-a0ae-a901f95e4838@linux.dev>
 <18e43cdf65e7ba0d8f6912364fbc5b08a6928b35.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18e43cdf65e7ba0d8f6912364fbc5b08a6928b35.camel@gmail.com>

Hi,

On Sun, Nov 26, 2023 at 10:14:21PM +0200, Eduard Zingerman wrote:
> On Sat, 2023-11-25 at 20:22 -0800, Yonghong Song wrote:
> [...]
> > --- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > +++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > @@ -6,7 +6,10 @@
> >    * modify it under the terms of version 2 of the GNU General Public
> >    * License as published by the Free Software Foundation.
> >    */
> > -#define BPF_NO_PRESERVE_ACCESS_INDEX
> > +#if __has_attribute(preserve_static_offset)
> > +struct __attribute__((preserve_static_offset)) erspan_md2;
> > +struct __attribute__((preserve_static_offset)) erspan_metadata;
> > +#endif
> >   #include "vmlinux.h"
> [...]
> >   int bpf_skb_get_fou_encap(struct __sk_buff *skb_ctx,
> > @@ -174,9 +177,13 @@ int erspan_set_tunnel(struct __sk_buff *skb)
> >          __u8 hwid = 7;
> >   
> >          md.version = 2;
> > +#if __has_attribute(preserve_static_offset)
> >          md.u.md2.dir = direction;
> >          md.u.md2.hwid = hwid & 0xf;
> >          md.u.md2.hwid_upper = (hwid >> 4) & 0x3;
> > +#else
> > +       /* Change bit-field store to byte(s)-level stores. */
> > +#endif
> >   #endif
> >   
> >          ret = bpf_skb_set_tunnel_opt(skb, &md, sizeof(md));
> > 
> > ====
> > 
> > Eduard, could you double check whether this is a valid use case
> > to solve this kind of issue with preserve_static_offset attribute?
> 
> Tbh I'm not sure. This test passes with preserve_static_offset
> because it suppresses preserve_access_index. In general clang
> translates bitfield access to a set of IR statements like:
> 
>   C:
>     struct foo {
>       unsigned _;
>       unsigned a:1;
>       ...
>     };
>     ... foo->a ...
> 
>   IR:
>     %a = getelementptr inbounds %struct.foo, ptr %0, i32 0, i32 1
>     %bf.load = load i8, ptr %a, align 4
>     %bf.clear = and i8 %bf.load, 1
>     %bf.cast = zext i8 %bf.clear to i32
> 
> With preserve_static_offset the getelementptr+load are replaced by a
> single statement which is preserved as-is till code generation,
> thus load with align 4 is preserved.
> 
> On the other hand, I'm not sure that clang guarantees that load or
> stores used for bitfield access would be always aligned according to
> verifier expectations.
> 
> I think we should check if there are some clang knobs that prevent
> generation of unaligned memory access. I'll take a look.

Is there a reason to prefer fixing in compiler? I'm not opposed to it,
but the downside to compiler fix is it takes years to propagate and
sprinkles ifdefs into the code.

Would it be possible to have an analogue of BPF_CORE_READ_BITFIELD()?

Thanks,
Daniel

