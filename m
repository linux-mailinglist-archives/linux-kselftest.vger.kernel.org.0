Return-Path: <linux-kselftest+bounces-20477-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C949ACF45
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 17:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2564B286A0
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 15:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246AD1CFED6;
	Wed, 23 Oct 2024 15:44:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F8B1CF5E8;
	Wed, 23 Oct 2024 15:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729698255; cv=none; b=bD/MHbFlWHINpt4/RACrOJNE+G+f+CnHElfyw9ioKX1JO2F2KuwKvHpD+FEdk6jzPCNReAp2tZHO/b+zqZcAQmXqMnsRxqweqEnsnXEIW9Kwi9pdli49wDG5rEHobOlJUkC0/DRXjvGIlwqffNA9oLbWTE/3Xx8aGR7mA7JKV2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729698255; c=relaxed/simple;
	bh=HQzDey7GgEVa3rTI5jthiLJDrmkMe+R6419M0Ug8+yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tLZf1XxqaPK1RSUY++IBtuWIeSsi52FnS9uw5S36SQW0Afr3J9UERsl+PqA+3qua5Zb9WGva+b2eHJnbuHDsM2wfOx58UuV3mojvjvejXh/hhSWjpMPKlbpXQ6qXCfdUGTDWhB8sfApkcAzPTfeFLtYbO/sV5nhRYs5y3A7Hgww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71ea2643545so4755188b3a.3;
        Wed, 23 Oct 2024 08:44:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729698253; x=1730303053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/lZRzUOJGf0+vqtRPw1M1zfctMTkla5AJBP9vN6QXRw=;
        b=feOGsypmZC8Hhzo1Q4gUWzfEcVdlgqeuK8wCTAlfuwKlHSgNUj1xw239OzNnCbe+Xy
         RZOGx7YrF9ef88HBsW1hX7yGHfsaWTdlx/cdP575V8VTW7F0Ym4KZR/kMgWAHDgGg4jx
         5NIOnOpnp6kYvAMKYwFZW4gPDuxLWykEVQKPR0izoiPasH3ahnxIiQtj/cvwnQiTjeeO
         sHL7SzOrIiNpWBnTOemclq35ON4LyLSl+RZ5g+Vra7kFn+sdux0SeEu+AgdAun4RFtWD
         XlqulyYb5GZi9+mgO2k4IsjeKysR8VAPEnI9dYMyVf1myg8uSHBDL/045XpCDgAV7tc5
         LtzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDmarlj4ItqIu21fUK8JanYAu83Gmvxo/fafIOJZSVH9tRPaQG+VTk5GEzIpFIdQ8lskylBUnYq1t0woA=@vger.kernel.org, AJvYcCX1lIl50kQJb2KHfhnr4cXRNF9OZWxXJmGa/QBBb7tSSkgdJg/xmrfd5Dk684ZaIVhYJXwQNkBSBjxQvXinOIuY@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw+fyJu/nOPBOCWFq/IdSfdiRGGsPLCSJlfFGEny86l9g1DhuO
	rf17mLYxyx11LALxendQOmq7JDuJ6V2wB5dYl2GEABwO9+1po/5o37rglMs=
X-Google-Smtp-Source: AGHT+IHj64z2ZiDnLpjI261VFNR6D2A2Ch7MZv5ivbzzHXDu8Jfy3MHaGsuBTRTGHRJawP2UL73New==
X-Received: by 2002:a05:6a00:27a1:b0:71e:b4ee:960d with SMTP id d2e1a72fcca58-72030aa4330mr4928096b3a.10.1729698252581;
        Wed, 23 Oct 2024 08:44:12 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13ea284sm6693072b3a.146.2024.10.23.08.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 08:44:12 -0700 (PDT)
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
	almasrymina@google.com,
	sdf@fomichev.me,
	willemb@google.com,
	petrm@nvidia.com
Subject: [PATCH net-next v5 08/12] selftests: ncdevmem: Use YNL to enable TCP header split
Date: Wed, 23 Oct 2024 08:43:58 -0700
Message-ID: <20241023154402.441510-9-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241023154402.441510-1-sdf@fomichev.me>
References: <20241023154402.441510-1-sdf@fomichev.me>
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
index 697771c1f9fa..e1faad46548b 100644
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
@@ -370,6 +420,9 @@ int do_server(struct memory_buffer *mem)
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


