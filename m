Return-Path: <linux-kselftest+bounces-502-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A27F7F6F83
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 10:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ACDA1C20B06
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Nov 2023 09:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D64BCA74;
	Fri, 24 Nov 2023 09:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcNMmIBS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E558D46;
	Fri, 24 Nov 2023 01:27:53 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5c2139492d9so1091634a12.0;
        Fri, 24 Nov 2023 01:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700818072; x=1701422872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=08TyyyR4Y0mFzmW5qWREvNnpyQq7Y6bXyj+Ypqof5Ro=;
        b=dcNMmIBS28e5Ca7m55dfpAtZpzyi2EyTSYOugN8BjQY5kBm10+ehYNfAetD21IpBT4
         dYojIvjJkIqvgB5TYNNFRXhVn03TzP5y5kVUPEosvU/j8s1yejo2DYTzbvfSFC0Wzxd1
         D14xnrbiUQ8RQBGfkZOw850o0svO9zPZwPc0CUW+mm+Hrr/UQF+xnb5VcpAq+0udAtBT
         EKuDAZQDNNNteJsDC9AN6gM/QBxC5+QdM5Mtjl7xTM1drji90iKWbNBnxZAFOdMXzO99
         gyZf7fjC+2yAclLvDmbXT8EqpAfQAQsfCy60pjK/BbfFj84zYiioqkyIgyhN6Hc6YJ6S
         p62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700818072; x=1701422872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=08TyyyR4Y0mFzmW5qWREvNnpyQq7Y6bXyj+Ypqof5Ro=;
        b=X4SoG3Qcp2IywZ+HuoweRQZYEjrNRa6sYY+D642r5rM1qcu0VAJUNAzD2XzGM7c21l
         L7vQAZTr91XtwQbiSF7zafDDOiLSyJMxGKgyiQIJfOkW/vzqB9neoKgp4IlYxgvVWUxL
         xLMS30G9DmhqySVjXk6d0BXN/z8YR0o00+clrf9l86DGw8L4wQIAmmjolwRJlf3A8ATM
         5WgIiyC/8qI0k6/1RdSPIRbBcbXN7TofUDGzpl6Zz5XCiHiJR8JRZ2YcI5y1ysM8x6lE
         2vkAIaASWcmInLTnqxNijVQKFKUKeK/fqr15lMXP3RV6FzqlqeJs46o1pUY6qqaSD1si
         jKHw==
X-Gm-Message-State: AOJu0YyNjr/X5wPVicVdJOgcv8xN0W7wZ/qCT5sr32K4DiPPHM+lalug
	kPk9Z/7pKYe8i4KbXud1kI30TcYl0nHgvxXY
X-Google-Smtp-Source: AGHT+IHTKuXx1In518jaVlTWSkT4umIt/5+eSyON4kwy4VQRtnBX+eESfWnKM9xaJCzTkP/QLA9r5w==
X-Received: by 2002:a05:6a20:42a0:b0:17d:f127:d435 with SMTP id o32-20020a056a2042a000b0017df127d435mr2496571pzj.45.1700818072175;
        Fri, 24 Nov 2023 01:27:52 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o10-20020a170902d4ca00b001cfacc54674sm32679plg.106.2023.11.24.01.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:27:50 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Po-Hsu Lin <po-hsu.lin@canonical.com>,
	Guillaume Nault <gnault@redhat.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Brown <broonie@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 00/38] Conver all net selftests to run in unique namespace
Date: Fri, 24 Nov 2023 17:26:58 +0800
Message-ID: <20231124092736.3673263-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As Guillaume pointed, many selftests create namespaces with very common
names (like "client" or "server") or even (partially) run directly in init_net.
This makes these tests prone to failure if another namespace with the same
name already exists. It also makes it impossible to run several instances
of these tests in parallel.

This patch set conver all the net selftests to run in unique namespace,
so we can update the selftest freamwork to run all tests in it's own namespace
in parallel. After update, we only need to wait for the test which need
longest time.

]# per_test_logging=1 time ./run_kselftest.sh -n -c net
TAP version 13
# selftests: net: reuseport_bpf_numa
not ok 3 selftests: net: reuseport_bpf_numa # exit=1
# selftests: net: reuseport_bpf_cpu
not ok 2 selftests: net: reuseport_bpf_cpu # exit=1
# selftests: net: reuseport_dualstack
not ok 4 selftests: net: reuseport_dualstack # exit=1
# selftests: net: reuseaddr_conflict
ok 5 selftests: net: reuseaddr_conflict

...

# selftests: net: test_vxlan_mdb.sh
ok 90 selftests: net: test_vxlan_mdb.sh
# selftests: net: fib_nexthops.sh
not ok 41 selftests: net: fib_nexthops.sh # exit=1
# selftests: net: fcnal-test.sh
not ok 36 selftests: net: fcnal-test.sh # exit=1

real    55m1.238s
user    12m10.350s
sys     22m17.432s


