Return-Path: <linux-kselftest+bounces-15174-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2146A94F755
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 21:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9C401F21BB3
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 19:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2031918E02B;
	Mon, 12 Aug 2024 19:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3t/BsaJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A568BC156;
	Mon, 12 Aug 2024 19:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723489898; cv=none; b=Cd8Gqmltfu84e5t0aNVi/gFHGW25i1AX2weabAMe6hn7XsdVvVcGKmuuReif8Rkit5zfB1QKzu0DU66/SzPNurIbIi5+7CvhggaEWVIDsbNLYmSrkAekGBeTjQZlEB3SOtd8jMWDBN3Tclm51IW5MdI/9ggE6hEb+SMCman0O0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723489898; c=relaxed/simple;
	bh=0Nats6PcATwZRGOJCFhv3KEUydKEHLAmbxtEOrfkVwA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=r+68h7trJJtMgrcrpfHEJ5paeE/Uh+E0oz6imU1LR/loHuoM8ckQpzLbCMTXFFzeuUnjz7TKU9Pp1dRiefW659LdkbOSPcP5SftWjOVsBEPbhyk++wqKFQaYcwJwc4SPsW7kpAc4UHNfVWnlMp2iW2A+7Zwhte5qvO8fF/QGFbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3t/BsaJ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7107b16be12so3881399b3a.3;
        Mon, 12 Aug 2024 12:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723489896; x=1724094696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yOujgskCf1HwSznu2b68MZnepfDyCSp2vvqkqZuDR3o=;
        b=X3t/BsaJLl/BR6wtTfP+iP4Aed/TaEyFBopidvmCfI/OVGdt02v406jJA9gveQ4R5+
         fRrqNlWHh+HDUbBphZwmLINDX3Tj2PWWxIFA1Mt3j1Q7ukszgJ56n7xp2N3BP9IOnaya
         o61bBR4GqlEXBEZjuemv2Hz1DIr6OdvDLkpuZALndYbGDedQrxUXYMeglei9eMETAZ5L
         GH655QLnoXVSka6zSmLv9HXi437x81HRg4fxuMCmthrV3D6+0cyLzn5uEUA5+QpDdLh0
         zVzEpV4zCaVKbzkjSqLq+Z+AMgzoiALALT0F96Mx/sNR7/NWq1QZLa7WL8/BqVQAXp4t
         JwUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723489896; x=1724094696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yOujgskCf1HwSznu2b68MZnepfDyCSp2vvqkqZuDR3o=;
        b=NWsI0/nqWV8957GdvrAvz5gWHm9FARtkKOOhnfYBDyUSHQx0zfleIeLzbvrjdyIpuL
         NsZQTLzBAWCwhCj2zX63OAWJqiL1V468E1dF/ErbqYGoRKKfaQMeXuJBhRY/ujCdwap1
         vo+xELScZ1o+dp3UTSv5v2qd4BII/W3C5HsYn/MA3RlVNNfg/GccyIO0XmSHVyojK6dT
         yIaR7HoXxGSG4O8SSvpMCzQ2fdjuGdZbPdbK5xa1JxCwD04kIlfjiPYbdvSZYoDDOcE/
         hiI8BqSY9FMoob3VW6sqzWfO/1/xNWFpBkyL9yrniDP98oSuUwkMUZ7K+L7K1Y2PCGGk
         Q3Xg==
X-Forwarded-Encrypted: i=1; AJvYcCWOU+xtsC6eZw1vkafGS2XxdVoReUVLZbxMXlupnD2k3Hg1kYFCd7cbOymIhJ0EIAADLUBAOZPY2Nv/70aGZerjlsoHXmPRrSC+fofuk50zwfD+l3WxSUVuxSzS/pZTxYrJZHKoHs6/MpFuBQzlGWVz3zRZXo1e2SmojszPRjga2o4fpEcR
X-Gm-Message-State: AOJu0Yx9HSLMGViKKXsm+655V7k0D611xatI1dQGHOBHbg7EZUeS7Mn/
	ymS8bt4K4CJrLr3ppaXCdI0W73ZYOZE+30qE25xet6uALO3WzR+Q
X-Google-Smtp-Source: AGHT+IGjE2KOpTt5QbvDI+5ren5hlJOmnfHqFQBq/CRGm/JaLxeJWe1/wdc3499nhDbGvVsgk1qmhw==
X-Received: by 2002:a17:902:f54b:b0:1fc:6a13:a39f with SMTP id d9443c01a7336-201ca17404dmr14408255ad.25.1723489895800;
        Mon, 12 Aug 2024 12:11:35 -0700 (PDT)
Received: from dev0.. ([2405:201:6803:30b3:3671:7e47:70c8:c710])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd147eb9sm348845ad.90.2024.08.12.12.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 12:11:35 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	Abhinav Jain <jain.abhinav177@gmail.com>
Subject: [PATCH net v2] selftest: af_unix: Fix kselftest compilation warnings
Date: Tue, 13 Aug 2024 00:41:22 +0530
Message-Id: <20240812191122.1092806-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Change the parameter expected_buf from (const void *) to (const char *)
in the function __recvpair() as per the feedback in v1.
Add Fixes tag as per feedback in v1.

This change fixes the below warnings during test compilation:

```
In file included from msg_oob.c:14:
msg_oob.c: In function ‘__recvpair’:

../../kselftest_harness.h:106:40: warning: format ‘%s’ expects argument
of type ‘char *’,but argument 6 has type ‘const void *’ [-Wformat=]

../../kselftest_harness.h:101:17: note: in expansion of macro ‘__TH_LOG’
msg_oob.c:235:17: note: in expansion of macro ‘TH_LOG’

../../kselftest_harness.h:106:40: warning: format ‘%s’ expects argument
of type ‘char *’,but argument 6 has type ‘const void *’ [-Wformat=]

../../kselftest_harness.h:101:17: note: in expansion of macro ‘__TH_LOG’
msg_oob.c:259:25: note: in expansion of macro ‘TH_LOG’
```

v1:
lore.kernel.org/netdev/20240810134037.669765-1-jain.abhinav177@gmail.com

Fixes: d098d77232c3 ("selftest: af_unix: Add msg_oob.c.")
Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
---
 tools/testing/selftests/net/af_unix/msg_oob.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/af_unix/msg_oob.c b/tools/testing/selftests/net/af_unix/msg_oob.c
index 16d0c172eaeb..535eb2c3d7d1 100644
--- a/tools/testing/selftests/net/af_unix/msg_oob.c
+++ b/tools/testing/selftests/net/af_unix/msg_oob.c
@@ -209,7 +209,7 @@ static void __sendpair(struct __test_metadata *_metadata,
 
 static void __recvpair(struct __test_metadata *_metadata,
 		       FIXTURE_DATA(msg_oob) *self,
-		       const void *expected_buf, int expected_len,
+		       const char *expected_buf, int expected_len,
 		       int buf_len, int flags)
 {
 	int i, ret[2], recv_errno[2], expected_errno = 0;
-- 
2.34.1


