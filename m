Return-Path: <linux-kselftest+bounces-21401-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BAB9BBD1B
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 19:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 169FA1C22649
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 18:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88DE1D2232;
	Mon,  4 Nov 2024 18:14:44 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6CE1D1E62;
	Mon,  4 Nov 2024 18:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730744084; cv=none; b=Y8B7JVzLIeCUcWht4Wy0VjHoOqwfR9N0vdKOZvy6TXuycZvgpdbd+aupful6ZeLf+rC6vS/4pQGr1Fp1znXJAbHUCc5zwI/zA7hOtb8+SEty35CYHYCLSY9a7/AywcIb2pHt3wrhOlCW2sGMKk5bt5DMiYgC9H2D/YDNUMThFCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730744084; c=relaxed/simple;
	bh=HEprPoq1IsIYeEgDwCpbe2AY4uFkB21Ly4ySJ8h1NCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e+Wk2xslaIrvX6QyIE4AnJxTD8ZOh3GW7ODtQ5ZvncpTliCx7QDhlrQhzUMOL3SDGsK16R8Af3zIVxfQQZh3zVLuAMJOUEH0wb52Ln7NW3zi4HtA10X+sG/SHO2uhgVkK80eHVDGZMrfs+1/m/CE5uTiFYumzsn4ig75UKIbwFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2110a622d76so34836685ad.3;
        Mon, 04 Nov 2024 10:14:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730744082; x=1731348882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=chkH/KYtOTBy5j86yWDDP7t68zN26H3k4mJ3Ip1/oJs=;
        b=GdeDoAE1JgYWPZuQShNj1/hyfdv0ZZwSN80vkrLXXFPKu8n0TQEeRdEtj14SwOaB+D
         Rd5nyQ25cuXB6nWVXJxvGgjOgN/yNWLr/UTXrl3qqATwfNHzxV5kxwg/nGsQ4tzaJWy6
         9NFrSWVzbtybzdtLYGH86SXf6CO38DYZatI3rAPhJeCSkNFIlMpyqZWRbV+sethv26+G
         pUVnH6g9z6eKcoj4QQdGKUznLg5eCAjjEOtF/jlJElu4qKtb1o3WSuFYd0rG0qHt8580
         5c17JcYyvoCt8piof0/v4eSiSN/vZeclAg7+qWBn3J7tuhhjxCNlTxgExFehXrqmlelL
         fmZw==
X-Forwarded-Encrypted: i=1; AJvYcCVQIecC4a04O3ii9X2ttNqodBcOw2Py04+ozxr78rw0Fnozp/KuNQ2ZQfmR4uUWdn3TYwRf81zgrySIXhZ88ZWn@vger.kernel.org, AJvYcCWAKPrpdfJdJqRTc4WzfDay88BNGlQgRVb6n1wpIlJRpsKRkwiBg5bxO5QXXc5we0BFq4aFKxTbN0jMnmM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4nmBAu9/oSanfSCv1RH/nGR+bATUqvLRF+plDrwAQJrW9HTAx
	GT5sQkbEYaGqstoZxuO6kYndl0ZyO7UPj/JMaPyqcctkAh2wDlKxtqcx
X-Google-Smtp-Source: AGHT+IHdQdolv7+0xRZNxaMUgWAhLbTcH1r9wF6jgKwiSN9SY5f5W6UdX70Ee6I3trFcRz+lTvw0SA==
X-Received: by 2002:a17:902:e5c3:b0:20c:95d9:25e6 with SMTP id d9443c01a7336-210c6c1b09fmr391058865ad.34.1730744082225;
        Mon, 04 Nov 2024 10:14:42 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2110570815bsm64278255ad.91.2024.11.04.10.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 10:14:41 -0800 (PST)
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
	petrm@nvidia.com
Subject: [PATCH net-next v7 08/12] selftests: ncdevmem: Use YNL to enable TCP header split
Date: Mon,  4 Nov 2024 10:14:26 -0800
Message-ID: <20241104181430.228682-9-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104181430.228682-1-sdf@fomichev.me>
References: <20241104181430.228682-1-sdf@fomichev.me>
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
index 8062d26fbce0..be89735d6408 100644
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
@@ -384,6 +434,9 @@ int do_server(struct memory_buffer *mem)
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


