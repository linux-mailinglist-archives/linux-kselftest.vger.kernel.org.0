Return-Path: <linux-kselftest+bounces-18633-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD8C98A2FD
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 14:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29536281978
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 12:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B29194C79;
	Mon, 30 Sep 2024 12:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GI52iKz0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C2419307D;
	Mon, 30 Sep 2024 12:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727699845; cv=none; b=CAIZHhS1ApnjGTll5W4sSIfXgJH/gOR0EsoNy0sNJ7OgpaRCHRLDJATKs11mgVOivsx+aS6SEBiw8N+ZMKI/fpNmvmHu7hoLQ9KRZ4bz+4ALikuWLWiyPkrNxHw0SQ5wc+0AmB0k31vx6uvpjghVRD7fmFJBu2DA9AUwzGCv2PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727699845; c=relaxed/simple;
	bh=cl2o7WOP+XxveqCXggCoTSn8OS6G2iWQbzL9Denpf68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=otCTF/S/nqsY/om6pGgpjDzNpZRZUpnECyYYu38d538rVftSvteVyaN/FMQ4mVsl+QZCYLzezAn+0/rmjY/9v03dMbH7jIB18KqlODLlWAGYj3rmpOLH8xPpek+OGEzkvb+hSgNfZ28BP28U4ZXDko0Kng8RiRPfILf8QrUOFPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GI52iKz0; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cc8782869so39889835e9.2;
        Mon, 30 Sep 2024 05:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727699842; x=1728304642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqCZlFa0k9WmJz/BFH863M+r457tyeztRr2WseZe9PM=;
        b=GI52iKz0oSFnPzJNb3s20OQBcDlvk/KXbQwwznUkklNvZ2YDQ7qsa90H7CaH5MLm+A
         HT3+74xHRBFrGtwmP5MZSZHk9aVwPum4EuibdReSp7J1ik0yiMWObfr14msAebjjGkug
         1DeA1e2V/pepFmKhZ+zgCDqh97uh1BVfDe+Oz7aiadiiiODRun+nM0etaKJcq8cHmOCK
         RnbrbHXqJrSuE27Ap53PZi+/MtSQxSFoQpdbrSWJTqbJ11hWpQAOM6T5qFErGMLGVEqa
         3WdfxcfUT4qCPdlmcF3VtIyHW7zrmvkCw5lKIaYrVooMArPDhZ1e5VwdsCNCK+xT/PWq
         cObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727699842; x=1728304642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GqCZlFa0k9WmJz/BFH863M+r457tyeztRr2WseZe9PM=;
        b=awi2BWVks6ynlcCQmKzhLIK/bFYK3EVIWPJAnzhL+1bGzrQJC2TJ5ihHbuTUsYpPsj
         CFrzAwZpXSyzfCrBRcH/dmpsZnQZ8/Icz0IljmBVWMVqBfhiucd4+LcnvOZeT3GSyOIb
         tRVouL++WMw5ECGtA/BtirNHP9h4J1a2mSyWri97hXCGpVAcIdQX8ed1jtFuoemf7yqp
         4Hm/NoHh7G0swDqVIVcmDpvLhcrpqJnfY6MZBGsKgQGzTqEQJeEc4mSVNjkPZu0EZEEk
         ewAc6ajC8eVJfoHMec71YSRd0M/5LZqnAq2As01Oj2+SDJzX8HdpmPEsJ+v9wh+zRt/n
         0q3g==
X-Forwarded-Encrypted: i=1; AJvYcCU9CAkYmu35ePofOTlSpB5c7zkECNwFxLoWNWAsHLLvT9VXhkAEs2H4ZKaL3wHnr458wP4=@vger.kernel.org, AJvYcCVEbn7R5BzBq37S1tNr8jR2o+Hz1HaDRCXE61SR1VOTGXDvjPXDRM+/0fnqFWgMwoB+kGoIE7Jpuuf5UFvk@vger.kernel.org, AJvYcCVIWWGi1d/kBEqq38dw+jcbby3rStfDgOr329nbBM72uVxxfjVgPWP4CjS3ybESOwL4/FFSoWUvFvXEc8U=@vger.kernel.org, AJvYcCWqCWr4Rdd9SS6VV+gpuM3CNMXIuMjzB2wSTQFxAAYiKuHdHwg3XTadzAuNXNxKvT0Lz3rtvWRwqryGb/i6KG8R@vger.kernel.org, AJvYcCXT9LKB7HV4CkcHar0SE5nJ6RFH1oVsxdRIfMXDGk5gpIcU5jdv/eDkegnZ47v3YZp/gGqY7aux453hAZ80@vger.kernel.org, AJvYcCXTqnVnG0uqCMl2vZblYfe/PMDJby449oh8UzXIBTHsX+Nb7IKodpJCQAUrsadhKTlWazPdo866j47m3A==@vger.kernel.org, AJvYcCXnHp8CnjQdBFUvh2nW479W3imRzat0HbTtuWXsQC/xLuNy/Jr2p4M6mDTB1osumZnxH+Zzf+MexCt/+Zvc0A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3lp3XHHvVSIlPSP10z9kciAWfkeqeulmdOzDoDwaZenXNieBO
	CxK6d2djkI6qmfLkMn9p04zVHnTwq1m0nfvt9e/1i5VJCDDc92Vl
X-Google-Smtp-Source: AGHT+IHDSczxlpNlMjqYJQ/J5lvvp+MGxNHf3VyEwPU2HocH3ahQJeDUV9edXRytld8Js+EVeXOtyQ==
X-Received: by 2002:a05:600c:350a:b0:42c:b74c:d8c3 with SMTP id 5b1f17b1804b1-42f584a2da9mr83108865e9.32.1727699841971;
        Mon, 30 Sep 2024 05:37:21 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a52308sm149011355e9.43.2024.09.30.05.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 05:37:21 -0700 (PDT)
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
Subject: [PATCH v3 10/19] lib/interval_tree_test.c: Include <linux/prandom.h> instead of <linux/random.h>
Date: Mon, 30 Sep 2024 14:33:21 +0200
Message-ID: <20240930123702.803617-11-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930123702.803617-1-ubizjak@gmail.com>
References: <20240930123702.803617-1-ubizjak@gmail.com>
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
 lib/interval_tree_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/interval_tree_test.c b/lib/interval_tree_test.c
index f37f4d44faa9..837064b83a6c 100644
--- a/lib/interval_tree_test.c
+++ b/lib/interval_tree_test.c
@@ -2,7 +2,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/interval_tree.h>
-#include <linux/random.h>
+#include <linux/prandom.h>
 #include <linux/slab.h>
 #include <asm/timex.h>
 
-- 
2.46.2


