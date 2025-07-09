Return-Path: <linux-kselftest+bounces-36803-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F44AFE383
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 11:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1900C583E98
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 09:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73794283FF8;
	Wed,  9 Jul 2025 09:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJYrDYHM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABA527AC44;
	Wed,  9 Jul 2025 09:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752051852; cv=none; b=gDwPObvSM7FCDDBmAeQ6jDEsOMrunjqdjTShDkDcg6JoVBsT3HkHV+X/CeciHJHPdC5wWfWVWcvjqc5im6/XwxK56EUG42blMQd1S20YtjtN5Oq+nw6c3UdPMrSx3hwX/jDaMYhM0JlUKH9UW6PAznNbIiWoU1zs0p1HW+Y3VXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752051852; c=relaxed/simple;
	bh=GOzhX2GzqLAc2kmJ9CRuzgbr4ARczQe5nsnIL5KbtaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LJnCGbsTwCC3FjC5il1ntB3L+P9p7icf/BWQQWasnL1V5mNVPirYge9icRo2l8Mr6xXIbVwReQEajQ5SEbYC8NMPDNu+LzZA/dAIvXGCT/A5lw3UmYbzxtV6u/0zr2iX1ZzkLpy0XZguEKE9XaWXmBMC6pz7xuZcTATKCVSHPfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJYrDYHM; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7426c44e014so4246399b3a.3;
        Wed, 09 Jul 2025 02:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752051850; x=1752656650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=raLbeBFFTNqeQUKnu2mwcarmbDXgKlnhQ613jJ0RUBM=;
        b=HJYrDYHMOkUgTM0NebJvrs/U+yyH6MH1iPYktNVEiZC0iiUL6qGDS9n3biDDzk50hl
         xNQ1ExWLS5T9MzSWw2NSR6Tdc8ohfAq5Nlm/1lplWlWxtGO4mU1EJYp8bFJKmEahfwQs
         kCIo1LakeWo1YzI5pb9QagL64nQO5LxeqyDRrwGjaoYCHXxe7myfD1IGsRy+VjkzO/AJ
         91SkN7bGN82TxMN/+VHyBswKYuqHlD7dbs4XchlLDagLlW/RISbYO0JRUUstR6tz8t2s
         zREZt8D/6I7kBd2TKnRcw7IezTXZz4SF/0JJubkkHzuGYEA4W113uve/Wak/Z+amU/T5
         oREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752051850; x=1752656650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=raLbeBFFTNqeQUKnu2mwcarmbDXgKlnhQ613jJ0RUBM=;
        b=D09Eg6GjDHh9xY+tT+/C0Mgi3IHqxrEGyI/jMqyIyhwoDqUQGmkn+fCDP4O2VV0OUz
         Dq40Lv6/SkZShAv3B9oy4Ok1Ysrw/nJmo2nq3MO+Wy3ltmw/B6+VNUUqUma5rUcPvYDa
         Hj7o5yg6+7V3jG3on8dYz+RsXNb5KeBPT0pIhKITsLCRthmZwsq9gLd26uFIcNJByc3F
         ni/aZMkSXV/GxUIGCLRCcFDF/zK5evgUHtf9RcnOwhB2WV90EZoG5u6joatbNLfNJ0yl
         ZTWLTKO6gLpBgnEmwmOD4EkY5+Q5bNZbFyuw06tO7QhES0EBxCnaZDWyK0gBos9GEg1Y
         fiPQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1YzVtpyoKtWfvk8UhUI9H3jw6MoDdH9pRD8X3mojisj7GZwDmalZOfa0a29k+5Dxe9q3l3q7jjTmWFDLxT6cB@vger.kernel.org, AJvYcCWnpNCJlbG0GsS0UYdUJsWJItrvL6yF0oY9NZc3CPOazXoNPEvpwexb7J3FfaBLPg1ZgEIAHG6kpfl4f4k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0U5i8JdLtY2PQ0c+yNqWBvuJKXJIQVpV/jX4vYxVbF1AYHhXl
	8obIjL/uFnA/wGqzo0/47TMb0LvtbVQK9TyYw31JYzR2R1T5KUlpjjoB3A7ZXEszig8=
X-Gm-Gg: ASbGncsXDUdNgQTOyDDcN+e30KpiGhZLTkmfK6t5hkGjyykMeDBMJmg/dwq+AUpcBLy
	DxH+z3sEpE3mAZzlgRdHok3ljT/aVYObew18RRVbjuj+u741pvkixV2EZ7vPs22b5grjWlZuPUL
	PDEnqMfu7L4wlVroDbOUi/0JRp+WESwBLhQeg0u32PIKaxl/8QUr0odLRgepO0RP5yCx56Ykf69
	z1KbkKeRImraMBRkA6P7mPAuEfNiNPFNgIL4U6K2+zfBPeh/cd1BxhZxsQbd6y4PrFskX0/37S6
	PcELSuM/aCb4TYC3hhd4EUNNFLUjlQNGMftwirPpQv2jqyl4yMgUDRq+QSMXBk4I/Ji0xtPV/Y3
	dJfAd1zkkB+M=
X-Google-Smtp-Source: AGHT+IHDEUt/lqlxNpmzPOz7UgJ4iGmRo3ZrudmpTUJwyed3xSYhz7n9LWORFwOMhw+vEeMCj5hwew==
X-Received: by 2002:a05:6a21:6f13:b0:229:1130:7411 with SMTP id adf61e73a8af0-22cd7aa495emr2801773637.31.1752051849837;
        Wed, 09 Jul 2025 02:04:09 -0700 (PDT)
