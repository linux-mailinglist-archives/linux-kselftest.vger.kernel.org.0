Return-Path: <linux-kselftest+bounces-21117-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0319B65D9
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 15:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A9B51F24919
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 14:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B061F943D;
	Wed, 30 Oct 2024 14:27:38 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0961F1304;
	Wed, 30 Oct 2024 14:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730298458; cv=none; b=QCfNBn8yTlv+wQGEZ3ehAkTWVbLeJiBBQ/UKiK80+7nb94FUK6saLzskW5LAB7+W4hefWloQEzwQKUNZE9pwwPLUObYBC1tMb3EarUlqG/6GHuEyxL4NIooSigghjexoDvsRgY0pJGhTkpAuu2s8mncVpEFD0Tk/5EHkmlo7riQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730298458; c=relaxed/simple;
	bh=og3zr3saPqbWT0VxgUJgzCO724Ye3nF8hiqLbYRm8GU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lniayxi+Bo6pqZU7NVsU1eZug2aobSNS1xFXh/Ryg/5UVPyX7aAYsY1mjdq/Ae8nRErD79xKoZCqJwiUdcn+m6qCAaiYC0J8KoWmD9x142Q4ZT4cIF1gqi7xR2N3XU+LY5VGA9IAsGnp9EZWc23L9TuF4YeluWqwQ2IJF9HlnBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-656d8b346d2so4592062a12.2;
        Wed, 30 Oct 2024 07:27:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730298456; x=1730903256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+bp/FLvuQ/H/YT5HFz5uDgTntUpplmekx3z9WyNTng=;
        b=jxTgJKwJr3HptIs52XB4ZJeMVg8hr/eZYKqGumNUFwVmgEnye9uxDxjkDCAywNTO3h
         BFLDONf/bKvxwyjEOtMUWPfpi/j88ck0RFWNzQHXnGld81GJJOKL/ug9iVI6iwo7cvix
         AsesDIinHlPRVE/pDx9KYTVNCtQA6scD39ThIbfLS8V02GyC73OwwE9O5u7VXp3yblp8
         dL1y0/MlnCEv8fbnfZdxRz6Ni8Xh/EQ01Jn4bp0yRyBJgHGzP97hBRWYcYt+J+hsYfS0
         2P4eI+NeVWQbba221c9p8UrODW61Q56C8SN0lt3BRChTGbzHRXZE95OJFnD5VcXwBRNb
         0lyg==
X-Forwarded-Encrypted: i=1; AJvYcCWTS55AbobvXORzllcnRDpiRAwlChVgf5N3EemDXl9uWx9zZ81SSLJJy326nLn03sWVL7f8q33pqYY2w1GoXuJy@vger.kernel.org, AJvYcCX3/Sr5yebJpnYkXhvBC1GLiZEL8LReQzDPIlHopusYTZjzkiSivRiidaHRL5vvKy2Rj8Yrrrzfh5N7H7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXwN0vcevku5oufBtpjWlk16sJBvsvb6TCVhUxgN8/aUP8S1xH
	hROW8692PlB4qcG7l+I/YcM7ryTtSx7MHg6N0Jv7eCix911NzpsyVf2eh1c=
X-Google-Smtp-Source: AGHT+IFNbGrqHHMfY+G+fciJmPrc6K3Oy5dPTfwsk3FBfXZZKnnOnxcIuLShI6o9je+d/FignN4u8A==
X-Received: by 2002:a05:6a21:3a4a:b0:1d9:3957:8c24 with SMTP id adf61e73a8af0-1d9a83ffdb5mr21634630637.21.1730298455740;
        Wed, 30 Oct 2024 07:27:35 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057931e2csm9268012b3a.63.2024.10.30.07.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 07:27:35 -0700 (PDT)
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
Subject: [PATCH net-next v6 09/12] selftests: ncdevmem: Remove hard-coded queue numbers
Date: Wed, 30 Oct 2024 07:27:19 -0700
Message-ID: <20241030142722.2901744-10-sdf@fomichev.me>
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

Use single last queue of the device and probe it dynamically.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/ncdevmem.c | 40 ++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index e1faad46548b..fe4d81ef1ca5 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -75,8 +75,8 @@ static char *server_ip;
 static char *client_ip;
 static char *port;
 static size_t do_validation;
-static int start_queue = 8;
-static int num_queues = 8;
+static int start_queue = -1;
+static int num_queues = 1;
 static char *ifname;
 static unsigned int ifindex;
 static unsigned int dmabuf_id;
@@ -208,6 +208,33 @@ void validate_buffer(void *line, size_t size)
 	fprintf(stdout, "Validated buffer\n");
 }
 
+static int rxq_num(int ifindex)
+{
+	struct ethtool_channels_get_req *req;
+	struct ethtool_channels_get_rsp *rsp;
+	struct ynl_error yerr;
+	struct ynl_sock *ys;
+	int num = -1;
+
+	ys = ynl_sock_create(&ynl_ethtool_family, &yerr);
+	if (!ys) {
+		fprintf(stderr, "YNL: %s\n", yerr.msg);
+		return -1;
+	}
+
+	req = ethtool_channels_get_req_alloc();
+	ethtool_channels_get_req_set_header_dev_index(req, ifindex);
+	rsp = ethtool_channels_get(ys, req);
+	if (rsp)
+		num = rsp->rx_count + rsp->combined_count;
+	ethtool_channels_get_req_free(req);
+	ethtool_channels_get_rsp_free(rsp);
+
+	ynl_sock_destroy(ys);
+
+	return num;
+}
+
 #define run_command(cmd, ...)                                           \
 	({                                                              \
 		char command[256];                                      \
@@ -702,6 +729,15 @@ int main(int argc, char *argv[])
 
 	ifindex = if_nametoindex(ifname);
 
+	if (start_queue < 0) {
+		start_queue = rxq_num(ifindex) - 1;
+
+		if (start_queue < 0)
+			error(1, 0, "couldn't detect number of queues\n");
+
+		fprintf(stderr, "using queues %d..%d\n", start_queue, start_queue + num_queues);
+	}
+
 	for (; optind < argc; optind++)
 		fprintf(stderr, "extra arguments: %s\n", argv[optind]);
 
-- 
2.47.0


