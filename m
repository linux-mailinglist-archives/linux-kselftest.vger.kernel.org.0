Return-Path: <linux-kselftest+bounces-32645-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9952AAF56C
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 10:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 749283BAB83
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 08:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6472227E80;
	Thu,  8 May 2025 08:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBMxDeD5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3744E221D85;
	Thu,  8 May 2025 08:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746692368; cv=none; b=US/11VOO2AX+nAQzL61L6FOx65TsU402ecL8YkSmy7X1/2n2wGKrE0tKcJKo68D9aCq+m1KYCacXgMpOgCrkhsBrtHJqiZItykw2pspCycDNcrmglzgKt/Kbw1he8VMtQH3UPIttEm6vctsUAWtkfxM822I3U9jQJTOvuCKw3O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746692368; c=relaxed/simple;
	bh=14n4tW0qeqU54B1pKTKeoFx7E7yIyzyMSpakYOShDt4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jp3wVAbR2fsbPuUsJRyTaWyO/b2q+Ooic7DeGZT+OXCmfUCBY00lVihz/2MBS4t0ijbw3J3f/dFFnjrbSdV95Lqo348XgSw0ZOab8vkJjTCBoPUSrLO61z3IK7JquHCo939zOAmB6xYT3Hblc3oePYHdHZnZ7AOfqfIWL79AXps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBMxDeD5; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-73bf5aa95e7so756453b3a.1;
        Thu, 08 May 2025 01:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746692366; x=1747297166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HPpdRtp3aVyMAVOGkWkmMRZEWVnHO+8x5d8pJrgFXgU=;
        b=TBMxDeD5/l9dXKVQXU3R3Eexk2WmPxQWiF8v992O/Iy8lXTy01sf2yMllsPI/vkXRs
         QDeFeUmZp9u9RLlMxt+ZKNWPDoTD94YpFrorVOrpKPNB8kh2c8ToGoS8+t4cAt9M0ZCp
         OX+qX/L7Wcwlt4olhcFUJaBKnjfVRiRFwErmCk90sf3KSNcpbpne4cvaq8E30LcfWZD9
         6ldwczrnRJ/PtAkl4/grtL5N98ozjBXXBzKbiBzvsKh7WUNwEBgaMvXJ6fvhw819YGuh
         5DcpkDHpMvitWGYn7guyx5Y5YoBJXzn0W5j6Qkv6BEghw7zk5qdTUDPrp0z2viEG38fR
         xagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746692366; x=1747297166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HPpdRtp3aVyMAVOGkWkmMRZEWVnHO+8x5d8pJrgFXgU=;
        b=W+HexM0YE1lw01YZyzAH3dlI8JcziwUb8qUZncLsL+ipPxboymqee/oa3YG7h6rEhO
         FxK6rxHtP7IZ/Iacu0E78M9gBqscg/PhPi343VTrcycdwyQLi89xWBNfwB7ugb4Tjdle
         wd/4Fonplp7QeQGChQkqL7cSi5qXhlGFMAk2qPw5zs7JCEFZPb4oxhyMcipV43yIX6rU
         3ofV0us31642Ave++I/rbEHI5glit0UMH9qJuR23IB0kS94LjToAQEKfmtFfaeRr1ZGf
         sYynn9w8S+SPeeYNujQZd/HwOEi1cL57J6pDTRyw45QSY6RG4GUx7qu4g+U4ROX6sTrm
         CzVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhP5R8CWi55eKOwjzsxQlLOJbK9O+Uv051Cbya6vISkgt5BCrAwGk7Xvm7gI2BWs86vObz14R0a/safkj3awo=@vger.kernel.org, AJvYcCW7254c7WLoHF1fquRWUi40oIfv4JjSIWlwNNUI2LcmqjlQwp0/0fplKAcyh5Pvkdmcw2AMU3Dzp3JPr1UUXW16@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv2ky7iqZIIQxovZQ6oEqAyLH3GoVx5cNQJT573/oh5qLYE6AV
	Ys45vU2WFze7mJjFnlI+D6r6sVVKVDvMVl1nb7+vL4v39EA7vGJ5M+yy918as3o=
