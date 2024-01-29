Return-Path: <linux-kselftest+bounces-3687-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A16E8404FD
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 13:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7B631F22E4C
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 12:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752A9604D3;
	Mon, 29 Jan 2024 12:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IkvWCcat"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B626A6087E;
	Mon, 29 Jan 2024 12:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706531282; cv=none; b=YVvGic5sTeMG63FfB1L7pss/Yz8+dztY4bXmAwRP4vbReF1cGRYbl4LeHluHiqj+kvNsM9zCSpjMMCD21ev0Qyow8NDy9Sv8BEZ24O5H6Vih8znCljrpyqQ4/ED3EEUmV44onb+MeVU5k18cqJnG4mxEiZwhx88KSU5mk6TQrmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706531282; c=relaxed/simple;
	bh=wtct48Xnu9tMkFU96DvSJS/jG9ywDzu01vAbn0w9TwI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hO+QxGD/71PNAbXOK79UKQAMI+hhuvoRUv1ZaMlBFfbYUTIKeIJd/zF9sIYcaDaWUWEpIAku5EG98ABiQ1PzEe2/RSGQna00wJCFduyWOBWLCKg+VoJ7xL7FC2VIFySfRhTt4rCO0L8A6f8rSw/P6QsJ3IsTdzLwDJL4/lfJVZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IkvWCcat; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706531277;
	bh=wtct48Xnu9tMkFU96DvSJS/jG9ywDzu01vAbn0w9TwI=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=IkvWCcatiFBInP0jrFI+ya1i5nuwmVu8KjnLGoNxZAExbUIwQDMCjxxy3/9YA6Im7
	 5U2pUPmusMGTxYHraw2vN/cfrt8GIT5shyTiCHIeoAU0g9ZZhFqPVMLgNfG9bFSRWc
	 slJZNXy9qJyZBiy2rz5+VOsCguRnpLVpFXGcT1oSNR1n0EvX4EJE4qBlPmjEgWOjri
	 ZpkzZY/OH8/p7G8Hav9EQlvz+K7e0+fyq3/O0PHPBH5padz/afX7im7+exMJueAEWd
	 YnDlJ4om60wrt37NsJDuKWTHN8WjbvsCxl3wfPcr4izoVTQfTBNBShTupu4fTTzIIj
	 uIHU6Mnc8kX2g==
Received: from [100.96.234.34] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5409C37809D1;
	Mon, 29 Jan 2024 12:27:55 +0000 (UTC)
Message-ID: <0ebdbf75-3354-45ca-8760-c920f62b9809@collabora.com>
Date: Mon, 29 Jan 2024 17:28:09 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, jsavitz@redhat.com,
 ryan.roberts@arm.com, "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests/mm: run_vmtests.sh: add hugetlb test category
To: Breno Leitao <leitao@debian.org>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
References: <20240129115246.1234253-1-leitao@debian.org>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240129115246.1234253-1-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/29/24 4:52 PM, Breno Leitao wrote:
> The usage of run_vmtests.sh does not include hugetlb, which is a valid
> test category.
> 
> Add the 'hugetlb' to the usage of run_vmtests.sh.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/mm/run_vmtests.sh | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> index 55898d64e2eb..2ee0a1c4740f 100755
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -65,6 +65,8 @@ separated by spaces:
>  	test copy-on-write semantics
>  - thp
>  	test transparent huge pages
> +- hugetlb
> +	test hugetlbfs huge pages
>  - migration
>  	invoke move_pages(2) to exercise the migration entry code
>  	paths in the kernel

-- 
BR,
Muhammad Usama Anjum

