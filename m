Return-Path: <linux-kselftest+bounces-46203-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 638A6C77D6E
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 09:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F7984EC183
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 08:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4956B2FB99C;
	Fri, 21 Nov 2025 08:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RcRBIxH4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646CB33AD80
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 08:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763712856; cv=none; b=WfPSMwOptyvwMGUl5C+5M7KHL2DVceCDkQIx+pp1i7bqR94kgCiJTwjfrZjLZHjsspflQx6atUsefVTqjbCteg5xPzUs4HLPkCeaKjGdETWciJmW5E5Y+JiVJ6nvGloTqMf7oA3CnDv6i681srvS1fEw+rZJHCsJVAFXvgF6vm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763712856; c=relaxed/simple;
	bh=yRG8Nxy/l0LvjSvT/KrupkQ2EizRIh9OaEoODht8KYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eOIILONDtJKigICMSLMqR3B9Orv1xmOQQVUq8bQ9XWub44m/Fl46TR5z+8mgdNDi1lUW5kSyIvVsmcS2fkZIqWTpNK6j/2Q9uRTRLj6KaL6PGxsgZBp1ddcfK4Ko9bxADs8gNGxGRqCtMlXNXmoWS7y2B9Z4x0n2k90BT5hVM+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RcRBIxH4; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47118259fd8so14965905e9.3
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 00:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763712851; x=1764317651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ps8UGCpaZwTjonsD4/+wCNz8vb5xTFCKH5GRNUH/TvA=;
        b=RcRBIxH4EfgqyJVlkycqJCMTSxWN49/fn1e2zx5opRW0ECHwcvM1qrnqzKpVzA1Vot
         LuLcGkzsKHHqKjsTR9waFbt4iBThUypKtwH2zUoEMQvG147Ze/HHkPbRKiM4cdT+Duux
         3HsxF72sIAXjKQb38GX+OjMBXOj9oWkSrltoHgBe4AV//0GqcOownbJ6dSbhg8x7DIvD
         Rop219dQu1Kp6GsLawA1Im0ZI7re5uBzmYS2Kr/fOoEBvEQcWEPJaa0WyCiQzPdkYkKv
         UpouE4qvLXNR3hiHxjvAJGIN8Rhkwf/nxxHxFwzvv9VVZPGqGcSL8Tj94NX5C+WoEiQO
         5QGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763712851; x=1764317651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ps8UGCpaZwTjonsD4/+wCNz8vb5xTFCKH5GRNUH/TvA=;
        b=mo8XRVzfQZ94+ViB5wGSgiw3T98DpmeHnIm47eXORvkYY2pyz7STnEJ56SXZ4lF4Wp
         oxia//FKjzV+zww37N4QEB+M5sqeSf5MsJsfWudbBkvXR71PstUiae0LxPgXS5oZ0gAI
         x/hh30NuXyX0/93cJLpUM18+uLlPZoW6gab/tpfHaQLmRF2pRso3dXckGbsH26c7WirG
         /BB0o6gvNP/XLift5PgXyftjcwKG9U/EYKnR9wrSBseLAuSuKxfo17WG/jX3DwYocVli
         qehO8wj07VmoEmeznBA4eXpOB0+O+di6/k3JZgTtmvI+X/uwXXavZjmk5RslZrW0ts+2
         C69w==
X-Forwarded-Encrypted: i=1; AJvYcCWc3UzAvllMQHTf/n9r6Q5XxBwNZ4b8Kog+cqRgi4eLvSKRkMMiZCtYbgUhgb6wF31mc++qXkWEUTVcjLciL6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYYfPtplRYa94nBZ/+DMo4oDdWKSv/fLQ9BC8MX0pzn8z/rbHT
	Sdu6LZtcXEJnFDB/34DUnHVybyLinm5hlTao7fA3q4DXKbEEICzlbz6Y2ZnK/4jN4sG52kK9Lfe
	RoneJ
