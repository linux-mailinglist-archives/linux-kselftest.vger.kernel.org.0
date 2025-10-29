Return-Path: <linux-kselftest+bounces-44273-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1C8C190AC
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 09:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 59C7B355C85
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 08:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6D031C580;
	Wed, 29 Oct 2025 08:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LD18+JxD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99CF31B10F
	for <linux-kselftest@vger.kernel.org>; Wed, 29 Oct 2025 08:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761726198; cv=none; b=WnKmhiSzDq++GOw+sEsZ7lTqQy4ueNonkNi25CAl6ehzqgWivQKKRuHls8NTyPpKdcusa+iER/38koGRpk0a+vNqzThzbw0zVuXPk5SB/VqOAi9ZBpTmPlh4e9QW5DFWKb24wQCtyk2BvD8opQ1gpNkeDeCl0jsIh6s+jI9e9Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761726198; c=relaxed/simple;
	bh=BudCRENGljleU4jw/J30tPJ8Ha/lVoPujgu+8unYncA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=om/VZxAQ0x+UVFeGv2EZqWkcle/giYSRXVz2fgyG67jpP3wEYojch9oBb8kONYd/MWpBHem/e1akuuvwcDMSHAogU8K/dBBqMmp3TxSKAJaeFwqEq1kGyEvFY10in11OJQ2JuzyHO2wYCxyDyQsoONiM1zXqdpcK2JUIj9HMxIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LD18+JxD; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b6cee846998so4752528a12.1
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Oct 2025 01:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761726196; x=1762330996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wTAuzeBtDgOSqyXzQwljRZm7ZgqX8CCjhJgVNNXB70=;
        b=LD18+JxDgRS88iTVUUoYj2fuKa8YW3mSXs0shi8e+3wd1kH4s27FGnH86g2a5yfwr5
         5faIrlU0MI05OlZSJaw5OkTPChUQd3kztvWqa/L9HldwO8QdkV+FhqWTKIZVgV/axhgl
         DOEP3ovgrQeJjJeO595FUPZWGe+8KKMKeTaCaACLT8FUwkyR5ejj6+iHg8Hx7uvc83WU
         eqZ+/nP6bdv/pmLCoz4XWxvrrUMjXTpnqSbuoc3R7ScaKWfetrqzSdJb1xJIxITW4zsK
         kObLFUgZEd4PPZtnwIyCeJuxSjQZxkND/w3saD2cob8YM7yRyyXVglJYujOsFopAnfim
         QPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761726196; x=1762330996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0wTAuzeBtDgOSqyXzQwljRZm7ZgqX8CCjhJgVNNXB70=;
        b=lDjQgHDqtrgRnImKavLdHtjEA6X9sm0QWtM9JLcLokpWJDIO/PA9XIxbZsB/XiDB1B
         K9gzjquic2edsa2ljRf94hK5ofxEmk3pjVmVysQU1VnGtDAcENnvBQ5MNwbT6fNMEBio
         IoDo250MamJ4eyzEnE8/SWdT9CiGLFkO7qLYcwH4F+RPHUu7BpIv8+A9Qt14UeGqfjH+
         yUPT/ryGeBVyFFzR5vOX50wLvqgXNblXKoNhB7p+ADcQAU2Q5EAJCvY55g17kJQEFbev
         BaQSNYoaTlaQ1SRlsssludrjPyffT/+wnBMYuiIkpGBifp7RI9SY9iSUvePABR2NTiM2
         j/Zg==
X-Forwarded-Encrypted: i=1; AJvYcCXq8V1O7oLq6vaDgHBq4Hg2Y8yPVbq9SZILNkLiSDYe4HQ9KAfE04sP75WKZFyjwqv8GCm/+VUN4FArmj9MWKs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6U6UREC1x8nw81VNfNSE1Es8yBfE+JmhMYj2cMV0YMTcXOJNK
	mT5GzjDibHly77TyQpoEYmrDKg4HRyS0ryt9AchcCxqfJrGoC3ozfZC+
