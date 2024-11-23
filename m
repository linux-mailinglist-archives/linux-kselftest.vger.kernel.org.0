Return-Path: <linux-kselftest+bounces-22468-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2559D6AE6
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Nov 2024 19:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDACD161CD8
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Nov 2024 18:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAC91531C4;
	Sat, 23 Nov 2024 18:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFzjoxU1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DE62FE33;
	Sat, 23 Nov 2024 18:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732387918; cv=none; b=R8GwPN4Sj4pbG98Rj+zO3KO5p6wx0CvK9317oUcbaAAT4lsgH3Q4uS0Ud4egjVurO2ac3w4Fp8flojXBIAWnK2Ch1f42M4ce0NExhpGOAMXdWsVasAFPQG3S94r1Y6PPYWlezCtfvFcLWdZGmFrU3L6D6L116dNdtZ6Pp/jBPFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732387918; c=relaxed/simple;
	bh=rN6eJiPKJkIM95ZTHaovy+TpATtWEdVFaV03crZ//Lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a5fvUxSW7G4QyRkY316VNu/8fDsAVpo0IKQTpN2qLMP+xApyqrJMNuBvy+kZh1Iio3C2y87TOMYODnDbXU2Fe8EKsoq3xA+Foe4+XkBRKPNOZaJi9KHDASNJ7zx6k8+f57Kls58ZAwt6/gx624CMJ6SAJH92I7853BiQ5dRxlxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFzjoxU1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2AFAC4CECD;
	Sat, 23 Nov 2024 18:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732387918;
	bh=rN6eJiPKJkIM95ZTHaovy+TpATtWEdVFaV03crZ//Lk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EFzjoxU1Kk3jEjTEmMv8zu9yJeo+MnsZuFW9zZ9Urk6ZQob+x6meG92fol0oZ+oap
	 yDYfQOtXXDDHfm1Vkepkby7FIfV31jQ3K2HcTUQMVzfWvN6RIFOgXnG1eG3hKi/CKT
	 qsdvWsSFGiuTHrCf+L4ewxF0bjmuC0Xrr2h4N9xofNSV4R99z5LMMGeu0oBZmdmHO2
	 qI1dk5A7zdj12InJ0hPHS107ZQAhqS26dO0J2FPQ5HJWN9RzvePWCOord3wbYF1z6z
	 5zuIj5/8Nc/Kzs5H1dH0nAc5HSm9kaU0bC6JRR1CEhnmtWMp1tz1nW0g7lg2ZPN90d
	 EHKaeerTEJlKg==
Message-ID: <a37d0a88-095a-4f18-b79e-16ee1927c953@kernel.org>
Date: Sat, 23 Nov 2024 11:51:57 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net 2/2] selftests/rtnetlink.sh: add mngtempaddr test
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Sam Edwards <cfsworks@gmail.com>,
 =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
 Alex Henrie <alexhenrie24@gmail.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20241120095108.199779-1-liuhangbin@gmail.com>
 <20241120095108.199779-3-liuhangbin@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20241120095108.199779-3-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/24 2:51 AM, Hangbin Liu wrote:
> Add a test to check the temporary address could be added/removed
> correctly when mngtempaddr is set or removed/unmanaged.
> 
> Signed-off-by: Sam Edwards <cfsworks@gmail.com>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  tools/testing/selftests/net/rtnetlink.sh | 95 ++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



