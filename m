Return-Path: <linux-kselftest+bounces-41093-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73033B50B19
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 04:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DB0946730F
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 02:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF4423D7F3;
	Wed, 10 Sep 2025 02:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyD4v3+F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6339018E1F;
	Wed, 10 Sep 2025 02:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757471675; cv=none; b=Eo/KGVmvvhpzUNGj6o8jsJnGicZwpUNWu83PNIFpEorydGxSMW7LnkSuEXxuqunTfyoVufNcl6p26lX1vHDs5M6Uv/t81BFCpTjKzdT5o0Pi1sY9w/3fZsfJjeiLvvEyFK8WpCD0PRrnImyre9yZVZ2bvWu0TB9memVue3gxkFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757471675; c=relaxed/simple;
	bh=4AGxj23eU65q4It1bCd89yUBuCGACqnFLIUYP1pSWdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jnXlOKGphnAWR5nawGyY4Srs17eeIM+wjfd3nsAOHJF9kTU9E37voOkiRXZCsULUtQO6COWTjVq9yglpHWHa1SWmEDjyM4YgupCgFlpd1UExyVb0CX20oUMQqsxSxoUdZqmIA4lFrE6UTaMuj/vqx6yDLN7n3GMTa9MQ8Bg/dzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyD4v3+F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73DE0C4CEF4;
	Wed, 10 Sep 2025 02:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757471674;
	bh=4AGxj23eU65q4It1bCd89yUBuCGACqnFLIUYP1pSWdQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KyD4v3+FX8uLWYhxDu4SF/1NvWubcA4z/Oh5cC433gvvqIhvj6zQlshu1w1ZLHlEQ
	 7uctVJY5OGQK4IW0iNrnIJREKoHHgalV4OWNMkd3pYJxnvQoGnYn5+SwnpkFNXMYPm
	 aO3gZcBt/IkMMFwVFv1yOi6oTXie6t3wq4UzUcV4E6xSej3IGWmStRM0iDyqugZr7J
	 aqHpOrHfvZaggUEIZNTr0SQAApzLZC15/HKJh7B0koMDbcXTLXgaHntHXYi1/6TJ1g
	 9eVz6vUouyK8VCirXxH0K9WHteCNav7CS5/AT+gJzrUNh56tFWFWrFaR+KtRVFJGf+
	 eFT6KzSMr8bdg==
Date: Tue, 9 Sep 2025 19:34:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2] selftests: net: replace sleeps in
 fcnal-test with waits
Message-ID: <20250909193433.3f507546@kernel.org>
In-Reply-To: <3a10e26e-5c15-4208-b79f-6fbf5011b8b6@kernel.org>
References: <20250908200949.270433-1-kuba@kernel.org>
	<20250909153346.4fa8c369@kernel.org>
	<263f7204-6f5b-4bbc-8c05-222cdb04fb15@kernel.org>
	<20250909170323.5b0dbcc0@kernel.org>
	<3a10e26e-5c15-4208-b79f-6fbf5011b8b6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Sep 2025 20:17:34 -0600 David Ahern wrote:
> >> That is surprising to me. I will take look tomorrow.  
> > 
> > Thanks! FWIW I repro'd one with "pause on fail" enabled and trying 
> > to ping manually also wasn't working. Something odd.  
> 
> This fixes it:

Do you want to send it officially? I don't think it will conflict with
the outstanding patch

