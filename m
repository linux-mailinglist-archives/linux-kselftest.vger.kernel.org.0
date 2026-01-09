Return-Path: <linux-kselftest+bounces-48587-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8515BD07709
	for <lists+linux-kselftest@lfdr.de>; Fri, 09 Jan 2026 07:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2023A30155E3
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jan 2026 06:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A702E7BB6;
	Fri,  9 Jan 2026 06:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="FL1EIOqN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eDIdxhQG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-b1-smtp.messagingengine.com (flow-b1-smtp.messagingengine.com [202.12.124.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71FA2E7631;
	Fri,  9 Jan 2026 06:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767941167; cv=none; b=NjwuqbIheM/q/wTpwoggQ7CBbWtrfGUyDIGY4+9WJ42CAtuhtwF/RRr15oOwecnGNIF1u1reTR9MJy/8yUbNLqAvwq6uSN8uBx5peEEIenZHAV4g91O91rhdaYtyw2lxal1qsjFEANzsjdcNiOTna2bMucLdYigcLf3a871zVuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767941167; c=relaxed/simple;
	bh=YcpLjbUUzr6hWX16ZbkqNNqxEJmALGeA88q7/vc3Tno=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=XGoRA1Xo7koeWNObY82xBylWRvlh4WFN2HO8t6Fligho+2dOsbj1uy1mEURtn5TnftZloU/kREz5pis7h0JWRANabicSHv+knS2XfXzbJ5yb6hAHLOkTEG9upeYCZENcwWSqEor6ukTINPGizHa0ip9tm0CcO2lqQCsvOuR900s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=FL1EIOqN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eDIdxhQG; arc=none smtp.client-ip=202.12.124.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 5E7C313006F9;
	Fri,  9 Jan 2026 01:46:03 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Fri, 09 Jan 2026 01:46:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1767941163;
	 x=1767948363; bh=YcpLjbUUzr6hWX16ZbkqNNqxEJmALGeA88q7/vc3Tno=; b=
	FL1EIOqNDjCoxZtxJZlPMTUcImjeFYxI5GvoXxr2aINNF5cJvBP6qwld1HmI5IW+
	lYFq1rbGYWIJHBHvvUxeF/W9V5IaSdAi4dE2aAdnXv8DIf66GasTGCgrcKsaCIxB
	dL+QZu8x8OdLBlsLjiKXov5DfDEgPsstqsyqyHNLBLukd1FKFGslaAX2QujTUHM0
	LhD8JDQzEzSlOwIQOBQt5HQMIoDfyDpzlucoVtFJ1ZGu/KW9Nlr4EbrzZflwP1QG
	Tezrn7FNxM8Sl3ZCDg+TYZHX6m8wDi4Os3C5ATiACOdj/9CR/GnhKtNoE60njC8f
	DD8m5pzOJkpB5kGcmCTGlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767941163; x=
	1767948363; bh=YcpLjbUUzr6hWX16ZbkqNNqxEJmALGeA88q7/vc3Tno=; b=e
	DIdxhQGenKWOA7r2WA6JIwuAZcouvq7tHPMOxI2Vl02A5XqcnwCkBW5iSwudYchf
	b/LfTjQjfv53enrbnv0PCeO+8766eO4Md6SjbFJzjhEmI5Vs2Aq+Ix6TK36WRej1
	NYxh08tROHtV7RXEWcyfEUU+qHbdFz25RSNCmCgcR6/A1/Pg8/i3wdJqdl6+aaHH
	r7P/Xw0zIVM234NG0Nois3RlPkQakllEUezxzFfV46CLJ/m3JkJTGQMqL0WS3zbp
	y90yfhE0muARRkXypS5d6NfiYLGplpId0XDjO39dlurftMjElCgisB1mSMRk+R4Y
	t7Qi6EU+ZtPlmE9XDKyCA==
X-ME-Sender: <xms:KaRgaa3Khu8_p__hPiKoYBztmrNDDM3V3caVmGHhybWbL4kHmdWlKA>
    <xme:KaRgaX6Nhs_HPUpYwdFnuUNIR8Qlz9S3P2s6MzYIbXJEf2OuBnSAzv8_gEALYQ7WO
    sdk_8RuaLyQpEOm_RkKaj93gWBHDZeNux0H48_5icdruZPSuzDwwI8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepvdegpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehfvggrrhihnhgtvghsshesrghoshgtrdhiohdprhgtphhtthhope
    hjvghffhgsrghisegrohhstgdrihhopdhrtghpthhtohepkhgvgiihsghishgtuhhithes
    rghoshgtrdhiohdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprh
    gtphhtthhopegrohhusegvvggtshdrsggvrhhkvghlvgihrdgvughupdhrtghpthhtohep
    jhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomhdprhgtphhtthhopegrlhgvgi
    esghhhihhtihdrfhhrpdhrtghpthhtohepshhurhgvnhgssehgohhoghhlvgdrtghomhdp
    rhgtphhtthhopegthhgvnhhhuhgrtggriheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:KaRgaa_yBMDXZQ4y1lytDTjAr6MjULMfC2vgxAbsR6lYDq6gYyrsDA>
    <xmx:KaRgaWKgwa5_pl8-4Xf_RzybCaHYtGE9IWzYYAKHh6SbxDJ0m0-4Qw>
    <xmx:KaRgaet70oQ_Z6JYxhhHOUCt4-WXFLuAehhs7adRoLSY9MIGOthfZA>
    <xmx:KaRgafkTOgh7fPXAV32jOzTZvLv7dGYA9ncAUIORK6M4rxxTc7lj3A>
    <xmx:K6Rgaagi4lhHKnxarQtcvcbjgm74mUyWlKC9ayZ0QvbAud9-HRnSgaSH>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 65A02700065; Fri,  9 Jan 2026 01:46:01 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AqT2GkHpMKdg
Date: Fri, 09 Jan 2026 07:45:41 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Lain Fearyncess Yang" <fearyncess@aosc.io>,
 "Huacai Chen" <chenhuacai@kernel.org>, "WANG Xuerui" <kernel@xen0n.name>
Cc: "Kexy Biscuit" <kexybiscuit@aosc.io>, "Mingcong Bai" <jeffbai@aosc.io>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "David Hildenbrand (Red Hat)" <david@kernel.org>,
 "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 "Vlastimil Babka" <vbabka@suse.cz>, "Mike Rapoport" <rppt@kernel.org>,
 "Suren Baghdasaryan" <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>,
 shuah <shuah@kernel.org>, "Paul Walmsley" <pjw@kernel.org>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 "Alexandre Ghiti" <alex@ghiti.fr>, "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Message-Id: <08f257db-5fff-4707-b89e-d62b7d592143@app.fastmail.com>
In-Reply-To: <20260109051054.188030-1-fearyncess@aosc.io>
References: <20260109051054.188030-1-fearyncess@aosc.io>
Subject: Re: [PATCH] loongarch: wire up memfd_secret system call
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Jan 9, 2026, at 06:10, Lain Fearyncess Yang wrote:
> From: "Lain \"Fearyncess\" Yang" <fearyncess@aosc.io>
>
> LoongArch supports ARCH_HAS_SET_DIRECT_MAP, therefore wire up the
> memfd_secret system call, which depends on it.
>
> Signed-off-by: Lain "Fearyncess" Yang <fearyncess@aosc.io>
> ---

Acked-by: Arnd Bergmann <arnd@arndb.de>

