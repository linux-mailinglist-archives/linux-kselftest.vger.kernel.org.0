Return-Path: <linux-kselftest+bounces-7917-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F11318A41FD
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Apr 2024 13:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A5571C20B70
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Apr 2024 11:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24022E657;
	Sun, 14 Apr 2024 11:06:58 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180B52E633;
	Sun, 14 Apr 2024 11:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713092818; cv=none; b=sAReVDLV7dsExiJ4Vp9BkkojsA8u+ruByHjxYf/DDKeFKxrlMM/MUbpJ2L0gVlQrARBRBb5F2C48exGpb1hqZHQvh9KxcDFDkN64tJycvycL9HzrIQN2X6KPZCEKld2PzRY6YOcDD7H1OLd1GsH7ENcaJ2zQPdkkg+p2coo0+3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713092818; c=relaxed/simple;
	bh=miun8jVmCtQfWySsPIyXcoPjpOxTuPM88zBCy1XymS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KuDnh7+LtdC8Qwrr64dsc5ab0Xid4KADNe8dz96FLo0emNbh1LjZY4jwaimxFlcTJfJHlihOLs6idtFxAWkKsIvpYh3/B1lJ76CdS+Q2zglzcyf8FnUmrQcRQYohNOherDzfru7ZHaXubHK8GmHRKPD4vsiyjQAl7kupmX7DaLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 43EAukRc002592;
	Sun, 14 Apr 2024 12:56:46 +0200
Date: Sun, 14 Apr 2024 12:56:46 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: add support for uname(2)
Message-ID: <20240414105646.GA2236@1wt.eu>
References: <20240414-nolibc-uname-v1-1-28a1fdbd5c64@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240414-nolibc-uname-v1-1-28a1fdbd5c64@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Thomas!

On Sun, Apr 14, 2024 at 09:56:23AM +0200, Thomas Weißschuh wrote:
> All supported kernels are assumed to use struct new_utsname.
> This is validated in test_uname().
> 
> uname(2) can for example be used in ksft_min_kernel_version() from the
> kernels selftest framework.
> 
> Link: https://lore.kernel.org/lkml/20240412123536.GA32444@redhat.com/

I find it really annoying when other developers waste time trying to
work around some missing trivial syscalls. I would have bet we already
had this one, but obviously not.

That's obviously an ack by me: Acked-by: Willy Tarreau <w@1wt.eu>

Thank you!
Willy

