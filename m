Return-Path: <linux-kselftest+bounces-9268-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D60168B9E41
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 18:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 132FD1C22099
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 16:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB37715CD5D;
	Thu,  2 May 2024 16:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="jD42/wP2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B26915359A;
	Thu,  2 May 2024 16:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714666217; cv=none; b=oE4VsO4XhmH27fhRzuUt5D0QB53CQfBWmvEW7RWdh7tNh7iZY9gBhZ1aq2zjslU8zDSQ39xRNnZADIvrseJAdWz6OWrLhqvbkQNJSLmRjJm2mc2GNGnrDQAvdjPAo7ZJzMOW45uSOZOQ7TIKc+FZw4NyhHlm8/akfAFboFKWzsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714666217; c=relaxed/simple;
	bh=nSiUt7xwVlxTcuHrvcBkg8GU3oAdtaKupJT4g91MCd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILl831nksGkaJ4L3Qi3EfDhv6voB09rX4JiJCQZaE0qWrYZAn9qmniICZwXijksK77YfV7Zhk2u6F7MZ4BgxfYDOx81CD02V81TnF1t5ieCDCM5Qq3dkKnDsoXRYJrvojJOD/lRbxrURfBRSDdS+xBqVdkPFx0+CNYtkg5VLFB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=jD42/wP2; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1714666204;
	bh=nSiUt7xwVlxTcuHrvcBkg8GU3oAdtaKupJT4g91MCd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jD42/wP2BxcQNqEeEkX+91KAntJBS9ck+Uq6haO83td82UzBoPMXaGf7YmpteVkZH
	 lzjL1bNTSmWXjwLN2cy7pxZ0Dxpw9M2J9VpFGZvNmveAFY38Y1vkrmDSH/iMLorL4w
	 RtdlpSIG4ni9zM49Q0P3JdJSCy7xmVM7B/XoUVoM=
Date: Thu, 2 May 2024 18:10:03 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH 0/3] tools/nolibc: implement strerror()
Message-ID: <d6021c7c-271a-4aaa-82af-5a8ac7aac60b@t-8ch.de>
References: <20240426-nolibc-strerror-v1-0-76a4c9c5271d@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240426-nolibc-strerror-v1-0-76a4c9c5271d@weissschuh.net>

Hi Shuah,

On 2024-04-26 13:08:55+0000, Thomas Weißschuh wrote:
> Adds a simple implementation of strerror() and makes use of it in
> kselftests.
> 
> Shuah, could you Ack patch 3?

Friendly ping for an Ack of patch 3 of this series.

After that I'd like to submit an updated nolibc pull request to you for 6.10.

> Willy, this should work *without* your Ack.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> Thomas Weißschuh (3):
>       selftests/nolibc: introduce condition to run tests only on nolibc
>       tools/nolibc: implement strerror()
>       selftests: kselftest: also use strerror() on nolibc
> 
>  tools/include/nolibc/stdio.h                 | 10 ++++++++
>  tools/testing/selftests/kselftest.h          |  8 -------
>  tools/testing/selftests/nolibc/nolibc-test.c | 36 ++++++++++++++++++----------
>  3 files changed, 33 insertions(+), 21 deletions(-)
> ---
> base-commit: a3063ba97f31e0364379a3ffc567203e3f79e877
> change-id: 20240425-nolibc-strerror-67f4bfa03035
> 
> Best regards,
> -- 
> Thomas Weißschuh <linux@weissschuh.net>

