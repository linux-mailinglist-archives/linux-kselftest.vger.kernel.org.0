Return-Path: <linux-kselftest+bounces-19247-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C7E995492
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 18:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4101EB286C9
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 16:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081651E0E18;
	Tue,  8 Oct 2024 16:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EuwGGFX2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C1D1E0E04;
	Tue,  8 Oct 2024 16:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728405437; cv=none; b=um7p8GOmXR4bsTUGcmejuhUm9M65W6r521Oh6M5DeLkYf1WC7lmEnJlyvAaXKuvxDdc7ZVYOffuvrRIXhn3jrcnVrelA+e7NCWoYQW7Q4bUsFe2nS8ATQwZd1xYrCU+tRJgWjn3bQGTGhur0bSQi+lqw4Gj8N5LP0zUqXqHceG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728405437; c=relaxed/simple;
	bh=I0eecJ1H6p39j89P52KD9UBoB62EIuYihHp66Ej7wHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ox66tqVIB4/R772ctTI93Bc5oDqrcboXvjoY8d3BBJmod17iQ3li4BVk+339VloXMAiuxffeHXzhae/FDCDRUs0A2pxOr4R8mNC8wqCIDqG2TDM21pSvxjB0GE11qKNCR+uPNG4Lqa27chdgjuRD+8wLYSrNv621GVrqUvepNaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EuwGGFX2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=pAwcdPyDTWI0IXx2YvTOKN936XNdh4Q1YXTzNk6IMP0=; b=EuwGGFX2Nr6WjkjncN9Iw8jvmB
	oy+l0QizqUs+FGN9+GxzBkEmxxjsqsk0WvHb/nuTYjY/sQc/1fLhJ5GWsWVRZlQE2H/cDiLaCFZJg
	gQzTV7EtWBNOaaMye40hV1zrxgKFLTnCjhsZjLIn/TBXvyXO4OCD9UG8Vblms0rEX/giL7okr4XQr
	1xR7eDenFhs5brX3c0gHIKwSQ6NitlXCV8m/M33399F6Vb+4VxH8yEB8XL6UASR8a0bmb3ptU6lf3
	iz9Q0PjG0Rw2R58NWIqPGUK1qQi5BDcJSkWqpVjHJlxO+NH4Z9PnnpXvnFDFJp+8vhxdSA8wtN7L3
	KA7RJfQQ==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1syDCs-00000002jZk-3lIX;
	Tue, 08 Oct 2024 16:37:08 +0000
Message-ID: <5e1ef8a0-f063-4166-9d93-cf047cdd2792@infradead.org>
Date: Tue, 8 Oct 2024 09:37:00 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mseal.rst additional fix
To: jeffxu@chromium.org, akpm@linux-foundation.org, keescook@chromium.org,
 corbet@lwn.net
Cc: jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, jannh@google.com,
 sroettger@google.com, pedro.falcato@gmail.com,
 linux-hardening@vger.kernel.org, willy@infradead.org,
 gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
 deraadt@openbsd.org, usama.anjum@collabora.com, surenb@google.com,
 merimus@google.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 enh@google.com
References: <20241008040942.1478931-2-jeffxu@chromium.org>
 <20241008041804.1481453-1-jeffxu@chromium.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20241008041804.1481453-1-jeffxu@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/7/24 9:18 PM, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> Change "overwrite" to overwrites"
> 
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> ---
>  Documentation/userspace-api/mseal.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/userspace-api/mseal.rst
> index 41102f74c5e2..54bbcce330ec 100644
> --- a/Documentation/userspace-api/mseal.rst
> +++ b/Documentation/userspace-api/mseal.rst
> @@ -97,7 +97,7 @@ Blocked mm syscall for sealed mapping
>     The first set of syscalls to block is munmap, mremap, mmap. They can
>     either leave an empty space in the address space, therefore allowing
>     replacement with a new mapping with new set of attributes, or can
> -   overwrite the existing mapping with another mapping.
> +   overwrites the existing mapping with another mapping.

No, that one is correct as is.

>  
>     mprotect and pkey_mprotect are blocked because they changes the
>     protection bits (RWX) of the mapping.

-- 
~Randy

