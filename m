Return-Path: <linux-kselftest+bounces-6071-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA4E875A09
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 23:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 729751C217EB
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 22:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4A213DB9A;
	Thu,  7 Mar 2024 22:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B/e8h3Xe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB28D13BAEF;
	Thu,  7 Mar 2024 22:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709849526; cv=none; b=bIVCdL0lqUs+2hxlQGHD7MJy8kjUA2bm1vJit8cUrQZjCbP3Ri6wPjiz+xi7CxwzIFHLlkNMn8OHypaO4BnoUcOVIxpIWcIzPoiPLX7T1taQMIf408heeDrzEwQY5rSOPbiGKBbvit8m57AWJQ5Fv4KxiiXmSmfCol5H5coWbSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709849526; c=relaxed/simple;
	bh=qv8+spMNjo+8OovqII5cP9bZdZgkXALJcuSfu6n5vvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxNDukiFQ1ux6PMr/SNXrIvAQDdL0p/hrvLgALpYfOdCwYvJd2j3PY41tKw2bVi2Hv8V+s6E5tfPWBDt3/IqluRx5fIL/vQ+j2uJIlvcNAJfdN8FTVRzZ1eFkyLvQZ1kkiluUBuaQPJmZ5kg5nnnip7PutWjYlUPNwPte4DapJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B/e8h3Xe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0EFC433F1;
	Thu,  7 Mar 2024 22:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709849526;
	bh=qv8+spMNjo+8OovqII5cP9bZdZgkXALJcuSfu6n5vvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B/e8h3Xe/bwwVojLCUzEbzD1vJb03wkXcvFdwpIN7zgCuL9UzlPe/d/KEog+HT+j0
	 tmbv+RuNV/k7Cw9fugQCEScWqz65P6+M21SQFmr9SnTeTe7GIpqdMaiZbOBYSt3Ws8
	 tVs+pGew39WQS5iXbWMdbN3hyri7Vd9PV80y208E=
Date: Thu, 7 Mar 2024 22:12:04 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Elizabeth Figura <zfigura@codeweavers.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, wine-devel@winehq.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Wolfram Sang <wsa@kernel.org>,
	Arkadiusz Hiler <ahiler@codeweavers.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 02/31] ntsync: Introduce NTSYNC_IOC_CREATE_SEM.
Message-ID: <2024030721-expletive-repose-0a89@gregkh>
References: <20240219223833.95710-1-zfigura@codeweavers.com>
 <20240219223833.95710-3-zfigura@codeweavers.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219223833.95710-3-zfigura@codeweavers.com>

On Mon, Feb 19, 2024 at 04:38:04PM -0600, Elizabeth Figura wrote:
> This corresponds to the NT syscall NtCreateSemaphore().
> 
> Semaphores are one of three types of object to be implemented in this driver,
> the others being mutexes and events.
> 
> An NT semaphore contains a 32-bit counter, and is signaled and can be acquired
> when the counter is nonzero. The counter has a maximum value which is specified
> at creation time. The initial value of the semaphore is also specified at
> creation time. There are no restrictions on the maximum and initial value.
> 
> Each object is exposed as an file, to which any number of fds may be opened.
> When all fds are closed, the object is deleted.
> 
> Objects hold a pointer to the ntsync_device that created them. The device's
> reference count is driven by struct file.
> 
> Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>

I want to take these, but I need someone who knows how to review
locking/sync primitives to give it a review to verify that it is working
properly within the kernel constraints we have here.

Anyone want to give it a review?

thanks,

greg k-h

