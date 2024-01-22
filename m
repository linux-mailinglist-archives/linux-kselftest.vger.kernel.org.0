Return-Path: <linux-kselftest+bounces-3332-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AD7836CC8
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 18:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFB7B283BBC
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 17:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70294E1BC;
	Mon, 22 Jan 2024 16:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnQF3XQc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7773EA92;
	Mon, 22 Jan 2024 16:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705939577; cv=none; b=Fm8LRaAoksQChD5ZQi5EYflSc2hOcBn1RjPbqHvtAS439jSX851rnaJdj6RFml4Cck75U0nEgav0kmCwRRL8G9FLyp+kqlKByJ6EaF2PA+bYEaZ6nsDD076HSMNMFjWT7ceQrJNA3ecP8QQTrFkVuxVOgm6QMSl7XumBuiFxaLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705939577; c=relaxed/simple;
	bh=hY/zyn/406LOd8YtMIcobNKeKbMaMrknpBMXDWrJbh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+l/+so+8Hbzqp3f2gTu9dt0moa+1jQ1UVwkdCeC6Yra1Sea9GU7/YduQ5zPkdiEb8rQ3bds8pbPwduBlCI/9grMg3GBT0a6FuZdVDSU0LRqW1k5VzuGeAUJ1wLEwtYxVqqb3WKAceIhgB5XP32T72HWM5tAJudPtYLpK4EOGBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnQF3XQc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC083C433F1;
	Mon, 22 Jan 2024 16:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705939577;
	bh=hY/zyn/406LOd8YtMIcobNKeKbMaMrknpBMXDWrJbh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CnQF3XQc/Bia9iXEaxMN5SySXr0yt7xebAkakModjUElWzlzLvkW4cwL1hZRRov8G
	 fvgBgFRypiExZ441hi3u2FCqeem+RtoFAbLWBGSr0JqxmBG79pn9PxRwpcoIjqEECy
	 iy+1PLWEpkpBwqIIUCLjMFs2HJ6BrYLx/7/ZqFzwTkqvB5QwnmwnvmUsww2nMeXcAF
	 wai+cgG50OHA64uK+WIPmAaNcXI6a+C4Aq6x8mK5NTsAoyqfdyBB7vdzRtEDzjnYIB
	 8z24J29alU4y1X7EloH/Cl7Vmq0vM4kACw+M4bruohHLCIIQhm3LONpjFTiZyC5cPw
	 uH8VQ/ht51T6g==
Date: Mon, 22 Jan 2024 10:06:14 -0600
From: Rob Herring <robh@kernel.org>
To: Laura Nao <laura.nao@collabora.com>
Cc: Shuah Khan <shuah@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	"Nicolas F . R . A . Prado" <nfraprado@collabora.com>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH] selftests: Move KTAP bash helpers to selftests common
 folder
Message-ID: <20240122160614.GF601827-robh@kernel.org>
References: <20240102141528.169947-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102141528.169947-1-laura.nao@collabora.com>

On Tue, Jan 02, 2024 at 03:15:28PM +0100, Laura Nao wrote:
> Move bash helpers for outputting in KTAP format to the common selftests
> folder. This allows kselftests other than the dt one to source the file
> and make use of the helper functions.
> Define pass, fail and skip codes in the same file too.
> 
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
>  tools/testing/selftests/Makefile                          | 1 +
>  tools/testing/selftests/dt/Makefile                       | 2 +-
>  tools/testing/selftests/dt/test_unprobed_devices.sh       | 6 +-----
>  tools/testing/selftests/{dt => kselftest}/ktap_helpers.sh | 6 ++++++
>  4 files changed, 9 insertions(+), 6 deletions(-)
>  rename tools/testing/selftests/{dt => kselftest}/ktap_helpers.sh (94%)

Acked-by: Rob Herring <robh@kernel.org>