X-Gm-Gg: ASbGnctnHJQcJaB75A2v3peULXCSk782EIW7uhZSAVLN7K+SlP0P/2Gus0xb6ofKXfw
	WXJKjZTpUxZWocMzPNOMAoOiL7nmOw6OU4U/0AclKTCcU7hGfMJvTI2zBzhBdYniYmLHdeyvB6P
	Yt9Qm0z+Mxkavr+mcaHjg3MygF5NWR0sWTj+/CamOnTA3r3EzSWcQnoAaKI6qPuKea03DQmKJLE
	ZDCc/IQYivaco64BdBQoetrjVEblig+ZPLyQ52a7VgRWNR8u4Ng6MaohL+EhCR69srpO9lsTKHC
	TMTZM+uV0BpW92pKC6s4ipuE3Nb/QmyukSpfBN7EojULkv5Z9WsDcDyeAIvwVw/XPDNO+UkAIyH
	r7d9U3gxcRRS9FHe3e4Tx+1LsKgt0IrdwwRo0wul/p8QkWNVRr2R6vMenC2osLZfB4lNM1b2CAB
	R5PspkL6+h40QUK5c=
X-Google-Smtp-Source: AGHT+IHX7B4va/Tn+hwi/F8PQGoRX19Do39HGb6b6T9yWfBdT5kdTctQvLTbMEwxXgCZunDQ1Res5A==
X-Received: by 2002:a17:902:ceca:b0:264:a34c:c6d with SMTP id d9443c01a7336-294def2e7aemr24942695ad.37.1761726195946;
        Wed, 29 Oct 2025 01:23:15 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d09958sm141906005ad.24.2025.10.29.01.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 01:23:15 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jan Stancek <jstancek@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	=?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Shuah Khan <shuah@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Guillaume Nault <gnault@redhat.com>,
	Petr Machata <petrm@nvidia.com>,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 3/3] selftests: net: add YNL test framework
Date: Wed, 29 Oct 2025 08:22:45 +0000
Message-ID: <20251029082245.128675-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251029082245.128675-1-liuhangbin@gmail.com>
References: <20251029082245.128675-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test framework for YAML Netlink (YNL) tools, covering both CLI and
ethtool functionality. The framework includes:

1) cli: family listing, netdev, ethtool, rt-* families, and nlctrl
   operations
2) ethtool: device info, statistics, ring/coalesce/pause parameters, and
   feature gettings

The current YNL syntax is a bit obscure, and end users may not always know
how to use it. This test framework provides usage examples and also serves
as a regression test to catch potential breakages caused by future changes.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/Makefile           |   1 +
 tools/testing/selftests/net/ynl/Makefile   |  18 ++
 tools/testing/selftests/net/ynl/cli.sh     | 234 +++++++++++++++++++++
 tools/testing/selftests/net/ynl/config     |   6 +
 tools/testing/selftests/net/ynl/ethtool.sh | 188 +++++++++++++++++
 tools/testing/selftests/net/ynl/settings   |   1 +
 6 files changed, 448 insertions(+)
 create mode 100644 tools/testing/selftests/net/ynl/Makefile
 create mode 100755 tools/testing/selftests/net/ynl/cli.sh
 create mode 100644 tools/testing/selftests/net/ynl/config
 create mode 100755 tools/testing/selftests/net/ynl/ethtool.sh
 create mode 100644 tools/testing/selftests/net/ynl/settings

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index c46ebdb9b8ef..3335a8dc7cff 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -78,6 +78,7 @@ TARGETS += net/ovpn
 TARGETS += net/packetdrill
 TARGETS += net/rds
 TARGETS += net/tcp_ao
+TARGETS += net/ynl
 TARGETS += nolibc
 TARGETS += nsfs
 TARGETS += pci_endpoint