X-Gm-Gg: ASbGncurJHVK/a/oOXakxT8BzZlyfJpisGEf9i63ZGioVFUHLXs2wrTLtMCVb6/kXWc
	uUQdr9zbyP0MMPRscrYEH9G5iZmJmoHPGVittMA1rKHl4xk2C6Zi7/xP7iMXZD8b5IEEds7ryCH
	QZeubaggD7TnMzhkfk3vNIHk0dfrb+bvrlVDb+UQhYbWKq7bw/1nl18lOdmRtaqpufQI5unzS9K
	x7Aus6swUNcUP6UN4dtpIBgd9bLL8JhUX+v1B6AYMwIlqK6NI+GEmWKAK3iZZs4VHC3C/ug2qye
	cpGwNsgjwJHCAi2wnO3qpm7WelnnjIhW9po6Eo2xd1tng4qDNJaPZpl6bgCmxbSntfhW1x8=
X-Google-Smtp-Source: AGHT+IEw7Njo6XB2YXjl91SPT7jER52C00agtAZZ8VbNoPu1BX+dXS3OeJ2BaTH53o5fy8nazQPpdg==
X-Received: by 2002:a05:6a21:8cc5:b0:1f5:5b77:3811 with SMTP id adf61e73a8af0-2159af8c8e3mr3464618637.22.1746692365946;
        Thu, 08 May 2025 01:19:25 -0700 (PDT)
Received: from fedora.dns.podman ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7406a36c523sm10907408b3a.144.2025.05.08.01.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 01:19:25 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
	linux-kselftest@vger.kernel.org,
	mptcp@lists.linux.dev,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 0/6] selftests: net: configure rp_filter in setup_ns
Date: Thu,  8 May 2025 08:19:04 +0000
Message-ID: <20250508081910.84216-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some distributions enable rp_filter globally by default, which can interfere
with various test cases. To address this, many tests explicitly disable
rp_filter within their scripts.

To avoid duplication and ensure consistent behavior across tests, this patch
moves the rp_filter configuration into setup_ns, applied immediately after a
new namespace is created. This change ensures that all namespace-based tests
inherit the appropriate rp_filter settings, simplifying individual test
scripts and improving maintainability.

v2: fix srv6_hl2encap_red_l2vpn_test.sh test failure (Jakub Kicinski)

Hangbin Liu (6):
  selftests: net: disable rp_filter after namespace initialization
  selftests: net: remove redundant rp_filter configuration
  selftests: net: use setup_ns for bareudp testing
  selftests: net: use setup_ns for SRv6 tests and remove rp_filter
    configuration
  selftests: netfilter: remove rp_filter configuration
  selftests: mptcp: remove rp_filter configuration

 tools/testing/selftests/net/bareudp.sh        | 49 ++---------
 tools/testing/selftests/net/fib_rule_tests.sh |  3 -
 tools/testing/selftests/net/fib_tests.sh      |  3 -
 tools/testing/selftests/net/icmp_redirect.sh  |  2 -
 tools/testing/selftests/net/lib.sh            |  2 +
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  2 -
 .../selftests/net/netfilter/br_netfilter.sh   |  3 -
 .../selftests/net/netfilter/bridge_brouter.sh |  2 -
 .../selftests/net/netfilter/conntrack_vrf.sh  |  3 -
 tools/testing/selftests/net/netfilter/ipvs.sh |  6 --
 .../selftests/net/netfilter/nft_fib.sh        |  2 -
 .../selftests/net/netfilter/nft_nat_zones.sh  |  2 -
 .../testing/selftests/net/netfilter/rpath.sh  | 18 ++--
 .../selftests/net/srv6_end_dt46_l3vpn_test.sh |  5 --
 .../selftests/net/srv6_end_dt4_l3vpn_test.sh  |  5 --
 .../net/srv6_end_next_csid_l3vpn_test.sh      | 77 ++++-------------
 .../net/srv6_end_x_next_csid_l3vpn_test.sh    | 83 +++++--------------
 .../net/srv6_hencap_red_l3vpn_test.sh         | 74 ++++-------------
 .../net/srv6_hl2encap_red_l2vpn_test.sh       | 83 +++++--------------
 19 files changed, 90 insertions(+), 334 deletions(-)

-- 
2.46.0


