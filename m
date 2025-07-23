Return-Path: <linux-kselftest+bounces-37890-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E526B0F87F
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 18:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E7881C84160
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 16:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14730204C1A;
	Wed, 23 Jul 2025 16:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DUozZG12"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AC120126A;
	Wed, 23 Jul 2025 16:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753289694; cv=none; b=LAeyMSelRJ1WGTSPh3j8s9H/JdZYZ3iQxaou24pyl3gLzGZJpbwjqCpa6ZYLSIG1/zSjdUZcclPl7RZcwHVpwArrdXANH/m8zV369HaCB4LsKkCxMOIUk+HQzbSMT+RKZxu8I5P9XlM6QzyZz3xd4QLbVRzRKxfdzmH8MBEU9x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753289694; c=relaxed/simple;
	bh=6EGV5oVqnt2HJv/uuL6WTaHCm4vulgYtHw0OHP8srZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2AEbgNxn6mUFBA9ec/Zl7/Poqj+d8j831Bmsj0wogAL3QdKCipIglFTYMwoOLIQA2LQPPMsRSPfny9Da352tjacY4hD1u8uVnt6HZszSjx1CXB8DxomZkKjdqm3BDbwd/5S6eEHxUV0E4G6amPXGuehwlv3ADXPvBN4xd86viY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DUozZG12; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 60D4744200;
	Wed, 23 Jul 2025 16:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753289689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oh4dfa/0L3B39iTg6k0Zy0MlKxBfFSrzu1Ttqr6MqPg=;
	b=DUozZG12DcyE2hA3klfjMeAylEK8f7X3ghRiX83HQoSgXjeTAXkI2srqRVetL2D/GaXSe9
	5ulOJM47G3mtg0FPw8DfTcPtrqSOIkMj/CAa4Mu+WSskHSTZC0JT3vTLd+f8DtLiH8yGnW
	jnnIBPsQ9SfSBEKwTb2gOOI0Ux6gc2LR22bu4f1dhoKsmtEe6Rj5fXbuSGyiG1aHaqTcpv
	LzPAd52w/s9y55hBexLgyiCdIZPIAUFCTbjRzofyLuFUJgzlZzCWGZi8TSicSmf4MfWpij
	amHgHMLHbNSzbApEOO3vGFOzy7RiuYa20irQ+2QA7XhxEcXz+0eQzn7Sdaq4hw==
Date: Wed, 23 Jul 2025 18:54:49 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Subject: Re: [PATCH v2] rtc: Rename lib_test to test_rtc_lib
Message-ID: <175328962919.785597.17989599955686169611.b4-ty@bootlin.com>
References: <47019d7f8ced12107b54a372fdf34b1b8f7b6183.1751355848.git.geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47019d7f8ced12107b54a372fdf34b1b8f7b6183.1751355848.git.geert@linux-m68k.org>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejkeeftdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehlvgigrghnughrvgcuuegvlhhlohhnihcuoegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeijeefhfffkeejueehveeuveejvdelveejteduffehuedtffdufeejudffuedvtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemvgdtrgemsgeiheemsgdvfhdtmeeksgelkeemjeeltdehmegrsggvleemudehvddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmegsieehmegsvdhftdemkegsleekmeejledtheemrggsvgelmeduhedvvddphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomheprghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepkedprhgtphhtthhopegsrhgvnhgurghnrdhhihhgghhinhhssehlihhnuhigrdguvghvpdhrtghpthhtohepuggrvhhiughgohifsehgohhoghhlvgdrtghomhdpr
 hgtphhtthhopehrmhhorghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgvggvrhhtsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehlihhnuhigqdhrthgtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhhsvghlfhhtvghsthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhhnihhtqdguvghvsehgohhoghhlvghgrhhouhhpshdrtghomh

On Tue, 01 Jul 2025 09:44:39 +0200, Geert Uytterhoeven wrote:
> When compiling the RTC library functions test as a module, the module
> has the non-descriptive name "lib_test.ko".  Fix this by renaming it to
> "test_rtc_lib.ko".
> 
> 

Applied, thanks!

[1/1] rtc: Rename lib_test to test_rtc_lib
      https://git.kernel.org/abelloni/c/0c6f0d77ab62

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

