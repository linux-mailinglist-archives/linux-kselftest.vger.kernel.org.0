Return-Path: <linux-kselftest+bounces-8999-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1418B4C6B
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Apr 2024 17:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849FB1F21366
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Apr 2024 15:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62ECC6EB7A;
	Sun, 28 Apr 2024 15:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="QHSaNfVF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103A51E48A;
	Sun, 28 Apr 2024 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714318756; cv=none; b=m62tnnLRzeIH2KIF1ctSTSwKkrdrVqlXmNo+dOve3rU78JgZimYqpr7hnFoV80upD3/OQZZYCu4l/wHHq5KnZyLdSVCn6agWHx2W/vu+kyfY1W/qihT+/YkGKdv9GLyBRlsrgJwYuVyvfMu4tVv8WwcIHKJe6WCE+1H965CIyrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714318756; c=relaxed/simple;
	bh=ViyQZTMIcF5v+1IYQTvuXRzOzG85wmh4Y3HOHwhO5gY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=NjyQRgXfgBSv2ykHPLRPlNWc45WDUnU1KyXQun5VicjxDyFHbt15h35r3a7nVdqnDwxmrY/pzlKlqmI3EngEAoCTSD1asjdryauo+CTQ/+hYTyElMNQbo0nv7a0LORLAQQ+7d5f7ACH4AnTwZMsqSBtGg1FtNBYcrIgoejvcn9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=QHSaNfVF; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714318718; x=1714923518; i=markus.elfring@web.de;
	bh=g4JtHB0LA6rj2gdM0a7dzQ25Ozs54psB2cq0Nnk5tUs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QHSaNfVFBHPPh6QlbqU+9gPPj6bEDthUZd7Dpp0YrSmhPme/e0Oc6+N6bugbjUF2
	 HQJdTl9d5tMomQ17HRA0yzbvyo1NDHzO8IODYZITJGzQ2AWyC3vsmNNnbzHskBktU
	 DUdmc9k8pEjOQzzMs6E5fhvO58y9U9auXFyjwH//PA0aC3rKh+ylBUqGoDAdsTZxL
	 BHSU1AlbSchjgPR5CKaseiaIPZEzGyLMBUDOZqv04dC8CQBnk2zV/UJiiRsE4VTYK
	 7+Af6WLVDzKDzEBk6Vmpb/qExS2w1JLmBXZB+OF/P4m8AeivgqfhIkp+HbzwzEj5J
	 gThzWZCkiLOWbNqYcg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MNORC-1sKIPn3wR0-00UEVD; Sun, 28
 Apr 2024 17:38:38 +0200
Message-ID: <d3f389e2-7a72-4ce0-9f05-245c4f34f829@web.de>
Date: Sun, 28 Apr 2024 17:38:35 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kunwu Chan <chentao@kylinos.cn>, Will Deacon <will@kernel.org>,
 linux-kselftest@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
 Kunwu Chan <kunwu.chan@hotmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>
References: <171429017935.1716809.10906291781915903062.b4-ty@kernel.org>
Subject: Re: kselftest: arm64: Add a null pointer check
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <171429017935.1716809.10906291781915903062.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OPEqQzbV7tCKfsZZw9Vc6Y9TOgOxLJenJ4U/zPHrydyN5r+4bVD
 9VMg1yI2DNsetpNcFGGaRR0mJYV2rK/HLnRoo7P5Y8E479Oj8CzsY5yfUA+AyI7txW/0u80
 T+4HgJB13Rhz4cy4Q+wwcP3sQpPvSNosVJom4hTKg0qgPkcyvPg4+WDLcDmHDIU1kW4QIl9
 nEyt4QCfKytD3iPPA2x1g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ohnDtBiNdL8=;gPBrqtU8Z9IHlSkwLLAp9xiAZvd
 W6Ux4CMAEPEQs5QZKO1ETdkfczDxIJZh81DXWIb9LsS4nUESIEnMIA+B1Ho+PJmYW0j0ExWfm
 kcEcDNmZt560gyijImr4jfjivl2Gb8bIT3IPpahVWquRTE5oKSqEKTHcJ3nUHye0YrL1IaEYe
 0yf7FHpJq4UAPCwb5VDL5S6E39PJLxQoc9yqS9kFQTzzuQFrYZKsqcxIodR3Iylgr2FSzrcP8
 ++pWvOv6ZTdQXhB145021a0wP84PIUUYYUfcK7INs89g1Se/x1r0hRaAICmcHyD11GwemTdjJ
 1lrnJY844dIpF5puNdfeFFYi16PeTv1O+Upy8Ivh6A4/14djFbWw0ZbKPubAW97Q4KAtOcRSI
 4o8WMPQIXXw0LewsgH97qhpdT7BiyHIHIig4epfbWkNwmnZvViC6MMZfC6cP3oKvJUdg/7zC2
 tABA0V5Cp+XHce7vtqTTbtUPXWqQ2Y8sZGpBB3+1NnNZgMQBRSwn3nYqpFnl/I9Msr5Hwltq2
 A06fpQJ00IGowo/YBZGGI0aufyDem/F2eBx5AUNp3GW9kmbuymRfuWIE7yqSdnBXQhNN+/iCj
 skgoGigwuu2PsHqvsR70ABTMLKFQzg6ueStZoy+sntgxlF040H/ST/50A6XjuliKAhYvwgc9p
 9fmYph0mZzp9KTeFdgLy2XyAiFvV4Q6xLPdP+/YDMuPjl34V4zD5QyMSYIHSjTE/ZOjRE0TvG
 9Tj2wsZW+i5MJdywmQ/Zve6J0uQrNPy+fXdmae7OP6uCKjPVYR+RRhrWEjW0acIUKd1iPSBiy
 uEdzHHs+ELIHKPO2sP+VKM3r34fAlWYfTFfhf6SBE9biI=

> > There is a 'malloc' call, which can be unsuccessful.
> > This patch will add the malloc failure checking
> > to avoid possible null dereference and give more information
> > about test fail reasons.
>
> Applied to arm64 (for-next/selftests), thanks!
>
> [1/1] kselftest: arm64: Add a null pointer check
>       https://git.kernel.org/arm64/c/80164282b362

Why did you not adhere to known requirements for such a change description=
?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.9-rc5#n94

* Imperative mood

* Addition of the tag =E2=80=9CFixes=E2=80=9D


Regards,
Markus

