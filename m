Return-Path: <linux-kselftest+bounces-22339-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A16739D3772
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 10:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 377D01F21EB0
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 09:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1A819E997;
	Wed, 20 Nov 2024 09:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmGtNPKU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7750522318;
	Wed, 20 Nov 2024 09:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732096292; cv=none; b=hfog+KGuTVi8BRmdSKa3AhVxEVYJ45uDgU8u+HChoioUP9qt6AF/BUi7ct1GdlJ0P7Gj9/vXDRz4B5Bgb8GQRwyWGIiA67Q6rZJadO0VKFejKOtTrKq9yaDlypFoKNL6VQTIhB10sGx2qJdc7PdYTL+epRihgb5dBpNoZHtyAm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732096292; c=relaxed/simple;
	bh=8z8AJHQyS+sNb/WQ/kGSKpaStwf+sD2vm0PLcfxamok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TW24X2Yj+iHpvUnl8QhvoXTCSY6eprFHzlmxfNr3/260Feym760AE5fADXDp/L/0uokM2oM+Ra4gBf2L8VPHAMvww3QK5ulyZMhLNKwNt5mhQfAljefAnsr7IYsA3wG0eGCSQvGewvMHsDCUaiHbnjQeAsVKSHvYfbwF5ej6yoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmGtNPKU; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e91403950dso1422643a91.3;
        Wed, 20 Nov 2024 01:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732096290; x=1732701090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03TQ/vc+VXYkzrjOICzyrRqCzY7ln3nnZ3S3zhacJQ0=;
        b=CmGtNPKUJfu0ClnEk5frNXGOH6FzgQ2Ams+PUgyIqySn+TMyTAPs7IPw2Wypg3Uh5H
         vq27R5TmECgXdHHzEZjDDzuV7jLsizrYs687YNrDFL0XKm8FEfWgZGqWqwCCERVFBhCi
         tysMi052soinPxo3KbOh+iIFo4my+oSSVm/E88Eu6f35Jxf1B04VJ7/q7TuSYQRCzTzk
         19NUCV6qS9z+8ZNSHxN7rs73IPBz0WYiTX0UHY/79sRFzNqrisdGVDPb351QyMmevgxv
         0X1iKfWXEqZbaS1Jeo4REahNgdipYmURg+3F88F2qIGxFhz6lmh5NHeSwx6Fx0tp+oZi
         1B3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732096290; x=1732701090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03TQ/vc+VXYkzrjOICzyrRqCzY7ln3nnZ3S3zhacJQ0=;
        b=DZhCSg+qpi2EUEDO9i+lkonO+doTwd9pJ78Eo/LPeexaJIV+NK1nT3HQtwvGfcPFIn
         Uvx8eHfPP6x6HhnMbThiWVJHQb021Rt4CPD/Qmpw75ssLaAlwwLqqqrC4C+Uc2ehVKIu
         MJ85dKahXEWgdVIFsDF7o4kYjMacYCG3COVQBnx8UGivx2pufhzNeZ719HeM4n0VGI6j
         2eFRyrYcjNhqSx3bz7a5BTbd4/5BAewR3k8uO91TV1O4Yyvyu0NXWlFWcvAxWvkaFCPx
         yVT+v3khZHGQimRdFatHIxDW2n+njXCVWvUprdh6PlWNnaqZj6+CvcqaqRqM/JcVOIxU
         dwbA==
X-Forwarded-Encrypted: i=1; AJvYcCX2xROW8ZttMPAZmXpNCex2zCzRIxqYva8iG1CwVBKfBSAQIhErvU4x4+jyr9FlyyDoUaIt9yuZ+UkbIag=@vger.kernel.org, AJvYcCXJ0EjIt1rDN3Gp/ZKou9avOrGWpZZJK+0+s0vkB/toorb90pZovrWx0P+NCCQMuaIqKUv66SgsqYE1EncUa7x4@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4oiiYex+Bud4AEYaA4P0+uGJkdTVnTw/59b4K1uh2/hHCY/Ve
	zJLdJ+qoRoL6v0+lq4XodTRgrfPXlJgkVKpDqdZtcDAGSrjWKGcViiJmvxIVz2w=
X-Gm-Gg: ASbGncsoN93dUJqQSJKgWNmUoJn2wdD5X5HeWYqGx6hgBvYGK0RgzPEIDGQ4v9NJnZc
	axsO4/rXawIcrOQ2t29xE8jnHFoIzO/RScpxklvbCVwNKlX2PDq0Y0C3ScKwYx9xTIz38M+Vjq9
	7DxmAYFPV8emAygaI/ErUeCiZYdgW/gkXb/vr1cdl3epwFJC21+Cf5NbRcXOctQVWJHWEMK1k6V
	7LNaLGzvhVP/AaaEbYsPIE0SyS0VLoaq5gdAuLm7gjv2paO4SlH17Ew4fN/cswMA4U3Xw==
X-Google-Smtp-Source: AGHT+IE1vsmwPVlNhn+X8MM+4leTVObI2J9jlN2t6Zu6w72Yf49rvxUhGKEr/wz8xl8LK3mIPX1Vqg==
X-Received: by 2002:a17:90b:3a84:b0:2ea:77d9:634d with SMTP id 98e67ed59e1d1-2eaca7448c4mr2596753a91.17.1732096290488;
        Wed, 20 Nov 2024 01:51:30 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ead03de5bbsm887338a91.36.2024.11.20.01.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 01:51:30 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Sam Edwards <cfsworks@gmail.com>,
	=?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>,
	Alex Henrie <alexhenrie24@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net 2/2] selftests/rtnetlink.sh: add mngtempaddr test
