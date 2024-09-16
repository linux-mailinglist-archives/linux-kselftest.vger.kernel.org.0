Return-Path: <linux-kselftest+bounces-18037-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 031D5979EB0
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 11:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 224E41C20308
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2024 09:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE19014A0A3;
	Mon, 16 Sep 2024 09:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hrikar6A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007FE1CF83;
	Mon, 16 Sep 2024 09:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726480168; cv=none; b=J/QY+ufMG6cLEuUY31N7KX3Opy9zaPQbyHJ7U6kR9km6fq2nxOiA+qbl7aRnNJb+HH1MxbtJA0p2KbztPTXElLzkhwl5FOcfjf0U3kR/haJrQveBCin/M9ALvpN2B/dLwMvsaEaWJOPWPYPbjrQhhksCAdQkvLo7I0EquwZAE2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726480168; c=relaxed/simple;
	bh=Fezmf/xSYYA+2Rp5prhtsDNAElh7xq591BRP3qfI9to=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rh71YsOSg2FY2mUDOtroVEWiFaGCPTQzTqnQs+4wTJAUuc18ERy3tLnIznPvpPPPaNKS+kvPHN8GVsAT57oN3/p3VfFg5hdHwhWWQMrrT0xe5I0hhqVe/DdbyoBGPkcuoc6f2J4lGgO/jrSbEjbsOKKgyLnXhjkxYQcv03qMFJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hrikar6A; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-206b9455460so31782885ad.0;
        Mon, 16 Sep 2024 02:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726480166; x=1727084966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=agEM9Bnjv/wIh4lqw0cG9MefC44dMCYZWQLQqTZdFTw=;
        b=Hrikar6AtetL8V37gB9UKh6AuYi4VkHWt/+AJO54CG7JznowgcHImkB/vljr16kIOY
         mvYBDPlw3TVGtimVFDHX8kHFAouBqVTIM2+/LyDSiURcMG3rXuqfvOQ4fPA5rHH1Iy9t
         YFOLMmSYJ7Lm+Rm3Scm3G45ih+4ic8/wwckOKye6Ko8n5hEc7dXxh/bVqyC27h/N/Hhi
         oKyC2YP4p1bAdg4txI5MryRLvokrCwj7L5PCIUQ4oriHqZydELh++sbcFi0y/Iyv/lti
         ijdClJZg2gANkvSYAoymiWtQRg7cXeN/0ubi9Ap6LdeAKpc876JouTTcEMiqexrM0Hnb
         bHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726480166; x=1727084966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=agEM9Bnjv/wIh4lqw0cG9MefC44dMCYZWQLQqTZdFTw=;
        b=ouX7gCDzpuQkc8xb6Dl3PS8NRoRmIUG48bP79pC9c4iA2teT0O5+W+vRt/oXxCXU9W
         WqtYSpJ0Lmh4wKSHxpO2leO9hzC6K36dNxqzxbEyFCcgrQKXSo8dwElWyJjkMme34EZD
         i5GTtPazydCYEo05ZeEsKmnbYHK6Rk6Cy3AO7K7UIQYmGDQFDN38f2yVQWczw9agaPPv
         MHmlAKPkmrbFTPjL+3/wwaSme2mMgLAki4J8HNZpNfu2qn6PU4ulXc3Gbab4isTM8sSb
         po3OPOSkMBTXzcfaUaVMM8i+tqi+RsLEzZ7tPKBBLr6M5gGS5+SaibQ0VMGbWGSzPoxt
         9qTQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/zZFGhhzE+oPvwCVlhhIqxfKIG/UVc2oEJq2ZQtFPh5YNQC+eTxnpGiLsAEAPBZ81muIay5se@vger.kernel.org, AJvYcCVS/8vXWF6DlcskVzHmLH5cVZqw9GfE1Ta8e5ui2j4iK8c42zMuljtgkqMagGEFvYgEm4CIAA6DmY3vYUz3+Ghc@vger.kernel.org, AJvYcCWP970qUG6mAhStauRhL24gFQsaRr4VJS6XUukDGLejp7DglP3fSt9AQukG30lvfNV3WcFE83wIf5E5mls=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxGZWTphXbQaWYQ5OUDQpkkg66z0XjaC04cgaFI1mAK2i4v3lF
	M3QmK1XaeqTUdil1mda9g3cbXFDqSJB7hgZrs0rgqL75zb863732
X-Google-Smtp-Source: AGHT+IF/8LADqxUJsInaUBiMLuBfWpa5XVS3tiDK6OKzHNTW5GsosmpZWdz0yIzhFtWEyhd9ltYzow==
X-Received: by 2002:a17:902:d4ce:b0:1fd:96c7:24f5 with SMTP id d9443c01a7336-2074c5d2351mr264320415ad.5.1726480165906;
        Mon, 16 Sep 2024 02:49:25 -0700 (PDT)
Received: from localhost.localdomain ([159.196.197.79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946fccc1sm33018905ad.214.2024.09.16.02.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 02:49:25 -0700 (PDT)
From: Jamie Bainbridge <jamie.bainbridge@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: Jamie Bainbridge <jamie.bainbridge@gmail.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] selftests: forwarding: Avoid false MDB delete/flush failures
Date: Mon, 16 Sep 2024 19:49:05 +1000
Message-Id: <c92569919307749f879b9482b0f3e125b7d9d2e3.1726480066.git.jamie.bainbridge@gmail.com>
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

Create a delay variable just for this test to allow short sleep, the
lib.sh WAIT_TIME of 5 seconds makes the test far longer than necessary.

Tested on several weak systems with 0.1s delay:
- Ivy Bridge Celeron netbook (2014 x86_64)
- Raspberry Pi 3B (2016 aarch64)
- Small KVM VM on Intel 10th gen (2020 x86_64)
All these systems ran 25 test runs in a row with 100% pass OK.

Fixes: b6d00da08610 ("selftests: forwarding: Add bridge MDB test")
Signed-off-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>
---
v2: Avoid false check failures as seen by Jakub Kicinski.
---
 .../selftests/net/forwarding/bridge_mdb.sh    | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb.sh b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
index d9d587454d207931a539f59be15cbc63d471888f..49136279973d05d0e6b14237228ab58455554bb0 100755
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
@@ -970,6 +997,7 @@ cfg_test_flush()
 	check_err $? "Host entry flushed by wrong routing protocol"
 
 	bridge mdb flush dev br0
+	sleep "$SETTLE_DELAY"
 
 	# Test that an error is returned when trying to flush using unsupported
 	# parameters.
-- 
2.39.2


