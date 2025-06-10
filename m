Return-Path: <linux-kselftest+bounces-34545-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EA4AD2E7C
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 09:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4BE13B1A1E
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 07:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8204D27A92F;
	Tue, 10 Jun 2025 07:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEzyCIi8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1851B4685;
	Tue, 10 Jun 2025 07:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749539973; cv=none; b=m8VUtOQSMD83LpiEFU3tvaI//RPUez973UVDl/xdaHcU2iaP7RbDKFey+eKyICq0nrRnfBV8lYyfQ1N10IkhL5AfnY1OTHYNKSgWZ9BR8rsRumUsL6ZFZIG8u/hLMed1x/NoCboWOFddC7HqE9LfZIPEQZ1OGxbvluWPVTjXBIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749539973; c=relaxed/simple;
	bh=wDddb1ld4SB4Zfz1RpLwVoYWot4JpeZ7vucqwJW5zoo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ESBweHOiqHDQnSdB0DNPZgsEQB7M092cr4iKvRThF6sG5tbxO9Ijv245uWzMIJjXD6ESOPA2io4ln+6pIO2UXhyylamgQdgV9gSNXlwYR0iYwASSMK6TpnGpBn+DX0K9MJpdP/DfoYpPzHgamkIWPx9g7iJjQpUPXuVhi/NzJms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEzyCIi8; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-747fba9f962so4324984b3a.0;
        Tue, 10 Jun 2025 00:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749539971; x=1750144771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pDX4vPZViSmWx9XsZSFtm3JkGpSEHjpstS/gbSMAf4Q=;
        b=KEzyCIi8qj1LXnX3UVOBI6Wx1DlU5E+BdnYNRdl+QC659u1jQ2pc9ok553mI3TIcUG
         PPwsVUWifiVTG0Gk0CD5b4WLbbPE5qfvAXgP3RwH0YoKEHBVP/+bbDuo19ism1HHFlvD
         +2HWiDwxi/VInrpqnEJ3M1OUCCTPOPFFpNBdKcuZgkRE6t/P+sSHf6KD8BC3q+rfz+Bg
         1iSafrmaRPlQIH9UDB29vhsVtxcHMq59fZbjCRpz5535ndEnAWul9GTx3BX9Xuy/QWDu
         nyDmGClMf5MLCNBa1fAb1IAabukOZpYuHlgNSq9vsuFtaEPmxNPSVXGUi1G2bAx4g4DQ
         ZAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749539971; x=1750144771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pDX4vPZViSmWx9XsZSFtm3JkGpSEHjpstS/gbSMAf4Q=;
        b=ajJEtZM1T+nG+C2tdINrYcti3Rq4BXj54AeV1p7O1BMNiZe9JCef6o1s6x1Q5OB0J+
         emqIhFJ20RjVgd8OhhtCb9Az6OgKHKh2wW4BHtfcXIBGQIMkcmv6NjjJM6oADEeioOvY
         m5TLU1tnWMDiC9nTt1224kgheBAjpWaMSIoy/S4osPU7bx/glVKxukpQSg1/FdGVDWCR
         MdUO5M5ZE76P7a1THl0ebxbnw6jq+LXx6S4iFp3P3ZutH3xm4sFIVZIcSNlJtESdqr3i
         7n+KsecPCW7zddca0Fs2HR/iHaPGkabgdkrI80YNwjA0hC4XlnXOPx181WjyedhOdcIt
         RzxA==
X-Forwarded-Encrypted: i=1; AJvYcCU8+E3Wds2wZKA97jJXV7F3g6f60/+0HkKx1bO+DpS6jDZS6Fo+ghP6OQwqJSEJ+RvN3hQBt/jzxe83SBM=@vger.kernel.org, AJvYcCVPgxbSr9q8GRMkDZheH2yGKidxtBFey0aBFMHgX1lZlRxqvKudKFQqV4/YPQURLOTlK1km/qZYKUGbLx3naJXi@vger.kernel.org
X-Gm-Message-State: AOJu0YxryFCWh/k29CpXChKuQmSEtUTpEZFIJrQFYeSM3p2ERZS7hMWj
	mMKGgDfXoN+0+8gqW2wJpRZR1JkE2YaK4xF8LIBaXYi0ypPk6nLO9nIFl5ZHVfO7fSw=
X-Gm-Gg: ASbGncuMlLzN6gU8fzzIEhPTLdhJYhHf8qhK6K1NZJfjlKbXW8lGRQTB/mRUNc1E6nW
	lL/foolLv+GDKxvTGtWG+WFiA2+AzPpdhfDmTdJ5o9UqZ0/Z/qQONfMOXjVj01vv7sI8mgm2lqZ
	3LhgQI63CkLQqBNZOZ6ozdO1ybT1mQublhgp7X8W5wpjWK8MtDTAdLzYPtpRzZu3DxRVrgLsd7C
	oMvceXLXl7JW9NNrZgaOtCi6wlTWHm3MMRKzEukG0qzQCJU1NHhXkb2Xmmf0o/TTre5opGUXCuM
	HPhxN3JB8ezWq+uKBZ0fVX4sk0cAwnKRooKFS7CGAz4EJSKXPqqkwbcfZ00sd2fxBcsKXW4ZfbT
	/p3xp6a9TqUIRJALGHsg3QLo=
X-Google-Smtp-Source: AGHT+IGx7RAYvNR+BCxplI7dwIlr4fCOsZQSAXxnui6LxNDDT4+1U7VYn/Ig6VAsuxLZagXdS0Oz5g==
X-Received: by 2002:a05:6a00:61cc:b0:742:ccf9:317a with SMTP id d2e1a72fcca58-7485eaf793dmr2338597b3a.12.1749539971308;
        Tue, 10 Jun 2025 00:19:31 -0700 (PDT)
Received: from ankitchauhan-Legion-5-15ITH6.. ([2405:201:4042:d128:777c:e0e7:a5ab:8698])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7482af3823esm7110224b3a.17.2025.06.10.00.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 00:19:30 -0700 (PDT)
From: Ankit Chauhan <ankitchauhan2065@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ankit Chauhan <ankitchauhan2065@gmail.com>
Subject: [PATCH net-next] selftests: tcp_ao: fix spelling in seq-ext.c comment
Date: Tue, 10 Jun 2025 12:49:03 +0530
Message-Id: <20250610071903.67180-1-ankitchauhan2065@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Spelling fix:
conneciton --> connection

This is a non-functional change aimed at improving code clarity.

Signed-off-by: Ankit Chauhan <ankitchauhan2065@gmail.com>
---
 tools/testing/selftests/net/tcp_ao/seq-ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/tcp_ao/seq-ext.c b/tools/testing/selftests/net/tcp_ao/seq-ext.c
index f00245263b20..6478da6a71c3 100644
--- a/tools/testing/selftests/net/tcp_ao/seq-ext.c
+++ b/tools/testing/selftests/net/tcp_ao/seq-ext.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Check that after SEQ number wrap-around:
  * 1. SEQ-extension has upper bytes set
- * 2. TCP conneciton is alive and no TCPAOBad segments
+ * 2. TCP connection is alive and no TCPAOBad segments
  * In order to test (2), the test doesn't just adjust seq number for a queue
  * on a connected socket, but migrates it to another sk+port number, so
  * that there won't be any delayed packets that will fail to verify
-- 
2.34.1


