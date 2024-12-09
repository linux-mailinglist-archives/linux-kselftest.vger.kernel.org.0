Return-Path: <linux-kselftest+bounces-23095-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 253079EA038
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 21:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C8A91665BA
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 20:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425A91991BE;
	Mon,  9 Dec 2024 20:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Y+FgGJjg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oBMFyKmr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162A6137930;
	Mon,  9 Dec 2024 20:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733775903; cv=none; b=qP2eEjKZYKDbB4ZqPKQUmQpUWxr/xIz2jkG3xeD2Zl4whpjN5PDF5n+xwRlSZb1Yi/UR2iTwDOEWkJDWdjyT0qb5XQpdYxq8a3PX8nlTYaUidfd2KaRIpIHhmvfdAv3kpo6FXzddqRch+q5u1HudhIPTAbIIoEzEt2Uu1YIvslw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733775903; c=relaxed/simple;
	bh=XuKBFWV7sMghAAmzDDKU+oCHGfAkAlfcmzNHpZekxVQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JegIBF6dzeHlzhruob8RHUYbAtV7N7AeYedNFrsiFI0Fm6FuJhLHOh3mXfnvOhOIeVqKY698vHjN1464+rgoU90ljh/KZP08wpZrJzx6AIKX9zscclg8ozJ66MSIqgSPG6Kj303YGruZvfqBLESD6OBGb5GjpeD9dy4TPEQQeSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Y+FgGJjg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oBMFyKmr; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A4B0D2540134;
	Mon,  9 Dec 2024 15:24:59 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 09 Dec 2024 15:25:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1733775899;
	 x=1733862299; bh=7nBQV0r1Z6owX5pPf4OHPRGvFvNjhi2kLUsShxYzxTA=; b=
	Y+FgGJjgE7DjoPbcS1qP/5uI7Me93cdrBCVHyKOxXkH47zTCamvc/EvP3NXwQsfz
	55Dipba8f150WJkyeXGaHWX74f6bBAkg8wYpANvvtRUE4GNr4BDA6MyZ2BO6i86J
	BZ7a4gS8ZK9aJQHNSeXpaUWNoFzkt2G8GCSBLCfE6We2sVkZBANru7JM0L5ZBjZl
	L0ExChA+SI0TVXpIc5ZhWLSYVawtqFFA185cSfrRl9CdIWizvR7AjXYAcbWNh0FM
	Cu41cFBso5T7uvrRNYXFJW1ZSobDjOi6Yfddn6TFwb0RVjuKbAh4cRby94NTYu6O
	XtZZ+KWSsvICUYysA/AbrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733775899; x=
	1733862299; bh=7nBQV0r1Z6owX5pPf4OHPRGvFvNjhi2kLUsShxYzxTA=; b=o
	BMFyKmrEByxEBKpSJBtm3Cs8nP2DshO8oVi+cqvLlAcceOVzETEXN6kwCuMB2aR/
	whT8eS3P1noj6WmG3vRKNOQc330TXwKReWL4lENhNOZn+l31QthegZST7uxBiuz2
	jTv3eR/UFzTM5oA2ckxkl+czRuybj3mHkdZhgxARRz92r4VbHIyDnHrsZh+h6l32
	ybDxIZnjbfVyuS+CctrIqnNcbnHFCjB0U9QeZkR9thj5VzCFS/2D/KCrum5aSFUw
	IzhHs5mC8X5IhMNiVoh7emiGczX0uzOYAnHYyGiJBCMXHIsEWGBcAmq5izb4Ehwh
	wot/1c1v9McX3Zem4Z+kw==
