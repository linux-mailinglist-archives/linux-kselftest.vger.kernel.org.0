Return-Path: <linux-kselftest+bounces-27440-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2B1A43D3A
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 12:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBF1D16254A
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 11:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C9D20AF78;
	Tue, 25 Feb 2025 11:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="mWeGPYYq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cl16CYMr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2386A3DBB6;
	Tue, 25 Feb 2025 11:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740482036; cv=none; b=J6Nnzj2CAPnEdk6CaitUoBJHwlSWzDfwmndNrtOWFeQPjFqaxxYT6iH4TQ9We31ROR1JDvx7oI2JjyStNYvzmyRwE3bJXPZlOoXp4Giku8qXm8JypQMEIZf5TnsesMuQf8x438nBK4JyqJmmy3AcHtXyJiVxgIinLyRXygHhey0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740482036; c=relaxed/simple;
	bh=8OZuyHpvsUVbfiGFhXm25KHhZEJBKdeeXHeNu3ALA4Y=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=R6i4mbzpQFSryjOpB1KPEVWX02WEzCEv+QqDrFwRh4JRm63yjG/DIqTpqYmjI/QBDnHeF4Px7CGrsQHnT40KIY04eHf0Zc7kWYHanE6nFl6jOwtqEIW8tjdolhtwrIDbdiJipduDrvZmLMr+Qgo626ftdTgyKMzGQXQzksdUJm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=mWeGPYYq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cl16CYMr; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AD0E425401A7;
	Tue, 25 Feb 2025 06:13:52 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-11.internal (MEProxy); Tue, 25 Feb 2025 06:13:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1740482032;
	 x=1740568432; bh=8OZuyHpvsUVbfiGFhXm25KHhZEJBKdeeXHeNu3ALA4Y=; b=
	mWeGPYYq0c+Voz1qnm2FhSsI7U8mrjHqAzAu62vmmyoS3DhDjhlDjb423TXNpojS
	N+8DfUEFJhpnrI71lzRaO23Ivf2oR5SUdxx4NMCeF/vlULuNWGtB21mY8iowjNqP
	2Pk9d47gwynUlIvZHnj/7P1ZMb6kAXhFuIBHw9vNCX/rOxrFOHG0FTFqpOwv4C8y
	xAeoaKR/7xtERIEuQOZnF2jzEZ6j5PV5xlv0trWawbxmbq7yOoObJuuOcRB8x1ap
	/d0zBKo7V0nfIecD8TdHqqw94IQqzOS3AdHSYRXAH5NN0/HTTCP2ovf343qNLq8a
	dYVlkT9KC2rfgUwoLozJaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740482032; x=
	1740568432; bh=8OZuyHpvsUVbfiGFhXm25KHhZEJBKdeeXHeNu3ALA4Y=; b=C
	l16CYMr3RfZCBZOPoHsg/fUIr0ytp7z4P+FMV7mbRiPIhK9UyfFU8679PxtgYbu+
	JdLwX1H9KzDbGQj5POLFfp0/4PE197XkeTqm5aCyeZzHR/VTu5Q6957bL/nOxjbG
	dGc0AbPUMFbsuCKUwSVhxUONUtFbPiIIe2hZXA4dCAQ9t/JjevvaKqRDjrXpJHes
	kJkSNHiE9SXDfLgz+nvzr4gRqfGEW7XGUkXMjwpc9a6wA8fBdDNZYFc+jL1gDpep
	xCkwMq2y6RTNk0P/lTIGdDW2onT8qCbT30YZIrODmKzh8/75DclN6twj0cuiuP8x
	bCDWp0tjaHFxz0hRK4fvg==
X-ME-Sender: <xms:8KW9Z5PunitMNPM4PYDZJczPgIO4hiJFlvvX16mJX078TOlX2zRL9A>
    <xme:8KW9Z7_CfQ7qGFN8kK3yeh0Orn9fOKe0JFJmHdPle3cfUNV4F6PitYd9zV_l9MO2n
    kjHK2oYMqqffKNlML8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedu
    fedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghhvghlghgrrghssehgohhogh
    hlvgdrtghomhdprhgtphhtthhopegtrghsshgvlheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepkhhishhhohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlphhivghrrg
    hlihhsiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepmhgrnhhivhgrnhhnrghnrdhsrgguhhgrshhivhgrmheslh
    hinhgrrhhordhorhhgpdhrtghpthhtohepkhifsehlihhnuhigrdgtohhmpdhrtghpthht
    ohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoh
    ephhgrhigrshhhihdrkhhunhhihhhikhhosehsohgtihhonhgvgihtrdgtohhm
X-ME-Proxy: <xmx:8KW9Z4Td90mKZqTBkvmK8xHIWtnOQo0wAPE6FgKUia1urs-w9AY8cQ>
    <xmx:8KW9Z1tVISLlzuXTNCAY8cZpzL1027zd185fK7i-g7dlXcoNayuUiQ>
    <xmx:8KW9ZxfeCFEvPWeUaRk2r8xDyRw_v1_mKLqZEPbjgfsJJW9tFVBW8w>
    <xmx:8KW9Zx3WaahY2phJachF8QGZ2TQx5wc7Uz3QI2Czt-twEQ_p0FYoiw>
    <xmx:8KW9Z_3_BcgusIHbm1RyJLyshHGnvdPXZxQndvKDNB5ePz0nTP8pc-gA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2BE2E2220072; Tue, 25 Feb 2025 06:13:52 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 25 Feb 2025 12:13:31 +0100
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
 linux-kselftest@vger.kernel.org, "Niklas Cassel" <cassel@kernel.org>
Message-Id: <87857a72-eca0-4919-8e1d-ff04b9047d82@app.fastmail.com>
In-Reply-To: <20250225110252.28866-6-hayashi.kunihiko@socionext.com>
References: <20250225110252.28866-1-hayashi.kunihiko@socionext.com>
 <20250225110252.28866-6-hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH v4 5/6] misc: pci_endpoint_test: Remove global 'irq_type' and
 'no_msi'
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Feb 25, 2025, at 12:02, Kunihiko Hayashi wrote:
> The global variable "irq_type" preserves the current value of
> ioctl(GET_IRQTYPE).
>
> However, all tests that use interrupts first call ioctl(SET_IRQTYPE)
> to set test->irq_type, then write the value of test->irq_type into the
> register pointed by test_reg_bar, and request the interrupt to the
> endpoint. The endpoint function driver, pci-epf-test, refers to the
> register, and determine which type of interrupt to raise.
>
> The global variable "irq_type" is never used in the actual test,
> so remove the variable and replace it with test->irq_type.
>
> And also for the same reason, the variable "no_msi" can be removed.
>
> Initially, test->irq_type has IRQ_TYPE_UNDEFINED, and the
> ioctl(GET_IRQTYPE) before calling ioctl(SET_IRQTYPE) will return an error.
>
> Suggested-by: Niklas Cassel <cassel@kernel.org>
> Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Nice catch, always good to remove global variables with too generic names.

Acked-by: Arnd Bergmann <arnd@arndb.de>

