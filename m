Return-Path: <linux-kselftest+bounces-48249-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4433ACF6265
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 01:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4B1DA3011470
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 00:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4663E23EABB;
	Tue,  6 Jan 2026 00:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="c2+3K+Hs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f228.google.com (mail-qk1-f228.google.com [209.85.222.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DDF223DEA
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 00:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767661097; cv=none; b=QVsOc92zqBBp8xMytLSf0Q0OleS0lOPSgp3WIFoo9zrPQCGNM8BXxO1zn0Zdx0vkIPwra7fLs0+FgrnrESPwnocGZWN9eSqwCeMahXkqeg/wmTa1vlYYyKtMDUAaxkJcnmYPe3Dk8u+LGUtJ2KYMdHFSRANp4GknX90AUtOX8W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767661097; c=relaxed/simple;
	bh=QglB6BGs25acZBZ2X1ev1Y2R47EaBUb4fHz318ccOjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KuqlwlzliotM/jQydpqq4P47SWOtFlqyxQcNvr8uiwP8/tcVJYxdp18fDlSWnNA8ti4K0naRzQAj4KXFGhJ1OYwElM9mO46aecewMqXH5kQjuuOCS97hVdUp5NRmpKmCFox9HA2RIfJ1r6VQvAM8z3yC+wLhkyw0bpGIsfvUrME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=c2+3K+Hs; arc=none smtp.client-ip=209.85.222.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-qk1-f228.google.com with SMTP id af79cd13be357-8c0b24cc4ddso5657185a.3
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jan 2026 16:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767661091; x=1768265891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BbKFwj6h+lok/a61k6jPQXyKKIaN26l620iO0DTX5Y=;
        b=c2+3K+Hsg9J9HIqPIFY6xzuVNidUVXFtg0YEgdmJoPEZAPU07aOKoG3CjFjUEgr6wT
         5SlqcFEEqpatwPBsNLRD7+NM+6fFezWZAHdoqe5WEmQ6fKvmOLoYneNXIjKBNN+2EhOB
         jA53DjXUfCAhBGXeO3cxvLsPm3AXVZScshGaD9hUZa3IxFwc7LUR3shyGdJbiFYgsuOd
         alPTdT2uXwlhgNTvF9YgrhFgKKLZM1o6L7UVTcIHYA1AQg5BNBJHzKzYQ3h6OyXcHzFr
         iPSqPLvBLHN/u+b8Hv56T9vJ6FcVA0Zkjuk890STRFEmmbz9zLRHR1aBM4T+0eL3w4wj
         ZrmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767661091; x=1768265891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+BbKFwj6h+lok/a61k6jPQXyKKIaN26l620iO0DTX5Y=;
        b=dj7LMpA4P6WgFyKHkJwzcur1UsXkMYCm7Xm1J1k28qYgivuN1+kpzocgD3F813kN/z
         rxQ6FEiiRSua/i9wEPn7yOnpfMvDTql1OOrFBRGf6Q6/dh8DeCS5ZhoYtyV/wX7GxQD9
         v8+tzD1ar2rBpPQ+I9Qa3qZ4j/3rHeHmmdTTFpPtiGtwebja/V/u7Ij6NfgaDwJQ0etK
         NpbeSZvJ6/xG0TO31rx3b0ute4mCxXu6Wsr6oCV6y+ydN2LaB1YLELY5HuGhDfqTQ5CJ
         Dit6arRKePdDVChAxnHpLOaAD9vRmRk89STwIZzyLnvRgHlwDSGdil27a/3T3OtM4wXF
         YD9g==
X-Forwarded-Encrypted: i=1; AJvYcCU2hYb0sKCCpEWuhF82yHnDcIcKutlO3NDKV5SR3TTWPffxBQAxtei6B7+XLeQO9Pnz3YWoxt8gvZAawYTRNPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvvSIBSWPVExWY9ulcDjykGMmZul7eMHaCEdr2ufXvsUsuO1uQ
	nAhnj5/0eEQQFuGSr2EJHv7PJV297UFmp3cqiM9+nRVN9l+SJsD/DJkAdmYQgr+2nxUDAYK3Mo/
	SQtWYPosMtmWKHLSaHSYiBzfsw0wRdXVBQ6tU
X-Gm-Gg: AY/fxX6GnAGECMHfzwfgubFeDIgA2uWV928vow+oA2BR3csdAru2qaMJSAExHsG0zrW
	ep6Zp70yc3vHw4j3F9uhsPTE1ed5MxD3CwxxcPn7kSAAZODU/hPSzu43rafoBQoghAWgK77ctb0
	mUDUsVwQ1OSXinEf9h5elPCikIYDQ3Y7RiF09dRM3zJPO80w3luraU5AebutFwCxt9VaJrTEGqF
	nhZmlf+goj7KUIDLC+zKGnIDzc5TeDRyEjQjgC4BCtHwclpbX4RP/itfYDciv5KFYoq2TWcYg1o
	wKIivUdFaKd+ExyxnI4Z/vwQHtaNvtljtNfFDA7dIM/epxVFophkXkb9X6EZh1IHwjAkrNT/xLb
	Nyj3txxBdEwcrhWClaSx0jCNXsFVM9TEjzBAciaFY7w==
X-Google-Smtp-Source: AGHT+IEDNXV4VdNZ1DJwkLlmPxJbs0JiakgrmjqHOO6P+b26CkjANhu8BNuBM6Q6P5Surr2WvM7vVk5hYPgL
X-Received: by 2002:a05:620a:3724:b0:8b9:fa81:5282 with SMTP id af79cd13be357-8c37eb6d00amr164322585a.3.1767661090570;
        Mon, 05 Jan 2026 16:58:10 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8907715cec3sm786396d6.30.2026.01.05.16.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 16:58:10 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id BAA7734084D;
	Mon,  5 Jan 2026 17:58:09 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id AC289E44554; Mon,  5 Jan 2026 17:58:09 -0700 (MST)
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
Subject: [PATCH v3 10/19] ublk: support UBLK_F_INTEGRITY
Date: Mon,  5 Jan 2026 17:57:42 -0700
Message-ID: <20260106005752.3784925-11-csander@purestorage.com>
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

From: Stanley Zhang <stazhang@purestorage.com>

Now that all the components of the ublk integrity feature have been
implemented, add UBLK_F_INTEGRITY to UBLK_F_ALL, conditional on block
layer integrity support (CONFIG_BLK_DEV_INTEGRITY). This allows ublk
servers to create ublk devices with UBLK_F_INTEGRITY set and
UBLK_U_CMD_GET_FEATURES to report the feature as supported.

Signed-off-by: Stanley Zhang <stazhang@purestorage.com>
[csander: make feature conditional on CONFIG_BLK_DEV_INTEGRITY]
Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 9694a4c1caa7..4ffafbfcde3c 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -73,11 +73,12 @@
 		| UBLK_F_USER_RECOVERY_FAIL_IO \
 		| UBLK_F_UPDATE_SIZE \
 		| UBLK_F_AUTO_BUF_REG \
 		| UBLK_F_QUIESCE \
 		| UBLK_F_PER_IO_DAEMON \
-		| UBLK_F_BUF_REG_OFF_DAEMON)
+		| UBLK_F_BUF_REG_OFF_DAEMON \
+		| (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) ? UBLK_F_INTEGRITY : 0))
 
 #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
 		| UBLK_F_USER_RECOVERY_REISSUE \
 		| UBLK_F_USER_RECOVERY_FAIL_IO)
 
-- 
2.45.2


