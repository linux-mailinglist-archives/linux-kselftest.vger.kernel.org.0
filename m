Return-Path: <linux-kselftest+bounces-23632-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7E69F8906
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 01:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D1E118905AB
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 00:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60E52594A9;
	Fri, 20 Dec 2024 00:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="YVu904Hw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CO+DZSik"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67594800;
	Fri, 20 Dec 2024 00:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734655238; cv=none; b=YgXcxLHsxUtPccoByVWcwaaFGlCcUVphXYEFLV+b1B4jBH4HtJurvtyIT7qF6sRFEz+ypcXepFPE6cycLYIWYVAAj3VLxqAuKlZ0h/n2Y7N71fk4EW4wTl7by26gYkpz+A2cLi/FbCJJI0A9NLjFNS8H2LUOxzAkyJy2yhGKOSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734655238; c=relaxed/simple;
	bh=13wJenR/mQ9s96VRt2lf8g8bCxoH2vnPVKeXG18STug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3uhucQaBb4JSI1EcKPb21NVS0v5CzzvWXWN0OY0XlXo8GWL11dvBU12C0iA2ub8y/P9TpaZN7ocJjW7ogMee5wN/WkiIyq4fMGg0TnUDdAXlzN5/m7howHjIk8chzWpcwCv6gvo1IItPIPM1hAulgeJcoj1xBE3f/6zByG7T9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=YVu904Hw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CO+DZSik; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EE66425401B3;
	Thu, 19 Dec 2024 19:40:34 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 19 Dec 2024 19:40:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734655234; x=1734741634; bh=Ktg3pBXvwq
	rACo60Nz+FZ0dP2d3kQw9ZPLTVaSGME6c=; b=YVu904HwsvcD+iMamYb0DtCwTR
	KE4zxYU8qnGj/aCb+Dz45swpg0xrVGz6HGKcz0DQbVA10XLi3GO8HKzGIFdCdef2
	CTMy2oAquLubCysfeBlet0T4LxsI9SL0CG/Kgtm0BOkiFQAMoeol7FbdtJ4ppqjk
	Dv5rUk9dwJsjw8B3VX02CADDvvbgN2cb8hBIWfFpNCxpndFR2Hsc4uCkqYcN1Fx3
	nuDI2gzncgwCt5HPnzbih5PIWyqJM7T2KTCuTfpCbTFzhHZ2IlzasRN2hz3+uCdx
	WAwxVe4fy4q7XkfMrOLiQBGWh0/AhUrOPPjeXbTMJkSALEtw1EAIUtu1GfFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734655234; x=1734741634; bh=Ktg3pBXvwqrACo60Nz+FZ0dP2d3kQw9ZPLT
	VaSGME6c=; b=CO+DZSikI6zeNipBcfQCeYvgUIsnUbbGg43oQc1em2WeefdYVMy
	8sx6TJbv0Cwgb4+wTRlWfuwPL7lQCCusq9cZCDc0NuFBtoP1f+3NLb97LTxH74OP
	aLzYfPJ0jw1XAw/cFwFjN99m4ePBVY7pssBOKvbzO2lJF6+aLNSbSNf9PlcB05Wc
	tSwGI5jUAB4pod7t0So4YWWEAJnuGikdRmql+NQT5uJNiNSsIATm4FYkFQGtrlUG
	hS7l9vbj7Ti5WQSz8/v4Y8PbCmStG4QKBbGAiAkjrHHY0Rpg0SB8OmAYXbntSMwb
	NkUGC0ngtOk7ZnfjRQCTF/9iamoM+7td8Mg==
X-ME-Sender: <xms:Ar1kZ_gTFOWiRtl934rMJnpvJ-zQYTDKEWe8wvTD2WyNstdAr1Ha5A>
    <xme:Ar1kZ8BsE1Sjv995-kkLxUvIOGWDjtbByoPXilVjSlUfxyXztaWeD7AavUNbsccrV
    vNVYqltFXJS755bGA>
