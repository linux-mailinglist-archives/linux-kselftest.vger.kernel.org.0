Return-Path: <linux-kselftest+bounces-21296-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D34EA9B9224
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 14:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 106B81C21F77
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 13:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B7E19F436;
	Fri,  1 Nov 2024 13:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNxCCxnZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A2419E971;
	Fri,  1 Nov 2024 13:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730468068; cv=none; b=XLbWgMgVNAWzzcvvaA2YpHBKqJiOGiwSzdb5V1ECiRM8Dx0JKoPeTVKCeCPzan6usHvw+9usPR+shFz5YnqrLCMfnqoK4vyD1R+pmti9rPWGBy/2AH/ekkHZo5n2rxXVF4jdgyREYu6Sr+9twPn4mBJckObkaHse5AL8hJCwuEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730468068; c=relaxed/simple;
	bh=hYp05bVLahHxOAcKC4ocuEePDKAH3YSSK+RDuub5x0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UhM3mcvpcTBAzWo0qtHyB23uQwvrKJyH+821ZdoKIJU1FJObfsjIH6IGsTBOtYs7yj+N0+eKak2+5JPY6E9uZhuNWWsb8QB1ni3yHCOMHHvdU119hLCPeorSqDyg4lBPmSIQYM7D6443eJG/DPbzR0hkuZ/3/4v3z63jwZBBdek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNxCCxnZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6BBC4CECD;
	Fri,  1 Nov 2024 13:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730468068;
	bh=hYp05bVLahHxOAcKC4ocuEePDKAH3YSSK+RDuub5x0Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eNxCCxnZvwsXV2dLXMNpkoLLENJ3Hs5dlC9uWyGAykx7JsG6jtngn9dC164BSkAve
	 jB4kzlJGmk8nqtET/A2FjndZloYAGZ2YJyn6AZU1Nmk/W6xbn2bAWJ2yz56f98Mhpi
	 hEdYeygaZUditmP0/B0+yxxnLM2S5Oidz5ZPjO0tb//sDKaPWm0dXoF0qK42FRiCZQ
	 RRrX8VtB161tABU2vWnVYTgMpeSSQ5EmtljT8qPIVDauTymUZhidn1LXychRvDs8Ri
	 BHQv29y6VcIEiR6gWX3LyS5odvOez/SFJ9Vqn8KzyilB7aWqU7Oy/wTkkTJBGNWIf1
	 vaGOuyv1VJd0g==
Date: Fri, 1 Nov 2024 06:34:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, namangulati@google.com,
 edumazet@google.com, amritha.nambiar@intel.com,
 sridhar.samudrala@intel.com, sdf@fomichev.me, peter@typeblog.net,
 m2shafiei@uwaterloo.ca, bjorn@rivosinc.com, hch@infradead.org,
 willy@infradead.org, willemdebruijn.kernel@gmail.com, skhawaja@google.com,
 Martin Karsten <mkarsten@uwaterloo.ca>, "David S. Miller"
 <davem@davemloft.net>, Simon Horman <horms@kernel.org>, Shuah Khan
 <shuah@kernel.org>, linux-kernel@vger.kernel.org (open list),
 linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: Re: [PATCH net-next v3 6/7] selftests: net: Add busy_poll_test
Message-ID: <20241101063426.2e1423a8@kernel.org>
In-Reply-To: <20241101004846.32532-7-jdamato@fastly.com>
References: <20241101004846.32532-1-jdamato@fastly.com>
	<20241101004846.32532-7-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  1 Nov 2024 00:48:33 +0000 Joe Damato wrote:
> +	ip netns exec nscl nc -N 192.168.1.1 48675 < $tmp_file

Thanks a lot for adding the test. Could you replace nc with socat or
a similar tool? There are multiple incompatible implementations of
netcat packaged by various distros, we get:

# selftests: net: busy_poll_test.sh
# nc: invalid option -- 'N'
# Ncat: Try `--help' or man(1) ncat for more information, usage options and help. QUITTING.

nc is a known PITA.

> +	# set the suspend parameter for the server via its IFIDX
> +
> +	DUMP_CMD="${YNL_PATH} --spec ${SPEC_PATH} --dump napi-get --json=\"{\\\"ifindex\\\": ${NSIM_DEV_1_IFIDX}}\" --output-json"
> +	NSIM_DEV_1_NAPIID=$(ip netns exec nssv bash -c "$DUMP_CMD")
> +	NSIM_DEV_1_NAPIID=$(echo $NSIM_DEV_1_NAPIID | jq '.[] | .id')
> +
> +	SUSPEND_CMD="${YNL_PATH} --spec ${SPEC_PATH} --do napi-set --json=\"{\\\"id\\\": ${NSIM_DEV_1_NAPIID}, \\\"irq-suspend-timeout\\\": 20000000, \\\"gro-flush-timeout\\\": 50000, \\\"defer-hard-irqs\\\": 100}\""
> +	NSIM_DEV_1_SETCONFIG=$(ip netns exec nssv bash -c "$SUSPEND_CMD")

Can you try to run this test in installed mode?

https://docs.kernel.org/dev-tools/kselftest.html#install-selftests

IIRC YNL moves around when we install, you'd either need to do
autodetection of the path (see tools/testing/selftests/net/lib/py/ynl.py
and if you go down this route please move the helper which exports the
YNL variables to lib.sh so other tests can reuse); or teach the C code
to do the setup, you can link against YNL fairly easily (look at where
ncdevmem is added in the Makefile, it uses YNL)

