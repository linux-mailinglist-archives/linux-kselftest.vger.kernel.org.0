Return-Path: <linux-kselftest+bounces-862-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 507857FE7EF
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 05:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B8B12821B2
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 04:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A726613FF6;
	Thu, 30 Nov 2023 04:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVZnVV0G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363C498;
	Wed, 29 Nov 2023 20:01:15 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so439952a12.1;
        Wed, 29 Nov 2023 20:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701316874; x=1701921674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g3a9sCiS2Css+WXIZZveZE/xtShrUDTTw/Xo+wUDP5I=;
        b=iVZnVV0GUv4DYBg3A4075ExxbqczAOAR8t5KMnBKqjNfCqnDAlm0byGY/S9RjK48RX
         QpKfQxuyGSyPchVRU5RBm3GxDi6E7j7zi4OX6i7C8YkhMRVfV6oLCI9xrCIXBKFrMNTP
         NHRjVskFnHMDD7R3CFjNtvdHWYO4AgIoM9e6sLxu1X/x9OblAG4i/Z5Ct6ap+PKbyOC8
         N1Swfnu/4AjEYiHVpO55vlmn0vW5B/SjXU9gifckD6BbJaVnFRMMvr5N17Dr38lo/bfY
         w0Klq5mehFXahFXfeUnODVQpxRD6CCOJCn04wmeBgKZV5buxj0ljK8cmQ1YaBPjTOLBc
         ePGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701316874; x=1701921674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g3a9sCiS2Css+WXIZZveZE/xtShrUDTTw/Xo+wUDP5I=;
        b=PR9/TdG2cU4TkmK2HQeMUlu5UF0E/KAyQpd2GY944S+mcrmba4QrfLmOrWplgl5fr2
         eJ2urxhD2UErVo/FFGjdAtljeAwB5i9X95jLOMFwtc9XoKNAuoFaQKAAZAYm3umZTyDx
         a80inHJyn7FmeRK9ie812zqWyi/HRsn3G29Y4Yi1TDf79/QutpXTm4RBAHxIqnuWUns/
         QBRi2Xd/p09waY7SRkUfKWCt7lB1MDzb+hDOW+pahCXrP1+kSb+bjD5Ig0QoYq8UqgnD
         /Xq3a7Vma0SI/6iZKSEBV8VaC4rFR0GzKcBEA/TWNqkRCEr9ROqxb056ndRHqAuse9Bo
         HE4w==
X-Gm-Message-State: AOJu0Yxc1C2FOVyv7cP455w/QvvAcpvfQauNevBsZ2S84toxIXPXsts/
	x2bbR2KHXv/mcsqeN4HywsAa9dsNpGmWig==
X-Google-Smtp-Source: AGHT+IF3BPa+FqlOORuz23m3hh4/ReFMOunkAZMPAoTkU/NORxOHXGTtA9eZKfSzO+VBysmSuXs0OQ==
X-Received: by 2002:a05:6a21:99a6:b0:18c:63cb:e86e with SMTP id ve38-20020a056a2199a600b0018c63cbe86emr19548963pzb.2.1701316874000;
        Wed, 29 Nov 2023 20:01:14 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p16-20020aa78610000000b006cc02a6d18asm187975pfn.61.2023.11.29.20.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 20:01:13 -0800 (PST)
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
	Francesco Ruggeri <fruggeri@arista.com>,
	Justin Iurman <justin.iurman@uliege.be>,
	Xin Long <lucien.xin@gmail.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 00/14] Conver net selftests to run in unique namespace (Part 1)
Date: Thu, 30 Nov 2023 12:00:51 +0800
Message-ID: <20231130040105.1265779-1-liuhangbin@gmail.com>
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

This patch set intend to conver all the net selftests to run in unique namespace,
so we can update the selftest freamwork to run all tests in it's own namespace
in parallel. After update, we only need to wait for the test which need
longest time.

As the total patch set is too large. I break it to severl parts. This is
the first part.

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
2.41.0


