Return-Path: <linux-kselftest+bounces-45993-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 43718C6FB23
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 16:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 10AC64E45E2
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 15:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566E329A9CD;
	Wed, 19 Nov 2025 15:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="DiOLNDF7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FF3285CB3;
	Wed, 19 Nov 2025 15:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763566319; cv=none; b=B/PXPxBGak8WlkxG+UguBSvNX4AfJD4oxBgaqQsOt3RxFPmTSzACcdX6q97FDGa7IgdMuMN9xniVJNI7y2/JGobmDmAV7TD1JUCIlolp4wEmVk/IrB3iiAbANAOxdQtD7AevMiNXJlo410DwlQRjCZLvYJhRPNziCaUoxpGtikM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763566319; c=relaxed/simple;
	bh=UA6BbECwsiGdz8YYnxOIoGO1ZKDze8WBFj4cUmpvk84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RkafdT1Gh9DtUBXZGEI4gYr0jb8iHSGbqjIyvugkNno1spV4OSIcOEjuV3Dvdax3HuoP5dcjOJRxO6mbRvonyAx2X/JMrFPne38liyIk7purPXRezQ/HxMpORV8T3PG6mXlUmRHXDQizS+r4LqdwCsdtEECZUmXNd9625wQgW2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=DiOLNDF7; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZEydrG7L1tp3+i+7Fup4PEypaIBN4DKaXmuX18Pd51Q=; b=DiOLNDF74veKYhJgk4wDwEDoXF
	yY6VNA0wHAm0EiJ0FcnqW8SHxNNJ6CTleyLTnbRiPPWZ5rCPBbwG1vrYepwtSSfvUqtHa2wyNCnEI
	N2Djv8x9ggJwy5k/to2cyFTa5h96cgTU102th7uOlswxWwhpWb7w7dd1KiqVZBYBKYtxMkNrqEAJP
	w6Wqtkx0OJBF123yRplNV/vKfyh8M+r8DSKkpIGGDCcBnsOL/wdVr/CSDb6zbkg78uSmsNyuhyeWU
	RoUzr4f6sQf9Y8cqXQy3293np/81zxsyX9CObieyFuMZuONOTF8/ZqSJRY8cqrZemMkW4hqWuhB+/
	2qT7O7Mw==;
Received: from [187.101.0.152] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vLk9q-002pHQ-Ug; Wed, 19 Nov 2025 16:31:46 +0100
Message-ID: <b133c105-861f-4c56-b3ef-ea2ec5054e65@igalia.com>
Date: Wed, 19 Nov 2025 12:31:42 -0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kselftest: futex: Fix memset with zero size warning
To: Wake Liu <wakel@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
References: <20251119030052.315502-1-wakel@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20251119030052.315502-1-wakel@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Wake,

Em 19/11/2025 00:00, Wake Liu escreveu:
> The `FIXTURE(args)` macro defines an empty `struct _test_data_args`,
> leading to `sizeof(struct _test_data_args)` evaluating to 0. This
> caused a build error due to a compiler warning on a `memset` call
> with a zero size argument.
> 

Do you mind sharing your compiler options? I can't reproduce this 
warning here. I also noted that a few other selftests have this pattern 
of defining an empty FIXTURE(), do they also produce warnings?

