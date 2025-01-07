Return-Path: <linux-kselftest+bounces-24029-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4FBA04A66
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 20:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2267165E10
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 19:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEBA1F63CC;
	Tue,  7 Jan 2025 19:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QlwVbvoG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87921F5403;
	Tue,  7 Jan 2025 19:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736278981; cv=none; b=Vd+Dy9DI0+XQMjazHLfv8XiYosQ5EqojVm02yM5ddVPG0HuIJlfDVvPy0i2tqGKnJXN45eA3p05falvVOTZf2iOLvo+gs8zr1PzRdrUKWfkWZYMkPuD/OBICtTrvv1RzV9ZVIqa8LEvnL7KNLXh0gLaQ1Kf3MCoi6gM/QmHj9z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736278981; c=relaxed/simple;
	bh=t+8uTRgj3gqX8+ziV9ohJ4mPjlVtEYUkCWJDb3GaK5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsYSwvmz6ePiVczTAveqIlZMaM+FLChQ33c4MP5fHFuVZkksB0TsI9oRTipBfEkvrsUDB6okbIFbDru8MdbhzXmJmvXiL1H5abTpj30ao5odjPo3eBaabYTlxy5epBJkKGhuv4JSVFeVQcppNfkjJxywv5Ai9grduAMnVHGEuPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QlwVbvoG; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=t+8uTRgj3gqX8+ziV9ohJ4mPjlVtEYUkCWJDb3GaK5U=; b=QlwVbvoG7US1jHkRaAadaISRMg
	Ebk/BIhZCjQJVmEM5/PXM6Y70U7WoeyHwrGsB69F+sT+2O7zQ4eQQa2LhUO5eKVKssduJjSEIBwRc
	XJQfOkmYJjwxmfscyOJovYCzOShOPFVXYBNYnh8sZOIUj5vWaCdrErMNV1/0Dz0Doc+VxPkNJnyVV
	U2GucMtnwSBkl3/c/1AQlVwCHxHtbebq3jvUONDsAUstkyNYinIrdpvQHkj9M0o4t16j6BeF9/Xl2
	dD3xRT+MBG1XtYZUeepPa+8fUWxzO+tXtY5umVquXF5SRG7nTIg52IFSUB3BylClROAi6SNxj6Uiw
	KkuFHPXw==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tVFTO-00000009C6c-0iJW;
	Tue, 07 Jan 2025 19:42:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BCAC630057C; Tue,  7 Jan 2025 20:42:41 +0100 (CET)
Date: Tue, 7 Jan 2025 20:42:41 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Elizabeth Figura <zfigura@codeweavers.com>,
	Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, wine-devel@winehq.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Wolfram Sang <wsa@kernel.org>,
	Arkadiusz Hiler <ahiler@codeweavers.com>,
	Andy Lutomirski <luto@kernel.org>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v7 00/30] NT synchronization primitive driver
Message-ID: <20250107194241.GC28303@noisy.programming.kicks-ass.net>
References: <20241213193511.457338-1-zfigura@codeweavers.com>
 <2025010738-amicably-art-f746@gregkh>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025010738-amicably-art-f746@gregkh>

On Tue, Jan 07, 2025 at 06:06:03PM +0100, Greg Kroah-Hartman wrote:
> Given a lack of complaints, I've now applied this to my testing tree.
> Thanks for sticking with it!

Right, so I acked v6, which wasn't preserved. The v7 changes are minor
and seem fine (IIRc I even suggested them some very very long time ago).

