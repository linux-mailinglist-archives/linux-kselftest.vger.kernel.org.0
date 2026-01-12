Return-Path: <linux-kselftest+bounces-48791-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D6526D15220
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 20:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CBECD3018329
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 19:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330AB326D70;
	Mon, 12 Jan 2026 19:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="HwaP2ws8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7A9324B2A;
	Mon, 12 Jan 2026 19:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768247735; cv=none; b=S1PfKzuK3B5RvTPk3q87PpaSPjbmRwL+NIXStuqdRNvdPahIX68EpcBbSk5/vjhgfP5M/i5Uv2ZIF4yOuZdTh7Whuti/QCNDxuIaMnBdMCtUYvySk0NAlTty6CreMfMv7aufCUY/HnqO9/HV1pN4tLHU5kLLjCP7wWxCVfYRAOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768247735; c=relaxed/simple;
	bh=XE/p0KG71dvRivmx1HE0U30vS0lzaT2ZOja8t/WsClk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=rwCpxW8eGaGyVZRXZjCnQm7XBZ/cJ1qjqDyuCOxEtGFjoV2vTQKWlo4J3zE3wtgcXr+mvUEIzBT5vEsTz8BpVMEo9iRRgHMB8kwS4pKU/782eHH5sdhQ7rVRPcdY91WpQifiXSOXnLp29unv4ckJqC8PgQK3+1fscTsN8qs23AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=HwaP2ws8; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768247713; x=1768852513; i=markus.elfring@web.de;
	bh=XE/p0KG71dvRivmx1HE0U30vS0lzaT2ZOja8t/WsClk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HwaP2ws8PbYLTQvIj0rDK9suAxaiIS6Zs24dYr0oMo63P4j1y6cbshRT4OyEsuhf
	 aKscFpU0DSoluEGA5g7W9V9LC0xL5sEX9OHbPXXrOQUr5Pi/KLSBXo5n16kEweThT
	 Mis7NZDpLEHXKyDayo4rtVYT4bJLItIbuyb51Dy/y3iGtvt+ToGPf+Wt+mjbcXdLc
	 UMsJv1Bg3AReUlVa6Bk5xtC9NhlRc5Qqk7NikdZ/HpH7cn+fJAindnqiov/ZKffjB
	 /xiNb+btKIyWAXT/QAT+Kf+0ViTT/56+HflE6NmlQldqPsx1pqnmQfiFzIfJ19Atl
	 EE50DqV2MKxvT5tbpQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.241]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MZSBQ-1vInDD0DDS-00MIpJ; Mon, 12
 Jan 2026 20:55:13 +0100
Message-ID: <4bdd89fe-914a-4baa-a9b5-a6e15168ba52@web.de>
Date: Mon, 12 Jan 2026 20:55:10 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yohei Kojima <yk@y-koj.net>, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Simon Horman <horms@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <60dc3da1f913aa9625e864ea862c23c401e7bc6e.1768207347.git.yk@y-koj.net>
Subject: Re: [PATCH net-next 2/2] selftests: net: improve error handling in
 passive TFO test
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <60dc3da1f913aa9625e864ea862c23c401e7bc6e.1768207347.git.yk@y-koj.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aDAlOIIIUSkoiUgevWgJHV3CET5fRF8yqna/UZI+TMG0SHgW9rl
 MfW6nvIzr50UmSWTj8c36TdwJuzluGXCNG48YasaYR95QoxHOOlEaepnHxx+3U7EENc/DFI
 M0ZtOtyYJ3BzTU4wD5EEpmOwmTp453RyOD36WOMgcRRzO7wRZDWpY9Tud8gwvvNpTNmfSM0
 7xTED/P2GSRtj37va2pug==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:10RPEaApqos=;SGA3ag9GSic7h2qmqCn9h0qdS7F
 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
 +qVSzWAY=

> This commit improves the error handling in =E2=80=A6

See also once more:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.19-rc4#n94

Regards,
Markus

