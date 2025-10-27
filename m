Return-Path: <linux-kselftest+bounces-44140-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFFBC113F3
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 20:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07DD219C6955
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 19:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3952DC781;
	Mon, 27 Oct 2025 19:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yxIXJJHz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3965E1FA859;
	Mon, 27 Oct 2025 19:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761594371; cv=none; b=sdyFdQm0UHjDK/ajD1YacUFOpUKRA+FP7AQaYhMWMYt3zNY2XsZEdp/+KaSvOZG5bh43ugH5/qWCQowCCwrRnQNXM7+T2ou86qlZLd1xtD7tZqH9HBxwHSsrlfuga/aNbUcHuc+xOMRBXeQtGtRpefBXouIhyzMDjdkpAlEfQyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761594371; c=relaxed/simple;
	bh=7GWwiStjtDAbbnkF2zYQxdt4B/0h1K8bSVhtEvQUAbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=csURWJsrrnScRyIBjoP6QCw2v2bWkmjSUPI19Im7A9W2n1Qu8ToqUPyR35v45A7F7bTA5UqmLS2nYwQRLd+mcesGo4Ocj4LfTTInrEHtfKm7WiPMw8s/gezfpBfSgjh8Q2RAqEbrTUEPDI30+i5vxBcpBZ8MMe19cU0IxDotBm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yxIXJJHz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QgVHnEB9dbxI4tOIpbAUdE9ckXhIXrcdZxqomo85tvM=; b=yxIXJJHzNssHdI9lAPrjZEukGA
	Jxmb9ZzWfKNBbtoKTvy+Qv0PVqHS23awerM6FrII1AaZwtIQbk8FPWbQuk++BPDkEv83asiyu77wi
	DHZ0KECwxg780e/1G/pVvHE4DcDl9jOOjWQx7iucvUpkaE1i2cUkh+8ChPIL4Bhon3sE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vDTAG-00CEF6-TU; Mon, 27 Oct 2025 20:46:00 +0100
Date: Mon, 27 Oct 2025 20:46:00 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2] selftests: drv-net: replace the nsim ring
 test with a drv-net one
Message-ID: <57359fb9-195c-4a4a-b102-f7739453a94f@lunn.ch>
References: <20251027192131.2053792-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027192131.2053792-1-kuba@kernel.org>

> +    def test_config(config):
> +        try:
> +            cfg.eth.channels_set(ehdr | config)
> +            get = cfg.eth.channels_get(ehdr)
> +            for k, v in config.items():
> +                ksft_eq(get.get(k, 0), v)
> +        except NlError as e:
> +            failed.append(mix)
> +            ksft_pr("Can't set", config, e)
> +        else:
> +            ksft_pr("Okay", config)

We expect failure to leave the configuration unchanged. So i would
actually do:

try:
	before = get()
	set()
except:
	after = get()
	fail(after != before)

Also, does nlError contain the error code?

        fail(e.errcode not in (EINVAL, EOPNOTSUPP))

It would be good to detect and fail ENOTSUPP, which does appear every
so often, when it should not.

> +    # Try to reach min on all settings
> +    for param in params:
> +        val = rings[param]
> +        while True:
> +            try:
> +                cfg.eth.rings_set({'header':{'dev-index': cfg.ifindex},
> +                                   param: val // 2})
> +                val //= 2
> +                if val <= 1:
> +                    break
> +            except NlError:
> +                break

Is 0 ever valid? I would actually test 0 and make sure it fails with
EINVAL, or EOPNOTSUPP. Getting range checks wrong is a typical bug, so
it is good to test them. The happy days cases are boring because
developers tend to test those, so they are hardly worth testings. Its
the edge cases which should be tested.

	Andrew


