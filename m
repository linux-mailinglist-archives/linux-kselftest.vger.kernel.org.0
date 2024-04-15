Return-Path: <linux-kselftest+bounces-8015-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 229AE8A59FF
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 20:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE69C1F21687
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 18:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC5E15574C;
	Mon, 15 Apr 2024 18:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QdWD1EKV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DE941C66;
	Mon, 15 Apr 2024 18:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713206279; cv=none; b=B00aEgu7IXGQegkKtHvc4JHbGFa3/5qAPqWeLgf17iXlupuXaCCMvD6tEakwzb95gDD2SIbmzAV8uDHTFpPyqqIF77RHypeTdEUR4rLRwBUO/zBZymLLRCaQN4HWINXc2PtmcoefHtdeK6kUIm1cXr9cHyj3jUASR9mUO5QTN+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713206279; c=relaxed/simple;
	bh=U29sDrgbhhdXj+npBt1jlHxYJTm07oduug5LWw9LWsU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ui3zK6B7hXImESGtMPr5l9E3udaBpA/uM/Yp2rAk4IuDSIHA0g+Yblo9w/7mUBAiYs6JSygPl2TSKfi7woJTIVJGfDHG6a65WEoy6Cv3bgqkyEPFntPkaXRho9TIXMF8kzWZ3u/8eMfgdNbBqQRI3oU6k8HmpubGW/F4u7TUHe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QdWD1EKV; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713206276;
	bh=U29sDrgbhhdXj+npBt1jlHxYJTm07oduug5LWw9LWsU=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=QdWD1EKVTObBT2wXUT8lnEtSx9LXzcJYzfDirIso9e+V2B3BAnLOae0svdRihqC8t
	 EQXyFBqlA5DD+hNEctLOlMdxDBkbwxb39cJYshUjVkycsxTu/RSUOEDORweWMJVt2B
	 iZU8vEBb9GEM15dJUTjrBEzvZiP3qQ1lJnzKATDxseIYPZfOd6M3bLC2RB4XZAiovD
	 uRpJxdm/26pM9DIDzpQuw8oNMevbXimZfth+9hMVJ0J4Yrm0bD3AjRSUOhvNMTVm6u
	 UAPOmswX4Dcmx6Da+ehimEAAf34zk4PDFax5jJFZobC5yNQ+gi8MubJUhVvLwOuEhV
	 VS67pw1BuZO5A==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 334C13781107;
	Mon, 15 Apr 2024 18:37:51 +0000 (UTC)
Message-ID: <01247791-7841-4530-bde3-5db3fbd1770d@collabora.com>
Date: Mon, 15 Apr 2024 23:38:28 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Sebastian Reichel <sre@kernel.org>, Mike Looijmans
 <mike.looijmans@topic.nl>, kernel@collabora.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests: power_supply: Make it POSIX-compliant
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Shuah Khan <shuah@kernel.org>
References: <20240415-supply-selftest-posix-sh-v1-0-328f008d698d@collabora.com>
 <20240415-supply-selftest-posix-sh-v1-2-328f008d698d@collabora.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240415-supply-selftest-posix-sh-v1-2-328f008d698d@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/15/24 8:32 PM, Nícolas F. R. A. Prado wrote:
> There is one use of bash specific syntax in the script. Change it to the
> equivalent POSIX syntax. This doesn't change functionality and allows
> the test to be run on shells other than bash.
> 
> Reported-by: Mike Looijmans <mike.looijmans@topic.nl>
> Closes: https://lore.kernel.org/all/efae4037-c22a-40be-8ba9-7c1c12ece042@topic.nl/
> Fixes: 4a679c5afca0 ("selftests: Add test to verify power supply properties")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/power_supply/test_power_supply_properties.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/power_supply/test_power_supply_properties.sh b/tools/testing/selftests/power_supply/test_power_supply_properties.sh
> index df272dfe1d2a..a66b1313ed88 100755
> --- a/tools/testing/selftests/power_supply/test_power_supply_properties.sh
> +++ b/tools/testing/selftests/power_supply/test_power_supply_properties.sh
> @@ -23,7 +23,7 @@ count_tests() {
>  	total_tests=0
>  
>  	for i in $SUPPLIES; do
> -		total_tests=$(("$total_tests" + "$NUM_TESTS"))
> +		total_tests=$((total_tests + NUM_TESTS))
>  	done
>  
>  	echo "$total_tests"
> 

-- 
BR,
Muhammad Usama Anjum

