Return-Path: <linux-kselftest+bounces-17927-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9203A977C6F
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 11:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52CF32836DF
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 09:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127151D86C0;
	Fri, 13 Sep 2024 09:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qwc6QOZH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2E21BD4EA;
	Fri, 13 Sep 2024 09:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726220424; cv=none; b=OeJ/f91lcAACdRs0RH+Fuzy1eP+CfljrQyYEnJlB3V2N3pyCBCvTYSU55Gsft0yi9rQiOcm7sZWPFlIl2zds0cvi3wGZF0DztIFcie7O3tgK6dw4I/oBgmyHwFE9+6uawFMX+6qwyCVx7yNhV/fE6QRHo42JCrcheAvBSRbgjbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726220424; c=relaxed/simple;
	bh=X4fAQMAelUS9clyaz9OffqdwJw26k8f3MTc5hg05xxU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jjHQB2ixdk+kl4tNCgTKxJ/fpvE7zXBxmntoKNKxqcByEHB7Xhc/NeNhzyvRCL8K9dXbSYsmg6PP2yqvUzgwOqJQe890XgMDMpMz8b0fRzbkF2bpwbl5jaWniBO7i7+ETMNiQ28CgOw7dKTCcg66aW2CyWNTx7Rn5CTvQ1Zqx5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qwc6QOZH; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7191ee537cbso1449816b3a.2;
        Fri, 13 Sep 2024 02:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726220422; x=1726825222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i8ygMJ5LTZc1fQF15LFQbHHeNTeiKVtqwTRi7OzD+wk=;
        b=Qwc6QOZHmDEwdZK82iThzXGuOUsZEB0AjuFzS4BkY448HCPSFBZsbX/IQigSP4Xeov
         Pb/FgRfCiQ3YdPOOeQiXLp5AobwInstAtrALciJgS8qYH98ll3Mr9xC+cCUqscZTsB+T
         CBseYXqgYmeULY+RcBnKunwNxsMv6QdGDTq99sw8McJTgK2fW6EGgVNZu1PGFMEGjJCo
         QpR2ong6z1NkmMBa5X9IEYaHvCpwsePTjc4marNcsStmhzVt/fUD5VR9co871WPYb6BB
         guVmCMQmU3iYGhWydccezsk2MdR3AQaCqYp/jqU5Juyn79hw/WY83LpliU7qCmDWEsz5
         +dAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726220422; x=1726825222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i8ygMJ5LTZc1fQF15LFQbHHeNTeiKVtqwTRi7OzD+wk=;
        b=DVjyWetG5YjeaeTpxxdz6Qqxg7myZcP3ryXgfxRCFeG8g+GZVhlAHdpvItANaBIurK
         y891QWxzLp7N210erNiPhAqx6IaB7DFG7HBjRRzgwVx+uagc+u5oSRBjFvtMeQQ1jdbR
         v0tOT7c5zHuDgBux95kMHdKfcmgJDiO2bC1wuxVMK39Ofv9odl8Jh0Cs5MB50vI5Tmh3
         EF05phpJ8AFAyvL5QEVs3uLFEAcjBna1552rW0KpoEMkUIr2NGzHvTjFUHhR1x77zcTV
         kIQxHHdCjqmK0HrtOZjftL8260oZXH+OFjxyVBwNMOK1W5d9Au6Q2k8zMyYujvvDOQbB
         oBBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV031oU5Sjg0JNPYTxZHtA9AIY668hORH7/0gMKAvZT62bIQ8dPp/dmcpwAdlmmv4K9hvhqczwSy0qbR3rsbbHD@vger.kernel.org, AJvYcCXESektIS0vFZLpY4z0Y9ka4DE/fdb+5u2dS692roDvF6Ox2i22ngUHAX8xTBs2G5fOC68HQ4mQ@vger.kernel.org, AJvYcCXEU4o0nMxJgzm3CKy1aD5LeiskZKa2cG/vp+kSZ+hNgXrnHXmkH77Y0MvnsO9btIdT6WRFRa4B0dNCzeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnGGVTpDP8SrzHNK2sXkcC2F6nPhvh4CaZqhaZNgqUWjQ2D0oa
	TINwtWkWC+XjjZuW0Oyvl5IH2OxZ3MZOKZBDDcFv36J5OX5CE9eh
