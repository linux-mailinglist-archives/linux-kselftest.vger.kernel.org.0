Return-Path: <linux-kselftest+bounces-49040-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 217EFD25BB1
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 17:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E61E1304BB6F
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 16:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F3B3B8D60;
	Thu, 15 Jan 2026 16:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b="fS91y4AN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from outbound.mr.icloud.com (p-west2-cluster4-host9-snip4-1.eps.apple.com [57.103.69.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BA73A9018
	for <linux-kselftest@vger.kernel.org>; Thu, 15 Jan 2026 16:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.69.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768494068; cv=none; b=tg4FYr2vYXIpgfVVgNVDWfpICiWWZLCdM/z26g9dzNKAIwhbjuqloyyQQC2B0A9K3Dzr3ZpLHIQx7zVpfbgLPx7w1KWn1t8WUe5gWiheG19v0A2fE4rNcAjyQhbzrNvItMqL/gE7ILpSU2hlgrFlOibFBAguFlnLPPrb4lhF2uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768494068; c=relaxed/simple;
	bh=OUyVgq7n6ocw8+tH/ttuc+fcP78f5xqqDzDaGHPrNuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iztWSLyVFmpjLdgbKmL+S2jmXHKu1qblcijdzHzr30U6kP2QpCk947JE6FsQNBVhNAEb995gxBxpf8dxo8DrSTSOKyV5Tpwis7+m01V+185YMWEnIooobW9o/5WFxUx1M/72ri42FbwZmdj2rWwDVTUtMpercZHhszgrhB/Aj3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net; spf=pass smtp.mailfrom=y-koj.net; dkim=fail (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b=fS91y4AN reason="key not found in DNS"; arc=none smtp.client-ip=57.103.69.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=y-koj.net
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-60-percent-3 (Postfix) with ESMTPS id 1A444180011D;
	Thu, 15 Jan 2026 16:21:04 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=y-koj.net; s=sig1; bh=aH808W6yiWKX0lcyGYLe3fnalzSmDYO3ZMB253efdQw=; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=fS91y4ANhGYo7yPgIAtx6NESup1ZJGceGTWF2IXmsVWXZY5AucfX5tQHfs5Fn9YmQeTCLkC+xhoOhYrdSipkFyJQgM/83Yh/ywqA0oNz4Ta8mzW6GGTy4zGiXLF9U2zOtpPTKI6geWtFd1zoSJa8KMerxyXFtd1xaPaFuefGLP/3QafqiBN/Jem5wMgwRjmgIhXIdfsoCaZVV8tb1X2j8rcb9wYi0BJ9vGv8nRV0Tp5kofPnbIgCEgIaXTY7V7P0Y74qaLDLc+GVorlRk3XfC8tPGIjQpE4UT+58vqHJwRlagDCJ43UPagXqjCYnqH/3FwhGT0WKxgpXVKU2cif0TA==
mail-alias-created-date: 1719758601013
Received: from desktop.y-koj.net (unknown [17.57.152.38])
	by p00-icloudmta-asmtp-us-west-2a-60-percent-3 (Postfix) with ESMTPSA id 53EC118013D6;
	Thu, 15 Jan 2026 16:21:02 +0000 (UTC)
Date: Fri, 16 Jan 2026 01:21:00 +0900
From: Yohei Kojima <yk@y-koj.net>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v2 2/2] selftests: net: improve error handling
 in passive TFO test
Message-ID: <aWkRvBz734sa_1vV@desktop.y-koj.net>
References: <cover.1768312014.git.yk@y-koj.net>
 <24707c8133f7095c0e5a94afa69e75c3a80bf6e7.1768312014.git.yk@y-koj.net>
 <1696424e-2092-4e47-bd4f-293e2992056b@web.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1696424e-2092-4e47-bd4f-293e2992056b@web.de>
