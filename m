Return-Path: <linux-kselftest+bounces-12395-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80365911945
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 06:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3D871C21596
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 04:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26550126F1A;
	Fri, 21 Jun 2024 04:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFhOD+Kc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FC430358;
	Fri, 21 Jun 2024 04:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718943409; cv=none; b=H0MVC8FbgpUNOxVLahK8ol8iQ9HTgyReAWqPuDimZ0xF2/38jZv9SCypsS8uU+wucyZYpM+YEKF2ztjR9Lo/+vCeijvjG19+ifI2uRhmXwx5wJn1kDkvZfMXmIbK3jOEvZIo+7QvPn/yx6u/EmxHsyDIzdQMo+Ot0Y4aUYx6kfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718943409; c=relaxed/simple;
	bh=sv4wMFkdrBdBxZnOrzr8gr1N0+BkeY4dtGYEng2BH2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=axrWZI0M5N2p17Z25cErSVKiqW8qNpzLnWDN1TxYpqKhl2O8BsPCL72rQGkm5Tx2wbaIhvcOYjNZETXGPCq41pL2rLPXow9tJw8BdeSHahF8kUj5KeMBABm05+U28kmF54OHL5arUfaI9a6ar3eUbCg6+8VSlsKMdVXcWvPi788=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFhOD+Kc; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70627716174so1418247b3a.3;
        Thu, 20 Jun 2024 21:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718943407; x=1719548207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YN8PcBH1HYvufdu7h366KZ+SpqI0rfaHBVU/tFndEIc=;
        b=fFhOD+KcAuM2j8CkU43sbIaDZvOYFqrkMEdW3Oj+/75ERKgshnJONe3NxmvNTxOvdi
         6F137O+Cg9w9cw0KprMOt6SGVefsNNOSvgt/Jgrk2+Ljx0Mc7kvRvYwOElsZQh6sz8A5
         ZxDEYDcR2JK0wffvjCvMSLkgCOBIz9MhRzF0KUM8JdOKr5JipSzG0ZJmh7qI4GN0bWP5
         e+Et8FhRPqpPDPADyR08ggNC01wArWh2L2fVBFEB40u1/UU0Rvn/7n6EJ5EsO/sE/4TT
         GUzNHI/ZftIIaL4FevNRpws/oOwHw9gQnAGbYwzF+jF39jWkB3IYNDJAb8OwiAXWgXwQ
         W9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718943407; x=1719548207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YN8PcBH1HYvufdu7h366KZ+SpqI0rfaHBVU/tFndEIc=;
        b=gSxCgxc1vY22bxj3CiXXw/LnBYdLp7MdWMQA+5DnI5r3unYDcWcve8DA2USRSty6Gl
         j4qSUSUSZ8ubxdHtOfBUVp/VR7szz8d6d0X9koQWtw7+FDMpkSae2VtGVojspwfiLm1N
         2w0sZjNzJbrexL9kWF5vThxRdhz+rdLa3nWka/s6rDj6D/NF2Dq6C9Y2gPo03oN6xFhL
         xKDexKUdUuwQ2OM9ZoVvBi4tipwKbtuXb4e4dJhnb4kZgTo4rLeJ89jEu+mXeC2vRZ4x
         G8xXQPXUzQ5LB1c+iNWGFPrQK4lfkSYvEMECAnjMt9SpQS7KO4Sc1Rkx5RyIWm2ZWntf
         ggLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxgpdNmQh2rxGBB4PRO+4TN8c9zSLbf3M51tRJ8vHMfr0LU0/ir8uP0C3Bq2tfQxQa/UXYAstqHubZi9TIi5dr0HXQU9+RQWjdDKjQ5rv+zVS3q7QGfN+03CU7jLtBQIi89Gf6jl8l
X-Gm-Message-State: AOJu0Yz0WWlSBkLTIb/dDBIsGg9N0dbTZafsRltCgKFqxelfB2sDMb/t
	hVDPwbYXyNshOfURjUczZ7RhasehGSBDDrhjZrZD7s4L5IttPLcR
X-Google-Smtp-Source: AGHT+IEfRCA09u379kAmN+1ttTMfE1XH0NT8/hlr5uulBJQSrIrMhEj+Krmb+8gq/0rOzr7b3HfGgg==
X-Received: by 2002:a05:6a20:2a21:b0:1b5:8ecf:4e7c with SMTP id adf61e73a8af0-1bcbb665465mr6944715637.62.1718943406882;
        Thu, 20 Jun 2024 21:16:46 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c81eaf92b2sm363830a91.40.2024.06.20.21.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 21:16:46 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: ap420073@gmail.com
Subject: [PATCH net-next] selftests: net: change shebang to bash in amt.sh
Date: Fri, 21 Jun 2024 04:16:37 +0000
Message-Id: <20240621041637.3600944-1-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

amt.sh is written in bash, not sh.
So, shebang should be bash.

Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---
 tools/testing/selftests/net/amt.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/amt.sh b/tools/testing/selftests/net/amt.sh
index 7e7ed6c558da..d458b45c775b 100755
--- a/tools/testing/selftests/net/amt.sh
+++ b/tools/testing/selftests/net/amt.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
 # Author: Taehee Yoo <ap420073@gmail.com>
-- 
2.34.1