X-Google-Smtp-Source: AGHT+IGSmMWfT8V1KS8SDbuat+WOLdwEW4lNv0Riu16Ao10Gy0TcpLnW7C1BNh2/GSQSEuiyVal5sw==
X-Received: by 2002:a05:6a00:1988:b0:718:d573:25b9 with SMTP id d2e1a72fcca58-719260931a7mr7714812b3a.16.1726220421516;
        Fri, 13 Sep 2024 02:40:21 -0700 (PDT)
Received: from localhost.localdomain ([159.196.197.79])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-719090d469bsm5738932b3a.210.2024.09.13.02.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 02:40:21 -0700 (PDT)
From: Jamie Bainbridge <jamie.bainbridge@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: Jamie Bainbridge <jamie.bainbridge@gmail.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] selftests: forwarding: Avoid false MDB delete/flush failures
Date: Fri, 13 Sep 2024 19:40:04 +1000
Message-Id: <b77ab871df2475df37aa29672c9bbcc33d03e90f.1726220359.git.jamie.bainbridge@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Running this test on a small system produces different failures every
test checking deletions, and some flushes. From different test runs:

TEST: Common host entries configuration tests (L2)                [FAIL]
  Failed to delete L2 host entry

TEST: Common port group entries configuration tests (IPv4 (S, G)) [FAIL]
  IPv4 (S, G) entry with VLAN 10 not deleted when VLAN was not specified

TEST: Common port group entries configuration tests (IPv6 (*, G)) [FAIL]
  IPv6 (*, G) entry with VLAN 10 not deleted when VLAN was not specified

TEST: Flush tests                                                 [FAIL]
  Entry not flushed by specified VLAN ID

TEST: Flush tests                                                 [FAIL]
  IPv6 host entry not flushed by "nopermanent" state

Add a short sleep after deletion and flush to resolve this.

Tested using 25 test runs in a row, resulting in 100% pass OK.

Create a variable just for this test to allow short sleep, the default
WAIT_TIME of 5 seconds makes the test far longer than necessary.

Fixes: b6d00da08610 ("selftests: forwarding: Add bridge MDB test")
Signed-off-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>
---
 .../selftests/net/forwarding/bridge_mdb.sh    | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb.sh b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
index d9d587454d207931a539f59be15cbc63d471888f..b3a2a7bc1824f4c394267b283b89e7a3ae19b0fb 100755
--- a/tools/testing/selftests/net/forwarding/bridge_mdb.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
@@ -30,6 +30,9 @@ ALL_TESTS="
 	ctrl_test
 "
 
+# time to wait for delete and flush to complete
+: "${SETTLE_DELAY:=0.1}"
+
 NUM_NETIFS=4
 source lib.sh
 source tc_common.sh
@@ -152,6 +155,7 @@ cfg_test_host_common()
 	check_fail $? "Managed to replace $name host entry"
 
 	bridge mdb del dev br0 port br0 grp $grp $state vid 10
+	sleep "$SETTLE_DELAY"
 	bridge mdb get dev br0 grp $grp vid 10 &> /dev/null
 	check_fail $? "Failed to delete $name host entry"
 
@@ -208,6 +212,7 @@ cfg_test_port_common()
 	check_err $? "Failed to replace $name entry"
 
 	bridge mdb del dev br0 port $swp1 $grp_key permanent vid 10
+	sleep "$SETTLE_DELAY"
 	bridge mdb get dev br0 $grp_key vid 10 &> /dev/null
 	check_fail $? "Failed to delete $name entry"
 
@@ -230,6 +235,7 @@ cfg_test_port_common()
 	check_err $? "$name entry with VLAN 20 not added when VLAN was not specified"
 
 	bridge mdb del dev br0 port $swp1 $grp_key permanent
+	sleep "$SETTLE_DELAY"
 	bridge mdb get dev br0 $grp_key vid 10 &> /dev/null
 	check_fail $? "$name entry with VLAN 10 not deleted when VLAN was not specified"
 	bridge mdb get dev br0 $grp_key vid 20 &> /dev/null
@@ -310,6 +316,7 @@ __cfg_test_port_ip_star_g()
 	bridge -d mdb get dev br0 grp $grp src $src1 vid 10 &> /dev/null
 	check_err $? "(S, G) entry not created"
 	bridge mdb del dev br0 port $swp1 grp $grp vid 10
