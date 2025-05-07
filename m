Return-Path: <linux-kselftest+bounces-32573-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED9EAAE087
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 15:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63B6C1BA768F
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 13:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CF6288C20;
	Wed,  7 May 2025 13:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WuNpuuxB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C186F28136B;
	Wed,  7 May 2025 13:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746623966; cv=none; b=NUa8WDy0OcGCvnyZn1VnjL39jsVyurYQnkkxuIvobwjmSclY+oVzKMyZdn2iQKqPBQvJ3XidT/auVWbaMCHUpBbQwQw0iGPUBheFeIgf/45v1Xyt4arpvbYVYxToiF339AQWmRk21PuqMFc1OcWRaZpbrtf9azdJnk4PywUQwi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746623966; c=relaxed/simple;
	bh=NDqRijYzjhs0y/BEUOAKtrmFA7xwhtMvr8QfCvPf9aE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUTnjG2VFMmUV06b7aYpCMLaMqQ89lu3b4GVG6Nnx8hASSQLpF1sJXiUmiWL2cxhx/HZShxwuZz6W6BveOZy/EhvXYoMLAvNUerXNm4+Rwif3lLO03BkzNFs7jFaYeyVYV17BYBpEXjNTaXj6twP2MvKFOtWNF2peMOlmp/uXMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WuNpuuxB; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22e6880d106so4624955ad.1;
        Wed, 07 May 2025 06:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746623964; x=1747228764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtfXnYitCXVUTGCdTcTCxeQzg7Q4AmshUJnCjDRlr08=;
        b=WuNpuuxBblCjQbi0HAhPEAiKuk21h+VuyM2L3JifxfrzlQKOgHKR3ojLaRy/OTQ6ZT
         eBsW8tGI1ntPGaTNmf/dZEbTx1D2ugj7gcbZn1H+OzLJzcMLSs61oEVErVe6gamkTdB7
         1Mmw4jOQK1594kIRLrvK5AewHehBzdj94rkVQ+hk2nrHXA/vPHGsvuzOdBKlsGuIsl8j
         U2hnEinIv2yZjkom8/6Dt3S2HZqZeqtaKiTdQ4Iq7WApPsGrL8N9lQA46Dsile8D9r3i
         ImFuyOuDwsO2EdThVviDBOP8iwHjoaN217NPbAZM9JYlBkam+2ogN9iStVa+Gdc0IjJP
         w9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746623964; x=1747228764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wtfXnYitCXVUTGCdTcTCxeQzg7Q4AmshUJnCjDRlr08=;
        b=hXiLQdU6YJq2Z4D49Zrh5sy8NfP/8CF0wmTqnqPDPO61y97stSEu35gHIx0jL+7UZ6
         FkbZR/m5DAFVegOr05ESb6nxjsr0gAAMkFvr/o0gKtjoV64nnfg8RCxJhyDOm0KXRtIo
         NsQJQMzCXAMkz2N2kQTYmHCXQJd53qHUAnhbk8pFfS42JegZk/zyHDQnfSt0Z0FUEllE
         ECtTiwSsiJQDfAXvVkNEvtr31k2kUaqdJ4yi97q0L5UoQODWfgbKZPCEvWtkgqQieTp3
         qeobDxH8jai9jwy/Ll0MwwjK0wLky5bxfD6i3Kvbv7CcbX51M3bVi56a4u4o7u/Q5A0X
         8G+A==
X-Forwarded-Encrypted: i=1; AJvYcCV5W4ySkPcurcPcUCVC+QkWni8gcuqwrQF8v0G6rDiyh0noeM5Hd1IrtYgrTKqY2n18csfrGBOAB9BDPyGWmmWq@vger.kernel.org, AJvYcCV64/YbG0APGTsojPaHGqwwv9dJZqKzSmGOV5QGxdxU6IK5ZFgDAI04IdEQluIyB5BTVvk1EzajV3vOJWn6sLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW17wcosPEhDrboWYDR49kAbONICZAyDS89LcwjWoajepaCpaB
	5W6yp6sbkwfC50VaHozwFr3iiKhuv64htCfsiiZdCngcAOqOFaSVwpWRuZcR
X-Gm-Gg: ASbGncuAO2TEsrvilVuMbsBOtwg3XIuF3EIULgutcDCQ6ZhRrqFctwO4Et12k85riFw
	AChG1rjVdndxkYJ9mZ2CDGDJzL4ZKwU6dq4+O+ie40rRNDFyHer2eDJqLtjMnI0ElQXUQ21PAt+
	YDPggQteKSrCmCjFFK6AgM7QY6ajRx230oGL5S7OsSocvyBHWoM8c17UVoedRbtDtuSXy9Rjbae
	bE92diU8Livco4DbkfxP61uHdZvnw0F40Zv2oVu9Ds+fnNsvvko+0JERUcyMD24nhOVsUjg4uVz
	mQjkMofsMcweNVDUNWNeJIx7K/ix1g47gFg5KDAvbvunt4K50I64RSV+JHqY
