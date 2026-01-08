Return-Path: <linux-kselftest+bounces-48482-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A9199D024DB
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 12:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 173643008753
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 11:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F8742B93E;
	Thu,  8 Jan 2026 09:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="HQg+Gkf3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9D842A592
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 09:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864011; cv=none; b=rNleOS1WLPmK9b1TfJOBQQVrIy1H/lLoTFh+Vql56p3TRtFhEmFDbWhzK5KZnEeM4wWeAxnlZ5c3c45IH/agMs/RXsrcoJzvw+zH2xOPqDKG4GieJpFQGE9CDKC8Bdm0yTR8lZ8GV5B0s3DyNSlt86qXNaN5CGpnjh5YG1yLW7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864011; c=relaxed/simple;
	bh=RSIk539QU0YeMD2OF+ndA/QgOH1sYpMVe11eirRJlyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ikhU0RXO7r0BCjP4m+B7uroswnT83+tX+/uHKY0gcJU/zFc+jIuV5qr5ktR72DtVbaFgEcwc84aoXUsjDuDw7TEsbaSUaAvTe+lb8jlDQ4kUQcsHwPt/AlMG8G7YLN348VtIBUCW5e1AmkDIDHaoJeJ/2ojwQEFhpibA641pCdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=HQg+Gkf3; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2a3051bc432so2656665ad.3
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 01:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767863996; x=1768468796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNgOa//j6HpxCA/+vGAeV8sKsy7oyXQnnYVexO4WVVc=;
        b=HQg+Gkf3zoVBei8tB0SD80KjDtxmlZXuYW+E/ghRRQJiErgN7h2dENzSWI2CzOEEzV
         VlBDfTb5KF3Rac9Yybf6pPy5p6NOwGr30QyPOO4qd6C3FfEI2ih7ULCAHAe3UcogQ1Yf
         ZimDQhWLESIBICtZnBwBde8YVGtaHXMoFm/UbHHClbDvXzTM3uDrAJOJu+uC5J3mxF/b
         THR5HaVfZBZmYJgjFq9OYbSs4bx2PBPa5J+OxOzbM8wHpshN5kUMfEM5+RQw1rXjRkRx
         YxVVLrajpS8SH0VuYalqpF3yT9Gf3sELcToAFxDgPW2C55ncE/X7Vf6UmIpbXuFYlLkX
         DdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767863996; x=1768468796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mNgOa//j6HpxCA/+vGAeV8sKsy7oyXQnnYVexO4WVVc=;
        b=dvK/PQI82E2W31Flj5JIeV0t7VbKOA2OadEgVUcFTtpIjEJCS1+4y0xeXJnOJTl1Rc
         Zt03NZhXYx+aKU0RROqcwTqhldJw6MIspNv+9fvQQQT4aoOxwSvESq4GiJQdVazSq0PO
         QdZSEdB8B5bgdJR1ne4SIWuQLSs8oTEkQMAx/jYwBELKFzqNBxTTNvU3GJRC0CNQJV1p
         E82Y05Sh+tqUWsT9+n4XJSNhxPqFg2SiSyeP5mGCOTGU5i+QmYvCwiIBhFHeeRixx0Mx
         rd172yeyil2GWw6AgBDWm8Avjo1SQWAZyVG3lT0YhUqtIMUrocW82DtYbfT9WVQx/dUw
         RIlw==
X-Forwarded-Encrypted: i=1; AJvYcCUXBartWVwGWNOuASSda305MnBj7MsK9+a3r0MNzzHQ9VguTVfrnDngaaClQA9pxoOnZUhqPQhjusEP81hx9rY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+Y48g0vZorp8jTM0TPVl1EpTE697nwk3L9dhezhMcXhBkA1+A
	KFaFHnUuwospKbEoTKVIG5XuxHYz+2Qbf9gmfq/wZEAMd/FlFzNY0QAcQ/Yzq6PSMqHJuM9Mxop
	8594O/J9xNAI2ygHqr398wqUE/1Hqzs/jACmh6tczn6T6hNjIPSq9
X-Gm-Gg: AY/fxX6AXhLbYDhjZmqwExyX908aQwGI1Yigyg6nkrBaMHVSAg/v+NjMEFq95YmtHDV
	s86dJW57a70Ifp5DmUulNZyYSrV+Z8+/y2v0z9KzALTSEn58kfU0DZtynzlCg3VREmJCC7CRPkp
	QwulC3qF1v4G1ogoSOj3iRAKIya1L2J9kQJFhe0DydyhxP15JU4T3T72wehmYiCAniWg36To/wU
	d7LJeMwBGU2O2f1hR2HbPcQPunxkfaRWRJHD4m4nNqHvmCCh2DRJmICISwBadlVMTRrfoeCe9HD
	rIbHxpo5EufY+oqqzqNvZe7z7wjn3ogepWD6oXmcCw/g7mE0isNCkm2ghs2gFPyOHBJmX2K04UT
	DvyTVynYtQ1FGr9E6bqR+tMPv4WI=
