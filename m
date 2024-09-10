Return-Path: <linux-kselftest+bounces-17657-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C128397459D
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 00:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83D3E28BF35
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 22:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666DD1AF4EF;
	Tue, 10 Sep 2024 22:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="Vbkopv/Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tBDF6Uy+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8191AED49;
	Tue, 10 Sep 2024 22:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726006614; cv=none; b=LHqUCTiEgw/yX1ZaxmEB5HJPnCTrgKKwbuf0FaSYHSt6tZU/ohVH0cRwH/T76iX+zjP3UZyR1XK4xYNR/7lWSpe6kB+K6+x5CVNsMfmSVAzjuqRMlUC628HSXR9qT4Ry/ZQ72wgWQXR7ktt07R4G+Yi7pPZfbq/aNZihsY1yP6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726006614; c=relaxed/simple;
	bh=6vSSgVY+sWsTklYYrlr/OHdGD26xT77F0/uVkqmOnyE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=I733ix2VnRHZT9DNu6i38a4fOaqg3NEmFAr3gSMH6DSBN8IRx/lJRwIkjWgT0bQiXWQAoNAl8Dq6LiXVHiUWhZ4aNncGAVjbj5DYeLJdOBwqpAAIy/0afvBzv0gnMqMoSbGdbTu6m7a+XFG3PdcZRJJJOFF5uEFh23wGGtEEpMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=Vbkopv/Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tBDF6Uy+; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7CBC31140089;
	Tue, 10 Sep 2024 18:16:51 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-03.internal (MEProxy); Tue, 10 Sep 2024 18:16:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1726006611;
	 x=1726093011; bh=ZFPbHuL11lgtaJbe7iI1GZ1VpmwkrdzMiyKw6UGwaB8=; b=
	Vbkopv/QTZM0mu+wp79frcd4guHmuSI2BCr1sJL5CXqMWHjzoolqMoHKFXFj+6Ov
	7EczDHa8hVq7b0WsueeHkvRNHg00/zi5WSFf2wxYsIKMWZlL2P6GXwLrs7DfB+qF
	eMKDZXmcpEmdkH/miqS2iSSOddDi8LFIrGNoGNOUojHVOLf/cLOwMsI/zowziQy0
	6XT/1QbHe4MPK9/47tgVU/MsxrvYL23Il59kmrqcQmpsDSnk54NbNNc6bWrcCDYY
	sbFEAJUlbyjVGaxRaakqOPeqogTg3ofzi/9V1PYE1Gh5ihUEEgyvgPFvYbWCD3R/
	h4va/PLw0Vu1zmSu9H7ZNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726006611; x=
	1726093011; bh=ZFPbHuL11lgtaJbe7iI1GZ1VpmwkrdzMiyKw6UGwaB8=; b=t
	BDF6Uy+wb4qbbNJKTnVM9I4pYnt5x1irLc48v25tdb/jtm4MdfOjvWeHokthWMil
	0ciQiJeZrE82lELMzlFMG20Yo2szJkzmN5uespmb/LBvel6how7pCNON63ImZNyU
	8fbZhg1xNLPRp8cK9A0UhPoHySXwul1H2Uc2H9kqtRg+kT8SQ06WNJBt5wyAwl6h
	qvBXFzTruv5OI/bQCKEGOLRMqkcY+4gsd37L1ropoR9J3DBGwEkTxpD41YM1aSbP
	APkf7+3DCXXq+MQxNpUCwY4GcIBfK++toJUmC9WAk+uul6VHt1dpp3JZrEhg390+
	jMTp11FPBmDlGZ97NiYug==
