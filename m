Return-Path: <linux-kselftest+bounces-48086-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB8CCEF90E
	for <lists+linux-kselftest@lfdr.de>; Sat, 03 Jan 2026 01:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D16430124F2
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jan 2026 00:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E3C248F5A;
	Sat,  3 Jan 2026 00:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ffhtsnKb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f227.google.com (mail-qk1-f227.google.com [209.85.222.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0352264C0
	for <linux-kselftest@vger.kernel.org>; Sat,  3 Jan 2026 00:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767401137; cv=none; b=LRRsv5hpLd/egdqzsm4fQjds7Rds7Yo+QB1kjkpi0frpk770KL1B1Mr+fl6avp46Zc99Yhg85PDjXL9c0b3+n3F/njQBJVkbhAkzFHqeN/fl8UsO+nme6k/5EGeKZUCnie4XfERmbAbiDT3lb/LPBqbJikSm0LZZM+d1E5tM7SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767401137; c=relaxed/simple;
	bh=OHCvRTYKVhIoqJ0IbwNbmP3S0pPDKsYwK9/NPEhFebY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VwGFag65GytxQQlcQRcuU2bB7+LWUuzVCg06bRUVT2dKyTAWS+2W2Q1mh+MRa61OBpY8jke0hdnAUvrg2PbwNwXf8Jw16LyXoZ22EwmuBM6LNYJfpdI1WVI9GTMWswn2PiSOvo2+NVKcpF9boSiVhtomQmtJnSuMExApiGgb/zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ffhtsnKb; arc=none smtp.client-ip=209.85.222.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-qk1-f227.google.com with SMTP id af79cd13be357-8b6691baa33so166173685a.1
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jan 2026 16:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767401133; x=1768005933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59cCDgPfeatMIS2T54XZ5qKYRlkQDNaFxzaUv99tjXw=;
        b=ffhtsnKbL0bACNDUCOPMTDm1xPo7TQsU9JOGSFTV4HstCVXXMejFVw0Hxz9PDrCEO8
         Z5rsmYl1vtSJyk7lWOeJx2fZ66qj7PgAmm0aQ7Q1/zmI/MhKbxlQvmotWr+usUPMx7Xd
         RaC/Q1YDSWvXFk7tstcoI8+ApoIDbjHFe0LzB/sGX8GTcVUdvboY1lrOa0cgx9pAoPZP
         jBjMP20P0HQG2JWnf4kdIyB/3X4ci2s2Y450GI3HfSi21Oleu4xj19udCBrc8q5Edc67
         K4C1jyrHp23RVTglh8J6q5VPicVrWnGNyHqK7d4to8UxoD99ov3LshW9CTsX3Uco0Utp
         zBag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767401133; x=1768005933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=59cCDgPfeatMIS2T54XZ5qKYRlkQDNaFxzaUv99tjXw=;
        b=lZfzgfeGZIRIRgac0XBAIn6t3m6LssbtzCzdRr94Im8DAEvWHZbKvulu14bHvpVVuI
         V6/1QNfV/oK5CNlQsPqgmP+fSlZd2LZjR5ieFubneowqKxiabc+OYZI4RKqSOK7QTg8d
         yFBjALsmVUNkPhAiCR340/wS1qVApGHyau6QFQGfJbkgcPuJIH4O/SATa3zWaoSv8KWc
         z0iDvDlGY7ImjlCpvMzkaanq9xP5QKBjoNlg9jKUQnO+L696q0k03XvovKG28YvqIovV
         aEGZ0m9d6LZGBLebTJnOl9VXwb/opWJBlHPykm0AaqwtvwogaW7zkKYWprY40NnNM+ft
         OB4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVVCLft4//6XXRDvXFy8BRGRwxz3GITH8FplwZuGFC6YMJjuUMx6l12KkrDfgnpGvEV4KuH/abyQG8ojWTKYKI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr7y2y4jQkY68kiJlRSV/9dIEUUIeulKT8sQER2EBTvg72Lm+h
	BCBCA+0+Vv5KlPVsXY9ql2qR+FlSseYx+hSnzY/+Bks9Bs8i2PZFsCv8zkzqLFbaHOsTmGDnRQZ
	gqAU2milx8miZ7IAeN0UAkPkRsCpe2XTRmNH9
X-Gm-Gg: AY/fxX5GNo3TRmTnQkiVvAx6pmZy6J8ltrLpV1fT+mftIz8icVJWKdEeIb/B9PC3Znb
	l9j/Ci6DeTzVV0a/2AAd7tHVZCjKt8eQz3XGVkwpzQBOUYKYgl0a/GL/qgkYfG3KpJgx5ns7ZV+
	0mwm7yE+dRfKOLqsrExcqou2dC7NCTFSRZXbtFT/uhXdOlDvnVp4V+gClVnv/6/m8ZXo+0j1iec
	Ttu6voz3xGfvCVIfOC+VJWZCwfuLMDHCougSljCDVbd1//ZdXDapG8EDzTZXM4G3KW2kJ5EQe32
	pB2tz1Xuhn8zqYcwoXxjFZcCJ0ND+jfcQaykUwYGJimNj9vR1YWGpnuJCQNMS9ozt8Rp6udHocs
	vYs5vICzTmm40N7RwJI/NQARHo81qByFnnII3dVUC4A==
X-Google-Smtp-Source: AGHT+IFqMJoRCOhorEZ1m5a1GSBNb1Nq8U5gwFI3EoZHHVIsX+lo7hsl8u2Cg5Ps5OOYvTTwO9tanO6Feto2
X-Received: by 2002:a05:6214:415:b0:801:2595:d05d with SMTP id 6a1803df08f44-88d83797f60mr536526336d6.3.1767401133182;
        Fri, 02 Jan 2026 16:45:33 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-88d98050c97sm55962466d6.25.2026.01.02.16.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 16:45:33 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id E36283402EE;
	Fri,  2 Jan 2026 17:45:31 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id DFE06E43D1D; Fri,  2 Jan 2026 17:45:31 -0700 (MST)
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
Subject: [PATCH v2 01/19] blk-integrity: take const pointer in blk_integrity_rq()
Date: Fri,  2 Jan 2026 17:45:11 -0700
Message-ID: <20260103004529.1582405-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260103004529.1582405-1-csander@purestorage.com>
References: <20260103004529.1582405-1-csander@purestorage.com>
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