X-Gm-Gg: ASbGncsq0CRPrSHREn6VJNfa2YpZIeMZ2H9SOYJwRw/hwK7VNhMj6czbXjriQyN8lEu
	W7A/zhbjNgDpfTGr8+2H8YzadaEvxZMvcLg0zJ5ewKKhxPw4aoPvW2vUp24K8sY1aTrJd3xm49J
	MTgI6oVFt0Rpra9ajjxxjRMYCLlRU/pnTzGUKS5HHjfLEHwajuTS/+y7iyllBZJcNcl0OuUlTDK
	An2rHDVEgZ/G0TAGecxMyJOBudQOTitQIj96n9LOwJjFb8HeR/cdxYakbmCIfjoDhq2YJz1SpEd
	kiweZNcL8kI9axH6r+nedbf+VHjlZH+K0XqHjkvpI6Uou2+mZ4dhvVzoRoDbxVX95BNb5NVf9uX
	PpRNnQoQSzHD3j8eUSw6c9dtXNQY6kEnpX5I4SrFs80377C6wCAYD806brumcsQBEq2YfJpUZCb
	9hF6bq4CQEelaQ0oOLbnB0KBZXEB/sVj0SHk5UcXmP0kgjg+jemQ==
X-Google-Smtp-Source: AGHT+IFnlEJswVxHvEMgc0ivtrXYrObVWG/nBBqizX/gmyv6vLPBOc/j5AsjkUbZkZCVsCuPkMfgHg==
X-Received: by 2002:a05:600c:5491:b0:477:fcb:226b with SMTP id 5b1f17b1804b1-477c016e60cmr13674025e9.2.1763712851432;
        Fri, 21 Nov 2025 00:14:11 -0800 (PST)
Received: from F15.localdomain ([121.167.230.140])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd75def6314sm4722370a12.7.2025.11.21.00.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 00:14:10 -0800 (PST)
From: Hoyeon Lee <hoyeon.lee@suse.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	hoyeon.lee@suse.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: use sockaddr_storage instead of sa46 in select_reuseport test
Date: Fri, 21 Nov 2025 17:13:32 +0900
Message-ID: <20251121081332.2309838-3-hoyeon.lee@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251121081332.2309838-1-hoyeon.lee@suse.com>
References: <20251121081332.2309838-1-hoyeon.lee@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The select_reuseport selftest uses a custom sa46 union to represent
IPv4 and IPv6 addresses. This custom wrapper requires extra manual
handling for address family and field extraction.

Replace sa46 with sockaddr_storage and update the helper functions to
operate on native socket structures. This simplifies the code and
removes unnecessary custom address-handling logic. No functional
changes intended.

Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
---
 .../bpf/prog_tests/select_reuseport.c         | 67 ++++++++++---------
 1 file changed, 34 insertions(+), 33 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
index 036d4760d2c1..3dbcc091f16c 100644
--- a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
+++ b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
@@ -41,11 +41,7 @@ static struct bpf_object *obj;
 static __u32 index_zero;
 static int epfd;
 
-static union sa46 {
-	struct sockaddr_in6 v6;
-	struct sockaddr_in v4;
-	sa_family_t family;
-} srv_sa;
+static struct sockaddr_storage srv_sa;
 
 #define RET_IF(condition, tag, format...) ({				\
 	if (CHECK_FAIL(condition)) {					\
@@ -135,24 +131,24 @@ static int prepare_bpf_obj(void)
 	return 0;
 }
 
-static void sa46_init_loopback(union sa46 *sa, sa_family_t family)
+static void ss_init_loopback(struct sockaddr_storage *sa, sa_family_t family)
 {
 	memset(sa, 0, sizeof(*sa));
-	sa->family = family;
-	if (sa->family == AF_INET6)
-		sa->v6.sin6_addr = in6addr_loopback;
+	sa->ss_family = family;
+	if (sa->ss_family == AF_INET6)
+		((struct sockaddr_in6 *)sa)->sin6_addr = in6addr_loopback;
 	else
-		sa->v4.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
+		((struct sockaddr_in *)sa)->sin_addr.s_addr = htonl(INADDR_LOOPBACK);
 }
 
-static void sa46_init_inany(union sa46 *sa, sa_family_t family)
+static void ss_init_inany(struct sockaddr_storage *sa, sa_family_t family)
 {
 	memset(sa, 0, sizeof(*sa));
-	sa->family = family;
-	if (sa->family == AF_INET6)
-		sa->v6.sin6_addr = in6addr_any;
+	sa->ss_family = family;
+	if (sa->ss_family == AF_INET6)
+		((struct sockaddr_in6 *)sa)->sin6_addr = in6addr_any;
 	else
-		sa->v4.sin_addr.s_addr = INADDR_ANY;
+		((struct sockaddr_in *)sa)->sin_addr.s_addr = INADDR_ANY;
 }
 
 static int read_int_sysctl(const char *sysctl)
