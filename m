Return-Path: <linux-kselftest+bounces-33254-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE80ABABDF
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 May 2025 20:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0EE23AE14E
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 May 2025 18:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD27D1E008B;
	Sat, 17 May 2025 18:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHtkvoLe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03FB170826;
	Sat, 17 May 2025 18:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747507170; cv=none; b=NmEUI6gDdgiAMg9GyQS8TsA6IMcxhMB1VgqOC0Wq2QzSll8U/+E2El9bzQB0Qmc43+u+93avbVLcYNsnwV0oEKY8MXg4PooJZ2ALn6YO932n8bIP/HigOP5F06VCu46Gh7DDSPxM5wlQNFngDZlHziPE03au9npx950XyD9EHNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747507170; c=relaxed/simple;
	bh=6n6vtPPpy1jIatp/0sOElN1VzMiWlrrits4IaDsbbLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hi43i8snltCdSS01LyMo6z6Z87eKDl5oZ6YrhGjP8u1gIXbB2lNof0gfzx4fqkPsNq+/N+j02X16xmAKPqh3WPHPLtHILO6/aXGUUK8t0kBFm8v6/3GV+83K6p2X585BUYc+MQV04mm3fNCoEHMgBAq7JcQnC6SSZkUbpERVC8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHtkvoLe; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-442fda876a6so16053175e9.0;
        Sat, 17 May 2025 11:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747507167; x=1748111967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8rLp3fAoKmMhFEj543FiT4J/bez6Qh2zBbDpq1aPZoc=;
        b=hHtkvoLeAMIq2BI7zrNuQ1usSup0FR6KHZNfCMCfWB3Ik2YTJbsrwvZPYq11M5Oqo7
         va1JiK0kVgooe/gXJla/6wUgO7M84v8I9xufkwFAnyaJhNl8syhDmnWEhtyobIkVN+7i
         c2DtMmF2wvK2IPMjI7IIuDkJDAy/bqWYeBZoPHDiCcRFwKOjhO5EIw3a8Nb5ap86bMdD
         niJIRIkg7m8paGA4qnCrTzayOfJLM4UbcWuovA4Pe6g0CJ7jWSq4uSL+5ZEpurTjR3rU
         2qkaYStKHhGonxqsiqP8vzkuvH0sfmvjrne/88l0z3DY6UsZVgulqLLjMIGaANqM1f0V
         ktqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747507167; x=1748111967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8rLp3fAoKmMhFEj543FiT4J/bez6Qh2zBbDpq1aPZoc=;
        b=xT7yVrDWc2xdbYFrgtMcDdUgBMlCJ0LD0oKdIUqEW3Rsz18FAkkjpULro5WZxl3a4J
         DAwuNYT22kOfxqkKwTvurULc5bfRRWIL5nTeTRT0RyMiCVp54jAV+h/AmrFMAUpBwOFI
         dI5vRIkEhirv3h13evf8/QdrGn+Xhbv2QExlqCEx0OJCuAZApUn5VRjx4dDkmganfwff
         m2h78Sh6IUVH3jF2cmsNbuvtuq/mIjz4P7HHdZf5KQwNMeasdEO/7rAtrBZBu+L4dIvM
         sU+ZLhVZHRgUKyU68H4jvgyR2jpklqQzuT5XmInK6D1t7lOikdDGcwfSiJUnJb+mfUpN
         epEw==
X-Forwarded-Encrypted: i=1; AJvYcCU9Pv4dRLMMpVuiX2IH5ZsqPhkJLRlIh+k83ePEQrBnGoan/CyjTHUTm+a4N49TuVHnQbj9lAcZ9gYW1qE2bdri@vger.kernel.org, AJvYcCUvVW2FevP2k6x6J7ybcrHSxgdKMnRbxt6Lft3UVlIpuJTMXu8uc23WkZLfEqhzHRitZ0eY4rfHrn7N+1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQzFSdDoB4nOyH+uztm5SsrQbNWx/XJBeg1Gps25WDdmb6Bhgh
	661qVTSApYhFQeu2jO4pPNUMe/6VkxJlB7SqleL5Ky4bx6CVTMRUd9js
X-Gm-Gg: ASbGnctUbG1Pn6Af2Bl8niE03TZieS3w0N3fEZUkcw1DbXeXgPsYJXEjeIPGS1XY1dN
	/l0yEC+7oqlXNwH+ac4t75lxt0H9PIsTjl5M1Bat6GPw+jVy15o38JB5LjgXI45mye6xbLQnslL
	pr09+mMaHkexvhRs10L0reBNQZmZxR66oYdWlV7kTXbS8UgtU6msrt2vNLR6wYgimINs0tjbRmv
	lgBBIla+yq/60hIiQ5DzwhFnRV5HabhnucEe54P/OjLkwhRSVm511g1eblfmF6AzSdGa8gNr46o
	CB8AXRo1q/6uoDmzreDvVDgM7nitWafyWfj175SZmk9W
X-Google-Smtp-Source: AGHT+IHRlAl4uzkKtXrPtksBU7hfyP7MmBY3rnU4nmSgOwh1hGxpcP8yZXd+fx3IAqyEOwuUhNIGzg==
X-Received: by 2002:a05:600c:3d11:b0:442:cab1:e092 with SMTP id 5b1f17b1804b1-442fd618f88mr74762825e9.11.1747507166849;
        Sat, 17 May 2025 11:39:26 -0700 (PDT)
Received: from hsukr3.. ([141.70.82.122])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca8caaasm6908922f8f.83.2025.05.17.11.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 May 2025 11:39:26 -0700 (PDT)
From: Sukrut Heroorkar <hsukrut3@gmail.com>
To: chenxiang66@hisilicon.com,
	zhujun2@cmss.chinamobile.com,
	iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Cc: Sukrut Heroorkar <hsukrut3@gmail.com>
Subject: [PATCH] kselftest: dma - fix typo "mininum" -> "minimum" in comment
Date: Sat, 17 May 2025 20:39:01 +0200
Message-ID: <20250517183901.165631-1-hsukrut3@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes a small typo in a comment; helping to improve clarity in code comment. 

Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>
---
 tools/testing/selftests/dma/dma_map_benchmark.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c b/tools/testing/selftests/dma/dma_map_benchmark.c
index b12f1f9babf8..ed5522061dd6 100644
--- a/tools/testing/selftests/dma/dma_map_benchmark.c
+++ b/tools/testing/selftests/dma/dma_map_benchmark.c
@@ -80,7 +80,7 @@ int main(int argc, char **argv)
 		exit(1);
 	}
 
-	/* suppose the mininum DMA zone is 1MB in the world */
+	/* suppose the minimum DMA zone is 1MB in the world */
 	if (bits < 20 || bits > 64) {
 		fprintf(stderr, "invalid dma mask bit, must be in 20-64\n");
 		exit(1);
-- 
2.43.0


