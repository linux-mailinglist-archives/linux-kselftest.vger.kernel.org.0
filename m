Return-Path: <linux-kselftest+bounces-21924-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA2C9C6FCB
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 13:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EF13288BA8
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 12:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F792038CC;
	Wed, 13 Nov 2024 12:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZORVkgE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A9A203715;
	Wed, 13 Nov 2024 12:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731502332; cv=none; b=PdzIDZcOFhVxZICRdU39GvbkY1PspNn5UlemP999G+xruSCUdtmlZ03Is8Cbo/he41qACRIK1dwLdyvIeqIKe7p0rbPrs2eNm81+wSgCH4DUrfG6lx3KGPyXiqqcpdZNuhTNFCFUixfcMsdbnExG7LuqoYyD37ejmdGq/oE9GxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731502332; c=relaxed/simple;
	bh=7EK9WdjCqkV7Na+zQG7xEtIJkamZHlr1piJWfXSpWwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QfgwfrU+f8OrFBrcbvtLiBJpX56neYO85ZnLUCvkyGXSRIkhwrmeA61CoJsPcLtyHQ4V7Eu1eYYEBOL6u2Nth7Q+s3i1RwI96+GOw09qT4gHG/ChzKKzLkagR17AIwSOsd+ff/4e2/qmxK/qnor7GXJpchx1AxdaLZtp+BOwSak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZORVkgE; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21145812538so63067945ad.0;
        Wed, 13 Nov 2024 04:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731502330; x=1732107130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vmw2aGbUmIbympiMA9t+9QUm6FY7MHOvDDMcOvECtkw=;
        b=WZORVkgE8nbP/5d7hGl1Pw9IOklNSte7jMXLL90KuRBZvzsEdz+fE4Bqzb0brD6XP/
         tKJ5x7nrc5WM/5aSv3lhRDMHenVNaRMaH+CYkhnVZ59Ssith1PCagd3efNdqKeNq4OiU
         IU3ugusrD6urC42xp709q6MQRhyG92KJCaenysgmNXDPZ+lN1/xDbx5/Z2vtSAJeSZSA
         71qN1TFch2OKtdsqgpPU7WNf6HWODeD5CCeXsAQ1+9V4ayn+AFMQaAd5nangX8gN8HnE
         T2JWcTFQa6x+xunQF10+PnNlUrOs7ZKz03GHXckYYukbvr6GhIUa/xs+eCW5KywTLcyP
         4qSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731502330; x=1732107130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vmw2aGbUmIbympiMA9t+9QUm6FY7MHOvDDMcOvECtkw=;
        b=iYHGLqEeUIYLQB358iwF04Frmq0lJbSsU7heJs+K41lcoOdOZmcciXMfr0bRKDr1jL
         WsNtuP3+9aocv8Vq0nU1p0hyTwSWKj9yC3g4zBCVUSrDGFFqy7gitMEoEpvXZukL9+7F
         KEmGw0fuj//p9dJ7AM0lLs8nWV/Ivwkw/7qMOQTLoEYDAC7YH2uzjYQUrorhuSnx+g+f
         kRT4ovsG9plAShCR7Ywatv69Qd0YBvgTG32fD5vphsEA5XW4qcntQaRdY8OxxiiGR98v
         aZUSPuv9TQhXfBajRtsIxvep9CXq7RDoK6Uoh7GoJxQ5Q9fh96rh4XewQ+X/ARXA6mhP
         CckA==
X-Forwarded-Encrypted: i=1; AJvYcCWr2DDArZsb+eSn9gM3QNZ/YiUhZzKwiIZ+LPSLPing3bbnqN6JglF40jLdqP9Y4Hukg+o5ijCO8K0LByIFoqCX@vger.kernel.org, AJvYcCXtAeop7IE1xbaBd6To7JMstnARMm460zFMv6uh8i9FRrkMH2k+FS5VcN1R6NLZcRx77+6wmqsic/sdJng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz9m01neFyTqFKAchb1zwOXlXDrVH/DIBUyd18nW9rpTHOWKiz
	tKyqVLlkGvDqrr3ZJSHXyivf1GD6M4AyEsDf7tqMWpwwVQAItbBf/fjmQk15D5+nkA==