Date: Wed, 20 Nov 2024 09:51:08 +0000
Message-ID: <20241120095108.199779-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241120095108.199779-1-liuhangbin@gmail.com>
References: <20241120095108.199779-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test to check the temporary address could be added/removed
correctly when mngtempaddr is set or removed/unmanaged.

Signed-off-by: Sam Edwards <cfsworks@gmail.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/rtnetlink.sh | 95 ++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index bdf6f10d0558..b63053202524 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -29,6 +29,7 @@ ALL_TESTS="
 	kci_test_bridge_parent_id
 	kci_test_address_proto
 	kci_test_enslave_bonding
+	kci_test_mngtmpaddr
 "
 
 devdummy="test-dummy0"
@@ -44,6 +45,7 @@ check_err()
 	if [ $ret -eq 0 ]; then
 		ret=$1
 	fi
+	[ -n "$2" ] && echo "$2"
 }
 
 # same but inverted -- used when command must fail for test to pass
@@ -1267,6 +1269,99 @@ kci_test_enslave_bonding()
 	ip netns del "$testns"
 }
 
+# Called to validate the addresses on $IFNAME:
+#
+# 1. Every `temporary` address must have a matching `mngtmpaddr`
+# 2. Every `mngtmpaddr` address must have some un`deprecated` `temporary`
+#
+# If the mngtmpaddr or tempaddr checking failed, return 0 and stop slowwait
+validate_mngtmpaddr()
+{
+	local dev=$1
+	local prefix=""
+	local addr_list=$(ip -j -n $testns addr show dev ${dev})
+	local temp_addrs=$(echo ${addr_list} | \
+		jq -r '.[].addr_info[] | select(.temporary == true) | .local')
+	local mng_prefixes=$(echo ${addr_list} | \
+		jq -r '.[].addr_info[] | select(.mngtmpaddr == true) | .local' | \
+		cut -d: -f1-4 | tr '\n' ' ')
+	local undep_prefixes=$(echo ${addr_list} | \
+		jq -r '.[].addr_info[] | select(.temporary == true and .deprecated != true) | .local' | \
+		cut -d: -f1-4 | tr '\n' ' ')
+
+	# 1. All temporary addresses (temp and dep) must have a matching mngtmpaddr
+	for address in ${temp_addrs}; do
+		prefix=$(echo ${address} | cut -d: -f1-4)
+		if [[ ! " ${mng_prefixes} " =~ " $prefix " ]]; then
+			check_err 1 "FAIL: Temporary $address with no matching mngtmpaddr!";
+			return 0
+		fi
+	done
+
+	# 2. All mngtmpaddr addresses must have a temporary address (not dep)
+	for prefix in ${mng_prefixes}; do
+		if [[ ! " ${undep_prefixes} " =~ " $prefix " ]]; then
+			check_err 1 "FAIL: No undeprecated temporary in $prefix!";
+			return 0
+		fi
+	done
+
+	return 1
+}
+
+kci_test_mngtmpaddr()
+{
+	local ret=0
+
+	setup_ns testns
+	if [ $? -ne 0 ]; then
+		end_test "SKIP mngtmpaddr tests: cannot add net namespace $testns"
+		return $ksft_skip
+	fi
+
+	# 1. Create a dummy Ethernet interface
+	run_cmd ip -n $testns link add ${devdummy} type dummy
+	run_cmd ip -n $testns link set ${devdummy} up
+	run_cmd ip netns exec $testns sysctl -w net.ipv6.conf.${devdummy}.use_tempaddr=1
+	run_cmd ip netns exec $testns sysctl -w net.ipv6.conf.${devdummy}.temp_prefered_lft=10
+	run_cmd ip netns exec $testns sysctl -w net.ipv6.conf.${devdummy}.temp_valid_lft=25
+	run_cmd ip netns exec $testns sysctl -w net.ipv6.conf.${devdummy}.max_desync_factor=1
+
+	# 2. Create several mngtmpaddr addresses on that interface.
+	# with temp_*_lft configured to be pretty short (10 and 35 seconds
+	# for prefer/valid respectively)
+	for i in $(seq 1 9); do
+		run_cmd ip -n $testns addr add 2001:db8:7e57:${i}::1/64 mngtmpaddr dev ${devdummy}
+	done
+
+	# 3. Confirm that a preferred temporary address exists for each mngtmpaddr
+	# address at all times, polling once per second for 30 seconds.
+	slowwait 30 validate_mngtmpaddr ${devdummy}
+
+	# 4. Delete each mngtmpaddr address, one at a time (alternating between
+	# deleting and merely un-mngtmpaddr-ing), and confirm that the other
+	# mngtmpaddr addresses still have preferred temporaries.
+	for i in $(seq 1 9); do
+		(( $i % 4 == 0 )) && mng_flag="mngtmpaddr" || mng_flag=""
+		if (( $i % 2 == 0 )); then
+			run_cmd ip -n $testns addr del 2001:db8:7e57:${i}::1/64 $mng_flag dev ${devdummy}
+		else
+			run_cmd ip -n $testns addr change 2001:db8:7e57:${i}::1/64 dev ${devdummy}
+		fi
+		# the temp addr should be deleted
+		validate_mngtmpaddr ${devdummy}
+	done
+
+	if [ $ret -ne 0 ]; then
+		end_test "FAIL: mngtmpaddr add/remove incorrect"
+	else
+		end_test "PASS: mngtmpaddr add/remove correctly"
+	fi
+
+	ip netns del "$testns"
+	return $ret
+}
+
 kci_test_rtnl()
 {
 	local current_test
-- 
2.46.0


