Return-Path: <linux-kselftest+bounces-48100-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F030BCEF965
	for <lists+linux-kselftest@lfdr.de>; Sat, 03 Jan 2026 01:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C1AE3011A9C
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jan 2026 00:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAB023EA86;
	Sat,  3 Jan 2026 00:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="DRjgjhpF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF51D23EA87
	for <linux-kselftest@vger.kernel.org>; Sat,  3 Jan 2026 00:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767401143; cv=none; b=VMjJfJy3iE6tJdPaRImSCUWrZLD+haiUFRYkaK9F/FiplSJ4YKcW9Kg7GWNSAgzTrcY9axwZv2A+Dsm9gz9ICeusi/bbDCHX+A+u5RGodGi9LF1eIpVFBK6tZyhgXfQiyy4cm8qf11cv0lFUfBHgnPEG90UVW7dMX6GgmGcsa7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767401143; c=relaxed/simple;
	bh=FpSk9SBO7a8fTola1zwsU8+516cI+0H9/8WbLKjGV0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Slp8WUECSkXLrcVwG5yYabEhl3nZXVzAjzUxzUoWSJZglrTl+fCJL/pR6nIP1g/InihWS7yK//22c+pa9Mn5UmbU9Iojere/cKxK4zuzzCe1Xeri7B1B0+MO2AD91pL5gu4Y5Ygc679P0LfLV28/WoYgzpu7JPpcXHQHR/in02Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=DRjgjhpF; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-8887d6d237fso11091416d6.3
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Jan 2026 16:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767401135; x=1768005935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdwpGAzUowZ3h68lzOUG2hhVHWdUBrDTU/ZZOy1LyBQ=;
        b=DRjgjhpFNm4N4N6hG4XO3vKRWqUAic75HF8GEWYB8P0Yf+MpZQJ1ftPddE+B4iYAQj
         xcbNX8UoTZ1tkhxJwNZt+JYe8kTVsz0ZBtohgdbvaEsLNyrnxLKZdVq3NqWyN2f6ughX
         IfJ8GPI1n9hTSsCulm0LKdmaR1+vkb71vwZCOVBJQiCNsO7IaV4RB/CUxCgXMzf/7TFm
         t2Yl5E6CTSIVAfGELtfGvd6TAL2jWMH+Vk6ybBMC2rWtw1L120Say7N/knIgdJAOQRcK
         DqhZzDxSBLKFHGlfEVYZMriLD/iB8q9Tl+0kJgZHRVI9sCjAbNj3Sq6/kEujlapOx43f
         xTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767401135; x=1768005935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zdwpGAzUowZ3h68lzOUG2hhVHWdUBrDTU/ZZOy1LyBQ=;
        b=Ara43aMK34O2d3uZDnUUMSFumj7FYiDk/AB9cGEpOqlzlvee5i+C81SE7i2qi360fz
         p8nHLgtbI57LUjBIhrR1EYi36U0dJFJElPN4CTyrlZ2dOSPMS6edRqnCTuWjezCSb1oK
         Jmy5NqG4ZWNSdaReAKBbJbGM4NFB/28USP58+7ZDP/v02ENhJKgFFqHtAcQFHc0rRDsy
         COnSRhxJnRtwB+q4oZ2pA15cd11SEfhmhxlTAonPPpHOeBTM9vqeF9VdiBowWjrjw/th
         YynHb9NJbzZ9aLErU8nBbz6hRrTfYG6Cl+qD/2isQXYir9jjRmPvOTISp4ZFHnq4vM4a
         5/8g==
X-Forwarded-Encrypted: i=1; AJvYcCWymTYEBA0C4PrGy0INCbRsF+HQWAbPQhM8xcVih2O8CTGqDugf2thtiAUtpDLqsmb89YRFtP34Q3YlZD6jck4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRCAzlBh+5L3FHheYl4f1Rhwj2QHh3JDfHNp2E5sVEnCGwkTN/
	bM8dQ890dL9bSsgiRq60fhnYMqwUHocW1y40+6C3YbBpFBQLyzCFf7q7+xYVckr7euykXqGpmAN
	fC/top8eOgYVy274zPlHFI+Q9vCRNGXzGmHxj
X-Gm-Gg: AY/fxX7axnU8Haw8ICNlCG7i2jqKQmMK/xmtpXjNW0QukUpvsaj0RSBIWj9EqShF+xu
	Aicj+pK0Nc7Cmev07/3uqtcnpsWngNBug7j1ALquYwqg3/CMFzLv93DLjLWnfBS90GfQ3cspFcn
	KQqIe+UPbYC+ykDoAe0VZYYBDnmSZm5mDhJeTt+dKgk9i7DIVY5bV9HP5Hl39pqV/SCGiWEk5KR
	J//LWe/QiUCsUDBIBZjYzmx7Tn4S9/yapJkzZV/2IsoFuPGt63LvPXL8Lj2F6DsINURlqnPTeMt
	Y24G6ffhFwqTBeE8bvIgihcmfeecRYDxQujII88IFfSOcUtgr7HkVO8mybHE4tJD2W1+RzWCjGX
	UfZjOUDfUGVD3BSZ1F7OyCXCotUG61JD38sXP78aEgA==
