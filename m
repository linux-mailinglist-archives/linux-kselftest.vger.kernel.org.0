Return-Path: <linux-kselftest+bounces-2333-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C38F981C2F0
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 02:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4EC51C23B96
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 01:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C553A53;
	Fri, 22 Dec 2023 01:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="YX3E2ayZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9CDEB8
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Dec 2023 01:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40c3ceded81so13875315e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Dec 2023 17:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1703210356; x=1703815156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0ZZHyRUOudrPPat9HrPnVQdIseVaW1H9mPsRN0/wVQ=;
        b=YX3E2ayZpqYCD+BxGbTIE04TMVXcg4TzZMdC60WcivbVzX5mpfaAcbGCEZhHz/bVFC
         0dfTFgrNhvczaIonJgSyin9RlLF0hNCcIZ1I3guCJuzpoYSMBjj3Qr2jU8AA/hpr6cx4
         VwQc9oYRV8ILv7nILMh9/TPEo4PmR7bebfFIUgzoE5A+2am3T7DXjRoLM8va+Uv9ruu7
         lxTRV5FSQCP4Kjuiy2ynPPX8nWisiK+2A+y7me2zjbOVbAzE0towjIs8P3N/l6vKLiQm
         /jT4JzwL0alFWDNwU+FjW1azfR4+gxrvl+C39mOfv6Ar1eBg+AFm8UYGecdU3ekxQDfz
         ZFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703210356; x=1703815156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I0ZZHyRUOudrPPat9HrPnVQdIseVaW1H9mPsRN0/wVQ=;
        b=dLrn+RJZ2zTcB6RHiISWAG+juOgisQStoElQ7oXJ6Xe6gL44NB9fWb4Z0FPj1jaSRs
         c3jp/ZPI8dBMANVuBXEczw3GSQBFGPFSLu6C9Qy1UwL+h+D3xOtsmpZmc/3VjYiwdhmI
         12q09Su/B9R/qCdO89e8CxFSS5OB9+QFCWU89zL77z0mzhEyxx28gicQHTXt6sZmW+Op
         uhBRGGpkL2YImV8Gh1ekB2JrbI174R03OHux1pYvOJWFoD+hP4yVe1LNiIBmvK0vd9j8
         6ChwUpIGoJh795o1cePkmRLpfsRtHPVyVPuPhbzZM1+F7TF7qjnIm2GD9+gElHq55S1H
         qIIA==
X-Gm-Message-State: AOJu0YxAFcZZCuIaA0SvRB5igB2f7nIteeZzNFDKzKyCs/QQiubv921P
	N6ZFVVi+dK3dj4J7vdmuTB+S5va5zFor
X-Google-Smtp-Source: AGHT+IE3vs/NykBo7NUkxFNtBovxM1kRWQiA8cZli4ryyJNq4gT3Zixc766nGnYbSSOxEx7EfcJzFQ==
X-Received: by 2002:a05:600c:4e08:b0:40d:443c:533b with SMTP id b8-20020a05600c4e0800b0040d443c533bmr170236wmq.73.1703210355728;
        Thu, 21 Dec 2023 17:59:15 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id g3-20020a05600c310300b0040c6b2c8fa9sm12991667wmo.41.2023.12.21.17.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 17:59:14 -0800 (PST)
From: Dmitry Safonov <dima@arista.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Dmitry Safonov <dima@arista.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 1/2] selftest/tcp-ao: Set routes in a proper VRF table id
Date: Fri, 22 Dec 2023 01:59:06 +0000
Message-ID: <20231222-selftests-tcp-ao-fixups-v1-1-39c73817c372@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222-selftests-tcp-ao-fixups-v1-0-39c73817c372@arista.com>
References: <20231222-selftests-tcp-ao-fixups-v1-0-39c73817c372@arista.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13-dev-b6b4b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703210346; l=3819; i=dima@arista.com; s=20231212; h=from:subject:message-id; bh=8oUqobZh1rQ6EPFePyfLPfw6YTJWq/V1xAlZPegsEw0=; b=NWgzbSD4Bw0jiy+VdLxT93KGXlqdQwZ9UlMZuwK/jtiGLaXLGBXS79oFKf7xUoSFnl/AaTa6K 3EON2UdCrqAD1asACxwZIhklcjo4cWubagp80jOg/aTHwtKS24WWzcY
X-Developer-Key: i=dima@arista.com; a=ed25519; pk=hXINUhX25b0D/zWBKvd6zkvH7W2rcwh/CH6cjEa3OTk=
Content-Transfer-Encoding: 8bit

