Return-Path: <linux-kselftest+bounces-9778-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E37D8C0CAD
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 10:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DF541C20EB0
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 08:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADAB12E1C4;
	Thu,  9 May 2024 08:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRSfnqHJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EA7DDD9;
	Thu,  9 May 2024 08:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715243905; cv=none; b=f6AXevLTJ+GlbpVaPzLXlP4S+cj+uKpiwK9skO6JKGgG1UvCqf2f36i63IfQGxKTXYGr2PHMaCXUXOOw9ieXvi63qrctXV71rqMr5eQbv5O0D8UyzYBti6KApF5AtoIMh++0DxLvdKjT6tTceec8VVDSxlRNWPLDz7FOfYsdVEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715243905; c=relaxed/simple;
	bh=zsovbGoq8RZauFYPDoccHy6UgagSseoBYUdNySN/XtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQEacZVpjG/NtH73ZAg35T5aNYjdWbWq6tiab7GmH9MDOrQDZIDyCgXgjRW18K1JUYk2LeeQ2upXN41Jb5wL9OUgTfaxNyyX3Cbl3MAMLrK0Hu2s+/rE+3AyJUy+TnhnDy1lNBX4o8gwScDF/abk2WoFdFpKTxOOtqS+vrQdL7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRSfnqHJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1616C116B1;
	Thu,  9 May 2024 08:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715243905;
	bh=zsovbGoq8RZauFYPDoccHy6UgagSseoBYUdNySN/XtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XRSfnqHJbO9qTED8QloMU6C8EPGxwiSaxCnP8F2m6fhUAOA3WFBqDMMngD7Q5Py00
	 d0lE86n4mxYdtbqY2simyyUfQ94f35NNP+d2AG/YMQobyyPToIBKrX1LsLaMF7Xif+
	 uYC0+56a179PA8Oe6z0z/WJnj5AbEp/kMF3CRqK0DJtKHfn7z2GKgSWVjy6z1T3gru
	 Tk2bTXDMpOCwg521HFF9JproQ3IXeMKDwivLFyDwmVRENCxHM3bS36dLC5+BwarwPy
	 akJzOf5jvIHyUeHrpRBxwKm9FywTC7QCpispk5lZhoemGBMukyrfDg+pCysIRhuFLD
	 ua6O6paBOkMKg==
Date: Thu, 9 May 2024 09:38:19 +0100
From: Simon Horman <horms@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: net: avoid waiting for server in amt.sh
 forever when it fails.
Message-ID: <20240509083819.GJ1736038@kernel.org>
References: <20240508040643.229383-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508040643.229383-1-ap420073@gmail.com>

On Wed, May 08, 2024 at 04:06:43AM +0000, Taehee Yoo wrote:
> In the forwarding testcase, it opens a server and a client with the nc.
> The server receives the correct message from NC, it prints OK.
> The server prints FAIL if it receives the wrong message from the client.
> 
> But If the server can't receive any message, it will not close so
> the amt.sh waits forever.
> There are several reasons.
> 1. crash of smcrouted.
> 2. Send a message from the client to the server before the server is up.
> 
> To avoid this problem, the server waits only for 10 seconds.
> The client sends messages for 10 seconds.
> If the server is successfully closed, it kills the client.
> 
> Fixes: c08e8baea78e ("selftests: add amt interface selftest script")
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
>  tools/testing/selftests/net/amt.sh | 63 +++++++++++++++++++-----------
>  1 file changed, 40 insertions(+), 23 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/amt.sh b/tools/testing/selftests/net/amt.sh
> index 75528788cb95..16641d3dccce 100755
> --- a/tools/testing/selftests/net/amt.sh
> +++ b/tools/testing/selftests/net/amt.sh
> @@ -77,6 +77,7 @@ readonly LISTENER=$(mktemp -u listener-XXXXXXXX)
>  readonly GATEWAY=$(mktemp -u gateway-XXXXXXXX)
>  readonly RELAY=$(mktemp -u relay-XXXXXXXX)
>  readonly SOURCE=$(mktemp -u source-XXXXXXXX)
> +readonly RESULT=$(mktemp -p /tmp amt-XXXXXXXX)
>  ERR=4
>  err=0
>  
> @@ -85,6 +86,10 @@ exit_cleanup()
>  	for ns in "$@"; do
>  		ip netns delete "${ns}" 2>/dev/null || true
>  	done
> +	rm $RESULT
> +	smcpid=$(< $SMCROUTEDIR/amt.pid)
> +	kill $smcpid
> +	rm -rf $SMCROUTEDIR

