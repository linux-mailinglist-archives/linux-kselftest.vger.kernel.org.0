Return-Path: <linux-kselftest+bounces-1697-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5607380F5EF
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 20:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D67291F216D3
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Dec 2023 19:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA34080048;
	Tue, 12 Dec 2023 19:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="fJWcEKim";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cbVgQ2bD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA647F5;
	Tue, 12 Dec 2023 11:00:19 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailnew.west.internal (Postfix) with ESMTP id DC7D12B00324;
	Tue, 12 Dec 2023 14:00:16 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 12 Dec 2023 14:00:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1702407616;
	 x=1702414816; bh=mkQgKltTP5G+DPU34il+RvyvNIX4AiTMdSuv1wgyTCs=; b=
	fJWcEKimbASXhvV2Y/u0MJ78svo+WEkATOLi4dOjMTJl34I+28RO6i2vxF8vBxXh
	jsbmdZ4CZZ3oJ0xuCFVmtmz0iN6NZN490VBweoWK0dziivbpcE0EtUMAeEIciL/R
	+D+IlrTyEMR032DiKExWbeQLGl0EHepFzcM9oN/2/ylsF8jJc6Pev2gO1ky9dcWu
	ECeZJ1ERoohvZvfHjllChUutXddvQlzoGvGUGkTHZPhpBQNlMVNxiVb9F51l4EVl
	xpmyxS4Ve70UewVgveHc5z95UkFMU7l7BXAxJXvH2MkCGbWlYVI423oPKYmwb5MW
	3ojHrD+5mip5w6kwCQ4FOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1702407616; x=
	1702414816; bh=mkQgKltTP5G+DPU34il+RvyvNIX4AiTMdSuv1wgyTCs=; b=c
	bVgQ2bDrismRt/s9rEJ7L8njdhlUd9ehE9q2nUNlkqM5tU0Zdb28XirF+GNNFJgK
	QGD6CAdH4+xkV+I2dGTf6x1mnzvFqB8eCvv3nw30VMPppuU1SlTqvzcpBpWQC+RV
	rtN+rqLwlhFtmAF69aVziglCNyeSmhNjq8w8jPiHu7c6a0zwJSymjnxekk97tOd5
	1ry6hUEkPvJ6//Fxbvjl9ne61C4CL6pzlahAnbAGJ6k/rvR/HP4/YJvN+TgMwGN0
	XU2PeD7N46LosjFryxWsg4qkwDIfnxMGZbGttHLHA2wuRmHBqAf561NeXE5z3LLD
	jTX/JrIU85031qi8sBtQA==
X-ME-Sender: <xms:v614ZdNfI9-uA0PK0QDYer2BsPagbyWLZCLz-v2dCoFjaA2F_-kHYA>
    <xme:v614Zf96oWJysoaTeYx3VOho0uu_GXGvTdUiKCg6hUg1c_NRjRx60kKgG3xKXVuor
    B7vXwkNK1NZnJUhKQ>
X-ME-Received: <xmr:v614ZcTQto9pOgbB7OCKQqX68JRxvTP1wQAkxjjEZgeN09Sj-U_PjPe-QiTlTq83lRqWQ4mNryKm7on5Y-FsdtiWsuAOygvqn5Cd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelgedguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdejtddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkefs
    tddttdejnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihii
    eqnecuggftrfgrthhtvghrnheptdfgueeuueekieekgfeiueekffelteekkeekgeegffev
    tddvjeeuheeuueelfeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:v614ZZtn-iEtijrnnfd_gIrwezZGZLhKx2rX_xMDQZJme2y_5j0sxQ>
    <xmx:v614ZVcj25nt5Bc0ewmlh-SqrlLvJuSRuPVIXROMiUuMHGU_J-2evg>
    <xmx:v614ZV3SKOsS48sIkeGi0PTU1DkrmTd1ab3KcGdPw9tOTPey6q-TOA>
    <xmx:wK14Zetkyeho1ahXdowo8kPL8mJXZyr8HfYclHZYOVWMJv1dO0NaKiku2s0>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Dec 2023 14:00:13 -0500 (EST)
Date: Tue, 12 Dec 2023 12:00:12 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eyal Birger <eyal.birger@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Steffen Klassert <steffen.klassert@secunet.com>, antony.antony@secunet.com, 
	Yonghong Song <yonghong.song@linux.dev>, Eddy Z <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, devel@linux-ipsec.org
Subject: Re: [PATCH bpf-next v5 9/9] bpf: xfrm: Add selftest for
 bpf_xdp_get_xfrm_state()
Message-ID: <kj5zxyxf3edmz3uyjanxukdiysagu5f6mkneq64yyqgfzp4lsd@7glieqovplgd>
References: <cover.1702325874.git.dxu@dxuuu.xyz>
 <8ec1b885d2e13fcd20944cce9edc0340d993d044.1702325874.git.dxu@dxuuu.xyz>
 <CAHsH6GsdqBN638uqUm+8QkP1_45coucSTL7o=D2wFW-gYjPaBw@mail.gmail.com>
 <7yjkfhrwdphtcljq3odv4jc6lucd32wcg277hfsf4ve2jbo7hp@vuqzwbq5nxjw>
 <CAHsH6Gs1vUQnhR_a4qFnAF37Vx=68Do28sfVfFxQ9pVj9jSzjw@mail.gmail.com>
 <qiv464c4y43mo5rih5k6lgzkbpnj6wsrl52hrhgbxeqj45atun@szmqlmnccm52>
 <CAHsH6Gujycb9RBuRk7QHorLe0Q=Np_tb3uboQfp9KmJnegVXvw@mail.gmail.com>
 <fwadmdjjogp4ybfxfpwovnmnn36jigffopijsuqt4ly4vxqghm@ysqhd25mzylp>
 <CAADnVQKpXpqMr9jmc8RKLcL822ir0wA7bEN2h6dEo=6Y60qgWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKpXpqMr9jmc8RKLcL822ir0wA7bEN2h6dEo=6Y60qgWQ@mail.gmail.com>

On Tue, Dec 12, 2023 at 08:44:42AM -0800, Alexei Starovoitov wrote:
> On Tue, Dec 12, 2023 at 8:17 AM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> >
> > If you don't mind (and there no more comments), I would prefer to send a
> > follow up fixing the nits in this revision. So that I stop blasting the
> > list (as well as people who may not be as concerned with these details).
> 
> Resending patches is little effort while follow up patches
> double the commits, more code churn, increase in code reviews, etc.
> Always address feedback by resending.

Got it; will keep that in mind.

Thanks,
Daniel

