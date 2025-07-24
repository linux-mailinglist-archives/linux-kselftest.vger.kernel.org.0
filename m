Return-Path: <linux-kselftest+bounces-37947-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6590B10DA2
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 16:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C5C01C82BBC
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jul 2025 14:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E596F2E1741;
	Thu, 24 Jul 2025 14:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYqGAjnE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C45A937;
	Thu, 24 Jul 2025 14:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753367514; cv=none; b=VB4543j8zXwPUm5qjTMemRpZ1g4IQ4I9ME60QMx26yA2RFRWIqwbXngpysjrTj3bFK1LhU1XLLSR1ZPh+BqBmSqpWip9Ow6i8vkDfBwd8b7eTdEZ7xTEzU2/v5RP9nfeC1L+n9IjHVQkXg7IBHM4Sl+q8Yujfa173QoJoRNftIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753367514; c=relaxed/simple;
	bh=YNBaN3j4mUbkAKTE3TC0ZA98z+X2KPUvinEexHZ9C8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3ZyDVohDQ4NWDswCSKNJzIeUvAdJsJCnCeDYvUKfryzS9+SsIGXXRbkMbuzwEeu8ImJuT3Lt/cKGEMyI0z9tQvrpV5KRfzASQJYoPToGGgih8LO69PAdcDg06TOAvOP0Zn12LeRpR0Q9+0NGoky5Mh2+c9WxvrA7R3EQwTtmSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYqGAjnE; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-237311f5a54so8185045ad.2;
        Thu, 24 Jul 2025 07:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753367512; x=1753972312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+iwAeIA2+xfwqfXMdMLqDVi+dKWzWoeBjyMMY0H8dWg=;
        b=mYqGAjnEt/iMaYqopYADC1s3heVyA70tQwAJHNO2Po9OUbWfZCGt1WDAaivHp41KSc
         qz4nHlDFP5NucwWcYmsbl8yC/FzF6Cgdk63d8w3PSuReFMeBwsgaBDXSD84am5RICXHu
         UT83SKdN1w5jJ/4J038grzVq6Ips5bD5fbaRzDyKme3tTE3hupd2YlqtxLNkKWxC9Wbk
         leCmx8idcrJw0/FsVvKaQ5AQmYRuUDh9dTHRU4UFLSF06NBgPzM+8zuDl17Xs4VHpMIj
         UCHzUyVIT4trfCxVoORy3OR6GXjFb9pB5igQzQj3yrO023vBoG2jWrUBq4/Tt6MY+azr
         gnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753367512; x=1753972312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+iwAeIA2+xfwqfXMdMLqDVi+dKWzWoeBjyMMY0H8dWg=;
        b=AO6N0BWQqe75TjG/izDB4ewjPTiIKf7Eft9NjSPZgKRvApHYmIW40YT1ZXSAWLqkPV
         e6nfl1lppC+a2ACBwzAPMsv0LlICbao4R60PeM9lfpJvXGVTODIUR769YTQOd5SaJJFg
         Bol80Oegt+MKxIRUB01tL+iYvD07Oftq33M/pGzn12Tm8xpW8BDS/mwsCnCaMrFF9e3z
         qCOn9O4yUu2xXh/0ZCHmFhpwEinXmrQCQlNChqP/8nW6nivO/ISx57IcEzVfkKlaA0lf
         PXaC1sw6TpDdGBqSxvQRK/52Gy9mcufIUTAv5mfigIzlpNv+4HvBUUpdy4BzV8txaTVR
         SkmA==
X-Forwarded-Encrypted: i=1; AJvYcCUwDP2rKdkVOiMXSRuzOq/GKS67I/s/eEUi+aCejA4aShM1MHhJn4pnNdHh79+DO/DMWNju4lpyo+EaRLOk@vger.kernel.org, AJvYcCWXVZtW6Z1/ErRtiulJKtOIr+i4FAb3fChZER++ARZ21pvj07rYZmtcd3jB9zEJMw7Yj0X19Eoa1WqLE26paCQs@vger.kernel.org, AJvYcCWiwOZQwpnxyoX/f9fLjm9s4/JLbWFlh9r2/NUS5fxi0pQM18Gz0PqRDP2Jd+ylf+xK92B/DEH1T3s=@vger.kernel.org, AJvYcCXi4ySk/A+wIg6Gy5qayc8rstdPYO6MwL+ehsdsrG5rwolprnNyGl/bb6DpQJWu8uT0eWYS/kEQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyX9Pr+1aXzseerMuh5CD8ABGONFbfLM3KkXR2/3OgJSJH0NEQT
	rNKcXLRlXXKMZTwh5pMHIvU+lwGngRRjA2cAuuuvLQ2dchaNznaswm7N