Hi Taehee Yoo,

I think this cleanup may be executed before SMCROUTEDIR exists.

For consistency with other temp files, perhaps
perpahps it is best to move the creation of SMCROUTEDIR up
to where RESULT is instantiated above.

And perhaps the pid handling can be made conditional on the
existence of $SMCROUTEDIR/amt.pid

	if [ -f "$SMCROUTEDIR/amt.pid" ]; then
		...
	fi

>  
>  	exit $ERR
>  }
> @@ -167,7 +172,9 @@ setup_iptables()
>  
>  setup_mcast_routing()
>  {
> -	ip netns exec "${RELAY}" smcrouted
> +	SMCROUTEDIR="$(mktemp -d)"
> +
> +	ip netns exec "${RELAY}" smcrouted -P $SMCROUTEDIR/amt.pid
>  	ip netns exec "${RELAY}" smcroutectl a relay_src \
>  		172.17.0.2 239.0.0.1 amtr
>  	ip netns exec "${RELAY}" smcroutectl a relay_src \
> @@ -210,40 +217,52 @@ check_features()
>  
>  test_ipv4_forward()
>  {
> -	RESULT4=$(ip netns exec "${LISTENER}" nc -w 1 -l -u 239.0.0.1 4000)
> +	echo "" > $RESULT
> +	bash -c "$(ip netns exec "${LISTENER}" \
> +		timeout 10s nc -w 1 -l -u 239.0.0.1 4000 > $RESULT)"

Hi,

It's unclear to me what the purpose of the bash -c "$(...)" construction is
here. Can the same be achieved using simply:

	ip netns exec "${LISTENER}" \
		timeout 10s nc -w 1 -l -u 239.0.0.1 4000 > $RESULT

Also, not strictly related to this patch, it seems a little odd here, and
elsewhere, to call bash in a /bin/sh script.

> +	RESULT4=$(< $RESULT)
>  	if [ "$RESULT4" == "172.17.0.2" ]; then
>  		printf "TEST: %-60s  [ OK ]\n" "IPv4 amt multicast forwarding"
> -		exit 0
>  	else
>  		printf "TEST: %-60s  [FAIL]\n" "IPv4 amt multicast forwarding"
> -		exit 1
>  	fi
> +
>  }

...

>  send_mcast4()
>  {
>  	sleep 2
> -	ip netns exec "${SOURCE}" bash -c \
> -		'echo 172.17.0.2 | nc -w 1 -u 239.0.0.1 4000' &
> +	for n in {0..10}; do
> +		ip netns exec "${SOURCE}" bash -c \
> +			'echo 172.17.0.2 | nc -w 1 -u 239.0.0.1 4000'
> +		sleep 1
> +	done
> +
>  }
>  
>  send_mcast6()
>  {
>  	sleep 2
> -	ip netns exec "${SOURCE}" bash -c \
> -		'echo 2001:db8:3::2 | nc -w 1 -u ff0e::5:6 6000' &
> +	for n in {0..10}; do
> +		ip netns exec "${SOURCE}" bash -c \
> +			'echo 2001:db8:3::2 | nc -w 1 -u ff0e::5:6 6000'
> +		sleep 1
> +	done
> +
>  }
>  
>  check_features

...

-- 
pw-bot: under-review

