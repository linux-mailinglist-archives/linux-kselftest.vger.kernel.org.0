Return-Path: <linux-kselftest+bounces-2893-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDFC82BB57
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 07:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2E02B25251
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 06:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7271B482F2;
	Fri, 12 Jan 2024 06:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="4lNpPT8A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED51133067;
	Fri, 12 Jan 2024 06:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705042228;
	bh=rXcbu4QY6UCu3qy4gvXw+tpopWxC0tsBqLnsgFqfj/Y=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=4lNpPT8APDolfFCTLwh0woAmpgkpMjWjRiAcuOwGVtOmZHgPQJPjDY1i+rTrdB2jo
	 rcLq9g8koWFxvFcoNPA6t6zy4fOxXySsLwmAPgXM0FD+11scWCGX3MGaDgD/FZ1CyV
	 KMRCqOYoCxQQrN7fbTlRVoBgBdkE8c/9sFm7cHxjIzhxP8nr1tEn51VGbVZNWvbg+K
	 4oJveuu99TmvFwQj7tp1/wpHPw+/4BsCoOMl2XjIJnulTxtFHOxzY/6EDeQhnuBn9A
	 rPAyhbTVZdGvr+4haE6jnHKRaXNN9G779HKR2d3cHiwmg9/1Zji3GKx+wnSwFBsOeZ
	 A7PSHbMh2Jijg==
Received: from [100.96.234.34] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EC6403780624;
	Fri, 12 Jan 2024 06:50:25 +0000 (UTC)
Message-ID: <bfb6f6ac-d29f-4857-aa8c-6b8da9c2f436@collabora.com>
Date: Fri, 12 Jan 2024 11:50:33 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>,
 "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 Lorenzo Stoakes <lstoakes@gmail.com>, kernel@collabora.com,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/mm: mremap_test: fix build warning
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
References: <20240111082039.3398848-1-usama.anjum@collabora.com>
 <20240111131405.4b47521fb8884760d712e93d@linux-foundation.org>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240111131405.4b47521fb8884760d712e93d@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/12/24 2:14 AM, Andrew Morton wrote:
> On Thu, 11 Jan 2024 13:20:38 +0500 Muhammad Usama Anjum <usama.anjum@collabora.com> wrote:
> 
>> Fix following build warning:
>> warning: format ‘%d’ expects argument of type ‘int’, but argument 2 has type ‘long long unsigned int’
>>
> 
> Looks good to me, but... grumble.
> 
> `i' is an integer.  That's just how it is, Blame Fortran if you like. 
Didn't know this. Thanks for sharing. I'll send a v2 by using two variables.

> Discovering that someone used `i' for an unsigned long long is like
> seeing
> 
> 	struct inode *page;
> 
> It is surprising, and readers shouldn't be subjected to surprises.
> 
> `i' is used in two ways here.  Twice to iterate across threshold values
> (as a ULL) and once to iterate across dest_preamble_size, which is an
> int.  It would be better to have two different variables for the two
> different uses.  Ones with more appropriate names than `i'.
> 

-- 
BR,
Muhammad Usama Anjum

