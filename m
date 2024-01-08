Return-Path: <linux-kselftest+bounces-2720-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAD08276B6
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 18:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5335C282B78
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 17:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546DD54BC3;
	Mon,  8 Jan 2024 17:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="QCuiJ8OT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HW+5pS6p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735C854BF7;
	Mon,  8 Jan 2024 17:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id C2DC53200D00;
	Mon,  8 Jan 2024 12:52:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 08 Jan 2024 12:52:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1704736373;
	 x=1704822773; bh=U5vHpLovxHw2jLbFSMwbVDfMhB5fX3K4zCUa0DIZn9Q=; b=
	QCuiJ8OTr3lnfrzIujxwe/TZfLN1UIxB9lhaB8yim94u+mOcHro7SQ0ObxmjGCj4
	Tb5u0npdf4GTBeVq7Cz2aFXmNa+QaEhiPOPcYSTHw5bxB+WNwzuSL0IBboyPK2jL
	RzROivW2MUr5bdEzhDn/fpTjaPkhuKq7Y2O2FlIsGTSQ9/BiKUju+JyX8yMRXGxy
	4JPkPMqkebAGZ6X5Oy2CJOJRzQ+gue9Cqa/+eZVCp0qB+sAUPlgY+jxbyGXJVYhe
	X8V375V1byyUcuQNDBOBnTK7GBHSMhaLYEUU1U0iaoBJMrNlJHxV6qxUG3wMq5B0
	uH7MPtSQ6xQmfd7oR7iFQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1704736373; x=
	1704822773; bh=U5vHpLovxHw2jLbFSMwbVDfMhB5fX3K4zCUa0DIZn9Q=; b=H
	W+5pS6p8StQO1iOCpRMUGETWwegLC/itEkr0WC7HcpACh+OG0OM0TAGa2hkvGwaP
	5qvYy2mXuiO0tnh4P2u0crfFK96diRxzgDdqyWzqT/FYexQukTZ6mnUCLxYEbIIM
	4VlhkzufmFARICF16ChUFz/yOoBP+iZekdv0UswKOkpjR6BNq5VapPZOg1q2qT/C
	5PveKLQu44B16jB0rftks3B649wadrnfVLj2ZAxOpu0DO54vzbm8rXKi4m1mMfQ9
	/eYc+hn5aySPRTAK8Hg9gCA/LLAcGWZE7njvQ556WjGBHBu6qQhslWNzlDUkyO8K
	iQsL/YuJcDENA1Msf1eVA==
X-ME-Sender: <xms:dDacZcuDTXN6lIEB8WcOO16Pq_Tb_ovk8QZo9ds7l0Lpb-hT7fKQlg>
    <xme:dDacZZebg42EFk_Dte7vA-bggeXbFkekpX81XBWPhF---MbikwU4NEQAq_cbaMZyt
    GDLFMocQhEF5-vUZA>
X-ME-Received: <xmr:dDacZXxBZ9cQLWYl6jdfdcpCufgtDH1LcuUb3pmhHdXoOlL94QlkfynIuxozVxZlTsp7KYObYheOxk2Q_1uOjqeGruABsR5zL19sbLc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehjedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdejtddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkefs
    tddttdejnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihii
    eqnecuggftrfgrthhtvghrnheptdfgueeuueekieekgfeiueekffelteekkeekgeegffev
    tddvjeeuheeuueelfeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:dTacZfO1_6ZhFSPZ7zYR_vaSkrh9xyqkFLtjv5fayG8ZpCbkP8Qaxg>
    <xmx:dTacZc-OoIoBjtWs99QJ3JVhf7MeRx8huVlrpOGlzP4IbiCQjrWwAg>
    <xmx:dTacZXVkZfDjbk7VxlH_D6LS-Uq5m97mwmnDhWMv7x4tSBRugNGqbw>
    <xmx:dTacZcOHJTHi1jhIyuq6e13SVSM7x8VZNsMZkqqn0mrcGx9wqqEgzA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jan 2024 12:52:51 -0500 (EST)
Date: Mon, 8 Jan 2024 10:52:49 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Lorenz Bauer <lorenz.bauer@isovalent.com>
Cc: linux-input@vger.kernel.org, coreteam@netfilter.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-trace-kernel@vger.kernel.org, fsverity@lists.linux.dev, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	cgroups@vger.kernel.org, alexei.starovoitov@gmail.com, olsajiri@gmail.com, 
	quentin@isovalent.com, alan.maguire@oracle.com, memxor@gmail.com
Subject: Re: [PATCH bpf-next v3 0/3] Annotate kfuncs in .BTF_ids section
Message-ID: <6t5bei3t2gwhuycu6ewftrgfuuyfhs26euymkysefqyfabgupa@3od5pe6ajybo>
References: <cover.1704565248.git.dxu@dxuuu.xyz>
 <CAN+4W8gPeQ2OjoYLKXsNPyhSVTB+vcSaS3Xzw=-M9Rf5MXfKPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN+4W8gPeQ2OjoYLKXsNPyhSVTB+vcSaS3Xzw=-M9Rf5MXfKPg@mail.gmail.com>

Hi Lorenz,

On Mon, Jan 08, 2024 at 10:15:45AM +0100, Lorenz Bauer wrote:
> On Sat, Jan 6, 2024 at 7:25 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > === Description ===
> >
> > This is a bpf-treewide change that annotates all kfuncs as such inside
> > .BTF_ids. This annotation eventually allows us to automatically generate
> > kfunc prototypes from bpftool.
> >
> > We store this metadata inside a yet-unused flags field inside struct
> > btf_id_set8 (thanks Kumar!). pahole will be taught where to look.
> 
> This is great, thanks for tackling this. With yout patches we can
> figure out the full set of kfuncs. Is there a way to extend it so that
> we can tell which program context a kfunc can be called from?

I think a potential approach would be to extend BTF_ID_FLAGS() with some
more flags if we want to continue with .BTF_ids parsing technique. But
it has some issues with program-type-less helpers that are associated with
attachpoints as well as struct_ops helpers.

Since it looks like we're in rather early stages of program-type-less
world, maybe it'd be good to defer solving this problem until more use
cases are established and we can find a good cut point to design around.
Even with uapi helpers there was no way before.

Thanks,
Daniel

