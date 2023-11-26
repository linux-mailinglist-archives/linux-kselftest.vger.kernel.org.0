Return-Path: <linux-kselftest+bounces-613-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AB87F9145
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Nov 2023 05:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F0181C209CB
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Nov 2023 04:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B90CEC2;
	Sun, 26 Nov 2023 04:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="DGUMPjvK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X/2xbBLc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786E510D;
	Sat, 25 Nov 2023 20:34:34 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailnew.nyi.internal (Postfix) with ESMTP id 2FA34580892;
	Sat, 25 Nov 2023 23:34:31 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 25 Nov 2023 23:34:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1700973271; x=1700980471; bh=nt
	RXoWRJb4uUGlWmDeWV4tv5+SsfDee3WWNlUl0hNCM=; b=DGUMPjvKnI7cJfCzZA
	wavOFcmQvrABWS14qboN+2+WyqDTo0d5tsIqtxw7HerR7dr07UYAMtHdfszL6UsX
	8Jl2wAXaD8ZNqTooBHQfHJA7ivMb/6LP3/EVwn8MzH/Rzdkaj+NUn+dPogdYqGYb
	2Up2+DWm6L0Z8Hy88qUPqGUDoEaPc2XpsN/ivnZO6H6f7tQ0xqZlFb3YW3+5aoOq
	oAQqTe/6va+A5LE+mhav1RoENWzACKenhTC74Sic9vzwO8+WXK3/Thh3CAvY3aFX
	9UZPsBLHO4or6xcfVVb5lSwtv93SlePWb4bkrAEr5Bv1fhpsKXiGHJhSVhpXn04J
	Po1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1700973271; x=1700980471; bh=ntRXoWRJb4uUG
	lWmDeWV4tv5+SsfDee3WWNlUl0hNCM=; b=X/2xbBLcKl45j7AHiUzN//xsKfI2w
	V74vQeN9TnSyfpV3+0QNswby9mtcxq3qXf+H4TUdRnF0polbKjfR66tyN2v/Hjos
	M4OiQr5KptrmxuNPnXQAF1ZGtNVoOV+D5KwwklF5pIeTPP8OmRUNt9jHhkEob7TI
	G5/o+uRKGBOzXsBJSWZTCqK+OMVoZ9Lm/xPTfJd4mppliEFpiDwTD9RZNdVkc6A6
	6adjHi/mgZ7KJoBmhWYrlp0sZxr/0jaAAajwQxc07d0n6PVnrPuc1gIvhJ7bxR8m
	Ovko2P1vExblqKzMOvEX48m6tgd5FMNJHISBAN4epXZA/PH5i7lsbisfw==
X-ME-Sender: <xms:1spiZZ6qZxO8zIpyRWjyWei2hmWHxI4lW2hgbRj4C_JGrOl8X9MZbQ>
    <xme:1spiZW61C_wbtfuW_ORqQck0SNFlXLPDSn7fFRh0iCKCXwva8-31YW2q3RYxgj1cl
    ZpFeYiVf657__6Fmw>
X-ME-Received: <xmr:1spiZQdsxXKcvxKdkp0BGJ00BAJ79wIH9yGlldDrw-gtLSeRM9WKWu_yzgnj2z91QZFchW37hRQCNvE3vMWO_RTHg2iprf8TEVYS5cnY9BcJylDl25bhDA6g7_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehkedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddt
    tddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepvdefkeetuddufeeigedtheefffekuedukeehudffudfffffg
    geeitdetgfdvhfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:1spiZSK1dCq9SZtCGns5zlZXiW87j6LeWakZ-g4pHtG4M1wWnOFujQ>
    <xmx:1spiZdJvCaJr22eazr9EzXM7nesMnt-SRl5W2doqtAtSgqfYr8KoTA>
    <xmx:1spiZbzk-SplHBHW8d0Tq65EbuNBZuN6V9l405xTJVGVlABmUZn41w>
    <xmx:18piZV9DCv0VkxPOPViftn1rNfjgZh1Y97QVRf5qAGOb8BR74FY9ew>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Nov 2023 23:34:29 -0500 (EST)
Date: Sat, 25 Nov 2023 22:34:28 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: shuah@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	ast@kernel.org, steffen.klassert@secunet.com, antony.antony@secunet.com, 
	alexei.starovoitov@gmail.com, mykolal@fb.com, martin.lau@linux.dev, song@kernel.org, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com, 
	jolsa@kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devel@linux-ipsec.org, netdev@vger.kernel.org
