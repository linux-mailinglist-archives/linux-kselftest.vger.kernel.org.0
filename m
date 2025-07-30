Return-Path: <linux-kselftest+bounces-38083-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4A7B1629A
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Jul 2025 16:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5F2E5A4C49
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Jul 2025 14:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35CB2D8368;
	Wed, 30 Jul 2025 14:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nj8nV0SQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DB02AE84;
	Wed, 30 Jul 2025 14:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753885392; cv=none; b=UvvjKhuVEW91nR11ci3rgjgE1GVOMJ6EzPPdtDoFfE1jyktkqnyJFNMIGcI/Ov5yjllZ5r2dYU7DxQI80lxuk/d3fPIaDJVAzNGeDl73hogE4u6NtP9K2+70YBElUC1PG2g+4db8YXc+lu2l/mrSiZV1lba+ebELGBNxprMb+vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753885392; c=relaxed/simple;
	bh=Rj4aipnDRO0gDvZfK75+KHrLjlVFps5RzIp1ozeQHjI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D4Zk/Xfh2SPCEL01BxT9DFALqst+3wXv5C/2krkCDU+mXfxzfTWGLbAjkkwNZ7dUAbcrOjT9aGvAb6zGTkh1de+5kl9t5bA4qf7B+8r0/3uvCnpNHBvZX8my2+REZEKYARD7TBCmXk1NRSAnm5hPMs7PO9gNHjn4cFH3QWB3TKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nj8nV0SQ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76bc55f6612so282701b3a.0;
        Wed, 30 Jul 2025 07:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753885390; x=1754490190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1cRqC1FtXpwVgZZdAo/vwbXfMDd9zPAjXXlAeihsTpA=;
        b=nj8nV0SQI4lq9P1ZDZGsGIHG01AEmRsTQvx8vNbSk+dDqEousKB2D2+0qWS5k5nxQf
         ymh6W/SgYq64g7zVFulebeeWSm7qY7Lftl9GLxUE3CXvdG+6cFwo28949/ZF7SU2VY4d
         xK5YxsdBRiISYgvDNcwm7RgMoP/crhzM3yojS+RCDcowqbJdpgXcw/KLr5jpw7FcabcB
         kGn+kM93MeeHJplu1kBH4Db87YArQkNuC1lXYzfZIX8c+o4/JBa30zAIRGyVK+eIgZZ+
         NDYV7jABXmKbAwW95eOsr0qECBMWi4IhNsl6vuE/U8PBSjYitAxuvc3myfV9RZg05ZgT
         BZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753885390; x=1754490190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1cRqC1FtXpwVgZZdAo/vwbXfMDd9zPAjXXlAeihsTpA=;
        b=VWbb/jwhwM0CazTf8bSViK9tcWRR1X7CRdYwxPtXdl7R5yhLn5w1sPftM1ws1yPhr6
         tOvKpe5kSsGhWb43yhbYl+o9W1np0GjVeAIeKbabFVMS0JlgROem4FOSzAZkc40NWux2
         zjz0weTsYgok1Ja+1B1zc+TYvXJE8GPLNf0hHxTNEa0HrkriBDMfGNyDlu5AXWLejj8V
         YkRjFKvxWUnsxSz3FnSc0uNeMzgB97wYeBVR2e7rRlnRBlcFMLFEPQ2rb1hxyFq85rT8
         I11YQE1HMwlcLZhEogFc/3YP8w/390/DAGnryiBTsSpgPnAWuqvk2EoHa3Gv1xPSOT21
         GElw==
X-Forwarded-Encrypted: i=1; AJvYcCUQx9Ht3rBf5z4SlmA2vRtpdh4erqGfZeby9Ql7GMsSiVA6NFMjhHN/so++TumvFo9308y0Y1XaWkvdMYId/+mg@vger.kernel.org, AJvYcCXxJ1/oOmrtKEXeVbcQc1NUe3KAClM3HIfPiffJXYy0UTg96tuK4xoZ0Qj8XU0r7wolRBE/NnKLj7y20o4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxijb2xV+H7MtUxxBIK+HvFdJcCrDD87n2559setxxWAIyQGCUw
	1NzTOB25Le/PPLvykiXaDslkjimtxqStnx81TsqUsJIIpc1pI2sr0Lzp
X-Gm-Gg: ASbGncuJSCrdAL/KMk3TwvSQflFRQT/46cQlCnMQTo9OqejCpQt2GLFEi+T88ahA1s9
	FZ9ki/aMBWlA6G070TE2UC0/bhHOlj6pfu15sSWk6X3Crq5S4mjDjrfXfXqyYFx5fFDog+Ov0WE
	WNEWK3c61O5PxP8qg8iWWxY9ZcZ2do8BL/IB05+qgKe/yR05s8d/LYOzy1B/3+hM4xcAkt6lMP+
	VPnpv3m7k1LM591G3/idbuuiaPJoUUQn2C+EhOCUqW6SmUP57N41WYH1WtkznUMa80QkVRge+Po
	j7eqNJZIpt0xpHaFTvK0vTXDMeKxOyYTM/Z2l069e7rHVqSuXjD5mwPJp4Sype6KeAHCkczG1Im
	tJDsjrzp9U40txypb17S3CbXhbcidhmDzE2vogwZx20ehtuPo9KiTUw==
X-Google-Smtp-Source: AGHT+IEkuk5DkkrSXb8g61jXiyuwFe8WE4pg2bZKktTui0p034jBJ+2UWZW5+vUGLJdWXD5cf8sXMA==
X-Received: by 2002:a05:6a00:3283:b0:76b:2834:8c5c with SMTP id d2e1a72fcca58-76b28348e14mr3030492b3a.6.1753885390071;
        Wed, 30 Jul 2025 07:23:10 -0700 (PDT)
Received: from manjaro.domain.name ([2401:4900:1c66:2c0e:6464:f87e:9efc:7514])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640b2dbbc2sm10148099b3a.95.2025.07.30.07.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 07:23:09 -0700 (PDT)
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
To: akpm@linux-foundation.org,
	peterx@redhat.com,
	shuah@kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-kernel-mentees@lists.linux.dev,
	Pranav Tyagi <pranav.tyagi03@gmail.com>
Subject: [PATCH] selftests/mm: use __auto_type in swap() macro
Date: Wed, 30 Jul 2025 19:53:01 +0530
Message-ID: <20250730142301.6754-1-pranav.tyagi03@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace typeof() with __auto_type in the swap() macro in uffd-stress.c.
__auto_type was introduced in GCC 4.9 and reduces the compile time for
all compilers. No functional changes intended.

Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
---
 tools/testing/selftests/mm/uffd-stress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index 40af7f67c407..c0f64df5085c 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -51,7 +51,7 @@ static char *zeropage;
 pthread_attr_t attr;
 
 #define swap(a, b) \
-	do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
+	do { __auto_type __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
 
 const char *examples =
 	"# Run anonymous memory test on 100MiB region with 99999 bounces:\n"
-- 
2.49.0


