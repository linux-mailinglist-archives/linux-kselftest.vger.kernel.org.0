Return-Path: <linux-kselftest+bounces-48241-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E21CF624A
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 01:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0716303B794
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 00:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47071225A3B;
	Tue,  6 Jan 2026 00:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="PMp2pu3A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f227.google.com (mail-vk1-f227.google.com [209.85.221.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D772163B2
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 00:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661092; cv=none; b=MHc7oV19JaGhSXVDCNfMUk3Rw8cGYhMzHG2MWWM+UQGrIT8XX+0iN9DcygFQhC99m3tJTKh9ujwPs5zlPqI0ICOg4Bp/YU3aeMTyE1F3i77n1xUGRD5JdwTSC1oOICZjGEB7Wpy494OmikYc1Sz5geX9ai8llk3azib7wy0C0+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661092; c=relaxed/simple;
	bh=MFrMgizmK5MaIPV+Gko7o6kSYnpBboKUcVmDmAwyHCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W08AI0nSe+WIhP1pcTlL9Ghv2KU783VLzCNl1YoL0fJW74fu4CdFOZ0qT+HCSYVq8UaRhPQG57Np5RT9CoMiDVTsQnBYsDLkfm9karK2f3ZiBTQSlSIVGfttx8SuCzX64Ogvm/q2a+quL1c+9T9f/algvBXUkAnv+Rv/sFES35k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=PMp2pu3A; arc=none smtp.client-ip=209.85.221.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-vk1-f227.google.com with SMTP id 71dfb90a1353d-5595f3acf27so18682e0c.0
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jan 2026 16:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767661089; x=1768265889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNQyNIuF0YsgyAJSwbc/xgpZYuEtibH5Z0ga5IDU7gw=;
        b=PMp2pu3ACjn1sCwdWRqazeoN7KrK1cWNvEYCk9mzn0Tk3UeXs/U72J7hmmcA4aYTTK
         iMJL8SMCA8YWRT2PWb5eb6vk/bHU1pbF4tIaZ6oCkBtSUMuwGM/75s4/UPWy8MWpTUi8
         ay+lqlQ8HpLX1ztZt/lKlRpBvvnSbs1vQBml6paaGrBWR9Q1L7SkZXtfR7AOKTOcAWka
         HgH1SCSbBHyyxshYB+4jqCZLb3Pf7Ha789aPHzyGD+Y2w8KcxxDgf4CelhWT57SwqRjl
         HM8DH2n047Z1JfVKzi4Ihbp78fJokt9oJ79+DbhC/p2iHOO7tIu+7Y/mBi14CN3kIZ0o
         Gjgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661089; x=1768265889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MNQyNIuF0YsgyAJSwbc/xgpZYuEtibH5Z0ga5IDU7gw=;
        b=U4PYmdkgVJV3wdLTm2XvRsXgvPf4WfxlRKpqPm+D/Gsq2DdLSo+SkBqXDpe+ACaREs
         IZ3ElcIp+6AWbHxEK/gdsmS3nMtHxOCdlblNYpTYNP+bIIwQV2L71qFaNHCQugrjOMDN
         7+kKMNosx9ooFjWDd7+ZN+elzvFdWWo4a5JPwsKtsYa/k/TnqlJ7EI5+Hy3kNMRrXnaV
         QZZZLJ18R7n5oDNqies/vpJQdnNwtqivUEO3eDBzJLSbpiicDlxLXpZOoiz/Nv/wFgii
         GH/AxZ29O73vsONVl3r78LwmkoVfUfj2c+fbr//iNiT81E4zJ+tN5rl0aiuSWqvKl0B0
         CzAw==
X-Forwarded-Encrypted: i=1; AJvYcCU04qx8QUqDAxCJ6ZUGYbNp2unMoRcf7GSow/OmiOwCSedUHr6cnlXwXK3WdW1uKQ3FLFuUurCHXfuig9RGAUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyunUVMD9eIc3rdVgVse9TORiuuwajN+7fj0cfacrGqxvmMGZWY
	BshfWChrtzNjjjog70dH4i2wzHW8P5a7ClRO+ctXeUgJ7HVtGrQHgcyrUrJZHk0YhLtcAJ0G4nM
	6IA+5dKo3P9jZArFrX8sXaAFeNEZjWucbYqedQPKqep51c5NKQrIw
X-Gm-Gg: AY/fxX46NQXVAlQnMwrPnQ+LtHwxohsA93HSim1qQrimzlLyNxeIhlSHypvU/xH+332
	WW249Lv69Fa5MORi7O3NOunLSLM2We2cLj6Tf1UPpyqhQGJhl14BWZ9iPXJCv0pZlX8wOjqi80a
	9k9RLnEX4xu/2u9cjAtBVv9Dd9iLH8F7S5yRZuV3J57MSuY/AAXq/CspD/H4lr6lwlas7lWPPWw
	pxfMPQ/RkPEKeaFPujdGsh8NYReRdX9LHCRQ66TM33LYWCU8fH98U6A8yg6vGOYK+qj6lZkbBXi
	D3Cpug0ZxfFjKCCzGOGg1dNHJjQt7RP5kiV9aN/oSTZFJh+yIQ5+W7j6Co4Yak050fKJARTmxxz
	YNfjOxbBNzfyPDo4EnMc7W2lwDbI=
X-Google-Smtp-Source: AGHT+IE61WlaoTEdEojd+c8ZwUjfNjslPkPW4kBvumfbC08CESGGGz0wA+YeAH99IQPcIB5gAPU5IWfKHKOH
X-Received: by 2002:a05:6122:ca1:b0:55b:1668:8a76 with SMTP id 71dfb90a1353d-56339524d92mr266941e0c.2.1767661089325;
        Mon, 05 Jan 2026 16:58:09 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5633a40656fsm84914e0c.7.2026.01.05.16.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 16:58:09 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id B942334084D;
	Mon,  5 Jan 2026 17:58:07 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id A8E81E44554; Mon,  5 Jan 2026 17:58:07 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 01/19] blk-integrity: take const pointer in blk_integrity_rq()
Date: Mon,  5 Jan 2026 17:57:33 -0700
Message-ID: <20260106005752.3784925-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260106005752.3784925-1-csander@purestorage.com>
References: <20260106005752.3784925-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

blk_integrity_rq() doesn't modify the struct request passed in, so allow
a const pointer to be passed. Use a matching signature for the
!CONFIG_BLK_DEV_INTEGRITY version.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 include/linux/blk-integrity.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
index a6b84206eb94..c15b1ac62765 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -89,11 +89,11 @@ static inline unsigned int bio_integrity_bytes(struct blk_integrity *bi,
 					       unsigned int sectors)
 {
 	return bio_integrity_intervals(bi, sectors) * bi->metadata_size;
 }
 
-static inline bool blk_integrity_rq(struct request *rq)
+static inline bool blk_integrity_rq(const struct request *rq)
 {
 	return rq->cmd_flags & REQ_INTEGRITY;
 }
 
 /*
@@ -166,13 +166,13 @@ static inline unsigned int bio_integrity_intervals(struct blk_integrity *bi,
 static inline unsigned int bio_integrity_bytes(struct blk_integrity *bi,
 					       unsigned int sectors)
 {
 	return 0;
 }
-static inline int blk_integrity_rq(struct request *rq)
+static inline bool blk_integrity_rq(const struct request *rq)
 {
-	return 0;
+	return false;
 }
 
 static inline struct bio_vec rq_integrity_vec(struct request *rq)
 {
 	/* the optimizer will remove all calls to this function */
-- 
2.45.2


