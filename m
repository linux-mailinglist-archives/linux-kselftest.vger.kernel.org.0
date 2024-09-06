Return-Path: <linux-kselftest+bounces-17404-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8BD96F867
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 17:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34E21B22414
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 15:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02591D364E;
	Fri,  6 Sep 2024 15:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKVdcKMw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41D01D318F;
	Fri,  6 Sep 2024 15:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725636990; cv=none; b=rYo2qsau66bQHaiibZLcum2d9CtrqQxpA4QECoYtS5jTFtE1fGjSOxUUO3t6ZiPCS3J5tR334klNJCZ9WGy1MW16A8wFj6CsnLT7Fnhmzg4mpk3YmXif06h4L9YY9BqtpZTPnJcKrMgoaRktve+f/+JDVKi0yp5dtH5zaW/bj0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725636990; c=relaxed/simple;
	bh=d3kF/aNmEm/24uRuAMCcYfvowrJWElTHCOLo3RSY09o=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=rM2feH4kyDZ+Qfpz50a9KeI4ImHMoe5aiPJUo/Kfv3zeR/srrzhh8a5TWq/y/9FZfZ1qvfu8jXRcl2SxBSXFQd0yEQbmBJItQ27IJh2UAPdWvmUFnLTD5NzlIwtkTesadusL10EQxLJoRhsVHgp116vzZf/oRRSyyLh7lT9ad9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKVdcKMw; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6c359c1a2fdso11979056d6.2;
        Fri, 06 Sep 2024 08:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725636987; x=1726241787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4s96N4/JMkBfFDDKCyQikDh6zmKZTsXXe4Z7qd5yv8=;
        b=GKVdcKMwSlEkCVC9ky6qU5J+PtvqJ0Nezoy1SPJxDmpWBJjbaXa0MfJOaBp0RdEfa+
         ifwhYWxHodzwJVH6DgwD7+4j2NmPjY07W8FM+UCPUl269K1UbUcmDUNvN47dc33CfAA5
         jq3U0KHQgS5zcYskuBi2lfOghyU/HJKsVQJRB2TGsLJsWl/YqivE2tIri7jAVhzDCryZ
         rbqOnOABlcj2HkNdHNrMhf1oFs3MLUsd+qoJjdr2AWB105597kbNklNeFb2XZw5THaJ3
         7MY4t0zZiiHzdFFn3CqMreRjlJ4RiRP4ErfWJxh4GLVUGf5MOa/A/5kWV+YDKJOVaZyY
         oQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725636987; x=1726241787;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M4s96N4/JMkBfFDDKCyQikDh6zmKZTsXXe4Z7qd5yv8=;
        b=qoZSkUKesaeequ+cgcyRFmXEroJGDvv4sCHaYHMz7pwdlEgNQCs7KeiAlR10zJtr2c
         /csZTRpyJ05LX/tZW4aR22EoJkqgd8jiqAlH+QepTABH4VI4TwG0IVMjPM6DCGsnolOH
         RZSO7m4S9gGVgfpf+Lc00trd9x4vr88q3P2HRj4xIknj2ac/WaXdJ0M9T/XlwGTCXu6d
         snYcowDPAOON4NkHX1G0uHgspBbN1Y/MppdJZYLmJpzueKcA0pvqf6Ky/A5xcSRBJbES
         ntZb09d6ucx9dYsRy1NuJp3XJbPupXFqe8nvD/NIwABMen+s6dpXXfl5xsEBMmjIwhro
         4qfg==
X-Forwarded-Encrypted: i=1; AJvYcCU8AFPTnppC2/KW9fct4dBmZ9nUvSCK66yZ4JP2uVGE7gn1s6fheXNARPwgRgT5t5zcpGwXK2zXMvFwGyovJkc=@vger.kernel.org, AJvYcCVxAt2Y039PYsReOZ7aZ1At2JOzY4Ov42bMHL/mDg4VqU+wcj86NThBKZupYimjkyoP63gVSaU1@vger.kernel.org
X-Gm-Message-State: AOJu0YxIq4sEcMv44ozUnRPPgZfgFSdJTpJPcBi6XIneRQBnFwXVv8KS
	4RK5qvJX0BiC7AWLKc50uq+Zu09TOipRv/05dJuhTy83F3AYwI6S