X-Google-Smtp-Source: AGHT+IF8bzWzZtwJ9Fp6GZBrHamBcZ5ADKAHqPgxdoKDpPxBrHsoI2HWrXBgoN0bekPl039O+BVBfQ==
X-Received: by 2002:a17:902:d4c1:b0:20c:95d9:25e6 with SMTP id d9443c01a7336-21183d2659bmr289071655ad.34.1731502329822;
        Wed, 13 Nov 2024 04:52:09 -0800 (PST)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177cfb0ecsm109276345ad.0.2024.11.13.04.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 04:52:09 -0800 (PST)
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
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net 2/2] selftests/rtnetlink.sh: add mngtempaddr test
Date: Wed, 13 Nov 2024 12:51:52 +0000
Message-ID: <20241113125152.752778-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241113125152.752778-1-liuhangbin@gmail.com>
References: <20241113125152.752778-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test to check the temporary address could be added/removed
correctly when mngtempaddr is set or removed/unmanaged.

Suggested-by: Sam Edwards <cfsworks@gmail.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/rtnetlink.sh | 89 ++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index bdf6f10d0558..f25a363d55bd 100755
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
@@ -1267,6 +1269,93 @@ kci_test_enslave_bonding()
 	ip netns del "$testns"
 }
 
+# If the mngtmpaddr or tempaddr missing, return 0 and stop waiting
+check_tempaddr_exists()
+{
+	local start=${1-"1"}
+	addr_list=$(ip -j -n $testns addr show dev ${devdummy})
+	for i in $(seq $start 4); do
+		if ! echo ${addr_list} | \
+		     jq -r '.[].addr_info[] | select(.mngtmpaddr == true) | .local' | \
+		     grep -q "200${i}"; then
+			check_err $? "No mngtmpaddr 200${i}:db8::1"
+			return 0
+		fi
+
+		if ! echo ${addr_list} | \
+		     jq -r '.[].addr_info[] | select(.temporary == true) | .local' | \
+		     grep -q "200${i}"; then
+			check_err $? "No tempaddr for 200${i}:db8::1"
+			return 0
+		fi
+	done
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
+	# 2. Create several (3-4) mngtmpaddr addresses on that interface.
+	# with temp_*_lft configured to be pretty short (10 and 35 seconds
+	# for prefer/valid respectively)
+	for i in $(seq 1 4); do
+		run_cmd ip -n $testns addr add 200${i}:db8::1/64 dev ${devdummy} mngtmpaddr
+		tempaddr=$(ip -j -n $testns addr show dev ${devdummy} | \
+			   jq -r '.[].addr_info[] | select(.temporary == true) | .local' | \
+			   grep 200${i})
+		#3. Confirm that temporary addresses are created immediately.
+		if [ -z $tempaddr ]; then
+			check_err 1 "no tempaddr created for 200${i}:db8::1"
+		else
+			run_cmd ip -n $testns addr change $tempaddr dev ${devdummy} \
+				preferred_lft 10 valid_lft 35
+		fi
+	done
+
+	#4. Confirm that a preferred temporary address exists for each mngtmpaddr
+	#   address at all times, polling once per second for at least 5 minutes.
+	slowwait 300 check_tempaddr_exists
+
+	#5. Delete each mngtmpaddr address, one at a time (alternating between
+	#   deleting and merely un-mngtmpaddr-ing), and confirm that the other
+	#   mngtmpaddr addresses still have preferred temporaries.
+	for i in $(seq 1 4); do
+		if (( $i % 2 == 1 )); then
+			run_cmd ip -n $testns addr del 200${i}:db8::1/64 dev ${devdummy}
+		else
+			run_cmd ip -n $testns addr change 200${i}:db8::1/64 dev ${devdummy}
+		fi
+		# the temp addr should be deleted
+		if ip -j -n $testns addr show dev ${devdummy} | \
+		   jq -r '.[].addr_info[] | select(.temporary == true) | .local' | \
+		   grep -q "200${i}"; then
+			check_err 1 "tempaddr not deleted for 200${i}:db8::1"
+		fi
+		# Check other addresses are still exist
+		check_tempaddr_exists $((i + 1))
+	done
+
+	if [ $ret -ne 0 ]; then
+		end_test "FAIL: mngtmpaddr add/remove incorrect"
+		ip netns del "$testns"
+		return 1
+	fi
+
+	end_test "PASS: mngtmpaddr add/remove correctly"
+	ip netns del "$testns"
+}
+
 kci_test_rtnl()
 {
 	local current_test
-- 
2.46.0


