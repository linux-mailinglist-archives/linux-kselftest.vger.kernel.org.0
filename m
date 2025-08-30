Return-Path: <linux-kselftest+bounces-40351-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEA7B3C750
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Aug 2025 04:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E74234E0729
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Aug 2025 02:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6657082D;
	Sat, 30 Aug 2025 02:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXsTuSWh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5962F30CDA5;
	Sat, 30 Aug 2025 02:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756520139; cv=none; b=WDKEVY2VMCO3KYj+uGX2ezHt+cVnpdLjllcbOJo6LoHUXfot/0Mx7vNGzXFhL4T2/8AMEy4aWbGPUpHB39M4X/0n/9YkrISfnM3GoV3Yxg22I/7239C5hco0P6/kFmk1UKdRpL9ZQihdrpSc+z9U4FvNF4wFhbu8+VHSRj8+VcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756520139; c=relaxed/simple;
	bh=egVW/Xn9FX2VMJ6DuixGgONttWD8hugyDmiBb588KzM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OktRbSBiUv8+DDHMNdIBIvOWDRj49u+jdHQP9gPX6YgMeWafXIPSZtgQZHImAQMo5y/Avpf5tAi317OkMnRd8T8O2l1zcepEguJ4W7U2G3TbM9PeVYOs8XzfZUXncB0jmKo59ziImNSW7QrCF+oKgkz1WC9KG11kcfGXmteqCAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXsTuSWh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62902C4CEF0;
	Sat, 30 Aug 2025 02:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756520138;
	bh=egVW/Xn9FX2VMJ6DuixGgONttWD8hugyDmiBb588KzM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iXsTuSWhiF7BGP5YNzL7jsDOjj8dflanLWs86vPfNcBqnbBYmC8zQVZgXVIGKggdY
	 Me5d42dLhWHwjLZToVVhp4VmXWeocSQ9cgkxGKOcUE2uT1d+qxn2RkkkU6Pm7iae4/
	 dRsK9Fc+7NedDSXU7y2mvVw0LO8aXQtYT2Da/NcohFBiikEcCMBvqTdviMEiJaoOw9
	 tf4EOqdk0sevsO+cpzwrULSENSM7S2b1QtN80EO0fyAFW+8W5wM/m0Usg7+QSZUVU/
	 7mozxZN9Ts70HEHt9FT9bfqRo/BPpYEZhYadTVz+iRtiqQEH5RhUcGgE718QaJywjL
	 D6uMwhhiJWxTQ==
Date: Fri, 29 Aug 2025 19:15:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Zongmin Zhou <min_halo@163.com>
Cc: horms@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, Zongmin Zhou
 <zhouzongmin@kylinos.cn>
Subject: Re: [PATCH v2] selftests: net: avoid memory leak
Message-ID: <20250829191537.4618f815@kernel.org>
In-Reply-To: <20250828020210.25475-1-min_halo@163.com>
References: <20250827161230.GB10519@horms.kernel.org>
	<20250828020210.25475-1-min_halo@163.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Aug 2025 10:02:10 +0800 Zongmin Zhou wrote:
> @@ -501,7 +502,8 @@ int main(int argc, char *argv[])
>  	if (fd < 0) {
>  		fprintf(stderr, "Can't open socket: %s\n", strerror(errno));
>  		freeaddrinfo(ai);

Since you added the gotos now perhaps it'd be even better to remove
this freeaddrinfo() call here, and instead jump to a separate label...

> -		return ERN_RESOLVE;
> +		err = ERN_RESOLVE;
> +		goto err_free_buff;
>  	}
>  
>  	if (opt.sock.proto == IPPROTO_ICMP) {
> @@ -575,5 +577,7 @@ int main(int argc, char *argv[])
>  err_out:
>  	close(fd);

... added right here?

>  	freeaddrinfo(ai);
> +err_free_buff:
> +	free(buf);
>  	return err;

