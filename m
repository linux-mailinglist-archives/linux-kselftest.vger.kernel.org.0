Return-Path: <linux-kselftest+bounces-17506-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C51BA9710E2
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 10:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79AAF2817D8
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 08:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1221B6538;
	Mon,  9 Sep 2024 07:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rjxh5WfJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED881B5EC6;
	Mon,  9 Sep 2024 07:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725868630; cv=none; b=kBfoqtePqeyHzwP52cxSpfpl1vY+pzX2dKJkD6Zu1HQunA2LcU1J6axpxkLxbOUFKX+aCbO5G0S1nJyM5n5D4cTkWP/4kWgpb9tFSPjKez5zuQZ80EE2tdUxAGmOJ2OQXw6Yn8mO7bt2pDKEYtGslMJwdtxpckCdUjsrkAEkBLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725868630; c=relaxed/simple;
	bh=Ug4hwwp7UU99Plu4pnSIeaaJ0aVs+9Zn4OkL2ElDSpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c50Z718h+B/ZJiWdv3G93H/UVbX8O4D0HoPeGjaJxX+UofXyBkzi3hv7prVV9N6U/ruCIPayoLdBYXUlwdsCUa596WWTKe7X+Xf9UDz8dAEcvRrMIQfyf1o+ay/2SJNlU/QN5IEq+WRPWsh/9DC/9afx2LzE+USUmkfi57bIw3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rjxh5WfJ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-374c326c638so2985883f8f.2;
        Mon, 09 Sep 2024 00:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725868628; x=1726473428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqq6NzUB0QMlVgbuEigLtg4dQP3OsIeGqq5KqtK1ysk=;
        b=Rjxh5WfJuiz8yA4Xbu/ICVFsj0jTSOkivjBbCCXuaMBduCJm6IkNCx8hzv9FZ1lO6y
         fry7cpuHfa+++7F1+/N2X0v8go06YS3Iq6XNBIrv2+NpUJKvM8GsS33frYxftB/kEI54
         PPKIpSfE7xd75jvLLfPnbuIVjRceHWOZIcsymlJHJ7cmVYe5uTBq/OYa70IDXuGkRI+6
         hnVK1LfeDdnFgDg0MAzogu3PsJdHwS3Vl7KfIOEUtmBS6cffxmfvPxSgnYxNCKOA0Klx
         b0YJd0yWBez91O5k6bt5/cr21w9Ig46erPrjt2qGM2+EzMUPIpWbqII79YO+njucpEsg
         DZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725868628; x=1726473428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dqq6NzUB0QMlVgbuEigLtg4dQP3OsIeGqq5KqtK1ysk=;
        b=PWTI5JrWZe9m+tl4EDHPvV6w6xEqszOn/S7nyps9Zi+GLtRVsjd/RVbCXGY8t3AZRn
         QmDK9uYsJx1E3WqdBAnULqm5Oqj+LY4gtRbMu/UI9VYBJhMyPO6FiIcg2tZ+M1aTGK2c
         q0TNor/LA02N5HqieKCrsskaKYgMimVU+jm29S3P8zBgoPRiyBDSyhm3q3vDXxLFkQLb
         LZ6nz6Mkk0QVUOk66+dQNIpvauy8W37PQDM6SHa6gnrymlfk97a38dhiuVSsJy2SGnpM
         yRBTaFXkaB2rDFfqeKbImvBb9zWonB4678SjkWj9HWlbhg7VLHTD6NbnjAO990kgcjau
         fFSA==
X-Forwarded-Encrypted: i=1; AJvYcCU+4Ala+NMXMoLvjMUEgnhRSO7WzgYpvgDeNCOR928J2qHo8uW/6lpIFZGOb34ZQYiCqSHz6GpgXh/kJ6NX@vger.kernel.org, AJvYcCUFBapJw3mPOzngBUJNuL9ZEicB6chU2PmKCzA8DLa5piLXUZNXRK1DHbepNgoZ4azjuM9a0NyHEwGyDZccOWjb@vger.kernel.org, AJvYcCUgx8oKvRUE7geHBmGFKoCd7DOzBNA1FT119NVqq0CODPNsc+RBPicbsujrVzbZ7MukR84=@vger.kernel.org, AJvYcCUwzLJ1731cQTwflei1sbtBunr5vWkF9CxXN9OIGGBKPz8slFbZZkHyhaICNZrkN9YGBWQd8cbgPlrm3L0=@vger.kernel.org, AJvYcCVaWOwh82iYVxVJXRMHwF2d7KvkFNCq+tfpWe4JG+WUgvl2sz0U57uq98qeHKQaV0Z25YPGnZfLes4/ZdOqUQ==@vger.kernel.org, AJvYcCW9ubcPjmv/wt6R5n1O5cMPH9m7/nxBkKN0bEG8GjeVK2z49OKxmuqvJwz8bLNZERKxvXZMV6Q4wZiIVG89@vger.kernel.org, AJvYcCWx7YqOY5TLuSm4ZRlVNjP7mw8n61Qvrsm00lehpSOeYwnj4AzUyayCJDq9k/vQ4mEl8TMpdimSvy5WGw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1kk9iCxN4vb7e0Ksdz+oVZJIsqXXDJavjXKLf7CT0fQCU2ifE
	or2tC9BRHfPNSvuf4/xcQVxV2Udvc8AUASlNLOANette+j3P9iXU
X-Google-Smtp-Source: AGHT+IF890nGYevdgrqUf7UHJ87LKcir0BiPP7YH573XiCGqtakWSqkvGhsMvBroQEOSJMo347DAIA==
X-Received: by 2002:a5d:4fc7:0:b0:374:bad2:6a5e with SMTP id ffacd0b85a97d-378895d4894mr6553002f8f.28.1725868627558;
        Mon, 09 Sep 2024 00:57:07 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895675b7esm5303001f8f.50.2024.09.09.00.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:57:06 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-crypto@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-fscrypt@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH RESEND v2 13/19] lib/rbtree-test: Include <linux/prandom.h> instead of <linux/random.h>
Date: Mon,  9 Sep 2024 09:53:56 +0200
Message-ID: <20240909075641.258968-14-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909075641.258968-1-ubizjak@gmail.com>
References: <20240909075641.258968-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Substitute the inclusion of <linux/random.h> header with
<linux/prandom.h> to allow the removal of legacy inclusion
of <linux/prandom.h> from <linux/random.h>.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 lib/rbtree_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/rbtree_test.c b/lib/rbtree_test.c
index 41ae3c7570d3..8655a76d29a1 100644
--- a/lib/rbtree_test.c
+++ b/lib/rbtree_test.c
@@ -2,7 +2,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/rbtree_augmented.h>
-#include <linux/random.h>
+#include <linux/prandom.h>
 #include <linux/slab.h>
 #include <asm/timex.h>
 
-- 
2.46.0


