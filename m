Return-Path: <linux-kselftest+bounces-34266-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C89CACD054
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 01:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BACE188C658
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 23:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5837253346;
	Tue,  3 Jun 2025 23:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="KTM4WEDp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f225.google.com (mail-il1-f225.google.com [209.85.166.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CFF2522B5
	for <linux-kselftest@vger.kernel.org>; Tue,  3 Jun 2025 23:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748993921; cv=none; b=t4sIk0bBS3KgRQyFzompOYUN7f8Fx5ZpJGQeLuZ4144nFl4tHzzYzrdMphaF+o54Oa2pqakrCwpvL4J9QlCROofWFnzOuLC2rzK4jakWHm5WM9AT1Iuzx1/+B2fh/DB3cH+kTvgg+eaPakYDqGQEUDHQBZGmuBOoJqvWNGMLkgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748993921; c=relaxed/simple;
	bh=GRKko8U6tkBwoDvqev25212EMIC0D1LUxb+uSFlHjvA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uWxqHwfgCnoUZ22nB+MfyCLQZVa3/Rv5RPwB7Ve7fmZ15u/4/BLgPVkl9b/sZ/UD2l3rk+g64FyHaYLnyGDHL0o4aUpXch5pC9WS0+1VpH1pI+d44HGjcqgVt7Ip1DJCjPa7njGiaiN3aegJGePxh3YlOBd4bQ/IakqG47oWVuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=KTM4WEDp; arc=none smtp.client-ip=209.85.166.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-il1-f225.google.com with SMTP id e9e14a558f8ab-3dc7830a386so19741115ab.1
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Jun 2025 16:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1748993917; x=1749598717; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/R0RpgCFKdTj3IOKRqUkoQl1YyksTGBaXOZihTi8ctY=;
        b=KTM4WEDp1d4DHkOu92A6lL7h/GBr5zNy5dZ7BMk2MYTg+ip5aeLGTRcY6XgT5Iy+xx
         +uAA2thmT0uoHnNf3WrcliZN/ririxeGYhzprzlazkTRGT2UFFuONWR8GxtIax1AAS6P
         PSzSdGFOM8R4rg066jLU9ZD9OQLc/Ag6ew0ZQRolvZnItRC14GaVXNMVhopVdj+2eEQc
         TpksRpE0IPQi8iUcQLbVuOTWr8i68ip8SHJoaQCqM/LfXV536e232lyIjQWn6qmoneCu
         mzo0+6x/aCp8vKr+qZGf6/SDKmrZWg2QUsx7RZXVxUaDZTnzvvc4X+Uhw8gOEJ2WsRpr
         xL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748993917; x=1749598717;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/R0RpgCFKdTj3IOKRqUkoQl1YyksTGBaXOZihTi8ctY=;
        b=eqzxhUe2rpbKagN4XdqxUT9/eBLdWM4dCk+4hIIMyLOJOz377bNbVvJ3/SpTy5DFly
         zf+IamiMYta0lQkhx3QACj7ZJFkW70az2EIIO557NI5IHUrZ1bZ71bP9wkoGO+bGpzL6
         C2dQx5ngZFn9jsiPuTOJQKqCzI5GeZ3mqOP099cwG2MwqmHcaXxDiSCHl6ws91l5Jv6n
         Y912Lu8/FeHSjnq6G1VhomsUIDLsdkdxaFa5fkTM8s+quV817YMWT1Ck6igJEAx3VtT5
         bc23leI9ts5hoZBVwJv/N+2snoJ1lRvW7qXO5bifXHjnjrjTcp34dTFXWT98/n1J+glK
         tB+w==
X-Forwarded-Encrypted: i=1; AJvYcCXJELgo2QWYBfEaeOsnajsUu7SVwJV0t5MWCsII/9tWTfN7SSfSstUGOPi4ugvWknGY819TqHGF+DhfHUMNoyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqOrYqDFvMdyaK7JjBdr33+WA5fn1NLz9UeLK8wZLNP5gGfXhF
	4/uJZeHGN/wMTHNHOKi0VzdFnSnoOcFuYBmyafpB7SHndIEMRQrv05TXD54k0T/e4Ga6ocywcu0
	1OJTDiWIhTcksMPH9KP1J5efLSw/bqhojVaEy
X-Gm-Gg: ASbGncvdjshSfjurldP0oclvf1XzxyJsTCRM0xdDW3Qm2YXw2zwTRBwvc5aZgFizr2M
	CTZySWd54aCpG4dlYaYkqYJgL71K6Qz5ZAqaQAMGNaqARo/hv5JIAsunbypNyx7Y26g8lCXe+3J
	FDnlUen/hNSPk/ynhRJ1p7nX42Ev46BPZmbFunJd0NP6+imVxEoxNhRi7PDuL4DGYzyADITm0Df
	ybqSOGBA4mQySdhCmyohEImJy/czVrXYgGPbxC2l9vjqJ9scVJTWR2LL+4XrKVjVV8ihFadotjg
	DKsMcaaHdVmKRyms/2a+Ytmcz3jKf2eeug8iAUiKddcmuw==
