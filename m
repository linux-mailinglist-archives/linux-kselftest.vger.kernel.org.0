Return-Path: <linux-kselftest+bounces-14262-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BBA93CFA3
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 10:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58422B21187
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jul 2024 08:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550E677F11;
	Fri, 26 Jul 2024 08:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="vM+sCIFW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D92536D;
	Fri, 26 Jul 2024 08:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721982681; cv=none; b=dvNyNs2JdlI5bHd5vWM0I72ujUUZZUyq+8viNaa0l1WYOAQAr9xq2AJX+AJuOtv7AcNrZ6CVNYO6muzqkDVlcL7cWp/d4XF0WYizwXu6J4Ta2CxEVW5LQhTyV/jEyf9FeXiyJeLuuiMDPjxCFhrT5fORWKvyL1FOvfEz45LTpGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721982681; c=relaxed/simple;
	bh=WgrBFmHArYyVhxcUzIbxiPQ+jnmeSlQJXjZUSxN9QiU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=mpYFWfU1GYTKRjfJn9K1OEEiQfBI4kHT6xhOuxGt2Yv5VXZc4uObbjB00tob/oriDajCZo5UpL3keOwKFoS/0P2pf5YAkgIHC0unPGtoar8uTpmBR5vwJ7UBNsfSW6BRfnDqEpPMdj+sVql6NTkph8A+t1Wdv4Emen4LEyozPPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=vM+sCIFW; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721982651; x=1722587451; i=markus.elfring@web.de;
	bh=N6uKTvQILWUf3JbCAcziR3v7aPqVCaBhYrZUg4iAHhQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=vM+sCIFW3fwgjbKcs+VOeZMyw97VRmeQvQ/Rn67u9I+AwM2h1mp5Wk+WyHSZD99R
	 M4zOmwPflRPd/TL4DdGesO2e5KIebz6SzeqzobhYhyR/t/8eJ360f5KtYijb+iGJ0
	 tL3jo88gutUlFMSZBrZ4vDF2D2vKm0FCXpnH+0Z4pY7Lk+49Wz8O7vubstP5HKepo
	 BpbmP4NtsEUQTafNVC2Xy0jOF3RXzJR2xDI8nCjzR3vYXtclaDtsgy9gBNDIpyA3k
	 U22ev6BoMSTr7c7GsEqGsG5JkdouIDhCMxygEDLmjhPPMfRB0uQhK7MGPPdcRpWpJ
	 Ophv3e6wbz3lxjwJvA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N1uAl-1s8ste1qjx-0124Fb; Fri, 26
 Jul 2024 10:30:51 +0200
Message-ID: <0987e828-f7c3-4d11-ab1b-a671d091fbea@web.de>
Date: Fri, 26 Jul 2024 10:30:20 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhu Jun <zhujun2@cmss.chinamobile.com>, linux-kselftest@vger.kernel.org,
 Chunyan Zhang <zhang.lyra@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andy Lutomirski
 <luto@amacapital.net>, Kees Cook <kees@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Will Drewry <wad@chromium.org>
References: <20240726023241.17295-1-zhujun2@cmss.chinamobile.com>
Subject: Re: [PATCH v5] tools/testing: Fix the wrong format specifier
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240726023241.17295-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bike388/vrpcWqb9/dd9p0Wln5y1Yeq3HUZp/FH9h5fNHIbv/Tc
 X2NHQbcAsmvh71OH5mMMkbniI/p0Gxmqr8jAVr9nJ8nXrxr8xLkxnndr8oZMiRTCjxvp9E2
 tvZYbZ2SXgqpbxI9p8xNInWwKoyGW3Rk8cHy0J4bZ4WKLK90MnoRr3WQbE2CxPjjLcX1pT2
 RWEKzf1HpkolcyVS9WYKQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4yyP7CHdToQ=;9ayUQvqPK/YkUBDoX0UT4/YXkO2
 ZA2pCfCjY/zUNMeywR6ErabCKgAj33VUtNXVJ3ENuZdlN2q02e8yFlqHHPE3gGYIboZUzMJNH
 1vnpP0msXf+3LKV+t2SBZ1rfMKDZV86rVlou5O+n8aPQK/qn2EhYnZGHbAS89/EosSLSjNJzB
 zTRQ7T52eWugDtlfJnGljRn0KLjjJ0s3lhjO9vV3UYk5mJcy9BmeBAyyoCY0cx30K3dRBOB6c
 Ehr/ELRB9GZH67pkyqkS9Ak0wLplyqyPhJ8N8VQ5ESpY3Dth5JyyscnwvRD3MSSQYUIY2Mcnl
 yg36hGxBDr1DEHDCx8gtbaJiwlcIDoMTuFvBfYEbjK8uaB6eH4pkAhiIciAyITMId3Tify6x3
 sF+b4meKejazrEUKWBJOb6tdu8aZmlq/TjDzcwExNNIVxtk++1C8QH1gTpuJ4q+sAOt8d/6R5
 jQrubbmSEKPWt2Wpr5Z3w7D6/XoHdpLFTTzmUA0akmdqvtINso2euY4niGAzzjmMDpn0Pc9Mi
 fdyoaubAJkp42XKhfcrP9y25TVMQ7nPWHebKAdZmVCs79ILFS3h9EZIab+486MT6vvr4EC9Tp
 3TRE4Ej9MxfOWhK5CIWrlxnjp04y+rRGnTlQAMj0hJAR2SE9RDcIshoaMXlt8JXs3Ix3yiaez
 vdrv3a/9DsJm8A5Mnjb1XYmA6jlegWg5MsDmuqqMfTcCgvCZ32vyDoYBJAl9k2dVC6/9DAs9j
 uhL8fFcbXWl1QdV5fxDji30uHp3v5WvXUP+ArOM0cC6LzV8ues7K0ruztmHjPemTvUnzjHZS7
 UiFgn35z6qcO76HItklCOcWA==

> The format specifier in fprintf is "%u", that "%u" should use
> unsigned int type instead.

* Please improve the change description with imperative wordings.
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.10#n94

* Would you like to add any tags (like =E2=80=9CFixes=E2=80=9D and =E2=80=
=9CCc=E2=80=9D) accordingly?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.10#n145

* How good does the summary phrase fit to your proposal?


>                           the problem is discovered by reading code.

How do you think about to detect such change possibilities by more systema=
tic
source code analyses?

Regards,
Markus

