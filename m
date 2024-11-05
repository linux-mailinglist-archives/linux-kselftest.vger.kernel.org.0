Return-Path: <linux-kselftest+bounces-21500-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A959BD7C1
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 22:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E83001C2302F
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2024 21:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75272161EA;
	Tue,  5 Nov 2024 21:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awV7CbTd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C86921018F;
	Tue,  5 Nov 2024 21:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730842829; cv=none; b=Bs1/fKVdzeLrJGrrYF1hzJFl3zZM+MG7E5oytl7B5HgcbjUr/NOsg9wvUnJvusHgDUhNBdABKAtwl81wQk5wtvUoyag27oR98pUzi2Fv/0m1lJiUX3suLwCS3iDmK8E5UWfKSCES451nIOYD5KBv3hUoJtlLAJJSqENdIzdvu+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730842829; c=relaxed/simple;
	bh=sPWg6NXelo6X0RNUXsDk9+fIwefuySugSVi62oMIVcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nEk8DnEkVhwYiODMM30wgZGwi14zDad9lc7emi3SC51xrLVcCyLLLr9XZkY+s6gXKeWbDEXWiHqoTP+AZM3bK9vGfmkXoVshRW5WB1YErUqDb9PLbux8xRqsbdDgbS7C7+ZDFEvSxkXRo8maSsD+JYvpgsPzV+FLfzE4HEaqG3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awV7CbTd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98E8C4CECF;
	Tue,  5 Nov 2024 21:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730842829;
	bh=sPWg6NXelo6X0RNUXsDk9+fIwefuySugSVi62oMIVcc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=awV7CbTdDY4DYsPokCKI8p9b6Ns/pZAYdKJuvtPaQdx1gw9nFIm8i7/EbWiP+Lw98
	 U1dTuJwMxzl+pGzGVf3d6h0DEETYnb85D5QD96P5ySZq+N3K65yfOQ2ZgXyd2bM2oE
	 F4q5GodHKn9qgUBLQ3/9OCnlyCKVBx3s5wJ9SBeGcfFxdLbUkkC4X2VM7iECq5Jsx9
	 +sC/YAVsI2P9GWzrZLWACWmc4Qm09oiBttjemwciRAL3fXTgpaQNz2Img/Qs5lV3Pi
	 1o168w+gyqVMCczyyUFetEGmHtgbsScL6Pl/VeaF0mgpfHo45olAqAq820M7WuBcep
	 CrArC+kyE0aAQ==
Message-ID: <d3595e03-acbb-4a93-84cc-0dabe5259742@kernel.org>
Date: Tue, 5 Nov 2024 14:40:28 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 2/2] selftests: net: really check for bg
 process completion
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
References: <cover.1730828007.git.pabeni@redhat.com>
 <0e6f213811f8e93a235307e683af8225cc6277ae.1730828007.git.pabeni@redhat.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <0e6f213811f8e93a235307e683af8225cc6277ae.1730828007.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/24 11:23 AM, Paolo Abeni wrote:
> A recent refactor transformed the check for process completion
> in a true statement, due to a typo.
> 
> As a result, the relevant test-case is unable to catch the
> regression it was supposed to detect.
> 
> Restore the correct condition.
> 
> Fixes: 691bb4e49c98 ("selftests: net: avoid just another constant wait")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  tools/testing/selftests/net/pmtu.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