X-Google-Smtp-Source: AGHT+IHI3WlUSEHmZ+1u1hXYR6d4oNAiQx5UnNNYk+rdbw2FQFi+pnQTNFmtPF88OIAF0HT6Q1NiahQ34/YP
X-Received: by 2002:a05:622a:1819:b0:4ee:87e:dedf with SMTP id d75a77b69052e-4f4abdc433cmr505476921cf.8.1767401135307;
        Fri, 02 Jan 2026 16:45:35 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-88d980505aesm54692196d6.23.2026.01.02.16.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 16:45:35 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 99E273402EE;
	Fri,  2 Jan 2026 17:45:34 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 97E34E4426F; Fri,  2 Jan 2026 17:45:34 -0700 (MST)
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
Subject: [PATCH v2 16/19] selftests: ublk: support non-O_DIRECT backing files
Date: Fri,  2 Jan 2026 17:45:26 -0700
Message-ID: <20260103004529.1582405-17-csander@purestorage.com>
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

A subsequent commit will add support for using a backing file to store
integrity data. Since integrity data is accessed in intervals of
metadata_size, which may be much smaller than a logical block on the
backing device, direct I/O cannot be used. Add an argument to
backing_file_tgt_init() to specify the number of files to open for
direct I/O. The remaining files will use buffered I/O. For now, continue
to request direct I/O for all the files.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 tools/testing/selftests/ublk/common.c      | 4 ++--
 tools/testing/selftests/ublk/file_backed.c | 2 +-
 tools/testing/selftests/ublk/kublk.h       | 2 +-
 tools/testing/selftests/ublk/stripe.c      | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/ublk/common.c b/tools/testing/selftests/ublk/common.c
index 01580a6f8519..d9873d4d50d0 100644
--- a/tools/testing/selftests/ublk/common.c
+++ b/tools/testing/selftests/ublk/common.c
@@ -10,11 +10,11 @@ void backing_file_tgt_deinit(struct ublk_dev *dev)
 		fsync(dev->fds[i]);
 		close(dev->fds[i]);
 	}
 }
 
-int backing_file_tgt_init(struct ublk_dev *dev)
+int backing_file_tgt_init(struct ublk_dev *dev, unsigned int nr_direct)
 {
 	int fd, i;
 
 	assert(dev->nr_fds == 1);
 
@@ -23,11 +23,11 @@ int backing_file_tgt_init(struct ublk_dev *dev)
 		unsigned long bytes;
 		struct stat st;
 
 		ublk_dbg(UBLK_DBG_DEV, "%s: file %d: %s\n", __func__, i, file);
 
-		fd = open(file, O_RDWR | O_DIRECT);
+		fd = open(file, O_RDWR | (i < nr_direct ? O_DIRECT : 0));
 		if (fd < 0) {
 			ublk_err("%s: backing file %s can't be opened: %s\n",
 					__func__, file, strerror(errno));
 			return -EBADF;
 		}
diff --git a/tools/testing/selftests/ublk/file_backed.c b/tools/testing/selftests/ublk/file_backed.c
index c14ce6608696..db4c176a4f28 100644
--- a/tools/testing/selftests/ublk/file_backed.c
+++ b/tools/testing/selftests/ublk/file_backed.c
@@ -161,11 +161,11 @@ static int ublk_loop_tgt_init(const struct dev_ctx *ctx, struct ublk_dev *dev)
 	if (ctx->metadata_size) {
 		ublk_err("%s: integrity not supported\n", __func__);
 		return -EINVAL;
 	}
 
-	ret = backing_file_tgt_init(dev);
+	ret = backing_file_tgt_init(dev, 1);
 	if (ret)
 		return ret;
 
 	if (dev->tgt.nr_backing_files != 1)
 		return -EINVAL;
diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftests/ublk/kublk.h
index 830b49a7716a..96c66b337bc0 100644
--- a/tools/testing/selftests/ublk/kublk.h
+++ b/tools/testing/selftests/ublk/kublk.h
@@ -460,8 +460,8 @@ extern const struct ublk_tgt_ops null_tgt_ops;
 extern const struct ublk_tgt_ops loop_tgt_ops;
 extern const struct ublk_tgt_ops stripe_tgt_ops;
 extern const struct ublk_tgt_ops fault_inject_tgt_ops;
 
 void backing_file_tgt_deinit(struct ublk_dev *dev);
-int backing_file_tgt_init(struct ublk_dev *dev);
+int backing_file_tgt_init(struct ublk_dev *dev, unsigned int nr_direct);
 
 #endif
diff --git a/tools/testing/selftests/ublk/stripe.c b/tools/testing/selftests/ublk/stripe.c
index d4aaf3351d71..2be1c36438e7 100644
--- a/tools/testing/selftests/ublk/stripe.c
+++ b/tools/testing/selftests/ublk/stripe.c
@@ -313,11 +313,11 @@ static int ublk_stripe_tgt_init(const struct dev_ctx *ctx, struct ublk_dev *dev)
 		return -EINVAL;
 	}
 
 	chunk_shift = ilog2(chunk_size);
 
-	ret = backing_file_tgt_init(dev);
+	ret = backing_file_tgt_init(dev, dev->tgt.nr_backing_files);
 	if (ret)
 		return ret;
 
 	if (!dev->tgt.nr_backing_files || dev->tgt.nr_backing_files > NR_STRIPE)
 		return -EINVAL;
-- 
2.45.2


