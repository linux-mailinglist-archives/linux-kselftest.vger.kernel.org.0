Return-Path: <linux-kselftest+bounces-598-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F03707F8550
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 21:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2761A1C25ED1
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 20:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C7F3A8CB;
	Fri, 24 Nov 2023 20:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="TJo54wDK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bi9AtZKV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF0619A3;
	Fri, 24 Nov 2023 12:59:31 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailnew.nyi.internal (Postfix) with ESMTP id 7313958049F;
	Fri, 24 Nov 2023 15:59:27 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 24 Nov 2023 15:59:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm3; t=
	1700859567; x=1700866767; bh=LUc6+oAUXdxf0gLuIlkH0gh0571S4Y/6Cb0
	mYTuCEC4=; b=TJo54wDKCgMuWkoE9drzZDiVLRQhY/GJRZQbHp7h+tibivPtYdz
	aoy+dD/iB6VH/tHq1lkDZSyBeUiPUKnU+CPUBLH9oDL4UiuE6hzBkHgZdpTaAyMD
	vGDocwfPKyrAxwD4arpe2BagHsS4TfP6SchUmq7QzlC0tl9WV6mhq4DbdDSaJCkG
	DiZRzg+Grk2oWd3veN4MrIlJxOdoTv80OKIq9dyWH6G+POItZfygpmv6Hde5rox+
	VRCqRKdHztbDx/R3ACq9XqwpDs3mJqjXeVXTQV0qz2ku+2/FxPr2IdVbKLyeWSXT
	z2sPjzPCWFWfQyjSK3eu992T16Pw5NYvfrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1700859567; x=1700866767; bh=LUc6+oAUXdxf0gLuIlkH0gh0571S4Y/6Cb0
	mYTuCEC4=; b=Bi9AtZKVEzB6ILE28gGs0V2BjploLrLFm4vL9yieiaAbuReoHKj
	S60zq3BxmqGOrsPP16zHlbzesBhzij7oshzaUNJtfr8XyXKD7Y/f2gmFQnb1AXiu
	9yrNXo063xCLmAJehlT5JPFAc6fWKVUQ3DzZcnEinVvimSEOWM5/r08H43JKgk7b
	tkKSbPHpzmOW7YzvYqwQeYXXntHkpV7cMBehqn2I9KbyZK+enTbdOy4mnTlSfkiC
	KE2fcCPj8cU+u4o6qVzO2LKoIYF4nPxii4WlldEPSRHxAAy7Ly8EArEnUf0LO8jr
	VGHpemmpxDrV/SevjcIIHWH6+TnbVtMJmBg==
X-ME-Sender: <xms:rg5hZWcjngq0PBJ4Yt3DFGUS9mKKrFvQ303LZs4GmU1rdAtZJN3lTg>
    <xme:rg5hZQO5DdaBzcgYbUGXxPSRLUxCdh55A2W2lv9ITgz-joW-u7JXZaw49hWbn3muY
    jbX95IOBlzKyjt3EA>
X-ME-Received: <xmr:rg5hZXjQNJgd0YWEGzNMF92LA72-QPYKp2622RdnvCTjTsQtmF25A1O7OJl6Mv_cHrWUIM8XkOmGmx3seIC6N2roMDcwXiZxmuVx1-51lNdk_015rndatAEDw1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehhedgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdejtddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkefs
    tddttdejnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihii
    eqnecuggftrfgrthhtvghrnheptdfgueeuueekieekgfeiueekffelteekkeekgeegffev
    tddvjeeuheeuueelfeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:rg5hZT__S8VmppWZ-1-GJdLAUH0xp8oh4ZwiDoj9JUI2-36UilZY2w>
    <xmx:rg5hZSsMBnUp1nRxqwPpVc2fNRielAXeqic28Nl-pai_BQD8lJuvWg>
    <xmx:rg5hZaFsDEW49cZxHhwMqUFl5AZKUrSxHjmv5j-MR6jvRFD3dAdmSA>
    <xmx:rw5hZSf9w0z44a0z6VFmEW3z8LJC7RQyr-7597RGS6OlXcFCDjuG1A>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Nov 2023 15:59:25 -0500 (EST)
Date: Fri, 24 Nov 2023 13:59:24 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	antony.antony@secunet.com, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, devel@linux-ipsec.org
Subject: Re: [PATCH ipsec-next v1 7/7] bpf: xfrm: Add selftest for
 bpf_xdp_get_xfrm_state()
Message-ID: <rsj2usphrnghq3gnwkbho7rek7ffbgyur4kjuakpfxwu7zqpzw@cj3rmd4gupxq>
References: <cover.1700676682.git.dxu@dxuuu.xyz>
 <84111ba0ea652a7013df520c151d40d400401e9c.1700676682.git.dxu@dxuuu.xyz>
 <CAADnVQKg7-T_g7CFRs62ZDFyR9z=FTxfyXyTe=3_ojGpnvxJ4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKg7-T_g7CFRs62ZDFyR9z=FTxfyXyTe=3_ojGpnvxJ4w@mail.gmail.com>

Hi Alexei,

On Wed, Nov 22, 2023 at 03:28:16PM -0800, Alexei Starovoitov wrote:
> On Wed, Nov 22, 2023 at 10:21 AM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > +
> > +       bpf_printk("replay-window %d\n", x->replay_esn->replay_window);
> 
> Pls no printk in tests. Find a different way to validate.

Ack. I'll migrate the ipsec tunnel tests to test_progs next rev so it
can use mmaped globals.

Thanks,
Daniel

