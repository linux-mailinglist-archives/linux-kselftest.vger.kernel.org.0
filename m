Return-Path: <linux-kselftest+bounces-8239-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA958A7BC9
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 07:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9FB91C219D8
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 05:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E98B524CB;
	Wed, 17 Apr 2024 05:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KbK5xaDt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1BB3C68C;
	Wed, 17 Apr 2024 05:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713331499; cv=none; b=K/8jHhwsN78vlVBovvXi5renYgbdYlEhOTAlSmI7L2FE6xQCA+hIp/+WF/6dm36AJKqX3uGEcGqFUl7t7yA1kK7CkPuSXuWTqLFfJQHSpVJIQoxyyRPWHJmt/AZDEuffyNGZ5SSx25Nk/6XIcIsOzmHCe2jAM31wrUwj+sDVRhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713331499; c=relaxed/simple;
	bh=7rKJ7+aUCMuSiNXhwbE4neIbRD9mUgAthiVxifFFieM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXGthkJBV0oHSvuJOuZ9fivt6wJjnEYjZ60yfIqx5ScLY3zAa30YHR30Hi2QITDSAf6sPAUTZzeSqJHFK3FQx51h99heFji9ny3lMlXwrQmS1ny/on+0TJYYLn865VyPbYtLyVci7VaDEEX7oE5eZD7B5MOdqwxLt94Q/1NSn1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KbK5xaDt; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0Zb05ELMV8IYVpONILa//RiQ8KMHjDy5dS1Ui7wZZIk=; b=KbK5xaDtW9UhzyDh8OdiTg+ZZX
	uR93nvOWYmyia9U6xBV1hqAwhN4waN69Ese3JEAVDYFv7KQQXiBSaR7G1eUlLGsyPn91f/d2qzcVd
	hlVJJYwhB5gxkpW5RhjeLnDLNA95rkEPwFQ06I2bmx1UZHlr0ahbR7drrMAgCk0zkLaO2fREW8RtL
	bPzqgSifjMPJVauO8nbLV5EfkwnXBxdAvurPcA1ZPPHo9H8DkcvlJIuY4FbuRlz61NVCJPC/kyPjR
	1tkuJ7dKZ4Z/aa++phY/zPLqy97BmEc7CFoNjMikPWp9kQ9/d7nit+cgA5kXAw8YSgrrES2aaIjPc
	5LY3DFxg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwxjU-0000000BPLd-03kV;
	Wed, 17 Apr 2024 05:23:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4410930040C; Wed, 17 Apr 2024 07:21:19 +0200 (CEST)
Date: Wed, 17 Apr 2024 07:21:19 +0200
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
Message-ID: <20240417052119.GH30852@noisy.programming.kicks-ass.net>
References: <20240416010837.333694-1-zfigura@codeweavers.com>
 <20240416155345.GC12673@noisy.programming.kicks-ass.net>
 <20240416161917.GD12673@noisy.programming.kicks-ass.net>
 <23472492.6Emhk5qWAg@terabithia>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23472492.6Emhk5qWAg@terabithia>

On Tue, Apr 16, 2024 at 04:18:17PM -0500, Elizabeth Figura wrote:

> Over different lists. I don't know if there's a better way to name things to 
> make that clearer.

D'oh, reading hard. I'll stare more.

