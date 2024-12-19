Return-Path: <linux-kselftest+bounces-23538-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C799F713A
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 01:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0685418936C9
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 00:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44A31853;
	Thu, 19 Dec 2024 00:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="hUBUikLe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XU/9CtK+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1994C23A6;
	Thu, 19 Dec 2024 00:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734566978; cv=none; b=oOf7+hlZy8BS0YOnmGp4DhFq8/k/Yb+i4ijOg5OpLCx3UkvqvOmqah3X7GV5YjQo9fbj7v7ueo6oH8y8KYh4GJDnqszGAIfyQ9kXQmXt+qoldwh03S1KqcmQSQdadapfCdwLopll7r7R/URh8/jYVzy01H7QE9PiPWz15K8tHVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734566978; c=relaxed/simple;
	bh=iQCSvVz+THyO8p7gfWNci3Sgo03nIGGrpS2vYTVs8Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qAOGXFGe/mpUA8e7JK1j+BStczWNG91AF7/ItApyoToBf6sO28Hk6FlVkzKUZyENGewutO5TcGvTODRAzsMU0WHYLG5Nrt4X38vpeN/eIlQdOCikMUQ8VJC+R3l77dI7eiVj2r2Sz8bjxXVpJyPIeNjxY4RPFCDzdeOkUD3Hah8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=hUBUikLe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XU/9CtK+; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1886811400FA;
	Wed, 18 Dec 2024 19:09:35 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 18 Dec 2024 19:09:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1734566975;
	 x=1734653375; bh=qbj/8QsOjEZ5Oa4Tvk3tVPh+yXUwd4yDDy7fj3f0Yko=; b=
	hUBUikLeSVNF/gMDTGj7XFuFlcgPLe1KboVBSKFXdRwVdSuqYsCoSzJ7BPrx3StI
	2DkeNnG1/SbhWP3ttOQqhllaTuG6ImCE+xqQcpAtVM+fLdiY/jyqKeDwb56c5yLN
	2Fq6GcapsbXbh664FKh/Yfgosa9lEzGUjPxhONXRybyIiKkm7iaO8M7w/QVXSdC3
	2WVOwcH89YVLv5U7jQLLbLL8g6p1QwkhfSztGSCRVHO30+h609YzDmjeabhHE2bR
	hQ5FWkzVkY/lFb3jCiV6eM1lwLO6vyWihU000BxYBJNgzDgL+Lw2AV73RT6Pl/zf
	Nn42L9pRgtihm/YpU+RNcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734566975; x=
	1734653375; bh=qbj/8QsOjEZ5Oa4Tvk3tVPh+yXUwd4yDDy7fj3f0Yko=; b=X
	U/9CtK+THir7DODxGgtPYAL3kdUuEcLrYK913ZugBCMvmHXQPLF+eZRZHB2BQArI
	1JXhwFjiR/4WQvf8Mwq41YiT+gtK5mQ3mQd0gUPwJZVHS6oMtuVs8CWqHfJgf5TI
	M6DhsTFT0AMYciOENlj9J7T1DkAzQxl/KVk9BX9dtmqK8tA99alG4HZWdmDkCX+L
	dthmmRI3StQtH3svbNOSwx2nDQXlM4yqXuS1ZKU9gdbDH6JQBG4rvwSWKDe36xC7
	mqx24+KOWgr0iIi4Cgd+3FSClLEUEpRXcuAPDqFqfqZjuk5d+aleNwcUHa4xu23K
	PCQr9lt5BGV9Js8ut1GiQ==
X-ME-Sender: <xms:PmRjZ6qNDzoLTbYn7gr6zCBs4C_a4e-vY2_zzyhYZOq2HzdzU_xflQ>
    <xme:PmRjZ4oplP5T0B7XrOS8u73XmRPjVvjAyJv6OKgQZ87XdiUfswQk4B1c3dRGLow9e
    cb54NHn3P4qlIZAZQ>
