Return-Path: <linux-kselftest+bounces-21635-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C59519C0D90
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 19:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C46111C23D15
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 18:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583BE218D6B;
	Thu,  7 Nov 2024 18:12:25 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15C4218300;
	Thu,  7 Nov 2024 18:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731003145; cv=none; b=J0dM0FIQpZDwvcnFy+3ChjuTPQVSQw4vJiXiIToK8SFGL6OI4ICtdUGp1tKzvmSWHeBYMM43fJ9Usly6ZvSgx6WBfEWwe0CNSS3+1g/RshL2UxxUci/kaGfa6UlV2KaeQ+g0Rknx2fMDdwsO5pw6EBrghHEYxj9BPDdJzxf91k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731003145; c=relaxed/simple;
	bh=IpP00aCuowF9QGCHU0HXnhDTJIAjGcRrPT96a5RuCBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZX5B2ndoxCi9QRBKqo0YutFbaIG1cNbFDwUZxeQzFabMBpqcgTc77Zr3eaU2xH2yIAgVh3oVmB3BHDEw2WLGUpxzrwX+JnwrdCIv0q7UgSGkALxRKFIAKYcrDHicuf92sbn7P/DXGaGhX4ZQI4LPxbu2O6K1gfZJhX4qPNaOKuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2110a622d76so10770165ad.3;
        Thu, 07 Nov 2024 10:12:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731003143; x=1731607943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Em1uH7WWwP9uLKDu0J9tx3ubhx+AkkX/SgdwOrqLhXk=;
        b=f6ZpIvFsw4XnlhLLS4sipr3xoYTy7nJxIIiXFLGWYUD7FeDtaSO8iFIbwYOiyBjFUo
         VtGb2AIZ0iAB/uGCC9yTAXFjorr27mbraXa9BrcNUFCHDjAFyo1LA8MicXtpasmVqsMX
         lhcyF2cbK8kxnjYGhZo41tYXUGeTsKKIR1EaJTCQHJ0udvSE2V0KN4Cep09h3u15xMnH
         exqSWZSOzwT6/4mzmYuskR9QoVaeD5YB4H8mW7HRwYz176HH7wq9vPVWvDbw+YwvsPZ2
         3An00RFky/MHbBO4FO/+zs/GF6qUwyWcthMDRLwFXDyRx9O7ktGPkfy6o9gicYe4U607
         3y6g==
X-Forwarded-Encrypted: i=1; AJvYcCUjNzV1bAyFyEKXXSpuUYVMJC58CqoEvTD6j7TvYsYHWz/PTKA/xCJuMPhzIG8OnySmdbEtnbW9PRLsodie0Ak+@vger.kernel.org, AJvYcCVAKeVFkNOtHdQN44p/KqfDiJ2b9GQKlPQ9Yp1rqEAw0KowUXa+OE1S48p2lcvkv1H1jZHV+1P9vmYwUoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvFkWWUxpTykccagacbObWA7jWsznAJg2yxyc0GaoOWDNuI+2L
	wNdZNxiVzLQC+dAdestarSCuafn4uOQBuHpphlp1AG449atJxglDth75
X-Google-Smtp-Source: AGHT+IGRTlUxM7UsRogy1kztiQGDP7ZnWrUD40jI8gSq4yJP0icpO11xsRiE+cpHtLs7Y1xAml21Jw==
X-Received: by 2002:a17:902:ec83:b0:20c:8abc:733a with SMTP id d9443c01a7336-211823dab1emr3832125ad.53.1731003142793;
        Thu, 07 Nov 2024 10:12:22 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc8354sm15192615ad.4.2024.11.07.10.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 10:12:22 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	andrew+netdev@lunn.ch,
	shuah@kernel.org,
	horms@kernel.org,
	almasrymina@google.com,
	sdf@fomichev.me,
	willemb@google.com,
	petrm@nvidia.com,
	jdamato@fastly.com
