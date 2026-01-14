Return-Path: <linux-kselftest+bounces-48910-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD3DD1CB97
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 07:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C419E302B74A
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 06:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAA1374171;
	Wed, 14 Jan 2026 06:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmK5eLTd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE4736E482
	for <linux-kselftest@vger.kernel.org>; Wed, 14 Jan 2026 06:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768373409; cv=none; b=cF2u18BA8giHhy7NbmFimnPzXKgbxaiWm629IdB6cnpNx3mqEYV27yd1GqJ8oKHXLcLqHPT9Y6maxVy5zHIzp+paJvfQJIPd6ZKybo/vbLHpRXKd6Km7iV6TcvKapYrTEkX7ePhD7Wtzs9vON9/mhZqVLvnwwupbNhz0wd9gHUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768373409; c=relaxed/simple;
	bh=gjny3v/eTWHbeutrMbxDNE40G5kG1Ylj5usbZJzU9HE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gy+rqh7su8328HWT71D56pohwTPsVOXb8ttB0fGg3aG14gbtJgZA9UYnvjvTaGMoTAcsmgUtPYNILBV1VPEyf2ZQxU5SO8QNwoXzmmUaDY75oNT1D+N7JRVELrB+GlsV+kOPqrQlsfhx3vB+E2yBmHmLGbrRAvw77n7an7v7xHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmK5eLTd; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a0d5c365ceso55946705ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 22:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768373401; x=1768978201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUrXcfq9vgrgpVWA1902DBETXrF91GneB4Umctz9Jao=;
        b=PmK5eLTdY6j4wVv2M7NUvo1c/plrC9mkDenDmKV4dNK24GPj5OS/FIZIWUc5DzU0LB
         zItpJQe6x2aMeAcsY9qsvpXnAztoNh3+AWrRAeliOurbjKifSdKYkO4PtDReSJdL6nx4
         kHMV62Dt0VFG+KQ7Fnr5uXeJlzmCICuUCu6azAnIm7gixCcxxziNoeVM1YB2At4jXxO/
         kfpMzH2xcj6so0WBBNrz8fIOc5/IusrL0p9N6WNVZthiuTdtEcdjlbcLi9/3WR6stpZK
         qHTb4JWDH0FWuZ9M8G4gASXwr81hD1kqnM6po3w/tjRgu0zUn7kucTLbI95qrSGshGrM
         lRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768373401; x=1768978201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OUrXcfq9vgrgpVWA1902DBETXrF91GneB4Umctz9Jao=;
        b=BIn1+/5lNxB6U/dUSVF5Vq2zU2jWSXPQEp0O7h7jpq9kO8KLNOt93TG6D/tRBPsz/K
         /If9e1PYgxqbxvC7LuJK3pkBBIULQaZzNMjrH8jmYnRoEXBdZq2DRCTvG+3etN3v2bIn
         W9uIeDXUhYQH/CUy/PNGKrRGTHoq0qCwmtS/QYRPz9SFzCBO/psSJhMRVKqLK3t27VpM
         olb0eyMFU1i8Zlx1sZ+vas7r22RfDW6Cixmi/mNHXtaB4Zu/0fBdC3Cwqj9qcS3DN8Rk
         MxkQ6gZO/YHyb3CySyooFZS9kkoqhgTn5SkbbeLsWRyJLEymb3SBdrXC8baWuuRhI/bO
         iBhw==
X-Forwarded-Encrypted: i=1; AJvYcCXr66VEYwHFCrsikFp6NN2Z2zqBFg1pYXtSIIrrAPfY9xQpOVBKe0SZ/24d5Xyi01Hd5sWYpZJkaMJYM20lvv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTXtNvU9hXphvfFdfJ/3v0WNF9S6UPhJu5CF67Zov5tCOTeg2o
	+k68EnPdnIg24q5VMPa5Tic+9NdvAz7P/BUlqCJw+DDCoQwNVzuqorGA
X-Gm-Gg: AY/fxX6KatawibSt6hmKdnCI5YWP57a2gnFzCYIR9uCVHHcv8XBH1ParX22uGKXfTLO
	pB1cYRfA60R5twUNP4z3+zoW3qT0XpMN4V5HFvZwxThueSUPYT5xgEK+qpY6Ae7fiEqTsJiFMNR
	9VAO6pyocIgbzlTxbTChVo5rn7AfClHEw3HQvE0yebgm/w7ykmJAUmpJA+1VJaQhZvzjaAmpUMH
	SOMh6NwynNep4iIKShjZx5rjlllOxjdab1RsxTv845rxE/WDGjdTz2B8OVZtW49WkZNv3iseTDE
	5jMaAX9+QrlRj/sz0yx+68i4F6YltMOmF3sug4AvokWB58A9TpBiZNu1sckthCg1APteWAeKyII
	HXGhzrCqRnvxaH8bXWq3GTG1SzHWIANzwR3DJeezP2CEZneo8jkKo+0YT9PcMPyrbgzFJKQySxR
	dzl2360t1FGhCJSHvYIkM77pGkwA==
X-Received: by 2002:a17:902:f78b:b0:2a0:fe9f:1884 with SMTP id d9443c01a7336-2a599e585d5mr19091275ad.55.1768373400756;
        Tue, 13 Jan 2026 22:50:00 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cd492fsm96315525ad.98.2026.01.13.22.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 22:50:00 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Mahesh Bandewar <maheshb@google.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 3/3] selftests: bonding: add mux and churn state testing
