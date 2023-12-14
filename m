Return-Path: <linux-kselftest+bounces-1883-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A79C58123D2
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 01:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C65051C2120F
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 00:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B785837E;
	Thu, 14 Dec 2023 00:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="F4z/6gY1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1HSeLWX0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD37C9;
	Wed, 13 Dec 2023 16:20:54 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailnew.west.internal (Postfix) with ESMTP id 432AF2B002DA;
	Wed, 13 Dec 2023 19:20:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 13 Dec 2023 19:20:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1702513250; x=1702520450; bh=A2PcotebGi
	6VLDzZX2wIz+tqypyvwDgsO7u1srRyogw=; b=F4z/6gY1J9/DjQJZ7WzBgfQnIA
	3MxGdMgA616hpbu0+SvnCeTWya4Zz4ABDxjPuGA348CeMWn3tizJeMP0g2YT4E8U
	IG9eSOIv64q1G2/5J+NPhJ2An8U6JkBmyY7jEQ24t8DMUgifv+0Bm8eshDY8DnK5
	+FCq1KE0REluiG66OMb+r1BwQw33/mUIgH7Ub54SnOmFft2mbgROQPJedS/A6JDP
	jl6B0e2Cgxlek37mhPyOLaojcR/n78w4hH5ZyvcFqCROYDXnTsCP2w7n1jQjsHAf
	88ACr0HEQ/uNFeBIEidk60dg5hY51b7+YBEFvtZZBKRmVYxGHy95fLym0hVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1702513250; x=1702520450; bh=A2PcotebGi6VLDzZX2wIz+tqypyv
	wDgsO7u1srRyogw=; b=1HSeLWX04KCZqIHUNG/EtE3SvGqz5naqjcSTia60LrpB
	Cw1pLt2We4hWHq2zVCLiFQ15gEj78aA+A6xgo70QxmOxQzh693g5ww2c6cT3eNST
	FRgUpr/iSi2zVeuQSIheqknxIcKf8sXmJy3XBwqmLsFaH8AlW0Z6WrltTNgNGq1Q
	LLGya9K1mhYsVe7NcTsyB4NGJRL/ZbK+M4XfQoEzIjNNbyGeMD+174xmoV81vCt3
	rO2u0OmK0qu6yWw0wiwQJYuwqCcjIQ0EGOH/PhUH63YtIK1q6+LmRVpxtD1oshVY
	ov2FyVnMomU7Z/HuSrKUpj6pVYqMRyff8BIhHFvYlA==
X-ME-Sender: <xms:Ykp6ZabkOkPkyq-ckjqIqVkuHIUdLMQAWG8qVxRRBiQZ3fenNBOy2w>
    <xme:Ykp6Zdaafo5szGuzYflYYFhUZXokE_EmECJOSXfWSewhWijmwXQAxCTp6KkgF_O-j
    YB1sWGqhqq8Ll6FmA>
X-ME-Received: <xmr:Ykp6ZU-JrLPO2pGTunjSWbCxphBNoQtzh63iBa51YfeFpG6lrZ8csIIeMiM1U51d3hxNmCn0aRBtVwRO0ASQB74Vegx9gn8buWwF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelkedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddt
    tddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepgfelteeuteekgeeikeehtefhffelteekieeigfeuffehvdev
    ieetheekffegudevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdig
    hiii
X-ME-Proxy: <xmx:Ykp6Zcrcit-uNyfYtl8VniKKaDk_5H1JP-tJhdxfUiv4ON1f3Ivdkw>
    <xmx:Ykp6ZVpC-eITjFHKVxLTuvxMKk9dv4VVcF-yGp1WkUmTbCMk1EyhOw>
    <xmx:Ykp6ZaS4nE2_OIhtOZkhp7Bu0_N3m1hM4loh4S3_blq_wX83ILwnjA>
    <xmx:Ykp6Zc6tx-p830khytyhDdSWCcgbQo-KjUrAnuH7aT276yb0q72vDxLJdOM>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Dec 2023 19:20:48 -0500 (EST)
Date: Wed, 13 Dec 2023 17:20:47 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: mykolal@fb.com, song@kernel.org, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	devel@linux-ipsec.org, netdev@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	shuah@kernel.org, daniel@iogearbox.net, steffen.klassert@secunet.com, 
	antony.antony@secunet.com, alexei.starovoitov@gmail.com, yonghong.song@linux.dev, 
	eddyz87@gmail.com, eyal.birger@gmail.com, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>
Subject: Re: [PATCH bpf-next v5 5/9] bpf: selftests: Add verifier tests for
 CO-RE bitfield writes
Message-ID: <qydvklkwevtrqhz5vyy2gwvdxc55hupvgan4l7nzoteo3cfudm@cr52rpydfzm4>
References: <cover.1702325874.git.dxu@dxuuu.xyz>
 <72698a1080fa565f541d5654705255984ea2a029.1702325874.git.dxu@dxuuu.xyz>
 <85bb2e79-5b1a-41c1-972f-9f7f185fac88@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85bb2e79-5b1a-41c1-972f-9f7f185fac88@linux.dev>

On Wed, Dec 13, 2023 at 03:58:39PM -0800, Martin KaFai Lau wrote:
> On 12/11/23 12:20 PM, Daniel Xu wrote:
> > Add some tests that exercise BPF_CORE_WRITE_BITFIELD() macro. Since some
> > non-trivial bit fiddling is going on, make sure various edge cases (such
> > as adjacent bitfields and bitfields at the edge of structs) are
> > exercised.
> 
> Hi DanielXu, I have pushed the libbpf changes (adding
> BPF_CORE_WRITE_BITFIELD) and verifier test in patch 3-5 which is useful by
> itself. e.g. Another patchset can start using it also:
> https://lore.kernel.org/bpf/8fccb066-6d17-4fa8-ba67-287042046ea4@linux.dev/
> 
> Thanks.

Sounds good. I'll rebase my patchset on top of bpf-next.

Thanks,
Daniel