X-Google-Smtp-Source: AGHT+IE2Clg33E/8c+qwuR12THXL4yJ4NH4pmMoiTeWYcHOgHxUyzjy7wBBi6+80u6OaDk7frWPxrt/0AjAt
X-Received: by 2002:a05:6e02:3989:b0:3dc:7fa4:832 with SMTP id e9e14a558f8ab-3ddbee093d0mr9255995ab.9.1748993917492;
        Tue, 03 Jun 2025 16:38:37 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-4fdd7e3ee09sm297542173.37.2025.06.03.16.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 16:38:37 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id ED38C3401B8;
	Tue,  3 Jun 2025 17:38:36 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id DBCA5E40EF7; Tue,  3 Jun 2025 17:38:36 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Tue, 03 Jun 2025 17:38:33 -0600
Subject: [PATCH] selftests: ublk: kublk: improve behavior on init failure
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250603-ublk_init_fail-v1-1-87c91486230e@purestorage.com>
X-B4-Tracking: v=1; b=H4sIAHiHP2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDMwNj3dKknOz4zLzMkvi0xMwc3SQTSwtLA1NDU8vUJCWgpoKi1LTMCrC
 B0bG1tQCSUc+VYAAAAA==
X-Change-ID: 20250603-ublk_init_fail-b498905159eb
To: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

Some failure modes are handled poorly by kublk. For example, if ublk_drv
is built as a module but not currently loaded into the kernel, ./kublk
add ... just hangs forever. This happens because in this case (and a few
others), the worker process does not notify its parent (via a write to
the shared eventfd) that it has tried and failed to initialize, so the
parent hangs forever. Fix this by ensuring that we always notify the
parent process of any initialization failure, and have the parent print
a (not very descriptive) log line when this happens.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 tools/testing/selftests/ublk/kublk.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index a98e14e4c245965d817b93843ff9a4011291223b..e2d2042810d4bb472e48a0ed91317d2bdf6e2f2a 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -1112,7 +1112,7 @@ static int __cmd_dev_add(const struct dev_ctx *ctx)
 	__u64 features;
 	const struct ublk_tgt_ops *ops;
 	struct ublksrv_ctrl_dev_info *info;
-	struct ublk_dev *dev;
+	struct ublk_dev *dev = NULL;
 	int dev_id = ctx->dev_id;
 	int ret, i;
 
@@ -1120,13 +1120,15 @@ static int __cmd_dev_add(const struct dev_ctx *ctx)
 	if (!ops) {
 		ublk_err("%s: no such tgt type, type %s\n",
 				__func__, tgt_type);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto fail;
 	}
 
 	if (nr_queues > UBLK_MAX_QUEUES || depth > UBLK_QUEUE_DEPTH) {
 		ublk_err("%s: invalid nr_queues or depth queues %u depth %u\n",
 				__func__, nr_queues, depth);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto fail;
 	}
 
 	/* default to 1:1 threads:queues if nthreads is unspecified */
@@ -1136,30 +1138,37 @@ static int __cmd_dev_add(const struct dev_ctx *ctx)
 	if (nthreads > UBLK_MAX_THREADS) {
 		ublk_err("%s: %u is too many threads (max %u)\n",
 				__func__, nthreads, UBLK_MAX_THREADS);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto fail;
 	}
 
 	if (nthreads != nr_queues && !ctx->per_io_tasks) {
 		ublk_err("%s: threads %u must be same as queues %u if "
 			"not using per_io_tasks\n",
 			__func__, nthreads, nr_queues);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto fail;
 	}
 
 	dev = ublk_ctrl_init();
 	if (!dev) {
 		ublk_err("%s: can't alloc dev id %d, type %s\n",
 				__func__, dev_id, tgt_type);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto fail;
 	}
 
 	/* kernel doesn't support get_features */
 	ret = ublk_ctrl_get_features(dev, &features);
-	if (ret < 0)
-		return -EINVAL;
+	if (ret < 0) {
+		ret = -EINVAL;
+		goto fail;
+	}
 
-	if (!(features & UBLK_F_CMD_IOCTL_ENCODE))
-		return -ENOTSUP;
+	if (!(features & UBLK_F_CMD_IOCTL_ENCODE)) {
+		ret = -ENOTSUP;
+		goto fail;
+	}
 
 	info = &dev->dev_info;
 	info->dev_id = ctx->dev_id;
@@ -1200,7 +1209,8 @@ static int __cmd_dev_add(const struct dev_ctx *ctx)
 fail:
 	if (ret < 0)
 		ublk_send_dev_event(ctx, dev, -1);
-	ublk_ctrl_deinit(dev);
+	if (dev)
+		ublk_ctrl_deinit(dev);
 	return ret;
 }
 
@@ -1262,6 +1272,8 @@ static int cmd_dev_add(struct dev_ctx *ctx)
 		shmctl(ctx->_shmid, IPC_RMID, NULL);
 		/* wait for child and detach from it */
 		wait(NULL);
+		if (exit_code == EXIT_FAILURE)
+			ublk_err("%s: command failed\n", __func__);
 		exit(exit_code);
 	} else {
 		exit(EXIT_FAILURE);

---
base-commit: c09a8b00f850d3ca0af998bff1fac4a3f6d11768
change-id: 20250603-ublk_init_fail-b498905159eb

Best regards,
-- 
Uday Shankar <ushankar@purestorage.com>


