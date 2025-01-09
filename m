Return-Path: <linux-kselftest+bounces-24091-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8900A06C3D
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 04:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99D473A7868
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 03:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9A81A3042;
	Thu,  9 Jan 2025 03:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWlNLTO8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C95C19CC11;
	Thu,  9 Jan 2025 03:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736393315; cv=none; b=L1acP2SvjiBP83tXk2z6RPPEbcWuxfk+fbUvlh7U81VKtB5JygEDQZr/uYYvVHv+mK4Iiwli9EyVIoTZsJ17yI8H423bbfFf8EX73RrhgnQQqKGg8Y8l38SEMT7RtG/OMLda9hFw8HNjR7yOm+KSalwn4B16MUsxeGi0XE58oxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736393315; c=relaxed/simple;
	bh=iDMzVWaBAUc/5dl8JpM6FHVTwG2vTQoB1JP29bznlCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tCiWfE9anfQ6UpWmNwFXYIvvb/2s+S1ARBXOgFSiDSKdhP9XtEgL7RGF4HB93hyjPkFMgrEU/kZcw4cdPF3FLAo99HAqZ1lS1gM7snQQ677ZqvlN8YIMYfvYIXXWz6DzKiDa05CLkSvF8AtkHOXSCvBCj9cOPdXSx6S6JTMhshs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWlNLTO8; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b6fc5bf609so34896385a.1;
        Wed, 08 Jan 2025 19:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736393312; x=1736998112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mx066+d16N6jDD1oz7oaqQDJ4chX57pP1FwkUttpBwU=;
        b=OWlNLTO89xDncg6CvRF9AG7Myk208T75N3PpoTnBuHyD9RKYG5UONtUqnIuotw55m6
         hdHR+Qe9Tq/5vknZ9QiK928C1X/6NQky3ixl3NClMKaC5/qs/7Odx/k3dUU96E/2FKKb
         7Uv18a/jzjFTnSiLO0QU1+zH6onlPRnY26uET969zq9obVkkQ97Hvy178ks39oh0bvmn
         Lu8AWP5beeW9eAG9L0okSfV03/uqcRKaw4Zr/yyyVrfUVvXlmeeZRAlSoP5MmBBr9num
         YIjU1BAooZ6S8Wr2AeNwVUAQig8Qt0uHw4+kowbWHPYRJXzeYYqZjRnjbAxIK6r6iQoU
         uP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736393312; x=1736998112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mx066+d16N6jDD1oz7oaqQDJ4chX57pP1FwkUttpBwU=;
        b=g1Qf4ZHpygLhWVqJ2u5wwy5qaDB4B68ZdIJxpDbdCWsjcY/umxc+w5BEcWONPa9aMK
         amS40UsWloMfSlmlqn8XjZISzP3x9mA1cH0jxThI3vysIJtfYK3W5qB9G6sCtd44b5or
         bH7eJgOyRZNkdhE09qN0EzKpgJH312FyIO7xK0bD66MVAn/7g6pycNwR3V2WWHJO0CmK
         60sfafdfb4MqDIEIHd+4kxNKtP3XNivVbbDtAY3HrgDrspHFq8XUr4KMzYdpw+b2H59C
         lMWM2S0CjGvrdVqSYUrKq5NLTAzT4bQZVwQ+OB5k1Syd2ZOBOS/M3hv4G9TLfLEmCr/H
         bTIw==
X-Forwarded-Encrypted: i=1; AJvYcCVlBO1ELr5t4eZAQe8o++6ZKcqFfjnfD+9Swua+7jVBcxuaHmnxBldY5ASz66hjv01R5D6Mqp1bmqfc6p4UTYU=@vger.kernel.org, AJvYcCXBu3/D5UOhcWME+3U/CFzCt09hVaSeL5CqZuo65DM+94cWFz7F9+elJqRuaysjAC+a43WrvAjA@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk1BjRseNLrjzjKYQJi9R7vS/oAOFsUoHF6MG+WZX8PkEDRZ+7
	F+VslMtvEF6maYrn8wCjkY96z3ZztHQGvvIPIIBSkLhW3IhEtTRx
X-Gm-Gg: ASbGncvq1Tc9Ilgj69yYzIfY54qSNmWKoJLIichaJ+xvfP516gXX7m+gfpfA1ZUJaHS
	U789aetH726Gn3YK3Wi/kMKXK2qwsZxO98139BfBucKmn94C8nrFqbp9OLTODyM/jqjyRdCxUm/
	xyXOUXZpCLkMnyc9Qma2ySByOkJnmtORXSx9cngv5xeX/1CxC8KR5kY7A/MpWNDoSnDQN+B/LJO
	IyhpgnTgxOGwmFoncYgZfmJTfdjOKfkMVWql3N1v3R3xo4wWj2fDrCvIQ==
