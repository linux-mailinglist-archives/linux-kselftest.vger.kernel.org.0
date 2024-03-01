Return-Path: <linux-kselftest+bounces-5702-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD3F86DE42
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 10:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A183C1F27B08
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 09:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7CA6A356;
	Fri,  1 Mar 2024 09:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Bzk6hyKa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED192EB0E;
	Fri,  1 Mar 2024 09:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709285285; cv=none; b=tYpjXzXdtJluGwrMVB6kVH+pey0zLmfYYL1NNmHN91JrQKwGOiIt8kM6zEVNIEGeQpiGgMw9ZymmFt/Ox9tNcjE++v0UIpULNleZEgpBtBnPV4aaJ6rWM92sJYNtZR5F1Pj3T2j8qDVqMdwJBV8mHE4GQGARJAGXQbszZ6GDwgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709285285; c=relaxed/simple;
	bh=L5nqEaZ564iQomLzTksYYC3TTFf26qlS+Q0ueXvuHXo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=O+dZPWmuJQMvn4CHkVSL5ER8cdh/9dJMSi250Z1DfkN2vCSq3RpMN1PJ5y/QiLwIy8wAKXcGoCB4WjyCTBI7PcsLkJQbNnWd0itwMPjxL28VbS7jtMbxEiBc5QjtM7uLNegS/4cAeUvF4U+GSF2OAXzpStyYWE+qNVh7zQcYa+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Bzk6hyKa; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709285282;
	bh=L5nqEaZ564iQomLzTksYYC3TTFf26qlS+Q0ueXvuHXo=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Bzk6hyKaK3hasC6i1scAlG78eYLWjj6OIWtqJMbLwQBZVYC0FpjhFJ3p6eFWTz+RL
	 +1ZaqmvmNpnVwn/P1/ZfVUkJFIXVw+KvF5SdqB1YX1zKcSKybkLKeDF+daeaKFP5OQ
	 LaT6R1Efisw/JFRFEJ/y5B0tcKgYnZSCiTUnBRnT1+8iTo4j3+S/K0lgprg++fzk6x
	 BjY0h0Y+J80SbbY6DAyJZGP4pxKXYIlykYLmUr1BUNzs10dLhN9lQbkqCe4wpTTfMt
	 gcQYe4wM7nWQiT8FU0kaLM3cr8K5MH5rjHD9zeqk7afl3Ubk7qZxbqK63x1yVsYI08
	 f96PA872lvPLg==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B96AD37810CD;
	Fri,  1 Mar 2024 09:28:00 +0000 (UTC)
Message-ID: <d44ada61-8789-444c-9823-fc68704586bd@collabora.com>
Date: Fri, 1 Mar 2024 14:28:27 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, ben@decadent.org.uk,
 shuah@kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH] selftests/mm: Dont fail testsuite due to a lack of
 hugepages
Content-Language: en-US
To: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240301073300.287508-1-npache@redhat.com>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240301073300.287508-1-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/1/24 12:33 PM, Nico Pache wrote:
> On systems that have large core counts and large page sizes, but limited
> memory, the userfaultfd test hugepage requirement is too large.
> 
> Exiting early due to missing one test's requirements is a rather aggressive
> strategy, and prevents a lot of other tests from running. Remove the
> early exit to prevent this.
Why don't we only skip that particular test which requires huge number of
pages instead? Thus the behavior of this script would remain same.

> 
> Fixes: ee00479d6702 ("selftests: vm: Try harder to allocate huge pages")
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  tools/testing/selftests/mm/run_vmtests.sh | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> index 246d53a5d7f28..727ea22ba408e 100755
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -173,7 +173,6 @@ if [ -n "$freepgs" ] && [ -n "$hpgsize_KB" ]; then
>  	if [ "$freepgs" -lt "$needpgs" ]; then
>  		printf "Not enough huge pages available (%d < %d)\n" \
>  		       "$freepgs" "$needpgs"
> -		exit 1
>  	fi
>  else
>  	echo "no hugetlbfs support in kernel?"

-- 
BR,
Muhammad Usama Anjum

