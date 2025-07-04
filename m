Return-Path: <linux-kselftest+bounces-36595-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2952AF973C
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 17:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36CBA16D390
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 15:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E8C2D94BD;
	Fri,  4 Jul 2025 15:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="CYm2ND5j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A09D1D63F7;
	Fri,  4 Jul 2025 15:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751643914; cv=none; b=cJ+kv+VWAfvv2Yb0XMS8SRCSRm1g6owEAVRUAencw42D0oj14f/OhH3tO6wpq/W/T0SKU2VtbhLoePa4J5zYq7mTTYtZ7PyZLGjtIos99G8CBsgw4Z35KInLpV/DjAm/38N6Up79G04J2o5AZBCxGEJozE1d8KOm4+x+hnOuvFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751643914; c=relaxed/simple;
	bh=Yi6FMGhdZmp71DBj0EoNOP5uhCm8MoVkiZdV+ZbPiRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Idf6af1u7h8bedG7PXDd9DxRdxsjL5ExYTClqV75T95rfcoMA3R1EdUBb4s/oAZ9r6GF/+/IFqgRPxkS+ca5LGyTO9TzVxSvzcNfDNr/Buey/KzhGsPftA/TlA5NJrp0fhrlls6fOJLp5rZxqN0iKMmt1EU/jt0k+eeNUM8DKXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=CYm2ND5j; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0DuoSA/mWIrLTrligVUY/NBThkero+S2hwPp4ObFsnk=; b=CYm2ND5jT/fDfPEk8Th1TeirHq
	UGVgWZSPL5rTHJf6WCadczN1ZO4E+FpyRnwpTnben/wdG7GqtS3NqnG8B7t/QGPqnp/BmVDMCHznN
	AyuOhHrmw4Pja4udlfz9sQla2k8E9qnjXrSg+ZncWoXxUZboNFDuTEIBqBHEgEkaRZWNEB1PQzCtV
	4Co0ad9HDyZBE8/UVElU7r7Wjcll73g9nc8InVJSBqBD2A3kqkixycFBFAPL6CEsW9O4QRMh3peWE
	cYiRoTIk5SDyOWF0Vnyl99JgSj2mZ41u+8dHVc3XnfGVcg/QxZqHX0EcGh933dP+93gXzwr3x3uGV
	qUlizKvw==;
Received: from [179.100.5.63] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uXiaw-00CUK5-Ru; Fri, 04 Jul 2025 17:44:59 +0200
Message-ID: <d73d784f-f6a1-40dc-b4bf-f2dbbb4bf7bc@igalia.com>
Date: Fri, 4 Jul 2025 12:44:54 -0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/futex: Add futex_numa to .gitignore
To: Terry Tritton <terry.tritton@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>
Cc: ttritton@google.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250704103749.10341-1-terry.tritton@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20250704103749.10341-1-terry.tritton@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 04/07/2025 07:37, Terry Tritton escreveu:
> futex_numa was never added to the .gitignore file.
> Add it.
> 
> Fixes: 9140f57c1c13 ("futex,selftests: Add another FUTEX2_NUMA selftest")
> Signed-off-by: Terry Tritton <terry.tritton@linaro.org>

Reviewed-by: André Almeida <andrealmeid@igalia.com>