X-ME-Received: <xmr:Ar1kZ_ElWviMBKPGNhDEun6DGZZ4dM-yfZDw3xecGUr3M9dibu0nPYZQXiC-HMEPG0BqBE4Q_0lTXRBqigUEf5SQD-Zoq12WhUU_86vsMGaxMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtuddgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnegfrhhlucfvnfffucdljedtmdenucfjughrpeffhffvvefukfhf
    gggtuggjsehttdfstddttddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesug
    iguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepvdefkeetuddufeeigedtheefffek
    uedukeehudffudfffffggeeitdetgfdvhfdvnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihiidpnhgspghrtghp
    thhtohepudelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegvugguhiiikeejse
    hgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrihhirdhnrghkrhihihhkohesghhm
    rghilhdrtghomhdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprghstheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhuhgrhheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlsehiohhgvggrrhgsohigrdhnvg
    htpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrtghpthhtohepsh
    honhhgsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Ar1kZ8QZiPlQNIXCdPRdzFuMBfqWBnTKV3nqINDls8dj2BePfpd_uA>
    <xmx:Ar1kZ8zUDHuZjuKE5TTVdzDcwI7cKF6gWnVuZldfo2M6Sn3G4k5u6g>
    <xmx:Ar1kZy5_nICnCcMA3-SqMlf4GO4gl0O5QzO673cSgM6YgAqPBLrvEA>
    <xmx:Ar1kZxwM6_HX1mMRX1NTbR0wU_EYC4wUg4_DASC2ow04GM8bbVoSPg>
    <xmx:Ar1kZ5EKqn7ysuS1lzn323HtK0ElfxqdCNsBOXzBDY8amWWfIRnXb0Rs>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Dec 2024 19:40:32 -0500 (EST)
Date: Thu, 19 Dec 2024 17:40:30 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, andrii@kernel.org, 
	ast@kernel.org, shuah@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 4/5] bpf: verifier: Support eliding map
 lookup nullness
Message-ID: <f7taicw6c3f3yae4d6lrdagv26jiuihumklo4tkmqduvauargi@ld4bcmsbbiqn>
References: <cover.1734045451.git.dxu@dxuuu.xyz>
 <92065ca054beccd6d0f35efe9715ef965e8d379f.1734045451.git.dxu@dxuuu.xyz>
 <CAEf4BzaqCgW9keiT+tJUBQWT6Q+jMwuvn4O2ZghO0c+ZvACNrw@mail.gmail.com>
 <zow3q3nhlz6vedbni3upag5yr7zzrhyiqysl5nwyubebmbwojk@th7kbm62x36g>
 <31b0c85dbf85486df116ade20caf8685843899b4.camel@gmail.com>
 <CAEf4BzaEOBtrSWZTx40AdT=SQY6Qaia405KWgU-NowaqNdmpkA@mail.gmail.com>
 <kghvgxu5wdkupssnq7dy5upuf2wscsxgsnwl2yoam4mwk3h5pn@wjjsliwg6fzl>
 <a2999d8b4827516fe4bfd17646d2284580712d08.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2999d8b4827516fe4bfd17646d2284580712d08.camel@gmail.com>

On Thu, Dec 19, 2024 at 04:04:43PM -0800, Eduard Zingerman wrote:
> On Thu, 2024-12-19 at 14:41 -0700, Daniel Xu wrote:
> 
> [...]
> 
> > > > I think that if test operates on a key like:
> > > > 
> > > >       valid key 15
> > > >              v
> > > >       0000000f   <-- written to stack as a single u64 value
> > > >       ^^^^^^^
> > > >     stack zero marks
> > > > 
> > > > and is executed (e.g. using __retval annotation),
> > > > then CI passing for s390 should be enough.
> > > 
> > > +1, something like that where for big-endian it will be all zero while
> > > for little endian it would be 0xf (and then make sure that the test
> > > should *fail* by making sure that 0xf is not a valid index, so NULL
> > > check is necessary)
> > 
> > How would it work for LE to be 0xF but BE to be 0x0?
> > 
> > The prog passes a pointer to the beginning of the u32 to
> > bpf_map_lookup_elem(). The kernel does a 4 byte read starting from that
> > address. On both BE and LE all 4 bytes will be interpreted. So set bits
> > cannot just go away.
> > 
> > Am I missing something?
> 
> Ok, thinking a bit more, the best test I can come up with is:
> 
>   u8 vals[8];
>   vals[0] = 0;
>   ...
>   vals[6] = 0;
>   vals[7] = 0xf;
>   p = bpf_map_lookup_elem(... vals ...);
>   *p = 42;
> 
> For LE vals as u32 should be 0x0f;
> For BE vals as u32 should be 0xf000_0000.
> Hence, it is not safe to remove null check for this program.
> What would verifier think about the value of such key?
> As far as I understand, there would be stack zero for for vals[0-6]
> and u8 stack spill for vals[7].

Right. By checking that spill size is same as key size, we stay endian
neutral, as constant values are tracked in native endianness.

However, if we were to start interpreting combinations of STACK_ZERO,
STACK_MISC, and STACK_SPILL, the verifier would have to be endian aware
(IIUC). Which makes it a somewhat interesting problem but also requires
some thought to correctly handle the state space.

> You were going to add a check for the spill size, which should help here.
> So, a negative test like above that checks that verifier complains
> that 'p' should be checked for nullness first?
> 
> If anyone has better test in mind, please speak-up.

I think this case reduces down to a spill_size != key_size test. As long
as the sizes match, we don't have to worry about endianness.

Thanks,
Daniel

