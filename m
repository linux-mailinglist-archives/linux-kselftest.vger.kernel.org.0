Return-Path: <linux-kselftest+bounces-3904-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D0A844B45
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 23:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98DDCB26572
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 22:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984143A8C5;
	Wed, 31 Jan 2024 22:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RdmcEkaY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25373BB3C;
	Wed, 31 Jan 2024 22:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706741450; cv=none; b=p6Ywzl5rocUDzqHeJcQWllek24w+vbOpZOUugnhr0V5U4eky3FrKMUDA24NWeDWIjyT340ye1f0kcbQryx1mrhgkPpbsYKU24p2KRIboG5tzFQlhnvBgKWck41JVt48rPFfpxffqBJP7fUSGprTG4KrWDY9ywi2Kj4zjEz+vnSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706741450; c=relaxed/simple;
	bh=s8mNCm3spg67wpzoELCl6Nl2C0dTe1E0eKsxrmW9+f0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucXJQDLtAUTmggr7KDmoAR3Z2Q1CpL0kAurmeNUp2mWODeVhdw6J4h86jT6hI4yvSX28dGbH6VGxUAbKKDfXvlWshucoiF1tLYQrLUpSq9ITn5ZKjSj/Tdvm3Qw1GgrAxzaLntJIuBLcx8jbzqv5b4Y+tZlhP1/GKT/g7LgVH5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RdmcEkaY; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706741447;
	bh=s8mNCm3spg67wpzoELCl6Nl2C0dTe1E0eKsxrmW9+f0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RdmcEkaYotXJ+izkLIaZ7UPipr1jhoWVQF19AVVG4qphG+wRjYRsUwwf8nfxIAUxi
	 srARlU/k7FfMPpX8jeyTtgxBqet+KH5TPtRsfqH3G9E7BtkmouwCgrcuIoDFGwzFm7
	 RFtdZQLLMRnT+3YM58KZm/ktQySFFEBtn0KAVsxtmCk1J1K/cYo4Ti1zGr/qPNnRJY
	 NdsPgCPYIEAjU6YqHu6anNUPymEGLq++KlDVJ7CK/u0ESyi/jqdw6MikPARxYhg6MF
	 NTBY+0W0PvTvzn1REqTCg0Cy0M/IskwxZZjagPeCck76CcDCKhyXuXkOQxs2bSsvCb
	 f5QKN9YercUdA==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8F5A93781182;
	Wed, 31 Jan 2024 22:50:45 +0000 (UTC)
Date: Wed, 31 Jan 2024 17:50:43 -0500
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Shuah Khan <shuah@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-pm@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH] selftests: Add test to verify power supply properties
Message-ID: <fa11506b-0e00-4543-b5c2-598d1340ef28@notapiano>
References: <20240131-power-supply-kselftest-v1-1-7ead5645c004@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240131-power-supply-kselftest-v1-1-7ead5645c004@collabora.com>

On Wed, Jan 31, 2024 at 05:48:01PM -0500, Nícolas F. R. A. Prado wrote:
> Add a kselftest that verifies power supply properties from sysfs and
> uevent. It checks whether they are present, readable and return valid
> values.
> 
> This initial set of properties is not comprehensive, but rather the ones
> that I was able to validate locally.
> 
> Co-developed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---

Sorry, I just realized I forgot to add this to the notes, but this patch depends
on the series
selftests: ktap_helpers: Add some missing helpers
https://lore.kernel.org/all/20240131-ktap-sh-helpers-extend-v1-0-98ffb468712c@collabora.com

Thanks,
Nícolas

