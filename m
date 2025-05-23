Return-Path: <linux-kselftest+bounces-33621-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AFEAC1ED8
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 10:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F36324E416D
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 08:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A62422CBE9;
	Fri, 23 May 2025 08:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="cMxgzX38"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18711F9F7A;
	Fri, 23 May 2025 08:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747989541; cv=none; b=laVPyiyDL/HkbFi931unPgVsqY0fm5t0O5Oq55XFfOvDogYArriG0ObNk6mKxv7xiUCLgR7tRhRJR1/rhd+an57zbUizRmBuXv4xrEz2GHDtDeC1waAvHMl3scft6DwfINFVYVFWvcysgt6pL+P8kj6Yo46n+j6CQWr14umpV7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747989541; c=relaxed/simple;
	bh=msYNVRIJaIicsmP+EDUll+WhrqYovk4p5HwXJzc9dn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vtmn0jLUNv0wNh1J6rH/nyxncCyQGtDGweuAwQMJbOXm4ho7wyraPT/c5s2vBsHVf/gpNBHOlpP/WHbmefbPLwY2CVvby87L4ca4QxBPJ4jd9cbFDhoWvBN3hbaf7ePecT6j72RJgnBjg66flsKUMPFBzvvlsDlVM3epXyGktwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=cMxgzX38; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1747989530;
	bh=msYNVRIJaIicsmP+EDUll+WhrqYovk4p5HwXJzc9dn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cMxgzX38qt26870aBPdidhOIzrroJi6dU5AIsPz3xXOutDgIDIvHwvWYU2Zcvsxtd
	 50rvnl0ElSYiLRxos6fb1HNbE8TGez7LTr85RH5OwSl0D+97idMQzz7b6tll8eFgxc
	 X6img7f3rF/vhKceJuMpupJQSwm5D42haJt4S1I4=
Date: Fri, 23 May 2025 10:33:13 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Mark Brown <broonie@kernel.org>
Cc: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/9] tools/nolibc: move ioctl() to sys/ioctl.h
Message-ID: <25a18e14-8ac9-4ac8-8907-a087050b1eb6@t-8ch.de>
References: <20250515-nolibc-sys-v1-0-74f82eea3b59@weissschuh.net>
 <20250515-nolibc-sys-v1-1-74f82eea3b59@weissschuh.net>
 <eda3af4a-8dfe-4f82-a934-2d0256b754e2@sirena.org.uk>
 <89bb5a3e-dd6c-475d-9c5d-0bd1595be735@t-8ch.de>
 <744a1aa8-1efc-4c20-b45e-070fc038f6e8@sirena.org.uk>
 <198bf1a8-98d0-4693-a4cf-234cad728c9b@t-8ch.de>
 <ccc18ae8-80e5-471e-b1ef-da132b13b27c@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ccc18ae8-80e5-471e-b1ef-da132b13b27c@sirena.org.uk>

On 2025-05-21 19:49:39+0100, Mark Brown wrote:
> On Wed, May 21, 2025 at 03:45:42PM +0200, Thomas Weißschuh wrote:
> 
> > Or you could run your testsuite with the new nolibc for-next branch
> > which should be fixed now.
> 
> That seems to build with 869c788909b93a78ead1ca28c42b95eeb0779215 which
> is the current HEAD of:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git for-next

Thanks for testing!

To be sure, was this your full test-run? Or did you do a full test-run
on linux-next in the meantime?
I'd like to get your confirmation before sending these changes to Linus.


Thomas

