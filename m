Return-Path: <linux-kselftest+bounces-28038-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 006FBA4C095
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 13:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66241188AF15
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 12:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B75120E032;
	Mon,  3 Mar 2025 12:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iW2ssADQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FB520370D
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Mar 2025 12:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741005840; cv=none; b=KWzcXDunjJixaYU9AuojgD5yUp6I788/EXnTYtldgyMKyFXFAMxVlO3ZuO1HbLUENIRVdxTblWB2Uh/yaH/Lx0YzAy59b2X6ceQABIhyaMp/cJiG/NSk4xtwq3AjQyTgeAm95p4BM640Lgoofgrf/o8aMelaFssqfsbzA2stIEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741005840; c=relaxed/simple;
	bh=PALAmA07A0ocsHQIxyxYGhUW2CaWEXY/6wTWSrf84Uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pFXfqxVSLxf7z6fM5mfw5gkzw8Q8gEgjJlCbKzkSD7s51rSg0OZG/LWZFiXBXvNdhxM2PS8Qb7iutOjBrMjgPLSDfQRfLKTi7yuUUCG0G20T5M/dQxuciUQ5b0ilCgu6Z4w/zxgaeY1OUFm2T9nveciny1kPTyKCw1swi4hyG4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iW2ssADQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741005837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZgHwoN4FkuivIO+yjtqGfA61kFi7hVKtRpikbqGM3uU=;
	b=iW2ssADQnqt5pbI3ynROtyH/T8HC3L5UaztWU6/xqbp+VznM6JCaqbizSZ3q5iVzl52VX0
	WxhpojinQP3oTadeRSsj7SCqffIYr4C9PmtJOloLaP7bjQTQVvSt4gY3sJHEMs3Jrd9V8X
	NfCp7ZueT6c1IyzeohwrQInWwyWKhyo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-tLrZL-b_N5ScaYPRjuEREA-1; Mon,
 03 Mar 2025 07:43:54 -0500
X-MC-Unique: tLrZL-b_N5ScaYPRjuEREA-1
X-Mimecast-MFC-AGG-ID: tLrZL-b_N5ScaYPRjuEREA_1741005833
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5142D1944D03;
	Mon,  3 Mar 2025 12:43:53 +0000 (UTC)
Received: from localhost (unknown [10.72.120.23])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F3CA0180087D;
	Mon,  3 Mar 2025 12:43:51 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 03/11] selftests: ublk: add --foreground command line
Date: Mon,  3 Mar 2025 20:43:13 +0800
Message-ID: <20250303124324.3563605-4-ming.lei@redhat.com>
In-Reply-To: <20250303124324.3563605-1-ming.lei@redhat.com>
References: <20250303124324.3563605-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add --foreground command for helping to debug.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/kublk.c | 17 +++++++++++++----
 tools/testing/selftests/ublk/kublk.h |  1 +
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 2072d880fdc4..24557a3e5508 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -679,7 +679,10 @@ static int ublk_start_daemon(const struct dev_ctx *ctx, struct ublk_dev *dev)
 	}
 
 	ublk_ctrl_get_info(dev);
-	ublk_send_dev_event(ctx, dev->dev_info.dev_id);
+	if (ctx->fg)
+		ublk_ctrl_dump(dev);
+	else
+		ublk_send_dev_event(ctx, dev->dev_info.dev_id);
 
 	/* wait until we are terminated */
 	for (i = 0; i < dinfo->nr_hw_queues; i++)
@@ -867,6 +870,9 @@ static int cmd_dev_add(struct dev_ctx *ctx)
 {
 	int res;
 
+	if (ctx->fg)
+		goto run;
+
 	ctx->_evtfd = eventfd(0, 0);
 	if (ctx->_evtfd < 0) {
 		ublk_err("%s: failed to create eventfd %s\n", __func__, strerror(errno));
@@ -876,8 +882,9 @@ static int cmd_dev_add(struct dev_ctx *ctx)
 	setsid();
 	res = fork();
 	if (res == 0) {
-		__cmd_dev_add(ctx);
-		exit(EXIT_SUCCESS);
+run:
+		res = __cmd_dev_add(ctx);
+		return res;
 	} else if (res > 0) {
 		uint64_t id;
 
@@ -1044,6 +1051,7 @@ int main(int argc, char *argv[])
 		{ "debug_mask",		1,	NULL,  0  },
 		{ "quiet",		0,	NULL,  0  },
 		{ "zero_copy",          1,      NULL, 'z' },
+		{ "foreground",		0,	NULL,  0  },
 		{ 0, 0, 0, 0 }
 	};
 	int option_idx, opt;
@@ -1087,7 +1095,8 @@ int main(int argc, char *argv[])
 				ublk_dbg_mask = strtol(optarg, NULL, 16);
 			if (!strcmp(longopts[option_idx].name, "quiet"))
 				ublk_dbg_mask = 0;
-			break;
+			if (!strcmp(longopts[option_idx].name, "foreground"))
+				ctx.fg = 1;
 		}
 	}
 
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 8f48eb8568ab..26d9aa9c5ca2 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -67,6 +67,7 @@ struct dev_ctx {
 	char *files[MAX_BACK_FILES];
 	unsigned int	logging:1;
 	unsigned int	all:1;
+	unsigned int	fg:1;
 
 	int _evtfd;
 };
-- 
2.47.0


