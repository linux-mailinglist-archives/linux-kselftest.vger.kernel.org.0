Return-Path: <linux-kselftest+bounces-45694-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6907DC60C3F
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Nov 2025 23:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 383F13585AE
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Nov 2025 22:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E686254AF5;
	Sat, 15 Nov 2025 22:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NwiLzH+3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8493260583
	for <linux-kselftest@vger.kernel.org>; Sat, 15 Nov 2025 22:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763247392; cv=none; b=WgH9JDDR2vJzI4IamhZKSqIKY2UVGVKG80/byH99ja5OPHexFZuH2/vbCVPug7snLLZcu+BpZKrvnpadSRJ9wbFBb9Jmk5F1yl9NDd6xvhje73tIHLMv94ZlndfQjYSvnfjPeGvTVWw8iTk9znQtj9ywA9fKH+JeyLBlSDvMMdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763247392; c=relaxed/simple;
	bh=yRG8Nxy/l0LvjSvT/KrupkQ2EizRIh9OaEoODht8KYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WxnXmEQb8UgmUF4iHv0wvA3+ewR2hFCZuxhGzXhbrq+xjeXjiHkYMBJ2KJStxWN04eXASKZZe7c8ROpcX64AA13aGJMNL7oevaZGALdxdD+y56ZwGN+L9aLNzZNVMw0QD/PmihFo4PGkl1mcIYF/ULX/TMy/6tEJ6iC5/tw6Q+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NwiLzH+3; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477770019e4so36352435e9.3
        for <linux-kselftest@vger.kernel.org>; Sat, 15 Nov 2025 14:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763247388; x=1763852188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ps8UGCpaZwTjonsD4/+wCNz8vb5xTFCKH5GRNUH/TvA=;
        b=NwiLzH+33BRvHF8nr65OarDmt2W25zh891vR4glig5CmarRWsSf4kkjuugdEEpQaGT
         9gOcaR/ViYnoVmViY0jmO61XBHwpSR5BJsVlpqWc6b2QN0DfvsRAz5OrG0yW9+FCw7J/
         EdoTxzhI7XA7YGi1bFBqYUl1Gi8GY5NEFD8xO3EJdRklybhewsLaifsIegvdbxv8p3ht
         WfKYq6BDf0vpeJZmk3LiMt/DX53dR080lcI6iMH2EOskfsBu75+U7+lW6D+oeREzmndc
         7an0J6tNzJQ6WJ7ckyyzjpi0ACCBUybAo1u+X/2wYdJTyPsT2vqr0f14S54qbw/b4qq5
         u6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763247388; x=1763852188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ps8UGCpaZwTjonsD4/+wCNz8vb5xTFCKH5GRNUH/TvA=;
        b=IseIqiFp9u1D1daokiiI7kfnxziv/WgHgQSJaN8JsBnN4CCsuBS3DxbJ5jBmY8wjbz
         J5ZpSV5I30lFZC8Ly6Ze6AdF0bWzDDH/f04q1mpukLK2nY4lOYHaB+HQZIkrxFzBlY6g
         kYm8Gv0VFYSKpSi327XeFRoN6ENPYKPL2CzDzm4gvaWFE6bbL+4i+EYKRoZDrRUUu7ki
         kbr+NrkqpPZANEf9RPDL6xzhHxxb5c+tsyOeyiI+glpg2MhLvkhXkXAfhvWbTMx4/5OH
         1e3cY7MlexWZ9bTIeUxOR+Njr7fxxhcJRQQrxVvE264yoIBnsEVPdgdpo46kfAwzuWyv
         k04Q==
X-Forwarded-Encrypted: i=1; AJvYcCW8xZSa7RN+mfcNgddDMt96862ArzV6hti/uMz5R052ZMZryDSnpQ6hb85LQUWEf1g85nOgEHwgKvJVZ9Y5RBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqDrvFpSMqSfi7fae+QbAQ29o5QDTZB+3T3wNbfmtLVHtB93Xc
	F7VAE4oNs8ikSxyH/sw4bwK6nYxK2HcwCi/L1aYj7TgNw+evURabJ0yKPTDOIVBw/fY=
X-Gm-Gg: ASbGnctuKhH2MxGaZmA4dlIeoznUukEVQCE3R5d0dJqCyzyOO/VEektkRavL3/puFxE
	4Ad9FUmZxSR1Kd5DViu6KBiybmBIODSfBh1louAJNBoeIEBv99vbRic50Cx7CgxxcxrQ+RLpqQX
	VnGlfUufGUYUcPmotTRxvsQCj3Nv+zBFr0T5IlhY4z/0SarFpGsmm6KM1dSwPKsxdqsRPH/Sw7K
	mwX/iYN8QX/O0HKwTN2vxDI6NmgB/IIvVU4cJiVSko6P4+Y72pvqWOIFu0WVxjtknt+G+APbUJp
	eM+CkDd747mR5ovXq/x/JNVvEHvMedBLemTSvepVP5f5x+T4mh4TrmrDbb1tdaClrMAQs4yvEyc
	V0cUVE6k4JW3ZvRU0m4OABDljEUFfAcj5pL42YrrxcqAqj4S8s6BcBFK/kecgJQeUI58iSrrHaz
	H23VJmAgptw6jYI5N6klwWgOWeWlDgUD+thfHSHR0=
X-Google-Smtp-Source: AGHT+IFDpCictYIrRIjY6i+tnY3JVoJqZbp4M1IzOl9jkFjchbrF4S6GZivYdIQ9y/Hn2jAMz8IEwg==
X-Received: by 2002:a05:600c:3542:b0:471:115e:87bd with SMTP id 5b1f17b1804b1-4778fe7d0ecmr69055525e9.26.1763247388152;
        Sat, 15 Nov 2025 14:56:28 -0800 (PST)
Received: from F15.localdomain ([121.167.230.140])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ba1462c605sm6641971b3a.21.2025.11.15.14.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 14:56:27 -0800 (PST)
From: Hoyeon Lee <hoyeon.lee@suse.com>
To: bpf@vger.kernel.org
Cc: Hoyeon Lee <hoyeon.lee@suse.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [bpf-next v1 2/5] selftests/bpf: use sockaddr_storage instead of sa46 in select_reuseport test
Date: Sun, 16 Nov 2025 07:55:37 +0900
Message-ID: <20251115225550.1086693-3-hoyeon.lee@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251115225550.1086693-1-hoyeon.lee@suse.com>
References: <20251115225550.1086693-1-hoyeon.lee@suse.com>
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


