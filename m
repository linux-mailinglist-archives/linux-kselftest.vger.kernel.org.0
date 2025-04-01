Return-Path: <linux-kselftest+bounces-29986-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB89A77C03
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 15:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E61A63A627A
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Apr 2025 13:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957A12036FE;
	Tue,  1 Apr 2025 13:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Uwi3+XDr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2442E339C;
	Tue,  1 Apr 2025 13:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743513942; cv=none; b=EGKUrYjgn2Ax4cgxb2r1gMfqlW30/CvKhIbVMXc/dqrYN6OvWj4O2TG+/HWOXK9zwgXRA6OmgOGYzFxHsGvilXk3N2UnDGFkyYjzQvycflcTYP/tp+2iSP1dwlU/QIjUGKOCBCrsIFK3KIzW2EHiTfQirCvqhcRyGa2LmIXeY04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743513942; c=relaxed/simple;
	bh=GF0f0tW/yy7LJt+K8rgG1YjCTGX9e9esahl5dJob6WU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTAmpRNEBz+VlmeTJSzoZAJ+otsGS0gI9C8ZJ0BPlE72TMk6ZCSaN/3At6d9nbG0p7fEu8jZx8M70JHN3oknfNuoTzpNAlyQL7ztbr/7yi84t+ygdAmeNOFDHjWSwNGcJ3BcSeIf89uk20QMeZtjNNUEYrZOA8KjP9zM3fXytz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Uwi3+XDr; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 31D1343225;
	Tue,  1 Apr 2025 13:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1743513932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MQJJR+MmBVcYBxIBU6ebSUNoaTlBV4Ecy42w00gsupQ=;
	b=Uwi3+XDr1ZO+vt1eXMUc+3ChmfMpLyduHd0CAWshp0zDvjC7RlZUH0zI7yuf32mEr2YVfn
	QJ1+8ZnzoELZcgdzJzzjjWl0mQrVBXI0LOOtAh8/fY+mgKhGMTLQsUAzIXraVJonqbGqW/
	GzXIzwsdfmnNNuvGieA+Nowa+1HBTt/2AWDKKPzBh5TzTe4eQRImC5cbDi122vaRCxZ5jX
	Gujig+dRuwVMsH1rfNXcbZ5/LZ6INEpz52c8X/wz0c5wAon9rlLz29gx5ZGRVENomDRi7z
	onPsdc0fAVgXQ3vVPZf0aOWlWV9LilF6E6qhMYmZ+kzX4ZBhFqnk8kjM68pwJQ==
Date: Tue, 1 Apr 2025 15:25:31 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-renesas-soc@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-rtc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH] rtc: remove 'setdate' test program
Message-ID: <174351392483.1898102.15304359813219677106.b4-ty@bootlin.com>
References: <20250320103433.11673-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320103433.11673-1-wsa+renesas@sang-engineering.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukedvledtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeetlhgvgigrnhgurhgvuceuvghllhhonhhiuceorghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepieejfefhffekjeeuheevueevjedvleevjeetudffheeutdffudefjeduffeuvddtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmedvrggtjeemfhgvgegvmeehiegrugemtgekvgegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmedvrggtjeemfhgvgegvmeehiegrugemtgekvgegpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqrhgvnhgvshgrshdqshhotgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeifshgrodhrvghnvghsr
 ghssehsrghnghdqvghnghhinhgvvghrihhnghdrtghomhdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhrthgtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhhsvghlfhhtvghsthesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: alexandre.belloni@bootlin.com

On Thu, 20 Mar 2025 11:33:54 +0100, Wolfram Sang wrote:
> The tool is not embedded in the testing framework. 'rtc' from rtc-tools
> serves as a much better programming example. No need to carry this tool
> in the kernel tree.
> 
> 

Applied, thanks!

[1/1] rtc: remove 'setdate' test program
      https://git.kernel.org/abelloni/c/424dfcd441f0

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

