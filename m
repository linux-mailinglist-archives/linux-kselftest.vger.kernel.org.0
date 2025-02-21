Return-Path: <linux-kselftest+bounces-27121-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C6EA3E9A1
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 02:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ECAE17A2E7
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 01:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F0E2C187;
	Fri, 21 Feb 2025 01:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyc25Qeo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B25C7080D;
	Fri, 21 Feb 2025 01:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740099851; cv=none; b=YMCpn3K5fqw+mUET+PHD6KEzvZRhH8v41Vj3FWEynhTP1l5lO+A6HE3VOZyx3Bfn6HoaPYfduaIxpwrIEqTtye3klilnfJIKmMQ3vklG3AKLaC+SrX45VXHtvr1gM3Fj/NQYX2PIJx01igquqjyWKg8G+223gvkeEZXbxAMtwv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740099851; c=relaxed/simple;
	bh=XDOcSSu0rDcbE3pPzb8t2eP2JuFEMVZB5io3X9ORrmE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=adixGZaSfFSSfODsNzEusqMylpu4Gs81xzicGTx/0eNGXSty32X7O+3brbVr1eLlH8REXggQGSSgKdbNKQjkDe4eLCBBOXjOvDFribgbALXHRjXDtNDVLL7+tgzo2bKvbfhlV89LJSGi/kl0D378umDZvsVeFCMOIKX/mIamGR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uyc25Qeo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6033CC4CED1;
	Fri, 21 Feb 2025 01:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740099850;
	bh=XDOcSSu0rDcbE3pPzb8t2eP2JuFEMVZB5io3X9ORrmE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uyc25QeobqYnzKDgAhcZ9cLZwGYw/jAYJpZBhYLRSFQeAGzVa6tuuqlHMtvJt2NWc
	 u8hJPnbQkE2bkB5l0vE9t2vQ/Canbq6h3d2haPKU6LbrAnhiCDXuO31z7GDrSrsN0n
	 fQBeTaCUmQGIajV80zqhSA3G52FSksAHegUimUDEy0hgxwLQEZ0vy5EnHIFIV8/O2x
	 MmSfGckrhP7SFZhzxQeuP66+bSEU69oJJgO9tB+e9hPQtOcdTanG1hZ+5PVfCLSFlL
	 rIBT2+JcKr6f4VuDVDAKjkvfEUCg0SPb7Ng5tCGHqPdn2PLV0JkMIq7JYqjgPxAWVr
	 1yMN2K8NuMQpw==
Date: Thu, 20 Feb 2025 17:04:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kevin Krakauer <krakauer@google.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan
 <shuah@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/net: deflake GRO tests and fix return value
 and output
Message-ID: <20250220170409.42cce424@kernel.org>
In-Reply-To: <20250218164555.1955400-1-krakauer@google.com>
References: <20250218164555.1955400-1-krakauer@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Feb 2025 08:45:55 -0800 Kevin Krakauer wrote:
> GRO tests are timing dependent and can easily flake. This is partially
> mitigated in gro.sh by giving each subtest 3 chances to pass. However,
> this still flakes on some machines.

To be clear - are you running this over veth or a real device?

> Set the device's napi_defer_hard_irqs to 50 so that GRO is less likely
> to immediately flush. This already happened in setup_loopback.sh, but
> wasn't added to setup_veth.sh. This accounts for most of the reduction
> in flakiness.

That doesn't make intuitive sense to me. If we already defer flushes
why do we need to also defer IRQs?

> We also increase the number of chances for success from 3 to 6.
> 
> `gro.sh -t <test>` now returns a passing/failing exit code as expected.
> 
> gro.c:main no longer erroneously claims a test passes when running as a
> server.
> 
> Tested: Ran `gro.sh -t large` 100 times with and without this change.
> Passed 100/100 with and 64/100 without. Ran inside strace to increase
> flakiness.
> 
> Signed-off-by: Kevin Krakauer <krakauer@google.com>
> ---
>  tools/testing/selftests/net/gro.c         | 8 +++++---
>  tools/testing/selftests/net/gro.sh        | 5 +++--
>  tools/testing/selftests/net/setup_veth.sh | 1 +
>  3 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/gro.c b/tools/testing/selftests/net/gro.c
> index b2184847e388..d5824eadea10 100644
> --- a/tools/testing/selftests/net/gro.c
> +++ b/tools/testing/selftests/net/gro.c
> @@ -1318,11 +1318,13 @@ int main(int argc, char **argv)
>  	read_MAC(src_mac, smac);
>  	read_MAC(dst_mac, dmac);
>  
> -	if (tx_socket)
> +	if (tx_socket) {
>  		gro_sender();
> -	else
> +	} else {
> +		/* Only the receiver exit status determines test success. */
>  		gro_receiver();
> +		fprintf(stderr, "Gro::%s test passed.\n", testname);
> +	}
>  
> -	fprintf(stderr, "Gro::%s test passed.\n", testname);


That seems quite separate to the stability fix?

>  	return 0;
>  }
> diff --git a/tools/testing/selftests/net/gro.sh b/tools/testing/selftests/net/gro.sh
> index 02c21ff4ca81..703173f8c8a9 100755
> --- a/tools/testing/selftests/net/gro.sh
> +++ b/tools/testing/selftests/net/gro.sh
> @@ -21,7 +21,7 @@ run_test() {
>    # Each test is run 3 times to deflake, because given the receive timing,
>    # not all packets that should coalesce will be considered in the same flow
>    # on every try.
> -  for tries in {1..3}; do
> +  for tries in {1..6}; do
>      # Actual test starts here
>      ip netns exec $server_ns ./gro "${ARGS[@]}" "--rx" "--iface" "server" \
>        1>>log.txt &  
> @@ -100,5 +100,6 @@ trap cleanup EXIT
>  if [[ "${test}" == "all" ]]; then
>    run_all_tests
>  else
> -  run_test "${proto}" "${test}"
> +  exit_code=$(run_test "${proto}" "${test}")
> +  exit $exit_code

Also separate from stability?

Let's split the patch up into logically separate changes.

>  fi;
> diff --git a/tools/testing/selftests/net/setup_veth.sh b/tools/testing/selftests/net/setup_veth.sh
> index 1f78a87f6f37..9882ad730c24 100644
> --- a/tools/testing/selftests/net/setup_veth.sh
> +++ b/tools/testing/selftests/net/setup_veth.sh
> @@ -12,6 +12,7 @@ setup_veth_ns() {
>  
>  	[[ -e /var/run/netns/"${ns_name}" ]] || ip netns add "${ns_name}"
>  	echo 1000000 > "/sys/class/net/${ns_dev}/gro_flush_timeout"
> +	echo 50 > "/sys/class/net/${ns_dev}/napi_defer_hard_irqs"
>  	ip link set dev "${ns_dev}" netns "${ns_name}" mtu 65535
>  	ip -netns "${ns_name}" link set dev "${ns_dev}" up
>  
-- 
pw-bot: cr

