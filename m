Return-Path: <linux-kselftest+bounces-36102-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EB2AEDFB3
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 15:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E241E7AA866
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 13:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21D028B507;
	Mon, 30 Jun 2025 13:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BFOhlHRA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F007528A73D;
	Mon, 30 Jun 2025 13:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751291672; cv=none; b=C3i4jhRSsu27qWkeWuHN37x0JO44iWv8+KGd/fC84z4zGwCUFPgCTjuUJRDiACW+WQwi7GrCR7Knvfu/AJKd75H7ReW4DDj/DeFLbMgUTusmR52foohOkfjZdB70dJDS9tbK4ZZD20LGCh8QPR7ZwiwLeV6jnDzAJiPrPNHdtmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751291672; c=relaxed/simple;
	bh=GkBEBxrczIeCPGmkISnsYwrHn6krJqLwvMJkPaKExVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rb12XMZLqJUxyam1b5MxlOP6iKNqOFRUz+DcUtqguOjsaGLm5AUJCFeqbnOqSvdmp1ANn5qI6NBg/ccX0bGkJ6KG3qapx8g63QMd9NOR7gR6JFbyA1hRZu3D6ZcBuUdQF1+HkVuieYNEuFm6hly8QEmsnK71rHnp0bzAtTNJdZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BFOhlHRA; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id ECA90432F7;
	Mon, 30 Jun 2025 13:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751291668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YJ9GqCVgLtkae7Bb4itEhNyEy6V+i1VqDMhDhBJ0g2Y=;
	b=BFOhlHRAJjg0Yp9B2Ovp4rUo9I8+h0XO2JryszxMxBZRWbRsK9poXI6spw5HefNbkKfxV0
	ylkUbdW91HVSScIwJd8ik60DMXQlg23rufWXJQ7oKSAAWDCUqy9InGXo7+PjBDXLAHuKkf
	YNBTDcu5AuloaFSETcUuoaCHvHamMN3hLDQz5jELZ3MHZdSQnhAh5dk+PqxM85xDnMZyo7
	YRNQfn03RvbXGT5kyHgO1oRKkZt9cyhYrRlXKKuRRpd/TPEQ+rmgBtPlfHv4phG/LLuSlH
	LngZkPqdC/p1rkLPCtr2OjnUuwrMMCFTJ5XeVIBS09Hso5m+dOHgCF4stWWfpw==
Date: Mon, 30 Jun 2025 15:54:27 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH resend] rtc: Rename lib_test to rtc_lib_test
Message-ID: <20250630135427faa6c326@mail.local>
References: <df1a73d4a14426ae0d3e8809aed40c686b67dd3e.1751268290.git.geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df1a73d4a14426ae0d3e8809aed40c686b67dd3e.1751268290.git.geert@linux-m68k.org>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudekjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehlvgigrghnughrvgcuuegvlhhlohhnihcuoegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegieduueethefhkeegjeevfefhiedujeeuhffgleejgfejgeekueejuefgheeggfenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmedvrggtjeemfhgvgegvmeehiegrugemtgekvgegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmedvrggtjeemfhgvgegvmeehiegrugemtgekvgegpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeekpdhrtghpthhtohepghgvvghrtheslhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtohepsghrvghnuggrnhdrhhhighhgihhnsheslhhinhhugidruggvvhdprhgtphhtthhopegur
 ghvihgughhofiesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprhhmohgrrhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrhhttgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkshgvlhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhunhhithdquggvvhesghhoohhglhgvghhrohhuphhsrdgtohhm
X-GND-Sasl: alexandre.belloni@bootlin.com

On 30/06/2025 09:47:54+0200, Geert Uytterhoeven wrote:
> When compiling the RTC library functions test as a module, the module
> has the non-descriptive name "lib_test.ko".  Fix this by adding the
> subsystem's name as a prefix.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  drivers/rtc/Makefile                       | 2 +-
>  drivers/rtc/{lib_test.c => rtc_lib_test.c} | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename drivers/rtc/{lib_test.c => rtc_lib_test.c} (100%)
> 
> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> index 4619aa2ac4697591..aa08d1c8a32ec23d 100644
> --- a/drivers/rtc/Makefile
> +++ b/drivers/rtc/Makefile
> @@ -15,7 +15,7 @@ rtc-core-$(CONFIG_RTC_INTF_DEV)		+= dev.o
>  rtc-core-$(CONFIG_RTC_INTF_PROC)	+= proc.o
>  rtc-core-$(CONFIG_RTC_INTF_SYSFS)	+= sysfs.o
>  
> -obj-$(CONFIG_RTC_LIB_KUNIT_TEST)	+= lib_test.o
> +obj-$(CONFIG_RTC_LIB_KUNIT_TEST)	+= rtc_lib_test.o

I'd rather have test_rtc_lib as only the drivers are currently prefixed with
rtc.

>  
>  # Keep the list ordered.
>  
> diff --git a/drivers/rtc/lib_test.c b/drivers/rtc/rtc_lib_test.c
> similarity index 100%
> rename from drivers/rtc/lib_test.c
> rename to drivers/rtc/rtc_lib_test.c
> -- 
> 2.43.0
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

