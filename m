Return-Path: <linux-kselftest+bounces-48877-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D24D19F4E
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 16:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 504AB301E681
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 15:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743B13939A2;
	Tue, 13 Jan 2026 15:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YgpQfwqX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8912D392C26
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 15:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768318672; cv=none; b=LCwVv1XvPOSks/cm3lHjXqvjAazV4MMn4//HQC6/4S/aV8OnDR5+KINBT+QOoDQKiKozibEl/Gx98JCcac4DMBQClFjSuWr5ef36/aImpUVmr8WHKw7u00P/KvW2KYGp3YRcnkc+OEdA2bqxSHO32Oz2EUOZZdSuQJpwSVCsbfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768318672; c=relaxed/simple;
	bh=GDXfWHnos7u19NmPu4/CLffdDu9GAUaL542SerC6adQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=l0RYAofRL0HKk/zmBw596m9faVR6UVXg47Er1yzs2ih6LNJ20UtHOeiISCF+xsmQVjMntaq8178MzvnKShSHzSRCa7uL8q0PZqmWofHE4WWj3ihoMEgRk81WNA36JD5HUfPBxjcCg2a1CmhsdmwW/oCudPLK9BcMe3Q3IhQujvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YgpQfwqX; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47edffe5540so3912055e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 07:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768318669; x=1768923469; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PviygXDwFF6j06NM3itllXQSNFJErjj8x+gM1Sairpo=;
        b=YgpQfwqXLcyQZfYcgSFHTZRbYJUw7Q4QpTTRxtnvPxLDEVrXi/w9ukUgDK5WILZzDO
         QwUivQ5O2OAcp56Qj46Bpyi4hBmqBQAeniVdF7cjxxLNSP4kWnKllDNonvtOgfBeuvkJ
         LjDL6AdBZw0mjWhxK3PQfYdX6FHcRciOsntMGfkW9g9hahJRcbFImgyZJiGcw3bjQnDu
         r2okk4OUrlTF9zzshPFu9ZqYG7ht1pYpqk5FVf/UnG0o8tlVgaid4/HQGOOj/KL6fYEP
         HME2NqGQYfpFRtCn/7Ugs3zaCYQQelSwsSZlhTt0AXlofiorVckgsxx4o+SN+F9K3n/6
         8afA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768318669; x=1768923469;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PviygXDwFF6j06NM3itllXQSNFJErjj8x+gM1Sairpo=;
        b=OUEO9UysY7GDhPmMDdMBURPN7oHOfYlyFoQPwBZfKSoLN8tZicv6NWWhlZN7kMZxpq
         vFFVZQ+bj6m1Lo/bIX53XHecAMsygtfEOOxducfwCRf+DLfri00fTpcUFreyJwiwfZHG
         O9wTm9to4TgpTYUGTzf/8fNMvNxdVYXKPHiXRjo9iiQM78604PvrArBOoOs+lqeoJNxj
         Le+vbp6ulKRjjiK2fGVUOInKT61R1CLd0KVRF41Br2apO5jQzp5udw7E+JZ6OW5Ngq2T
         zBybAlGPQX8vTCpsw/KEeu8p3vc893yD4YBmeV8CZuf1DMEjxJIJe+hYhOT9AR1moVB2
         xswA==
X-Forwarded-Encrypted: i=1; AJvYcCX2YFV89BS1nHQ62+6q/OkwogG2nL/8yQovNGPvCSBUcdyL5s93dfe1e3pdqez+eUJUvpEeXA+OXZcDXY/paMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMaacn4iPQ4SeNDHJkW6H/pU2BGmcqaZ90EOP3CeQtEWEuErbU
	PjYx6Iopxi9oChFMcbrOacvtG6toO8zxTEKuwKNXoU7tI3hmo87eaQ9ryLBuR2InM2A=
