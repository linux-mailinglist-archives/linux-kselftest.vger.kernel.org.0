Return-Path: <linux-kselftest+bounces-35782-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA94AE8857
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 17:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 752B818869BF
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 15:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B8028135D;
	Wed, 25 Jun 2025 15:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPceV2E+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A411A5B8C;
	Wed, 25 Jun 2025 15:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750865649; cv=none; b=WyNUTHNs1WmMviXVaf5ZVDOuozDnnjtm5zqi5oJ7bHnQaeT6T5NdHOZyHFVQnkiq/Lu3wbEKlJvFcAaKY/VsHWWQfbl7UuTNsjVdUfokFpOMSVtCe3DrV1xPOYehtsx9NUVE5b2IPn5fPQoX6HyaIPCJdo2EdXyZGO/TuteCqxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750865649; c=relaxed/simple;
	bh=GO8/l9hZdF/FDZm2vS40Wtzn+Q/5nvto7+1zvwL9SiY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=acqSnD1iy3ld24SWq2CgcQhvDxK4OxxTrnB1BkxG7JkHf12RhNAfm2azmh9jVp/m3RqGGExJDzTxpAQTyb4OimznrddUTLlWlfcuiBXIvKA7Q+fd0NYMY1tHi0hbTr85ye1GVdSPHKqNETqwvYMbGSyN5RtXz2SHBv/0csYWS5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EPceV2E+; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-74264d1832eso139959b3a.0;
        Wed, 25 Jun 2025 08:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750865647; x=1751470447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/XVVjse7SLe3BXVW5yyOf89DyqZxU9QrMZCJroaokII=;
        b=EPceV2E+qgp3zudMaH2HwtBhmy2B4Nw7EFCSmeO7JjdevPzlYLszyznOCpEzEyCkE5
         DbXUlT7JDpTlIy8S+RVBL0dFmqEx6JTegaYzU9xoL6DVGdLQfGerjq0MPt+sUyeg31qi
         NoOLLMAmI+MUueSFvvFdEfE5b5z9eO+7jOUQyEdNKE935XBjvbsqYuG5eTtcr+UfemWe
         KYAwfwE8iXmWtnuLOhJmK9Z6pVcZQ0ef6NOnlJKroA0Lrq4fgQBrtJhN708RLZwnHASA
         1Ggcbm+Gl+IVbFwyife9b1IVRspbM12gq59HWxkVKnqUNsAr5F8ozj/JBugRznlu/yLQ
         DDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750865647; x=1751470447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/XVVjse7SLe3BXVW5yyOf89DyqZxU9QrMZCJroaokII=;
        b=fmyFsbK50n7gRLzLdh+tgFyu79LvzBxH8UXpntq04w1zcsLLemRufojW90sPIaQJ9D
         soodrxYHb21OvO9eYQCmDNYSKCswqedS3sTaIKMgi6YDYItKJHgFspx9MxjdUldDRLxM
         vdlKgHBCZhS6O5JDuxcmSiuDGFTw+9BA1RXvA4D9KZrDnMm4iMfU7nY9apMmHp+US7fP
         9AlcymbNsbTAVp3P2NIxXglf9IXxfoelJKRjF21OG9+1pOKjkFcnIu1PTJcR4Ifz7v6d
         9Hl9gUZl19CQ6waBm4A3eyNbDlzadG7H951jdg3RC6FQ9bdogiEBqfUFz93BbG/k878M
         iafQ==
X-Forwarded-Encrypted: i=1; AJvYcCUerbwfTykDAsXeOUOYoegTkl0cp4AV1+2LW0oTFn+0GCR/j8+Id9t3mjlW36EksKETb4Z7P17s4El5X1A=@vger.kernel.org, AJvYcCVCsJVs5dATw65kQIv5r2/Dtmnd5x2fGf3KJdMQQ4V8oS/xVphcDImWf7/p9597gVdFUbIFe+GXoUMaCcEQvdo4@vger.kernel.org, AJvYcCVI6EBaJTwCdpHS5DUHGHpvsshg0murH0/FlTSPpp32BlYOkE1h/we9YRUsXQWCi7TU2a1uPwnB@vger.kernel.org
X-Gm-Message-State: AOJu0YzXezlqRCYf7GtNrEhOxDSGxtAHDFh3NidV/1BOo5aqITILTJfP
	O04BOVjr91ln4miF7qYQvOs6CVW1DPGOHt7tQSXn77gOpanGQz1Y0s6N