X-Proofpoint-GUID: Y5j5UaESNPWUHeIKiSAldqreB0UtguRO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDEyNCBTYWx0ZWRfX6PHlrvHZ3Dz2
 7HEBRVJ3hsWICYlYguvKPxyxFgLEIMZWneK9OZ2B8PyZ1w1W7zc6smiA8TDWZjHs+Ymu85j8Xmz
 kLHDbsGei0vUk6YdOnaJ8Rv877ncQcKKfxCxMEhORHwkYdtPZw+DBFjv6oVxdljkVUSiV+rRjJq
 MwBikyLGEOHy+R5zxLPIKH0PRGpH/ypE1EdSdhpbDpMQflYUXDi7OGyYOSR9FhRxbrtZnuG61SZ
 Zq1CJDz9FpQfauPoG35rmLwcsJrm/pu9jQrQ/+xfToVGH8iKvfrApbZRbaykAeAaJs3JAA8/dMA
 oiYkwgNUjlkDSPBDx9j
X-Authority-Info: v=2.4 cv=bapmkePB c=1 sm=1 tr=0 ts=696913f2
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=jnl5ZKOAAAAA:8
 a=qKQrQ7_CLwTn8uSwdssA:9 a=CjuIK1q_8ugA:10 a=RNrZ5ZR47oNZP8zBN2PD:22
X-Proofpoint-ORIG-GUID: Y5j5UaESNPWUHeIKiSAldqreB0UtguRO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_05,2026-01-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 adultscore=0 bulkscore=0 mlxlogscore=771 spamscore=0 clxscore=1030
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2510240001 definitions=main-2601150124
X-JNJ: AAAAAAABetAzsSZ6/ZjHiPzpY9p5fLxX3cLwYCfpINjrrjGCVem46SQ0ppjb8Em7W+WyglCjc6BiJF35by0x9gA3/ARjj4IAqqBNiyyiW57El1mqVPmBI9pbbUdZgwccgpfbIavn0YKio8wV1AdsU/Yxny/o6LeE8P8ks4V6EwucBipZjiBRV0V4NSivMZKyVVAjvQIemah1ca7q63jwctQ3hzmPUXPq2AbCEvbd4R4oPR1ILUXUIXFC/eSFWpx2cs8OQwogxUsdnZR2duRGIQ1dkSKJyLdVg8iRfp8orKwmQxhHJYLrn8QCHdEUa58f87GHgS9zApMGf5RJOpRZlSLDOXWVoyUKqggPLAgnMQmh4W147gTU9IfA0iuF2gld25SXECmpaqxGAwqBEL2q1E4Pi3/uNpQraFVa2U+pvoo9biiaeoF4VjWcxnrucp5uHcA/k6MkljhjQD1Kj3FLE/rtirzUspyaLwlr7VOQzwQqdRHJoQxuypjtm6iWpq2zy9lPik2hNIBcQ/uND/xbfXujU/HmhhzosN48jjhO+RkWos7mNgPAr6r7pPsCR+0ukXEnvw87dpXpTbGsA/fdUMRELyeOWgVF4gM5Zy18fl/fPYRMd+VRssMJlZLG3Ey9kOxENriR0N8Sl127CBeZrxISdm7Aplww1/UJg2LZQK+j9ChAN43FdeXVKhcWT7qbjEvP5F+OO6WE6oJwrDIxxWIlJv2X6c4ZnUuAY27PH/CAOrJUYU1nInw1Y9A+1WQArEs6v9N+Ceew4wYJQg==

On Wed, Jan 14, 2026 at 09:33:12AM +0100, Markus Elfring wrote:
> > Improve the error handling in passive TFO test to check the return value
> > from sendto(), and to fail if read() or fprintf() failed.
> 
> You propose to adjust error detection and corresponding exception handling another bit.
> How do you think about to take also another look if further function implementations
> would be similarly affected?

Thank you for the suggestion. The first objective of this series is to
fix the misleading behavior that was caused by the following bug.
Therefore, I intentionally limited the scope of this patch to the
affected or closely related functions.

https://lore.kernel.org/netdev/602c9e1ba5bb2ee1997bb38b1d866c9c3b807ae9.1767624906.git.yk@y-koj.net/

I believe this is sufficient to prevent it from showing misleading error
messages when the test fails.

Thank you,
Yohei

> 
> Regards,
> Markus