X-Google-Smtp-Source: AGHT+IFSdSQM3IiHqluyQXlAUvMv4gM0CqL/WRQ17JX5c13/+GiFUCTdNuQLWbuZWinMIpGIpqDeYg==
X-Received: by 2002:a17:903:2f85:b0:21f:45d:21fb with SMTP id d9443c01a7336-22e5ea64dddmr47456425ad.3.1746623963559;
        Wed, 07 May 2025 06:19:23 -0700 (PDT)
Received: from fedora.dns.podman ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e5e93ee88sm17414765ad.86.2025.05.07.06.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 06:19:23 -0700 (PDT)
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
Subject: [PATCH net-next 2/6] selftests: net: remove redundant rp_filter configuration
Date: Wed,  7 May 2025 13:18:52 +0000
Message-ID: <20250507131856.78393-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250507131856.78393-1-liuhangbin@gmail.com>
References: <20250507131856.78393-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following tests use setup_ns to create a network namespace, which
will disables rp_filter immediately after namespace creation. Therefore,
it is no longer necessary to disable rp_filter again within these individual
tests.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/fib_rule_tests.sh | 3 ---
 tools/testing/selftests/net/fib_tests.sh      | 3 ---
 tools/testing/selftests/net/icmp_redirect.sh  | 2 --
 3 files changed, 8 deletions(-)

diff --git a/tools/testing/selftests/net/fib_rule_tests.sh b/tools/testing/selftests/net/fib_rule_tests.sh
index c7cea556b416..5fbdd2a0b537 100755
--- a/tools/testing/selftests/net/fib_rule_tests.sh
+++ b/tools/testing/selftests/net/fib_rule_tests.sh
@@ -516,10 +516,7 @@ fib_rule4_test()
 	fib_rule4_test_match_n_redirect "$match" "$match" "$getnomatch" \
 		"oif redirect to table" "oif no redirect to table"
 
-	# Enable forwarding and disable rp_filter as all the addresses are in
-	# the same subnet and egress device == ingress device.
 	ip netns exec $testns sysctl -qw net.ipv4.ip_forward=1
-	ip netns exec $testns sysctl -qw net.ipv4.conf.$DEV.rp_filter=0
 	match="from $SRC_IP iif $DEV"
 	getnomatch="from $SRC_IP iif lo"
 	fib_rule4_test_match_n_redirect "$match" "$match" "$getnomatch" \
diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index c58dc4ac2810..a94b73a53f72 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -2560,9 +2560,6 @@ ipv4_mpath_list_test()
 	run_cmd "ip -n $ns2 route add 203.0.113.0/24
 		nexthop via 172.16.201.2 nexthop via 172.16.202.2"
 	run_cmd "ip netns exec $ns2 sysctl -qw net.ipv4.fib_multipath_hash_policy=1"
-	run_cmd "ip netns exec $ns2 sysctl -qw net.ipv4.conf.veth2.rp_filter=0"
-	run_cmd "ip netns exec $ns2 sysctl -qw net.ipv4.conf.all.rp_filter=0"
-	run_cmd "ip netns exec $ns2 sysctl -qw net.ipv4.conf.default.rp_filter=0"
 	set +e
 
 	local dmac=$(ip -n $ns2 -j link show dev veth2 | jq -r '.[]["address"]')
diff --git a/tools/testing/selftests/net/icmp_redirect.sh b/tools/testing/selftests/net/icmp_redirect.sh
index d6f0e449c029..b13c89a99ecb 100755
--- a/tools/testing/selftests/net/icmp_redirect.sh
+++ b/tools/testing/selftests/net/icmp_redirect.sh
@@ -178,8 +178,6 @@ setup()
 		else
 			ip netns exec $ns sysctl -q -w net.ipv4.ip_forward=1
 			ip netns exec $ns sysctl -q -w net.ipv4.conf.all.send_redirects=1
-			ip netns exec $ns sysctl -q -w net.ipv4.conf.default.rp_filter=0
-			ip netns exec $ns sysctl -q -w net.ipv4.conf.all.rp_filter=0
 
 			ip netns exec $ns sysctl -q -w net.ipv6.conf.all.forwarding=1
 			ip netns exec $ns sysctl -q -w net.ipv6.route.mtu_expires=10
-- 
2.46.0