X-ME-Sender: <xms:GlJXZ0DC1UoxTnNgvwmK5b10zTMWbDXkFKn_C77GhpSDdfqL6-0HtA>
    <xme:GlJXZ2hRf8T7tcDwwx2l4dKQACklsLhhOPDCn38RNfa2ae91ANZBmj64bxjaAcNLp
    3P9pOwzED3wFeqCDII>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeeigddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhepfefhheetffduvdfgieeghfejtedvkeetkeejfeek
    keelffejteevvdeghffhiefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghr
    nhgusgdruggvpdhnsggprhgtphhtthhopeduledpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtoheprghhihhlvghrsegtohguvgifvggrvhgvrhhsrdgtohhmpdhrtghpthhtohep
    iihfihhguhhrrgestghouggvfigvrghvvghrshdrtghomhdprhgtphhtthhopegsohhquh
    hnrdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthhopegrnhgurhgvrghlmhgvihgu
    sehighgrlhhirgdrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrug
    drohhrghdprhgtphhtthhopehrughunhhlrghpsehinhhfrhgruggvrggurdhorhhgpdhr
    tghpthhtoheplhhuthhosehkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhhurghhse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:GlJXZ3lxmUBNgqZglI41ov6B_st_qnsjIqoqSdrfDsB4U2jTK3tEmQ>
    <xmx:GlJXZ6xytyvn_fpISdI0Vu9IdWb13Ze8sjx26b3fEb1A8wiGqz4TqQ>
    <xmx:GlJXZ5Qf9oicq92JHSQS0jUsPnX60MDCXFJoLnVxnxzIPlh-qnZXug>
    <xmx:GlJXZ1YGgWbn2dBE-VBAeZOCrY4wO5E9YK8PX45w6W1Ib_U7pfYMkg>
    <xmx:G1JXZ6LqqNGLkHV7IHrSL7YrACb8ygM4GmVT8J5GNkBLJQRrfOGQ8Des>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C47632220072; Mon,  9 Dec 2024 15:24:58 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 09 Dec 2024 21:24:36 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Elizabeth Figura" <zfigura@codeweavers.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jonathan Corbet" <corbet@lwn.net>, shuah <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 wine-devel@winehq.org,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 "Wolfram Sang" <wsa@kernel.org>, "Arkadiusz Hiler" <ahiler@codeweavers.com>,
 "Peter Zijlstra" <peterz@infradead.org>, "Andy Lutomirski" <luto@kernel.org>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 "Randy Dunlap" <rdunlap@infradead.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Will Deacon" <will@kernel.org>, "Waiman Long" <longman@redhat.com>,
 "Boqun Feng" <boqun.feng@gmail.com>
Message-Id: <a6ec954d-7794-483d-a1f3-d58d33c5fc7a@app.fastmail.com>
In-Reply-To: <20241209185904.507350-1-zfigura@codeweavers.com>
References: <20241209185904.507350-1-zfigura@codeweavers.com>
Subject: Re: [PATCH v6 00/28] NT synchronization primitive driver
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Dec 9, 2024, at 19:58, Elizabeth Figura wrote:
> == Previous versions ==
>
> No changes were made from v5 other than rebasing on top of the 6.13-rc1
> char-misc-next tree.
>
> I would like to repeat a question from the last round of review, though. Two
> changes were suggested related to API design, which I did not make because the
> APIs in question were already released in upstream Linux. However, the driver is
> also completely nonfunctional and hidden behind BROKEN, so would this be
> acceptable anyway? The changes in question are:

If it was impossible to use the driver, there is no regression.
I feel the entire point of marking it as broken was to be able
to add that type of change.

> * rename NTSYNC_IOC_SEM_POST to NTSYNC_IOC_SEM_RELEASE (matching the NT
>   terminology instead of POSIX),

No objections my me on either name.

> * change object creation ioctls to return the fds directly in the return value
>   instead of through the args struct. I would also still appreciate a
>   clarification on the advice in [1], which is why I didn't do this in the first
>   place.
>
>   [1] https://docs.kernel.org/driver-api/ioctl.html#return-code

The git log tells me that I have written that, but I don't remember
why I put that in, maybe someone else suggested it.

My feeling right now is that returning a file descriptor number
as a small positive integer from the ioctl() return code makes
sense. On the other hand, returning pointers, negative signed
integers or large (> 32bit) 'unsigned long' values can cause
a number of issues, so I would avoid all those the same way we
discourage passing those integers as a literal 'arg' into ioctl()
instead of going through a pointer.

So either way, this looks good to me. I also looked through the
series again to double-check that you avoid the usual common
problems we list in Documentation/driver-api/ioctl.rst, and
I found this is all fine.

So with or without the two changes you listed:

Acked-by: Arnd Bergmann <arnd@arndb.de>

      Arnd