X-Gm-Gg: ASbGnctYsJtEf9NbZ8wGI4fCaFN0h7bxQqpOxQQUWVSpS8w84k23NAfNywhL4J46+td
	aAQq2NQ0xmElQeCaqMsgHHwCoKT/Anf2TRi8EhnJAyCZEz7IV/viWU76zhg4XNlTcWa1jbVc2uQ
	utiLe72gG+8Y4A4MDMNGFZ6CjreuMf9CG9xxlIjdkmq6npAAU/Gvi71aC0SubDMllr+QHAUOYjx
	MKBGPBiM0/b8sYpIozb8Vz2gm7tgh7z7x++hSTBzvGYZTuf8H23nMpxNK2uWLoMuF+mh1KkkejO
	q516ej/FPwAXDHp+y2BfwntRZF08tHAC6+ImsIOwZECs4Mohm6arnR7USd1OMYgEjeKrgeJnE/V
	oG3E8rZOIT+WWV3aevRf44/drN7a9vlwcSQ==
X-Google-Smtp-Source: AGHT+IGEsigkbjsnTclJYWdU60y2qHEdvcVG9LRVDW0dYPsNGLYx5hAXrCi7negqVdxFafDSDMwEyQ==
X-Received: by 2002:a05:6a20:1581:b0:215:fac3:2ce2 with SMTP id adf61e73a8af0-2207f28f8bfmr5849761637.23.1750865646715;
        Wed, 25 Jun 2025 08:34:06 -0700 (PDT)
Received: from malayaVM.mrout-thinkpadp16vgen1.punetw6.csb ([103.133.229.223])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f1241f07sm13043969a12.37.2025.06.25.08.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 08:34:06 -0700 (PDT)
From: Malaya Kumar Rout <malayarout91@gmail.com>
To: malayarout91@gmail.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: net: fix resource leak  in napi_id_helper.c
Date: Wed, 25 Jun 2025 21:03:07 +0530
Message-ID: <20250625153334.434747-1-malayarout91@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Resolve minor resource leaks reported by cppcheck in napi_id_helper.c

cppcheck output before this patch:
tools/testing/selftests/drivers/net/napi_id_helper.c:37:3: error: Resource leak: server [resourceLeak]
tools/testing/selftests/drivers/net/napi_id_helper.c:46:3: error: Resource leak: server [resourceLeak]
tools/testing/selftests/drivers/net/napi_id_helper.c:51:3: error: Resource leak: server [resourceLeak]
tools/testing/selftests/drivers/net/napi_id_helper.c:59:3: error: Resource leak: server [resourceLeak]
tools/testing/selftests/drivers/net/napi_id_helper.c:67:3: error: Resource leak: server [resourceLeak]
tools/testing/selftests/drivers/net/napi_id_helper.c:76:3: error: Resource leak: server [resourceLeak]

cppcheck output after this patch:
No resource leaks found

Signed-off-by: Malaya Kumar Rout <malayarout91@gmail.com>
---
 tools/testing/selftests/drivers/net/napi_id_helper.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/napi_id_helper.c b/tools/testing/selftests/drivers/net/napi_id_helper.c
index eecd610c2109..1441b8d49b91 100644
--- a/tools/testing/selftests/drivers/net/napi_id_helper.c
+++ b/tools/testing/selftests/drivers/net/napi_id_helper.c
@@ -34,6 +34,7 @@ int main(int argc, char *argv[])
 
 	if (setsockopt(server, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt))) {
 		perror("setsockopt");
+		close(server);
 		return 1;
 	}
 
@@ -43,11 +44,13 @@ int main(int argc, char *argv[])
 
 	if (bind(server, (struct sockaddr *)&address, sizeof(address)) < 0) {
 		perror("bind failed");
+		close(server);
 		return 1;
 	}
 
 	if (listen(server, 1) < 0) {
 		perror("listen");
+		close(server);
 		return 1;
 	}
 
@@ -56,6 +59,7 @@ int main(int argc, char *argv[])
 	client = accept(server, NULL, 0);
 	if (client < 0) {
 		perror("accept");
+		close(server);
 		return 1;
 	}
 
@@ -64,6 +68,7 @@ int main(int argc, char *argv[])
 			 &optlen);
 	if (ret != 0) {
 		perror("getsockopt");
+		close(server);
 		return 1;
 	}
 
@@ -73,6 +78,7 @@ int main(int argc, char *argv[])
 
 	if (napi_id == 0) {
 		fprintf(stderr, "napi ID is 0\n");
+		close(server);
 		return 1;
 	}
 
-- 
2.43.0