diff --git a/tools/testing/selftests/net/ynl/Makefile b/tools/testing/selftests/net/ynl/Makefile
new file mode 100644
index 000000000000..0144c47b69ab
--- /dev/null
+++ b/tools/testing/selftests/net/ynl/Makefile
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0
+# Makefile for YNL tests
+
+TEST_PROGS := \
+	cli.sh \
+	ethtool.sh \
+# end of TEST_PROGS
+
+TEST_FILES := \
+	settings \
+# end of TEST_FILES
+
+TEST_INCLUDES := \
+	$(wildcard ../lib/sh/*.sh) \
+	../lib.sh \
+# end of TEST_INCLUDES
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/net/ynl/cli.sh b/tools/testing/selftests/net/ynl/cli.sh
new file mode 100755
index 000000000000..ecc2e349c4e6
--- /dev/null
+++ b/tools/testing/selftests/net/ynl/cli.sh
@@ -0,0 +1,234 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Test YNL CLI functionality
+
+# shellcheck disable=SC1091,SC2034,SC2154,SC2317
+source ../lib.sh
+
+readonly NSIM_ID="1338"
+readonly NSIM_DEV_NAME="nsim${NSIM_ID}"
+readonly VETH_A="veth_a"
+readonly VETH_B="veth_b"
+
+ALL_TESTS="
+	cli_list_families
+	cli_netdev_ops
+	cli_ethtool_ops
+	cli_rt_ops
+	cli_nlctrl_ops
+"
+
+# Test listing available families
+cli_list_families()
+{
+	RET=0
+
+	ynl --list-families &>/dev/null
+	check_err $? "failed to list families"
+
+	log_test "YNL CLI list families"
+}
+
+# Test netdev family operations (dev-get, queue-get)
+cli_netdev_ops()
+{
+	RET=0
+
+	local dev_output
+	local ifindex
+	ifindex=$(ip netns exec "$testns" cat /sys/class/net/"$NSIM_DEV_NAME"/ifindex)
+
+	dev_output=$(ip netns exec "$testns" ynl --family netdev \
+		--do dev-get --json "{\"ifindex\": $ifindex}" 2>/dev/null)
+	check_err $? "failed to get netdev dev info for $NSIM_DEV_NAME"
+
+	echo "$dev_output" | grep -q "ifindex"
+	check_err $? "netdev dev-get output missing ifindex"
+
+	ip netns exec "$testns" ynl --family netdev \
+		--dump queue-get --json "{\"ifindex\": $ifindex}" &>/dev/null
+	check_err $? "failed to get netdev queue info for $NSIM_DEV_NAME"
+
+	log_test "YNL CLI netdev operations"
+}
+
+# Test ethtool family operations (rings-get, linkinfo-get)
+cli_ethtool_ops()
+{
+	RET=0
+
+	local rings_output
+	rings_output=$(ip netns exec "$testns" ynl --family ethtool \
+		--do rings-get --json "{\"header\": {\"dev-name\": \"$NSIM_DEV_NAME\"}}" 2>/dev/null)
+	check_err $? "failed to get ethtool rings info for $NSIM_DEV_NAME"
+
+	echo "$rings_output" | grep -q "header"
+	check_err $? "ethtool rings-get output missing header"
+
+	local linkinfo_output
+	linkinfo_output=$(ip netns exec "$testns" ynl --family ethtool \
+		--do linkinfo-get --json "{\"header\": {\"dev-name\": \"$VETH_A\"}}" 2>/dev/null)
+	check_err $? "failed to get ethtool linkinfo for $VETH_A"
+
+	echo "$linkinfo_output" | grep -q "header"
+	check_err $? "ethtool linkinfo-get output missing header"
+
+	log_test "YNL CLI ethtool operations"
+}
+
+# Test rt-* family operations (route, addr, link, neigh, rule)
+cli_rt_ops()
+{
+	RET=0
+	if ! ynl --list-families 2>/dev/null | grep -q "rt-"; then
+		log_test_skip "YNL CLI rt-* operations" "no rt-* families available"
+		return "$ksft_skip"
+	fi
+
+	local ifindex
+	ifindex=$(ip netns exec "$testns" cat /sys/class/net/"$NSIM_DEV_NAME"/ifindex)
+
+	if ynl --list-families 2>/dev/null | grep -q "rt-route"; then
+		# Add route: 192.0.2.0/24 dev $dev scope link
+		ip netns exec "$testns" ynl --family rt-route --do newroute --create \
+			--json "{\"dst\": \"192.0.2.0\", \"oif\": $ifindex, \"rtm-dst-len\": 24, \"rtm-family\": 2, \"rtm-scope\": 253, \"rtm-type\": 1, \"rtm-protocol\": 3, \"rtm-table\": 254}" &>/dev/null
+
+		local route_output
+		route_output=$(ip netns exec "$testns" ynl --family rt-route \
+			--dump getroute 2>/dev/null)
+		check_err $? "failed to get route info"
+
+		echo "$route_output" | grep -q "192.0.2.0"
+		check_err $? "added route 192.0.2.0 not found in route output"
+
+		ip netns exec "$testns" ynl --family rt-route --do delroute \
+			--json "{\"dst\": \"192.0.2.0\", \"oif\": $ifindex, \"rtm-dst-len\": 24, \"rtm-family\": 2, \"rtm-scope\": 253, \"rtm-type\": 1, \"rtm-protocol\": 3, \"rtm-table\": 254}" &>/dev/null
+	fi
+
+	if ynl --list-families 2>/dev/null | grep -q "rt-addr"; then
+		ip netns exec "$testns" ynl --family rt-addr --do newaddr \
+			--json "{\"ifa-index\": $ifindex, \"local\": \"192.0.2.100\", \"ifa-prefixlen\": 24, \"ifa-family\": 2}" &>/dev/null
+
+		local addr_output
+		addr_output=$(ip netns exec "$testns" ynl --family rt-addr \
+			--dump getaddr 2>/dev/null)
+		check_err $? "failed to get address info"
+
+		echo "$addr_output" | grep -q "192.0.2.100"
+		check_err $? "added address 192.0.2.100 not found in address output"
+
+		ip netns exec "$testns" ynl --family rt-addr --do deladdr \
+			--json "{\"ifa-index\": $ifindex, \"local\": \"192.0.2.100\", \"ifa-prefixlen\": 24, \"ifa-family\": 2}" &>/dev/null
+	fi
+
+	if ynl --list-families 2>/dev/null | grep -q "rt-link"; then
+		ip netns exec "$testns" ynl --family rt-link --do newlink --create \
+			--json "{\"ifname\": \"dummy0\", \"linkinfo\": {\"kind\": \"dummy\"}}" &>/dev/null
+
+		local link_output
+		link_output=$(ip netns exec "$testns" ynl --family rt-link \
+			--dump getlink 2>/dev/null)
+		check_err $? "failed to get link info"
+
+		echo "$link_output" | grep -q "$NSIM_DEV_NAME"
+		check_err $? "test device not found in link output"
+
+		echo "$link_output" | grep -q "dummy0"
+		check_err $? "created dummy0 interface not found in link output"
+
+		ip netns exec "$testns" ynl --family rt-link --do dellink \
+			--json "{\"ifname\": \"dummy0\"}" &>/dev/null
+	fi
+
+	if ynl --list-families 2>/dev/null | grep -q "rt-neigh"; then
+		# Add neighbor: 192.0.2.1 dev nsim1338 lladdr 11:22:33:44:55:66 PERMANENT
+		ip netns exec "$testns" ynl --family rt-neigh --do newneigh --create \
+			--json "{\"ndm-ifindex\": $ifindex, \"dst\": \"192.0.2.1\", \"lladdr\": \"11:22:33:44:55:66\", \"ndm-family\": 2, \"ndm-state\": 128}" &>/dev/null
+
+		local neigh_output
+		neigh_output=$(ip netns exec "$testns" ynl --family rt-neigh \
+			--dump getneigh 2>/dev/null)
+		check_err $? "failed to get neighbor info"
+
+		echo "$neigh_output" | grep -q "192.0.2.1"
+		check_err $? "added neighbor 192.0.2.1 not found in neighbor output"
+
+		ip netns exec "$testns" ynl --family rt-neigh --do delneigh \
+			--json "{\"ndm-ifindex\": $ifindex, \"dst\": \"192.0.2.1\", \"lladdr\": \"11:22:33:44:55:66\", \"ndm-family\": 2}" &>/dev/null
+	fi
+
+	if ynl --list-families 2>/dev/null | grep -q "rt-rule"; then
+		# Add rule: from 192.0.2.0/24 lookup 100 none
+		ip netns exec "$testns" ynl --family rt-rule --do newrule \
+			--json "{\"family\": 2, \"src-len\": 24, \"src\": \"192.0.2.0\", \"table\": 100}" &>/dev/null
+
+		local rule_output
+		rule_output=$(ip netns exec "$testns" ynl --family rt-rule \
+			--dump getrule 2>/dev/null)
+		check_err $? "failed to get rule info"
+
+		echo "$rule_output" | grep -q "192.0.2.0"
+		check_err $? "added rule with src 192.0.2.0 not found in rule output"
+
+		ip netns exec "$testns" ynl --family rt-rule --do delrule \
+			--json "{\"family\": 2, \"src-len\": 24, \"src\": \"192.0.2.0\", \"table\": 100}" &>/dev/null
+	fi
+
+	log_test "YNL CLI rt-* operations"
+}
+
+# Test nlctrl family operations
+cli_nlctrl_ops()
+{
+	RET=0
+
+	local family_output
+	family_output=$(ynl --family nlctrl \
+		--do getfamily --json "{\"family-name\": \"netdev\"}" 2>/dev/null)
+	check_err $? "failed to get nlctrl family info for netdev"
+
+	echo "$family_output" | grep -q "family-name"
+	check_err $? "nlctrl getfamily output missing family-name"
+
+	echo "$family_output" | grep -q "family-id"
+	check_err $? "nlctrl getfamily output missing family-id"
+
+	log_test "YNL CLI nlctrl getfamily"
+}
+
+setup()
+{
+	if ! modprobe netdevsim &>/dev/null; then
+		log_test_skip "all YNL CLI tests" "netdevsim module not available"
+		exit "$ksft_skip"
+	fi
+
+	setup_ns testns
+
+	if ! create_netdevsim "$NSIM_ID" "$testns" &>/dev/null; then
+		log_test_skip "all YNL CLI tests" "failed to create netdevsim device"
+		exit "$ksft_skip"
+	fi
+
+	if ! ip -n "$testns" link add "$VETH_A" type veth peer name "$VETH_B"; then
+		log_test_skip "all YNL CLI tests" "failed to create veth pair"
+		exit "$ksft_skip"
+	fi
+
+	ip -n "$testns" link set "$VETH_A" up
+	ip -n "$testns" link set "$VETH_B" up
+}
+
+cleanup()
+{
+	cleanup_netdevsim "$NSIM_ID"
+	cleanup_all_ns
+}
+
+trap cleanup EXIT
+
+require_command "ynl"
+setup
+tests_run
+
+exit "$EXIT_STATUS"
diff --git a/tools/testing/selftests/net/ynl/config b/tools/testing/selftests/net/ynl/config
new file mode 100644
index 000000000000..339f1309c03f
--- /dev/null
+++ b/tools/testing/selftests/net/ynl/config
@@ -0,0 +1,6 @@
+CONFIG_DUMMY=m
+CONFIG_INET_DIAG=y
+CONFIG_IPV6=y
+CONFIG_NET_NS=y
+CONFIG_NETDEVSIM=m
+CONFIG_VETH=m
diff --git a/tools/testing/selftests/net/ynl/ethtool.sh b/tools/testing/selftests/net/ynl/ethtool.sh
new file mode 100755
index 000000000000..a70552afd7e2
--- /dev/null
+++ b/tools/testing/selftests/net/ynl/ethtool.sh
@@ -0,0 +1,188 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Test YNL ethtool functionality
+
+# shellcheck disable=SC1091,SC2034,SC2154,SC2317
+source ../lib.sh
+
+readonly NSIM_ID="1337"
+readonly NSIM_DEV_NAME="nsim${NSIM_ID}"
+readonly VETH_A="veth_a"
+readonly VETH_B="veth_b"
+
+ALL_TESTS="
+	ethtool_device_info
+	ethtool_statistics
+	ethtool_ring_params
+	ethtool_coalesce_params
+	ethtool_pause_params
+	ethtool_features_info
+	ethtool_channels_info
+	ethtool_time_stamping
+"
+
+# Uses veth device as netdevsim doesn't support basic ethtool device info
+ethtool_device_info()
+{
+	RET=0
+
+	local info_output
+	info_output=$(ip netns exec "$testns" ynl-ethtool "$VETH_A" 2>/dev/null)
+	check_err $? "failed to get device info for $VETH_A"
+
+	echo "$info_output" | grep -q "Settings for"
+	check_err $? "device info output missing expected content"
+
+	log_test "YNL ethtool device info"
+}
+
+ethtool_statistics()
+{
+	RET=0
+
+	local stats_output
+	stats_output=$(ip netns exec "$testns" ynl-ethtool --statistics "$NSIM_DEV_NAME" 2>/dev/null)
+	check_err $? "failed to get statistics for $NSIM_DEV_NAME"
+
+	echo "$stats_output" | grep -q -E "(NIC statistics|packets|bytes)"
+	check_err $? "statistics output missing expected content"
+
+	log_test "YNL ethtool statistics"
+}
+
+ethtool_ring_params()
+{
+	RET=0
+
+	local ring_output
+	ring_output=$(ip netns exec "$testns" ynl-ethtool --show-ring "$NSIM_DEV_NAME" 2>/dev/null)
+	check_err $? "failed to get ring parameters for $NSIM_DEV_NAME"
+
+	if [[ -n "$ring_output" ]]; then
+		echo "$ring_output" | grep -q -E "(Ring parameters|RX|TX)"
+		check_err $? "ring parameters output missing expected content"
+	fi
+
+	if ! ip netns exec "$testns" ynl-ethtool --set-ring "$NSIM_DEV_NAME" rx 64 2>/dev/null; then
+		check_err 1 "set-ring command failed unexpectedly"
+	fi
+
+	log_test "YNL ethtool ring parameters (show/set)"
+}
+
+ethtool_coalesce_params()
+{
+	RET=0
+
+	ip netns exec "$testns" ynl-ethtool --show-coalesce "$NSIM_DEV_NAME" &>/dev/null
+	check_err $? "failed to get coalesce parameters for $NSIM_DEV_NAME"
+
+	if ! ip netns exec "$testns" ynl-ethtool --set-coalesce "$NSIM_DEV_NAME" rx-usecs 50 2>/dev/null; then
+		check_err 1 "set-coalesce command failed unexpectedly"
+	fi
+
+	log_test "YNL ethtool coalesce parameters (show/set)"
+}
+
+ethtool_pause_params()
+{
+	RET=0
+
+	ip netns exec "$testns" ynl-ethtool --show-pause "$NSIM_DEV_NAME" &>/dev/null
+	check_err $? "failed to get pause parameters for $NSIM_DEV_NAME"
+
+	if ! ip netns exec "$testns" ynl-ethtool --set-pause "$NSIM_DEV_NAME" tx 1 rx 1 2>/dev/null; then
+		check_err 1 "set-pause command failed unexpectedly"
+	fi
+
+	log_test "YNL ethtool pause parameters (show/set)"
+}
+
+ethtool_features_info()
+{
+	RET=0
+
+	local features_output
+	features_output=$(ip netns exec "$testns" ynl-ethtool --show-features "$NSIM_DEV_NAME" 2>/dev/null)
+	check_err $? "failed to get features for $NSIM_DEV_NAME"
+
+	if [[ -n "$features_output" ]]; then
+		echo "$features_output" | grep -q -E "(Features|offload)"
+		check_err $? "features output missing expected content"
+	fi
+
+	log_test "YNL ethtool features info (show/set)"
+}
+
+ethtool_channels_info()
+{
+	RET=0
+
+	local channels_output
+	channels_output=$(ip netns exec "$testns" ynl-ethtool --show-channels "$NSIM_DEV_NAME" 2>/dev/null)
+	check_err $? "failed to get channels for $NSIM_DEV_NAME"
+
+	if [[ -n "$channels_output" ]]; then
+		echo "$channels_output" | grep -q -E "(Channel|Combined|RX|TX)"
+		check_err $? "channels output missing expected content"
+	fi
+
+	if ! ip netns exec "$testns" ynl-ethtool --set-channels "$NSIM_DEV_NAME" combined-count 1 2>/dev/null; then
+		check_err 1 "set-channels command failed unexpectedly"
+	fi
+
+	log_test "YNL ethtool channels info (show/set)"
+}
+
+ethtool_time_stamping()
+{
+	RET=0
+
+	local ts_output
+	ts_output=$(ip netns exec "$testns" ynl-ethtool --show-time-stamping "$NSIM_DEV_NAME" 2>/dev/null)
+	check_err $? "failed to get time stamping info for $NSIM_DEV_NAME"
+
+	if [[ -n "$ts_output" ]]; then
+		echo "$ts_output" | grep -q -E "(Time stamping|timestamping|SOF_TIMESTAMPING)"
+		check_err $? "time stamping output missing expected content"
+	fi
+
+	log_test "YNL ethtool time stamping"
+}
+
+setup()
+{
+	if ! modprobe netdevsim &>/dev/null; then
+		log_test_skip "all YNL ethtool tests" "netdevsim module not available"
+		exit "$ksft_skip"
+	fi
+
+	setup_ns testns
+
+	if ! create_netdevsim "$NSIM_ID" "$testns" >/dev/null 2>&1; then
+		log_test_skip "all YNL ethtool tests" "failed to create netdevsim device"
+		exit "$ksft_skip"
+	fi
+
+	if ! ip -n "$testns" link add "$VETH_A" type veth peer name "$VETH_B" 2>/dev/null; then
+		log_test_skip "all YNL ethtool tests" "failed to create veth pair"
+		exit "$ksft_skip"
+	fi
+
+	ip -n "$testns" link set "$VETH_A" up
+	ip -n "$testns" link set "$VETH_B" up
+}
+
+cleanup()
+{
+	cleanup_netdevsim "$NSIM_ID" 2>/dev/null
+	cleanup_all_ns
+}
+
+trap cleanup EXIT
+
+require_command "ynl-ethtool"
+setup
+tests_run
+
+exit "$EXIT_STATUS"
diff --git a/tools/testing/selftests/net/ynl/settings b/tools/testing/selftests/net/ynl/settings
new file mode 100644
index 000000000000..6091b45d226b
--- /dev/null
+++ b/tools/testing/selftests/net/ynl/settings
@@ -0,0 +1 @@
+timeout=120
-- 
2.50.1


