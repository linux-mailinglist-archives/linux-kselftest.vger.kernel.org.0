Return-Path: <linux-kselftest+bounces-45286-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D16C4C606
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 09:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E759D18C3870
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 08:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B6C2D372A;
	Tue, 11 Nov 2025 08:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+L3Fe9p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF608A944;
	Tue, 11 Nov 2025 08:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762849172; cv=none; b=bmG8ZqTOAFGOtHeexalIMvI3lNTyJBuSA2vcPyFVjI3ho8d0VDd2BoaYraMEckNCw06zsIlkI2Ac1+ffKdP1+c1mlDloCBMchxQS+IgCOc8YlGPuluJzDNc1MCDnXcDSEr2A3jySVw9aj8owp9im+WxhsCczY8G6PFkqE3k27oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762849172; c=relaxed/simple;
	bh=VstIjK1vfnpN7gjRmI8dp01MjG9QpTrz0bVPQw+b3VU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EG8nAsfVpUaTwNCUJzX+4nG1bKfoQ+dyU36ht9WEl7iQSBHYOtMyUUSej9jmqzckTyaw4Vs14W3EhPtwKvKxBEnZ+o6sSv4W9iQ7OycgcFjNRYqzOcNI7XUK1Z/dP9HoznQGcMZPmLQUvX4gAkPoC+RoHqpbyygoNVYbyGY6Mf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+L3Fe9p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE8BC19423;
	Tue, 11 Nov 2025 08:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762849171;
	bh=VstIjK1vfnpN7gjRmI8dp01MjG9QpTrz0bVPQw+b3VU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=a+L3Fe9pxBPaiamQhdm4lNYcibp3HHiPit3IntdyKfPq3efKSDEXdR/myFYriVM7h
	 2db9dgrICZ2s7FqFF6m2snCIbTcImEhP4sWEpY1DspRRgRdG0hEEm/soA+EgCcSW1h
	 G9Wekk6tMFakRC9/BvaA7OlKQBOfM7QD/s2/EsTgtWnltCqdjiL5J/0d9WtM77EiYm
	 xx8lvh4Etx51gd1YxfsJ3tZs4M2hWh3uMBVl8ZvilqKGyrs25RdV/2f07g0zgnbLYR
	 u/ab6rkP6WBQYapqxeQFIlqAqc8AcLyvQCFlqwwI7G5ffCTtrC41iICedumfZTm8DZ
	 UR+Lqx46UC2Eg==
Message-ID: <31caf9ecda9335a4377f383404b2609a24c8caeb.camel@kernel.org>
Subject: Re: [PATCH net 6/6] selftests: mptcp: join: properly kill
 background tasks
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan
 <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Tue, 11 Nov 2025 16:19:25 +0800
In-Reply-To: <20251110-net-mptcp-sft-join-unstable-v1-6-a4332c714e10@kernel.org>
References: 
	<20251110-net-mptcp-sft-join-unstable-v1-0-a4332c714e10@kernel.org>
	 <20251110-net-mptcp-sft-join-unstable-v1-6-a4332c714e10@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Mon, 2025-11-10 at 19:23 +0100, Matthieu Baerts (NGI0) wrote:
