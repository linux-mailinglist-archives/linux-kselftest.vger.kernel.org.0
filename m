Return-Path: <linux-kselftest+bounces-1134-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C3B8053B3
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 13:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5EF41F2091B
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 12:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D799B59E54;
	Tue,  5 Dec 2023 12:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NeW4rZvQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF86AA7
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Dec 2023 04:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701777634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=20GQcsknLlOrAs8uFrXzeujlWSijSdYal/a04hZduK0=;
	b=NeW4rZvQGzIx83shYgxhGjj06sg3w4RRmag2LFM6vzPzisvZsrcEFBReekzhOOaJxrkrjO
	eetO9MQM6BLKXVTSDk/Mx0PVb8JnFndc79RAmDqDcJuEO19fx+b0U+WlcY+ng2obk7Ra1K
	oIuxBobWegpctPhmVAtlbD5XibyRjMQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-sCZtVW2POwWBSs9dMgyrSg-1; Tue, 05 Dec 2023 07:00:33 -0500
X-MC-Unique: sCZtVW2POwWBSs9dMgyrSg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5450c83aa5dso688546a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Dec 2023 04:00:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701777632; x=1702382432;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=20GQcsknLlOrAs8uFrXzeujlWSijSdYal/a04hZduK0=;
        b=meQxiB/JTvIGBDXc5zi0ZoDja45YtNILGMRUf1cQ7RvPSHu/3GnuWgaLsyy3L/z8C0
         woz0cycdD0r8usEvbVguU5OQ7fK0kaUUZyWUli1fI28ZpFb+C1S3FlfucYT13s9Z3ayh
         Tm0qyrbN62TCR5nmHrQykYmp7Ng8wGBWjXaSpyZ9DKD+ibHyf8kSyY7/7qXRJTvGgV5G
         04rpM1QpCKuaGP4QL9J5YzCrKZ6vGebTeUgpnr3+4PPgKHm+k/lp4kja9p5jnzsS7pki
         yWZbdGh8m8LABb2siLULdA5DEsUNcUx9PSJFTQB1mczeqCdQZ4F+TiXb50sjJfiqSPSC
         eH0g==
X-Gm-Message-State: AOJu0YwPYGXCoRKmSxH131ZHxII8jPqt9t+hqHWeZSxLmmOXTLRaEggd
	fC+1UvA04i5FOXEASe/o6yGHnJwAypViCzMh7CzLwAdUtCgPhpfgFh2Q6CwMifK07qjwEJL90Bf
	ih2RKo36MTz1wpQHp2Q/oreEcPDRN
X-Received: by 2002:a05:6402:430d:b0:54d:3838:490a with SMTP id m13-20020a056402430d00b0054d3838490amr816140edc.3.1701777632305;
        Tue, 05 Dec 2023 04:00:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9eONxd7d8LRO22GLsrViNctQNoTDf/CknACqwPnUGu/qVoAXLfeKj9F84EiNm67Wd5ElUDQ==
X-Received: by 2002:a05:6402:430d:b0:54d:3838:490a with SMTP id m13-20020a056402430d00b0054d3838490amr816096edc.3.1701777631716;
        Tue, 05 Dec 2023 04:00:31 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-241-54.dyn.eolo.it. [146.241.241.54])
        by smtp.gmail.com with ESMTPSA id n10-20020a056402060a00b0054c6a70a435sm986678edv.44.2023.12.05.04.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 04:00:31 -0800 (PST)
Message-ID: <7e73dbfe6cad7d551516d02bb02881d885045498.camel@redhat.com>
Subject: Re: [PATCHv3 net-next 01/14] selftests/net: add lib.sh
From: Paolo Abeni <pabeni@redhat.com>
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>,  Eric Dumazet <edumazet@google.com>, Shuah Khan
 <shuah@kernel.org>, David Ahern <dsahern@kernel.org>, 
 linux-kselftest@vger.kernel.org, Po-Hsu Lin <po-hsu.lin@canonical.com>, 
 Guillaume Nault <gnault@redhat.com>, Petr Machata <petrm@nvidia.com>, James
 Prestwood <prestwoj@gmail.com>,  Jaehee Park <jhpark1013@gmail.com>, Ido
 Schimmel <idosch@nvidia.com>, Justin Iurman <justin.iurman@uliege.be>, Xin
 Long <lucien.xin@gmail.com>, James Chapman <jchapman@katalix.com>
Date: Tue, 05 Dec 2023 13:00:29 +0100
In-Reply-To: <20231202020110.362433-2-liuhangbin@gmail.com>
References: <20231202020110.362433-1-liuhangbin@gmail.com>
	 <20231202020110.362433-2-liuhangbin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2023-12-02 at 10:00 +0800, Hangbin Liu wrote:
> Add a lib.sh for net selftests. This file can be used to define commonly
> used variables and functions. Some commonly used functions can be moved
> from forwarding/lib.sh to this lib file. e.g. busywait().
>=20
> Add function setup_ns() for user to create unique namespaces with given
> prefix name.
>=20
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  tools/testing/selftests/net/Makefile          |  2 +-
>  tools/testing/selftests/net/forwarding/lib.sh | 27 +-----
>  tools/testing/selftests/net/lib.sh            | 85 +++++++++++++++++++
>  3 files changed, 87 insertions(+), 27 deletions(-)
>  create mode 100644 tools/testing/selftests/net/lib.sh
>=20
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftes=
ts/net/Makefile
> index 9274edfb76ff..14bd68da7466 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -54,7 +54,7 @@ TEST_PROGS +=3D ip_local_port_range.sh
>  TEST_PROGS +=3D rps_default_mask.sh
>  TEST_PROGS +=3D big_tcp.sh
>  TEST_PROGS_EXTENDED :=3D in_netns.sh setup_loopback.sh setup_veth.sh
> -TEST_PROGS_EXTENDED +=3D toeplitz_client.sh toeplitz.sh
> +TEST_PROGS_EXTENDED +=3D toeplitz_client.sh toeplitz.sh lib.sh
>  TEST_GEN_FILES =3D  socket nettest
>  TEST_GEN_FILES +=3D psock_fanout psock_tpacket msg_zerocopy reuseport_ad=
dr_any
>  TEST_GEN_FILES +=3D tcp_mmap tcp_inq psock_snd txring_overwrite
> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testin=
g/selftests/net/forwarding/lib.sh
> index e37a15eda6c2..8f6ca458af9a 100755
> --- a/tools/testing/selftests/net/forwarding/lib.sh
> +++ b/tools/testing/selftests/net/forwarding/lib.sh
> @@ -4,9 +4,6 @@
>  ########################################################################=
######
>  # Defines
> =20
> -# Kselftest framework requirement - SKIP code is 4.
> -ksft_skip=3D4
> -
>  # Can be overridden by the configuration file.
>  PING=3D${PING:=3Dping}
>  PING6=3D${PING6:=3Dping6}
> @@ -41,6 +38,7 @@ if [[ -f $relative_path/forwarding.config ]]; then
>  	source "$relative_path/forwarding.config"
>  fi
> =20
> +source ../lib.sh
>  ########################################################################=
######
>  # Sanity checks
> =20
> @@ -395,29 +393,6 @@ log_info()
>  	echo "INFO: $msg"
>  }
> =20
> -busywait()
> -{
> -	local timeout=3D$1; shift
> -
> -	local start_time=3D"$(date -u +%s%3N)"
> -	while true
> -	do
> -		local out
> -		out=3D$("$@")
> -		local ret=3D$?
> -		if ((!ret)); then
> -			echo -n "$out"
> -			return 0
> -		fi
> -
> -		local current_time=3D"$(date -u +%s%3N)"
> -		if ((current_time - start_time > timeout)); then
> -			echo -n "$out"
> -			return 1
> -		fi
> -	done
> -}
> -
>  not()
>  {
>  	"$@"
> diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests=
/net/lib.sh
> new file mode 100644
> index 000000000000..518eca57b815
> --- /dev/null
> +++ b/tools/testing/selftests/net/lib.sh
> @@ -0,0 +1,85 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +########################################################################=
######
> +# Defines
> +
> +# Kselftest framework requirement - SKIP code is 4.
> +ksft_skip=3D4
> +
> +########################################################################=
######
> +# Helpers
> +busywait()
> +{
> +	local timeout=3D$1; shift
> +
> +	local start_time=3D"$(date -u +%s%3N)"
> +	while true
> +	do
> +		local out
> +		out=3D$("$@")
> +		local ret=3D$?
> +		if ((!ret)); then
> +			echo -n "$out"
> +			return 0
> +		fi
> +
> +		local current_time=3D"$(date -u +%s%3N)"
> +		if ((current_time - start_time > timeout)); then
> +			echo -n "$out"
> +			return 1
> +		fi
> +	done
> +}
> +
> +cleanup_ns()
> +{
> +	local ns=3D""
> +	local errexit=3D0
> +	local ret=3D0
> +
> +	# disable errexit temporary
> +	if [[ $- =3D~ "e" ]]; then
> +		errexit=3D1
> +		set +e
> +	fi
> +
> +	for ns in "$@"; do
> +		ip netns delete "${ns}" &> /dev/null
> +		if ! busywait 2 ip netns list \| grep -vq "^$ns$" &> /dev/null; then
> +			echo "Warn: Failed to remove namespace $ns"
> +			ret=3D1
> +		fi
> +	done
> +
> +	[ $errexit -eq 1 ] && set -e
> +	return $ret
> +}
> +
> +# setup netns with given names as prefix. e.g
> +# setup_ns local remote
> +setup_ns()
> +{
> +	local ns=3D""
> +	local ns_name=3D""
> +	local ns_list=3D""
> +	for ns_name in "$@"; do
> +		# Some test may setup/remove same netns multi times
> +		if unset ${ns_name} 2> /dev/null; then
> +			ns=3D"${ns_name,,}-$(mktemp -u XXXXXX)"
> +			eval readonly ${ns_name}=3D"$ns"
> +		else
> +			eval ns=3D'$'${ns_name}
> +			cleanup_ns "$ns"
> +
> +		fi
> +
> +		if ! ip netns add "$ns"; then
> +			echo "Failed to create namespace $ns_name"
> +			cleanup_ns "$ns_list"
> +			return $ksft_skip
> +		fi
> +		ip -n "$ns" link set lo up
> +		ns_list=3D"$ns_list $ns"

Side note for a possible follow-up: if you maintain $ns_list as global
variable, and remove from such list the ns deleted by cleanup_ns, you
could remove the cleanup trap from the individual test with something
alike:

final_cleanup_ns()
{
	cleanup_ns $ns_list
}

trap final_cleanup_ns EXIT

No respin needed for the above, could be a follow-up if agreed upon.

Cheers,

Paolo