Hangbin Liu (38):
  selftests/net: add lib.sh
  selftests/net: arp_ndisc_evict_nocarrier.sh convert to run test in
    unique namespace
  selftest: arp_ndisc_untracked_subnets.sh convert to run test in unique
    namespace
  selftests/net: convert cmsg tests to make them run in unique namespace
  selftests/net: convert drop_monitor_tests.sh to run it in unique
    namespace
  selftests/net: convert fcnal-test.sh to run it in unique namespace
  selftests/net: convert fib_nexthop_multiprefix to run it in unique
    namespace
  selftests/net: convert fib_nexthop_nongw.sh to run it in unique
    namespace
  selftests/net: convert fib_nexthops.sh to run it in unique namespace
  selftests/net: convert fib-onlink-tests.sh to run it in unique
    namespace
  selftests/net: convert fib_rule_tests.sh to run it in unique namespace
  selftests/net: convert fib_tests.sh to run it in unique namespace
  selftests/net: convert gre_gso.sh to run it in unique namespace
  selftests/net: convert icmp_redirect.sh to run it in unique namespace
  sleftests/net: convert icmp.sh to run it in unique namespace
  selftests/net: convert ioam6.sh to run it in unique namespace
  selftests/net: convert l2tp.sh to run it in unique namespace
  selftests/net: convert ndisc_unsolicited_na_test.sh to run it in
    unique namespace
  selftests/net: convert netns-name.sh to run it in unique namespace
  selftests/net: convert fdb_flush.sh to run it in unique namespace
  selftests/net: convert rtnetlink.sh to run it in unique namespace
  selftests/net: convert sctp_vrf.sh to run it in unique namespace
  selftests/net: use unique netns name for setup_loopback.sh
    setup_veth.sh
  selftests/net: convert stress_reuseport_listen.sh to run it in unique
    namespace
  selftests/net: convert test_bridge_backup_port.sh to run it in unique
    namespace
  selftests/net: convert test_bridge_neigh_suppress.sh to run it in
    unique namespace
  selftests/net: convert test_vxlan_mdb.sh to run it in unique namespace
  selftests/net: convert test_vxlan_nolocalbypass.sh to run it in unique
    namespace
  selftests/net: convert test_vxlan_under_vrf.sh to run it in unique
    namespace
  selftests/net: convert test_vxlan_vnifiltering.sh to run it in unique
    namespace
  selftests/net: convert toeplitz.sh to run it in unique namespace
  selftests/net: convert unicast_extensions.sh to run it in unique
    namespace
  selftests/net: convert vrf_route_leaking.sh to run it in unique
    namespace
  selftests/net: convert vrf_strict_mode_test.sh to run it in unique
    namespace
  selftests/net: convert vrf-xfrm-tests.sh to run it in unique namespace
  selftests/net: convert traceroute.sh to run it in unique namespace
  selftests/net: convert xfrm_policy.sh to run it in unique namespace
  kselftest/runner.sh: add netns support

 tools/testing/selftests/kselftest/runner.sh   |  26 +-
 tools/testing/selftests/net/Makefile          |   2 +-
 .../net/arp_ndisc_evict_nocarrier.sh          |  46 +--
 .../net/arp_ndisc_untracked_subnets.sh        |  18 +-
 tools/testing/selftests/net/cmsg_ipv6.sh      |  10 +-
 tools/testing/selftests/net/cmsg_so_mark.sh   |   7 +-
 tools/testing/selftests/net/cmsg_time.sh      |   7 +-
 .../selftests/net/drop_monitor_tests.sh       |  21 +-
 tools/testing/selftests/net/fcnal-test.sh     |  30 +-
 tools/testing/selftests/net/fdb_flush.sh      |  11 +-
 .../testing/selftests/net/fib-onlink-tests.sh |   7 +-
 .../selftests/net/fib_nexthop_multiprefix.sh  | 104 +++--
 .../selftests/net/fib_nexthop_nongw.sh        |  34 +-
 tools/testing/selftests/net/fib_nexthops.sh   | 142 ++++---
 tools/testing/selftests/net/fib_rule_tests.sh |  36 +-
 tools/testing/selftests/net/fib_tests.sh      | 184 +++++----
 tools/testing/selftests/net/gre_gso.sh        |  18 +-
 tools/testing/selftests/net/icmp.sh           |  10 +-
 tools/testing/selftests/net/icmp_redirect.sh  | 182 +++++----
 tools/testing/selftests/net/ioam6.sh          | 247 ++++++------
 tools/testing/selftests/net/l2tp.sh           | 130 +++----
 tools/testing/selftests/net/lib.sh            |  98 +++++
 .../net/ndisc_unsolicited_na_test.sh          |  19 +-
 tools/testing/selftests/net/netns-name.sh     |  44 +--
 tools/testing/selftests/net/rtnetlink.sh      |  21 +-
 tools/testing/selftests/net/sctp_vrf.sh       |  12 +-
 tools/testing/selftests/net/settings          |   2 +-
 tools/testing/selftests/net/setup_loopback.sh |   8 +-
 tools/testing/selftests/net/setup_veth.sh     |   9 +-
 .../selftests/net/stress_reuseport_listen.sh  |   6 +-
 .../selftests/net/test_bridge_backup_port.sh  | 368 +++++++++---------
 .../net/test_bridge_neigh_suppress.sh         | 333 ++++++++--------
 tools/testing/selftests/net/test_vxlan_mdb.sh | 202 +++++-----
 .../selftests/net/test_vxlan_nolocalbypass.sh |  48 ++-
 .../selftests/net/test_vxlan_under_vrf.sh     |  70 ++--
 .../selftests/net/test_vxlan_vnifiltering.sh  | 154 +++++---
 tools/testing/selftests/net/toeplitz.sh       |  16 +-
 tools/testing/selftests/net/traceroute.sh     |  82 ++--
 .../selftests/net/unicast_extensions.sh       |  99 +++--
 tools/testing/selftests/net/vrf-xfrm-tests.sh |  77 ++--
 .../selftests/net/vrf_route_leaking.sh        | 201 +++++-----
 .../selftests/net/vrf_strict_mode_test.sh     |  47 ++-
 tools/testing/selftests/net/xfrm_policy.sh    | 138 +++----
 tools/testing/selftests/run_kselftest.sh      |   4 +
 44 files changed, 1676 insertions(+), 1654 deletions(-)
 create mode 100644 tools/testing/selftests/net/lib.sh

-- 
2.41.0


