Return-Path: <linux-kselftest+bounces-21906-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E34069C66FC
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 02:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AD52B2467F
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 01:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B21F6A332;
	Wed, 13 Nov 2024 01:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="EC00wFkI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VBUCvJSt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7094A43ABC;
	Wed, 13 Nov 2024 01:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731463134; cv=none; b=Sgi3FOwL0tsExP2HCCwhVAKZ+/VP0g4kTySLcfFjJ+kbt1HyATM1X0rLqcP7e2GvUcuco8PrFonEa74xRTGeajY2mZKT5Zsc/xvu1W6IGOaHOf29Nsty9gGd45pF/mk7ulju5VmuueY6bGcZIrVmKdtOrHJV3YuDabARn4yrY2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731463134; c=relaxed/simple;
	bh=uVNRehP/aFBKxJtf0EQ9djCSe0HL2Y4PiJy3FC+vh6g=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CFeaLCDAVeKpRg7xoYU7lKgpRihgu9CPV7Sot1ClASiEB3P7D9X2BbJN0kAUestZ4fqO+PidFdBXdZ2dFprcfgTjPIyWgIjByLw39wu3AieNSXNWpTpaxMJ8ABZqCx+0tcqvETLtQ1pm2jsxKyzaLyp5FHef90WWMCkeEtV9q54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=EC00wFkI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VBUCvJSt; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7779A1140126;
	Tue, 12 Nov 2024 20:58:51 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-03.internal (MEProxy); Tue, 12 Nov 2024 20:58:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1731463131;
	 x=1731549531; bh=uVNRehP/aFBKxJtf0EQ9djCSe0HL2Y4PiJy3FC+vh6g=; b=
	EC00wFkIrVlwLo/whiPi98UspsR+XEE+5PPrWrECbWxbQvxmNIScCcxQL4OOhbrS
	Vg7U0SWW+CKRcq0HHfOEoNTg1Yu+AsYnGQRDhJtr/wtkXeOW2II/uqiLNsDgvkmm
	r/P6TwAlIVeTC9E6nj4jJ+sgZzKxlot/LSHR8CnJ0bhsYCTNLwT1jLXQdSKWmmPW
	K9gWTrd8S7gtAThslb/USiP6Qysio6D4UPE0F9yGRT7fQujU/ST1V2KjbGzu0Bcf
	kOF6e3A1PT5m6EyuLdJlmtK7B6LVX7/VweJXkwbrMnJRGI3rWlAIceWchywO7cUX
	olfMXth7U2UipTuxMZELPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731463131; x=
	1731549531; bh=uVNRehP/aFBKxJtf0EQ9djCSe0HL2Y4PiJy3FC+vh6g=; b=V
	BUCvJSt/DRZIaf3YW2LhEYUkJXoyal6KhBG8phjxkLyc0jnhJAh/41dmyUIgzGDo
	6NPNd78jLyI8INcqTUNS3czSNBz8/OtdUlq9uKAWBXRwJcb7OG8B1MqI6SWMlQAA
	+0cHFm4Ekd/H3GVarjjtpbCFeUDY5ZkaxUIKjsh91XnrxIKAydcVgbPK6x3I7sEq
	mxTkp1znKoQ7AKeViiNrIFdmkiPb5EkRUA667+N42Wi9AV92wED3MSaVgo7raQ6h
	enSHQuwLkidx7ge+CMpxjyNyhIcqzc7HR0S05BLGkXXwalzmO0qwkINwdaVtL/tD
	CwScpKdLvRF6jFvMFovwQ==
X-ME-Sender: <xms:2wc0Zyn-PlnGv3dpshyClPCIZZo4Z9fWNl6WvspQHry2vtCYJSmzmg>
    <xme:2wc0Z50p7bsle7i9Az0FpnSCB-hd69KzJCRHJ2e6IkPxMV9H6s_HUhLE5cQIKG2Yi
    ObW7kyq4eN0IBhpNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeigddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenfghrlhcuvffnffculdefhedmnecujfgurhepofggfffhvfevkfgj
    fhfutgfgsehtjeertdertddtnecuhfhrohhmpedfffgrnhhivghlucgiuhdfuceougiguh
    esugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgeelieffhfduudeukefhieef
    gfffgeduleevjeefffeukefgtdelvddvfeefiedunecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihiidpnhgspghr
    tghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmihgthhgrvg
    hlrdgthhgrnhessghrohgruggtohhmrdgtohhmpdhrtghpthhtohepphgrvhgrnhdrtghh
    vggssghisegsrhhorggutghomhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvg
    hmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtgho
    mhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhuh
    grhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhn
    uhigrdguvghvpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthh
    dprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehmvghtrgdrtghomh
X-ME-Proxy: <xmx:2wc0ZwoeepGtEOn_slxZ5FKm7fL-wawTJxmfnIdaLoC_A2G0nHPEFg>
    <xmx:2wc0Z2kyF0rv1kFQWLepqu_UQm8Zrei8t2yT0hIwcMihDEb7xF6xfQ>
    <xmx:2wc0Zw2ROiYg3MmBXaPnWrqe691UjGNrraoYxOc4c9eFu0ibrLMhkQ>
    <xmx:2wc0Z9sMJGS5TMujJDdHDTWJuK-HArj7QtG9A0s168Ox3E4uOnMy3Q>
    <xmx:2wc0Z2OI5LY4_orgS_kR_x2uYLVxhLP47RQYHJPS0D-SXgwECWnssWbQ>
Feedback-ID: i6a694271:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 378A518A0068; Tue, 12 Nov 2024 20:58:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 12 Nov 2024 17:58:30 -0800
From: "Daniel Xu" <dxu@dxuuu.xyz>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: "Paolo Abeni" <pabeni@redhat.com>, "Eric Dumazet" <edumazet@google.com>,
 "David Miller" <davem@davemloft.net>, "Shuah Khan" <shuah@kernel.org>,
 andrew+netdev@lunn.ch, "Michael Chan" <michael.chan@broadcom.com>,
 "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Pavan Chebbi" <pavan.chebbi@broadcom.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Kernel Team" <kernel-team@meta.com>
Message-Id: <718b7af5-25f1-4a22-85a8-193b53db499a@app.fastmail.com>
In-Reply-To: <20241112174434.011bd0f6@kernel.org>
References: <cover.1731377399.git.dxu@dxuuu.xyz>
 <dc4398dfe9a8e959245d2a8ffe5c2fcefbdd67f7.1731377399.git.dxu@dxuuu.xyz>
 <20241112174434.011bd0f6@kernel.org>
Subject: Re: [PATCH net v2 2/2] selftests: drv-net: rss_ctx: Add test for ntuple rule
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Jakub,

On Tue, Nov 12, 2024, at 5:44 PM, Jakub Kicinski wrote:
> On Mon, 11 Nov 2024 19:23:31 -0700 Daniel Xu wrote:
>> Extend the rss_ctx test suite to test that an ntuple action that
>> redirects to an RSS context contains that information in `ethtool -n`.
>> Otherwise the output from ethtool is highly deceiving. This test helps
>> ensure drivers are compliant with the API.
>
> Looks like it doesn't apply, please base the v3 on net rather than
> net-next, I'll deal with the merge.

Sorry about that. Will think on how to make my workflow not involve
manually retyping patches between different machines...

