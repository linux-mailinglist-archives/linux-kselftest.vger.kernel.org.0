Return-Path: <linux-kselftest+bounces-38614-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A22B1F0B1
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Aug 2025 00:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF63B4E02FD
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 22:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09BB28A73A;
	Fri,  8 Aug 2025 22:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="QX4PjWPZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E25828A707;
	Fri,  8 Aug 2025 22:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754692609; cv=none; b=HzI4PX6ct/hL04Ci8DMEcyZ3i5ObrwbZte6LWF7PBgAxxh5GxKGe9kLWlepVQprVs9OCDigXqrtlQXwrS8q9dc22YaDjHhck9LiuqRA9Dxyf+ckiuZc92Gh591g2yzGRHnp8AjHP0oLKOjjiGhGxd//p61IPjvQ27ok0N+QpvNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754692609; c=relaxed/simple;
	bh=FwS3PinrPKUfvFRBjrw/J/V0dYO5TbmhMhKrOf2xTcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ke6P5Y9mg5zN86MbLF79TXaJTU5Bjg/1Ijd3iZTXZ1jYg+VQ4dnGC1dWaRQLNCDpRIwEZo97AcwSw3rrsosdBHYN9Od2w2tEvbJ6gXV3lfLRvK3LLPtujgGSKSzkDuIWs3X3lub+be2aeXiwjlz1dU5dmUROxMdjsxDLYF/KIfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=QX4PjWPZ; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rZJ6sUI0VPGHKYwEWcMIEXdAhnlLGneT2c1oC2ZqANk=; b=QX4PjWPZtc0EbjsAcKd+eIr5KK
	DcAgU2OlKpOuRkVSV3YbK7+mvbVYXn0ZTMcQjsd0YOysA8R1wP+wNov+mC8aThJsuzDOSkW81NNDk
	AzTcWFb74xTSfmSF97QI7zg5cWFMb+iqneNx+F+3NH7BEQuMjEh6czUt4Hw9UDBTe5wEBftBooSdt
	bJ99bMSTh4b+6jqE8Oq8y2ySA2gbIS44Zz9206fPQEx8bI4sbGKSN/dHRJ42s6ZYWcXDmSIIEPDOa
	tYz+BJJMBzNlkXD/ewjpndyV1oaQyia0LDOPPEiGuwR5Jx0Gh/Fq2CocNJf4GeMySf15q3WPglXds
	WvC+yU/Q==;
Received: from [152.250.7.37] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1ukVhH-00Bkmi-C8; Sat, 09 Aug 2025 00:36:23 +0200
Message-ID: <11620764-a95a-40dc-97be-ba6a9a39e71c@igalia.com>
Date: Fri, 8 Aug 2025 19:36:19 -0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/futex: Skip futex_waitv tests if ENOSYS
To: Wake Liu <wakel@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Shuah Khan <shuah@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250807145550.1837846-1-wakel@google.com>
 <20250808071540.2122553-1-wakel@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20250808071540.2122553-1-wakel@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Wake Liu,

Em 08/08/2025 04:15, Wake Liu escreveu:
> The futex_waitv() syscall was introduced in Linux 5.16. The existing
> test in futex_wait_timeout.c will fail on kernels older than 5.16
> due to the syscall not being implemented.
> 
> Modify the test_timeout() function to check if the error returned
> is ENOSYS. If it is, skip the test and report it as such, rather than
> failing. This ensures the selftests can be run on a wider range of
> kernel versions without false negatives.
> 
> Signed-off-by: Wake Liu <wakel@google.com>
> ---
>   .../selftests/futex/functional/futex_wait_timeout.c    | 10 +++++++---
>   tools/testing/selftests/futex/functional/futex_waitv.c |  8 ++++++++

tools/testing/selftests/futex/functional/futex_wait_wouldblock.c also 
have a call for futex_waitv().

Apart from that, futex2_wait() and futex2_wake() syscalls may need 
something similar?


