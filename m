Return-Path: <linux-kselftest+bounces-46718-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB6DC93827
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Nov 2025 05:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F20F634227C
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Nov 2025 04:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75222224B0D;
	Sat, 29 Nov 2025 04:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KaT9f2AV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A833F224AF7
	for <linux-kselftest@vger.kernel.org>; Sat, 29 Nov 2025 04:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764391107; cv=none; b=KsEQSZDd3Nqaj5yq3CeuN9yGEqRSwfvXBFruJWJ8WhRpZpPG4JlvYHovdx9Cr0zW3K8y6d3BQXuddnf4o5RExT84tfqsxXI1XK3r3T2MOLTk5t/Kb9xyy5wIJCE2RfeG73UKDjHRWsRENjdpLIk82moMYd7oaaoRMhrExBhswF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764391107; c=relaxed/simple;
	bh=MY6OepM4iCbQKboU2CzDmLhc+cf4XBwZQTl9an9blRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X28B3ZguxJ9tWCj30W2nkwm9pF2SHqAlR/Y/gPy82FwWUHzVX1obAdzt9myTEQOpHSJYEFd4TaQO0/umVQra7PRs3hT+AW+KNlLyyV1T9FyhlAUclglkSOrVOSLi8eg3WD5HKrzlYnKdT/5UKs1/SJpYhhtQB6mm2R7wcM0mQ6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KaT9f2AV; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-298144fb9bcso24563965ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Nov 2025 20:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764391105; x=1764995905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LoUjNl1uE2KTMWSYxjynIphVvFokAcjMOIAnwbmph0g=;
        b=KaT9f2AVWPNLrm0ULxEbpsToNTOx4XXcs6RFfLUxV/lSuTt8CcBBbl9Pyn0d5N2EVv
         RBUO9OFGcEb4j3VjCyxY6w1BLQBmdL4f1Zexbj9f6gKWtOagVKXj3cRBAJGYhgXwRqyD
         0SB9xMgOYx5Z4RFr9m5i46zFx5C3WNl4LnkIfwb2W+fKW0v5Llk/xnIqRPHO3libEHZC
         WDBKTjjNosMOJSvJVlB0O+4XMRW16/ErgIZXXJGqnS4OOVrVdFx3m4X4CN3Wi+j3Cqe3
         UZOOMYpBa1DE5qjdxsDQxmmT0AQvUomPIRatyq5F/RxFaERQe9Gl9JPTU37l3yDqWtup
         I4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764391105; x=1764995905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LoUjNl1uE2KTMWSYxjynIphVvFokAcjMOIAnwbmph0g=;
        b=AS1tc0KD1CqcIiZLKs5c7B9g9Q8dbEWLNr0MXMqwhtwu0BB/AW97/GgxS8xsA6oNxl
         OMcDGX7ovi3GX7ScZk9fqvbXuNHhQfEKIYU5MF84Wv6VhEYia/KU6gDVEQAxMcMxPnwY
         EPJb4vHK6r1t646HRcunxTs4ip6LSXoM2amqJWVMTdKMwpJLoUxswDj3DRxbMSzMhy10
         1A/H4FOZ0sir8k5bxJjD9Y2ZSgze4HonjD7okdvuhOyFwXjKBoLfjntHGlPPZfybp2nl
         loi+ylfd/kN9JYIu7NPAYTXUbn9DKZ3qo6wSUWqxn9OiQF946S8nygHmAVzwXUflrXSM
         IDFA==
X-Forwarded-Encrypted: i=1; AJvYcCW5qoD9vhWbGEPky3G7mo1gX1b7kYkRkbVXz3B8KPZza3TJS2LYZHTTHTyyqASyHfm1FfzqF2Pd1qIhnfTOrU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxSyD4559ya9YuoS6VU3qhTMUPkufyEFQCBuGVuz1LvHlWIyYr
	yj2PLPS6Pib2+/g6CYRDZ1YHjh9XNZTlbI0CdkR+XT4Zf2GhleLHPwglAqkmLtD2
X-Gm-Gg: ASbGncta/HxlzN7AaA+c9/GKkUrJyODR7hiDOGF0Bf7cd5X1yLrx87j/lPsCFOIpEON
	gSZQOcurUI0FoJzFA/y25CiZSRIXsodptswhbwTAZO9/85rWguyrMYJqyOXKuA1k36JhCjTerLA
	2IFm8L+7KXpgjNxvTGcldbUFc3G3Q0QjagKCYtlvaxnR4Zcb4Jg+A1qD+uAiSxqV6Ch40fjWxJa
	0m2mCrgrBYpQp1Po8WXUbnUIUnh6cHtIqc/+nxAX4vnLcbohFu2h36/iE7ECWqIrYzdkfz4Q/rG
	L1OIkIw07lO8RuJqpVSiNlqwdOAGvLzU9eEe2npHV193XTor23p1cqunLQW4fpR57z/MMkB25yi
	yKc+I7/8lOaLvM5HnwaE8YcBuJ8D/pjGCOkW9HNOTsjX1Tu8Ri35fAN9K2WkXNgdcyWaG4YDcVG
	VmCRYETpMDJN6fT/bswGvud88wERQhaJ5muevEkncK
