Return-Path: <linux-kselftest+bounces-37884-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96301B0F7D6
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 18:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBFEB17FD18
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 16:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E471E1DF0;
	Wed, 23 Jul 2025 16:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="U1VcTZ3g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7CA28DB3;
	Wed, 23 Jul 2025 16:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753287044; cv=none; b=j3cTIA6c/giEulYJRiUe7ebG9om4Rb6PGuKRDcHhkzqF4HNS5JQn18Id8WXv1ut69ZqL5RjYgA7kPKmqdWAS9uu9tzCXLgBFWY6cqHNKDVfP+uZVniRmR9a0g6iLGBiLKOEQ7Y5L8MJZsv8FEsXDMpL7lSbdBjVQpasU+zwcgek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753287044; c=relaxed/simple;
	bh=tF967T+KWgJ50KV+Qc+CERy5sOsknJ76x0zLDhDHgR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWHvPDP2+mKNbTdBbwanLvzpvDKnSlthc01/w5oLdfDMWicmgziPbDMF41CGqJx1pbr6Mf+T9kKopV5W9dUj2cWVACiZThsgwAVshSi5xl0ShZKF1jnPGGTieLR1YBNQlHSkg8ndaVhFC+tmG0t+E8U5hx1bEHicXxUT1bMP3/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=U1VcTZ3g; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0B48243992;
	Wed, 23 Jul 2025 16:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753287039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nj70YCuUwTam2AqNIVl2NKxCEyhdlssS8xo9X223qzA=;
	b=U1VcTZ3guoeifJtwhMjyhMHPwebD2p/YWPGKZD1LWDOb7hq73Xm0k4p5Eyf+EXf52GBgow
	IIY8JYq2rhHLXexDIzMai2vWGBBm4TVyondrqG1Nrt91K6LinDVqnvZdT9duzPVzW86M66
	UHw322caKDfKyE4aDKzSSqYC53Rt2orZXm2V02mYmW0/I6hFEXjzI97LTwJml8ENL2TsiH
	iMW1Mp036Id3XrCT5ZmkIoOHYK3DPPnIzqLUNAnojvn5fDs7NpkUQnydbdkjhy2W2PXAGL
	Cph64tH8VBncPyT4wdW+tD77IOI+3jNrfx4UmPn9UQ5P0NtDpfh/G+p1WXXHxQ==
Date: Wed, 23 Jul 2025 18:10:38 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: David Gow <davidgow@google.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] kunit/rtc: Add real support for very slow tests
Message-ID: <20250723161038ab6abef0@mail.local>
References: <49d57ab512c47f01d6c374d533f1752871ea4246.1743091573.git.geert@linux-m68k.org>
 <CABVgOSmxsXEyLVyhhffhXUXf3-QnGmZurXaRhpiK8w894mrwzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOSmxsXEyLVyhhffhXUXf3-QnGmZurXaRhpiK8w894mrwzg@mail.gmail.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejkedvudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehlvgigrghnughrvgcuuegvlhhlohhnihcuoegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegieduueethefhkeegjeevfefhiedujeeuhffgleejgfejgeekueejuefgheeggfenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegvtdgrmegsieehmegsvdhftdemkegsleekmeejledtheemrggsvgelmeduhedvvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemsgeiheemsgdvfhdtmeeksgelkeemjeeltdehmegrsggvleemudehvddvpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeekpdhrtghpthhtohepuggrvhhiughgohifsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgvggvrhhtsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopegsrhgvnhgurghnrdhhi
 hhgghhinhhssehlihhnuhigrdguvghvpdhrtghpthhtoheprhhmohgrrhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhhsvghlfhhtvghsthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhhnihhtqdguvghvsehgohhoghhlvghgrhhouhhpshdrtghomhdprhgtphhtthhopehlihhnuhigqdhrthgtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: alexandre.belloni@bootlin.com

On 28/03/2025 16:06:52+0800, David Gow wrote:
> I'll get around to extending this to allow the "base timeout" to be
> configurable as a command-line option, too, if this seems like a good
> way to go.
> 
> >   3. Mark rtc_time64_to_tm_test_date_range_1000 slow,
> >   4. Mark rtc_time64_to_tm_test_date_range_160000 very slow.
> 
> Hmm... these are definitely fast enough on my "modern" machine that
> they probably only warrant "slow", not "very slow". But given they're
> definitely causing problems on older machines, I'm happy to go with
> marking the large ones very slow. (I've been waiting for them for
> about 45 minutes so far on my 486.)

Note that as discussed elsewhere, I'm open to simply remove
rtc_time64_to_tm_test_date_range_160000. It was a nice proof that he change was
working at the time but I don't think it is necessary to check this range.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

