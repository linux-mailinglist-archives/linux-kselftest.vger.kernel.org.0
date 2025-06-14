Return-Path: <linux-kselftest+bounces-34972-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEA5AD990A
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 02:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AC4A7ABA07
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 00:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5686879D0;
	Sat, 14 Jun 2025 00:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mccHB8x8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253E53C30;
	Sat, 14 Jun 2025 00:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749860984; cv=none; b=kNAEDTpXvjU4khXvRu2VOJcEBQywW0fNDSo+gL4kDlrdvxp8yO7HxU/PbSJyDr4VmnnS84PIPWicbP7kyMxeWAbCpaiBa6MXpPrE2CqxRoQZEWlhkfsDBp3OdnN+mYabsNLw4p3650b9FEVErQ/lv+do8hSeqyKxLHVO1YM1rM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749860984; c=relaxed/simple;
	bh=TPpjFuTtZzouHnsGkFKuZ0GBTt3L4cV2yzplCeIHMLo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qsSvo7Z7gdwRvY94haO37ROvjV8whZM7lXCFKBHHpiGB/7kU+TCJ2ZLYghsNRqFUEqYrN7+rcO/PIdLP6FebhXEvT4x7rN3qq4K8vV3I+KFwgD7XeM0f9xtNShshdF5a+Rag9sbmcUDiCho92FX/NqLo7E9Rxf3Yd1taRLqUVfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mccHB8x8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343A5C4CEE3;
	Sat, 14 Jun 2025 00:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749860982;
	bh=TPpjFuTtZzouHnsGkFKuZ0GBTt3L4cV2yzplCeIHMLo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mccHB8x8gq2a6uydJHE6l3cBEURNLYJsVkF+ZHr0IjuBm/SOKrGQ2a0QZp+IGUwSD
	 q+zRAykv5knWCRvDuWPI13dySiJcfdEZQMn5YLp73UZ7/JuJc1Wzcg+VPLekvP0efQ
	 X9aS1xfm3C7lm2VmabT0ATRsuyGx+RT6g4wEqGq+EgYCLkEYmN/IgBa0938cGYQjE4
	 1P1A1YBlN5VKo7bCvTDShBc6zsn00MhBdDwLiJOeYV7TdmcVg1d1SHof9yTQ/Ta3wh
	 F4M8F/m6TPu6oOqoY3ub2fVNXekIQowYbkEIs8Dxw4UxkhDstONNs/RDgx4AOTlmJZ
	 j21mzSDGMET/w==
Date: Fri, 13 Jun 2025 17:29:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, "Maciej
 =?UTF-8?B?xbtlbmN6eWtvd3NraQ==?=" <maze@google.com>, Lorenzo Colitti
 <lorenzo@google.com>
Subject: Re: [PATCH net-next, v3] selftest: Add selftest for multicast
 address notifications
Message-ID: <20250613172941.6c454992@kernel.org>
In-Reply-To: <20250612020514.2542424-1-yuyanghuang@google.com>
References: <20250612020514.2542424-1-yuyanghuang@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Jun 2025 11:05:14 +0900 Yuyang Huang wrote:
> +VERBOSE=0
> +PAUSE=no
> +PAUSE_ON_FAIL=no
> +
> +source lib.sh
> +
> +# set global exit status, but never reset nonzero one.
> +check_err()
> +{
> +	if [ $ret -eq 0 ]; then
> +		ret=$1
> +	fi
> +	[ -n "$2" ] && echo "$2"
> +}
> +
> +run_cmd_common()
> +{
> +	local cmd="$*"
> +	local out
> +	if [ "$VERBOSE" = "1" ]; then
> +		echo "COMMAND: ${cmd}"
> +	fi
> +	out=$($cmd 2>&1)
> +	rc=$?
> +	if [ "$VERBOSE" = "1" -a -n "$out" ]; then
> +		echo "    $out"
> +	fi
> +	return $rc
> +}
> +
> +run_cmd() {
> +	run_cmd_common "$@"
> +	rc=$?
> +	check_err $rc
> +	return $rc
> +}
> +
> +end_test()
> +{
> +	echo "$*"
> +	[ "${VERBOSE}" = "1" ] && echo
> +
> +	if [[ $ret -ne 0 ]] && [[ "${PAUSE_ON_FAIL}" = "yes" ]]; then
> +		echo "Hit enter to continue"
> +		read a
> +	fi;
> +
> +	if [ "${PAUSE}" = "yes" ]; then
> +		echo "Hit enter to continue"
> +		read a
> +	fi
> +
> +}

Perhaps move these to lib.sh as a separate commit?
They seem generic.

Please fix the shellcheck warnings. The "info"-level messages 
are up you, SC2317 can be ignored.
-- 
pw-bot: cr

