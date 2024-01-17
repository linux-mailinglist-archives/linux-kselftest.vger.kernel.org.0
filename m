Return-Path: <linux-kselftest+bounces-3132-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FF682FFA5
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 06:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97AAF2828B5
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 05:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2131611A;
	Wed, 17 Jan 2024 05:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="j98ufzQX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECB31C0F;
	Wed, 17 Jan 2024 05:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705467634; cv=none; b=apBwZFaDP3G8lSIUOJXfEQepe4ZO0L+FBp7V9FexnAnZXYnIxX6yGXw0cWHoDVffI+K4+luyowSvyku5umz2AMp1OoFUKXCEfeLPQFjhvbNuOp3hnsiH2TrH9+lXgeLJ2dOkhsyIAo2NEKZRri+Q0nBb7LhaY9HTS/kUfSYEG4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705467634; c=relaxed/simple;
	bh=zULSsRwTQq8k5rydVDaY+DT96t5URjDNTyZA/KomP58=;
	h=DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Cc:Subject:Content-Language:To:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding; b=BC3XtgzYHM/x+bHQH6smAOE1AsXRCTebqU9R3/APnLoMCrI3j+4A6osCYxcE445H5ge0iz1lYqITH7/d0FTfBy1Gx1m/H3UFbUNNq0yoQIpn/t6a9h60VhQyQcBow4IrSSbdphzg+YQAbI4pGyTq59vEdKyYLFyP2nTx1S0n9JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=j98ufzQX; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705467631;
	bh=zULSsRwTQq8k5rydVDaY+DT96t5URjDNTyZA/KomP58=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=j98ufzQX43Ks4+QXuqTCA+FMbw1Gr0KuHxDORHQ0W1A/xDete07+1DgDqrKcywrzJ
	 Oep/Az7gugCKeEYMTIv5UyT0X3h1xwfmbuAuqKy+kCxe4QP3Ut9qrZ7r6i5isF2wcO
	 xCzGxSxCvp4F5CpeSwBFviaT+j23PhyNNJrobi9pPqasRbxoAjeFPlJ12KX79Hqm5F
	 GOwe+Hg53vBxIWIKO1Vb5nthbc80SYi4qo2ieYsnlHrMQdV2AlpKFxrVgqjKDVq6zx
	 MoyRYXsfGNKPiay9lk+NdD0E8P7D4dLfKDvL9cN+nNOrH5fEQfEKgbZr6O6zAPht0w
	 QmOZfmUxbAe0g==
Received: from [100.96.234.34] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 79914378206D;
	Wed, 17 Jan 2024 05:00:29 +0000 (UTC)
Message-ID: <fe1334e0-406b-40e4-b0e3-1c93a6764d99@collabora.com>
Date: Wed, 17 Jan 2024 10:00:38 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 "kernel@collabora.com" <kernel@collabora.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests/mm: switch to bash from sh
Content-Language: en-US
To: David Laight <David.Laight@ACULAB.COM>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
References: <20240116090455.3407378-1-usama.anjum@collabora.com>
 <0d5811eafd00496d98e88afe847fb8be@AcuMS.aculab.com>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <0d5811eafd00496d98e88afe847fb8be@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/16/24 9:52 PM, David Laight wrote:
> From: Muhammad Usama Anjum
>> Sent: 16 January 2024 09:05
>>
>> Running charge_reserved_hugetlb.sh generates errors if sh is set to
>> dash:
>>
>> /charge_reserved_hugetlb.sh: 9: [[: not found
>> /charge_reserved_hugetlb.sh: 19: [[: not found
>> /charge_reserved_hugetlb.sh: 27: [[: not found
>> /charge_reserved_hugetlb.sh: 37: [[: not found
>> /charge_reserved_hugetlb.sh: 45: Syntax error: "(" unexpected
>>
>> Switch to using /bin/bash instead of /bin/sh. Make the switch for
>> write_hugetlb_memory.sh as well which is called from
>> charge_reserved_hugetlb.sh.
> 
> Why not just fix the script?
The Bash is being used in all or most of the selftests. I'd seen other
similar [1][2] patches floating around which are converting /bin/sh
(pointing to dash) to /bin/bash.

[1]
https://lore.kernel.org/linux-kselftest/20240110141436.157419-2-bpoirier@nvidia.com/

[2]
https://lore.kernel.org/linux-kselftest/20231229131931.3961150-1-yujie.liu@intel.com/

> Looks like most of the [[ ... ]] could be [ ... ]
> although some might need to be [ -n "$cgroup2" ].
> The delete the 'function' keyword another bash-ism.
> 
> It's not as though you are trying to run on a system
> when /bin/sh is a traditional (aka non-posix) bourne shell.
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 
> 

-- 
BR,
Muhammad Usama Anjum

