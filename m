Return-Path: <linux-kselftest+bounces-39382-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBB2B2E161
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 17:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A31971BA4437
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 15:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125532C21CB;
	Wed, 20 Aug 2025 15:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="CELdqXIV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E392DECBB;
	Wed, 20 Aug 2025 15:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755704457; cv=none; b=JPxBC9JwC3/H1rlTa852GMXicLP1k7+QEOWBAU3u+qNF5tkPUssJP9DjvfY+DxLQW9mPT4k8o3Me4afV1rsDXZmdpb8NGrv9UJIA1drzz+vHQAl6cOE5VgeVHse6s8guoqQBu9j/rv+m/pn1lyLK2FfhoboFF8N+2+aGbMXvXRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755704457; c=relaxed/simple;
	bh=yPQP9xdUUp1NC+xPWPtOPfUaY+fSaRi9v5dh68y2WMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qiTyhTJbwuSv5Tp+1cpOnvXf4SHLPEeyBMYJrHetH8okgYuIChWlwDZJBdjwIIiNvufCUSKcdW0p3td4q6/Jx7SzGYdSIMJ5fYrvJd71d8kq9cC9W/X/2JbH7qbRA7yO3KIPyd9JUAlAqceJBQRavbc/AjdAKi7gYUmU5yqZISA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=CELdqXIV; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1755704447;
	bh=yPQP9xdUUp1NC+xPWPtOPfUaY+fSaRi9v5dh68y2WMc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CELdqXIVZMAhgjQeKZUVklBBaisPw93K7CNRgICRezMzZ51dofeJ207eSZ2d/cTuh
	 9F3a59/ol4xN8pfDNH6rVAdXqD0m3dwXcmREgRy5Z6J6YUznhmbB702nUnnWubqEZP
	 XvStRYFrOIQDVdF3H+8xdL6FsP06pLUkVPn4w/VrR/ebzPNujUBWw6VnNlqSh+0SXe
	 XJPHOnwlUHMKaYgr+m42kyHw6VWBT7/xA3+hEeVjNp5/5DfKY97NpkeG5FMHDQyHR7
	 XbAmY9H224kxvJG4TJu4kMyhekHm1T1HKzx9yabCDfjgSPq23VRLRsBJBbx3+ziPHs
	 IsRGp/fa9O1Qg==
Received: from [172.16.0.63] (192-222-132-26.qc.cable.ebox.net [192.222.132.26])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4c6Vz34zxlz2G0;
	Wed, 20 Aug 2025 11:40:47 -0400 (EDT)
Message-ID: <92cf18ee-e1ee-43ed-91e2-35e35cf97af8@efficios.com>
Date: Wed, 20 Aug 2025 11:40:47 -0400
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] rseq/selftests: Use weak symbol reference, not
 definition, to link with glibc
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Sean Christopherson <seanjc@google.com>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Kienan Stewart <kstewart@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Florian Weimer <fweimer@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
References: <20250819222945.3052711-1-seanjc@google.com>
 <62f49015-e1af-43ed-8499-507a49032662@efficios.com>
From: Michael Jeanson <mjeanson@efficios.com>
Content-Language: fr
Autocrypt: addr=mjeanson@efficios.com; keydata=
 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 IZHa
In-Reply-To: <62f49015-e1af-43ed-8499-507a49032662@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-08-20 08:55, Mathieu Desnoyers wrote:
> 
> Michael, can you try it out ?

Will do.

> 
> Kienan, we may want to add a configuration forcing "-fno-common" to our
> CI, this problematic pattern may be hiding other issues elsewhere. I'm
> thinking of LTTng-UST tracepoint headers and libside headers.

AFAIK, -fno-common has been the default since GCC 10 so it's already 
well tested in CI, there are a few fixes from around 2020 in LTTng 
related to this.

> 
> Sean, do you want to contribute the fix to librseq as well ?

Librseq currently doesn't have the weak symbols like the selftests so 
the fix doesn't really apply.

> 
> Thanks everyone for looking into this. I'll be back from vacation next
> week and will resume normal operations. :-)
> 
> Mathieu
> 
>>     */
>> -__weak ptrdiff_t __rseq_offset;
>> -__weak unsigned int __rseq_size;
>> -__weak unsigned int __rseq_flags;
>> +extern __weak ptrdiff_t __rseq_offset;
>> +extern __weak unsigned int __rseq_size;
>> +extern __weak unsigned int __rseq_flags;
>>    
>>    static const ptrdiff_t *libc_rseq_offset_p = &__rseq_offset;
>>    static const unsigned int *libc_rseq_size_p = &__rseq_size;
>> @@ -209,7 +209,7 @@ void rseq_init(void)
>>    	 * libc not having registered a restartable sequence.  Try to find the
>>    	 * symbols if that's the case.
>>    	 */
>> -	if (!*libc_rseq_size_p) {
>> +	if (!libc_rseq_size_p || !*libc_rseq_size_p) {
>>    		libc_rseq_offset_p = dlsym(RTLD_NEXT, "__rseq_offset");
>>    		libc_rseq_size_p = dlsym(RTLD_NEXT, "__rseq_size");
>>    		libc_rseq_flags_p = dlsym(RTLD_NEXT, "__rseq_flags");
>>
>> base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
> 
> 


