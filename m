Return-Path: <linux-kselftest+bounces-2644-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F89D824AEB
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jan 2024 23:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DE20B20EDD
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jan 2024 22:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4A921374;
	Thu,  4 Jan 2024 22:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNjrdFTI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08F42C6B7;
	Thu,  4 Jan 2024 22:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6d9af1f12d5so722632b3a.3;
        Thu, 04 Jan 2024 14:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704407752; x=1705012552; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bDHsAwed/XpRNyy0E5llCPUOO9YCKWu2OHs2Il7ljIE=;
        b=mNjrdFTInfsw4P+1SFPMH18DCGzLbfYKimtDaNvBLlCU3UMPisiFca6wd1qa6+vZAU
         DJbJoeBF3KN4/zbA6g4I9DfzEy7GNjvDLW2Hb/OvtchFetGFxgflJzAkMu4gFEAXHR7T
         qq6PiFDZ4BGu9F1CSh1J8jzv3MDQxzJQfYQa5EkKUvdTpDFBAohwIZZrD3XeuBzI+CYh
         m/9T5gMai0Jpno7Sn39TzInLluDo+AhUTddxZDdNFqud2fa5KG27X1o8Fod4gYgtS2Kn
         J24n+GC0hu1FUwcZb+Qx7yz+fcfj446UvWPf5wGijAPpoAVSqFieBGjEDiizLf++I+bG
         ZGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704407752; x=1705012552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDHsAwed/XpRNyy0E5llCPUOO9YCKWu2OHs2Il7ljIE=;
        b=W+NWtzQXUma79LbvITuRL3sV7bKHIdO0ScbL9D9UmPk3DNC3TsoUBUsCKL8+1TwApp
         q4vMb3HIHIYhPN8IXyJu9UFPghuJCCD5jO7/DvuK5KlJtNATg8TEUoY93V8HlDUvbLrb
         mPe7dSFYEGEs7I+dpigMP0CI5AqEyZ+yv+kuKqe7la4iJxRhCKo3fwb/x0FrIOEwtBvn
         c28RughDBs8vVuXdsW9nKYsXJu7xHN2RhKdNkRqlBYPacHq7W2vp5T7il7MxDR86RNVt
         +YJlYXbNMNZKlDY1SKRumAJl9D/h0CkOwRcEQCpxlJFNJdgiH1ShUoTFCTj7ruQonMjU
         IntQ==
X-Gm-Message-State: AOJu0YyHO2z7IyK8YWfreyyw38uM1E80wni84XnAhoc1K6qS9C45bIPY
	pl7aCtOGepqfta8bxHRatI0=
X-Google-Smtp-Source: AGHT+IG8LDbfaq3U7wAO5fPxPfaotSmtxf3M9TYq7XJjbRz64d8kUKnD5ECdl7O7hfmCpsfVRToQCA==
X-Received: by 2002:aa7:8709:0:b0:6d5:73b1:3cd4 with SMTP id b9-20020aa78709000000b006d573b13cd4mr1127897pfo.64.1704407751864;
        Thu, 04 Jan 2024 14:35:51 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id r12-20020aa78b8c000000b006d998f5b890sm152395pfd.192.2024.01.04.14.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 14:35:51 -0800 (PST)
Date: Fri, 5 Jan 2024 06:35:45 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Benjamin Poirier <bpoirier@nvidia.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: forwarding: Avoid failures to source
 net/lib.sh
Message-ID: <ZZcywXyDs6rL03Ok@Laptop-X1>
References: <20240104141109.100672-1-bpoirier@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104141109.100672-1-bpoirier@nvidia.com>

