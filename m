Return-Path: <linux-kselftest+bounces-6216-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44363878602
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 18:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC2D4281D61
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 17:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6058C4879E;
	Mon, 11 Mar 2024 17:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PX0CeTRQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8073B7AC;
	Mon, 11 Mar 2024 17:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710176891; cv=none; b=Eu0q5CHp28F4y+yNR/onNsXfpEfLqup3E/f40CeShlquy9MKdNFhryUBhrReQblCQU2RACr54JyyEBL5ZbKpdQvjOTg7dW4cDTODrf4YQsWxXrFG5u5oqxnz18ZNKyoKbpn4oRRSop69+9AWmUC3JJ14G+LZd0qrzJexi+RG7TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710176891; c=relaxed/simple;
	bh=j1+lCDL3pPjq33bhRXpGF+V0YmEJ2UOr72fJ5Hlut3g=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qMXU4isdbu0LLzxmwxBokImuzAqdMmODgpPjw+h8qIb0FsZa2pF6y/0X9ZR6DoSPuDPm+9uV9qjuhGNsdVMkdhpmzE3YJq2pIpOCo4FImusDNWF6iijtdoFqsHCfSiq0rs5CEukUjC0ubbhs+hwkwOpiRirRg2RvBFJSmX3R5Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PX0CeTRQ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710176888;
	bh=j1+lCDL3pPjq33bhRXpGF+V0YmEJ2UOr72fJ5Hlut3g=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=PX0CeTRQ/l4o+UZJghvdiZX9xmrFLq9w4rIe1uc7R4LXtVZU2CFNmre2kmJHbI465
	 9xHfbbc8s1DAZgMVWt1mXB/Z140MOCEKXpH6SJyos8Kio+mRb9M+FxHnPWX/UnULRi
	 9E+UU39eMR7H5eoPIPin7ZRXsW5kHnMR6vzP8Z+iD0HI8QQnP1LVV8f1c+2yYpJM05
	 0Ht8Ch1dfgxmcSmDkm2nMpruzg8VSc83qGdi8pDSI6b5qxwLQCAq+YsxDJ+YtFMyBP
	 8n7fRw1Gq/Rwdx9RaxZHcHWrJmlLXOMpnlewPMq8EgqOIzlhqv5XncZeYed4eK9H/F
	 MGOWjd81NfAiw==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 94EF0378200D;
	Mon, 11 Mar 2024 17:08:05 +0000 (UTC)
Message-ID: <cf98ff2f-66a8-4800-855f-5c03c952b514@collabora.com>
Date: Mon, 11 Mar 2024 22:08:36 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Eric Biederman <ebiederm@xmission.com>, Shuah Khan <shuah@kernel.org>,
 Mark Brown <broonie@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 "kernel@collabora.com" <kernel@collabora.com>
Subject: Re: [Test Failure Report] exec: Test failures in execveat
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>
References: <02c8bf8e-1934-44ab-a886-e065b37366a7@collabora.com>
 <202403051256.7A50FE28E7@keescook>
 <fd210d04-cc98-4e29-a051-bdb7e1367494@collabora.com>
 <202403071238.AC7BD90@keescook>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <202403071238.AC7BD90@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/8/24 1:39 AM, Kees Cook wrote:
> On Thu, Mar 07, 2024 at 02:22:27PM +0500, Muhammad Usama Anjum wrote:
>> I've tested this patch. Still getting same failures.
> 
> Okay, thanks for testing!
> 
> What environment are you testing under? It would seem like some unexpected
> userspace conditions exist that the test isn't prepared for. (I was able
> to reproduce one error with /bin/dash, for example, but not the others,
> so something must be different in the set up.)
I'm testing on Debian Bookworm with v6.1, v6.7 and next-20240304 kernels.
I've tested it on another VM which is also Debian Bookworm. The default
shell is dash on Debian as well.

> 
> -Kees
> 

-- 
BR,
Muhammad Usama Anjum

