Return-Path: <linux-kselftest+bounces-17389-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D7496F353
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 13:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60AAF289DAB
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 11:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4271CB33F;
	Fri,  6 Sep 2024 11:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vu4oGVhA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C621CB154;
	Fri,  6 Sep 2024 11:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725622995; cv=none; b=sPuEc3ABePFoDNBw09CXguGO7zgxYn9nJDUf3uoYS5RzR1Kgd+2j/2u4aHnOwZ3T/QoyTqtYTnk2T1Uyn9/jt7beIkrwE/wVfDPm04nxPJ4a6MFq6GWc5hm4s9d4Rked5uAvJQKGkeoiEXA+ocKJP78wqlReb5R132DO+PujHD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725622995; c=relaxed/simple;
	bh=GQ6YdvCZme06vhkOo8sRla90Q3CXAXY0sjM6ki6RoGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rkWcIR4PG4p5lh3Gc50ygNGIxq5F1aJND/WULCGpl9hY7UyRMkQIIhA0OLMX7RClR2LrrQPta4JSaU4QR1ip5QT8mmT2s/uv3jIDRDfwpyh/EeJSzS3DF+vDD+5xaDlmuMp3KkzvGsd+a0bqsHts1wHCkR4tbqyv9ULGy3tsmoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vu4oGVhA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C0AC4CEC4;
	Fri,  6 Sep 2024 11:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725622995;
	bh=GQ6YdvCZme06vhkOo8sRla90Q3CXAXY0sjM6ki6RoGo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Vu4oGVhA4wNM3sokZhMxwGcJvwNnXHx4MTtLCxXwbTq1c9ResNuOhxJlnmQdLk0cF
	 q7lH7ncIC52S2ZVK57gtttZjii5XAbfXZRhC3DlBsJVAr8VPQPiD/BvT2bwJErJmek
	 +qMGFiB0u+Pgf47B59LDhvseBxA8xdOohLidZj6h5cH9+Yrzhb2e69R+J4LPCA3BOO
	 XwbgmuQJk49pnum/XyudEB4cLm689bD3HkFZpvhH/RhWFhpQ+Ocng2DnSQWGR0VB15
	 UIAHXSPU2KZdK8wGkpl9/gCP7X+ekUCdLzQXLsDTjyJFTFCW6rbzXQqmxt/h0EL8j8
	 6M86Y4oYoFAqQ==
Message-ID: <f63e7367-c4fb-4cdc-a44c-6accbc309c5a@kernel.org>
Date: Fri, 6 Sep 2024 13:43:10 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next v2 2/2] selftests/net: integrate packetdrill with
 ksft
Content-Language: en-GB
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, ncardwell@google.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, fw@strlen.de,
 Willem de Bruijn <willemb@google.com>
References: <20240905231653.2427327-1-willemdebruijn.kernel@gmail.com>
 <20240905231653.2427327-3-willemdebruijn.kernel@gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20240905231653.2427327-3-willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Willem,

