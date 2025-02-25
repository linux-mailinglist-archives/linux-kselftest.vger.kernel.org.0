Return-Path: <linux-kselftest+bounces-27442-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB731A43D32
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 12:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BF98188AF30
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 11:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A031A2673BC;
	Tue, 25 Feb 2025 11:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="INaGGT12";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jFgehLMg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED871A2391;
	Tue, 25 Feb 2025 11:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740482153; cv=none; b=N+e+Ow2Vc5PbZHjUqLS5WFnIB0pkLkGt6qC/piLtARtch1fobz0+34RDCzjnyVaeW001GF0KSzu5BxfmSSNg7AGUykKlZIS3DgXNT6Mj/+gLnZ8j7qjuD7nsX2IvWxPlXgk5U1t1eiiLJfZt957K/Ps58l8a/MxTDqiTg4CpWCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740482153; c=relaxed/simple;
	bh=2JbZLuj3gbAS/CbcAaVAbFtDG+KHZF7DLmbgxyIVdWQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=X/fS7k9S0m3Djzcegkm+TLK+I2WTKxXglfovJdO4rEgMtNdXLnX3cxT3/Dy3ItbPgcAxTJkhjQHV+l1SDPWbgeJSB2QrDDN+UUswKH/26QB9Cdt7d2gGegWihmc1JMmWaFbBDlT9FYMS9Y+DF+QE74uu9RNwW40oYn6fw+9HmFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=INaGGT12; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jFgehLMg; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id A13651140191;
	Tue, 25 Feb 2025 06:15:49 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-11.internal (MEProxy); Tue, 25 Feb 2025 06:15:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1740482149;
	 x=1740568549; bh=2JbZLuj3gbAS/CbcAaVAbFtDG+KHZF7DLmbgxyIVdWQ=; b=
	INaGGT129xfkpqF5JmO4oiulg/DKpw8utIl0dIVUsZGJm5YiASR6S1TENPbFLpj8
	rJRQG1lViCOHdykU8p0eK71aKnJtjmzATZ8XaI51JtoMhcSDJXI2gbITN5PVebLg
	eKUleHAZGBNwAoyEd/SYQBNVhmIEd71BPuJ/r7BUAmdVV65/2BDN1dfjxlgNPCn4
	uxP6S35gSCgR2BM2xykMr+0jwhrARJ6IwsIeHFdVK8wy6IlgnI9yybu+PhtVhAXQ
	U7ok/yWrOGRJ5YOteNgGGEVjvjs1/Y/rXXHUkjQGhM/r52xoHxndSfQKy+vkyk3c
	b6pSNRO70aJf8Ct1EzcnMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740482149; x=
	1740568549; bh=2JbZLuj3gbAS/CbcAaVAbFtDG+KHZF7DLmbgxyIVdWQ=; b=j
	FgehLMga9x22Qe1q+5CdaggFBURAIfb7eEv10MkS1W40Lp4nbDeU4WvPavX+9FTV
	cSppr8+Iy6JSRPW4ce7x7hVLw9k1VcjWX29hExnx71l7AHGKyAGUCbTzUpMbGo+e
	2YgP5FuC4ZB782MKAqBXnj9IM7/eFUwWAVme5HeMajKXj6lp27yJgIwNYr8Vsi2f
	W9gtCxajB6gwrM8aASF4JwvAb872PDprYL4TN+m1B4iq98Dznsy/xJnYQ6J5QLqH
	TvvolAI4ii0v8ecCSudhyxNhlSBGvcojG3Mmi5U4BiOUTbCRhrC0l+YokQ58s+IG
	pNsmuG553BWU4UZcMAZUg==
X-ME-Sender: <xms:Zaa9Z4cWoi5hJHhCXT2ocnSVnM-UgwFpUA2sGuO0TfBsn60U90PwmQ>
    <xme:Zaa9Z6P9qpnKbh-2mjWdjynBBzzI2e_KUgJegRkFVF2mQ7pOroaBq7QBGV4KucylJ
    8mH6bn28XRrcbrkUV8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedu
    vddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghhvghlghgrrghssehgohhogh
    hlvgdrtghomhdprhgtphhtthhopehkihhshhhonheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheplhhpihgvrhgrlhhishhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehshh
    hurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghnihhvrghnnhgrnhdrshgr
    ughhrghsihhvrghmsehlihhnrghrohdrohhrghdprhgtphhtthhopehkfieslhhinhhugi
    drtghomhdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdr
    ohhrghdprhgtphhtthhopehhrgihrghshhhirdhkuhhnihhhihhkohesshhotghiohhnvg
    igthdrtghomhdprhgtphhtthhopehguhhsthgrvhhordhpihhmvghnthgvlhesshihnhho
    phhshihsrdgtohhm
X-ME-Proxy: <xmx:Zaa9Z5jIUjGNPM7FPng7NDjphrrovOju_7eZ94LYXhw9foJOGaLT3w>
    <xmx:Zaa9Z99ke2HCyobHq4MO9qjaYbCWIhRUvYqplTd2CH-2Y2lkKDskmA>
    <xmx:Zaa9Z0sRAvrNSkVtpekX9qLISUUgIndLgjCvEtHzSb9yzKMkf-XLcw>
    <xmx:Zaa9Z0FbdcreJf6cFTCWEY0WdJh7VDyMMjFlH_-J3QhK45D6PC9HIA>
    <xmx:Zaa9Z0HAjEqJyRKrvKu-xQBO8IDK3eyNTWbHzJ2ikyujrBkEQ0lZh-8t>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0332B2220072; Tue, 25 Feb 2025 06:15:48 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 25 Feb 2025 12:15:28 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Kunihiko Hayashi" <hayashi.kunihiko@socionext.com>,
 "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 "Kishon Vijay Abraham I" <kishon@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 "Gustavo Pimentel" <gustavo.pimentel@synopsys.com>,
 "Bjorn Helgaas" <bhelgaas@google.com>, shuah <shuah@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Message-Id: <05d8a0bb-2b75-44ac-855a-1abcef5f09c2@app.fastmail.com>
In-Reply-To: <20250225110252.28866-7-hayashi.kunihiko@socionext.com>
References: <20250225110252.28866-1-hayashi.kunihiko@socionext.com>
 <20250225110252.28866-7-hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH v4 6/6] misc: pci_endpoint_test: Do not use managed irq functions
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Feb 25, 2025, at 12:02, Kunihiko Hayashi wrote:
> The pci_endpoint_test_request_irq() and pci_endpoint_test_release_irq()
> are called repeatedly by the users through pci_endpoint_test_set_irq().
> So using the managed version of IRQ functions within these functions
> has no effect.
>
> Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