Received: from localhost.localdomain ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee74a681sm13619309a12.76.2025.07.09.02.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 02:04:09 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net 2/2] selftests: bonding: add test for passive LACP mode
Date: Wed,  9 Jul 2025 09:03:44 +0000
Message-ID: <20250709090344.88242-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250709090344.88242-1-liuhangbin@gmail.com>
References: <20250709090344.88242-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a selftest to verify bonding behavior when lacp_active is set to off.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../drivers/net/bonding/bond_passive_lacp.sh  | 21 +++++
 .../drivers/net/bonding/bond_topo_lacp.sh     | 77 +++++++++++++++++++
 2 files changed, 98 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_passive_lacp.sh
 create mode 100644 tools/testing/selftests/drivers/net/bonding/bond_topo_lacp.sh

diff --git a/tools/testing/selftests/drivers/net/bonding/bond_passive_lacp.sh b/tools/testing/selftests/drivers/net/bonding/bond_passive_lacp.sh
new file mode 100755
index 000000000000..4cf8a5999aaa
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/bonding/bond_passive_lacp.sh
@@ -0,0 +1,21 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Testing if bond works with lacp_active = off
+
+lib_dir=$(dirname "$0")
+source ${lib_dir}/bond_topo_lacp.sh
+
+trap cleanup EXIT
+setup_topo_lacp
+
+lacp_bond_reset "${c_ns}" "lacp_active off"
+# make sure the switch state is not expired [A,T,G,S,Ex]
+if slowwait 15 ip netns exec ${s_ns} grep -q 'port state: 143' /proc/net/bonding/bond0; then
+	RET=1
+else
+	RET=0
+fi
+log_test "bond 802.3ad" "lacp_active off"
+
+exit $EXIT_STATUS
diff --git a/tools/testing/selftests/drivers/net/bonding/bond_topo_lacp.sh b/tools/testing/selftests/drivers/net/bonding/bond_topo_lacp.sh
new file mode 100644
index 000000000000..33dca6ebdc4b
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/bonding/bond_topo_lacp.sh
@@ -0,0 +1,77 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Topology for Bond mode 802.3ad testing
+#
+#  +-------------------------+
+#  |          bond0          |  Switch
+#  |            +            |  192.0.2.254/24
+#  |      eth0  |  eth1      |  2001:db8::254/24
+#  |        +---+---+        |
+#  |        |       |        |
+#  +-------------------------+
+#           |       |
+#  +-------------------------+
+#  |        |       |        |
+#  |        +---+---+        |  Client
+#  |      eth0  |  eth1      |  192.0.2.1/24
+#  |            +            |  2001:db8::1/24
+#  |          bond0          |
+#  +-------------------------+
+
+REQUIRE_MZ=no
+NUM_NETIFS=0
+lib_dir=$(dirname "$0")
+source "$lib_dir"/../../../net/forwarding/lib.sh
+
+s_ip4="192.0.2.254"
+c_ip4="192.0.2.1"
+s_ip6="2001:db8::254"
+c_ip6="2001:db8::1"
+
+switch_create()
+{
+	ip netns exec ${s_ns} sysctl -q net.ipv6.conf.default.keep_addr_on_down=1
+	ip -n ${s_ns} link add eth0 type veth peer name eth0 netns ${c_ns}
+	ip -n ${s_ns} link add eth1 type veth peer name eth1 netns ${c_ns}
+	ip -n ${s_ns} link add bond0 type bond mode 802.3ad miimon 100 lacp_active on lacp_rate fast
+	ip -n ${s_ns} link set eth0 master bond0
+	ip -n ${s_ns} link set eth1 master bond0
+	ip -n ${s_ns} addr add ${s_ip4}/24 dev bond0
+	ip -n ${s_ns} addr add ${s_ip6}/24 dev bond0
+	ip -n ${s_ns} link set bond0 up
+}
+
+client_create()
+{
+	ip netns exec ${c_ns} sysctl -q net.ipv6.conf.default.keep_addr_on_down=1
+	ip -n ${c_ns} link add bond0 type bond mode 802.3ad miimon 100 lacp_active on lacp_rate fast
+	ip -n ${c_ns} link set eth0 master bond0
+	ip -n ${c_ns} link set eth1 master bond0
+	ip -n ${c_ns} addr add ${c_ip4}/24 dev bond0
+	ip -n ${c_ns} addr add ${c_ip6}/24 dev bond0
+	ip -n ${c_ns} link set bond0 up
+}
+
+setup_topo_lacp()
+{
+	setup_ns s_ns c_ns
+	defer cleanup_all_ns
+
+	switch_create
+	client_create
+}
+
+# Reset bond with and options
+lacp_bond_reset()
+{
+	local netns="$1"
+	local param="$2"
+
+	ip -n ${netns} link set bond0 down
+	ip -n ${netns} link set bond0 type bond $param
+	ip -n ${netns} link set bond0 up
+
+	# Wait for IPv6 address ready as it needs DAD
+	slowwait 10 ip netns exec ${c_ns} ping6 ${s_ip6} -c 1 -W 0.1 &> /dev/null
+}
-- 
2.46.0