+	sleep "$SETTLE_DELAY"
 	bridge -d mdb get dev br0 grp $grp vid 10 &> /dev/null
 	check_fail $? "(*, G) entry not deleted"
 	bridge -d mdb get dev br0 grp $grp src $src1 vid 10 &> /dev/null
@@ -828,6 +835,7 @@ cfg_test_flush()
 	bridge mdb add dev br0 port $swp1 grp 239.1.1.8 vid 10 temp
 
 	bridge mdb flush dev br0
+	sleep "$SETTLE_DELAY"
 	num_entries=$(bridge mdb show dev br0 | wc -l)
 	[[ $num_entries -eq 0 ]]
 	check_err $? 0 "Not all entries flushed after flush all"
@@ -840,6 +848,7 @@ cfg_test_flush()
 	bridge mdb add dev br0 port br0 grp 239.1.1.1 vid 10
 
 	bridge mdb flush dev br0 port $swp1
+	sleep "$SETTLE_DELAY"
 
 	bridge mdb get dev br0 grp 239.1.1.1 vid 10 | grep -q "port $swp1"
 	check_fail $? "Entry not flushed by specified port"
@@ -849,11 +858,13 @@ cfg_test_flush()
 	check_err $? "Host entry flushed by wrong port"
 
 	bridge mdb flush dev br0 port br0
+	sleep "$SETTLE_DELAY"
 
 	bridge mdb get dev br0 grp 239.1.1.1 vid 10 | grep -q "port br0"
 	check_fail $? "Host entry not flushed by specified port"
 
 	bridge mdb flush dev br0
+	sleep "$SETTLE_DELAY"
 
 	# Check that when flushing by VLAN ID only entries programmed with the
 	# specified VLAN ID are flushed and the rest are not.
@@ -864,6 +875,7 @@ cfg_test_flush()
 	bridge mdb add dev br0 port $swp2 grp 239.1.1.1 vid 20
 
 	bridge mdb flush dev br0 vid 10
+	sleep "$SETTLE_DELAY"
 
 	bridge mdb get dev br0 grp 239.1.1.1 vid 10 &> /dev/null
 	check_fail $? "Entry not flushed by specified VLAN ID"
@@ -871,6 +883,7 @@ cfg_test_flush()
 	check_err $? "Entry flushed by wrong VLAN ID"
 
 	bridge mdb flush dev br0
+	sleep "$SETTLE_DELAY"
 
 	# Check that all permanent entries are flushed when "permanent" is
 	# specified and that temporary entries are not.
@@ -879,6 +892,7 @@ cfg_test_flush()
 	bridge mdb add dev br0 port $swp2 grp 239.1.1.1 temp vid 10
 
 	bridge mdb flush dev br0 permanent
+	sleep "$SETTLE_DELAY"
 
 	bridge mdb get dev br0 grp 239.1.1.1 vid 10 | grep -q "port $swp1"
 	check_fail $? "Entry not flushed by \"permanent\" state"
@@ -886,6 +900,7 @@ cfg_test_flush()
 	check_err $? "Entry flushed by wrong state (\"permanent\")"
 
 	bridge mdb flush dev br0
+	sleep "$SETTLE_DELAY"
 
 	# Check that all temporary entries are flushed when "nopermanent" is
 	# specified and that permanent entries are not.
@@ -894,6 +909,7 @@ cfg_test_flush()
 	bridge mdb add dev br0 port $swp2 grp 239.1.1.1 temp vid 10
 
 	bridge mdb flush dev br0 nopermanent
+	sleep "$SETTLE_DELAY"
 
 	bridge mdb get dev br0 grp 239.1.1.1 vid 10 | grep -q "port $swp1"
 	check_err $? "Entry flushed by wrong state (\"nopermanent\")"
@@ -901,6 +917,7 @@ cfg_test_flush()
 	check_fail $? "Entry not flushed by \"nopermanent\" state"
 
 	bridge mdb flush dev br0
+	sleep "$SETTLE_DELAY"
 
 	# Check that L2 host entries are not flushed when "nopermanent" is
 	# specified, but flushed when "permanent" is specified.
@@ -908,16 +925,19 @@ cfg_test_flush()
 	bridge mdb add dev br0 port br0 grp 01:02:03:04:05:06 permanent vid 10
 
 	bridge mdb flush dev br0 nopermanent