Date: Wed, 14 Jan 2026 06:49:21 +0000
Message-ID: <20260114064921.57686-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260114064921.57686-1-liuhangbin@gmail.com>
References: <20260114064921.57686-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the current LACP priority test to LACP ad_select testing, and
extend it to include validation of the actor state machine and churn
state logic. The updated tests verify that both the mux state machine and
the churn state machine behave correctly under aggregator selection and
failover scenarios.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 .../selftests/drivers/net/bonding/Makefile    |  2 +-
 ...nd_lacp_prio.sh => bond_lacp_ad_select.sh} | 73 +++++++++++++++++++
 2 files changed, 74 insertions(+), 1 deletion(-)
 rename tools/testing/selftests/drivers/net/bonding/{bond_lacp_prio.sh => bond_lacp_ad_select.sh} (64%)

diff --git a/tools/testing/selftests/drivers/net/bonding/Makefile b/tools/testing/selftests/drivers/net/bonding/Makefile
index 6c5c60adb5e8..e7bddfbf0f7a 100644
--- a/tools/testing/selftests/drivers/net/bonding/Makefile
+++ b/tools/testing/selftests/drivers/net/bonding/Makefile
@@ -7,7 +7,7 @@ TEST_PROGS := \
 	bond-eth-type-change.sh \
 	bond-lladdr-target.sh \
 	bond_ipsec_offload.sh \
-	bond_lacp_prio.sh \
+	bond_lacp_ad_select.sh \
 	bond_macvlan_ipvlan.sh \
 	bond_options.sh \
 	bond_passive_lacp.sh \
diff --git a/tools/testing/selftests/drivers/net/bonding/bond_lacp_prio.sh b/tools/testing/selftests/drivers/net/bonding/bond_lacp_ad_select.sh
similarity index 64%
rename from tools/testing/selftests/drivers/net/bonding/bond_lacp_prio.sh
rename to tools/testing/selftests/drivers/net/bonding/bond_lacp_ad_select.sh
index a483d505c6a8..9f0b3de4f55c 100755
--- a/tools/testing/selftests/drivers/net/bonding/bond_lacp_prio.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond_lacp_ad_select.sh
@@ -89,6 +89,65 @@ test_agg_reselect()
 		RET=1
 }
 
+is_distributing()
+{
+	ip -j -n "$c_ns" -d link show "$1" \
+		| jq -e '.[].linkinfo.info_slave_data.ad_actor_oper_port_state_str | index("distributing")' > /dev/null
+}
+
+get_churn_state()
+{
+	local slave=$1
+	# shellcheck disable=SC2016
+	ip netns exec "$c_ns" awk -v s="$slave" '
+	$0 ~ "Slave Interface: " s {found=1}
+	found && /Actor Churn State:/ { print $4; exit }
+	' /proc/net/bonding/bond0
+}
+
+check_slave_state()
+{
+	local state=$1
+	local slave_0=$2
+	local slave_1=$3
+	local churn_state
+	RET=0
+
+	s0_agg_id=$(cmd_jq "ip -n ${c_ns} -d -j link show $slave_0" \
+		".[].linkinfo.info_slave_data.ad_aggregator_id")
+	s1_agg_id=$(cmd_jq "ip -n ${c_ns} -d -j link show $slave_1" \
+		".[].linkinfo.info_slave_data.ad_aggregator_id")
+	if [ "${s0_agg_id}" -ne "${s1_agg_id}" ]; then
+		log_info "$state: $slave_0 $slave_1 agg ids are different"
+		RET=1
+	fi
+
+	for s in "$slave_0" "$slave_1"; do
+		churn_state=$(get_churn_state "$s")
+		if [ "$state" = "active" ]; then
+			if ! is_distributing "$s"; then
+				log_info "$state: $s is not in distributing state"
+				RET=1
+			fi
+			if [ "$churn_state" != "none" ]; then
+				log_info "$state: $s churn state $churn_state"
+				RET=1
+			fi
+		else
+			# Backup state, should be in churned and not distributing
+			if is_distributing "$s"; then
+				log_info "$state: $s is in distributing state"
+				RET=1
+			fi
+			if [ "$churn_state" != "churned" ]; then
+				log_info "$state: $s churn state $churn_state"
+				# shellcheck disable=SC2034
+				RET=1
+			fi
+		fi
+	done
+}
+
 trap cleanup_all_ns EXIT
 setup_ns c_ns s_ns b_ns
 setup_links
@@ -98,11 +157,25 @@ log_test "bond 802.3ad" "actor_port_prio setting"
 
 test_agg_reselect eth0
 log_test "bond 802.3ad" "actor_port_prio select"
+# sleep for a while to make sure the mux state machine has completed.
+sleep 10
+check_slave_state active eth0 eth1
+log_test "bond 802.3ad" "active state/churn checking"
+# wait for churn timer expired, need a bit longer as we restart eth1
+sleep 55
+check_slave_state backup eth2 eth3
+log_test "bond 802.3ad" "backup state/churn checking"
 
 # Change the actor port prio and re-test
 ip -n "${c_ns}" link set eth0 type bond_slave actor_port_prio 10
 ip -n "${c_ns}" link set eth2 type bond_slave actor_port_prio 1000
 test_agg_reselect eth2
 log_test "bond 802.3ad" "actor_port_prio switch"
+sleep 10
+check_slave_state active eth2 eth3
+log_test "bond 802.3ad" "active state/churn checking"
+sleep 55
+check_slave_state backup eth0 eth1
+log_test "bond 802.3ad" "backup state/churn checking"
 
 exit "${EXIT_STATUS}"
-- 
2.50.1


