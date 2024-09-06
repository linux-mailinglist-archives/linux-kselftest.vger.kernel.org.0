Return-Path: <linux-kselftest+bounces-17384-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B3B96F0A8
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 11:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8A22282B85
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 09:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F211C9DDB;
	Fri,  6 Sep 2024 09:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYZeCQWX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7D01CB158;
	Fri,  6 Sep 2024 09:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725616617; cv=none; b=t0ljkU0hxL33LZOaRLLSzmTfggz5F5CnjvzhiI9DlvoxISWTJW/rodSaj4mjC8h1dkCf/G37SlTCubz7k+G7lQZKbQc/RKXKGaubkz92ACOdAcn8/frnFCsuvLxVhhe5MTOC8q1Hl/KE70OhSqpKVvVdwMOAJIgbChpQpPyYhiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725616617; c=relaxed/simple;
	bh=uxJr8HI575cU2I9eRQ0A18f0JZR5HN+ogm4wbuf+hzo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ess12MS0n98wOB7/H4AvP3eC0Wq/gx620BvZ/QWXxe6ZeXQKglPCNSfX9L8NWn7A3MU1SF8qwC0Sx2OFYg2kn7Jy4yXNI2ytAYASL3tJ7ucWV5u9w71ESWFp8DIhiOl7N61RxU+joo7yyjLnngNZ5p4nsbnGWi0XsYrsrHzyYJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYZeCQWX; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20696938f86so17329045ad.3;
        Fri, 06 Sep 2024 02:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725616615; x=1726221415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyyARlWipjDoS0SXZOFTgBRApilxAcItlWIAe+irTHY=;
        b=hYZeCQWXJoulKBc11qBGDAYSS3wmaKtxUIrVB7r1AZuZ3wLUnSAEzLzDMG7BQtkZU7
         ++6nNl/f+ZmbaUpoWhoXfFxB9Z9X6lmJjRM1zO2fa+34rXd7e6CLWgmkJ3NYpcRsYspY
         5mrxy0+vAyF66BobO5yNnEwX8DvMdfKuUBSCXVn645O11AODw7ijYzu2NHYGDGdOP2WT
         t5bOvrzbLXo0LpKRe+RmqZDqhDE8GU73I25ZWgntYsWEOzVqW4yJ9u9LG6qKZper0i6h
         amL2rjTrHiBdGeM4tgTl/V2ekydgx+aTQFtYPIBIh/P0dhUSRbr6HyVfdUKe2u4ff5qz
         ld1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725616615; x=1726221415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kyyARlWipjDoS0SXZOFTgBRApilxAcItlWIAe+irTHY=;
        b=Hi64OP4xHolB8zorJ/XLRDcUQQlzQE9cELkhm4Gt9HDhOF2SauoIl5+bPUaaCvBMYP
         TuAlakV1D38c1yu9BzXxQ2ZQ+PfWrxftD2sdXKnLMSpaQvuFT0miiH03QIhs1f+UhSuG
         4DEYthx8MaSrtSPzDY4NtxddIxXtrxzwn9yn9/AUugYwuLmp4sa2sx4TKZi+FA/MniOJ
         nT8msw/vV+PHix9CdFCRCE4+CQgDenzPWc5/1AfhtVR+gEPgkUQZOMf/L0LeAMvHWPQt
         L+62jbrzz0rQxfnMN4oBBI/KEkc9Yk+Dk+4VOAMyNFkH6BQsA8+TvcL8SLvfeMseBSpm
         P6lQ==
X-Forwarded-Encrypted: i=1; AJvYcCVd9NtyqNXm407oXWhw1k3B8TtVE4AMBby+hsjtH8tFqmtelXXrZYKywJCAFIw586wdivrEB/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze+/F6M52SDlrIj1NMH/0ZfkQ/17VkjOB5Fd0FHHSXD8tHgKX1
	qQmPP7i153gVzK783dJJT9xiquYaQOaD93ziS0xpMAC2vomRnJEA
X-Google-Smtp-Source: AGHT+IH6499Xn15y+nKGzL55z8eQyKoBweqyDbyzdVQdEE+ZcudWGXCuPiZF3CHDfP3HKZZ3WFEHlA==
X-Received: by 2002:a17:903:2b07:b0:1fd:9d0c:998c with SMTP id d9443c01a7336-206f065bb48mr18915845ad.56.1725616615473;
        Fri, 06 Sep 2024 02:56:55 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea5582csm39982595ad.221.2024.09.06.02.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 02:56:55 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemdebruijn.kernel@gmail.com,
	shuah@kernel.org,
	willemb@google.com
Cc: linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v5 2/2] net-timestamp: add selftests for SOF_TIMESTAMPING_OPT_RX_FILTER
Date: Fri,  6 Sep 2024 17:56:40 +0800
Message-Id: <20240906095640.77533-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240906095640.77533-1-kerneljasonxing@gmail.com>
References: <20240906095640.77533-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Test a few possible cases where we use SOF_TIMESTAMPING_OPT_RX_FILTER
with software or hardware report/generation flag.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
1. add a new combination test when both flags are set at once
---
 tools/testing/selftests/net/rxtimestamp.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/net/rxtimestamp.c b/tools/testing/selftests/net/rxtimestamp.c
index 9eb42570294d..16ac4df55fdb 100644
--- a/tools/testing/selftests/net/rxtimestamp.c
+++ b/tools/testing/selftests/net/rxtimestamp.c
@@ -57,6 +57,8 @@ static struct sof_flag sof_flags[] = {
 	SOF_FLAG(SOF_TIMESTAMPING_SOFTWARE),
 	SOF_FLAG(SOF_TIMESTAMPING_RX_SOFTWARE),
 	SOF_FLAG(SOF_TIMESTAMPING_RX_HARDWARE),
+	SOF_FLAG(SOF_TIMESTAMPING_OPT_RX_FILTER),
+	SOF_FLAG(SOF_TIMESTAMPING_RAW_HARDWARE),
 };
 
 static struct socket_type socket_types[] = {
@@ -97,6 +99,22 @@ static struct test_case test_cases[] = {
 			| SOF_TIMESTAMPING_RX_HARDWARE },
 		{}
 	},
+	{
+		{ .so_timestamping = SOF_TIMESTAMPING_RAW_HARDWARE
+			| SOF_TIMESTAMPING_OPT_RX_FILTER },
+		{}
+	},
+	{
+		{ .so_timestamping = SOF_TIMESTAMPING_SOFTWARE
+			| SOF_TIMESTAMPING_OPT_RX_FILTER },
+		{}
+	},
+	{
+		{ .so_timestamping = SOF_TIMESTAMPING_SOFTWARE
+			| SOF_TIMESTAMPING_RX_SOFTWARE
+			| SOF_TIMESTAMPING_OPT_RX_FILTER },
+		{ .swtstamp = true }
+	},
 	{
 		{ .so_timestamping = SOF_TIMESTAMPING_SOFTWARE
 			| SOF_TIMESTAMPING_RX_SOFTWARE },
-- 
2.37.3


