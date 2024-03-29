Return-Path: <linux-kselftest+bounces-6892-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2468C892458
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 20:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B826A1F2143F
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 19:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8E3137742;
	Fri, 29 Mar 2024 19:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OTb2Vl1N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F743B78E;
	Fri, 29 Mar 2024 19:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711740927; cv=none; b=q7cvtx0L0h6iskZNndO1GHFCqstB0thw1b3NX0Qes6z3RD+1uW3Tgn+bHUYNboIlkT0yEpaepfOHS9otSCblqnHnzRU+RzwpRFrfqSM7kNmTHn8UO2CVBdMBpXW6YUn4xRne1cWVA539Y7S/cnQHs6hpd8xqhEWteXhnnKRQkvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711740927; c=relaxed/simple;
	bh=TlPpxSDTpTIAz1Ksh0yB0J+dhwPWSosmwqEQjlUUPHM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OPjqHTytmTYNdQErU9eGiCI+KbUG0gDA9c5hioCf2w8N0z7oTZkLcEVBq4hsIfKaqMcKXnlEbVy017XGi4x73n5vPW3x7AAGnkLTioAHCa+YBP4e0WbjnaIkXSplpwzpkSblE6SH9voTqzN6mGA+JDBs1PbwbTKrQfF+QN26/WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OTb2Vl1N; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711740923;
	bh=TlPpxSDTpTIAz1Ksh0yB0J+dhwPWSosmwqEQjlUUPHM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=OTb2Vl1NSqPTrYBIbb/Af7uDYx8LbRMRG+paqMvjf5//iLpHdkGx03vMZavSg1pta
	 VsMRuS5aLBTxCMGXELfgaTn+N9OuSP2D6OH2QsrMVnsdEQPb6fGoOoxYbejZnL8VCu
	 LXoX9W52MdJDDEGD853BqXIGxjmbz8pBq61L5N1Af/ws6yAeW2K51IEgGVt8oLQnOc
	 UD/SXXN1xRDDulG3nTD/CQK4DOPWPx7ES2DTt+SVH2QK9lJtRuFTYJGWdvvf6zlg+0
	 t+KFAgw7cg8hGocfKdnP309XfNcZ6NGT4v9EDuZLyGOWSTvOTsVHkaAaQO5SaMGbqI
	 vq7M+t6u4mA7Q==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C41B93780C22;
	Fri, 29 Mar 2024 19:35:20 +0000 (UTC)
Message-ID: <489b5f4c-a7a0-4c8a-888f-ccf09d4bd81f@collabora.com>
Date: Sat, 30 Mar 2024 00:35:51 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, netdev@vger.kernel.org,
 edumazet@google.com, pabeni@redhat.com, shuah@kernel.org, jbacik@fb.com,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: reuseaddr_conflict: add missing new line
 at the end of the output
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
References: <20240329160559.249476-1-kuba@kernel.org>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240329160559.249476-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/29/24 9:05 PM, Jakub Kicinski wrote:
> The netdev CI runs in a VM and captures serial, so stdout and
> stderr get combined. Because there's a missing new line in
> stderr the test ends up corrupting KTAP:
> 
>   # Successok 1 selftests: net: reuseaddr_conflict
> 
> which should have been:
> 
>   # Success
>   ok 1 selftests: net: reuseaddr_conflict
> 
> Fixes: 422d8dc6fd3a ("selftest: add a reuseaddr test")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
> Low risk and seems worth backporting to stable, hence the fixes tag.
Agreed to back port it as ok or not ok must appear at the start of the line
to indicate the status of the test.

> 
> CC: shuah@kernel.org
> CC: jbacik@fb.com
> CC: linux-kselftest@vger.kernel.org
> ---
>  tools/testing/selftests/net/reuseaddr_conflict.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/reuseaddr_conflict.c b/tools/testing/selftests/net/reuseaddr_conflict.c
> index 7c5b12664b03..bfb07dc49518 100644
> --- a/tools/testing/selftests/net/reuseaddr_conflict.c
> +++ b/tools/testing/selftests/net/reuseaddr_conflict.c
> @@ -109,6 +109,6 @@ int main(void)
>  	fd1 = open_port(0, 1);
>  	if (fd1 >= 0)
>  		error(1, 0, "Was allowed to create an ipv4 reuseport on an already bound non-reuseport socket with no ipv6");
> -	fprintf(stderr, "Success");
> +	fprintf(stderr, "Success\n");
>  	return 0;
>  }

-- 
BR,
Muhammad Usama Anjum

