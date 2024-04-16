Return-Path: <linux-kselftest+bounces-8184-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9858A70DB
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 18:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6BFE1F2153A
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 16:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05BC131737;
	Tue, 16 Apr 2024 16:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EPXDvwcD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A2912BE89;
	Tue, 16 Apr 2024 16:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713283564; cv=none; b=m8RtjIECYZbUqeBungmbfaaHfq7AHGTWVrfj09HQM0cNeXZQ80A/dE8V9f8G/nSwlBPT66IXUfh3SkhZf2O4LlmeNA7uKUJO3aI682QI5n9ALGAKuuE0al+XTyWH75kfJznHA3xmtyhiOpC1jAIhuIMfN3UyUbzpPWFQd9LtxWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713283564; c=relaxed/simple;
	bh=cZE7572WdaMnw0VhxC7qCiWzqmrsC8CaXvTFf6wdSLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYjZpRGDuUqqSrEycwKL/OYB6IPX1dZmwiDav0OTw3l40uq9jL4zZZvKQiaAR3Jneyb6gX0+pgfV+ScbKGTUQCNj23YwPrKC5QJyPj/b/1UdsPVUN+YIN2Q+WE8w0bhyyGgU6arvudmVZhVp3tnssgvfmzBBj2ZEJ1uwRXzSYm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EPXDvwcD; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cZE7572WdaMnw0VhxC7qCiWzqmrsC8CaXvTFf6wdSLQ=; b=EPXDvwcDV25K1tkyw7t04oEjJR
	HeTR0KCVpO2bp9NYq7GsNtppql3IYgNPLLdSx8a34OJtQZw2jJ956uNvekw0yLIareJw/53gC4Eco
	im/P33QtjQci4VEex9d4xAWCgA1+kN3t3sR0V98Au52DHnikQg4fjYBbdVczJKN/n0SYiB5Q+RgYc
	fNJyFl9Lz2ni35575OdHPM0XvZ4hRqpZ9ddptkJSY9yJm1sbHTInSnfIj0mnVl/AS3aosZGsjDbFe
	iWWNUIUQYqrcy3/gwS2s0ytCFC/OaSEaso6fhLrxeWGr98pCu5SyFQXE33iRLc3bdKqgHEYJjEfHG
	7z1+y+tQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwlJh-00000000suB-2YgI;
	Tue, 16 Apr 2024 16:05:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 45FB830040C; Tue, 16 Apr 2024 18:05:53 +0200 (CEST)
Date: Tue, 16 Apr 2024 18:05:53 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Elizabeth Figura <zfigura@codeweavers.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	wine-devel@winehq.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Wolfram Sang <wsa@kernel.org>,
	Arkadiusz Hiler <ahiler@codeweavers.com>,
	Andy Lutomirski <luto@kernel.org>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v4 00/30] NT synchronization primitive driver
Message-ID: <20240416160553.GA30707@noisy.programming.kicks-ass.net>
References: <20240416010837.333694-1-zfigura@codeweavers.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416010837.333694-1-zfigura@codeweavers.com>

On Mon, Apr 15, 2024 at 08:08:10PM -0500, Elizabeth Figura wrote:

> The intended semantics of the patches are broadly intended to match those of the
> corresponding Windows functions. For those not already familiar with the Windows
> functions (or their undocumented behaviour), patch 27/27 provides a detailed
> specification, and individual patches also include a brief description of the
> API they are implementing.

You happen to have a readable copy of patch 27 around? RST is utter
garbage to read :/