On 06/09/2024 01:15, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Lay the groundwork to import into kselftests the over 150 packetdrill
> TCP/IP conformance tests on github.com/google/packetdrill.
> 
> Florian recently added support for packetdrill tests in nf_conntrack,
> in commit a8a388c2aae49 ("selftests: netfilter: add packetdrill based
> conntrack tests").
> 
> This patch takes a slightly different approach. It relies on
> ksft_runner.sh to run every *.pkt file in the directory.

Thank you for adding this support! I'm looking forward to seeing more
packetdrill tests being validated by the CI, and I hope that will
encourage people to add more tests, and increase the code coverage!


I have some questions about how the packetdrill should be executed:
should they be isolated in dedicated netns?

There are some other comments, but feel free to ignore them if they are
not relevant, or if they can be fixed later.

> Tested:
> 	make -C tools/testing/selftests \
> 	  TARGETS=net/packetdrill \
> 	  run_tests

Please note that this will not run the packetdrill tests in a dedicated
netns. I don't think that's a good idea. Especially when sysctl knobs
are being changed during the tests, and more.

> 	make -C tools/testing/selftests \
> 	  TARGETS=net/packetdrill \
> 	  install INSTALL_PATH=$KSFT_INSTALL_PATH
> 
> 	# in virtme-ng
> 	./run_kselftest.sh -c net/packetdrill
> 	./run_kselftest.sh -t net/packetdrill:tcp_inq_client.pkt

I see that ./run_kselftest.sh can be executed with the "-n | --netns"
option to run each test in a dedicated net namespace, but it doesn't
seem to work:

> # ./run_kselftest.sh -n -c net/packetdrill
> [  411.087208] kselftest: Running tests in net/packetdrill
> TAP version 13
> 1..3
> Cannot open network namespace "tcp_inq_client.pkt-TaQ8iN": No such file or directory
> setting the network namespace "tcp_inq_server.pkt-sW8YCz" failed: Invalid argument
> Cannot open network namespace "tcp_md5_md5-only-on-client-ack.pkt-YzJal6": No such file or directory

But maybe it would be better to create the netns in ksft_runner.sh?
Please see below.

(...)

> diff --git a/tools/testing/selftests/net/packetdrill/defaults.sh b/tools/testing/selftests/net/packetdrill/defaults.sh
> new file mode 100755
> index 0000000000000..1095a7b22f44d
> --- /dev/null
> +++ b/tools/testing/selftests/net/packetdrill/defaults.sh
> @@ -0,0 +1,63 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Set standard production config values that relate to TCP behavior.
> +
> +# Flush old cached data (fastopen cookies).
> +ip tcp_metrics flush all > /dev/null 2>&1

(Why ignoring errors if any?)

> +# TCP min, default, and max receive and send buffer sizes.
> +sysctl -q net.ipv4.tcp_rmem="4096 540000 $((15*1024*1024))"
> +sysctl -q net.ipv4.tcp_wmem="4096 $((256*1024)) 4194304"
> +
> +# TCP timestamps.
> +sysctl -q net.ipv4.tcp_timestamps=1
> +
> +# TCP SYN(ACK) retry thresholds
> +sysctl -q net.ipv4.tcp_syn_retries=5
> +sysctl -q net.ipv4.tcp_synack_retries=5
> +
> +# TCP Forward RTO-Recovery, RFC 5682.
> +sysctl -q net.ipv4.tcp_frto=2
> +
> +# TCP Selective Acknowledgements (SACK)
> +sysctl -q net.ipv4.tcp_sack=1
> +
> +# TCP Duplicate Selective Acknowledgements (DSACK)
> +sysctl -q net.ipv4.tcp_dsack=1
> +
> +# TCP FACK (Forward Acknowldgement)
> +sysctl -q net.ipv4.tcp_fack=0
> +
> +# TCP reordering degree ("dupthresh" threshold for entering Fast Recovery).
> +sysctl -q net.ipv4.tcp_reordering=3
> +
> +# TCP congestion control.
> +sysctl -q net.ipv4.tcp_congestion_control=cubic

(maybe safer to add CONFIG_TCP_CONG_CUBIC=y?)

> +
> +# TCP slow start after idle.
> +sysctl -q net.ipv4.tcp_slow_start_after_idle=0
> +
> +# TCP RACK and TLP.
> +sysctl -q net.ipv4.tcp_early_retrans=4 net.ipv4.tcp_recovery=1
> +
> +# TCP method for deciding when to defer sending to accumulate big TSO packets.
> +sysctl -q net.ipv4.tcp_tso_win_divisor=3
> +
> +# TCP Explicit Congestion Notification (ECN)
> +sysctl -q net.ipv4.tcp_ecn=0
> +
> +sysctl -q net.ipv4.tcp_pacing_ss_ratio=200
> +sysctl -q net.ipv4.tcp_pacing_ca_ratio=120
> +sysctl -q net.ipv4.tcp_notsent_lowat=4294967295 > /dev/null 2>&1
> +
> +sysctl -q net.ipv4.tcp_fastopen=0x70403
> +sysctl -q net.ipv4.tcp_fastopen_key=a1a1a1a1-b2b2b2b2-c3c3c3c3-d4d4d4d4
> +
> +sysctl -q net.ipv4.tcp_syncookies=1

(maybe safer to add CONFIG_SYN_COOKIES=y?)

> +# Override the default qdisc on the tun device.
> +# Many tests fail with timing errors if the default
> +# is FQ and that paces their flows.
> +tc qdisc add dev tun0 root pfifo
> +

(when applying your patches with 'b4 shazam', I got the following error,
I guess it was due to this blank line at the end)

  Applying: selftests: support interpreted scripts with ksft_runner.sh
  Applying: selftests/net: integrate packetdrill with ksft
  .git/rebase-apply/patch:142: new blank line at EOF.


> diff --git a/tools/testing/selftests/net/packetdrill/ksft_runner.sh b/tools/testing/selftests/net/packetdrill/ksft_runner.sh
> new file mode 100755
> index 0000000000000..2f62caccbbbc5
> --- /dev/null
> +++ b/tools/testing/selftests/net/packetdrill/ksft_runner.sh
> @@ -0,0 +1,41 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +source "$(dirname $(realpath $0))/../../kselftest/ktap_helpers.sh"
> +
> +readonly ipv4_args=('--ip_version=ipv4 '
> +		    '--local_ip=192.168.0.1 '
> +		    '--gateway_ip=192.168.0.1 '
> +		    '--netmask_ip=255.255.0.0 '
> +		    '--remote_ip=192.0.2.1 '
> +		    '-D CMSG_LEVEL_IP=SOL_IP '
> +		    '-D CMSG_TYPE_RECVERR=IP_RECVERR ')
> +
> +readonly ipv6_args=('--ip_version=ipv6 '
> +		    '--mtu=1520 '
> +		    '--local_ip=fd3d:0a0b:17d6::1 '
> +		    '--gateway_ip=fd3d:0a0b:17d6:8888::1 '
> +		    '--remote_ip=fd3d:fa7b:d17d::1 '
> +		    '-D CMSG_LEVEL_IP=SOL_IPV6 '
> +		    '-D CMSG_TYPE_RECVERR=IPV6_RECVERR ')

(nit: that's a strange Bash array with spaces in the strings :)
You can simply remove the quotes, then below, you can use the variable
with double quotes: "${ipv4_args[@]}" and shellcheck will stop reporting
an error for that)

> +
> +if [ $# -ne 1 ]; then
> +	ktap_exit_fail_msg "usage: $0 <script>"
> +	exit "$KSFT_FAIL"
> +fi
> +script="$1"
> +
> +if [ -z "$(which packetdrill)" ]; then
> +	ktap_skip_all "packetdrill not found in PATH"
> +	exit "$KSFT_SKIP"
> +fi
> +
> +ktap_print_header
> +ktap_set_plan 2
> +
> +packetdrill ${ipv4_args[@]} $(basename $script) > /dev/null \

(Why muting stdout? I see that the TCP MD5 test output lines from
/proc/net/tcp*, is it why? Is this info useful? Or should it be removed
from the test?)


> +	&& ktap_test_pass "ipv4" || ktap_test_fail "ipv4"
> +packetdrill ${ipv6_args[@]} $(basename $script) > /dev/null \
> +	&& ktap_test_pass "ipv6" || ktap_test_fail "ipv6"

Even if "run_kselftest.sh" creates dedicated netns before running this
script (RUN_IN_NETNS=1), it looks like the tests in v4 and in v6 will
share the same netns. Is it OK? It means that if a packetdrill test sets
something that is not reset by 'defaults.sh', it might break the
following v6 test.

Why not having "ksft_runner.sh" creating the netns? It should be easy to
do so, using helpers from the "../lib.sh" file:

  ns_v4=
  ns_v6=

  trap cleanup_all_ns EXIT
  if ! setup_ns ns_v4 ns_v6; then
      (...) # fail + exit
  fi

  ip netns exec "${ns_v4}" packetdrill "${ipv4_args[@]}" \
                                       "$(basename "${script}")"
  (...)


(Note that if these tests are isolated in dedicated netns, and if later
we want to accelerate their execution, it should be easy to run these
two tests in parallel, something like the following)

  ip netns exec "${ns_v4}" (...) &
  pid_v4=$!
  ip netns exec "${ns_v6}" (...) &
  pid_v6=$!

  wait ${pid_v4} && tap_test_pass "ipv4" || ktap_test_fail "ipv4"
  wait ${pid_v6} && tap_test_pass "ipv6" || ktap_test_fail "ipv6"

> +
> +ktap_finished
> diff --git a/tools/testing/selftests/net/packetdrill/tcp_inq_client.pkt b/tools/testing/selftests/net/packetdrill/tcp_inq_client.pkt
> new file mode 100644
> index 0000000000000..df49c67645ac8
> --- /dev/null
> +++ b/tools/testing/selftests/net/packetdrill/tcp_inq_client.pkt
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Test TCP_INQ and TCP_CM_INQ on the client side.
> +`./defaults.sh
> +`
(I guess you prefer not to modify these tests, and keep them
self-contained, but just in case it is easier for you, this line could
be removed, and have ksft_runner.sh sourcing this file before executing
the packetdrill test.)


Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