In unsigned-md5 selftests ip_route_add() is not needed in
client_add_ip(): the route was pre-setup in __test_init() => link_init()
for subnet, rather than a specific ip-address.

Currently, __ip_route_add() mistakenly always sets VRF table
to RT_TABLE_MAIN - this seems to have sneaked in during unsigned-md5
tests debugging. That also explains, why ip_route_add_vrf() ignored
EEXIST, returned by fib6.

Yet, keep EEXIST ignoring in bench-lookups selftests as it's expected
that those selftests may add the same (duplicate) routes.

Reported-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/net/tcp_ao/bench-lookups.c |  4 +++-
 tools/testing/selftests/net/tcp_ao/lib/netlink.c   |  4 +---
 tools/testing/selftests/net/tcp_ao/unsigned-md5.c  | 11 +++++------
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/tcp_ao/bench-lookups.c b/tools/testing/selftests/net/tcp_ao/bench-lookups.c
index 7be8a7d9308c..a1e6e007c291 100644
--- a/tools/testing/selftests/net/tcp_ao/bench-lookups.c
+++ b/tools/testing/selftests/net/tcp_ao/bench-lookups.c
@@ -46,8 +46,10 @@ static void test_add_routes(union tcp_addr *ips, size_t ips_nr)
 
 	for (i = 0; i < ips_nr; i++) {
 		union tcp_addr *p = (union tcp_addr *)&ips[i];
+		int err;
 
-		if (ip_route_add(veth_name, TEST_FAMILY, this_ip_addr, *p))
+		err = ip_route_add(veth_name, TEST_FAMILY, this_ip_addr, *p);
+		if (err && err != -EEXIST)
 			test_error("Failed to add route");
 	}
 }
diff --git a/tools/testing/selftests/net/tcp_ao/lib/netlink.c b/tools/testing/selftests/net/tcp_ao/lib/netlink.c
index b731f2c84083..7f108493a29a 100644
--- a/tools/testing/selftests/net/tcp_ao/lib/netlink.c
+++ b/tools/testing/selftests/net/tcp_ao/lib/netlink.c
@@ -261,7 +261,7 @@ static int __ip_route_add(int sock, uint32_t seq, const char *intf, int family,
 	req.nh.nlmsg_seq	= seq;
 	req.rt.rtm_family	= family;
 	req.rt.rtm_dst_len	= (family == AF_INET) ? 32 : 128;
-	req.rt.rtm_table	= RT_TABLE_MAIN;
+	req.rt.rtm_table	= vrf;
 	req.rt.rtm_protocol	= RTPROT_BOOT;
 	req.rt.rtm_scope	= RT_SCOPE_UNIVERSE;
 	req.rt.rtm_type		= RTN_UNICAST;
@@ -294,8 +294,6 @@ int ip_route_add_vrf(const char *intf, int family,
 
 	ret = __ip_route_add(route_sock, route_seq++, intf,
 			     family, src, dst, vrf);
-	if (ret == -EEXIST) /* ignoring */
-		ret = 0;
 
 	close(route_sock);
 	return ret;
diff --git a/tools/testing/selftests/net/tcp_ao/unsigned-md5.c b/tools/testing/selftests/net/tcp_ao/unsigned-md5.c
index 7cffde02d2be..f5b6d488d501 100644
--- a/tools/testing/selftests/net/tcp_ao/unsigned-md5.c
+++ b/tools/testing/selftests/net/tcp_ao/unsigned-md5.c
@@ -30,7 +30,7 @@ static void setup_vrfs(void)
 	err = ip_route_add_vrf(veth_name, TEST_FAMILY,
 			       this_ip_addr, this_ip_dest, test_vrf_tabid);
 	if (err)
-		test_error("Failed to add a route to VRF");
+		test_error("Failed to add a route to VRF: %d", err);
 }
 
 static void try_accept(const char *tst_name, unsigned int port,
@@ -494,15 +494,14 @@ static void try_to_add(const char *tst_name, unsigned int port,
 
 static void client_add_ip(union tcp_addr *client, const char *ip)
 {
-	int family = TEST_FAMILY;
+	int err, family = TEST_FAMILY;
 
 	if (inet_pton(family, ip, client) != 1)
 		test_error("Can't convert ip address %s", ip);
 
-	if (ip_addr_add(veth_name, family, *client, TEST_PREFIX))
-		test_error("Failed to add ip address");
-	if (ip_route_add(veth_name, family, *client, this_ip_dest))
-		test_error("Failed to add route");
+	err = ip_addr_add(veth_name, family, *client, TEST_PREFIX);
+	if (err)
+		test_error("Failed to add ip address: %d", err);
 }
 
 static void client_add_ips(void)

-- 
2.43.0


