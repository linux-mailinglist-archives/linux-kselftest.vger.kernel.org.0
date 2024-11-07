Return-Path: <linux-kselftest+bounces-21636-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A29D99C0D95
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 19:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2490E1F24C09
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 18:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5BE219484;
	Thu,  7 Nov 2024 18:12:26 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E574218957;
	Thu,  7 Nov 2024 18:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731003146; cv=none; b=odmb3AO2rcP8WnsCIhiFoppQd/a7iRX8QY2BTw1AkWbtUFc3uTDBqjGiEdmw8tLu5qUWORh9o1+QYL4TDlaXHvRtF2rl1gNdtOq+h2Tg9TduDlVsw+YtJ3rl6JnO7t9TT2guiozRKLrfLye6T6ofvHGUHWW4fw0KjfYce5oL9KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731003146; c=relaxed/simple;
	bh=GhC9tGqKarQ2Bdbc3qqWnBXRxTTtgWuongQth71ldwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e1aQOMHwGB8bZD1wEVDzkWZtpmn+VKaMt+Ket0+Z/Ev/uWmQO2O/tnLshpRIsdB6o7xDOFI/XPybWaCMYkxIqZndxrCMoa/h0nYCRIJQ75OBiNy9WiajCzRZz1W5p2nsp0+2qilyPeYppmWQTWLtY8Sts7sVQuq1PR5ppaRfL2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7f3e30a43f1so956800a12.1;
        Thu, 07 Nov 2024 10:12:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731003144; x=1731607944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZvCVvFo9Qc8rModALEQHZE29SD8rgkDPTG1TevSkcA8=;
        b=beS4yPGczFwYxMzKugAcE63LKLMwJliOJyz0YNLeusU55JESsdOXUCG0CRXtDS9EgT
         OPmVRQukulWShAx7GVHmVV8AcqyP1UvJ4aAxrc6BlFNwMCk2th+6sRF/HwnlwkB+90W9
         4XYmJSTlh4jVZ5Dv2GgBmX6lNpjBI3Vrl4jgMeVdiMcSu1ExHhqbvOMbEn9COckGlaQI
         KQUhBRoAXVfyNqk3lb6TloMGJrT3a0zyF5RdsTXeQ65qOyc+NRi5ddZxoy7VKc4pZxJH
         uo0636+tbX27LZICCrk/3iwIDOcQInXCs76KLWTqSS9zpIfe9hLiZWi8FPagkCMyILY3
         LcyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUv1L6lpPSxur1DoYNln6iBOh1eHKWFu/OBlyFfFAXlXc8j2RbJOjSP5ozOfYbQnyAvHUjd98/zlK6WdOGwt+zI@vger.kernel.org, AJvYcCWLAch2uNCeGqiD+mVs+8MmBk/ZJNhgduqAX4SWjtOdkV+oOG9d7GnwxzSUplPojJFzHuMxWH3FYf6yIV4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgm1kURpM0omSXGQTe+5SqtQRG+zm3mvF5OXFfFOwOb30kDPyq
	E+RgdpdQ/xWfHS1cDVQmbatIWBh6Uawu3zhNIBvZAoOer9gRWd93pXVF
X-Google-Smtp-Source: AGHT+IFV0VHiaT6gLpvKpGa/i997fI0xVeW+AcxPD4YDHOECBfRtRsxObNP4T8pzvqrW+PeSBJKZtg==
X-Received: by 2002:a05:6a20:748f:b0:1dc:30b:cfe with SMTP id adf61e73a8af0-1dc20637470mr621193637.37.1731003143922;
        Thu, 07 Nov 2024 10:12:23 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407860906sm1886811b3a.9.2024.11.07.10.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 10:12:23 -0800 (PST)
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
Subject: [PATCH net-next v8 09/12] selftests: ncdevmem: Remove hard-coded queue numbers
Date: Thu,  7 Nov 2024 10:12:08 -0800
Message-ID: <20241107181211.3934153-10-sdf@fomichev.me>
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

Use single last queue of the device and probe it dynamically.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/ncdevmem.c | 40 ++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index 9ca2da3a2f63..1ea62c129ddc 100644
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
@@ -711,6 +738,15 @@ int main(int argc, char *argv[])
 
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


