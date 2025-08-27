Return-Path: <linux-kselftest+bounces-40054-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7ADB383E9
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 15:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AC1E3A92D3
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 13:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7A813B2A4;
	Wed, 27 Aug 2025 13:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="an5dT5du";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YziFcbzA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49F83FE5F;
	Wed, 27 Aug 2025 13:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756302326; cv=none; b=uN9xwYx1CMOzApsjy39cL7juC78x2wVDNyj+fpOmGcYNC32VTMqXmwm0Ddw8WEABmMDngHPzOj7s+vZgqOkwHin705C1yGw0bLXXVMpn/DQ5H2qUWxGzOGNqgcTej09cKAmfOy+9J+XBlhPbco2IMGQfnRq1scO6CLcPC1U+EjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756302326; c=relaxed/simple;
	bh=IDR1Hcx1cJNRiqLSb//00NZw+n9NlkZZwGhyjGhCrf8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=j9QHxgjjmgfp+R4h5AHrb/6yvhYvHdW9w47FuXb7HlPbSvEAciATH5c5TP+Gcm9PorW1J1WU/TW/QoqdrVIeytsQ3EgEzwjM9pWKLmYqyFydtQ6PvNUAL9S6ouTMjK/OA72ltOktnCRu6Gi7TM6zNKcnlUXpKO34I1PRXr5hfSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=an5dT5du; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YziFcbzA; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 9E1EAEC0389;
	Wed, 27 Aug 2025 09:45:22 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 27 Aug 2025 09:45:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756302322;
	 x=1756388722; bh=m5pQcLLR+f+TkxFjSmRkg1YPysnG12IZlbG1c3mfhh8=; b=
	an5dT5duEAcLubJD45zTostX94m/f5klodSox9K3TQA9IpWlXXnwe3iJon7KPx8n
	UzA1ZcMcbcuyrKpWgdf++kToJldL1CivbnDK7PRpScM71xZRNkZniUJ9Bqta5BA8
	L/m4aasYblvQNmz+ZSn7D4GI6TJ8UHsphJTKVVR6lEAA/+QDSOq7t27zSDfK1EjD
	eklVpleB0ITEHYACA5yppOF9Q7DYNPyokq/9ahK8dA/g80/NGV+mWWoOeKSwEzgd
	Go50tHKS86dcO+IGrvltEaV+z9zHUmKabjtT4hima3PhCYqB8qP/O5bPGXnHHAOK
	W6kjrjea1E1H86G3ZBRLLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756302322; x=
	1756388722; bh=m5pQcLLR+f+TkxFjSmRkg1YPysnG12IZlbG1c3mfhh8=; b=Y
	ziFcbzAwsR6MNRD8h1T+67LbwunqdcghLXOR45lLvZOJJ3MXKH7JVnS73y0OSY+u
	h7hXcISipldZ4UO+ENPjZIwzQgM4cyBUd5TMCEsF1nPm9zk5ZASjy7qVMiTofuea
	O4eFtFK6TFvqrQe+/Wpj9fxOuXymUy4oZB4zWI7S64F2fPkRncYKaX7VXyoH38q3
	W28fsRLWsIVxYZL1RZz6+/WsK8/Zt4ixzRFf3+f8KXWXsRZutcL8/5ufBnZetVLg
	zV4G4Cehh0DgYS8yCMeDxw6cV7K+sa/e+XIQ1ukifhJ2gAgTQcJePBUglaWrknHw
	uR7Shci6NBJTGVIxBoBPw==
X-ME-Sender: <xms:8guvaDGzUuSaGjxahSzHlGuqG2k_BNkwvnuaXvZKbJpMetTp0Wpa3w>
    <xme:8guvaAVuVnutWjO3ZsMPY-SXchQ8sr4wuXtA-sXVEwRZKT--X1WpSMCx7hq4228zq
    1icdJUQ2K3dBzWx-mk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeekfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheprghrnhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnth
    hishhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjihhkohhssehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hlihhnuhigqdhinhhpuhhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidqkhhsvghlfhhtvghsthesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:8guvaOJpPOomkO3kH1rWdk5IEFFdebHWzPMrsVwN4aoK2DRESdFb2g>
    <xmx:8guvaDHfvi7mmjACRZ1-L76MVBplPm7PrPRJ1zyQeeh_Dcvkg2a1QA>
    <xmx:8guvaKUr4BdzuTmlG_TI85AvmkscFL8TBOfBZGuDG2uXLDAJvPs7QA>
    <xmx:8guvaLxhAwwDFIl5U2CWmNJQMuhQgSGu2e2HuJcd7zQEQeCdVszH1A>
    <xmx:8guvaBvzNYY0I7RmdNUT1k3yUAOqM22Inct86s-SOGvwDHPsZFxgDm_u>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5B3AA700069; Wed, 27 Aug 2025 09:45:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AgDG1evULkvc
Date: Wed, 27 Aug 2025 15:45:01 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Benjamin Tissoires" <bentiss@kernel.org>,
 "Jiri Kosina" <jikos@kernel.org>, shuah <shuah@kernel.org>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <6df083db-b1d5-4c80-96f7-e6b787bd357c@app.fastmail.com>
In-Reply-To: <20250826-b4-hidraw-ioctls-v2-3-c7726b236719@kernel.org>
References: <20250826-b4-hidraw-ioctls-v2-0-c7726b236719@kernel.org>
 <20250826-b4-hidraw-ioctls-v2-3-c7726b236719@kernel.org>
Subject: Re: [PATCH v2 3/3] HID: tighten ioctl command parsing
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Aug 26, 2025, at 14:39, bentiss@kernel.org wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The handling for variable-length ioctl commands in hidraw_ioctl() is
> rather complex and the check for the data direction is incomplete.
>
> Simplify this code by factoring out the various ioctls grouped by dir
> and size, and using a switch() statement with the size masked out, to
> ensure the rest of the command is correctly matched.
>
> Fixes: 9188e79ec3fd ("HID: add phys and name ioctls to hidraw")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

Hi Benjamin,

Thanks for fixing my botched patch and sending the new version,
looks good to me.

Since you already rewrote most of it, I think this should be attributed
to you though, so maybe make that just 'Reported-by: Arnd Bergmann
<arnd@arndb.de>' and make you the author?

    Arnd

