Return-Path: <linux-kselftest+bounces-8240-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF418A7BCD
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 07:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2BC51F23697
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 05:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9603D52F80;
	Wed, 17 Apr 2024 05:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cM5NmnHk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B04524BC;
	Wed, 17 Apr 2024 05:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713331500; cv=none; b=BBj6rJjOhyi8t1w1qPZTpsX6Hz+TzN2WokCvcwdcvOcCWDoAU1D3UmDXuHF+OqW6OkTttx8CqjkVo4IShO5tpjjViDCj4fwvf20oxfRSc6PitFz7SGRLYyyrYO94s/nXYTs5QmNHMr0m1KolEbVYcahacc/r3Sb8JCKywl3vudY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713331500; c=relaxed/simple;
	bh=Mh6lo95EntE4U9gD7xEgGnxAeRn1jgyseUr4/IiZXms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udCrQLccwhbCYg9VJNHR4gHbCyAb6RkoQvHUV/5t/+HdsZNbpjad1EC/B6dfdsEkL2bfeKEM3pZcQdjzI6UrqFH1hqCmkursY7l1Qf+983C7lsBzlVLNKx+triJd2aRV7yE/UGCpgJSj6nXoWt3GjX1MjDFXxcWfFbBWCHMfLWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cM5NmnHk; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=003sfHDDqVQT+lz1rgPd+SoevD4ApEiyNQ8RI/VFzsw=; b=cM5NmnHkNNtvgv84U/LwxiMc2l
	RKxtkw+kldotoc6n125+fBi23wZ6DhzawjJEVS+pVNtBgyN6tFZJn+RogPVC8dCpBKMv3MiVWAQ6G
	pq2cuGdSEeT3UTx7f8Cwn3jnfULVdvOMpS86LBV1UEL8BtbprPer4ebvZh4CdkBlbIlwt87a1trts
	SpNASGKoL8z6ESbpXBcM+Q9jB3BZBIsO5UGyEdAdjztHIFefNj8a7mq5TwjqbiuZ/WBmtgIYVxIl7
	yAQsPEVygB2NvO2TcKIWeNjDk5FtgcOIXqebE7f6f9UjhfXH1uCKYWMjlmYd7A+9UCzTnHi6H6nzD
	D1gbBqig==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwxkR-0000000BPMm-1RVc;
	Wed, 17 Apr 2024 05:24:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 88D383005B2; Wed, 17 Apr 2024 07:22:18 +0200 (CEST)
Date: Wed, 17 Apr 2024 07:22:18 +0200
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
Message-ID: <20240417052218.GI30852@noisy.programming.kicks-ass.net>
References: <20240416010837.333694-1-zfigura@codeweavers.com>
 <20240416160553.GA30707@noisy.programming.kicks-ass.net>
 <2602449.Lt9SDvczpP@terabithia>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2602449.Lt9SDvczpP@terabithia>

On Tue, Apr 16, 2024 at 04:18:19PM -0500, Elizabeth Figura wrote:

> Let me know if that's good enough or if I should try to render it into plain 
> text somehow.

Plain text is much preferred. I'm more of a text editor kinda guy --
being a programmer and all that.
> 
> 