X-ME-Received: <xmr:PmRjZ_MDAHEAcuIVC7c824GFnMrymQq0GJb48irUNZ1dI-UZuLDVaHXyTNzmgszc56sNkhnTpO-lYxxCLZBFTFYyeKTwSklFr-3j_Fmis7CgKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleelgddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenfghrlhcuvffnffculdejtddmnecujfgurhepfffhvfevuffkfhgg
    tggugfgjsehtkefstddttdejnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesug
    iguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnheptdfgueeuueekieekgfeiueekffel
    teekkeekgeegffevtddvjeeuheeuueelfeetnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihiidpnhgspghrtghp
    thhtohepudelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhgurhhiihdrnh
    grkhhrhihikhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgguugihiiekjeesghhm
    rghilhdrtghomhdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhuhgrhheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlsehiohhgvggrrhgsohigrdhnvg
    htpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrtghpthhtohepsh
    honhhgsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:PmRjZ55sdcN7kihBuaB1Cb_zRq9D2P6EOMS770N4T-virFDJqIoSrA>
    <xmx:PmRjZ573gBpFzeP9AHyXPI8xNPbstLPW9IJNUZowvwPaHRuiSwXCuA>
    <xmx:PmRjZ5j-7_HBmZ_q0nlcg0_Ue35WhG8A8ZMQa1QTEmCwXOwJyGo4Zg>
    <xmx:PmRjZz6IqZjfz6DwOrVI0uwF4d3cJ1te7A5V2SR-IoNszQHDkQI9lw>
    <xmx:P2RjZ7tLgKpW8nuCyX72l0FIuyHkoYEG6T8cPsj4lRHEk7LvYqJuesjX>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Dec 2024 19:09:32 -0500 (EST)
Date: Wed, 18 Dec 2024 17:09:30 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, andrii@kernel.org, 
	ast@kernel.org, shuah@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 4/5] bpf: verifier: Support eliding map
 lookup nullness
Message-ID: <aur6exve4ytjvrdpf6o3k74plqktc3ke4kmdqnrlrhiljtq72x@irruxegpbsce>
References: <cover.1734045451.git.dxu@dxuuu.xyz>
 <92065ca054beccd6d0f35efe9715ef965e8d379f.1734045451.git.dxu@dxuuu.xyz>
 <CAEf4BzaqCgW9keiT+tJUBQWT6Q+jMwuvn4O2ZghO0c+ZvACNrw@mail.gmail.com>
 <zow3q3nhlz6vedbni3upag5yr7zzrhyiqysl5nwyubebmbwojk@th7kbm62x36g>
 <31b0c85dbf85486df116ade20caf8685843899b4.camel@gmail.com>
 <CAEf4BzaEOBtrSWZTx40AdT=SQY6Qaia405KWgU-NowaqNdmpkA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaEOBtrSWZTx40AdT=SQY6Qaia405KWgU-NowaqNdmpkA@mail.gmail.com>

On Mon, Dec 16, 2024 at 03:24:01PM -0800, Andrii Nakryiko wrote:
> On Fri, Dec 13, 2024 at 7:13 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
> >
> > On Fri, 2024-12-13 at 19:44 -0700, Daniel Xu wrote:
> >

[...]

> >
> > > > with Eduard's suggestion this also becomes interesting when you have
> > > > 000mmm mix (as one example), because that gives you a small range, and
> > > > all values might be valid keys for arrays
> > >
> > > Can you define what "small range" means? What range is there with 0's?
> > > Any pointers would be helpful.
> >
> > I think Andrii means that each 'm' adds 8 bits of range.
> > E.g. range for 0000_000m is 0-255, range for 0000_00mm is 0-65535, etc.
> 
> yes, exactly, thank you, Eduard!

Gave it some thought. Still seems like a good idea, but I'd prefer to
leave this extension for a separate patchset. Mostly b/c I'm running out
of space in my head to grok everything :P. Probably higher likelihood of
me getting the existing stuff correct if I don't add more scope.

Thanks,
Daniel