X-Gm-Gg: ASbGnctBY8abPoIqabPLOHecSKKF76X9Xjv+rE2HfD4UV0FpcCHEmN6k2jMmrBpYyN9
	C2d62z2zctBBfU7zEHjLIywYJ2yydfaG1wG2qkkNySGncxNyZd4XlPItu2xMBB80g02ZNGRQLBm
	yqdA0rNuzrcsJKqpgAaw2t2GZV9rptAEFlJmOYXAOM/YIvHOmYyr5dGB4F3KUdhguGvamI/f/EZ
	0ajghjvkZYFrArSu19WsX2wJbyrUsIMbWf+A5eZbvgrS3vYcqTCbtMSb6nnfuf0Dn/AtibqtQNX
	yOwoHhcrRyuH4m5vOs1ZALms7WXxMwMPaSxD8wFhPCWHiAne/QnqRjhaPxkRj+AehukIIpqA4gZ
	h48x0ZEYhKSAmlIpLhVdrE07vptY5R/bWbnc8Pg==
X-Google-Smtp-Source: AGHT+IHLcuOpaFWgNJ0bOxXfH7GE7j0MIPGb9iJ4Lc9UbhKtiKFpDukLVJPuav7X8+8Dg+wiDyWhEw==
X-Received: by 2002:a17:902:e213:b0:23f:ac71:ef0 with SMTP id d9443c01a7336-23fac71127fmr283445ad.43.1753367512273;
        Thu, 24 Jul 2025 07:31:52 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48bbeaesm17439635ad.112.2025.07.24.07.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 07:31:51 -0700 (PDT)
Date: Thu, 24 Jul 2025 14:31:43 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Petr Machata <petrm@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Alessandro Zanni <alessandro.zanni87@gmail.com>,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] selftests: bonding: add test for LACP actor
 port priority
Message-ID: <aIJDz3AgQtnzSR59@fedora>
References: <20250724081632.12921-1-liuhangbin@gmail.com>
 <20250724081632.12921-4-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724081632.12921-4-liuhangbin@gmail.com>

Hi Jakub,

Should I drop this selftest as it needs the new iproute2 feature that has
not applied yet?

