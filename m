Return-Path: <linux-kselftest+bounces-38021-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E30BFB12BF8
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Jul 2025 21:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86CAE4E46E4
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Jul 2025 19:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A3E288C0D;
	Sat, 26 Jul 2025 19:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exYFZq/j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E621205E25;
	Sat, 26 Jul 2025 19:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753556701; cv=none; b=WTd1cvBCdI41wqwpiA5ZgozBPa/p7ERA/x34ePo7FCyTfIRveNhVa9aOejx7eZ4SogPi/Z2YzU3CECLVHjJWge1SRJHS7QmH+JitQVbhDrQFqrmmrOOCdwz3LRklo7dBwA/106hxUxUsB796XOKLIttYipBfaNO5yqdHEkpSFfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753556701; c=relaxed/simple;
	bh=yy6cnTwBnCXmwWO3MHjMEhHRrAAkWwy77MMk1Vy+NxE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IIdXS2B5+F3ztOUvVa5hD4HlMzW49eaDU46FDjQpq53/dhh1XZBBLHYj/jcbObl63OkioxhZ6/0UMspPRK1w8iTbMx8Z534dPMmMybL6i6uQeqXmwFnt+hGF7ewFCHPPHWzJB4R+ROW/L54GAcQvy4RgzajZQd7ZQ+wHKkDej0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exYFZq/j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E237C4CEED;
	Sat, 26 Jul 2025 19:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753556701;
	bh=yy6cnTwBnCXmwWO3MHjMEhHRrAAkWwy77MMk1Vy+NxE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=exYFZq/jxGPb59AlOyb8xRihdk/qpCpv8/nIJsn0oHjxk57XSUPYVBtBof395L9jZ
	 nf4wkJdDAlhXUBzPOat7bgUHOUxHDRr7gDbtSbmeCRQo2g2gb2r9JAtumqriBltlxb
	 o75lnH0VpC4AUIbedKQqTBhPLE5nw3DXe8GB/1wcYsbHxZm+S3ypib80zQ+xSfBA9g
	 3yln1rPFtoQ5Dpn0OOXvMKPJXenqfj2zsFyTXsOeLj3dYNNhB0kulEtevXL3RRrU0e
	 Bvjv48s6ykEt9aPloLNjgK7t3YJqgcxs4td+c/biTlpUUXkCR/xp7cgr0MvYelTzyQ
	 tdqeUSohvW6hQ==
Date: Sat, 26 Jul 2025 12:04:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, ast@kernel.org,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 mykolal@fb.com, shuah@kernel.org, pablo@netfilter.org,
 bigeasy@linutronix.de, fw@strlen.de, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: bpf: fix legacy netfilter options
Message-ID: <20250726120458.4aa17989@kernel.org>
In-Reply-To: <e691eb39-e13a-4558-8f62-6a1fd98382f1@iogearbox.net>
References: <20250726155349.1161845-1-kuba@kernel.org>
	<e691eb39-e13a-4558-8f62-6a1fd98382f1@iogearbox.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 26 Jul 2025 20:54:33 +0200 Daniel Borkmann wrote:
> On 7/26/25 5:53 PM, Jakub Kicinski wrote:
> > Recent commit to add NETFILTER_XTABLES_LEGACY missed setting
> > a couple of configs to y. They are still enabled but as modules
> > which appears to have upset BPF CI, e.g.:
> > 
> >     test_bpf_nf_ct:FAIL:iptables-legacy -t raw -A PREROUTING -j CONNMARK --set-mark 42/0 unexpected error: 768 (errno 0)
> > 
> > Fixes: 3c3ab65f00eb ("selftests: net: Enable legacy netfilter legacy options.")
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>  
> 
> Acked-by: Daniel Borkmann <daniel@iogearbox.net>

Thank you for the quick ack!