X-ME-Sender: <xms:UsXgZoSGn9JK7g6cmk4PiCl8suGigoNt6nIb04jqB94Y-iHO_mJTLw>
    <xme:UsXgZlz6bMIcQc58NWT3KaDnuc5zNGcmemAsnXb5PUuk04FlXyuwih3GnLJorxyMr
    6PeW10jtXWKUWQWyw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejtddgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegfrhhlucfvnfffucdlfeehmdenucfjughrpefoggffhffvvefk
    jghfufgtgfesthhqredtredtjeenucfhrhhomhepfdffrghnihgvlhcuighufdcuoegugi
    husegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgleeitefgvefffedufefh
    ffdtieetgeetgeegheeufeeufeekgfefueffvefhffenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiipdhnsggp
    rhgtphhtthhopedvtddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhihkhholh
    grlhesfhgsrdgtohhmpdhrtghpthhtohepshgufhesfhhomhhitghhvghvrdhmvgdprhgt
    phhtthhopegrlhgvgigvihdrshhtrghrohhvohhithhovhesghhmrghilhdrtghomhdprh
    gtphhtthhopegrnhgurhhiihdrnhgrkhhrhihikhhosehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepvgguugihiiekjeesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhnhdrfh
    grshhtrggsvghnugesghhmrghilhdrtghomhdprhgtphhtthhopehhrgholhhuohesghho
    ohhglhgvrdgtohhmpdhrtghpthhtohepuggrnhhivghlsehiohhgvggrrhgsohigrdhnvg
    htpdhrtghpthhtoheprghnughrihhisehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:U8XgZl2ZhT0bX_v3p9eEQBzvtCDaiGt48YokqalqoDVPxi6cgT-iPA>
    <xmx:U8XgZsBGS4YLAoyEI-0n8GJg_UBvro1uZ0kmPKbEJW9TMeHZ2oTtRw>
    <xmx:U8XgZhhk4cRYOCZu6wdUKcBeEWlZw5azMIn7318G7r-diKF_gJKxng>
    <xmx:U8XgZorK6-reDYHdQUA7_E7LhYMnDYjordf2uYvWlVJKQAOM7dPQ0w>
    <xmx:U8XgZm1UGeEAUJRZULkL9hKqQ4-67NLDrfzRo4bDSwR8fyUBuk3TO6tk>
Feedback-ID: i6a694271:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E188018A0065; Tue, 10 Sep 2024 18:16:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 10 Sep 2024 15:16:30 -0700
From: "Daniel Xu" <dxu@dxuuu.xyz>
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
Cc: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>,
 "Eduard Zingerman" <eddyz87@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "Alexei Starovoitov" <ast@kernel.org>, "Shuah Khan" <shuah@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "KP Singh" <kpsingh@kernel.org>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "Hao Luo" <haoluo@google.com>,
 "Jiri Olsa" <jolsa@kernel.org>, "Mykola Lysenko" <mykolal@fb.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 "Kernel Team" <kernel-team@meta.com>
Message-Id: <4ec8e15b-c44b-41d7-b337-32d17306d67b@app.fastmail.com>
In-Reply-To: 
 <vru2zgphyfywjcqikolwotsfun2bgtrnfmwvfls5ra4tznsydr@46w5rq7gqepz>
References: 
 <18a9ddacc99bb95e9802f8ad1e81214433df496c.1725929645.git.dxu@dxuuu.xyz>
 <CAADnVQKyfZ2-qCvmqG8z919ggdOszEjTs04H=cTGOZTi-zhx7Q@mail.gmail.com>
 <CAEf4Bza5Fiw2rZ5T7=zRwVk1Ct1Mgm7Gpa8w+NJVPZf8keY_9Q@mail.gmail.com>
 <vru2zgphyfywjcqikolwotsfun2bgtrnfmwvfls5ra4tznsydr@46w5rq7gqepz>
Subject: Re: [PATCH bpf-next] bpf: ringbuf: Support consuming BPF_MAP_TYPE_RINGBUF from
 prog
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Tue, Sep 10, 2024, at 2:07 PM, Daniel Xu wrote:
> On Tue, Sep 10, 2024 at 01:41:41PM GMT, Andrii Nakryiko wrote:
>> On Tue, Sep 10, 2024 at 11:36=E2=80=AFAM Alexei Starovoitov
[...]
>
>>=20
>> Also, Daniel, can you please make sure that dynptr we return for each
>> sample is read-only? We shouldn't let consumer BPF program ability to
>> corrupt ringbuf record headers (accidentally or otherwise).
>
> Sure.

So the sample is not read-only. But I think prog is prevented from messi=
ng
with header regardless.

__bpf_user_ringbuf_peek() returns sample past the header:

        *sample =3D (void *)((uintptr_t)rb->data +
                           (uintptr_t)((cons_pos + BPF_RINGBUF_HDR_SZ) &=
 rb->mask));

dynptr is initialized with the above ptr:

        bpf_dynptr_init(&dynptr, sample, BPF_DYNPTR_TYPE_LOCAL, 0, size);

So I don't think there's a way for the prog to access the header thru th=
e dynptr.

Thanks,
Daniel

