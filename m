Return-Path: <linux-kselftest+bounces-47644-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9573CC610B
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 06:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 358DE3048D9B
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 05:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC9C2BF015;
	Wed, 17 Dec 2025 05:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="SmhtK5EJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f100.google.com (mail-yx1-f100.google.com [74.125.224.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F7E26B2D2
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Dec 2025 05:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765949720; cv=none; b=d4+lQYnrKO7xGYzZD/G9zBl0SqEuvu/kWEMRCaxju7hd6qM6NM3v/HXQfQSL44AM+6EGwAA4TZNUNzcCTPormEN1LES6ln4ugp79mSn9yplJJZj1pHJyO06y9IVg91hYpK9TmK38gLFlBtSHXBr75n1Uvx+VNZ9IMbp+bgHW0SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765949720; c=relaxed/simple;
	bh=aD7QvT8m0ONYPgRJxDVX6ESAo8vcXx88PHv+jCm6Q1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ksc/NdQJ6r3ujrekICPR0ua0K2IqzRoEd9XDNUZ0QVXmUF4y8nmXk7/VrpZFAYVoll65+WfA+DlQCv1zI4hOdqYgCoOi7vimp47jzSxaWjIfwdSDMtaUKtASMDrmg0/oQthAyvQacO1dJRI3LPp44SjKQp8iGvNsFrNy3NlOoEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=SmhtK5EJ; arc=none smtp.client-ip=74.125.224.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-yx1-f100.google.com with SMTP id 956f58d0204a3-63f9fa715c6so844997d50.2
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Dec 2025 21:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765949713; x=1766554513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezc5r1HBuR8+0jmYpVSGWVnyd2FmDQBIXjG2jOM8aPQ=;
        b=SmhtK5EJSrIJ0x3+Wgav6FlA+I8HXYuKzjmlPJbyC1gVUoO+i0JX4F7w05bREfg9gb
         S/W58KcaGxU8SB+dsnYLyFwW3Zm34QG9wpWPxK50zXqdeGY3UjHq2jxhWaUjpJqlTH1N
         q/eqvt77V9pu4ngugMtpgvcojmYcGHDFidIxlFcmbmLITAOnjrhGUGBNQmNEIiyRD1Hp
         Ue9rfv2sZJp4TVYnm024/bpqDQWUzKp2B5DjpAHGJ0Q38cYv84Gz1KfWYMr/alBtLvrc
         HeEXHrm70sq/VKnIcMNakrS4SPVO5vZj4Z1JzF5XgmX3XzkdxjAm0on7sB7/jf5UDPQ5
         cHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765949713; x=1766554513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ezc5r1HBuR8+0jmYpVSGWVnyd2FmDQBIXjG2jOM8aPQ=;
        b=Ts1delMoA18dVf0+3LG6CzwKIiUjQ8UvukqbHVXN/Mobne/xl859xPYG5QkpvPsta/
         9m+CZHT/oIAp2mhK8o80hEp4vcjXq/3tPHJwT+dWMc4aDxjWcTbDzeVQSQF4CDN3LpLZ
         DqH5OxNdWbJJ3wmI+/KgOi6bxFjdFTcn/+xgU3SExPharvwK+YzybIB9GN9T76f4PGir
         B041KiExQR7Ud4hl9NH/8Sa6bEdoNar0MHnYVPT4QYl6in6xiObzFXtyg2kNATiYdfjz
         CeNF491tyOjlV0pvfvN66QiL2NfB3VXTLOuZpCPlbXkI7IICTp9pfnpi4hMc6/G1wOiv
         ex4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQzczbkF4PAEuCjnkBWNrwiIY3QwEc1gk13hqLEg/nKUIx8nDhJY74aKvTix0INDK3z8E2CCtR1mN7vtwH7FI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKKAyHFqvBD3wVj9Vi8MUMgXkAdnRebC3HW3MKvV2b6FnlwyUT
	CuJ/nwYUOZKP5CR49AfI0zfT3E4Rrz3QTRgKaNYCSFEN5rVGGx4MrzNh9yj3dcmrRA2bl7F95Z7
	ezqpeyqH8mLagC4ymIn3qeF/iZr6BM6sdCp+4Ewt3TYapAUWk81LS
X-Gm-Gg: AY/fxX782vTqkGUcXe5F66SVS2r14M83JD9OkLssWcahH89CkgC/1Dz4Ud2Zt6+xlJZ
	x+gpxt4/TVabkAY1RGGyArrniYjB6sW0ptfz8Q2cdpb7oEdUiHg+GlYgT5SUtX9c/tVETyiqul0
	h5NussE7gHV7Pi36S6Lkqv6Q+auzlXEGys03xA+mTX0usNh6yeL+woSaL/jVofj5vPfaQ3jwYsr
	fW8hDLzxfc3+ZNm6RPKeLXzvQjVc6gICWa1QWxBeJoEnYSugICAmu3IQkmqOinNu0wTMHTjEOji
	nJv/qMS+4owRyyytVT8PI1t8K7Q6FuSfHozYFDpjxnaCbTlSRHJjH0EVBY5Sr0EbMP9q6uoYIkm
	GXv1rUE5pvWchWdi3WEv6i0fctr4=
X-Google-Smtp-Source: AGHT+IGDVPrgNu9LhhkOAfEoaeOE/9G2q9MLKqgYrJRDejIIwiTDpmwJNvXg1IgkUw3GnsHHrvT+5hI1MqDw
X-Received: by 2002:a05:690e:1448:b0:644:49be:4b8e with SMTP id 956f58d0204a3-64555515881mr10604674d50.0.1765949713087;
        Tue, 16 Dec 2025 21:35:13 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-78e747ab14fsm12279017b3.0.2025.12.16.21.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 21:35:13 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id E5E6D34222B;
	Tue, 16 Dec 2025 22:35:11 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id E37E8E41A08; Tue, 16 Dec 2025 22:35:11 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 05/20] ublk: move ublk flag check functions earlier
Date: Tue, 16 Dec 2025 22:34:39 -0700
Message-ID: <20251217053455.281509-6-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251217053455.281509-1-csander@purestorage.com>
References: <20251217053455.281509-1-csander@purestorage.com>
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
---
 drivers/block/ublk_drv.c | 60 ++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 78f3e22151b9..4da5d8ff1e1d 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -258,10 +258,40 @@ static inline struct ublksrv_io_desc *
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
 
@@ -656,40 +686,10 @@ static void ublk_apply_params(struct ublk_device *ub)
 
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


