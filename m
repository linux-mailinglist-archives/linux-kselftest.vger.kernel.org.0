Return-Path: <linux-kselftest+bounces-48488-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3B7D0204C
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 11:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D2ACB30CEE17
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 09:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F9C42C3E1;
	Thu,  8 Jan 2026 09:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="fdnVn3xO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f100.google.com (mail-ot1-f100.google.com [209.85.210.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF9142188F
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 09:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864017; cv=none; b=rXA4QPwkKmcHM2VFoyrIFMovIwVskpZppkq8P+lo7E4mBqpLAZhJB8X7AaL5tPaGxgcBCCzkmJBZPg7Od3RchDvgqyFjAb7XHEkCLa/SjnOtuyjIJFHoEKVO1lw3Qiu9gpopGW4Ww94O2BeXEIn9Rpl3dSx9mYjiEerAodi/eyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864017; c=relaxed/simple;
	bh=FpSk9SBO7a8fTola1zwsU8+516cI+0H9/8WbLKjGV0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bReyb0YeL6dt8SEETxQKZ2m2Z52IVEj/C1KKrg0braoBySZqveemcKECJXFM/KcNSgKaUCh43q/UHu9TO4RO/6DtvKv4JGpBVwCUdjcjEhyooro6qwq8WV+lRYcS/ISPwY3psBYzn4+5KV2vArtV4ZbCVIWCf5px4I+ahBZzpec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=fdnVn3xO; arc=none smtp.client-ip=209.85.210.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ot1-f100.google.com with SMTP id 46e09a7af769-7c72d7e6c0fso340116a34.3
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 01:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767863998; x=1768468798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdwpGAzUowZ3h68lzOUG2hhVHWdUBrDTU/ZZOy1LyBQ=;
        b=fdnVn3xOzniOFrhulHPWBCbcV61TrJZr+RzhgBc8HuMpRWwcadBsxxCk6hmIbR0JF+
         INKXdlqqbp6MTQKCKuQ3YTeBLBtrgH8wrkrNalFS76Zqq+bmZYvnr/rIYGviPfTijAix
         kbK6oELQp/Kn7w33QwWuyqAMAB0HvCGY/0yEElSoKdQqOqmDBRLt06IAg2shcPzLIyYB
         hzk8beGcLPwnURPiR2Ec6ADvnT20H4n10k+L6L/Lwa0e7r4XYXQ248w+VaLTtS1X1Dy6
         w1f/rV5YyY354ft4wQz69spaGGJHKonLTv3FN3lsX5BVNKhtT8YqBHqmhqqpsBiuKual
         x3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767863998; x=1768468798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zdwpGAzUowZ3h68lzOUG2hhVHWdUBrDTU/ZZOy1LyBQ=;
        b=GO+0yrET4M/3bExyq/7XzBUoHR2FdBZjv8zvZEmLNh3pwoLG65TJn8v194o8rinPBH
         ZLPLwfP2FduJU2tFHsNq8UZJENa6kAiioIMXIr8tPEpKnTCglEpwRSwE/GPsvVBsaKKZ
         skNScGZToiNvgk7Wmcsosr6Lnj2NsTE/ObCQ1xNP1kHcBRwcEzpMr27+bQfF39ZrZIzR
         /DLiQSy+lUrdhoPqiNM4ZM3yQL0U83iUuUbHuWBJ1ME1k2DBF77bBhrYT3wIneFq7Lh8
         Ll07PmVzqenwcxNGNC4xW2UT1f+kv82DU8PlUtGUhQjuPMtNS8xM+TioBD6cfPBe3gc/
         JVPg==
X-Forwarded-Encrypted: i=1; AJvYcCXhlNb9CGEDd4JkA7+8R9wZQhOd8iFwAbuIvImvz0Lh4tFwt3xfu86aUqTrps9EfCdyTNm6LL097eABsE4Vl9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyID18o2LP8dmPPHBngafN4TWz4wBKv7wcQmbq7O2JWrvCRQuDM
	kcs0woIBN+l/sGEtM8k7an1KsZsMPxy9tzN0id+XfU5TVEV03g5nxjCOYaiA46EPyFyBMBRD4T3
	NYCIgLE2kRxLu84vX78a6zCL1Zw89YorFrlVd
X-Gm-Gg: AY/fxX4UtEc/pHT54u/y9p8BlaQrpumNsUerlHz6mnAaBK5+yDR/lB847yr5LkaRJoh
	HvCP2sw4Ng+jpDffcykgvq2O/DDiGA+2thhndQ/EdEm1ZE7m9LCF/02VuahDS96pfgQnER93l/+
	IeC8cEsmZ8+Fv5pQJdx9J5Y1IJfi0ng+H81PMEcL9UhpXa1aLUxF41P+vQSclXT8FUyqceFMES8
	78Nybd/0aLbISQZS9BF0PykPjbhBDRrNRLodQ6F46lE/vNfvgZ+SvSiB2PZtjm9Hjknm4QfYFjq
	GBegEhFVtrdBqWlG1eIlsfdf2f1fjLRAtIEHxPeZIGvqD+AiS0LmzqBh7rzZWDJ+pSGW2jQom0d
	NtKQYq3Ihcn3TTB4IqiMkKbsw51S5sY2znjDUCztt/g==
X-Google-Smtp-Source: AGHT+IGUm/Iy1iheWFfw5eo3T3n1C7/QfcUR6biu7iVn+XpWzIDZiQTmzwOni9Bte3nRtpcuFZadeg9tZXhd
X-Received: by 2002:a05:6870:32ce:b0:3ec:4e27:1f21 with SMTP id 586e51a60fabf-3ffc0c3c800mr2191144fac.8.1767863998371;
        Thu, 08 Jan 2026 01:19:58 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-3ffa508e961sm818826fac.14.2026.01.08.01.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 01:19:58 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.6.120])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 536BC3400F7;
	Thu,  8 Jan 2026 02:19:57 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 4E6DFE42F2C; Thu,  8 Jan 2026 02:19:57 -0700 (MST)
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
Subject: [PATCH v4 16/19] selftests: ublk: support non-O_DIRECT backing files
Date: Thu,  8 Jan 2026 02:19:44 -0700
Message-ID: <20260108091948.1099139-17-csander@purestorage.com>
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


