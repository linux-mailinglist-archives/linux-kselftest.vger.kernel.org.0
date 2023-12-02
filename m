Return-Path: <linux-kselftest+bounces-1003-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4F58019C5
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Dec 2023 03:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0574F2817A8
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Dec 2023 02:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205C21FA2;
	Sat,  2 Dec 2023 02:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enbmTjII"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD3A9D;
	Fri,  1 Dec 2023 18:01:20 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5d2d0661a8dso30862227b3.2;
        Fri, 01 Dec 2023 18:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701482479; x=1702087279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ETbMUJPdq3ZAibifRc15FxdQblP3OD10cIHFBChFvcs=;
        b=enbmTjIIqWq9QzlOzP8J7CbX6RmH0G6+Er3PaPUdR/6xDucmhVAVRSb9wFA6PbP9rw
         MbIoHsB+TzwuI1+9TlhW+yjRuOHUUuMIZNko+0yJvJ17rguxgH/ftEbQ33yCwa3g1ut7
         6ukYGDFITV+cOrDkBif8NjaA9Jxy5Qt/4cgSrE69WtgcT8Nj2Q2mUJicMTaLSsodh6Cd
         ecgv0z587QnxeFb/h0/Du9eIWMLKsMBPdqrob7lsifuj7nUtRpq3UWfbHhXbRbnrCjdC
         2ZiWj6QWYArv/J3vfNq8M5g7dfWYQf2S2bjsOiuf0gKmM6qRTQCUPB54xSHm4uYwxlJT
         5hSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701482479; x=1702087279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ETbMUJPdq3ZAibifRc15FxdQblP3OD10cIHFBChFvcs=;
        b=m/pb4JZ+QaQ+Y1MAeooJBh3puorvP/nR0mefnNLiznWODwmVzSAuk3DVQBviO8t50H
         pDSkOIlcP7uI2neUnbNUv/T8EgPjcMzCoYb6XML6mC2M8azXZplLFOeaq3sF7Q4pE647
         AajPjnd2jteP++9y2vomL5OTYqKzD0kJJpnEBH/VnuUf5lxr8VQn68EAGgmMpmpzLapn
         GcnBWF0g1IVZHH5jnAYHP6lcm31IQOLelu8SR5svuwXR9WVU6qlmgVSp1f7A2ygNKvHS
         WdFV0aXyUaXVesM0tekJpz4KajAip5GneFwKniYww9dwbMvGkqxsEBOGZlQ1R4/5RE38
         z80Q==
X-Gm-Message-State: AOJu0Yyl6uZizgNNjy9XLmbekPNEKSfwq8cNE0z7/umXm6qJXgYvSPl/
	UCZLeZ6OTk4/AyRpwEZcXccdAD904Tte7UXo
X-Google-Smtp-Source: AGHT+IEyJmYaYqrDmJ67q0QCLUiP4ltzy/kk955rdOlGK4mrlZ6iOvjAYsXspaILmVdLlVYoVcP7tA==
X-Received: by 2002:a81:ac52:0:b0:5d3:b951:6b12 with SMTP id z18-20020a81ac52000000b005d3b9516b12mr522172ywj.17.1701482479023;
        Fri, 01 Dec 2023 18:01:19 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id h1-20020a170902f54100b001b3bf8001a9sm3993034plf.48.2023.12.01.18.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 18:01:17 -0800 (PST)
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
	Petr Machata <petrm@nvidia.com>,
	James Prestwood <prestwoj@gmail.com>,
	Jaehee Park <jhpark1013@gmail.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Justin Iurman <justin.iurman@uliege.be>,
	Xin Long <lucien.xin@gmail.com>,
	James Chapman <jchapman@katalix.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net-next 00/14] Conver net selftests to run in unique namespace (Part 1)
Date: Sat,  2 Dec 2023 10:00:56 +0800
Message-ID: <20231202020110.362433-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
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

This patch set intend to conver all the net selftests to run in unique namespace,
so we can update the selftest freamwork to run all tests in it's own namespace
in parallel. After update, we only need to wait for the test which need
longest time.

As the total patch set is too large. I break it to severl parts. This is
the first part.

v2 -> v3:
- Convert all ip netns del to cleanup_ns (Justin Iurman)

v1 -> v2:
- Split the large patch set to small parts for easy review (Paolo Abeni)
- Move busywait from forwarding/lib.sh to net/lib.sh directly (Petr Machata)
- Update setup_ns/cleanup_ns struct (Petr Machata)
- Remove default trap in lib.sh (Petr Machata)

Hangbin Liu (14):
  selftests/net: add lib.sh
  selftests/net: convert arp_ndisc_evict_nocarrier.sh to run it in
    unique namespace
  selftests/net: specify the interface when do arping
  selftests/net: convert arp_ndisc_untracked_subnets.sh to run it in
    unique namespace
  selftests/net: convert cmsg tests to make them run in unique namespace
  selftests/net: convert drop_monitor_tests.sh to run it in unique
    namespace
  selftests/net: convert traceroute.sh to run it in unique namespace
  selftests/net: convert icmp_redirect.sh to run it in unique namespace
  sleftests/net: convert icmp.sh to run it in unique namespace
  selftests/net: convert ioam6.sh to run it in unique namespace
  selftests/net: convert l2tp.sh to run it in unique namespace
  selftests/net: convert ndisc_unsolicited_na_test.sh to run it in
    unique namespace
  selftests/net: convert sctp_vrf.sh to run it in unique namespace
  selftests/net: convert unicast_extensions.sh to run it in unique
    namespace

 tools/testing/selftests/net/Makefile          |   2 +-
 .../net/arp_ndisc_evict_nocarrier.sh          |  46 ++--
 .../net/arp_ndisc_untracked_subnets.sh        |  20 +-
 tools/testing/selftests/net/cmsg_ipv6.sh      |  10 +-
 tools/testing/selftests/net/cmsg_so_mark.sh   |   7 +-
 tools/testing/selftests/net/cmsg_time.sh      |   7 +-
 .../selftests/net/drop_monitor_tests.sh       |  21 +-
 tools/testing/selftests/net/forwarding/lib.sh |  27 +-
 tools/testing/selftests/net/icmp.sh           |  10 +-
 tools/testing/selftests/net/icmp_redirect.sh  | 182 +++++++------
 tools/testing/selftests/net/ioam6.sh          | 247 +++++++++---------
 tools/testing/selftests/net/l2tp.sh           | 130 +++++----
 tools/testing/selftests/net/lib.sh            |  85 ++++++
 .../net/ndisc_unsolicited_na_test.sh          |  19 +-
 tools/testing/selftests/net/sctp_vrf.sh       |  12 +-
 tools/testing/selftests/net/traceroute.sh     |  82 +++---
 .../selftests/net/unicast_extensions.sh       |  99 ++++---
 17 files changed, 500 insertions(+), 506 deletions(-)
 create mode 100644 tools/testing/selftests/net/lib.sh

-- 
2.43.0