X-Google-Smtp-Source: AGHT+IFJ3Mrk7czsoZyAjicaKLg0CHPuXzikuTJsncVpLLbd5HtB0qxccp+m/z7CpNByDeARBUv9qw==
X-Received: by 2002:a05:6214:54c9:b0:6c3:69e9:9a9a with SMTP id 6a1803df08f44-6c528509e17mr31503746d6.36.1725636987325;
        Fri, 06 Sep 2024 08:36:27 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c5201e4141sm17575036d6.34.2024.09.06.08.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 08:36:26 -0700 (PDT)
Date: Fri, 06 Sep 2024 11:36:26 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 ncardwell@google.com, 
 shuah@kernel.org, 
 linux-kselftest@vger.kernel.org, 
 fw@strlen.de, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <66db217a558c4_29a385294d3@willemb.c.googlers.com.notmuch>
In-Reply-To: <f63e7367-c4fb-4cdc-a44c-6accbc309c5a@kernel.org>
References: <20240905231653.2427327-1-willemdebruijn.kernel@gmail.com>
 <20240905231653.2427327-3-willemdebruijn.kernel@gmail.com>
 <f63e7367-c4fb-4cdc-a44c-6accbc309c5a@kernel.org>
Subject: Re: [PATCH net-next v2 2/2] selftests/net: integrate packetdrill with
 ksft
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Matthieu Baerts wrote:
> Hi Willem,
> 
> On 06/09/2024 01:15, Willem de Bruijn wrote:
> > From: Willem de Bruijn <willemb@google.com>
> > 
> > Lay the groundwork to import into kselftests the over 150 packetdrill
> > TCP/IP conformance tests on github.com/google/packetdrill.
> > 
> > Florian recently added support for packetdrill tests in nf_conntrack,
> > in commit a8a388c2aae49 ("selftests: netfilter: add packetdrill based
> > conntrack tests").
> > 
> > This patch takes a slightly different approach. It relies on
> > ksft_runner.sh to run every *.pkt file in the directory.
> 
> Thank you for adding this support! I'm looking forward to seeing more
> packetdrill tests being validated by the CI, and I hope that will
> encourage people to add more tests, and increase the code coverage!

Thanks for taking a look and your feedback.

> I have some questions about how the packetdrill should be executed:
> should they be isolated in dedicated netns?

Yes. The runner decides that, by passing -n 
 
> There are some other comments, but feel free to ignore them if they are
> not relevant, or if they can be fixed later.
> 
> > Tested:
> > 	make -C tools/testing/selftests \
> > 	  TARGETS=net/packetdrill \
> > 	  run_tests
> 
> Please note that this will not run the packetdrill tests in a dedicated
> netns. I don't think that's a good idea. Especially when sysctl knobs
> are being changed during the tests, and more.
> 
> > 	make -C tools/testing/selftests \
> > 	  TARGETS=net/packetdrill \
> > 	  install INSTALL_PATH=$KSFT_INSTALL_PATH
> > 
> > 	# in virtme-ng
> > 	./run_kselftest.sh -c net/packetdrill
> > 	./run_kselftest.sh -t net/packetdrill:tcp_inq_client.pkt
> 
> I see that ./run_kselftest.sh can be executed with the "-n | --netns"
> option to run each test in a dedicated net namespace, but it doesn't
> seem to work:
> 
> > # ./run_kselftest.sh -n -c net/packetdrill
> > [  411.087208] kselftest: Running tests in net/packetdrill
> > TAP version 13
> > 1..3
> > Cannot open network namespace "tcp_inq_client.pkt-TaQ8iN": No such file or directory
> > setting the network namespace "tcp_inq_server.pkt-sW8YCz" failed: Invalid argument
> > Cannot open network namespace "tcp_md5_md5-only-on-client-ack.pkt-YzJal6": No such file or directory

Ah, I guess this requires adding CONFIG_NET_NS=y to
tools/testing/selftests/net/packetdrill/config
 
> But maybe it would be better to create the netns in ksft_runner.sh?
> Please see below.

No, we opted for this design exactly to use existing kselftest infra,
rather than reimplementing that in our wrapper, as I did in the RFC.

> (...)
> 
> > diff --git a/tools/testing/selftests/net/packetdrill/defaults.sh b/tools/testing/selftests/net/packetdrill/defaults.sh
> > new file mode 100755
> > index 0000000000000..1095a7b22f44d
> > --- /dev/null
> > +++ b/tools/testing/selftests/net/packetdrill/defaults.sh
> > @@ -0,0 +1,63 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Set standard production config values that relate to TCP behavior.
> > +
> > +# Flush old cached data (fastopen cookies).
> > +ip tcp_metrics flush all > /dev/null 2>&1
> 
> (Why ignoring errors if any?)

I don't know. Just importing this verbatim from github.
As that is debugged over a long time and proven to work.

> 
> > +# TCP min, default, and max receive and send buffer sizes.
> > +sysctl -q net.ipv4.tcp_rmem="4096 540000 $((15*1024*1024))"
> > +sysctl -q net.ipv4.tcp_wmem="4096 $((256*1024)) 4194304"
> > +
> > +# TCP timestamps.
> > +sysctl -q net.ipv4.tcp_timestamps=1
> > +
> > +# TCP SYN(ACK) retry thresholds
> > +sysctl -q net.ipv4.tcp_syn_retries=5
> > +sysctl -q net.ipv4.tcp_synack_retries=5
> > +
> > +# TCP Forward RTO-Recovery, RFC 5682.
> > +sysctl -q net.ipv4.tcp_frto=2
> > +
> > +# TCP Selective Acknowledgements (SACK)
> > +sysctl -q net.ipv4.tcp_sack=1
> > +
> > +# TCP Duplicate Selective Acknowledgements (DSACK)
> > +sysctl -q net.ipv4.tcp_dsack=1
> > +
> > +# TCP FACK (Forward Acknowldgement)
> > +sysctl -q net.ipv4.tcp_fack=0
> > +
> > +# TCP reordering degree ("dupthresh" threshold for entering Fast Recovery).
> > +sysctl -q net.ipv4.tcp_reordering=3
> > +
> > +# TCP congestion control.
> > +sysctl -q net.ipv4.tcp_congestion_control=cubic
> 
> (maybe safer to add CONFIG_TCP_CONG_CUBIC=y?)

Ack, thanks. Also below.
 
> > +
> > +# TCP slow start after idle.
> > +sysctl -q net.ipv4.tcp_slow_start_after_idle=0
> > +
> > +# TCP RACK and TLP.
> > +sysctl -q net.ipv4.tcp_early_retrans=4 net.ipv4.tcp_recovery=1
> > +
> > +# TCP method for deciding when to defer sending to accumulate big TSO packets.
> > +sysctl -q net.ipv4.tcp_tso_win_divisor=3
> > +
> > +# TCP Explicit Congestion Notification (ECN)
> > +sysctl -q net.ipv4.tcp_ecn=0
> > +
> > +sysctl -q net.ipv4.tcp_pacing_ss_ratio=200
> > +sysctl -q net.ipv4.tcp_pacing_ca_ratio=120
> > +sysctl -q net.ipv4.tcp_notsent_lowat=4294967295 > /dev/null 2>&1
> > +
> > +sysctl -q net.ipv4.tcp_fastopen=0x70403
> > +sysctl -q net.ipv4.tcp_fastopen_key=a1a1a1a1-b2b2b2b2-c3c3c3c3-d4d4d4d4
> > +
> > +sysctl -q net.ipv4.tcp_syncookies=1
> 
> (maybe safer to add CONFIG_SYN_COOKIES=y?)
> 
> > +# Override the default qdisc on the tun device.
> > +# Many tests fail with timing errors if the default
> > +# is FQ and that paces their flows.
> > +tc qdisc add dev tun0 root pfifo
> > +
> 
> (when applying your patches with 'b4 shazam', I got the following error,
> I guess it was due to this blank line at the end)
> 
>   Applying: selftests: support interpreted scripts with ksft_runner.sh
>   Applying: selftests/net: integrate packetdrill with ksft
>   .git/rebase-apply/patch:142: new blank line at EOF.
> 
> 
> > diff --git a/tools/testing/selftests/net/packetdrill/ksft_runner.sh b/tools/testing/selftests/net/packetdrill/ksft_runner.sh
> > new file mode 100755
> > index 0000000000000..2f62caccbbbc5
> > --- /dev/null
> > +++ b/tools/testing/selftests/net/packetdrill/ksft_runner.sh
> > @@ -0,0 +1,41 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +source "$(dirname $(realpath $0))/../../kselftest/ktap_helpers.sh"
> > +
> > +readonly ipv4_args=('--ip_version=ipv4 '
> > +		    '--local_ip=192.168.0.1 '
> > +		    '--gateway_ip=192.168.0.1 '
> > +		    '--netmask_ip=255.255.0.0 '
> > +		    '--remote_ip=192.0.2.1 '
> > +		    '-D CMSG_LEVEL_IP=SOL_IP '
> > +		    '-D CMSG_TYPE_RECVERR=IP_RECVERR ')
> > +
> > +readonly ipv6_args=('--ip_version=ipv6 '
> > +		    '--mtu=1520 '
> > +		    '--local_ip=fd3d:0a0b:17d6::1 '
> > +		    '--gateway_ip=fd3d:0a0b:17d6:8888::1 '
> > +		    '--remote_ip=fd3d:fa7b:d17d::1 '
> > +		    '-D CMSG_LEVEL_IP=SOL_IPV6 '
> > +		    '-D CMSG_TYPE_RECVERR=IPV6_RECVERR ')
> 
> (nit: that's a strange Bash array with spaces in the strings :)
> You can simply remove the quotes, then below, you can use the variable
> with double quotes: "${ipv4_args[@]}" and shellcheck will stop reporting
> an error for that)

Thanks!
 
> > +
> > +if [ $# -ne 1 ]; then
> > +	ktap_exit_fail_msg "usage: $0 <script>"
> > +	exit "$KSFT_FAIL"
> > +fi
> > +script="$1"
> > +
> > +if [ -z "$(which packetdrill)" ]; then
> > +	ktap_skip_all "packetdrill not found in PATH"
> > +	exit "$KSFT_SKIP"
> > +fi
> > +
> > +ktap_print_header
> > +ktap_set_plan 2
> > +
> > +packetdrill ${ipv4_args[@]} $(basename $script) > /dev/null \
> 
> (Why muting stdout? I see that the TCP MD5 test output lines from
> /proc/net/tcp*, is it why? Is this info useful? Or should it be removed
> from the test?)

Indeed that's why. If a test fails in automated testing we can run
manually to inspect such output.
 
> 
> > +	&& ktap_test_pass "ipv4" || ktap_test_fail "ipv4"
> > +packetdrill ${ipv6_args[@]} $(basename $script) > /dev/null \
> > +	&& ktap_test_pass "ipv6" || ktap_test_fail "ipv6"
> 
> Even if "run_kselftest.sh" creates dedicated netns before running this
> script (RUN_IN_NETNS=1), it looks like the tests in v4 and in v6 will
> share the same netns. Is it OK? It means that if a packetdrill test sets
> something that is not reset by 'defaults.sh', it might break the
> following v6 test.

That should be fine. If a test cares about a sysctl, then it needs to
set it at the start. In this case, they both will set exactly the same
anyway.

> Why not having "ksft_runner.sh" creating the netns? It should be easy to
> do so, using helpers from the "../lib.sh" file:

See above.

>   ns_v4=
>   ns_v6=
> 
>   trap cleanup_all_ns EXIT
>   if ! setup_ns ns_v4 ns_v6; then
>       (...) # fail + exit
>   fi
> 
>   ip netns exec "${ns_v4}" packetdrill "${ipv4_args[@]}" \
>                                        "$(basename "${script}")"
>   (...)
> 
> 
> (Note that if these tests are isolated in dedicated netns, and if later
> we want to accelerate their execution, it should be easy to run these
> two tests in parallel, something like the following)
> 
>   ip netns exec "${ns_v4}" (...) &
>   pid_v4=$!
>   ip netns exec "${ns_v6}" (...) &
>   pid_v6=$!
> 
>   wait ${pid_v4} && tap_test_pass "ipv4" || ktap_test_fail "ipv4"
>   wait ${pid_v6} && tap_test_pass "ipv6" || ktap_test_fail "ipv6"
> 
> > +
> > +ktap_finished
> > diff --git a/tools/testing/selftests/net/packetdrill/tcp_inq_client.pkt b/tools/testing/selftests/net/packetdrill/tcp_inq_client.pkt
> > new file mode 100644
> > index 0000000000000..df49c67645ac8
> > --- /dev/null
> > +++ b/tools/testing/selftests/net/packetdrill/tcp_inq_client.pkt
> > @@ -0,0 +1,51 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Test TCP_INQ and TCP_CM_INQ on the client side.
> > +`./defaults.sh
> > +`
> (I guess you prefer not to modify these tests, and keep them
> self-contained, but just in case it is easier for you, this line could
> be removed, and have ksft_runner.sh sourcing this file before executing
> the packetdrill test.)

Future packetdrill tests can have different shell preambles. Let's
indeed leave it to the tests themselves.
 
> 
> Cheers,
> Matt
> -- 
> Sponsored by the NGI0 Core fund.
> 