X-Google-Smtp-Source: AGHT+IFVcm7ChxAY/1jPhDoKfJEkSF5O11FH/WiROaLu/4w+Gb2bH3MZZSsrQzHd3KsV4AMk6lIY7A==
X-Received: by 2002:a05:620a:4142:b0:7b6:6756:eefb with SMTP id af79cd13be357-7bcd973ad02mr845714185a.14.1736393312109;
        Wed, 08 Jan 2025 19:28:32 -0800 (PST)
Received: from echampetier.lan ([2607:fea8:1b9f:c5b0::4c4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce35160c6sm25547085a.114.2025.01.08.19.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 19:28:31 -0800 (PST)
From: Etienne Champetier <champetier.etienne@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Etienne Champetier <champetier.etienne@gmail.com>
Subject: [PATCH net-next v2 2/2] selftests: bonding: add ipvlan over bond testing
Date: Wed,  8 Jan 2025 22:28:19 -0500
Message-ID: <20250109032819.326528-3-champetier.etienne@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250109032819.326528-1-champetier.etienne@gmail.com>
References: <20250109032819.326528-1-champetier.etienne@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This rework bond_macvlan.sh into bond_macvlan_ipvlan.sh
We only test bridge mode for macvlan and l2 mode

]# ./bond_macvlan_ipvlan.sh
TEST: active-backup/macvlan_bridge: IPv4: client->server            [ OK ]
...
TEST: active-backup/ipvlan_l2: IPv4: client->server                 [ OK ]
...
TEST: balance-tlb/macvlan_bridge: IPv4: client->server              [ OK ]
...
TEST: balance-tlb/ipvlan_l2: IPv4: client->server                   [ OK ]
...
TEST: balance-alb/macvlan_bridge: IPv4: client->server              [ OK ]
...
TEST: balance-alb/ipvlan_l2: IPv4: client->server                   [ OK ]
...

Signed-off-by: Etienne Champetier <champetier.etienne@gmail.com>
---
 .../selftests/drivers/net/bonding/Makefile    |  2 +-
 .../drivers/net/bonding/bond_macvlan.sh       | 99 -------------------
 .../net/bonding/bond_macvlan_ipvlan.sh        | 96 ++++++++++++++++++
 .../selftests/drivers/net/bonding/config      |  1 +
 4 files changed, 98 insertions(+), 100 deletions(-)
 delete mode 100755 tools/testing/selftests/drivers/net/bonding/bond_macvlan.sh
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_macvlan_ipvlan.sh

diff --git a/tools/testing/selftests/drivers/net/bonding/Makefile b/tools/testing/selftests/drivers/net/bonding/Makefile
index 03a089165d3f..2b10854e4b1e 100644
--- a/tools/testing/selftests/drivers/net/bonding/Makefile
+++ b/tools/testing/selftests/drivers/net/bonding/Makefile
@@ -10,7 +10,7 @@ TEST_PROGS := \
 	mode-2-recovery-updelay.sh \
 	bond_options.sh \
 	bond-eth-type-change.sh \
-	bond_macvlan.sh
+	bond_macvlan_ipvlan.sh
 
 TEST_FILES := \
 	lag_lib.sh \
diff --git a/tools/testing/selftests/drivers/net/bonding/bond_macvlan.sh b/tools/testing/selftests/drivers/net/bonding/bond_macvlan.sh
deleted file mode 100755
index b609fb6231f4..000000000000
--- a/tools/testing/selftests/drivers/net/bonding/bond_macvlan.sh
+++ /dev/null
@@ -1,99 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-#
-# Test macvlan over balance-alb
-
-lib_dir=$(dirname "$0")
-source ${lib_dir}/bond_topo_2d1c.sh
-
-m1_ns="m1-$(mktemp -u XXXXXX)"
-m2_ns="m1-$(mktemp -u XXXXXX)"
-m1_ip4="192.0.2.11"
-m1_ip6="2001:db8::11"
-m2_ip4="192.0.2.12"
-m2_ip6="2001:db8::12"
-
-cleanup()
-{
-	ip -n ${m1_ns} link del macv0
-	ip netns del ${m1_ns}
-	ip -n ${m2_ns} link del macv0
-	ip netns del ${m2_ns}
-
-	client_destroy
-	server_destroy
-	gateway_destroy
-}
-
-check_connection()
-{
-	local ns=${1}
-	local target=${2}
-	local message=${3:-"macvlan_over_bond"}
-	RET=0
-
-
-	ip netns exec ${ns} ping ${target} -c 4 -i 0.1 &>/dev/null
-	check_err $? "ping failed"
-	log_test "$mode: $message"
-}
-
-macvlan_over_bond()
-{
-	local param="$1"
-	RET=0
-
-	# setup new bond mode
-	bond_reset "${param}"
-
-	ip -n ${s_ns} link add link bond0 name macv0 type macvlan mode bridge
-	ip -n ${s_ns} link set macv0 netns ${m1_ns}
-	ip -n ${m1_ns} link set dev macv0 up
-	ip -n ${m1_ns} addr add ${m1_ip4}/24 dev macv0
-	ip -n ${m1_ns} addr add ${m1_ip6}/24 dev macv0
-
-	ip -n ${s_ns} link add link bond0 name macv0 type macvlan mode bridge
-	ip -n ${s_ns} link set macv0 netns ${m2_ns}
-	ip -n ${m2_ns} link set dev macv0 up
-	ip -n ${m2_ns} addr add ${m2_ip4}/24 dev macv0
-	ip -n ${m2_ns} addr add ${m2_ip6}/24 dev macv0
-
-	sleep 2
-
-	check_connection "${c_ns}" "${s_ip4}" "IPv4: client->server"
-	check_connection "${c_ns}" "${s_ip6}" "IPv6: client->server"
-	check_connection "${c_ns}" "${m1_ip4}" "IPv4: client->macvlan_1"
-	check_connection "${c_ns}" "${m1_ip6}" "IPv6: client->macvlan_1"
-	check_connection "${c_ns}" "${m2_ip4}" "IPv4: client->macvlan_2"
-	check_connection "${c_ns}" "${m2_ip6}" "IPv6: client->macvlan_2"
-	check_connection "${m1_ns}" "${m2_ip4}" "IPv4: macvlan_1->macvlan_2"
-	check_connection "${m1_ns}" "${m2_ip6}" "IPv6: macvlan_1->macvlan_2"
-
-
-	sleep 5
-
-	check_connection "${s_ns}" "${c_ip4}" "IPv4: server->client"
-	check_connection "${s_ns}" "${c_ip6}" "IPv6: server->client"
-	check_connection "${m1_ns}" "${c_ip4}" "IPv4: macvlan_1->client"
-	check_connection "${m1_ns}" "${c_ip6}" "IPv6: macvlan_1->client"
-	check_connection "${m2_ns}" "${c_ip4}" "IPv4: macvlan_2->client"
-	check_connection "${m2_ns}" "${c_ip6}" "IPv6: macvlan_2->client"
-	check_connection "${m2_ns}" "${m1_ip4}" "IPv4: macvlan_2->macvlan_2"
-	check_connection "${m2_ns}" "${m1_ip6}" "IPv6: macvlan_2->macvlan_2"
-
-	ip -n ${c_ns} neigh flush dev eth0
-}
-
-trap cleanup EXIT
-
-setup_prepare
-ip netns add ${m1_ns}
-ip netns add ${m2_ns}
-
-modes="active-backup balance-tlb balance-alb"
-
-for mode in $modes; do
-	macvlan_over_bond "mode $mode"
-done
-
-exit $EXIT_STATUS
diff --git a/tools/testing/selftests/drivers/net/bonding/bond_macvlan_ipvlan.sh b/tools/testing/selftests/drivers/net/bonding/bond_macvlan_ipvlan.sh
new file mode 100755
index 000000000000..c4711272fe45
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/bonding/bond_macvlan_ipvlan.sh
@@ -0,0 +1,96 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Test macvlan/ipvlan over bond
+
+lib_dir=$(dirname "$0")
+source ${lib_dir}/bond_topo_2d1c.sh
+
+xvlan1_ns="xvlan1-$(mktemp -u XXXXXX)"
+xvlan2_ns="xvlan2-$(mktemp -u XXXXXX)"
+xvlan1_ip4="192.0.2.11"
+xvlan1_ip6="2001:db8::11"
+xvlan2_ip4="192.0.2.12"
+xvlan2_ip6="2001:db8::12"
+
+cleanup()
+{
+	client_destroy
+	server_destroy
+	gateway_destroy
+
+	ip netns del ${xvlan1_ns}
+	ip netns del ${xvlan2_ns}
+}
+
+check_connection()
+{
+	local ns=${1}
+	local target=${2}
+	local message=${3}
+	RET=0
+
+	ip netns exec ${ns} ping ${target} -c 4 -i 0.1 &>/dev/null
+	check_err $? "ping failed"
+	log_test "${bond_mode}/${xvlan_type}_${xvlan_mode}: ${message}"
+}
+
+xvlan_over_bond()
+{
+	local param="$1"
+	local xvlan_type="$2"
+	local xvlan_mode="$3"
+	RET=0
+
+	# setup new bond mode
+	bond_reset "${param}"
+
+	ip -n ${s_ns} link add link bond0 name ${xvlan_type}0 type ${xvlan_type} mode ${xvlan_mode}
+	ip -n ${s_ns} link set ${xvlan_type}0 netns ${xvlan1_ns}
+	ip -n ${xvlan1_ns} link set dev ${xvlan_type}0 up
+	ip -n ${xvlan1_ns} addr add ${xvlan1_ip4}/24 dev ${xvlan_type}0
+	ip -n ${xvlan1_ns} addr add ${xvlan1_ip6}/24 dev ${xvlan_type}0
+
+	ip -n ${s_ns} link add link bond0 name ${xvlan_type}0 type ${xvlan_type} mode ${xvlan_mode}
+	ip -n ${s_ns} link set ${xvlan_type}0 netns ${xvlan2_ns}
+	ip -n ${xvlan2_ns} link set dev ${xvlan_type}0 up
+	ip -n ${xvlan2_ns} addr add ${xvlan2_ip4}/24 dev ${xvlan_type}0
+	ip -n ${xvlan2_ns} addr add ${xvlan2_ip6}/24 dev ${xvlan_type}0
+
+	sleep 2
+
+	check_connection "${c_ns}" "${s_ip4}" "IPv4: client->server"
+	check_connection "${c_ns}" "${s_ip6}" "IPv6: client->server"
+	check_connection "${c_ns}" "${xvlan1_ip4}" "IPv4: client->${xvlan_type}_1"
+	check_connection "${c_ns}" "${xvlan1_ip6}" "IPv6: client->${xvlan_type}_1"
+	check_connection "${c_ns}" "${xvlan2_ip4}" "IPv4: client->${xvlan_type}_2"
+	check_connection "${c_ns}" "${xvlan2_ip6}" "IPv6: client->${xvlan_type}_2"
+	check_connection "${xvlan1_ns}" "${xvlan2_ip4}" "IPv4: ${xvlan_type}_1->${xvlan_type}_2"
+	check_connection "${xvlan1_ns}" "${xvlan2_ip6}" "IPv6: ${xvlan_type}_1->${xvlan_type}_2"
+
+	check_connection "${s_ns}" "${c_ip4}" "IPv4: server->client"
+	check_connection "${s_ns}" "${c_ip6}" "IPv6: server->client"
+	check_connection "${xvlan1_ns}" "${c_ip4}" "IPv4: ${xvlan_type}_1->client"
+	check_connection "${xvlan1_ns}" "${c_ip6}" "IPv6: ${xvlan_type}_1->client"
+	check_connection "${xvlan2_ns}" "${c_ip4}" "IPv4: ${xvlan_type}_2->client"
+	check_connection "${xvlan2_ns}" "${c_ip6}" "IPv6: ${xvlan_type}_2->client"
+	check_connection "${xvlan2_ns}" "${xvlan1_ip4}" "IPv4: ${xvlan_type}_2->${xvlan_type}_1"
+	check_connection "${xvlan2_ns}" "${xvlan1_ip6}" "IPv6: ${xvlan_type}_2->${xvlan_type}_1"
+
+	ip -n ${c_ns} neigh flush dev eth0
+}
+
+trap cleanup EXIT
+
+setup_prepare
+ip netns add ${xvlan1_ns}
+ip netns add ${xvlan2_ns}
+
+bond_modes="active-backup balance-tlb balance-alb"
+
+for bond_mode in ${bond_modes}; do
+	xvlan_over_bond "mode ${bond_mode}" macvlan bridge
+	xvlan_over_bond "mode ${bond_mode}" ipvlan  l2
+done
+
+exit $EXIT_STATUS
diff --git a/tools/testing/selftests/drivers/net/bonding/config b/tools/testing/selftests/drivers/net/bonding/config
index 899d7fb6ea8e..dad4e5fda4db 100644
--- a/tools/testing/selftests/drivers/net/bonding/config
+++ b/tools/testing/selftests/drivers/net/bonding/config
@@ -3,6 +3,7 @@ CONFIG_BRIDGE=y
 CONFIG_DUMMY=y
 CONFIG_IPV6=y
 CONFIG_MACVLAN=y
+CONFIG_IPVLAN=y
 CONFIG_NET_ACT_GACT=y
 CONFIG_NET_CLS_FLOWER=y
 CONFIG_NET_SCH_INGRESS=y
-- 
2.47.1