+	sleep "$SETTLE_DELAY"
 
 	bridge mdb get dev br0 grp 01:02:03:04:05:06 vid 10 &> /dev/null
 	check_err $? "L2 host entry flushed by wrong state (\"nopermanent\")"
 
 	bridge mdb flush dev br0 permanent
+	sleep "$SETTLE_DELAY"
 
 	bridge mdb get dev br0 grp 01:02:03:04:05:06 vid 10 &> /dev/null
 	check_fail $? "L2 host entry not flushed by \"permanent\" state"
 
 	bridge mdb flush dev br0
+	sleep "$SETTLE_DELAY"
 
 	# Check that IPv4 host entries are not flushed when "permanent" is
 	# specified, but flushed when "nopermanent" is specified.
@@ -925,16 +945,19 @@ cfg_test_flush()
 	bridge mdb add dev br0 port br0 grp 239.1.1.1 temp vid 10
 
 	bridge mdb flush dev br0 permanent
+	sleep "$SETTLE_DELAY"
 
 	bridge mdb get dev br0 grp 239.1.1.1 vid 10 &> /dev/null
 	check_err $? "IPv4 host entry flushed by wrong state (\"permanent\")"
 
 	bridge mdb flush dev br0 nopermanent
+	sleep "$SETTLE_DELAY"
 
 	bridge mdb get dev br0 grp 239.1.1.1 vid 10 &> /dev/null
 	check_fail $? "IPv4 host entry not flushed by \"nopermanent\" state"
 
 	bridge mdb flush dev br0
+	sleep "$SETTLE_DELAY"
 
 	# Check that IPv6 host entries are not flushed when "permanent" is
 	# specified, but flushed when "nopermanent" is specified.
@@ -942,16 +965,19 @@ cfg_test_flush()
 	bridge mdb add dev br0 port br0 grp ff0e::1 temp vid 10
 
 	bridge mdb flush dev br0 permanent
+	sleep "$SETTLE_DELAY"
 
 	bridge mdb get dev br0 grp ff0e::1 vid 10 &> /dev/null
 	check_err $? "IPv6 host entry flushed by wrong state (\"permanent\")"
 
 	bridge mdb flush dev br0 nopermanent
+	sleep "$SETTLE_DELAY"
 
 	bridge mdb get dev br0 grp ff0e::1 vid 10 &> /dev/null
 	check_fail $? "IPv6 host entry not flushed by \"nopermanent\" state"
 
 	bridge mdb flush dev br0
+	sleep "$SETTLE_DELAY"
 
 	# Check that when flushing by routing protocol only entries programmed
 	# with the specified routing protocol are flushed and the rest are not.
@@ -961,6 +987,7 @@ cfg_test_flush()
 	bridge mdb add dev br0 port br0 grp 239.1.1.1 vid 10
 
 	bridge mdb flush dev br0 proto bgp
+	sleep "$SETTLE_DELAY"
 
 	bridge mdb get dev br0 grp 239.1.1.1 vid 10 | grep -q "port $swp1"
 	check_fail $? "Entry not flushed by specified routing protocol"
@@ -970,20 +997,25 @@ cfg_test_flush()
 	check_err $? "Host entry flushed by wrong routing protocol"
 
 	bridge mdb flush dev br0
+	sleep "$SETTLE_DELAY"
 
 	# Test that an error is returned when trying to flush using unsupported
 	# parameters.
 
 	bridge mdb flush dev br0 src_vni 10 &> /dev/null
+	sleep "$SETTLE_DELAY"
 	check_fail $? "Managed to flush by source VNI"
 
 	bridge mdb flush dev br0 dst 198.51.100.1 &> /dev/null
+	sleep "$SETTLE_DELAY"
 	check_fail $? "Managed to flush by destination IP"
 
 	bridge mdb flush dev br0 dst_port 4789 &> /dev/null
+	sleep "$SETTLE_DELAY"
 	check_fail $? "Managed to flush by UDP destination port"
 
 	bridge mdb flush dev br0 vni 10 &> /dev/null
+	sleep "$SETTLE_DELAY"
 	check_fail $? "Managed to flush by destination VNI"
 
 	log_test "Flush tests"
-- 
2.39.2


