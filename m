Return-Path: <linux-kselftest+bounces-33942-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1B2AC6D33
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 17:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4633C1C007F8
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 15:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40E228C2C7;
	Wed, 28 May 2025 15:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UkB/QMIv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FF028A415;
	Wed, 28 May 2025 15:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748447352; cv=none; b=FSntAryQeb9Hj/gAg/eHE1QanQlY6ojhw7TEU0qINta+8i8fPELv9s2GpSpimeeKOrm8ZbB3+SJ0VgrO7G6Z91k0/FuZgN8wJ7NCucZjshmV5D/EFhxMGnrUMX6z5AB+9XmdwObppRqo1x9X0VUkbBOeydIgrwOnm4UinFsMYPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748447352; c=relaxed/simple;
	bh=aJ2WMLCSX44iSStAIMvDDspDN9X8UmDN8ucWqh9qNTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nw5GNmploN/yvOOitb13B9bGv3aq36S+LOqrkiy2wDswkqU3ulvDZkb/4cTJn6vsAb3Dn5GwXJucmiGK3Lb8ObPbbemkE2xNf+mcJo8U3OrvG8vjIJ5UUxpFur2l0d/o05BBaYYs6FvY1YAFQfjHJm7JbZBrijmDdtp77Vzwb6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UkB/QMIv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E65C4CEE3;
	Wed, 28 May 2025 15:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748447352;
	bh=aJ2WMLCSX44iSStAIMvDDspDN9X8UmDN8ucWqh9qNTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UkB/QMIvCRG8lhyTHK4ZClCcPcCOR6kEHf5wFQNBU6hJOGSgUvDPGLtf+EGP8KbII
	 3o3rUT7WyQaPv6DfnJYq4U8sVPFaM6ghiMyttbOd9gLmK0TofcmDhTQNV+XSHD5vdx
	 GiXyH4uXXTaZdJD/44uHqlHVeGaUU8UTl5iOdS3HstyLslqDx2UV2gm0rxG5fD3y3D
	 R2MVm9e01uI+s82RF6OG+sloU2pENCEAD7zhXKvo/jHy6VJEC8hAU5kkvSJqe2hZps
	 ZOp/00ejMeb3KK/FECAtiu1Bl+CPvO3Vbduvow6HWIGovD3zx/yC7cEl9PskvQYhx/
	 2n4QUWBCx6m1A==
Date: Wed, 28 May 2025 16:49:06 +0100
From: Simon Horman <horms@kernel.org>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
	Lorenzo Colitti <lorenzo@google.com>
Subject: Re: [PATCH net-next] selftest: Add selftest for multicast address
 notifications
Message-ID: <20250528154906.GD1484967@horms.kernel.org>
References: <20250527091855.340837-1-yuyanghuang@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250527091855.340837-1-yuyanghuang@google.com>

On Tue, May 27, 2025 at 06:18:55PM +0900, Yuyang Huang wrote:
> This commit adds a new kernel selftest to verify RTNLGRP_IPV4_MCADDR
> and RTNLGRP_IPV6_MCADDR notifications. The test works by adding and
> removing a dummy interface and then confirming that the system
> correctly receives join and removal notifications for the 224.0.0.1
> and ff02::1 multicast addresses.
> 
> The test relies on the iproute2 version to be 6.13+.
> 
> Tested by the following command:
> $ vng -v --user root --cpus 16 -- \
> make -C tools/testing/selftests TARGETS=net TEST_PROGS=rtnetlink.sh \
> TEST_GEN_PROGS="" run_tests
> 
> Cc: Maciej Żenczykowski <maze@google.com>
> Cc: Lorenzo Colitti <lorenzo@google.com>
> Signed-off-by: Yuyang Huang <yuyanghuang@google.com>

...

> +kci_test_mcast_addr_notification()
> +{
> +	local tmpfile
> +	local monitor_pid
> +	local match_result
> +
> +	tmpfile=$(mktemp)
> +
> +	ip monitor maddr > $tmpfile &
> +	monitor_pid=$!

Hi Yuyang Huang,

Other tests in this file seem to warn if the ip command is too old
to support the test. Perhaps we can achieve that here something like this
(completely untested!):

	if [ ! -e "/proc/$monitor_pid" ]; then
		end_test "SKIP: mcast addr notification: iproute2 too old"
		rm $tmpfile
		return $ksft_skip
	fi

> +	sleep 1
> +
> +	run_cmd ip link add name test-dummy1 type dummy
> +	run_cmd ip link set test-dummy1 up
> +	run_cmd ip link del dev test-dummy1
> +	sleep 1
> +
> +	match_result=$(grep -cE "test-dummy1.*(224.0.0.1|ff02::1)" $tmpfile)
> +
> +	kill $monitor_pid
> +	rm $tmpfile
> +	# There should be 4 line matches as follows.
> +	# 13: test-dummy1    inet6 mcast ff02::1 scope global 
> +	# 13: test-dummy1    inet mcast 224.0.0.1 scope global 
> +	# Deleted 13: test-dummy1    inet mcast 224.0.0.1 scope global 
> +	# Deleted 13: test-dummy1    inet6 mcast ff02::1 scope global 
> +	if [ $match_result -ne 4 ];then
> +		end_test "FAIL: mcast addr notification"
> +		return 1
> +	fi
> +	end_test "PASS: mcast addr notification"
> +}
> +

...

## Form letter - net-next-closed

The merge window for v6.16 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations. We are
currently accepting bug fixes only.

Please repost when net-next reopens after June 8th.

RFC patches sent for review only are obviously welcome at any time.

pw-bot: deffer

