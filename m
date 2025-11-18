Return-Path: <linux-kselftest+bounces-45872-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 566ABC6AB73
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 17:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7F6B63A194E
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 16:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531F0377E9D;
	Tue, 18 Nov 2025 16:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="JG2vECVA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E81270EBA;
	Tue, 18 Nov 2025 16:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763483718; cv=none; b=I5oWl8oKCNTas7QGe3yMCVotTA4m37KDGggZqrD5kph0dTsdiKhfnHEnaeDh922CrVA7yNkAvED0w0mKDLKJXfatWM5yTJfBd9JS4RZzTJNODPRC5aA4ct8ZC2Q1QverX+/G8TGNnYPkq4j7i2WllDMJpRh8mRT6PJ1WuBv/rso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763483718; c=relaxed/simple;
	bh=wRa9wV7lXAq4pWQQ4zTDvQPhFOJmW08DMcRpEwY20Oc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xi6QX9TX5IAl/T8onGHVEC4gOuwnJ2u25VnYgsjvKPhSTAIDk99QaUOG6gAnQn0M51OEY1Mbqr7XwbHjZPJwI2FmNelEPdZHySHLa4a0EsjOrrZ4rbYjNi9Q3vqxjo3qLccMczoLGWZXd0Xp3IZvd2Ndbglx+x75p1YQoA9Kqyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=JG2vECVA; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ksh9U0KHuVHmxLCi5JNn753atu32AFabkMKbDwp9OmY=; b=JG2vECVAx0pyo6yhYbTg9UVmfc
	Blj6C5wQZ22ejABvEFyNMzRJoabX6DJcCKpPBOYi0b7j7JitY8EsIUL0vH0YIZLAPqyyOsUqK3G2v
	X2dHC30+WfqawtJJXj4Y18FiIdO8bedcaQoNTqkCJ/wVYAsT7qixqkAUnWApgVB3GByMEqTnC/jw8
	ygwqsTs5lHfo7Dg9kiVZSUhn2IgKlO7c9cjWb0Hpth3QzI02n8eM4wLaWreDIy38mKj9ivqUneQpc
	8Eap+HavW8RK2WpTYYqeU39ixxFQLhueWAwJyoNHdHCOH1Eyp0rcJDEWud8yqR8UHA7MeXgixAJQC
	AVoeLMPg==;
Received: from [187.101.0.152] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vLOfX-002E87-Mv; Tue, 18 Nov 2025 17:35:03 +0100
Message-ID: <078950cf-01d0-42b0-868f-15096afd97e8@igalia.com>
Date: Tue, 18 Nov 2025 13:34:59 -0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/futex: Fix storing address of local variable
To: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Darren Hart <dvhart@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Shuah Khan <shuah@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 linux-kselftest@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>
References: <20251118162619.50586-1-ankitkhushwaha.linux@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20251118162619.50586-1-ankitkhushwaha.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 18/11/2025 13:26, Ankit Khushwaha escreveu:
> In `child_circular_list()` address of local variable ‘struct lock_struct a’
> is assigned to `head.list.next` raising the following warning.
> 
> robust_list.c: In function ‘child_circular_list’:
> robust_list.c:522:24: warning: storing the address of local variable ‘a’
> in ‘head.list.next’ [-Wdangling-pointer=]
> 
>    522 |         head.list.next = &a.list;
>        |         ~~~~~~~~~~~~~~~^~~~~~~~~
> robust_list.c:513:28: note: ‘a’ declared here
>    513 |         struct lock_struct a, b, c;
>        |                            ^
> robust_list.c:512:40: note: ‘head’ declared here
>    512 |         static struct robust_list_head head;
>        |                                        ^~~~
> 
> Defining the value with static keyword to fix this.
> 
> Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
> ---
>   tools/testing/selftests/futex/functional/robust_list.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/futex/functional/robust_list.c b/tools/testing/selftests/futex/functional/robust_list.c
> index e7d1254e18ca..d1aab1cc5a37 100644
> --- a/tools/testing/selftests/futex/functional/robust_list.c
> +++ b/tools/testing/selftests/futex/functional/robust_list.c
> @@ -510,7 +510,7 @@ TEST(test_robust_list_multiple_elements)
>   static int child_circular_list(void *arg)
>   {
>   	static struct robust_list_head head;
> -	struct lock_struct a, b, c;
> +	static struct lock_struct a, b, c;

I believe that the right fix here would be to drop the static from 
`head` declaration, WDYT?