@@ -228,7 +224,7 @@ static void check_data(int type, sa_family_t family, const struct cmd *cmd,
 		       int cli_fd)
 {
 	struct data_check expected = {}, result;
-	union sa46 cli_sa;
+	struct sockaddr_storage cli_sa;
 	socklen_t addrlen;
 	int err;
 
@@ -251,26 +247,32 @@ static void check_data(int type, sa_family_t family, const struct cmd *cmd,
 	}
 
 	if (family == AF_INET6) {
+		struct sockaddr_in6 *srv_v6 = (struct sockaddr_in6 *)&srv_sa;
+		struct sockaddr_in6 *cli_v6 = (struct sockaddr_in6 *)&cli_sa;
+
 		expected.eth_protocol = htons(ETH_P_IPV6);
-		expected.bind_inany = !srv_sa.v6.sin6_addr.s6_addr32[3] &&
-			!srv_sa.v6.sin6_addr.s6_addr32[2] &&
-			!srv_sa.v6.sin6_addr.s6_addr32[1] &&
-			!srv_sa.v6.sin6_addr.s6_addr32[0];
+		expected.bind_inany = !srv_v6->sin6_addr.s6_addr32[3] &&
+			!srv_v6->sin6_addr.s6_addr32[2] &&
+			!srv_v6->sin6_addr.s6_addr32[1] &&
+			!srv_v6->sin6_addr.s6_addr32[0];
 
-		memcpy(&expected.skb_addrs[0], cli_sa.v6.sin6_addr.s6_addr32,
-		       sizeof(cli_sa.v6.sin6_addr));
+		memcpy(&expected.skb_addrs[0], cli_v6->sin6_addr.s6_addr32,
+		       sizeof(cli_v6->sin6_addr));
 		memcpy(&expected.skb_addrs[4], &in6addr_loopback,
 		       sizeof(in6addr_loopback));
-		expected.skb_ports[0] = cli_sa.v6.sin6_port;
-		expected.skb_ports[1] = srv_sa.v6.sin6_port;
+		expected.skb_ports[0] = cli_v6->sin6_port;
+		expected.skb_ports[1] = srv_v6->sin6_port;
 	} else {
+		struct sockaddr_in *srv_v4 = (struct sockaddr_in *)&srv_sa;
+		struct sockaddr_in *cli_v4 = (struct sockaddr_in *)&cli_sa;
+
 		expected.eth_protocol = htons(ETH_P_IP);
-		expected.bind_inany = !srv_sa.v4.sin_addr.s_addr;
+		expected.bind_inany = !srv_v4->sin_addr.s_addr;
 
-		expected.skb_addrs[0] = cli_sa.v4.sin_addr.s_addr;
+		expected.skb_addrs[0] = cli_v4->sin_addr.s_addr;
 		expected.skb_addrs[1] = htonl(INADDR_LOOPBACK);
-		expected.skb_ports[0] = cli_sa.v4.sin_port;
-		expected.skb_ports[1] = srv_sa.v4.sin_port;
+		expected.skb_ports[0] = cli_v4->sin_port;
+		expected.skb_ports[1] = srv_v4->sin_port;
 	}
 
 	if (memcmp(&result, &expected, offsetof(struct data_check,
@@ -364,16 +366,15 @@ static void check_results(void)
 static int send_data(int type, sa_family_t family, void *data, size_t len,
 		     enum result expected)
 {
-	union sa46 cli_sa;
+	struct sockaddr_storage cli_sa;
 	int fd, err;
 
 	fd = socket(family, type, 0);
 	RET_ERR(fd == -1, "socket()", "fd:%d errno:%d\n", fd, errno);
 
-	sa46_init_loopback(&cli_sa, family);
+	ss_init_loopback(&cli_sa, family);
 	err = bind(fd, (struct sockaddr *)&cli_sa, sizeof(cli_sa));
 	RET_ERR(fd == -1, "bind(cli_sa)", "err:%d errno:%d\n", err, errno);
-
 	err = sendto(fd, data, len, MSG_FASTOPEN, (struct sockaddr *)&srv_sa,
 		     sizeof(srv_sa));
 	RET_ERR(err != len && expected >= PASS,
@@ -589,9 +590,9 @@ static void prepare_sk_fds(int type, sa_family_t family, bool inany)
 	socklen_t addrlen;
 
 	if (inany)
-		sa46_init_inany(&srv_sa, family);
+		ss_init_inany(&srv_sa, family);
 	else
-		sa46_init_loopback(&srv_sa, family);
+		ss_init_loopback(&srv_sa, family);
 	addrlen = sizeof(srv_sa);
 
 	/*
-- 
2.51.1


