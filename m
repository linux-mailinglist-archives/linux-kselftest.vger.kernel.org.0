Return-Path: <linux-kselftest+bounces-13134-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B07992667B
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 18:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C95A1C2141C
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 16:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9101836CB;
	Wed,  3 Jul 2024 16:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKf7aQjl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12DE1822CA;
	Wed,  3 Jul 2024 16:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720025744; cv=none; b=ufAwyXTqM5gocdo1FI9xXUN8R1pBaFls36DpWKuMXsu8V37+S6SdgmzocJmstkOUPBbfzKZIw1XNloj01hi3UWqPM/gPC8OKZZmj3EtQNpqkvJIa7mCpwKOU8Tj5sU5K0Z6+wR7A+8mKwMXmOcbd+WdmRMQwviqICv1nL/hfla8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720025744; c=relaxed/simple;
	bh=xrthwiU5Q34P6CXY76klZ7mwePw1V71z9dpDo3Q91tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbI6zmr6FwLu6UUX/soOCyuL90r0y7+PKoEa0SM3TMrjnChp6DBHMt5butdjcnZOgGc+7MYOGZ5zDHxmpkA9zMyLRFNp2vpGszc8yVSemZLnIgvLtKwfybG07gxtssgwLox6W6qf8cHABKJ7Dc6GDVzP9ZK/9lPL/vNXR94P+qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKf7aQjl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B31C2BD10;
	Wed,  3 Jul 2024 16:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720025744;
	bh=xrthwiU5Q34P6CXY76klZ7mwePw1V71z9dpDo3Q91tc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bKf7aQjlKw56vmukxHK7089YNSU0rdyEW9jcwCSucTz8Poo61McHIkl+DQaNfoKtO
	 eAWTUmr3fQawJyqMAwEn3Devq0krtfIicm3ewiMiRlZAine/DDRxckq7YH2eh+JLuq
	 dzXaw7fzJq1wzpFI/Kaw2dnqMQAUWxvTF99r/MB0kU9KiEE/R2+wV/BIMG1kPxWJ8b
	 6Ql6+r1A39MZCVpfr7iPY+RBkaYx8Hnc/tcisMTgOVD4wIHxPhMoyuBZtMHedpp/sZ
	 s9AWfjqYoWQmkPM5MSrFMkd1u6XGixJ6Bfq8BotnrJAH/FW4jyoDbMN/9CjmxtEPvn
	 MLTNBmjaZ0wDg==
Date: Wed, 3 Jul 2024 17:55:39 +0100
From: Simon Horman <horms@kernel.org>
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, dev@openvswitch.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Pravin B Shelar <pshelar@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	=?utf-8?Q?Adri=C3=A1n?= Moreno <amorenoz@redhat.com>
Subject: Re: [PATCH net-next 2/3] selftests: openvswitch: Attempt to autoload
 module.
Message-ID: <20240703165539.GT598357@kernel.org>
References: <20240702132830.213384-1-aconole@redhat.com>
 <20240702132830.213384-3-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702132830.213384-3-aconole@redhat.com>

On Tue, Jul 02, 2024 at 09:28:29AM -0400, Aaron Conole wrote:
> Previously, the openvswitch.sh test suites would not attempt to autoload
> the openvswitch module.  The idea was that a user who is manually running
> tests might not even have the OVS module loaded or configured for their
> own development.  However, if the kernel module is configured, and the
> module can be autoloaded then we should just attempt to load it and run
> the tests.  This is especially true in the CI environments, where the CI
> tests should be able to rely on auto loading to get the test suite running.
> 
> Signed-off-by: Aaron Conole <aconole@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org>


