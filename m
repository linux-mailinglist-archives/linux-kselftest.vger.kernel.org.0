Return-Path: <linux-kselftest+bounces-45992-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BFCC6FAEA
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 16:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 40BED3477D7
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 15:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B737433EAE6;
	Wed, 19 Nov 2025 15:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ULo3ngKQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5CA34FF4A;
	Wed, 19 Nov 2025 15:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763566147; cv=none; b=fepA4MdGxCc3q7jIgdeMwQt/28PneS8qYNSYm8lmY3jdZk3d15xlZZTYmbtFOquxk9yRqG5UoPOUMp2SqcK9tL+4T84QbEQVL+Xk10xv72AsdEdY9E7xyKBbu/tdNNOOlbI43NoGqeCIuhl+JLwK2OAM0TW7a2YVj5hlB2WlfL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763566147; c=relaxed/simple;
	bh=fxRrC4eWDzwRTHar/gM5igIfuXRafCI9mBKcj9AGc0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eCHSYrcZn0CcGoTQkARS8n/9fsGBhbBb/NU+IdTiCBN99d3UmOQdXzsxb+GF9WBeUgu8s5p5U6ax6RitsgrIcaqqfgGHrcAeRAeXpfPEiVVyV6s3pNhmvjqhhbNU3r4YG3i5h5YCjEOv0cu1+Bv65UyWh2DhqgfVp70tPAAH+iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ULo3ngKQ; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gluVA1xMVK3xSRqyLRXhSYdly47aZriJBcNX3M9TlqQ=; b=ULo3ngKQeuE/xdWc+cNtJqQj3l
	XyAlPCGr0/3y5TIAwrBbf7Rq57INSnN4+D0f3y99OgVy1NlZU7snxfgwRS6UeYaWCcVjMW3pKnVOA
	BR+KU8dB2v4GdN1KpL6bnn1eTbIxvpxHF3rCCsDAdSOVxCf3nHCkQWLvSyWNmIbLvM6kFico/voj9
	dpSjxO9EdUz+dMqvcjAsn/wm878dv2i/bK5pAtk3/K+eINcslVjZ0Yv5VMOM3j/Qk9xgXagHb/5lk
	T43CmRuJRbXxmmV4eValbrHYy28HLrFHWGJ4HBTygmRw7YnYjwyqClHrNCeXZSaiXa+4BTJ29Bmtt
	TENySD3w==;
Received: from [187.101.0.152] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vLk6s-002pEQ-MB; Wed, 19 Nov 2025 16:28:42 +0100
Message-ID: <cfed2906-291f-41e9-a6ba-4884a7380d17@igalia.com>
Date: Wed, 19 Nov 2025 12:28:37 -0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/futex: Fix storing address of local variable
To: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Cc: Darren Hart <dvhart@infradead.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Davidlohr Bueso <dave@stgolabs.net>
References: <20251118170907.108832-1-ankitkhushwaha.linux@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20251118170907.108832-1-ankitkhushwaha.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ankit,

Em 18/11/2025 14:08, Ankit Khushwaha escreveu:
> In "child_circular_list()" address of local variable ‘lock_struct a’
> is assigned to "" raising the following warning.
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
> removing the static keyword of "head" to fix this.
> 

This should be "Remove the static..." as noted in the kernel documentation:

"Describe your changes in imperative mood, e.g. “make xyzzy do frotz” 
instead of “[This patch] makes xyzzy do frotz” or “[I] changed xyzzy to 
do frotz”, as if you are giving orders to the codebase to change its 
behaviour."

Please have a look on this page here: 
https://www.kernel.org/doc/html/latest/process/submitting-patches.html