X-Google-Smtp-Source: AGHT+IGlX3edA9YWWH1XbQV4Vo1qb/AsMMH6cjbE0zkab2OXzJttdqFOVlxVLUgkkh4h4Ydm0zkfO4NLDSoM
X-Received: by 2002:a17:903:1983:b0:29f:f14:18a0 with SMTP id d9443c01a7336-2a3ee48fedamr37868625ad.4.1767863995970;
        Thu, 08 Jan 2026 01:19:55 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a3e3c4a15bsm8022805ad.25.2026.01.08.01.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 01:19:55 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.6.120])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 4B7B93421AE;
	Thu,  8 Jan 2026 02:19:55 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 4632AE42F2C; Thu,  8 Jan 2026 02:19:55 -0700 (MST)
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
Subject: [PATCH v4 02/19] ublk: move ublk flag check functions earlier
Date: Thu,  8 Jan 2026 02:19:30 -0700
Message-ID: <20260108091948.1099139-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260108091948.1099139-1-csander@purestorage.com>
References: <20260108091948.1099139-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk_dev_support_user_copy() will be used in ublk_validate_params().
Move these functions next to ublk_{dev,queue}_is_zoned() to avoid
needing to forward-declare them.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 60 ++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 837fedb02e0d..8e3da9b2b93a 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -273,10 +273,40 @@ static inline struct ublksrv_io_desc *
 ublk_get_iod(const struct ublk_queue *ubq, unsigned tag)
 {
 	return &ubq->io_cmd_buf[tag];
 }
 
+static inline bool ublk_support_zero_copy(const struct ublk_queue *ubq)
+{
+	return ubq->flags & UBLK_F_SUPPORT_ZERO_COPY;
+}
+
+static inline bool ublk_dev_support_zero_copy(const struct ublk_device *ub)
+{
+	return ub->dev_info.flags & UBLK_F_SUPPORT_ZERO_COPY;
+}
+
+static inline bool ublk_support_auto_buf_reg(const struct ublk_queue *ubq)
+{
+	return ubq->flags & UBLK_F_AUTO_BUF_REG;
+}
+
+static inline bool ublk_dev_support_auto_buf_reg(const struct ublk_device *ub)
+{
+	return ub->dev_info.flags & UBLK_F_AUTO_BUF_REG;
+}
+
+static inline bool ublk_support_user_copy(const struct ublk_queue *ubq)
+{
+	return ubq->flags & UBLK_F_USER_COPY;
+}
+
+static inline bool ublk_dev_support_user_copy(const struct ublk_device *ub)
+{
+	return ub->dev_info.flags & UBLK_F_USER_COPY;
+}
+
 static inline bool ublk_dev_is_zoned(const struct ublk_device *ub)
 {
 	return ub->dev_info.flags & UBLK_F_ZONED;
 }
 
@@ -671,40 +701,10 @@ static void ublk_apply_params(struct ublk_device *ub)
 
 	if (ub->params.types & UBLK_PARAM_TYPE_ZONED)
 		ublk_dev_param_zoned_apply(ub);
 }
 
-static inline bool ublk_support_zero_copy(const struct ublk_queue *ubq)
-{
-	return ubq->flags & UBLK_F_SUPPORT_ZERO_COPY;
-}
-
-static inline bool ublk_dev_support_zero_copy(const struct ublk_device *ub)
-{
-	return ub->dev_info.flags & UBLK_F_SUPPORT_ZERO_COPY;
-}
-
-static inline bool ublk_support_auto_buf_reg(const struct ublk_queue *ubq)
-{
-	return ubq->flags & UBLK_F_AUTO_BUF_REG;
-}
-
-static inline bool ublk_dev_support_auto_buf_reg(const struct ublk_device *ub)
-{
-	return ub->dev_info.flags & UBLK_F_AUTO_BUF_REG;
-}
-
-static inline bool ublk_support_user_copy(const struct ublk_queue *ubq)
-{
-	return ubq->flags & UBLK_F_USER_COPY;
-}
-
-static inline bool ublk_dev_support_user_copy(const struct ublk_device *ub)
-{
-	return ub->dev_info.flags & UBLK_F_USER_COPY;
-}
-
 static inline bool ublk_need_map_io(const struct ublk_queue *ubq)
 {
 	return !ublk_support_user_copy(ubq) && !ublk_support_zero_copy(ubq) &&
 		!ublk_support_auto_buf_reg(ubq);
 }
-- 
2.45.2


