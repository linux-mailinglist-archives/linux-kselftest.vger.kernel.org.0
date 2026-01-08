Return-Path: <linux-kselftest+bounces-48486-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6855AD0320F
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 14:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA96E304BB4B
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 13:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0877642B954;
	Thu,  8 Jan 2026 09:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="PJhDWRyJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C100E34FF75
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 09:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864014; cv=none; b=Pe09ZCryZpaG8rAjbacdd1qG6/6Eq2U54jM6dO2bvdMj9JJundszTwyhjO+VOMshA16F9IDfCN3XO1CSlFkf82T/Dc2AYS4NEUM8JEloW1O9UYXMB1NrfOj5UQhyTwXAtyCmxf9hHJz9JZbKA/8Zu8B0mJd3t3EqjIFOl4H4vEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864014; c=relaxed/simple;
	bh=MFrMgizmK5MaIPV+Gko7o6kSYnpBboKUcVmDmAwyHCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XquvkhKPlr4noJYI8ADY3iV163ieveHFk8ihzlbNGRr1Dr9d6T+5wA2mDoXy+NRzNzTIfexZEWgk/GqmUVJGq507BoCol7s6wA38Uupu7VGNUdj49d2aNyJkYPax/PeYR2VpZ3VzVRpPuQh7bjBoP6khrGZZpWV4L5Kd6t8HMDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=PJhDWRyJ; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-34f63b154faso77931a91.2
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 01:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767863996; x=1768468796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNQyNIuF0YsgyAJSwbc/xgpZYuEtibH5Z0ga5IDU7gw=;
        b=PJhDWRyJZgdhzo2osYdH0DTJHjzirGkQ/nd2uZaVlWMcOZzJyKm8pyzfSIMOFwCjNU
         9vDOfUl/uYejrQj2Ue23t/9ROQWOS0ap/5y2ruR5cYPVvAc2xLQkpuZzmYO5Ke0RSIW6
         DIkCl5jTQk7hspV6w1qhZ54u84R2s261WEYAJ5ynh/u1CZuIiAOxVcfwV6yU7bmU4xzP
         KakK/FEaRJd8EVyg4PBMHRdg6XfDhVOEfAyAk+nJwS9+bolHHBFXnVOolaSN8Dz77EZz
         yWvJ7ZVK+cBbWIMRIV+nPhSCIJ6S5TdwWH/137SRTQoY3rSmN56LN/C82oPlufqRRuVz
         LbhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767863996; x=1768468796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MNQyNIuF0YsgyAJSwbc/xgpZYuEtibH5Z0ga5IDU7gw=;
        b=rARArM4P3cTi3Wn9wlUo8C+YmDmoCyK+idITItR3wsHN+7ycqN9LXIgvK2z0jld1ZF
         sVpu2PF0tHaS/bw3AUUSmWIeacCDTqHiloYaXpxdXWnIsASCURL0e57cXc/mEuty7uc6
         Rf9U3sl0TqVAFRtBVDtf/w21vqmvcGURE9nVgOdHGbEinC5CYKNIMuIjonm/JZQXe6QV
         sqSzKjzIGHgJ8ZdUsWVUK1bfLXuvGgSFG8WJ2qnBLDfY07kZBSr6Evn/yZyZfgRYPQRM
         XYYSddwYOxeK1aZ+thMFGFBJz/ebKOiODMisZaThcSSh8bEMcQsiLvAC1AUJvwCcfXjp
         i9NA==
X-Forwarded-Encrypted: i=1; AJvYcCWAYcp03T/cxUPA/qxFJ/TU1Zvhh6BuS0xNse/WPPpRtJavot3zm+WfFywyz71luMtN/vznRi9ustNEtsd+P/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+Y2VHSJa2PJjMPvFBa2Ax8q6xKEGRvVcfuJoCLGGE/cGpg2ds
	PJBtgtJZFk3yhEKdf+lB6PVASbb9Q0pHpa5Wi5TReDT4439i1/bsD3ipWt6HPzG39A5NLL1vjdh
	B2A5HIUSC/PqqLz73tOd5jz7pTiFrkP+1O8Yx
X-Gm-Gg: AY/fxX7Z0kQvkC8e9zFT29N2a/6rWFZObBoN6FwAsG4nb1g2F3uW8U9kDxQXYETh3UF
	Is9O4rJZZiR4W11PMeLrHBWWQGNp/mOA7DCjVf1PgRxhMzOKxqMcv7EKLVwc0UhSBll0/yrfwXY
	sVHJhA9rBjHopisaMjay8MPLPWGmWrAYLMeQQrRXMMsmIDIBxXSeR+NLNy4smGl1lmEeesxJ8yV
	rIQT9wQ6mDpXfucVnu1GINLFAODQZUug2ZgCq3gX8j69pPw7TSMuto04L/AdVHLuGJR+pA1QJTg
	Y84Vedoh/mbE/pyqe169/f4FIG0VHjIgw/gw23XAR/h+rvhSFMvIn9M6l+/SsBwJSXQRYYbXH8b
	IvBtHveXKxgAerMO4HZ3D+z9n/nXc+Iw1KGIJ5JDoFw==
X-Google-Smtp-Source: AGHT+IGgsECl/s5X0anN6YN0NbDvXYMzPEZuaAu3pVTMt09j26paUiPRz914MTdupMzpukRtZg1N3wOUfHwP
X-Received: by 2002:a17:90b:2e0c:b0:343:e480:49f1 with SMTP id 98e67ed59e1d1-34f68c28ea4mr3826621a91.5.1767863995746;
        Thu, 08 Jan 2026 01:19:55 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-34f5f8d0c46sm1010471a91.0.2026.01.08.01.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 01:19:55 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.6.120])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 294EA342170;
	Thu,  8 Jan 2026 02:19:55 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 23952E42F2C; Thu,  8 Jan 2026 02:19:55 -0700 (MST)
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
Subject: [PATCH v4 01/19] blk-integrity: take const pointer in blk_integrity_rq()
Date: Thu,  8 Jan 2026 02:19:29 -0700
Message-ID: <20260108091948.1099139-2-csander@purestorage.com>
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