X-Gm-Gg: AY/fxX62lTjU1xHrqgHjVBFQJ9RFRaeE5FuTdvXCPKpoFoe4Y29kIK3o2pE6mvfdlYn
	P3fnxaUoR4IsujRc6vIbhehRSpgWlz/Ipm12x2eM2r9A0MhBWMn3MxKjkSfUHZBZ97avmsh1Oqd
	BA/kZV4jH7arQIYUIhw5mclJ/VUfRRlZTBcMoUBrCN70dra1DfUGbvhj4MYlxk+LrOk3GNcjfi9
	7KBJmG9v1RfuP++Sz2LUFnR/9E0ZtR4E9X7e5/mETMq3T4Q3gNm1lDtr+wwOASGKAIhAPcQ7Vhr
	LCSddHb05fDEDKAZSi4/orD3oLoKUianZPu6hjSAy2LiAONqhb3MRM5jyBjRuA8cpDkhdgqjChq
	BA2czRtLAA8B/SA9DVrxClwQhWBWLbeuqIMl9u0/aPg7OJ1Rg53+KiILoCHPFPgCdukzruCW07D
	RpQtP8a9XGpMGP8Iw71x5Qtnq3ubLO/M3azObY+68/
X-Google-Smtp-Source: AGHT+IH0KhNeJ74dpkbL66O3xTO4CaL+qK6+yBOKCa4diNwDUTPZtNVoaCzmax9mtzhFWlZ1/qAQlA==
X-Received: by 2002:a05:600c:4f53:b0:477:7991:5d1e with SMTP id 5b1f17b1804b1-47d84b3860fmr225612095e9.25.1768318668864;
        Tue, 13 Jan 2026 07:37:48 -0800 (PST)
Received: from localhost (201-1-159-113.dsl.telesp.net.br. [201.1.159.113])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-563995311fbsm1787948e0c.11.2026.01.13.07.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 07:37:48 -0800 (PST)
From: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Date: Tue, 13 Jan 2026 12:37:44 -0300
Subject: [PATCH net v2] selftests: net: fib-onlink-tests: Convert to use
 namespaces by default
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260113-selftests-net-fib-onlink-v2-1-89de2b931389@suse.com>
X-B4-Tracking: v=1; b=H4sIAMdmZmkC/3WOwQ6CMAyGX8X0bJVtiujJ9zAeNijSCJtZJ8EY3
 t3B3d7+pt/39wtCkUngsvlCpJGFg89BbzdQd9Y/CLnJGXShy0IVJxTq20SSBD0lbNlh8D37J56
 Ma6ryYGxjCDL+itTytKpvkG/hnpfOCqGL1tfdYl0Unqa0Hyz7BepYUoif9Z1RrWhuPiqtKoxu+
 N8+KlR4Lk2h7TFPba7yFtrVYYD7PM8/c5KhyugAAAA=
X-Change-ID: 20260107-selftests-net-fib-onlink-73bd8643ad3e
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, David Ahern <dsahern@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Fernando Fernandez Mancera <fmancera@suse.de>, 
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openssh-sha256; t=1768318664; l=5831;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=GDXfWHnos7u19NmPu4/CLffdDu9GAUaL542SerC6adQ=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QEfDb6B/2Qje/EDcOmEeQdxrgq8erXDF0Mh2ldTQyR5Hn47rB1OSpB9ScfrBu7bmFl4CGNTBsXQ
 YJTxuTOqOgQo=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

Currently, the test breaks if the SUT already has a default route
configured for IPv6. Fix by avoiding the use of the default namespace.

Fixes: 4ed591c8ab44 ("net/ipv6: Allow onlink routes to have a device mismatch if it is the default route")
Suggested-by: Fernando Fernandez Mancera <fmancera@suse.de>
Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
Changes in v2:
- Don't use the default namespace, instead of simply increasing the metric
- Link to v1: https://lore.kernel.org/r/20251218-rbm-selftests-net-fib-onlink-v1-1-96302a5555c3@suse.com
---
 tools/testing/selftests/net/fib-onlink-tests.sh | 71 +++++++++++--------------
 1 file changed, 30 insertions(+), 41 deletions(-)