> The 'run_tests' function is executed in the background, but killing
> its
> associated PID would not kill the children tasks running in the
> background.
> 
> To properly kill all background tasks, 'kill -- -PID' could be used,
> but
> this requires kill from procps-ng. Instead, all children tasks are
> listed using 'ps', and 'kill' is called with all PIDs of this group.
> 
> Fixes: 31ee4ad86afd ("selftests: mptcp: join: stop transfer when
> check is done (part 1)")
> Cc: stable@vger.kernel.org
> Fixes: 04b57c9e096a ("selftests: mptcp: join: stop transfer when
> check is done (part 2)")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

This patch looks good to me.

    Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 18 +++++++++------
> ---
>  tools/testing/selftests/net/mptcp/mptcp_lib.sh  | 21
> +++++++++++++++++++++
>  2 files changed, 30 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 01273abfdc89..41503c241989 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -3831,7 +3831,7 @@ userspace_tests()
>  		chk_mptcp_info subflows 0 subflows 0
>  		chk_subflows_total 1 1
>  		kill_events_pids
> -		mptcp_lib_kill_wait $tests_pid
> +		mptcp_lib_kill_group_wait $tests_pid
>  	fi
>  
>  	# userspace pm create destroy subflow
> @@ -3859,7 +3859,7 @@ userspace_tests()
>  		chk_mptcp_info subflows 0 subflows 0
>  		chk_subflows_total 1 1
>  		kill_events_pids
> -		mptcp_lib_kill_wait $tests_pid
> +		mptcp_lib_kill_group_wait $tests_pid
>  	fi
>  
>  	# userspace pm create id 0 subflow
> @@ -3880,7 +3880,7 @@ userspace_tests()
>  		chk_mptcp_info subflows 1 subflows 1
>  		chk_subflows_total 2 2
>  		kill_events_pids
> -		mptcp_lib_kill_wait $tests_pid
> +		mptcp_lib_kill_group_wait $tests_pid
>  	fi
>  
>  	# userspace pm remove initial subflow
> @@ -3904,7 +3904,7 @@ userspace_tests()
>  		chk_mptcp_info subflows 1 subflows 1
>  		chk_subflows_total 1 1
>  		kill_events_pids
> -		mptcp_lib_kill_wait $tests_pid
> +		mptcp_lib_kill_group_wait $tests_pid
>  	fi
>  
>  	# userspace pm send RM_ADDR for ID 0
> @@ -3930,7 +3930,7 @@ userspace_tests()
>  		chk_mptcp_info subflows 1 subflows 1
>  		chk_subflows_total 1 1
>  		kill_events_pids
> -		mptcp_lib_kill_wait $tests_pid
> +		mptcp_lib_kill_group_wait $tests_pid
>  	fi
>  }
>  
> @@ -3960,7 +3960,7 @@ endpoint_tests()
>  		pm_nl_add_endpoint $ns2 10.0.2.2 flags signal
>  		pm_nl_check_endpoint "modif is allowed" \
>  			$ns2 10.0.2.2 id 1 flags signal
> -		mptcp_lib_kill_wait $tests_pid
> +		mptcp_lib_kill_group_wait $tests_pid
>  	fi
>  
>  	if reset_with_tcp_filter "delete and re-add" ns2 10.0.3.2
> REJECT OUTPUT &&
> @@ -4015,7 +4015,7 @@ endpoint_tests()
>  			chk_mptcp_info subflows 3 subflows 3
>  		done
>  
> -		mptcp_lib_kill_wait $tests_pid
> +		mptcp_lib_kill_group_wait $tests_pid
>  
>  		kill_events_pids
>  		chk_evt_nr ns1 MPTCP_LIB_EVENT_LISTENER_CREATED 1
> @@ -4089,7 +4089,7 @@ endpoint_tests()
>  		wait_mpj $ns2
>  		chk_subflow_nr "after re-re-add ID 0" 3
>  		chk_mptcp_info subflows 3 subflows 3
> -		mptcp_lib_kill_wait $tests_pid
> +		mptcp_lib_kill_group_wait $tests_pid
>  
>  		kill_events_pids
>  		chk_evt_nr ns1 MPTCP_LIB_EVENT_LISTENER_CREATED 1
> @@ -4137,7 +4137,7 @@ endpoint_tests()
>  		wait_mpj $ns2
>  		pm_nl_add_endpoint $ns1 10.0.3.1 id 2 flags signal
>  		wait_mpj $ns2
> -		mptcp_lib_kill_wait $tests_pid
> +		mptcp_lib_kill_group_wait $tests_pid
>  
>  		join_syn_tx=3 join_connect_err=1 \
>  			chk_join_nr 2 2 2
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> index d62e653d48b0..f4388900016a 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> @@ -350,6 +350,27 @@ mptcp_lib_kill_wait() {
>  	wait "${1}" 2>/dev/null
>  }
>  
> +# $1: PID
> +mptcp_lib_pid_list_children() {
> +	local curr="${1}"
> +	# evoke 'ps' only once
> +	local pids="${2:-"$(ps o pid,ppid)"}"
> +
> +	echo "${curr}"
> +
> +	local pid
> +	for pid in $(echo "${pids}" | awk "\$2 == ${curr} { print
> \$1 }"); do
> +		mptcp_lib_pid_list_children "${pid}" "${pids}"
> +	done
> +}
> +
> +# $1: PID
> +mptcp_lib_kill_group_wait() {
> +	# Some users might not have procps-ng: cannot use "kill -- -
> PID"
> +	mptcp_lib_pid_list_children "${1}" | xargs -r kill
> &>/dev/null
> +	wait "${1}" 2>/dev/null
> +}
> +
>  # $1: IP address
>  mptcp_lib_is_v6() {
>  	[ -z "${1##*:*}" ]
> 


