Return-Path: <linux-kselftest+bounces-35634-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8538AE4BE2
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 19:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2DA8189E1B7
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 17:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D87A2BD023;
	Mon, 23 Jun 2025 17:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9KUbU3J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618CC29DB84;
	Mon, 23 Jun 2025 17:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750699745; cv=none; b=WRMh9HwgLVpjqZEvs93Q/RrY6i700KdxI0XUeFO1y4NsWC4FOiSxld8AUwr8kM3Z9c0FH+hDIwIeAYIwAv4nD+cyvnhACWoAsSEjPSCptzoMMRY8UaDKlPpy2Eo9VxBzOzjXglTGZrw3PdF02/tMeo4blNzmj4JSGMV9FvNe6n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750699745; c=relaxed/simple;
	bh=a/YjtocPnqP5cP6lzPFnDmdMokR12VJ4uig4PEQI2Is=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s6muTjdzr6q6V2kDLA8BAAOTUi8SECtaWkYTb/3Nu+VkDPTLokhsh5teJAYU29I5hnydAR/sAAMeSufn1vy6gH2rekO0rIaJBhC5YUpmEkLgF2Qukc6i1AlS9cZe0PYxScD7AJe7pNwBphu33y9Ac/SahwsILQyZv0PBa8wowrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9KUbU3J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8528CC4CEEA;
	Mon, 23 Jun 2025 17:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750699744;
	bh=a/YjtocPnqP5cP6lzPFnDmdMokR12VJ4uig4PEQI2Is=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q9KUbU3JUzJftUazF3rR0KxqPigegrvt7IVdwW8rJMYaZTfpe+hFnYKpR1m2l169R
	 QZ0acbY1kXhJxzB/ZSx7AVfH30djPpxItMTZLYXsyrtDiTO3NUQSshA9f5CAeoi+33
	 wGNjjDcTeM5opLNC/LgkKatnWzNGD2gugxw8pAsvshRTnFbqckuRiAMeHmZAYMWc/4
	 V6XyHIgswkrmWaJjPb2YXTGIngnEugzbvZWv1Vd+xIxpQWlGIh3/HxKHiXZkHVqKrW
	 YUluJGBLY9/xoMJQxlFStcPCxNti7nnXe4/Wc8oP6Rsf1zg/j7K/MkfZs31jM4fMaT
	 fUOsPUg41F5Fg==
Date: Mon, 23 Jun 2025 10:29:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, ast@kernel.org
Subject: Re: [PATCH net-next RFC] selftests: net: add netpoll basic
 functionality test
Message-ID: <20250623102903.3a58842d@kernel.org>
In-Reply-To: <aFkbXFvOKeMALwBg@gmail.com>
References: <20250612-netpoll_test-v1-1-4774fd95933f@debian.org>
	<684b8e8abb874_dcc45294a5@willemb.c.googlers.com.notmuch>
	<aEwd9oLRnxna97JK@gmail.com>
	<20250613174233.0dd5e7c1@kernel.org>
	<aFUeT8HSPYiDyALB@gmail.com>
	<20250621065121.78701641@kernel.org>
	<aFkbXFvOKeMALwBg@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Jun 2025 02:16:12 -0700 Breno Leitao wrote:
> So, the selftest for netpoll is already in the mailing list[1], so, we
> have two options, now:
> 
>   1) Steal your patch and make [1] depend on it.
>   2) Merge the selftest [1] and, then, steal your patch by adding the
>      bpftrace support in it.
> 
> What is your recommendation?

Let's see if [1] gets merged as is, if we need a v2 let's add the
bpftrace patch?

