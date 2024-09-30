Return-Path: <linux-kselftest+bounces-18638-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F9A98A324
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 14:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A42AF281CDB
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 12:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5BC199FA4;
	Mon, 30 Sep 2024 12:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSeIR3kh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B97A1993AE;
	Mon, 30 Sep 2024 12:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727699852; cv=none; b=iS0mwZrhQ3wh2S3GBZZ+5qOR90IuCCd7pa74/1pCPidlalfKTpO33zXaaKEIUvk3nIZwilb9SemKGloMXaYHNx5Ih5UZt5bshmTcnThW0KohbyjSxIF9T6KQDuo2hd4BGo8XcB0JlJYhq/y3kuBZsB9ZqubX0K/BhNwxip57p0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727699852; c=relaxed/simple;
	bh=liGEBzz4PELJoc/Ikpz03anMkKn/PFLeVYI7GeKl1OI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RREKXX3wI2kS7i22228KnrByuJa41ua1TdPaZ2RJj0h0V+y4cHzPocrwA5+FF5m8XzMENgZQq6i9bTB+ZFvGDczOclyJ2mwkI1yKvFlC16HzctfuCokS28A3OEpZrVlC2mAQqFOgWIdcCl+rVPGhqtlLJYnEIhy7vS3PLc+7yAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSeIR3kh; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cb806623eso33176325e9.2;
        Mon, 30 Sep 2024 05:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727699849; x=1728304649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=It3uv8+V16fpn+saBfVIlpi9seKMH0hwPDwquZC7SM8=;
        b=bSeIR3khy55C9w9p6YRNRAW5NUKzvBse10pYb6O/ba2Wvy8lbUNkn3A/K/VpECUIFc
         BYPVvTPTfdYZTdKnQ5OvDPlAjVt2tU3kWZCqy/Qpdl1V8OkKzWCI1gZrqNw37mIBmBCx
         qnbmKerFZ985s+EKaS++BaOJvrbsLm/CGoJtH9eHnv+Pq0o4pnBMzMLYddvGpqj9T2pm
         2mGCwGHIWemQ4KZsPe+KE9p+bB5C9Eg9jjTQvzxeNW7p1CYwTI1qmeQbpXgBYpCQvTJY
         BdKEsf+j4CF7w0gprH16dbDrxp0Hws8UVj2OVF8FFR57YGdPjH3jRwwXzYw9fe430/pZ
         PMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727699849; x=1728304649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=It3uv8+V16fpn+saBfVIlpi9seKMH0hwPDwquZC7SM8=;
        b=doYZHl0bset2Ox0O08wB5tLBsk23j2UEqkOjJ42uGV0r3l+qTcMpdjEWSoVl20F37N
         vWw6Km9mXCWm2vQi9paSt0Ex1Ty8lgYY5bchmoPg50G5LGyzTLfZDBYSM9EtHxgpUpx3
         O9q7EeH95UEmWdPJj4AXkvS3rDmNIW+gsrZz1k31EMBwAomN7xKS1juzOrMRlaHcCqxW
         goTscYdsbgy2bE1Ish0c0jz5wj3ICD5ySA3zpQgCmsvjI0jFmy2UCIgZTlVM4uLM1PNR
         sjojC5iwdtLL/oXJWuFBjaWT7bRrFh4NunFhgmlmbYnObIJM9j7ypnkEQNeYdESfv6AT
         PMUg==
X-Forwarded-Encrypted: i=1; AJvYcCUeqiosHJbygz42gimqVnlB+7IMK20ONTPFi6AEFtCLT0PMmzflUEWJ2CmBC9XBqsC4dwebfsv7rkrmMA==@vger.kernel.org, AJvYcCUgnuzfJk1s+sR1t2QtZoxa6LMmD9WpW9YMKLwGBieGjvhIaq/drfAUdNSMB8V+RgXtfORcSRuF27Hw0atv9oV0@vger.kernel.org, AJvYcCVyl94Ra0pkAMhNO2VV8ovRn6z11Fj5sN2uiF585jr0d+8IMt4Ufu+5RLVk4gpMTX3qhqM=@vger.kernel.org, AJvYcCWKT/bC+K8l/fGTQtcF4WF9MT73gUvq9fgKmdwk+pIoNhCqKrdMouGjLsdnEdEX8vQcmTiWB1akK/v5MtMz@vger.kernel.org, AJvYcCWNcHMJ3K5LOthJccb2UUXEq1qAcNgwap/sCcpYZldH3zjYp/nq5r4mcPeWZf8iCSXECxRADmtT29E2Csw=@vger.kernel.org, AJvYcCX/gcjqec2HRiz0l0I1ZVeg/ew05lhkZpVoQiqM1LXJta86kCT2NH4okC1ODX0nfUSodow2Ix1spICXR6YX@vger.kernel.org, AJvYcCXiP5B5b9i9OpWVvxoxuwLPiX0Q5viAhDzVwYLy/Er0UQEniJAjif2ClaOpG5zNbAOtzx8MJ9fWrhWr0J6P9w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxU+YeFF4gGekuensg+0o3UD1eZtxpIOKXxznPqqT8RolKRw6lr
	zGaa0an3ChqtrbVxNrWI1byn00XXaFT7korN//jhhM4jizTKWEG3bRMRXIe2Wnc=
X-Google-Smtp-Source: AGHT+IEqfXUL1BfL9uwnKBRwxBvUK5HW+SKSYQE3kTn+gocX4MXts0u3yymxZU+7jyC+w/S3B15WBQ==
X-Received: by 2002:adf:e888:0:b0:37c:d344:8b42 with SMTP id ffacd0b85a97d-37cd5a874bdmr6237784f8f.15.1727699848530;
        Mon, 30 Sep 2024 05:37:28 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a52308sm149011355e9.43.2024.09.30.05.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 05:37:27 -0700 (PDT)
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
	Andrew Morton <akpm@linux-foundation.org>,
	Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH v3 15/19] lib/test_parman: Include <linux/prandom.h> instead of <linux/random.h>
Date: Mon, 30 Sep 2024 14:33:26 +0200
Message-ID: <20240930123702.803617-16-ubizjak@gmail.com>
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
Cc: Jiri Pirko <jiri@resnulli.us>
---
 lib/test_parman.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_parman.c b/lib/test_parman.c
index 35e32243693c..f9b97426a337 100644
--- a/lib/test_parman.c
+++ b/lib/test_parman.c
@@ -39,7 +39,7 @@
 #include <linux/slab.h>
 #include <linux/bitops.h>
 #include <linux/err.h>
-#include <linux/random.h>
+#include <linux/prandom.h>
 #include <linux/parman.h>
 
 #define TEST_PARMAN_PRIO_SHIFT 7 /* defines number of prios for testing */
-- 
2.46.2


