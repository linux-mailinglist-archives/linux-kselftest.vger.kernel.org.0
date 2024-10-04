Return-Path: <linux-kselftest+bounces-19048-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A63990A3C
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 19:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFFAFB21427
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 17:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B421D9A5E;
	Fri,  4 Oct 2024 17:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Mhj16Aad"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CF51E376C;
	Fri,  4 Oct 2024 17:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728063431; cv=none; b=chwsZPg4E8uZFvI+t0tEYUG40D2bRcCH0+sQewHof/xPfuwupbz53206EzjYTSmXxcx9sTFUYcOlxMV9tsAzXZ1s0maGVAxJ7WimlEFnlWVrv2Jx7T0Mrz+2Z5AK6Zpne1/toQQ5fvtcdXXQ75Uycvw8f9Kr3z39K6iJ9z1T4RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728063431; c=relaxed/simple;
	bh=Rp57pMGyAcU9nt9TEmfZs9lMFXdF3AL13y1sIqxt0jw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qZTGB6EmIPhk+wc4nwIkLHaEpWjcLAhtRPVEcQBP2D6vgqnuEiZPHl8vl3JFw44BZujEH68Pk3H0I1auOQRS4gZaYVGcHCZ8+28UmpRE4JaoM4580fGTDhV2oJxef4balb4IKpC0ojCcGMZ5RoHrp4y9y03+HMredpVDjKsiAGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Mhj16Aad; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4963841043
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1728063423; bh=Rp57pMGyAcU9nt9TEmfZs9lMFXdF3AL13y1sIqxt0jw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Mhj16AadZP7RomdIpj5dg+10RMHWhF8r7BbPSO2sBURlkqPLBIi9hdu3Zk35Rr7HG
	 ogjKSp1JC9n93TMEglqicv9/j9+7EQ0pwzCij8mhisUmQoFZS8BPQglx28baH3v9JO
	 pFB5Pe5zHPsNiihluDVq65AVCCV5MSEQnx6VonvFe3La+7dBpRZ+FZbUcUXu6hdw3h
	 5eZQ73jQhC0ocQUAk3D88kndYPt9RKOJ+KY022z9waveHuhRkHZafVzXrpa+YSRnEG
	 bwKV+WGFvLPleDbqhxdiQEJDMiCcNv80Jr/esR5KOvi0BoESRCJy/maF5SZ+e5fnTO
	 Xp8gmM4A8G2MA==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 4963841043;
	Fri,  4 Oct 2024 17:37:00 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Shuah Khan <skhan@linuxfoundation.org>, =?utf-8?Q?N=C3=ADcolas_F=2E_R?=
 =?utf-8?Q?=2E_A=2E_Prado?=
 <nfraprado@collabora.com>
Cc: Shuah Khan <shuah@kernel.org>, kernel@collabora.com,
 linux-kselftest@vger.kernel.org, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernelci@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] docs: dev-tools: Add documentation for the device
 focused kselftests
In-Reply-To: <e3602786-d656-40ae-9e22-0e8195d33f0f@linuxfoundation.org>
References: <20241001-kselftest-device-docs-v1-1-be28b70dd855@collabora.com>
 <0040a842-de9c-4f9c-9d61-c1bfbd010470@linuxfoundation.org>
 <ef428a44-783c-43c3-81c6-9abf88ae8949@notapiano>
 <e3602786-d656-40ae-9e22-0e8195d33f0f@linuxfoundation.org>
Date: Fri, 04 Oct 2024 11:36:51 -0600
Message-ID: <87ldz33h3g.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shuah Khan <skhan@linuxfoundation.org> writes:

> Jon, Let me know if you would like me to take this through kselftest
> tree.

I'm happy either way - go ahead and grab it if you like, just let me
know.

Thanks,

jon

