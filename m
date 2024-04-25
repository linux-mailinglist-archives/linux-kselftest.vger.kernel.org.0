Return-Path: <linux-kselftest+bounces-8889-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E20B8B29D6
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 22:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88174B265B3
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 20:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D630AD2D;
	Thu, 25 Apr 2024 20:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="so3IsTwO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BF923CE;
	Thu, 25 Apr 2024 20:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714077031; cv=none; b=gHt4iwXJqqrg1N5sDUCkSg5Fbt9JKkrOExEFciFfajl52sdR/a0obsnbo5Eiw7ehJsabJMLMrwd7lr2nwDTHAkmsIDI3FqSjweol7DHRC+NUNA/Nsxx2X+BbWB4bcmG2I4kom9zgFnyFByEJGmUgWBIGhcI3OgnNbjjyLZI9I0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714077031; c=relaxed/simple;
	bh=hfdus2p+bM7iWg6TlBkavoSM/qj2oyLi4fBlb3KBeW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/7QTSgAVAtRKhcMsrlpvOA7qt85A0UfXqbZGjDNfL6HNFs/SQSOh6vXIXa+oJh+TjrIWLQPVAYznjO3I7aYWJuAiitV7V8wdUBmLJ3Ofmx9CGxv2KK1HfqtvTuSZvVGfUAMp6VeX5jeiCZ9x88K6V41E/JdngxjmQkhe2P5kz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=so3IsTwO; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1714077024;
	bh=hfdus2p+bM7iWg6TlBkavoSM/qj2oyLi4fBlb3KBeW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=so3IsTwO1ivEkwveyqFCciND8gTG+gMmvHEUsRHL/MI+2CPbGphn/wnS9CHoTWP73
	 32OB017oWa6UzKDblylTtZHQfWcUj0orRLYTsIHaTia+smoY/EwPm56d4W84pZZvsD
	 xeBWAHufEYq1ystLD6u81x8ufEDTMJywW0YXOpaU=
Date: Thu, 25 Apr 2024 22:30:24 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/2] tools/nolibc: implement strtol() and friends
Message-ID: <ed4ab3db-71a2-4f3f-bafe-f1a71d1c66a7@t-8ch.de>
References: <20240425-nolibc-strtol-v1-0-bfeef7846902@weissschuh.net>
 <ZiqFL02n3+4EKFMV@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZiqFL02n3+4EKFMV@1wt.eu>

On 2024-04-25 18:30:39+0000, Willy Tarreau wrote:
> Hi again Thomas,
> 
> On Thu, Apr 25, 2024 at 06:09:25PM +0200, Thomas Weißschuh wrote:
> > I wanted to implement sscanf() for ksft_min_kernel_version() and this is
> > a prerequisite for it.
> > 
> > It's also useful on its own so it gets its own submission.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> 
> Nice work, thank you. For the whole series, modulo my small comments on
> 2/2:

Thanks for those great catches!

I addressed them and pushed the result to nolibc/next.

>   Acked-by: Willy Tarreau <w@1wt.eu>

Thomas