diff --git a/tools/testing/selftests/net/fib-onlink-tests.sh b/tools/testing/selftests/net/fib-onlink-tests.sh
index ec2d6ceb1f08..c01be076b210 100755
--- a/tools/testing/selftests/net/fib-onlink-tests.sh
+++ b/tools/testing/selftests/net/fib-onlink-tests.sh
@@ -120,7 +120,7 @@ log_subsection()
 
 run_cmd()
 {
-	local cmd="$*"
+	local cmd="$1"
 	local out
 	local rc
 
@@ -145,7 +145,7 @@ get_linklocal()
 	local pfx
 	local addr
 
-	addr=$(${pfx} ip -6 -br addr show dev ${dev} | \
+	addr=$(${pfx} ${IP} -6 -br addr show dev ${dev} | \
 	awk '{
 		for (i = 3; i <= NF; ++i) {
 			if ($i ~ /^fe80/)
@@ -173,58 +173,48 @@ setup()
 
 	set -e
 
-	# create namespace
-	setup_ns PEER_NS
+	# create namespaces
+	setup_ns ns1
+	IP="ip -netns $ns1"
+	setup_ns ns2
 
 	# add vrf table
-	ip li add ${VRF} type vrf table ${VRF_TABLE}
-	ip li set ${VRF} up
-	ip ro add table ${VRF_TABLE} unreachable default metric 8192
-	ip -6 ro add table ${VRF_TABLE} unreachable default metric 8192
+	${IP} li add ${VRF} type vrf table ${VRF_TABLE}
+	${IP} li set ${VRF} up
+	${IP} ro add table ${VRF_TABLE} unreachable default metric 8192
+	${IP} -6 ro add table ${VRF_TABLE} unreachable default metric 8192
 
 	# create test interfaces
-	ip li add ${NETIFS[p1]} type veth peer name ${NETIFS[p2]}
-	ip li add ${NETIFS[p3]} type veth peer name ${NETIFS[p4]}
-	ip li add ${NETIFS[p5]} type veth peer name ${NETIFS[p6]}
-	ip li add ${NETIFS[p7]} type veth peer name ${NETIFS[p8]}
+	${IP} li add ${NETIFS[p1]} type veth peer name ${NETIFS[p2]}
+	${IP} li add ${NETIFS[p3]} type veth peer name ${NETIFS[p4]}
+	${IP} li add ${NETIFS[p5]} type veth peer name ${NETIFS[p6]}
+	${IP} li add ${NETIFS[p7]} type veth peer name ${NETIFS[p8]}
 
 	# enslave vrf interfaces
 	for n in 5 7; do
-		ip li set ${NETIFS[p${n}]} vrf ${VRF}
+		${IP} li set ${NETIFS[p${n}]} vrf ${VRF}
 	done
 
 	# add addresses
 	for n in 1 3 5 7; do
-		ip li set ${NETIFS[p${n}]} up
-		ip addr add ${V4ADDRS[p${n}]}/24 dev ${NETIFS[p${n}]}
-		ip addr add ${V6ADDRS[p${n}]}/64 dev ${NETIFS[p${n}]} nodad
+		${IP} li set ${NETIFS[p${n}]} up
+		${IP} addr add ${V4ADDRS[p${n}]}/24 dev ${NETIFS[p${n}]}
+		${IP} addr add ${V6ADDRS[p${n}]}/64 dev ${NETIFS[p${n}]} nodad
 	done
 
 	# move peer interfaces to namespace and add addresses
 	for n in 2 4 6 8; do
-		ip li set ${NETIFS[p${n}]} netns ${PEER_NS} up
-		ip -netns ${PEER_NS} addr add ${V4ADDRS[p${n}]}/24 dev ${NETIFS[p${n}]}
-		ip -netns ${PEER_NS} addr add ${V6ADDRS[p${n}]}/64 dev ${NETIFS[p${n}]} nodad
+		${IP} li set ${NETIFS[p${n}]} netns ${ns2} up
+		ip -netns $ns2 addr add ${V4ADDRS[p${n}]}/24 dev ${NETIFS[p${n}]}
+		ip -netns $ns2 addr add ${V6ADDRS[p${n}]}/64 dev ${NETIFS[p${n}]} nodad
 	done
 
-	ip -6 ro add default via ${V6ADDRS[p3]/::[0-9]/::64}
-	ip -6 ro add table ${VRF_TABLE} default via ${V6ADDRS[p7]/::[0-9]/::64}
+	${IP} -6 ro add default via ${V6ADDRS[p3]/::[0-9]/::64}
+	${IP} -6 ro add table ${VRF_TABLE} default via ${V6ADDRS[p7]/::[0-9]/::64}
 
 	set +e
 }
 
-cleanup()
-{
-	# make sure we start from a clean slate
-	cleanup_ns ${PEER_NS} 2>/dev/null
-	for n in 1 3 5 7; do
-		ip link del ${NETIFS[p${n}]} 2>/dev/null
-	done
-	ip link del ${VRF} 2>/dev/null
-	ip ro flush table ${VRF_TABLE}
-	ip -6 ro flush table ${VRF_TABLE}
-}
-
 ################################################################################
 # IPv4 tests
 #
@@ -241,7 +231,7 @@ run_ip()
 	# dev arg may be empty
 	[ -n "${dev}" ] && dev="dev ${dev}"
 
-	run_cmd ip ro add table "${table}" "${prefix}"/32 via "${gw}" "${dev}" onlink
+	run_cmd "${IP} ro add table ${table} ${prefix}/32 via ${gw} ${dev} onlink"
 	log_test $? ${exp_rc} "${desc}"
 }
 
@@ -257,8 +247,8 @@ run_ip_mpath()
 	# dev arg may be empty
 	[ -n "${dev}" ] && dev="dev ${dev}"
 
-	run_cmd ip ro add table "${table}" "${prefix}"/32 \
-		nexthop via ${nh1} nexthop via ${nh2}
+	run_cmd "${IP} ro add table ${table} ${prefix}/32 \
+		nexthop via ${nh1} nexthop via ${nh2}"
 	log_test $? ${exp_rc} "${desc}"
 }
 
@@ -339,7 +329,7 @@ run_ip6()
 	# dev arg may be empty
 	[ -n "${dev}" ] && dev="dev ${dev}"
 
-	run_cmd ip -6 ro add table "${table}" "${prefix}"/128 via "${gw}" "${dev}" onlink
+	run_cmd "${IP} -6 ro add table ${table} ${prefix}/128 via ${gw} ${dev} onlink"
 	log_test $? ${exp_rc} "${desc}"
 }
 
@@ -353,8 +343,8 @@ run_ip6_mpath()
 	local exp_rc="$6"
 	local desc="$7"
 
-	run_cmd ip -6 ro add table "${table}" "${prefix}"/128 "${opts}" \
-		nexthop via ${nh1} nexthop via ${nh2}
+	run_cmd "${IP} -6 ro add table ${table} ${prefix}/128 ${opts} \
+		nexthop via ${nh1} nexthop via ${nh2}"
 	log_test $? ${exp_rc} "${desc}"
 }
 
@@ -491,10 +481,9 @@ do
 	esac
 done
 
-cleanup
 setup
 run_onlink_tests
-cleanup
+cleanup_ns ${ns1} ${ns2}
 
 if [ "$TESTS" != "none" ]; then
 	printf "\nTests passed: %3d\n" ${nsuccess}

---
base-commit: 50e194b6da721e4fa1fc6ebcf5969803c214929a
change-id: 20260107-selftests-net-fib-onlink-73bd8643ad3e

Best regards,
-- 
Ricardo B. Marlière <rbm@suse.com>