Subject: [PATCH net-next v8 08/12] selftests: ncdevmem: Use YNL to enable TCP header split
Date: Thu,  7 Nov 2024 10:12:07 -0800
Message-ID: <20241107181211.3934153-9-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107181211.3934153-1-sdf@fomichev.me>
References: <20241107181211.3934153-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the next patch the hard-coded queue numbers are gonna be removed.
So introduce some initial support for ethtool YNL and use
it to enable header split.

Also, tcp-data-split requires latest ethtool which is unlikely
to be present in the distros right now.

(ideally, we should not shell out to ethtool at all).

Reviewed-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/Makefile   |  2 +-
 tools/testing/selftests/net/ncdevmem.c | 57 +++++++++++++++++++++++++-
 2 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 26a4883a65c9..759b1d2dc8b4 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -111,7 +111,7 @@ TEST_INCLUDES := forwarding/lib.sh
 include ../lib.mk
 
 # YNL build
-YNL_GENS := netdev
+YNL_GENS := ethtool netdev
 include ynl.mk
 
 $(OUTPUT)/epoll_busy_poll: LDLIBS += -lcap
diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index ad6de8e0e97b..9ca2da3a2f63 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -55,10 +55,12 @@
 #include <linux/netlink.h>
 #include <linux/genetlink.h>
 #include <linux/netdev.h>
+#include <linux/ethtool_netlink.h>
 #include <time.h>
 #include <net/if.h>
 
 #include "netdev-user.h"
+#include "ethtool-user.h"
 #include <ynl.h>
 
 #define PAGE_SHIFT 12
@@ -231,10 +233,58 @@ static int reset_flow_steering(void)
 	return 0;
 }
 
+static const char *tcp_data_split_str(int val)
+{
+	switch (val) {
+	case 0:
+		return "off";
+	case 1:
+		return "auto";
+	case 2:
+		return "on";
+	default:
+		return "?";
+	}
+}
+
 static int configure_headersplit(bool on)
 {
-	return run_command("sudo ethtool -G %s tcp-data-split %s >&2", ifname,
-			   on ? "on" : "off");
+	struct ethtool_rings_get_req *get_req;
+	struct ethtool_rings_get_rsp *get_rsp;
+	struct ethtool_rings_set_req *req;
+	struct ynl_error yerr;
+	struct ynl_sock *ys;
+	int ret;
+
+	ys = ynl_sock_create(&ynl_ethtool_family, &yerr);
+	if (!ys) {
+		fprintf(stderr, "YNL: %s\n", yerr.msg);
+		return -1;
+	}
+
+	req = ethtool_rings_set_req_alloc();
+	ethtool_rings_set_req_set_header_dev_index(req, ifindex);
+	/* 0 - off, 1 - auto, 2 - on */
+	ethtool_rings_set_req_set_tcp_data_split(req, on ? 2 : 0);
+	ret = ethtool_rings_set(ys, req);
+	if (ret < 0)
+		fprintf(stderr, "YNL failed: %s\n", ys->err.msg);
+	ethtool_rings_set_req_free(req);
+
+	if (ret == 0) {
+		get_req = ethtool_rings_get_req_alloc();
+		ethtool_rings_get_req_set_header_dev_index(get_req, ifindex);
+		get_rsp = ethtool_rings_get(ys, get_req);
+		ethtool_rings_get_req_free(get_req);
+		if (get_rsp)
+			fprintf(stderr, "TCP header split: %s\n",
+				tcp_data_split_str(get_rsp->tcp_data_split));
+		ethtool_rings_get_rsp_free(get_rsp);
+	}
+
+	ynl_sock_destroy(ys);
+
+	return ret;
 }
 
 static int configure_rss(void)
@@ -382,6 +432,9 @@ int do_server(struct memory_buffer *mem)
 	if (reset_flow_steering())
 		error(1, 0, "Failed to reset flow steering\n");
 
+	if (configure_headersplit(1))
+		error(1, 0, "Failed to enable TCP header split\n");
+
 	/* Configure RSS to divert all traffic from our devmem queues */
 	if (configure_rss())
 		error(1, 0, "Failed to configure rss\n");
-- 
2.47.0


