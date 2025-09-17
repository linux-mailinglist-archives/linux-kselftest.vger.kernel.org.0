Return-Path: <linux-kselftest+bounces-41666-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AADEB7C800
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 14:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19A241C039CE
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 09:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282553090CF;
	Wed, 17 Sep 2025 09:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQdhRnia"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F213E306B06;
	Wed, 17 Sep 2025 09:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758101888; cv=none; b=RyrnWdbA1+OPylVvFu552Ft9wpbSWmgkgLEjD18P3DiQT1+RXfMdeU6yrb25sfqjWfP87bU9hboz2hNGSwCCuPULzTgTjn/2Q9VgsSxZwo5D0D3MUj243hhi+TRVHtLrY6QZDBA12PuyRn2n7V7W1nHpxNbmfa5ICF6S74syYZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758101888; c=relaxed/simple;
	bh=g6ox8okuU/GzLNmZU+zyA1i4cDtybsxCyJ5PXmVcXz0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VFvbAsXaq1LP/fkoe3MpT3YMxr45FOYeW4NUY0sg3CuCsPZpLmOWevvofqcHU+O06/PkccJfdUObKqCGpn5/+B+aAW/2Nd6IrsJ98PfIy/J+LpEh1O2PvWb/+26NDmS08/wMp6P/fuZaPSvEWbQL8jfpy05v7B6Q8c3gCKfr55A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQdhRnia; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258CEC4CEF0;
	Wed, 17 Sep 2025 09:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758101887;
	bh=g6ox8okuU/GzLNmZU+zyA1i4cDtybsxCyJ5PXmVcXz0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=gQdhRnia76QDRyKpcClJlcEmA3GK+RAg8GYEv84CWhIf7RJqt11qlcYIhhovF8s5x
	 Rfqc+cMl+6Y3Iu04KrJYZnAyt2MdEfR/VNJt9s4MaNhDJHFq34eYo74n+uz5jvwSy/
	 H60zIVjUvI9kniKiYim6aCu/oSZGBgRHoITnkdkKO0FN2tcsAxnRJmmSVshDp5RY7t
	 hjPhkcbUUMveBBcsqbmppVmDf2NFTNv0Hmegh3MFsMe/9SpAwhx8znraIsU7vnhQAv
	 F5Dsx/ssig1hAr6YpAlbCh9A7U0FLw5hUV6EruNg91Fbkb0pefCxgm2DKeZ8Qbzii0
	 Q4wl4diSzpd6Q==
Date: Wed, 17 Sep 2025 11:38:04 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Benjamin Tissoires <bentiss@kernel.org>
cc: Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@kernel.org>, 
    linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 0/3] HID: hidraw: rework ioctls
In-Reply-To: <20250912-b4-hidraw-ioctls-v3-0-cd2c6efd8c20@kernel.org>
Message-ID: <6oo5opr2-30o4-s826-941n-n42179005p61@xreary.bet>
References: <20250912-b4-hidraw-ioctls-v3-0-cd2c6efd8c20@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 12 Sep 2025, Benjamin Tissoires wrote:

> Arnd sent the v1 of the series in July, and it was bogus. So with a
> little help from claude-sonnet I built up the missing ioctls tests and
> tried to figure out a way to apply Arnd's logic without breaking the
> existing ioctls.
> 
> The end result is in patch 3/3, which makes use of subfunctions to keep
> the main ioctl code path clean.
> 
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> ---
> Changes in v3:
> - dropped the co-developed-by tag and put a blurb instead
> - change the attribution of patch 3/3 to me as requested by Arnd.
> - Link to v2: https://lore.kernel.org/r/20250826-b4-hidraw-ioctls-v2-0-c7726b236719@kernel.org
> 
> changes in v2:
> - add new hidraw ioctls tests
> - refactor Arnd's patch to keep the existing error path logic
> - link to v1: https://lore.kernel.org/linux-input/20250711072847.2836962-1-arnd@kernel.org/

Now queued in hid.git#for-6.18/hidraw, thanks a lot Arnd and Benjamin!

-- 
Jiri Kosina
SUSE Labs


