Return-Path: <linux-kselftest+bounces-48551-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7451FD05ACD
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 19:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D171F30F434E
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 18:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEEE312825;
	Thu,  8 Jan 2026 18:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iwx/MBab"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B0430EF92;
	Thu,  8 Jan 2026 18:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767896848; cv=none; b=q9WzNMvwy6kLFEO72weQRZjsMWvTMmdxgU/Ixt00M77ww0X4UMhF5PmWbPegXKeag8Jg+BYnp6DlW2lHdPQV2kepygdhCl349oIWcpbnwZH1XEGkfkBhIrqdaoWtu7wRusVtMFaV25Pr8bM4fPuUFrKPSJBGhwnLMtT/KFQQmNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767896848; c=relaxed/simple;
	bh=4Vw3X+a+IKioJ+NPJzphxslue2bnilccQe6uqoqbw3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AhiT3EShaFPz6F0boOeFjopRpieujZU7rngygJaR+vc+Fuq3TX1mhybwL/fCkrTFnZwh9UR6EmMQMtI7Fh5p73dB7v0HVet7ZoYqkkQfhqgwbwsF1BC8d8a3ruy1A//9vHoPMdO0IiccUunZaajAxMWzieT8lRRkIJbDM38wRz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iwx/MBab; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E88B3C116C6;
	Thu,  8 Jan 2026 18:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767896848;
	bh=4Vw3X+a+IKioJ+NPJzphxslue2bnilccQe6uqoqbw3o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Iwx/MBabhg9Mn+RsGiViYT+ZtBLk+a0OIAgTpLgDDHowndzS8Ks5rr++DhJ+hwH0Z
	 hrNA6qp/oQ4uM9w3j7wjJmszJ28L8101AyR46VWdSygNb14gJhNGBTOMGLBLUT9h8I
	 ORbImCIpzVZ7YEqgk8J+ONeLu26JUgXIP1y5qJZwbIaRWDp9lsm0ZIulZVwSdY67u/
	 rDse34I/dswNeGsuXAgSojzYyNYEjo6/I5KTBjb9G1qZf3P/N9jDPdFnS6GUuZxQ/B
	 3rHmnZLd/iaQAI/QRoYQr3LJV17RKT2e4JX0xX8Hwi/RNlnOLXNbLko4CArC6zJJms
	 bBG44Az3Aoa8w==
Message-ID: <4513bb41-e493-48bb-bd58-f1cc3ea44e5f@kernel.org>
Date: Thu, 8 Jan 2026 11:27:26 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/tracing: Fix test_multiple_writes stall
To: Steven Rostedt <rostedt@goodmis.org>,
 Fushuai Wang <fushuai.wang@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 mhiramat@kernel.org, shuah@kernel.org, wangfushuai@baidu.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251227041821.75504-1-fushuai.wang@linux.dev>
 <20260107034914.22315-1-fushuai.wang@linux.dev>
 <20260107101846.61c182e0@gandalf.local.home>
Content-Language: en-US
From: Shuah <shuah@kernel.org>
In-Reply-To: <20260107101846.61c182e0@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/7/26 08:18, Steven Rostedt wrote:
> On Wed,  7 Jan 2026 11:49:14 +0800
> Fushuai Wang <fushuai.wang@linux.dev> wrote:
> 
>>> When /sys/kernel/tracing/buffer_size_kb is less than 12KB,
>>> the test_multiple_writes test will stall and wait for more
>>> input due to insufficient buffer space.
>>>
>>> Check current buffer_size_kb value before the test. If it is
>>> less than 12KB, it temporarily increase the buffer to 12KB,
>>> and restore the original value after the tests are completed.
>>>
>>> Fixes: 37f46601383a ("selftests/tracing: Add basic test for trace_marker_raw file")
>>> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
>>> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
>>
>> Gentle ping.
>>
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> Shuah,
> 
> Care to take this through your tree? It does fix a bug so it likely should
> go into the rc releases and not wait for the next merge window.
> 

Yes I can take this through and send this for rc5 or rc6.
But first the following warning needs fixing before I can
apply the patch

WARNING: From:/Signed-off-by: email address mismatch: 'From: Fushuai Wang <fushuai.wang@linux.dev>' != 'Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>'

Fushuai, please send me v3

thanks,
-- Shuah

