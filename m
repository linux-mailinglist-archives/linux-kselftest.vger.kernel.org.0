Return-Path: <linux-kselftest+bounces-29394-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F75A6812D
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 01:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF5543BDC92
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 00:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242DF145A05;
	Wed, 19 Mar 2025 00:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="gMn0Gk81"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5326935958
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Mar 2025 00:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742343341; cv=none; b=r1JIDoMWUVTpRNzyUhAXNGLZarPvzopQO/WVGWYpHJ500AYO4RlO+EpcV1GsOxueUWhOXNWDiJRfCyk1aG23ZR9i7RwKgGbi7IcRjnUMUD9Rhb8ipKiH4glEZRZn8rIg6zbJhz4hbcYZDRRHtLsmgtq2UDxbFfQO2w62/RttP0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742343341; c=relaxed/simple;
	bh=zDwqRePv1ZFUDi9FjMPQDVKfJ1n1RRe7hhmBOVzyCME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AV3s3QOefeSE+8W9+UIF4LksIGAbyQdsE4QR/NcnKB/eNWUCwDyO0XQWVUyVyFyx79ERaDvgX5vKTiTQ7IYcy5zgcLNFgbwftKw/DMVRPILepYA9pLBIMcZho9M6kaZ1TzYbwpQgu+1ihvzjO86wKC8yObvcH9IWPJORoEAuhdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=gMn0Gk81; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2f9d3d0f55dso7213674a91.1
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Mar 2025 17:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742343339; x=1742948139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jx2MMZGi/yQrztop394w65c9xYaCiVDt+AK5Yt9ywsM=;
        b=gMn0Gk81p6q/vZ4LGycCtV8PrWqmKL2X2+1X7JUYuAk7MxmnWIJuOfblGJYKzH1qHS
         NHGtmlgyX/4nIO0x+NDViqz93DL2F52q8hztCpCwajF3yIzTdhN8LJJc8uSXOkRRSbyx
         r8JDzvsMP8tNb3e/DiHLdTjOx59RF5ciEg/mU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742343339; x=1742948139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jx2MMZGi/yQrztop394w65c9xYaCiVDt+AK5Yt9ywsM=;
        b=wQaRfZSbA3/y5AvD9b47dNFT86qH0Q+z26dUJ/th6vN2bR1PHZdcOY1UeoEuNovgg1
         GtmHf288U7+UbkLJU3GfGUuF9Y/4/znfZam8PczgGm4xyKqNwduWz84Dd9x1hmRPDaMk
         p1lLd67fUrCU/IX3cNd8b5aV4ysAc5ZHdA4a0ARlyFspXqkz8lAj1rSj+SvYWCONgdeV
         LvDk2G+O6cwlXTPHC6vcUqmPFIazvIKCzoIlmMXJwjG7ljeNPYwbQyd8iK9sqM1Yxh1k
         oHW0iyD7L5jW01BrJoZn6gcGXHqme4NFG9u4x2YK4aR4lXn7QvPrc1Pbv7OLua+R66xL
         eJdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXj7qXfp2cMzmDiSIAbHIss9+S8Qc0QgKg1f5hB7X1MWzlasEdPtKDrdDkBEeQCCelP64kJTS1ky1Wx8Zeelw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAnVXonlKFPEVbfzp95HvpYv5oTgYAA2bsSUrvz8JxKC85XNUa
	woRi2HGYIt+e4D+oK4XSZSSF7XgAY27VUVwXRHIGDuzD/u+SqOrCD9u7WzJoTRY=
X-Gm-Gg: ASbGncsnGSTu/EeZfw7DCR1rfMIiy5laGaB8A+67gitsUZH+uPKq6Vi2wf8XNUYCFjg
	vxHYbfOun6StYKh8l/HP5Rkr1gan3nJCWlBaNkEvu+EUgqQnbQNQMhgemBCueG8FzZ1VfGgHoe+
	POx1MtCW7EgFqnrvPY2aC9MTagRyRNA/4XM1E+lerrS7IFuBhNZuDKRDVTeCKMOk3WZB4QK/vaG
	G80UJTDjCo+RiaRN1iTFfK5TzU/0nX1aQUnQdvdjU4QP3fVRdYWN+C39pizOPan8wDMlE9RY0Ae
	4/UJsEONAJ02f90hBV5uswNd0eK+FHXb+PJ6pdv8iJP7r+gn8HQEMvSD1lGBMsI=
X-Google-Smtp-Source: AGHT+IEnc6PYsekT6MewbYE2xz5zbksEbwPRypdKB1fVzKJg+O8NyDF3d1M1ZZ7rEg687HtSnDkx0Q==
X-Received: by 2002:a17:90b:2f44:b0:2ff:5357:1c7f with SMTP id 98e67ed59e1d1-301be204e8dmr956493a91.30.1742343339529;
        Tue, 18 Mar 2025 17:15:39 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a4876sm101281375ad.70.2025.03.18.17.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 17:15:39 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	asml.silence@gmail.com,
	linux-fsdevel@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	kuba@kernel.org,
	shuah@kernel.org,
	sdf@fomichev.me,
	mingo@redhat.com,
	arnd@arndb.de,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	tglx@linutronix.de,
	jolsa@kernel.org,
	linux-kselftest@vger.kernel.org,
	Joe Damato <jdamato@fastly.com>
Subject: [RFC -next 02/10] splice: Add helper that passes through splice_desc
Date: Wed, 19 Mar 2025 00:15:13 +0000
Message-ID: <20250319001521.53249-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319001521.53249-1-jdamato@fastly.com>
References: <20250319001521.53249-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add do_splice_from_sd which takes splice_desc as an argument. This
helper is just a wrapper around splice_write but will be extended. Use
the helper from existing splice code.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 fs/splice.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 2898fa1e9e63..9575074a1296 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -941,6 +941,15 @@ static ssize_t do_splice_from(struct pipe_inode_info *pipe, struct file *out,
 	return out->f_op->splice_write(pipe, out, ppos, len, flags);
 }
 
+static ssize_t do_splice_from_sd(struct pipe_inode_info *pipe, struct file *out,
+				 struct splice_desc *sd)
+{
+	if (unlikely(!out->f_op->splice_write))
+		return warn_unsupported(out, "write");
+	return out->f_op->splice_write(pipe, out, sd->opos, sd->total_len,
+				       sd->flags);
+}
+
 /*
  * Indicate to the caller that there was a premature EOF when reading from the
  * source and the caller didn't indicate they would be sending more data after
@@ -1161,7 +1170,7 @@ static int direct_splice_actor(struct pipe_inode_info *pipe,
 	long ret;
 
 	file_start_write(file);
-	ret = do_splice_from(pipe, file, sd->opos, sd->total_len, sd->flags);
+	ret = do_splice_from_sd(pipe, file, sd);
 	file_end_write(file);
 	return ret;
 }
@@ -1171,7 +1180,7 @@ static int splice_file_range_actor(struct pipe_inode_info *pipe,
 {
 	struct file *file = sd->u.file;
 
-	return do_splice_from(pipe, file, sd->opos, sd->total_len, sd->flags);
+	return do_splice_from_sd(pipe, file, sd);
 }
 
 static void direct_file_splice_eof(struct splice_desc *sd)
-- 
2.43.0