Thanks
Hangbin
On Thu, Jul 24, 2025 at 08:16:32AM +0000, Hangbin Liu wrote:
> Add a selftest to verify that per-port actor priority (ad_actor_port_prio)
> is correctly applied and affects aggregator selection as expected.
> 
> Move cmd_jq from forwarding/lib.sh to net/lib.sh.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  .../selftests/drivers/net/bonding/Makefile    |  3 +-
>  .../drivers/net/bonding/bond_lacp_prio.sh     | 73 +++++++++++++++++++
>  tools/testing/selftests/net/forwarding/lib.sh | 24 ------
>  tools/testing/selftests/net/lib.sh            | 24 ++++++
>  4 files changed, 99 insertions(+), 25 deletions(-)
>  create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_lacp_prio.sh
> 
> diff --git a/tools/testing/selftests/drivers/net/bonding/Makefile b/tools/testing/selftests/drivers/net/bonding/Makefile
> index 2b10854e4b1e..32617a834a6b 100644
> --- a/tools/testing/selftests/drivers/net/bonding/Makefile
> +++ b/tools/testing/selftests/drivers/net/bonding/Makefile
> @@ -10,7 +10,8 @@ TEST_PROGS := \
>  	mode-2-recovery-updelay.sh \
>  	bond_options.sh \
>  	bond-eth-type-change.sh \
> -	bond_macvlan_ipvlan.sh
> +	bond_macvlan_ipvlan.sh \
> +	bond_lacp_prio.sh
>  
>  TEST_FILES := \
>  	lag_lib.sh \
> diff --git a/tools/testing/selftests/drivers/net/bonding/bond_lacp_prio.sh b/tools/testing/selftests/drivers/net/bonding/bond_lacp_prio.sh
> new file mode 100755
> index 000000000000..a3f939d12143
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/bonding/bond_lacp_prio.sh
> @@ -0,0 +1,73 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Testing if bond lacp per port priority works
> +
> +lib_dir=$(dirname "$0")
> +# shellcheck disable=SC1091
> +source "$lib_dir"/../../../net/lib.sh
> +
> +# create client, switch, backup switch netns
> +setup_ns c_ns s_ns b_ns
> +defer cleanup_all_ns
> +
> +# setup links
> +# shellcheck disable=SC2154
> +ip -n "${c_ns}" link add eth0 type veth peer name eth0 netns "${s_ns}"
> +ip -n "${c_ns}" link add eth1 type veth peer name eth1 netns "${s_ns}"
> +# shellcheck disable=SC2154
> +ip -n "${c_ns}" link add eth2 type veth peer name eth0 netns "${b_ns}"
> +ip -n "${c_ns}" link add eth3 type veth peer name eth1 netns "${b_ns}"
> +
> +ip -n "${c_ns}" link add bond0 type bond mode 802.3ad miimon 100 lacp_rate fast ad_select prio
> +ip -n "${s_ns}" link add bond0 type bond mode 802.3ad miimon 100 lacp_rate fast
> +ip -n "${b_ns}" link add bond0 type bond mode 802.3ad miimon 100 lacp_rate fast
> +
> +ip -n "${c_ns}" link set eth0 master bond0
> +ip -n "${c_ns}" link set eth1 master bond0
> +ip -n "${c_ns}" link set eth2 master bond0
> +ip -n "${c_ns}" link set eth3 master bond0
> +ip -n "${s_ns}" link set eth0 master bond0
> +ip -n "${s_ns}" link set eth1 master bond0
> +ip -n "${b_ns}" link set eth0 master bond0
> +ip -n "${b_ns}" link set eth1 master bond0
> +
> +ip -n "${c_ns}" link set bond0 up
> +ip -n "${s_ns}" link set bond0 up
> +ip -n "${b_ns}" link set bond0 up
> +
> +# set ad actor port priority, default 255
> +ip -n "${c_ns}" link set eth0 type bond_slave ad_actor_port_prio 1000
> +prio=$(cmd_jq "ip -n ${c_ns} -d -j link show eth0" ".[].linkinfo.info_slave_data.ad_actor_port_prio")
> +[ "$prio" -ne 1000 ] && RET=1
> +ip -n "${c_ns}" link set eth2 type bond_slave ad_actor_port_prio 10
> +prio=$(cmd_jq "ip -n ${c_ns} -d -j link show eth2" ".[].linkinfo.info_slave_data.ad_actor_port_prio")
> +[ "$prio" -ne 10 ] && RET=1
> +log_test "bond 802.3ad" "ad_actor_port_prio setting"
> +
> +# Trigger link state change to reselect the aggregator
> +ip -n "${c_ns}" link set eth1 down
> +ip -n "${c_ns}" link set eth1 up
> +# the active agg should be connect to switch
> +bond_agg_id=$(cmd_jq "ip -n ${c_ns} -d -j link show bond0" ".[].linkinfo.info_data.ad_info.aggregator")
> +eth0_agg_id=$(cmd_jq "ip -n ${c_ns} -d -j link show eth0" ".[].linkinfo.info_slave_data.ad_aggregator_id")
> +if [ "${bond_agg_id}" -ne "${eth0_agg_id}" ]; then
> +	RET=1
> +fi
> +
> +# Change the actor port prio and re-test
> +ip -n "${c_ns}" link set eth0 type bond_slave ad_actor_port_prio 10
> +ip -n "${c_ns}" link set eth2 type bond_slave ad_actor_port_prio 1000
> +# Trigger link state change to reselect the aggregator
> +ip -n "${c_ns}" link set eth1 down
> +ip -n "${c_ns}" link set eth1 up
> +# now the active agg should be connect to backup switch
> +bond_agg_id=$(cmd_jq "ip -n ${c_ns} -d -j link show bond0" ".[].linkinfo.info_data.ad_info.aggregator")
> +eth2_agg_id=$(cmd_jq "ip -n ${c_ns} -d -j link show eth2" ".[].linkinfo.info_slave_data.ad_aggregator_id")
> +# shellcheck disable=SC2034
> +if [ "${bond_agg_id}" -ne "${eth2_agg_id}" ]; then
> +	RET=1
> +fi
> +log_test "bond 802.3ad" "ad_actor_port_prio switch"
> +
> +exit "${EXIT_STATUS}"
> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> index 508f3c700d71..09b63c6f3dbd 100644
> --- a/tools/testing/selftests/net/forwarding/lib.sh
> +++ b/tools/testing/selftests/net/forwarding/lib.sh
> @@ -551,30 +551,6 @@ wait_for_dev()
>          fi
>  }
>  
> -cmd_jq()
> -{
> -	local cmd=$1
> -	local jq_exp=$2
> -	local jq_opts=$3
> -	local ret
> -	local output
> -
> -	output="$($cmd)"
> -	# it the command fails, return error right away
> -	ret=$?
> -	if [[ $ret -ne 0 ]]; then
> -		return $ret
> -	fi
> -	output=$(echo $output | jq -r $jq_opts "$jq_exp")
> -	ret=$?
> -	if [[ $ret -ne 0 ]]; then
> -		return $ret
> -	fi
> -	echo $output
> -	# return success only in case of non-empty output
> -	[ ! -z "$output" ]
> -}
> -
>  pre_cleanup()
>  {
>  	if [ "${PAUSE_ON_CLEANUP}" = "yes" ]; then
> diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
> index 006fdadcc4b9..4c278829e04c 100644
> --- a/tools/testing/selftests/net/lib.sh
> +++ b/tools/testing/selftests/net/lib.sh
> @@ -616,3 +616,27 @@ wait_local_port_listen()
>  		sleep 0.1
>  	done
>  }
> +
> +cmd_jq()
> +{
> +	local cmd=$1
> +	local jq_exp=$2
> +	local jq_opts=$3
> +	local ret
> +	local output
> +
> +	output="$($cmd)"
> +	# it the command fails, return error right away
> +	ret=$?
> +	if [[ $ret -ne 0 ]]; then
> +		return $ret
> +	fi
> +	output=$(echo $output | jq -r $jq_opts "$jq_exp")
> +	ret=$?
> +	if [[ $ret -ne 0 ]]; then
> +		return $ret
> +	fi
> +	echo $output
> +	# return success only in case of non-empty output
> +	[ ! -z "$output" ]
> +}
> -- 
> 2.46.0
> 

