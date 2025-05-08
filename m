Return-Path: <linux-kselftest+bounces-32647-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA518AAF575
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 10:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC9D83B1488
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 May 2025 08:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F61C226D04;
	Thu,  8 May 2025 08:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cApO4moo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEAF2248A6;
	Thu,  8 May 2025 08:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746692383; cv=none; b=ofMvj8C3AvMxWAWkcfTJloqp9Lme1ePCio2ZBi4wLeWOKYnKVSkHawyWe6wezI9pXLwNDvtPfPwgqh7FmnxC/NRnHEOK/LwO3MNPHV57Bv5dStNCmrE01UpcICKYGqElQP2yBKvrLdjQs/s3SWu8w+IJcM4+mgGn3zSAuDap0oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746692383; c=relaxed/simple;
	bh=NDqRijYzjhs0y/BEUOAKtrmFA7xwhtMvr8QfCvPf9aE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ivIRYBGDVK9Ji03U+nCobfa7Fo9DM4gnqKUB9iDENQa3Rb7y8jnMOAzH4Omv3RgYn4+CAaQRPBlk8+YcUHoAZhJKX/vO7ZDvUZ+2fOx3MH49REAWMzcQo4eXK8Zf3tEMvjcUGC+lzn0WXX/GLdG5DbUQ0pQKzO6PVqjaDXdErVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cApO4moo; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-73972a54919so738145b3a.3;
        Thu, 08 May 2025 01:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746692381; x=1747297181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtfXnYitCXVUTGCdTcTCxeQzg7Q4AmshUJnCjDRlr08=;
        b=cApO4mookshnvcHBob0B1IMBl64jBi7oSoLDJMyZC9oIBYd8z7tozD6/KNYX3+gOVw
         IkytV4f6bYceM7Vnz9IW2N1S7wgrIBGDMYOmQsyL4NDGYQSBjQ2qCuYLcKsx9DeRdRav
         wbn0KT4GafA9Cv+17cnWlS0arx0Cso2RzBBCkIe5KSVhh03+asyOL/3PipZBgEj26Vp/
         qSTlX4SDBGnoByM0GqsVOjTrIwV7sA0Iv+l5CWqATd/Di0p6/tWUPH6iABorXpqZ8xiU
         oTjKM5XisTSEcpGUqQa+WmGbvDa0HBVu8u3AtkzqvgD/ltmkVYy60U5LkKOVzqMd+mWD
         UjpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746692381; x=1747297181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wtfXnYitCXVUTGCdTcTCxeQzg7Q4AmshUJnCjDRlr08=;
        b=KwPxsHsqXvcRy799xLWtHtvSIUfUiKQE3C2bqpx4prAXAAd2z/4zm+oGDUErDH587o
         cgYlXLt7H8yOhQL6LL0SgBrGTOhRhzR74dkDpW26+bhLz6Um2hRmXGXhhbgR7WlaG2Jx
         LeKwU8qv9NN8X/YHcEkhkW+BWD6RmS1U3FH1knrz1G9wE0RKZumX6S51KNS3kQTTSAKg
         DdyrwjH1K1knrS2DhS8o6IgG41nMOrKV1MFM703LkNDxfOVOisZzhVhjghy6EH+NdAPG
         9dSCMykAfgqc92cc39aihvL5ZSkTUNUqDT/PNL8phnFj0Gc/c59WMC2oa0MV3+5LQo37
         fSXg==
X-Forwarded-Encrypted: i=1; AJvYcCU9+s0hTxOV10ujLvQdAr3u+hVOLUORseNMsbV1LDJDV1w0ZgpQ1md+S4m91GzP9m+uFB76MNnKKDZITgJjsoFi@vger.kernel.org, AJvYcCUySKDdcPy518einZsZoJZsLEWlAK0SWREhIPmG5tQuJsdj7xzIG1iOqySwhYJTTgwj3CzvpjU13rbQB6cvfA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzlcESgcYG/sCuVPWa+gIt22SDrcBX0nudYqNo7MFa1j5ufIhH
	LBQDWms7vCwVPg7bfl5xv2kUhe8Uco2cGHEPjqNSP0Mj7gtM0PD8+A+sk6p0aK0=
X-Gm-Gg: ASbGncspG8U1NRmo6u+JVlcXkYN5bJdB45vD+OWtENK2QNfIHZgbfkhQG/yD8o4ilIN
	VXW7F3i/XuC0lcGthzxu5r82+XCg18tlm2fXTrJOK6vQpjHE7vSo+I1FI+WftfQD9eUNQJP2qiQ
	mOxlZbHYKlNJ3AphXpkx/wctHVW0E//AaKa+unPkq9rIx7xmQ3OmV88rSHfAABdi0+8Yo2Kbx5t
	FbuhJxBn/Y4q9alLg0FPH3T7GU1/twEAj7sIAUFcfiB73EniRqbHoxXfUsK8iEwyAhFf5fwIpds
	OgymdL6SET8yaR1ty+eqaxv+/GYdjOV9+9+WNAravsqtpUMqx7nSbIRX9gpP
X-Google-Smtp-Source: AGHT+IG7pwQ/ZmLNv85y0ipwxtsXxWTqjT9C0wws4LQDnBve2+4o0xCMNV6ghhEGty2Mj/8lwIMs5w==
X-Received: by 2002:a05:6a00:ad07:b0:730:75b1:7219 with SMTP id d2e1a72fcca58-740a99cb1ebmr3589916b3a.12.1746692381066;
        Thu, 08 May 2025 01:19:41 -0700 (PDT)
Received: from fedora.dns.podman ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7406a36c523sm10907408b3a.144.2025.05.08.01.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 01:19:40 -0700 (PDT)
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
Subject: [PATCHv2 net-next 2/6] selftests: net: remove redundant rp_filter configuration
Date: Thu,  8 May 2025 08:19:06 +0000
Message-ID: <20250508081910.84216-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250508081910.84216-1-liuhangbin@gmail.com>
References: <20250508081910.84216-1-liuhangbin@gmail.com>
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


