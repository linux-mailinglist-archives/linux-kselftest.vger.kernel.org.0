Return-Path: <linux-kselftest+bounces-46365-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6732BC7EF2F
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 05:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BFAD4346172
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 04:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AF12BE64C;
	Mon, 24 Nov 2025 04:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncS9EfQm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58B926FDA8
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Nov 2025 04:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763958847; cv=none; b=rdtjmv4hQA1EqefPL/rg3TX+KBcd5jJuqg0/q5wWwChbiEx0Jo7dF4rXx99867TkeCS10tln92U/NgPu95whcO8xnNhAJdfmbihrOEV1Z9Hpmj2SzdybKbYpNnmqVFfXU6JFkaDWsgxMUKvrl2IYDldMc9Nj8uRGQsfJAp1Zdxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763958847; c=relaxed/simple;
	bh=gjny3v/eTWHbeutrMbxDNE40G5kG1Ylj5usbZJzU9HE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iBZktK6H4r1CqP0HSmSqOxhyqGaCB8WPMRXeIb4s8uAWrayhjvMEXkIDWE/552OjMfGUsFo57miCQvgZ5dqjb6ufuuybp1eRbtETr88Alx+vX6GpDyIoAtEIQYz+NGdxETl/zSYeN5HU9mFv360sn1yamnBZWGcbGudCvBflwtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncS9EfQm; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-297e264528aso41532255ad.2
        for <linux-kselftest@vger.kernel.org>; Sun, 23 Nov 2025 20:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763958844; x=1764563644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUrXcfq9vgrgpVWA1902DBETXrF91GneB4Umctz9Jao=;
        b=ncS9EfQmiMFL266TefhElJaMkKhf5pc67o85sqgo6BMeEyfxxiazVjuVtgVO30wLwR
         s1z0mqDDeWfWAnUiAB5PXUiZLlKTEho7zVncEzunfU+ZSTP3j9tMyW2JiyJZcXF8ajiB
         o1Jj7YInBi27/SF/rhi7nutErWdbnbRVmUdPkCQYG+zIuOJc67gbSZMiLgAfiHIh5ASh
         APBPcu6EccZW6OLqa5ABa0zKK+fL1lNXhUPrNNlGMuVHGo9pJIdz4jiPku1Esw7JZwZm
         a0ZRMJOZYG3C5BMclJ7rrBER3uW0foEd4RWQPEKGosNSjo9U0zEuT8jxOB/XMpe7mhRa
         y5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763958844; x=1764563644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OUrXcfq9vgrgpVWA1902DBETXrF91GneB4Umctz9Jao=;
        b=ZvIWUTw56KL8jE+YQsAexnimNfav8LIFLQNFl3NUTUwq6+vXE2YbA00yQ0ksD1B/8H
         x6Kq2hNDwrPEo7ZIog2mPGUhl6KrlP5aBnRWQRblQYKUt6rr+LdN7JqYr1cv4L5FVYa/
         3S+jlOqMqVtwml14MQPDbmK4WNrMUbGzW3x71FldSnJotkZEMP/pHf+wcZKiyJEyij4w
         S/XavAEPUCawWIXABLDT1KrHGshRA8cr+ITJ5JZOfXkc6PeEwDKxh5kW1Rn0zIqdsLih
         W+Trw2854Ju2JNYkfwxWyYzIC3gpupT7OmhUxyffLRSpmjr1D5fXNfcQYBb37gu+kd7d
         rdcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlRHjmxiN/5cmYXjoDqizSG7rnmu3+DSYDfndBP/wpgD161oP/KWj7cYRyedqzeOMsUtOBclt9nhlcVw4SpIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBtZGQZlV9GuOQFl7Bt+MOLfTN0G4pkj4fC4lQsXQQdI/NQ7+N
	mmUQl1ISk0ocGbfngw4VBQjwoDDjFMzRcAIqR+Xkco0JctUoPDBC8BEm
X-Gm-Gg: ASbGnctj1fvlCxXqfXejnx1Nk2TJGPX5wptuzy/CE7wFB6xUT8BxP48a2o5DHkfQD61
	v07vce4uhPFglechmHOQ7GzF5PRDmaiPWIkD0mu4o7G1cDQCJ/HUdTe7fw6IWMIeNqyQnFTZOnG
	kUdZ6BPxjE/zxINf4uwmVytotUZATp9NyPP6G0Ni0QpzgCWGb35iZVU+DnX3XCwvNFeyETCOmb9
	yyAt/+Q2yM0q+QqRHMyIJcQlFrCehBdpWrM0o61s4B3WaHrivYYj40hdZI9tPKvW/rOf3lp+zm3
	Oeidozha7BHcHQ+W2BDiEKEeiJuzVWLACIlZIPUK7vdGEm73syzH0mwi8RFHfE8cpjFzrWZuVC1
	zw35WxL/iJ3y1AVD9LuJbeH1jxj2SRRBMAGdXWhyL+A4gcQERc6TDwlDGL/fv9sCUdFTZEidB+F
	H3FqY2OZT9pAVIKVk=
X-Google-Smtp-Source: AGHT+IHzZbGSEFGQuemPw85evFvVCC+Eai0oeIOUa5YVq58nYvmhhMSbHtXIId00/UrGD+zfBkF1iQ==
X-Received: by 2002:a17:90b:3fc3:b0:343:d70e:bef0 with SMTP id 98e67ed59e1d1-34733f19bc5mr10892764a91.21.1763958843988;
        Sun, 23 Nov 2025 20:34:03 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345af0fcc0csm10359878a91.0.2025.11.23.20.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 20:34:03 -0800 (PST)
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
Subject: [PATCH net 3/3] selftests: bonding: add mux and churn state testing
Date: Mon, 24 Nov 2025 04:33:10 +0000
Message-ID: <20251124043310.34073-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251124043310.34073-1-liuhangbin@gmail.com>
References: <20251124043310.34073-1-liuhangbin@gmail.com>
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


