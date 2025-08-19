Return-Path: <linux-kselftest+bounces-39305-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EACBB2C390
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 14:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCBF416DE82
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 12:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277D4305064;
	Tue, 19 Aug 2025 12:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="dWFY1RHO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71300305050;
	Tue, 19 Aug 2025 12:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755606182; cv=none; b=ozq8c+rRU5pwMgZ4TSBLnj3loxAP0z90pWIcP0UYCkVfSX1NIz9nlpGLOs/nUl4Jixs6KEoAV70XfX68dN1ZTSKspqGLJ3NbuGQv2dUilyGeOl+79GE4OMC6mipWc8H9xf/ZBoMENULObsIlNrX6VGqyb6e62sbaPjsY72RaEvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755606182; c=relaxed/simple;
	bh=UIVgnaPOkfkj0+s2fZ1kT4QmB6+k4qgll7lE7+uny4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hWtul/Jo7jksBJUQViqB376UrevGyeNAPog+lmOcATwy+wqiMDdXzNfb2i2WN75H+oUAdfynf4gd7RqcZsrgj08l83PScwMow/IwT1k59L3vo8xj5RPBoNsVQcqc3F1XGFZ14TnocByTczGlJiuuOkiFojDKNnkSCrae5p/HB+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=dWFY1RHO; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Wt9Rl5yae8ZyPuScS1CiDGrHZdakA/vXQAszbSh8Efw=; b=dWFY1RHO0fCOnfiGdkfXKn8FBf
	NU+2XZ/MmYttCVLyDkQrIjiQmBVgwEGHXudg8efRAF2dm9Wh+I87fg0Y1561DwZFa4e5T5B6S4N5i
	ddN9EOpycDklANyzP/75z0jGETgqRrX9jqUJX8vnfzQxslux7LbNRHeMwlZ554QQARwqBCRc7rIjk
	Eq5R7VVJEqlhmFmmq2KZlQysflNZChBETkkWyBlZiFHy6HiQ3baKHfNF47J5bOUbeydK5XWjM2ipX
	BHOLMHeCNuFzLKoTkllWnM6TQbHP9osV4SLiYhKgYonLj/pkeeHDMAPTiAhcQSfm6JqvDl3JNOUDX
	yIL8teNg==;
Received: from [152.250.7.37] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uoLMc-00GIHi-0l; Tue, 19 Aug 2025 14:22:54 +0200
Message-ID: <336a1a43-54ac-4f53-b3a8-5e46f6d45359@igalia.com>
Date: Tue, 19 Aug 2025 09:22:49 -0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/futex: Fix some futex_numa_mpol subtests
To: Waiman Long <longman@redhat.com>
Cc: linux-kernel@vger.kernel.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>, Shuah Khan <shuah@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kselftest@vger.kernel.org, Colin Ian King <colin.i.king@gmail.com>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>
References: <20250810222742.290485-1-longman@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20250810222742.290485-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Waiman,

Em 10/08/2025 19:27, Waiman Long escreveu:
> The "Memory out of range" subtest of futex_numa_mpol assumes that memory
> access outside of the mmap'ed area is invalid. That may not be the case
> depending on the actual memory layout of the test application. When
> that subtest was run on an x86-64 system with latest upstream kernel,
> the test passed as an error was returned from futex_wake(). On another
> powerpc system, the same subtest failed because futex_wake() returned 0.
> 
>    Bail out! futex2_wake(64, 0x86) should fail, but didn't
> 
> Looking further into the passed subtest on x86-64, it was found that an
> -EINVAL was returned instead of -EFAULT. The -EINVAL error was returned
> because the node value test with FLAGS_NUMA set failed with a node value
> of 0x7f7f. IOW, the futex memory was accessible and futex_wake() failed
> because the supposed node number wasn't valid. If that memory location
> happens to have a very small value (e.g. 0), the test will pass and no
> error will be returned.
> 
> Since this subtest is non-deterministic, it is dropped unless we
> explicitly set a guard page beyond the mmap region.
> 
>
I had proposed a refactor of the futex selftests[1] and I spotted the 
same issue with the memory out of range test. My solution for this was 
to create a "buffer zone" with PROT_NONE to ensure that I would have a 
invalid memory access:

/*
  * test_harness_run() calls mmap(..., MAP_SHARED, ...), which can create
  * a valid access memory region just bellow the mmap() issue here. Then,
  * the test for "Memory out of range" will fail because it will succeed
  * accessing the memory address after the range. To avoid this we create
  * a "Buffer zone" with PROT_NONE between the two mmap's.
  */
buffer_zone = mmap(NULL, mem_size, PROT_NONE, MAP_PRIVATE | 
MAP_ANONYMOUS, 0, 0);

[1] 
https://lore.kernel.org/lkml/20250704-tonyk-robust_test_cleanup-v1-13-c0ff4f24c4e1@igalia.com/

