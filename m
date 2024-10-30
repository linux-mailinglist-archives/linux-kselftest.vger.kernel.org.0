Return-Path: <linux-kselftest+bounces-21116-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C009B65D6
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 15:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7970D28437E
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 14:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E70A1F940F;
	Wed, 30 Oct 2024 14:27:37 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F7D1F892D;
	Wed, 30 Oct 2024 14:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730298457; cv=none; b=iRfphjuaLSTxJ3E9DISz2eYNZ/DpreyaGwkiroqSlRtmUQRoIJApeJnGgwxDp57zzxNPPvzhSRnMF2UDe+FjuMmOdZks8qu9OdS2n5wmBAyiRBxjIyoIU14Fcwmi2XkUF0IzE/Kyh8BnfgXyFnmTE/rNpE19gNArG9Q/GqjZ5eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730298457; c=relaxed/simple;
	bh=HQzDey7GgEVa3rTI5jthiLJDrmkMe+R6419M0Ug8+yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=urcN6hOZ7i6VFyrvjXnhEBLDIaux1/SvuAPtHhbXwMhGBt+DvSP2BAumTZtVw7Dbwy6X+gMC3kqqJAZJ///K8FX38mX9fgAHGICo4oNB0TDfdNHCfRQz6gnSv26ghi7N25OX9Jvwo1sibZ8DcVhLjWnhivokD0E7yFo3cNdVNsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e2a97c2681so5008454a91.2;
        Wed, 30 Oct 2024 07:27:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730298454; x=1730903254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/lZRzUOJGf0+vqtRPw1M1zfctMTkla5AJBP9vN6QXRw=;
        b=bUdE3OQmcrutewdmsJiGfGo/Dyv/AxSyS/m/ltxwdYFUpgcrsdRDodhCUgqmTpc2m4
         xeq8QH6nIUTVH4di3G+B9MY0Fdagf820SF/P+SM6GsU6X82EcBzNfb3VKvW7V9NZQQpD
         xO5uU8pGR1y17hpa4Rw17VN3jPGOixOE2K2bJIxVVj+zejtQEWQYQdAhJSGorgFwugZE
         TZ/BHFmqh+1qp7aodSfGwT3UwiUNG3BzqEEZ4orbXUhpG+c7+KLWfXg1VGWU/t56rxlW
         KsQe6fVcVKZtjhH8u8dl/1tz/euBn+TCA2vWaFCNpnfiG+h0QTYsharYH1DsSfmXHzfM
         v/Mw==
X-Forwarded-Encrypted: i=1; AJvYcCUP2cA1N/9F44KL4U4R6bhvImbHRMaBNgdBellq39XM93WJfnN/tXvojWPQoknFqd1UvPjQtOCGH+yUvlU=@vger.kernel.org, AJvYcCVJmX7RBxeL41IhG/qwYxT0Fy9ZbKVOC0fFXoJbfS3okrPphh4ignT0F6iLUWo6khApQYnsq5FyzwRuxjTbTPEo@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9xFyqvkLLNoNB7Sdqt3/1xGIRap2YyufSBoPQzwH1BKxkyQLB
	HeS8gNk1WOkYcWMpi9CYQCUFcT0Sq/ESunWruBfUr5Pjv5SJpD4sXzZYjbQ=
X-Google-Smtp-Source: AGHT+IFsH/EwXVMLCxRW/raeS6EBiQwsIMQYcxG/dXnvDNoTZFiN7pBi8KR5sP8ApAZo7L9SVZGheA==
X-Received: by 2002:a17:90a:53a2:b0:2e0:f896:b806 with SMTP id 98e67ed59e1d1-2e92cf2d020mr3697105a91.27.1730298454077;
        Wed, 30 Oct 2024 07:27:34 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fbfb05asm1756851a91.48.2024.10.30.07.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 07:27:33 -0700 (PDT)
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
	sdf@fomichev.me,
	almasrymina@google.com,
	willemb@google.com,
	petrm@nvidia.com
Subject: [PATCH net-next v6 08/12] selftests: ncdevmem: Use YNL to enable TCP header split
Date: Wed, 30 Oct 2024 07:27:18 -0700
Message-ID: <20241030142722.2901744-9-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030142722.2901744-1-sdf@fomichev.me>
References: <20241030142722.2901744-1-sdf@fomichev.me>
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


