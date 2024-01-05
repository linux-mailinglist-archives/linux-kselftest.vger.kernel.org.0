Return-Path: <linux-kselftest+bounces-2648-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF93824D0A
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 03:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DA97B242F6
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 02:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6161FD7;
	Fri,  5 Jan 2024 02:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="VXwCp7hq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="87Glr2Ll"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAE420F4;
	Fri,  5 Jan 2024 02:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailnew.west.internal (Postfix) with ESMTP id 4A5472B00474;
	Thu,  4 Jan 2024 21:38:06 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 04 Jan 2024 21:38:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1704422285; x=1704429485; bh=hhJPu3tNnq
	xckGttQAIaSboNHKCsm1A0qRCYF/TLTLQ=; b=VXwCp7hqAkbSThJHwvaHtcMONK
	k7Zbx7LQStUYGpDYxVIB7DZziK1R9H6eFLqamhAL6NMmIB5rjxStP+zT1uOEtTtm
	lmO+B5RHcvSzLAitr6mr5EhvAJywcsfelYp2Qr6K4D5wFRk/ytVbNEnOVrl9zgvS
	ui/sPUhKvEY1QlqoOGMeyBz3tuGHLgCQXDRk64IxQ8Vn4/KAawqNmMJHJ2luEhIy
	5JswRkn6uaLha9Op5HoMyrdCUnk6FzVvOCkgFY0d6FnZlVz3Ebuoo//NqYeRiVlA
	h1vxMqOpxe2CKRoSMm1YUyko8tBwsegNiNcR7c4ujYDom3eBhbbyiVf2Sd+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704422285; x=1704429485; bh=hhJPu3tNnqxckGttQAIaSboNHKCs
	m1A0qRCYF/TLTLQ=; b=87Glr2LldJEIX+FphDwBcyLF9pjPSXtkxx2DELFxgZ9h
	Kv+Yan/y1ssDandSsWJhDewJg36Xk4MsIpgLXd08Jm6JnCQyzHTx88OUL3zSOLz/
	LmNlJP/2ZqfNmMghYmQuW4tNgvEBjovd5KBdzBbZFPwiEEAAj+j/EkwXtyYyWzC9
	tmdrcl9bxFK3+sCI4dplPF23HP5T0QT7ZgRmlLVj5s4Iwnepo9rIolQ83zx7zvUE
	ptVABJbSyD+Br1QWQGQ9m3ztgWnpIpodF1T8TUBya+GhYMIGAJ8WmWmqxNrteng1
	WuAKri1h6nqVKWdvw7Ma0M4j0bH4ZfwZnNu8kDKH7w==
X-ME-Sender: <xms:i2uXZQGRqmDUp5xjuBcrMlr4pnlYSVV6jRx37GkJ1Fn4F0KXQXIIcg>
    <xme:i2uXZZW_yDlVJwqUvAueDKMdSYO3ODzWJmdtp2wCiVwSmHf-RuklamuE6KSilR-kM
    nWYJ5VEtwjr2XVyZA>
X-ME-Received: <xmr:i2uXZaLIVcHJYxsG-JJ9HTTQwKGNJvaVHF2HF-0dHSP1AwmhQlQV9kzSMNrO1I1Iq5-xOnt4rENH_83giA-xVGLzvXAUXRZ6nQ8VFZU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdegkedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdljedtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddt
    tddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepvdefkeetuddufeeigedtheefffekuedukeehudffudfffffg
    geeitdetgfdvhfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:i2uXZSFlAxpevVOLGhgMtHzxLXFOOUvIH8Mmq-SLR2_Jbs6qBiUvAg>
    <xmx:i2uXZWV5_TQEuLzdkEq6lGBqjqe6rs979NfZ5R4AQZ_nj9z0j2ocxw>
    <xmx:i2uXZVMKAEvxYx8O1pdzsLA1g6wyYTZXAzmuoGkiX6AjVoXnq4DVOA>
    <xmx:jWuXZR9gwCbaAGWYBSuJd5u7AFKUS3CCeYfxty9rRcyPhRDYua0qfJuNwnA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jan 2024 21:38:00 -0500 (EST)
Date: Thu, 4 Jan 2024 19:37:58 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: benjamin.tissoires@redhat.com, hawk@kernel.org, edumazet@google.com,
 	alexandre.torgue@foss.st.com, ebiggers@kernel.org, tj@kernel.org,
 rostedt@goodmis.org, 	shuah@kernel.org, martin.lau@linux.dev,
 ast@kernel.org, fw@strlen.de, 	kuba@kernel.org, pablo@netfilter.org,
 jikos@kernel.org, john.fastabend@gmail.com, 	mcoquelin.stm32@gmail.com,
 mhiramat@kernel.org, yonghong.song@linux.dev,
 	Herbert Xu <herbert@gondor.apana.org.au>, dsahern@kernel.org,
 hannes@cmpxchg.org, lizefan.x@bytedance.com, 	pabeni@redhat.com,
 steffen.klassert@secunet.com, daniel@iogearbox.net, 	tytso@mit.edu,
 andrii@kernel.org, davem@davemloft.net, kadlec@netfilter.org,
 	song@kernel.org, alexei.starovoitov@gmail.com, quentin@isovalent.com,
 	alan.maguire@oracle.com, memxor@gmail.com, kpsingh@kernel.org,
 sdf@google.com, 	haoluo@google.com, mathieu.desnoyers@efficios.com,
 mykolal@fb.com, 	linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, fsverity@lists.linux.dev,
 	bpf@vger.kernel.org, cgroups@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, 	netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 	linux-kselftest@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH bpf-next 2/2] bpf: treewide: Annotate BPF kfuncs in BTF
Message-ID: <kblwkuzcblwogxqjv6vgkwat3wuwpopdmk25smlbz3nho7qhes@2dfdponsqxwo>
References: <cover.1704324602.git.dxu@dxuuu.xyz>
 <68d5598e5708dfe3370406cd5c946565ca4b50f1.1704324602.git.dxu@dxuuu.xyz>
 <ZZaZf_8RuX2xqZGf@krava>
 <bix2uwya2mnk2vgno3vkdpg5kyusq763bmfj2ov6zwpbva6q4h@nqgm3vk4byh5>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bix2uwya2mnk2vgno3vkdpg5kyusq763bmfj2ov6zwpbva6q4h@nqgm3vk4byh5>

On Thu, Jan 04, 2024 at 06:17:50PM -0700, Daniel Xu wrote:
[...]
> > 
> > also given that we can have modules calling register_btf_kfunc_id_set,
> > should we just return error instead of the warn?
> 
> It looks like quite a few registrations go through late_initcall(),
> in which error codes are thrown away. I'm looking at
> init/main.c:do_initcall_level:
> 
>         for (fn = initcall_levels[level]; fn < initcall_levels[level+1]; fn++)
>                 do_one_initcall(initcall_from_entry(fn));
> 
> Higher level question: if out of tree module does not follow convention,
> it would still make sense to WARN(), right?

Ah, I got what you meant now. I'd say returning error makes sense but
WARN() is also useful. I'll send v2 with both.

[...]

