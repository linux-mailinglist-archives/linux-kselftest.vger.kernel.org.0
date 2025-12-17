Return-Path: <linux-kselftest+bounces-47638-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5673CC60D8
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 06:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 177EC3029C73
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 05:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6088C280023;
	Wed, 17 Dec 2025 05:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="QPhW/l4B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2264523D7F3
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Dec 2025 05:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765949716; cv=none; b=D1EkYSjAqRyk4EUqQWPOQ3aTiUCt4OVDbI2Ip2TAbiN+yW6q/yOeAH6mBlzBL5f5qJYOpah6uhlACvQwIhZdHJeJBvM67YRJxaM0vSDJQHDVzLuZM5AV15vVO+dlAGQrUB4yyE+kmdG66MbM2jbA6S9KXegwakPjl/d47logTdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765949716; c=relaxed/simple;
	bh=xUnt6tcNFcvbLUQluEk+DA7ehpoD9vCwdlMzIL9waLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mF6imE+LjnFcMXxGUqBD4UvoMSgEc+kYmptFRQ/L+TBugBRCEdTUdyP9UC/qVZNCsjmyqnQcTrrYIvSGxohdQ9/NUIBayiR3ZKGK9pYCwnyY32ayncyjbdQapIXwuzuW+vcNArMjk7Eqz+q0OAW4qY/r/0wYWO41ZEKQ0HAe0uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=QPhW/l4B; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2a08ced9a36so9763635ad.2
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Dec 2025 21:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765949713; x=1766554513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hT0LIZA1/TY2oqNx1vHBtwvUuMBhHk0keJnG4GSpICg=;
        b=QPhW/l4B6tWoXj5qDnMRCWuTF1jZyUTu9gPxmoIF+Kmn/ScMbAeFaaQm1EC2S7oTDw
         MPSnj5bVzx5Zhk3lr15jDGWz0dmQPvUuG1C38xyShrPo2jLwD0s5BqZTkaWkVhHvAvaj
         cJW6kyt9VQcZI5GVuq6SI6ltdXBD1cbG8RPkJ2wgMXkZ17BANjN0Bx+8pgIyygMjKoWM
         znvceNfXgjPOCkrGyxp7jupSTVCoj9ILURiDqH0KopDUZG1Esb2xLSWHWfJvCmPl+Xz4
         ejVyuCDMzhVD36P9wUhtQ5GsJnO0KTfSZjlfdkgAjfeAEu9gsF5pugUT7QLc0txHas2A
         3vYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765949713; x=1766554513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hT0LIZA1/TY2oqNx1vHBtwvUuMBhHk0keJnG4GSpICg=;
        b=NU2yw/DjrMZIxlzPWoF1OvJDyM9CmZtOY4XWJh/oZ3i+Bb+9Zn4ViRaCL7YA/mwF8I
         F1R4J6HQPDa0j0BiP1KeA9gIlPeiICHl1fTA4KF6n2joohPu1FRNp74BeJkH1jC9l5zm
         yeKw8y73A0jeOnVqjUrTxm0XN6y7YkNaYr2my+XbyExq16Qz9QCUlgHEv154ETLqkd1t
         zMIi18tNXJJYUw7LBzC+ymoZRtSuoG0/0SdXIedpUlI+AWxgqnj1xMy6O42gKwF7tn3l
         FkoJX+tt7UBYjFeNEQEnD0ycU2WoozrF2cC1JFro3FQH+aZStCoRLKW9HA9KoFZovGRR
         TGDg==
X-Forwarded-Encrypted: i=1; AJvYcCVFHq4LAusMu2HSHV2SWaYTTZV26opj28h8t1xGZ+f8tnwYYLEXOeZjeBT8n31DYRN15LitljoTnEarRdFu6NY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVC6tZx9FYSMoMyKrg54tBMrOu8ds0TNZz0kUro2/jK9IXMZcn
	66JnpwbQDP4PegWaxS77g4CnQX7B525R2yLF4U3ejpW1t66pEdDiBYAT0ieseJhCaR+Tleq4YG6
	uq9AC7cdpzLe6ejw/il/PcUn0/o9MYzyGaIZQ
X-Gm-Gg: AY/fxX5AmG0L4O7jsA9LjGrG+lDfFgx/CHsdq9/3sGGK1fxS8IoI22hSxlNB3IDIpFT
	AxP7i+N9AIAay8zD0Gg24Svm826kqjwTclQ6a36hHI8v5P0fUii63SIJ3bCVe/cf3VUfFaaGIJ7
	XU2RipMgOHeDpdSFRHUGGTajStqfAWTpa/AtvNYp1h5gxF3kpZ/h0EaltHzJe8/+5uXnHVB0GdB
	P+j2qawndbd+vlQEgz6gf9Xa4nu9UoQ0TZxE4Oi3GT+EvNbJMZ7EEScsoDA8BfP2EXAojyRZf9G
	jCjmk0k/PFd8AgITr2Zw0WfWLHg8Fb6UEOhF7GAF409sIGhxGi+47dhsODwhe5Embijy+nVI9c7
	YVURVjav0djG8euzVFGv13xhq/3FS9Y+9311cftmX6Q==
X-Google-Smtp-Source: AGHT+IE4myv0h1KnrGoh4Bqnmy5Mn0kVvtXxHRg1nwGw/MPEPtvDRRIKUFstTHvUGXtDDPJ5IrxUtlbepRvi
X-Received: by 2002:a17:902:cccb:b0:2a0:879c:ed37 with SMTP id d9443c01a7336-2a0879cf44bmr113254795ad.2.1765949712890;
        Tue, 16 Dec 2025 21:35:12 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-c0c29ee87aasm1974455a12.11.2025.12.16.21.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 21:35:12 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 2ADCA342243;
	Tue, 16 Dec 2025 22:35:12 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 28A44E41A08; Tue, 16 Dec 2025 22:35:12 -0700 (MST)
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
Subject: [PATCH 07/20] ublk: set UBLK_IO_F_INTEGRITY in ublksrv_io_desc
Date: Tue, 16 Dec 2025 22:34:41 -0700
Message-ID: <20251217053455.281509-8-csander@purestorage.com>
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

Indicate to the ublk server when an incoming request has integrity data
by setting UBLK_IO_F_INTEGRITY in the ublksrv_io_desc's op_flags field.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 2893a9172220..d3652ceba96d 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1107,10 +1107,13 @@ static inline unsigned int ublk_req_build_flags(struct request *req)
 		flags |= UBLK_IO_F_NOUNMAP;
 
 	if (req->cmd_flags & REQ_SWAP)
 		flags |= UBLK_IO_F_SWAP;
 
+	if (blk_integrity_rq(req))
+		flags |= UBLK_IO_F_INTEGRITY;
+
 	return flags;
 }
 
 static blk_status_t ublk_setup_iod(struct ublk_queue *ubq, struct request *req)
 {
-- 
2.45.2