On Thu, Jan 04, 2024 at 09:11:09AM -0500, Benjamin Poirier wrote:
> The expression "source ../lib.sh" added to net/forwarding/lib.sh in commit
> 25ae948b4478 ("selftests/net: add lib.sh") does not work for tests outside
> net/forwarding which source net/forwarding/lib.sh (1). It also does not
> work in some cases where only a subset of tests are exported (2).
> 
> Avoid the problems mentioned above by replacing the faulty expression with
> a copy of the content from net/lib.sh which is used by files under
> net/forwarding.
> 
> A more thorough solution which avoids duplicating content between
> net/lib.sh and net/forwarding/lib.sh has been posted here:
> https://lore.kernel.org/netdev/20231222135836.992841-1-bpoirier@nvidia.com/
> 
> The approach in the current patch is a stopgap solution to avoid submitting
> large changes at the eleventh hour of this development cycle.
> 
> Example of problem 1)
> 
> tools/testing/selftests/drivers/net/bonding$ ./dev_addr_lists.sh
> ./net_forwarding_lib.sh: line 41: ../lib.sh: No such file or directory
> TEST: bonding cleanup mode active-backup                            [ OK ]
> TEST: bonding cleanup mode 802.3ad                                  [ OK ]
> TEST: bonding LACPDU multicast address to slave (from bond down)    [ OK ]
> TEST: bonding LACPDU multicast address to slave (from bond up)      [ OK ]
> 
> An error message is printed but since the test does not use functions from
> net/lib.sh, the test results are not affected.
> 
> Example of problem 2)
> 
> tools/testing/selftests$ make install TARGETS="net/forwarding"
> tools/testing/selftests$ cd kselftest_install/net/forwarding/
> tools/testing/selftests/kselftest_install/net/forwarding$ ./pedit_ip.sh veth{0..3}
> lib.sh: line 41: ../lib.sh: No such file or directory
> TEST: ping                                                          [ OK ]
> TEST: ping6                                                         [ OK ]
> ./pedit_ip.sh: line 135: busywait: command not found
> TEST: dev veth1 ingress pedit ip src set 198.51.100.1               [FAIL]
>         Expected to get 10 packets, but got .
> ./pedit_ip.sh: line 135: busywait: command not found
> TEST: dev veth2 egress pedit ip src set 198.51.100.1                [FAIL]
>         Expected to get 10 packets, but got .
> ./pedit_ip.sh: line 135: busywait: command not found
> TEST: dev veth1 ingress pedit ip dst set 198.51.100.1               [FAIL]
>         Expected to get 10 packets, but got .
> ./pedit_ip.sh: line 135: busywait: command not found
> TEST: dev veth2 egress pedit ip dst set 198.51.100.1                [FAIL]
>         Expected to get 10 packets, but got .
> ./pedit_ip.sh: line 135: busywait: command not found
> TEST: dev veth1 ingress pedit ip6 src set 2001:db8:2::1             [FAIL]
>         Expected to get 10 packets, but got .
> ./pedit_ip.sh: line 135: busywait: command not found
> TEST: dev veth2 egress pedit ip6 src set 2001:db8:2::1              [FAIL]
>         Expected to get 10 packets, but got .
> ./pedit_ip.sh: line 135: busywait: command not found
> TEST: dev veth1 ingress pedit ip6 dst set 2001:db8:2::1             [FAIL]
>         Expected to get 10 packets, but got .
> ./pedit_ip.sh: line 135: busywait: command not found
> TEST: dev veth2 egress pedit ip6 dst set 2001:db8:2::1              [FAIL]
>         Expected to get 10 packets, but got .
> 
> In this case, the test results are affected.
> 
> Fixes: 25ae948b4478 ("selftests/net: add lib.sh")
> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Suggested-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Tested-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
> ---
>  tools/testing/selftests/net/forwarding/lib.sh | 27 ++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> index 69ef2a40df21..8a61464ab6eb 100755
> --- a/tools/testing/selftests/net/forwarding/lib.sh
> +++ b/tools/testing/selftests/net/forwarding/lib.sh
> @@ -38,7 +38,32 @@ if [[ -f $relative_path/forwarding.config ]]; then
>  	source "$relative_path/forwarding.config"
>  fi
>  
> -source ../lib.sh
> +# Kselftest framework requirement - SKIP code is 4.
> +ksft_skip=4
> +
> +busywait()
> +{
> +	local timeout=$1; shift
> +
> +	local start_time="$(date -u +%s%3N)"
> +	while true
> +	do
> +		local out
> +		out=$("$@")
> +		local ret=$?
> +		if ((!ret)); then
> +			echo -n "$out"
> +			return 0
> +		fi
> +
> +		local current_time="$(date -u +%s%3N)"
> +		if ((current_time - start_time > timeout)); then
> +			echo -n "$out"
> +			return 1
> +		fi
> +	done
> +}
> +
>  ##############################################################################
>  # Sanity checks
>  

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

Thanks
Hangbin

