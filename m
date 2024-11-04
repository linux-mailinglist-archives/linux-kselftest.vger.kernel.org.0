Return-Path: <linux-kselftest+bounces-21402-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5F69BBD1F
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 19:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49D131F23B49
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 18:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB651D27A7;
	Mon,  4 Nov 2024 18:14:45 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C13A1D220A;
	Mon,  4 Nov 2024 18:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730744085; cv=none; b=pw0+GXWwx58bm5iU34WrIXDlddD0eSu31opeUNRrgX+EA2jmbn11NsNzEkywjr2dy2rcZwJK/wmxNKnINNMv92KFhSnn4uAu/6Qc9aRgqPf5zUSKWwNf1IA6z1Z71jtNzOKmQQB+3XuiIOCBurdRaZ7SSu1HUpl+YSpwhQLrbBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730744085; c=relaxed/simple;
	bh=FqwkzCj7Oo52GxQLIk8kMLxdTIgLdXiAl0FYGpgOpus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lorYBFqSQcYQPkVyObN9V6g21E5OjvKfRUoMXvTNu5MUgn/6ESpHEQz/iAo4HbL+8rR+73Xzx/FnA0vBOS4JBUEFVdR+xpYdtnAOLKxyoLFtqlTNmSf898ecpW3SB6/EN41fQfB+EbfgrVY25LveZ06hl71EvJZhZISoQV4nyFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20c8b557f91so47074095ad.2;
        Mon, 04 Nov 2024 10:14:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730744083; x=1731348883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3RnouCHbo4rVx9xUzcrJNSVrtgq+CHRpQxygse3lkA4=;
        b=X3IyPKzz18Stgs/jvNlpqK3jiFFTdwDQ7IdAxxnx4PogTkRkj5XU90xbgKr5DX5keI
         70QHH4Xlhg83xpCa812/1sTQh1rkaEJOXaDorHHhT9weIM9n7GAPugXgkfoREWW0fbwY
         PyNL37GMEoGyZyMDsByFQ/D29tC/jG7lHQQPNdJ5/H+w5hIXLRIDf0ogRvZENMTCpEeh
         RJ/D+UukFX5eNBStsgCWVXy7fvsF/bxRrJT3Di13n8ix7tG5aAwG3I0lfRUKt6v9sw6L
         G3gw78MLUPO4enhWK00MxEAE5ADZigAKNlPY8+8WD5a6Qbk7nhhmzxP5wp2R55fT/ZAR
         lYUw==
X-Forwarded-Encrypted: i=1; AJvYcCVKqLX42cJFVO1ayz5F3oimRD+1SO8u/gteZhBg29rYStBdIZJoznEAqxVHg946CRnCYvSjqoWRe/kkThGcdsEl@vger.kernel.org, AJvYcCXSZMmqW/A8/+ebgHkw93gW2jqKPolbFw0saMx38riOT6HInnOwnPQjgLc2rTrYhGOknMXl1C7EcCbS5z0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE4Hqf3YTCkfeQ9oimwKNAlrBRawwhE9h5fqKfaaaXmQWBsop6
	IE38cyPXVmrB73olUQrMDPodQPnt50h3bcUqU90K3pHGJ8LlFCs+WvE7
X-Google-Smtp-Source: AGHT+IGMC893+Lvb6crgpz4p6LiMvJ7O/KeQMwbIVHwkPZcqfdXD+XpOSYq1oFrlenHMcofTVGqm+w==
X-Received: by 2002:a17:902:f642:b0:210:e6d7:765 with SMTP id d9443c01a7336-210e6d70d99mr370068705ad.59.1730744083459;
        Mon, 04 Nov 2024 10:14:43 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056edc1asm64371995ad.57.2024.11.04.10.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 10:14:42 -0800 (PST)
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
Subject: [PATCH net-next v7 09/12] selftests: ncdevmem: Remove hard-coded queue numbers
Date: Mon,  4 Nov 2024 10:14:27 -0800
Message-ID: <20241104181430.228682-10-sdf@fomichev.me>
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

Use single last queue of the device and probe it dynamically.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/ncdevmem.c | 40 ++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index be89735d6408..044198ce02a7 100644
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
@@ -715,6 +742,15 @@ int main(int argc, char *argv[])
 
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


