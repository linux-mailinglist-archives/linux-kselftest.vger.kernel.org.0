Return-Path: <linux-kselftest+bounces-29984-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BA4A77B9C
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 15:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0A3816B093
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 13:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743B21FC0FA;
	Tue,  1 Apr 2025 13:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cDo6wWp9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAFF1DEFE1;
	Tue,  1 Apr 2025 13:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743512670; cv=none; b=JyPK10qA2dVuHz+kZZk23M4lT9CJB2PSUxQV2/ji2rQEf+6fx4uuhPJFiyL/UU82eP1HeQjPxRfCsfr+N/N+NCZ5yHSgPHxBVdCA02z+5BVSAPnjJTpW2rZqOIBHwfkPtluTvDo6OKGRo7hD3s6cjeKhZfMO4bGAbFpeSDeTddQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743512670; c=relaxed/simple;
	bh=eHqludk6fP5eQk7OwGo/s6nwD+Rn420X1O0Q8YNxZQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1xPRmsurF/BK2v6oKhVMN13GuJCkMQqlZIZO2NhAyvQWKiH7l8e+KFOr5i6avA/Hc8vXzMgt1nVvgeTle410E0UUNYu6OfjibvEQg2bb5QaRymSkv5FcesJ1jYxTE/hNHhMpDhOlXhB2hbLpA74hc3DD1lhk7+NnZpR6Ci3UF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cDo6wWp9; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 43964432FA;
	Tue,  1 Apr 2025 13:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1743512660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QQZxdATdz95KxoNwpFI+ZgEGxddqiOo4jL6SkpKzPxU=;
	b=cDo6wWp9hwWBq/4aeX7UEmEBUPVkziBGCClqcOj9qdU4YT4oheJc2rmzhuRnEtTcwDDD3v
	oQAtvjejvSbV6EVCEwxqWGc1moc/ggdcj8VlEzoKzxCD8M8EtfjNpZPrEwBm5X/zCZPkZv
	4cZVFgn1WwCLvapGzV2IIqd6hHwf6+BgplKqVjigo5Pgf52uIgRXzQU2DsWgziw7EX875U
	IdoGqXx/Q//kX8Abs21d/H8lf9Y+h6hfMjOWxNB4UKRGrlsyk8LmQfwIUgcKT+8xP0GqYr
	ZE7ZwDpUzv41WqaY5FWbWfl1tMfPdMRoJBBl4WoOc4bimNA8JDnWSEIAAb01Aw==
Date: Tue, 1 Apr 2025 15:04:19 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-renesas-soc@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Joseph Jang <jjang@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftest: rtc: skip some tests if the alarm only
 supports minutes
Message-ID: <174351260008.1895066.11736723802709414744.b4-ty@bootlin.com>
References: <20250218101548.6514-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218101548.6514-1-wsa+renesas@sang-engineering.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukedvkeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeetlhgvgigrnhgurhgvuceuvghllhhonhhiuceorghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepieejfefhffekjeeuheevueevjedvleevjeetudffheeutdffudefjeduffeuvddtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmedvrggtjeemfhgvgegvmeehiegrugemtgekvgegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmedvrggtjeemfhgvgegvmeehiegrugemtgekvgegpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqrhgvnhgvshgrshdqshhotgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeifshgrodhrvghnvghsr
 ghssehsrghnghdqvghnghhinhgvvghrihhnghdrtghomhdprhgtphhtthhopehjjhgrnhhgsehnvhhiughirgdrtghomhdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhrthgtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhhsvghlfhhtvghsthesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: alexandre.belloni@bootlin.com

On Tue, 18 Feb 2025 11:15:47 +0100, Wolfram Sang wrote:
> There are alarms which have only minute-granularity. The RTC core
> already has a flag to describe them. Use this flag to skip tests which
> require the alarm to support seconds.
> 
> 

Applied, thanks!

[1/1] selftest: rtc: skip some tests if the alarm only supports minutes
      https://git.kernel.org/abelloni/c/0cd73ab4df45

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

