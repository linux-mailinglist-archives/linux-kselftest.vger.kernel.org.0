Return-Path: <linux-kselftest+bounces-49355-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEAFD3A927
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 13:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85BA430215CA
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 12:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E8435C1AD;
	Mon, 19 Jan 2026 12:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="J2WXxaDi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1366B2EC096;
	Mon, 19 Jan 2026 12:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768826363; cv=none; b=EWFTQtcDR1NUtQ96S3Iwel1kExhWTwDi76Kt/Jb2zpQjx76U5mNFql5Ztu4u380IZTGUO8YDfkaAV3e4jsxONGNLy6Ayds5ZPcqA4KATWYvZK14CwDM0EMIxUvVde5nkqRJO9oOh/5gHUxZrsk48DWvaXK45EsRoIIk7kdMbLxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768826363; c=relaxed/simple;
	bh=CP+fncSPDdHNdNNZbFprfRBxBb7RVaeVjGw69bWHfik=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=PEYGcCD0uXQRqxbFqZbHbcDm50YPRxipTPqV0s3DhTGrdxrTJ7OTNu29SMnaH5moK9WmwiKYmkLowPUqx8OwXrDHnScURvkqPFmz2JNVSRKe9h29J7Csu71hxw9fJCKSMYSCnY5biZ/57pnzdT/V5T4hPBOnobr5FHQnEIUYENI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=J2WXxaDi reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4dvqlN2YwLz1DDhH;
	Mon, 19 Jan 2026 13:39:12 +0100 (CET)
Received: from [10.10.15.12] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4dvqlM28mxz1Fg0D;
	Mon, 19 Jan 2026 13:39:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1768826352;
	bh=Dko06QnWdam8aAaddK8BY+snmJX/OQ2k+0eGXUgFsec=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=J2WXxaDiQlACTRNscspUtkKK+CMgW3JTw2CcDNjwwSHDXGWylLvYq+XcAA3OQADaw
	 vygdNj653Wq36bOMfwpkSXuLGbzP2EThvuvrOJgxJUe9kDaI4egxXLyaJKbJIwbKtN
	 0OYIIG/1aadZ+ujzmrPetW/OEex4uF14SPgi2PXTEb3l/pnT40K9iAF1Xbfd4LUkJ8
	 g8ri/4t9knmggYurdissAY3s8At4Vacvp83BGmkVrgjQ8IvE6CbQWKJsg3QkYQLORz
	 GIheiQOH9umb767I618ZjeB/z7m5G+dFDo/m5kw9l4hPkHkM1xfZzi7qxrrjHSBJWi
	 AUr82BNpxRcRA==
Message-ID: <b7801647-9149-4068-9627-8346ad822908@gaisler.com>
Date: Mon, 19 Jan 2026 13:39:10 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
Subject: Re: [PATCH 2/3] sparc: Add architecture support for clone3
To: Jessica Clarke <jrtc27@jrtc27.com>
Cc: davem@davemloft.net, andreas@gaisler.com, brauner@kernel.org,
 shuah@kernel.org, sparclinux@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 arnd@arndb.de, glaubitz@physik.fu-berlin.de, geert@linux-m68k.org,
 schuster.simon@siemens-energy.com
References: <20260116153051.21678-1-ludwig.rydberg@gaisler.com>
 <20260116153051.21678-3-ludwig.rydberg@gaisler.com>
 <aWprkg0fRoYQl5DP@Jessicas-MacBook-Pro>
Content-Language: en-US
In-Reply-To: <aWprkg0fRoYQl5DP@Jessicas-MacBook-Pro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jessica,

> One of the benefits of having a new clone3 is that the interface can be
> made the same across all architectures*, unlike clone, which both passes
> the arguments in different orders for different architectures and, in
> the case of SPARC, has this weird return convention inherited from the
> SunOS syscall interface. Is there a good reason to deviate for clone3
> too and keep this annoying oddity going, that requires special-casing
> SPARC when other architectures can just syscall(__NR_clone3, ...)?
> 

Thanks for commenting on this. No, you're right (there is no good reason).
The original implementation just followed how things were but I have a v2
coming up which will follow the regular kernel return value conventions.
This will ensure that syscall(__NR_clone3, ...) works on SPARC exactly
as it does on other architectures (i.e I'll drop the third patch in the
series).

Best regards,
// Ludwig