X-Google-Smtp-Source: AGHT+IE3d227D6O/a6E8EeYXs1AA4qchJAYZ2y3RerwefcyJ6amSAoYNHYb6emQiTrh6d6t1kWOLlA==
X-Received: by 2002:a17:903:1105:b0:23f:fa79:15d0 with SMTP id d9443c01a7336-29bab1a156fmr189382745ad.46.1764391104946;
        Fri, 28 Nov 2025 20:38:24 -0800 (PST)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb5c6c9sm60774995ad.97.2025.11.28.20.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 20:38:24 -0800 (PST)
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Subject: [PATCH net-next v2] selftests: mptcp: Mark xerror __noreturn
Date: Sat, 29 Nov 2025 10:08:08 +0530
Message-ID: <20251129043808.16714-1-ankitkhushwaha.linux@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compiler reports potential uses of uninitialized variables in
mptcp_connect.c when xerror() is called from failure paths.

mptcp_connect.c:1262:11: warning: variable 'raw_addr' is used
      uninitialized whenever 'if' condition is false
      [-Wsometimes-uninitialized]

xerror() terminates execution by calling exit(), but it is not visible
to the compiler & assumes control flow may continue past the call.

Annotate xerror() with __noreturn so the compiler can correctly reason
about control flow and avoid false-positive uninitialized variable
warnings.

Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
---
changelog:
v2: 
- annotate 'xerror()' with __noreturn
- remove defining 'raw_addr' to NULL

v1: https://lore.kernel.org/all/20251126163046.58615-1-ankitkhushwaha.linux@gmail.com/
---
 tools/testing/selftests/net/mptcp/Makefile        | 4 ++++
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 3 ++-
 tools/testing/selftests/net/mptcp/mptcp_inq.c     | 3 ++-
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 3 ++-
 4 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index 15d144a25d82..4c94c01b893a 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -35,3 +35,7 @@ TEST_INCLUDES := ../lib.sh $(wildcard ../lib/sh/*.sh)
 EXTRA_CLEAN := *.pcap

 include ../../lib.mk
+
+$(OUTPUT)/mptcp_connect: CFLAGS += -I$(top_srcdir)/tools/include
+$(OUTPUT)/mptcp_sockopt: CFLAGS += -I$(top_srcdir)/tools/include
+$(OUTPUT)/mptcp_inq: CFLAGS += -I$(top_srcdir)/tools/include
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 404a77bf366a..10f6f99cfd4e 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -33,6 +33,7 @@
 #include <linux/tcp.h>
 #include <linux/time_types.h>
 #include <linux/sockios.h>
+#include <linux/compiler.h>

 extern int optind;

@@ -140,7 +141,7 @@ static void die_usage(void)
 	exit(1);
 }

-static void xerror(const char *fmt, ...)
+static void __noreturn xerror(const char *fmt, ...)
 {
 	va_list ap;

diff --git a/tools/testing/selftests/net/mptcp/mptcp_inq.c b/tools/testing/selftests/net/mptcp/mptcp_inq.c
index 8e8f6441ad8b..d4a729814662 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_inq.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_inq.c
@@ -28,6 +28,7 @@

 #include <linux/tcp.h>
 #include <linux/sockios.h>
+#include <linux/compiler.h>

 #ifndef IPPROTO_MPTCP
 #define IPPROTO_MPTCP 262
@@ -52,7 +53,7 @@ static void die_usage(int r)
 	exit(r);
 }

-static void xerror(const char *fmt, ...)
+static void __noreturn xerror(const char *fmt, ...)
 {
 	va_list ap;

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index 286164f7246e..15cea5e919b5 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -25,6 +25,7 @@
 #include <netinet/in.h>

 #include <linux/tcp.h>
+#include <linux/compiler.h>

 static int pf = AF_INET;

@@ -139,7 +140,7 @@ static void die_usage(int r)
 	exit(r);
 }

-static void xerror(const char *fmt, ...)
+static void __noreturn xerror(const char *fmt, ...)
 {
 	va_list ap;

--
2.52.0


