Return-Path: <linux-kselftest+bounces-47649-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7B2CC610E
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 06:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B086300832E
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 05:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD812BF006;
	Wed, 17 Dec 2025 05:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Dfm4S+Xp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f98.google.com (mail-vs1-f98.google.com [209.85.217.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C27027F017
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Dec 2025 05:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765949723; cv=none; b=tV/ZPTnumfl4n7qYMJsajt6kBnoKTZ2ndMfgO8FBLHWDj3VNPk40SF1HchEYIRBOA9v+lP/Y+ft7QHYFa2OdjydoXL91C8LLpfgdGhqcNDRKyu3H+YnHFTwmzhpqbN9mgOCHYH7AoAvbKsLfjyO9pDmKT/2Qb03GMD56XZ/xmgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765949723; c=relaxed/simple;
	bh=FpSk9SBO7a8fTola1zwsU8+516cI+0H9/8WbLKjGV0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=co7WzbuJeoJ1nyJe9aaHKUlNg/gz7jvkFLGHBM0lgB3Vh5CUir9nTQvq12iqINVZYonMY12cS47j0kvSr4a+dNxsVWYuvyfzz2qLRTG03Ua2lSDWbHvv+qZgNlLh7cHsri1bryzq2bKmqt70lgzYexG5HJFUoywYTM5NMpfrL1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Dfm4S+Xp; arc=none smtp.client-ip=209.85.217.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-vs1-f98.google.com with SMTP id ada2fe7eead31-5de60139f25so225408137.2
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Dec 2025 21:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765949715; x=1766554515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdwpGAzUowZ3h68lzOUG2hhVHWdUBrDTU/ZZOy1LyBQ=;
        b=Dfm4S+XpMmGGUCQuca1Fo1fBeTpLoKTBs3gEUAHgptA/jxigRIoUOvYOKpyfuBm89c
         3lLdvn+c4kPNPZr0G/2zvI2WV6t9Xf4hvGKLjXk1CqAqgXGZqJH4SKGxiY4ZXZqnWwj0
         O9AEjDMuprOtE6P7paNTCdfWXfFixhGetP/IYTzKsf3Cghkngz8msH6P3vmFXV9Jv5r/
         kmw3k3WQl11kzTCRB46xljrfIJSrc6pLhwRUnGj+JMk6TjL+op/JIYh23awU7CZ9lW7U
         JDRZlI0RCTVxmNYEmF8DCFt3s9pwe7soXfMweiwoh8+ooRttcHzK8tt3KvnE/GZt91M9
         bIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765949715; x=1766554515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zdwpGAzUowZ3h68lzOUG2hhVHWdUBrDTU/ZZOy1LyBQ=;
        b=UwN6z90lxPKK7TFkptfnzGg2GW4Y0Si9Enz2osWVz06AlZX0yHuKGfKrTMfOJXqQxW
         LEZ+KYjd8HVgN3zwTt99Uy9P9UTXoEMJi78xC/XDekVikVJvbX6MF0TFTGRbjhzW6APL
         I78ji/QigsZ9TZFpQrsabPJ+YySy0+peYogE/4RVMM7eQfubrrKCTUvvaMyFiAYz2ayh
         ZjtMRB00DZ1QtAQTXvaQB05tK4yYSgQQOybwAvn8ESU4IH+UUSiGN3gjGlX9nus6gi0e
         14H4wAMAFczNM6i7h9eryfKdhtBzhdq+AliHX2J1NK0XAiW9/3rdeLxqS1n+oJGWbNF9
         RN5A==
X-Forwarded-Encrypted: i=1; AJvYcCWs2tJFB8JS6zhPziB41acBhDVttRMyzg5lZb0rpL98Be1fMcPFBTVPKrMzq7nlR8r2XlUp7vH3T+5DMV2jzEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxSGtIHRkRxF1tjzJAa2xvoQZdZFK9cI0xIZY53Pw4cSYxSjwW
	QFXkOcrnA8F9rGVYMB/G3VyTgM4WoUEPLZdnY8aw7ykkm6MXoaJ9Xo8DgwW7qDYaq/vXz4T/gBD
	XkEllYScH8H5t6SoVId5fKck57pmnUoo+pVGyR6vWOqAoo4QwJEr3
X-Gm-Gg: AY/fxX50EN+nq8cICfrK1EHq0czHXcv3drPFnd/oErpFsmvtcbyMg0yjfR7C3sXv3Ya
	YF1vGBCi3V+2kKxE076xa3rS0hVifEgO95TV4ekK4CYItbpQCDKTpsiOvcozhLes7jv5K/qGtnE
	4Y8Y4fKGddNWAYqd2rT0NpiEk8HRSbOmWV+6mgEUZHw0TlUeof6GorNBoaGK3hlUolYzssPMyLX
	sEGQnAjtgzp/WNCzZ+o7yW7lxaJW0nYv6LdOrc0o5CVAD4Z9uUlyyML00KYRbhZ8S54lAdnDJjR
	9E/+dpuNdv9rmE4RPpoBn7wX+f07BgiVF4e2gmtARzH9KIZo0fdsdt43jGT0uOQ3CZeIqHQSxNu
	74uOF9JlmN9Tq00CSpDteAfGqQYQ=
X-Google-Smtp-Source: AGHT+IGbTNJ02+RKFBYlqs7YIcJpilxtpylxbJjk/gFQO432hKQBGIITHIc+g1MwE2v1dfjvNiGYySuW+HQJ
X-Received: by 2002:a05:6102:5f70:b0:5e4:9fd:5a3 with SMTP id ada2fe7eead31-5e8277e5aacmr3076145137.6.1765949714905;
        Tue, 16 Dec 2025 21:35:14 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-5e7c85bb9b4sm2722834137.0.2025.12.16.21.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 21:35:14 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 6406E3420E8;
	Tue, 16 Dec 2025 22:35:13 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 62062E41A08; Tue, 16 Dec 2025 22:35:13 -0700 (MST)
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
Subject: [PATCH 17/20] selftests: ublk: support non-O_DIRECT backing files
Date: Tue, 16 Dec 2025 22:34:51 -0700
Message-ID: <20251217053455.281509-18-csander@purestorage.com>
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