Subject: Re: [PATCH ipsec-next v1 5/7] bpf: selftests: test_tunnel: Use
 vmlinux.h declarations
Message-ID: <a6npfmowxzvzgs77zitwlhumpfwkvopbzbf3scwlgxfn5j2xcg@b6orczqbftvf>
References: <cover.1700676682.git.dxu@dxuuu.xyz>
 <c5f6a6686e1472e17014f5d015c8dacade9f053e.1700676682.git.dxu@dxuuu.xyz>
 <eb34b5e0-caf0-472a-99fa-77b43cfce56e@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb34b5e0-caf0-472a-99fa-77b43cfce56e@linux.dev>

Hi Yonghong,

On Sat, Nov 25, 2023 at 04:34:36PM -0800, Yonghong Song wrote:
> 
> On 11/22/23 1:20 PM, Daniel Xu wrote:
> > vmlinux.h declarations are more ergnomic, especially when working with
> > kfuncs. The uapi headers are often incomplete for kfunc definitions.
> > 
> > Co-developed-by: Antony Antony <antony.antony@secunet.com>
> > Signed-off-by: Antony Antony <antony.antony@secunet.com>
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > ---
> >   .../selftests/bpf/progs/bpf_tracing_net.h     |  1 +
> >   .../selftests/bpf/progs/test_tunnel_kern.c    | 48 ++++---------------
> >   2 files changed, 9 insertions(+), 40 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
> > index 0b793a102791..1bdc680b0e0e 100644
> > --- a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
> > +++ b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
> > @@ -26,6 +26,7 @@
> >   #define IPV6_AUTOFLOWLABEL	70
> >   #define TC_ACT_UNSPEC		(-1)
> > +#define TC_ACT_OK		0
> >   #define TC_ACT_SHOT		2
> >   #define SOL_TCP			6
> > diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > index f66af753bbbb..3065a716544d 100644
> > --- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > +++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
> > @@ -6,62 +6,30 @@
> >    * modify it under the terms of version 2 of the GNU General Public
> >    * License as published by the Free Software Foundation.
> >    */
> > -#include <stddef.h>
> > -#include <string.h>
> > -#include <arpa/inet.h>
> > -#include <linux/bpf.h>
> > -#include <linux/if_ether.h>
> > -#include <linux/if_packet.h>
> > -#include <linux/if_tunnel.h>
> > -#include <linux/ip.h>
> > -#include <linux/ipv6.h>
> > -#include <linux/icmp.h>
> > -#include <linux/types.h>
> > -#include <linux/socket.h>
> > -#include <linux/pkt_cls.h>
> > -#include <linux/erspan.h>
> > -#include <linux/udp.h>
> > +#include "vmlinux.h"
> >   #include <bpf/bpf_helpers.h>
> >   #include <bpf/bpf_endian.h>
> > +#include "bpf_kfuncs.h"
> > +#include "bpf_tracing_net.h"
> >   #define log_err(__ret) bpf_printk("ERROR line:%d ret:%d\n", __LINE__, __ret)
> > -#define VXLAN_UDP_PORT 4789
> > +#define VXLAN_UDP_PORT		4789
> > +#define ETH_P_IP		0x0800
> > +#define PACKET_HOST		0
> > +#define TUNNEL_CSUM		bpf_htons(0x01)
> > +#define TUNNEL_KEY		bpf_htons(0x04)
> >   /* Only IPv4 address assigned to veth1.
> >    * 172.16.1.200
> >    */
> >   #define ASSIGNED_ADDR_VETH1 0xac1001c8
> > -struct geneve_opt {
> > -	__be16	opt_class;
> > -	__u8	type;
> > -	__u8	length:5;
> > -	__u8	r3:1;
> > -	__u8	r2:1;
> > -	__u8	r1:1;
> > -	__u8	opt_data[8]; /* hard-coded to 8 byte */
> > -};
> > -
> >   struct vxlanhdr {
> >   	__be32 vx_flags;
> >   	__be32 vx_vni;
> >   } __attribute__((packed));
> 
> In my particular setup, I have struct vxlanhdr defined in vmlinux.h so
> I hit a compilation failure.

Yeah, saw the same error in CI (the emails are nice btw). Looks like
vxlanhdr isn't even being used in this selftest. I've deleted it for v2.

Thanks,
Daniel

